Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F5AC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07C010E30A;
	Thu,  6 Aug 2026 11:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z98vwWYv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFF510E30A;
 Thu,  6 Aug 2026 11:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDmuRPB8qAOm39GbBVZNP8pnNerp8fD9vUHMYWv8FIKDBak1LFJH3WGmmBvGYk5UXjd2gi2B+7V3U3/yPyka3OBKej+3+usK/u43RJj5tKuv8ritsXG/qhngzYlpy+6SiBDzUrSBIcNm6afoOYAjqa81ioMSnWFpjQrKFZdh5ny1O1xi+msgwx11pKofhOfbexNeMK8RTQd2IIMZvOFRitRPkqlojjGWaew0pomDbX7xoVJwRMWwxekPQM6CDhpx37W7adpIVcK6pk5Nn2klbdUdSdvpWtuIB5l9L/A4CV/xkQuPUApq5uyfiEWmpevcyrxsi1fMIp/+q6/UFLKvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBTMInjPmxuttSEGqa5Xf4crMZTPLZ+peR7GhP0Luo4=;
 b=l5DgohdX68UFGdlZDSaB2LnESPVW/SJvQeWASg8ENedR32+eXu8I1Dzj7sNszmYu8Wsx9RsE26AeV42uR907FLcPoDPjDeYi6w3NbDGOVLqUzVUgnPklRuGEi6q1gUkK9H/5FV459ZjhXS09HA0mugeGRsIphbc1rrvSo8temBwfaA4HI/6rWHrQARDcmpxIWK+qAbKOrDJokpHDRR9G58BjxOA0lpOv4fDJg2cimxw6Zt1P+DNM/BWxp7ypDyNI8CSWKPsrN24CtoFDPEsyIeSPERpAgVFjVc8JtcydsWKUsE1IIJJiPGSzCOdHEEkXlFm4dG0khdUGaZ5FmhEb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBTMInjPmxuttSEGqa5Xf4crMZTPLZ+peR7GhP0Luo4=;
 b=z98vwWYvROBZ1nWzKO9E0xmonQsWIC/uE6mkJruKfsyz6VJ+8R7tnjPaPHo6MWDjFPaKJfE0b6ttKszeER/NbKg1he6U2mWgegaOFqSf+VH9CXQNu/luKGlj1CWg4MubZppnFvTFZXq7rEqXRS3zI+TobYqwiVr07MSGUGt8jJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 11:32:25 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:32:25 +0000
Message-ID: <843f7781-d75c-4f01-a977-04cf74ceb724@amd.com>
Date: Thu, 6 Aug 2026 17:02:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
 <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
 <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
 <002dcde7-5dc4-4fc4-93d9-984fe5e6344a@intel.com>
 <dc702b3c-fc47-4fb2-9619-c4115cbff5b8@amd.com>
 <DS0PR11MB8718001019A9FCB196EC1AD081D22@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <DS0PR11MB8718001019A9FCB196EC1AD081D22@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::15) To CH0PR12MB5026.namprd12.prod.outlook.com
 (2603:10b6:610:e1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ba2157-5935-40df-f45b-08def3ae6135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: wsga04A5dN4Wnv/w385kCH1RytxuyWaMBO+ZZXdl4WZUd1LzNvFUK+NybDH/Ma2l/6/BXBTIK/2ugvxB3rHWwB86znNh3BikBJnE/X7z+Sf0QY65DJtvHffwM57N81TNO4TUfvyEhfOE3UqK/kSmpOMWY9QyftpFAaA+aaiwG1ua8yUZ8rutsot61ToASxT2LDdTZY4EVlh/LGY5s0yWMDCU7Ie+tHMwVVOpRLhsHO9aLexfe1MK/M/x6iaOCup4Wyvvod/z8JROWQSUvF2ZIs5ttpnUBU57VVsueeNHs4ehDrbWGQFCWhX0lYPLN7EDakhqEuEk/s38UjCp9H4/nY8Tw9zFuhyws1Lz4ABdqJ43guO59c+PGlMZbLmROgKZ3Aw49XzCrHDCKlv6STiE1Jx2myOo8CZlo2yOCh3bQRuhMaqEX7fmRR4qQR3U0WcT4FntILoizP5j9MHaWMevTYO39I0E8vU5Dipwf7qgG4SmdFLE3sE/9874RLOsoGEGbydtl1qO1A181RQ6xY97WZ82sHyITL4KvR+6OfkCvlyopcqNQ8qVnuj02+JxldIeJbeMuPPCtz3SdQzDaXaWiw+NZLBSDISnUMHPlHMtuojZBRkQp+BIlRM322S2+jwXewCPf+v/4ByO0613GlEF1FsQk/ASoQIm4j7Zk/8KtQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkN0cUx3Nk1ENnpkeWh2Y3BVY2IvNUgrNWpUaGZ5cFNDVE9tMXhQRks2TDNu?=
 =?utf-8?B?RVZMaHZYcTc3bTBsTW44ZW5RRlpPYlY1emVkRlBTY1BNeE13eGI4UjdKenU4?=
 =?utf-8?B?WXJWQlVxQVZHMXVtOS9zSDJUejFaYWhGWktwLy9XbitSZDdLaEVNYzV1WmtC?=
 =?utf-8?B?cmtvWlc1NGZVNUVzVVlhY0VSbHVNbWY1ZW15am5NRENYRG11amw2dDcwRVFE?=
 =?utf-8?B?L2xaV2hOSVh6SWU2ejcvY08wQnY1aElOQk5lVTRWNWpoL0JyelRPNlZLOGVa?=
 =?utf-8?B?a2VuTzJjTVh2TjlKQTRGQ3JWZWZWS21kRVZPcUhYSHN1azZaYzVMVzdxd0Vh?=
 =?utf-8?B?NzE5Njh2T3NxTlJ0N2lSSU03MXZ1NWxISS9jRk1oSzVsSURTVXFmb3ZTOW1E?=
 =?utf-8?B?WUlrTnRaRGpNZ2tNdUpkNm9BOWUyeHZqL1JwOWtlVnlpcnVHZUpLdTMxSVVQ?=
 =?utf-8?B?MEN0WCtjckdGb2F0QXZkNXZLb1pxS1lrNW8zYy9IbWR2T2k4QUY0V28rSDdJ?=
 =?utf-8?B?K09DcEVqMFlaSXRlZUpXcWJ0UFNBRmtucXN3RldwOTdQdlhJNGFWQzRPZDRt?=
 =?utf-8?B?cHMwYTM3VXRrek9Mc211L0dRTllDamNGNVFoQTJQZ0ZvQjNoWnR1cVhqNThX?=
 =?utf-8?B?Y1ZaRU9EU1Uxa2p0VjFveEhGdlBaa3Z6SUlKczhaSUg3eU0wRWJpeDdjZW1P?=
 =?utf-8?B?dWxaVVRiNVkwZWZuQ210U3pFMXRpQ2VReVoxMnB5WWRZTkhvMlMwdFdUWEc0?=
 =?utf-8?B?cWREdURHSmsxWTdQeWpCN0txRkthZTJQRm9HelNIVWVUWVY0OVI2Nk4xeHFE?=
 =?utf-8?B?dWZCellmZG14L29iampvdVJnMVVpVzJkSWZXQkNDUEJIenVjSWRDUlYrWE1B?=
 =?utf-8?B?MVdQYTAxa0pBQ1M3UWxPRUlNZ1lVY0ZhY0hQNEMyWVhZamx0NU9icWIwQVVZ?=
 =?utf-8?B?TGtzeFluamJnN2NDTUpZZ0EwZ3NudEpubkR1ODNFd3RMRjlpUElOU2JYNnRR?=
 =?utf-8?B?dXNRUGlDSkVnQ1VyTGdMajBGdHNIbVZ6dmtlMkwrT1RpN3ZscmppZ2pJU2NX?=
 =?utf-8?B?bUtNUFNqUXFhTVNDTHk0UXgwdUFJVzhoUG1ETlc2R1NWWDJIYjBFeXdXMEl0?=
 =?utf-8?B?MFpWdzlRcXQ1clFrdDJZTTlVWTNrWDZnRmpwU3BocHArcTZjc1JvL2plblFM?=
 =?utf-8?B?K1dFSEVKb2pKenUyNkRVQWhpL3JqWmM0bHlvc1pSQkFWOGRCV2hmOHphckJZ?=
 =?utf-8?B?bDE3TStTZUg4ZXRWTFc1SFdoaEVxVmFQMWg4ZUpyYXZpNi9vSHIzVmdJcEhN?=
 =?utf-8?B?dUQva3hNano2UiszTFZQdHg5L0JkRm1YUCtMS1pGSFlveEZLdEtrOTJOM1Ir?=
 =?utf-8?B?cVY4bzlpbFExd3Fkd0VuVjZyRWFTUjZRcUY2YjV6UlppUjZ0VjNCeHhMZFp0?=
 =?utf-8?B?NnRqb2hsMTJwOGhVUnJvcmxLeVhaRVQ2Ulp0NkhzZFdVdXMzYzNsYzhVVitG?=
 =?utf-8?B?RnBLanpjOWlpWXJFT2M0djIzbWp5Mk12c2RjRklhdWNMaWwrWmxhSkZKRnBY?=
 =?utf-8?B?Qnc5blFkQkQxTmVTUzVES0ZWblQ1cS9pa3FmcXZoVmpGdjZNRVFuendoUEFS?=
 =?utf-8?B?aFh5TWlDZU1YSWkyazA4VEdqeldiQ0dwU01xdmhzbmFjMXNCb1BLK3pGZGQr?=
 =?utf-8?B?eERKS2wzTzhURm1UZEYyeU9OOW9ramo1M3ZpSmo5NUNLNENpUUJjWHg4MGdI?=
 =?utf-8?B?SktrVGY1aHB0eDhQSWpwYWhNRXFRTVk3VFpFR2ZrME1lTExmT0htbGROL2hT?=
 =?utf-8?B?U0xHMXJtVDB6UE84ZzVrYk9OT0pCb0VxKy9mdERhbklSYjVKek8vbnpUVXNC?=
 =?utf-8?B?RFRPTlk3ZnpoRVV1cjl1SnlJdHpmd3Y1SXNGQy9Dditud3QwNTFMK3cxcjZQ?=
 =?utf-8?B?K2p0dlhiNjRna1h1cUYyUHVUWkVXMjVON0pTclVaSk14VWNYKzBnOGhLTWpE?=
 =?utf-8?B?L0paRWtmVXdFQWpnQkRNa2MwMmtCQjMxTlA0OHMvOUpLZkViQW44UUhtdlha?=
 =?utf-8?B?UXFYaUdtWjZMMTdJbS82S2o0UEVSVCtHQzd0VExrVVJJb3hHeTVxbWVYOGRB?=
 =?utf-8?B?ZlZFd1RtdDFxckZOWTI2TmgwTThlbDBSN3I3RU1BSWw2WFMrMWJRSndvNVZY?=
 =?utf-8?B?WFd3ZXlMeUZGeDV0czNZajRyRzRuQ20yd2VXOW10anR6OThtcXR6cnd4elR3?=
 =?utf-8?B?Y0NQWnhvVG1aUUVmMG5WNVRMSTU4ajBqTEkwTnRDMVNmZDhRRk02U2hDWTNy?=
 =?utf-8?B?eWRlNmtwK0pzcEFuL0xVR1dYMmk1TlFqdEZOeWt3L1I4MCtvQ1dTQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ba2157-5935-40df-f45b-08def3ae6135
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:32:25.6327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiwx5DIyAO8Ic9lYVa0H10PslqhzyChJSsfQGEy/a7gYwAMQ/nNzez+9v6EKYUFgKBNAVjNJ6Ha88+sNaczIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792
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



On 8/6/2026 4:48 PM, Upadhyay, Tejas wrote:
>
>> -----Original Message-----
>> From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
>> Sent: 06 August 2026 16:43
>> To: Auld, Matthew <matthew.auld@intel.com>; Upadhyay, Tejas
>> <tejas.upadhyay@intel.com>; intel-xe@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org
>> Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
>> gpu_buddy_allocated_addr_to_block
>>
>>
>>
>> On 8/6/2026 3:49 PM, Matthew Auld wrote:
>>> On 06/08/2026 10:46, Upadhyay, Tejas wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Auld, Matthew <matthew.auld@intel.com>
>>>>> Sent: 06 August 2026 14:31
>>>>> To: Upadhyay, Tejas <tejas.upadhyay@intel.com>; intel-
>>>>> xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>>>>> Cc: arunpravin.paneerselvam@amd.com
>>>>> Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
>>>>> gpu_buddy_allocated_addr_to_block
>>>>>
>>>>> On 06/08/2026 06:36, Tejas Upadhyay wrote:
>>>>>> Add a new KUnit test gpu_test_buddy_addr_to_block() that validates
>>>>>> the
>>>>>> gpu_buddy_allocated_addr_to_block() helper which traces a address
>>>>>> back to its allocated buddy block.
>>>>>>
>>>>>> The test covers:
>>>>>> - Exact address matching returns the correct allocated block
>>>>>> - An unallocated address inside the manager should return NULL
>>>>>> - An address outside the manager should return -ENXIO
>>>>>>
>>>>>> v4(MattA):
>>>>>> - Add test for unaligned address
>>>>>> v3(Sashiko):
>>>>>> - remove unused target_addr variable
>>>>>> v2(Sashiko):
>>>>>> - Drop the mutex and lockdep annotation; standalone KUnit tests do
>>>>>>      not register a driver lock.
>>>>>>
>>>>>> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>>> Hi Matt,
>>>>
>>>> Thanks for review. Since I don’t have merge rights on drm-tip, Would
>>>> you please help merging this series.
>>> I think Arun normally merges these. Arun, any objections? We need this
>>> for an upcoming driver feature (patches on the list), so wanted to
>>> land this API ahead of time. I don't think this will conflict much
>>> with the big rework you were doing.
>> No objections. Do you want me to merge the series below into drm-misc-
>> next?
>>
>> https://patchwork.freedesktop.org/series/171145/
> Thanks. Yes, you pointed to the right series.
Done. Merged into drm-misc-next.
>
> Tejas
>> Regards,
>> Arun.
>>>> Tejas
>>>>>> ---
>>>>>>     drivers/gpu/tests/gpu_buddy_test.c | 45
>>>>> ++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 45 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c
>>>>>> b/drivers/gpu/tests/gpu_buddy_test.c
>>>>>> index 7df5c2ae83bb..04e425eb8bdd 100644
>>>>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>>>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>>>>> @@ -1381,6 +1381,50 @@ static void
>>>>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>>>>>         gpu_buddy_fini(&mm);
>>>>>>     }
>>>>>>
>>>>>> +static void gpu_test_buddy_addr_to_block(struct kunit *test) {
>>>>>> +    struct gpu_buddy_block *allocated_block, *found_block;
>>>>>> +    LIST_HEAD(allocated_list);
>>>>>> +    const u64 test_size = SZ_4M + SZ_2M;
>>>>>> +    const u64 alloc_start = SZ_4M;
>>>>>> +    const u64 alloc_size = SZ_4K;
>>>>>> +    const u64 chunk_size = SZ_4K;
>>>>>> +    struct gpu_buddy mm;
>>>>>> +
>>>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size,
>>>>> chunk_size),
>>>>>> +                   "buddy_init failed\n");
>>>>>> +
>>>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm,
>>>>> alloc_start,
>>>>>> + alloc_start +
>>>>> alloc_size,
>>>>>> + alloc_size,
>>>>> chunk_size,
>>>>>> + &allocated_list, 0),
>>>>>> +                   "buddy_alloc failed\n");
>>>>>> +
>>>>>> +    allocated_block = list_first_entry(&allocated_list, struct
>>>>> gpu_buddy_block, link);
>>>>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block),
>>>>> alloc_start);
>>>>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm,
>>>>> allocated_block),
>>>>>> +alloc_size);
>>>>>> +
>>>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>>>> alloc_start);
>>>>>> +    KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>>>>> +
>>>>>> +    /* Unaligned address inside the allocated block (should
>>>>>> resolve to the
>>>>> same block) */
>>>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>>>>> +alloc_start
>>>>> + 16);
>>>>>> +    KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>>>>> +
>>>>>> +    /* An unallocated address inside the manager should return
>>>>>> NULL. */
>>>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>>>>> +                            alloc_start -
>>>>> chunk_size);
>>>>>> +    KUNIT_EXPECT_NULL(test, found_block);
>>>>>> +
>>>>>> +    /* An address outside the manager should return -ENXIO. */
>>>>>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>>>>> +test_size);
>>>>>> +    KUNIT_EXPECT_EQ(test, PTR_ERR(found_block), -ENXIO);
>>>>>> +
>>>>>> +    /* 3. Standard inline cleanup flow */
>>>>>> +    gpu_buddy_free_list(&mm, &allocated_list, 0);
>>>>>> +    gpu_buddy_fini(&mm);
>>>>>> +}
>>>>>> +
>>>>>>     static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>>>>>     {
>>>>>>         while (!random_seed)
>>>>>> @@ -1405,6 +1449,7 @@ static struct kunit_case gpu_buddy_tests[] =
>>>>>> {
>>>>>>         KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>>>>>         KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>>>>>> KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>>>>>> +    KUNIT_CASE(gpu_test_buddy_addr_to_block),
>>>>>>         {}
>>>>>>     };
>>>>>>

