Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A81C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175B910EDF3;
	Wed,  1 Jul 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="K6T2ngx6";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D226C10E31C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNZgAjfW5YbA8Fw2L4jyEMW6I1I/XDLkmmnd+SO6O16bh0J5Ubdt5oRw8AkiZqlGGg5PWr+grY7NY4CkhV94Rjxygj1iXDgW0tF5J/GGV6PPvK0eFWJSLED+TivFHTGo/2VXJSV0eRiCDzDdxx8b7fzERtvZfivmwY9sFFvfUEIQTfQnGuiGPWRsx/yvLx1azLaEVyDe71S4m0aeM+sBsvkN16TJJBhfBZUK3gfNU3KaIBHOl8sLKgk3XDb3pw0bo91OgRMajgI4P33TSyJwucO/V0NfK6UbHSBnEPLCFgAQUJuQVWcnfCGojVWL6nAxgjaiNyYgRz+gYRJ+9OSplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4TEm943zqrfH/dkWDqINtcbznRtx55T1GosdL3XJ6I=;
 b=k7/kHvunj9msv9rq4+hilzXvDs8UMGp+nBbvRTZmrB3K6V7+UuLmXQPFgrfVotU6ZlEgE23xlW/42mEGVOxhHtPajZ7gO/NIBEBjUlB6u+3/RytUffL1Ld5UXBGB468jOgAnHwqjl8DkbeohJ7cobXvBUKM333inWawBD87VItm2Drx4qDTBhXaJ7rEZczhlQHjK88i7ZTF0fb/JQikVxk/PmRrsn/RqS6osbZVOkvaMbgkiHVH6kIwkJvz7qp4B1rn14PQRutLQehhw7W/St64q2JPlIrBvuzivm2X/BWwjBjgmoJa6uYnPZIbQfat9uCbxZ39L999jiGNeG/H49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4TEm943zqrfH/dkWDqINtcbznRtx55T1GosdL3XJ6I=;
 b=K6T2ngx6uF4UU69lb7pPQcVzl/aeldfCH8Atz2FT/eEObm4YX7nshCTLLj0HxWi4QblTB7bdEFpjMayF6olNnq9s+ccztYWXaw8go+rdDAeEhtCHiP2IT57BtPL0QnsCIZ+DoDZltwAYc8qK16wa90HIbblX2UzdnDXctc24+T4TqFkLyJdh+ckrMsyiljpZhksgnI9ndAbTOyjZTLmioKUsgQhzDZmrd5qloJYx4IU21IZak1ZxIRMeUlhySAiQfbYNE4bU68dfTzaZvR6gYJD0rg/a8C8qjjX82MJphqJMgHm/oLzY/A8hQgfFANX1tW3XIx822J3MqvQIFJYkuA==
Received: from SA1PR05CA0020.namprd05.prod.outlook.com (2603:10b6:806:2d2::22)
 by SA6PR22MB5789.namprd22.prod.outlook.com (2603:10b6:806:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:02:15 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::3) by SA1PR05CA0020.outlook.office365.com
 (2603:10b6:806:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.4 via Frontend Transport; Wed, 1
 Jul 2026 06:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:02:13 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id DE0CC1290D;
 Wed,  1 Jul 2026 09:02:09 +0300 (EEST)
Date: Wed, 1 Jul 2026 09:02:09 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH 12/37] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw:
 Switch to atomic bridge callbacks
