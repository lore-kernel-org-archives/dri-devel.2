Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC7C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7630410F48B;
	Fri, 24 Jul 2026 21:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuqqXvcf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED5D10F48B;
 Fri, 24 Jul 2026 21:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTB5or2iMoo3ibHnJ+V86PJLrTdJCKewrzairczjUDbAPiTB75xmcy+5NXZeL6cmBP4JpfvPd1JpaSrHfXAjyjIzU/5nBd5bTpgdXvk/BXuGEfb4GhgdXqS9137AOlnW4GG06nbC+Fapa+XsyZJjbZ/fnOtEiyBn5A75/HBOVvvosjkLoDTDKyXWVS1iM6SxlRY7LE/TdPyME4dOSiU9wRQoZ1NjHqQhteWCtgEGoeuvoqVzt/mG+4zSEs8Ytat80Aprn1L3yV48ePq2WruXcBUq9O5zhD9iaRcQsm7R9LwtWSyBGfGdUQqWweyhh1IRO7EjJAhUNEO7Pt21ImtuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9CIIsFrQVvhKyuv7yOucCxYbQMQT100vTwqLDv91bw=;
 b=xi9u4A8Ykiw3Jn/2oclIMPlm5Wm4Q9Yl8BEinPFgNKBqq+N9RKIaT2r4oX5ME2kPkreoNnW1pP6gbzpTXeas1ACx96Q0wroCVAQvx+lp7Wx2cF+hUpeFqmVatj7hG1FZrI0dutAHSLTXOl5E6WA3txhN/VOjSQ1omt65ImMnAQCh9jxrBnVkng4xFJajqqVjzrO9odkX/uKgkVVYSlBOYmqLVikKoKrVKc3YOV5xV03qLAB1KzZ2WhdewAZ3MMIiESq+1f32PPzoDsjk39CDhDKmaXyJzPyHs1Z/zp90bu39O3QAptb/+r6C6fdo9qtqLlc0YTWoIiaA52yzhC7dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9CIIsFrQVvhKyuv7yOucCxYbQMQT100vTwqLDv91bw=;
 b=yuqqXvcfOfz2ukYm58j1GPX0O6nekRZw/4HaEjD/k7yeXYzcSIwDmTdWydhlpU923MP5Za8vIKskPW4pnAIsDCYnwPo7DTp90mSjvh66fJxARA96sH+glOvadjJGJTP/wULqTsJqCT9V2XqjoIMa+zLY7d8jQ2nh2D4ri8PVoGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:36:05 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 21:36:05 +0000
