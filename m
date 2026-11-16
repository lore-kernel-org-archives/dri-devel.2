Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97494606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.a=rsa-sha256 header.s=selector1 header.b=MhdQ/uuJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF87110E2D3;
	Mon, 16 Nov 2026 11:38:30 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11021101.outbound.protection.outlook.com [52.101.52.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47D110E2D3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPPHV+fyiYW6UuWzyEisAdx+Ln6V1BIFKxcV7avw/BgI6udV+EgqvOzADt0DHPU1RvRxRz12wlpw7UKf6lD2n9jkRovL5viBipIguYxBUQ/mt5ldlYpmyRBgZ1sO5q13pZu2AqdSHziRU6LSpwrXXGny8OLXWDh58bCaby4fbFWpwAdo9yR/8cwq8TQw/dmsrs8+nXh0QRu0DeHtGa2pZ105cVsG9g9xfxqRZYijJYXw6l81qI+HmYPffDsMTV225iDxiA7ReW3uj0MZJdfJ6hoSikM4ol0V/LyppDGDYAA4UzP6M4VnwRi5hd9vxqCKHSsNUmRyzJYq5fL1XjXjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RiEvPT551u5fx8VuTUaZwgDYYY8DRTOsZmYQApuzYs=;
 b=yzKY7Z4/pN6buiG8VazunSaIQLAFBAsXqwILg66bCyfH0D0Fwu9+v+FnnemnOQ/BNlAnHdp01lDdTFuy/ggNfhMt8RRCLwzL9UKktjwoHV+R3CVwIiC2n0aXMOqYL6zNDCqlkcwr9hWAcJ9EfPEKs6LBfwiji1UIqi1cQhWsFwQMZlu4Zff5GBMUWwfJ+hD7H1w9bmX0ZxwhwbqpP2+X4cq2OXKHEHfdmH/+DnqI8NONcZ9dWCbd6JZaKEZUhXyhJp+otgKQ+2EwfDFEwAfbiTUonbaJBklB9/6Xjyy9G+o2b0cSpxPH2rSLW65Txjzzpf8M5vMaiHg6/g1oTVUelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RiEvPT551u5fx8VuTUaZwgDYYY8DRTOsZmYQApuzYs=;
 b=MhdQ/uuJRN8YM8ezHVPbC+bLF5ypbI4rieOsbFVXsH4zU0TYrRytPVCwRDdN3PTS0lvKvTnVMzMOoawfUZ/OhfHcVSx1VV+vlrHxNyqVUm6CjmOcanszYei2jSZIaETW5N1OjnoFwNsXJ0yRlSSluSYOi/rX1AKcJy/xj1VxlqU=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by PH0PR04MB7464.namprd04.prod.outlook.com (2603:10b6:510:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:38:20 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%3]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 11:38:20 +0000
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
Thread-Index: AQHddXOSgLVf+Ga7cE6z6iDm0vvV9bcwiTeAgAAGhtA=
Date: Mon, 16 Nov 2026 11:38:19 +0000
Message-ID: <DM6PR04MB697059DAFCE167EB7CAE9B43C77C2@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20261116023740.2257699-1-anx-upstream@analogixsemi.com.cn>
 <d1553faf45c5651feefd667a3decb454fc596415@intel.com>
In-Reply-To: <d1553faf45c5651feefd667a3decb454fc596415@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|PH0PR04MB7464:EE_
x-ms-office365-filtering-correlation-id: 0119822e-dcc3-4e30-d5eb-08df43d61d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|921020|4143699003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261026135527099003|261026130827099003|261021123027099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|261021130227099003|261021133027099003|261022115727099003|261021135927099003|38070700021|10067099003;
x-microsoft-antispam-message-info: jHGTzFKqjVHqj4oV3j1MtNB0lI0cJ6b8pB/0795U3R5nJD6R7BtISbuUw2MP7h76WFpA1f1vbTerIWy1DSTzHsjfDcjALglub3R53muhxGU3HDf2qxiU0n0B+J0u2jenQ+brx4gOk+Q0o3udyZwoqLnczqeN+7SrXJaWo3rkMbVX2Y+/twrMGy6iarZBK+NmATihX2vtpdip1F5BcxOAX5fuxUfO8ytagIbrHPulmlLX77eyhINUuDd4ZRPsK/uWAmpCuXI2/2YAe/lafKjMQuCcZHzfnIjlfzI4T3Aa15Fig7NSmN6Aobt3vqTO8+UOnVGqzWSa3aN5mCn934U+bRweC3CPAlm7Let4NcxExQjrp7zQM3mdf2BSnLddh1ODHl+D60K7ALY9NM80nCj95H4hmHeSWV00g7nke1pxeFZ0fdSuMuZYrwDvt8zpM+W5qyn6lL05rutY4FGFbpoYkZ609AxsQ0OOl4+9/ZDJtT1932glEUIOiB7Mn6ogIX0SrMCVZevR0qKJEizKp2Z0Xn5F6Ml76dlZo3ripGASV98UrtSMiJ3QWLkm0LPYBLsUNgo2/+QBOeOw91KHpNjHveJOdICDoo7UihGd3QokJauitvFXH2JWvi8g83zkJKAdXKooeDTsUm2fNPMWPM0hvjWZT27De2fA3TzG6vAoc9+LNjFeCKA4jWLtj0tdSVX3MYUMWmOmrpHPENVMtQ2RVQ6yaPDWfZ5gs9IkWtYReuw7G/i/toDYVSJUgXGPxF8X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(921020)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261026135527099003)(261026130827099003)(261021123027099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021130227099003)(261021133027099003)(261022115727099003)(261021135927099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xp6j+NlQOjIFJuAQWCg0+J5B+2Ee4pGjNYjjfFOggDknlYGb9RAR7gg8p+BV?=
 =?us-ascii?Q?eT4tqF1dmq3Ym+CmhQ7lahGA7tc3XKdw4e0jxQtcwwcLVqclchMIKhDv2UUg?=
 =?us-ascii?Q?5zbfzIacMIbk2c0RQy31wRiQtEWJPAlmEpGlPh8Dty4449VdN8//0aOp2sRG?=
 =?us-ascii?Q?jI2wanJIqyfI3TLQrHIdgGll9uHIs4uNJWu9OFFhdGlp30mqESzXoo75KYOp?=
 =?us-ascii?Q?YRw+oj0UIccjiUqpI1ewfc5dSXzFwen1umLGy33i5vYOepmnIhIn88K6u87R?=
 =?us-ascii?Q?DyTgc18Nnc5TMkkeE7dWf2XL8Ax0CVpgOTUxxrytRxYuzRY6KfMcQVQiyrpl?=
 =?us-ascii?Q?EN1BdaZgYIsqs9Tmcuzn1gL36EbkVE1+VmP77Azav4DB/GCBKTmle2m0+DkJ?=
 =?us-ascii?Q?G+6eFt+gh70XmvGao69QRQdSdaFhOukeRLAI7rMmvTPQo2+E1Poz2wzpIfBZ?=
 =?us-ascii?Q?q+otfS/boPL+vJ2P21JGTwLHvPFNYvOOzuH37MeTaVQT0X9pEiYWUCDj6r4t?=
 =?us-ascii?Q?4D2SmemqAKFR03izwxVzGvPMblSlb8h8jYUs8xj75SLmHy8+F212/oUoDjo3?=
 =?us-ascii?Q?Aw2zKhyRcttLG9uZX/VZvB9o9H1NgGdHI/wK6TQ3EmJXMk4brOwoh0MUtYj2?=
 =?us-ascii?Q?oOmPlOVbHR+U4ZOLm/x3kjQ+hc4tkW8KwCTtbEoHUwyhp2N8E4h5P+EW1YY3?=
 =?us-ascii?Q?U0Mt6KPYyM33/FeKqc281WXyQ8qRmbIgtf+CvC8JQd1NloiOaIG+SjDOFuZa?=
 =?us-ascii?Q?gs2Xl+AExTIzv6NQFjgf2LUOUMipc0qY6auCBEAMktXJAEVNVJoPdEHIgYLe?=
 =?us-ascii?Q?liQ9yTPb+7ovosrsjYmK9HJMLcYKf02lk3IBglMfXGIT6QCsaA0YsegU7BBx?=
 =?us-ascii?Q?NPZf1EC+W2IjaeIwUrBNKw76CvAhZVzilRxSdiQE0C+4yY6uaww4yD7vIYwC?=
 =?us-ascii?Q?eY4p6mCrrFhpRzMdGFPg8plEZhNxdxUX7fyJbwJD7+iaTIABPK2a/50hDjXJ?=
 =?us-ascii?Q?J71lJVwfuZbTk9i3Oo8rw7ESiG6vauvumK7Idd2PYXWmzhH7BytaaVG+E7RI?=
 =?us-ascii?Q?MHjREKwjdEdRNBBMLJ8zuZjqfR9cexit4DoSABNgXuZ5YtIFKV1aJjCLFJqA?=
 =?us-ascii?Q?FSc/2Ro5sfqr9eqxAK0htFVrgiMAk1An78vW6N7SnF49q8WD9ltVz8xXOG4K?=
 =?us-ascii?Q?O5BI0DWhFjHCTOEhSd3hYX4TrMSn9mNZVdgsOkuYoKVX9BwpUs/lv/lnMNtm?=
 =?us-ascii?Q?Nvq0QccfSsbFSnw3hrKRLJMBNyHFNRvyUpS8Dw/Kh6ecBE5yVdWLSFyqecwf?=
 =?us-ascii?Q?cVpXoMNm3r0sb+YTvp41LgEvx31bD0YtPJtEdzFHggivPK6WKRopbeEi4qyb?=
 =?us-ascii?Q?QiYdezANUFylC9TKGwr7F2dUzRIjkwKTeSwljK+r7GPL/j13NUNw9aUi8uIc?=
 =?us-ascii?Q?dsL/swXSVxxjzbyIv2Bx1D6+knjZlXhoymGccbZ75Ih8A8CElRYa5uvTHCJO?=
 =?us-ascii?Q?H6YQsfgHV2hg/w30wT4bD5sHeD1clAeCno98cZzWIHolBYnfb1pxlY/wroh/?=
 =?us-ascii?Q?Av2Gie/aYSHSv0D+Z4DW4Sj9e2Aqv+wVSey7KvyJEwB1mK3kwP8iK0reDlMI?=
 =?us-ascii?Q?J4d6+lUjRFSNDoSfVIas3GWUmBczWuNTiZ5S7VhVocSgy6CmOmMk6o66blvm?=
 =?us-ascii?Q?55Nf6TlQ37dZE+HGa45U5sOtYtukmaGTTPwR1FHS0rYbrTyixgJE/8fTLPuj?=
 =?us-ascii?Q?Alx1e6HMpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0119822e-dcc3-4e30-d5eb-08df43d61d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 11:38:19.9055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hmogNHkvYRKKSDjQptFoeius7eiEThtiUBd6gdKEinlIFCP1tc6QmBW9+EEhkMSuuCvPykzOZR9hadoUGkn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7464
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

> > From: Xin Ji <xji@analogixsemi.com>
> >
> > Currently, sp_tx_get_edid_block() only reads the base block extension
> > count at 0x7e and ignores CTA-861 HF-EEODB overrides in block 1. On
> > displays using HF-EEODB, the driver only reads 2 blocks, which
> > drm_edid_valid() then rejects due to the size mismatch.
> > Switch to drm_edid_read_custom() with a per-block read callback so DRM
> > core handles block count discovery (including HF-EEODB and >4 blocks)
> > and validation automatically.
>=20
> Yay!
>=20
> It warms my heart that the work I put in drm_edid.c to handle HF-EEODB st=
ill
> keeps paying off, and people can enable the complexity of it by
> *simplifying* the driver code. :)

