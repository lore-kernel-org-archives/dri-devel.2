Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD64CD4846
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 02:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387F410E243;
	Tue, 12 May 2026 02:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="i0iMKBqD";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4346A10E0A7;
 Tue, 12 May 2026 02:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljwebpQxParQKqTnSQpkYNpkxpqzBB5zXyggCQTFWMv4uMvRe6D1XxBhLx70ve3r8kD9aoFZoL6I0MlkDFLJQKE9Cy3dfDA8M7Xo6Sz56ORYIPM7z3ia+QadO+2YputWg5efzXRSlHUjcfeRS7b9vFazNQ6JtbY9Nul44pSJKmxpu64DtAH7INiAyzcfR4jnZ5mfPUPxnMrxli/u+kNuqqJrBarIL2uumwrtY0h5YuvvI+jSa4TiLEIrViFCxQmTd01QTO21YscY+5D5QCvnoMsqSDXlJcO4d4MeoNRFSNwpBgTDpXwjq4s433dy/EV4jDi2h5YlxmgBzW9rBZxyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB9Z1XISuE5TmIN+wzSo7EmWgnYHriGeI4H1K/EhnJ8=;
 b=eEb4Pyamym4ocKFJxNlp3bNJka+3HQZcY4ESB4xB3No+GRxLkD+N/RXVZYqbC+Bu8hnKA8DHTndg55+kIEp0S5t2Ea0RIGsiPL6OGPkZyZWAy5K7sxdUkrahYpUXRizvvJyroSkwIqOsNCScZ1NCSonYsxLmH4F5T479bBPmgfuA5dQEtNrqvyGK8XxIHn0vXdv4VA53Ka+4euBWlUtnJ28ASKH5EaQ7DhRnSJBbNmC5BG+zm/MV9PTM30DvL9tCK1ovPHZ7J4p/XAw5E3jS260G3XPdaIiF0wAw5TO0x4b36EqDCBHzgBqY+FS5ziastbCfz8DYqXcFlzzJGjwtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB9Z1XISuE5TmIN+wzSo7EmWgnYHriGeI4H1K/EhnJ8=;
 b=i0iMKBqDCDZ5li+h2EM3uIkh8Vs0s6qHfX3sH+quHmuZ2MF3Pjn6F8nZ9fGXIj/qLn3L/zpACEWCXaG/D+r/2GE1o2SjFSQgTNSd9eDdcm39Vm9a3UoON4USBqwvhigEwpcA2p3KJCKkYTPVK9tmrVTBTHNo1RSESldpDA5aXWN5HP+vJht7ZjLnjgqKujb+zR/wOc/0au/Bk+m/KOpKwl4+/bkZaDRqWU3o9ZMZW+IMxG+0xcsyeY7NyERdSztDFXgrN8caj5mVJqstmkds59M4bFVtq6e912gx3QwodZqhDn0Zc8udedKuIEjSKsTnFgMiBdbm3rzdHV4kq77CVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAXPR04MB9023.eurprd04.prod.outlook.com (2603:10a6:102:212::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 02:56:49 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 02:56:48 +0000
Date: Tue, 12 May 2026 10:57:59 +0800
From: Liu Ying <victor.liu@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Vinod Koul <vkoul@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>,
 Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mirela Rabulea <mirela.rabulea@nxp.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Heiko Stuebner <heiko@sntech.de>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Parvathi Pudi <parvathi@couthit.com>,
 Mohan Reddy Putluru <pmohan@couthit.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Linus Walleij <linusw@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 "Andrew F. Davis" <afd@ti.com>,
 Hussain Khaja <basharath@couthit.com>, Suman Anna <s-anna@ti.com>,
 Ben Levinsky <ben.levinsky@amd.com>, Tanmay Shah <tanmay.shah@amd.com>,
 Erwan Leray <erwan.leray@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Roger Quadros <rogerq@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
Message-ID: <agKXN3Nmfqcdu8XZ@raspi>
References: <20260511165942.2774868-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
X-ClientProxiedBy: MA1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::19) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAXPR04MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: fae848d6-322c-4c53-1174-08deafd21c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|7416014|376014|366016|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: i65/kxoFCtN8uVYhAkDIwx6i4aXCDz8yhOgmByjJxx8iqrRME3ifmpANzfsXijKEiIUm93iNUbooyZssin+4SeeJAYuDYoHNp8ruFz2SBCC+KMoUElkoBkR6UDyBwZwmfapJkD6026qbu6bjDVNPoUXWZd2tydBt1SfyxgVTcnEZQnWhG5hBAyZa+iVwICsXD+zjLq1oykP9Crxxqc25rzvog56dpuz7q8k9cQ6R1xj5+WS2WUa1ZJWE7Yw4ij4wg9WMag5xnSn+zAo/S9SchXbGhQSEpakiv4KWDbCoWtNQhGhZQXKXkiICROP+jwNffAbV0TNfSj2JHW09rKbJAH36a5b7y16wwsxJF+funirRN1YoJZ1F9GSMePKANv70k8Nmsd1pT1CMMd3Os4RYvClPwda9QyR0dnmpdkaNGS4sPP0zTXLBPPrd5HnUqrIVIJjEpel38TqLyE95/vhpTLl1KFh0WQQ7b4tOEunpngSteTjLXeIOzM+JHhxJrmxUCXR+y/601lISVlZcJ1lNBDCXa+vwfPEKp2QW5M0zsrtyQZqHEB5d50FgDs9XqsTCoRjP/1RvujCL157ODD1q/Tj3VoGwBJ863Ph36AnDWmHqUfRq0I6XGqjdrN0487G9kfqCeqv2IaSAQec/9iYlpdonSzjhUynUNY/rc/Wp15mR+uf2WdRltdVWsKPuZvwh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FqDaVSi8/2cSWzMoof3hJoHqJ8Akda0YefkoOhWp5frsAFmOLN/C40sMnJ1c?=
 =?us-ascii?Q?iRk5nLOKLDBaPZYEAaFqZ+6WNUqZsaBxR4NDraO1BCL13cWwK3CZQIAsWZyu?=
 =?us-ascii?Q?gx/vMJhVG5q3pi/XbkAOY+9UFJMOyaH7ck9f0E4pAU2RScfXjUngpLHaqHap?=
 =?us-ascii?Q?mfTQI+/isiCTfp2qJmtHobLvkoxpmQ25+kfb0oGQZ5wdvTaS/p3siGV8g8Cw?=
 =?us-ascii?Q?J+U4t2kAEXaDQWApPS1GQq2kl9d6xyCo6qMOjGFvixGQ4+Xfdi+PwiCPbpbt?=
 =?us-ascii?Q?uLz/g7zW5rS+RpyWzcNsMQO60a/qL32LMz2IFNrSK2FWtcXGwzbgd66nO6PX?=
 =?us-ascii?Q?kcGq0gEPqfHFFjaVdYp++dOw7gx/T5BPA16WMZLQSrhCtImc6HpfiS4uFAev?=
 =?us-ascii?Q?HdYP4pzffXolHjv+oKfguMm7cgc+2XG1QbmenQFn+Q5hActpPxB8afbolm2r?=
 =?us-ascii?Q?KGdK/zEeC+jN55hWBmjCep5/jqHbBpa9PMVJfmer5h5MHkPgPL8DQ6euVCVL?=
 =?us-ascii?Q?DuXUcjGTdk8EqDpjVhPqfOVJ15kdGiFtwogjZBN5/nKUJ59k151g5JotW+pa?=
 =?us-ascii?Q?2239PqNfYRMr1ThNBvSMcEXJS5XLkMrYN+JnUOoiLjvsX/zcqpS0GkZIGYgz?=
 =?us-ascii?Q?JDuVEIo/pqlfJp5dSq1s0uHzUSjiwDoztbZQAAWG+GHEBR7NZa3TPwYnbXuD?=
 =?us-ascii?Q?Dw/8XqvBu61rm5GKNAcG/kPNbROngtBN6TUE0HbXv8vHpzQ/GMO3pkEytMZl?=
 =?us-ascii?Q?DmY8o9knZ0d9BzeB3POofqZY32JA2bMvcTI/VvmN0UWw5wXqCezM8OuIgAzs?=
 =?us-ascii?Q?tw2fpkJxrbVnyuGGuYDUZjFkkVXDyfQE0NhzHVcWj99B8UWDHNeg5FpEBJrr?=
 =?us-ascii?Q?9Hunv2nfXSxE8xfr0DgY6M2bPBLuwm1m8+jh/w7DhmSaLZUEQhJP42LvFGwt?=
 =?us-ascii?Q?1UQqFXXqFscKWpNUWsRbUWlpN9E4JTMiluYAXRlMRQsMkS2Fk/LjXfVYROCx?=
 =?us-ascii?Q?Cv+fRzAxs8G3tffVvK1hX13EDWG8ZDHVaMmQCaLBz2ueeHGo86FH4jGQRaQx?=
 =?us-ascii?Q?8jNVua1Waq4jMKmaMg9SnqyuXoUPGsoWX7CqCf4Vg2PysRl4zArreDgrBdCG?=
 =?us-ascii?Q?KvW7NNy/cVMgmscLC7qtKUa6IiFmUF8RvHIJbUn7ZCrRTlKKcU4nBoMCweIW?=
 =?us-ascii?Q?sgzJmAFy+/HAgN3zBR9u2zjvwCgtorj29wz3bAtxaUxOalaeNAQQPBRlgaLy?=
 =?us-ascii?Q?x+B7ZgYaCnJNK7r/9IjIu/yPPmMy1H6AXwNYd7JFy25PKH6Qa9nhHTQ15CXZ?=
 =?us-ascii?Q?FVlB9n4sVsSasOZVSJSTucLquHOtf6qaLFiyjrDt51JpZgCrYf2Hv2bvB26X?=
 =?us-ascii?Q?wuPSz0e+vK/Rbl0ohQJA+PBSiLSJXJGfylhNFM2VZPv75BzYrjeiNd+AHBR5?=
 =?us-ascii?Q?+GK1LY8YFRx9FGfPexkusYOxKTmOdG3lpFCHUUCzdXY4pxR40HEB5HfPY1/p?=
 =?us-ascii?Q?oNjT01A9vVCIpPuELU7Fv42bdXH7MmfNYRLTFaRCs65ezYS74qWIayTiXdti?=
 =?us-ascii?Q?UFElTtQjNfVl/TTDKkr7+i6HhH9eQ9gOnNprMJwB3jflijZSOYQiJfM4Gqyl?=
 =?us-ascii?Q?ot7ZZiUPK8dOaca8lg6Xs+2/O8uVEQCE9Ra/1r5vpVpRtu5ZE6w7YZ/c85Xo?=
 =?us-ascii?Q?dsqR51RTJ3xjzx1kEY7HTfMQCoH9AHgXcPwfeM7/ZBpmQpnNayr36b6CkNbX?=
 =?us-ascii?Q?54DsVfYq8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae848d6-322c-4c53-1174-08deafd21c4d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 02:56:48.8907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujWXCB0yCLO6GHxiUCgb/xLJDnkArGspbiq1fTy9hRS7tcGIMY11BXjON09xMtd+4uLGrsCR6DShxJtMKl1wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9023
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

On Mon, May 11, 2026 at 11:59:36AM -0500, Rob Herring (Arm) wrote:
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml |  2 +-

Reviewed-by: Liu Ying <victor.liu@nxp.com> #fsl,imx8qxp-dc-command-sequencer.yaml

-- 
Regards,
Liu Ying
