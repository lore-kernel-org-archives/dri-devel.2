Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4E606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BP523HED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1540F10E08B;
	Wed, 21 Oct 2026 05:16:37 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A74E10EA00;
 Wed, 21 Oct 2026 05:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792559787;
 bh=UtaOkbC6oXF9PskgOOgEz+UJHHl5feMuA4mZgvwvzBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BP523HEDNrJsiOVl2bsRi8tXl2BwI1YXjPDFHRr7aRMYeeyjCG3qwDlPR21Eo+ghD
 B5yevWX+hUpQnGX0kSsyt9uUyEgBdpqSLBQkciS9oZ7EvIgK0aW+yaOPYl4uWPZXSI
 ZswhaSoV2QYV/P+JRCLZ4CkaZqK5TQNFnTq4JgUdDAmPrvd036tRfuK8rB9brLLBkV
 Uo0JOyLgnpSQJsoQESQ8K+zGheit6g4m9bJJRafCRUtAZTBbH8IEF1nGrVn0IJfy/i
 ii6ZAH/B2OJEgfetM1hfHTzV7t8mACrQVF4fMxgz9Y37nQlFTz0OEahi8dkkjBOnsc
 SdzOxcm6GrYsA==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E97C017E0EBF;
 Wed, 21 Oct 2026 07:16:24 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] drm/ci: update xfails for sc7180 trogdor devices
Date: Wed, 21 Oct 2026 10:46:07 +0530
Message-ID: <20261021051611.3328351-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021051611.3328351-1-vignesh.raman@collabora.com>
References: <20261021051611.3328351-1-vignesh.raman@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some tests were skipped on sc7180-trogdor-kingoftown because
they hung, timed out or broke other tests.

Suspend tests now pass, and the other tests no longer hang or
affect other tests. So drop those skips and update the expected
failures.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v1:
  - New patch in the series

---
 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt       | 12 ------------
 .../xfails/msm-sc7180-trogdor-kingoftown-fails.txt   |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
index 154b047787b2..8d1768de90cc 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
@@ -1,6 +1,3 @@
-# Suspend to RAM seems to be broken on this machine
-.*suspend.*
-
 # Skip driver specific tests
 ^amdgpu.*
 nouveau_.*
@@ -19,20 +16,11 @@ kms_dp_link_training.*
 # since core_getversion also fails.
 core_hotunplug.*
 
-# Timeout occurs
-kms_flip@2x-wf_vblank-ts-check
-
-# Hangs the machine
-kms_cursor_crc@cursor-random-max-size
-
 # IGT issue. is_joiner_mode() should return false for non-Intel hardware.
 # https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/162
 kms_display_modes@extended-mode-basic
 kms_display_modes@mst-extended-mode-negative
 
-# It causes other tests to fail, so skip it.
-kms_invalid_mode@overflow-vrefresh
-
 # sc7180 does not have APRIV, so memptrs is not protected.
 # (Preemption is not supported on devices that do not have
 # APRIV, so this is ok)
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
index 2daf4ab879a9..96743acc399d 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
@@ -9,10 +9,12 @@ kms_color@ctm-red-to-blue,Fail
 kms_color@ctm-signed,Fail
 kms_color@gamma,Fail
 kms_color@legacy-gamma,Fail
+kms_cursor_edge_walk@256x256-right-edge,Fail
 kms_cursor_legacy@cursor-vs-flip-toggle,Fail
 kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
 kms_flip@flip-vs-modeset-vs-hang,Fail
 kms_flip@flip-vs-panning-vs-hang,Fail
+kms_invalid_mode@overflow-vrefresh,Fail
 kms_lease@lease-uevent,Fail
 kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
-- 
2.47.3

