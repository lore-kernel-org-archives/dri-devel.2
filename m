Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBF8C982C7
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9854210E78E;
	Wed, 16 Sep 2026 07:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jolla.com header.i=@jolla.com header.b="tIRHTTkh";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023124.outbound.protection.outlook.com
 [40.107.159.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D981F10E2EC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUY2Rnh2SEWIk/IOj7cyuoK2NlcOFFdkBoEX6Rg2FlqMoUwb0dfXIuD2/5JHDCW9fdQS5sZpyjjqm4q8JKhqo/YaVyGSoxoYCmlXEjWq6/QoAPs39lEIO71t09s5gpOMqFZafF4pd+VWYvux73LGw5uqesf6BBsy4Us6JvrFe1FIp5nHrphLUzCpDeO0ADYoTkvUlRzEd9bL1R7s8K+F7Ed6Tyz/x01DqLkBDqL9nz9RR+i3dU/rdVtaIZPfkGX2Uvd3JKhnlKtMmDx1aWkASPSQPgcpC5m7M8TZIObtrj68sCHn1RJvUXosTokV4W719hRzuPf3xMfeuCTBOdmu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKFK6UKUFnBDThSG5fGTqyiAfQBoEcCXqzSvcmKsvlA=;
 b=reeqSaEeboucXL36chUt5avp/goOd0377GOLsW06Qe60cueZ+TjKGvlJ2DE4nKZN5j0p/e0soSmVw8ipB0MIfpEub8A19DKyIqKAA/Sd6mHCKM8tMfM4L3u+MF2akohIGJeXutKdP6btjZ4019dFDe1PhKIcozB1MAj4c4KDKDii6jCsnA/z1SVCUToR8q9MGdN8/rMW4M0T+w80jsSg+arItWcpFgnV9y07FnKjsTenXPQsrp8/gNzbKlQyeFS6EBRfeFk2ozNibHV589zXXIhonuAMBlmO+DNs0beHR2Z2yNL7AyZC8RCZn0n4gVtkt61TkQqKUzX0StgLRdH41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKFK6UKUFnBDThSG5fGTqyiAfQBoEcCXqzSvcmKsvlA=;
 b=tIRHTTkhnP3ZYlGdut5SZXWURGRoCHbA//xiXDrwSMDaDvGo8aI3hQXcq3uM7/7UYpXwaiSwiBmKe9yEFNSVH3xmihB4MiDtloTCWVCzUbXJTsXahN2XA2B+f/gm/aGuqY5tsPSRpkwJrZ6zPeJAwwipewI0A/8CCj+kPiGGkA0Ph3K6XkGyhUP6hiMN5rs4pt1q8RF6TUT7xCiNaCYsjLGwV7kpie+cxOR5uVcNfVeL+y2Qi6wmD0HtGYm39H3gTtYUTC3z43U6RCoAQ3deOigWq5nk7jUIy+56rHoLJZG4vrmHiHCzWG/oF2M9UqzR8ewROiOp8aX39xlXMTIs7A==
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com (2603:10a6:150:24::20)
 by MRWPR06MB10612.eurprd06.prod.outlook.com (2603:10a6:501:94::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:37:27 +0000
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99]) by GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:37:27 +0000
From: Nikolai Burov <nikolai.burov@jolla.com>
To: "nikolai.burov+review@abscue.de" <nikolai.burov+review@abscue.de>
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
Thread-Index: AQHdRQqeK2Ypb3mcyEKOw4qUZ3ay3rbPpGPH
Date: Tue, 15 Sep 2026 13:37:26 +0000
Message-ID: <GV1PR06MB8417460B8AD5F96A7996BC8EE4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
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
x-ms-traffictypediagnostic: GV1PR06MB8417:EE_|MRWPR06MB10612:EE_
x-ms-office365-filtering-correlation-id: 5565362f-74f0-4cbf-368e-08df132e7b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|10070799003|1800799024|38070700021|56012099006|4143699003|10067099003|22082099003|18002099003|18092099006|6133799003|3023799007;
x-microsoft-antispam-message-info: KtA+IQlcBQRVwbNeFHwvECq5wytUO/goG4yuJbW+uQM5hrFoim8Vvsb/6z9U79I4o/kxmfmgp/b/fqEniNhV2w9/4vB5fPyn5O0eoCRJRvJCohiV81lPP9kez30Vk0bLyR9+GuS/wPiHfyoMhHPJ3+aenalwunMBfyTpR4DWREGr9QhYT4NDTRO7nxVSyElRBnltKYZkR03FLVIy3ANE65tR/dFByFoKaunfPBBsrwu2ubfFpjwCDrGxoi5cDeHULYoeSQuqHNZZrjLbK0ZQuGyxfwqCG26PngA65iRB7bxwGj5hpdwq4Tu+/aIp23KzXXa18EFLsNtFVLOtYGAqWtXQYWKcEc04ohHQNTCIsautbKLtyGLummtAlI9Fq+hCCGu0nSZGJ0ixb1OH2Kven2txXZo2iDTV8uqwDdLt0MBqqXbZxRrV0eGw2kaZmyuGiMTAZbjM4deRzWXFQDU1naRBUCu0OprX5b01cNfRtCoS4pn7EyvNEBK2d69/oVVzH8JloDtFo/RCZpnaUDXb/jMdDra/o3nypu7mqToxRkFz11aAuO2KlDQA1gsnT4B6F4l2fWPikf+IZu60bwFbl2GQzBggPSJuvXcEvZU9+G8ddj2G5j4KG/3ChNvO8E+ipLPZz0Z73Is2hW9vUyxeg0eETCyPYvvBtriMtuCcYEKIlgxFv4f6ot4mtAj6USHs8Quxas4nEwuLk3Nj9HtCZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR06MB8417.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(10070799003)(1800799024)(38070700021)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(18092099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bOpQG6AWoa407PCbAWGqmh4+7OJQLMEDkUSsUsY2YZ1n+0dOa5mV1zdXtn?=
 =?iso-8859-1?Q?bbB3qLlLnrUg+pscP81wyVs66+gZkaf5e34F18igYmogr6PfY6elUhNica?=
 =?iso-8859-1?Q?72ANEqiuSaacoyvxC5fawr8402pGplLe/3RBeXfgbts8b37j0DMoM9hrj5?=
 =?iso-8859-1?Q?NUaIzRdgQGYP0A3s6Esoe3FyEVDLtTuatxiTjqSoDQMsAXvqHTvA4qW9zp?=
 =?iso-8859-1?Q?QQvLZdCa6dmZOZtMDX8ijzUlrmPbziGGGWaDCtKzjNxe0+SHf/v8KrKhMT?=
 =?iso-8859-1?Q?i7mH/kxgJUZhufkSp/kUgSzo8bRaFZfl5Tc0gVzbclTci2Hxn4b+43APJT?=
 =?iso-8859-1?Q?xU5EeF/WtaXbxSRfE5sAycXtpv7Jn1jePjjueSL7WJlo0jJdKK/48ONluV?=
 =?iso-8859-1?Q?9fmReGyXqBAVjSQe/jTX2gZniVSkSc9gx0to0IMvMGPLj4gdpr2TXEbUKH?=
 =?iso-8859-1?Q?rdba+U5mDELCB9Qz8Dbb2WDJJMEzI+U2usb0DrmOGriARmuMPcnHzWmLTE?=
 =?iso-8859-1?Q?n3NHlmlsK0pIjQtNUJP3o3xXzQWuQfSLCb2wxvq5MNJWTxDLQc/NOhr6n1?=
 =?iso-8859-1?Q?sXRZ9DzJGR4cLWBnjdBTE9XM+6Wv3RQxrVRQUHbkJpmg4AToYiUW/KV8Vx?=
 =?iso-8859-1?Q?RDUphbGZ6bbRzov846Of3nWaeb0+k/ZoSQyWyZFcePYkKHk8JbPQXvhrhK?=
 =?iso-8859-1?Q?/xIhIbzSQuoaJW2t8vWKKI20g2nOYbmfChn3I0H0PbRApLyj/nbDNapo2+?=
 =?iso-8859-1?Q?DA5UGsHiSjHYFI8t6bmmo88Df3Zul8cvYeo6oFZuP3bmg6BfKnyJqjk6Oz?=
 =?iso-8859-1?Q?/+zzY9YznMS7D4K5WBCFL9dHgs+FFzqED8OMrnhi8Zp6z3oTgfC/DUywPs?=
 =?iso-8859-1?Q?Fk/0uwf+W78exy/JBQ6lnbkg0pMBchJw504eRBC0eJ+C6OSWYm7vMgxPOU?=
 =?iso-8859-1?Q?N7NfJPzOZ2qkeVc+Rprz9hGOg28dVQ50tSA5s1yIpMM0VomkUyOPA9TipS?=
 =?iso-8859-1?Q?AWDdBHaVLB0X/6BlB+tAGD+IzwvJs0C8QlJhIHbVHTzjBGIT2xiU5KrOXA?=
 =?iso-8859-1?Q?tc9Va8wzQ2gYDmnIjJBudLt8ExC60BoCR9ShQQXs8vrb2sfqlEj+FGOSo1?=
 =?iso-8859-1?Q?LiyVW/b9P8WuNg7BsyuYb1BbT2nNr/kHiT/olSPiNviDgh3TpiB9XZOLzN?=
 =?iso-8859-1?Q?1jLlwMVqIajqp6BhQaxNfOTis0bJzXr3CcUqt/NEARNi6IY0dqVncHo9lS?=
 =?iso-8859-1?Q?HoqImyWl34sk7lKMUItPzoQRwTP+xHFUIdg79ucIoJu2zNLF9Eu9wGfExu?=
 =?iso-8859-1?Q?0WBKFDMofjcBKivboHCKrJxiQF7L0U4oqLBw0HPd8bExWRm7fuNeNApIrH?=
 =?iso-8859-1?Q?2+cXpWPRbczzY0etymCfFsKNCK7U2vCN/ZJRSZ9BalQRQRwQqnSIr8MtY0?=
 =?iso-8859-1?Q?y+SfKpGRxu3mYRYo7bXtA7YmoS6Z4Es8P6r4WablK88IRGVv63UpZOx+HG?=
 =?iso-8859-1?Q?SpnkJj9cAujovH9DdwaFhIuLTsYWN5xvLFsi7u8b3Vc3/6/eYxEixuPnJN?=
 =?iso-8859-1?Q?YkOjmC0XiVrMJEDczYPggpfdaZheVgjufHeNTeX8jIpfYJfx07sz4PCUfs?=
 =?iso-8859-1?Q?4YVO+nVbY/3D+IxhRgyKyjBA/pF3SFER7IKuSVIqy/42XV4EtwdNpgqjWw?=
 =?iso-8859-1?Q?AxqqyU6hciomVKMp11GAmdFDFakbTlJf0rMzc7RQH5zidfvRpeMLflI97J?=
 =?iso-8859-1?Q?zvouXI7FDsHt08HUmI3PNO/LByF8F4wEF47LzzmWKI4hL656Ij7ojTBl2V?=
 =?iso-8859-1?Q?rgVCnyCBjv1oewQg/5LbufY47a8Rx7dpk1SSDQH7vo3S8UNr0oxWQgwpZk?=
 =?iso-8859-1?Q?os?=
x-ms-exchange-antispam-messagedata-1: yNy3aKpdKEk01g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8417.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5565362f-74f0-4cbf-368e-08df132e7b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 13:37:26.9733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqu5c9P7IyAlnea4cp34zQxSYYLIOYStluVw8KXb0JIOjeG75IGboFwBQEO5HNiEA8i1VJrZA93bYHn2K11WHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR06MB10612
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

Hello,=0A=
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
I have been testing previous versions of this patch on an MT6858 device wit=
h a DSC-only panel. Since I spotted a few issues with the code, I decided t=
o leave a few comments here even though I am not a maintainer. Some of them=
 are already mentioned in the Sashiko report.=0A=
=0A=
[...]> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/m=
ediatek/mtk_crtc.c=0A=
> index 97e3ff412e6e..c0a53c153b8d 100644=0A=
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c=0A=
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c=0A=
> @@ -22,6 +22,7 @@=0A=
>   =0A=
>   #include "mtk_crtc.h"=0A=
>   #include "mtk_ddp_comp.h"=0A=
> +#include "mtk_disp_drv.h"=0A=
>   #include "mtk_drm_drv.h"=0A=
>   #include "mtk_plane.h"=0A=
>   =0A=
> @@ -344,6 +345,8 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_=
crtc)=0A=
>   	struct drm_connector *connector;=0A=
>   	struct drm_encoder *encoder;=0A=
>   	struct drm_connector_list_iter conn_iter;=0A=
> +	struct mtk_ddp_comp *comp_dsi =3D NULL, *comp_dsc =3D NULL;=0A=
> +	struct drm_dsc_config *dsc_cfg;=0A=
>   	struct drm_device *dev =3D mtk_crtc->base.dev;=0A=
>   	unsigned int width, height, vrefresh, bpc =3D MTK_MAX_BPC;=0A=
>   	int ret;=0A=
> @@ -398,6 +401,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)=0A=
This is inside a for loop that skips the last item:=0A=
=0A=
    for (i =3D 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {=0A=
=0A=
>   		if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))=0A=
>   			mtk_mutex_add_comp(mtk_crtc->mutex,=0A=
>   					   mtk_crtc->ddp_comp[i]->id);=0A=
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
If DSI is the last component, it would never be considered as a candidate f=
or DSC setup. Shouldn't this be in a loop that covers all components?=0A=
=0A=
>   	}=0A=
>   	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))=0A=
>   		mtk_mutex_add_comp(mtk_crtc->mutex, mtk_crtc->ddp_comp[i]->id);=0A=
> @@ -413,6 +427,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)=0A=
>   		mtk_ddp_comp_start(comp);=0A=
>   	}=0A=
>   =0A=
> +	/* Setup the DSC if present, with the config coming from DSI */=0A=
> +	if (comp_dsc && comp_dsi) {=0A=
> +		dsc_cfg =3D mtk_dsi_get_dsc_config(comp_dsi->dev);=0A=
> +		if (dsc_cfg)=0A=
> +			mtk_ddp_comp_dsc_setup(comp_dsc, dsc_cfg);=0A=
> +	}=0A=
> +=0A=
>   	/* Initially configure all planes */=0A=
>   	for (i =3D 0; i < mtk_crtc->layer_nr; i++) {=0A=
>   		struct drm_plane *plane =3D &mtk_crtc->planes[i];[...]=0A=
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
> +> +static void mtk_dsc_pps_setup(struct mtk_dsc *disp_dsc, struct drm_ds=
c_config *dsc_cfg)=0A=
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
This register has a field called SLICE_MODE (bit 0) that should be set when=
 there is more than one slice. Since the code above already configures the =
slice count, this should probably be enabled. (Maybe only some SoCs require=
 it, but I wasn't able to get it working on MT6858 without this.)=0A=
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
> +=0A=
[...]=0A=
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c=0A=
> index f82506e10fd5..97b8a91874f5 100644=0A=
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c=0A=
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c=0A=
> @@ -18,6 +18,8 @@=0A=
>   #include <video/mipi_display.h>=0A=
>   #include <video/videomode.h>=0A=
>   =0A=
> +#include <drm/display/drm_dsc.h>=0A=
> +#include <drm/display/drm_dsc_helper.h>=0A=
>   #include <drm/drm_atomic_helper.h>=0A=
>   #include <drm/drm_bridge.h>=0A=
>   #include <drm/drm_bridge_connector.h>=0A=
> @@ -71,11 +73,12 @@=0A=
>   =0A=
>   #define DSI_PSCTRL		0x1c=0A=
>   #define DSI_PS_WC			GENMASK(13, 0)=0A=
> -#define DSI_PS_SEL			GENMASK(17, 16)=0A=
> +#define DSI_PS_SEL			GENMASK(19, 16)=0A=
>   #define PACKED_PS_16BIT_RGB565		0=0A=
>   #define PACKED_PS_18BIT_RGB666		1=0A=
>   #define LOOSELY_PS_24BIT_RGB666		2=0A=
>   #define PACKED_PS_24BIT_RGB888		3=0A=
> +#define COMPRESSED_PS_DSC		5=0A=
>   =0A=
>   #define DSI_VSA_NL		0x20=0A=
>   #define DSI_VBP_NL		0x24=0A=
> @@ -203,6 +206,7 @@ struct mtk_dsi {=0A=
>   	struct drm_bridge bridge;=0A=
>   	struct drm_bridge *next_bridge;=0A=
>   	struct drm_connector *connector;=0A=
> +	struct drm_dsc_config *dsc;=0A=
>   	struct phy *phy;=0A=
>   =0A=
>   	void __iomem *regs;=0A=
> @@ -393,9 +397,35 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi=
)=0A=
>   	writel(regval, dsi->regs + DSI_TXRX_CTRL);=0A=
>   }=0A=
>   =0A=
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
This assumes that there are exactly two slices. That is often the case, but=
 the number of slices may vary depending on the width. There is a dsi->dsc-=
>slice_count parameter.=0A=
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
>   {=0A=
> -	u32 dsi_buf_bpp, ps_val, ps_wc, vact_nl;=0A=
> +	u32 dsi_buf_bpp, ps_val, ps_wc, size_val, vact_nl;=0A=
>   =0A=
>   	if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)=0A=
>   		dsi_buf_bpp =3D 2;=0A=
> @@ -430,6 +460,21 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, =
bool config_vact)=0A=
>   		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);=0A=
>   	}=0A=
>   	writel(ps_val, dsi->regs + DSI_PSCTRL);=0A=
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
>   }=0A=
>   =0A=
>   static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)=
=0A=
> @@ -565,26 +610,68 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(s=
truct mtk_dsi *dsi)=0A=
>   	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);=0A=
>   }=0A=
>   =0A=
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
Any reason why this wouldn't support 10bpc? The rest of the code seems to h=
andle it fine.=0A=
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
The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, not DRM=
_DSC_1_1_PRE_SCR, and the panel on my test device requires that even though=
 it uses DSC v1.1. This may be a panel-specific problem, but has this drive=
