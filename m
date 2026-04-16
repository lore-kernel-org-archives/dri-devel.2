Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2228F433F7
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE9E10E189;
	Thu, 16 Apr 2026 06:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ovG4Cwqw";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010061.outbound.protection.outlook.com [52.101.228.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C3F10E189
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHfnkjEmI9Pgd2OGFZYSmJoq2GyrNesJkX/mkX3PNvZjD93U7w94kfckSDk7TltAxJTfoEgi/5+d2qO1pkszb7NaNZtSdwaCHEWSpouFjUVO179IPjQr2tlaKJ6HQm0M6SjCFBrykJdXJBUnxI0G2jQE2LdTrVJDUMgcKZWw+BP7camL2ujj32Z/DrUYnsOQYIonSTipgqOwphxQp55rwOXuCJTNaEDabl1eFag2tpBievSRSittKhTxbjfVJP9nILSf1Pxvt4joMFWmS35GniSgVPxDxDrI/SSyZdWAomU/o13rAFYLiYFWxbFyxZARdDMbo9ZRv3hql5lcZ0idGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etoio207zBXWGaQ9BtJwfVMu65Or1UoHf/8KNt1tr8s=;
 b=xu310kcK1cH01CnLXITIKk+L7xtYmBGZsKe2nD8arp/q5JAHrEID4g+CWAy0vRY8jAa2rqvslXSmPGoEPgCmnI9R1FpycArUs38Zw2o1d1hW43mVHZoD99X9cYI92zyf0GfJuBGXqwz1qCF/DM357h2ua/9tKMNywtq3EK1G6VLRGrpgDkSWOfKICgTeuV/yAv0lgSXnSEWf+xxwq+AY7Z9Vy2CROJxxFUmd1PB+pG+TxWbCZb8Slyfo2wSsQ5pgPMrRrv7/Z0IVfVLC1cvbcnq1f1h2HMLnyk2exAVu+mJvn3zPBEMFFoX02bMpmJIrBRLDC5D8knqeZOh+E6etqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etoio207zBXWGaQ9BtJwfVMu65Or1UoHf/8KNt1tr8s=;
 b=ovG4CwqwlNC8/Da23nTKRjQNWWxL7/QvXhhT0CV3qwmPwXhTKZH5kTYk25ikrV6GATxTyVYJEppgD9zFZSiVltS90bSY8EzeZ74+28j81P0L/T6i0JwsmQkZkntiY5gH/yfDmZy5PuSoi4f2qdBPP6XeCPZtP8i35fZ9wKmaZ9o=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB10181.jpnprd01.prod.outlook.com (2603:1096:400:1ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 06:02:08 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 06:02:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: Chris Brandt <Chris.Brandt@renesas.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Sam Ravnborg <sam@ravnborg.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
 <biju.das.au@gmail.com>
Subject: RE: [PATCH v3 0/3] Improvements on RZ/G2L MIPI DSI driver
Thread-Topic: [PATCH v3 0/3] Improvements on RZ/G2L MIPI DSI driver
Thread-Index: AQHcwDJBy4atFmyM2UamT3/YAnHUnbXhTH5Q
Date: Thu, 16 Apr 2026 06:02:01 +0000
Message-ID: <TYCPR01MB11332B9E11788D4988B62143886232@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB10181:EE_
x-ms-office365-filtering-correlation-id: b847005a-6889-4427-5a98-08de9b7dad68
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EmcFHpA57VVEcNBsIyhmkPP4OxmJckWsOeH1Hf4uK5jVl9u/IH/Kb/5IqKdq73R8PhfQhcig0mUdA4Vl9jXnNEklt2iD9/GRCDkVaD/PAAvlutyuJnAJoHR6Jl0CKVHO9SN3OK4xL/7YR5OQYPhSasJseCDHF6khLCWPYM9ZXFZDDXarGdMZQ9WBBLRUUBJ44vz3YPxKaUP5B4kB/YWCOA+MXARb0wwFRZf6TMHKtXKaP+McMZ/yeUVOJ4I+4KmM6XlX9Hd3SalBIcLbe6Ab3y8ZjAN38HMUoqoXR1e0bjWdfQektEqNh2zI36OH5FKpf+8HTTKtHzQ9NV/VV4UgN/ZkSRUKdMh3LacAwOhiWcryu9Lt1O3YjmYcdZC6y/eQ3tknF+qLmkVZC2Z6jXJDRaThJRd5Sfb56FluOmtX3QwrWZEl0tjaE5j+bLLHHP/Me+lqRyyroHFZVVsDQ6JfuCoZXFGXeZZDgeDTRLNhyJt5ok6UMD+6kjUuVtsyq0C53s0ThuoOERmiZ0VrmnxqPDr3ClfDl8Ryf6bpbJ4lDl/cIXCqSe5liL7Pz8KJ2wB836XmYTLHMBOyD35gnkR+UE4TjbqmrZL+Agi3aDa90hKDu9K8lPDWIz0Hx/RdeatfS01i/OzKzW5KhG8LU58oyBiq0s0DG2+zc9OUSNLUi7eTemIIMuLEYmiWpgL9PcKaZDJRC08J8+jhuABRammNy180TJ3fBOOvZV1Qpq+RsaUVGM0SGKTGuxPGbD7OdS0CJ0v88jemSKXFK82/yC4/ADMzjDb6oIMID9Cw+C3Ixt0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11332.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/1fxsLufOsKFcds77hwVP7k7AxmekgN7i5huY8HGyMRexAhAVGRMjF803JX?=
 =?us-ascii?Q?v2D/hDVM83kvwEXGvbbzt5qCRUjOlOo0gxyJR9lrk3XAHgAqugwgfDgLp0kU?=
 =?us-ascii?Q?9+BDjsmAl3qhC/IUT/anYmRSyID8hJtVqdJ4a0ynQvlwlg1uaotlA4dBADwF?=
 =?us-ascii?Q?WAJO3gnHiWY2LRTXh15gB0u29HiW3biAtlXGjR81m1xtURu3FNCdDlcSd2R6?=
 =?us-ascii?Q?hDngNLFOebv3pLwnH2IAb1byPBJmFPDEy0HDGSlxovZDlIXyrdi+jCAssF/A?=
 =?us-ascii?Q?cqklgdlxkxmyxFb1IY6e14fSlkm+1z6EIHkz6ee+sL62LE2v+Q2bPRN4oKGi?=
 =?us-ascii?Q?6EwCi94vihn1v+cySQtCt8ahqLJlbQzbVZ5WavvURqCLOd/wmqjVLjO/F28h?=
 =?us-ascii?Q?fy6HrOn+51j9FdqlTlaSBvgBFd01tRA2lss9Ndv6xqC1o0IR9Oxjp8/1UKZr?=
 =?us-ascii?Q?oJCfMg545MbeEfTl8LWn3xoL3fWbW/Iww0uWOC1g1QbMIN1V3YCTbH5ZaeU5?=
 =?us-ascii?Q?QUsRyJY/4NRfjIImNHtoAsC3tWrJYXSsdJt4f+vRmXgrpRkNpgdPJzVD3GME?=
 =?us-ascii?Q?yHuYMsxcP4t4svwdoQ5AFKBXClw8eJBLKrggfqiTxfKsGogTdfMY9hfx7pPU?=
 =?us-ascii?Q?KyfuqE5Jg0A9aeZPNaRNttXHLOH5E8/trOW/QMIZvAXngZCQ8SicfIJFhE5F?=
 =?us-ascii?Q?AfWR6r3cv/N2SF+wagpar/Wlrqkv+EdgDWpeoZ51xmoydBogvSLxOM53d1aN?=
 =?us-ascii?Q?01qvbYOIoVs/RmyPvEuIZwG47oQ0WUZR33D07mYsjko44cs2YLLadnz0/LwF?=
 =?us-ascii?Q?4Qx7z+04rcnx35nffEuOJ6lmKNhPRNu56RyS5R9gykTENYyRRKqYAR9CelV/?=
 =?us-ascii?Q?Wbb39hV7haI4b9VpeNry0PYwZcVgtR88XdTKUhY0d9Eh5gr1qbMFim4tMHO1?=
 =?us-ascii?Q?4rODSjtmQuGIGWX/W1+D8PJYERt6WfXGSKJvNNgGzl5XPoOMgYeE3RzW66Un?=
 =?us-ascii?Q?yZz+GaWy/zvbZJIQ1ed1m9kph4cNkbSD5bSl3HsFYCzSJU2l/Fby2QVbGnD9?=
 =?us-ascii?Q?S+Q6ZJps06hdHPRd4e4a7vnt+HRRwqK5HcIFJHGGh8YxWS7bPPFZ3Jxci4+G?=
 =?us-ascii?Q?OrTo3nS2e6SlzVX4iTs4B68lKM5/PgcATZWxJ8ZUKV55KdA0vccOYl0w/GAN?=
 =?us-ascii?Q?v0KF2fTUkDDly56D3r+w/+Lank34DhC1q66QthXhnlxjz8S8XHp9CFEz52cf?=
 =?us-ascii?Q?QCoRDNmwIsxmFMLZamsFhZcgjl/rFOMWwS6oAi73wyjCKi2lbbTQSVZXBjCR?=
 =?us-ascii?Q?QfRNKvr+GF1dFwaKGOd9xKLGOLeZYd9SgHqaGTNjbTLVG/8j0UG2f4k7rw8R?=
 =?us-ascii?Q?GWWYjrOhMAJTdxSqFMSBxUfQZxUlN7IudsWMpzIsr+nmjKWRFELdKFjZl1gF?=
 =?us-ascii?Q?trmBmOJ416sYcilJq/k/Aqb0thOYMQ0Q53m320yZvy8DfpKDIG10AqH58X77?=
 =?us-ascii?Q?+EafuBDSDBZUsWPcj9E59KSOjDvcsdYHf/B8ZLD+z9+hBLBeM8K/nNKNrBQy?=
 =?us-ascii?Q?BIk9Ent47moLzFyJlwn19nrQt5yhZ0vVlrGjqcOv0Twa4p9LZpmLNVxwN2JG?=
 =?us-ascii?Q?0qsNXKqqCWZDRmBmVj0GPF898Brrtv8DWQVMDp9KvSfvoDtzrTX996w0ktNn?=
 =?us-ascii?Q?EzcIw50CzPzmxSgcTWBakYgkwovre9gZz075X8x4eWLL57bTf9EXiMv2m51k?=
 =?us-ascii?Q?Cdx9H/0jlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b847005a-6889-4427-5a98-08de9b7dad68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 06:02:01.5457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZwsFwjd7kIbydlSJdnzIRq4rnNehyQ+rA1SKCbSlc9BXq1GN+54PMMJLuDuzB5Xw46OPvg1WuhyzHqGYNapue/hj572Tuag6RhX3JSp8po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10181
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

Hi,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 30 March 2026 11:45
> Subject: [PATCH v3 0/3] Improvements on RZ/G2L MIPI DSI driver
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> Enhance the RZ/G2L MIPI DSI driver based on section "34.4.2.1 Reset" of t=
he RZ/G2L hardware manual
> Rev.1.50 May 2025. According to this section, it is required to wait >=3D=
 1 msec after deasserting the
> CMN_RSTB signal, and writing to DSI PHY timing registers and LINK registe=
rs should be done before
> deasserting CMN_RSTB.
> Additionally, the hardware manual suggests display timing settings should=
 be done after the HS clock is
> started.
>=20
> v2->v3:
>  * Merged patch#2 and patch#3 to avoid breakage.
>  * Moved the patch from patch#4 to patch#2.
>  * Added fixes tag for patch#2.
>  * Updated commit description for patch#2 and patch#3.
> v1->v2:
>  * Updated commit header and description
>  * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_start=
up()
>  * Moved the check before calling reset_control_deassert(), so that it wi=
ll be
>    skipped for RZ/V2H SoC
>  * Added fixes patch for moving rzg2l_mipi_dsi_set_display_timing()
>  * Added fixes patch for assert of CMN_RSTB signal
>=20
> Biju Das (3):
>   drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()
>   drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay
>   drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert of CMN_RSTB signal
>=20
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20

Applied to drm-misc-next.

Cheers,
Biju
