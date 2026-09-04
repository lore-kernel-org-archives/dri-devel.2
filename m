Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60715C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D195410E619;
	Sat,  5 Sep 2026 15:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JwYQOFFJ";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2713610E551
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:06:13 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6acc74fef22so421053eaf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523572; x=1789128372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUnqZgZG6/HByiIclaEltYHSMp4tHK+7pXJmI++LxBc=;
 b=JwYQOFFJzJIwZvNk4xS7ihjOh11Sdf/VMi/d+8hep3Sf7Pm+VPPI8XFDBenJkVfOCj
 6LUZDWXmnH+nISzKqW6Rv7hQIrrwtRPoeI9cO6yQMoQkXSJOHESDLYqFg48DeyEfNLL0
 GuIOK1lQbiUgaZ81MCBl/t6qgQH+NzVES0+2Fkv4no7ohme2MG3TA2/nZp1tjSeCP2Sj
 S8W58J+NeOS9AST0AIhtl3bcoZ9CtqLxPw4u8qb4VVJtdR2BWKw+uwQLKBnzrn01MgfW
 tBpRqOHjrvGPNKEiz3Sy0eL/vJGwByFX+bBx/aFf5QWOATVVI/Nf425nTWN0GLapkwIk
 Okjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523572; x=1789128372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUnqZgZG6/HByiIclaEltYHSMp4tHK+7pXJmI++LxBc=;
 b=NtYjevTsInYvdC9+qMA+NqoLIwT74jHkUgtD052NQNxdJOEgsO4FCx+gQ/AFWmPvg3
 9d3i819moenxbE1JFAeVENbpPdZmxkhSCDsKjwAGTaJKqMUH/4L4xgvZi0jlh3fA0SX7
 Owst3cs9O3p4fxFFrW5ZWNbDE5krqsnCnHDcwToVE7uRmWIs1IwELeiN9tOMR6VR3Fqs
 LSB/w2cEFcm+2dLVdkwh4q+q9+wpS7JAdKkFplziA5+7IAmxCdFmUrk7Al+VzBe3hMaT
 c5jhO8ukCwMnD+1g78tgM59YydiV9TkniBnHk8EUBiMebPpt/tCdYZLqE8cctETjFJ+2
 sqXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgSt+MsEmI7GttMd5ArsJcyfZUeSfeUeAlIiXS6a2Cyn+R+BdSn3Zns3Sb/ci64sZuI7xKwjxh48o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcw4PmcTtip8C2FroQcvALhZ1PVgNnpmAJybD2Alcl6GhuM9d7
 bgzsyKaqSApGhZS12tGmpMIdYuwtCeZgBL0MS22z3zPe6XtMww1YZZPC
X-Gm-Gg: AYBFou1vhLK/58ZyG3h6TCZQpEUdck8Mfw4bK8St4X7BwP7vchKtuWqLgfw0hG07n/f
 cqz3ritN6uL7b65aEh4iqZL/PioCJN4e73JBgrF23j801EjW6vgoyI5HI76CHEMsXq3aypUIKoa
 PZVJJR6opIQJFRaH3d7StlOP/AO1K/OhmgX8sizHrH99BxCKIQwZcT20ybGg1RnSKdNLmjLr6w8
 mRYMYGb9pQYa3mrgSKf+LDdo/BISBiyvdpbo985boZnpeRSheUEpAmDjYz8W/EDGyG4d+AXJO3Q
 rtnVp930Nx+iQF8EhkzV/TarEiImv4ZPLivxRkBxnB00GcTJlIpmvt4iL0t92J0cykXy7bAKRw4
 1sYD3tJcUD8sGhbUBvM12nZ2W/3ByI9NzfGQBQL/h8teVLH6TJHGCaLiz0q1F0pkXDolJKNImwn
 NdLvnb5jd3YjnEVNYnxsM57Gw0SvV4ngyDYRhW1EcJzmaVOSLI12ZconSLoMZFxOTgYnKCWs5Zl
 9vPKQHm66djBe4=
