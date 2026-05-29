Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D903ECD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458B9112197;
	Fri, 29 May 2026 15:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JTO/Ae5L";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA94911218B
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/h+ya0SKVRa0XBPQxpcS9UQ0tdg7Rx7uPBgdFqaViQRYeOI07BkzO9v4sAnLThH2kDnLh6Iw0JQHYfjP5I8GAN2QpiCqUIDPGl3FqW1S03czys4Ns0I7MyBjC+JJys2N0qDKahYtFY1nggrz/kb6aqdMq+YaS+M6Etiym0DKD2HNVmneeey82paank57Q/ES539pv41aV/aZ97MDxaNFO3MqIdJTTH0hxPv21vSq782ZzCzmDAI+Y6/9URksWINnXC2CPtPB7mfAcpe3f07S03xsyIkd5HYAlMy/svBlTUI7ptr5ungunY5+j8biBMYm6E8ym8HNReJvAxBk0BWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8B7fsGaRMlcMnFyTABzOXe4W2xFt4+gZgVhtUjR6zo=;
 b=dVRUV9iqC+Nl6GAiPjwbQyRuSCE+uCi9diz0KBQgfyLuv08hZZNmx2nEMVbW4P9r+Um68zd/a7so07d5/Xo3P0jaHGQ8VarjR6P4OYxsXRBEqsm5sZZa5K0a7RDAs46q9TzfsPghkXQqmIeCx69oaR2kF3PrwuvvgORbMbfYmVpJxVzL1Ip2UlrFVCNTNc3kFKCvC8GaCyRgeCE3L1sRMlqj/j48QOk6OziYnV8M3VRrcSKn9wBsG+j7OtfcXIKj8FK/1BFX3BeANcpplXl3x68a4jeIgZM/cR6hCwe99IIJTby8XIFHIUQlh2F7nnUdPP0K9PmuFky60ShAAPyiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8B7fsGaRMlcMnFyTABzOXe4W2xFt4+gZgVhtUjR6zo=;
 b=JTO/Ae5LZR/CwiCj5lVXbRhMm6aldWX0gmQHBwTzZ6NcD84AoKlczCEGOIMbxjGoUlLopqb2OaOq3nrJqme6w3srUVhHF3521TzJEQSyf6EUsBKShr8MMyjp3IVnsKTz6LcM5uPgOfx5SG3kUoYpEuPd6sYZYANsdygS973TluA=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 15:53:56 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:610:33:cafe::f) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 15:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 15:53:54 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 10:53:45 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 10:53:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 29 May 2026 10:53:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64TFrjCS265972;
 Fri, 29 May 2026 10:53:45 -0500
Date: Fri, 29 May 2026 10:53:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Vitor Soares <ivitro@gmail.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, "David
 Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares
 <vitor.soares@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 06/11] arm64: dts: ti: k3-am62-verdin: Add Toradex
 Capacitive Touch Display 7" DSI
Message-ID: <20260529155345.z6ht5adzhwafdvx5@voting>
References: <20260522161105.277519-13-ivitro@gmail.com>
 <20260522161105.277519-19-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522161105.277519-19-ivitro@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|BN0PR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ebe46e-ced2-4757-e8b4-08debd9a7ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: FBPmoow77uluJmSFIJdfIFTwWwxqhgZx7sNUSVjS3RKufJLKdxVcgJKtlHdYTIxEKjSlyte3lghjuNev2j8bxht3+1bgc7gG2h3eEx/bSHvILxspNqClkr5o70p1AW4H64acFQyJ2Jv8WXTAKOIddfzfvFemgTmlnev2JViOqyO2u7Jpc2sxkdTNQAxgYXAfujHLXvMspBq81YmvFWlJ7Y3H9tQO8CQQ5vBUc3d/UoU2RHsYwDY4ad6yJi58Lc33SHkVukOOrrD2ah8RKjXOLYfn6b4BujJBdG6XZbPxTHn61LhWfUPgXpNnrH8C8xCM014H0zBafBEvFB193h4M61YkPftRnjKOjddkdS2CHNupZeEXBRIAvg1vJX/d+RCpQmJU0gaLhAnKG73QE07+b6RbxGggKQGh2kFiZrpeXVtl9cpidOjJhRwpgosc/cokDy/CPNUtr5Pcp8DdG4sevDenmXu82pOo8Zs8cTZ/qmRtqtrplpr4lOmnHC4ewyKA9LuFp+8ah6kBn0VbD1vq7jzjfYa0sJf0zvU6SG5lUCt3h5z3CfxguaZMvkW9Lq5Hxz9wdlSm4DCJzFc7zahCiCFb0Pnnj7wkDud5lNle4BbKT7Nft1bTSpGvYqW+pgXHaTZEU0bXeL59td2Y6GyeFLdsCAoBhK1iV23GHd+xDHfO7kh6aOU1eVytt6rrqsxY
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LXvcqpIauV6XrtxyhBIsve/p0uX//ZKC2CJvFDYnFuxeo1c/6pvQ/UTj0FLmMqzcG0tryETTy/ufVj8o0kGXenuKY3W7zD1cvo3ilBYBMW7DqO8Ki+W3zUdNF5CYj8BQyZAljq2Bjwe2rli5J0v9tirJtsVW7zDvMx6f+e+DM8oF37tVkOhKLQVbT6vdJWXnc5v4ofPD4w1g6YStwdiGJRXiVlv9VWpjCo9clhIF6r+CtB8s7XsCnTfPkgIx+jvLKIaIoz2L89oiSaSng82II52PpF6UP24GvNex4myZGsTXeBAwQXVeteZGIQcCfR4Q78TD8fSP5MkfwL1Vf9l20FwoDoEhjqmIgl2fdgZICAnoCW9W8n+qYGPj8GTVGrRSgLcFQeVf6o7rt3byG+qxrY1AujM5NXmZuamcLKNce/91iYxQS2MCZ7YoWAUssqyt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:53:54.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ebe46e-ced2-4757-e8b4-08debd9a7ca6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
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

On 17:11-20260522, Vitor Soares wrote:
> +	touchscreen@41 {
> +		compatible = "ilitek,ili2132";
> +		reg = <0x41>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_dsi1_int>, <&pinctrl_i2s_2_bclk_gpio>;
> +		/* Verdin GPIO_9_DSI (SODIMM 17) - TOUCH_INT# */
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <49 IRQ_TYPE_EDGE_RISING>;

https://lore.kernel.org/r/20260521152550.A928B1F000E9@smtp.kernel.org
https://lore.kernel.org/r/20260522140245.472651F000E9@smtp.kernel.org
Sashiko comment would probably be good to explain - I see the same in
v3.

> +		/* Verdin I2S_2_BCLK (SODIMM 42) - TOUCH_RESET# */
> +		reset-gpios = <&main_gpio0 35 GPIO_ACTIVE_LOW>;
> +	};
> +};
> -- 
> 2.54.0
> 
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
