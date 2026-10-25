Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D5606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLvIan/L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730DB10E0EB;
	Sun, 25 Oct 2026 00:24:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1EC410E0EB
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 00:24:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71204433D1;
 Sun, 25 Oct 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792887856;
 b=gYRaCUWB6LS5uRCCN9IR/mhLjjU118ehJDaPlhOz0IU3VhLWpllgnDT5x2g+LNTZ9fLQ
 cHHeOufukO/PD2T+oREVz3U2vBEkOc5QysjioTlLae2uKjsQGuxez5w94km+vNfz+0h2R
 oXgBmwqtlnm4rzHKHgGZzwn4EHi5hKLeZcCCN4gT7cDMdmUtdGyKCJ9NdDpG7VylW8y5B
 kR4zUgWNpVO7ni2SSk7YJ7ot2JG+JNrmsZxFsdr2FbDNqGnlG3vJRAbwW+quy8IgUFvNZ
 kVu7/FlCCDixWihKhzxMbatdmyFDXaAT2RtR+uk55lb9t/CniGWO/5n07KnOuVqDOxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792887856;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=jh1RY3xoeF/XaqMjp8a7e4jU3alkw9RlqWuVIZCU8vQ=;
 b=S3EjIPxfhBe0dJEdpkEZS59fzzBRfhBweyELWkhpK2c1qgrV9RFQ4NorsuzaKQ53xpwa
 OcYR2ISCOU6RM8Wshis0Y6n9lDYsHwSgbnsqtxwXvxdFd+sD6Mo8gKgaagdedipIlOOY5
 9Ew7hrKpRgTbp3lSDBAgeUsPaLMfxtmlYq3aoqCk41BHMRYdzF6CG3dK51JfCMqzCahzh
 j02P2/unuzU5keyivLyXbLxEQu/MszKSs84uDbJvx1yZn3gWJosKHhRAqkYBPnAEJ1GdS
 LKPEAy4FxuCeT3agjpDnYAzLg7muY71gRlV2tH/sGwOD7bCzFeZ+9+sT17lyH4Vyq1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A5AA81F01825;
 Sun, 25 Oct 2026 00:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792887856;
 bh=jh1RY3xoeF/XaqMjp8a7e4jU3alkw9RlqWuVIZCU8vQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=dLvIan/LnjFzGr/S5BdRvXIqwHpz2JkUvg8wNPTBahx2c04a4UG6LB4WU6V/K6n38
 idNTjUkuLnF9hM+JCcpc4seul11rBswFF/+5DrWpbOmZyk0R+LdQW0mzl/c2lU234m
 COfEZNSC5OYd/f8E1PP2KS+KRbM8ylpDwJE7tq0js7ZORpvAm6d/Mn/RF0lggs3zjK
 IZz7gGRB7KAg3aAP+sJsEYwECGl5V3xF5cATkax/JcSDdtSb8rBc6CdkqhOTZDwJw3
 Lqpil3VxZkExwGKhtpxrdLpttO0hz6N/oIKi5OqDmr13OFz5IIJVppCY8uIk27rNua
 cylRvVI3wmOrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 02328448FE;
 Sun, 25 Oct 2026 00:24:14 +0000 (UTC)
From: Haipeng Lin via B4 Relay <devnull+jimmie.lin.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 20:24:00 -0400
Subject: [PATCH] drm/panel-edp: disable the backlight before powering off panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261024-sp11-bl-upstream-1-v1-1-d39bfaf9afbc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyMT3eICQ0PdpBzd0oLikqLUxFxdQ91UMzNDs0QzixSzNAMloMaCotS
 0zAqwodGxtbUA0eaJsWQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792887854; l=4817;
 i=jimmie.lin@gmail.com; s=20261011; h=from:subject:message-id;
 bh=Ad1iSx6+Lkqh9DkZeY8irIQ3hUZslhOvNah24ewp07A=;
 b=PogfgUqfM2SzGF0yLihQqRwvLshIXA7c0iqTKAbXu3RzurqjhsnfnnS2SZ8SfVxRdSC7DzfEd
 V7qdqNst1DzCD3vex6ve2i0T8eyEINM48JC+gywDQmJOuwrHr9yr7ve
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

