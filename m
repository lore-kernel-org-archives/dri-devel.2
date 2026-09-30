Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC59CA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB3F10F40C;
	Wed, 30 Sep 2026 13:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNgyxCQ/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD1C10F3EF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VamHs5yW8z53WNdBIV6AFlsihBz9RvRfayuUEzZEKa9j5v9ekGFLW2MwKolXJqc2E4imdWLJbQ1naF9KBtgLRW1vQpAnD6FbFyuMPNOQNmuIzNz8mwAK+Y6z7YLth6xjy6JTWcsJZKJGXCzV5oaFGsdtKKkZZ47T5repSsf4d9xBKTXUc6fYUa6BhX1BtxfwI/31FcvSJcjQctUSWieEBq1ER1X2jMupJE9qw515F3WWDIrhab3k+uYYE9bUz3/2b+fXNp5zmWoprHYy+mGFW0/mVHrBfbgHIK7R3YlcwNeBAgfhUc5jyUaqN6RDnmeHAc8bxaM5NCMmrg/WP2Oqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEcbgzCFp2LWuFu0gDnoBdXNAgiMz3UvE8B3Esk6PB0=;
 b=KYDIFSY3YMdlwzHmlCUGZviHrXwm41KKo6Clrae9BCDUGXSa6CTt0RxwMWR/oZvddAdg6lElyzLgLlvkCYRdyCxKlb7PLZEr/4B3P3pe1L+L9yn/pr+28psMmjmj32AqnIagjWQYdw4HXFzO6oKmxvOA5V2AWa22GEmjuP56eFCJW1bOTkt6RRxZ7L/gZ0ieqNOTZz3wvbuy8sHFTOLDn66BeL1RLR/mmNrg7VJbw2zeNTNcyONKufRcRT3lz9wVKzc73QSH7453lrWbSPoZ5Niazlf5ySFJx7VPuDVCgFedgBFtkqpRQOyG56xUgCz6q6L1CkPNEYJbd4w+IMp1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEcbgzCFp2LWuFu0gDnoBdXNAgiMz3UvE8B3Esk6PB0=;
 b=rNgyxCQ/R6syDf00XWkgoZCrH/y7U+GBYphvC+ydaSX7++attO6XG5PHbGwzSKHxIMQ0MZClcZSEWmV0CrMMxgwjORniGkr+GARol958e5KtA1aR1+xRu22JHMuv/tW/jcudAoMzOr9pQHP1OXDIutde4Rxa8Zxyw+TqMF5VcCY=
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:45:14 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::af) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Wed,
 30 Sep 2026 13:45:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 13:45:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 08:45:10 -0500
Received: from [10.254.92.204] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 08:45:08 -0500
Message-ID: <2c7f90d9-1f47-4406-bc7c-828ac14fe6d6@amd.com>
Date: Wed, 30 Sep 2026 09:45:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atomic-helper: Skip redundant disabled plane commits
To: James Lin <PingLei.Lin@amd.com>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
References: <20260921143049.46985-1-PingLei.Lin@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260921143049.46985-1-PingLei.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: e74478c7-a0b0-4a70-5a34-08df1ef90db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|23010399003|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WCBGISrsqKeNldwxsCKnyyR6OLNRD2wHfNG0c+b5yOmlHTv6pwG/i6xHzIlcGluhWFETDr1Wz55nF58W0taEKhBlEU6zSKFTm1u+tyRCVQH1W6SOEMjYbaq4A2BIKQdUtoOwMfTWJAc+EoPjBFpX3lOrUxn4auhBGUs/k6zBT/P3v9sxWJfPUiyCNuS+GgcCQCf3TNgLt5iKloAuKcGfUDnFI4JfSedE/mHHKyAjnyscxtXMiVHvWfPCpjyVOzk8oJ8NtBOxNVyhZCzveJGeGLWFWvqIiRo+2fJWXYHJC4kP7BsW58/Nk5MpPExQ0WP+E8JYQ/cQ5zwvSjwitAYub+hyWYPgr38k8BUd9rgnXjtViWX80KB4F5dnabTBYziKWbRSv6cKaXLxldt0bhnlfLhc70yDC16CweT1ug0zg4PNuRXD+AWb4LLYizRo7WnHXbWI1n3fB6CCLVo17bpo0QZ5dE5O+jBgwxIPA2dRlKAN39AiELo/vA7Jx3y8ED7btwU8miqJxjpqJtOGlHkT5xrs8ew7UUZfXT+4ZS9o6E07sRiXyDCiNqYN35rUVechoBZYXAxJj24Xry3pmNzluXjMVkxEuIMTdZj63FvASjNzUOjK8qzPwRGSnOvvY2AGjFQN+zh/KS5v1wGDaNsk1M9UsASaD67dXIUDks4r1UsQPK/3GUnO2knwujMz/3D0QAPRXtqSeSJezwpVXvv2yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(23010399003)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jzeyPe4DxJ0KKJPhlvhb2kIOS6/CmcW7ypLSkaSSKNITjyZ/Y0bTuP9FxWwlmnQW5NDJvRqsSfuiXivg9u8uc7i5uMQG3brNp1imU4eCfoN1E/Y+BdAWywQG9EZ9s+6LIWvzVx+zmVyscplUx8VxfZKfr1cne51zyhISNiAu85ELdK930Cj91xFRGPJUgzqPYscDZyA7js6M/Rxt3892hWEAOxQNXCO+a+w4/dbpE4fn3u6OFnqM6/bGlAMwUbm7VGluTGPQ4PJqxhkXRrkfBzhAbV56DhxGlVJMEr8+LsIPwhYxRthDe8Q7jGkhnVlI+pHdDA1g8aVzPmxJr97QUpw/VhARwKcxyOG0OZOBjoCv8SxkZmmQpg8zge8nz7ClbT4M45sx2CF7Z2Xau6Cu7Rn7roxbVVkzQ+S6NK9WJD2IRZJwjMeSCqwRHXYpKZvt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:45:13.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74478c7-a0b0-4a70-5a34-08df1ef90db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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



On 2026-09-21 10:30, James Lin wrote:
> Return early when the plane has neither a CRTC nor a
> framebuffer to avoid redundant disabled plane commits.
> 
> Signed-off-by: James Lin <PingLei.Lin@amd.com>

Makes sense to me, __drm_atomic_helper_disable_plane clears CRTC and FB so this can avoid redundant calls.

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 51f39edc31ed..30cc9c07f455 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3470,6 +3470,11 @@ int drm_atomic_helper_disable_plane(struct drm_plane *plane,
>  		goto fail;
>  	}
>  
> +	if (!plane_state->crtc && !plane_state->fb) {
> +		ret = 0;
> +		goto fail;
> +	}
> +
>  	if (plane_state->crtc && plane_state->crtc->cursor == plane)
>  		plane_state->state->legacy_cursor_update = true;
>  

