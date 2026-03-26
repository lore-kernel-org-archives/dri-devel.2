Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B236E106F2FC
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0565B10E8D8;
	Thu, 26 Mar 2026 08:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ADxPX8Di";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD93F10E0C9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8Tu6COAREJXwCk6ks4eyWGKCX3SNKriVkamFyL6MnDIdVPPVRBf14oGGRQbrsPszXBTIFl2304c6C/1Zb70Qr+iLaySm/B5qd27OLvOXdEKgRtbw2C4zMtTBQZYnx4KzusaSzcMlOYeDzZY2utsmiLNiEw6N4P7Avk0/62cTAZduyyzMROCPEZQn9AwloQn5JVGwQWIIlR++8iPaBXNpYc5rU15xplPRQRyDRFUE51r/8uMEyat0LZxMxG58u6c2KBM/csTW9bC5w7nqQ/wzPqlwIwBytJWnxzbUloiYsrdbO32w3H4WcIvnz8X6fgdEcpeB5MjoEQ+2tNAmz39FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN4IwFef/G23A6+SNwXwIiqZ75G76GkBSO2OoKrEXoo=;
 b=q/NBnhMPxocKDorwd+M1cKAQsvaYKYLijmQf94TSdMC0/n4K5dg2Vjfcs2826lktFUUGIQd1QLnaZAglt9n1uSjsd6ReBdQRiQHhLtAyWx99zh6/xS8/LADHVTpXBFthzA7jqpFQiX6g8G2a2zlV/SjAY6/BltBwRm74M68FK9xwTtnPfWe/sW7QyJ3cqk6RL6niG2lHCZVy+9q9bUb7oDm2zvFIPMekWAm3E69bpWv+zhVW0eJi/oR0O21vsmRx27oUSPGhYkT7H8Hv01whGO+gbUUFikT8ecY6rsU7CfWn2YNQQiuj3BuJsyTGaRMPZrioUM2ziJ1cG8gF406a0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN4IwFef/G23A6+SNwXwIiqZ75G76GkBSO2OoKrEXoo=;
 b=ADxPX8Di3BOrHxPwg4aXJWAjBtl58STL0CcKjgsn/JpwVbSSGQ/jDcTOH6//T+UxN36BYeD0Hs3ofPeAesk2WTpzYRArrrH8dznWv39Hna2zOZbJvAN3xSkJI0ySLDv0xM+C+1KxewEcxnhffoqGeRXcSdZyBEA0VR6m9jAOu33mabONSjvkkGVHmbkJZSkUbboiDf5RtuUB25ZrtpFObWHqoizFOgs5NzDenakyVD80eZoipBk6vMnEbldvdkFDM72x7Pr9xZk4HGN34/P5wnlo3iUVH/EVYl0ASJzmCMExUn5gkVNFfzbzXFSGxr/bOlso3j3RTbaXGP6cDhX4cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by MRWPR04MB11285.eurprd04.prod.outlook.com (2603:10a6:501:79::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:14:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:14:47 +0000
