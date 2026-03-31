Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFCAFF60FB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08A310E916;
	Tue, 31 Mar 2026 09:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KUc15jDg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A6510E8E0;
 Tue, 31 Mar 2026 09:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3oRSGq7mbC+vJn9fIOSgHcT6YxFX6njHtc2oUp7m8YCgTRgiVnZ8DAETNqkkykzXDZIm0JbsOOJ5WlNcKlzhDNjMhYbYFFWAGkD8nWJ6v6+DbvLfSWxJzWGAt5q2QeGxcaKIwdYGQHuuVbPjr36RvNN4zOwuczZiW04WPUYLJrVRbhvjsIs7JxOGouliEcyKs/EQzCqwTsnzaTMIdfmPQ0/jGpMErYwEM/VTQrd77KF34D9lk1k3sFh1ALgPKAIvFYiZVyEN17KGc8pilQmCFT7tklJal7nsjJBK4lteWiQZMZcUPqJuPBeKX6GY/G6/QD1KbNU44TC0bXB9lxKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGdhgn+LG71HJtny0cLU4kdbUM1TJeqzJqlKq8xLM68=;
 b=d/Ez2HSdmHnp9L9dDzCdZF/WnjFjg/5OCHBie062XtUWYhDKzTvdN0Br9MUu4IASvJJ2ivbY4mEz+pfIkV+FHxOlR8sWyg5dtNKjdrJSMNXrCDQRWo/R05N8xRYmsHF3tReCkoBR1lC2kTezE23nZru9+Wl3pEXbv8Ew3dbKmQPjDtKApnP+nq+UeAwf7moakj/EyNFUwm6TcibntDKBKRzOw7rT19/M7DG3G7kigNo3eAlfLETXl9WZf2aFomT+j5mju0qWFeBSqc+oG76BsaseTFDb9BploBMeB3m9JtvjKVy891JGSZcASC+vRQ99niniLHOq0XYMP9PzvshxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGdhgn+LG71HJtny0cLU4kdbUM1TJeqzJqlKq8xLM68=;
 b=KUc15jDgJXTfAnJZ24ZiaFpZmaUPOepCV5EBG/46e20b9JXxvHmnyhb3pFKTEEGnqEEoKIr6WY16iKdZ6bYDf+FN+QQRVm+ctA8CcNMpK849Le9M5GQl2w6mgd5enWMU7eu5uShLc02iM0zr08xDRYSXdAHVIS8WXjaz6hGhZig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:44:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:44:54 +0000
