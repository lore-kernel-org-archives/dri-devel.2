Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB27606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6NzlCru
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF2A10E0BC;
	Tue, 27 Oct 2026 01:14:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A244A10E0BC
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:14:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A44D60052;
 Tue, 27 Oct 2026 01:14:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793063674;
 b=2lvkoI2Ca4K9NUvIrOg2rwO8ECQc871sdIYAKT4dhUKREp4IiKh46JeMyda99QI/FxCA
 de2gLciFEgoI4v/LoR4a0vNUGVNbR2+oIGoMCsL6wON6ai7hOQtslUTApjhQ3faHja8tB
 HwTCujXo/st8ApUo0ohOrDyDF89+nVKQwfk8uPSYaQi8CrlxN0lmxS55gCwFBADZL+58C
 3h0PGl05Uip0hxnYeJdRabIwke1DcSb93Vn+Hex4MYY9UA5mFWPdOYnAtU1AGMMLLck7H
 efypvKOGaAYmcbjyZah0prZejeQkcNkhXCCz3NPnvlrHp1dcHncczeUI/CuPXPmLrIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793063674;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=jMsIChqulb9GIa12+hHaFUFMvoztx3aWdNCiyNkirSY=;
 b=N/l948Eu5re927ZqPEI0jr0nIBUqsxt4WR7iwtvy8IAjyRPUk8jTcKCLqfPUapfERapL
 pquNs+4yIYjngWGFAYuWSQxpfISaxJzlz/ajDJqZLw53HQIH7d9Odu6KJoKC0ydDBKvGv
 QI/3loWWD4ZFyrNAc/5K4b4o8ksK587vszQ+fvLYWeV3jAzq4NooH8U6V4nEQiLmiU0s6
 1tj0JiLsmUiYzP+RolpPkcIV1/F5rlBPlZni+T+VSKeNGeWIFiIYzU3OR2jVaECdDvYu4
 Ozi0UmBQEdYSQYEBDvTubXFSvYlzdEuKUaODq3MymdPLhRjA95zkgTOmj1RXBmwlmRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 555851F01825;
 Tue, 27 Oct 2026 01:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793063674;
 bh=jMsIChqulb9GIa12+hHaFUFMvoztx3aWdNCiyNkirSY=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=f6NzlCru5qtpXU6hmCipRQvJVJbjV5FRpqOmMzMJuX9z6Yev8tjfomVnt7rvRZa3t
 vgmBcThL4TP0meisMHFil8HdzbmnKBa56AevKMor5AuawGimZPwTZfwnztfM6HrsxU
 ce8FyrqLNx1FNAL75lScl/CHdNVQhfuMFTrpCq750SWU69UzWSCnvzHclUbK0IRksq
 BLffqw2KZegYS/NE9sqpFfYpw9TYDHVQTPeVFK9ha2V/g74YyX8A5GSSJPzdkbsiLK
 Z+HP2jMjrIVJfqihuSNS+t/GtJm6fXedUFkqX1QwgkWd16/3wpJspxP0wrfv9Kj5xD
 w/k3ogWadFmrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A5DCF44F22;
 Tue, 27 Oct 2026 01:14:33 +0000 (UTC)
From: Haipeng Lin via B4 Relay <devnull+jimmie.lin.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 21:13:02 -0400
Subject: [PATCH v2] drm/panel-edp: disable the backlight at probe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-sp11-bl-upstream-1-v2-1-efc84396adf1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQqDMBBFryKz7pRMWkLtqvcoLhIz0QGjklhpE
 e/e1AN08+F9+O9vkDkJZ7hXGyReJcs0FtCnCtrejh2j+MKglTak9BXzTIRuwNecl8Q2IiEbQ8a
 amzdBQRnOiYO8D+mzKdxLXqb0OT5W+rV/dSuV8JfaBRtqG1z76KKV4dxOEZp937+Ogc2WtAAAA
 A==
X-Change-ID: 20261024-sp11-bl-upstream-1-e6616a68d6f0
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Linus Walleij <linusw@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dale Whinham <daleyo@gmail.com>, linux-arm-msm@vger.kernel.org, 
 aarch64-laptops@lists.linaro.org, Haipeng Lin <jimmie.lin@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793063673; l=4890;
 i=jimmie.lin@gmail.com; s=20261011; h=from:subject:message-id;
 bh=Wc0k3oO67F3S7EDiEGmSzJEvwEL5CUGbgzDoGXTLcs8=;
 b=+lS75aoCJDPrdFiEZL0w7xUoK2eON3nABsbxAPsz28j9zI94XDgBJQdLexqdioijrzqv2Zoxc
 8PH2eb3pR4aCab9gRf5IECpOmd6qj4Mb0NEo5JskcYdo1h4E3egOfbO
