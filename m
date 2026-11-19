Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF5606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.a=rsa-sha256 header.s=selector1 header.b=Wa4v7Ep+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CA110E43E;
	Thu, 19 Nov 2026 01:56:04 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022075.outbound.protection.outlook.com [52.101.43.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E51710E43E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQUMQNRy9UE1XkgWTzOIdC4crh6Uxr8/Vs4jpmNK/Df0LkCGeYor1nLJyUYB5oPJ9uqCUortbZBi48VzULXFDQkh3MxcjOTM1Jrx0c/3V+3Qx/bj0Gma2vy+F2EAGVx7etPbUo+RBpgfR1kJyxX8pqtAIR4Hiy5bZ7OA4iOSZwzNGp5p7RWwZoImGo1VBMUYoIvRQVbDF1dEQKGEWp3WAcZ3mLqCXXlyIvY8pNxVMS5W62gASU5pgYX0MKdijonbmkwP2VWifJz1pxidUocTg9PGEE8TLnw+0AyWihWvRyPLkj2fnjkvBxcY0NJzEB4+04gkG9dQ+AK3armgh2buTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQI0pDy3NFQ8x7avcO7CqtUc2cRZLUZS+5RRVtQSUy4=;
 b=fin7xrREZq8v2JI25+6ELf02q8kCfTUYU+NeOlkkKIq3X61kqI+dzfeuAnoGDgnVzJTmiY7WgJPLD/WrEdcDXqkC7qVlxX9BRzo+O0AUg167NUYgcsc0RhyesI/T6h0Ne4MUS0p1042HwJFTyppms6FRJQwGhW86SgGj3drTYFOs8e3ecY5U8Di18bkl7PZbK16kB9jpMY2I4dLWH2DWCwoYPJ/cCAjqptgqoZtejw5IrqzsBoPglxI0bNDdG0GU481K+0ioI0KTltiEbeSlRxMd7dEMHbF9zsxueWDkA+LqDfPSlkfpxvDJq4SVD8AofLt/N0wK/mrPiNdmX6A0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQI0pDy3NFQ8x7avcO7CqtUc2cRZLUZS+5RRVtQSUy4=;
 b=Wa4v7Ep+5VWhT33eLGA4gnRoQABb2KRuZXDM7Oz3vLmH5Wxq3burC2Sk7FlZImFzTVLkbuN8o3EnHlrsjxzadds4FWVKa4p6QmspMJVwomO4feL49slwC1xVT5VbJkCxTUnH5JWKe9Y5N62wI7xqTYGozKQONuf8WI+rEM4CoA8=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by SA1PR04MB166510.namprd04.prod.outlook.com (2603:10b6:806:51b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:55:54 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%3]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 01:55:54 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Xin Ji
 <anx-upstream@analogixsemi.com.cn>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: Bernie Liang <bliang@analogixsemi.com>, Qilin Wen <qwen@analogixsemi.com>, 
 "fshao@chromium.org" <fshao@chromium.org>,
 "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/bridge: anx7625: switch to drm_edid_read_custom()
Thread-Topic: [PATCH] drm/bridge: anx7625: switch to drm_edid_read_custom()
Thread-Index: AQHddXOSgLVf+Ga7cE6z6iDm0vvV9bcwiTeAgAAGhtCAA0vRAIAAyX/w
Date: Thu, 19 Nov 2026 01:55:54 +0000
Message-ID: <DM6PR04MB69708E4AA0DE914158D67E47C7792@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20261116023740.2257699-1-anx-upstream@analogixsemi.com.cn>
 <d1553faf45c5651feefd667a3decb454fc596415@intel.com>
 <DM6PR04MB697059DAFCE167EB7CAE9B43C77C2@DM6PR04MB6970.namprd04.prod.outlook.com>
 <6fab6bf1beef0c38b95f0b3e628237ef2142f5b8@intel.com>
In-Reply-To: <6fab6bf1beef0c38b95f0b3e628237ef2142f5b8@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|SA1PR04MB166510:EE_
x-ms-office365-filtering-correlation-id: 4d65b764-0d5b-4c3b-d630-08df45e03f1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|261009223027099003|18002099003|3023799007|921020|261021135927099003|4143699003|261026135527099003|56012099006|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261021133027099003|261026140227099003|261021121427099003|261022105027099003|261026130827099003|261021130227099003|261022113327099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info: gQ0oN1DuJatX0CVYfC3cv2rUgjIetEHbG5mo+Jov+L8vclTB4VqWJ3D4Gq3xbEc5fMbqv124AdCJhPQAcQZKGsG7FEQ1rYQdI/+LCuqO90gRz789L0HM1kkHxOJraU9xEjUh23rxvARbEx4JbOAOxYdgPuzqlHl0aqzDJ/YsOzdsNYOixDipt3WYDbXCxIqaxbSbexVL27WZZNR6iR874H3Jf+s+HYEXJeOTK0k29EBmWv1pLbYgWk3jAytWOoVKKvCg6n25e7eq+m6RRgbMVGm8fRgOpjy/auWPczj/iHbQ2DXdx0n/dXDu6etmBDK6tROA/e5jdB358I/r+wAxCC61D5BN9uz3lXWoOl/7c5qHFNkxnKX1AUAoXJeSdhqPgelAYDa7M8MMUMygZTu9tU86F5oXFbJNuewivUZ+cFoBgrQtg6hzm9dVgb+IxvuvZtPzsXYmQ3ftscpZu9wIkkwvklaee/FzJvYnQJg3b2iLChgeN/bbVTUFGBB7x0YDvceO1QML9eU83hE2ntIJso5hn6DIJeVdMMIzaeuHDujdrq65x6fnoDnB7IE4PMhpEtHAufFB3qeH70n5HAmZ/cfj71MZoIflj02AZ9EU0+t0D8CeswTicLCC7y60RnHrcfnZ0Vl5Ym185c+ekvLS/FeqCBqWm7FAnFKVielzjTB3zLwsj3uhzx00gtVcEFSgj/xKV7D9dZar0utJ+I4M3jMABUQUBObwhq1jdQJNlX4ajypwIw4gMmFc3DVfIEaU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(3023799007)(921020)(261021135927099003)(4143699003)(261026135527099003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261021133027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261026130827099003)(261021130227099003)(261022113327099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?jUtAMY20poxVdP8kYXfy9z1DLeWeylQ3seerGpNFi/qrJzjNM60AykyX?=
 =?windows-1256?Q?6S1Kep8JD0To82E3S4njJaXWb8wB+kAVHdwwH5rg4LQw99Txhfhcah4h?=
 =?windows-1256?Q?BqysedgOaOT3MyF6jhw1GFJnQUf/+e9OLtVwESbTqlduZOMNt/XUZsQL?=
 =?windows-1256?Q?ojtQlxHKD/79OOktz54rnLA5k//jtXM8akEa9lvx+KqMr1FUSQ9zLq5H?=
 =?windows-1256?Q?DvQ0TT0pHh1QkykZDpyysn2NNlyoveVBBRd+5LUOo4eAjtywEBcF5lV2?=
 =?windows-1256?Q?el8nw/grTkmS1q9HNDKZmrBImEbvG7/jIY/qIOw61yWRTj+aYcYXbflo?=
 =?windows-1256?Q?QQuK3wnGOruAsH22LgJM5hKQJpWJmEz18y6bWnVcNg/Mvo04XFk5BTu3?=
 =?windows-1256?Q?/6dqQUw3wQdcLbXJ+aWDXd3KzsFN+uN3m3oAXwMxjImryR3z+LV7+MLg?=
 =?windows-1256?Q?krr/tEdFgaxsPuUr9v6i2r8celMobR5cR+JvUt8fMXrGjEINWch0jYYR?=
 =?windows-1256?Q?K19oRleWXAYyOUblyvv2SoA00Pd7iQYlKvd16GHqdxrM9fwIpmGLuIKv?=
 =?windows-1256?Q?padlMUR2SfdOWAqcNq/Qimi44FBmolG7LKNzjVX3NZH74Rp8awA55W5X?=
 =?windows-1256?Q?+O+/GnyQ76Yuf9HXL9ySb1NFFkVpZeEze0elHHEksRJ4OeU8c2K6PwlS?=
 =?windows-1256?Q?WMnch2EOLROaW6LrJavE16sxu42xi7UxQqGBDEXeMcUbt6FTAK6vXUdE?=
 =?windows-1256?Q?ZGANjlR/E19p2j/HoRx+454ywm3oa0DbxvxYYiXcCK/w3nX8esJlvHL9?=
 =?windows-1256?Q?jxq2owy9PEdvmGi6Mk8Ynk996IdU1CsMRDLiBxxc7YVRUD4+Bnnx/5u/?=
 =?windows-1256?Q?NlofyoF+rQR1tVI9lxsbXxiMPWEm4EZfSGYfJJe7nRzenviey4G0glkc?=
 =?windows-1256?Q?tLitiuY8DRNMY9Nn+jSDDnjHzgYHXHUa70OeWF0xVMtUlA0uE9fLLrjK?=
 =?windows-1256?Q?TUAUmGpprYCGZvD00Lma5YN6RsnM8aCF/tDdIKwC4v331PT8Prsj/gfe?=
 =?windows-1256?Q?ONGbBDFPRVpOCzdZpv7eBtdyKGDcWelCZ5XA1ylgEyuTK29R4Jgz+TRY?=
 =?windows-1256?Q?Bex2TZrT640RgrXcKstG3yVGuR8RVKQy5YnqWIIuOYa2GEcSp1O8Pg/L?=
 =?windows-1256?Q?/gJe+ij0oi/J3rUsCULAFNe2n9UFWBIoyUk3SA5SYrOUD6F6PNNd7Eo6?=
 =?windows-1256?Q?SaDSeqJ3RxoNmFapfSCMKCLxlOBiQeNpd9cTeSX8R/YA4RRkMYa0mGeT?=
 =?windows-1256?Q?FENJPiIIc7WfpP89oDasc3NZvK1f4VkAm9E328d/xPvdR/sJXgIH+0At?=
 =?windows-1256?Q?Jt1dUoi7Z7etwd4SVNS5GMwPgQMBpFHJv8X7pibh9WsYt4yllK0URmfj?=
 =?windows-1256?Q?dGJH7gi9Qbu+zdfIRAqyPTbMDJn7OfUgmKWBFh0x0l39i219q2hxuTRO?=
 =?windows-1256?Q?u9qvrGv1IK8tGdNoBXN0w0d0UFnjBLHaokX+X+SdhC6HTU38NYLdpoi0?=
 =?windows-1256?Q?tdg60oeCj05++ivYztb/9ypCnnjddGYY2gzf4Kd6XM8OQ+o3KSWSeSQG?=
 =?windows-1256?Q?0agPPjZ2RxIpQHi1nOPYHC9DSZiAEO+DYzFpGZsXxtUZ9+Wd5ePNUGfo?=
 =?windows-1256?Q?ff3feyv/zszgVVydT9KmpdQFgsQrKpggOPHMpE0B2inS8OYwkKX3zWvD?=
 =?windows-1256?Q?dCnbDhR52G6VSlLJRpz7M8Hw/O9Ki31KgR7KuPdsaGi6280i++F9zZr3?=
 =?windows-1256?Q?rXDHzQu2xtHAZ8v7EU+yMK0xuLyZ67F7q3qQvvjjg2rngNpgdGLf7QLi?=
 =?windows-1256?Q?3f8Qlc2ybyZ0uQ=3D=3D?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d65b764-0d5b-4c3b-d630-08df45e03f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 01:55:54.2562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQbc4gOyQTPro1jhyMHLHb1d3faBtjvvhE+vp8pIh0g3aItQfV7OKeJ+CYudHR/IcuPTMaIDQRJg/prnVCSL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB166510
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> >> > From: Xin Ji <xji@analogixsemi.com>
> >> >
> >> > Currently, sp_tx_get_edid_block() only reads the base block
> >> > extension count at 0x7e and ignores CTA-861 HF-EEODB overrides in
> >> > block 1. On displays using HF-EEODB, the driver only reads 2
> >> > blocks, which
> >> > drm_edid_valid() then rejects due to the size mismatch.
> >> > Switch to drm_edid_read_custom() with a per-block read callback so
> >> > DRM core handles block count discovery (including HF-EEODB and >4
> >> > blocks) and validation automatically.
> >>
> >> Yay!
> >>
> >> It warms my heart that the work I put in drm_edid.c to handle
> >> HF-EEODB still keeps paying off, and people can enable the complexity
> >> of it by
> >> *simplifying* the driver code. :)
> >
> > Yes, thanks! The HF-EEODB handling in drm_edid.c has been very helpful.
> > It's great to see it paying off.
> >
> >>
> >> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> >> > ---
> >> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 172 +++++--------------=
---
> >> >  drivers/gpu/drm/bridge/analogix/anx7625.h |   4 -
> >> >  2 files changed, 33 insertions(+), 143 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > index c3af88e14f8b..eb503be005e0 100644
> >> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > @@ -1022,27 +1022,6 @@ static int sp_tx_aux_rd(struct anx7625_data
> >> > *ctx,
> >> u8 len_cmd)
> >> >       return (ret | wait_aux_op_finish(ctx));  }
> >> >
> >> > -static int sp_tx_get_edid_block(struct anx7625_data *ctx) -{
> >> > -     int c =3D 0;
> >> > -     struct device *dev =3D ctx->dev;
> >> > -
> >> > -     sp_tx_aux_wr(ctx, 0x7e);
> >> > -     sp_tx_aux_rd(ctx, 0x01);
> >> > -     c =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> AP_AUX_BUFF_START);
> >> > -     if (c < 0) {
> >> > -             DRM_DEV_ERROR(dev, "IO error : access AUX BUFF.\n");
> >> > -             return -EIO;
> >> > -     }
> >> > -
> >> > -     DRM_DEV_DEBUG_DRIVER(dev, " EDID Block =3D %d\n", c + 1);
> >> > -
> >> > -     if (c > MAX_EDID_BLOCK)
> >> > -             c =3D 1;
> >> > -
> >> > -     return c;
> >> > -}
> >> > -
> >> >  static int edid_read(struct anx7625_data *ctx,
> >> >                    u8 offset, u8 *pblock_buf)  { @@ -1123,18
> >> > +1102,16 @@ static int segments_edid_read(struct anx7625_data *ctx,
> >> >       return ret;
> >> >  }
> >> >
> >> > -static int sp_tx_edid_read(struct anx7625_data *ctx,
> >> > -                        u8 *pedid_blocks_buf)
> >> > +static int anx7625_get_edid_block(void *data, u8 *buf, unsigned
> >> > +int block, size_t len)
> >> >  {
> >> > +     struct anx7625_data *ctx =3D data;
> >> >       u8 offset;
> >> > -     int edid_pos;
> >> > -     int count, blocks_num;
> >> > -     u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
> >> > -     u8 i, j;
> >> > -     int g_edid_break =3D 0;
> >> > -     int ret;
> >> > +     int ret, i;
> >> >       struct device *dev =3D ctx->dev;
> >> >
> >> > +     if (len !=3D EDID_LENGTH || block > 255)
> >> > +             return -EINVAL;
> >> > +
> >> >       /* Address initial */
> >> >       ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> >> >                               AP_AUX_ADDR_7_0, 0x50); @@ -1147,85
> >> > +1124,18 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >> >               return -EIO;
> >> >       }
> >> >
> >> > -     blocks_num =3D sp_tx_get_edid_block(ctx);
> >> > -     if (blocks_num < 0)
> >> > -             return blocks_num;
> >> > -
> >> > -     count =3D 0;
> >> > -
> >> > -     do {
> >> > -             switch (count) {
> >> > -             case 0:
> >> > -             case 1:
> >> > -                     for (i =3D 0; i < 8; i++) {
> >> > -                             offset =3D (i + count * 8) * MAX_DPCD_=
BUFFER_SIZE;
> >> > -                             g_edid_break =3D edid_read(ctx, offset=
,
> >> > -                                                      pblock_buf);
> >> > -
> >> > -                             if (g_edid_break < 0)
> >> > -                                     break;
> >> > -
> >> > -                             memcpy(&pedid_blocks_buf[offset],
> >> > -                                    pblock_buf,
> >> > -                                    MAX_DPCD_BUFFER_SIZE);
> >> > -                     }
> >> > -
> >> > -                     break;
> >> > -             case 2:
> >> > -                     offset =3D 0x00;
> >> > -
> >> > -                     for (j =3D 0; j < 8; j++) {
> >> > -                             edid_pos =3D (j + count * 8) *
> >> > -                                     MAX_DPCD_BUFFER_SIZE;
> >> > -
> >> > -                             if (g_edid_break =3D=3D 1)
> >> > -                                     break;
> >> > -
> >> > -                             ret =3D segments_edid_read(ctx, count =
/ 2,
> >> > -                                                      pblock_buf, o=
ffset);
> >> > -                             if (ret < 0)
> >> > -                                     return ret;
> >> > -
> >> > -                             memcpy(&pedid_blocks_buf[edid_pos],
> >> > -                                    pblock_buf,
> >> > -                                    MAX_DPCD_BUFFER_SIZE);
> >> > -                             offset =3D offset + 0x10;
> >> > -                     }
> >> > -
> >> > -                     break;
> >> > -             case 3:
> >> > -                     offset =3D 0x80;
> >> > -
> >> > -                     for (j =3D 0; j < 8; j++) {
> >> > -                             edid_pos =3D (j + count * 8) *
> >> > -                                     MAX_DPCD_BUFFER_SIZE;
> >> > -                             if (g_edid_break =3D=3D 1)
> >> > -                                     break;
> >> > -
> >> > -                             ret =3D segments_edid_read(ctx, count =
/ 2,
> >> > -                                                      pblock_buf, o=
ffset);
> >> > -                             if (ret < 0)
> >> > -                                     return ret;
> >> > -
> >> > -                             memcpy(&pedid_blocks_buf[edid_pos],
> >> > -                                    pblock_buf,
> >> > -                                    MAX_DPCD_BUFFER_SIZE);
> >> > -                             offset =3D offset + 0x10;
> >> > -                     }
> >> > -
> >> > -                     break;
> >> > -             default:
> >> > -                     break;
> >> > -             }
> >> > -
> >> > -             count++;
> >> > +     DRM_DEV_DEBUG_DRIVER(dev, "Read EDID block %u, len %zu\n",
> >> > + block, len);
> >> >
> >> > -     } while (blocks_num >=3D count);
> >> > +     for (i =3D 0; i < len; i +=3D MAX_DPCD_BUFFER_SIZE) {
> >> > +             offset =3D (block & 1) * EDID_LENGTH + i;
> >> > +             if (block < 2)
> >> > +                     ret =3D edid_read(ctx, offset, &buf[i]);
> >> > +             else
> >> > +                     ret =3D segments_edid_read(ctx, block / 2, &bu=
f[i],
> >> > +                                              offset);
> >> >
> >> > -     /* Check edid data */
> >> > -     if (!drm_edid_is_valid((struct edid *)pedid_blocks_buf)) {
> >> > -             DRM_DEV_ERROR(dev, "WARNING! edid check fail!\n");
> >> > -             return -EINVAL;
> >> > +             if (ret < 0)
> >> > +                     return -EIO;
> >> >       }
> >> >
> >> >       /* Reset aux channel */
> >> > @@ -1235,7 +1145,7 @@ static int sp_tx_edid_read(struct
> >> > anx7625_data
> >> *ctx,
> >> >               return ret;
> >> >       }
> >> >
> >> > -     return (blocks_num + 1);
> >> > +     return 0;
> >> >  }
> >> >
> >> >  static void anx7625_power_on(struct anx7625_data *ctx) @@ -1958,37
> >> > +1868,6 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux
> >> > +*aux,
> >> >       return ret;
> >> >  }
> >> >
> >> > -static const struct drm_edid *anx7625_edid_read(struct
> >> > anx7625_data
> >> > *ctx) -{
> >> > -     struct device *dev =3D ctx->dev;
> >> > -     u8 *edid_buf;
> >> > -     int edid_num;
> >> > -
> >> > -     if (ctx->cached_drm_edid)
> >> > -             goto out;
> >> > -
> >> > -     edid_buf =3D kmalloc(FOUR_BLOCK_SIZE, GFP_KERNEL);
> >> > -     if (!edid_buf)
> >> > -             return NULL;
> >> > -
> >> > -     pm_runtime_get_sync(dev);
> >> > -     _anx7625_hpd_polling(ctx, 5000 * 100);
> >> > -     edid_num =3D sp_tx_edid_read(ctx, edid_buf);
> >> > -     pm_runtime_put_sync(dev);
> >> > -
> >> > -     if (edid_num < 1) {
> >> > -             DRM_DEV_ERROR(dev, "Fail to read EDID: %d\n", edid_num=
);
> >> > -             kfree(edid_buf);
> >> > -             return NULL;
> >> > -     }
> >> > -
> >> > -     ctx->cached_drm_edid =3D drm_edid_alloc(edid_buf, edid_num *
> >> ONE_BLOCK_SIZE);
> >> > -     kfree(edid_buf);
> >> > -
> >> > -out:
> >> > -     return drm_edid_dup(ctx->cached_drm_edid);
> >> > -}
> >> > -
> >> >  static enum drm_connector_status anx7625_sink_detect(struct
> >> > anx7625_data *ctx)  {
> >> >       struct device *dev =3D ctx->dev; @@ -2647,10 +2526,25 @@ stati=
c
> >> > const struct drm_edid *anx7625_bridge_edid_read(struct drm_bridge
> >> > *bridge  {
> >> >       struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> >> >       struct device *dev =3D ctx->dev;
> >> > +     const struct drm_edid *drm_edid;
> >> >
> >> >       DRM_DEV_DEBUG_DRIVER(dev, "drm bridge get edid\n");
> >> >
> >> > -     return anx7625_edid_read(ctx);
> >> > +     if (ctx->cached_drm_edid)
> >> > +             return drm_edid_dup(ctx->cached_drm_edid);
> >
> > The patch will return with drm_edid_dup() if ctx->cached_drm_edid is no=
t
> null.
> >
> >> > +
> >> > +     pm_runtime_get_sync(dev);
> >> > +     _anx7625_hpd_polling(ctx, 5000 * 100);
> >> > +     ctx->cached_drm_edid =3D drm_edid_read_custom(connector,
> >> > +                                                 anx7625_get_edid_b=
lock,
> >> > +                                                 ctx);
> >> > +     drm_edid =3D drm_edid_dup(ctx->cached_drm_edid);
> >>
> >> Consider deduplicating?
> >
> > No need to check it again as the patch checked it before.
>=20
> Obviously you'd remove the check before. Point is, you'd only have *one*
> instance of drm_edid_dup(ctx->cached_drm_edid); and use it on both code
> paths.
>=20
>=20
> >
> >>
> >>         if (!ctx->cached_drm_edid) {
> >>                 // ...
> >>                 ctx->cached_drm_edid =3D drm_edid_read_custom();
> >>                 // ...
> >>         }
> >>
> >>         drm_edid =3D drm_edid_dup(ctx->cached_drm_edid);
> >>
> >>
> >> BR,
> >> Jani.
> >>
> >> > +     pm_runtime_put_sync(dev);

Hi Jani Nikula, just double confirmed the driver, "ctx->cached_drm_edid"
may be freed after "pm_runtime_put_sync(dev)". Therefore, the driver
must call drm_edid_dup() =9Dbefore=9D releasing the runtime PM reference.

> >> > +
> >> > +     if (!drm_edid)
> >> > +             DRM_DEV_ERROR(dev, "Fail to read EDID\n");
> >> > +
> >> > +     return drm_edid;
> >> >  }
> >> >
> >> >  static void anx7625_bridge_hpd_enable(struct drm_bridge *bridge)
> >> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h
> >> > b/drivers/gpu/drm/bridge/analogix/anx7625.h
> >> > index 957d234ec07c..55615ad274f2 100644
> >> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> >> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> >> > @@ -424,10 +424,6 @@ enum audio_wd_len {
> >> >
> >> >  #define MAX_DPCD_BUFFER_SIZE 16
> >> >
> >> > -#define ONE_BLOCK_SIZE      128
> >> > -#define FOUR_BLOCK_SIZE     (128 * 4)
> >> > -
> >> > -#define MAX_EDID_BLOCK       3
> >> >  #define EDID_TRY_CNT 3
> >> >  #define SUPPORT_PIXEL_CLOCK  300000
> >>
> >> --
> >> Jani Nikula, Intel
>=20
> --
> Jani Nikula, Intel
