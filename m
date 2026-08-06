Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C3FC5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D2B10E097;
	Thu,  6 Aug 2026 11:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYn2j5Y/";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE08010E097;
 Thu,  6 Aug 2026 11:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oScbdRctwuByEKMSdrXxUUYRfDv/YjnXuKBHZBwGAMeKED1FBX9i/IkHZnx7iYo3lbddUri9+z2HAlVAyAUe/0P+sKx7W8ZMnnEkh4FOHuC+qFkUqBtuGWn/npCGKEFZY1WYrQsgtYO3gGi4ij+G9gWFlJ1bAdkSumHaVkdmruBhj90LfyE0uj+9Eym16LFupIdptwqcsqfWWZElQCqCxdFox2QGvvaCpatsrsoAf7VX3THf2vhvt8Fcs5GDIe/055qK+X+IWuSn8AuJPlY5HIvOKyaeFtBgWdEUqIvdeju0U8QY8MGsD1cklEXOWioCzh3FFu6EkFshbNNdpt3CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0LNM4vE7Cf85H3JAFuht9bYmxPDC6r6cbtGvxe8Cjk=;
 b=Oo11Ls9iJ60Od+PM9ow18sJfA1xNZlFxK+4j0guNLTVtwjUCvIBKW5JMcSirCG8L6DAxEwIPAZBtkZ/Lh4KMfMrrbBroeg7OUjZLNQ8K547qxfNWITSYy8/mCcM8uzTd+LoaTU4WyomZORTgek9dG5zZ6SIvxpxrhcZ4Mp8ducaXBfAh+ofFIds3Y8XkONpmYIwJf1ct7qdGQUQJs57aq3zr4gWdaH6Q0FEHYuo36pmPUSUg2IDJh5sVKICPlO/9F8FvexeP2Xx7KBgd5QeE5gHZ2mhlThiJ1/Vg3xIZuC8EtKmBdhQ7NPkoiLvO+dUAIlrrSmzoy31Fz66+veAofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0LNM4vE7Cf85H3JAFuht9bYmxPDC6r6cbtGvxe8Cjk=;
 b=jYn2j5Y/EVcp9FBy2OHDq7fDkg8nIZUU2BnDuH7zuDpzRSw/gBPJf97Ju6YHPP+m4GSZbgo1ZXqvUqvhqmBge4g+/qmJ8jbYp1lpkzDnQGzK/1ZtxiDU28yoVSFblxrC7XmxfJijogQY6WLQin3wpp6OYPuZG8xBmjKAwajxbr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 11:12:36 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:12:36 +0000
