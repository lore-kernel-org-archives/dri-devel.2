Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E89606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlLxoyIR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD2F10F489;
	Tue, 24 Nov 2026 11:00:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2992610F46F;
 Tue, 24 Nov 2026 11:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BC8A624E5;
 Tue, 24 Nov 2026 11:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9B21F000CA;
 Tue, 24 Nov 2026 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518003;
 bh=t6s2PX7Sd++VYOk1Ys4uJFm0pc/KkhlKdM2ntkQK/s0=;
 h=From:Subject:Date:To:Cc;
 b=IlLxoyIRIstAcQraRB1EcPoLc5C8U0bfOoLLVHs/mOkffjZZ9FuxSIXQ9dSjSPHEs
 OtSHhmF4P8xQOUGHS5V5rdT2h16xK8ptgCUk5tEqIRFphoVanDR29/HtsJ9GmFQHEE
 ws79pOyZbaWUpI2uvkbi1SjYS9RZ+fMRnm026UfEa0zxhYwQKU/MBoHSvYtw4eaNCS
 EX60ebiraVLWaOLsYDn4DiRBfJht6rikf3E8+qpB8eAn6KTPfOOJnwvfh75/NTqPT5
 YWBtLvVn0azOU0WAftXDlhaQyJcBRjo6qHTOJoO3MitEWqdcS6yCtKA74J/r+B5uIs
 fSZ74nsK4jg6Q==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/6] drm/i915: Support DRM_MODE_ATOMIC_RESET
Date: Tue, 24 Nov 2026 11:59:50 +0100
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/2WOS27DMAxEryJwHQKkXH+kqxRZyDKVEqjtRlKMA
 EHuXtjpokWXw+HgvQcUySoFvHlAlk2Lrgt4wycD8SMsF0GdwBuwZDtm+4ZTnlEdtxjXZZO8/2O
 poQpmCdN6q9jQ0IUuBLZdCycDX1mS3g/G+/mVs1xvWrS+jjCGIhjXedbqzQ6YtURc5F5x5yIzs
 oPfSt7sBfU0HEJZitQfjfQZLmjTaMe2Z06u9xvb/+OW+oaO8V97piHR4CLHhvzm4Px8fgNxNkL
 UJQEAAA==
X-Change-ID: 20261124-drm-i915-conversion-state-readout-3086a6aa1265
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6947; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/gZvSqK2nrij8vgXlsINvOJmq4hSmTo7a7wU4h26VdQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmseTr2GucXRRxc67ivMf3GM233BS7GO74/1Nx/TuQh7
 7R3F6/IdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ6JoyNlw4o3fvFdOCv+/W
 Zb9/J/P+9K7D1uzpHx0+T99Y79DjsitYoN9NXv54qLj2trdxexPYYxnr0yI18u1eqXJz/RZ9v8U
 pqHjHnbu3r15SvH29yupTbNlid/W/s66nsp58cV+C/0+I00QXAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

i915 objects didn't implement the reset callback, allocating their state
when they are registered instead, so the atomic_create_state conversion
had nothing to convert and left i915 out. The new DRM_MODE_ATOMIC_RESET
flag builds its commits out of states created through that hook, and is
only reported and accepted when every plane, CRTC and connector of the
device implements it: i915 therefore rejects the reset with -EOPNOTSUPP
and doesn't report DRM_CAP_ATOMIC_RESET.

This series implements atomic_create_state for the i915 CRTCs, planes
and connectors, and carries the current state over the created ones,
like other drivers had to: a CRTC that stays enabled across a reset
takes the nomodeset path of intel_atomic_check(), which relies on the
state a duplicate carries over.

The pipe configuration comparison is also moved to the STATE_CHECK_*
macros, with the u8, u16 hexadecimal and enum variants the i915 state
needs fed back into the framework, giving every compared field
compile-time type checking to start consolidating with the new atomic
SRO infrastructure.

Built with LLVM=1 and checkpatch'd, the new macros come with kunit
tests, IGT runs are still to be done.

Let me know what you think,
Maxime

Test-with: 20261112162147.766264-1-mripard@kernel.org

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (6):
      drm/atomic-state-helper: Provide more STATE_CHECK_* variants
      drm/i915: Use the STATE_CHECK_* macros in the pipe config comparison
      drm/i915: Implement CRTC atomic_create_state
      drm/i915: Implement plane atomic_create_state
      drm/i915: Implement connector atomic_create_state
      drm/i915: Carry the current state over created states

 drivers/gpu/drm/i915/display/i9xx_plane.c          |   2 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |   1 +
 drivers/gpu/drm/i915/display/intel_atomic.c        |  23 +
 drivers/gpu/drm/i915/display/intel_atomic.h        |   2 +
 drivers/gpu/drm/i915/display/intel_connector.c     |  23 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   1 +
 drivers/gpu/drm/i915/display/intel_crtc.c          |  12 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       | 607 ++++++++++++---------
 drivers/gpu/drm/i915/display/intel_dp.c            |   1 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   1 +
 drivers/gpu/drm/i915/display/intel_dvo.c           |   1 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   1 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |   1 +
 drivers/gpu/drm/i915/display/intel_plane.c         |  25 +-
 drivers/gpu/drm/i915/display/intel_plane.h         |   1 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  26 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   3 +
 drivers/gpu/drm/i915/display/intel_tv.c            |  15 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   3 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   1 +
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  |  99 ++++
 include/drm/drm_atomic_state_readout_helper.h      |  66 +++
 23 files changed, 638 insertions(+), 278 deletions(-)
