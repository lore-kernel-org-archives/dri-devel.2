Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A73C55174
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1464F10E47B;
	Sun,  2 Aug 2026 22:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.srl header.i=@kernel.srl header.b="MZDZr3iP";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99D610E438
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 17:07:02 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso5537555e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.srl; s=google; t=1785690421; x=1786295221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRAy2nVyQPy4R9FHWUMzTGUQy8Oyu41Og5cXR0XYVss=;
 b=MZDZr3iPGjvriRzFaq1J42OFHTpqPDE699owHosylqzoEEfExish/+umtooucTo0hm
 neuvVZM/cwNeqJ/MkBynNEK/460ylRUN4jvENrVNj0b9hmtJmgDDjdx3QYCnrqg/5xzM
 HDZZVyffG3y4bKdl47Lvbgv4s3reLFwEJelWDJui2N+SvlJnLV121/gAWiI/6YHun4HA
 qMs2WnVkpTfu9XtkKPyMMLuNrT7LGXixhSrTdOt0qGQt66Ng+56pI5EfBu5TQMpJCD1q
 uiAXEETTFKHm2rMszUXZR+ETaGhwFl5b41oXD4xcz/7JcdpDZ+VjtRn5dL5f+RbkhSNj
 huHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690421; x=1786295221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BRAy2nVyQPy4R9FHWUMzTGUQy8Oyu41Og5cXR0XYVss=;
 b=SLzXu/AgKf2tvmDY2UmUO8q7DQVZ2kG8SlLi1XGV7blaL2KlYUT4zwJrQeSLP1DfND
 y0kYJdbhXsIJkEbZX2+w1GdPpxLj5UoXZGp4ibZRmoJtZRmhN1AfHbZASew8U2VekBJf
 MqB4ezCKm3NQi7GYtCQA6ZbojYvGyyFuYFPqVf6ihF75S/7Y0j+Ie2/13xqodqLQXPhN
 RkXglDG9vYHyEzrQjAZwBUSgiPzgK6RQ3Q6a3r8+c+nUkrJXpcytxycxlYsC4tK762L/
 nvFU5IuJvpEv01sYjkbqhALWL+zn4erkNk2gya3g/CUonWNtBPefuXVMBUsHyn2jPRSC
 bPuQ==
X-Gm-Message-State: AOJu0Yx9vFM1oF2pD7KGFG+X6USUjo8SYkdl2DTMbGeKpkhEoGiJNGY5
 HFUAxPEn6PBC9ggAmkbhw2hwTMtjis8HRs44CSTQf7Xcaqy1NLm3bS431h8boTztDLxcI5nm4FO
 J959Gxi2NEA==
X-Gm-Gg: AR+sD139tDWo3uup8aENiBTBp3xfWHh6JBO+59lwSNjnb6bBuXMORCL6VmcBRAEmqDG
 9gfPzJrv72Gspby8d/+3OYyoctQ3zP/rTLY/7/TiZcPrfMYQ6orumB/2W3WFUwNR94VrMaqN0ob
 ulbcbBoetL43ENRZxhMptZoPXqh9uOursgeU3Fhi56zmzPw/04FvE0Ecl/d3sFK82TciAmPg17q
 Vg7ujx/fLRYVl/2i7/NXDrL2thk+7xdVAyiQnSRYbXI+328VOkyDC/WjFXQTNGOe86dTKU83M4w
 Np1VKGDfYbkpBSvA98IP230zXqDHIxaVygRaCccbAWkkzGDo5icWOeBYVeNfE6+LrJsott0n7kO
 Wd5O0H/FrmUJVNQlSV6Ms+XS7yAUhI0sJpjuVBs2CXNLOmZJyZoOBbG3E4ZZWVPg4T8nYUyISsJ
 jUUFFvvz6R1ItpVK/yaf8G9hsNcHvyK96fyCHUnKBj/4mLElGwr5LS7jVCmz2GOnUNdyjurqx0s
 IpoQKgs75/wfrz3ojE9XhCPrioltGYnX4qER5lv+Dnkg0KP/ReD/drvTpUp7ZBI/OVMzc6ExqQR
 Nt64+VoOiU3VmMrAbjBNxZCk+nei7clVbMZaAU5rQC5GPwm7VzWYO/9bI2GDQA0gHlx0BsXS6/a
 pK9GZb0luk1qEo+LaURJK7iZXurSGeguP1DgXEkKwtUmF+xiD7Q==
