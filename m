Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B68C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC4C10F8E6;
	Fri, 25 Sep 2026 07:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pH7Opx6b";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0E710E22B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:12:10 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so9020595e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790201528; x=1790806328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=14msH1DLW+vh/dJJ1llExxyOzbLsmiOUyZtaLlxkEYY=;
 b=pH7Opx6bRjVASpzqlEZgWEs3rwQHcAZbqyEjYLGAMSqIWfz7QsYlYDI3mwL0Nu+CpP
 lk9pxc5VLXaERYhgwkEVYwYkRwDOj5XXfZk6CCyNy/nFua/mHxN8D9w5rWiGI7a02M/9
 29eUJ/AAguy06p5Ysp1h9HUyUCdqHeuW+/CyB7JiFJa4BgHgZK8UnZWmE9DyHNkbsM/q
 qLmFLvPA6nDopMj4tqmbugd6wUbtszWl6SxcFSx+YK+jSbxVtlqDGVQfBe5QSj6WMn9H
 mZoONBLCszN0Iv0NH3dJ8Ohc9t1/xYzFZJqXIzERe7If8F6RvLTItoBGolL2khDH8RuT
 yIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790201528; x=1790806328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14msH1DLW+vh/dJJ1llExxyOzbLsmiOUyZtaLlxkEYY=;
 b=jPljJkXQVrHyoN79h9V2DTIS7O5oH4sdkBqcOaAKowGm50z2glWx7Cxsmm0rJk73mG
 10G/OIrlvJkX1MSnCzbMCsbrKqRh2PiYBLhFZkvGlSyGGoA+/SObcDUzBkdaIjUTe+gA
 UZYZAFVfyFwlCG92ypLVSmMronXqKOF43xErqcuI5NdJxlZzTUbPUZnJHJOIvTkCzhXs
 z307N8g1YKjwSZEHe6ATARHLTHuDODWk/WWsp1ae6ZLLGBNotCaD3F/Sju1+y7dfF/vu
 gVypGfetJf5/KpKDFRQy7Py7HMrHux4nbXTT3GqvrM2B9RWWDdG6GX7grcJcOU8HGYYQ
 2wyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+Q0zQB9C9FWwyXaCtNxAYWb4PqnqykHsIE8woPvLJybVLE/pF01411tfxoGCacdFsEIKE+/7Lws8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1YAkCFVoSJFsV086Rt26BsOmXQwS/9zXl5mI9YTU808xOXi7t
 mBvKurG4LwrxYHoB1IjzUvIHRIjNucy4uJ3M/QIgS2A+6asibIhUMCjv
X-Gm-Gg: AYBFou35MWc3Whq+AWvyis/Pa5mesZyqzpEIbvZl3rbW4e+HuIMfG679mzcCuy61VBR
 2N8U2qtk015QE2tHqyx7heXgbdYJJg5q6XcpSjMRRVRKMOq7TvyEBWHw0hlPz9dmt8jaAct/5Pq
 wmfOCgCd4TtRFqx/M9YCdVJ345/oSQv8gKt0xufPzZhnTgdssNGCojCHhocimhJ577xkHzvMA/B
 B+q8J+/DZM1gdG4U8BRQg88GmaJxwTthxaxyH+i3lZCuHyE/nA6MP1pC+zvAAhvdHdTyjFLoJH7
 Y+yEk2DP0SDhF2li5bu76GozuHpkNWtrKVCY4nJHd7SVgtQBNdvHoI83VpwykSr8td+z/8K32r4
 Opp40+6vZOnbR6pNybaZ/VbMwg/KwGiUE5c81nlWVUduHYk5yvHah9XTBZkpm8H2epe7MM6JUFX
 x6RywJdGFhvXqlntc/07gUKu8pYggVJBrrLfWT8SxQiCWD0mWkQDc8HECZGNnsmeINq2az7mZJ5
 Os5DRUcAZr7WBDYMcH1mAFMoazQkeTBUbMtDUnwrYyOlfScSakBQBP24pffs5QMFR9cIC1IUMRs
 I82RHkL2aXZvZV0sjll3eXsszaCz2UaiD5Bx86IlLypDuDQ=
X-Received: by 2002:a05:600c:a00d:b0:49f:ce73:7ab with SMTP id
 5b1f17b1804b1-49fe6708b23mr9674415e9.34.1790201528357; 
 Wed, 23 Sep 2026 15:12:08 -0700 (PDT)