If the display pipeline takes longer than the runtime-PM autosuspend
delay (1 s) to bind after the panel probes, panel-edp's runtime suspend
powers the panel off while the backlight is still on: pwm-backlight
inherits the enable state left by the firmware at probe and keeps the
enable GPIO high. The panel supply is thus cut without first disabling
the backlight, leaving BL_EN asserted across a panel power cycle.

On the Surface Pro 11 LCD (LGD0779), leaving BL_EN high across this
power cycle appears to leave the backlight controller in an incorrect
state: brightness is pinned near maximum with a greatly reduced
dimming range. Subsequent brightness changes update the PWM duty, but
do not restore it to normal. Cycling the backlight off and on at
unchanged brightness restores the full range.

The first drm_panel_enable() does not recover from this because
pwm-backlight still considers itself enabled and leaves BL_EN high.

Disable the attached backlight in panel_edp_suspend() before marking
AUX unpowered and cutting panel power. This ensures that the first
modeset enables the backlight after panel power and video are ready.
When DRM has already disabled the backlight, it remains off.

Verified on the Surface Pro 11 LCD by delaying display pipeline bind
past the autosuspend timeout. BL_EN now drops before panel power is
cut, and brightness control works at the first modeset.

Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
Link: https://github.com/dwhinham/archiso-aarch64-sp11/issues/41
Assisted-by: claude-fable:5
Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
---
Can reproduce on an installed system on Surface Pro 11 LCD (X1P-64-100,
LGD0779 LCD) by booting with modprobe.blacklist=phy_qcom_qmp_combo then
loading that module manually after ~20s. This delays DPU component bind
past the panel's runtime autosuspend timeout.

A/B tested against the same v7.2 tree:

- Unpatched: panel VDD off 3.5s..20.5s while BL_EN stays high.
after the first modeset brightness is pinned near max brightness with
a "collapsed" dimming range. sysfs brightness writes still reprogram
the PMIC LPG. One bl_power off/on cycle at unchanged brightness 
restores the full range.

- Patched: BL_EN drops ~300us before the VDD cut and rises again after
panel power+link at the first modeset. full brightness range works.

Tracing and functional testing on the SP11 shows unchanged sequencing
for fast boots, DPMS off/on, and system suspend/resume.

Two cases would benefit from testing on other hardware:
1. AUX-controlled backlights
The disable is placed before drm_dp_dpcd_set_powered(false) and
regulator_disable() so the panel remains accessible if disabling its
backlight requires AUX writes. But I have not tested this since my 
LCD is GPIO/PWM based.

2. Panels with shared/always-on supplies and no panel enable GPIO
These panels may continue displaying the firmware framebuffer during
the pre-first-modeset runtime suspend. This change will turn off their
attached backlight during that interval, potentially making the boot
display go dark earlier. This matches the driver's powered-off state,
but I have not tested that configuration.

Testing on other panel-edp systems particularly with pwm-backlight,
would be appreciated.
---
 drivers/gpu/drm/panel/panel-edp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94bc54c3833a..87f9c13380be 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/backlight.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -413,6 +414,18 @@ static int panel_edp_suspend(struct device *dev)
 {
 	struct panel_edp *p = dev_get_drvdata(dev);
 
+	/*
+	 * eDP panel power sequencing requires the backlight to be off
+	 * whenever the panel is powered off. Before the first modeset the
+	 * backlight driver may still hold the enable state inherited from
+	 * the firmware, and some panels' backlight controllers come up in a
+	 * wrong dimming mode if their enable line stays high across a panel
+	 * power cycle. Sync the backlight off here so that the backlight
+	 * enable from drm_panel_enable() performs a true power-on in the
+	 * correct order.
+	 */
+	backlight_disable(p->base.backlight);
+
 	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);

---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20261024-sp11-bl-upstream-1-e6616a68d6f0

Best regards,
-- 
Haipeng Lin <jimmie.lin@gmail.com>