r even been tested with any actual panels?=0A=
=0A=
> +=0A=
> +	dsc->initial_scale_value =3D drm_dsc_initial_scale_value(dsc);=0A=
> +	dsc->line_buf_depth =3D dsc->bits_per_component + 1;=0A=
> +=0A=
> +	return drm_dsc_compute_rc_parameters(dsc);=0A=
> +}=0A=
> +=0A=
> +static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)=0A=
>   {=0A=
>   	struct videomode *vm =3D &dsi->vm;=0A=
> +	int ret;=0A=
>   =0A=
>   	writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);=0A=
>   	writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);=0A=
>   	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);=0A=
>   	writel(vm->vactive, dsi->regs + DSI_VACT_NL);=0A=
>   =0A=
> -	if (dsi->driver_data->has_size_ctl)=0A=
> -		writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |=0A=
> -			FIELD_PREP(DSI_WIDTH, vm->hactive),=0A=
> -			dsi->regs + DSI_SIZE_CON);=0A=
> -=0A=
>   	if (dsi->driver_data->support_per_frame_lp)=0A=
>   		mtk_dsi_config_vdo_timing_per_frame_lp(dsi);=0A=
>   	else=0A=
>   		mtk_dsi_config_vdo_timing_per_line_lp(dsi);=0A=
>   =0A=
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
I don't quite understand what is going on here, even in the original driver=
 before this patch. What is the point of setting VACT_NL twice? Does mtk_ds=
i_ps_control() really need to be called in mtk_dsi_poweron() if mtk_dsi_con=
fig_vdo_timing() ends up calling it a second time?=0A=
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
One problem is that mtk_dsi_config_vdo_timing_per_frame_lp() currently does=
n't take DSC into account when computing ps_wc, resulting in wrong timings.=
=0A=
=0A=
Another problem is that the data rate calculation in mtk_dsi_poweron() is a=
lso unconditionally using the bits-per-pixel value from the color format. T=
o get a correct frame rate with DSC, it would need to do something similar =
to dsi_adjust_pclk_for_compression() in drivers/gpu/drm/msm/dsi/dsi_host.c.=
=0A=
=0A=
Other than that, the DSC support seems to work well so far. Thank you for t=
he useful contribution!=0A=
=0A=
Best regards,=0A=
Nikolai=0A=
=0A=
P.S.: I can try to push my changes and workarounds to a git tree if needed.=