---
base-commit: e6e635c4407e5bb8ddc6017a2e9825c17240e799
change-id: 20261124-drm-i915-conversion-state-readout-3086a6aa1265
prerequisite-change-id: 20260708-drm-reset-state-flag-2fb2b5711f97:v12
prerequisite-patch-id: eb7ef1bbf930a321d43086788e29a61899cabea9
prerequisite-patch-id: 69cb59e0e1800c71f284adf63ca98641df772975
prerequisite-patch-id: 794b3f9689e1eb474d90535b43d8c8de58ec5e48
prerequisite-patch-id: af7dfeb5128254a2368b8c3abd54c778caeea1fe
prerequisite-patch-id: d7baa4aaf5b686cef8a7762f6ec46e517505a7d2
prerequisite-patch-id: 3e4d1a009d6a944b20b2675d87436fb2acec2750
prerequisite-patch-id: cac360557a737dffdfec293c4c08608e327fd6fd
prerequisite-patch-id: 8e64689f12166016a371aaa15ec0e6691546c794
prerequisite-patch-id: 118c8beb0d45f5476c8814f82b79c90a4ea48e05
prerequisite-change-id: 20250730-drm-state-readout-108f089c1c30:v9
prerequisite-patch-id: f8c3385d46e2be7cba68c715e31f1b3ea80a45eb
prerequisite-patch-id: f04cf40e8c62005a0b5a928a68d394be2079a202
prerequisite-patch-id: cd09f9e502efc35aa22ede9d3c3b46e064466d22
prerequisite-patch-id: eb0a00c943fd93a555c0ef044d4008f5f83edd08
prerequisite-patch-id: a277ed9151f84539ec40ecfe630c18ff482e022c
prerequisite-patch-id: ae6b7f40f2b9002bf0eea54b1c41281db2adcde7
prerequisite-patch-id: e755bcd2e58f79d14e246446864ff204699d1a87
prerequisite-patch-id: 90687ec829c655bcfe4d81b12e24bccca7bd4833
prerequisite-patch-id: ef67b1cd0911021331844861ae0f2fad84b270fc
prerequisite-patch-id: e92f85eb974b4f507692da4fd0909cf272366b23
prerequisite-patch-id: dfe3ca8ddf643420beb99e613492ac319b2266b0
prerequisite-patch-id: fd825bcbb5b262926dca7139f759e9ad19a057de
prerequisite-patch-id: ad586d955ee4d48bc8bb935041602dfbe0fa0a8a
prerequisite-patch-id: 92a1b99d84487fc35457542f408cf3ceb40f2200
prerequisite-patch-id: f1605fb5ed653b35443647422bc348bdc3f03060
prerequisite-patch-id: aa65022cdfedaad2cedf6b5be5bf7a403d23a0cc
prerequisite-patch-id: 3f9fc15f5d3ef94c1026b020ffe08e0ff1504243
prerequisite-patch-id: 3d1e451d302dd742bec53cb1aa50643aa71ebf4c
prerequisite-patch-id: ba5c149130eb1a23094d507281bfadc444bd0b2f
prerequisite-patch-id: c89f59e3aa7165d77d1a616ab87d2ab4207ccae4
prerequisite-patch-id: 94873fa437500fc6a377875fca01ab35cb545382
prerequisite-patch-id: 66ff18129c8f0e1df1c4b899513a70f591c51eb4
prerequisite-patch-id: 08da79b7e93e614f918d0c65d3e015d7d62e0a2a
prerequisite-patch-id: 81e5473c19b1df4d76e0854305295277722b84a0
prerequisite-patch-id: 9ad81f0921c7ff7121244dfa81e8625eef2872ef
prerequisite-patch-id: 91b87c9dfd4f94ea8612d35ba0a59e734ea13478
prerequisite-patch-id: 25fbe2804e1a162e75cc083e8cb45fc01efca01b
prerequisite-patch-id: 9ef0dc76a9b0f998ea8e568849568648d4d859ea
prerequisite-patch-id: dd1b97b1854cfa5dbf7b794732e6fd7fdbab8e74
prerequisite-patch-id: a2c2d019cc44d5a7c5c64aa13039ca0502150dfe
prerequisite-patch-id: 8adda3ba9ca95ad041acfd258a31e4fe03d0c0e0
prerequisite-patch-id: 7b38fa633f4dec44d54037f1754f9d1e1c003e4d
prerequisite-patch-id: f8ff07c5ff81332c3e131c6e98532a83eab77304
prerequisite-patch-id: 3c12b1bf7245bb8ca3d98854a69c4e3eb3cc6c4e
prerequisite-patch-id: 28f453e6b4a60111c4f452bf1f470c965940df2d
prerequisite-patch-id: 5af22c10f16b8ba0920a4c9a942016982557df52
prerequisite-patch-id: f2667f1c8010b2147be6cbccdc7b4e8c8c90ca78
prerequisite-patch-id: 4b5c8d9aaa88af62ee71cdbf7581115ae8d2108e
prerequisite-patch-id: c13d82cab1c523a7589723b12a9d9c674d1b548c
prerequisite-patch-id: dc3f630e2f48e07c4287920da256f81fde29afbd
prerequisite-patch-id: e94aa17d17ba8fdbd935c455fd2ae52df3bb4d68
prerequisite-patch-id: a4f0694c3c6da19f47e160e6bed1b8b8b42c8180
prerequisite-patch-id: 732d43e26eff2f092a61d52950377bbee8d05186

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

