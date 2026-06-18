Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E1CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DBB10ED8F;
	Thu, 18 Jun 2026 12:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FvesYwI4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1071010EE15
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5m6+OSBwjbpBFAW0IHxqgPcYxpd+n+t+SoixLUJx4+5WtiKsdg/WO4JYf+QanZwvFjFugzwvbPOMpkvSuFaVJCLdTmlvDlNYYcdxlsGk2+M5I67iBwSRHvio6owOufxGvOvtgiPxiVdQ5/e1LSQaPOJccJJOV3wXPfJVJAtq1Fc52yPVvuGFLWNoM8PtK+3waH7H7+dWaiCHkgnVAfdfCYL9sDd0yths24x0cmBh3bpbk12IAp8hQL6rRMvJljf7Wvhq1A99ihgO9yN7MiI3Uff8IUzbp1hqM2H8QkD2iMco/vOnSXCmgkF2uXqQ9BoeZMwLyGvM46hwYxY4ZFhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tAAA+icOayjJlB4yrsGjnCl1G2ulGPZBFiDhQ0XGwI=;
 b=H5LXovOWiGRkS1yGBPnAudDb+EeSE1872IE03Xm4lokxVIJTQiV5YL7tADHCNiS0SgnDSx/Fgc44nSoNMd0FDt2ovEK8q3nkU0sgD9/1+GrvpPjYbearDYLUCFi+/aj8kVi0hA/DZCJaPgmXfuZhSH/byQopSa0DLndNQuKCOS9RQEPf+06CgJdJS38bURxmOGWc39tREonWKHR4WMjTcgUe4CnPN/U1alAs2Cb7eA06Isxro9cJJgVkBvLCW4ly3QbH8/TGd9g7xSUXRx9FFehKfKdItsZYx/fg6e5xhLX6otelgiG12wUmzT++G01yijtGxe9dXc2V+/bZOfT9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tAAA+icOayjJlB4yrsGjnCl1G2ulGPZBFiDhQ0XGwI=;
 b=FvesYwI4MTIzNfeiksexsUNYB6cmYE1u5VphBL7bcAYidmpR6NPKQWmeOjSjDBQB/izmH0JAr2TF6HewZe+GI62HAY+7crMpoInO4WtrDp282S2jzs2h4DCWhikRH6uKLYjLVXmcY5L8L/Bk4dOZxULwG83piiESPQ4vNYj+5Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 12:46:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 12:46:45 +0000
