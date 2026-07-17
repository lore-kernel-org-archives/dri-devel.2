Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49AFC44517
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8CB10F45D;
	Fri, 17 Jul 2026 07:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V28Fbziv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7015D10F45D;
 Fri, 17 Jul 2026 07:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omFGw02SUXoyj2HNf+59152ENgAw6GmO5ZFvb30Gj36E04DLfV+ir3pEFrwLnN3YUAYQFSDJ6Jt9/K1xGCqYzxNnx181l6suyrvGrX8FECUxb47zioBaO2PTKphzVqaUPfWdSSWpghoyY4wYee6837/m2cEGb4M82xPzgpIFcbyabCPPGxs67KiTMweaIs1Y8mYXCNhhd+1hIuZypeuSEgatLqLo1IYYHvFWUbHsDxC1bs1qmBxlZbjGkDgZlqJE4eTweDh9mZYvpq+a4RV8BY3BAoZ/mPpkT1g/3aoNA4amA/+R57S0aMV8YQEiKMVr34tO25bVU5sSFhGmdX1mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6do3m0p3xl6u8oIvtvKb3H0wyh2fYVz0fYAaVGrrok=;
 b=sTW0K3cppMB51tAfLmJN+0KTqvah6ohE3uCts58P1iujRK+nanMQASL8mI1j3IzPpOhKrx0I+jyB5rXAkM+VeLtsHDgES2GNEKe8Cxh5A8weuD+pUnkcOs3+n9SZROB1TGNVyq8vv78m9F7THUI7NepeF6vnVwi8ecUx2DeL0AF0intCVQl+vw3KfbZ2jimS+UYoACUQvVl/UCEIpOWXaIaQ1nQDhCwt7HvBZTMWloAsCUIlBi0IoNxTMKuCEjMoFNBwCUNhx3KaBFHLuq+uer96/535xOV/eVL+zw+UI/1ZkyIWn6ExjjetIg1psEDCsBrZfObTdhbd3mlmQqPd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6do3m0p3xl6u8oIvtvKb3H0wyh2fYVz0fYAaVGrrok=;
 b=V28FbzivpwmTdS8pkkZisxXWvsMFyczby8Yq3arM1UXUM05DC99mAbY1qi/EIw3k7qPQau7ePHbqZHeosRScfVlt4GeRV2Cmon67dHYLDrtAV5+yRF1Tqx43cl0d+o8jXWxILMzKboKnOCrUi81E94rcRJz3kV0LECfhGmPqx1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF50009C446.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 07:26:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:26:07 +0000