Message-ID: <dc702b3c-fc47-4fb2-9619-c4115cbff5b8@amd.com>
Date: Thu, 6 Aug 2026 16:42:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: Matthew Auld <matthew.auld@intel.com>,
 "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
 <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
 <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
 <002dcde7-5dc4-4fc4-93d9-984fe5e6344a@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <002dcde7-5dc4-4fc4-93d9-984fe5e6344a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::7) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 4608fd7b-11b4-4273-8066-08def3ab9eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fGvRrXECnbplgYUk6YzAqScxLoejDC0Djs9x8SFOXuJuriMHAYNAGXwAKCcV4Vc5NletYhgl5uM+L7rCFfNuYR2Ctcz86bcjEx8qWL+HYSZDuje/woYcoPs64KXnf+9LY9AnyJ/QF4ouk/lK3GauyjvJCO+8HNIJp14sfm897iMLUfnODyzIM10dyYU1x9v/HX6QIK5N96n/HIrUpM2kHLLfDkt5wVDTojCTZmcD8FZi/YnKuJJ3SfYD1FSow+/Waur+u+GA1Vj2FfMRnmtj9zoKVskBYBKoAzwm66NdQLsnx1S32LpLb8KsO6sL5vHFOrJN5e+6xYI2WzzYms07ApOdY70G9FQ/+zaob0u1uxAQHtGb4ofVs1lSqPp+LBsQB7SG3L4DfkAM3kCzNS66Wtb5tm/D6PWVk7bdz5frG3x9aj7eigp9xH9fWVgF0x8mHY/4ZTLE+FHizKfJhbKTnuzgyKl7jZeyMET/5iYG4yEu3vQy0JUt68E0w8VnifKoh5fiTxn5sNluQAa+jzRp9rjpoa5XQyF6Wsa6qmJWs1HMorTyUkLbgk7ZQbtLknRBhwhQeZ7S/Gb51h+ZYsdPu8dJli9qnfzMb7HglLump3ST7bN5x3SqQclvMXf6iLOu2jx1VaUCD/gBf0BJbK1aTBmKgbnUMxx5mv1YK+FLnnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lFWTZPSGdZbXN0cXQ1L25vaW42V2tGOXNBTGZPcUtvaTdZUll3RXlIT0Z6?=
 =?utf-8?B?VUlhMzdSM0lEYmQ2SlNNQU92R2p0elc2QmNHRGd0dGRBVU16OGorK3o4RHVT?=
 =?utf-8?B?blh1dlo2a3NPM3NWelpqS0RlaXhPcDRtcFJNeU5jTlVHb2ZmN0hZWHlwYnZO?=
 =?utf-8?B?SXNCSzRxNjRyREljMDBHMnVHdWZFSmo3WkNuUFgxUldQL1VUbzc5VUt6d1FB?=
 =?utf-8?B?RHpVd25TVUhneGx5ZERhZTIrYTAybXVmc1hwS1V4SXlBd25oRHdrcDBNbXBI?=
 =?utf-8?B?NDNmdU1BZnRucTBPTVZwa3RVYlI1QjdPK1gvaXErWlNROThJM1FpSVVpQlla?=
 =?utf-8?B?SitxNFl6TXprd2NSYURxb1cvMlREd0dZOHMyc2hsTGhnamRkZ2FBUmR0SnRu?=
 =?utf-8?B?aWpEN21kY2FoaDFjVU1FcTM3VVQ4UVpnMmVXMTZoWkRXSTA0T2c0TzBTUzFu?=
 =?utf-8?B?RDl5V2w5Qk5XbUxnd0thcXZ0RitMWHgvQksxb3F1TGZrNlA3Sy9NZ1U2SXJX?=
 =?utf-8?B?NlF2Z3NkaFl6OVpINnkxZ2gxY2lOY3BqY3QwekQrbm84TUJiUnNBd2ZUb3BT?=
 =?utf-8?B?bmEzYWRVemc3M3BmRXBiTG80ekhiMzFqRTN5MWVhUE4xUnJpa05SdzhxUmVU?=
 =?utf-8?B?d3F3U1RITm14SlR6N0VhT1lidHg3ZnJaK3dZVGpGR09sVWpEWVdNRGVFNVd6?=
 =?utf-8?B?YnJ2amtjaVlERTY0WTE1UUp1VCtiVitPN1JQdXhuTlBWQm9pRElIS1kzQlY5?=
 =?utf-8?B?SzhKUm1qZUhtTVBGcWc5Smk3Zys4VFVOQXlPQzc2elVtSEQ2V09WZmxteE1K?=
 =?utf-8?B?YU1qNlprN0QvYVF6dXBnb3JQekdxVVRhYUdYNzM2UVh1OTVGSUhWRlorblE3?=
 =?utf-8?B?UXJvZ0JhZUtZUmh5aUJyY2pVaHBUWTZVNTFCdzNwLzh4YnBscEtHTzR1cGN6?=
 =?utf-8?B?cEVqWGZqZnJiRXhQVThxaWk4QUIrcmc4K2JreklFV3FJUjRDN0NDTmtLakRk?=
 =?utf-8?B?a0hXS1IwdFJmMVlnZGhiSVdSQyt0RVErMDlwME12L0d6blZXSGtYOVhiRU41?=
 =?utf-8?B?ZWJwbGRUaTZ4VFU5MTBEc3dxSE16eG9jWWs3REF4Y1MvNUpjdWExTmJiSm1o?=
 =?utf-8?B?aTQxa3ZGdHpQcU90WUdabTE0eGQ4NXI0a0hwQk5kNVJDU0Rpa2dRV20wM0xi?=
 =?utf-8?B?a2xJZzJHaXF0ZU54RGxPOUEwOEhSSEFZc3JXanpoU3RhMU9DNU4vTURRVmtw?=
 =?utf-8?B?WUVGdEpDenpUR0xUTGhpNVU0a1JRVFFaYkQwUmFRa3NtM05PcVI2NDYrK2w1?=
 =?utf-8?B?NlY1eG1aQmtFakZONWpGdHgvdFZRTHdNQ3VSekJHYmhrQmVGNThSbEZWSm5q?=
 =?utf-8?B?KzJiN3NydXdDV0xmN0o4UkVKQjQ0M1dxRzVIRlgxWVFsdkxCVE9JVkw5aWxW?=
 =?utf-8?B?ZDJ3Q2JCUy8rVkRvOTJ0R3MzdEF4M3EvdmNsNmFiSWhiUjdsOXFWUTdkTURJ?=
 =?utf-8?B?R05SNmFhelZDdjdORjRjZkwycm50M3dTTUZ3MExoUHNmUDdMWkFYQlBtaHh2?=
 =?utf-8?B?dzZIU3dtSjEySEhsYVVteURWWjcvdWg5L2lZTHgweVQvOEZ0T2lEb3VZalRO?=
 =?utf-8?B?RjRERmIvNXBUL29TdGNGUDZ2V0JJRHQrckhCallvUmd0UXQxcGVQYmlvN21R?=
 =?utf-8?B?S0p3d1RzekExSlRsLzNLdWhJeVJZT2ZoVVoyV25YcitnZGY1anNZVnQycHNr?=
 =?utf-8?B?TlhETVYxTGxJemFGQWF1RmlTWkl5T2RMeGFhUkFHVW1aSTJMdjh6SWt1TXhI?=
 =?utf-8?B?V2hmcGZsMCt0Sk5ibDExN2s3U3piQXBJUTRzek5WWEhyWVJ0UXJMMkI4bUY1?=
 =?utf-8?B?YXptRzcyRzNuKzhlWm1iZFhhMUo4SVdyZjA2cURmRXJ1aW8zSW5NWm5wQndo?=
 =?utf-8?B?ZjFQbFBOYnRtT0hBcWJBb1FrN2Jmd3EzUGN2MmE0Z21mTFhkK282d0c2bXpv?=
 =?utf-8?B?d0lmWEZYMkVKd2NsYVhtMFY1ZFRSd0tWTUVXTktGMHhiaHg5VXVFb0FNOTZ6?=
 =?utf-8?B?NXpnL0c0VFIwcThuZ2ZwWktsaDNENkFkN3dQVmJWVW5XNzlMbDhMMkpUaVYw?=
 =?utf-8?B?V1NuenFmM3FEZ0M1VnRJdjdlMVcybWR0UXFqQnlIYlNxbGtHUXBHV21LMDlV?=
 =?utf-8?B?SFZWak00ODYyVllsRzJXdXZ0VkZtakFtTVhWZDB3WmVsenNMSVVKTVRac1h4?=
 =?utf-8?B?Y3lWSlZjaGxHeVJsQnQzODh3ZFRZcWw1RS9NMkZlMWNxMUhyRDQzdjJjdmtq?=
 =?utf-8?B?bVpZNlFVU2ZodDBrYk5DSTd2ay95ZWpwZ3Nrd0hSYU5qbTk2V0tYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4608fd7b-11b4-4273-8066-08def3ab9eb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:12:36.4526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYO432c18H31knELER0S6/TA1SJSQnFLhrgl6Vqisc7jSeDJxIscnPQsiWG8Z+PRQW5YgcdvDbhfOApYejc7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 8/6/2026 3:49 PM, Matthew Auld wrote:
