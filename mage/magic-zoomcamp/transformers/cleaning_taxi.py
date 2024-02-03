if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here

    print("Trips with Zero passeners: ", data['passenger_count'].isin([0]).sum())
    print("Trips with no distance: ", data['trip_distance'].isin([0]).sum())

    data=data[data['passenger_count']>0]
    data=data[data['trip_distance']>0]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    bfr_columns = data.columns
    
    data.columns = data.columns.str.replace(r'([A-Z]{2,})', r'_\1').str.lower().str.lstrip('_')

    affected_columns = set(bfr_columns).difference(set(data.columns))

    print(affected_columns)
    print(data.vendor_id.unique())
    
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, 'vendor_id is not existing value in the column'
    assert output['passenger_count'].isin([0]).sum() == 0, 'Still 0 passenger count'
    assert output['trip_distance'].isin([0]).sum() == 0, 'Still 0 trip distance count'