Received: from tulkas.localdomain (95f12971.skybroadband.com. [149.241.41.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dff204sm24977495e9.14.2026.09.23.15.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:12:07 -0700 (PDT)
From: Conor Svensson <conor10@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: Conor Svensson <conor10@gmail.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/i915/dp: Ignore inconsistent TMDS limits on an Anker
 DP branch
Date: Wed, 23 Sep 2026 23:07:50 +0100
Message-ID: <20260923221018.42133-1-conor10@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Reconnecting an Anker 565 A8388 USB-C hub with a DisplayPort monitor
attached can leave the branch reporting a DVI downstream descriptor
with 25-165 MHz TMDS limits. On a ThinkPad L14 Gen 4 Intel with a Dell
S3422DWG, this removes the native 3440x1440 mode from the connector's
mode list even though the EDID still contains it. An explicit native
modeline works with the same hardware state.

Ignore the derived TMDS limits only for the captured branch identity,
firmware and downstream descriptor when EDID 1.4 identifies a digital
DisplayPort input. Retain the raw descriptor and other mode checks.
Do not restrict the match to a particular monitor or laptop model.

With otherwise matching upstream Linux 7.2.5 control/patched builds,
the control loses native modes after USB-C reconnect, while the patched
kernel selects 3440x1440 at 59.973 Hz automatically. Repeated reconnects,
both USB-C ports, suspend/resume, undocking while asleep and docked boot
pass. HDMI also works and does not activate the workaround. Periodic
picture cycling observed on the control stops with the patch.

The branch identity is not proven unique to this retail adapter. This
is an experimental workaround for review, not an explanation of why the
branch reports inconsistent capabilities. Other adapters and monitors
have not been tested.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180
Assisted-by: LLM
Signed-off-by: Conor Svensson <conor10@gmail.com>
---
RFC: is this best handled as a branch quirk here, or in the common DP
helpers? The captured identity and descriptor match is deliberately narrow;
there is no monitor/laptop model restriction. The informational log marker
is retained to show exactly when this experimental workaround executes.
The commit introducing the underlying problem has not been identified, so
there is no speculative Fixes tag.

Hardware A/B testing used upstream Linux 7.2.5 with otherwise identical
configurations. This RFC applies the same 48 added lines to drm-tip at the
base commit below. This drm-tip revision has not been boot-tested. The affected intel_dp.o
compiles successfully here with no compiler warnings; strict checkpatch
passes (human sign-off pending), and 426 predicate boundary cases pass
with ASan/UBSan. These predicate tests are not DRM integration tests.

Results: three USB-C reconnects, alternate USB-C port, docked s2idle
resume plus reconnect, undock while asleep/wake/reconnect, and docked
DisplayPort reboot all passed. HDMI also passed without activating the
workaround. The control lost native modes and showed periodic picture
cycling; that cycling stopped on the patched kernel. No custom modeline
was used in either test kernel. Other hardware and higher refresh rates
remain untested.

AI assistance: Codex (GPT-6) helped investigate the reported hotplug
failure, wrote the match/limit-clearing change, prepared the predicate
tests, collected diagnostics and drafted this message. The human reporter
performed the physical reconnect, suspend and reboot tests and confirmed
the visible results. The assistance arose from an extended troubleshooting
session, rather than a single code-generation prompt.

Evidence and detailed test results:
https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180#note_3677750

This is my first kernel patch submission. I'd appreciate feedback on
whether this belongs here or in the common DP helpers, and whether the
matching criteria are appropriate.

Thanks,
Conor

 drivers/gpu/drm/i915/display/intel_dp.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ffddf4b33..6d6767ca7 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6153,6 +6153,39 @@ intel_dp_get_edid(struct intel_dp *intel_dp)
 	return drm_edid_read_ddc(&connector->base, &intel_dp->aux.ddc);
 }
 
+static bool
+intel_dp_has_anker_tmds_mismatch(struct intel_dp *intel_dp,
+				 const struct drm_edid *drm_edid)
+{
+	static const struct drm_dp_dpcd_ident branch = {
+		.oui = { 0x90, 0xcc, 0x24 },
+		.device_id = { 'S', 'Y', 'N', 'A', 'b', 0x10 },
+		.hw_rev = 0x10,
+		.sw_major_rev = 0x06,
+		.sw_minor_rev = 0x05,
+	};
+	static const u8 downstream_ports[] = {
+		0x0a, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	};
+	const struct edid *edid = drm_edid_raw(drm_edid);
+
+	if (intel_dp_is_edp(intel_dp) || intel_dp->is_mst ||
+	    !drm_dp_is_branch(intel_dp->dpcd) || !edid)
+		return false;
+
+	/* HDMI and DVI inputs must retain their downstream limits. */
+	if (edid->version != 1 || edid->revision < 4 ||
+	    !(edid->input & DRM_EDID_INPUT_DIGITAL) ||
+	    (edid->input & DRM_EDID_DIGITAL_TYPE_MASK) != DRM_EDID_DIGITAL_TYPE_DP)
+		return false;
+
+	return !memcmp(&intel_dp->desc.ident, &branch, sizeof(branch)) &&
+		!memcmp(intel_dp->downstream_ports, downstream_ports,
+			sizeof(downstream_ports)) &&
+		intel_dp->dfp.min_tmds_clock == 25000 &&
+		intel_dp->dfp.max_tmds_clock == 165000;
+}
+
 static void
 intel_dp_update_dfp(struct intel_dp *intel_dp,
 		    const struct drm_edid *drm_edid)
@@ -6181,6 +6214,21 @@ intel_dp_update_dfp(struct intel_dp *intel_dp,
 		drm_dp_get_pcon_max_frl_bw(intel_dp->dpcd,
 					   intel_dp->downstream_ports);
 
+	/*
+	 * Experimental workaround for the branch observed in an Anker A8388.
+	 * USB-C hotplug can expose a DVI descriptor for the DP output. The
+	 * monitor's native timing works when requested explicitly, despite
+	 * the reported 165 MHz limit. Keep the captured identity and failure
+	 * signature checks narrow until the underlying cause is understood.
+	 */
+	if (intel_dp_has_anker_tmds_mismatch(intel_dp, drm_edid)) {
+		intel_dp->dfp.min_tmds_clock = 0;
+		intel_dp->dfp.max_tmds_clock = 0;
+		drm_info(display->drm,
+			 "[CONNECTOR:%d:%s] experimental Anker DP TMDS limit workaround\n",
+			 connector->base.base.id, connector->base.name);
+	}
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] DFP max bpc %d, max dotclock %d, TMDS clock %d-%d, PCON Max FRL BW %dGbps\n",
 		    connector->base.base.id, connector->base.name,

base-commit: 703cd271db3a35088460ab3fec0a96bd48e7fe04
-- 
2.55.0

