Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21289C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FEC10E446;
	Wed, 16 Sep 2026 07:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jolla.com header.i=@jolla.com header.b="QOnjnzQw";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021125.outbound.protection.outlook.com
 [52.101.65.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55FD10E3AA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASqNEYG58AYBJAPabzLr2UYDtWK80X4io4x5qU1ts+BH3EOgVx+J+5xhTuH+MgputnW77WOw8tZZ0v/a3+9vcUOhAMvGogTzAJftbpp1QxgTElCQDTJZThVRtqVO1gsM3+ujaQUX/qZG8ve5d5dLZM46DTd5xur02rZ1RY+XZUdb3/utEH739TzjRua3D4HT6yaMiJptpUQcm7rCc4/43bdDOgDq5NlnibvpOmJytAu/TZJ5Fv5bo1sIDw6rpBsdIzMY+q4SttNoZYBInNxXg6K3iMM5/8yp6EPLwnni3tDs0N3/VGz6ml+XFuKbI+zqxUB0FVlxLDSqU4bbSZtdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjJeg/2uy2nFAOFEfBOD/RF96PbwfXfmiVhNorkA+/0=;
 b=ACuzI+up4n0rGpQkZLcMYNxljw1Fzgj/3AEE3flwai9Ivb5YnpYEtIvCgEEW4WxPHpUv/MJ+eTr+g3+MMwiRtxs+YRbYZ08eHt+rQJdnFI46/FGtlJ2yBL+Qur2SH608ttJhKxvURgwbrPnENgSB8lDgAY49nm6RwE7pZjI+vSIoU+gsJ5c9+dXXAjJjRDD3PYIhBai6nRNEnZt2NCZqnZSOIrwiiGs85x+pvgva/L9ejntgj1slyjGEDVmWcOls4a9gLsMLpUo5045Ugg+DlqbiZQrh4n9mnktrB7l1cfGT9uXtwkQ2pDPoscK9g4oMN1FYfx/97zaDF5hyQEjbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjJeg/2uy2nFAOFEfBOD/RF96PbwfXfmiVhNorkA+/0=;
 b=QOnjnzQwJ4vubysL2F4LyahbyYK0Du95G9GVfBuvuLQT7kDCLOUJGL2mD0U3XgwEVdkXVlCpcQWuC5k8/aaXF77lT88PnnQVPTmlf+muImzm/Tl4aGWjPcJpFACQyNwj9jndgh7Bia886IyRrLfGDPMIIQbzg2p2/l2TJTiygmgjgyWnXboJwufepJOLKusHauiujwKgyUpxw9nbvmQXiu4pf2DQZp4uuMic6sR3ddnK3CnCEKl5kX05abHeJ2pErRrc4oMH5t4WbSxFgDxVtyUADP/iirjUP0LfK7YKra89mh8prjD5VJQpHF0XS1DQ2PxGcKLa4qnnM2M7TTLCVw==
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com (2603:10a6:150:24::20)
 by PA4PR06MB8571.eurprd06.prod.outlook.com (2603:10a6:102:2aa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 13:55:38 +0000
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99]) by GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:55:38 +0000
From: Nikolai Burov <nikolai.burov@jolla.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "jitao.shi@mediatek.com" <jitao.shi@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "justin.yeh@mediatek.com" <justin.yeh@mediatek.com>,
 "jason-jh.lin@mediatek.com" <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
