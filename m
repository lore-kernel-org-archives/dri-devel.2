Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81E606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c+DWBFiy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB60D10EC3A;
	Mon, 26 Oct 2026 08:22:31 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A802110EC3A;
 Mon, 26 Oct 2026 08:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=If/UggGSpoyDWvLsEQrwii96BNzK96YSclJKtOktFEc0GInHfCZc9de0YLovk44kbac44Tf2PX0yPTbW9j6T7Iwf8Daqu+AHeC5XjjbQQY9TLs3djRiFyHx9e6NjBY1atoOf+BnCctSnGka/usqwpTUFJPacqLxr+dm8zyA03KZbAzXe3Y6StTwHKn3UQJt/2T1lU+bhxFRo5wG2KAN6EeLJakAIqFhilreU7lwjVH4QZziSOwnsDZADHwOZdYmWO5A2h9tsWieMqD2iVBujlPRnWrz+dwbvM+x+DwDMJh4XE5s/YNzL5JmAl626bbPpUgx4pirWmxRQss8IyrzGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qobjWu3QEHrvQvTIaLJHKnO2+5fag7MYYLOHsHCyxHQ=;
 b=aLx65qrQRc2/RDI+LARg+eooLtrOGmusiIL+Z4SC1uWrc9nelfAo55GtyVRgwOql8diZD1Qq+ha+7F7HO1UEvptQ2BKtRWMmd9HcAHDOqhl5aZc1m5shaVnbshmoxffUA406fAiVbdkTgNciWBncTjXS+7Rv/Ko0IjCYbWSx7YxCKmqlcZdLDEHkG8HQN4FxaVA3/M9Er0w5Jmxcuc1YBDIC5+DSmB9y0STQ76Jq4xvvE51AWEr1HgxjsTq/IpSg1VpOlWd+W6+9vktEANX+rUUybgHV5QB5IizppGpXeWWW4QsFwwMFNZRKDSe3dW8gBr6WhSju5tbHI64UewqEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qobjWu3QEHrvQvTIaLJHKnO2+5fag7MYYLOHsHCyxHQ=;
 b=c+DWBFiyNZq5YaRnnJAcJ+EK/1Aygk8iQpfQF9VVTlK4ZlgF1FKdi+5UiNoiOweC/BH2YpvzCdnSv6QGNcFoz/MSGvlYOYfYDRxo14j5b+94r4GET5yZ5Z3dCb6GCs4/KCH+JzpSTrBhEEiQpNMgm1m1gqaiZZpz1A9kLzAksos=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PR12MB004700.namprd12.prod.outlook.com (2603:10b6:8:47c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:22:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 08:22:18 +0000
Message-ID: <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
Date: Mon, 26 Oct 2026 09:22:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
To: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022114754.865669-2-mptagliari@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PR12MB004700:EE_
X-MS-Office365-Filtering-Correlation-Id: f61b192d-fcf4-4a15-0027-08df333a3faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 1DE2xsqUAdSA3plR5C4L1UYAtn4KCnG15XrNW7KJGZHl+EeU0MhtiKqhAGFE5Lp8Oal7AvmIhyPsnzpYrn0Bh/4btZMvA90veNfsRxguNN5NBykhz3/af9nm+xLOJtd+c0N7QcIkUPQJuwvNYuM4wCRXEcYtG3kG2eDl95SErltfeilyQ513ommjGMRy7Wa8s3EVPnz+8EiKCVWp+TZWblbJDlgCqjLDMfE7OOVoofrUjGA1thwx1/KHxveEH10ide8mj07cfKWWOBN5WPFZCN6Ik9/w+v99237unZD7zNowjwiIr5p53X7vrGhFRYeTinY7dNf/a4pHPaoLiDYLxdznqQadz4kAdsbE2FJa1iRAVUVzx5McrmZetE3vnYL0OYVzANo/hnBQVNkM0yMzuVzLZo4VKz88uFA43c3/rIVZtcj3a35fLLN+dNUPxifT/j3X9qbJkmUcOk3bvRy7d+Dr1ceImuPNbsyCwbbB/ZlRLGnK0XZGosBhXpPjawOAQ/zKteRyc83EfUplilwPY/OxAIcPqAjcgYJnIMtSKk2ImG85X2lxGW41UU2G390OnQzFOd3TFNr+oFwOK8L2KnBIQbFCoys09O6CJgaRguj9lzBdyAO4Nek46EgWEMp8yY8i/s9vKPqTwIneftVPeeCTkysZMCQ3spv7ac5yRvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZwNXJNN1h0WklPSlRHaElYc2t2aXlGM0Z1TkgyU3J2cG9tVHZqeHlZOHB5?=
 =?utf-8?B?bnhoczU2cWZaUktXSVpUSExVK0hnUGtPeEc1TmFhZjJtSlNrYjJxaTU5RnFL?=
 =?utf-8?B?M2ZTbGNIOVh2N2xhMEhzTFFvem1WMHNqM0VIS1Z2WTQ5OG80VldyRFdVbzNN?=
 =?utf-8?B?RzFzYjNialY5TTN6dWFwb2VqRWUvdEFFSFZNNXhLaGQvQjRZSGUwdkRtejRq?=
 =?utf-8?B?N1puMGNmQSsyZFlya3l1K2RaMHQ0Zk1mR3QxbkZLcG9OTFlJa2toMjZwM1A5?=
 =?utf-8?B?YjE1QmR3MldIc2FhenV3Z29TMFU4d2Q2SGI5NGoxa3ZSWW1Da1NmdDNRc2Ra?=
 =?utf-8?B?RmhKT1FpbWphakJKT3YzcFFHVUp0MmF6NHFOc2xTUWpSQnFWOTloVmJIRUl3?=
 =?utf-8?B?SWt0STlXdTZWbkhPVXM5dklvSnZES2hkcTBQeDZVaVk1RFJZOUdJaFBLeHNh?=
 =?utf-8?B?ZWdPeThnblk3WTk1S3VWMWY0SU1iQ1JSVG9seE5VeXdGRmJpcmlQdFNoNThW?=
 =?utf-8?B?QnMvU1ZKUFRUSzBmb08wS2ZVb1h1ZWxDNlRQRjV3Nm9iY3VlMVhpcHhEejY5?=
 =?utf-8?B?K0wzMGdWOGxBQm8rYkhQakZ3Z2ptK0V2T3RXcHBqM0pkRzdoWUtuM0NlT2RK?=
 =?utf-8?B?NEc1dnlSenRUSldtQVlxOGFNWWE3c0Roc1lmUVpYbEdZNjlFMFo4K3J2V0wz?=
 =?utf-8?B?c0lRL0xjaWdpK081ZXRXZkJ3TjQvQjlCZnA4MyswbUxhZTkxeVlGcUUvS1ZD?=
 =?utf-8?B?RE1vMVNXclViQ2RydVRKVDg4M0hRUWY4YnEwK3ZObW1DdDN1K1lkSkpqK2hN?=
 =?utf-8?B?K3dJWE82RnJ3MVpFdSsvRkgxOEpwUkI5KzdhVE1lZjNpR25HR2ZDWjBvRGN5?=
 =?utf-8?B?MStiWk9lam95Z2dTYlBBa0Z6K3VQRmpZRngzV3luUkFYQStDRlllZlUzR0Na?=
 =?utf-8?B?YUZEMS94SGN5amNoSkhNeTYvQnFkUFBpc2V6Y2RKbXhlUDdlQkx0YUxLdzhR?=
 =?utf-8?B?V2N5ZlQvT28zWlhkdDJkMHBNQXRPcEhqdVdsaDk3L2xXNFJWS3Y1QlhTK3ZB?=
 =?utf-8?B?VWgwaGNMbDhzTW9lM09GaU1QUEZFVnlxWmhOQW1XNzN4ZitRZHRxMWl6WWEw?=
 =?utf-8?B?WFI4UzZja20xQS9BbE1uM2R4S2I5TG9OVmg0L3dTeWpVSWc4RmRkQmg1ZG9U?=
 =?utf-8?B?RU1YSi9nS2FuUVQ3aWZxVVUzTGdDRzBDaXA3SGllUG9URmx4RXludmlYNkps?=
 =?utf-8?B?d1pxeVhWeFdPTlBXZDg1VHBGUkQ0ZFJ6Z1pRWmtwTEo5U3p0a1ZoaVJnYlNn?=
 =?utf-8?B?emZleHF5R2VtajA3YWpzQ09ZamVPcTd1WUtNcG1HaVFzelFvZ2h6TS9YcTI2?=
 =?utf-8?B?NlF5dVE4bjg4VFl3dXF6Q0o3cHo1ZktMeENnZzI4RnRxbHN1NDd0Y3ZUS2o2?=
 =?utf-8?B?cW5sRm9VZU5vZnhiUzhlekt5ZFZPZEpuS3Rlb3FIai8wY2xXOEpkanJ1d1Iy?=
 =?utf-8?B?QmI1Z0Z3UEsxWFRtRGRNTHNDRnNUdXRabVZ4Q21leEFPM2VGL0IyNXBsYi83?=
 =?utf-8?B?cWtvRzd6VnRnVlZVOEo0YnNTeXE5bGxzMlZpQkhybHNEdkJDcU9BWWd2L3c0?=
 =?utf-8?B?YVptUmpHZVVCUXk5ZFQ1eVB0Z09vdEZtS0ljTklIb09YRVNrNU1pTmdseVBh?=
 =?utf-8?B?VEJMR20rNGFHeXJXeTFESk5HNXVYYXJKWm1JYTNoM3hZbklmelA3OWFEVE4v?=
 =?utf-8?B?R09ST0pmaEFLajVNSVBua2lQY3JuWHMvWTBoSE9KTFJhdG93T1RGZlQ5Vi9T?=
 =?utf-8?B?WGxYcmJnVDdnc210cDJVNjNkVG1EVWpadkVhdUtMTzV0MmR1dUZVQXhaQnZF?=
 =?utf-8?B?c1FsV0s0eW9aQ0d0QmpQYVJ6QVZXS1kxNE4yMHdGTlF4RG0vTTV3NjVWcWF4?=
 =?utf-8?B?bzMrdHZOM2hNNXcrSjRCKzQyeW1aS1F6MWVLb01GZTlqVkFZY0tlNHJaeWVs?=
 =?utf-8?B?Mk8xVVNMUDFlRVBHZjBhcDZqNzJJRWZhOWhyR2txakZvTjhhUFNicXNBK2V1?=
 =?utf-8?B?ZXdtK2lkWjlLQVhVbjViQjJ0UkJFQjJDUUZCS0hMdituTHhrU3VUWUtzcTBI?=
 =?utf-8?B?VExoc213Tm03ZU1jb0xYK3htY0xJa2tEWHRRUkZBaDdtb1lWb0NMRTJIUVlw?=
 =?utf-8?B?RC9QYWlVVWF6TW8xTlhXVDhJeUk0SElKSWsydmE0RW9YK1BaamYzelM0KzVW?=
 =?utf-8?B?NG13VXNlZHRFNExYWWYxYlB1bUtKb3JsWWpMMzVzWTV3OGhndThDOG5ndDFS?=
 =?utf-8?Q?J/nq+hVEPb7Sdy/7vs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61b192d-fcf4-4a15-0027-08df333a3faa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:22:18.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYhgNJiyYzT809NXfOnm/xBNYxKDfW9jPrbBz0LUnyOmkM156HggqW13169zIXHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB004700
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 13:47, Matheus Tagliari wrote:
> radeon_vce_fence_emit() ends every VCE fence with VCE_CMD_TRAP, which
> raises the VCE trap interrupt (IH src_id 167).  cik_irq_process()
> handles it by calling radeon_fence_process() for the matching VCE ring,
> but si_irq_process() and evergreen_irq_process(), which serve the other
> ASICs with VCE1 (SI and Trinity/Richland), have no case for it.
> 
> Add the same handling.  The trap interrupt is not enabled on these
> ASICs yet, so this does not change behaviour on its own; the next patch
> enables it.
> 
> The SI part was tested together with the next patch.  The Trinity part
> mirrors the CIK and SI code and has not been tested on Trinity/Richland
> hardware.
> 
> Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
> Cc: stable@vger.kernel.org

Please drop that, we really don't want this to be backported.

> Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>

With the CC: stable tag dropped Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
> index 3cbc6eedb..eb94916c8 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -4847,6 +4847,20 @@ int evergreen_irq_process(struct radeon_device *rdev)
>  			drm_dbg(ddev, "IH: UVD int: 0x%08x\n", src_data);
>  			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
>  			break;
> +		case 167: /* VCE */
> +			drm_dbg(ddev, "IH: VCE int: 0x%08x\n", src_data);
> +			switch (src_data) {
> +			case 0:
> +				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
> +				break;
> +			case 1:
> +				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
> +				break;
> +			default:
> +				drm_err(ddev, "Unhandled interrupt: %d %d\n", src_id, src_data);
> +				break;
> +			}
> +			break;
>  		case 146:
>  		case 147:
>  			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 4681ff286..af3c4026d 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -6347,6 +6347,20 @@ int si_irq_process(struct radeon_device *rdev)
>  			DRM_DEBUG("IH: UVD int: 0x%08x\n", src_data);
>  			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
>  			break;
> +		case 167: /* VCE */
> +			DRM_DEBUG("IH: VCE int: 0x%08x\n", src_data);
> +			switch (src_data) {
> +			case 0:
> +				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
> +				break;
> +			case 1:
> +				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
> +				break;
> +			default:
> +				DRM_ERROR("Unhandled interrupt: %d %d\n", src_id, src_data);
> +				break;
> +			}
> +			break;
>  		case 146:
>  		case 147:
>  			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);

