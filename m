Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B05CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E838410E539;
	Mon, 11 May 2026 13:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pWxuly+5";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DB810E539
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0hk0sn0d1VEMXgd18K9pP6DQWHeZE4WTppbOI8gtojWN+5jxNKnw8Q0Nqh8BnWgl/jn/ZfG/ymjr3UjBlNMfe8dmAAJAF3hu7PhwQk1Wa0nDt2VjGjYLrRAcdzHZTFd/evCs86KZ9Q453EanHcLuqbA+TU/4qiKGjr4BzgG53SvParALr2fJgqyfsFiIdJWoU35yP+p0f4cwUDvninhNsZsCFEV6O6zqEmfsAyLtghUV0I93yVUWx5m0yYAPqIYCC39iE6Q4s5CNOEdn3jSbflyhnj+mFQdRTfU9fZOPkZkpFF2IH8rydrLNnRaOv+nT8W1FA7petiN2LRbGCuZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFHOapMXE1tv6EvDC3lnrF2hf1ig3o7NeTU/uB47Cig=;
 b=s18ZKCoMKDhHTBWg89hFuXvUsNmRJij9auXOeMkeJc4Ym/gM/eafwQ+U/EItC3IqOxhCVQrgzS4qZXO21y1KWM2ih0AGcq68sFVN9Uax0Ri7rFd+1nsZhaOG0R7u4MUEu2bRXQgeyw8y7G7QlApi0e3KCf/2umKsWdcc5gMSANjcQ0uXObIz+jof4ACmugaiYy9APAkuJe0j+uOaL2e+EdpgAuREf0FPolfcSrklKsR5FWD2o7LFXyDkHg4D6+BSwAfb+jll+6oL4P5hIpjIeBapvY/3+JWGLy+g0oe2+lRXLPLeRmTb55ewLFvVO485mW6aNDSa9E51OM2amA/tNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFHOapMXE1tv6EvDC3lnrF2hf1ig3o7NeTU/uB47Cig=;
 b=pWxuly+59ePsUUT932pPAf3uuj6C58DzIS71/2yF/raJXA8TpZocwDfFhbSGZq6WoHFtzkiox24oBTe6fDPaM4yE+VlqYAeZ1QJjIbkqvFs0GQ3c5f4y4BImQ+Us8Kzhh8qGaGyGA66DgU+YagNDkTkASzA7OP7BzRJU8UUCSGY=
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:20:04 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::37) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 13:20:02 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 08:20:02 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 08:19:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 08:19:59 -0500
Received: from [10.249.132.118] ([10.249.132.118])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BDJrNl3786243;
 Mon, 11 May 2026 08:19:53 -0500
Message-ID: <53985724-09bd-494b-9093-3e7efb6a6ce0@ti.com>
Date: Mon, 11 May 2026 18:49:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] drm/tidss: Add BeagleY-AI display support (and some
 more)
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c525c1-5ab9-4dec-c55c-08deaf600281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|18002099003|22082099003|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: rFgdfCfnMOZ7s53CS/LkRGCAWlx9tXZOdnU0++JCWmBHdqfCXERBQSziLJsNga+0YT2pJgu9jipV4Wn0bQlDKPmTWuhFSIy4O0QrwtFXxpcwpOt11/wMsQtrLXmMz55mJf4wN5cTv8OeY9KeowZhJOY9LQHzvEw7hDZeBRP2iOo+Tugveeap+wqE1HdAtSK3/j4JFDnCuixx0BgiWsOhek59izk5OdBkB7GE/dcFYg/USvYnAWZH3Mw48qXMo+YSlZ1fSr3tNmP33jmpunkLEW6JgUPZEdEauksbfWiLecSqjHBSR558T0uDO9o3UUD+e3/nMiTmnioELD9JAF85znvbCzWg4UaCyTHpxzrzKJE6KlApCfdBOagFh69WUFqThiVNS/yF46DWPb/8iqWxWBccyOObURV9eILs9MFahYyyQ7iW1OaEvh6bdKRmN9EJqJHU0YZtq7X9wibZmxUAsw4AtYY6DTT+ZDV6lmpOwl82KeXoeHiKo/g2f8iJxS6oe+zLjyAizionrwvjHLpidn8voPDbStKQolVH2NzTCKFArCfwSnm/JVAqUX1F6J/jr2WbNmofgEbhwOzU7ch2qOhULl5eIjx0aGw11JcfCGSfb+g8nbcqn9TeGO46uDHXCJmTwCh9znwkVphd2nSK55i4mbVYgEX+tf+t/LCzmt/P1XxTpb5sw1Dlrd/ox/tO28km6he1UMcW91X/x2J0/fcEk9FvQX0oLDQYZwD1LWo=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(921020)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vu8TneXfty4r3ZbfiQ8CfomC01oy7+zJHyFoy3OGd2q3mMeWeclANNynaFmBmQhtFhEsm5TEUzmmMYqJzkqE9vu6Rx4FLaMTJ5perKk6cpWVOF1NmmGWKSdQGBfROpYz+3od6t3JeEWvb0A8Lws+dIAP6vT2MvV4nRtN50j0rPXdOiw0tjnHzrP/h8tBiX7NFgTeLz6ELxFcNYiAM/o4HQjY+9wZC8jCJ2l1Z0sVSuXNPcoXZgR8EzLq3U5w9dxQtQlR4laKKPSM5eG13kg8JTGwOVgYyknOw6TZqAt7+ni0SirWGEW6XbQpH1Hy47Y4yV9bXIDKIf6kbzmvh8RProEu0XpwwUCG0qBXJR/zp88dbUFwbwh4oXVzom+SUIrBddVYj8x4eSVClT2lHl/ru2OYDAyuqvzToTGzL8/Tic07kfOkSRlIBOYQK9m0ClPR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:20:02.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c525c1-5ab9-4dec-c55c-08deaf600281
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
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



