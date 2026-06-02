Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9064CD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3DC10F25B;
	Tue,  2 Jun 2026 14:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eUA1Apos";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B3110F25B;
 Tue,  2 Jun 2026 14:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAjC7cViLDG/A+FtzEsWD40JzJhWGHc24dS8Nfaez/jCMKtoN7Vo+Fiqn4tmuhHV+hUAEWv6z2C8gog/8uBoujgU8xnw7VSZv7sXf9UY3e8FmuLJdenO9mRgjlPEFHlrd6ukfsaCH6QL5yVzoZs6RVCNnjFUw5BYxp5thd374zmNDjZ5RP9VGHbI84DvcqEbFma80NBluH4BtDRRWNvaDDcyPAFSZE8+uw/0InWtwzfLawNW9m1AKWkWNC1FzELiIqfXGOYXkE5lm0pwJ79dMYDf1HXQOUKX9GaLlnHrFUNfBgEPBFeyQfWAZaQ5DshBCumvkPsZkpCkEMx9OmNhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DFoeL/DBkSdNltDI2+oyIzqYORaDpNnOZX+SZizLn0=;
 b=VI0FGGtZwdSN6Kogp6RRIOi7G/aMwOVvOxWZO5dBoI9mwUT3+Rf1tyyS7iEBnzo43q7BH2doEMOPsa7RiZ/QelWC192paHuVb0U/dnqnRU+xePK//9x3W/BSpU8stNl62FImUlCJdOoH1eo329BRBy5KujjcNZH86U84EFhX+KLtTozPF+lFNCCEKCLmSjVIbyIZURfYAKjYco7/QU6VDZyin88v1NwcR1yWyCcYSfdIJ6BqiZts4PwXlDiPamJesGw1G6tiD0unb0py3GVvcUClPkNj1hoJ1Uu22y/upCberkjKOGE7/sis5DjfESQIk7i8VE7JjxMXsMfKPyYF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DFoeL/DBkSdNltDI2+oyIzqYORaDpNnOZX+SZizLn0=;
 b=eUA1AposxWT75qtkT6GUYvdB+9Ir3YCiWqk2qPr7TMy/FsxkiHdB48k8+dsi3J2popcWyNJOk5vaq46g1BgKzgvtEYqt+Xu3npQcB9VfBRiOlThzGtE7XeFUscikNqL2Hb2yqFbHBVo48AResFP0SGvw9t/WtfnGizvzYALXTSCPsomOaQUhhLJUe3yaDLQJ1rJLfZihUe1+UEhbmLK7LSPVNxtWXpjmmbPmHDxSOPN5N85lqPdj8WzEEAo2C2xK2VgbA1kRDOwRuUXLoQd8p0qbv6fi8yAi0iDZCkhYKlyo56CFr6FV28ccjXryDSB68kFS4qRI/+j2CWqp791DwQ==
