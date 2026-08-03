Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA5C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DE210E239;
	Mon,  3 Aug 2026 07:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="taPROM5y";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7B410E233;
 Mon,  3 Aug 2026 07:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp4X4s2Qp9Eb8Xnh5ISHFgecnLoS44pzGoKgdArRC5CjK9Oor4AYGVrs4yuEmCeB7Gpe5gvD7nmUeOwF7UjRKUUx/OV+218u+jC7JZkmqhXXFeZcymISCdN0v65eDPsm+OdAhgYZsbssP95UhQwI5bGfqPebDxGGykf93l/JMmPoSBjPdPfBOFl761ZEqB/pQFnA62TgDW/jtoweX8fH3pJjtBMeb2Lx4rmD/6r8Bn1SajKOLl5E4cH1Hj8ohykTDEIeZKFsPj65042fE0cA7YhTcyLQb7XOZc4XhzYunv+D+CZQRqFYQMsBq7SEQYS7SIUbmMrZFFx3Q8YZwxkesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0E1Jxcej/v1sOUo3/hxgFlQW1bCBbYYXYB+5skxFCc=;
 b=I0Q8D4/iLWyHRXvAI772Yt2f9heRGBXzbOJQN6vQosIS8XpExN/DxuGAnGpLdh0wmxRCSoeZbP7q+KF3jUR36+hMcatYcne1/X4my8nOFMRP3BVkViCJGt77m9+nFi7kLVR8cnJ3kPi6LSK0LD2EaxgmV+LdCnsDROx/CAfwxmNjx3fro/7kuB+/e/zSFW7cPBLTgHaGmm0gnYeeWYQNOa4Z7AcZv8CdlQ6Ad8GA/qTot+OSbbv/YIJHgJnBi+vDm9ZXkYbOYpg+HGK1ZG40S52pOzoz6qR8WazR2ZLmtuuTEZcEEl2s64CBaVNCBat1dz4ZswqY6UPVSJ+gbusrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0E1Jxcej/v1sOUo3/hxgFlQW1bCBbYYXYB+5skxFCc=;
 b=taPROM5y0sRafBa1vjCzbc/2pywKhqStyeESmLa3x6e2iHioKP0hPa3nmm7LzSM7qEtf8Tl7nQDbeTJUBpnq7R5pD/rLr5OU7PDDgOzQL8ffixFko0OcUyYeZqdHr/D/LqMRcFcq5fuZ+dGOhPausQz1X3zQHzrAI+LhDD+Wclc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB999252.namprd12.prod.outlook.com (2603:10b6:806:4dd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 07:23:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0245.012; Mon, 3 Aug 2026
 07:23:00 +0000
Message-ID: <1cdcb9f5-2370-4605-b10a-803dcaf168c9@amd.com>
Date: Mon, 3 Aug 2026 09:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix writeback completion timing
To: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunpeng.li@amd.com, siqueira@igalia.com, mwen@igalia.com,
 tzimmermann@suse.de, ray.wu@amd.com, jpeisach@ubuntu.com,
 mario.limonciello@amd.com, cristian.ciocaltea@collabora.com,
 timur.kristof@gmail.com, ivan.lipski@amd.com, chen-yu.chen@amd.com,
 srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260711033159.3096477-1-alex.hung@amd.com>
 <b67ca397-397f-481e-9aec-cab883237eb2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b67ca397-397f-481e-9aec-cab883237eb2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:408:ff::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB999252:EE_
X-MS-Office365-Filtering-Correlation-Id: 43389eb6-b323-48fa-e17d-08def1300ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|921020|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wT0wSD9tWvZO1hY/JSIta5toJ18DtbOlT4szcXkw3kSCSHpC6v46OR94PVur5YHDGdANvnjM4cYXC89JxXvF4/x46lnFa+oYX6wc8pOWsPFhazpwAHpRCPulHn+FrZB7eIA4h4Ayr6voYNOQN8yzZTOVJty/J4NF/f+QXDx2YXpZl/oBfmQfRqMJC2mofgGWdtCmS8Fi6gIIdxSd0OLF1PLPH1cpCLRk0+nSeoheTAoO2mztPFIDJeZ+DkoWcfAjsiYP2AcuNDmO0PVooQJQUZSFew//fWQRfZn816c8PNHoHUJ46k5Gk+5B1OTPv8mxOd91hSn7aQq0x05CfLHs6u7CZOj+MzPJxy3dpolg1bWpDvlBMT07cM7F18dAfDYv/x/sH2FCroNLELwYHvgHcITcXQmGVQPQtMQJgaWwJbdZEY6tB+cUwyEf0YDQhi5RsyEoaFgoJGA/v0KyWaZoujtgNc8AjoK02ZQJ8cA9vpbe+AhWH1D1iya0aiuL3Ql0uvGJzSbJC73N6dImcphkWDV6VxVnNxuZ4eODm9EiGAB5VKRt+fKbxZC+NuqV80OxJ+JhM8Wrr15Hwz7DZc6W9FASLMPra46T2dHK+DuRbXPvxsQXmh3UoyQVv9rufxc7rOVvCYS2ne+lCRVDn24zWpwBUp41iWZImk6H8nh4mUHm4eYPsThVyka2u9I4ldm7kIeR2C9HV/qFlGSlYjRDmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(921020)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09pbEJ3WXdmSjdObUl3VlJUN2JZT2llOVlxWENZZ243SnlIeSs4Mm5KYUJr?=
 =?utf-8?B?TEZSL0VzZCtGRTNKd2h2UG5ZSGJhL0tXd3BzSndoTW16SmpWaWhHT2M0QXJ5?=
 =?utf-8?B?MGQzKzVlOGhranV3TnhMelBpNGpmR1pVS2dvZ3hSNmw5RTVKUlJkUENGMGN0?=
 =?utf-8?B?azNiYXQ5M0Zpd1NQaHF6RkVWbzVtL2o5VGx1T2NWOTQyT3RNWVhNSC85WEZy?=
 =?utf-8?B?Y3FxK1pmYStZYXJ6U2pxSkpnanZtVmxBTm9NTTBpUmt1RWpHWSsrTndJQ3FJ?=
 =?utf-8?B?TGtDdU43S2I2RFUxZTFoaEtrNFBVWURaTThCamtETEQwd05aYkROcXBZMlFv?=
 =?utf-8?B?aWsrVmhBaG5nRHhianUvKy93bmdka0l2QitkZkxKNXl5RDhYOExOM2xNNmkz?=
 =?utf-8?B?dUxtdVl2aCt5TC8zYVVLdGJTejZCczUvWUlIUTU3VXZhTTlKNEp6dGJvRWpz?=
 =?utf-8?B?dEVDRGVjVnVITTI5ZFpNVzVxeVRnaG1aeVRZeUM2dDVrUjFzc0V1TUs4K1p3?=
 =?utf-8?B?K1kwZXBMQnpXNnM2NGlmK0M3MTdOT0hQQ3RWUDVlMERYaDYzQWsrQWNYaFQy?=
 =?utf-8?B?WnBwckR3YzlTN1lJNUFQVjM0SWpoRlcvRFgxSUdTYzJ3NFlya1BLRUxSM1JS?=
 =?utf-8?B?YUN3akdTY2lzWVp1TGhFNkNzRWUyNW1iLzVmNEx5NFJyWVFMLytvTUxRVy9D?=
 =?utf-8?B?NGVRWnRqU2c1WU14UHltL1p5elpQM2FSTkpMRU9wSTY1RzNnOStZbm9jbjAy?=
 =?utf-8?B?UHAyMXZXK2tDNFM1T0dZVmRkWjFEVVRuWG5MdktWRkdRZnhqd3JmZ0Z4QWc2?=
 =?utf-8?B?U3BMTUpkcm4rcjM5VXBPMEdXUm5JUG80Y0xoa3BPMEhpMFFpdEJRN1FKM1Jk?=
 =?utf-8?B?Z1ZZTTE5V05aRklNb1k1Y2VOMU5WZDhMNjdqVTJKWmVTczB2QXh1S0ZEbEFZ?=
 =?utf-8?B?UnN4NHNTMWkxOHUzOUg5ZWxmL25RZ2RQTzR1R2JVYkhCejlkVTRVc1c3d0U1?=
 =?utf-8?B?WHVBaW1PQ1EwU2NjM1hoTkdmQ1NoSDVMc1MzZXhFYmowTG1BN0JseHBCS1pY?=
 =?utf-8?B?VndScEZjU2pPZzJmTjFTakNGTWtiZ1ppS1htcGwyWXJwQkFpb1JSRjBjVm9l?=
 =?utf-8?B?WTBOajRjcDVxYlRONTJzTHhqREx4ZlozbUxXeU14ejJ4eE5sYWxXWEJucFZP?=
 =?utf-8?B?ZWNKWFRRVmhXbjBNbmprc3ZYTFEyckxXbGUwSFJzM3pBSVJPTDkyVWtGTzNm?=
 =?utf-8?B?UFQvbWRsSlV5VnZrNW43eUk3dm53QlJiaGx5V0ZBeEhMYVNpNTcxTDByaXVJ?=
 =?utf-8?B?YnN0cDJoK3cyTzFTRGsvV21nMTVoWUZEdkN2MjhBdS9JS3dTNWNkWkIzemc4?=
 =?utf-8?B?emk2dlBTSWFCZ1hJeGxnZ01NNHpjWitHMzNhYmF4ZlZtVzN3MllqWFJPRjBQ?=
 =?utf-8?B?Nmw0QXdPZW5ZSTY0SjNhdTRJUUpVbXdSeXNrVS90V21ReHlmQjBjbWhFU0NJ?=
 =?utf-8?B?aGhYODBxTHh2SklRaDhGdUVrcDRENDRwWkY1QWNaMUdNUFNzbkFxclp6Vit0?=
 =?utf-8?B?Qndtd0YrM2hYcTg0amRPN0dOem14R0JBQkxYMDBmaUIrNERzdDQ0YXRjYjA5?=
 =?utf-8?B?ckFxQi90dWdVbVoxZmt2WFdsY2haVEwwUDlycDIxSDREZnI3NUJva01XcTBC?=
 =?utf-8?B?dThxQjFiS2dic0VnTFlXK3QyUTJiamxXODRva2RyMENZdG9Qblo4K0s4eUhE?=
 =?utf-8?B?QWcrdllncWQyZWJZdVpiNlppNkMzdjQ2TjUzaXhOMGpVMmN3VVJGczBNdGRy?=
 =?utf-8?B?Q3JJVTE2dWpaRk04S2pUdGZHc3hPdm5CQWdCQWtkNHo1dTFDVWp0cmJaeGhu?=
 =?utf-8?B?VzQzTERQQ3NXVUVEdGh4dnRPL3dkNEphUG9mZXc2RGZ1NUNCUFlNWkU4bW5z?=
 =?utf-8?B?clVLQTJXZkp3SGVmVUljN0p0SkQ1eHJUN29LaUZHRTBzcjkwVHVHNmd0SjdQ?=
 =?utf-8?B?YkJhS2JHUWRldGtjRnpHV3BPWG54S0NWcUM3c010ZUwydnlWOTlFWlRDcHFm?=
 =?utf-8?B?ODlMSmRid1hlS3hjMkNpNW5MLzhMYnUreVpFMHRET2FuRDVFZzkvdmFPWVQ4?=
 =?utf-8?B?a1p3QUdZTVRrY0ladHdYUlhXcnZUZ2Q5OEFva0UzTkZubXhNNjAzY203a2tO?=
 =?utf-8?B?ZURuUUpMSXF4dzJQS1VqYkpJMmE2OEU2RXNlaU5tN1pJK2svd0sxRVhVM3pi?=
 =?utf-8?B?WFhPR3A2UzZQYTJITW8rU2dtZjNZWkFpanhXakNySmt4d2ZHTnB5WkFHY2JB?=
 =?utf-8?Q?/B7adH/cqhH+JOBD7z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43389eb6-b323-48fa-e17d-08def1300ab0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 07:22:57.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daFKQAmUCOPObE8Ek2xgHztQcwJUtEjkS9Jz0ROSag1Rs4P8WetlOyTj3BFDX2TO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999252
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

On 7/17/26 23:00, Harry Wentland wrote:
> On 2026-07-10 23:31, Alex Hung wrote:
>> [WHY]
>> The out fence was signalled on the first vblank after arming, before the
>> DMA finished copying,

Uff, that's a clear violation of dma_fence rules and can easily be used to cause massive security problems by writing back to freed up memory.

>> and the old code worked around this with an
>> mdelay() in the IRQ handler.

And that is a really ugly workaround to the problem. Not sure if that is 100% reliable.

>>
>> [HOW]
>> Hold a vblank reference while writeback is pending and signal the out
>> fence on the second vblank instead of using mdelay(). Add
>> amdgpu_dm_crtc_complete_writeback() to finish and clean up writeback
>> from both the IRQ and teardown paths.
>>
>> This can be verified by running IGT's kms_writeback 20 times without
>> timeout errors.
>>
>> Assisted-by: Copilot:Claude-Opus-4.8
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Can we backport this patch to stable kernels?

Regards,
Christian.

> 
> Harry
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
>>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 33 ++++++++++---------
>>  3 files changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> index 8069fc41cc7f..7c784277396a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> @@ -509,6 +509,7 @@ struct amdgpu_crtc {
>>  	struct drm_pending_vblank_event *event;
>>
>>  	bool wb_pending;
>> +	bool wb_frame_done;
>>  	bool wb_enabled;
>>  	struct drm_writeback_connector *wb_conn;
>>  };
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index d67dcaa3fa8f..0f5453649200 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4521,6 +4521,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
>>  	spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
>>  	pending = acrtc->wb_pending;
>>  	acrtc->wb_pending = false;
>> +	acrtc->wb_frame_done = false;
>>  	spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
>>
>>  	if (!pending)
>> @@ -4988,6 +4989,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>>  	 * cannot run its matching vblank_put before this get.
>>  	 */
>>  	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
>> +	acrtc->wb_frame_done = false;
>>  	acrtc->wb_pending = true;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> index c5467f34c51f..4de7fb264cb2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> @@ -1974,23 +1974,26 @@ static void dm_crtc_high_irq(void *interrupt_params)
>>  		return;
>>
>>  	if (acrtc->wb_conn && acrtc->wb_pending) {
>> -		struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
>> -		unsigned int v_total, refresh_hz;
>> -
>> -		v_total = stream->adjust.v_total_max ?
>> -			  stream->adjust.v_total_max : stream->timing.v_total;
>> -		refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
>> -			     100LL, (v_total * stream->timing.h_total));
>> -		mdelay(1000 / refresh_hz);
>> -
>> -		/*
>> -		 * Completion (signalling the out fence and releasing the vblank
>> -		 * reference taken in dm_set_writeback()) is handled by the shared
>> -		 * helper, which is also used by the teardown path.
>> -		 */
>> -		if (amdgpu_dm_crtc_complete_writeback(acrtc))
>> +		if (acrtc->wb_frame_done) {
>> +			/*
>> +			 * Second vblank: the DMA for the captured frame has
>> +			 * had a full frame period to flush to memory. Signal
>> +			 * the out fence now.
>> +			 */
>> +			amdgpu_dm_crtc_complete_writeback(acrtc);
>> +		} else {
>> +			/*
>> +			 * First vblank after arming: the frame has been
>> +			 * scanned out and the DMA is finishing. Disable
>> +			 * writeback immediately to prevent the hardware from
>> +			 * starting a new capture that would overwrite the
>> +			 * buffer. Signal completion on the next vblank to
>> +			 * ensure the DMA is fully flushed to memory.
>> +			 */
>>  			dc_stream_fc_disable_writeback(adev->dm.dc,
>>  						       acrtc->dm_irq_params.stream, 0);
>> +			acrtc->wb_frame_done = true;
>> +		}
>>  	}
>>
>>  	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
>> --
>> 2.43.0
>>
> 