Message-ID: <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
Date: Thu, 26 Mar 2026 16:15:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector
 when missing using a DT overlay at boot time
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
 <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|MRWPR04MB11285:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f5437a-adcb-4ed8-d8dd-08de8b0fbe66
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rcmnwALYsHr2OIyWdT3zCJFXMl8B7ffqsXo4aHwPaHym+I5vyvzcOkzl0VZuayJTLtP8rTvW0QUOSaJwXMjNCeT9gwW8FEJuTy6Esrn6Atf2UlsNVH7s0tNMsJSZG4hfMj+wKYlIs6aMzVRhjWShj2cGLYl5++Z/voMdSxoWLOqvkwQFvDGYgd2r01aFKozYOn4oGpbwsaoydT5bn4koYDZF9jRV4ZutEvJjYCthUb1EZb6sUeTlOypN6Ns5vWsLOrbFkr1h1xg5sOWdOsN/VKohHkx2Y62OlDH9bRTSMUxm2WxJlsqubL20q/P3tL7EGZemtXUXqNxz98ywaFUe9kBjxWGfe33S2Tsua6t5HOGWhml5LskLLk9bC58bzUfbvGNvRCBSk3KwK7gGLpBhUsnz87E7hHr4s5zxvAoILblmYouK0hwDafSVKedxeR3VTYpy5An+97RdCwCBu0s34P93vi9JAMZwZfKCJ0p2GyaxwrMdT/yLhvymfNMi8ChuxMHqPxHVIntbdvjB1B7lukTxZwMdNH0hbgoSL9UXCGmi/8Keqnwy/jf2uyq0fuxPPMhHg5p8szKvwQJ2/Zjd28ptg6lyY5dUx6K69QcXMy6ajV4jmMM0yxS7HtK6I7Id1/+VsHn7ZYAGqkYMBiH1IcvF6DVcg+dPRkJDUoAteT9tzHoRWWXpRsiBv9yhq0yuByuQqclxlrm5mo4EBdEFYocuahEJ9VC1PubJhi//m3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0lMMm4xN3YxNlM1YzhqZ0NyaitXbTZkRzFvcG8wNmVRaFpKYnNZZGV5R0FI?=
 =?utf-8?B?ZkpicExsemJDZG1NS2J3dXdFK20wVHhHcmJ6NFN4bHU1YWJEQnlRTkNzZWZy?=
 =?utf-8?B?ZlRLQldjZjczTzZrbGhSTldGb0puRFhhMmxKOURrNjVvdlBaZnJvOXpXMnc1?=
 =?utf-8?B?Q2NEbVdKL2RNbTVWbERSMUMwTWJwWlBEMnl5bzF0YjFpbTczcWEyOG5QRzF1?=
 =?utf-8?B?RjJldndQTDMrNWErU0lveUtUZkN1UTREWU9vZGVNbGRXaTMyUm5vYWkzSTB4?=
 =?utf-8?B?OEdmMFU0S09NL1NOOG1OeU4zRzU1SlNyMUZaaytmS3dBN0cwOTczbStlcWlu?=
 =?utf-8?B?R3JJSnIyYnZrVjFiZjBwNG9wVXd1MmFnSGd2Tm1vZXRjd1Z4SDlsMTdWTXk5?=
 =?utf-8?B?Z3VzRTcxT2tVS0tDMC9WU0d6UkMzajBwbDRXdmk0MG9wbWJLTFNBS0FSVk1U?=
 =?utf-8?B?T2tobnBTc2I1L1R2SG9Gc0lBMFJZWUhPMjlDU1VhUHFycWlpTmRSM28wbFE5?=
 =?utf-8?B?TGJySno4cjBwbmpaNEZYR1cycUZ3YmZnMHFyNytWMUdjYnRSTGdxMEEzbm9j?=
 =?utf-8?B?YU12M3Z6QWtNemU5VHg0MUcraTlOc3JpZjc2U2k1NkdSRGUyVXJJbkZXVUJm?=
 =?utf-8?B?SWdlak1DL1dzV1NzM3NVejExWGlnOUo0Z2diVG5xeTZBajdkZVkwc3ZSSHdz?=
 =?utf-8?B?OUswQzl5bCt4N25jbjVhQUZnVlBhejRzY2NjK01WZkJ4Y2Y2aUVLU1JteWVj?=
 =?utf-8?B?WHZTdUxVNURDdnBTQjZOdUY4OWQ5MU1XcVNBYzBudGM1bzAxR0M3L1V3OFM4?=
 =?utf-8?B?NzFkdVk5RVFOamQ4eHllYXdLVDR0TjRFN1hIdy8wQTJWOUlvY2RGWE85Qnl0?=
 =?utf-8?B?dVNWbEVDaThWZGcyRFUzNVNRZDBpTmhRQTRiSGM3VTJsKzZTWk5vaUlmYUJS?=
 =?utf-8?B?MDdyUXIxRElLYWhxbm9hTVJUZmMxckpkRGlkTnJ1aHg3S0czS0NEMUo5NVJt?=
 =?utf-8?B?TWxpRXJiR2lVQVhwb2dPQ29lTFZ6QXhmcHFPNVJtaHFvUGd1N2ZDSm9xZnQ2?=
 =?utf-8?B?cjNHWWNlWUxndnlPdDllaTRLMDFPRTV3dHR6U0ZaMXQ1OUVhK0JhMTJhUlhp?=
 =?utf-8?B?WmFBWnNIYUxVWFRuRGRvcWovQ2RFMDNZRDNFS3czYTdEUVVFOTZES0puaTk2?=
 =?utf-8?B?cDVMSW9nKzZuR3I0SWVUSmhMNElreWJKdEJ1NkZrM1RZaDBOczc0Z0pwdVNH?=
 =?utf-8?B?RVh6UmlrS1ZjeHR0NzZwTmlZRnJmTDZsVUxreXdmMjB6Y2UxTVFicGFTWFZR?=
 =?utf-8?B?NUoxSC9uMkdQTVFmZGlCQWpDaVYxc3NmcFdxb3F0T1c5Q1phVzFLQUxXKzdv?=
 =?utf-8?B?YUdobDRDSnZsa2IxOWtSL084MlFIL1c1TXdEY0p2MUxydzI5Y2ZLeC9OZlpS?=
 =?utf-8?B?bmZvaU1sU2hRa0pWUDV0YlNqSEtNVHo2ME04TFYxK29WaDMxNnE1SFl2RHNv?=
 =?utf-8?B?d0ZEaGhEUDhrODlPazJtaExDb2VoRDdDQ3hHUWJqWVFMV0pNeVdTWmFXQ0d1?=
 =?utf-8?B?Q3pPZEt4cThHakVKL0ZSWmxXWlY0dE1TWE4zdGN3SEd3YXNINGtTVzRjdEth?=
 =?utf-8?B?b3Jtd0J6YlFCa3g2MVR3WDNScFB2UitRYTdvYzhrd3FjbGJLQXlrRkR6Ky9i?=
 =?utf-8?B?eVBCVjIvcWpCVzVVNUdScU94emZsUkVVVnhQNmxUZTRIMStFWHlOSUZNVWov?=
 =?utf-8?B?WmM4bURMVXR6eWgwbTFiWFhJTmdtbzdMRkp5V0NtVlpDREcvamhxK1lDVFA4?=
 =?utf-8?B?UTl2N0RkU2pJUWdBZWE5Tkk3cXdqQnlmSEJ3OXlOOTd0bXlzbm5wbDllR0hJ?=
 =?utf-8?B?L1lzdHovSkdodCtYOVY3UzF2aDAzMmVJaGlzeStCRHFqZXZFcVJPTFdxczV5?=
 =?utf-8?B?eWJmQ3hVTlNBZ3FNTHkvQTBCSzVDVVpoOUk2MmZIVDBFOTNoZGdxZUhaVFZJ?=
 =?utf-8?B?STcxbTJKTnRKemVIQzJ3VERTYXZYR0xzZGpoUVZxZG5kYWFGR1JacUIwZmJX?=
 =?utf-8?B?MjNHT3FSNFRJbEl0RTk1YjI4YWovNUtrSWx3REdBMXF1SVR5Z3NSNDJldmxw?=
 =?utf-8?B?YWxqMk1ZZThWaVF6b2ZISVFrYmo3clkxd2lwRnBjalJsZjR2dTlOOWtBSUFG?=
 =?utf-8?B?Wmk0TFZPaUJ4enVmTU1ORVFQRlFBblllMnFySGlwSzdXVlhiQ3hGM3hGZVY3?=
 =?utf-8?B?dlBRRzVWc281Q09tbkhiczRmYU4rc1djUmMxeUVVMGg2eHhLY0s1Z1E5RThP?=
 =?utf-8?B?c2FVQ2ZrZ3BuSWhab2RFRmszZmgxZXZzOGdXTzVJLzAwcWc5Tmh5UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f5437a-adcb-4ed8-d8dd-08de8b0fbe66
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:14:46.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIVMtBdpmCX9T7Wl7wJO+VgOpZbvSmHQTClYqiFgMuO2VZh/pi0E3Vw4IuD/BglvSOTjR+eWR7NOIxnsG7sClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11285
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

