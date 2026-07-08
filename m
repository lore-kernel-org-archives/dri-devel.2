Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1512EC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFD910F260;
	Wed,  8 Jul 2026 19:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WRT2Bnpc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7430910F265;
 Wed,  8 Jul 2026 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rZRUp0WSbipr+dsFrfFGkqzwHeopNNaJ9Iamc/7LTJs=; b=WRT2BnpcVPJYIopXU+VbXc+QbE
 bag4E3CNtiuqaZh2tIT371t3VuWrAG2IUyspp7J6Q+t+a54Xhag2gA4SLGhMOagBRoZ7RTmj+BnLk
 N3khmrHeYIOtAJBFm66puhnG6Thyo6nOLvAmn2NTe68c4eVuWi8UpRo1GLi9YLMg5PhZBKeohup2v
 PWSJijU02JWHmAc2CbQh9DjSwpd/I8CjSB/tWpSs7F76aclCfXLP+qEwpRp1v/eN26IdGDDCD1N/y
 Ji32qfL6Pdt3EsODYSQWYJxcQJGtHCBtoZd/V4yPNWY43I2Sgd391aeZX0mjNrkkI7qlTBsqpMel1
 dYuLbESg==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBP-00BtrH-BB; Wed, 08 Jul 2026 21:43:47 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 00/19] drm/drm_colorop: add post-blend colorop support to
 AMD display driver
Date: Wed,  8 Jul 2026 21:37:15 +0200
Message-ID: <20260708194343.2578387-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hey,

I have been working on gamescope migration from AMD driver-specific
color props to KMS colorop API [1] and, with the fixed-matrix
replacement for COLOR_ENCODING and COLOR_RANGE[2], the only missing
color prop was the CRTC AMD REGAMMA TF (the 1D Curve). I worked on top
of Ariel&Nícolas proposal for post-blend colorop API [3], discarding
patches for DRM_CAP_CRTC_COLOR_PIPELINE driver cap flag, as commented in
this year Linux Display Hackfest, and exposed AMD post-blend colorop
pipeline with CTM -> 1D Curve -> 1D LUT, since post-blend Degamma is not
actually supported by AMD (even though there is a workaround for enable
it in CRTC color mgmt properties).

I've not worked on the gamescope part yet, but decided to share it
upstream to check if it makes sense and I'm in the right path. This
series doesn't take into account the inactive color pipeline work I've
been doing for plane color pipeline. The plan is to apply a similar
approach post-blend when we agree that the plane series is correct.

- Patch 1-12 are Ariel&Nicolas work for DRM post-blend colorop support
- Patch 13 completes deprecation of CRTC color mgmt properties if
  post-blend color pipeline is enabled by hiding them;
- Patch 14 applies the same bug fix logic as Robert did to guard plane
  client cap[4];
- Patch 15-19 add support to post-blend colorop API on AMD driver based
  on plane colorop work.

Just adding `DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE` to `drm_info`, I got
this CRTC color pipeline structure on Steam Deck with this series:

├───CRTC 0
│   ├───Object ID: 399
│   ├───Legacy info
│   │   ├───Mode: 800×1280@90.00 preferred driver phsync pvsync 
│   │   └───Gamma size: 256
│   └───Properties
│       ├───"ACTIVE" (atomic): range [0, 1] = 1
│       ├───"MODE_ID" (atomic): blob = 512
│       │   └───800×1280@90.00 preferred driver phsync pvsync 
│       ├───"OUT_FENCE_PTR" (atomic): range [0, UINT64_MAX] = 0
│       ├───"VRR_ENABLED": range [0, 1] = 0
│       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 400} = Bypass
│           ├───Bypass
│           └───Color Pipeline 400
│               ├───Color Operation 400
│               │   └───Properties
│               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
│               │       ├───"BYPASS" (atomic): range [0, 1] = 1
│               │       ├───"NEXT" (atomic, immutable): object colorop = 405
│               │       └───"DATA" (atomic): blob = 0
│               ├───Color Operation 405
│               │   └───Properties
│               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
│               │       ├───"BYPASS" (atomic): range [0, 1] = 1
│               │       ├───"NEXT" (atomic, immutable): object colorop = 410
│               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse, Gamma 2.4 Inverse, Gamma 2.6 Inverse} = sRGB Inverse EOTF
│               └───Color Operation 410
│                   └───Properties
│                       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
│                       ├───"BYPASS" (atomic): range [0, 1] = 1
│                       ├───"NEXT" (atomic, immutable): object colorop = 0
│                       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
│                       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
│                       └───"DATA" (atomic): blob = 0

