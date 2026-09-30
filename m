Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3CCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F02010E4F4;
	Wed, 30 Sep 2026 16:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u53G/ewJ";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D316A10E1D1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMMEBslMaMgbc092uEZPoglWYks9seBGSAGtduhTDXbSpRAW+Jvq9NXCM+snqO8I8n0v7d0deZvJ8MCJMDe/ZETwPM4LCDUK9VJ4CyVW2F+4o8IO8+FD+NsLnoUsLBefhy9hfGaLjHvMeI+eLQiBVsz7aQz1ybu3Knqzq3b5NPno4y0IqgkQZiRrfrEOjkfYovWbtHBNO3iH0A36Ej7/Yy+LddwTq+1qcUdpLs0/1Fps5DoplRsZuHXkzTqTmQ8QM7Hqwse/mDuPbGhkdKcZXTKo0Yxfij5YO+NxatJpWRewwLQD+ZoqBTHYkC1hjmKKwEzXVsbRX5j0lM9ToYSv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eb/4yL2EWy5jS54+rtmevHkFiZ9XMwrjQahzTsfUkg=;
 b=jLhcgin4J9TuoPuZDvfY7ZsUkDEJTZ9r3VivOVKSrYdgRJ5NMNLchRjYXFvXwTeDZmOu2j15skkYmY1q/mv0Y2TUegcSSP+Gk1voMQhdLCRkEkSyZOu11TCdytl10chQj8t/zDBUwn/K0Fd7ByED8c+1m3NUPXcGtpsObpQuWmHNRXTAgMYms3WxfDO7DQi308GEH0m+SvOI4jiYPBvRpRzLw3ffG+F3jmPXpyWuGYG7svnYhZ5s3bH1zDRukCzuGSAtkUeoXJ7gSt+eHw7+9ff3MyjGgJCuXMTR/pdZGOHGejN4hsXdvM5fKo28SJ3z2K232A61+uIycb91EMFYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eb/4yL2EWy5jS54+rtmevHkFiZ9XMwrjQahzTsfUkg=;
 b=u53G/ewJKWLLXySiwb87FBHbunbHYGdrL3J+j0B4meZ66G2o1ts7iWMrrQcBPYSgFPsEsGaodXbHs+z+Ym5/i7o/HU2FMP0cck5sMg+YTIg2a3QNepqfwvi2pN42zmt84dxrAAESfGsI4j6VL54lmHCEPHckEoll0QW5RoQfYQo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14342.jpnprd01.prod.outlook.com (2603:1096:405:247::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 16:39:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 16:39:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
 <magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH v4 7/9] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Topic: [PATCH v4 7/9] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Index: AQHdUOBBTx1djDr0FkqKzabs38ulp7bnThPg
