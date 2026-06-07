Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830BDCD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC0210EA6A;
	Sun,  7 Jun 2026 14:39:58 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A4610EA06
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 11:34:18 +0000 (UTC)
Date: Sun, 07 Jun 2026 11:31:56 +0000
To: dri-devel@lists.freedesktop.org
From: Tyron Govender <dev@tyrongovender.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Tyron Govender <dev@tyrongovender.com>
Subject: [PATCH] drm: panel-orientation-quirks: Add HUION Kamvas Studio 16
Message-ID: <20260607113147.55507-1-dev@tyrongovender.com>
Feedback-ID: 202006238:user:proton
X-Pm-Message-ID: a297d97a2384dfd1f8bccf600fbaaf6d9ee663ca
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Signed-off-by: Tyron Govender <dev@tyrongovender.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/d=
rm/drm_panel_orientation_quirks.c
index 3a218fb59..85203b140 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -364,6 +364,15 @@ static const struct dmi_system_id orientation_data[] =
=3D {
 =09=09  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
 =09=09},
 =09=09.driver_data =3D (void *)&lcd1080x1920_rightside_up,
+=09}, {=09/*
+=09 * HUION Kamvas Studio 16
+=09 * DMI has "Kavmas" spelling error, matched intentionally here
+=09 */
+=09=09.matches =3D {
+=09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "HUION"),
+=09=09  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Kavmas Studio 16"),
+=09=09},
+=09=09.driver_data =3D (void *)&lcd2560x1440_bottom_up,
 =09}, {=09/* I.T.Works TW891 */
 =09=09.matches =3D {
 =09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
--=20
2.54.0


