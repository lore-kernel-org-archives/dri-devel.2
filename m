Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF653C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8149710F400;
	Thu,  3 Sep 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="CjkTfUyH";
	dkim-atps=neutral
X-Greylist: delayed 35948 seconds by postgrey-1.36 at gabe;
 Wed, 02 Sep 2026 22:31:12 UTC
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D6610E532
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788388269; x=1788647469;
 bh=eTuXow2RDpv5lP3+8l+Zj7LsJOisvJ24M6HDGUFAuqU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CjkTfUyH2TOXBqe36p/R8NHvZmmty34pxSIVSB+4tFPnSxmG6o0F3J6WpnWFIQWUB
 vqXpcITquxoeNrUqHZQfJVuInkdOVjotz2LN7zGFV7UCqkgPWUY1rr2W1QQz3mRHXh
 m6ctLowQIRWhJoCXDY5S7Jt1NKU2FAXhErEuvpjzPNJq0/sHwEVCmBPCGhks56kUuM
 0PZsUdkkDOCsx/GbmMw3Z8sN5zJXsjSwVLZPPrkL8Ri2L70BC7zVHAuXpZPsbhyYoN
 ji5/yF33DgCaTwNckFlT98K5rlvRciPFQJFyVIaanytrMH6GmrM6uGAIvuPgp8wtRw
 H+F+/k8svBrDg==
Date: Wed, 02 Sep 2026 22:31:03 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com
Subject: [PATCH v2 0/4] drm/amd/display: fix brightness ownership through
 power module
Message-ID: <cover.1788388049.git.arc@empyreal.works>
In-Reply-To: <20260902-brightness-cover-abf809f2@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 16ac18dfe530b3eb205388d0b49a1f373a909ae2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Linux passes PWM eDP brightness through two owners. The display manager
maps the request into the firmware range and applies the ATIF custom
curve. The power module then derives a percentage from that hardware
value and applies the same curve and range again. A non-zero firmware
minimum consequently prevents zero from reaching the panel minimum.
The split also leaves the custom-curve disable policy and final source
brightness mask attached to the wrong owner.

Patch 1 keeps pre-power-module custom-curve output in the userspace
domain, which also fixes affected stable kernels. Patch 2 covers that
conversion with a non-zero firmware minimum. Patch 3 passes zero-anchored
millipercent into the power module and keeps AUX millinits unmasked until
the final AMD AUX or effective PWM handoff. Patch 4 covers ordinary PWM,
forced PWM, AMD-AUX fallback, true AUX, live and replay callbacks,
multiple panels, endpoints, interior values, clamping, and invalid
ranges.

GPT-5.6 Sol Fast assisted with issue investigation, source and history
analysis, patch and test development, review-response analysis,
submission preparation, and consolidation of the working context. A
separate tool-enabled Claude Opus 5 review audited the complete final
diff with direct access to the source tree, build environment, KUnit
harness, logs, and relevant hardware records. Objective verification
included strict checkpatch, a clean UML KUnit build and execution of the
configured DRM test set, an exhaustive C reproduction of every EDID
luminance-byte combination, and source tracing through the DRM commit
worker and hardware callbacks.

The human contributor reviewed the final behavior and evidence, directly
performed and observed the physical hardware QA, and explicitly approved
the exact tested series for submission. The quirked OLED path, VESA AUX
panel, pre-DCN3.1 hardware, and hardware mode-change replay on a quirked
panel remain untested physically because no matching panel is available.

Changes in v2:

- rebase onto current Linux master 89a312991dc6;
- retain mathematical AUX millinits until the hardware handoff;
- apply the panel mask immediately before live and replay AMD AUX writes,
  or after PWM derivation when the effective handoff is PWM;
- add a composition regression whose input distinguishes intermediate
  masking from final-only masking;
- capture and verify the live AMD AUX, VESA AUX, and mode-change callback
  values;
- credit the Sashiko finding and add the documented LLM assistance
  trailer.

Sashiko also reported two pre-existing potential issues. Both were
checked without changing this series. The DRM nonblocking commit tail
runs from system_dfl_wq in sleepable process context, so taking dc_lock
there is valid. The EDID parser and AMD fallback were exhausted across
all 65,536 max_fall/min_cll byte combinations: consumed AUX ranges were
always min 1 and max 50 through 12544, with no equal or inverted range.

The final candidate passed all 2,036 configured UML KUnit tests,
including 88 AMD backlight cases. Each patch passes strict checkpatch
with zero errors, warnings, or checks, excluding only commit lookup
diagnostics caused by the shallow source checkout. The production AMD
display objects also compile with KUnit disabled and W=3D1.

The v2 physical PWM sweep on a Strix Halo panel captured both hardware
endpoints and restoration:

  requested 655   -> actual 0
  requested 65535 -> actual 65535
  restored requested 20119 -> actual 11597

The operator reported normal panel behavior through the sweep. No kernel
fault followed. This panel has brightness_mask =3D=3D 0, so it validates th=
e
shared path but not the quirked OLED hardware path. The existing
LUT-unaware hardware readback inverse remains unchanged.

Andrei Rusu de Castro (4):
  drm/amd/display: keep custom brightness curve in userspace domain
  drm/amd/display: test custom brightness with non-zero minimum
  drm/amd/display: pass userspace brightness to power module
  drm/amd/display: test power module brightness input domain

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  57 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   3 +-
 .../tests/amdgpu_dm_backlight_test.c          | 622 +++++++++++++++++-
 .../drm/amd/display/modules/inc/mod_power.h   |   1 +
 .../gpu/drm/amd/display/modules/power/power.c |   2 +
 .../drm/amd/display/modules/power/power_abm.c |  55 +-
 .../amd/display/modules/power/power_helpers.h |  14 +
 10 files changed, 721 insertions(+), 46 deletions(-)


base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
--=20
2.54.0