On 20-04-2026 18:24, Tomi Valkeinen wrote:
> This series aims to add display support for all display interfaces on
> BeagleY-AI board. More generally, it adds display support for TI AM62P,
> J722S, and related SoCs, and, as a bit extra, improves AM62L's DPI
> handling.
> 
> The main topics to highlight:
> 
> - The ti,am625-dss-dpi0-clk-ctrl feels a bit like a hack.
>    But it is a single quirk register, among other registers that belong
>    to either the firmware or other drivers. So what other options are
>    there? This has already been discussed e.g. in
>    https://lore.kernel.org/all/20250730-fix-edge-handling-v1-0-1bdfb3fe7922%40bootlin.com/
>    without proper conclusion.
> 
> - The tidss OLDI support will now use auxiliary device/driver. This seems
>    to solve quite neatly the requirement to have a power-domain for each
>    OLDI. The main issue that remains is that on AM62P (and similar) we
>    will have three OLDI TX DT nodes, even if there are only two in the
>    hardware.
> 
> With this series one can use the HDMI output on BeagleY-AI. I have also
> tested the DSI output with Raspberry Pi's 7" DSI display, and OLDI
> output with an oscilloscope (I don't have a suitable OLDI panel).
> 
>   Tomi
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

The series is tested on TI's AM62P[1] SoC and tested HDMI display and
audio output with BeagleY-AI(AM67A SoC[2]).

Display panels used:
--------------------

DSI Panel: https://www.raspberrypi.com/products/raspberry-pi-touch-display/
OLDI Panel: https://www.ti.com/tool/SK-LCD1
HDMI Panel: https://www.viewsonic.com/in/products/lcd/VA1655-3

Test branch: 
https://github.com/jainswamil/linux-next/tree/AM62P_J722S_BEAGLEY_AI_DSS_V1_TEST

Got some DT check warnings with the above test branch[3].

Links
[1]: https://www.ti.com/product/AM62P
[2]: https://www.ti.com/product/AM67A
[3]: https://gist.github.com/jainswamil/945a9859c0f75b41ef21abeede405b2e

Tested-by: Swamil Jain <s-jain1@ti.com>

> Andrew Davis (1):
>        arm64: dts: ti: beagley-ai: Enable HDMI display and audio
> 
> Jayesh Choudhary (1):
>        arm64: dts: ti: k3-am62p-j722s-common-main: Add support for DSS
> 
> Swamil Jain (1):
>        drm/tidss: Add support for AM62P display subsystem
> 
> Tomi Valkeinen (12):
>        dt-bindings: display: ti: Move ti,am62l-dss binding to a new binding file
>        dt-bindings: display: ti,am65x-dss: Simplify binding
>        dt-bindings: mfd: syscon: Add ti,am625-dss-dpi0-clk-ctrl compatible
>        dt-bindings: display: ti,am625-oldi: Add optional power-domain for OLDI
>        dt-bindings: display: ti,am65x-dss: Add AM62P DSS
>        drm/tidss: Remove extra pm_runtime_mark_last_busy
>        drm/tidss: oldi: Remove define for unused register OLDI_LB_CTRL
>        drm/tidss: Add mechanism to detect DPI output
>        drm/tidss: Add external data and sync signal edge configuration
>        drm/tidss: Add support for DPIENABLE bit
>        drm/tidss: oldi: Fix OLDI signal polarities
>        drm/tidss: oldi: Convert OLDI to an aux driver
> 
>   .../bindings/display/ti/ti,am625-oldi.yaml         |   4 +
>   .../bindings/display/ti/ti,am62l-dss.yaml          | 136 ++++++
>   .../bindings/display/ti/ti,am65x-dss.yaml          | 176 +++----
>   Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +
>   MAINTAINERS                                        |   1 +
>   .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    | 112 +++++
>   arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  16 +
>   arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts     | 197 ++++++++
>   arch/arm64/boot/dts/ti/k3-j722s.dtsi               |  16 +
>   drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
>   drivers/gpu/drm/tidss/tidss_crtc.h                 |   4 +-
>   drivers/gpu/drm/tidss/tidss_dispc.c                |  46 +-
>   drivers/gpu/drm/tidss/tidss_dispc.h                |   5 +-
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h           |   5 +
>   drivers/gpu/drm/tidss/tidss_drv.c                  |  54 ++-
>   drivers/gpu/drm/tidss/tidss_drv.h                  |   5 +-
>   drivers/gpu/drm/tidss/tidss_kms.c                  |  55 ++-
>   drivers/gpu/drm/tidss/tidss_oldi.c                 | 531 +++++++++++++++------
>   drivers/gpu/drm/tidss/tidss_oldi.h                 |   8 +-
>   19 files changed, 1095 insertions(+), 288 deletions(-)
> ---
> base-commit: 3131ff5a117498bb4b9db3a238bb311cbf8383ce
> change-id: 20260420-beagley-ai-display-d7f634cde5f4
> prerequisite-message-id: <20260415110409.2577633-1-s-jain1@ti.com>
> prerequisite-patch-id: 654d90f9cddec8b41e6fb1b3776a632606fef88c
> 
> Best regards,

