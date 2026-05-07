Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E4CCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 20:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B471A10F26A;
	Thu,  7 May 2026 20:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gN6AoL2R";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EFB10F26A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 20:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH8cCMMf/Sn/+k/8qQj08dCoSTaCtLPzTo1OrhS2RUK/1FqhBgbNiI3gBNjRjopiKixHf6a3VK5uFyVCvX2x11M/2tMMLOKvm4EFwb6lH5HytXPTu3sJsQ74dPYdeHo8hitjVYAsY1xzvbSyikZgsJ/ss3YA/v2WRCY0Aqp5TSgmsVH4gyyt0BoGJFsbwWamoxEX/nviMdkhzWp4uuycW+l1J1O+7OsxL3lerlww0T8GKGugIgGNSE6IvF6eFrQbASFTlNFrD/uRQtmFIuOc4sNrOEZL0tMuuN8m+U1j+cHNWlncFqJVOpwegEEk1h4AwWAhmOsF2ijgRQ18Oi/27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuj7iVrmL7pkOffMjXOZSJ9c4Kq/DgDh0bQAh02myzo=;
 b=Ioja3KSA6kvrQbLd7lG1Em9T1/uf9G9/NTkcH4kvlix4VBUnmGoU5PGZ7xHklYaY8kzixFs6cuKOBaOsUM5+aTweJQy01tKyDPe5mVMEnxSh7u9yaBL0N0SgkZne43iSpG3Bfo16DVBk2d9SP9zwjrvZJ3x+70+bnsPB3g6I60jbpBx5IBrJsF52koef9SNWY9D8w8afnLwRS2vs4ia2ftwrtZdDM61GbjqKqe09KkFZcMBRoYrMyHITRlNxUizC3q9Uxf+jV1CSN5Xg/C/4tkhcDDTTUS0cIDAdYmVyEw1Izizi6CkvWDcea7t+yHzR0Z24MC/11hno7QJkztrEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuj7iVrmL7pkOffMjXOZSJ9c4Kq/DgDh0bQAh02myzo=;
 b=gN6AoL2RgFjLVXBHjN7vJhxOUrfztG7EeMMbMBi1o3CiDoidzPvu7RoRQCapKoJAFlNv944+7XFSKjkFQYN9zQ/JATkp5LJ0OgFZuQk2j3ylIZjffNUWJQYkhj2D8K0MMLhmgRO/sYPSqzNcKrSzAK42D0lf6kUAMkUEaYi7qTM=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by SA3PR10MB6999.namprd10.prod.outlook.com (2603:10b6:806:318::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 20:38:36 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::42) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 20:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 20:38:35 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 15:38:34 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 15:38:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 15:38:34 -0500
Received: from [128.247.81.183] (ltpf5gwk6l.dhcp.ti.com [128.247.81.183])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647KcY854100890;
 Thu, 7 May 2026 15:38:34 -0500
Message-ID: <455a8f0b-9886-45a1-9ce3-f8b7229b66a6@ti.com>
Date: Thu, 7 May 2026 15:38:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio
 Helper
To: "ple@baylibre.com" <ple@baylibre.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>
CC: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, "rfoss@kernel.org"
 <rfoss@kernel.org>, "Laurent.pinchart@ideasonboard.com"
 <Laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "Thakkar, Devarsh"
 <devarsht@ti.com>, "Jain, Swamil" <s-jain1@ti.com>, "SAHU, JEEVAN KUMAR"
 <j-sahu@ti.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
