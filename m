Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA7EFF513A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 02:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4810B10E500;
	Wed,  8 Apr 2026 02:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BKjH3c8A";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1888C10E500
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 02:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miV3F86j6khyJB6pKzKLgOOdENsXAjmqatIi2Dq8nnSqrPdtr+8yI3MjIp2M3PyQOvgyZKlA/s0EKQHoK/oZDP40BsKRwEpi9Q/o6CupvmtJS3Hap9LZQCq9rhcV0ZeozqkDThKD8o3n0SjSqLMOzhctAEeWqAPgPxqVkgHXXGZGF+OS+2nMrlyLP6clIAqf659iKGq8Ac6nzKWRJX8m/SHc1sczTUXCDnRf2vAMp0tMlNOMXH4q0AHzu8f9KSNAq3fjWx23YUt7mNLpYenxIJCCemIwAE60sZDMNa0JCbzGhVbLI9fbhjP53cSK8aK3VPYZpXxK9eDHrGKsbuL35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA5uBHR+jwig+47CGz/jmLegqyrujaf7LL8D4sAM1Mg=;
 b=thdW4YdWuK3RUBrdDXOOLFL2VryjwD4xh6KARrmSWP4Ak3e8ayRRj4ThwYW+gEBQcle1ZqNbmZCIIhzdOOChBBBB2yaorymoaQQAQgksYl2VFBV1NUqumN8N7rbaVqpVYh8GMAWhkz5GbyWCUvnb8QJYn56SdNNa7XYVP7v2SBJAeQ/BxvKqpiDGqbVJ9hUSAuBqCUGE3ZVjYIUMEtJDfJEKjUD0O1if6yis7a3wk6m5HpYgDE2ThsvGqvmJvUnnmMQeWGfH2A9UHWjSZNUtxZ3Tmam51pfoFNAXpFSkl/WPu9LAOq9MhVcIKIZyvWJxTMzp9zS6MrbvnpYNIc4WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA5uBHR+jwig+47CGz/jmLegqyrujaf7LL8D4sAM1Mg=;
 b=BKjH3c8AqJ95/pNyE5NgpMBmy4hfWyZdMdqpoJDOy6S4/o3Rbi1hO2Wa93Oooy618bJnEYR7XGrAC/7SF/BDFfLNkDIghlO8pnLnRQIHAG9agKQTqLzkVHr5b35JKd/AYPXFndVo4kGKWU37nB9yYvyGcPf8hjqCMH6zYqC1O39sXBaH0pk55X11iz09Qcse/4M49EisjVeVPbaHygZrkgK3VEu6xW5lCd+XViV2xL5RRsvUZxzQiGm3kmJKHdUsPboSZseUVDk+bG8s40mvn26prKzVUFQuCOxBHKZN5p8KAJMBtTdJk2Y8WCNW1Ep8WGz5WG98EGmYAVHWusrsUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 02:57:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 02:57:28 +0000