Thread-Topic: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
Thread-Index: AQHdRQqeK2Ypb3mcyEKOw4qUZ3ay3rbPp/cD
Date: Tue, 15 Sep 2026 13:55:38 +0000
Message-ID: <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR06MB8417:EE_|PA4PR06MB8571:EE_
x-ms-office365-filtering-correlation-id: b8d7e154-69e3-45de-ad70-08df133105ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|18002099003|10067099003|3023799007|6133799003|4143699003|22082099003|18092099006|56012099006|38070700021;
x-microsoft-antispam-message-info: /togqCY1UXUFdfXHBKMm3guRMCOA2IdZTbZBjzCkrtAIgkbgJiGraLDPakZFCV2SJDwMBjylrFmWmzhEyMpUmI1qbsmekl5436YHg7KTo3b93ku1Uy0GsNWjoq27L5BntBLcSfimky/MCoOXlwStkfT2rCSOFE6uTw1C8Ius50E0mcFMKzV+xdc1cPjU4irY628IYuI78bVmOA6XShp1//bFQCxaMVdM7INdmH/aKkBFSt7zPp1mjTYsJXzFvqfTGaRSo+RCADxvmt6XjxzVQPFdnIxBjtUNqUVBY5tFAVUmAVThI3zR7zCgNu7jKvUUr8ZqxICf37xGdLMVj0RbJj+PooUOn3Xqjf8NRJ6J4fNl+NUe7b7xbTET36UlmHbDAzdhQqznGvQgB4sZTsqF+iAQ8wTTX2fqx4rE8y52Vg0UGKQYhxQ4mUtmbiv/JnFb5AMahiVPhiWMkSTMgoBrAoKSNhRgnQoz9V3HeOEmCqmgGVh6Yj7a6oKXKHSrTcjbuMTZEqWjjtR17ywFSmLrDj4I2c9qOpZA+Xudne6pmaokL4MMf4L4vdtENMmDNHrvhK6nC5KsHgwRtOoxBUgZBxTU8E6VVmAQh2sdr6wHof+m8LAaTB9snqBONcUE5OfQn8NvS/HPTfvgyLlmPIzig12sF8joQ3yaoc/7HhLVj4Z4kOPY7yO99PL0+Sn5EpUkv/PXJhXiWNrh05E1Q0wTOYqKswSjQRwrwqk8Ej3v3jo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR06MB8417.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(18002099003)(10067099003)(3023799007)(6133799003)(4143699003)(22082099003)(18092099006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9DrqKCREn9jOaNUQjsiIBR6mcX6/XXZzY0TNyyWDpEw/uU0UEo3mkLXxLx?=
 =?iso-8859-1?Q?Xoz95k19AhSV9wgcPIcKHvI2+ZU+gIFzWPVd8Ee/7w4z2XBGejtAe/+dZn?=
 =?iso-8859-1?Q?wjXhujYeUt2Pw0yao7PXrW1/4j4QwkxPbKcpju4CryVO+ZmBGymqJ7W8hE?=
 =?iso-8859-1?Q?adchR4YJzBlAzjpn/pvr2QUfc/eNtIoYtCMljyfPAjAZvb5H6EpV2/Qud0?=
 =?iso-8859-1?Q?jKERJOnvKl+pLCi9mIh4ZBfPt0pLQNoQoDslslW+dJDJJgz6AYu8spJksp?=
 =?iso-8859-1?Q?dNHdEZRd7oaU6a8CAwyZ8cjNipAIKuwCXdEBi99WN8mB6K2gvF7pDCJ/W1?=
 =?iso-8859-1?Q?26XGHnp1jnJKv6bJdQwXL4ak9w+j0kkPAip/oZhnASsxr2UyAcdIT2WxYF?=
 =?iso-8859-1?Q?SOfQRX4bN+Hx2z3UXTZiG4P3ZWtwdIJsGOtlXmEPnnRw75h+mXO5o62KK+?=
 =?iso-8859-1?Q?jDMBWpKvOhWoOMeEUGdpBkwNn7uf5grbp4a3DHDjFDW9+qK1r/erW+woAa?=
 =?iso-8859-1?Q?8M5L72bCKq9+3BwXhROFbXNh51KMH6RGACtEVIHWPO8Kn6WYUc9dc5PXnY?=
 =?iso-8859-1?Q?h/F/+ko+o8pBFd9KnfaRZt5gBZmop8bu37w+g0vj6CA7OpMltUYX8HwZi0?=
 =?iso-8859-1?Q?OAR3hLGF0oYrvdjJEppZCi9hXehCIVJD2QTyF4ZRS8lt4nGM8JWkbydReQ?=
 =?iso-8859-1?Q?Gfylu090r5EMQEXC5DFYGak4rO5kdDw8eBcAu39rCLaAttQTDb/iNbTvd1?=
 =?iso-8859-1?Q?/RQ/fk028rUu9qPrr87g0C1/2Fxk4kf/kxVreqa84ncGGkwWQZvdmvR0lr?=
 =?iso-8859-1?Q?jut7BR+IIXY+OhCgc+C87oXakmVlDJYVm7KD9QBq1JcuzHyvzQmtRM44wB?=
 =?iso-8859-1?Q?I8JtHiI/Rn/rBEuGNZoAheyMDc6NKDHWSxRT5FkYUemEHx2SquPlOkgfLL?=
 =?iso-8859-1?Q?GFrFO5TOoumHjfDWGJmdDg1lTZ9HCYj8ZGz4kCd4rUF8XRwq2b8sNiuUAF?=
 =?iso-8859-1?Q?X0sw6YS+gw/LlT127Lspy9zwooTJNcqlkjQmf933G1kwIqiXuYWaYVpLjx?=
 =?iso-8859-1?Q?zeG6gh+tC9/wBnfOzzwMuc4VDBhRR+MIvuPJw/B/N8wbgNUkrvVda+miit?=
 =?iso-8859-1?Q?AYsP/Lf8fGF9df/vAVPzUjwBxTLO8WY/7Yj47Brp2zMTP7O0cW15dGxeLQ?=
 =?iso-8859-1?Q?j7Ggot44JuAXslY+PfC5wTakDp/EmtFKulybfnPFpcLK4heCwvgg1tjtBu?=
 =?iso-8859-1?Q?2fyqnBxFL6Nu8HoyvP466v+6HdvEZ8aK/ZHB4ZigDoN4kaHtudWclc60JD?=
 =?iso-8859-1?Q?iJXmvEG5ctsuVv1U+MX6BI9mfAfgeqXONG3mclytkru1yOjAyi0BFXXLU1?=
 =?iso-8859-1?Q?gb2CLuUyeOheFZZ0TvCVtq1Es+20nJmems2s654VNWmvbHH0nkwLGIMwsu?=
 =?iso-8859-1?Q?QQJJrFcvxEXP5I4cfs/ncFHLim7j3Foc2FJwSVyviWlOCV0fCcIdbZW5RO?=
 =?iso-8859-1?Q?PLVQy1AhYBH5g78wFIfCg0bPM7r6/xTvKmfWWAHDZdQ9hZkfmq5u3RcFah?=
 =?iso-8859-1?Q?cVUA98UHaszRkB6ViRlBzAaqrYmNdJX+zeaURdbC7xrcYN6bWD1gqasNTu?=
 =?iso-8859-1?Q?0G7ZZAy2JWjLnxwYAI7oQuMdNnoEZJJD47jaz0FAJoSSWfdstMBcpr7IdR?=
 =?iso-8859-1?Q?gSdpNSN3T/jyP2xF5T1AQWa83ON59K1KO4xfZJ+b++GLUBaTbH7g2giHXR?=
 =?iso-8859-1?Q?3+FHZd3qnvmG58xJ/2WqyQagLRs4HZUabsFvx2TnslnTkluwR53M8e2xEm?=
 =?iso-8859-1?Q?vMAhOWVNXzFyL+I2uXX95GZmm4SmiaMqRJH6zlXz5F1Ez3M/vwGmxeCZEB?=
 =?iso-8859-1?Q?dU?=