Date: Wed, 30 Sep 2026 16:39:46 +0000
Message-ID: <TY3PR01MB113461A1F24736A8E23A17069868B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260930133257.23210-8-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14342:EE_
x-ms-office365-filtering-correlation-id: f00a2692-21bf-4f8a-27d6-08df1f117050
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: jr48GeWM43pXGpgY7p72vTv8isQPXJhtetDS59p7Ghek8igeRCc2FCB/gAJ5EcOdsFb7XrwscxYe9/Aq5NHoTO6ptvzpRSUDuuei4/Sn1gLTgGn3AFw0DkmGd5SVRloIu8hMoKyXfswpkq7jhKd8be+XQUvEqRmip7VLQTfMZkXLcT0ZmqeCqNcJ6RrlHJxGbyXX2ByKRE3hMuCKtBX2f4lBWirwMWkidDieijCBPl+e/nI5ZfzXqpJUhHP1I+CPr0lbsEA3QSVnCSQmOaakLX3rcyoUlSB0c+gEzB4lF4Z+T46vRu+yq9DTRJTcjXGnP6ylrn+Rif3csx9RolpHtenwuR4ZwdsG1mowBbBM5WMyMWliELl3uy9411CNFODrwSSXOTj8w0bMLJfund/4Nu28B/Cw2nAWLhxcoxEkcX+oGvCOVQPnLX4AJ7TifpJWOsO9Ow/FJKEP7m1bGj7MLZXhbiQHai9g/LJAFdLofFLqjdL8/kAMKc6wtufIhw6vgKHv0V3nVnNneGY9/C+UGa8c3lOngWPZztzU51YTxgL/FkHLDHEsbvhN6dHlFAzpbDgtzPHrG8fdB41VXGg7GEpHxjLRLp6Dn3q5cAXEC9ACrIfoPGsSMJ4WGuIpxJ5uP7xDTT0X3mKXVe96bBCA3rhzJzAyw8Swfh9aLBCmF3ju/i0WBrRA8NpRf+iEHRLmZo0lY3Gs2sVFMvTrvm24gegOh3joFq1PIGVrSTaDRoQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PTaSU8vE6n/HV29Js3oLRb+2bCJtTqRg2XALReQdvjtdsW9vMpf3x/qd+6lS?=
 =?us-ascii?Q?NOXvkOZ6KI4DGd5Io/tuYL5ji4r3LfsAKb8PPi/dP90CqjpRzi6GLkrbuilx?=
 =?us-ascii?Q?j6Iok/Q1NW95a9zu3Vhnm9Z6KNYxLYJF6Laeu5HLxT/kgeOA/jd/3GmcbT5L?=
 =?us-ascii?Q?mK7OcJO60cvjc0yLIui0yzRdXfXL/TnxPQxFhuipM21lZbdg+YkUxb1Ne6lQ?=
 =?us-ascii?Q?wSyiIyW+QEANVxhV7Lf8DLByXcU43h4MtyLWe6sYQxaEk3nWeoVJwpYCVljR?=
 =?us-ascii?Q?DgyzAsjCPzEVFrkLcIqE/eXiQLo3juknxFp/a8m9DFJWDsmv4onSZUQnX4M3?=
 =?us-ascii?Q?/SKtm344VJo/0BSFfjUL4B0w+sxr9aQm5wXUcr8k5CwliTW9K6YcKMKpgytS?=
 =?us-ascii?Q?sYBbKRXw5c0XVe5Xt14XGuc6ydf1Bpidoced4RgVl7BsRO8qWH14CAoBcofO?=
 =?us-ascii?Q?foNESzQMVAiqPxS71QJwmoi8wE/U6uVzt7IZ4HgoHiqWoJBABGwF+WiscHu6?=
 =?us-ascii?Q?Yi+lCp0uOwLjZZTQA0cDkGZ77PDIzj4pBmUX0JvFHeSa/EbRsw182HM4a0BU?=
 =?us-ascii?Q?aeOPEbOT0Btvhwnq6n//c08VeVIEyNMRfJ7cl2arWWEmntM0aVuqZsZnDL3n?=
 =?us-ascii?Q?kRAmlqZRFRjbS8tosf5TjIyxNOPjO2t4UuDZz0za3W7mz3sLnBEYfZ33ar9d?=
 =?us-ascii?Q?QHwLLlvc/ckA0XO4TgkATIaE6ldjOuiXxseDhFoA954L6t8Dgz1Z6+F6RJ+r?=
 =?us-ascii?Q?wNKQBUV7y5fd8oFr1B7jaytGc1HJracMUYntGbJfPPOplksoPb+Z2cGhcB0Q?=
 =?us-ascii?Q?h8BGqltvHD8xb7kRuU4qvfmoctjEbdXJmG2hvif99UdCYecqDK/2kOz5hewI?=
 =?us-ascii?Q?k/fXpsfNVedzT8ekrNA1sx1Ow6hTUl3tNp3oolwc3vYvJ+NE9/wGwm1159gL?=
 =?us-ascii?Q?MgDMrj8nkLJ7ntv5bQ9N5RpBYjfPYVepWgUKT2TrPa/hbXRRMQsMbRwuB6RK?=
 =?us-ascii?Q?1rfEcAeFPrVE5DrHPBkKElbQsXhNcEXvWcAzgqhJ9DEUITo0ioaehJ0e4y8Z?=
 =?us-ascii?Q?8VM00zbqXW6+0J75NR/mc2F3+aKsBJ6CN3EWD9Rkwk/ZmUkgDHF9AN2igLic?=
 =?us-ascii?Q?yCk/Hi9I7bVNQZC/jwbDWEuK865zKnmf6noOfSgi1/+dM4HR45xwYPyZuY/b?=
 =?us-ascii?Q?EEvk7jaqDkoU/2LBdi3B4cnP4i6QAuT7pX2OkzJOQZOrLnftNqDttFvMT7CQ?=
 =?us-ascii?Q?mc8BKTZ2lL7OdottM1bwWqYubn+fncsCOEd4cxUVubOWdHyF1IW6Sht0V5p/?=
 =?us-ascii?Q?IO0X2QbVywJkvZ4GjmQt/WUxbZxT9WwUH/9SJNLCOzl2QtCRzOqxqehzoOiA?=
 =?us-ascii?Q?F+tq/iaLs8Os5T0PNcrXxVnZ3J+q709f4vo/n8JIFNexS0cKEFtVhKtEsQcF?=
 =?us-ascii?Q?gzUuoMQc9B0k67T2Uwjv/X2cXTCSdeTeGIU/LRtOb9H6VLup1lgrrUQTZiPg?=
 =?us-ascii?Q?VyZQp8QTiUuVro+Qc3dbSVPh1HgeHzh+1AjwlHs/Bv7K2SS3wWVII2AgHuD0?=
 =?us-ascii?Q?QD+OeB3/gqghuRXROtwRn21EVpkGI3QI2dmvPfpMOqfB/yNrov3P5ubyaD3u?=
 =?us-ascii?Q?Ln4WT9jStBFwkZUxncP9HoGI1ugtyumap5puzQBShHlU6A8ukGjwfa1JV03U?=
 =?us-ascii?Q?lymtn33P/DZAoHYcyvTpMXuSkzfrc/LxThPkO/0k+Na4W2C+jJi2Rg9F+5zf?=
 =?us-ascii?Q?LsCV9wb7Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00a2692-21bf-4f8a-27d6-08df1f117050
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 16:39:46.8479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmQIq90TUipPLXMnW2g0F0sRvLw88SmlCfAhvOWta2BMmpAlWdq+sQXdx5CSUQbQRcTi9qTJ6c2m1Nsifz6PiHG6OvQvjH0+Lf7tLlQV8jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14342
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

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 30 September 2026 14:33
> Subject: [PATCH v4 7/9] drm: renesas: rz-du: Add support for RZ/G3L LVDS =
encoder
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add support for the RZ/G3L LVDS encoder driver. It operates in single-lin=
k mode with 4 lanes (Data) + 1
> lane (Clock) and supports pixel clock rates from 25 to 87 MHz. The LVDS m=
odule cannot be used at the same
> time as MIPI-DSI. However, LVDS and the DSI interface share a peripheral =
clock and the MIPI_DSI_PRESET_N
> reset signal. Also, the MIPI_DSI_CMN_RSTB and MIPI_DSI_ARESET_N reset sig=
nals must be asserted before
> using the LVDS module.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Added resets in pair for simplification.
>  * Added comment in probe() for asserting resets.
> v2->v3:
>  * Moved set duty cycle to DU encoder.
> v1->v2:
>  * No change.
> v5[1]->v1:
>  * Added clk.h as LVDS requires 4:7 duty clock and moved this handling to
>    LVDS driver
>  * Avoided accessing register in disable if clk is disabled.
> v5[1]: https://lore.kernel.org/all/20260625172359.292631-3-biju.das.jz@bp=
.renesas.com/
> v4->v5:
>  * Added Kconfig functional dependency for DRM_RZG2L_DU
>  * Dropped DRM_PANEL from DRM_RZG3L_LVDS config
>  * Dropped unused headers of_device.h,of_graph.h and drm_panel.h
>  * Dropped the unused macro LVDS_CMN_RST_PHY0_SEL_CH0
>  * Used plain number for macro LVDS_0_PHY_CH_IO_EN0_MSK
>  * Retained the tag as the above changes are trivial.
> v3->v4:
>  * Dropped the header files clk.h and syscon.h
>  * Dropped next_bridge check in attach().
>  * Dropped syscon for getting regmap.
>  * Replaced the below macros to match with hardware manual:
> 	LVDS_0_CTL_FMT_SEL_MSK->LVDS_0_CTL_FMT_SEL0_MSK
> 	LVDS_0_PHY_CH_IO_EN_MSK->LVDS_0_PHY_CH_IO_EN0_MSK
> 	Replaced LVDS_0_PHY_CH_IO_EN->LVDS_0_PHY_CH_IO_EN0
>  * Replaced atomic_reset()->atomic_create_state()
>  * Dropped the tags as there are new changes.
> v2->v3:
>  * Collected tags.
> v2->v2[1]:
>  * Replace drm_atomic_state with drm_atomic_commit in
>    rzg3l_lvds_atomic_{en,dis}able().
>  * Drop local variable ret and dev_err() messages in
>    rzg3l_lvds_atomic_enable(); use WARN_ON() instead to
>    capture unexpected failures since atomic_enable should not fail.
>  * Drop local variable next_bridge from rzg3l_lvds_probe().
> [1] https://lore.kernel.org/all/20260524194457.479681-3-biju.das.jz@bp.re=
nesas.com/
> v1->v2:
>  * Dropped unused function rzg3l_lvds_is_connected() and removed the
>    corresponding header file rzg3l_lvds.h
>  * Dropped next_bridge from struct rzg3l_lvds instead using bridge's
>    next_bridge.
>  * Replaced pm_runtime_resume_and_get()->pm_runtime_get_sync() as
>    atomic_enable doesn't fail and for each enable there always will be an
>    atomic_disable() call.
>  * Started using DEFINE_RUNTIME_DEV_PM_OPS for PM callback.
>  * Replaced rzg3l_lvds_parse_dt() with devm_drm_of_get_bridge() in probe(=
)
>  * Started using reset_control_bulk_*() in rzg3l_lvds_pm_runtime_{suspend=
,
>    resume}()
> ---
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
>  drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
>  drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 282 ++++++++++++++++++
>  .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
>  4 files changed, 321 insertions(+)
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/rene=
sas/rz-du/Kconfig
> index 7f2ef7137ae5..0dbe86bd65d0 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
>  	def_tristate DRM_RZG2L_DU
>  	depends on DRM_RZG2L_USE_MIPI_DSI
>  	select DRM_MIPI_DSI
> +
> +config DRM_RZG3L_USE_LVDS
> +	bool "RZ/G3L DU LVDS Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	depends on DRM_RZG2L_DU || COMPILE_TEST
> +	default DRM_RZG2L_DU
> +	help
> +	  Enable support for the RZ/G3L Display Unit embedded LVDS encoder.
> +
> +config DRM_RZG3L_LVDS
> +	def_tristate DRM_RZG2L_DU
> +	depends on DRM_RZG3L_USE_LVDS
> +	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/ren=
esas/rz-du/Makefile
> index 2987900ea6b6..46decb7ac4f1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Makefile
> +++ b/drivers/gpu/drm/renesas/rz-du/Makefile
> @@ -8,3 +8,4 @@ rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+=3D rzg2l_du_v=
sp.o
>  obj-$(CONFIG_DRM_RZG2L_DU)		+=3D rzg2l-du-drm.o
>=20
>  obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+=3D rzg2l_mipi_dsi.o
> +obj-$(CONFIG_DRM_RZG3L_LVDS)		+=3D rzg3l_lvds.o
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm=
/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 000000000000..1658be8da545
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/G3L LVDS Encoder Driver
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation  */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "rzg3l_lvds_regs.h"
> +
> +enum rzg3l_lvds_mode {
> +	RZG3L_LVDS_MODE_JEIDA =3D 0,
> +	RZG3L_LVDS_MODE_JEIDA_MIRROR =3D 1,
> +	RZG3L_LVDS_MODE_MODE2 =3D 2,
> +	RZG3L_LVDS_MODE_MODE2_MIRROR =3D 3,
> +	RZG3L_LVDS_MODE_VESA =3D 4,
> +	RZG3L_LVDS_MODE_VESA_MIRROR =3D 5,
> +	RZG3L_LVDS_MODE_MODE6 =3D 6,
> +	RZG3L_LVDS_MODE_MODE6_MIRROR =3D 7,
> +};
> +
> +struct rzg3l_lvds {
> +	struct device *dev;
> +	struct clk *dotclk;

As pointed out by sashiko, this is not needed.

> +	struct reset_control_bulk_data resets[2];
> +	struct regmap *regmap;
> +	struct drm_bridge bridge;
> +};
> +
> +#define bridge_to_rzg3l_lvds(b) \
> +	container_of(b, struct rzg3l_lvds, bridge)
> +
> +static const struct regmap_config rzg3l_lvds_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.max_register =3D LVDS_0_CTL_OFFSET,
> +};
> +
> +/*
> +-----------------------------------------------------------------------
> +------
> + * Bridge
> + */
> +
> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state) {
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	u32 fmt;
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
> +	if (WARN_ON(!bridge_state))
> +		return;
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		fmt =3D RZG3L_LVDS_MODE_JEIDA;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		fmt =3D RZG3L_LVDS_MODE_VESA;
> +		break;
> +	default:
> +		fmt =3D RZG3L_LVDS_MODE_VESA;
> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> +			 bridge_state->output_bus_cfg.format);
> +		break;
> +	}
> +
> +	if (WARN_ON(pm_runtime_get_sync(lvds->dev) < 0))
> +		return;

