Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B17C5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DB389226;
	Sun, 16 Aug 2026 14:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSNK8VYE";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0972310E265
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 06:24:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3260632a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786861441; x=1787466241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2+VXnP47ytTguI11i1PKxSzDAJacSIz5jyC8KDUI+I4=;
 b=KSNK8VYExEi1leXEykG+e54H3uTw9vDn3O6ibsb5glj71JpThhjEa9oj70hBLegnbN
 ALU9APYIT9PYvbcPUm+8oj5qCs4iEz2YUrdxLL7Tp2M+MiqqXGu6HZ+NlUT4YEjz7glx
 aU8/cP4WCFjpOrZ948+E4vJdh7nkMEl/1luw41/kwjpz6aHgmsyLOzRX8n5txRIlWc/1
 ZXvGhZHzlziAtm7bou8ULhwsiDSxISMT6dZ1IKNsGr0TvLF7kVhbqIivTls4xJxiqUHt
 wYc5l5/URSPAzw/OaAdABgOTQLhhZUmL+ri9hFieU4kawjcttu05ea3nWDpYThUgaG7X
 c9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786861441; x=1787466241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2+VXnP47ytTguI11i1PKxSzDAJacSIz5jyC8KDUI+I4=;
 b=X1ht7WUCW0ucbz2NhD9Ng68aYlrJVgx9QbyAtumH+p++OtXUdPeTNB/T2sEFk3vmpi
 1+jX7RkdXU1P0nfwbgvQDPKmCoSj/f0XRrHOcM3BvhOmSFXZKAcymO0kiKpMzoD4sOaA
 tHv+aJdzgJnHNXpDf+szAXYoehoZh1roFuD1+scwJ2EUXdzRFx90UApxM2RJCvMiq8Tp
 woBwlzBLI2xHLrFVRFYPo/7YGVe0gAMgrdnjWXYG/5Iq5g/ZklyijMcV9lYOuYi8e5b7
 gcg1Y5MHJycHmMjwg5xbQVXeiOSSqAwxo5l1uxURTv3Hxrh64RP1Vk4CmBcARMNdGsKm
 duAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0s62zxP4UokPRwHkGDUJf4lME+Y8eTVPjGuhVZiVQUmv7VPAx+zaIOCeigaacYMshb6JPlSRLd5U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykX0tY3r6Nls4N/Wea81qy1T+vAbjg5dTNm8l7lf6LIX6n3Ksv
 +wwL3FrTu6I7X36yo7vvjkSZQt3VEfQjCkFGwl+w2sGoLt9Txt7uM3My
X-Gm-Gg: AR+sD12VDoeAp7IsK28OYPjz4YE44fGHLg+ueAgM7Rn7jGzQhjlHRf2HR6DLtbWV8Aa
 UTwbnNz/Nuceqdyb1ZXFPtbd9gW8jMEGLsbC5omP0GEIv/UUEJaO8QW+IzIR1XtVbLcHDf4r/w9
 TfCKb2SSaCL/ccs3V9ridN/pCDVPFhSljSJkA0J3nmo8ImdfHEHwCbfeRJ720y2hFLnPdev7Drs
 QEzervkyfCDkmG/opM3iOoLgzcoYM5utbm+wzNcIx1fYBnu7inU59i3XTttFcTH44k2p8siV+LJ
 T7pPqJ4lV7tAx+4hOPBdC8FU0axS5cibR3BKXnPEnTAL3xCKDeDXjmNv6LBXPuBid1qdlxS1YpE
 rXbQugP/ENBCK2ziL/3b15eLZVh0Hu6V+EgZRAV+Xiskn1JwoyQV7pSJOQnEv1Kh1YI6WG7FRJo
 3FlewxWCg3kzHvmaUn1wXy/DScrKWoVK0/VxLYYE32T4STGLByo0lLIURFeLN2WLE89a47FNaeW
 nLmpNPw5pAUbT48qC1Z8okgVldT9aiQdA==
X-Received: by 2002:a17:90b:5450:b0:38e:655c:6516 with SMTP id
 98e67ed59e1d1-3933b4f3238mr18629232a91.0.1786861441487; 
 Sat, 15 Aug 2026 23:24:01 -0700 (PDT)
Received: from allen-xiaomibookpro14.lan ([2600:1900:4030:ad65:0:1::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e14346sm686330a91.4.2026.08.15.23.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 23:24:00 -0700 (PDT)
From: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>, 
 stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 intel-xe@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in
 bxt_sanitize_cdclk()
Date: Sun, 16 Aug 2026 14:23:44 +0800
Message-ID: <20260816062344.796615-1-xspeed1989@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
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
v2: No code changes. Resent with From matching Signed-off-by
    (v1 was sent from 304750714@qq.com, which is not on the
    Intel CI allowlist).

 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 7bc9b956554b..0438f5ac78c0 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
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
-- 
2.55.0

