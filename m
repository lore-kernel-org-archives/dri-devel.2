Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15D606A6A7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GOOmeWEJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F73F10F04E;
	Tue, 24 Nov 2026 18:18:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224B110F042;
 Tue, 24 Nov 2026 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=5GuBlIdA41QA+IrSIBPOUnKYTRIZlR3rT10Wt+oZhVY=; t=1795544290; x=2110904290; 
 b=GOOmeWEJMDu3qhNXKKakVsQkQGk9krU3FeqBbpOQe2oMUuJPWju1VKRinCWey96l9mUlHISJAqB
 DSBu1PzlLTgW8VZcgR7EhALPH+kyEQBKYTAKsutdMcD9tl/7ZThh1yJ1Hs8DAuEdCGaJJAkfpJ8kt
 /fAV+/3AGk+FqkOT2yJ0t61ai9dgv6URinAqG8Dld3I4VKYm6V9c1mPeFPamVWipZcb7F06AA9tKW
 VkDkvLz0m+5pNhE/OjEHUdRr981Vn5q25YWb91tEzlnGnNq8VqVpVHyNHbZ0zipPcd89R39RTPVqB
 +GyFVaySdlXTXAY2Oqv+EjvGufqejJ6461Rw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5U-00000003axM-2TXd; Tue, 24 Nov 2026 19:17:52 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 00/19] drm/drm_colorop: add post-blend colorop support to
 AMD display driver
Date: Tue, 24 Nov 2026 19:03:17 +0100
Message-ID: <20261124181652.1333986-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an updated version of previous RFC series which adds post-blend
colorop support to AMD display driver [RFC v2].

As I mentioned in the previous version, I worked on a proposal to
migrate Gamescope, shifting from AMD driver-specific color properties to
the KMS colorop API [1], and the `AMD CRTC REGAMMA TF` is the only
driver-specific color property still missing upstream. I then
implemented this 1D post-blend curve — which had been missing from the
upstream kernel — based on Ariel&Nicolas’s proposal for post-blend
colorop support [2]. Matthew is now continuing and extending this work
on Gamescope.

Besides that, Robert is also using this support to offload the pre- and
post-blend color pipeline in Weston:
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157

This series doesn't depend on the inactive plane color pipeline series
[3], but I already applied some of the plane rules:

1. AMD uses the committed state of colorops that aren't in the commit
   (as in "allow individual colorop changes").
2. "drm/atomic: duplicate CRTC colorop states" duplicates CRTC
   colorops for suspend/resume. If [3] lands first, the plane and CRTC
   duplication loops can be merged into one.

The rule that only colorops of an active (or (de)activating) pipeline
can be changed is not applied to CRTC colorops yet. I plan to extend it
once the plane approach in [3] is agreed.

Also, [3] adds a core check rejecting an enabled colorop without a DATA
blob. Until then, AMD checks it for the post-blend CTM itself.

[RFC v2] https://lore.kernel.org/dri-devel/20260716160556.227556-1-mwen@igalia.com/
Changes:
- Rebase on drm-misc-next.
- New patches:
  - drm/atomic: handle CRTC colorops in drm_atomic_commit_set_colorop_state():
    adapt the lock assert added by 259907fef771 to CRTC colorops.
  - drm/atomic: duplicate CRTC colorop states: keep CRTC colorop values
    across suspend/resume.
  - drm/atomic: track individual CRTC colorop updates: set
    color_mgmt_changed when COLOR_PIPELINE changes, as done for planes.
  - drm/atomic: set hidden CRTC color mgmt model to default values.
- Dropped:
  - "drm/crtc: Track crtc color pipeline client cap in drm_crtc_state"
    and "drm/atomic: Pass crtc_color_pipeline client cap to atomic
    check": Drivers now choose between colorop and the CRTC color properties
    from crtc_state->color_pipeline, as for planes.
  - Dropped the CTM 3x4 and LUT32 extraction helpers: no users in this
    series.
- AMD:
  - enable post-blend colorop properties since the beginning of the
    post-blend colorop support to avoid unused function.
  - set colorop funcs on CRTC colorops (fixes a NULL dereference on destroy);
  - based on [3], use the committed state of colorops that aren't in the
    commit, check colorop types, program bypass explicitly, reject an
    enabled CTM colorop without DATA blob;
  - reset the CRTC degamma flags when in colorop mode;
  - move "move CRTC CTM color mgmt prop to check helper" before the
    post-blend colorop enablement.

You can check the implementation for Gamescope [1], which fully migrates
its color pipeline—shifting from AMD-specific color properties to
planes/CRTC colorops; on the kernel side, this just needs a
drm-misc-next kernel with this series applied.

[1] https://github.com/ValveSoftware/gamescope/pull/2113/commits
[2] https://lore.kernel.org/dri-devel/20251223-mtk-post-blend-color-pipeline-v3-0-7d969f9a37a0@collabora.com/
[3] https://lore.kernel.org/dri-devel/20261111160814.21326-1-mwen@igalia.com/

===  

This is one example of `drm_info` output on Steam Deck with
SteamOS/gamescope implementation and this kernel work:

├───CRTCs
│   ├───CRTC 0
│   │   ├───Object ID: 399
[...]
│   │       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 400} = Color Pipeline 400
│   │           ├───Bypass
│   │           └───Color Pipeline 400
│   │               ├───Color Operation 400
│   │               │   └───Properties
│   │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
│   │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
│   │               │       ├───"NEXT" (atomic, immutable): object colorop = 405
│   │               │       └───"DATA" (atomic): blob = 0
│   │               ├───Color Operation 405
│   │               │   └───Properties
│   │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
│   │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
│   │               │       ├───"NEXT" (atomic, immutable): object colorop = 410
│   │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse, Gamma 2.4 Inverse, Gamma 2.6 Inverse} = PQ 125 Inverse EOTF
│   │               └───Color Operation 410
│   │                   └───Properties
│   │                       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
│   │                       ├───"BYPASS" (atomic): range [0, 1] = 1
│   │                       ├───"NEXT" (atomic, immutable): object colorop = 0
│   │                       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
│   │                       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
│   │                       └───"DATA" (atomic): blob = 0

[...]

    ├───Plane 3
    │   ├───Object ID: 218
[...]
    │   └───Properties
    │       ├───"type" (immutable): enum {Overlay, Primary, Cursor} = Primary
    │       ├───"FB_ID" (atomic): object framebuffer = 513
    │       │   ├───Object ID: 513
[...]
    │       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 224} = Color Pipeline 224
    │           ├───Bypass
    │           └───Color Pipeline 224
    │               ├───Color Operation 224
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 229
    │               │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB
    │               ├───Color Operation 229
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 234
    │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2, Gamma 2.4, Gamma 2.6} = sRGB EOTF
    │               ├───Color Operation 234
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Multiplier
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 239
    │               │       └───"MULTIPLIER" (atomic): range [0, UINT64_MAX] = 4294967296
    │               ├───Color Operation 239
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 244
    │               │       └───"DATA" (atomic): blob = 0
    │               ├───Color Operation 244
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 249
    │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse, Gamma 2.4 Inverse, Gamma 2.6 Inverse} = sRGB Inverse EOTF
    │               ├───Color Operation 249
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 256
    │               │       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
    │               │       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
    │               │       └───"DATA" (atomic): blob = 528
    │               ├───Color Operation 256
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3D LUT
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 263
    │               │       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 17
    │               │       ├───"LUT3D_INTERPOLATION": enum {Tetrahedral} = Tetrahedral
    │               │       └───"DATA" (atomic): blob = 529
    │               ├───Color Operation 263
    │               │   └───Properties
    │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
    │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
    │               │       ├───"NEXT" (atomic, immutable): object colorop = 268
    │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2, Gamma 2.4, Gamma 2.6} = PQ 125 EOTF
    │               └───Color Operation 268
    │                   └───Properties
    │                       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
    │                       ├───"BYPASS" (atomic): range [0, 1] = 1
    │                       ├───"NEXT" (atomic, immutable): object colorop = 0
    │                       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
    │                       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
    │                       └───"DATA" (atomic): blob = 0

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

===

Melissa Wen (11):
  drm/atomic: handle CRTC colorops in drm_atomic_commit_set_colorop_state()
  drm/atomic: duplicate CRTC colorop states
  drm/atomic: track individual CRTC colorop updates
  drm/colorop: distinguish whether a colorop belongs to a plane or a CRTC
  drm/drm_mode_object: hide deprecated CRTC color mgmt props if colorop is set
  drm/atomic: set hidden CRTC color mgmt model to default values
  drm/drm_ioctl: guard DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
  drm/amd/display: move CRTC CTM color mgmt prop to check helper
  drm/amd/display: enable post-blend CTM colorop
  drm/amd/display: add support to post-blend 1D-Curve colorop
  drm/amd/display: add support to post-blend 1D-LUT colorop

Nícolas F. R. A. Prado (8):
  drm/crtc: Add color pipeline to CRTC state
  drm/colorop: Allow parenting colorop to CRTC
  drm: Factor out common color_pipeline property initialization code
  drm/crtc: Add COLOR_PIPELINE property
  drm: Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
  drm/atomic: Print the color pipeline as part of the CRTC state print
  drm/colorop: Factor out common paths from colorops helpers
  drm/colorop: Introduce colorop helpers for crtc

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 254 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  76 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  42 +++
 drivers/gpu/drm/drm_atomic.c                  |  17 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  18 ++
 drivers/gpu/drm/drm_atomic_uapi.c             | 132 +++++++-
 drivers/gpu/drm/drm_colorop.c                 | 282 ++++++++++++++----
 drivers/gpu/drm/drm_connector.c               |   1 +
 drivers/gpu/drm/drm_crtc.c                    |  31 ++
 drivers/gpu/drm/drm_crtc_internal.h           |   1 +
 drivers/gpu/drm/drm_ioctl.c                   |  20 ++
 drivers/gpu/drm/drm_mode_object.c             |  18 ++
 drivers/gpu/drm/drm_plane.c                   |  34 +--
 drivers/gpu/drm/drm_property.c                |  44 +++
 include/drm/drm_atomic_uapi.h                 |   2 +
 include/drm/drm_colorop.h                     |  32 +-
 include/drm/drm_crtc.h                        |  21 ++
 include/drm/drm_file.h                        |   7 +
 include/drm/drm_property.h                    |   5 +
 include/uapi/drm/drm.h                        |  20 ++
 21 files changed, 912 insertions(+), 147 deletions(-)

-- 
2.53.0