x-ms-exchange-antispam-messagedata-1: lO2jMic7PiLLGA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8417.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d7e154-69e3-45de-ad70-08df133105ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 13:55:38.3658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHByvR8gRa7ZbLAQS4EGb9sBI231Fn5J4icrLWHKq1eZbNzQE0g82jvzt56KT3ANSTWV/N2Pdm+ho/jEmbTOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB8571
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

(Sorry for the resend, I made a mistake with the formatting and the recipie=
nt list)=0A=
=0A=
On 9/15/26 11:41 AM, AngeloGioacchino Del Regno wrote:=0A=
> Add a real driver for the Display Stream Compression (DSC) Display=0A=
> Controller IP, implementing support for DSC v1.1 to v1.2.=0A=
> =0A=
> In order to do this, it was necessary to remove the basic DSC IP=0A=
> bypass setup from mtk_ddp_comp: this functionality is retained in=0A=
> the new mtk_disp_dsc driver, which checks if DSC was actually=0A=
> requested by other components (with the only one that currently=0A=
> supports this being DSI) and, if not, it will set BYPASS mode in=0A=
> the DSC IP.=0A=
> =0A=
> Like before, the BYPASS mode is set before starting the DSC IP,=0A=
> but unlike before, this is being done in the component start=0A=
> callback instead of the config one.=0A=
> Notably, the config callback is called by mtk_crtc always=0A=
> immediately before the calling start callback, so the order of=0A=
> register writes is retained.=0A=
> The only real difference is that now this is being done through=0A=
> CPU writes instead of CMDQ, but since that's called only once=0A=
> and since it's just three registers, the performance impact will=0A=
> not be minimal and not even measurable.=0A=
> =0A=
> As anticipated, DSC handling was also introduced in the mtk_dsi=0A=
> driver: when performing dsi_host_attach, the driver now checks=0A=
> if the DSI panel adds the DSC configuration structure to the=0A=
> mipi_dsi_device structure and, if it does, it will store a=0A=
> pointer in the driver-local mtk_dsi structure's `dsc` member.=0A=
> =0A=
> The DSI driver will then check whether the DSC configuration=0A=
> that comes from the panel is valid (in regard to MediaTek DSI)=0A=
> and will call the DRM API's DSC helpers to calculate and set=0A=
> all of the const and RC parameters for the actual DSC setup.=0A=
> =0A=
> For the time being, even though the latest MediaTek SoCs do=0A=
> support DSC v1.2, only DSC v1.1 pre-scr support is implemented=0A=
> as an initial contribution (which is rather big, and 1.2 would=0A=
> make it even bigger - but that can anyway be implemented later).=0A=
> =0A=
> As a last step for validation of DSC parameters in DSI, a check=0A=
> for the hdisplay against DSC slice sidth and one for vdisplay=0A=
> against DSC slice height was added to the mode_valid callback,=0A=
> making sure that H/V are, as expected, multiples of slice W/H.=0A=
> =0A=
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>=0A=
=0A=
Hello,=0A=
=0A=
I have been testing previous versions of this patch on an MT6858 device=0A=
with a DSC-only panel. Since I spotted a few issues with the code, I=0A=
decided to leave a few comments here even though I am not a maintainer.=0A=
Some of them are already mentioned in the Sashiko report.=0A=
=0A=
[...]=0A=
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c=0A=
> index 97e3ff412e6e..c0a53c153b8d 100644=0A=
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c=0A=
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c=0A=
> @@ -22,6 +22,7 @@=0A=
>  =0A=
>  #include "mtk_crtc.h"=0A=
>  #include "mtk_ddp_comp.h"=0A=
> +#include "mtk_disp_drv.h"=0A=
>  #include "mtk_drm_drv.h"=0A=
>  #include "mtk_plane.h"=0A=
>  =0A=
> @@ -344,6 +345,8 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_=
crtc)=0A=
>  	struct drm_connector *connector;=0A=
>  	struct drm_encoder *encoder;=0A=
>  	struct drm_connector_list_iter conn_iter;=0A=
> +	struct mtk_ddp_comp *comp_dsi =3D NULL, *comp_dsc =3D NULL;=0A=
> +	struct drm_dsc_config *dsc_cfg;=0A=
>  	struct drm_device *dev =3D mtk_crtc->base.dev;=0A=
>  	unsigned int width, height, vrefresh, bpc =3D MTK_MAX_BPC;=0A=
>  	int ret;=0A=
> @@ -398,6 +401,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)=0A=
=0A=
This is inside a for loop that skips the last item:=0A=
=0A=
    for (i =3D 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {=0A=
=0A=
>  		if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))=0A=
>  			mtk_mutex_add_comp(mtk_crtc->mutex,=0A=
>  					   mtk_crtc->ddp_comp[i]->id);=0A=
> +=0A=
> +		/* For now, only single DSI is supported */=0A=
> +		if (mtk_crtc->ddp_comp[i]->id >=3D DDP_COMPONENT_DSI0 &&=0A=
> +		    mtk_crtc->ddp_comp[i]->id <=3D DDP_COMPONENT_DSI3)=0A=
> +			if (!comp_dsi)=0A=
> +				comp_dsi =3D mtk_crtc->ddp_comp[i];=0A=
> +=0A=
> +		if (mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC0 ||=0A=
> +		    mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC1)=0A=
> +			if (!comp_dsc)=0A=
> +				comp_dsc =3D mtk_crtc->ddp_comp[i];=0A=
=0A=
If DSI is the last component, it would never be considered as a=0A=
candidate for DSC setup. Shouldn't this be in a loop that covers all=0A=
components?=0A=
=0A=
>  	}=0A=
>  	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))=0A=
>  		mtk_mutex_add_comp(mtk_crtc->mutex, mtk_crtc->ddp_comp[i]->id);=0A=
> @@ -413,6 +427,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)=0A=
>  		mtk_ddp_comp_start(comp);=0A=
>  	}=0A=
>  =0A=
> +	/* Setup the DSC if present, with the config coming from DSI */=0A=
> +	if (comp_dsc && comp_dsi) {=0A=
> +		dsc_cfg =3D mtk_dsi_get_dsc_config(comp_dsi->dev);=0A=
> +		if (dsc_cfg)=0A=
> +			mtk_ddp_comp_dsc_setup(comp_dsc, dsc_cfg);=0A=
> +	}=0A=
> +=0A=
>  	/* Initially configure all planes */=0A=
>  	for (i =3D 0; i < mtk_crtc->layer_nr; i++) {=0A=
>  		struct drm_plane *plane =3D &mtk_crtc->planes[i];=0A=
[...]=0A=
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c=0A=
> new file mode 100644=0A=
> index 000000000000..090f0609a14c=0A=
> --- /dev/null=0A=
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c=0A=
[...]=0A=
> +=0A=
> +#define DISP_REG_DSC_DBG_CON		0x60=0A=
> +#  define DSC_CKSM_CAL_EN		BIT(9)=0A=
> +=0A=
> +#define DISP_REG_DSC_OUTBUF		0x70=0A=
> +#  define DSC_OBUF_SIZE			GENMASK(11, 0)=0A=
> +=0A=
> +#define DISP_REG_DSC_PPS(x)		(0x80 + (x * 4)) /* 0..19 */=0A=
=0A=
This causes an operator precedence bug when you use=0A=
DISP_REG_DSC_PPS(8 + i) below. Wrap the argument in parentheses:=0A=
=0A=
#define DISP_REG_DSC_PPS(x)        (0x80 + ((x) * 4)))=0A=
=0A=
> +#  define DSC_P0_UP_LINE_BUF_DEPTH	GENMASK(3, 0)=0A=
> +#  define DSC_P0_BPC			GENMASK(7, 4)=0A=
> +#  define DSC_P0_BPP			GENMASK(17, 8)=0A=
> +#  define DSC_P0_RCT_ON			BIT(18)=0A=
> +#  define DSC_P0_BLOCK_PRED_EN		BIT(19)=0A=
[...]=0A=
> +static void mtk_dsc_pps_setup(struct mtk_dsc *disp_dsc, struct drm_dsc_c=
onfig *dsc_cfg)=0A=
> +{=0A=
> +	struct drm_dsc_rc_range_parameters *rcrp =3D dsc_cfg->rc_range_params;=
=0A=
> +	u16 *rbt =3D dsc_cfg->rc_buf_thresh;=0A=
> +	u32 data;=0A=
> +	int i, j;=0A=
> +=0A=
> +	/* PPS 0 - Note: Fractional BPP is not supported! */=0A=
> +	data =3D FIELD_PREP(DSC_P0_UP_LINE_BUF_DEPTH, dsc_cfg->line_buf_depth);=
=0A=
> +	data |=3D FIELD_PREP(DSC_P0_BPC, dsc_cfg->bits_per_component);=0A=
> +	data |=3D FIELD_PREP(DSC_P0_BPP, dsc_cfg->bits_per_pixel);=0A=
> +	data |=3D DSC_P0_RCT_ON | DSC_P0_BLOCK_PRED_EN;=0A=
> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(0));=0A=
> +=0A=
> +	/* PPS 1 */=0A=
> +	data =3D FIELD_PREP(DSC_P1_INITIAL_XMIT_DELAY, dsc_cfg->initial_xmit_de=
lay);=0A=
> +	data |=3D FIELD_PREP(DSC_P1_INITIAL_DEC_DELAY, dsc_cfg->initial_dec_del=
ay);=0A=
> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(1));=0A=
> +=0A=
> +	/* PPS 2 */=0A=
> +	data =3D FIELD_PREP(DSC_P2_INITIAL_SCALE_VALUE, dsc_cfg->initial_scale_=
value);=0A=
> +	data |=3D FIELD_PREP(DSC_P2_SCALE_INCR_INTERVAL, dsc_cfg->scale_increme=
nt_interval);=0A=
> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(2));=0A=
=0A=
Is RC_MODEL_SIZE omitted here on purpose?=0A=
=0A=
> +=0A=
> +	/* PPS 3 */=0A=
> +	data =3D FIELD_PREP(DSC_P3_SCALE_DECR_INTERVAL, dsc_cfg->scale_decremen=
t_interval);=0A=
> +	data |=3D FIELD_PREP(DSC_P3_FIRST_LINE_BPG_OFFSET, dsc_cfg->first_line_=
bpg_offset);=0A=
> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(3));=0A=
[...]=0A=
> +=0A=
> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)=
=0A=
> +{=0A=
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);=0A=
> +	u32 dsc_slice_w, dsc_slice_h, dsc_mode, dsc_cfg_rval, dsc_shadow;=0A=
> +	u32 dsc_dbg_con, dsc_con, dsc_enc_width, dsc_pic_w, dsc_pic_h;=0A=
> +	u32 pic_group_width, pic_height_ext_num, slice_group_width;=0A=
> +	u32 chunk_size, dsc_pad_num, dsc_pre_pad_sz;=0A=
> +	bool dsc_en_bit;=0A=
> +=0A=
> +	pic_height_ext_num =3D dsc_cfg->pic_height + dsc_cfg->slice_height - 1;=
=0A=
> +	pic_group_width =3D (dsc_cfg->slice_width * 4) / 3;=0A=
> +	slice_group_width =3D (dsc_cfg->slice_width + 2) / 3;=0A=
> +=0A=
> +	if (dsc_cfg->slice_chunk_size)=0A=
> +		chunk_size =3D dsc_cfg->slice_chunk_size;=0A=
> +	else=0A=
> +		chunk_size =3D dsc_cfg->slice_width * dsc_cfg->bits_per_pixel / 8 / 16=
;=0A=
> +=0A=
> +	dsc_enc_width =3D FIELD_PREP(DSC_ENC_WIDTH_PIC, dsc_cfg->pic_width) |=
=0A=
> +			FIELD_PREP(DSC_ENC_WIDTH_SLICE, dsc_cfg->slice_width);=0A=
> +=0A=
> +	dsc_pic_w =3D FIELD_PREP(DSC_PIC_GROUP_WIDTH_M1, pic_group_width - 1);=
=0A=
> +	dsc_pic_w |=3D FIELD_PREP(DSC_PIC_WIDTH, dsc_cfg->pic_width);=0A=
> +	dsc_pic_h =3D FIELD_PREP(DSC_PIC_HEIGHT_EXT_M1, pic_height_ext_num - 1)=
;=0A=
> +	dsc_pic_h |=3D FIELD_PREP(DSC_PIC_HEIGHT, dsc_cfg->pic_height - 1);=0A=
> +=0A=
> +	dsc_slice_w =3D FIELD_PREP(DSC_SLICE_GROUP_WIDTH_M1, slice_group_width =
- 1);=0A=
> +	dsc_slice_w |=3D FIELD_PREP(DSC_SLICE_WIDTH, dsc_cfg->slice_width);=0A=
> +	dsc_slice_h =3D FIELD_PREP(DSC_SLICE_WIDTH_MOD3, dsc_cfg->slice_width %=
 3);=0A=
> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_NUM_M1,=0A=
> +				  (pic_height_ext_num / dsc_cfg->slice_height) - 1);=0A=
> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_HEIGHT_M1, dsc_cfg->slice_height =
- 1);=0A=
> +=0A=
> +	dsc_pad_num =3D (3 - ((chunk_size * 2) % 3)) % 3;=0A=
> +	dsc_pad_num =3D FIELD_PREP(DSC_PAD_NUMBER, dsc_pad_num);=0A=
> +=0A=
> +	dsc_pre_pad_sz =3D FIELD_PREP(DSC_PIC_PREPAD_HEIGHT, dsc_cfg->pic_heigh=
t);=0A=
> +	dsc_pre_pad_sz |=3D FIELD_PREP(DSC_PIC_PREPAD_WIDTH, dsc_cfg->pic_width=
);=0A=
> +=0A=
> +	dsc_mode =3D FIELD_PREP(DSC_INIT_DELAY_HEIGHT, 4);=0A=
> +	dsc_mode |=3D FIELD_PREP(DSC_RGB_SWAP, 0);=0A=
=0A=
This register has a field called SLICE_MODE (bit 0) that should be set=0A=
when there is more than one slice. Since the code above already=0A=
configures the slice count, this should probably be enabled. (Maybe only=0A=
some SoCs require it, but I wasn't able to get it working on MT6858=0A=
without this.)=0A=
=0A=
> +=0A=
> +	/* Must enable checksum calc in DBG if enabling core checksum in CFG */=
=0A=
> +	dsc_cfg_rval =3D DSC_CFG_ICH_EN | DSC_CFG_CRC_EN | DSC_CFG_DSC12_BUGFIX=
 |=0A=