X-Developer-Key: i=jimmie.lin@gmail.com; a=ed25519;
 pk=3KDRF1RQ/9A7ZUVTdRVEZnVrGltdmq1bRocsOYeXezI=
X-Endpoint-Received: by B4 Relay for jimmie.lin@gmail.com/20261011 with
 auth_id=1164
X-Original-From: Haipeng Lin <jimmie.lin@gmail.com>
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
Reply-To: jimmie.lin@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haipeng Lin <jimmie.lin@gmail.com>

pwm-backlight can preserve the enabled state left by firmware to
support a seamless display handoff. However, panel-edp does not support
such a handoff. When probing a generic eDP panel, it powers the panel
on to read its EDID. If display pipeline binding takes longer than the
runtime-PM autosuspend delay, the panel is then powered off while the
backlight remains enabled.

On the Surface Pro 11 LCD (LGD0779), leaving BL_EN high across this
power cycle appears to leave the backlight controller in an incorrect
state: brightness is pinned near maximum with a greatly reduced
dimming range. Subsequent brightness changes update the PWM duty, but
do not restore it to normal. Cycling the backlight off and on at
unchanged brightness restores the full range.

The first drm_panel_enable() does not recover from this because
pwm-backlight still considers itself enabled and leaves BL_EN high.

Disable the backlight at probe, after acquiring it and before enabling
runtime PM. This clears the firmware's enabled state so the DRM panel
core turns the backlight on after panel power and video are ready at
the first modeset.

This also turns off the firmware display at probe on systems where it
previously remained lit until the first modeset.

Verified on the Surface Pro 11 LCD by delaying display pipeline bind
past the autosuspend timeout. BL_EN now drops at probe, before panel
runtime autosuspend, and brightness control works at the first modeset.

Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
Link: https://github.com/dwhinham/archiso-aarch64-sp11/issues/41
Suggested-by: Douglas Anderson <dianders@chromium.org>
Assisted-by: LLM
Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
---
Can reproduce on an installed system on Surface Pro 11 LCD (X1P-64-100,
LGD0779 LCD) by booting with modprobe.blacklist=phy_qcom_qmp_combo then
loading that module manually after ~20s. This delays DPU component bind
past the panel's runtime autosuspend timeout.

A/B tested against the same v7.2 tree:

- Unpatched: panel VDD off 3.5s..20.5s while BL_EN stays high.
After the first modeset brightness is pinned near max brightness with
a "collapsed" dimming range. sysfs brightness writes still reprogram
the PMIC LPG. One bl_power off/on cycle at unchanged brightness 
restores the full range.

- Patched v2: patch provides the same full brightness range on boot
(stalled or not) as the v1 patch. BL_EN drops at panel-edp probe,
~1s before VDD cut, rises ~0.5s after panel power at the first modeset.

Tracing and functional testing on the SP11 shows unchanged sequencing
for fast boots (without artificial delay), DPMS off/on, and system
suspend/resume.

Panels with shared/always-on supplies and no panel enable GPIO
may continue displaying the firmware framebuffer during the
runtime suspend before first modeset. With this change panel-edp
disables the backlight obtained through the backlight phandle at probe.
The DRM panel core enables the backlight again at the first modeset.
I have not tested this configuration.

Testing on other panel-edp systems particularly with pwm-backlight,
would be appreciated.
---
Changes in v2:
- Disables the backlight once at probe instead of
  in panel_edp_suspend() following Doug Anderson's suggestion.
- Only disable the backlight obtained through the backlight phandle.
  The driver's AUX backlight setup is untouched.
- Link to v1: https://lore.kernel.org/r/20261024-sp11-bl-upstream-1-v1-1-d39bfaf9afbc@gmail.com
---
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94bc54c3833a..d019f4165674 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/backlight.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -918,6 +919,16 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 	if (err)
 		return err;
 
+	/*
+	 * Backlight drivers may preserve the state left by firmware,
+	 * but panel-edp does not support seamless handoff.
+	 * Runtime PM may power off the panel before the first modeset,
+	 * leaving the backlight on.
+	 * Disable it here so the DRM panel core enables it in the correct
+	 * order at the first modeset.
+	 */
+	backlight_disable(panel->base.backlight);
+
 	/*
 	 * We use runtime PM for prepare / unprepare since those power the panel
 	 * on and off and those can be very slow operations. This is important

---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20261024-sp11-bl-upstream-1-e6616a68d6f0

Best regards,
-- 
Haipeng Lin <jimmie.lin@gmail.com>