Received: from DU2PR04CA0246.eurprd04.prod.outlook.com (2603:10a6:10:28e::11)
 by AMBPR10MB9320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:29:38 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::5c) by DU2PR04CA0246.outlook.office365.com
 (2603:10a6:10:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 14:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 14:29:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 16:33:46 +0200
Received: from [10.48.87.71] (10.48.87.71) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 16:29:33 +0200
Message-ID: <14358d35-2ce1-4d7d-8bc6-e40da4d9b75f@foss.st.com>
Date: Tue, 2 Jun 2026 16:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH] dt-bindings: Consolidate "sram" property
 definition
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-spi@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
 <dmaengine@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-media@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>, "Liu
 Ying" <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad
 Dybcio <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Marijn
 Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>, Nas
 Chung <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
 "Mauro Carvalho Chehab" <mchehab@kernel.org>, Mirela Rabulea
 <mirela.rabulea@nxp.com>, Detlev Casanova <detlev.casanova@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Heiko Stuebner
 <heiko@sntech.de>, Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat
 <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Parvathi Pudi <parvathi@couthit.com>, "Mohan Reddy
 Putluru" <pmohan@couthit.com>, Bjorn Andersson <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Michal Simek <michal.simek@amd.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Linus
 Walleij" <linusw@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, "Felix
 Fietkau" <nbd@nbd.name>, "Andrew F. Davis" <afd@ti.com>, Hussain Khaja
 <basharath@couthit.com>, Suman Anna <s-anna@ti.com>, Ben Levinsky
 <ben.levinsky@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, Erwan Leray
 <erwan.leray@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20260511165942.2774868-1-robh@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.71]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AMBPR10MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cde00e-6949-49f5-f185-08dec0b3601e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|18002099003|3023799007|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: WoiZQnXY9lhhRT/z5Y5Rj899Io6tIuOZN55x3x58LjDRWY5RlNk9AQa4IA7TQ3NNzyyqW9LngKLlE+LfMfTR0dRgMVizKHQ67jyGzVEcx1nK+HmDoUMgFal0lIpnGix/1zOLQG5Y8vcnY/IH0SQRqUYNJ7ebfq4dm+PhftmCxOZZAdzPOFF0GdcT6LdnuiDTNYoNenB7QbBDKtB197gnjxCIt7RbxZ/YTygbe1CURVoiPGdoc6uzGaV9GtRYNdWWyEhXnbhu4DEmlKpVxjYR4r+M4stbcGWUnMdog+DiyPsuYWvIKRf9gPkGVUzVnZvoffUKFrGLQrTFk+3xOogq+KxJUenHqYlUqjRQPVM3Bt7DD3+3ZCArV3uxqIz1WX1z6pGmUIdSqDIDt8SrHg8lwgxcwKko/GQWlrCdmDc0RZhTgXAMNRFxTbGi2QcLg8azQAjeRhrKy1fkncIz/cfRhsHUh+LyvJPUmc7raaI6pypyuw9lflSGzFMvk5DLYD+scxdW5Uvm2vPdFsameWpCLSK3hEC3mgzZWjlXtZs3mtrYwg59ey8PL51pn0R24iw5sJif1caCl82GdS8VVBKugGJYgbOTE8RBNrglBvUedmb9ueDS79yHFNNPLIwS++lnmo1DAlJgXLutRxnGGwkC+o/2PjcDyt6Xc//Iz2pANUTFtX/h6JzYhg4oHr1qDuvrfoEwxls8HoqElVmqXbDoUnL2666hSnS+XP1FYqU+tZY=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(18002099003)(3023799007)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jagGbSISWk6WVljYbqvzNZeMQmXF8wnwolT1poC4IPw+kZnaJWOAvae+By8ALFkwZX3ScvkRDexX+MC/qfuFMgZCeNiCBhpQNcNK5wR+JpMVswGDWFPorUXjO+JGL+08nUJuRwfjG+Od8WcO/J1GzR+70eGjwwmAQYajjOni8eY72yCWfs3LtMwQptyN+8b3YfsncxwDsZHV5F6M+6+Gavs1T6oCEacPSj3XuKq0QIu/zBvVpZSpaLUVOCeu3EYYGUV/vT9VAtzdiHSMUAhWJXzKRE26xqOT0WXe6QkuS/U+A8fSLo8e3jViDM/StnOJcbR4rNhh/tKgU3zmTiWbnhYcXE61cRDTKGsLGOKauXdsZ6JkozjOta7d+c0Wo/RJX4bxubydVeIG27LcE2Xe/yHiWw0YXCWaKo9/8iANXE7tJFn+kIM27xOO9u5cQx5e
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:29:37.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cde00e-6949-49f5-f185-08dec0b3601e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9320
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



On 5/11/26 18:59, Rob Herring (Arm) wrote:
> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
> 
> Signed-off-by: Rob Herring (Arm)<robh@kernel.org>
> ---
>   .../devicetree/bindings/spi/st,stm32-spi.yaml | 10 +++----

Acked-by: Amelie Delaunay <amelie.delaunay@foss.st.com> #st,stm32-spi.yaml
