Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56C9103A9A0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD2010E0F6;
	Thu, 26 Mar 2026 07:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="arEfJ4A4";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE3410E0F6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFze841bq17Gvh/9rWw30NySHUASUKMqWmHyjtE35lkfB0GTSUdM2gyzI4SQ/k07CF8E0fS8WYl6QJLPx5g+maWoUjzLvyxLq/W34NUj61gzhwOR/RH8VxTQsksva+D/HUlFCPXRlvUgqViZOcpB4xXMR6gn2PgrNlgA303UwqEMUMPvbNPhDk5fn/RrzgsPUtR71VyDfzuW4wijbRTYZfEjfgS+g8+emIyrADNzLYAUaieexmbS11Vl26sn9rCcqzJ4JMvBC/6byyAcmlobUGlUXoQXRErlDIDk59AUfOJBX0EjEu5Df8dBx77oQxb24SkH+uC5cJ+6WBSokUatKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVXaI3HiTjzEvhrEKk6v1jpsapmGXt4rpfd+d0nABMs=;
 b=XtPX4zdMfaYoLnPDWo1+lGwi63tfP9v0LxIWXJzbzwq9YaO6zAJNT83w5N08DVZC/UoA2H1RltDRdAEuJXUx0P/QmkN8W9pAxP6zqizYLT1nbTqMNHg5NvpYCAF6jM5ftTCOsXBpIDOiAAOLRvvR3utv8Jnof4nCduJBcjoNxMFdn5gvOag5h+AWlggQPH5LZjmccyBLlt7ZcJjYv623fKN1rdWgiL4M/mwgek8RJ6Fd+TkBx7YgNru0//p6Kgs3wpzQhF4hjitMyG9uU0Zw8S5ueJ4M3+ZQLNoS5xE4yl1Jkzdvh9aPM2zNsmukTj9jWRMbR8uVPv6uoxKN5WB04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVXaI3HiTjzEvhrEKk6v1jpsapmGXt4rpfd+d0nABMs=;
 b=arEfJ4A4lw4bbHZ56RwqvZ2CDqNVYmiLCxaZBvX6U5DYpznRMNcsKknWNWzoq7Egt6qghcb2FjHs65eCrK/MEFvctIvuBJRErfKj/ghG5W3WQ6v4X5lgndguGA2dZhffICUZ8+EKFeu7KFOqkbIl4SxDnYVph9gQb6k5WVBEOCsiMD58lo+cINNghSPNesTa2bj/dD3RUfOK4gXBczJXjxdmIlZ71GvHWjl1x9dNGhZ85NPXHe02O5yDVsuhh7rNjlOe+YsBoknAlAmtvjeoXdrBSrkZKk9SQDr7/tYEaPQUIcBoVGGJS7LJjeXHeeKNRkbJyrOF2RrCGM/enEXV3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 07:24:05 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:24:05 +0000