Message-ID: <37d52d4e-7f4c-4467-83b5-99ccf6f73558@amd.com>
Date: Fri, 24 Jul 2026 15:36:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix use-after-free bugs in KUnit tests
To: John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Harry Wentland <harry.wentland@amd.com>
References: <20260723233548.580891-1-John.Harrison@Igalia.com>
 <b43b52a3-9577-4e39-94db-75fd7f62c3ad@amd.com>
 <0dcfdc1a-cae8-403b-acff-01cc65bb0846@Igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <0dcfdc1a-cae8-403b-acff-01cc65bb0846@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: aae85104-de3d-4401-0b9e-08dee9cb90e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bo36LWoXS6SePBF0Wu3dzwioQ3LUe5NTSscJiLPX5Z6FpeNZkqZH+5zy06P4qQ9vhTr9iDqBZ+mdZlVT2uiV03RBNM336l2e0egsD0TCKv63CdNoBkS2U9obwrgHGjApLoncLJGk3BJHH/2LMoxGTy8dVYr5ndJVwyRTvx6CMf4d1akwGHayOR/bOWsNbzwtf2/pm0nr7w8rva2ZRLzyKVZgZEgQ1w2HZvB9s25d+6WsgQT1Fc2QsiVSwzeZvDdhuMJ0/PxhvN3g0Yh1Dw0ZHGfr+IAsFIsL8iORtq9aGNMkUhJ/2kCtErpI+lz9A+mySlBBBrGnYECJ6N+4S8+t+vSOLB4oi4tcNhk3YF+UAiKrQkww580SN5IyDPpZY4422oF1HmoxC/ToQohRd6rB97exDfpVkR47+/1ESpozwItBXi50yzidztB5ULk6eeSvs7XqziKzEW+vBmL6qtQS8q77GaBrO9x21tFx7TyxOvBBx1+PgPMWZXrn+exxMc1O8qV2LbgPP2TPFADDbVyTq7kV+f8kp8iRc3VDJQ6K8y5HnsaocBG2Ng3gCyp75noUYSIIH45eqzYGEPeG8Mk9B1FRk+VC3nhRHTBEGnp2N7QHvdTlqQhWivE0drOx25QO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekF2T3cralRiMHVKMkJvaTB1ODNjZnJIQkwrd1lHck1LSUEva3ZueEhNdU5q?=
 =?utf-8?B?U2p6dVJXRzRhekszU2FRNG1DUm9XdUNpb1ZXWEcwM04vTDJQS1kvRGVnRm93?=
 =?utf-8?B?c25LRWYybEVVbmlWQk1VN05oSXNOMXNhMnQ0YWJRVzhmWWg0SlpCUzg4QUhw?=
 =?utf-8?B?UmhVRENyWUNxb1VnbGNHTlNpNUdRdUF3b0ZmYU8wRTFmNlMzNllpSHZrdHBq?=
 =?utf-8?B?VjB4bWw4c3NiTEt1VlhyVFNidjQ3ZHdndnc1V3BubXRpakhOWXhUaHpjenJI?=
 =?utf-8?B?ZkRpMngvZkhpN0tEWXBGRFZzSisyQllXT3NDYVVRT0svd05BUGkzb2dBSUhz?=
 =?utf-8?B?L3czWTVvbld6N3U1WW02cHM4aDdxRngvb2x0c0N2OHFHQXRQR2V3VHNKZDVv?=
 =?utf-8?B?WHFSay81d2dLYUU5eHlrejJaTDJ5VGhvdmdManpTZDg3SkxyUDFlak9rVzZN?=
 =?utf-8?B?SHNTM1ZKcE9HSStiV1BodnZBV1U5RUFMdXEwQmszS0RlRFBGbE4rMjZGZ25w?=
 =?utf-8?B?TEQvS3VVd1dYVEZjUFJJTjVUeE1zR3d1Qm9Wdk5KR0ZHM0Rlb1lYdWhYNDJS?=
 =?utf-8?B?QW96TDhKNEpEVWNNL1oyc0FhTVFFOE9wNUZtSUFRVytvWEh6VUJWbjM4T1V5?=
 =?utf-8?B?SHpqRDU4dEVySU41MzdMaGlYbDRqdlpUdmhsQ25XTEUvWGtYbFBSV0ZmVjJh?=
 =?utf-8?B?aUJ3VGk5cFdsZXNHYjFyb3U3MWpRblRPdm85L3FiTDZIdkUvRlFXTitPeUpa?=
 =?utf-8?B?dng1a1lxd09Sb2ZQamlmVWRnb2VUSXhtVDU0eE45RWkyK0hDeUE3UnJXTHM5?=
 =?utf-8?B?c3hQK1VDMDYzYzJxNnF2dkFhTEZzZjN3bHNWRExaTGhvZFNLUmovQ0VoVkND?=
 =?utf-8?B?ZzAydkErL3Mwd3Z5aFVrZytKWlR2L25sTE1wV01Jd0I3Y2JKdm95QWZjYnVJ?=
 =?utf-8?B?bWtOTlU3NzBIODJwaDBnQjJYMHkwZjYwVmUzdlZJUXFBQzlIeEwvOE4rU29o?=
 =?utf-8?B?VU5uTmlMZGdKTENzdGVrYXJuUHBOUVFETFNuLy9PS0dldzFFL0U2RWNaMVRh?=
 =?utf-8?B?aUJxTkpHaVpvK1B6aEhYbW1nVkRpK3FnWTBWNU40OFI5SW4xQzZrNmZsY01L?=
 =?utf-8?B?RnYyWmoxVE1YVDk4aUt6RW9nNHFoUGRWa0JGdlBjTFkyWDhIazVHZHFoK1JN?=
 =?utf-8?B?WGJYME5DNkNtZ0ZkbEZ4MlNGNDJlS0JXdEwzcm8vSWtua0UyY1RYY29hTWJK?=
 =?utf-8?B?dENOK0ZUVitpRnZCUiszKzZlU1pNViszenNwVWpDLzd1d0IrWEE1SXNHUXBW?=
 =?utf-8?B?ay8ybXp0QkJkZUtLZ256VXdqT2F1a2ljMSs5YjVwRXpkdCtpYmVkWVVjWDMv?=
 =?utf-8?B?VmRvRmZSNHVtSzh3TjFCbFRVWmpLN3BVaGdRcG95dkx3QnkxSlRuTFZvdHlu?=
 =?utf-8?B?WExtZ0tJTFBCb1IxWVA1Z05FQ2JGRWZ5aW9kQTBBY3d4UGRuZEFtaElScFFZ?=
 =?utf-8?B?NGVCN3EzbEgwUmcvZTRxRGtjMmE0eVdQaUpKcktSajV1ZytUdHdQNWV2Y1d0?=
 =?utf-8?B?ekRZSUttTE0wWnczQXhpYmVuenhEOWp4YzhGRDZ0Q1VLVmVqYVcwVkgzUWlT?=
 =?utf-8?B?S3hUR2w2ZkVTRENtTmlwbkJ2Ym5wV3o2enN1VE96MWs2TkVqQitKNDFSK2pD?=
 =?utf-8?B?UTFmRnhEVXFPQ2huai95bGk3VXZhb08zTVZ0aGpmV0I3VnJJQk81NGpXYzFv?=
 =?utf-8?B?OUZIWXBzcXM4Um9IUE5CYm5GdFJwUmZZK1FBY0hXbHBQMmJQYjVzQkFGdkhr?=
 =?utf-8?B?bTd4MXlTQkpGS29Ba2RWR1JtNGIzSW4yY29Dd25oVDkwZ1ZPcEk3TStSM1pq?=
 =?utf-8?B?enNZTnVCR3EyNjkyTWFyelVvZTg0MXU3blpmRk5ac0d5emk1Snp4YkU4MFAr?=
 =?utf-8?B?NVBKME4waE96R1h5cklYR2FYdmtGNzdaeFFEWEcyTE5OVzRQVzJ4SVNlYzBp?=
 =?utf-8?B?aFA3V1V4aWIydFV3bEt1S0tBUlJDSmtaREYwYWFEc2pnR1FxRkdOYWNiejNj?=
 =?utf-8?B?Y29GOXQvQkY3cjZPZERiK1ZVdkY1aklFeVlOY25oa2lTT2wvbUQzYzRWT0ly?=
 =?utf-8?B?T0V1QzhuMUU0NU1vRCtZOTNzR3dvS2FuNG96K3F3Wk00RWVEVis0eS9aek1W?=
 =?utf-8?B?SVBxMHlWSE1uajlHS2FBaW9KK3NnT0l2Yms0NVVvV0xPV1dRRUtyN1ZzU3lF?=
 =?utf-8?B?TmxHQXc4TU5INlJDTmZSUitZYXBEbHc1Z3BvTXRDNUZzdmh5L2Q4NjFvMUQ2?=
 =?utf-8?Q?Cwa59IOcVJg1Wly8QA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae85104-de3d-4401-0b9e-08dee9cb90e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:36:05.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y12n3njCKFnrddKUvaGKwpwVOavZMG0aYhokzRrDS+YKFt8h8aWA+hOJT5D0VOP7uYQhwVtqZbIN4nDE4PohSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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



