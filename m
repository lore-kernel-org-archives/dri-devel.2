Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9977C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DF910E226;
	Wed, 26 Aug 2026 13:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="ilWVNh6C";
	dkim-atps=neutral
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E295A10E226
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:23:25 +0000 (UTC)
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
 c=relaxed/relaxed; t=1787750600; h=from:to:date:message-id:subject;
 bh=mmakPHcWW7jBC3Xj88rgfv6itvMd6D8/VDEASWlTC14=;
 b=ilWVNh6C3yje3f+GN/hSHY+AEdFhFrTcYdvAaXqE4J9WNN2d3WG5f7NqSOR9qbA/GZCjsaBowYt
 7C/sLR+xs9g3UbLFzfQEVdKJBfisVNKzuQLLZXKDIQGv/ATYqYSrj2DY9lBh0TDylEmxqX+QWELtO
 cnbRCVs7au9j4k6ihfgIBLeucXsc/lPeh7aBSTr0glwahBt732i2nJ2ZVLZP5tpkktUkSuhCxmNDb
 42nk6rL8JsUghw+P4NaIwJoIUhqYTpPRf2Z317dtc11QQXSSv6vqdYITuaFJmNH38j40aMf0epeMM
 rENMt+enMfkzEfbT+lBBFQ4MZd/NxAb/IpIQ==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30;
 Wed, 26 Aug 2026 18:23:20 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 26 Aug 2026 18:23:22 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Wed, 26 Aug 2026 18:23:22 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
 <r.zhambakiev@prosoftsystems.ru>
To: Andrzej Hajda <andrzej.hajda@intel.com>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
 <r.zhambakiev@prosoftsystems.ru>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: [PATCH v2] drm/bridge: tc358767: check regmap_write() return values
Thread-Topic: [PATCH v2] drm/bridge: tc358767: check regmap_write() return
 values
Thread-Index: AQHdNV4R9Ssj8fJLJUq0dXfDXhMkww==
Date: Wed, 26 Aug 2026 13:23:22 +0000
Message-ID: <20260826132251.113084-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.1.89]
MIME-Version: 1.0
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

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

The switch to direct regmap_write() calls replaced the tc_write()
macro, which bailed out on failure. At three sites the error check
was not carried over, so the return value is overwritten before it
is ever examined:

The DP0_VIDSYNCDELAY write in tc_set_edp_video_mode(), and
both DP_PHY_CTRL writes in the main link PHY reset sequence in
tc_main_link_enable(), whose error is clobbered by the following
PHY_RDY poll

As a result, failed I2C transactions to the bridge are silently
ignored. A failed DP0_VIDSYNCDELAY write can leave the stream running
with stale THRESH_DLY and VID_SYNC_DLY values, causing display
corruption without any error being reported. A failed PHY reset
sequence can leave the main link PHY in reset; the PHY_RDY poll may
still succeed because the bit was set during the initial AUX link
setup, so link training proceeds on a bad PHY, or the real I2C error
is masked by a misleading "timeout waiting for phy become ready".

Propagate the errors instead. The callers of both functions already
handle failures by disabling the main link via tc_main_link_disable().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6d0c38315915 ("drm/bridge: tc358767: Drop custom tc_write()/tc_read(=
) accessors")
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
Changes since v1:
- Fixed text encoding of the patch itself, so git am applies
correctly
- Rephrased patch description to avoid checkpatch.pl commit
reference error
- Added explicit `From: ...` to the top of the patch body, to
prevent checkpatch.pl email name mismatch error
- Dropped Cc: stable because this issue is minor and does not
cause regressions or crashes.

 drivers/gpu/drm/bridge/tc358767.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc3=
58767.c
index 7188935fdb82..d6b62546fed0 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1014,6 +1014,8 @@ static int tc_set_edp_video_mode(struct tc_data *tc,
 	ret =3D regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
 		 FIELD_PREP(THRESH_DLY, max_tu_symbol) |
 		 FIELD_PREP(VID_SYNC_DLY, vid_sync_dly));
+	if (ret)
+		return ret;
=20
 	ret =3D regmap_write(tc->regmap, DP0_TOTALVAL,
 			   FIELD_PREP(H_TOTAL, mode->htotal) |
@@ -1144,9 +1146,14 @@ static int tc_main_link_enable(struct tc_data *tc)
 	/* Reset/Enable Main Links */
 	dp_phy_ctrl |=3D DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
 	ret =3D regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
+	if (ret)
+		return ret;
+
 	usleep_range(100, 200);
 	dp_phy_ctrl &=3D ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	ret =3D regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
+	if (ret)
+		return ret;
=20
 	ret =3D tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 500, 100000);
 	if (ret) {
--=20
2.53.0