> On 06/08/2026 10:46, Upadhyay, Tejas wrote:
>>
>>
>>> -----Original Message-----
>>> From: Auld, Matthew <matthew.auld@intel.com>
>>> Sent: 06 August 2026 14:31
>>> To: Upadhyay, Tejas <tejas.upadhyay@intel.com>; intel-
>>> xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>>> Cc: arunpravin.paneerselvam@amd.com
>>> Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
>>> gpu_buddy_allocated_addr_to_block
>>>
>>> On 06/08/2026 06:36, Tejas Upadhyay wrote:
>>>> Add a new KUnit test gpu_test_buddy_addr_to_block() that validates the
>>>> gpu_buddy_allocated_addr_to_block() helper which traces a address back
>>>> to its allocated buddy block.
>>>>
>>>> The test covers:
>>>> - Exact address matching returns the correct allocated block
>>>> - An unallocated address inside the manager should return NULL
>>>> - An address outside the manager should return -ENXIO
>>>>
>>>> v4(MattA):
>>>> - Add test for unaligned address
>>>> v3(Sashiko):
>>>> - remove unused target_addr variable
>>>> v2(Sashiko):
>>>> - Drop the mutex and lockdep annotation; standalone KUnit tests do
>>>>     not register a driver lock.
>>>>
>>>> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>>
>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
>> Hi Matt,
>>
>> Thanks for review. Since I don’t have merge rights on drm-tip, Would 
>> you please help merging this series.
>
> I think Arun normally merges these. Arun, any objections? We need this 
> for an upcoming driver feature (patches on the list), so wanted to 
> land this API ahead of time. I don't think this will conflict much 
> with the big rework you were doing.
No objections. Do you want me to merge the series below into drm-misc-next?

