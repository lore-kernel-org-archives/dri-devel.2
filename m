Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EE8CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6D310F5D7;
	Fri, 22 May 2026 14:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="OsaLrwbN";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA5B10E53E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:40:24 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7bdec52f48dso59614177b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1779392424; x=1779997224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmIdxc0lOd0CxowYMAnyi/yzRzGd3DC7R3Y/lI6Dr6Y=;
 b=OsaLrwbNb+gapRHXe1AJ56dMeHVP8ygv5bSoUUo4tAiFozWo543BAzEBHcGMzh2NTl
 B6Nb1/fWCrBmau9rcDpmZFm68btR/T8eT5wSwKR369F5v4qwF/xyVc6rUuP8+exqo+XO
 G34p6Icl+ssTKk/hAt9JnqB9Zf42DgpkBMr/AoCrk1ybUqQUYsRm8MG/kriLeVyRFQZa
 NUGWMT4+d+BGDIFhZb3xdnCe7zWJUX59gPqvw9AWa2RO9Hi3beSucFpn3cAo9tKWurHa
 y6OTkRUWqNwnGkL0Xn3EdtDFj+3PHCFGipVKV/1NhW0GeLk+JuCd2p4ZMbEzwui6PCPj
 1CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779392424; x=1779997224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmIdxc0lOd0CxowYMAnyi/yzRzGd3DC7R3Y/lI6Dr6Y=;
 b=FtBEd3V6QbAHPlGfdKb23xG+2wsTVhmCwtfOBVWcNyl/JdGY8n5cFy704YsEyTQcdW
 m5VjxiPigDkxVRMw1Rfkda/jkfM8wHyy1E9tok8wtz8v/u6og/Aauwg5bTz33OIbrb00
 UkWhxXQZ4qCzFkm8qgEnnUV+IcMgyZ13F+FZCOXOZCkkfjPlGpK9Got//gDHsCBS/Dtz
 gnHB0oz2jjFEN1F3WO1ngTlce+R6mCnNHrBaB5/aNF8I4JUtT/2N/Ypy2FkHLQQzKRX2
 nz0r1HUPHPJg8/Dd0lWC6IVetXfSI+v5bS/Y0GPKMEDsoVVnl6hhshom/LVHO12sQW1X
 Q++Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TQ6YgxqyCAEn0w284NJhftfjF7jTtUOO+epaIYhC9WxIbk3BUXpwiG7CFAys617G+1SkRVLdU3hM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA+wGSWVQIOELFu4WegE6avOEsQwDXedKGVaCAFiQMWlk9CA2P
 mgZ0ZP7RnvkV4et7GV9bJkhoVpArISrhaMyHiR8Mf+7J+3U6f0pT7VTbv2wqRAKHib4=
X-Gm-Gg: Acq92OFIjseCczRTdVwNbFFvo+NiTUPYeIlTLG+5s0c7Iiv/MQAsn0fvQ3D0H+V5Wma
 0K7crq1ARhGsOcERMT/4GmHn/s6dp3c+RcVRR6YsgPFOWlnynGjdWP0iAL++pPqY+Djckk927az
 TLgCvzNdif7zAec2yjkJtkPz7DaN7kZ3bzK6Qej75J+G+fvqNNIV1L8ph2GszmrU6+l/Sc8C2aI
 rfpYCRjYuSka/TVd/d9FqAtRVqKSPicTBArU2GiHLCH0jJKTwmzEdWvYCcz2VR7fMmT7GPyL1K4
 OLHCN3IpfH5qu4m5sKp7WquXdeVDm+F+3luslRuaNHe4VF8vhBT55HOWr3WxJonP1BGLbXsu+i9
 0tG3vp9qu0V8J52Qccvc67ajIstzKfMLtrACtrckSLCzYYRtJ5LatItfHUpKNKnZFzA7AnY26EC
 6o/IesZShDLgblNWJBUOPAoCf27vtaJPeMNaaRFZFasao2iCYHzCqckUA=
X-Received: by 2002:a05:690c:7446:b0:7b6:783f:2122 with SMTP id
 00721157ae682-7d356236f08mr2231767b3.9.1779392423699; 
 Thu, 21 May 2026 12:40:23 -0700 (PDT)
Received: from localhost (182.221.85.34.bc.googleusercontent.com.
 [34.85.221.182]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d35f7d8684sm323507b3.25.2026.05.21.12.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:40:23 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, Sean Paul <seanpaul@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/i915/color: Fix Pre-CSC degamma LUT bounds
Date: Thu, 21 May 2026 15:39:45 -0400
Message-ID: <20260521194018.2445206-2-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260521194018.2445206-1-sean@poorly.run>
References: <6d8e36e2aea806f9973b3c501aad4523f7316d6a@intel.com>
 <20260521194018.2445206-1-sean@poorly.run>
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
 drivers/gpu/drm/i915/display/intel_color.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 90d5dc2ef3e4..469011c83f9b 100644
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
@@ -3975,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 			do {
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
-						   (1 << 24));
+						   lut_val);
 			} while (i++ > 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
-- 
Sean Paul, Software Engineer, Google / Chromium OS