Message-ID: <050c6532-8122-4ded-9946-3ce1a86d2be0@nxp.com>
Date: Thu, 26 Mar 2026 15:25:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/bridge: dw-hdmi: document the output_port field
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-4-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-4-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: 587ca543-d644-4070-f605-08de8b08a907
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 87da/4fE4I+5C6C+2ZGdsvznVrCFcp5Ipkwr057gk1Bo8q+9Dg+q/ivlwwcRsfROotp/2kporg8GM4AalsqU9Tser6IGvir3nAZjUIifQS2NPy+P4Zbh58Oqr3XqC0muITOE70a+PIRNC7VNXk7GMGVjCng7dBypC140nJle6mj0GsGXkr8GmRCwYcEBof3q1oJVYGyhJoAxQPk5RTOukkCSTC1aU36UqRHiGQnVb//lT057XHaEsyLnWWevTfVoQfloMCKTooRrsD2q2nKMQ6HA/NkEAvT7KWYWX5/GAWoXUMduJmT4PrTqrHYAM2AKq7TGHAaVhzLmecpoWp4nYeamStDubb7+B69Rl1aLhCEpXl6SA3PwOuX+oiehZsT6MegmYhQm0mF9yJVPvg58BCfNndgMtKBH+fAxLK+TOcedPLIOzsZd9s5XqQlc2Sb/8NvjRX/oYRe2zGwIkvy54aj7CSvfHPneaaEjsxCLdezy/czzV9zHylTMBKC7X8QfO7EMJbtd1ASZGHDn4tRSi5VsOeq1uW4OmtWc4PgMzM4iAURYv+9XAe2rc/I0xoYFeaZ5hstd4qZfM7uSWqZ8ir77Ml5Mr7Cy4XCS7soGYKTYxWDCrSMU3jTyy5xEMbUrazCE/oWXCAI1yVrVJzP/cgG6udDsUO3tHGo55czuPXQBDjoWK3CbT/YBjv2P8mo7Bq+BlfFqnrvhHwnzknzezL2M8GczqXhnECJEV+/EBQORqkW5Z40ANv08zwoIVe9iXkDyO5VsAAtvVna8ZEMXQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1V6M3EzNDNKUkhlZ3V0ZEtaV1dQWFpQQzdRTGE5MnJOUHNTSWltTjltYlgy?=
 =?utf-8?B?VENhZC9PdzVRZWovS0JEM1pma3FHTGs4WmY0dkk3QW1FZEVqa0IzRlQxMnBE?=
 =?utf-8?B?VUhQVmwweWRUOC9sWW1uZ3oyaWRWRG1Lc1dIQ2svK2xhcE9oN2l0c1VtRmFl?=
 =?utf-8?B?TzNPblJvQjQ5YnA0WkhkY1liS1VJWnRLbFEwaE1Eakp5QVRqTHZjaS9TUzdQ?=
 =?utf-8?B?ekt0VmFjYTl5QVh6ek9zYnE1QUlrR1VkbVhJYVJhUlBFcFltb003d1FnSFJq?=
 =?utf-8?B?RWpRRGFyRW8yc0drU2VwaVZ5WGF2TjdTRTlEaWVQcGRHQ1BDem9aSkplS0x4?=
 =?utf-8?B?VVpKOHNSNzM2WGtCS3dXR2kxOXlOSHlUTiswYlpiajdhSUVTaDNIVUJwYUl3?=
 =?utf-8?B?UnZHRWpzd04vbEl3a29VbGdJMFNJUHFlS29KaWYrMzJ0S25SSWZuMnlsNkxR?=
 =?utf-8?B?c2M1cktUZm1oMGZsMERHOFViNnYvTnFSYkFCejZKWDE0SUR2NHZoMXhzcGp6?=
 =?utf-8?B?SnBBRGxPZHFCRDN3Rk9HYmdOZHFVM3dvTk1jNEJJcDJyWmlBK0EreHFpU1NO?=
 =?utf-8?B?cUhma0RxUncvWlQ3RHdrdDMwempsUnhDc0N6cmZ4czNnWEFiWEIyRXRNS1dB?=
 =?utf-8?B?UnpsMzQxU0NwbnZpMmU3NFl3bWVaYmM1UE1TaWs3Z0J6N2dldTEveXl6MWRD?=
 =?utf-8?B?U1ZYRDYyamFkczJINWJRbjAyWThBeGJJc3kzK00xcDdmc05jTEVCZ0hSVFUy?=
 =?utf-8?B?c2RZMWlTa3dZYkFJRjE4YklVbWc1bVZKNnhCWUxzNlBLL0gxSnVPdWgyR1Zq?=
 =?utf-8?B?aWpJdFg3MDNmRGpTTUdXZkRHdDQ5SDZVVzdsZDV1S3lYYkszVEFtR3diWnMy?=
 =?utf-8?B?YUdoSlBzeVNKZnI1N3lsY01zMi9waTRlbGo1Qkx1NW9PMytkS3FxMitXd1JD?=
 =?utf-8?B?dTZHSkNvRFl5R3dudmpyNk1lSk9ObXFPc3d6SCtQR25YR2MrTFZJUWJLMURX?=
 =?utf-8?B?S1ZjMHBCVWtTaitwcmJ5d1h0Nm5hamJNNFRBVmxRMnUxL0w2K2loRlVBd3Yr?=
 =?utf-8?B?d2xsNHZXeWt2eXRhT1pocTZHWlpFUUlzTlJFUU1FeGhQZkRzc3N4dzRPZHUz?=
 =?utf-8?B?K1gzZlRCS1N3OEpYaUNVZGEvYUxCOHZ3eUIvU0xDdExGT0xLak9QNHVZOEpF?=
 =?utf-8?B?N1FQcGttc0FWTlBBWWNSa3dvMGlwajRsdkJlRDc2ai92V3p0MStwMk9SenB6?=
 =?utf-8?B?eUcyRHUyckFoZ2pOeDBGVmI5MkNtL0VJR09lODRJSEhTNUhrSEJmYmx5L3dx?=
 =?utf-8?B?Q051bzJWL3ZGSyt4M1E1M25pTkxXcHZ2Rm1hemU1ZjlSNVpWcVNOZVFkMDc3?=
 =?utf-8?B?UlgrQWdadjY0blVGY0hyQnUrczhHWmFsT0FYMEdtYnVBQ3dOaFVqbVgyQ3JH?=
 =?utf-8?B?UnBCeDZrZFEyWmhkaWJZRENDZmJJNzIzak1IN1A3N2lwbEZVb3FQYkFuMHlB?=
 =?utf-8?B?NUhhajhWeUU2dEdLTUkyVmZWZnRrcm80cjJrOHUyN0l2bmtmckhCbldRbzdU?=
 =?utf-8?B?NlhoT1ZEcVJZKzRJZ0NHWmhuelMxY1hUcGg5VXN0K0VmaDFiMWNGUWZXRjFq?=
 =?utf-8?B?S29WV2k0Q1RUY0I5YVlnZXV2cTRxYTdEQ3lRaU1PelNQM3ZDWEVPYVowMm5r?=
 =?utf-8?B?SW55dk5JNXVmMy9EWm1XYWNOK3RlU0Zxc1FYb0ZFLzZRUjVoL2NqdG5QcHAw?=
 =?utf-8?B?VUVMTm1kR1hWTHpvODBiZGNPajNOWmo3a08xZ3l0VUl0R01QaG4zU2oyWkdw?=
 =?utf-8?B?azVKVmYzYzdVcUE3TlliaUpuWEQ2dUkrTW9CN0ErVW1OWnpENis4UHlPMjk4?=
 =?utf-8?B?SGFid09LK1FHc0hlTGt3Qll2cC9QTS9MM2pLNTBkRlV6Njl1NTR4bnROSVM4?=
 =?utf-8?B?SXZmdmVoSmd1YllvNEttMlltaEUrcGVNTTJ3cUpNWUdwNTlQdDdjUEsvU2xu?=
 =?utf-8?B?aEFuOG5xeUczZnFZSUdYdFZEVWNrRXBTUVRwYmRYWHlNV1NIeWpDL2lqNGQv?=
 =?utf-8?B?TCt6cGt6cldaZVpRSGp6VGFtUmNmVDZFTmhtT2JJeVk5aVk2NWkyWUwwNVFG?=
 =?utf-8?B?OHVVdUI5SlpPNGlnekgxSmo4bU8yZTRoYUFIUjlJclRLc1dkcHg1OFZUeG1x?=
 =?utf-8?B?OGJUY09kSHoxN0FJbGZGVStYMUxGWEtQYWVUUE4vRWVkaFl2NElXYkRDbE1G?=
 =?utf-8?B?K09tZWNlN2U3V2pxMkJzRW4zajdvZnZyOElxZFZLQVdUUk0wVGlNN0JhRnl6?=
 =?utf-8?B?YytVUC9jb2JNOWVoajByT2szSXNEVi93UEorWVFGV08zemtyWExDdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ca543-d644-4070-f605-08de8b08a907
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:24:05.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtmNJIkx5ZevY+SQced/VJYyIhGa8JejzFiN1vYcrOIW0yLayYWAAhimhcfCw3fSme5A0xVfp8Xjo3pLTXH9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311
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

Hi Luca,

On Fri, Mar 20, 2026 at 11:46:15AM +0100, Luca Ceresoli wrote:
> The meaning of this flag may not be obvious at first sight.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  include/drm/bridge/dw_hdmi.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 336f062e1f9d..45f6ba1a8ee1 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -126,6 +126,11 @@ struct dw_hdmi_phy_ops {
>  struct dw_hdmi_plat_data {
>  	struct regmap *regm;
>  
> +	/*
> +	 * The HDMI output port number (which must be 1) if it is described

I'd rephrase:
The HDMI output port number must be 1 ...

> +	 * in the device tree. 0 if the device tree does not describe the
> +	 * next component (legacy mode).

Maybe be a bit more specific about "legacy mode":
legacy mode without DRM_BRIDGE_ATTACH_NO_CONNECTOR flag when attaching bridge
?

Reviewed-by: Liu Ying <victor.liu@nxp.com>

> +	 */
>  	unsigned int output_port;
>  
>  	unsigned long input_bus_encoding;
> 

-- 
Regards,
Liu Ying
