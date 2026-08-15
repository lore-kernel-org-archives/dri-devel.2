Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C597C5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E14A10E2EB;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="lfa3hg5K";
	dkim-atps=neutral
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com
 [203.205.221.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F3710E1DE
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786796762; bh=jTXyFKm0R7DY+Za1M9TAqurhFo7QSaZ9AjGQD+n13oM=;
 h=From:To:Cc:Subject:Date;
 b=lfa3hg5K/rN4rugEfXogI0lSyAOxUGKNQzU5bGIVo+MFShCAERJmLs+rZkOwIj8Zz
 XnAWpzBAXhGe3xvt/yMGeiUVIo77aPTluYQheThY1Wy8cL1iKfQ7yoZIkHll3gtv2D
 QzWW99fzoFX8vjEMF8oq4lSZyHJ/7Rhjx8+tJNmY=
Received: from allen-xiaomibookpro14.lan
 ([240e:39a:35b:26c0:8997:9440:4da9:9b8a])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 6741CE0E; Sat, 15 Aug 2026 20:25:52 +0800
X-QQ-mid: xmsmtpt1786796752tcm8domqh
Message-ID: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTknGIKLCns5qN/q7G0+BxozUGLCzIP+qJXLp0bidUOAA5qR3fYHv
 EzjJCntptfkA80Ol9kYtlRr23hhb/UiCQ/gb7yp3smONLHaZ0ayKHYOIzWDdUWH9fKh8vyTU+Klt
 iMjFqkzdAFNKbZZlOURIqJcnRTHZ5A+uuyVvqqeaW5Ob6MIxLW/yGXiFg8uaVBjbSZ0288sLnOvH
 qwmt99rgPWhs97IYSgmQ45zj7TnLHI8P+OXaEXHuMR72o/9oDrJG5VxhJJqOAJugHSul7b2pXWeq
 ekj1vET1yg4C0HlpyA9iVex12LD7jHrikYneMbcTu3ZD4hDEx4BHbYDA7xA3tzpOz8t5OgtJ2rbg
 DpRt+39c6gF4z81eQU6YJXFOYdf8roAQfSqzlCtUodxbk3b5A2VsyA+qEfTi5fa1wLUPrC9FbCHz
 xkX70kctkvDtJ5oML9QF8q2CEZOLFUvTNyneVZlJGKQnZI5dVHH7um0b0wqS0jSwog1lHaWMUaG+
 5BNLPNSKkwvP6R9gu7+6xFrhgIVK0jz0LGp2anviSCUZpw+i74M4QqJxQMJTieANX4qQ09HOTfwU
 ggvaEA9QmEeVznSTG4rqNA1P2JGwXWwUSCSfO6dkOsWuqF95tJ04zpQ4maQ2ov8O49lSJUC5jfG3
 yRk419Lev5EnAHVZ8wJaxXtebGfTkMr74w7MhTAJiNpRz+HsQC+EMDTQw3ikwwvL4hiXQQklZr+r
 fYFsYmqiYwqQzmj8w3hlNIytUgarxti23IP2+4qtAK8fM8DCf7yKzAhjeLV5k5YUyldIjsZ3FWB7
 r+/hb5IoY4vDCzI/NbaH6+he8WQElQ4mzJV26rzudVbvI4jSa4XB0N69hRML4hlIwLAqBgwwoyQF
 gmkdj6ESnBEAq9ivqHzHem4eSlO9aBa/4GuQcVvygsYiiVhAWl4wNrEGla66kuDD/NeyFw+s3zpZ
 Qr1oPlGO/HDm1tzhAka1IaDu7kKrIOBReJ9UY4txNoQXtxasvLL6zwn6OQIBOMvpn58xk3dLG6So
 0DTzJgimaj9EzzGsmn8yIpWSKDxcnGaLpzVpXtislnC4sCT3H7EsSUHsb66YKLZVaIRxhTeg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <304750714@qq.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 ville.syrjala@linux.intel.com, stable@vger.kernel.org,
 Chang Jiong <304750714@qq.com>
Subject: [PATCH] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in
 bxt_sanitize_cdclk()
Date: Sat, 15 Aug 2026 20:25:49 +0800
X-OQ-MSGID: <20260815122550.67009-1-304750714@qq.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
comparing against the expected value.

However bxt_cdclk_ctl() does not include the CD2X pipe select field
at all on DISPLAY_VER() >= 30, so on Xe3 (PTL) the normalized
readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
never match the expected value (pipe field 0). The comparison now
fails on every boot and we always take the full CDCLK PLL
disable+re-enable path with the BIOS framebuffer actively scanning
out - exactly what this code was trying to avoid. On a Panther Lake
laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
"CPU pipe A FIFO underrun" during probe and persistent full-screen
scanout corruption for the first KMS client (the SDDM greeter);
the corruption lasts until the next full modeset.

Only normalize the CD2X pipe select field on platforms where
bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
check.

Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Cc: stable@vger.kernel.org
Signed-off-by: Chang Jiong(常炯) <304750714@qq.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2364,8 +2364,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}

 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {

