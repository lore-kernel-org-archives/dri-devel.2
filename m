Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDDDC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C878892ED;
	Wed, 29 Jul 2026 21:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A4svtpRB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46E510E0E5;
 Wed, 29 Jul 2026 21:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO7tSGrrel4lzZkaB/E/K3s+Tj+yXzIsbXOB5lQpeWYKh26QikMlyDaFnqweSOnRF3fLhZ6/1SPEaBzQuoNgXsV2X5TIkaEX/ZH4OF9P1rA1phkUeIBi34/mQJRiRohU6n9Jn7tfxSWHWQ9GpCRibOxYJS8egroI5exq0svBIliEDty8uBcMfI15psfS19uVBZlh3LK7xcoqsN+sXvIh6wBQqABydjZFp+tvpSJinGY5Dsuz/cdp5RCd0QmokyuWYyvEq6S+7MPGHQELALPhdUSN1c4Mdo9vhO8cb6Oqz4cfCfpDqg7bPXw0EK+smMEwozKekQ2X3ObhCPdfUdbxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLox01750W+mfx+CCGy9Pb1ivF7og4n3yTSwk+7x/2k=;
 b=zRPIcFuUCcqh3LgJY57M82Tj25zFmC6e5Yi/S8cMVRdsnOPETo7TnHJ4dPIfIFN9BMviBdo8W3xxaVjKlszenQHNRCk9STqZFbrJMFjtKY/dayzud2xCbbGxXOkGphb8kMiVrRZYE1T5/L+QkyRBccS564CKpWzOvUB95SI1aIQkmVq8FQgMuQu9Pf0WOEezYgdhcxcwmBzhPo43gxbCbz+TUXcStM2R7uvgrVHfOd5QdzME1eRbld8Y6tbqwIMfluju0lgsm8+LTFg6yJ0Jyryk1GI9CCxiyuzsdq82JSKJ5vWn2mQ1Ku88Tm3q0EDiisv04LYeyFCL7aOdjD8fgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLox01750W+mfx+CCGy9Pb1ivF7og4n3yTSwk+7x/2k=;
 b=A4svtpRBwoOb4BvqtfHs3cmV2XXSz37y+bXLIQ2noGpdeETYLzmu/jWXuyRlr1GsPH97x6dHm01du/S23HsWSGVeOoAQoUkLrUhJmyGvPxKzzkV3WHDEpgy6Gp46PyGinWkndlmXOZIVTBvkYYYbeQRDqYRBNV5/oLPSmKoO/gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 21:40:21 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 21:40:20 +0000
Message-ID: <875db361-d009-4844-96ff-5196f9613ec2@amd.com>
Date: Wed, 29 Jul 2026 15:40:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix use-after-free bugs in KUnit tests
To: John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Harry Wentland <harry.wentland@amd.com>
References: <20260723233548.580891-1-John.Harrison@Igalia.com>
 <b43b52a3-9577-4e39-94db-75fd7f62c3ad@amd.com>
 <0dcfdc1a-cae8-403b-acff-01cc65bb0846@Igalia.com>
 <37d52d4e-7f4c-4467-83b5-99ccf6f73558@amd.com>
 <9143dbcd-84ff-4210-9c8a-8054e5dc6bf9@Igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <9143dbcd-84ff-4210-9c8a-8054e5dc6bf9@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 718df427-b63e-42de-f30e-08deedb9fd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mPnpDAU6o2hZczRLQXz2XezJv71rBL5HPIDbIq1HoXnsWLLtrIO3qY56EQq5k2njZZCDKwGzwuzmjQ8B3qw9FAOuq1RPb5zCNt8rC2Q2qirFk6tULnqeYIaeoM4BpmEVNIIl1Y30ZVV0pdfy85IFEaB7MpJXBNykag6hlOyZWWqWd704+T84W5db0pRKb77STo7lTjjBsrl529Ek1RnV9padbSVJ82O372NCXW48pbGcNuz2/IpbrpPi8ZSHDVLFlCqt2DT4y/U8kBsxTfvjlt5cbLqWI9o08kbjH31Tj5ZgCz/w0SdO2RDWlpxZNYH3rHkCONXu76OVWbTfiCZOPn4P72kR9M6zJmuaeRJjWIdmPLfc0hOK3iwmx8BrdiWlfZjC4KGq2vyRMkzawJYRk7irE2g3cg8lGrlfDcB84/biryI9TsrwGlBHyBqIKzEMPN1tbZfjaa+KUjT/+YReLEBoX4AdWwfusuUWZ54KOzS9ZzYFS7kynehPfJMddZXgOmcSiDB5eRDDDYiu2PJc5zA52Ii+9BC8Jhwtvd0oghy/BJtOC60Wss8TA4ecqzxiDIzQN0VKVKfs81GcRtwFCD17NEs55PX2otiPxaWn1PKYeyLTaohTzegEFid1VwYH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdoT3JhMWFhS3ZYYXdzclkrS3dxZm1jdnlRMFBCYklKRDhBTzdBbmo3anpP?=
 =?utf-8?B?UkI5ZUZ5Y3dXelA5N3pJdlBrZytzOFl3UmltVWcyRGVJQVlEUjZZenIwcjU3?=
 =?utf-8?B?c1NJQjJLMUJFL2dKZU0vZXFaS1N0WUhrOG4rSUVxRmdEWnpqREpMa0g4R2Q5?=
 =?utf-8?B?NEZYN3ptc1luZGFSSS90U0YxQXZjL0NUK0Fac1ZEVjdaaVdyMnY1bWlzQjZm?=
 =?utf-8?B?MmtVUnBkS0FHdG5jNkZhRWRDQ0VMN0VXc3ptazRwcDhQT0htdThsQ3ZML0xL?=
 =?utf-8?B?UGQzak9uUSs2dFo5c0VIaXVlVnp4NlpuQ1c3amUxZWNVMzhPZjgxS2FLaEx0?=
 =?utf-8?B?YlpGcVBnQW55UFBoQUI0N1RKejBEdjN2QUdEUUx4clJyKzBuZUlDajFVRFV6?=
 =?utf-8?B?QXNVMG9IMFhPWmtraWlYNEVXOHJWYzRmckpQZFdsZXBHVWt3cjg0WFVSeWtx?=
 =?utf-8?B?Y0lYcjZ6czZ0NUUweXYxbk9KbDVzTFg4enI4dys3TmVqZ01JaE9OMWN4a3Fj?=
 =?utf-8?B?b0pSWVZLRjZmKzVFR2xHT2dLWkpuY2Nkbk96Uldwb20rbEoxZFJqRSt1dHNE?=
 =?utf-8?B?bTJ5ank2QW5JbGpzWktDZHRWUGJ4SEFTc1MxSmNLa0NMU2RMeENwRVhRZWdQ?=
 =?utf-8?B?MjZ6YUVlYjhOMzJYdlBFczNZK2VMVWlTZ1VOeUQwYThBNFRGTytXOUZaYVZv?=
 =?utf-8?B?ZzZTcDc4Rk82eXdhTzg0U0x5Q0hydTB2NTZLYkR4Q2Q1RWVrOWNHWUVPZXZE?=
 =?utf-8?B?d01aT244ZEdJTnBmV3RoME1oT3M4UnA2ZmhhK1IyNjlXaEJXYzRXMyt4SUN5?=
 =?utf-8?B?akhIK1lIejZOalZvbk9oMWdsRmtkaEpleEk2VzdDcDN6elRuMGRzMmVwQjlM?=
 =?utf-8?B?WEEyK1hROHh0MFpHS3hYN0xxMmxNVXF2Sk1yNlQ0K3dlcXl1OUlzUUdUSzRm?=
 =?utf-8?B?SU1RelZkR1VLSEp5djdTajRaK3ZMRy83Q2pBeTRhYlJ5eVp6UWE5dmNYVDQ2?=
 =?utf-8?B?dUhjeXJwTEg0Z2tlSkZpTFI0U2tiZ2VNV3hQSXlOZzVmMmN5cjBpdEhPVzhz?=
 =?utf-8?B?UktJajVJeGhmT3pTRmtGNjZnNjQ1SjJWQTVqay9SZUViTHpaU09HYWhSaHll?=
 =?utf-8?B?Y3dZeU9xKzZqeS9xbXV4bk9URDFDL2pMbnpSM0hURzN2M3c2WVNRNHVDSTJF?=
 =?utf-8?B?SG1BVC9CSVFvSE11bzkrclBMaVd5L20vRkUrMnRJdENkbEcwUUQyM1JsVDht?=
 =?utf-8?B?V0xiMG9wQ2FOcGphS1BVQzY5NVYrM2plazZZUlI5ZW9mZkhkOHV4Q05oNThm?=
 =?utf-8?B?M29uajJES3VKQnhkNE5WN2VpWkl6YWlkNGp4MnRhWnIzWnpzd2p6R0szeTVM?=
 =?utf-8?B?NE5VSU10OEdNbStvQURXaEdlQ3E1bVlCMTRGVUs2RlpHYUJ3VjRpK2NzeUxW?=
 =?utf-8?B?anlyNjdMWGlUbWtsTDE3RWZ5aHVSM0tDNjZnVjg0YU5jeTRBcHBKUlJGYW5T?=
 =?utf-8?B?dzZwVlZpTStQTVFpMTdCczFRME9OcnJDTnlXb0ZEZkdlT2kwempxVU5QK1Np?=
 =?utf-8?B?V1p4eWkzR0IwTTlBTFVWR01GbTVyRXJNQkpKeHRRRkNUSzFrUHlvNEdTcW9S?=
 =?utf-8?B?UjRpd1pFV1FuTmsyRFZwb2NnSDRXYUtKTzZ4eDIrdGJRUlRoUjBQMUd5UnA0?=
 =?utf-8?B?STlnYmZMVUVxdmtsblpQUkx6Um1xMkxEQ0NhaDBjdThVWHVSY1JlR09TdWd2?=
 =?utf-8?B?bWpvTERaQklSWjNHdHgxRjBwZS9OaE4wR1FoYmdST1FVNnd6Y0tuM1hTdWRy?=
 =?utf-8?B?QXRaaDd1SVN6VHFGUUh1UENueVlEbHF4OVFiYUQ5Tlk0Z0NYOGFxU1M3WXdi?=
 =?utf-8?B?bk5LbjA1MndIT1JEUHViWUpNTDJBN1pVZ3dPLy9BbzNZODU3UUtEMndmWjN1?=
 =?utf-8?B?QjRVcFpKTnhQS0VZcU9BZUJhMFFvNFdqSmVoaFp1S0wwMGdZU0I5dU9lK0RR?=
 =?utf-8?B?WVFRTEJIcFQvSXNtM1Z2Y0JTSFdIV28rWmllUkhxSWhWakFxK0wweWFyTCtv?=
 =?utf-8?B?TVY2MUhJNkRoeVBPUko2OGRBUy8rMW0wb3FxS3RLR2hUd1pHQVZ1bDZ6V2JZ?=
 =?utf-8?B?YjZkbXhwRUJxRU02MVJ5R01ReVNOQkhwUWRnVHVwTXJTSzZXdnlVK0Q5ZENM?=
 =?utf-8?B?TkdqYytJczR6RmZrMTNpcEVlTGhEczJGMzFTRm1seHRHaDlMWERjQXhaam9G?=
 =?utf-8?B?U3Vjb3hYNEhxZ1pKLytvVU14NlJ2cjdtbkx4aUFPRVZraThjdWlkWnJDdTY5?=
 =?utf-8?Q?8Ffj6GHn18Go8MG2fp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718df427-b63e-42de-f30e-08deedb9fd2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:40:20.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EkYX0XRUGyE3i7mov7JjwBmNTNVeglKsgKd9ss1GIoTUabwK/F4mybfIBeGeMz1v+ZbbMRdUmtc288zskc20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
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



On 7/29/26 15:24, John Harrison wrote:
> On 7/24/26 14:36, Alex Hung wrote:
>> On 7/24/26 15:09, John Harrison wrote:
>>> On 7/24/26 12:37, Alex Hung wrote:
>>>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>>>>
>>>> With two comments:
>>>> 1. There is a minor conflicts on include
>>>> 2. The following code seems to have the same patterns (passing to 
>>>> drmm_* functions). Do they need to be changed too?
>>> None of those functions exist in my tree. Which might also explain 
>>> the include conflict. I'm using drm-tip fetched the same day I posted 
>>> the patch. Should I be basing the patch on a different tree?
>>
>> My bad. My local branch contains additional patches.
>>
>> I will create a patch for this four additional changes. Thanks for 
>> pointing this out.
> Can this patch be merged? It would be good to get the existing issues 
> fixed.

Hi John,

This patch is merged in Alex Deucher's amd-staging-drm-nex tree 
(https://gitlab.freedesktop.org/agd5f/linux)

The commit is 
https://gitlab.freedesktop.org/agd5f/linux/-/commit/637871507797e15bb109cec428877e56cfd94266

> 
> Thanks,
> John.
> 
>>
>>>
>>> John.
>>>
>>>
>>>>
>>>>
>>>> --- drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_connector_test.c
>>>> +++ drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_connector_test.c
>>>> @@ -3645,7 +3645,7 @@ static struct dm_test_stream_ctx 
>>>> *dm_test_stream_ctx_alloc(struct kunit *test)
>>>> DRIVER_MODESET);
>>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>>>
>>>> -       ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>> +       ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>>         KUNIT_ASSERT_EQ(test,
>>>>                 drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>> @@ -3903,7 +3903,7 @@ static void 
>>>> dm_test_poll_dac_load_returns_cached(struct kunit *test)
>>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>         adev = drm_to_adev(drm);
>>>>
>>>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>         KUNIT_ASSERT_EQ(test,
>>>>                 drmm_connector_init(drm, &aconnector->base,
>>>> @@ -3950,7 +3950,7 @@ static struct amdgpu_dm_connector 
>>>> *dm_test_reg_connector(struct kunit *test)
>>>> DRIVER_MODESET);
>>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>
>>>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>         KUNIT_ASSERT_EQ(test,
>>>>                 drmm_connector_init(drm, &aconnector->base,
>>>> @@ -4405,7 +4405,7 @@ dm_test_modes_ctx_alloc(struct kunit *test, 
>>>> int connector_type)
>>>>         ctx->drm = dm_test_alloc_drm(test);
>>>>         ctx->aconnector = dm_test_add_connector(test, ctx->drm, 
>>>> connector_type);
>>>>
>>>> -       ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), 
>>>> GFP_KERNEL);
>>>> +       ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), 
>>>> GFP_KERNEL);
>>>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
>>>>         KUNIT_ASSERT_EQ(test,
>>>>                         drmm_encoder_init(ctx->drm, &ctx->aenc- 
>>>> >base, NULL,
>>>>
>>>>
>>>> On 7/23/26 17:35, John Harrison wrote:
>>>>> When running the KUnit tests with memory debugging enabled, a bunch of
>>>>> use-after-free errors are hit. These are due to using KUnit managed
>>>>> memory for the test objects but then giving them over to DRM managed
>>>>> objects. The KUnit stuff is deallocated first and when the DRM side
>>>>> calls its clean up helpers, it hits memory that has been freed 
>>>>> already.
>>>>>
>>>>> NB: There is still a use-after-free bug in the writeback tests.
>>>>> However, fixing that requires driver side changes as well as test side
>>>>> changes. Those changes are part of:
>>>>>    https://patchwork.freedesktop.org/series/152420/
>>>>>
>>>>> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
>>>>> CC: Alex Hung <alex.hung@amd.com>
>>>>> CC: Harry Wentland <harry.wentland@amd.com>
>>>>> ---
>>>>>   .../tests/amdgpu_dm_connector_test.c          | 37 +++++++++ 
>>>>> +---------
>>>>>   .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  3 +-
>>>>>   .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  5 ++-
>>>>>   3 files changed, 24 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>>>> tests/amdgpu_dm_connector_test.c
>>>>> index 0a5d439f66c3..93a854d4fdfa 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_connector_test.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_connector_test.c
>>>>> @@ -12,6 +12,7 @@
>>>>>   #include <drm/drm_crtc.h>
>>>>>   #include <drm/drm_edid.h>
>>>>>   #include <drm/drm_kunit_helpers.h>
>>>>> +#include <drm/drm_managed.h>
>>>>>   #include <drm/drm_mode_object.h>
>>>>>   #include <drm/drm_property.h>
>>>>>   #include <linux/hdmi.h>
>>>>> @@ -1449,7 +1450,7 @@ static void 
>>>>> dm_test_funcs_reset_sets_defaults(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>>> @@ -1488,7 +1489,7 @@ static void 
>>>>> dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>>> @@ -1526,7 +1527,7 @@ static void 
>>>>> dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>>> @@ -1568,7 +1569,7 @@ static void 
>>>>> dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>>> @@ -2359,8 +2360,8 @@ static void setup_panel_type_fixture(struct 
>>>>> kunit *test,
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
>>>>>       fixture->adev = drm_to_adev(fixture->drm);
>>>>>   -    fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture- 
>>>>> >aconnector),
>>>>> -                        GFP_KERNEL);
>>>>> +    fixture->aconnector = drmm_kzalloc(fixture->drm, 
>>>>> sizeof(*fixture->aconnector),
>>>>> +                       GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
>>>>>       fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), 
>>>>> GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
>>>>> @@ -2554,9 +2555,9 @@ static void 
>>>>> dm_test_update_subconnector_dp_with_sink(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>>> GFP_KERNEL);
>>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>>> &dm_test_connector_funcs,
>>>>> @@ -2598,9 +2599,9 @@ static void 
>>>>> dm_test_update_subconnector_dp_no_sink(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>>> GFP_KERNEL);
>>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>>> &dm_test_connector_funcs,
>>>>> @@ -2641,9 +2642,9 @@ static void 
>>>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>>>                              DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>>> GFP_KERNEL);
>>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>>> &dm_test_connector_funcs,
>>>>> @@ -2657,7 +2658,7 @@ static void 
>>>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>>>         link->dpcd_caps.dongle_type = 
>>>>> DISPLAY_DONGLE_DP_HDMI_CONVERTER;
>>>>>       aconnector->dc_link = link;
>>>>> -    aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector- 
>>>>> >dc_sink), GFP_KERNEL);
>>>>> +    aconnector->dc_sink = drmm_kzalloc(drm, sizeof(*aconnector- 
>>>>> >dc_sink), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
>>>>>         update_subconnector_property(aconnector);
>>>>> @@ -2804,7 +2805,7 @@ static struct amdgpu_dm_connector 
>>>>> *dm_test_add_connector(struct kunit *test,
>>>>>   {
>>>>>       struct amdgpu_dm_connector *aconnector;
>>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>>> GFP_KERNEL);
>>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>>         KUNIT_ASSERT_EQ(test,
>>>>> @@ -3103,7 +3104,7 @@ static struct dm_test_panel_ctx 
>>>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>>>>       KUNIT_ASSERT_NOT_NULL(test, prop);
>>>>>       ctx->drm->mode_config.panel_type_property = prop;
>>>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>>>> >aconnector), GFP_KERNEL);
>>>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>>> >aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>>>       KUNIT_ASSERT_EQ(test,
>>>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>>> @@ -3112,7 +3113,7 @@ static struct dm_test_panel_ctx 
>>>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>>>> drm_object_attach_property(&ctx->aconnector->base.base, prop,
>>>>>                      DRM_MODE_PANEL_TYPE_UNKNOWN);
>>>>>   -    ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), 
>>>>> GFP_KERNEL);
>>>>> +    ctx->link = drmm_kzalloc(ctx->drm, sizeof(*ctx->link), 
>>>>> GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->link);
>>>>>       ctx->aconnector->dc_link = ctx->link;
>>>>>   @@ -3376,14 +3377,14 @@ static struct dm_test_fill_ctx 
>>>>> *dm_test_fill_ctx_alloc(struct kunit *test)
>>>>>                                  DRIVER_MODESET);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>>>> >aconnector), GFP_KERNEL);
>>>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>>> >aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>>>       KUNIT_ASSERT_EQ(test,
>>>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>>>                       &dm_test_connector_funcs,
>>>>>                       DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
>>>>>   -    ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx- 
>>>>> >conn_state), GFP_KERNEL);
>>>>> +    ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>>> >conn_state), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
>>>>>       ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), 
>>>>> GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>>>> tests/amdgpu_dm_kunit_helpers.c
>>>>> index 58615cdbe854..7d5e3823b33b 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_kunit_helpers.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_kunit_helpers.c
>>>>> @@ -8,6 +8,7 @@
>>>>>   #include <kunit/test.h>
>>>>>   #include <linux/module.h>
>>>>>   #include <drm/drm_kunit_helpers.h>
>>>>> +#include <drm/drm_managed.h>
>>>>>     #include "dc.h"
>>>>>   #include "core_types.h"
>>>>> @@ -127,7 +128,7 @@ struct amdgpu_dm_connector 
>>>>> *dm_kunit_alloc_connector(struct kunit *test,
>>>>>   {
>>>>>       struct amdgpu_dm_connector *aconnector;
>>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>>> GFP_KERNEL);
>>>>> +    aconnector = drmm_kzalloc(adev_to_drm(adev), 
>>>>> sizeof(*aconnector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>>         if (adev)
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_wb_test.c
>>>>> index b43bc244487e..3454cf371414 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>>>> @@ -12,6 +12,7 @@
>>>>>   #include <drm/drm_fourcc.h>
>>>>>   #include <drm/drm_framebuffer.h>
>>>>>   #include <drm/drm_kunit_helpers.h>
>>>>> +#include <drm/drm_managed.h>
>>>>>   #include <drm/drm_mode.h>
>>>>>   #include <drm/drm_modes.h>
>>>>>   #include <drm/drm_writeback.h>
>>>>> @@ -266,7 +267,7 @@ static void 
>>>>> dm_test_wb_get_modes_returns_modes(struct kunit *test)
>>>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, 
>>>>> &dm_wb_test_connector_funcs,
>>>>> @@ -301,7 +302,7 @@ static void 
>>>>> dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
>>>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>>> GFP_KERNEL);
>>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>>         drmm_connector_init(drm, connector, 
>>>>> &dm_wb_test_connector_funcs,
>>>>
>>>
>>
> 