> +		       DSC_CFG_CORE_CHECKSUM;=0A=
> +	dsc_dbg_con =3D DSC_CKSM_CAL_EN;=0A=
> +=0A=
> +	if (dsc_cfg->bits_per_component =3D=3D 8)=0A=
> +		dsc_cfg_rval |=3D FIELD_PREP_CONST(DSC_CFG_FLATNESS_DET_THRES,=0A=
> +						 DSC_CFG_FLATNESS_8BITS);=0A=
> +	else=0A=
> +		dsc_cfg_rval |=3D FIELD_PREP_CONST(DSC_CFG_FLATNESS_DET_THRES,=0A=
> +						 DSC_CFG_FLATNESS_10BITS);=0A=
[...]=0A=
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c=0A=
> index f82506e10fd5..97b8a91874f5 100644=0A=
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c=0A=
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c=0A=
> @@ -18,6 +18,8 @@=0A=
>  #include <video/mipi_display.h>=0A=
>  #include <video/videomode.h>=0A=
>  =0A=
> +#include <drm/display/drm_dsc.h>=0A=
> +#include <drm/display/drm_dsc_helper.h>=0A=
>  #include <drm/drm_atomic_helper.h>=0A=
>  #include <drm/drm_bridge.h>=0A=
>  #include <drm/drm_bridge_connector.h>=0A=
> @@ -71,11 +73,12 @@=0A=
>  =0A=
>  #define DSI_PSCTRL		0x1c=0A=
>  #define DSI_PS_WC			GENMASK(13, 0)=0A=
> -#define DSI_PS_SEL			GENMASK(17, 16)=0A=
> +#define DSI_PS_SEL			GENMASK(19, 16)=0A=
>  #define PACKED_PS_16BIT_RGB565		0=0A=
>  #define PACKED_PS_18BIT_RGB666		1=0A=
>  #define LOOSELY_PS_24BIT_RGB666		2=0A=
>  #define PACKED_PS_24BIT_RGB888		3=0A=
> +#define COMPRESSED_PS_DSC		5=0A=
>  =0A=
>  #define DSI_VSA_NL		0x20=0A=
>  #define DSI_VBP_NL		0x24=0A=
> @@ -203,6 +206,7 @@ struct mtk_dsi {=0A=
>  	struct drm_bridge bridge;=0A=
>  	struct drm_bridge *next_bridge;=0A=
>  	struct drm_connector *connector;=0A=
> +	struct drm_dsc_config *dsc;=0A=
>  	struct phy *phy;=0A=
>  =0A=
>  	void __iomem *regs;=0A=
> @@ -393,9 +397,35 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi=
)=0A=
>  	writel(regval, dsi->regs + DSI_TXRX_CTRL);=0A=
>  }=0A=
>  =0A=
> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)=0A=
> +static void mtk_dsi_ps_control_dsc(struct mtk_dsi *dsi, bool config_vact=
)=0A=
> +{=0A=
> +	const struct mtk_dsi_driver_data *data =3D dsi->driver_data;=0A=
> +	const u16 *reg_main =3D dsi->driver_data->reg_main;=0A=
> +	const short dsi_buf_bpp =3D 3;=0A=
> +	u32 ps_wc;=0A=
> +=0A=
> +	/* Word count */=0A=
> +	ps_wc =3D FIELD_PREP(DSI_PS_WC, 2 * dsi->dsc->slice_chunk_size);=0A=
=0A=
This assumes that there are exactly two slices. That is often the case,=0A=
but the number of slices may vary depending on the width. I think this=0A=
would be a good place to use dsi->dsc->slice_count.=0A=
=0A=
> +=0A=
> +	if (config_vact) {=0A=
> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),=0A=
> +		       dsi->regs + reg_main[DSI_VACT_NL]);=0A=
> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);=0A=
> +	}=0A=
> +=0A=
> +	/* Always use DSC Pixel Stream type */=0A=
> +	writel(ps_wc | FIELD_PREP(DSI_PS_SEL, COMPRESSED_PS_DSC),=0A=
> +	       dsi->regs + reg_main[DSI_PSCTRL]);=0A=
> +=0A=
> +	if (data->has_size_ctl)=0A=
> +		writel(FIELD_PREP(DSI_HEIGHT, dsi->vm.vactive) |=0A=
> +		       FIELD_PREP(DSI_WIDTH, (ps_wc + dsi_buf_bpp - 1) / dsi_buf_bpp),=
=0A=
> +		       dsi->regs + reg_main[DSI_SIZE_CON]);=0A=
> +}=0A=
> +=0A=
> +static void mtk_dsi_ps_control_uncompressed(struct mtk_dsi *dsi, bool co=
nfig_vact)=0A=
>  {=0A=
> -	u32 dsi_buf_bpp, ps_val, ps_wc, vact_nl;=0A=
> +	u32 dsi_buf_bpp, ps_val, ps_wc, size_val, vact_nl;=0A=
>  =0A=
>  	if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)=0A=
>  		dsi_buf_bpp =3D 2;=0A=
> @@ -430,6 +460,21 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, =
bool config_vact)=0A=
>  		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);=0A=
>  	}=0A=
>  	writel(ps_val, dsi->regs + DSI_PSCTRL);=0A=
> +=0A=
> +	if (dsi->driver_data->has_size_ctl) {=0A=
> +		size_val =3D FIELD_PREP(DSI_HEIGHT, dsi->vm.vactive);=0A=
> +		size_val |=3D FIELD_PREP(DSI_WIDTH, dsi->vm.hactive);=0A=
> +=0A=
> +		writel(size_val, dsi->regs + DSI_SIZE_CON);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)=0A=
> +{=0A=
> +	if (dsi->dsc)=0A=
> +		mtk_dsi_ps_control_dsc(dsi, config_vact);=0A=
> +	else=0A=
> +		mtk_dsi_ps_control_uncompressed(dsi, config_vact);=0A=
>  }=0A=
>  =0A=
>  static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)=
=0A=
> @@ -565,26 +610,68 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(s=
truct mtk_dsi *dsi)=0A=
>  	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);=0A=
>  }=0A=
>  =0A=
> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)=0A=
> +static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)=0A=
> +{=0A=
> +	struct drm_dsc_config *dsc =3D dsi->dsc;=0A=
> +	struct device *dev =3D dsi->host.dev;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (dsc->bits_per_pixel & GENMASK(3, 0)) {=0A=
> +		dev_err(dev, "Fractional bits_per_pixel not supported\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	if (dsc->bits_per_component !=3D 8) {=0A=
> +		dev_err(dev, "%u bits per component is not supported\n",=0A=
> +			dsc->bits_per_component);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
=0A=
Any reason why this wouldn't support 10bpc? The rest of the code seems=0A=
to handle it fine.=0A=
=0A=
> +=0A=
> +	dsc->simple_422 =3D false;=0A=
> +	dsc->convert_rgb =3D true;=0A=
> +	dsc->vbr_enable =3D false;=0A=
> +=0A=
> +	drm_dsc_set_const_params(dsc);=0A=
> +	drm_dsc_set_rc_buf_thresh(dsc);=0A=
> +=0A=
> +	ret =3D drm_dsc_setup_rc_params(dsc, DRM_DSC_1_1_PRE_SCR);=0A=
> +	if (ret) {=0A=
> +		dev_err(dev, "Cannot find DSC RC params\n");=0A=
> +		return ret;=0A=
> +	}=0A=
=0A=
The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, not=0A=
DRM_DSC_1_1_PRE_SCR, and the panel on my test device requires that even=0A=
though it uses DSC v1.1. This may be a panel-specific problem, but have=0A=
you tested this with any actual panels that need 1_1_PRE_SCR?=0A=
=0A=
> +=0A=
> +	dsc->initial_scale_value =3D drm_dsc_initial_scale_value(dsc);=0A=
> +	dsc->line_buf_depth =3D dsc->bits_per_component + 1;=0A=
> +=0A=
> +	return drm_dsc_compute_rc_parameters(dsc);=0A=
> +}=0A=
> +=0A=
> +static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)=0A=
>  {=0A=
>  	struct videomode *vm =3D &dsi->vm;=0A=
> +	int ret;=0A=
>  =0A=
>  	writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);=0A=
>  	writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);=0A=
>  	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);=0A=
>  	writel(vm->vactive, dsi->regs + DSI_VACT_NL);=0A=
>  =0A=
> -	if (dsi->driver_data->has_size_ctl)=0A=
> -		writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |=0A=
> -			FIELD_PREP(DSI_WIDTH, vm->hactive),=0A=
> -			dsi->regs + DSI_SIZE_CON);=0A=
> -=0A=
>  	if (dsi->driver_data->support_per_frame_lp)=0A=
>  		mtk_dsi_config_vdo_timing_per_frame_lp(dsi);=0A=
>  	else=0A=
>  		mtk_dsi_config_vdo_timing_per_line_lp(dsi);=0A=
>  =0A=
> -	mtk_dsi_ps_control(dsi, false);=0A=
> +	if (dsi->dsc) {=0A=
> +		ret =3D mtk_dsi_set_dsc_params(dsi);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +=0A=
> +		mtk_dsi_ps_control(dsi, true);=0A=
> +	} else {=0A=
> +		mtk_dsi_ps_control(dsi, false);=0A=
> +	}=0A=
=0A=
I don't quite understand what is going on here, even in the original=0A=
driver before this patch. What is the point of setting VACT_NL twice?=0A=
Does mtk_dsi_ps_control() really need to be called in mtk_dsi_poweron()=0A=
if mtk_dsi_config_vdo_timing() ends up calling it a second time?=0A=
=0A=
If the order is not important, perhaps this would be cleaner:=0A=
=0A=
mtk_dsi_poweron()=0A=
 - mtk_dsi_config_vdo_timing()=0A=
   - set VSA_NL, VBP_NL, VFP_NL, VACT_NL, SIZE_CON=0A=
   - mtk_dsi_set_dsc_params()=0A=
   - mtk_dsi_ps_control_{dsc|uncompressed}()=0A=
   - mtk_dsi_config_vdo_timing_per_{frame|line}_lp()=0A=
=0A=
One problem is that mtk_dsi_config_vdo_timing_per_frame_lp() currently=0A=
doesn't take DSC into account when computing ps_wc, resulting in wrong=0A=
timings.=0A=
=0A=
Another problem is that the data rate calculation in mtk_dsi_poweron()=0A=
is also unconditionally using the bits-per-pixel value from the color=0A=
format. To get a correct frame rate with DSC, it would need to do=0A=
something similar to dsi_adjust_pclk_for_compression() in=0A=
drivers/gpu/drm/msm/dsi/dsi_host.c.=0A=
=0A=
Other than that, the DSC support seems to work well so far. Thank you=0A=
for the useful contribution!=0A=
=0A=
Best regards,=0A=
Nikolai=0A=
=0A=
P.S.: I can try to push my changes and workarounds to a git tree if=0A=
needed.=
