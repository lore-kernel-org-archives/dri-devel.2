Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFE0CC6B01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 03:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527CE10EF88;
	Thu,  2 Apr 2026 03:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Arx95Rne";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7909810EF88
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+rBIorlWi50j5v15UeQNqZy3KxlVLF70c3BV+NuN47HIKiW3qp8xOCwimacBKa/WZtigmm+XDb42weBhRhSjgh32xcc4DnQEUcvdos5vSxMALtug86WgX4kBvPovxHtKvGlGyZw62r9P5Z+i/Pv7HBfJ2t3lM5bTQMhil0ae9oZucP3Y9BbnaLF8LM0NiGHm4alTlELrNXhom2DZIVg/7jA4jEOQzSWlIxYs/Ed0P9MmgUb8YPdJjTvm9iQukROFWDWSOhhQq+tYeI3hOQejitWqCpXpIVWmJd+LCNBEhtsOhfS/+8KJbku6hdmjH6RG1/HdflERFmEaezUMq3e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4q2Zvi50EjL5k5Ki6F1tup/xTd4DWGCbFZeRUAdJxs=;
 b=bsoetxbw3CblfF1yR4td1WvOI3F/ONbyFsydALg/NGqSSSBAli78GVu2WYkoBGhRoPondic60JjRwWn8Rrk+jDV5PfK0Ph+ZSnM+vv/g0k0R+/pDL4x/kjJBehBCuqahbBaRB95MkEyFyE+sRbx39hP7lxB/nG+KWV4NkHL93KGLckPA4d0bYVLzezvkTe67bianNkehbKh3vrdKt76p782jBmjxc5hAR4eQHK4H96QSV0ano2zqCigMHGmttaNhK1T/g6wghYxyizESpc+bA+P/VCXGOlXlTBQCtIedXu4cbw/3tN434GGi5OtbYPuI6L3opg51iDvd63Qqbeh1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4q2Zvi50EjL5k5Ki6F1tup/xTd4DWGCbFZeRUAdJxs=;
 b=Arx95RnekVspSDvSOoBxnt7Thppm7nXYa256/S+7fQugfg/EaWGGOJvVQioFtTedB7lFn0yMYox07dGlCWk6c+6cUZtVTBvaADu4mrPSKwvXdlGe10RwVHfBfn+cPHTHUtp1dxU79L+MlYiccv04e0mdT2jn10qrLTK9kmicqehDD5IYVQT7izlQNEDGrktffSLTWJt+tAPwb1YkehBFr+y15bYqMWTAtsZFIgZqbRKDe26cRnTuNyg88sUc3MYEqyoodhZKCRpjZm8/LwQKrDYXDawRgsSL8gNvAvWNthVx1baRh517AdSlYLOF7pfwfbUpQLY31xx+iMcpeDio9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB12107.eurprd04.prod.outlook.com (2603:10a6:150:334::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 03:57:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:57:56 +0000
Message-ID: <de12554d-75ff-46e8-a29a-6a9ef354b781@nxp.com>
Date: Thu, 2 Apr 2026 11:59:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] drm/bridge: dw-hdmi: move next_bridge lookup to
 attach time
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
 <20260330-drm-lcdif-dbanc-v2-7-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-7-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB12107:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7227dd-97b2-4524-1dd4-08de906c05b1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kw8n/vjFPJqCT87gE8oJaV/GHZqN943HdX2eH0Bi+87IrkzJrVSIwUo6G5dvYlz0QgGFtlJK35Wc+rlcIXfOxtooAu/fRYwniRjRKzcvn0Ant8s4ErrGJYlanSjeoptnmb+Pt7fICdZWUgjtJQSSHxugFKUUMj7axEjX51M6nTi4FQMlq6j/jPOh/HRdgufj64ifIoKwZnCvOQr5LbFMBGHy1XTbHur/ekz+aAa/5eCjt2k96I4N0BuL9cvLI5f2H6iTfCFQtSDNkrZp2ujn28KYYOLVFAztqFULFV2O0MvL68lOXyx+hx3BFfAGrZTYo3La53Q+n6EudAQZtice9IWcBbLUQ1RSvYs+Epcw0YX43x2qHd2rd1qNi4SARSULkzp/3yBDAkS+H6nLyUtFD/ubtQFU59fcalDkl8kOAOGL6pShkKDqLLcOSto35B/M1E3ocDHK1liH6ELlDOsWTJZuK8kqLjL9IX/NzWauaYZVjyT2As2Sg1sDG4b4HDGXdUNXUajVTRwGP8p9m7T74YwqKeHql5RWVVmND3vjJQemRp8u8OffZzBSkpxP3Mn26YNMtIt4gTuT+INy9ddlv7xV1dshQGuFA/Hxl1A4mLfMa6lnE6XNLcq9WOmeZ3pfZ9rHCmQqNkm3qQ5SI6rlk/qtR3JEK/+qudJpG+gh6abf6fu7d9oqMvsMHteXTsUK8gQdXst8d/TUlxEQlaRwZYtjAdiiSFEDOAzpcNww2h5JslYGFAMyGnRnSgmQJMdprDHN44UQA7XRuTUOWXaZTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFIeGEyeW5RREhSQmQzMGRXaFFUWWZON2FjRDdDaTRmc0RZUUxKWnQwemdK?=
 =?utf-8?B?bm0yT2wvZGUvNVJ6RzhJdC90RTJ5THRjTmdlK3VldEgrL3g0RTJ3V3ZQRHRP?=
 =?utf-8?B?c25pQTc3MXRuaTd3cGhCandnd1I3NXRRaTd0VmU4KzRPNythWGVlOHArejY1?=
 =?utf-8?B?VXBaTXkwZ2tVTEZxVUVVZjNPZnhaZnZjc1hDQm5ZcUt4YmtEbGdiVkVYNXR4?=
 =?utf-8?B?QjA4ZzVXbmNONXBxNzN0MXlzelg4ZzhlSUx1V21aR00rTFE1aHUwQzFpbUhn?=
 =?utf-8?B?aFhkUTdHRVYrNnpQUGx3SGNWMkMvWU1vTTVUcE9hR2ZRTDlhZTJjNFJDWlQ2?=
 =?utf-8?B?Y1NJa3VVUU1uTXo0Z2twY3p0MS9FajVWUHNWaXNHL3l4eTlmL240emdvSjNh?=
 =?utf-8?B?YmxFMkxWREZlQ3hXUVhsSWMrM0JRTXhGY3BkZ2kvaExIWVdnck9IMWpWQjU5?=
 =?utf-8?B?QlVkd3NuYkl4c3NTdG5VYmlxVXVodmdYL0VKcWVPMTYvMUlIeEtDWWRnRXN3?=
 =?utf-8?B?bVVvVDRXOXY3Y3RQTXVqZU1YWC9GaDdPZmo1dUcwdm53dFJraDFNWG96a0RU?=
 =?utf-8?B?bk1YQlBxSHZidExFNHZSSmxid2N0RzRoaXdpd3NxalNYcjdJNUFEMWVMUVVM?=
 =?utf-8?B?MFpMTUNGdVJEekFHT3o0MnJ3OVBQczRkMzdxcksyZDQyeVN6emw1bDZ3NFk4?=
 =?utf-8?B?cmg2NkZMVzJMeGVZK041dDNpUFdveFpjeEY3TElkUFRUMWYwVWVzNzZWV3dQ?=
 =?utf-8?B?L3J2dDF2bU5SN1IxNFlvS0RWZ04zNWJvWm12bzY5Z2M3bkFnMHFiY041U0lN?=
 =?utf-8?B?Z2FoQWFoVGtjRjBKWlFBZjl5M05EemJVa1paL2lJU2ppQXc4R3VkM1hwdUF6?=
 =?utf-8?B?cXZELzYrejJxamwvQXpiV2w2Wng1MTNRVE41WTN5TlRFaElBbXZwb0lmaHVF?=
 =?utf-8?B?WjZadDNVbTBiTnZhQkRxQWxtcU1UWTNFYjFkekM5OHFpSzRYbGxBRVBYVDJB?=
 =?utf-8?B?RG8vWXd4VVVsaDBnaUhuM3Bac1dmYkMwWHpqY1lZL2NiREszKzZVckxjdnds?=
 =?utf-8?B?NERZd1V4dmhhdmE1TUU2enFDcUtqZ0ltT0YwL3l1R3FiNnlpektiQi95bHEw?=
 =?utf-8?B?V2NtWXdhb2ZsVXNWNURlZDg2VmswbTJHL0Z4ZmdjeXh3MFRuWnRnQWNZVE5Y?=
 =?utf-8?B?ZHQrdVk5UXRCeGo3MGdHUjlGbWRpZ2E4QXhKZVN0V2VUOHRyOGlYaXlwLzND?=
 =?utf-8?B?K3lnUGFobXhnY1ZLcDF5V2N4T251bG10RmFMTllIc2sxMXlkMW5kYS9sTDRC?=
 =?utf-8?B?REo5OXFlMDIxb2FFVDBQZDN1eVhHTzRBbUxVUTFhTE1VMlVxN0VJTzNVdFcx?=
 =?utf-8?B?ZlcxNVJLaHFDSGg0WHhteFRWNnh2eTFsa2UxUnNPaGtXWTJPbkUxN2x6MG04?=
 =?utf-8?B?cThkV2p0bkZnR2dXY1oyOW1vZU9SSTZ2T2ZYakxEeHBYeUZaV1RaYysvQ2wy?=
 =?utf-8?B?L0kxZHhDaFVMSjFPcW5hZVhPbE5IU3JSTWhOY1pYa3NpdEpPOE1WT0VkbUFk?=
 =?utf-8?B?V1JPVVlxamdkclZuN2krbVo1RU1iMitWVDMyRVVJU2twbUx2SkNka3BDNk5o?=
 =?utf-8?B?SUY0TmhFYmNGb0p2UDJSMk5SdEljMFVjRXZOZEZoU1hxMmxyVTZhU2ZYQis1?=
 =?utf-8?B?b1R6SzduNnU1aXBIeDhZQnh2QWpxMjlrMnVCNWhhRU0xMUtLemFhS1FKQzBn?=
 =?utf-8?B?WjJ6bnVGeHMrUGdJZVRmRWpDSGh2VDJ6ZlZETDVRTzhCYTZEUVkrZlQ3SDJk?=
 =?utf-8?B?cTZMYlFMYTAzNGFWaEN1SG9FQnlENjN1dTI2WFI0eUdhVVRkaGR6NVN2WW9z?=
 =?utf-8?B?c0pxN0F5TnNGbTB2T0JuYkdzSWlsUWdLRzZsamhvcUZ2NVp6ZmJSMHBJNCtu?=
 =?utf-8?B?dFYrRzQ0UmtNNDVtYVhpdzRDM1AxR0RDc3BpazR3cHBBeEhmTXNKNng1dk1q?=
 =?utf-8?B?Vllvcy9kUW52eDdGNDdjK2xQTWVHZVlCOFA3bTJ3S21ycTkzdnplN3F2SE1r?=
 =?utf-8?B?YUR2NzEvU1VFTWVuNjV3Zm16c3FwTmYxaGdta3VvbVBpdjhjdW9RLzBiNWNZ?=
 =?utf-8?B?S0VOVHFLN3BLbU5FM043dDFGaHFxU3V5OEN6RUV6aEdCemFQcUhVeGpRc0Fi?=
 =?utf-8?B?ZVZRSFdxTFByTW41L2M2eXd5MmZJR0ZtV1g2Zng0Nkc2UzZMRkkwQXZoRG1h?=
 =?utf-8?B?L3pkeDdxb1ptZVoxRjVzWkFkUkRuajB5ZmNjTkxmOVczYkdOWjhya3JKUHRY?=
 =?utf-8?B?WnozZ2lrRDdLSE8vV04vUFlsOHVIemxhellrT1BmZ2lSZFJCSnJsZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7227dd-97b2-4524-1dd4-08de906c05b1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 03:57:56.2533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH5A693oqOT6qG4ll7YfFUTFVbSz3dTp0KKvTJ/V4YnYNAahSNU9bshpgzXD5V4jIljpy6of9D3u7Qvh5t2YNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12107
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