Message-ID: <6288019f-b026-42d6-997a-5c322c9d0520@amd.com>
Date: Fri, 17 Jul 2026 09:26:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] drm/amdgpu: add typed helpers for ring
 writeback slots
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
 <20260717033009.649538-2-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260717033009.649538-2-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: d455b3a8-ec17-4251-34c7-08dee3d4aab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +XOftv7AePXZKSqYYPRW63GlqzVdoJZtWmmllihrlx6UOmDpJwI0Y9ubiX7uq7rVUPElvgIQjuZgIDYBaStqlJybKl+K/MPB4NQ1bWxWVj4K5M4/t3PBuOthG1zVBEOQssvMCqngUgJ+IQKdL8RxSgsoDQNVGgPrXKuFzHW4cmrLocZjHRpV5xNriaNrTWbwsL7XnUF0FZtO5IQb+zn08li41QmiTvA+WYUyiOg4NuXNDALg0Pzkf+4X4iBbQkig2goalNju12yEElqVVeCOsoP44jROhepRr3xFKjmu9WVWJJNlocurduIQRfXQ1OghHpmQ2sl8ngUK4GWDefgs6STesfEzqfDeya74e2ewbYkuf4vyERiZFPgzeeBiTvu9Bjefi9DKNWfsyf69HQqly0lttFqNZcn9QL3RpBHs+6cBcZlTFtTY099pIq2WR/7k8D5bajULZ9F8ClcW13ptiTDWi9Oka5YUGOkofTPSr0Dao1NVCQAFAyh3xyvlBnik7asTFnbev5kGVIKnmPvrDkwBMGqu0hKGM7w7BKTBSUEhh983rf/QEsW2VYsf1V3nPmWBKMiRfZqNjZctEoYKzile53yBBgHflVmiPwVNBwF34RcwflE+L/ZVeW99n8Q4gfqsaBzjT0iJeVXTJRRceF3n/Tfb/1BDqoYbCbD6aRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBwMmhSRVhFZ2FOMlNNMy9tNlpoRkxTVytXZTdUdFo1cHB0QmpPQjdyNmxV?=
 =?utf-8?B?aVdEWHNuQ3VtOXFhWkkyZ2hhN0xleEpVU0RrVVBTNVNXZThzUUYvL3pMUGNB?=
 =?utf-8?B?d1YrT1h3V0pzTDJueEFaNCtscTBDTFNXNWtNVkZkWitRZUkyelhIUmJSdGlv?=
 =?utf-8?B?MjZJeHdKMVlGTDk0M0xHUTF1VVdSaWJ6d3JicWs4Y0dXTVdRcFN0WnNkd3Q0?=
 =?utf-8?B?SE1kczFSRU01c2RrTldVZFhkQ0c3WVN3VXdtZ3RiNjNwUVV6dFBKaXEra1pK?=
 =?utf-8?B?Mk5FVUNLTTRFMk9QMFIyR2hDVWtabmI4RVVQT0kxUG1nSTZYTElySGZMa2I0?=
 =?utf-8?B?Q1NOanVrWHRzU2FuTzcwYURESnc2bVV6UDVlZ092bE5OdERFT3g1WGFUTUxI?=
 =?utf-8?B?c3gzdnN4Qk1LaHZ0RURSTWljMWdra1ZWNU1ZdjZxQXk2TDE1aXJ0UWJYRUg3?=
 =?utf-8?B?ZjFuZ295UWRHaVc4MU1jeHhoUTZJRytoQitmenBZVDVhc011K2Niby8wTDM3?=
 =?utf-8?B?Y2Y0Sm1IT0ZJNTdnUHF1ZHZjZzJVcWV3WEVxbVpPVmY1cnJqSE4vNUx2RGlo?=
 =?utf-8?B?VitYMEFhS3QxaXNBSjdLT3Iwai9ZcU5SMWI0UHNvM3JlanMrNE1xRXVjWXZy?=
 =?utf-8?B?bXA4MEVNV1h6YzZWb3FBMU55RXZPWXVQb083a0pHOXdJVDRVRXplNzlPVnIy?=
 =?utf-8?B?VElGL2hFbnNBVmk2dFJMV05Od1F5Ui9TOER6WnVnTzFKOFlxOVAxWUlhKysw?=
 =?utf-8?B?b09zY1VhR0xrZ2pJMjcwVHdqbGF2aFBET1lQeVFtOVFyMUd3RVFuQUFZeWE4?=
 =?utf-8?B?VWpKZEV0ZzE2bEtkUzBRNWVUQURhQTMyTGdEZXd4UzB4MWlEUWdZcEdBYWh2?=
 =?utf-8?B?VXFPYWR1QmFUSE5XVXNDekExTTd1RVYvdjI4TVRzYm1RTkhkd0w2UEdTL21B?=
 =?utf-8?B?enF2c0Q1bWVPdFpDUnQ0QWFFZkNkRk1ZYUhhSTU2b3dCMVBKd25HaHB1YU9h?=
 =?utf-8?B?NFNqZk9GVjNhWXRCbnIwb0dIS2tHb1VuT2F1azJnY2lBK05zazVTMG1wNVRj?=
 =?utf-8?B?QUdQSjhqci9uZlc1VjJxSmo1bGZVR0kyRHFGTWdKcWZBTmN3WDFDa2JZM1lw?=
 =?utf-8?B?SE9vNW1qeFgybENyTEY4ZGRuTmhyM2VseDFhNnNCRmpWV1Mva25iOS8xOE14?=
 =?utf-8?B?eEQ0bk02M0ZiVWZYQVczc0creWE4WUNZalcwZHl0anEya1hydWdDeHV3ODUr?=
 =?utf-8?B?dVYvNlJWU0RGeVlTRjZIQjhpVkx1bjNuSjBHY0g0MGoyQUZQbGpocldXVUU5?=
 =?utf-8?B?Z2I4WDgwSm1wQ2pjYTFzVG04K3VOc1VyMkpTVjd3QkMrbGdtbE5jSFI3N2pT?=
 =?utf-8?B?emF0UDJFU2VzZHJFSjA0SHJJcGVzRHFZaFBSTVY3UGx0YmZsZm9WTkVRWjB4?=
 =?utf-8?B?anQ0NGZzcUZDeEdSaXFvNkZJOVEwd01wSUFVZ3liT29sNTlQb0xVTzNMbmp2?=
 =?utf-8?B?UnI4ZW1KTDYvM0JXeFhWNG5wUjJEY0xEeUEwQld3Sll6S1Noa1dVSUlDYkRR?=
 =?utf-8?B?dTdmWFhHa29XSlZFdlhEMkxBd2E0UEZzZXZlaDJCcGY4TUlzZkhOdjNaT1Rt?=
 =?utf-8?B?T3JMN1lzaXlRc2I4aGpzVHVFSURJZi9iR3JUT2E0YjRvTVVyRm1Idm92c2hV?=
 =?utf-8?B?eWlyNjVadjVaL0V0bTIrN2dqbnFxMFZYVVRxRk1Zeldodml4b2FPNVRaaDhR?=
 =?utf-8?B?WFVPRkhtSU5hR0dKTUJSUU9MenlPcTU5UCtTaGxYMTVPc2t3SnZjWmZxN0lk?=
 =?utf-8?B?cC84SjkrZVpOeS90Nm5XTzViVUsvandteWY4VnNlWVhwSUxSRUVVanNnQ1Uy?=
 =?utf-8?B?Z2w0RjRCelRYb1Izb3V1djV5M3VmOEg0Um1BenIrTzlZYm1mL3J0NGZqSGNu?=
 =?utf-8?B?MjAycXFKWkxDV1dtZ1pyVER4NUZGZTFrMFJLZWNwQ2ZDVTAvckRVRlMwdFAv?=
 =?utf-8?B?encyVERWeURabG9WbWJzRWxNUkY5cks2UnZpbVRpa0s5c3NUeGhSRjRXTWJL?=
 =?utf-8?B?OHdWNXV6NFNVcHFOTXVkL1VTK1dGRTVlWXFlU2FyTHdDY1NtUnZHS0RFUmZX?=
 =?utf-8?B?SUZlVnFVSHdBSVF0S09PYUpJQ01NOE96VS9mTGJDZGt1b1M0WmtVQTNYNEph?=
 =?utf-8?B?anBSdWhHWW1vN2ltTERFckZVN2RFcTlZUWx5eEE0VmsvcDJENEFhcDJ3NmRC?=
 =?utf-8?B?c2UzWWpuUVVYMXo1V3RuRU9zejEyOS9hdS82YzRvVkpITGh0bHRBUzRYLzdz?=
 =?utf-8?Q?l9/OEaLne07X7BM1rc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d455b3a8-ec17-4251-34c7-08dee3d4aab3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:26:07.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5w1u80fGAYxqDuz86xuDnWh1E3CW0Eoal7xPUMX20zGDg6QxnDNgP6mJHZznvTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
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