https://patchwork.freedesktop.org/series/171145/

Regards,
Arun.
>
>>
>> Tejas
>>>
>>>> ---
>>>>    drivers/gpu/tests/gpu_buddy_test.c | 45
>>> ++++++++++++++++++++++++++++++
>>>>    1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c
>>>> b/drivers/gpu/tests/gpu_buddy_test.c
>>>> index 7df5c2ae83bb..04e425eb8bdd 100644
>>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>>> @@ -1381,6 +1381,50 @@ static void
>>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>>>        gpu_buddy_fini(&mm);
>>>>    }
>>>>
>>>> +static void gpu_test_buddy_addr_to_block(struct kunit *test) {
>>>> +    struct gpu_buddy_block *allocated_block, *found_block;
>>>> +    LIST_HEAD(allocated_list);
>>>> +    const u64 test_size = SZ_4M + SZ_2M;
>>>> +    const u64 alloc_start = SZ_4M;
>>>> +    const u64 alloc_size = SZ_4K;
>>>> +    const u64 chunk_size = SZ_4K;
>>>> +    struct gpu_buddy mm;
>>>> +
>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size,
>>> chunk_size),
>>>> +                   "buddy_init failed\n");
>>>> +
>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm,
>>> alloc_start,
>>>> + alloc_start +
>>> alloc_size,
>>>> + alloc_size,
>>> chunk_size,
>>>> + &allocated_list, 0),
>>>> +                   "buddy_alloc failed\n");
>>>> +
>>>> +    allocated_block = list_first_entry(&allocated_list, struct
>>> gpu_buddy_block, link);
>>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block),
>>> alloc_start);
>>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm,
>>> allocated_block),
>>>> +alloc_size);
>>>> +
>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>> alloc_start);
>>>> +    KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>>> +
>>>> +    /* Unaligned address inside the allocated block (should 
>>>> resolve to the
>>> same block) */
>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start
>>> + 16);
>>>> +    KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>>> +
>>>> +    /* An unallocated address inside the manager should return 
>>>> NULL. */
>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>>> +                            alloc_start -
>>> chunk_size);
>>>> +    KUNIT_EXPECT_NULL(test, found_block);
>>>> +
>>>> +    /* An address outside the manager should return -ENXIO. */
>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm, test_size);
>>>> +    KUNIT_EXPECT_EQ(test, PTR_ERR(found_block), -ENXIO);
>>>> +
>>>> +    /* 3. Standard inline cleanup flow */
>>>> +    gpu_buddy_free_list(&mm, &allocated_list, 0);
>>>> +    gpu_buddy_fini(&mm);
>>>> +}
>>>> +
>>>>    static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>>>    {
>>>>        while (!random_seed)
>>>> @@ -1405,6 +1449,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>>        KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>>>        KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>>>> KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>>>> +    KUNIT_CASE(gpu_test_buddy_addr_to_block),
>>>>        {}
>>>>    };
>>>>
>>
>