On Fri, Mar 20, 2026 at 11:46:18AM +0100, Luca Ceresoli wrote:
> The imx8mp-hdmi-tx one of many drivers based on dw-hdmi. dw-hdmi in turn
> can operate in two different modes, depending on the platform data as set
> by the driver:
> 
>  A. hdmi->plat_data->output_port = 0:
>     the HDMI output (port@1) in device tree is not used [0]
> 
>  B. hdmi->plat_data->output_port = 1:
>     the HDMI output (port@1) is parsed to find the next bridge
> 
> The imx8mp-hdmi-tx driver falls in case A. This implies next_bridge will
> always be NULL, and so dw_hdmi_bridge_attach() [1] will always fail if
> called with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
> In fact case A assumes that DRM_BRIDGE_ATTACH_NO_CONNECTOR is not set and
> in that case it adds the connector programmatically at bridge attach time.
> 
> Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c in
> case B. So, in preparation to support DRM_BRIDGE_ATTACH_NO_CONNECTOR in
> imx8mp-hdmi-tx, move to case B by setting hdmi->plat_data->output_port = 1.
> 
> However this change requires that port@1 is connected to a "next
> bridge" DT node, typically the HDMI connector, because dw-hdmi won't add
> the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> Many dts files for imx8mp-based boards in the kernel have such a connector
> described and linked to port@1, so a connector is added by the
> display-connector driver along with a bridge wrapping it. Sadly some of

