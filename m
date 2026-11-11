Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE860A263A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eyu0Dzke
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33AF10E1F1;
	Wed, 11 Nov 2026 07:19:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B812C10E1F1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:19:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7761B41FCA;
 Wed, 11 Nov 2026 07:19:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794381582;
 b=i7U5cy1IMGIYDIghRZr9xuLBHRB4nzNsOoC2ibO6rLnwpL5NTKxCBw/gSOAliUfBSLxu
 QLNysSAIJTzCeQ8VB5TuvtEPA9xWjTezIVuyigCKNzX3QQ+hE15ep/SBLriCEcLWOxkTD
 7/czv45VsCy5y9y+8K0OcMT2UmbswdsVOuD0C0adbJYjU7Qz/1RzXHYEEhlWStFkriDNv
 zzBPoC0k1/D3YTEUvuXz2rC95Engs3LDIJtkF2jYNlaWoytzFtvb0aceySlcYTsMX93Sr
 O6T7st24TZWR6hMEEmiHbj1xS1YG6xIsdttAqr7Qyu+x+sTOZKiyO0wtJy2CI6xeEsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794381582;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=83VQc+V/d7sVytOA37pnJFrWAXWZbo8taqD5cZTmQxw=;
 b=pcT6WQBWqhz0a6XcKSaqrYEz8OyAya2pYIXa5rQBhrLXL7YF2IRERVvmOJl7Jrv+9Bxx
 4GrOgxkGgUHOStj8eoa72/q6P/UIULgMp4IDwkQcygKdmcve2PkyRr2fmjvfy8OyHoK5y
 JdrVEs4+UCXjPTJmE7ogxwJfxYDvhDM0KYydFgUfsBq+CtjV4SkdJR5BP4elGs7kCcgdg
 ueTQNy/GYDeesEmNWPQdv8t6HT+ajgX93/rlBU/oyDZTx11H/Ik5khA3BVeX0/rc2ZMze
 2mTNRgioJid0fLcpQL/FuWn5whYEjDN7tBUQcHj1BpaQf6Xwi464lxq+AtoiNwsAUzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B67EC1F00A05;
 Wed, 11 Nov 2026 07:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794381582;
 bh=83VQc+V/d7sVytOA37pnJFrWAXWZbo8taqD5cZTmQxw=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Eyu0Dzkecdtiey1ZynU2sG/qi8i1f/+P4YKS3y+4Gkn4K55QV95okpA0c1lVKHOWm
 KiFMD7wkdq1S3Rg+ZC6IlZPHxU9swHK5QmKhy4exCFC8e3XBTvmoKBij0IU1yqOcrq
 1ozdWXTVxpVoms7ba1pIoSbw6O9xYorL/H9RDcpd1KyOeWq2v+WKjvklneT0a+2fxY
 Kc5mix5TiO2kv3oUQ4SE9UQ2QiNQ/924t3X6E6kSZR4BQB1t+Rwol9LAkVsKc/ISwx
 o39+PsFVBixthzVfPMG7cEO8seAykS+6YQ3Gl7hE8tyOOMWu+k4cI/+gT2pygTlYbU
 Kippfj3w0atCg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1654948E41;
 Wed, 11 Nov 2026 07:19:41 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 07:19:41 +0000
Subject: [PATCH v2] drm/bridge: Fail an unsatisfiable bus format
 negotiation with -EINVAL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-drm-bridge-busfmt-einval-v2-1-fbb74905614b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0Jm7RimEKKuvIdhQdsBxlAwLTQaw
 t0teAGXL9/PWyGwFw5wy1bwHCXINCZQpwxM34wdo9jEoHJVEVGO1jvUXmxK9BJaNyPLGJsBlTE
 XXVjKy2sBaf7y3Mr7uH7UPw6LfrKZ97+90UuYJ/853JH23h+aSEhokqTUVhWqKu+da2Q4m8lBv
 W3bF9Z/s8LSAAAA
