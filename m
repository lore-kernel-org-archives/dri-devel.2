Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558581061B3B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF9710E8C3;
	Tue, 31 Mar 2026 11:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3SNez+uq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E5A10E2B6;
 Tue, 31 Mar 2026 11:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXYJYH9lXfI3/aq68AzxlFw0lbFZSw3skCIt6/VTdlBH0G78ohJOXshrLjiJscO9XnLYVlRWOFK3w0nODpothZlftW5Rfw5sQEM0gZbxnFAvO1jQC2dklz3NXlcb/QUcabSpg5X7PfX9108jcc94lbL6HtjOa3hyLU3zWEYAKgzpRfMlLyvkvZhpFtnwIH70IcNfknmW4SjmwfXRIwX1Y9P14AtOx/XC7m/rS6n3U0jwVeUOo1WQYgip22oV5oTFQrcN3TSnFC0OtE0hGMQkrWJsN4JX5KAFMxLCNLvYLuJ3wxrpsZ5j96FGXyBnnUJzSJ3bYDXfR0niiELiXAY9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty9DiPFfgSJtVd2yrgzqGQAYCBYVtK44IHYHyCDCsMI=;
 b=n3QMR/QQeq8M9ktTs3aB9xcmWfC34zusKckdHgUoeKP4rYn0J72PhpBVEx2sXJoxUoOSs2YgBcuyL2VjLbbZu0fBEgF/vBGqozaeIbaGOptgcpWiySKKOdw4wYSxYOsGSs3DgtjSnkLUOvoZx7hupp4Lhj/vT47RGGJDFVoPCimWxQdY9MqLhsl3+zonIfFGRVbujah0JkQ7muxyGsWTYj6ZwFuqz+BaXT3OdTMclmXQSdRFecMwWMYD/dQ7ScInHomc6rWCnLeo8QnYwWp8Tq7cmARn9W9vnGcxCVmSChQ7V3cxbhLppjKoht8PWTgp5bA1LjsF9vx0fxJdw5xYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty9DiPFfgSJtVd2yrgzqGQAYCBYVtK44IHYHyCDCsMI=;
 b=3SNez+uqoISmUB/gClaPdVWZcRmYgnb5iJLKhxBMWbedjNw5qA/k+/9dSN9ndnTaSRZzP9Zye7cWQwEojeWtzebTuGBoUuqCQYXVk8ca2mTcS56g+Hqt1rmQCHatBhFHrOmsYwHn8fpYSLPrYSydTjSKjHEtT3p1xaqctZc1M6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:59:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:59:51 +0000
