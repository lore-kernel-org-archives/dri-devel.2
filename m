Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AACCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 11:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A4410F069;
	Thu, 28 May 2026 11:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TDVtnmQg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE73310F069
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6/x/2zoKK9diuxC3L4eerq1K8LbujbNJfo7NJlrFKVosZSwNTpWFTdOWPDJHpXzrp8hOYa8W9ZU9LfXXiz+t6r5dxFbX1kdo5jOSu8+xqcKALYKDHvIWnEIkHLCrvt/4xYgOd8cdNGqxSs9LmnW7RIhcS2OBZqbGa1TarXgLvWfemWgbRYtwNnnFdjVVL+9gvXbuyIj+ZK93177ebb21nnvAvh805DaRRF1Z8+KwexOFJoDgYYp3mae3ULIENbqv8iG9AYkjoU5533nO/1DGpfCUjkQdSK3uSawl5G7vRIN3SwZVqX+QPlejNzgDmMfKc0c8LrWFZOq0tT0KwVS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/yox6qiTS3Hk/9/amI9A3GWnlNfA6lz9kXXgWfrzxE=;
 b=IpyGBxfMZH5pdpMcRUSG0ZmzNdRqmpvS2b8ia1p/AgbvHPREZXUWF1+AC/w3jE01TwTvj+/yBibFV1JHUaSqu7tnxSkK6horw+eXFeCFCqcdy7uJlvL7f4dS06nq9+/0AZJJsM2Snn2soCd1BihCsLNKd9rwuvEk9RWT1Rnnt1gbswjYEzibntqjG5h6arUpG3AxLtNBHhpzTTIVcbF/vwP2sFgTlcciRiT4XRUm5eslP3/UNhTHUgybk69f/lgeXkkCzay5yTeVXNiGBgP7vPCT+YBSxDbHJMNVv+jQ3Dgbsv5HoNYVDT8K4+1iQZGBuK3efrAaH17P8Enh2wmNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/yox6qiTS3Hk/9/amI9A3GWnlNfA6lz9kXXgWfrzxE=;
 b=TDVtnmQg4MJoevNU+v9LHJOsDHTL5wJdOKUklwhSWhrrU6Il1I0UkawAO/gTcz7rUifXuCV3HwNRgKrEk+9Q5gpZNU82VNy0rQ1yEfuhUxMr+OmSJSnX6Bo16rRoUmjqxpIuUR9YK5GmgR89YW0DI1HFH7D+Gn00T0mHfDRIieY=
Received: from SJ0PR03CA0080.namprd03.prod.outlook.com (2603:10b6:a03:331::25)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 11:40:46 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::9) by SJ0PR03CA0080.outlook.office365.com
 (2603:10b6:a03:331::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 11:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 11:40:43 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 06:40:43 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 06:40:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 06:40:43 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64SBehOi1428868;
 Thu, 28 May 2026 06:40:43 -0500
Date: Thu, 28 May 2026 06:40:43 -0500
From: Nishanth Menon <nm@ti.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Reding
 <thierry.reding@gmail.com>, Vitor Soares <ivitro@gmail.com>, Vitor Soares
 <vitor.soares@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add
 display and peripheral overlays
Message-ID: <20260528114043.n226kfd5urad22xe@sulphate>
References: <20260522161105.277519-13-ivitro@gmail.com>
 <177980721984.3070642.16547338359984019493.b4-ty@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <177980721984.3070642.16547338359984019493.b4-ty@b4>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: e9aef92d-502e-44e2-3260-08debcadf3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: jKzBNryOoSRwf2nY99K4qTAC4ZFxJhWwIwQPAORKhrE1Wm/S32+YWuY7AGpRVtPtWPT8S0eaI0IZYAGfIhTTeVOWrwKOdfUYyy57RVHwB6pWxyDrczGpQH6Z88kjoEWn8vBKMSFKZCZsUCsI05rHnhD+3b/CfTt04eVxH70b0kWvmwQPc2f4fZekNemGtL7sgGbDlLWTeEy4omPyuywseX4AxfCokm8keIKtZGRChUlMZ9/CCRd4Rf3NSsg9P7Eo9/Dw7RAg5p6gr+X64Kt1rIbsuNWAXK+JcLnA3t5WFq2WUvWi/ndCbGiET9SZJs7FbwFPXv57EDTbk3mEhAHNaABMIh6D1BLO8OcYtAYntphV6Yw+cUi87LB8X6hN6vaZ2EFz/E9JbPr+tVgeDCZXeU1Hkt4VLTrCTkZQzz9JWGzdutw4nfRIf6bAjxsJjGl14X26pRNB83FHLldt98Y2/WCko/j2GxUwuRGqhqn5ET5wL4wVybKt2FTUAyM/iLVoL6gmwe62hikYSXQ7+FOpe5Q8XISLAyA6SUmMTVM9rpjl6pcDuIXslYZDHk/noU8CiYInt2TpE16Srg5vRFSPE2wNI3UCJocBNF/SrynaNIfJXpn5mACvPYbfZ8rc32fF3kjT/312ylBuW71BsO7U1h5Eg+VnGj9ZsZjR94dND5Q6wjYDK7L6GPLsOkCH/4/7
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ep5sqNNLaUzROjUKs3KEiwjVcnkBSMywsBvLCCtghjejY2psXAYd7PWUNFMGUGsPodrNMOcmjHfuzWDifRqX3KK1uDlj8Go2ROdRitd+MMJ6HzdXW+l+2aimC7OnAMeYJOLdX4VcM83MenU0RgLVj4YVnWr4aO7WE58G6SPSc6PbQ9IDr868GtlZcuoXobvxSVcViGs+k/fChFl4GfBMVIvtc2f4htXvmvGD7L5M9uqBf2rKMmYDRlvRwvGKL51oPfVRjCbJKJBEBeKDH8QMy3rKzvXUDDk78tezzj8CIRjB+rLdN9B5eZnATORB1VRlvnGNlHrLZ6x/sws+n9c+NPJ/bBAhJLMaDelTroNBPAP1TkxWq3vlGG4kL3XkgBA+JO9qoZpW8fw8TFu5zEllrMTPJt7W/fvgh5FrFyl/EixbViSjPrBwTn3KazGTHtr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 11:40:43.9650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aef92d-502e-44e2-3260-08debcadf3ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
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

On 16:53-20260526, Neil Armstrong wrote:
> Hi,
> 
> On Fri, 22 May 2026 17:11:04 +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> > 
> > This series adds device tree overlays, expanding the hardware support for
> > the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
> > and peripherals available through Toradex carrier boards and the accessory
> > ecosystem.
> > 
> > [...]
> 
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
> 
> [04/11] dt-bindings: display: panel-lvds: Add Riverdi RVT70HSLNWCA0 and RVT101HVLNWC00
>         https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3c3c5fb9b36836d279ebe370189d68a0a3387362

Neil,

Could https://lore.kernel.org/linux-arm-kernel/20260522161105.277519-16-ivitro@gmail.com/
go through your tree as well?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
