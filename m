Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B255ECD98E8
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1731C10EA8A;
	Tue, 16 Jun 2026 11:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="df6uXJRF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C4910EA80
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781610872;
 bh=jC+FAM3EW54MLhU3yGmuzjo8IWqD8uHcIWces1mre1w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=df6uXJRFBPQ8mJOw4V2ugIhBbyJEBrvc5ZRPwpZRkoR6SaMaG07aVbvztMHxM0IGT
 6g5YwHflSBylgWymhKG/YD1ez+QMyYeNDtcjeqrPF8Xb0JH6Hkc7B8bU0QcuI4xsso
 8ZkbF2IEhkRkn+yafqMq6IPkS5PtC63rG87IMaR6deLet7lrOirwCWLrXzS0KsrbtH
 4hxWxkTiv6DguN6y94/c+B1Cu3QVBGpPelU2AL3FfeVI/ZjgHBwX0WoCW/TZ5eoeUe
 cBqDEViQyWFBGBMPfrNUo/kvBhH+C819Lnd/GuJkMvDM2ZrJduTlTGVMNutH4WZuXp
 KiYVtNrxDUYJg==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A67A117E0CAC;
 Tue, 16 Jun 2026 13:54:29 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/ci: add sc7180-trogdor-wormdingler-rev1-boe
Date: Tue, 16 Jun 2026 17:24:05 +0530
Message-ID: <20260616115410.325837-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616115410.325837-1-vignesh.raman@collabora.com>
References: <20260616115410.325837-1-vignesh.raman@collabora.com>
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

Add job that executes the IGT test suite for
sc7180-trogdor-wormdingler-rev1-boe.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v3:
  - Rebase with msm-next
  - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221

v2:
  - Add comments to clarify panel configurations for sc7180 trogdor devices
  - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
  - Failure pipeline - https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1642103

v1:
  - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
  - Depends on https://lore.kernel.org/dri-devel/20260210071138.2256773-1-vignesh.raman@collabora.com/

---
 drivers/gpu/drm/ci/arm64.config               |  4 +++
 drivers/gpu/drm/ci/build.sh                   |  1 +
 drivers/gpu/drm/ci/test.yml                   | 12 +++++++++
 ...180-trogdor-wormdingler-rev1-boe-fails.txt | 23 ++++++++++++++++
 ...180-trogdor-wormdingler-rev1-boe-skips.txt | 27 +++++++++++++++++++
 5 files changed, 67 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 563a69669a7b..f601b662c82f 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -214,3 +214,7 @@ CONFIG_PWM_TEGRA=y
 CONFIG_DRM_PANTHOR=m
 CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y
 CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX=y
+
+# For sc7180-trogdor-wormdingler-rev1-boe
+CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
+CONFIG_GPIO_SHARED_PROXY=y
diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index fdaa26ad79d6..61ac2d043ce3 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -28,6 +28,7 @@ if [[ "$KERNEL_ARCH" = "arm64" ]]; then
     DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sm8350-hdk.dtb"
+    DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb"
 elif [[ "$KERNEL_ARCH" = "arm" ]]; then
     GCC_ARCH="arm-linux-gnueabihf"
     DEBIAN_ARCH="armhf"
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 3777189e9737..d9b21d63fb65 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -102,6 +102,7 @@
     KERNEL_IMAGE_TYPE: ""
     LAVA_FIRMWARE: qcom-lava
 
+# eDP panel (parade ps8640 dsi->edp bridge)
 msm:sc7180-trogdor-kingoftown:
   extends:
     - .msm-sc7180
@@ -112,6 +113,17 @@ msm:sc7180-trogdor-kingoftown:
     GPU_VERSION: ${DEVICE_TYPE}
     RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-kingoftown
 
+# MIPI DSI panel
+msm:sc7180-trogdor-wormdingler:
+  extends:
+    - .msm-sc7180
+  parallel: 6
+  variables:
+    DEVICE_TYPE: sc7180-trogdor-wormdingler-rev1-boe
+    DTB: sc7180-trogdor-wormdingler-rev1-boe
+    GPU_VERSION: ${DEVICE_TYPE}
+    RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-wormdingler-rev1-boe
+
 msm:apq8016:
   extends:
     - .lava-igt:arm64
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
new file mode 100644
index 000000000000..4af93eeeaf99
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
@@ -0,0 +1,23 @@
+core_setmaster@master-drop-set-user,Fail
+kms_color@ctm-0-25,Fail
+kms_color@ctm-0-50,Fail
+kms_color@ctm-0-75,Fail
+kms_color@ctm-blue-to-red,Fail
+kms_color@ctm-green-to-red,Fail
+kms_color@ctm-negative,Fail
+kms_color@ctm-red-to-blue,Fail
+kms_color@ctm-signed,Fail
+kms_color@gamma,Fail
+kms_color@legacy-gamma,Fail
+kms_cursor_legacy@cursor-vs-flip-toggle,Fail
+kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
+kms_flip@flip-vs-modeset-vs-hang,Fail
+kms_flip@flip-vs-panning-vs-hang,Fail
+kms_invalid_mode@overflow-vrefresh,Fail
+kms_lease@lease-uevent,Fail
+kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
+kms_plane@pixel-format,Fail
+kms_plane@pixel-format-source-clamping,Fail
+kms_plane_alpha_blend@alpha-7efc,Fail
+kms_plane_alpha_blend@coverage-7efc,Fail
+kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
new file mode 100644
index 000000000000..8d1768de90cc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
@@ -0,0 +1,27 @@
+# Skip driver specific tests
+^amdgpu.*
+nouveau_.*
+^panfrost.*
+^v3d.*
+^vc4.*
+^vmwgfx*
+
+# Skip intel specific tests
+gem_.*
+i915_.*
+tools_test.*
+kms_dp_link_training.*
+
+# Currently fails and causes coverage loss for other tests
+# since core_getversion also fails.
+core_hotunplug.*
+
+# IGT issue. is_joiner_mode() should return false for non-Intel hardware.
+# https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/162
+kms_display_modes@extended-mode-basic
+kms_display_modes@mst-extended-mode-negative
+
+# sc7180 does not have APRIV, so memptrs is not protected.
+# (Preemption is not supported on devices that do not have
+# APRIV, so this is ok)
+msm/msm_mapping@memptrs
-- 
2.47.3