Message-ID: <099959fa-3a41-4166-8c10-4e5c2b9fdf19@amd.com>
Date: Thu, 18 Jun 2026 14:46:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: use correct callback in
 dma_fence_timeline_name()
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 kernel-team@android.com
References: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5627fb8f-1e99-429e-ac54-08decd37a6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PbbQjyc7OUy2TpvM3ZHnW9YkazbvSTdXgl1c4BuV1jzmT8I8z+MCpY0ecP+0S4cxyOeoUikdpGCXGcuaVx1sUrZfFi0Ay15/ibdSD+//LiNaG5QA4QD5hOHGd7Tg0tRjDNooRzZlFk+rvs0R/MhIYlxc4qLumyBEdWjuBkSTzhBrQ3bhKJ34jHN1Hpgdq+AGHDiBTDfpUS6PsHLknonjyLILnBxBHLW8xYYUNprJxEe6ZFRDPlnohfWAkxmcMxGT1oQ4Ii/Q0e9j2xMJU0KiZn4Ev2i4BHReBIavvCYkwnHUz3pQC1tHeGJ4CkZWMIM7+7WhNb1n98K4utUOzZ7Xlda4BEddvxoe1xBBvOh1ofRaVo58AjneAA5oefQ4rxjjp3b6yY50hhmFaVor7A72qWfFYlqZb8gbU1e4H8XycP/vio3j3J9NL2JeB7XRhqErz5/EWgLSR7UMOtFRU43n2yEMf57ASBiZeirORjv3rdaZG1sMpsqxsPLAxgWOq6vGq1nq3P7SdduLoZ96IjUdoJ2/uKczW1HSVw7Lbecu+Ry6jLm1dmyW6M+U6CXYDiWHKlk0U8WL/ahI85chRls6jkZTeDp/EznzT/51fZB9PDBtUESo/cL2sI8I+nqmCHe7elqLzCUTKirUkt6xH7PpP/JgJcX6Ixjk7lZg508JEAvk73jjxbqtGKvKY4+yDRZI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZWd2wrdGNMM2FtSVdRa3lzeU81dkRFZjc3d3E4UGdWY1RZMHp4RDBTZUxF?=
 =?utf-8?B?aTZRcjQ2VHdNZUNCWUwralkvN1ZKTkRXalZ2YnIvR1hQTVN2bmsxeXdHb1pH?=
 =?utf-8?B?cGVqemt3Z1paUXJxYkl2WU9ySkxtNExvY2k4cEFPaFJuV0E1bHlmOGIweUxD?=
 =?utf-8?B?cUczdDVSZUZtS2M2UDJaL0s4OFl6RVJIT1MvWVFHUXhwVXBieVRwQUtJTi9H?=
 =?utf-8?B?MUZMK1Y2Sjg1VnNmcFQrZ1ovMnIwT0xTam1xaitLSjYzK0JPcWhabmV2b1Av?=
 =?utf-8?B?aE52elZnb1N1UU5DVUk0ZGprVVd4bCswa1g4bGl5MFJ0T3BOUU1DUzlWVStK?=
 =?utf-8?B?MWNNM0xXMFUyUElZTEkwVTludVhYTThkMGhUNVp0WkZvalgzb1J0Q3YvQStu?=
 =?utf-8?B?S2V0YWlBdzRLbWhyallaVm0rZ0FNYlNTOFdWcFJNS2hveDNvV0JxWFhCeUhu?=
 =?utf-8?B?cWlmRlVNekVseTdqR0RKN0t0STY0Smphc1dyRC9QOGZTMldqRjBaODhuYUM2?=
 =?utf-8?B?emNObkdOTDZPY3AvbWdaL0F2bFZ2d0l3ckZodG16dHN0UDNTb0pmNUlROTFH?=
 =?utf-8?B?MmY2TWlNWEtuK2NLQ25OVjJ1YzZ2TXErd1MwT0NrZkMzMGVIanRpb3czZGtS?=
 =?utf-8?B?SW9MQ0Z6dStzUVVmMDNjK0d3VjJkZlVXc0dsSFZjbHBINlFmSzRTTTZhS0s3?=
 =?utf-8?B?RnZDV2MwQTRlbjd6NmV1NjJVUWg1clRkWWR2SUkyWElQaUVmNWRTUzRBb2dG?=
 =?utf-8?B?N1l2eDFnZitmUWlxQ2N0TGdEQkVMVUUrRFdIbmV2VkwxSFFzczgwWFk3SUV1?=
 =?utf-8?B?NnpHQkJ0YTJhS1pmYklBcHhkSXJaM2x0QlIrNThwYWNHeVFEUXhKc2hHMTF4?=
 =?utf-8?B?S1NRalBDdXYxZlkzdXVHQnhKSlJ0Ynpvb3luY21yZGhqMDBCZ29vTHZuMUt6?=
 =?utf-8?B?SFRQTjN0M280WjFEYkt3OTZYUHRRUTd0UlVGcGFaZjhmWi9nZUZQaDB4eER5?=
 =?utf-8?B?K080VWcrTE5GM083bm9VeTNLUWJiZy9Sa0tkQ3lGQ24zWlBMeFJCamJHbmxR?=
 =?utf-8?B?VCt2S0ZTVi9WaW9LTEt1U0hPTzBtTUpqQm0rWWNRWUxYMjdMUmdxZE1RSTVZ?=
 =?utf-8?B?aVhYc0sxNHpkVWgrQ0hYbGw0bVFaYlhiWXZDTEhwMmd5bU9KVkhhQjM4L0I5?=
 =?utf-8?B?bExjN0l4a2hjUUZsbUp6Wi9qRm9lNTJvbzNYdGxIZXJEcXVWRkNPc3FYSFdm?=
 =?utf-8?B?dUhUSUFxVVpFRnYvNTJ6cXM1QjZrS3ZvcmliS2RXSCtxa2lDYkJkUThZWDNC?=
 =?utf-8?B?ODBCbVBVcTBkemhreHJjd2NJb3R1b0dWc3BZZUc4M3VDZVJLZ2tGZFZIazYz?=
 =?utf-8?B?UHFIcDJ1eGc5SHl6aEg5ZENIcitZQVNScS9xZ1JFeHkwblhvSEZTdVBqdUVz?=
 =?utf-8?B?Sk92d2U5TGZqRUk1akhMTmNEWTBKeW9GOThJWit3V1FEMzdEK0NTKzVGUEd3?=
 =?utf-8?B?cEF2MCtHanJoNTJiWGNiLzhMTm5aWTU4cWxmRTVrZTBKZXhMTnBuaEIrM1JJ?=
 =?utf-8?B?dXEzaVp4U2xFQk1WOUpLaW0yU1JmZXVlLzVyVE8rVUsrSExJYmVnRURldEJk?=
 =?utf-8?B?dnQwL2J5WEdkZ2lCa3BJeGxUYUh0bi9wWjRQTEhDRGlCWnByb1BkOUJ3UW1G?=
 =?utf-8?B?VGZOdElCNFJKRk80dXRUWG12NFBiNTRMM0k0dEFUSHlwQ3VYMnI0ZFpQUmFw?=
 =?utf-8?B?SVFxcTdUUjNjQUpLL0F5ZGlMdWhsc3VuanZtV1EzL3ZQNGpBY1lpYjdEaStO?=
 =?utf-8?B?dzMzVlBTUXlWN0ZqV2pWK2NZNW54MGFzUXlTZmFIUW1lazdXVjZjVitvU05P?=
 =?utf-8?B?VDkvVkR0c3pwdGNsSnlQVkhxR0k3VGw1Nmh4Kzg3Z0xNUmswRmFzUHdudXNQ?=
 =?utf-8?B?SUhZSHJKQjV0VnF0cjVuMHM5WElNaXlMRVNDVTgvT254c0w5KzJTTXRtSFVR?=
 =?utf-8?B?MGhEeDNnZXlaOXQwWUR5cEhqZitHWnE0N204dTVwZnIwVWNOZHFLekJDa05P?=
 =?utf-8?B?clpuY0VNOWdZOXZxZGptQW1HY2piYVZEblo4Z0xUZHdxQnJkdE0rZVkwWlR4?=
 =?utf-8?B?cmpGTmczTmMxVksva3MyT0JjaVNaUXJFU0p3ay9qeWtXKzNGc2VkWjFRRVZF?=
 =?utf-8?B?NlhuM1N4TUw1YWdLRDI2bU9SUnBEU3hObzVHTGFySm45TTd4blY4Y0ROME95?=
 =?utf-8?B?d2JBaVYvYnZpODJHMFBXSHFsZFZML2lTUFZ6MXY4b3QxUEcyK250ZnRSOXkz?=
 =?utf-8?Q?EWsI7/MpvbaknyHSNN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5627fb8f-1e99-429e-ac54-08decd37a6f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:46:45.0625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPmza0eG8v3YWi/ckuyJ3+n1NHU7GjlSCt5FAuHCCZ6RU67f1bTRB0kxI6P16Y4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

On 6/18/26 14:00, André Draszik wrote:
> dma_fence_timeline_name() is a wrapper around
> dma_fence_ops::get_timeline_name(). Since the blamed commit below, it
> calls an incorrect callback.
> 
> Update it to restore functionality by calling the intended callback.
> 
> Fixes: 62918542b7bf ("dma-fence: Fix sparse warnings due __rcu annotations")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

I'm like 99% sure we had that already fixed weeks ago, but somehow it looks like that was never merged to drm-misc-fixes.

Anyway Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e..5292d714419b 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>         /* RCU protection is required for safe access to returned string */
>         ops = rcu_dereference(fence->ops);
>         if (!dma_fence_test_signaled_flag(fence))
> -               return (const char __rcu *)ops->get_driver_name(fence);
> +               return (const char __rcu *)ops->get_timeline_name(fence);
>         else
>                 return (const char __rcu *)"signaled-timeline";
>  }
> 
> ---
> base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
> change-id: 20260618-linux-drm_crtc_fix-267655a1c89f
> 
> Best regards,
> --
> André Draszik <andre.draszik@linaro.org>
> 