Yes, thanks! The HF-EEODB handling in drm_edid.c has been very helpful.
It's great to see it paying off.

>=20
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 172 +++++-----------------
> >  drivers/gpu/drm/bridge/analogix/anx7625.h |   4 -
> >  2 files changed, 33 insertions(+), 143 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index c3af88e14f8b..eb503be005e0 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1022,27 +1022,6 @@ static int sp_tx_aux_rd(struct anx7625_data *ctx=
,
> u8 len_cmd)
> >       return (ret | wait_aux_op_finish(ctx));  }
> >
> > -static int sp_tx_get_edid_block(struct anx7625_data *ctx) -{
> > -     int c =3D 0;
> > -     struct device *dev =3D ctx->dev;
> > -
> > -     sp_tx_aux_wr(ctx, 0x7e);
> > -     sp_tx_aux_rd(ctx, 0x01);
> > -     c =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, AP_AUX_BUFF_ST=
ART);
> > -     if (c < 0) {
> > -             DRM_DEV_ERROR(dev, "IO error : access AUX BUFF.\n");
> > -             return -EIO;
> > -     }
> > -
> > -     DRM_DEV_DEBUG_DRIVER(dev, " EDID Block =3D %d\n", c + 1);
> > -
> > -     if (c > MAX_EDID_BLOCK)
> > -             c =3D 1;
> > -
> > -     return c;
> > -}
> > -
> >  static int edid_read(struct anx7625_data *ctx,
> >                    u8 offset, u8 *pblock_buf)  { @@ -1123,18 +1102,16
> > @@ static int segments_edid_read(struct anx7625_data *ctx,
> >       return ret;
> >  }
> >
> > -static int sp_tx_edid_read(struct anx7625_data *ctx,
> > -                        u8 *pedid_blocks_buf)
> > +static int anx7625_get_edid_block(void *data, u8 *buf, unsigned int
> > +block, size_t len)
> >  {
> > +     struct anx7625_data *ctx =3D data;
> >       u8 offset;
> > -     int edid_pos;
> > -     int count, blocks_num;
> > -     u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
> > -     u8 i, j;
> > -     int g_edid_break =3D 0;
> > -     int ret;
> > +     int ret, i;
> >       struct device *dev =3D ctx->dev;
> >
> > +     if (len !=3D EDID_LENGTH || block > 255)
> > +             return -EINVAL;
> > +
> >       /* Address initial */
> >       ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> >                               AP_AUX_ADDR_7_0, 0x50); @@ -1147,85
> > +1124,18 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >               return -EIO;
> >       }
> >
> > -     blocks_num =3D sp_tx_get_edid_block(ctx);
> > -     if (blocks_num < 0)
> > -             return blocks_num;
> > -
> > -     count =3D 0;
> > -
> > -     do {
> > -             switch (count) {
> > -             case 0:
> > -             case 1:
> > -                     for (i =3D 0; i < 8; i++) {
> > -                             offset =3D (i + count * 8) * MAX_DPCD_BUF=
FER_SIZE;
> > -                             g_edid_break =3D edid_read(ctx, offset,
> > -                                                      pblock_buf);
> > -
> > -                             if (g_edid_break < 0)
> > -                                     break;
> > -
> > -                             memcpy(&pedid_blocks_buf[offset],
> > -                                    pblock_buf,
> > -                                    MAX_DPCD_BUFFER_SIZE);
> > -                     }
> > -
> > -                     break;
> > -             case 2:
> > -                     offset =3D 0x00;
> > -
> > -                     for (j =3D 0; j < 8; j++) {
> > -                             edid_pos =3D (j + count * 8) *
> > -                                     MAX_DPCD_BUFFER_SIZE;
> > -
> > -                             if (g_edid_break =3D=3D 1)
> > -                                     break;
> > -
> > -                             ret =3D segments_edid_read(ctx, count / 2=
,
> > -                                                      pblock_buf, offs=
et);
> > -                             if (ret < 0)
> > -                                     return ret;
> > -
> > -                             memcpy(&pedid_blocks_buf[edid_pos],
> > -                                    pblock_buf,
> > -                                    MAX_DPCD_BUFFER_SIZE);
> > -                             offset =3D offset + 0x10;
> > -                     }
> > -
> > -                     break;
> > -             case 3:
> > -                     offset =3D 0x80;
> > -
> > -                     for (j =3D 0; j < 8; j++) {
> > -                             edid_pos =3D (j + count * 8) *
> > -                                     MAX_DPCD_BUFFER_SIZE;
> > -                             if (g_edid_break =3D=3D 1)
> > -                                     break;
> > -
> > -                             ret =3D segments_edid_read(ctx, count / 2=
,
> > -                                                      pblock_buf, offs=
et);
> > -                             if (ret < 0)
> > -                                     return ret;
> > -
> > -                             memcpy(&pedid_blocks_buf[edid_pos],
> > -                                    pblock_buf,
> > -                                    MAX_DPCD_BUFFER_SIZE);
> > -                             offset =3D offset + 0x10;
> > -                     }
> > -
> > -                     break;
> > -             default:
> > -                     break;
> > -             }
> > -
> > -             count++;
> > +     DRM_DEV_DEBUG_DRIVER(dev, "Read EDID block %u, len %zu\n",
> > + block, len);
> >
> > -     } while (blocks_num >=3D count);
> > +     for (i =3D 0; i < len; i +=3D MAX_DPCD_BUFFER_SIZE) {
> > +             offset =3D (block & 1) * EDID_LENGTH + i;
> > +             if (block < 2)
> > +                     ret =3D edid_read(ctx, offset, &buf[i]);
> > +             else
> > +                     ret =3D segments_edid_read(ctx, block / 2, &buf[i=
],
> > +                                              offset);
> >
> > -     /* Check edid data */
> > -     if (!drm_edid_is_valid((struct edid *)pedid_blocks_buf)) {
> > -             DRM_DEV_ERROR(dev, "WARNING! edid check fail!\n");
> > -             return -EINVAL;
> > +             if (ret < 0)
> > +                     return -EIO;
> >       }
> >
> >       /* Reset aux channel */
> > @@ -1235,7 +1145,7 @@ static int sp_tx_edid_read(struct anx7625_data
> *ctx,
> >               return ret;
> >       }
> >
> > -     return (blocks_num + 1);
> > +     return 0;
> >  }
> >
> >  static void anx7625_power_on(struct anx7625_data *ctx) @@ -1958,37
> > +1868,6 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux *aux,
> >       return ret;
> >  }
> >
> > -static const struct drm_edid *anx7625_edid_read(struct anx7625_data
> > *ctx) -{
> > -     struct device *dev =3D ctx->dev;
> > -     u8 *edid_buf;
> > -     int edid_num;
> > -
> > -     if (ctx->cached_drm_edid)
> > -             goto out;
> > -
> > -     edid_buf =3D kmalloc(FOUR_BLOCK_SIZE, GFP_KERNEL);
> > -     if (!edid_buf)
> > -             return NULL;
> > -
> > -     pm_runtime_get_sync(dev);
> > -     _anx7625_hpd_polling(ctx, 5000 * 100);
> > -     edid_num =3D sp_tx_edid_read(ctx, edid_buf);
> > -     pm_runtime_put_sync(dev);
> > -
> > -     if (edid_num < 1) {
> > -             DRM_DEV_ERROR(dev, "Fail to read EDID: %d\n", edid_num);
> > -             kfree(edid_buf);
> > -             return NULL;
> > -     }
> > -
> > -     ctx->cached_drm_edid =3D drm_edid_alloc(edid_buf, edid_num *
> ONE_BLOCK_SIZE);
> > -     kfree(edid_buf);
> > -
> > -out:
> > -     return drm_edid_dup(ctx->cached_drm_edid);
> > -}
> > -
> >  static enum drm_connector_status anx7625_sink_detect(struct
> > anx7625_data *ctx)  {
> >       struct device *dev =3D ctx->dev;
> > @@ -2647,10 +2526,25 @@ static const struct drm_edid
> > *anx7625_bridge_edid_read(struct drm_bridge *bridge  {
> >       struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> >       struct device *dev =3D ctx->dev;
> > +     const struct drm_edid *drm_edid;
> >
> >       DRM_DEV_DEBUG_DRIVER(dev, "drm bridge get edid\n");
> >
> > -     return anx7625_edid_read(ctx);
> > +     if (ctx->cached_drm_edid)
> > +             return drm_edid_dup(ctx->cached_drm_edid);

The patch will return with drm_edid_dup() if ctx->cached_drm_edid is not nu=
ll.

> > +
> > +     pm_runtime_get_sync(dev);
> > +     _anx7625_hpd_polling(ctx, 5000 * 100);
> > +     ctx->cached_drm_edid =3D drm_edid_read_custom(connector,
> > +                                                 anx7625_get_edid_bloc=
k,
> > +                                                 ctx);
> > +     drm_edid =3D drm_edid_dup(ctx->cached_drm_edid);
>=20
> Consider deduplicating?

No need to check it again as the patch checked it before.

>=20
>         if (!ctx->cached_drm_edid) {
>                 // ...
>                 ctx->cached_drm_edid =3D drm_edid_read_custom();
>                 // ...
>         }
>=20
>         drm_edid =3D drm_edid_dup(ctx->cached_drm_edid);
>=20
>=20
> BR,
> Jani.
>=20
> > +     pm_runtime_put_sync(dev);
> > +
> > +     if (!drm_edid)
> > +             DRM_DEV_ERROR(dev, "Fail to read EDID\n");
> > +
> > +     return drm_edid;
> >  }
> >
> >  static void anx7625_bridge_hpd_enable(struct drm_bridge *bridge) diff
> > --git a/drivers/gpu/drm/bridge/analogix/anx7625.h
> > b/drivers/gpu/drm/bridge/analogix/anx7625.h
> > index 957d234ec07c..55615ad274f2 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> > @@ -424,10 +424,6 @@ enum audio_wd_len {
> >
> >  #define MAX_DPCD_BUFFER_SIZE 16
> >
> > -#define ONE_BLOCK_SIZE      128
> > -#define FOUR_BLOCK_SIZE     (128 * 4)
> > -
> > -#define MAX_EDID_BLOCK       3
> >  #define EDID_TRY_CNT 3
> >  #define SUPPORT_PIXEL_CLOCK  300000
>=20
> --
> Jani Nikula, Intel
