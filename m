Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E919CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 04:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0298810E030;
	Thu,  2 Apr 2026 04:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iJp5C9NU";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013036.outbound.protection.outlook.com
 [52.101.83.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB18010E030
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 04:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVF1kQEbjBN70rc1xbSATEEGsBPAw+yH3UiwyDM8dEKec9fS5lc0JmnlzbgglxmC9W8JzrJSqFkSjAgTB6PDLeKswZC+G8wtU/60UCcpsDh5rI0w6HPhB562pOc66rNYE9pggoNDt3HE7WR/dUd45gjjzbpYxZUZFn1c1LUfdujPQXCHLiDfwcfNcMJc/ZglAOZiWDB9bQr4Wo63xHKjx+XDq6TNHUiRe/vwtvFraJIsYw0hWph1DkAH1Fu886nDQyMUGT3IUQa8DvFkanvWuRex4d4eZFkq8R6zntLvV0+aPH9mBF6mBAadbuS+qhy3Mz/K2r0JaJG1dzZGi0O45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvsBRDDp3LyWkzHH+OIM45C3UVT78jLzPxpsGYby3xQ=;
 b=jRog0AL0DwW7elIT4aMOlDg7QM9nQtATXpWYh3lKq7XsLpxOfOlP9qXLCAtqDcKdgf7BscoqgpfHsjMXMnT0F4XKPnY2+EvHEnYuwXgnICrvpSPQpFppIk5vIp+ogTl4wbhUuGZf4R8SBEK3/RlFCwXcNn7mPOWIZKA4mQGaB7aLF/EZlj+OnxPHqmr+jdgNPm3nS4aMM/G/3FasBiFVO2LSP7JAuSo1QobeHy9tcjfMTIq85T4ICRUqsMDHKerzmH5HFWblvYfLxy3vu5EarDrnwkzjXLCQsfzWxEly31BjZDCCNxMGGmeHxjotPNInM8Qjv95MlDvSKJRjRU1G3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvsBRDDp3LyWkzHH+OIM45C3UVT78jLzPxpsGYby3xQ=;
 b=iJp5C9NUzgBS+3tinrv0aw2UlJi+1p4ZSQzlguzA5YIGKcxKdamrxiI+ZOXC36RNi/WyZGVmceKBLAgSR9u8pan27yjXlOSjMfkT8jFnmrfmRFX90nk7cE1ZyHRfIxTVLrUgdeCyUgzsp1CKnKGqYU6rltwDInddH0E2VflYy4nIxGyzcFFTTMvdt6v2BO1TMPzgHBuukdrBgWKwoDEq180OfgUj/idZT7viim0sqU2tHaIoIBL/H+/uPUyNoNz+SIsEJnjY9IaqOSoc6xA9kiYUPebyv8OwSsrRBf1yyRkBSre7ADQI0sHqWCYP2BXNdSV4rQ67QDDK+GlhXorFyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8994.eurprd04.prod.outlook.com (2603:10a6:20b:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 04:54:24 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 04:54:24 +0000
Message-ID: <1a8b1a34-89bd-436e-8b5c-64ea71e8f333@nxp.com>
Date: Thu, 2 Apr 2026 12:55:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
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
Cc: Damon Ding <damon.ding@rock-chips.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-10-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-10-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: bee08a06-bd1e-4bd8-2035-08de9073e91b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FQ4YcZxRBwisAxpFCS8KrAmo6gLVARvZWLgQqYKl+DYueAvCkrLFTDV2oIdi7wf4uB50S1k9FtmZEdGn1eDWTXLsa0do0nYgjN7dXWKD9+dCJGdCoXthcDdQNpSktSMkPPE3UmqDFjZmE43nTH+E3QV1j+AEt9wD07YZeFK4BiMUXaeffedlYxGgoxQs0Jx5khPxdU74BthjZBuyAkpG3T/UlYVRSTOYK+QWmsuQ/0fJtez3vV/rwyiTyavGxM14DcfTTWovPxET/StqsTTI7qe9wqpR9ENC5Z8Qxva+tD1Lw4YxEyWS9PukW28tLVaFvXjd8KRlsZSscCFJ0TvboPILpdUV5ZHCglocOh+zzdfkgtfJW+nEoiFSCCgRfsHGYaly7un1D5pTeaBqeElntqRwMcc3S4gnPXFLz1s0BiX62N9GgWrupVKU4ePMQTevK05t5+6TvUoxni+XeROQiX0IpTdhoSaami3rrifUcUmVC5UvAmKs3Aiuuvh2T/BnjJUYXyTeDle83mpcdw59CZz5TQV/pNB29RJXSVuiNiLJi1iTY0TJqkiwYsZ3Zq7C4JL3CkVF9/VqixJOAnkJPSsSSTQhFxbLMPSssqK+gJssXV9VQIvUzSKhxHJAtTvh75AsKI+XlCfv0N9YRKuMYy2X/OiD2rnr9XNY2duN8ee4jn3VwG4FZ+GiU5+z4Is+cXm9elJ4Vh3Z6+jmlmk1SWpOqqMVmX+SxoLkoVp83gh+NCSTN1deCItVx3uJJeHTh9sc5N02BcBnlhzRq3Be8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNFZ3dYK3VLZXQxYjFZbHR5YzRZWVU4TG5pZStCZTdYWHZHczdXUW1nZktE?=
 =?utf-8?B?RTJycTR4dnE0ZXpiMTJtOHpyUWlId0ViNFIwRzdhWmd2U3JJQlBrSUdWMWRm?=
 =?utf-8?B?RnpzeXV3ZWRJV0htK1d3T3hrTlVrdjhkV28yWHMwWnk2K0VsRis3UytFelpH?=
 =?utf-8?B?czNrQ0FXdU5UQTg3M0hOaXc4dnBBZHlKc3dLc3I1TEhwd25DVVYwcnovTXNV?=
 =?utf-8?B?Q2c1UlVFaFQ5dkFUVlRCN2ZORHdSc0JuK0xnUUtJeURqZURkaS9kM0JWTWll?=
 =?utf-8?B?YTNpR1o2Q0dLeGZGaTVFMEZ0T1l5QTBFS1A4U1hSeVU2MGdvT1JZQk5DejJE?=
 =?utf-8?B?UEl3dE9rRzdyZ2ZDZnZSSmdRbkl1Q0hCVDNSWmphUEZOcDNSS0tsQ1hOVzRC?=
 =?utf-8?B?SG5IMElKWDljVGVZajRzT1JDZDkvaUwydWs0ODRULzJOd2xkNk9naW5YS2Zj?=
 =?utf-8?B?LzNyNUsrRUZZUFhjVFI2TUorN205Ky9ma1prVlZhMTNzWDdJcVVmQnBGMHB6?=
 =?utf-8?B?ZmVtMEdZQXlzTlh0eTBzYW1LMUNlYnA2bG1aYzQvaEdhNEs1QzQwNWVIT3Vy?=
 =?utf-8?B?YUVkM3JiWXAzMjVPajVkT0lYazV5c3hHTERocUlueVJGdEtoek5GNFQwK0xq?=
 =?utf-8?B?dnhManE4VUhFYkF3bVArT2FzQWlwaEoyUlJ5cXpqUkpxSmVacU1WK1U3eGRO?=
 =?utf-8?B?OEh4ZjVVUmRsdzBiOTdNSkNtdXJGa210Y0xZeDZhZE05VUd5R1FDbm9yUDNs?=
 =?utf-8?B?Z0QyTGRNTW1DOXhNOHFuaC9RNU12eHcrM2h6WjdETHVXRmRCUllld0dzb1dF?=
 =?utf-8?B?cnQ2NUxSUzhTQ2FSQTUvSFRuZFJDT3lsUlBrMlI2N1laUndSVHo4dU5Ya0Jk?=
 =?utf-8?B?VzVzTStuZHpwcFFzaDNNdU4vR1dod0RuaEFUYTNZVTFyZTgxMXNZY1lQTGxL?=
 =?utf-8?B?YnJTN1MyZEo3alZUSi9qcGRRcVFMaVZFUUoySzJjL0thcWw3ekV2V3ZqSzZ5?=
 =?utf-8?B?amhneXdiY3pxQ1EwRHczKzUvWHhhZVI3ZWVteS9LVTA5V3c3aXBHZlFhZkdL?=
 =?utf-8?B?Njl0Titja2ZnMFFkR0xHQWhobjg0NW5Jd1pwTDNxWEFiak1laDA4MWVsa04y?=
 =?utf-8?B?K0FWbmJid09iUGxwU1hKM1lhM3U3bjIzSDVPOWJwdG82YVdOZFdNeWM5M1Rm?=
 =?utf-8?B?eko0U0FXRm1Mbmc2MVQ0N1VlN1d5NDU0STZSL0IzOER6K21QRGRkTDBPMFNy?=
 =?utf-8?B?aVFndmZzT1d0aFRoNnV5NFN2SUxBZ3lPUk8xL01ETTcyeXVkNnRta1lRZ0sz?=
 =?utf-8?B?S2JQUC9RVWM4dC9xakF2SFZqWlFWY003UkRtTDVuRHBGMHZTQWRkWnhVdERW?=
 =?utf-8?B?dUI5bjFIaGJYZHJPTWlDREJLWko4cy9YUHhmREcvdjJ6ZUdXSXgxSkJCSlBp?=
 =?utf-8?B?ZTlwM1R3L3RmTWFTYWh0cE9Tc3hEZkxFYnhDYjd3dHMzL1d2b1dxd3FkR3Ra?=
 =?utf-8?B?SUwydUplWDlxK2RlN1NlWStpSS9uTzE5UFpQbXYvSVRXVjlVWE1QdEIwdW1F?=
 =?utf-8?B?M1JSdEtIMjVkUlZRS0c0ZU5oT0ozM2kvOUl6R2o0NkV5U1ptb2lNNVE2ZEtY?=
 =?utf-8?B?Z3VucVZFWXluVldGSDZhbGJRRzVxdXFESjl4bGc4SDBkVFFCbmV3VnpYT29L?=
 =?utf-8?B?ckNBc053cVJJaEYxVjh4M2JoVDVLRHVEbW9PT0d1TGdNVnorMEpoUHgzVUdF?=
 =?utf-8?B?QzcxUjJSdnpxaThia0IvY0k3SjZKa0IzckdZYmRiV3pNeE5mVGI5VEJGK2Vz?=
 =?utf-8?B?Vm14QVhkNFhXTm9Bcmg2UFdKeitneTdISjc4UnlXV0tUdG5QaDV6NlpyL0RF?=
 =?utf-8?B?S3ZDdnZqL3krWDJTL0dGOUM0MWYwYjFFYWRFRUZEbGcyYkIxUHNOL0tnQWF0?=
 =?utf-8?B?TlJOSnJ1V2ZoLytzUk5TRmFUNVJiMkRaTGpkZkRHUkNzbGlLWmFONHBnMlFx?=
 =?utf-8?B?bGVpSUprN0tRcExvRGEzdlAwY0M5Q3dkTGNubUpGUERMbzdxNVNpSVpRSlpo?=
 =?utf-8?B?REF5V2lZSTM0VHRNWENEZU1pMlB1R1R3aVkycEp0dmUxWDBrL2VmempjSGYr?=
 =?utf-8?B?SUhSaVZ3YjU1Y2dnYVYwOGNhNk5abkFwZWxJbkwvbVczZllMUnRJdjFVZC9M?=
 =?utf-8?B?bWpuNlIwQ3NVZ2xFampjb3JEZVh5TWZIS1JaTERsemJMbU5EWmxFaWliMHZW?=
 =?utf-8?B?bFhQWUR2bENSdTdDWjhITTRqSGZoRERqbExWdW9RQTRnTlhCeE5ZcVNSWGpC?=
 =?utf-8?B?K2RDdndJY3ZPN3ZMN04wQkZjWXBFbkZ1bXY5aitaV0xuZFlpbWI5QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee08a06-bd1e-4bd8-2035-08de9073e91b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 04:54:24.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsJX7j/7V18Xwv+is2vV4WOhJzP25vSCu9dsywvKD91j0VTH4gFJhJb3j30ZQd/onEov+uDod/xiEGZoYCdEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8994
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

On Mon, Mar 30, 2026 at 09:25:51PM +0200, Luca Ceresoli wrote:
> Convert this driver to DRM_BRIDGE_ATTACH_NO_CONNECTOR and to the
> drm_bridge_connector framework which is the current DRM bridge best
> practice.
> 
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - Added missing select DRM_DISPLAY_HELPER in Kconfig
> - Rebased on previous patch changes
> ---
>  drivers/gpu/drm/mxsfb/Kconfig     |  2 ++
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
> index 264e74f45554..31db7a824a93 100644
> --- a/drivers/gpu/drm/mxsfb/Kconfig
> +++ b/drivers/gpu/drm/mxsfb/Kconfig
> @@ -33,6 +33,8 @@ config DRM_IMX_LCDIF
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_PANEL
>  	select DRM_PANEL_BRIDGE
> +	select DRM_DISPLAY_HELPER
> +	select DRM_BRIDGE_CONNECTOR
>  	help
>  	  Choose this option if you have an LCDIFv3 LCD controller.
>  	  Those devices are found in various i.MX SoC (i.MX8MP,
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index c8ba8f9b1da8..7f07ae24e0dc 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -18,6 +18,7 @@
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_fbdev_dma.h>
> @@ -57,6 +58,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  		struct of_endpoint of_ep;
>  		struct drm_bridge *bridge;
>  		struct drm_encoder *encoder;
> +		struct drm_connector *connector;
>  		int ret;
>  
>  		if (!of_device_is_available(remote))
> @@ -86,11 +88,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  					     "Failed to initialize encoder for endpoint%u\n",
>  					     of_ep.id);
>  
> -		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
> +		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);

It seems that only analogix-anx6345.c, analogix-anx78xx.c and analogix_dp_core.c
don't allow DRM_BRIDGE_ATTACH_NO_CONNECTOR, since they error out when attaching
the bridge with the flag:

if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
         DRM_ERROR("Fix bridge driver to make connector optional!");
         return -EINVAL;
}

Looks like i.MX8MP platforms don't use these drivers.
But, are we completely safe here by adding the flag?  You also mentioned
"pitfalls" in commit mesg, which makes me a bit more worried.

Sorry for not bringing this up in v1.

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "Failed to attach bridge for endpoint%u\n",
>  					     of_ep.id);
> +
> +		connector = drm_bridge_connector_init(lcdif->drm, encoder);

Also, kernel doc of drm_bridge_connector.c says:

 * To make use of this helper, all bridges in the chain shall report bridge
 * operation flags (&drm_bridge->ops) and bridge output type
 * (&drm_bridge->type), as well as the DRM_BRIDGE_ATTACH_NO_CONNECTOR attach
 * flag (none of the bridges shall create a DRM connector directly).

Are you sure that we are safe to use this helper?

> +		if (IS_ERR(connector))
> +			return dev_err_probe(dev, PTR_ERR(connector),
> +					     "Failed to init bridge_connector for endpoint%u\n",
> +					     of_ep.id);
> +
> +		ret = drm_connector_attach_encoder(connector, encoder);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to attach connector for endpoint%u\n",
> +					     of_ep.id);
>  	}
>  
>  	return 0;
> 

-- 
Regards,
Liu Ying
