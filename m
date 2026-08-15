Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B196C5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944AC10E2E2;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CkSBZ7k9";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909E410E20D
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 16:41:59 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso2073490b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786812119; x=1787416919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B7syqqlv6107gB1yL3JYNqE/FxDJIWovYEa1sbJDV+M=;
 b=CkSBZ7k93cTL695Zy/LhesTrs2Kfeo6ct67Jf6BejyImkReQRygMKUSId4qPteznTG
 GItPw/ARx8e21c5ujM8wpLr9iKkZ0NnO+/8l0zSpeyE8mrZtHMtOk0M7uPoVCkH7hFMP
 wrecd+ckcYfwLbmwiqZ/j9J/Yhg8RdwQPN5tXR1XzFuIf1AkkIuOm/BWPGJGvMGiJBsA
 dgpNErpR1IfC634IqzJNNEYuJtnUha0yxG+oBNIExbPpnRT3Pbpf/ShD02khHrRaqNDh
 ZddDZavoMTc0Xn2d5PVRHCEJXmIimTdcH1jX5l6KDLN0+uO1FZLrSgVI8erZvvgAT6p4
 4W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786812119; x=1787416919;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B7syqqlv6107gB1yL3JYNqE/FxDJIWovYEa1sbJDV+M=;
 b=oWiaz124OPTs7LFcwtINhZo7S0gznxHxzeQiUEDBm26hFqmUPNZ0knKb0C86RdNc9I
 xUmViZ6+sakex3rfFPeeYJyjOqYUfgvAykhh83Bnp7nr9qb7GmMNVh6L6E+Av0sIeTjL
 pEb0f5EY8KmjyjsOHtpuxE0wRJwiNEJAPv5eNvjiqU9tpNWPCC/YMM9umuBn7gp/UCU4
 cSB6ZwPWh8u78YW0Koz4a3bTz2duVcIXt9uSJ3UCsvNkkyP/Cbt5pfJ5jEUaWv8EoKf+
 mWrtyZttTsTnZ4H25BJ9YO2bprmzl3c4k/ZkUv+yClpYuAxCSp7+jVI3CVgcvTqUMyHA
 VMYg==
X-Gm-Message-State: AOJu0Yzcx3+n/n5wVtfbPug1uLPBBtSAsWgoCAoE0TtRgEp41BoruGKL
 Nm7o19YDYAe998BhDnY2Zx6zS0EC5lrm42EYi6VqR/oxC5PyciPyl50/
X-Gm-Gg: AR+sD13upf+Uo2FzbTXw+iKfQxzKKOsuwcml+RUUDCkpkVGzE2u788+e6zLYXZRIJCq
 N0mIq76msnrRu9WwHSHxhSZ6N6o3xuFbVLBxCTqeTcfoAIimUq7hO5RZGHdIbCJjPEGW6UrEnBA
 K4x550z8CB31e4PYzPE0VMN28+DNl9S+rqST50gX2MRWAh21u8Gv0c4YrECApwYCfYxNGjQG7Q4
 5KZSSKKiYhUBjZVggSDfm/6UBfD936f1mylspBUMYX6NmlS9NswLe5oe4bAbzEV/p8MNuvIUN5S
 q6zRpQQ6wKlXLEmC5tXuB5zENO0JCkxHvglUVcj6GTjVqf02I/CeLaRqeo+Zquq1xDpdmIDoiH2
 d/SnoDepciYikL+w4ybPZlZsPoatpC3QtcObDa7vY9eQ6vCGGT6x+OWGVKaiOA9oxFxtYVHZB3h
 WU2Jm4lAJvoGqJlvI0wVuytsFaJWBkjrOnvy78NyeSGfdNgK6h4c36jdghRaGtOO+Uz9xDOCcd5
 lIKQfAc1I7cX1H0GyCcGA==
X-Received: by 2002:a05:6a00:1810:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-84fde2defa1mr13881212b3a.39.1786812118931; 
 Sat, 15 Aug 2026 09:41:58 -0700 (PDT)
Received: from allen-xiaomibookpro14.lan ([2600:1900:4030:ad65:0:1::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d249c54sm1405086b3a.48.2026.08.15.09.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 09:41:58 -0700 (PDT)
From: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 ville.syrjala@linux.intel.com, stable@vger.kernel.org,
 Chang Jiong <xspeed1989@gmail.com>
Subject: [PATCH] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in
 bxt_sanitize_cdclk()
Date: Sun, 16 Aug 2026 00:41:47 +0800
Message-ID: <20260815164149.607690-1-xspeed1989@gmail.com>
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
Signed-off-by: Chang Jiong(常炯) <xspeed1989@gmail.com>
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
