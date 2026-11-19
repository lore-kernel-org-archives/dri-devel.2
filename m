Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C7606A330
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.a=rsa-sha256 header.s=selector1 header.b=lS//fLZH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8335112107;
	Thu, 19 Nov 2026 01:38:29 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11022109.outbound.protection.outlook.com [40.107.209.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C4310E1BD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJdkwypsRJWYgB2t8PExiCztpvgCq5lc12FhUu6+96rig/PFmkRxnWJHMjylvoGCZFAqWt0eFtE9/fD1siTjqg7fXIFtwP/mwDY8l0uK1HwLzSvaMwL+QWFk1DyBofe8hKZBeYgGFA+yqBTpMrn3WN+u7W+AdHSQpfQ4MQegGemuBX2tb1uw2gIBoss1qZbC5j0UAP7oxIKm3wji4h7X5aw1uOljy1sqeC72LLxRHPqb07DOA6r/Tja5hw9S3SM5u/dtseIzFiExAHj/BzNJJAHRdqH956Mr1uAKRH05r7N84ZUaq8zH2iCvOdn4eveSdW2+1SA0S1/pHFoISoUAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIenV7ELl3mnuQXOIJlGpihNd/mQ5T2wmzh58drqCsY=;
 b=IqCLCOqgThORFq1ygSypZTFF5R5/OLhzhQttjFrXxGk1Zc9OStZ87vakMdIxVn1Ci36DffHtyu1h7BnPC8aTlRK03P6C3g9S6Rrguo25QjMa95oYxBYIyYzJjMvNfGLo8sUKWTCIsafL++qPk37tqtf006diuAAQST+BQlSn4hPGtfwH+C0Di5C4l+S1o3d9guHxQZcvw5wmLeiP4NKXbn0q6sojCOcfWTJQTjv2q380WUP76iY7SAdSbWQNJtLaCmL3wtnxKXuKCXTZu/o5t66ckip+avFJsovnj3MOAXyQ+6aa2PIAhLhXmR7uxkbAbLTvi1FkwP2l84c1iBkd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIenV7ELl3mnuQXOIJlGpihNd/mQ5T2wmzh58drqCsY=;
 b=lS//fLZHs+XBJgINKfLahrdg/bW6T7abDK+8Odr87fJ1d+5MtSER697g9eQrzIl+9t9vjPLvstfNTSHJAafybMhTL1hebS3cEgrlANay8E3wljHzTOG+IMiKpFbJrDf3cSs6jADad+aShdeJ9+RqIppKaeg9AlOFsv/RfbHdMX4=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by DS0PR04MB9343.namprd04.prod.outlook.com (2603:10b6:8:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 01:38:17 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%3]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 01:38:17 +0000
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
Thread-Index: AQHddXOSgLVf+Ga7cE6z6iDm0vvV9bcwiTeAgAAGhtCAA0vRAIAAxonQ
Date: Thu, 19 Nov 2026 01:38:17 +0000
Message-ID: <DM6PR04MB697003C1254E147D36E9B2BDC7792@DM6PR04MB6970.namprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|DS0PR04MB9343:EE_
x-ms-office365-filtering-correlation-id: 1c06a954-bf72-4246-dcbf-08df45ddc8f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|261102123227099003|38070700021|261022115727099003|56012099006|4143699003|261026130827099003|261026121527099003|261026140227099003|10067099003|261026135527099003|261021130227099003|261021123027099003|261022105027099003|261021133027099003|261022075727099003|261021121427099003|261028144727099003|261022113327099003|261021135927099003|261009223027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: oOVzaOeWmQVW3cucYW3L7M//p3VfM20qS+RvoIudWbjRP/XAG9rCu3tIqIblka7oR69575gdqge85LqgZoIjmpogePjS8hFwEb7ZEoCYRh2kB0JzZf0LqUX14AV8y9Oul4Y8Ql3aWguTrb3eSom0V+FmB5Xv1Gke4jMcpQq4AQe7vQfOWPzN3fAYVvYBytAvX4juMfcuZr9n0M8/D1N9+rAOvV9NvQA7KDc3XxSLaeExV/afZyxQ0s2iQM0quXh4PQ1kZHHDZK6nQiz5QB2VxpoHUx80O4FkU9PsJDtKabogSx33CraQSzg8TH86pJ8C2UlKKv5d9FHRbJeaiBN4OcSUNaNJE6Buo4+1hXmIpgbSEkH7jPdZ+/kOvDFsgd7tMY3xH5pg+QJeyeH7moI/6JCXK9F8lWaHP409ZaVMc53kKEd3JpAanpkWcAYSpoJK8cwQ+gyjiiWw8J5zVKqnAWo7S1kL6afYxZoCEmteJgvn7tqNuLhq2UDqyNuzC32Rvd0+Di4Xm4HnzjRKiSCpbqT8wbMuzV2Wt9lissxarFDBIRtqEbqShdYcL0mcKonJjtsSXz1/O8xkI98IgLJxuzgnS+EQrkGKN1a4DHVU/mCPVlk3128VpY/R1VpYZachfnY1i2wkmV3tIE8EZJres7UrUyGwT89DGpmLtPs7xnWi/DSxKS8NXs4MfzIj3qwg+LNfOITfiZa4m/D3ipDYgDMzfjUol2ek725SGcsOcHgODR5QFH3HRc1bC8obsWRB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(261102123227099003)(38070700021)(261022115727099003)(56012099006)(4143699003)(261026130827099003)(261026121527099003)(261026140227099003)(10067099003)(261026135527099003)(261021130227099003)(261021123027099003)(261022105027099003)(261021133027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261022113327099003)(261021135927099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7k0qTyARPvLSS3Vk9FQSI6bI7VVoe+sXNHXrkR5U09+43PFY7Exbbkuf6Ne2?=
 =?us-ascii?Q?30o7Ft0JsyHQtDZHq0ax6lg1bUcNwo80NE/cna2fbHykyrWOmTRVkdM9K1dh?=
 =?us-ascii?Q?S06NORnL5juqMe/NSd2F+nrX4cQfWh2jR+l2iwkfnirLOCWDa+EWQs7HEAVq?=
 =?us-ascii?Q?ds8bXeleV0kcKWWj8reKSfzEuQFNr7d9dnPm10x3O+n4HWNLedLCHgScEmT8?=
 =?us-ascii?Q?aqPf5tit6M3wyKr6GM+ZUiidfMDZF0Tqwkxtq7OjTtiG0edGKxNkXtX7QfA7?=
 =?us-ascii?Q?abIE+1omcT1pGvsF6DW3xbqjBeAGqUfclxZkb2OvNJ/lBoSDSwxkyG05XuJc?=
 =?us-ascii?Q?APjb5GtIBeykidmkeM7ScjoXy5dAc95iMUXZ6gt2UNPcpHZUILPaJkS3p65r?=
 =?us-ascii?Q?7OCsU0NQQy71VflQNTEBlc7MWJonB62Q6pqcQx1qnOeUwaKjuzot9qLiCdXk?=
 =?us-ascii?Q?XTjcwt3Zp83CqJXoAVO9uDX6LvZTk1VlFCD07aJVgKsJIlpDrPuvZlx4OEsM?=
 =?us-ascii?Q?j32O6E47wjaCrDm4w//8MV/af6NbKx/0ZyEZrVEZJ/XydR5urvdGH9Yap4KD?=
 =?us-ascii?Q?712LBmOVthiW4nMocidMRBdKXfk+pvgXzX3BUex8cpWDZFXzObDVhdjxsf04?=
 =?us-ascii?Q?yXsUMmygdUfJFJBYlrMqfRJfMxI0OmWYOvIEalVQ27OQ+go6W4xg4pwgwTOH?=
 =?us-ascii?Q?5dBI/+VJEABKgo/35+k0i0aMoYGYZru3Ette35A7xFZcZXjcyBFsHPenNWKN?=
 =?us-ascii?Q?MQHm++aEOok8/LYdMmyZG0mTjYAa80qpiL+o53HwTZfEh9bCZGI4zuOMtBOh?=
 =?us-ascii?Q?EfmdQvQGmKQkvepqEzh71bvp/U96g/DiWdcK6YolnmYldmVuPww+5vQYBgG4?=
 =?us-ascii?Q?CPM0jdW4pMM4cJ7bChTT+0aNA8/ct1QdGzfh9yE5L97MMFgZoTCwxZdPh7No?=
 =?us-ascii?Q?EYDShou/SibQyjeQmjolkgqgbQxZ2Er7LoNDdCTH7uQfRK1c81LpvrROdB65?=
 =?us-ascii?Q?B4eZMOUdUbQbehh3Ju+BhqOjkNZZT3740HfZDciEL992oqdG1AbCpuPAJa3y?=
 =?us-ascii?Q?NOohRzjyk+WJM7LFytcwS1SJGsPjylRnhg2N40Dl8tv7nwJ+wdvwPQprz59A?=
 =?us-ascii?Q?2QykbZYllftbiuCSU9EFc/vxB3bGD0h4QwZWpCx7Rvj59gi6xTMtARp+NXgt?=
 =?us-ascii?Q?cyo1Fvr8F5cobYGpoNHTz6cDschqJngSNYtmsOBqT9HZtgtRFoeJfrsXwKCk?=
 =?us-ascii?Q?Q3MWCz5+glT0HynlHebtj6BeXyb/z6j8Uh9TR/SITGYCYjWSX+p8XGvHmqoi?=
 =?us-ascii?Q?4nD7r+iUSCsnCqrCIdbCaPujJsHDNwqDn7iFP6wK8YTovhuE9Z3ph7mTZxQw?=
 =?us-ascii?Q?YWoObJQgFV0At/gR0BRl2aTZSf/qcNrFJ4pCBgNxVYckli68D1LlnNvwG5vF?=
 =?us-ascii?Q?5TCag7yVi3Z9+DRHCq7l7Zsz+ibjlUrdJV6xxNRFMzo/UxUV6ydXqVFTVLbf?=
 =?us-ascii?Q?zuMDjO50nmjlHI+gqEthBaTga+Y2kqxaBrIjIFchqA4CTACstJy2M0tTLat0?=
 =?us-ascii?Q?77zpfYQSZuU701gJhC8Xccf2NgbXc1RanXtsfrF5fwlVFvN3YICYfif/OTHP?=
 =?us-ascii?Q?F+eQKop5/C8aE4INL9nQrFMuYigoheahyAejGUBHubte2uX+pAcPxyXKXTmH?=
 =?us-ascii?Q?S2h8Pz57vRIbaG5qF51zIE+UwhmqVzHdNhEoAw+PjeSaXqqKZO09Fl2otD9N?=
 =?us-ascii?Q?KIlgLRKzMQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c06a954-bf72-4246-dcbf-08df45ddc8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 01:38:17.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWXEZhl/ailCkHxmhIw7ycQMIOEyIVmzfj9/CijuPuq1oE5l/GPul/dWdBo7an17zJBJZ/P1oFbtREv3HAcWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9343
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

OK, I'll adjust the check, thanks!

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
