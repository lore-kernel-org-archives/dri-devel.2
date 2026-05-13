Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF6CCD4F25
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8718310F084;
	Wed, 13 May 2026 20:57:04 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.111.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D67310E31A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:31:45 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021087.outbound.protection.outlook.com
 [40.107.130.87]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-102-h46IPnI2McaQRAEfxIfvFQ-6; Wed, 13 May 2026 15:31:43 +0200
X-MC-Unique: h46IPnI2McaQRAEfxIfvFQ-6
X-Mimecast-MFC-AGG-ID: h46IPnI2McaQRAEfxIfvFQ_1778679102
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by AS8PR01MB8074.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:375::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:31:36 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:31:35 +0000
From: Boerge Struempfel <bstruempfel@data-modul.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Boerge Struempfel <bstruempfel@data-modul.com>
Subject: [PATCH v2 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
Date: Wed, 13 May 2026 15:31:27 +0200
Message-ID: <20260513133127.376458-3-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513133127.376458-1-bstruempfel@data-modul.com>
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|AS8PR01MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f129b15-49d0-4cbf-2e67-08deb0f3f407
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|921020|3023799003|56012099003
X-Microsoft-Antispam-Message-Info: fJINjYXLuKIhtdTv5db+IR3OwLUh1CutpHV07N1n4AsMHW9cHmRoVXpWzg4pVx0C4RDS4sB9Gn9iiF3aAo9+fZQVlyN3YiZAtoDYtQVJk5hKAu1q4gQ6mOIDQPgT2oPS1Lorq0NEz8ENLm6AEBw/FUhio3Yg7z5iNwC2FP1Nb5TqoLTy2N19kMG5cZGAAm3meAnFrP0BMFp/VpUP6GAC02zuA9xZgZwcuRdyxHBIdPsY7bXyinT2YSJiN68uhNt98KPdxLWpld0Db3mq5ETYu1UYEX7wg/Y857aferhit6P9c+BfQip2KlEK8YfjlQaPAo4ZANMd13Pum8nfPXSnLT5Lp9NtLmWlNJzPv9W8a0pjN6Q+mVrKRAaVH7TR9A92nIAY5x9RrO9iu0PjaUdhtxXTgkszHLMMrKcCbYveqRUgefkChkVaE5nSlYYzFtr+3zC0hyMvF2EpSdcAzWh1oCea5mh0cZ11dGBmzY8XM+vaGXNLFhpBdpUb7RYv3tf2EIH/UcrUpdsAQPIgwR/zE2B3fGddX6x6FMkJ7+QTeXo2aKfIjsc0+G5UI/uBxK4x+2MZoxtAgVoxZpa2aOKIGNl9SmAtct9VhGXERyxmEXXfQPw9XgcFTdhULwdnxy8SenyTNbzLyxhdlEwNBREugvYwZ+eEs/cqvjRBW2IDUGb/dWhKVFPZ8kxR0TPqrFhs2CpvcGRShMK7XJ08ydfd+QgzHweq61/MupUC8vDuG2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(921020)(3023799003)(56012099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ig75iiCn+BrN7eHfzAkK4G+zUsSNssxRU2lmPughIJaKEDPbjwYuI6/SvK/2?=
 =?us-ascii?Q?2qE/5jqHlOFqlPzJ3cKLa36IQnZajQ9oDm37lzq02hdWTK/tXmPikdTjPEHv?=
 =?us-ascii?Q?Q4qDB8WioUzkhl2y6tuou3ALfpeQYf97NIh+XgKM46dsizFvDxzpGMzE0EG/?=
 =?us-ascii?Q?X1oOdWB2I/MJUEHz0HydSkoa61WAczsiUrI/Vawss3nAUqAXm9XDZT5wT7lC?=
 =?us-ascii?Q?RuQeRY22/86D3ppHyZrRdOAgpcRh1LE2AoGozXphEKmU4ktRG5ar9mXlgrH/?=
 =?us-ascii?Q?fuZnBFpPXVtVckKJXVyoCw+vbYhsZBAssgGFfZ+uN6SlyGM89OladFUVdG8D?=
 =?us-ascii?Q?OpV7KOzfVB8Sy+Ie0EvxDYxcBVsyEA8rRDBQ6jQE4XBD2X3uW7Y0gT+qnE+Z?=
 =?us-ascii?Q?lBo99BKDGrE1mwmQqTSe6ynEkjnPVgl6LXL1Wc/yYNgZl6rMW/P9Udq1nepr?=
 =?us-ascii?Q?hdw+YyTQd+cXeU1OhD18CnKT/3wODgmu+VXoRU+J6r2J3IiA8iShpdYrNVKY?=
 =?us-ascii?Q?V5Y1qZZ74uj+2J26NisdZQ1thjglF8ZpaQ6KvvQgChd3X7huR1M0jGGbQA1P?=
 =?us-ascii?Q?oSqhGMersCE93N667wBv3Zd6Hbm5skknRaHvs1hqrDA7UHMrcR/98wjFeD73?=
 =?us-ascii?Q?fOYflJ4g3nqXJvTSON09C1jYv6XHcPFE1Wuv5O/50D3tOcfxY2mOKmMsAqcu?=
 =?us-ascii?Q?E8/aZvbieJYFpx9bJ0KAUGD2q36Qld3r3R5VtaiMqwGmlM4ymeb42Jej4VU4?=
 =?us-ascii?Q?ZhQB6540TV278ekbO4tJG5BUxNG0pqsm/79/82vLbtkjyrtFiIrRxxPhc+Xy?=
 =?us-ascii?Q?xjsGgyMItrYLGhO60hU9KBkhuo/iDUOdTOLFIvR8HUwnj3FUJZEU4ohWKqP0?=
 =?us-ascii?Q?aDNCIpGR/kgWIHNXxrb3S3jZTCWRNhvcz6W2MAdDLnmzUxgmoyer/VO/+QdP?=
 =?us-ascii?Q?8U4YLxHI81epdau9CbcPbK+opz9fO0FTDeyIJWkEYU6bnBvnEx45loc4VKor?=
 =?us-ascii?Q?vldfil4kCoxYHuRR8hM5eiPuuolAnyB14OrBVvDxpduQjSv6CW/Yu3ejACqH?=
 =?us-ascii?Q?+DNTBiU9Jf7DzmF4ATFOXJLKznBH30yg/0V86cyoY5wUTmBZRI7cxwGwsxVZ?=
 =?us-ascii?Q?Q0W2WeYyNvT2DEk6Oz8qzB74BrULKa+NQcZThEO563oIR22R3wVHiIyogX8X?=
 =?us-ascii?Q?dzgMUX8oSDkliC3hTkLYQjRPj0FGJ2XMDEODLs6lF6+H8JvEiAl/PykrmG7i?=
 =?us-ascii?Q?wl2cTbFKgTLE0DD3SfIXxIJ41XL2WLrvGFUbltHbq8AlCr2yah5Mh6bjCG3L?=
 =?us-ascii?Q?d0QpBzxXKrPhz1cZy4q3aoMRqDx0hRUBrbJ39N1Ia0sv0Ko41DHApoYgZXeY?=
 =?us-ascii?Q?Xv1hcia7RX/WjsmjFUdPy+JpV+yA8LDW24rfStQI45bCwHp6t0RanQINPkT5?=
 =?us-ascii?Q?btgGRRGfJn+ZgNE+NIQp4IlZued/Uiwq9oIKz2y5C/pgwZZN8B47BZXNv7Tx?=
 =?us-ascii?Q?yp5MHGOcV2pgA9XxwAmmEhngZWJXE3W7V0333sbYj6IjUwODG6fWHIUp4uNd?=
 =?us-ascii?Q?GTfvqcJX4QYpWSttieehx2sx9I9bN/w4nBCnrYLgG+9KPwgUibwCFUES9caL?=
 =?us-ascii?Q?bJLlh+MHpZkNbl9ziWbbSzv9m9DJzbgZsMSF9Pw9nUVyldxvjF2NH7t2BNWe?=
 =?us-ascii?Q?9g6RuNvhZLZBo7T6N7pg/7oR+2x0FMLgkJEKRHRgZMEoOnMm5YYGnxnBB256?=
 =?us-ascii?Q?16SmhlPIrom9WdAzusgbTx2HA8ZQwCY=3D?=
X-Exchange-RoutingPolicyChecked: pn/WlX4AUO41+XvGoJHoIK14PlZjZKmFaGelj+WrQIHCUxwtdiTClLzGa2Kx5HzmIYr4hWLkFZ6VkvWymQPB7exu7OAlhX6ORxkgfIMwItY/meaDZqW4sdAZa5aB6JiiZyKx4Ty82kVY5witeQ9D14H+Yo3tB84XLLNbLo+pTvUKcrF9sGCxhr+8ARal1tK9qEfwm/XGO8xkMDMrsZoD5HlsTft9Kq6uo+qbFhWLGzKZXXY66Q3n1oKbbvB5KeNnCGzCIetopy6mUp/kxUga/Ixk6uv1tMrf3hjqZ98pLJQBd8bA67sWuGZJGRVLObnBwjIfUPhfx1ZAdPPtZLs+Mg==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f129b15-49d0-4cbf-2e67-08deb0f3f407
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:31:35.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyU6772U+7pdqhSLqMxgKe5zk+4v5PmiNNoJqwtAXM2fg+fwJeKlCLiTenSGddze+rsMP+SNtPlKLSY8KR6mPPs86ZYDKKpwg0dZNkWFefY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8074
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ktsWNf58_BpelU-qpQ2kNKZ6dV-zskHGFAIV74SG8c4_1778679102
X-Mimecast-Originator: data-modul.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

The LT9211 LVDS TX output driver current (RG_MLTX_HSDRV_ISEL) was
previously hardcoded to 0x8 (~25 uA), which may not be optimal for all
board layouts.

The hardware supports 16 discrete current levels starting at 12.5 uA
with a step of 1.5625 uA. These are exposed as rounded integer microamp
values in the lookup table.

Add support for the 'drive-strength-microamp' DT property. A lookup
table maps the sixteen supported microamp values (12..36 uA) to the
corresponding register field. Defaults to 25 uA when the property is
absent, preserving the existing behaviour.

Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 31 ++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/brid=
ge/lontium-lt9211.c
index 03fc8fd10f20..5edd2d2e3da6 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -40,6 +40,11 @@
 /* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
 #define REG_DSI_LANE_COUNT(n)=09=09=09((n) & 3)
=20
+/* Maps register value (index) to drive-strength-microamp DT property valu=
e */
+static const u8 lt9211_hsdrv_microamp[] =3D {
+=0912, 14, 16, 17, 19, 20, 22, 23, 25, 27, 28, 30, 31, 33, 34, 36
+};
+
 struct lt9211 {
 =09struct drm_bridge=09=09bridge;
 =09struct device=09=09=09*dev;
@@ -50,6 +55,7 @@ struct lt9211 {
 =09struct regulator=09=09*vccio;
 =09bool=09=09=09=09lvds_dual_link;
 =09bool=09=09=09=09lvds_dual_link_even_odd_swap;
+=09u8=09=09=09=09lvds_hsdrv_isel;
 };
=20
 static const struct regmap_range lt9211_rw_ranges[] =3D {
@@ -374,7 +380,8 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool=
 jeida,
 =09=09/* BIT(7) is LVDS dual-port */
 =09=09{ 0x823b, 0x38 | (ctx->lvds_dual_link ? BIT(7) : 0) },
 =09=09{ 0x823e, 0x92 },
-=09=09{ 0x823f, 0x48 },
+=09=09/* bits 3:0: RG_MLTX_HSDRV_ISEL, LVDS TX driver current */
+=09=09{ 0x823f, 0x40 | ctx->lvds_hsdrv_isel },
 =09=09{ 0x8240, 0x31 },
 =09=09{ 0x8243, 0x80 },
 =09=09{ 0x8244, 0x00 },
@@ -629,7 +636,9 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
 =09struct device *dev =3D ctx->dev;
 =09struct drm_panel *panel;
 =09int dual_link;
+=09u32 microamp;
 =09int ret;
+=09int i;
=20
 =09ctx->vccio =3D devm_regulator_get(dev, "vccio");
 =09if (IS_ERR(ctx->vccio))
@@ -666,6 +675,26 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
=20
 =09ctx->panel_bridge =3D panel_bridge;
=20
+=09ctx->lvds_hsdrv_isel =3D 8; /* default: 25 uA */
+=09ret =3D of_property_read_u32(dev->of_node, "drive-strength-microamp",
+=09=09=09=09   &microamp);
+=09if (!ret) {
+=09=09for (i =3D 0; i < ARRAY_SIZE(lt9211_hsdrv_microamp); i++) {
+=09=09=09if (lt9211_hsdrv_microamp[i] =3D=3D microamp) {
+=09=09=09=09ctx->lvds_hsdrv_isel =3D i;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09=09if (i =3D=3D ARRAY_SIZE(lt9211_hsdrv_microamp)) {
+=09=09=09dev_err(dev, "Invalid drive-strength-microamp value %u\n",
+=09=09=09=09microamp);
+=09=09=09return -EINVAL;
+=09=09}
+=09} else if (ret !=3D -EINVAL) {
+=09=09dev_warn(dev, "Failed to read drive-strength-microamp: %d, using def=
ault\n",
+=09=09=09 ret);
+=09}
+
 =09return 0;
 }
=20
--=20
2.54.0