On 7/24/26 15:09, John Harrison wrote:
> On 7/24/26 12:37, Alex Hung wrote:
>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>>
>> With two comments:
>> 1. There is a minor conflicts on include
>> 2. The following code seems to have the same patterns (passing to 
>> drmm_* functions). Do they need to be changed too?
> None of those functions exist in my tree. Which might also explain the 
> include conflict. I'm using drm-tip fetched the same day I posted the 
> patch. Should I be basing the patch on a different tree?

My bad. My local branch contains additional patches.

I will create a patch for this four additional changes. Thanks for 
pointing this out.

> 
> John.
> 
> 
>>
>>
>> --- drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>> amdgpu_dm_connector_test.c
>> +++ drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>> amdgpu_dm_connector_test.c
>> @@ -3645,7 +3645,7 @@ static struct dm_test_stream_ctx 
>> *dm_test_stream_ctx_alloc(struct kunit *test)
>> DRIVER_MODESET);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>
>> -       ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>> >aconnector), GFP_KERNEL);
>> +       ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>> >aconnector), GFP_KERNEL);
>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>         KUNIT_ASSERT_EQ(test,
>>                 drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>> @@ -3903,7 +3903,7 @@ static void 
>> dm_test_poll_dac_load_returns_cached(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>         adev = drm_to_adev(drm);
>>
>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>> GFP_KERNEL);
>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>         KUNIT_ASSERT_EQ(test,
>>                 drmm_connector_init(drm, &aconnector->base,
>> @@ -3950,7 +3950,7 @@ static struct amdgpu_dm_connector 
>> *dm_test_reg_connector(struct kunit *test)
>>                                                   DRIVER_MODESET);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>
>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>> GFP_KERNEL);
>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>         KUNIT_ASSERT_EQ(test,
>>                 drmm_connector_init(drm, &aconnector->base,
>> @@ -4405,7 +4405,7 @@ dm_test_modes_ctx_alloc(struct kunit *test, int 
>> connector_type)
>>         ctx->drm = dm_test_alloc_drm(test);
>>         ctx->aconnector = dm_test_add_connector(test, ctx->drm, 
>> connector_type);
>>
>> -       ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), GFP_KERNEL);
>> +       ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), 
>> GFP_KERNEL);
>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
>>         KUNIT_ASSERT_EQ(test,
>>                         drmm_encoder_init(ctx->drm, &ctx->aenc->base, 
>> NULL,
>>
>>
>> On 7/23/26 17:35, John Harrison wrote:
>>> When running the KUnit tests with memory debugging enabled, a bunch of
>>> use-after-free errors are hit. These are due to using KUnit managed
>>> memory for the test objects but then giving them over to DRM managed
>>> objects. The KUnit stuff is deallocated first and when the DRM side
>>> calls its clean up helpers, it hits memory that has been freed already.
>>>
>>> NB: There is still a use-after-free bug in the writeback tests.
>>> However, fixing that requires driver side changes as well as test side
>>> changes. Those changes are part of:
>>>    https://patchwork.freedesktop.org/series/152420/
>>>
>>> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
>>> CC: Alex Hung <alex.hung@amd.com>
>>> CC: Harry Wentland <harry.wentland@amd.com>
>>> ---
>>>   .../tests/amdgpu_dm_connector_test.c          | 37 ++++++++++---------
>>>   .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  3 +-
>>>   .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  5 ++-
>>>   3 files changed, 24 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>> tests/amdgpu_dm_connector_test.c
>>> index 0a5d439f66c3..93a854d4fdfa 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_connector_test.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_connector_test.c
>>> @@ -12,6 +12,7 @@
>>>   #include <drm/drm_crtc.h>
>>>   #include <drm/drm_edid.h>
>>>   #include <drm/drm_kunit_helpers.h>
>>> +#include <drm/drm_managed.h>
>>>   #include <drm/drm_mode_object.h>
>>>   #include <drm/drm_property.h>
>>>   #include <linux/hdmi.h>
>>> @@ -1449,7 +1450,7 @@ static void 
>>> dm_test_funcs_reset_sets_defaults(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>> @@ -1488,7 +1489,7 @@ static void 
>>> dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>> @@ -1526,7 +1527,7 @@ static void 
>>> dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>> @@ -1568,7 +1569,7 @@ static void 
>>> dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>> @@ -2359,8 +2360,8 @@ static void setup_panel_type_fixture(struct 
>>> kunit *test,
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
>>>       fixture->adev = drm_to_adev(fixture->drm);
>>>   -    fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture- 
>>> >aconnector),
>>> -                        GFP_KERNEL);
>>> +    fixture->aconnector = drmm_kzalloc(fixture->drm, 
>>> sizeof(*fixture->aconnector),
>>> +                       GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
>>>       fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), 
>>> GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
>>> @@ -2554,9 +2555,9 @@ static void 
>>> dm_test_update_subconnector_dp_with_sink(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>         drmm_connector_init(drm, &aconnector->base, 
>>> &dm_test_connector_funcs,
>>> @@ -2598,9 +2599,9 @@ static void 
>>> dm_test_update_subconnector_dp_no_sink(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>         drmm_connector_init(drm, &aconnector->base, 
>>> &dm_test_connector_funcs,
>>> @@ -2641,9 +2642,9 @@ static void 
>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>                              DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>         drmm_connector_init(drm, &aconnector->base, 
>>> &dm_test_connector_funcs,
>>> @@ -2657,7 +2658,7 @@ static void 
>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>         link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
>>>       aconnector->dc_link = link;
>>> -    aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector- 
>>> >dc_sink), GFP_KERNEL);
>>> +    aconnector->dc_sink = drmm_kzalloc(drm, sizeof(*aconnector- 
>>> >dc_sink), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
>>>         update_subconnector_property(aconnector);
>>> @@ -2804,7 +2805,7 @@ static struct amdgpu_dm_connector 
>>> *dm_test_add_connector(struct kunit *test,
>>>   {
>>>       struct amdgpu_dm_connector *aconnector;
>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>         KUNIT_ASSERT_EQ(test,
>>> @@ -3103,7 +3104,7 @@ static struct dm_test_panel_ctx 
>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>>       KUNIT_ASSERT_NOT_NULL(test, prop);
>>>       ctx->drm->mode_config.panel_type_property = prop;
>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>       KUNIT_ASSERT_EQ(test,
>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>> @@ -3112,7 +3113,7 @@ static struct dm_test_panel_ctx 
>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>> drm_object_attach_property(&ctx->aconnector->base.base, prop,
>>>                      DRM_MODE_PANEL_TYPE_UNKNOWN);
>>>   -    ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
>>> +    ctx->link = drmm_kzalloc(ctx->drm, sizeof(*ctx->link), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->link);
>>>       ctx->aconnector->dc_link = ctx->link;
>>>   @@ -3376,14 +3377,14 @@ static struct dm_test_fill_ctx 
>>> *dm_test_fill_ctx_alloc(struct kunit *test)
>>>                                  DRIVER_MODESET);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>       KUNIT_ASSERT_EQ(test,
>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>                       &dm_test_connector_funcs,
>>>                       DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
>>>   -    ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx- 
>>> >conn_state), GFP_KERNEL);
>>> +    ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>> >conn_state), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
>>>       ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), 
>>> GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>> tests/amdgpu_dm_kunit_helpers.c
>>> index 58615cdbe854..7d5e3823b33b 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_kunit_helpers.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_kunit_helpers.c
>>> @@ -8,6 +8,7 @@
>>>   #include <kunit/test.h>
>>>   #include <linux/module.h>
>>>   #include <drm/drm_kunit_helpers.h>
>>> +#include <drm/drm_managed.h>
>>>     #include "dc.h"
>>>   #include "core_types.h"
>>> @@ -127,7 +128,7 @@ struct amdgpu_dm_connector 
>>> *dm_kunit_alloc_connector(struct kunit *test,
>>>   {
>>>       struct amdgpu_dm_connector *aconnector;
>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +    aconnector = drmm_kzalloc(adev_to_drm(adev), 
>>> sizeof(*aconnector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>         if (adev)
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_wb_test.c
>>> index b43bc244487e..3454cf371414 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>> @@ -12,6 +12,7 @@
>>>   #include <drm/drm_fourcc.h>
>>>   #include <drm/drm_framebuffer.h>
>>>   #include <drm/drm_kunit_helpers.h>
>>> +#include <drm/drm_managed.h>
>>>   #include <drm/drm_mode.h>
>>>   #include <drm/drm_modes.h>
>>>   #include <drm/drm_writeback.h>
>>> @@ -266,7 +267,7 @@ static void 
>>> dm_test_wb_get_modes_returns_modes(struct kunit *test)
>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
>>> @@ -301,7 +302,7 @@ static void 
>>> dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>         drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
>>
> 