Message-ID: <916ac7fc-d699-453f-af60-5cb3b15c1156@amd.com>
Date: Tue, 31 Mar 2026 11:44:46 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331092023.81616-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ac0c5e-9c36-40c1-18a4-08de8f0a29ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: krmUT+e/UiMz66FwyfaIXfPL5TffkuDnUUD/8Dr8YU1XPYRE35UQ4rWt23VtUNFzMQ3gbr1+wAGdEHnq+nsAJdUR+Hm3l5nEULk8YqJ6EXdky2TS97Os96aDLWLSPC/Pnj4uTTn0YZLOzaMPYhF/umDmi6pOgbm+MwVvfv14TzWtpvO9I3fatwrJjPbmxuOzwfnhaSmYqfBgX315GEVvhDEG1L8NhhjhB4Q9hPUHTs4rFgODFjJhA0TaaoPfbJ3MN79i61dQB/prjzqSUe7GtBZRqjFu6KThTiCN6mTn8WCbXsByyR2FC3KdX/EKRgC/5sC+DKInkGvDi2sk7GpSAymFwUF9lxgVwZazAsyAve4Ou0lPN3jx3tkvm9AIjK+pBd+vbUtVn7P00PF+IESAeNbvIjBCHNyTWLgQcnq9FhI9YO30Xkv/M/FXmgLqOaO+jM2UwjKsRdyS2LoA6lsQSIAnhjNy72BITTPFn7oL7+Y5wDnLVyJlxiQl5uaG8ZQzLB8f4u8xV99nuzfBftH8URJPFoWSVUqQIkdFkN2bVXflP2h2ANW3WOSZVmReUoMa3Zhf0Q+EqiSX4sfHXi3RBUcdN2QFwZ+t9m+poJ0FozS8wwo20+2CEbpQ0vgP4OSrzdZU4EqMppeaPiN/n7GY6EDz78bclD8AE69Bqqk0Rq6sMdNzk+tOd6lE50deEL80m77fcLg9tih3D+XB1FMFhp2UJO14FzcIyppE88IQe5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJza3lpYTFGMVNBMEViUHcvYW5reWIzbG1yK2xYNnlUYTBGN2I2RGhFZkJQ?=
 =?utf-8?B?akpuNHFVM3lIVGZ1eDVpTnJVMHR4eVl6REY1OU1NdFlYMEtPZjMzWmJjUEl5?=
 =?utf-8?B?ajhUcFpyVE5iUlhMWGEzOHVkMkxCczZmL0hkbEdQaWdSSFNZMUhTdHp3dVpp?=
 =?utf-8?B?VGNpRnBzZXpKWVcrb3FWQ2tGU0ZMUzU4VTN4ZDVLODltRHpOcGpHRXQvVytl?=
 =?utf-8?B?V0NNdWtwQVpqblJxSFp4bkxxY1ZFTVlEK0IrRzZxemdvZk8vV2lmUjQ4Y0Vl?=
 =?utf-8?B?RXJPWlNWWWpGOWNZcE9kY0lMczhobmFWRmNJVU4zam1UR3lMNEROWEJwRUxv?=
 =?utf-8?B?WThkNkxncjBEWkRCa3QxWk02MnFveTA3NEFEeWR5UkxhUDdhWUtmVnhNcWRF?=
 =?utf-8?B?K2toUllUN20vQjhES1BHOGpGczBJK0s2SUNlR1JGS3ZTNnVQcUIvNGZLZmU0?=
 =?utf-8?B?TWxzWVM4QlpkZnhUdWdxL1BXQUxCVkd6YlNjOGFoZklkWDFGVzhQemNvdkY0?=
 =?utf-8?B?ZWxTSE0zOUlyRXY4VUpqVE54c3A1MXloMThKQktLV3UvK0UzMW5ScHk3cm4r?=
 =?utf-8?B?TVFsZFA1VzZwUCtUeVBjZVpiZ3pkdDI4RmpyRXNZMDZrdUZYbjJIOTJ3Z2pN?=
 =?utf-8?B?TE1id2kvUm5rQW8yWndjSUNLdGM4bDhtREpKZElES1hIcHJ1MWdyMWtzeGFm?=
 =?utf-8?B?RExIWTU0cmM3dnE4Y3ZrdFRENW1tSW5mejVFT215Mllrd1Bsc1JJK2dMdnBZ?=
 =?utf-8?B?eXh1anIzZVBMR2V3ZXZIMGtlL3BpNzdhSUlXb3hjalhkSzFocU5HL08zcXNQ?=
 =?utf-8?B?WEdHa2d6Ry8yUk5JdU1SQ2Z3T1B6N1BJa2twZW9lRXZTWEdTQWIvRTU0Y2hp?=
 =?utf-8?B?dlNMTnNrQ3NmNStjU3VCZEJkcy8vQTljTHlFY01hb0x1MWoxTVJZcTA5bC9P?=
 =?utf-8?B?eGRXbEV0NHJ5Rmc4K2J4QWlTTVJDOUJrU1VoaDh1ZnVnd1JNcURQMi9JZGo1?=
 =?utf-8?B?N1VVUHBGditoS2xFREdXMit3UHJWSm1tcEZuU0E5c0YrYU03R0UrQlFzbkJM?=
 =?utf-8?B?L0FzbzBPamk3Y3pTQzFvRGs5YXdVNVI0QjFuc3U2WWVHYytZSXVUd3F1WndM?=
 =?utf-8?B?bGtwb3BrcnU3NVVLVEk5KzhkRnVwYTNuOVlWUksrSkdJUE5SeXRBVnBDL1ZN?=
 =?utf-8?B?RWIvMm92ZG5KR0lvdmhVS0d4Z3NSTVJtb1Nyemk0U2EySjdmTVBmVFVJaU5X?=
 =?utf-8?B?L1UyRjVRWkVVMzc2cmJPaGlHUkY2YlB3NUxleU9hQmh5aU84Q1ZDMmxENXVJ?=
 =?utf-8?B?eGRobHpaVkMwVEhpeURRUlcwZUpGWUZoOE92UDF6cFQzUTA1cmtXU3cxRk9F?=
 =?utf-8?B?NFlmVWIrMXdBMk5aWTBTNC9uWFBwdnNjdmhjM0xzbjNIWGRsUGpsQitNYnZV?=
 =?utf-8?B?QXg3SVQ0UUUydGJhQ1UxNXcwVXVMUTNRK3FEeU9KOFV2MzRjY1ZkNWxURjZM?=
 =?utf-8?B?UzY3UHVFMnczckN3WlJiM3hLdTRHYndjeTV0Y0pmOFU0UnRmMWxxaVhJT21Y?=
 =?utf-8?B?UVkxQlNpU21kNkcxbGo4cXg2QitVSTIwc0Z4Z3NtbmhVTmc5RzdKS0JMSkdT?=
 =?utf-8?B?QnptaXVXT0p5UnU2MGNRcmtKeWhtNVl6MGNBV0YzOFBNUTRZWkhqKytKcU54?=
 =?utf-8?B?Wm5YaGxkYWV3S1VUL3drTVV0aDNRbmlXY3ZmT0s5T3pQN09ibXYyTDRmVG1i?=
 =?utf-8?B?K0ZWeEI2amtjUFVTM255K0RtUFFJQkFvNWQ3MUpSMUVTM3h1THF2cG5xU0Mr?=
 =?utf-8?B?SXgvUW94WHh5MVFITEdxdFJZclJrZVV3NjlIVmtzNFZ4dHhmcTczb0RqbjJT?=
 =?utf-8?B?Z1ZVZEFKbXdpR2Q2SVFlSlhCRXl0c0cvSEswZW9xZ1Vzd00xSzNiN2N3VDgz?=
 =?utf-8?B?WnFXYXYzQSswRzJLU2ozRmVsajRvZ01tQVFpNUR1ckRQMTdPWDNFOHl5MU9m?=
 =?utf-8?B?V2U5akZ2QUlqa0pxaThzbGQ1YUs1dmpYaGpGV0FtTzk4SnpJRkR0MmYxajQr?=
 =?utf-8?B?MzJGZ1h2VjkrdGRCUmYwNFVnZkFRelJwc2g4SkhWZTBUYnNBditUclkvUWhu?=
 =?utf-8?B?MlNPYXlMSTNwa2lacGZuQzV1Y1pHTmNrclRTQTFvK2J3bWdPZko1SytOMlVJ?=
 =?utf-8?B?SUo4eC9KSSs3ekR0cTBWanVJbzl4Z0N6OXlKNEVCT1hJak9JSzhqdGtCLzZr?=
 =?utf-8?B?V0JLQUZ3M3BQNGhBYlNDZzA1N0grenQ4TEkxaXZEVm1YU04yV0NXN1dLcGkr?=
 =?utf-8?Q?zJ5zEr0yxJoUVFMwAB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ac0c5e-9c36-40c1-18a4-08de8f0a29ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:44:54.8434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE/MBd/mAxU1pHRSbLFopZehebryUKlsKcCCc/fZm0v7LFgHA2/aDGpqNVy6mvZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

