Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C072CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38C411215E;
	Fri,  9 Oct 2026 15:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hz9qlTXa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE5111215E;
 Fri,  9 Oct 2026 15:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvVIX5uWK/M/FqGhFB2C4PMnhsrYAhizzzuIzY4H8dP98BBsfl/Gu4hYjDWj7/u78YWilhwaKuEMU7uRTNh5zJB9PYxfntIdgcfB3C7OtVC2BD4wKkFQQtnrzo1lMoPDdZeANBWpr1oRVKM6V3j0SI0cRgCwSo7xfaUxgoVKJo8URb8j/+QfTynkrKs7X4RSq7sJd+m6OOqnGbtFB5kXD1CPEPHluK6qZNQ0hHliQ4jFmbhhkZJ5T4AnNw2KJ1p360cFkX7vhDTHrqON0k6l9YGR5H/zPKSIS/RXxZnHq7RePGkj8EIFGjLDb7Zpuv5FqK7AKd262J56DFOwTf1R4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnOiJIgDLWU+rkoz6NWl2t3dLjwbWg86a9gFoo9asZ4=;
 b=p2WkWsT3aCSaH0uLkxHm5urGPBeebULjp0EXLO6KYC458xPmOa5i62lq6mG6FfmpIVqsgfDJC2J50J9rtSgtmlQpr0QHDqDE1pDb5M9XTXXWQywHLGfKsEwrPxM7/cd0Y0LcpFPOhP5crRih+WME08zvIxKd+JEOCq6tZ/fymYoT61Pe4pMbvhClds6SbHOciSdHZrCNPkGOLEv15KQX1OZuc1DvfM5utJqnnioM1bRFvsv/dLiC4VTcfdddfYEOjgCBk/uukiaO6KAcsTWbxVh/VG6TAP5+qDYVcIQrZw0WnB6zsG/qvEhxzn79pmfaq+S6t0AL9+vsijGFfDaioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnOiJIgDLWU+rkoz6NWl2t3dLjwbWg86a9gFoo9asZ4=;
 b=hz9qlTXa7XZYDpC7eGxq1aGLT2irWPlZlTkCXzQEQnVeDXXOtVuNfka4rushQ2xLb2YpnTd+CGWFwnpFzPiwrew/lawT/1s34NySCl8xC09H1lnsgT37RA+CgoFJ+hn7lhjPRSz5yW3i8dXE/SSXkhHTeaypWyFal4jdtg54ItA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SACPR12MB275847.namprd12.prod.outlook.com
 (2603:10b6:806:549::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:00:40 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:00:40 +0000
Message-ID: <2bbea75d-2e3f-4a57-a291-5f5d9ca698c5@amd.com>
Date: Fri, 9 Oct 2026 11:00:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
To: Henry Martin <bsdhenrymartin@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SACPR12MB275847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb8b588-f8da-431b-3d9b-08df26161552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g16wkOJb9h/YROlC7NiNiHUHTTyYXvjc92IMJXZhZEYJ/jQYDokc43rib9uW8pLBV87It4VHJCWA5qSXwd+g/7fx5+t8xgzISL31ecZGLpiKjDsqENr53GGhSuh5zUt8TgqMNStitoTIwkBp/GHz1e9yBjzJ122j9zB8GwPJftyr8eztev+VgVKtcJALsoKq5KodFW5dKAjzz0NVnW/IHgn++19sfxYDMaf2Gpwamfvwj0zCSQXsPDKFmhrZSOYZEeYoqvIq+wZapsL8OpKYuQxCbxzSUGls0vTWOlfe3dPEdoVuPw2mubyJSN8U4QpZPA89e/jeKwF+5HrTsksYSHW92/JNk7r2IEAK3TSVjjmEiz8ilHVUh0G45D/M3Fxj1TcXomoRwQ/LC7ESgJAyK2M3eAqJ4cn2FHHmG0Ajma4SsbJRdXvfpczczAdyKvRzGw/FlLulqHMRmHs+cJr6KN9VBzKJ/WF5OnNTtIyEKNf9ozVBWdcXHk3yjXqAyXk7pL9KNbC9vlgq6s/1eyHRVdp5y432vTQWr2U9TPCAxdVFCfKkWNaEppKPPGPpUcI/9/dSuIlXn/JQMy0Ij1k/5KQfbKzWPHtS6fSuJuLONBJI50JVDxpF46XCHbhEihgoPROi+MrBr1LMG1PR/urSxdyAlJEkmGXfAF90ZZpf7dI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZHU3NzcGdSVVF4RXZaQS9JUWJmcURTdGw1QWRIY2FYcmtYWmF5eTJTMFVB?=
 =?utf-8?B?WnM5TEQ3RnlVRjR5ejlVVWRIK0FJbXJQbUxxTGtKanVoaGJCTWdyOGlUT3R3?=
 =?utf-8?B?UDhCa0NCRkk4UW1XbVBDRURGYWV3RmNsTEo0cXRjSHBLaW0xdFg0YWM2V0Ja?=
 =?utf-8?B?Sy9wMmZyVzVvZVp1MklqV2tBb0RmdThIQjdKTGl2VzdMUlhyc3JGSC96c0xs?=
 =?utf-8?B?aFBzWGhucjRjOGIySUJGaTNvc3A0TWsvZG1ZRkdLNG94cXBsK3kva3FuaWhV?=
 =?utf-8?B?NUNyR0haUTkvOWFJWXRMM3VhUkpwNjIvTWxNdXFSeWtqSmZXejFKYXI4K3hp?=
 =?utf-8?B?NE04V1A1a0ZQVFRCNi9ZcGpwKzNEMW1IRGVKUXlQeGxWbVpaRTA4TzNwSThn?=
 =?utf-8?B?MWU0VTJ3SHZYMTF2ZjI5bVE0dVE4andWMHYvQlNuOWpDRHdyN21XM2dMODVC?=
 =?utf-8?B?UGI1SCs3bFRmZ3NmTC9QS3NCOGgxcjZJZi9hL0hZcDB4QlZWeUYzY2RwV0RF?=
 =?utf-8?B?b2k2UE5PWEwvbFh2TDJLcEZaLzR4ejdxK09jRll1OXRUd3JoZ0htUlVYdE5S?=
 =?utf-8?B?K2FQUWR5Qm1wWTNJaUZNWklLcEpSankyS1lPejRVMjdzcXR0SEVTaEc5ZWIw?=
 =?utf-8?B?K2NnWHBNdTg4ZCtUc2hCM0FERWlxcEtvTzdzMlBTZW94VHhjUlRiRTVLbDFu?=
 =?utf-8?B?RnRYMTY4OTdFUFFzZERtUnBTUWxmcHlYbXBENGUyNkJBSE1NcG5VKzYraXZ5?=
 =?utf-8?B?WElGUjZHOUo4MDNaaGtNV1ptNDA3OHJiNzdtV3FOaUI4Z0VpVlEwWkllUERo?=
 =?utf-8?B?MnRiMFJ4bFp3WVZsb3JRaW1oYUovZnBrQUxCMzFPbFlHczVwbTlVMmNSV0o4?=
 =?utf-8?B?SHBRU2g1djA3amc0alhLWWRvTDNNT20rby84MEZndkdhMU9IdnZ4bnJGOUtK?=
 =?utf-8?B?NS90emJYT2hJVERBY2xnekIzRWdGSHlJRGdZMVR6eGpETm1WRlpuelZDSWl6?=
 =?utf-8?B?a3RPRU9Scll1VEpyZDAyWnJXamtQWmUzQk5VZ0xWMFVkMDJjSU5ud01Pamww?=
 =?utf-8?B?RS9PY21rSlRWVHA2VWJrNk5QeUI4UENhOG03dStVckkwVk0rM1JNQ1doVEhR?=
 =?utf-8?B?aUo4cUFCT3VOU2MrZHZwMHhSMDdDTzl4QmFXTG1Ka0tMZkRNMGkvM0lPN0NV?=
 =?utf-8?B?Sk1zdEx4NjFDWFNvQUhRSE1sdUN0MVl6dFZENWtVQnJwMEl4c1hYNVArMGs1?=
 =?utf-8?B?cFpFTE9xaDhEclR6Zjg4ZEtPT1FlZUY2OEkvM25lYTVLcXdZUFZmb3hDTWNx?=
 =?utf-8?B?WTJ3bWpxMzMzVENMelV3d0s2czZBcFFXWTl1a0dQUEFaVDNvQ3I0cGIyNXp6?=
 =?utf-8?B?WU0wck9hbFozZTZNelR1WlN1R09ZWmdTWGt4UjA1WGcyeExoWHhvK3FNVk9j?=
 =?utf-8?B?cmlYdXdKdW9rck5LcFRYK0tRQTZoU1M4Ynp4Y3JvVThWTFR3QmhWMEFwVnlx?=
 =?utf-8?B?VWNMY1NVZjh0Zml6bEF2UnYzN21FRmQvVXovR3EzNndvdTVuNnBKYzQ0T2wr?=
 =?utf-8?B?MFN6TG5tL25GL0xJYm1uMklFWGpReVlSU3J5K29BMlhHMWVjK09GRDdJTkVX?=
 =?utf-8?B?WlJJVTNhVkxXZFE3aHFWY2pFMUF1V0d0eTR4VTZGb0h6OHBpWUZZYitmS0ZZ?=
 =?utf-8?B?ZGxZNERpNGtOaW8rYUM5UjFiY2YxUFpXeVFrYVdhdGFxMEZUUm1yY0lJTDln?=
 =?utf-8?B?ODFGUWIxVVo3UXRJMG9FcWRqc0V1TmwxY3dWU3N1QjVWZnp3ZzJCNjRRQnQ4?=
 =?utf-8?B?SitkTTVRWVpnUHV4cUVxQk0ydWJ3K3JidjZxbk9peXhvcHp4b2lMdEkrV3JN?=
 =?utf-8?B?VVRxcGhINGV1OW1qSjlERXRPbHl4SUhXR083QnM2d3dBaFUrVi93UVhpZ25W?=
 =?utf-8?B?NHBiQ3FEVVFXS3FzdmdjTkRtNzdCRkNQcWFaakl3SndldDlvTnEwREVmVFB3?=
 =?utf-8?B?OXBHdUtxTjJjTFJQdUlsT1hRWW5tdzA1OFBrTUExZ1Z3WnVHaFhVS3hkRCtL?=
 =?utf-8?B?N1JubFdnTWloVVl1MHVMb0NUOGVCZVJ1UnVMM2loODlLN2xwOFIwN0dxS0Jw?=
 =?utf-8?B?OXpDQ2UyNG0vNXcyVllOUWZzRjZjRW9Ed0NDeEthSFZxVEwyT0hjU2hwZzll?=
 =?utf-8?B?bzBwVHZNYXIwYjNvVjl2OGpYT0p3VS9zTThidFpPYlFIbHVobzNLQWhkWGxv?=
 =?utf-8?B?cGxmQjcybHIyaFVIUTdmSEJ5V1h3NmZaMFVBS3A1d0NMVEJYRzhsZkpId2Fv?=
 =?utf-8?Q?E1oim4AOz9xXvIsFeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb8b588-f8da-431b-3d9b-08df26161552
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:00:40.0306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mX1QdUuw0rLW0qXAZHykPhwpgOgggy2zlEW4Xfx2sDd3ISH15+tprqZaBrt1KcXzaNZNGrn4IbrLIjwMesXAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB275847
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

On 2026-10-09 06:18, Henry Martin wrote:
> The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> lockless at every call site of kfd_alloc_process_doorbells():
> kfd_get_process_doorbells() (mmap of /dev/kfd), kfd_ioctl_create_queue()
> and the CRIU restore path each test the pointer under different
> locking (or none), so two racing threads can both observe NULL and
> each allocate a doorbell BO and bitmap, orphaning one allocation and
> handing the two mappings different backing pages.
>
> Move the serialization into kfd_alloc_process_doorbells() itself:
> take kfd->doorbell_mutex and re-check under it, so all three call
> sites are covered regardless of their own locking.  The existing
> doorbell_mutex users (kfd_get_kernel_doorbell() /
> kfd_release_kernel_doorbell()) only guard the device-global
> kfd->doorbell_bitmap in short non-sleeping sections and never call
> into this path, so there is no nesting.
>
> This vulnerability was discovered by Tencent CodeBuddy Security.
>
> Fixes: 428542d91772 ("drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I'm applying the patch to amd-staging-drm-next.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index fdcf7f2d1b5b4..07f881573837e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
>   	int r;
>   	struct qcm_process_device *qpd = &pdd->qpd;
>
> +	mutex_lock(&kfd->doorbell_mutex);
> +
> +	/* Another thread may have won the check-and-allocate race */
> +	if (qpd->proc_doorbells) {
> +		mutex_unlock(&kfd->doorbell_mutex);
> +		return 0;
> +	}
> +
>   	/* Allocate bitmap for dynamic doorbell allocation */
>   	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>   					     GFP_KERNEL);
>   	if (!qpd->doorbell_bitmap) {
>   		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto unlock;
>   	}
>
>   	r = init_doorbell_bitmap(&pdd->qpd, kfd);
> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
>   		DRM_ERROR("Failed to allocate process doorbells\n");
>   		goto err;
>   	}
> +
> +	mutex_unlock(&kfd->doorbell_mutex);
>   	return 0;
>
>   err:
>   	bitmap_free(qpd->doorbell_bitmap);
>   	qpd->doorbell_bitmap = NULL;
> +unlock:
> +	mutex_unlock(&kfd->doorbell_mutex);
>   	return r;
>   }
>
> --
> 2.43.7