Testing still pending.

FWIW, here is the `drm_info` diff:

diff --git a/drm_info.h b/drm_info.h
index e61fda7..f7f2017 100644
--- a/drm_info.h
+++ b/drm_info.h
@@ -21,5 +21,6 @@ enum {
 /* Remove after updating libdrm */
 #define DRM_MODE_OBJECT_COLOROP 0xfafafafa
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE    7
+#define DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE     8
 
 #endif
diff --git a/json.c b/json.c
index c9f8c72..b2c306b 100644
--- a/json.c
+++ b/json.c
@@ -29,6 +29,7 @@ static const struct {
        { "WRITEBACK_CONNECTORS", DRM_CLIENT_CAP_WRITEBACK_CONNECTORS },
        { "CURSOR_PLANE_HOTSPOT", DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT },
        { "PLANE_COLOR_PIPELINE", DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE },
+       { "CRTC_COLOR_PIPELINE", DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE },
 };


[1] https://github.com/ValveSoftware/gamescope/pull/2113
[2] https://lore.kernel.org/dri-devel/20260623164812.81110-2-harry.wentland@amd.com/
[3] https://lore.kernel.org/dri-devel/20251223-mtk-post-blend-color-pipeline-v3-0-7d969f9a37a0@collabora.com/
[4] https://lore.kernel.org/dri-devel/20260703073230.19982-1-robert.mader@collabora.com/

Let me know your thoughts!

Melissa

Ariel D'Alessandro (2):
  drm: Add helper to extract a 3x4 matrix from any CTM matrix dimensions
  drm: Add helper to extract a LUT entry from either 16-bit or 32-bit
    LUT

Melissa Wen (7):
  drm/drm_mode_object: hide deprecated CRTC color mgmt props if colorop
    is set
  drm/drm_ioctl: guard DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
  drm/amd/display: add support to post-blend CTM colorop
  drm/amd/display: add support to post-blend 1D-Curve colorop
  drm/amd/display: add support to post-blend 1D-LUT colorop
  drm/amd/display: move CRTC CTM color mgmt prop to check helper
  drm/amd/display: enable post-blend colorop properties

Nícolas F. R. A. Prado (10):
  drm/crtc: Add color pipeline to CRTC state
  drm/colorop: Allow parenting colorop to CRTC
  drm: Factor out common color_pipeline property initialization code
  drm/crtc: Add COLOR_PIPELINE property
  drm: Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
  drm/atomic: Pass crtc_color_pipeline client cap to atomic check
  drm/atomic: Print the color pipeline as part of the CRTC state print
  drm/colorop: Factor out common paths from colorops helpers
  drm/colorop: Introduce colorop helpers for crtc
  drm/crtc: Track crtc color pipeline client cap in drm_crtc_state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 250 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  76 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  42 +++
 drivers/gpu/drm/drm_atomic.c                  |   9 +-
 drivers/gpu/drm/drm_atomic_uapi.c             |  72 ++++-
 drivers/gpu/drm/drm_colorop.c                 | 282 ++++++++++++++----
 drivers/gpu/drm/drm_connector.c               |   1 +
 drivers/gpu/drm/drm_crtc.c                    |  31 ++
 drivers/gpu/drm/drm_crtc_internal.h           |   1 +
 drivers/gpu/drm/drm_ioctl.c                   |  20 ++
 drivers/gpu/drm/drm_mode_object.c             |  18 ++
 drivers/gpu/drm/drm_plane.c                   |  34 +--
 drivers/gpu/drm/drm_property.c                |  44 +++
 include/drm/drm_atomic.h                      |  20 ++
 include/drm/drm_atomic_uapi.h                 |   2 +
 include/drm/drm_color_mgmt.h                  |  61 ++++
 include/drm/drm_colorop.h                     |  32 +-
 include/drm/drm_crtc.h                        |  27 ++
 include/drm/drm_file.h                        |   7 +
 include/drm/drm_property.h                    |   5 +
 include/uapi/drm/drm.h                        |  19 ++
 23 files changed, 920 insertions(+), 138 deletions(-)

-- 
2.53.0

