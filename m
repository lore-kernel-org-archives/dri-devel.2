Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B10CD4F39
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156DB10ED07;
	Wed, 13 May 2026 07:53:32 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.109.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DC410E59A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:52:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020133.outbound.protection.outlook.com
 [52.101.84.133]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-132-IJLfOKF6MiGUF5uA612Yxw-1; Tue, 12 May 2026 18:46:29 +0200
X-MC-Unique: IJLfOKF6MiGUF5uA612Yxw-1
X-Mimecast-MFC-AGG-ID: IJLfOKF6MiGUF5uA612Yxw_1778604388
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by VI0PR01MB11487.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:2a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:46:26 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:46:26 +0000
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
Subject: [PATCH 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
Date: Tue, 12 May 2026 18:46:09 +0200
Message-ID: <20260512164609.3390700-3-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512164609.3390700-1-bstruempfel@data-modul.com>
References: <20260512164609.3390700-1-bstruempfel@data-modul.com>
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|VI0PR01MB11487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed5856e-5140-4dcb-03fc-08deb04601dc
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|3023799003|18002099003|56012099003|22082099003|921020
X-Microsoft-Antispam-Message-Info: HLngR8imnI631SndFncy9IU6CxjwKteqnKgOT+0Qoc085VvzntfioYcxGnPMCreZahMRgN8TQ49APqSup7cQPZkV/SCDuBo+Uu6dLL/lxvojgqQmYYqp3unvvTOZfQUIJHsdxVOHTTFXrE6HQ2bptZrGFT8mVAIgtHCyjBQTBzan5NmrqRGEW3x0dtjkTnvhexNzeuO/9KtqoiC72ZBCwyTXCXwvRexpTfGxwjlvaAtWEwYzmJ3y9dsw/HbNFvhkbWx7xc+Ul2Iz5Dns2LoUUzCt8wPGGr7TMJeQJM1PmU3BfdhOoW3LJ19X5/hlfj4n8HrC2MX7cwl8qvEiDFLSg8sEtXfxgQHk/r7I+kzFoOwMPfWOpOkDA4DVP6ZanoHWvBtd7Kj8Vl2PkZ9RfHxtU5LsBAgjL/p/Se2oieQgu5LJO7D3hY7bO9KJl9JkukEMVl8jTa6wMiSiMaC/FNCeS+sNTONNb00+UxL3UmObZHbxqqRqzK4mi3iPLCGvpAOZnnTMy9hKhMcbXqd1gBAbvBWdFEWtoU4ysnzwnbWawxZjwmZaY2JkW9k024ACvF1v5GMGqP8vv8n11GDh/fpOQDe9JwQQDTZ2kF3Vf0oLFaXD/qXH5oja1kQNxhiAuO9Q5Bhl2UZ9BnpkKk/HCg6Dq+5MWQxSGHuVjHAgR97SGqhC4zWm42RUpwwrfr99p5FAlAFCIQIZ8g+yyE9tJS3tGkMguN735j9uC9I/z8K72vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(3023799003)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdOqD2bHJ5ag7WJEAfNtDmU2IxGoJHlRczb6wsTk0vvVadXm/5DomWBZczvL?=
 =?us-ascii?Q?Jqumwu5SZqmue92pZIOb+OIhdh9HYzq5YzLR4+MmSTypebywuZDw6Z5fPKIk?=
 =?us-ascii?Q?XmNmIBo8oYHfgVDpyvfrcKqDxDi+Rc2X29QIYZaHIljtoFIawzAAP4JvCJuz?=
 =?us-ascii?Q?stEtB/3jYeVwyHZ6HM7rBwpRs5jijuPl4MP05C8yjvG5T4c2Kpy/mgvuqa/V?=
 =?us-ascii?Q?YQwAY291jjT1t6YplR0iOnq7bIJIS79Mh+7MY4rWYLxj8ywXrRhlWk6vrw0r?=
 =?us-ascii?Q?2xfNPQRL3zLBcg4oMfufH+OUTG4mO35Nv7gL66OIeCuc6N4QdcrnjAydHFrs?=
 =?us-ascii?Q?WpexRbJNMEs8clDL5sh8Bcr9X1Y1YeYtIrKKN0H7pkbmc5LozwBv1d9Mppc3?=
 =?us-ascii?Q?zwSwIM1pYeALjnGqCwrgpaCm0pcdGpTmBhkAW9v4mpgdN+6nH5fZ05jWUg5U?=
 =?us-ascii?Q?D424etTZILZJ6k6WPP5IspREFFXJakDf0vSUo6ZVHO3+R7erhup0YyEruGD3?=
 =?us-ascii?Q?3gVFIXNFFtJuf8gzS6heCnT7j1T5gooApDf3ZtIfm9sEkB0gN6TjQqp7AoNp?=
 =?us-ascii?Q?ge8uFNQ0zVGQlN2Ve3oojJ+HsmW0Vca5rIKV4XmVFNC7gkGooXk/FTRrGL1p?=
 =?us-ascii?Q?uin86q8Zp2FNJ1Z7BRq8imZbgi3uq/yqx4GunrC0dU2LJTcG8L2S8d9bVpG1?=
 =?us-ascii?Q?Dmk7cT9S/ECtXw08BtA+I8wg+YhyTuUi5sPtD2MVG/dDvjs2YMLn2j60c2qA?=
 =?us-ascii?Q?BYzIiaacciyoq2mcVtcxE5lzAzM0amF09EIt/Ra/QNCx+i02Y0YPL5CNvybs?=
 =?us-ascii?Q?ToU2TzP0Xko2Z/81UqLzuWsX6L/gtfO80L0lY2J33CLdNrhifej0Tn0UZCf1?=
 =?us-ascii?Q?KPqWLmrL7TkcEB2HUDXnPG8x1fm8Lh9945PXjPRPfsDNotKBaUo0aWjl+6Pa?=
 =?us-ascii?Q?5dVpWnYIniJQebdjgNRwUcDkcxuZzIADQauiUeDCL9HvLVjbzpiAzQGztTPI?=
 =?us-ascii?Q?cGJ0tqQEJ+47BvSC4q7NDlTjVdbFW+nkGuZtCA62968rUn4PAvtjinyyaq30?=
 =?us-ascii?Q?hGZEWHfyNgFACoap8G4mKvZjOPS2Q8L30PUGPcKQOkBFe+tbxk0KnRZnK2qy?=
 =?us-ascii?Q?idlTK3hLYlq/ZrrQKRztfDAMhV+C47ow65xhIJRTvd174kx8ZHT1TfcgzP5N?=
 =?us-ascii?Q?haHfn1IxvCFJfSF+VGPbOzIP9PnhiOlm1XOj6i1z0qF+kTNWwuMYwY0FYH9K?=
 =?us-ascii?Q?CnaFEGRd2JgKX3Tn5UYV2DagMxyJqM8abe2deWcxRl1xHoGJgE+jIxKTSvRG?=
 =?us-ascii?Q?sTSzSs7x0e9AdKCcmdbgLXz+I3QkBiltg1854TkpWGK4jXhP3y8YDEHxdpr8?=
 =?us-ascii?Q?oDTUMP5JSP20g6TjfLS3EsHkZPYdcJnejgcdtPzv6sspwd7zf4bpAyEf5dkt?=
 =?us-ascii?Q?nHUkQQR5SxFFsrySchGXAnZjSkXc+bmbI8ngckNVqqWX6W68KNvKiwMh7xFz?=
 =?us-ascii?Q?7D/JWGb5TjtMFc0fhDTvMTomrLCHVmx0ZNtjANlYyo2QxjvGJpW2SI4WrOP1?=
 =?us-ascii?Q?x4OFPV0HqXR9cfxcTqtHMDH94Hy5B1t7q1mKE/h2Fwi5Pe8Q1HZT0b/JU5sr?=
 =?us-ascii?Q?rHk8PIJqjztty8+abA0y4ZVWPORmizR5AKf60Mp6/hMDFbfpDxgz57k3BQ+F?=
 =?us-ascii?Q?hIkUOZhiCjM62cJT7J8udqocBvMeIF6gFFYJEJBxxlI7YRBGISlZj5rG5uKa?=
 =?us-ascii?Q?HFYb9jKEKfWAwvsdsT5ng4i/V/8q4Ry6rq9YD2ElXW2E74231Vi8jOaDkDUC?=
X-MS-Exchange-AntiSpam-MessageData-1: a0mIuK0NJ3Qg1MjNKmPyyL53APcgbVk4QmY=
X-Exchange-RoutingPolicyChecked: oFjxVSst+UPu16oh059VrGSMICiIk5zK/ISZ7d8F2tI+wQ/kNxWxDjNFqwxcV135M1460w18UnSDfk+Aq4eAcfchlYWGo+UVEveoA5mZY4//0IXD0hLRH86SMjMZExcPY1Ne9PewM/56OgnnpLF90bs4IJyIykGUlauHXLTjm3NWjp/8F0SaG/FKJBIP5mPZtAWHNjRjXsVhLdT3+YkRm7Ex0CgDUm+dOMrD7orhEGushWbVdGolzmwAKl3kGWHmVmMtZlCQ1mCKlNA1eG893QHFM457pWadc/xt+YnRg9WpBv5IMEzE7i/upN+B1Fc9wdx+jtMEXoJN+jL19dwHFQ==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed5856e-5140-4dcb-03fc-08deb04601dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:46:25.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNY7Wj8HmVWPEMMR9Lmp1WO6nPObr+z5dv8gLINmuE2LcBRo1qCz00BpR4Pv7uisDHMEIqZYD/JaptJCUG9N6jNFcVaK7KxiTR2h4xul2Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR01MB11487
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2hKfhuyExrFqIS8_kXg404-5TckajDZInZnYksNrb90_1778604388
X-Mimecast-Originator: data-modul.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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
 drivers/gpu/drm/bridge/lontium-lt9211.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/brid=
ge/lontium-lt9211.c
index 03fc8fd10f20..402c639ac515 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -40,6 +40,11 @@
 /* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
 #define REG_DSI_LANE_COUNT(n)=09=09=09((n) & 3)
=20
+/* Maps register value (index) to drive-strength-microamp DT property valu=
e */
+static const u32 lt9211_hsdrv_microamp[] =3D {
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
@@ -666,6 +675,23 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
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
+=09}
+
 =09return 0;
 }
=20
--=20
2.54.0

