Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62034CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A357A10ED1F;
	Wed, 13 May 2026 07:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="uVsc1U82";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5DC10E2E2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDoenzcyX0s7XydN65OULSi5lHQHlJ9FgJhakA35NoQ1Fy6FG+y2j1NJNEefHOypXoGPo7TO9TFKu9AgLqRkYt72xGGyRSFPU+jHrSiJXPp6hZRbszIMG6AsyCBtn5qqQ3wnS0UQpRsMADgRC/LtsGjCjn/x/gTNyMdlE107MrAO0bbXsd684RUMe5OJwF7Uw4kfPcc3gyJjwEB/C19loF1Dp9GhPLWa+iykgWFAdZK5n/KEvYqblb4KU05DVfFYHiohWSeBIE3naqAkDD5ORlTnnH3/SWDUjkPlj0Nvm4okssUFMSQ54oA/MxHgu6nVk++Bl8YPmwI3QzzC1RONuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L7e9lIqPC8X3+V82e1SGUuk3M422PvAD8xYZ4mDock=;
 b=NGDKMoD1nelS/JRCMKQEwNIW4jXQvedNZt6ihmdqhBv/j/CN8MTTSuwepliG5pwlW0CliAQMErp3mBU22EmKV8HGB0OE3+t7BgdR8mXNagaRTp6UgGU/fLlzRIrTkRcstJVYTgMeS5QQJT7SLBELpJ6v7/qMy5e1UncW5MtpoZalQ1vV7I2SiOFSNvXK3C1Irwpz0jQRbpmmzGP5tEmAgUkyfdV+LONIg7C97fXJ9OzTHYyhqsWgAYqi8PNnk2wRiV+QrCY1sYoSSW2ESyGFIus81pmZVn1Ki27OI2bSUT25NyicH0TENfIgJAJWX6TGgx9gX+X0iB/H7PYpFj06bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L7e9lIqPC8X3+V82e1SGUuk3M422PvAD8xYZ4mDock=;
 b=uVsc1U82COtMB94q48uqlHLrfxyDmu+sB0vRqKCGEm6QU3di2S0PmSjCiDLNf+CjseC22A6oZKYB9w2MvnuePIkvuAa0VFYJvR4DWZK0B40BgviKMTnjd9ddPiK/VeO/BQZ5yxQdYXscIpZW3jFNGrx+2FfQBZkYpQr2TfP7mpgJ0qZfhC4poaUyUiR686sTapK/+PuYnovYMb3SC0NoKZ5oBH/phTVRwPgPQEFFNSBkmUQz/NAEevAOyyH7tKEz16hCdIG3L8hR+zLUcrQmEcYHuYuXx8tNN5a960Wc3DvGGDXnUVlU3ebCdNAqdBjYh64QQNTVk8jnceceOJJSNQ==
Received: from SA9PR13CA0091.namprd13.prod.outlook.com (2603:10b6:806:24::6)
 by MW4PR22MB2974.namprd22.prod.outlook.com (2603:10b6:303:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Wed, 13 May
 2026 05:04:25 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::62) by SA9PR13CA0091.outlook.office365.com
 (2603:10b6:806:24::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Wed, 13
 May 2026 05:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:04:24 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 5D970131E4;
 Wed, 13 May 2026 08:04:20 +0300 (EEST)
Date: Wed, 13 May 2026 08:04:19 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-ID: <agQGU_N7DtT4nvU2@zeus>
References: <20260430195700.80317-1-osama.abdelkader@gmail.com>
 <DIAUSFCMDQEJ.37TV8SIXF9OTP@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIAUSFCMDQEJ.37TV8SIXF9OTP@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MW4PR22MB2974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3798b9fa-0c03-405b-81be-08deb0ad1a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pKvCq0CzK4zStaN0cmQfA3kS50n3pwjcQ447inJCaJlN8Fj/EpykUSVURIdsFiMDIHRFT9FzlyDiZWCygjTGZNkSzUGNAU3m3TiTKj0UlS12rDAVDG0ONMVoIliXt68yX59PgPsTyVKMzx9FEsWgXbDwNCfL7Svqy9WDpoxE7H8Cq41100WcWxt4d81dBhcoxXsqfvVQPrd+7tUOD3clbZ3GlNtvrOS/uy2545Xj83Ms8uc1qcp6DyQ1lHZXrzuQApJ6q4Ue1BHvsqigxO0r4KxzWDBUZTCNLFceU2rv7Ib9L9d8JG5IeQK6K/eVMcR+fG1DJrd4TlrvET1A9Ib5NsQjQiWnrvHLesv0gosrRE+AXHt6qsBbAC64y5ApoaGyXg9JZGNw11+gDmjVQ/NQR4nXM0Qb2dmEdvP1h7wOc8ez5AThxfM8M+U85S582jbQwF+jWxz+YuHkG/ntd0mgXfAEd0rWTZN+NTkNH1gSSWrp3uFGRVWG9Gxdmjb1bT1b9a1NG7LZVHtx7RPfGIki8t3RxVfJTZFoPuUu5xiaXyFZr7RoEIgZ1ftrIA8DHwAeWy20t9likWaPnCLCXOYkWyTG7/SdpP/ZYGIHvyb4SVPU4Egy3l9N1FaTzXMWc44x/DGKnHqdYvNv5PzAC8gIrsAphY04HxLrty/oeIW4YmXp9/dsCvA17fYCya1ztFh+
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2NGDh/X8BZAXLU20BM9lAgMENcTr04I9OeyQyQyZLauUc9YIsPDnzRHoYNa50hEGUp2xNxr/nBWt6xBdlQvhRvVCf8amQj3Y1WNkzC5ks1vESKeCsGGN+BqZ2spCSIfe3JPzAVSKhSIsWxaNtEGeGZnQuUB0y6LjFEsOSNz3gA8fsRFj2PDpY45R1TPEiLPuseaTZYXYFVUpPRXwlPLQU6qx8u/SBO0HSpVjUvo1VynR8Bq/kGywCqvPB2D64Bn/GOcAmrNEjR7HoYg6Sw0/wDY3RYfkV9cITB53VNzb7Kk4REqchvj4rWQT6clnShQuqPp2nILsNVWi7TaqMwQeASRaS+9rAl6aLwxEPpJ1wHvol9CQnjFDE0PV2Bc7N0Jt1GH5cFe9odNuStVlIncTQpk3xkJWYDyayLZfaw00XSlzXnIp5o2noZbQqL2QyKn2
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:04:24.5839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3798b9fa-0c03-405b-81be-08deb0ad1a31
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB2974
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

On Tue, May 05, 2026 at 05:37:42PM +0200, Luca Ceresoli wrote:
> On Thu Apr 30, 2026 at 9:56 PM CEST, Osama Abdelkader wrote:
> > If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> > bridge before returning.
> >
> > Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> > tied to the STDP4028 device while ge_b850v3_register() may complete from
> > either I2C probe; devm would not unwind the bridge if the other client's
> > probe fails.
> 
> I had a hard time in getting what you mean, until I noticed the global
> (ugh) ge_b850v3_lvds_ptr and the two "Only register after both bridges are
> probed" checks. Pretty hacky, but definitely for the sake of the fix you're
> introducing your patch will be OK.
> 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)")
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Tested boot and hot-plug, no regressions found.  Side-note: an update to
MAINTAINERS has also been accepted [1].
[1] https://lore.kernel.org/all/20260508234835.38732C2BCB0@smtp.kernel.org/

Tested-by: Ian Ray <ian.ray@gehealthcare.com> 

> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