Message-ID: <863f6c6d-88c0-471a-a548-3cc3dc63f72d@nxp.com>
Date: Wed, 8 Apr 2026 10:58:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] drm/bridge: imx8mp-hdmi-tx-connector-fixup: add
 an hdmi-connector when missing using a DT overlay at boot time
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
References: <20260407-drm-lcdif-dbanc-v4-0-247a16e61ef9@bootlin.com>
 <20260407-drm-lcdif-dbanc-v4-8-247a16e61ef9@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260407-drm-lcdif-dbanc-v4-8-247a16e61ef9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0187.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: aa58580c-4590-4596-319d-08de951a91be
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|19092799006|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: T2ELXqVu31FQzgdi/GHMxIOiux6gKgFJgPrVvp+yyUgB08vWVIgpRP6F5rvlze4sOy40X0fOA6VuU3Q7tldCi99+tmoS6nb2c0Q7ZJPNVAdSvv9xFv4vOLaV+saCurGMfVFFsRHjhAsgbcERtf6OXPUFultiKZDYwvm28wNu6eo1vKTOwXVpdpEf5Q2hzg9SquOclx9K/Bw15Sbfx9zei40sb2ajtNw+ceuuGE44gHMhVh26Qz5S6RofYBoDJUV5+ryFsxR43/8Ry1dbjGw1BbURgZwtJiUENZ8wUnjbdiJWFs91SF36V9/rCEQvH3Y3xG59O1f2KiV5u8xYXMxamGhQQBYrwGPRGjXEhR7jidIhlMM5bk+X/U62JxhHLF/6eTyTfHub5cwHaouvBIIGSRd6ewS5fj0c4KkRlUg95kv+Tj+fHEWiiJUyXWQdr7V3+zjBpPHxmNztvlrqapf9fCsLixm2jBPHX89D49DO22F7ofZcY7ZvMCgfrbUJAU/dkCKD1L8INZjdaAjFYTpKKqZBuLufG0W8azFDdydbtzhuJlBJsc7Q5XWDLqk93kYvvZZmJ/DpwTmvcV/kuu5ggHyFqg1qMWSoJpijLCRqRyq977V20V+AlkgW4CPwQdHGbb7dGTl74AnTKa1rJmcn8xb63kONUfP7w/HXPf6F2xBS8ECbff47nJbuy2O4kSpwq1x3QiEM26/Fo33MJQQcXL+Hh98FuDRxIa492UQWkuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(19092799006)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENSeUdoTFNNYTBRVkE4Ti9NSE03MDdkUWxjTUUySEIrL0tCbGI5RWlUU2xY?=
 =?utf-8?B?V29WeGJ5Q20zVndaaXMyK3RUNE5uTVErNW1vMlhPNDd1RktmTmMrZzg0NHNl?=
 =?utf-8?B?dzVOUkRwa0c3M2JpbGlxeTRNcWtmVFN2WmJlTkkzRytyQXlGbGYrUkh1Z2FP?=
 =?utf-8?B?MnRyNXYzRk90WEdaMUFzV0l2TzRqVjFCUEs1d0dDemRORjNIVE9JTGxLS2Vh?=
 =?utf-8?B?T21LenZaNTlTTVM4clY2cGQ1WHpaWFdlZEpyMzNTOVFkcXZmTUgxam1raTM5?=
 =?utf-8?B?NnMxeG53TU9PNzBiT2JuMyszekE3Y0pCUVBxWFU0c1JpUm1qMU85TkNja25i?=
 =?utf-8?B?ME9helVNdk1IRkgrTDhyV1VvSTMwWE0xYU1PTndrbStUSUZhdDllRVVFc25v?=
 =?utf-8?B?dnk5U1R1SS80R1Iwd3YwZHBVOTQvNm1ZcVhFQ1NWa2xwcGZjc2ZkOEd0ZCtT?=
 =?utf-8?B?VHhzUUdGSE1oRTNZUmZuenh0TG9xZWNEb0p4M2ZkZkkybXc1cGR2eUhJelNp?=
 =?utf-8?B?M1hYQW9hbEthblltSnU1L29MdzROdVlXRWRQbkVuODU1dUJSc3VSeTJQRThz?=
 =?utf-8?B?TmxtOHcrOURpRU5sZHBIcHZtdmtiNzIxenlZbG5XdW5sUFBPaUxaTUlUTUNo?=
 =?utf-8?B?WnRSa3hjSU9taWFCY1R1VDI4Mml6ZTc4SXp6ZlJoSlBHRERQdnh2ZDN0QVMv?=
 =?utf-8?B?OUwrUFdnSXRlcTRKdzVFKzBWbjhqNm0rMTJyUXM1dGNLTDVWV1FVMXBqWEVR?=
 =?utf-8?B?WmpEcC9wSWxuMHE4VTM5ZTNoZUpSaG82ZnQvK3pjdnUzSzdHYlI1Q1BIQTFS?=
 =?utf-8?B?RFBibzVZM1dVMnBBZFp0Q2VBVW5GaHdLRTBObnk4cXREaEZzc3JVRkhTYzBE?=
 =?utf-8?B?YkliZkQwRC9qVnA4QldXaU9XTVRoam51SEVVQkpFeFZhRUNxbGJRaTZiM1Bo?=
 =?utf-8?B?bmJPMTJJRUpjL2dBR0I3Znk5V1krLzZReEU2UXplVkpJMFFjWUs3REZ4ZmNo?=
 =?utf-8?B?R1krN1ROdloyYlVoRGpXa09MWjBEbzkwL1F0eUYvMGRIaWptbGN6ZGRxZFRP?=
 =?utf-8?B?SHpaZVVHVDFla0huaUpick5sSVJ4VnM4NGl2RUJaTEUxUzJOMDRvaDhpSUFV?=
 =?utf-8?B?VVZQQ0xsU09PYi9ZZzg4cVJOMjYwc3UzMFFWVllxWjZRenJyTTc3UjFXYzM1?=
 =?utf-8?B?Q1JzR0FZeFVKYnNTRmt0azI1Nm5PVGRnWEpvVEVnNFFWNzA1ZE1vV0gyQUl0?=
 =?utf-8?B?bGNNeUpMYW9La05RaTd4VkRZUTA2NmdaWmJVK1QyNnhEUGd6L0dRd09ONCtO?=
 =?utf-8?B?OG1KTnZXcmZ0TnpKYk9mRThQc2RsR3hBU0JBNGQ5SzF1VVJ0blBDQlliWFRz?=
 =?utf-8?B?TGxVVVJDbzdhRHU2UGUwdjd6S2l4ZmxqZm83ZlZ1aEpCNGFMK1VpaFF0OHE4?=
 =?utf-8?B?S2JoZ3E0YUZrdGpPR1NZQXFLMCswU3lwVS9WcEk3UG5pcDgwaVBya1JTb0Fn?=
 =?utf-8?B?WFlvVVF2Y1RZUUo2OTlsWlBuRWZYQnFvQVpjTnFSU3YzQkdJNlFjbEJTd2Jm?=
 =?utf-8?B?aVZ3RG1oM2JEMzBlemJXWklCNE9qUkZYUmpnbE5pcGhVZGVsRDdvWGZBQUFW?=
 =?utf-8?B?VFFucmQrUDE1UHRZMXl3R1FIVTJNZWZPdTM0RE0xdEZDTEVHZ3pjZnJlTkVK?=
 =?utf-8?B?UTVzWHdNdDhMNStLQmMvbDRjTjdTR2FGM0NzZTlMR1ZhNWNjVmN2bEQ2Vy9L?=
 =?utf-8?B?YzhHd1pCM3JQTUVESGEvd3Q3dWh4bFpSVTJzNkI5MlBaMnEvdElxSjFHKzh6?=
 =?utf-8?B?eEFncHh3eS80bWQzdE50Mi9iNmZRUTY5Z3J4ZjZOYW1ITzJhcGdHbThmOFZx?=
 =?utf-8?B?VlJQcGJlVllFNnQ4aXRsWTlOU2lUVDRwWVc2Zm0vRFg3VTFtYmF6aTZnbUF2?=
 =?utf-8?B?dWt4cWNYb0QzZzdkUDVneEIwSTBSZkdYRHEyeitiZ3FGdDA4ZmJqc3B1UlNW?=
 =?utf-8?B?OU5sSlorV01PU2E4STVMSFYrUDJMNWtRT0hzc2U3dEIva2orbTM4Y29xY2pW?=
 =?utf-8?B?WmFGd0VaN2dqS0MzMnVOeVphRW1nKzZLd1M5YWFseUU0WmJvQlU4WHdNV2gr?=
 =?utf-8?B?Y3pDcllJV09nclhiVVlnOEhzU2ErYnBuYjRnMUsxNHpZUVo0VE0zY3d5M3BQ?=
 =?utf-8?B?OEdiWHBPeTJIZnNIVUI5Tzd2alFMM1Y5ZGN1NS9vZUxnNVJlQTRyeTNzdk5h?=
 =?utf-8?B?blVvR3g1Z3BLRlN3MERmWWVTaGw4eUpyb25LaE5VQ0FmVkhVdDZpem9HenZv?=
 =?utf-8?B?QTFSZXA5bzRBZkJZbnNXd0RsTExmc09ZcWtLMVdsVVBjZnNvL2ZZdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58580c-4590-4596-319d-08de951a91be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 02:57:28.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gR6NpVVptgpx8WNv7m7UuUGvvOBjD1ajyaMCO/PtdsXEK3/R7+URB01cY7vJgq9eydCa7tdupcF33T1Ad+B5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356
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

