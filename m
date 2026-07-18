Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CBDC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 13:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F04510E259;
	Sat, 18 Jul 2026 13:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EALpOPfD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4B110E259
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=DQ3OZ98rWXCqM52MtHtWFrOSnPd9u4m+9VklW0dOlyI=; b=EALpOPfDZ6HOBJdRluml/ExMQx
 e5IQ+TPPGO9TqdQr0wQSRLfg5XWa9pMloTpy9QC847Hyi0CfOYBchTXGh35osb+vAnf9e6td/OM9J
 lhYkPN6nEuXepBjQQpHl+kgSp6AGq8uU81lMfH0aodAkYAnSZhOcID2b6fxY82fROg6BHc/wDVdsm
 rSfFWmSzzX7nw14Kmd94ZlKkExy3B98wPV+7nVf7a0zehhQEcHE+wMlrTEPwaVLk6NXIF6bxr02TT
 bv4w9BtUyq2vUubFichVHIWyEJG/PuoFNGdfwPXpfzO20RSuSIXt3INAujYrjrDXZMJGpO0M6TnRE
 4DmJkaDA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wl5LU-00HSXW-TD; Sat, 18 Jul 2026 15:44:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 10:44:37 -0300
Subject: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3186; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=QnQcBYp6xY0uqSFicbOvXcGAfWZvdvmkRh/MezFdQ6M=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW4NInp0yEnEu6ApXIs1POwnLnAjnQfWI1sTcT
 aD8Gr5+SC2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaluDSAAKCRA/8w6Kdoj6
 qvjdCADbO4BH0IjQwOI+OTYXjkhyqtWBT3APNBGvGspHMePY4wejS6SKXWBWge+3zXqb8kCkrO4
 rhNkPhwidlSK3om33xDfTIny2rxNem91j+1utM7JDnKrsBIZDrxmAUw8LIe54Sx51iiJEFVQ4VR
 3E7nKKeuKzGnGx87Dfjy7ZGTnWXJgRwI9VVpu6SwzuPaa/SahnO+Nv+cI1ZbociRAdNnsaGpwMn
 YLWQSLaz7+kcUKrbBHNxW7Ux8EzA/s2AJvpvUfqHjrPS0/T6ja0tQiBaYttWD471ILbRaAK75n+
 ZzjPw0gHsK9v016qZlc/WAwcV0fr0ikPvZZMdANV7b3u39ba
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Currently, v3d_power_suspend() removes the GPU clock without first
quiescing the GPU's memory interface (AXI). If the clock is cut while the
core still has outstanding AXI transactions in flight, the hardware is
frozen mid-transaction. That corrupted state survives the power cycle, and
the first job submitted after the next resume will cause a GPU hang
accompanied by an L2T "pte invalid" MMU fault.

The hardware already provides a safe-powerdown sequence for this: request
the GMP to stop and wait for outstanding reads/writes to drain
(v3d_idle_axi()), plus the GCA safe shutdown on pre-4.1 HW
(v3d_idle_gca()). The driver implements both, but the runtime PM support
added later never invoked them when powering the GPU down.

Perform the safe-powerdown sequence in v3d_power_suspend() before
disabling the clock, while the core is still powered.

Cc: stable@vger.kernel.org
Link: https://github.com/raspberrypi/linux/issues/7443
Link: https://github.com/raspberrypi/linux/issues/7488
Fixes: 458f2a712ab4 ("drm/v3d: Introduce Runtime Power Management")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h   | 2 ++
 drivers/gpu/drm/v3d/v3d_gem.c   | 4 ++--
 drivers/gpu/drm/v3d/v3d_power.c | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 1b88b3dff757..f28b19237c0b 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -618,6 +618,8 @@ extern bool super_pages;
 void v3d_init_hw_state(struct v3d_dev *v3d);
 int v3d_gem_init(struct drm_device *dev);
 void v3d_gem_destroy(struct drm_device *dev);
+void v3d_idle_axi(struct v3d_dev *v3d, int core);
+void v3d_idle_gca(struct v3d_dev *v3d);
 void v3d_reset_sms(struct v3d_dev *v3d);
 void v3d_reset(struct v3d_dev *v3d);
 void v3d_invalidate_caches(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 41dc3617fb44..bc88ebdcdbea 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -36,7 +36,7 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 	V3D_CORE_WRITE(core, V3D_CTL_L2TFLEND, ~0);
 }
 
-static void
+void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
 	if (v3d->ver >= V3D_GEN_71) {
@@ -61,7 +61,7 @@ v3d_idle_axi(struct v3d_dev *v3d, int core)
 	}
 }
 
-static void
+void
 v3d_idle_gca(struct v3d_dev *v3d)
 {
 	if (v3d->ver >= V3D_GEN_41)
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index ade8e932fb9c..f608e6d5516a 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
 
 	v3d_clean_caches(v3d);
 
+	/* Wait until V3D has no active or pending AXI transactions. */
+	v3d_idle_axi(v3d, 0);
+	v3d_idle_gca(v3d);
+
 	ret = v3d_suspend_sms(v3d);
 	if (ret) {
+		/* Staying active: undo the GMP STOP_REQ from v3d_idle_axi(). */
+		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
+			  V3D_READ(V3D_GMP_CFG(v3d->ver)) & ~V3D_GMP_CFG_STOP_REQ);
 		v3d_irq_enable(v3d);
 		return ret;
 	}

-- 
2.55.0