As pointed out by sashiko, this need to be moved up to
avoid pm_usage_count issue in disable.

> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
> +	fsleep(20);
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, LVDS_0_PHY_CH_EN_LDO);
> +	fsleep(10);
> +
> +	regmap_write(lvds->regmap, LVDS_CMN, LVDS_CMN_RST_PHY0_SEL);
> +	regmap_update_bits(lvds->regmap, LVDS_0_CTL_OFFSET,
> +			   LVDS_0_CTL_FMT_SEL0_MSK,
> +			   FIELD_PREP(LVDS_0_CTL_FMT_SEL0_MSK, fmt));
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN0_MSK, LVDS_0_PHY_CH_IO_EN0);
> +	regmap_write(lvds->regmap, LVDS_CMN,
> +		     LVDS_CMN_RST_PHY0_SEL | LVDS_CMN_PHY_RESET);
> +	fsleep(100);
> +}
> +
> +static void rzg3l_lvds_atomic_disable(struct drm_bridge *bridge,
> +				      struct drm_atomic_commit *state) {
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(lvds->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret < 0)
> +		goto pm_put_sync;
> +
> +	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN0_MSK, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, 0);
> +
> +pm_put_sync:
> +	pm_runtime_put_sync(lvds->dev);
> +}
> +
> +static int rzg3l_lvds_attach(struct drm_bridge *bridge,
> +			     struct drm_encoder *encoder,
> +			     enum drm_bridge_attach_flags flags) {
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +
> +	return drm_bridge_attach(encoder, lvds->bridge.next_bridge, bridge,
> +flags); }
> +
> +static enum drm_mode_status
> +rzg3l_lvds_bridge_mode_valid(struct drm_bridge *bridge,
> +			     const struct drm_display_info *info,
> +			     const struct drm_display_mode *mode) {
> +	if (mode->clock > 87000)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (mode->clock < 25000)
> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}
> +
> +static const struct drm_bridge_funcs rzg3l_lvds_bridge_ops =3D {
> +	.attach =3D rzg3l_lvds_attach,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_enable =3D rzg3l_lvds_atomic_enable,
> +	.atomic_disable =3D rzg3l_lvds_atomic_disable,
> +	.mode_valid =3D rzg3l_lvds_bridge_mode_valid, };
> +
> +/*
> +-----------------------------------------------------------------------
> +------
> + * Power Management
> + */
> +
> +static int rzg3l_lvds_pm_runtime_suspend(struct device *dev) {
> +	struct rzg3l_lvds *lvds =3D dev_get_drvdata(dev);
> +
> +	return reset_control_bulk_assert(ARRAY_SIZE(lvds->resets),
> +lvds->resets); }
> +
> +static int rzg3l_lvds_pm_runtime_resume(struct device *dev) {
> +	struct rzg3l_lvds *lvds =3D dev_get_drvdata(dev);
> +
> +	return reset_control_bulk_deassert(ARRAY_SIZE(lvds->resets),
> +lvds->resets); }
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rzg3l_lvds_pm_ops,
> +				 rzg3l_lvds_pm_runtime_suspend,
> +				 rzg3l_lvds_pm_runtime_resume, NULL);
> +
> +/*
> +-----------------------------------------------------------------------
> +------
> + * Probe & Remove
> + */
> +
> +static int rzg3l_lvds_probe(struct platform_device *pdev) {
> +	static struct reset_control_bulk_data resets[2];

As pointed out by sashiko, on safer side this need to be global.

Will fix this in next version.

Cheers,
Biju

> +	struct device *dev =3D &pdev->dev;
> +	struct rzg3l_lvds *lvds;
> +	void __iomem *base;
> +	int ret;
> +
> +	lvds =3D devm_drm_bridge_alloc(dev, struct rzg3l_lvds, bridge,
> +				     &rzg3l_lvds_bridge_ops);
> +	if (IS_ERR(lvds))
> +		return PTR_ERR(lvds);
> +
> +	lvds->dev =3D dev;
> +	lvds->bridge.of_node =3D pdev->dev.of_node;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	lvds->regmap =3D devm_regmap_init_mmio(dev, base, &rzg3l_lvds_regmap_co=
nfig);
> +	if (IS_ERR(lvds->regmap))
> +		return dev_err_probe(dev, PTR_ERR(lvds->regmap),
> +				     "Failed to init regmap\n");
> +
> +	lvds->dotclk =3D devm_clk_get(dev, "dotclk");
> +	if (IS_ERR(lvds->dotclk))
> +		return PTR_ERR(lvds->dotclk);
> +
> +	lvds->resets[0].id =3D "prst";
> +	lvds->resets[1].id =3D "lvdrst";
> +	ret =3D devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(lvds->res=
ets),
> +						    lvds->resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get prst/core resets\n");
> +
> +	platform_set_drvdata(pdev, lvds);
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable Runtime PM\n");
> +
> +	lvds->bridge.next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, =
1, 0);
> +	if (IS_ERR(lvds->bridge.next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(lvds->bridge.next_bridge),
> +				     "Failed to get next bridge\n");
> +
> +	/*
> +	 * This module cannot be used at the same time as MIPI-DSI, so assert
> +	 * the MIPI_DSI_CMN_RSTB and MIPI_DSI_ARESET_N resets before using this
> +	 * module.
> +	 */
> +	resets[0].id =3D "rst";
> +	resets[1].id =3D "arst";
> +	ret =3D devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(resets),
> +						    resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get rst/arst resets\n");
> +
> +	ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_drm_bridge_add(dev, &lvds->bridge);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register drm bridge\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg3l_lvds_of_table[] =3D {
> +	{ .compatible =3D "renesas,r9a08g046-lvds" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, rzg3l_lvds_of_table);
> +
> +static struct platform_driver rzg3l_lvds_platform_driver =3D {
> +	.probe		=3D rzg3l_lvds_probe,
> +	.driver		=3D {
> +		.name	=3D "rzg3l-lvds",
> +		.pm	=3D pm_ptr(&rzg3l_lvds_pm_ops),
> +		.of_match_table =3D rzg3l_lvds_of_table,
> +	},
> +};
> +
> +module_platform_driver(rzg3l_lvds_platform_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_AUTHOR("Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G3L LVDS Encoder Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h b/drivers/gp=
u/drm/renesas/rz-
> du/rzg3l_lvds_regs.h
> new file mode 100644
> index 000000000000..5b276cca9a5d
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G3L LVDS Interface Registers Definitions
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + *
> + */
> +
> +#ifndef __RZG3L_LVDS_REGS_H__
> +#define __RZG3L_LVDS_REGS_H__
> +
> +#define LVDS_CMN			0x00
> +#define LVDS_CMN_RST_PHY0_SEL		BIT(24)
> +#define LVDS_CMN_PHY_RESET		BIT(0)
> +
> +#define LVDS_0_PHY_OFFSET		0x10
> +#define LVDS_0_PHY_CH_IO_EN0_MSK	0x1f
> +#define LVDS_0_PHY_CH_IO_EN0		(LVDS_0_PHY_CH_IO_EN0_MSK << 0)
> +#define LVDS_0_PHY_CH_EN_BGR		BIT(8)
> +#define LVDS_0_PHY_CH_EN_LDO		BIT(9)
> +
> +#define LVDS_0_CTL_OFFSET		0x14
> +#define LVDS_0_CTL_FMT_SEL0_MSK		GENMASK(23, 20)
> +
> +#endif /* __RZG3L_LVDS_REGS_H__ */
> --
> 2.43.0