References: <20260318154636.3230454-1-sen@ti.com>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <20260318154636.3230454-1-sen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA3PR10MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: a508dc0d-d6f0-43a4-f708-08deac789c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /61ZfihH2TLD6K6OY1Q6KvqHVwEsaIuv4anoypMeaJV8AqleScomFf/9hZzVsG1Sl+76mGIa/OJf/OFsQfUWRp751CtK2I2ZTVtt/rTIOVAT5Thkp1gvTc49RInPJ3z3vYmNi0dZjgST2kXrmjVQvYmwOM9ROc8jgD5ZorxizuuvItBIktAB8qHgCvXujxh6kw5/NzDET0c5JYZB/gh0mpINZO4z984cMFITBwLReY/Ggck78Ps3iISyofPQXUudj7y8P1qwAXgeXsS7UErTKPAwWugoOsCTNRBWWxedK+Wqu21g+hGrXxEwD+BkShkP46bVBYh6i1iwUaev4nks59+dvfR8UXpHzcUXRFkzbMran+6+KNnWkSTywbcsH76VB27ya5QYViGqr5LwE7v/dIwNIkvMayVzTAYztNawsUXDAwxr96WOrHo+XVG28J9ja8caxfuacekWc/+cu4BxYG31YEQJ46kxhSRqQ3Qeq1K8vIpLayhy50aR5Hx535R/Q/Dc/m/1fD4kmAk8rRRgdtfATp+BgRPkINyW0StyNbs1QQyXvk3RUIJQkrIq//SLoFEMqJgzOc4Ts6vAs3Oi5MwVvlZWEtF6lnaoABhz7IoPn8cT+D+Lp3U1+WRCvSkxvHhO6u4r3p0o96WSYnYaNCtfKposYfasRjztNjYM6/rkXF5e3GdOA6dw76QPiZnpA1Q96xAje6KEzWUfTwaxo8dhlN1vb6rGOoOOb/yirME=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D6baHty9XcDgJFpttWnAUDt1e+tUnm3oS159RmBwF01VoxDje7JL3L1tcw9O+S8jkiIBl6KjVsw1AD4KqWEXEBngbuWI5zNLfyRbZlYAUHqx4doO6oZgvRAtJEmDqHCqXnbQOgYVNyC0aDSaUI/ZIoFy+fZd/OVYYoMBXZerd9ZyJiyK6yUPdTlMMd8AMMjr/nB1DFBWkHASOIiDfZIAWQIinkJl8FDvf6YyR7s6FDFAdEPWV+Zjh7Csvkv+vpo4D0PFZTtLAWaHRrzuIJMaXXsWYckMmFgnaLfjFVI4COcJibXxdxSflT4jINw2t3ZA3lE9HpLumeKtfH99H4VAK66War0/zjVaJxNtsNR6rRjfDFNh/JJ9L8qkwPbjcSU0Nnkh/sxeVsvolzqEenKSVR5XVTJk+7pEFYB++9j/TU7bTKNgSS8KFiK6RUQeZyhi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:38:35.5643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a508dc0d-d6f0-43a4-f708-08deac789c9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6999
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

On 3/18/2026 10:46 AM, Wang, Sen wrote:
> Convert the IT66121 HDMI bridge driver from manually registering an
> hdmi-codec platform device to using the DRM HDMI Audio Helper framework
> via DRM_BRIDGE_OP_HDMI_AUDIO instead.
> 
> The previous implementation manually allocated hdmi_codec_pdata,
> registered the platform device, and implemented hdmi_codec_ops callbacks
> including get_eld. The new approach sets DRM_BRIDGE_OP_HDMI_AUDIO on the
> bridge, letting the framework handle the codec registration. This also
> resolves some non-compliance issues with the current audio implementation,
> such as HDMI audio advertising a non-functional capture stream to userspace.
> 
> The audio callbacks are converted from hdmi_codec_ops signatures to
> drm_bridge_funcs hdmi_audio callbacks:
>    - it66121_audio_hw_params   -> it66121_hdmi_audio_prepare
>    - it66121_audio_startup     -> it66121_hdmi_audio_startup
>    - it66121_audio_shutdown    -> it66121_hdmi_audio_shutdown
>    - it66121_audio_mute        -> it66121_hdmi_audio_mute_stream
> 
> The it66121_audio_get_eld, it66121_audio_codec_ops, and
> it66121_audio_codec_init functions are removed as the framework handles
> these responsibilities.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sen Wang <sen@ti.com>
Hi folks,

Is it possible If I can get some feedback or reviews for this patch?

Best,
Sen Wang