On 3/31/26 11:20, Thomas Hellström wrote:
> The xe driver was using the drm_exec retry pointer directly to
> restart the locking loop after out-of-memory errors. This is
> relying on documented behaviour.
> 
> Instead add a drm_exec_retry() macro that can be used in this
> situation, and that also asserts that the struct drm_exec is
> in a state that is compatible with retrying:
> Either newly initialized or in a contended state with all locks
> dropped.
> 
> Use that macro in xe.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_validation.h |  2 +-
>  include/drm/drm_exec.h             | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_validation.h b/drivers/gpu/drm/xe/xe_validation.h
> index a30e732c4d51..4cd955ce6cd2 100644
> --- a/drivers/gpu/drm/xe/xe_validation.h
> +++ b/drivers/gpu/drm/xe/xe_validation.h
> @@ -146,7 +146,7 @@ bool xe_validation_should_retry(struct xe_validation_ctx *ctx, int *ret);
>  #define xe_validation_retry_on_oom(_ctx, _ret)				\
>  	do {								\
>  		if (xe_validation_should_retry(_ctx, _ret))		\
> -			goto *__drm_exec_retry_ptr;			\
> +			drm_exec_retry((_ctx)->exec);			\

Oh, that goto is extremely questionable to begin with.

>  	} while (0)
>  
>  /**
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index fc95a979e253..5ed5be1f8244 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -138,6 +138,19 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
>  	return !!exec->contended;
>  }
>  
> +/**
> + * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
> + * @exec: drm_exec object
> + *
> + * Unconditionally retry the loop to lock all objects. For consistency,
> + * the exec object needs to be newly initialized or contended.
> + */
> +#define drm_exec_retry(_exec)				\
> +	do {						\
> +		WARN_ON(!drm_exec_is_contended(_exec)); \

This warning would trigger!

See the code in xe_bo_notifier_prepare_pinned() for example:

                        drm_exec_retry_on_contention(&exec);
                        ret = PTR_ERR(backup);
                        xe_validation_retry_on_oom(&ctx, &ret);

Without contention we would just skip the loop and never lock anything.

What XE does here just doesn't work as far as I can see.

Regards,
Christian.

> +		goto *__drm_exec_retry_ptr;		\
> +	} while (0)
> +
>  void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
>  void drm_exec_fini(struct drm_exec *exec);
>  bool drm_exec_cleanup(struct drm_exec *exec);

