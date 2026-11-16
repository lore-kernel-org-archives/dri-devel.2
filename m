Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E7606A33A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=MI3Gc1KS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CF810EB1F;
	Mon, 16 Nov 2026 08:47:20 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630D210EAD2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1794818770;
 bh=lSsI9v4x2V3cJuZFCaNIrvFewmsEWmwhG13HbDEgbVM=;
 h=From:To:Subject:Date:Message-Id;
 b=MI3Gc1KSbVC5BcV2CwgpV95IMD5cyHfcaC5kHgFonFtXV/i0uj7jbPmhPGwYILAku
 jaqrEA57XvnsC9XeEvOQCQYj7/ViDBuhpY823YizFHJYaSzJViK/iL7Bakd439tLwn
 ss69gQMCIwFj2BQCRf39nKB5Bz6Uv/yzWlI2fhRI=
X-QQ-mid: esmtpgz13t1794818763t8e5c2cf0
X-QQ-Originating-IP: 71HDNamfL4ZLghdjCeoOieO1N3vPn7U1SZ+jZDPEX30=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Nov 2026 16:46:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13307274964963775721
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 0/3] drm/rockchip: vop2: Add 8K support for RK3588 vop2
Date: Mon, 16 Nov 2026 16:45:52 +0800
Message-Id: <20261116084555.1061-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ONv4FG6+I+02RcKJHIIADmIGZQ8MKAvYtlt+r2hrkPntKjVAGjjJ8Lxt
 a2s667RSoW2H8BLicFk/p9VebxVpgoizlD1b2ozyrzd+sr1T3OVK69b0nQP508nyIhLbgps
 mp7RiFFw1kb8+eHZt4LMdC1CTG4ykyTjwQqIuuqgdEgtRLy3phiYlengfhb9f/7owh5c6Cl
 J3QclxY68STsWM4pd1W8ulh/o+hKDdhPA4Yc0zcdoxs42kQZxP13hZ8W9fZbTNuFpF1rwB/
 VHcTQjpzMvVGwwMgSpnjszGW0oHFG0KmKeHp8MVjIgZGXb/mzYHaQ4T57JD7HcETw1RLmN+
 Rm0Z4rCZ1ZiHrZKHfkgnLbYELc5ap7SHk6Z2Nc07Z0tS8/EuGZBSMRhONmcdgKyb5L51EGX
 NeMZ/IKkOVVZrFn30JaZCrQBX4ZXSd7Efub3J36OhMXzsNdw04qsvwZRLFxECGVvnpPgWLd
 Zqjfj3jsTTIQ7+p8BuGsCLITLlMNS1cQHOLRLl2pxTUE1QvacYgpzjSyfxK+z50jOSdMOnC
 NjskHGeBagKhfH30kq6apikAH4/iwI0yEna6xHT4LAQ/qciag336aojA73wQ45fFkfReH2Q
 6lQFEa2yyYWeAUisqxNvXl/kLXVdr/+wUS7kglRq1p8y5vBikRYwA8UYD2dQLPGuQkQOyQ/
 50XtE6An5CXi2hafzgrXIR/KaeGeKew23JVomPJkFZ/h5tXKi+2Ed/ymYdIqhpL/UbqlN71
 glGpsSjb2bJmG52cBEEuG6TEGZZeofGBy0SmW+TrcC+AYTyBXeSwbI1ZZTdRqzLVWnR2i5A
 0YcSE0Io02d6LkwQGRoX7NJrmF9bs2RSxbxIbfrl1/560HinfZR3eoN+4VtDoYBE5SiC88x
 IC5wK8wYz1Fvf79GgNblHc47F60KbJjBhoPiSQddgBRC+dvey5PjhmADjpvPyh3YlB2fxy4
 iwAOxiR3qHzU6yKw1QapgJou4rpeaxwvA2weDHPTmGMfCbVYA30b27hVX80eqMIYN0KaLqT
 wX7Y+hfQ8d6K1VV9d2ynNYGAzxdLs=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Hi,

This series adds support for 8K output on the RK3588 VOP2. HDMI is not
ready yet, but I believe many people might be interested in this.

8K output on the RK3588 is done by splicing two VPs together, with VP0
outputting the left half of the screen and VP1 the right half. In
addition, 8K planes have to be split in half as well to stay within the
width limit of a single plane. Similarly, there are a few post-processing
details that need to be handled.

Note that splice mode is not only usable for 8K output. This means the
mode can be tested at 4K and even lower resolutions, by simply changing
this one line:

-#define VOP2_MAX_VP_OUTPUT_WIDTH    4096
+#define VOP2_MAX_VP_OUTPUT_WIDTH    (3840 / 2) /* for 4K test */

And yes, this has been tested at 4K over HDMI on the RK3588 EVB1 :)

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20261029081429.862-1-kernel@airkyi.com/
- Cast the result of drm_format_info_min_pitc() to u32 to avoid 64bit division.
- Rework the left-window splice check to avoid pulling an unrelated CRTC
  into non-modeset commits, and use the new CRTC mode instead of the
  stale splice_mode flag(Sashiko).
- Reserve the splice partner window when the partner VP has no CRTC, so
  it cannot be assigned as another VP's primary plane(Sashiko).
- Only set the partner VP's CFG_DONE while the new state is in splice
  mode; do not force it when leaving splice mode(Sashiko).
- Program the main and splice video ports in a single layer-mixer pass,
  and apply the YUV overlay mode to both VPs(Sashiko).

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20261022071737.508-1-kernel@airkyi.com/
- Missing removal of the replaced line(Heiko).
- vop2_win_get_pstate(): use the left window's state only in splice mode(Sashiko).
- Reject splice windows already in use by another CRTC(Sashiko).
- Check the splice partner via drm_atomic_get_crtc_state() instead of the runtime flag and unlocked read(Sashiko).
- Set splice_mode_right/left_vp before the error paths of vop2_crtc_atomic_enable()(Sashiko).
- Validate each split half against the min width 4 and max input width; align NV20/NV30 like NV15(Sashiko).
- Latch overlay registers at the left VP's vsync; don't wait for the partner's own cfg-done(Sashiko).
- Program the color key on the window actually being updated(Sashiko).

Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>

Chaoyi Chen (3):
  drm/rockchip: vop2: Use drm_format_info_min_pitch() for plane offsets
  drm/rockchip: vop2: Skip UV plane setup for packed YUV formats
  drm/rockchip: vop2: Support 8K output by splicing two video ports

 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |   5 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 579 +++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  66 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 370 ++++++++----
 4 files changed, 857 insertions(+), 163 deletions(-)

-- 
2.53.0

