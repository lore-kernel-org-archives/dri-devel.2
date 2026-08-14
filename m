Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62145C5DF76
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEF210E2E1;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="xfoDB6GZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2410210E150
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv91BivU7dnSRZQpiGKUFRc2+ol4xrtOULAwUVyigZLLx3PEdPgjgRNYql0217zJIV7y/KuRprIz3FEJ5WvDuxsW7JFGzV7GtJaYMk0m2tZxc1QPo243d7Wr2f/cWTm+m7AYkJlJhPaq+R0zFHUZtu/ekdI2+LZKT4siYWZ3WC27HK/SVTsbm9Ym/3kYWK8GfKphWvu6funAOtlo9gfy/kKQfNqSyPJhdUHQW2yFYXPrYR2U05xsfYC4ssb9O9tiAeWiFLHYdRsf/XhvoHcPl9cWMHVJ7b9U8D+ZSTVXDlwQ749eIe3MkKwUtqayeeQtZkCnmJMO9fhzOCNO2Bz4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzX5VWC6Mkn/0T3WQt/Utek/gGAlrZ3CPbBdmKxvF9o=;
 b=bWeWDH24NLaBAo6LAT3rd1WxRsiSi2Mkjkv1LUsQ3ROh9nLp7XNH5nMaX1j+VTpo6Jd++YrRDgM5wLUqeeAXzq+de9rFjeCGu74UI0Bd9gOghgfXosYVgE0Iw5tWipNddeohjq7etxJmyNS3Z4gW8fUsfMzsNa/i+I7Sucja0qIwjPpGISbQey9aRQICW0yekYK4HvnnXm0IkacczToL4w0DglLEYMOGT6IbWwHJeFnc3BqktaM03Dv2M6vATihytApIgp+3POo9q/I2ryt4E7z3CdM2Dpg8rtKMzbG/5tSllZshSJoeaPDMewnZqJ8mErda8/mPO1gTPgZ0lCBXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzX5VWC6Mkn/0T3WQt/Utek/gGAlrZ3CPbBdmKxvF9o=;
 b=xfoDB6GZ8dfiUgKwnH3GQ62TqOXz9aaCo7lDdke5tojBWRdxZMMZPLQomQCgiwg8uZGHGZTzfEoqaCj2l/Yn8eRbslXjOf9MTRkREWst3v47ZjCRWTk67Xvj3NgBEItK0Xl5WcycRPmiVVOR+ToxRzwnKSq3T3SZmoDTYysvBYyP13R5LT+Vg1/l2RWbe3n0Zst5LMpWEW4iQTTfD+oabFPjma/9+hb7PV38Wq83O6WYzXf4a2vBEkP7fGwF8Ozas14+bSEZKIx5xzYww4dSVaQGbn6EJrswB63gE5RciEPLWN1HT8UYWlgZju3u+vK0OSqaw1cjIXbIW6p9+wV+dQ==
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by CH3PR22MB4406.namprd22.prod.outlook.com (2603:10b6:610:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 11:48:40 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::21) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 11:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 11:48:39 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 89C7DE4DB;
 Fri, 14 Aug 2026 14:48:36 +0300 (EEST)
Date: Fri, 14 Aug 2026 14:48:36 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: don't
 select unused DRM_PANEL
Message-ID: <an8AlCgNh3E4G5Gc@zeus>
References: <20260812-drm-bridge-drm_panel-cleanup-v1-0-0d86734e908a@bootlin.com>
 <20260812-drm-bridge-drm_panel-cleanup-v1-1-0d86734e908a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-drm-bridge-drm_panel-cleanup-v1-1-0d86734e908a@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR22MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f0652d-975f-4a29-b588-08def9f9fbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|6133799003|56012099006|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: 8C+7gKB3TFlj4H+A+oAwgN1NNK5AH/bazE611OGzdYB/WkOnUwNCNljj1pP92PQH4rXraawnlUvZLP18TwGaSHzvkhwmUv/c+NLQyE2Po2GOTFWSo6RF9GgaxIwT1pF1SsSEc28KetBZ4JX1CybW9dHvVxvIQ05R73KwvLpPSXjItsbCPYOB/mLg4Z1TI8sSrEW5luJkoDNNr7QsNQv2j31QzXpZcunyLjgdrRSJ8cjlg9soOob7+CaxQ4XY8p3sEJuekIvjarH4QJ2PJKoePvl5Abrp4Qgd+L0pxtURiGFi84+NCMTavFogvwnbQszdpbxQv20LmwIwc3JmOlFkhMZSZ/bGd40JM/59Q05TjNACe8ZtfQUh7zBP3ULdKBKW6bV7RYalwZjylj6Pr8/zjgP38Y0i35fKpHHLVsTIQ4xnbxt445eflyDkv9vVfv/JaXInPilanb9oCG2n0QQNngptm1hKaLg23QGLOEF+7aaLF+vuwgTF/tUBTi6x9unHlKvWue8pgvvDOQqxxWXhHCFCubTC4dhyD2UPEy+HskXCMXKuzWBIiV1jwwL2F4lzSxITGe9hLn6zj7vOnIajtsFpLmoBjMkZGRJAVK7WfKDXdGylfFZidbEKqA7p/ciOQqIB5jFU3kC+vauIiBg953ypx+F9JBbmvKNi3OJ6ZUUvqXMYLokWuARfwHMvzQFf2kRGuXfit5DGmth5wv6wZA==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wpH+h3XFU9uhVYfBgAWEG/s+cwQYCghb3KaQJZ4RoEivpTJJ30Rz3NBE2o+tBLSZbOPg6uk+tI0VlxEJs0Pgu6BS1yPU465g0x0igUe8m5ITfrAYV5sLQKvbuxfbfcZZf/Eq97P/bgQxcfc5TPAD9jgQEFamhA+vgCe9FAGAtKn+R1d8AFeHWIEIp4UcP+y3Iq6GwLj2/n7x3ex41sOkcTfQlB+CzC6A89T9ihDztXwVDkxewv1HG1Cx+4rfMtsecK29SEQC0Sq30OQ5+AIX5kuf5r4oH/5MIQ4OH/uNc7kD44gx7esr/6bQYEK6vwxT0g183QIEFRbmAqOu4khEaGTMyudgWaMfHdNMAOU/I7JGNbWKOjuLmwvaZea7RinWOYilJW6cXK6812+cemEtV856dr5N+DPErv4DGK0qypSM7ufggp0hAGwvz73fTWR
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:48:39.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f0652d-975f-4a29-b588-08def9f9fbfc
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4406
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

On Wed, Aug 12, 2026 at 03:42:41PM +0200, Luca Ceresoli wrote:
> This driver does not use the drm_panel APIs at all, so no need to select
> DRM_PANEL.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 4a57d49b4c6d..a999e57d0cc1 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -225,7 +225,6 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
>         tristate "MegaChips stdp4028-ge-b850v3-fw and stdp2690-ge-b850v3-fw"
>         depends on OF
>         select DRM_KMS_HELPER
> -       select DRM_PANEL
>         help
>           This is a driver for the display bridges of
>           GE B850v3 that convert dual channel LVDS
> 
> --
> 2.55.0
> 