Message-ID: <41747ef2-54d6-45e6-8d19-d682817c23a3@amd.com>
Date: Tue, 31 Mar 2026 13:59:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/exec, drm/xe: Avoid abusing the drm_exec retry
 pointer
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-5-thomas.hellstrom@linux.intel.com>
 <916ac7fc-d699-453f-af60-5cb3b15c1156@amd.com>
 <e4855d379990345e47e1175ff4b20a757888ff42.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e4855d379990345e47e1175ff4b20a757888ff42.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0aaf9a-2a9b-4e05-63c5-08de8f1d03d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E6OcKGU9tf47SG6cNd6vc3hlwmXSieEWKhOYJxzX0jXknyp4zNX+FMWLCvh7tCXacaFlOYwri6PoB+lPrAq4zbchKNSYcjCWP4P5NZAtLRN3RBptidpW6z1LMY+ulzRJth2HkSmVPyszJnYYc97bVMgdgkqVb1/aVmHF5DIfyqFpUHomEDiUrj95swZrdcvyvpLCPgRX6SzM8cIF2GipyZXom08gEVEaQwxLfI0jg6JczPILMBD3mFa3yWUyYN5MjzdwV07E/mIYBSZXfFVwp7Iej3FcBHrza3VPtaPmTmAr9FepoBEeF94pQJaUwFwcHNqwNyDZXOHAxTb6F1Tn5uZrSTiAB2OgQ00eRHc6j6gTOhSwvHJiHDLZbn9HJVIj+ZtWs95E74StGzBZ7AVlKCOS60xHntm2aocUCYmDTuxdsPri/HOizEdXKAl99wE6+a92kO/MID7l8cVXZnjraZtqpJQBy1LZ2VLcZl/PC+JxUcTkub5RYuYdi6rEl4SO308cI0sKspHTmJiXucz1Ytwi4kUUDeLsSDdi5E1YxYaUeQbWcqRubVktDDgWwVhp9Ej+TFqfG04UakFFxlrExHdoJyHbn95V9ftiimOMYWPHgdskpLGjPGbUeMdcA8zXaZ6O475UG/1ivt14KkcSBsIJWxImBZRy1e4PeWuyHhVeKKQiU+ZikdRVVCnbr5Xb0bIpjoq/vWNK/qsZC0HKD95dXXi55jC/a4XLKH4SsYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdsSnFnenY1WFVLcGpFcW41ZG1FZ3M4K0FSREFzMS9ETzNocW5DWEV5N3hG?=
 =?utf-8?B?bXVkRGk5c0NuajU4YURLeERzLzNrYVIvWTIvQmNHZHFXVHlqNmNldnVjb2tC?=
 =?utf-8?B?RjBoMEpXczJiejArd0FWUDkwQ2tHQUI1bjZheEM3SDVrZHZPUzZVT1p3U0VJ?=
 =?utf-8?B?T2lON0dLRkhMY0l3MGRwY1VDcDg4TWhyelF2ZEdLc0pXQWFRelBRN3NNNEZm?=
 =?utf-8?B?NGo0NlZ0YmdSVU9CWkhuQ3F1TDcycEZYYzNyZkNpOHhYeE5JckIwMHQrRDM2?=
 =?utf-8?B?ZHdaRFFCdVhPTEJTTVMzK3FtYkpLRThJVko3TUhDV3JJNFBKY3JwMnF2aG1Y?=
 =?utf-8?B?OEhlcVNjMWIwUXcvVzIxZWt0UGhmU0g3dCtNcGxKQUxaMWlJck9rMzNtU0ZC?=
 =?utf-8?B?MllyYnhMT0xqR1FaVmdGbjg4dzRsZEgwU2xIREZvaTZId1VUcVoyWE1OVk9q?=
 =?utf-8?B?WThkVGtVY2J2N2VEWGhJd0pOSlhZS09IN0VMMEN4ekhPcjdjZ25rRmRVTkdF?=
 =?utf-8?B?QzZiVVByaVJQcnlZOG4zamxjb2tqQjJJd0U0RG9YeVE4eWJrNExPS2tQd3Vp?=
 =?utf-8?B?dGI0bHlvcHRKanlYU2RuRVAyWi82Zm5PK3NrdHFZMEVYaUsrTVlZc0Mraytv?=
 =?utf-8?B?S21mSDNCbmxmTkRpeEpFL3VvUkF3YkVkS1J6MUhSOUg1V3o4amljWGVNcHY4?=
 =?utf-8?B?RDZpRE9Wc1BXZmI3QVhHRUM2NlNjTmNoRUIvTFg1VGdxemIxblI4emMySVk4?=
 =?utf-8?B?VHFzaVhWcTdneDh4R1NtOWxVUGxoY0ZtME5PT3RsazZEbWJRRmNGb1R5OUYw?=
 =?utf-8?B?dzR0N2pNVTNYM2diUG8zT3VNMmYvR1lIY2VnanNES2I2MGtSMVdJdFE1OE9j?=
 =?utf-8?B?bmEyVi9uVUdSTGxWVHZ6VDdtanZpeXh1TTU2bDYvbmhpY0ZxZnBzbW5vZVRz?=
 =?utf-8?B?YnFiQ1pZNDY4WWRxQ3cwM1hqMUowU3NkMUpGekpWZEZqMEsyU2FQTURzQ1cr?=
 =?utf-8?B?TFpkYkxielRvamx0SERjZWlsWVV1RjZ4Y0FEUk84b0ZPZlFELzAvbHIrVkE4?=
 =?utf-8?B?NE9XNnBnYmZEUWo4S0pYSWkrMkp4cXpBWU1oNVAxcUhrUEZuSU1NNnNGM3BO?=
 =?utf-8?B?WWVBNXlmVFhSKzJFalliTldValR1elgycHdCdTBnWlR0ZUFHSDg3UzlEcDJo?=
 =?utf-8?B?alhCSW1OSW1meGsvc0Zsdm5PMU1DRzFiNFRYcnJhdmFYVWVyQ2lDd1JiZ1lv?=
 =?utf-8?B?d0NDRWIrWVphMDZ5YkZ3NDRDYXZ6VTJSSUV0QTREYWZyaUJRN21IT3poc3Bo?=
 =?utf-8?B?VWsrM0tUOW5sVlZKWmJORWhoRU1xcXc3NS9YT3ZaeVlMUmlkVUY1ZXRTU0lj?=
 =?utf-8?B?SmI2OWQvYUYzcGVxaVAvR1RSQ21QcnBDSWVwMDcxb3FZelJGMlZqMjNTWG5X?=
 =?utf-8?B?eG1LL3g4RklrMG1kaUM1RHZuS21wMVZyVU0wQVNoRlhGUkRaVmxqLzlsYml1?=
 =?utf-8?B?VVd3L0ZXUDUwS1JGMDA0dGxQOTRxWHN6Q3B2L25TMUpsN2xYN21mc0tTL1JN?=
 =?utf-8?B?WVhhR0Nwd0k3MGo3OXFMZllzM3VTakpBNU1CREZmS2tWZksvWElQRUpJL093?=
 =?utf-8?B?VHEyNWxzalZzVW1OOUdoNStwUzNEaVZtTlYwNS9sNjJFSVB6TWNBaUxNQkVD?=
 =?utf-8?B?U0lxK1V4Wjdobjd5Um9vL2EweVF5TE9WckFTYjRkQkVESE01ZktrWnl1akpO?=
 =?utf-8?B?MmUyZUZTNkZ0U0dCTnNtY0tLTExqOVhSYzFHQ1FpNXFxZVhKQS93ZW9zbHdB?=
 =?utf-8?B?ZnVEeDRMUGxOcDRORnIrZEQ2WkZsMEYzWU40R3FKMnd2cFZ0YkVXenNhR2Ux?=
 =?utf-8?B?WDZpWHQ3MDhnSEZvMENPWVAvR1FNTG1XalVmVk9pUXVUZEZxbENXaGlSc0VY?=
 =?utf-8?B?Z0JiVElsUS9rSDRBL0RjTks5azRSZG1HUlA4aTJOdWtsMU54SkdaSDJncGRk?=
 =?utf-8?B?VE96RDVEUHBzVU0rbURtL250Tm1zNXNwc3lZU0hjMWlYWnNtOXdBaURjWVFW?=
 =?utf-8?B?RmpBL25VeWlaUi9OM0owN1htYWhkejJ5OUkzY01Ha3lSSkZjaEZpMFd4MjI1?=
 =?utf-8?B?aUJEZHlPUnRlQm5peG9BNE9pRG1TN3luZFZjeVI0TzFHOVdlYU5NZDJhQTU5?=
 =?utf-8?B?UnQ4c2RjUG5aSlozWW1TMW0zRG9qb1FoMzh4ZTFBVjg0YXhtdkRML1Jlalhi?=
 =?utf-8?B?MDkyYmVOUytsYktCWWZOakJaMlQ3SlhOZS95WHRSN0RZS00wajRneHQwQUV6?=
 =?utf-8?Q?ckpMMePkLmP9AahLNv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0aaf9a-2a9b-4e05-63c5-08de8f1d03d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:59:51.5406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RblIdvcc06PPq01HnTE/trkk6U9W1OpgqhUgr7rXfX2ZEnR3BrwuPZTG1uTckQmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