Hmm, display-connector driver is a bridge driver so it cannot add a connector.
I assume that you mean a connector will be added by the bridge connector
driver.

> those dts files don't have the connector described. Adding it would solve
> the problem easily, but this would break existing devices which do not
> update the dtb when upgrading to a newer kernel.
> 
> To preserve backward compatibility for such devices, introduce a module
> adding the hdmi-connector node to the live device tree at init time. This
> allows the dw-hdmi code to find the next bridge (the one wrapping the
> hdmi-connector) and let the pipeline work as before.
> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3310
> [1] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2907
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> This patch is inspired by commit 0ff223d99147 ("drm/tilcdc: Convert legacy
> panel binding via DT overlay at boot time")
> ---
>  drivers/gpu/drm/bridge/imx/Kconfig                 | 17 ++++++
>  drivers/gpu/drm/bridge/imx/Makefile                |  2 +
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 60 ++++++++++++++++++++++
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 38 ++++++++++++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |  1 +
>  5 files changed, 118 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> index b9028a5e5a06..b9ce140a93dc 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -25,6 +25,23 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>  	  Choose this to enable support for the internal HDMI encoder found
>  	  on the i.MX8MP SoC.
>  
> +config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
> +	bool "Support device tree blobs without an hdmi-connector node"
> +	default y

depends on DRM_IMX_LCDIF ?

> +	depends on DRM_IMX8MP_DW_HDMI_BRIDGE
> +	depends on OF
> +	select OF_OVERLAY
> +	select DRM_DISPLAY_CONNECTOR
> +	help
> +	  Modifies at early boot the live device tree of boards using the
> +	  i.MX8MP fsl,imx8mp-hdmi-tx adding a hdmi-connector node linked to
> +	  the htmi-tx. This is needed to support bridge-connector usage in

s/htmi/hdmi/

> +	  the i.MX8MP LCDIF driver.
> +
> +	  You need this if you use the i.MX8MP HDMI output and your board
> +	  device tree file does not have an hdmi-connector node connected
> +	  to it.
> +
>  config DRM_IMX8MP_HDMI_PAI
>  	tristate "Freescale i.MX8MP HDMI PAI bridge support"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
> index 8d01fda25451..84499fe2e444 100644
> --- a/drivers/gpu/drm/bridge/imx/Makefile
> +++ b/drivers/gpu/drm/bridge/imx/Makefile
> @@ -1,6 +1,8 @@
>  obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
>  obj-$(CONFIG_DRM_IMX_LEGACY_BRIDGE) += imx-legacy-bridge.o
>  obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE) += imx8mp-hdmi-tx.o
> +obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP) += imx8mp-hdmi-tx-connector-fixup.o \
> +							   imx8mp-hdmi-tx-connector-fixup.dtbo.o
>  obj-$(CONFIG_DRM_IMX8MP_HDMI_PAI) += imx8mp-hdmi-pai.o
>  obj-$(CONFIG_DRM_IMX8MP_HDMI_PVI) += imx8mp-hdmi-pvi.o
>  obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> new file mode 100644
> index 000000000000..8c423b9bfa50
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Add an hdmi-connector node to boards using the imx8mp hdmi_tx which
> + * don't have one. This is needed for the i.MX LCDIF to work with
> + * DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> + *
> + * Copyright (C) 2026 GE HealthCare
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>