On Mon, Mar 30, 2026 at 09:25:48PM +0200, Luca Ceresoli wrote:
> This driver looks up the next_bridge at probe time and stores it in
> hdmi->bridge.next_bridge, but only uses the stored value when attaching,
> and only in the DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> This will be problematic with an upcoming change, adding an hdmi-connector
> using a device tree overlay when not present. That change is in turn
> necessary to migrate the i.MX LCDIF driver to the bridge-connector.
> 
> The problem is that, adding the hdmi-connector via an overlay, devlink
> considers hdmi-connector a consumer of the dw-hdmi device, generating a
> chicken-egg problem:
> 
>  * hdmi-connector probe won't be tried until dw-hdmi is probed (devlink)
>  * dw-hdmi probe will defer until it finds the next_bridge (the
>    hdmi-connector wrapper bridge)
> 
> In preparation for those changes, move the next_bridge lookup from probe to
> attach, when it is actually used. This allows dw-hdmi to probe, so that the
> hdmi-connector can probe as well.
> 
> Also avoid storing the pointer in hdmi->bridge.next_bridge: the value is
> computed when needed, thus a local variable is enough.
> 
> Finally, this also allows to slightly improve the code by not doing any DT
> lookup in the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - Fix returned error codes
> - Added missing cleanup.h include
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++--------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)

Acked-by: Liu Ying <victor.liu@nxp.com>
