Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D28FC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D105410E1CD;
	Wed, 19 Aug 2026 21:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNc9wi/f";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6626F10E1CD
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRfgWrmF/77ld+Gvaw81/Xw5vfrh5WylUbpTaR/9zC9L2D0aPJo/n7OF4FH12FNLBlU1+CByVNB505RRr7pHdLNP3hG482onAsCODpZb26KSXTwYMkDLEO+leMNDk5HWdHv4FZEDIhhMB4sGcgS6LyOBLKN+HtbjpuXqu5vGy6WjrrtlF2qdYuh1xeYn43e+GuRBBBwkxrU6DITa0eLzb1VNj3CFooEO07RNA1ucxCnUi2vrGqgzZ+e/Ti86ZvMlTBa6P7LaDBLpV3/QuLwUcIW9b8tTYvgSFp0Woi828WegflbgTRoGYu/X+Tzh5tQYgIsj2cu2/1TR8uFeNWcx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrYCekca4G9mmyH9IjQOS/SeDK3c7P7lpj3Q8V04GBo=;
 b=lJiYmtuzcPO72IyIjF9a5xiC9tUbfusv08ZeORRU8YOs6qUxhElICDcaNv4SFzJnFXeLzkOkI+vXbHOQGcUSNLR6BMv2vjV0EoBGZWWqw+Mw7OV2xLUQoLPs5O0zQ4NXCuV6RecDLZu3IlC5B2FRhxjVOihZ6RK9K3ewo7g0UUPUG1oznW72RGuJUAPrn3XsqLCdjQIAUVtWf2lBUY+9OPrQhARDGTd3AZmguGYuNWMDZfDd2vDYEYp/ubpdoJYstxvSm4BEl87udNb4ZbodX10RNIT3HoQ5b0P1J4gLMwg8mwTDrqyu9KZOL1zU4kvFwrEIlna8/J3hqJRvHJeZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrYCekca4G9mmyH9IjQOS/SeDK3c7P7lpj3Q8V04GBo=;
 b=fNc9wi/fCQh9u1A9FhI575UXWn3BeaGkdJC+m5OaI7S+wJtIq0lYX59UOpRIhYEg29fivbvgEp8XA3cOUu1IibvVAhmgzjIX2r+GUi5vW77TwTQ439jdNBItOkPLir0Nkj69HJQhAmCJ7Q5bTDrnV0fYOUZom2YDI+E6r8Moo0I=
Received: from CY5PR15CA0144.namprd15.prod.outlook.com (2603:10b6:930:67::11)
 by SA5PPFE494AA682.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 21:05:05 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::14) by CY5PR15CA0144.outlook.office365.com
 (2603:10b6:930:67::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 21:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 21:05:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 16:05:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 16:05:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 16:05:01 -0500
Message-ID: <bf6b34f5-eeb5-ad54-388b-24223a37d111@amd.com>
Date: Wed, 19 Aug 2026 14:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/5] accel/amdxdna: do not fail a sync for a BO with no
 debug context
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <alexdeucher@gmail.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
 <20260817230707.356828-6-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260817230707.356828-6-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7892634c-b923-436d-ca9c-08defe358ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|5023799004|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LiuwnmL/K2psxdx3BCMCVFaGwrilZrruDY6UauM7rJPC76MMimf3x81Jp1D3KzCx9e+vSgLqKpC0EXninoctjfci7SjtSW+91p3Y5dysSj8gr0BD3C7+OkF53J64tiecRxkGJ4GkE34vPZ5Q7wpstR25ipH0TbSTClfD8ESL+f5nuLsQ2NVCTWJ/KUfFo7dJyCsL6ruP0ygJvQp0SH5talizO1nQcchD93xePBukDVFAfjqTEGTeJSAr1xtE7qF/4vNi0gVFt7M7M7plIzQSSM8flDk3Tev819wv0K0HOjTv23bWtAxh2J0LFtIjQeFRK/5Wch05KIzlFLFl1plBPVFFvDm64KKXkS0PxFNxGiUtqlC+GWAf3q8BnXXkVJx9RCFE8U80py2J0ZgNHcWqqFIfIi3SQLGXYSHr7OmWfr2Ke+M5sWeWpXZA4qHjDTruwOQBuPeeHtsyJtGcydCmRr/geqY8U1IBTYtoa6MmEpdME03Ek1raLq3v3HlCFHAN2tmaaHu8BAzLcm65PyBZyljLXc2yBK0wVKzvBQleHSmtcT7kz67GT+ca72pdLSVi0/y6x6oWGUG5otH8UX2d+IwxC9i/McOAuYdIYqUjx4FYHrGuY6tREku04wn/lNVrNXQZTv1xS2qQQdpH0hOvrT8ughN8mVwzw0fytqbPCiDEOoRnzrv4TZAOWE+F5mI2K6AwNT5D18V1UVpeoiAppQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4JvnPuzPjtM5V15MxKkeC0TohkbHe302lGx1+L/6WEbwJgc9rXuIBSjrX33BEcCwXjmAw1vYoRBK2h6KfKHRUo8eUZyFf4DCG4AEs/kPt+V16bXuZDVsyipAnkCmy1yrtHpk3M0xaRxPE0NYJHdzLD2cG4HdMXD9OuYDycP6LinIJYytIQA0xg4p5WW8pO3OUT+jYF9GwW41y6fx8i8EZifHB9tWOMW1dJCR9JTFHZUVBw35eZu/QFIy0kynGzD/kEOZH/Nh5AGPTk5RTg2l6vZycgkFH8z6jMC5OhRP/Eb9FULQHyked/iLEqUeiHLcsoTNUmKBIK1HfDWWCfkQH6SEAFcQHnh48uY5Y+C5N1YRohHtOemfY9VFJLh5ypXn+oMXcaSvDRc4jYrow9QBQL55nqH4hqhsKpzGSww8Gk3uhWm+P1H75Kv2rOj3JFEp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 21:05:04.8077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7892634c-b923-436d-ca9c-08defe358ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
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
> amdxdna_drm_sync_bo_ioctl() calls amdxdna_hwctx_sync_debug_bo() for every
> FROM_DEVICE sync, which answers -EINVAL when the BO has no assigned hwctx.
> Only a BO attached with ATTACH_DEBUG_BO ever gets one, so an ordinary
> read-back sync reports failure after its flush has already run.
>
> There is no debug buffer to sync in that case, so answer success.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 855da8c79a1c..c0d0aa53c596 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -416,7 +416,8 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
>   	guard(mutex)(&xdna->dev_lock);
>   	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>   	if (!hwctx) {
> -		ret = -EINVAL;
> +		/* Not attached as a debug BO, so there is nothing to sync. */
> +		ret = 0;

It should check assigned_hwctx before entering this function:

    if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE && 
args->direction == SYNC_DIRECT_FROM_DEVICE)

        ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);


Thanks,

Lizhi

>   		goto put_obj;
>   	}
>   