Unneeded?

> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/slab.h>

Unneeded?

> +
> +/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.dtbs */
> +extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_begin[];
> +extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_end[];
> +
> +static int __init imx8mp_hdmi_tx_connector_fixup_init(void)
> +{
> +	struct device_node *hdmi_tx __free(device_node) = NULL;

Include linux/cleanup.h as __free() is used.

> +	struct device_node *endpoint __free(device_node) = NULL;
> +	struct device_node *hdmi_conn __free(device_node) = NULL;
> +	void *dtbo_start;
> +	u32 dtbo_size;
> +	int ovcs_id;
> +	int err;
> +
> +	hdmi_tx = of_find_node_by_path("/soc@0/bus@32c00000/hdmi@32fd8000");
> +	if (!of_device_is_available(hdmi_tx))
> +		return 0;
> +
> +	/* If endpoint exists, assume an hdmi-connector exists already */
> +	endpoint = of_find_node_by_path("/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1/endpoint");
> +	if (endpoint)
> +		return 0;
> +
> +	dtbo_start = __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
> +	dtbo_size = __dtbo_imx8mp_hdmi_tx_connector_fixup_end -
> +		    __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
> +
> +	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);
> +	if (err)
> +		return err;
> +
> +	hdmi_conn = of_find_node_by_name(NULL, "fixup-hdmi-connector");

Do you really need to find the node, since the overlay was just applied?

> +	if (!hdmi_conn) {
> +		err = -ENODEV;
> +		goto overlay_remove;

I'd just return -ENODEV and drop overlay_remove.

> +	}
> +
> +	return 0;
> +
> +overlay_remove:
> +	of_overlay_remove(&ovcs_id);
> +	return err;
> +}
> +
> +subsys_initcall(imx8mp_hdmi_tx_connector_fixup_init);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> new file mode 100644
> index 000000000000..ee718ca1b11b
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DTS overlay adding an hdmi-connector node to boards using the imx8mp hdmi_tx
> + *
> + * Copyright (C) 2026 GE HealthCare
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {

I see build warnings(W=1):
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:25.8-37.4: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0: node has a unit name, but no reg or ranges property
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:26.16-36.5: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000: node has a unit name, but no reg or ranges property
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:27.18-35.6: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000/hdmi@32fd8000: node has a unit name, but no reg or ranges property
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:29.13-33.8: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1: node has a unit name, but no reg or ranges property

Here is a patch to suppress them:

--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
@@ -10,6 +10,9 @@
 /plugin/;
 
 &{/} {
+       #address-cells = <2>;
+       #size-cells = <2>;
+
        fixup-hdmi-connector {
                compatible = "hdmi-connector";
                label = "HDMI";
@@ -23,10 +26,25 @@ fixup_hdmi_connector_in: endpoint {
        };
 
        soc@0 {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges = <0x0 0x0 0x0 0x3e000000>;
+
                bus@32c00000 {
+                       reg = <0x32c00000 0x400000>;
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+
                        hdmi@32fd8000 {
+                               reg = <0x32fd8000 0x7eff>;
+
                                ports {
+                                       #address-cells = <1>;
+                                       #size-cells = <0>;
+
                                        port@1 {
+                                               reg = <1>;
+
                                                hdmi_tx_out: endpoint {
                                                        remote-endpoint = <&fixup_hdmi_connector_in>;
                                                };

> +	fixup-hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "HDMI";
> +		type = "a";

What if a board uses another type?

-- 
Regards,
Liu Ying
