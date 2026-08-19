Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C19C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55BE10E0E7;
	Wed, 19 Aug 2026 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jQzVcF1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDD110E0E7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdG2ZDHw2HA97uEU6yUKak/DfpN6LCRXLvUrCe3KQEmuwMUanDHMZvd+H7YiATLAPzODzuaFpO85jGd7Ab8zG4DoGtn6DtaCerwyuSxoYowngzBOiS6pO0UzWefZw8jMzemjBWpnoV5py5KUzdutrg9dVEzRwy70f4T09lzOLcWj+eveTkI4kNLtfvI0OlidLTWWjhN3O8JQnzSKSbT+g2o+TstmYKBFK0pcGSr/1I0P0nPmbtcEec/g0DgnlqD4lOWUbTfV2bvy51JSJsPbjyLoJMxHQNQw0dDMJsbaZID/yVZGoAUf74c0rKnv6kJlfpWc6m+zUvLraVLY5gci9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNo1SOX9PmlU5v4C53iI2CBDWKKfyD0KGuN7/L1lmzI=;
 b=sSmsic1AxWRTTMznjMaBp5NdaY4dA2U9mNOMzFDxahwtywkOGCsKlYHkUwxkd8pX+qLthm6y33ri27rJ8di3PUg9h6jS7J+PPcz0mluuLCEMUqtFNYkA9/9GJ/ENFHQ7pYtDl/zcncyZvseJ4ldyq/kGbRLxkgQoW20M5TtHyrm1WB91KDyUeAkGF8qnc4GiIRKlfSWs9Saf1bYvFr4pxdyMnbimNxxc1oRQeOoSfLBiK9rNCDJOMIj4D8tphp8KyF2yrOcBZQ6wttvYfUimspyEe+CSvzKsgizitPqaev9WiL3Kt4vjiTh5+lS4CHAq3o7U7cPJxjyKQDwZiKwwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNo1SOX9PmlU5v4C53iI2CBDWKKfyD0KGuN7/L1lmzI=;
 b=3jQzVcF16E52SoVFq7uXb+OxFAJGMkUTW8ZDP8kG/dNogMN582rye+7YgBN65Ljib0STc7C6Uk+61UADAfGg3dORbV8n/Pw7zzJW55TjsXOsLxCRtp15FELLumjAEMBiEFYn2KDm8YIiWmsgr2duwVjYw7TTPH7rtlsvZ3wz+mI=
Received: from SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23)
 by DS0PR12MB999266.namprd12.prod.outlook.com (2603:10b6:8:426::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 20:39:12 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a4) by SA0PR11CA0168.outlook.office365.com
 (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 20:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 20:39:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 15:39:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 15:39:11 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 15:39:10 -0500
Message-ID: <3d677570-2204-016c-efde-779b07e76538@amd.com>
Date: Wed, 19 Aug 2026 13:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/5] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <alexdeucher@gmail.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
 <20260817230707.356828-2-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260817230707.356828-2-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB999266:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4dc8c7-4d48-484b-d25e-08defe31ed19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cn6vmydGRga99A7mxBHxGX8DTfrFb6lQNMb7G8jmbaU9FCXuf5Uu5jKG8XRryd0kzipTBRmlBYmWFLmcM7bhZhJLBvIxS6VryJPpOEhLGQyqsF4iSvIXWFl7o034zp3TUXB0e+kxhmKx1h1ZhYUM7eoo2hE0OF7YK/tfZ3OLRzxDqDzVskbE+zP2nq5CFXEWdK+w0fuoatBB43Ys6JqefAoWIRpuHYEH4Xb9YurQOYzq8uUFw8tlEU9yz2voiPUY4svqiZucpsnKifTG29lJyEsILbMbH6F9xWh12kKLPgJ4rjFKL+NlTLkkMY11DRQ98NgLUFKiMcJbOf0vutdpbFBK7j7b0Ro7L5mSVkvDQ+Ovx4LpKwlgJHip9efx+pFf6wUx1QnWc2z587DEADLr4CZv676yQsILQ6J9tHx7k7u5zuydB0TmpBBWrWMsfBgy0xgxkxz2PKVXm8PrXuHUnvxuRSzLQzo6P2nVwmyOmDkCiuqOhw/e0cFXcfcQ4EYE/ks971y1+oPs4JXRQywBLGyEAqaykVh0yB75auCYFKoljIw6LE/sA6Po1N5+NpMJqW+t4izbcG4EXpwtohEjz9CWXuGMq2PlgYBD3EUn1CklaoYVXOzRnm4xiTHlLsKz8ikDUBMpRmex+ErHB7rbxhYgRM1BtRYUKCY7J4Ew/nWOBmm7kkw/+g0VrY/ktybXfVo84//0zeOkhDSbo93O5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d4FTGwGHxeR+s/XxnomnclLXrAb/UHsCulWRwdGItNiPiaZr6106WUacw8ZwiJX6RSOF0UlTdzp6vzgnjvRzccUpTfkEaNwP9osyvMQNF+eXeRU1K/+OqaAbOaQexGe2qaz1WRnR0xcr6rZ9et8vlr47SXwKur73O3t8U0mFLja+O6Kqa+AxZrHd78YhFnY5GkoWu6CLK9LHpl4TEvOxbLdapJ9cmEdDBcBBcFV6AJz4NC9603Q3YGd4V8MhanqcMJ47X/01PPUodjJx4pbUmQfMgswezLgDqxec+4Hm63KzlBumbfLOGm+0U706MYU2Hv3lpkA7X1eArQog+ck+HNR/PMHi1zIUarLtZUqPXghQHdDUFKECMmeqG9gX22qiOpPGz9e3LsT8t4z9Lsl1fniZt1Sm7guiSXcVzqMb2vuryT43XYKjxOe93/9kXSAg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:39:11.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4dc8c7-4d48-484b-d25e-08defe31ed19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999266
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


On 8/17/26 16:07, Taimuraz Kaitmazov wrote:
> amdxdna_gem_vmap() flattens the iosys_map drm_gem_vmap() fills in down to
> the void * in abo->mem.kva, and iosys_map is discriminated by is_iomem, so
> an exporter answering with an I/O mapping leaves a void __iomem pointer
> there, which amdxdna_cmd_set_error() memsets and memcpys through.
>
> amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
> buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
> peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
> no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
> object, so an NPU paired with nouveau or radeon does.
>
> Drop such a mapping and answer NULL. Checking here rather than in the
> .vmap callback leaves that callback's iosys_map contract intact for a
> caller equipped to read I/O memory, and covers everything that takes a
> plain kernel address through this helper. vmw_gem_vmap() refuses the
> same case; unlike that one this path is reachable from an unprivileged
> ioctl, so it neither warns nor logs at error level.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index cca84fa07e9d..f88b5349cd4b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -209,10 +209,15 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>   
>   	if (!abo->mem.kva) {
>   		ret = drm_gem_vmap(to_gobj(abo), &map);
> -		if (ret)
> +		if (ret) {
>   			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
> -		else
> +		} else if (map.is_iomem) {
> +			/* Callers use the result as an ordinary kernel address. */
> +			XDNA_DBG(abo->client->xdna, "Vmap bo returned I/O memory");
> +			drm_gem_vunmap(to_gobj(abo), &map);
> +		} else {
>   			abo->mem.kva = map.vaddr;
> +		}
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	}
>   	return abo->mem.kva;
>   }
