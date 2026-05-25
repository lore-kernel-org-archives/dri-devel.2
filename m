Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA4CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0338210E131;
	Mon, 25 May 2026 13:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="VyWwa/km";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331BE10E131
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:57:37 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7d1bcb92072so44873957b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1779717456; x=1780322256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIiu1ri2o7Ro6bhV4J7LIEJCYOdJihANjgjmW46ndBY=;
 b=VyWwa/kmvRYntINVD3k92mcfzF709r74BBo/7cJy3Dpis6ybpoV1FLuaU7R9Vrqc+L
 Wc26WRcgc3OXWloggpfweikJy4k1kApXF0rKVL7LetZdmhBHGFP/VNWXU3j4pL7a0g2m
 IyTLFu3VQxwkTh1fHqqZCV+3HRSOMxYDO9b7YHxTPF+YjufKdA/gNjcMXnpSkWTLWcv7
 gPt+h9jUt05BuJO+qcL1f25vP3PjRwYh0babRQL/3SVsUF3mwIzU7lGPPC5cu46lXmGB
 Tylg9MMUs8ADdCi0AEt6m7f7OBSPdMikJ6VHdl2oSTJ2lbXtT9PWT0E5cDVcwU8mdSFT
 NAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717456; x=1780322256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gIiu1ri2o7Ro6bhV4J7LIEJCYOdJihANjgjmW46ndBY=;
 b=VwjK26yvqhkTbZwyV7X5pDLifSmijRhQtipWX8khZ+U/UOFnSf7ZZe+3IwYmOTzXQR
 jdqQBhg5Kt2CZHt2S9y07mEF29mppYMUgILWWTkT8jCEtEYFhgIjeYq6loI+olNEVzEf
 QRGQQ5QDYZXx8rUt8YeLhZu2jowv/DXYin+f32w6E/zTxnXFHdM4Y0s4HDzLbSaCAzlb
 CuxRa3BRaH3CXApyk+HxPiz49VYJZOtCjXV2S4Ut2ExCt04ylXn6Ghdq91zur2AZpACY
 CFATD05W7B+4/ibGdJbHDnY9hVIMopDJNtNkeN8J5KhxdAP3LFsRDjNzlsi/Osc5kRxI
 HuNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ95nSnhgrMHqXxLPtXIGFTsVQVmqmmv0Ph6cSF3Baoyv1ULTxO//qRlfOKyz1CL65fF8DZQ0f1PGIc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOQKYzKiQX1idKmohm2Qdpbhpi87mPDP+3EeiTl1imnvRBw+dy
 KNVg9NK9of9ueGO9fxSg+RFbXIwyahDqLeEwJiREw5JNYqr1mB8SJw7+o4XKLhncBYs=
X-Gm-Gg: Acq92OEe3trdh6ldUwKr538nHNHFbcnVHlTcWFLVtQzNP4Wh2WSrsJ8+rAUQ+ZJdxkB
 c4ELt9Aduj2h1Tx2xWYPEFOwRaj/HI7pcz1JlA+5b44dF7zK1HGdEf+mRcauJUFzEpgeO832nyO
 yVyApOtcdTZFXyBCwOCPaDRjnXesV7LR1r637GXAGDOQEgRf/GfdJ/kgzMTsEKBMcpp1tp+SSI6
 r1M1zBLV0oLIbMFMymmpdiAp3DIJ0vsbBujbDjqMCSYYGom9jzokRw5rChIqds0fYWkO7P+XIsD
 bhq6kBUsMESJ0W7He57yEmQfXXyXGAFlpbV5Kk+Rspjj9GfwUT6+J55nXu5f9zVxA4r97rjXBLz
 blq3gKHX1pYk3X/Ag2YVI/lqVqNwrDoUVdpP5BB6IPUPDoTjVFpBVS5OFGO78eQjxtfmLW/AYFV
 gelVUWyJSGd2XTHRayvln+gxtZBlvLhMki2Lpn4kofzXX0NS9NtiNSHeE=
X-Received: by 2002:a05:690c:6982:b0:7cf:e690:3e3c with SMTP id
 00721157ae682-7d338488bc8mr153718117b3.11.1779717456255; 
 Mon, 25 May 2026 06:57:36 -0700 (PDT)
Received: from localhost (191.99.245.35.bc.googleusercontent.com.
 [35.245.99.191]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d38be2dc9csm46036237b3.24.2026.05.25.06.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:57:35 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com
Cc: Sean Paul <seanpaul@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2.1 2/2] drm/i915/color: Fix Pre-CSC degamma LUT bounds
Date: Mon, 25 May 2026 09:56:05 -0400
Message-ID: <20260525135730.1122696-2-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260525135730.1122696-1-sean@poorly.run>
References: <20260525135730.1122696-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sean Paul <seanpaul@google.com>

Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut
for Segment 2 degamma programming, changing 'while (i++ > 130)' to
'while (i++ < 130)'. Also clamp Segment 2 to the last user-provided
LUT entry value instead of hardcoding it to 1.0 (1 << 24) to fix
a step discontinuity.

Link: https://lore.kernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.run/ #v1
Signed-off-by: Sean Paul <seanpaul@google.com>

Changes in v2:
- Split out into separate patches for pre/post csc fixes
- Dropped loop bounds fix in favor of [1]

[1]- https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel.com
---

Changes in v2.1:
- Rebased on Pranay's patch and sending without in-reply-to

 drivers/gpu/drm/i915/display/intel_color.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 7185f3628dcf..458508bcf1f4 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3968,6 +3968,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 	enum plane_id plane = to_intel_plane(state->plane)->id;
 	const struct drm_color_lut32 *pre_csc_lut = plane_state->hw.degamma_lut->data;
 	u32 i, lut_size;
+	u32 lut_val = 1 << 24;
 
 	if (icl_is_hdr_plane(display, plane)) {
 		lut_size = 128;
@@ -3978,7 +3979,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 
 		if (pre_csc_lut) {
 			for (i = 0; i < lut_size; i++) {
-				u32 lut_val = drm_color_lut32_extract(pre_csc_lut[i].green, 24);
+				lut_val = drm_color_lut32_extract(pre_csc_lut[i].green, 24);
 
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
@@ -3990,7 +3991,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 			do {
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
-						   (1 << 24));
+						   lut_val);
 			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
-- 
Sean Paul, Software Engineer, Google / Chromium OS