Message-ID: <akStYWMEyZdN2Gx5@zeus>
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-12-b63e6316166b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-12-b63e6316166b@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA6PR22MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b7f97c-5068-44c3-0b02-08ded7364c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 7mkEn5Kx1HBV5RnwZ6W2yKqYXTp52H3NPCj1ICWPJRbjtWkbVGL2pvZ00YxTXzJye96yI9plldq97/fVp4ZRgQSU+8IlqXYXg+Q7HGIft/qGmX9yPmZGWrn6Ng3nBR4Y6Pkyr6x+QodQr/NmRICZT2UsYDQu3RdlIUyt1T+TFee/ZrJIdwUv1iC4NWEE6aNBBO0T4WsPNbT4uETW+VX9DVcDmni+GblPCG3JaJ0XJapU+SE+FfyU+PM4yS+3zCGMD2y5Jp5irU1s/LuzHTMzsuPOTUnJruoVh7FO2aL3ORBb2huvis0Z+kOcsvYOvzPi6lETtV2DMtA7jCw8zs/UeJ9O+Mu30Vk75gVewIaCYp/eS0QTe/A6JjLlcJNb4i3NIwJOhMb6Mi2GEwaF0Cm8kdgVdh5IEWI2dn+HZbJ8ZDWyPS95FKXL13Lvk7JSf+iMdsDsZ5d0LCXWB1U4lEzzZoA/HQvyj++EX5qqyYVJqcHo2iCvih7s3NIGZwMCnCsfeuZYEP6d113f7w7zBE9ApWHhV0gZLkNhjMOTB/dm95zyNj4CJ2h2OajJIdskwiUXCB2FC8FF53P0EfNMErRP1O5XSfKM3ZlwkiGy2ih0UtLknGRnlMhGFa7Lz1kZigQTPSmbcx3H1hn6iKAPHY0S7Fr56sYfxDlALleVzuYnk6W1hp5a4m5Md2NGuBoq+Tn7UuBSh/8sLJddknApwhNRyg==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /iiTDFh3lckjtIVJ5TgPKqZ8cZL417f9uVAOkpDKUOpHY2vjIr9xhlWXy5pEFPrZPKcfd4wFdU8zYRbcLa1DH6e/V+UyGMsSRkGBCOVJh6u9T3Axz5p8gB0kHeL5oArwScMOJRCaErvIW/Q926t+a1cg39WUgbt5kqlJoAW873Py25nN8m4ToEA4UCGi7rF2ppDIm61Cwwb91pYQMualo9O3BH6KSzib4TZu11Jbb2I4klR/PmH839n13y+heBJn4Xntk/ELgLK7U0N/YhnLy5+67/MoZk5F1MVEFepkrjF/Ot2SPJwQzTiesJhU5nERsfKiIRZbvPIiBxBdQporTT8i4Rrwt/n7hImE8t812HM0srF4/tPHHiM8NJvpSSknqXsHD7NPPaDqPGVfOO49f9LMB4NdrbJEyrPyPEziSYQaUoBbYDmlU0UrvasFMCNn
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:02:13.7613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b7f97c-5068-44c3-0b02-08ded7364c39
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5789
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

On Wed, Jun 17, 2026 at 12:14:37PM +0200, Maxime Ripard wrote:
> The megachips-stdpxxxx-ge-b850v3-fw bridge still uses the deprecated non-atomic bridge
> callbacks.
> 
> Switch to their atomic counterparts, adding the bridge state
> handlers if not already present.
> 
> Generated by the following Coccinelle script:
> 
> @ is_bridge @
> identifier funcs;
> @@
> 
>  struct drm_bridge_funcs funcs = {
> 	...,
>  };
> 
> @ has_create_state depends on is_bridge @
> identifier funcs, f;
> @@
> 
> struct drm_bridge_funcs funcs = {
>   ...,
>   .atomic_create_state = f,
>   ...,
> };
> 
> @ update_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
> 
>  struct drm_bridge_funcs funcs = {
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	...,
>  };
> 
> @ update_pre_enable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
> 
>  struct drm_bridge_funcs funcs = {
>  	...,
> -	.pre_enable = f,
> +	.atomic_pre_enable = f,
>  	...,
>  };
> 
> @ update_pre_enable_impl depends on update_pre_enable_struct @
> identifier update_pre_enable_struct.f;
> identifier b;
> @@
> 
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>  {
> 	...
>  }
> 
> @ update_enable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
> 
>  struct drm_bridge_funcs funcs = {
>  	...,
> -	.enable = f,
> +	.atomic_enable = f,
>  	...,
>  };
> 
> @ update_enable_impl depends on update_enable_struct @
> identifier update_enable_struct.f;
> identifier b;
> @@
> 
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>  {
> 	...
>  }
> 
> @ update_disable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
> 
>  struct drm_bridge_funcs funcs = {
>  	...,
> -	.disable = f,
> +	.atomic_disable = f,
>  	...,
>  };
> 
> @ update_disable_impl depends on update_disable_struct @
> identifier update_disable_struct.f;
> identifier b;
> @@
> 
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>  {
> 	...
>  }
> 
> @ update_post_disable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
> 
>  struct drm_bridge_funcs funcs = {
>  	...,
> -	.post_disable = f,
> +	.atomic_post_disable = f,
>  	...,
>  };
> 
> @ update_post_disable_impl depends on update_post_disable_struct @
> identifier update_post_disable_struct.f;
> identifier b;
> @@
> 
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>  {
> 	...
>  }
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> 
> ---
> To: Peter Senna Tschudin <peter.senna@gmail.com>
> To: Ian Ray <ian.ray@ge.com>
> To: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 2d02cc69f237..25ff0a0acc93 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -212,10 +212,13 @@ static int ge_b850v3_lvds_attach(struct drm_bridge *bridge,
>  
>  	return ge_b850v3_lvds_create_connector(bridge);
>  }
>  
>  static const struct drm_bridge_funcs ge_b850v3_lvds_funcs = {
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.attach = ge_b850v3_lvds_attach,
>  	.detect = ge_b850v3_lvds_bridge_detect,
>  	.edid_read = ge_b850v3_lvds_edid_read,
>  };
>  
> 
> -- 
> 2.54.0
> 
