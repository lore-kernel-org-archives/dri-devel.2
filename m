Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1811BCD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DA810E27D;
	Fri, 22 May 2026 14:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="OK6KrhN4";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374E610F3D4
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 18:01:47 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7bd4c61765dso62353607b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1779386506; x=1779991306; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0j0TPpzgwk8K8QWPmCr8MZO43/oD20R506hhkUYcHEM=;
 b=OK6KrhN4Z0FUSpUTSVvrgxIoDf7qt/vSis4pzlEbXvXB4MJ7tOLAbFTmlbivEgt7kM
 Mz3ksPFnySsKojD2JwKrppvlSu7NXYWSDFJU1ueR+QbzBXpmVm4zoUCyfek3u0CP1+9s
 mYbaYZUAegkVjCzsXyDiUTHu2pMOyURscgLYYH1VIAm2zc1Yu7C3dHyl/ABT3zwYdsgI
 It0Ev3uaYA7YqbXseuytqianpRFnMKZfB3XWO48CaoaJk96rTYwgdPbrMPXbzMuF+sdH
 SkI1Ew2sRPBqo7z7UrNeZmOv6mTezfLEYhMYIMEUDvVLtKiiUYIAqb1X3X8T+OkqXHY8
 3u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386506; x=1779991306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0j0TPpzgwk8K8QWPmCr8MZO43/oD20R506hhkUYcHEM=;
 b=Btrt7il82NntoF+XNqAd6noAigC9cUQBwX+VPQVYknA+a3B5r3dSbfiFIU2PVWTQub
 MhupQNyAmtcyg/polf+CbtYeb1sCEj5mL1/OCdverwNQz3iNI0jwlnCWxmcxGCg1AyQ8
 zIA2MZ72h5DhsgG1ar2X8INeWVRI7gq9jhB/6tI98SmTxJr1gzVCYxqzcVgI1kzeoikb
 C141GkigaVJ/ajj/wsPBWpdOW0KBMtSVGbmFAWgvGC+QdFjd9F9brpexQ8QbwbTfWELd
 lufG8/ZGwaPagLtIjjZ//lnwbTXaNCSizyWhaWJm2RZcl1Hwf+Cgawx3DnjJ6U1VW5Nm
 3KZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9mNVKAC3RdGMCJVHSTDeGZqWxx5EQ0l1xRgIiPagueUZCdIVS/OCbhQZm0fpzSCoiv/qMgDo5tmk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFX+MWpb2y700eX3xtd5QFdFXq4qVOvhOA6UkfhM0r9cx0d/rN
 KR4oSj8DmMsB2ykXOzhtKZfceVlABIUCAzFNzr0EOl1A8iQpYXUasioKlzzdnTj9+Rc=
X-Gm-Gg: Acq92OFwti3+99PqDT1Fx1550gMQwNto91pBe7m8AykNIZsyeZ+5R5L76u8kzPT/t8M
 EQjAy9GWU/9q4PsqRpXcDV2UsZJAKW1XtAO22ozXm0/4PizHTqjpRu2b1cd5jqwU5p1IiYpWpYb
 vXldI0zq3CUuadc0oCuEFUuZiQs2J3rgpehUNoyWwfcJ4+AgwvDHE4uWjRtLzbMpqS0Qb9A07tK
 8MtqQFI4P5XwJCoHuFetmmRSCjXlSInGXaurALTerIO0/GUcbsLcgUxGBATEceq//PzfrCMxom/
 VjlorBpqMcdBhoF2BHzQW5pEFKPtyqOrRTW2mUEZGQe8yFG6fKexWPhwFpF1Zd4KsCrYxEAWd/A
 b/NN/z8NJBdeoZp8N2D+NHeQhMgHBCOZRDqyEvPMuWLWRw0iVPBGFBGJPf2/3XsBjkgPoOzOtIF
 dxTT4PJNJO4QxL/OkBcWXy/3W5Vk2gBRGM/xiPyGt3ECpWPC4QJ2IMH01sColBxIVKKg==
X-Received: by 2002:a05:690c:22c2:b0:7b9:edca:bac6 with SMTP id
 00721157ae682-7d3342da421mr5592967b3.15.1779386505668; 
 Thu, 21 May 2026 11:01:45 -0700 (PDT)
Received: from localhost (182.221.85.34.bc.googleusercontent.com.
 [34.85.221.182]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d2ca76a7b1sm5987237b3.23.2026.05.21.11.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:01:45 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org
Cc: Sean Paul <seanpaul@google.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/color: Fix plane color pipeline programming bugs
Date: Thu, 21 May 2026 14:00:45 -0400
Message-ID: <20260521180143.2143262-1-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

Fix two bugs in the plane-level color pipeline programming:
1. Fix a step discontinuity in the Post-CSC Gamma LUT when SDR dimming
   is active by clamping Segment 2 to the last user-provided LUT entry
   value instead of hardcoding it to 1.0 (1 << 24).
2. Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut
   for Segment 2 degamma programming, changing 'while (i++ > 130)' to
   'while (i++ < 130)'. Also clamp Segment 2 to the last user-provided
   LUT entry value instead of hardcoding it to 1.0 (1 << 24) to fix
   a step discontinuity similar to the Post-CSC fix.

Signed-off-by: Sean Paul <seanpaul@google.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 2d318e922671..9b807b024ec3 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3953,6 +3953,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 	enum plane_id plane = to_intel_plane(state->plane)->id;
 	const struct drm_color_lut32 *pre_csc_lut = plane_state->hw.degamma_lut->data;
 	u32 i, lut_size;
+	u32 lut_val = 1 << 24;
 
 	if (icl_is_hdr_plane(display, plane)) {
 		lut_size = 128;
@@ -3963,7 +3964,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 
 		if (pre_csc_lut) {
 			for (i = 0; i < lut_size; i++) {
-				u32 lut_val = drm_color_lut32_extract(pre_csc_lut[i].green, 24);
+				lut_val = drm_color_lut32_extract(pre_csc_lut[i].green, 24);
 
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
@@ -3975,8 +3976,8 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 			do {
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
-						   (1 << 24));
-			} while (i++ > 130);
+						   lut_val);
+			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
 				u32 v = (i * ((1 << 24) - 1)) / (lut_size - 1);
@@ -4023,11 +4024,11 @@ xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 						   lut_val);
 			}
 
-			/* Segment 2 */
+			/* Segment 2 - clamp to the last LUT value to prevent step discontinuity */
 			do {
 				intel_de_write_dsb(display, dsb,
 						   PLANE_POST_CSC_GAMC_DATA_ENH(pipe, plane, 0),
-						   (1 << 24));
+						   lut_val);
 			} while (i++ < 34);
 		} else {
 			/*TODO: Add for segment 0 */
-- 
Sean Paul, Software Engineer, Google / Chromium OS