X-Received: by 2002:a05:6820:1992:b0:6b1:4173:ca4a with SMTP id
 006d021491bc7-6b6fafe071emr3681918eaf.11.1788523572254; 
 Fri, 04 Sep 2026 05:06:12 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm6321674eec.22.2026.09.04.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:06:11 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 1/2] drm/msm: fix typos in comments
Date: Fri,  4 Sep 2026 17:35:56 +0530
Message-ID: <20260904120601.18363-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120601.18363-1-hemanth.selam@gmail.com>
References: <20260904120601.18363-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_power.c     | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     | 2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c  | 2 +-
 drivers/gpu/drm/msm/dsi/dsi.c               | 2 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c       | 2 +-
 drivers/gpu/drm/msm/msm_gem.h               | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h        | 2 +-
 drivers/gpu/drm/msm/registers/gen_header.py | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_power.c b/drivers/gpu/drm/msm/adreno/a5xx_power.c
index d6da7351cfbb..95f432de2bcc 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_power.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_power.c
@@ -8,7 +8,7 @@
 /*
  * The GPMU data block is a block of shared registers that can be used to
  * communicate back and forth. These "registers" are by convention with the GPMU
- * firwmare and not bound to any specific hardware design
+ * firmware and not bound to any specific hardware design
  */
 
 #define AGC_INIT_BASE REG_A5XX_GPMU_DATA_RAM_BASE
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 8cd2020d4b7e..667ed411076d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -518,7 +518,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-		 * We can only swtich to VM_BIND mode if the VM has not yet
+		 * We can only switch to VM_BIND mode if the VM has not yet
 		 * been created:
 		 */
 		if (ctx->vm)
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 841f444a8d68..cb9606c21ba2 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -245,7 +245,7 @@ static int mdp5_plane_atomic_check_with_state(struct drm_crtc_state *crtc_state,
 			new_hwpipe = true;
 
 		/*
-		 * (re)allocte hw pipe if we're either requesting for 2 hw pipes
+		 * (re)allocate hw pipe if we're either requesting for 2 hw pipes
 		 * or we're switching from 2 hw pipes to 1 hw pipe because the
 		 * new src_w can be supported by 1 hw pipe itself.
 		 */
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 3c9f01ed6271..1a1a59151e5c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -246,7 +246,7 @@ int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 	if (msm_dsi_is_bonded_dsi(msm_dsi) &&
 	    !msm_dsi_is_master_dsi(msm_dsi)) {
 		/*
-		 * Do not return an eror here,
+		 * Do not return an error here,
 		 * Just skip creating encoder/connector for the slave-DSI.
 		 */
 		return 0;
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 959daa88b1d0..36c7ae94b1c8 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -347,7 +347,7 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge,
 	/*
 	 * Do nothing with the host if it is slave-DSI in case of bonded DSI.
 	 * It is safe to call dsi_mgr_phy_disable() here because a single PHY
-	 * won't be diabled until both PHYs request disable.
+	 * won't be disabled until both PHYs request disable.
 	 */
 	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
 		goto disable_phy;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index dff60cbc9d95..a8e983b243b8 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -346,7 +346,7 @@ msm_gem_unlock(struct drm_gem_object *obj)
 
 /**
  * msm_gem_lock_vm_and_obj() - Helper to lock an obj + VM
- * @exec: the exec context helper which will be initalized
+ * @exec: the exec context helper which will be initialized
  * @obj: the GEM object to lock
  * @vm: the VM to lock
  *
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 3631ec283c6e..486280ca478e 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -101,7 +101,7 @@ struct msm_ringbuffer {
 
 	/*
 	 * preempt_lock protects preemption and serializes wptr updates against
-	 * preemption.  Can be aquired from irq context.
+	 * preemption.  Can be acquired from irq context.
 	 */
 	spinlock_t preempt_lock;
 
diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index d3b56a9d84fb..d6bfb7b7d7b3 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -576,7 +576,7 @@ class Parser(object):
             raise self.error(e)
 
     def parse_varset(self, attrs):
-        # Inherit the varset from the enclosing domain if not overriden:
+        # Inherit the varset from the enclosing domain if not overridden:
         varset = self.current_varset
         if "varset" in attrs:
             varset = self.enums[attrs["varset"]]
-- 
2.48.1