On Tue, Apr 07, 2026 at 02:24:22PM +0200, Luca Ceresoli wrote:
> The imx8mp-hdmi-tx is one of many drivers based on dw-hdmi. dw-hdmi in turn
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
> in that case it adds an HDMI Type A connector programmatically at bridge
> attach time.
> 
> Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c in
> case B. However switching to base B requires that port@1 is connected to a
> "next bridge" DT node, typically the HDMI connector, because dw-hdmi won't
> add the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> Many dts files for imx8mp-based boards in the kernel have such a connector
> described and linked to port@1, so the pipeline will be fully attached up
> to a display-connector and a drm_connector added by the
> bridge-connector. Sadly some of those dts files don't have the connector
> described. Adding it would solve the problem easily, but this would break
> existing devices which do not update the dtb when upgrading to a newer
> kernel.
> 
> In preparation for switching to case B while preserving backward
> compatibility for such devices, introduce a module adding the
> hdmi-connector node to the live device tree at init time. This will allow
> the dw-hdmi code to find the next bridge (the one wrapping the
> hdmi-connector) and let the pipeline work as before.
> 
> The module is inserted only if there is no endpoint in port@1. So boards
> whose device tree describe the connector will not have the device tre
> modified, and will start isntantiating the correct HDMI connector type as
> described in the device tree.
> 
> For boards lacking a connector description in DT the overlay will be added,
> abd the HDMI connector will be Type A, which is a reasonable fallback and
> is what the driver is currently doing.
> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3310
> [1] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2907
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v4:
> - fixed warning in overlay build
> 
> Changes in v3:
> - removed unused variable
> - simplified overlay using full path to port@1
> - handle of_overlay_fdt_apply() errors
> - use of_graph_get_endpoint_by_regs() for more robust endpoint lookup
> - improve subject line
> 
> Changes in v2:
> - don't apply the overlay if the SoC is not i.MX8MP
> - build unconditionally, but depend on DRM_IMX_LCDIF
> - remove useless error check
> - add missing cleanup.h and init.h includes, remove unneeded includes
> - avoid dtc warnings on overlay
> - fix typo in Kconfig help text
> - not added the Tested-bys because the code has changed
> - split the 'plat_data->output_port = 1' line to a separate patch
> - improve commit message
> 
> This patch is inspired by commit 0ff223d99147 ("drm/tilcdc: Convert legacy
> panel binding via DT overlay at boot time")
> ---
>  drivers/gpu/drm/bridge/imx/Kconfig                 | 18 +++++++
>  drivers/gpu/drm/bridge/imx/Makefile                |  2 +
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 58 ++++++++++++++++++++++
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 30 +++++++++++
>  4 files changed, 108 insertions(+)

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Thanks!

-- 
Regards,
Liu Ying