X-Change-ID: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381580; l=4655;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Ziyi2IZLgbKXw37gKHjsH70kDZh1z3mkpnBpz48qVjs=;
 b=CTIsg0OH7JUFZHae3BOEI0lTa03NHzsUj5+AJYyeUAkZXBYalcoBcTWtAguxGRZ2EpGL2Qucv
 5Xtku29gr03C7dzC4uZ1Sz8P/z6KDmNLgM9vJDlwzeeE3DIKfNGMmX/
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

drm_atomic_bridge_chain_select_bus_fmts() reports that no chain of bus
formats fits with -ENOTSUPP, and drm_atomic_bridge_chain_check() passes
that straight back through drm_atomic_helper_check_modeset() to the
atomic and legacy modeset ioctls. -ENOTSUPP (524) is a kernel-internal
code that userspace does not know; for a configuration the hardware
cannot do the atomic API returns -EINVAL. Since the connector "color
format" property makes the negotiation fail for any requested format a
bridge chain cannot output, userspace now hits this routinely: a DW DP
connector asked for YCbCr 4:2:0 on a sink without 4:2:0 support gets
here with no matching format and would fail the atomic commit with
errno 524, where an HDMI connector asked for the same returns EINVAL
from the HDMI state helper.

Return -EINVAL when the negotiation finds no chain, with a debug
message naming the encoder, and make the drm_bridge KUnit test of a
chain with no bus format path, drm_test_bridge_rgb_yuv_no_path(),
expect -EINVAL from the atomic commit.

Fixes: f32df58acc68 ("drm/bridge: Add the necessary bits to support bus format negotiation")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Found while making the DW DP bridge honour the "color format" connector
property on an Orange Pi 5 (RK3588S): once dw-dp only offers the bus
formats of the requested colour format, a request the sink or the mode
cannot take leaves the chain with no format, and the atomic check
returns the kernel-internal -ENOTSUPP.

Tested on that board with this patch and that dw-dp change, with a
DisplayPort monitor whose EDID has no YCbCr 4:2:0 support: all 74
commits asking for YCbCr 4:2:0 over the monitor's modes and depths are
refused with EINVAL, as the same request on the HDMI connector is; the
296 RGB, YCbCr 4:4:4/4:2:2 and automatic cases still get their format,
with the picture checked by a camera.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed and tested it
as described above.
---
Changes in v2:
- Make drm_test_bridge_rgb_yuv_no_path() expect -EINVAL instead of
  -ENOTSUPP; v1 broke it, and I had not run the DRM KUnit tests. All
  drivers/gpu/drm/tests suites pass with v2 (UML). Reported by Sashiko.
  The colour format series added that check to record the value the
  negotiation already returned; I found no review comment about the
  error code on the test's postings (v6 to v17), and the atomic uAPI
  reports a state the hardware cannot do with -EINVAL, as the HDMI state
  helper does for the same colour format request.
- Add the Fixes tag, for the commit that made the atomic check return
  -ENOTSUPP. Suggested by Sashiko.
- Cc Nicolas Frattaroli (author of the test) and Boris Brezillon
  (author of the commit in Fixes).
- Link to v1: https://patch.msgid.link/20261110-drm-bridge-busfmt-einval-v1-1-c0494bd23264@gmail.com
---
 drivers/gpu/drm/drm_bridge.c            | 11 +++++++++++
 drivers/gpu/drm/tests/drm_bridge_test.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8ae2f9b1db44..6a97b579c604 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1437,6 +1437,17 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 
 	ret = drm_atomic_bridge_chain_select_bus_fmts(bridge, crtc_state,
 						      conn_state);
+	/*
+	 * -ENOTSUPP is the internal "no bus format chain" code of the
+	 * negotiation. It is not a valid userspace error code; an atomic
+	 * check that cannot be satisfied fails with -EINVAL.
+	 */
+	if (ret == -ENOTSUPP) {
+		drm_dbg_atomic(bridge->dev,
+			       "[ENCODER:%d:%s] no bus format chain found\n",
+			       bridge->encoder->base.id, bridge->encoder->name);
+		return -EINVAL;
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..792dbd035501 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -1351,7 +1351,7 @@ static void drm_test_bridge_rgb_yuv_no_path(struct kunit *test)
 		drm_modeset_backoff(&ctx);
 		goto retry_commit;
 	}
-	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);

---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