On 7/17/26 05:30, Runyu Xiao wrote:
> AMDGPU ring writeback slots are currently accessed with a mix of direct
> pointer dereferences, casted u64 accesses, READ_ONCE()/WRITE_ONCE() on
> casted pointers,

Clear NAK to that.

Those differentiation are completely intentional and exits for documentation purposes.

> and atomic64_t casts.

Well that is clearly problematic, where do you see that?

> Add small typed helpers for reading and writing 32-bit and 64-bit ring
> writeback slots. This makes the intended slot width explicit at each
> call site and provides a single access model for the later cleanup
> patches in this series.

That's just nonsense.

The writeback pointers not only vary between 32 and 64bits but are sometimes full 256bits with all kind of information in them.

In general it should be a 32bit pointer which can be indexed and/or cast to 64bit if necessary.

Regards,
Christian.

> 
> This patch only introduces the helpers and does not change any existing
> call site behavior.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 8f28b3bd7..cdc855285 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -457,6 +457,26 @@ struct amdgpu_ring {
>  #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
>  #define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
>  
> +static inline u32 amdgpu_ring_wb_read32(const void *cpu_addr)
> +{
> +	return READ_ONCE(*(const u32 *)cpu_addr);
> +}
> +
> +static inline void amdgpu_ring_wb_write32(void *cpu_addr, u32 value)
> +{
> +	WRITE_ONCE(*(u32 *)cpu_addr, value);
> +}
> +
> +static inline u64 amdgpu_ring_wb_read64(const void *cpu_addr)
> +{
> +	return READ_ONCE(*(const u64 *)cpu_addr);
> +}
> +
> +static inline void amdgpu_ring_wb_write64(void *cpu_addr, u64 value)
> +{
> +	WRITE_ONCE(*(u64 *)cpu_addr, value);
> +}
> +
>  unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>  void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);

