Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8308ACD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E297A10EA40;
	Tue, 16 Jun 2026 11:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="e15C4+7h";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7118010EA80
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781610869;
 bh=R2E9ORlyPEOJ/lZgRyZEX56Qk0VOHmnqRy9p9iHuGRk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e15C4+7h31mzaktTEHd274GSHsauwsFVL7qGl33H8hpMUfZrfOnLlewx2Ner8xI5/
 N6FaYKA7dHMh1vMJc+94M09SRwEh7RY0p3dC78txFiPszf1A1ktOke6FpfKCuB+zL+
 2nT/Ou91ry4BG7fuCTJn2DHa0w3AdqsPz+zIWosXhEcKUYhv3Zl2lVmJK3l3BDKoAl
 qk3iZA60WUEui+UMhAFE0L0oK0aM283WqR0LShGjHji4PLjmh/RsLSkPCUyMPOHx+G
 Fehvd8Dksr8vFcODw6BO1pV5JkYkF0ArKexIuTvYe+fSpx5bf29in0qPRCXtxTaHK7
 3T7zyVGJfRYsA==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EA3417E0C65;
 Tue, 16 Jun 2026 13:54:26 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drm/ci: Remove sc7180-trogdor-lazor-limozeen job
Date: Tue, 16 Jun 2026 17:24:04 +0530
Message-ID: <20260616115410.325837-2-vignesh.raman@collabora.com>
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

sc7180-trogdor-lazor-limozeen devices in the LAVA lab have been
experiencing stability issues, and 4 of the 6 devices have been
retired. So remove the corresponding job from CI.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v1:
  - Remove sc7180-trogdor-lazor-limozeen job
  - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221

---
 drivers/gpu/drm/ci/build.sh                   |  1 -
 drivers/gpu/drm/ci/test.yml                   | 10 -------
 ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 22 --------------
 ...m-sc7180-trogdor-lazor-limozeen-flakes.txt | 20 -------------
 ...sm-sc7180-trogdor-lazor-limozeen-skips.txt | 30 -------------------
 5 files changed, 83 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
 delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
 delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index d00d549cbd9c..fdaa26ad79d6 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -26,7 +26,6 @@ if [[ "$KERNEL_ARCH" = "arm64" ]]; then
     DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb"
-    DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb"
     DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sm8350-hdk.dtb"
 elif [[ "$KERNEL_ARCH" = "arm" ]]; then
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index f6bee5b67931..3777189e9737 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -102,16 +102,6 @@
     KERNEL_IMAGE_TYPE: ""
     LAVA_FIRMWARE: qcom-lava
 
-msm:sc7180-trogdor-lazor-limozeen:
-  extends:
-    - .msm-sc7180
-  parallel: 4
-  variables:
-    DEVICE_TYPE: sc7180-trogdor-lazor-limozeen
-    DTB: sc7180-trogdor-lazor-limozeen-nots-r5
-    GPU_VERSION: ${DEVICE_TYPE}
-    RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-lazor-limozeen
-
 msm:sc7180-trogdor-kingoftown:
   extends:
     - .msm-sc7180
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
deleted file mode 100644
index 2daf4ab879a9..000000000000
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-core_setmaster@master-drop-set-user,Fail
-kms_color@ctm-0-25,Fail
-kms_color@ctm-0-50,Fail
-kms_color@ctm-0-75,Fail
-kms_color@ctm-blue-to-red,Fail
-kms_color@ctm-green-to-red,Fail
-kms_color@ctm-negative,Fail
-kms_color@ctm-red-to-blue,Fail
-kms_color@ctm-signed,Fail
-kms_color@gamma,Fail
-kms_color@legacy-gamma,Fail
-kms_cursor_legacy@cursor-vs-flip-toggle,Fail
-kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
-kms_flip@flip-vs-modeset-vs-hang,Fail
-kms_flip@flip-vs-panning-vs-hang,Fail
-kms_lease@lease-uevent,Fail
-kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
-kms_plane_alpha_blend@alpha-7efc,Fail
-kms_plane_alpha_blend@coverage-7efc,Fail
-kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
deleted file mode 100644
index cafc802cecea..000000000000
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-# Board Name: sc7180-trogdor-lazor-limozeen-nots-r5
-# Bug Report: https://lore.kernel.org/linux-arm-msm/661483c8-ad82-400d-bcd8-e94986d20d7d@collabora.com/T/#u
-# Failure Rate: 50
-# IGT Version: 1.28-g0df7b9b97
-# Linux Version: 6.9.0-rc7
-msm/msm_mapping@shadow
-
-# Board Name: sc7180-trogdor-lazor-limozeen-nots-r5
-# Bug Report: https://lore.kernel.org/linux-arm-msm/661483c8-ad82-400d-bcd8-e94986d20d7d@collabora.com/T/#u
-# Failure Rate: 100
-# IGT Version: 1.28-gf13702b8e
-# Linux Version: 6.10.0-rc5
-kms_lease@page-flip-implicit-plane
-
-# Board Name: sc7180-trogdor-lazor-limozeen-nots-r5
-# Bug Report: https://gitlab.freedesktop.org/drm/msm/-/issues/74
-# Failure Rate: 20
-# IGT Version: 1.30-g04bedb923
-# Linux Version: 6.14.0-rc4
-kms_cursor_crc@cursor-random-128x128
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt
deleted file mode 100644
index a9bb3e1ad75c..000000000000
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-# Suspend to RAM seems to be broken on this machine
-.*suspend.*
-
-# Skip driver specific tests
-^amdgpu.*
-nouveau_.*
-^panfrost.*
-^v3d.*
-^vc4.*
-^vmwgfx*
-
-# Skip intel specific tests
-gem_.*
-i915_.*
-tools_test.*
-kms_dp_link_training.*
-
-# Currently fails and causes coverage loss for other tests
-# since core_getversion also fails.
-core_hotunplug.*
-
-# IGT issue. is_joiner_mode() should return false for non-Intel hardware.
-# https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/162
-kms_display_modes@extended-mode-basic
-kms_display_modes@mst-extended-mode-negative
-
-# sc7180 does not have APRIV, so memptrs is not protected.
-# (Preemption is not supported on devices that do not have
-# APRIV, so this is ok)
-msm/msm_mapping@memptrs
-- 
2.47.3