On 3/31/26 12:13, Thomas Hellström wrote:
> On Tue, 2026-03-31 at 11:44 +0200, Christian König wrote:
>> On 3/31/26 11:20, Thomas Hellström wrote:
>>> The xe driver was using the drm_exec retry pointer directly to
>>> restart the locking loop after out-of-memory errors. This is
>>> relying on documented behaviour.
>>>
>>> Instead add a drm_exec_retry() macro that can be used in this
>>> situation, and that also asserts that the struct drm_exec is
>>> in a state that is compatible with retrying:
>>> Either newly initialized or in a contended state with all locks
>>> dropped.
>>>
>>> Use that macro in xe.
>>>
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> ---
>>>  drivers/gpu/drm/xe/xe_validation.h |  2 +-
>>>  include/drm/drm_exec.h             | 13 +++++++++++++
>>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_validation.h
>>> b/drivers/gpu/drm/xe/xe_validation.h
>>> index a30e732c4d51..4cd955ce6cd2 100644
>>> --- a/drivers/gpu/drm/xe/xe_validation.h
>>> +++ b/drivers/gpu/drm/xe/xe_validation.h
>>> @@ -146,7 +146,7 @@ bool xe_validation_should_retry(struct
>>> xe_validation_ctx *ctx, int *ret);
>>>  #define xe_validation_retry_on_oom(_ctx,
>>> _ret)				\
>>>  	do
>>> {								\
>>>  		if (xe_validation_should_retry(_ctx,
>>> _ret))		\
>>> -			goto
>>> *__drm_exec_retry_ptr;			\
>>> +			drm_exec_retry((_ctx)-
>>>> exec);			\
>>
>> Oh, that goto is extremely questionable to begin with.
>>
>>>  	} while (0)
>>>  
>>>  /**
>>> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
>>> index fc95a979e253..5ed5be1f8244 100644
>>> --- a/include/drm/drm_exec.h
>>> +++ b/include/drm/drm_exec.h
>>> @@ -138,6 +138,19 @@ static inline bool
>>> drm_exec_is_contended(struct drm_exec *exec)
>>>  	return !!exec->contended;
>>>  }
>>>  
>>> +/**
>>> + * drm_exec_retry() - Unconditionally restart the loop to grab all
>>> locks.
>>> + * @exec: drm_exec object
>>> + *
>>> + * Unconditionally retry the loop to lock all objects. For
>>> consistency,
>>> + * the exec object needs to be newly initialized or contended.
>>> + */
>>> +#define drm_exec_retry(_exec)				\
>>> +	do {						\
>>> +		WARN_ON(!drm_exec_is_contended(_exec)); \
>>
>> This warning would trigger!
>>
>> See the code in xe_bo_notifier_prepare_pinned() for example:
>>
>>                         drm_exec_retry_on_contention(&exec);
>>                         ret = PTR_ERR(backup);
>>                         xe_validation_retry_on_oom(&ctx, &ret);
>>
>> Without contention we would just skip the loop and never lock
>> anything.
>>
>> What XE does here just doesn't work as far as I can see.
> 
> So if the xe_validation_retry_on_oom() is actually retrying it
> internally call drm_exec_fini() and drm_exec_init() first, which means
> that the warning doesn't trigger, due to the dummy value of contended.

Ah! Yeah that information was missing.

I'm really wondering if the calls to drm_exec_fini()/drm_exec_init() should be part of the drm_exec_retry() handling.

Otherwise that is kind of easy to mess up.

Regards,
Christian.

> 
> So the warning does its job, and xe is safe.
> 
> Thanks,
> Thomas
> 
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> +		goto *__drm_exec_retry_ptr;		\
>>> +	} while (0)
>>> +
>>>  void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
>>>  void drm_exec_fini(struct drm_exec *exec);
>>>  bool drm_exec_cleanup(struct drm_exec *exec);