X-Received: by 2002:a05:600c:8715:b0:498:273:327a with SMTP id
 5b1f17b1804b1-4980c66b5d5mr160221615e9.7.1785690421108; 
 Sun, 02 Aug 2026 10:07:01 -0700 (PDT)
Received: from KITT.minareto (host-95-230-187-130.business.telecomitalia.it.
 [95.230.187.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6745csm161687225e9.7.2026.08.02.10.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 10:07:00 -0700 (PDT)
From: Cristian La Spina <cristian.laspina@kernel.srl>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Cristian La Spina <cristian.laspina@kernel.srl>
Subject: [PATCH 2/2] drm/i915/display: accept a luminance range from any source
Date: Sun,  2 Aug 2026 19:06:47 +0200
Message-ID: <20260802170647.206880-3-cristian.laspina@kernel.srl>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260802170647.206880-1-cristian.laspina@kernel.srl>
References: <20260802170647.206880-1-cristian.laspina@kernel.srl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

intel_dp_aux_supports_hdr_backlight() refuses the Intel proprietary eDP
backlight interface unless the panel carries CTA HDR static metadata.
What the interface actually needs is the luminance range, and
intel_dp_aux_hdr_setup_backlight() already reads that from
display_info.luminance_range, which the DRM core now also fills in from
the DisplayID 2.0 Display Parameters block.

Accept a panel whose range came from there too. Panels carrying the CTA
metadata are unaffected, including those that provide the metadata block
without the optional luminance bytes and so still land on the hardcoded
512 nits fallback.

On the Lenovo Yoga 9 2-in-1 14IPH11 this replaces a backlight that does
not respond at all, because the PWM fallback drives nothing on an OLED
panel, with working brightness over the 4-500 nits range the panel
declares.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Cristian La Spina <cristian.laspina@kernel.srl>
---
 .../drm/i915/display/intel_dp_aux_backlight.c   | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 7a6c07f6a..8ac47ed18 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -136,19 +136,18 @@ intel_dp_aux_supports_hdr_backlight(struct intel_connector *connector)
 		return false;
 
 	/*
-	 * If we don't have HDR static metadata there is no way to
-	 * runtime detect used range for nits based control. For now
-	 * do not use Intel proprietary eDP backlight control if we
-	 * don't have this data in panel EDID. In case we find panel
-	 * which supports only nits based control, but doesn't provide
-	 * HDR static metadata we need to start maintaining table of
-	 * ranges for such panels.
+	 * Nits based control needs to know the panel's luminance range. The
+	 * DRM core fills it in from CTA HDR static metadata, or from the
+	 * DisplayID 2.0 Display Parameters block for the panels that publish
+	 * it only there. With neither there is no way to detect the range at
+	 * runtime, so do not use the Intel proprietary eDP backlight control.
 	 */
 	if (display->params.enable_dpcd_backlight != INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL &&
 	    !(connector->base.display_info.hdr_sink_metadata.hdmi_type1.metadata_type &
-	      BIT(HDMI_STATIC_METADATA_TYPE1))) {
+	      BIT(HDMI_STATIC_METADATA_TYPE1)) &&
+	    !connector->base.display_info.luminance_range.max_luminance) {
 		drm_info(display->drm,
-			 "[CONNECTOR:%d:%s] Panel is missing HDR static metadata. Possible support for Intel HDR backlight interface is not used. If your backlight controls don't work try booting with i915.enable_dpcd_backlight=%d.\n",
+			 "[CONNECTOR:%d:%s] Panel is missing its luminance range. Possible support for Intel HDR backlight interface is not used. If your backlight controls don't work try booting with i915.enable_dpcd_backlight=%d.\n",
 			 connector->base.base.id, connector->base.name,
 			 INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL);
 		return false;
-- 
2.52.0

