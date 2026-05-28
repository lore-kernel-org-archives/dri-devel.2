Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DFDCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 23:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C8110F6D4;
	Thu, 28 May 2026 23:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="H7DeJtmS";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CA710F6D6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:08:23 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7dbfebfbf50so22216847b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1780009702; x=1780614502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN66wXnuf6IgvNfIu/oqHRce6wGXmhGXpBXVMToPfVY=;
 b=H7DeJtmSdgjYcYGFEG4W0E/2jM5nWRCtItczFDddM2uSl5RyQPAJSaAREkkIjpGHFy
 /jyK/kKfzZ6ysvdLIcRuZ52svHrs3e6Tbz6LoT+FBu91uQ7S2UZ2okK85tGxTUC7bYnh
 bYQOpo/o+RriTaPLBJj8Hh8iQWGa1KAs/zmUOvl5Yj2sH1VECJK5wxKzqvKfIRQl1U55
 7VEDqd/zfPVttdojnkdCB4O2itOGnzywI5wygh+lDdoceWSU9Zsk9dA+d6FwQJulTZ7z
 neUsTcZGGp2PK9fW+V6verbLXRqqnwmRgGeRlcZyeyyyXd97sRYlRcjVQU++E/ER8t8C
 xvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780009702; x=1780614502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sN66wXnuf6IgvNfIu/oqHRce6wGXmhGXpBXVMToPfVY=;
 b=sM/0KQAJqjz54ItJddG4oeBO+1GiWNJ/Vj//3CPpED2HVPmYf+aM7Fn1UHn8wszR12
 7od3Z+2dk5TLfDDmyXoEWKzf2uZ4aZg9DahQFax4xQht2N/R7bEt0+Z9nhWx21YBdEa5
 a7IKE9owYGQN49GOx8tw2o5nE1i1kUJAIFW+Dz9MHam5p8AcGfT727Rzj6KvIY7l8D6L
 IPuR3fh+yd7JzUEIr60zyIoDEmgBttGCMt8enIkMJwmC/TBvJBUcQRmuzu4lZNSq+zie
 MxqEyU8i1SaiIymB2jG3TCSAfUHvZ8YqsZd0ePr2GQ64gL4bS4qW7lDPWfQENUKOyx2v
 98Qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N9YPJYW0UsFBLvquaDoU8B58gt6FK4QIZtl5AXS1OI8ahjcv0XY+uiEkb5kWu0H0wnQb5hbKvFPI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxSrEiYyXBeard57uc2d/ewCjPv4cG8kyLKqLMl7qzi2lGQGkY
 usdswA8TyJ+BN3BJkQTD1u0HdZ3MnGmxWiEbtYo3K6IyGiBtyZIkPXwKqNT9VOA6W2c=
X-Gm-Gg: Acq92OGp5jnF/0o9AXHmbKVvWD5VS1UQofcCShJ69lMEdtopmDdJAp76xhPxxwmCxI/
 FmKSqZwKi02Ik1AszEYqCM2QA15jwTUdQV0vEC8j9TcizrceQnsLB9tlZq0qvIPQGTi9yo+GPPW
 pNIoxTcwpvDuuaZYz+/klrIqvLxfCjRQBXKUWQThhppRO983vhbwazAzY3RxxWKuUFu1F4oO02C
 9gzSdA9WoW3x/0dgsrwok7HzEXais2AdX2wdacdsxP/ujSo+k+Cn9M2kpO7WapdhgoZnrP5Giq4
 xhJOq9TEaka2ZFoPVsyE+/8WI4vH1sJJDs057UygBWv+pvGYo5eyRB+3L3I/9ajHztPuLn5tLDk
 XeISzkJPv6J9RWu+IgLffqzPrxp6wSWH0te91T3nv61cgIRC3i00xiCUAgFWOc6bNAsFycQcNwm
 RBt4SDXRIITTt6YKDksbKFpSW5N147r1iFqANYZwwxExsCKQ1/1NyfvIXkQYzQ3Eaw1VixS9iXR
 BI/
X-Received: by 2002:a05:690c:6288:b0:7dc:7b3:6326 with SMTP id
 00721157ae682-7de4bd19fc1mr2454467b3.33.1780009702204; 
 Thu, 28 May 2026 16:08:22 -0700 (PDT)
Received: from localhost (182.221.85.34.bc.googleusercontent.com.
 [34.85.221.182]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7de6757e963sm167097b3.1.2026.05.28.16.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 16:08:21 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 chaitanya.kumar.borah@intel.com
Cc: Sean Paul <seanpaul@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/i915/color: Fix step discontinuity in Pre-CSC
 Gamma LUT
Date: Thu, 28 May 2026 19:07:47 -0400
Message-ID: <20260528230817.2455072-2-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <20260528230817.2455072-1-sean@poorly.run>
References: <20260528230817.2455072-1-sean@poorly.run>
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

Clamp Segment 2 to the last user-provided LUT entry value instead of
hardcoding it to 1.0 (1 << 24) to fix a step discontinuity.

Signed-off-by: Sean Paul <seanpaul@google.com>
Link: https://lore.kernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.run/ #v1
Link: https://lore.kernel.org/intel-gfx/20260525135730.1122696-2-sean@poorly.run/ #v2

Changes in v2:
- Split out into separate patches for pre/post csc fixes
- Dropped loop bounds fix in favor of [1]
Changes in v3:
- Fix stale commit message

[1]- https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel.com
---
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

