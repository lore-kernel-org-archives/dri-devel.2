Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1DC79F94
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E023F10E605;
	Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpp2Ypah";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D9110FAF1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:06:20 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6b35cc0a8c3so782998eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523580; x=1789128380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpjAUK45k2PJKSjdfeljwO5d42gX8uNwxDJAnF1e9RY=;
 b=kpp2YpahtS8FoEmNLYzxBuF4n/JOKl3bgB1gGPvrSEdOptzpxRJkvFXyR4q2d7MlGm
 vegsKvt5nau2QCttmBMYOKoNmA0nAHoITf9b9NbeKQau0LM2+YHfr2bg+/osDG9OctRl
 eq2paY56xdtTLiHP1iQ+IXzYoBD3H4MHTzxQ3JsbBy6yk8rawU9lWdVo2LAaJcdFDErW
 q2stO1sy85PTJ8Ul0HpLjtZGxXNhpU+kG5AxrXlYRqILsCszA+XaeQN0IWbVGDtsXNlD
 P4h/Kjeom+8iWzeA+8GNPuhlQjnsPxMu4J5dW9TShgZ53YiBCwk4XHLIRVKfX/K0Ii5S
 29JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523580; x=1789128380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpjAUK45k2PJKSjdfeljwO5d42gX8uNwxDJAnF1e9RY=;
 b=QF2vset10fZEVF2H+PAUDU57LKXVYBCxi3/JdtNqRTZ8oLbTEPw0WDJ0GQgEHD+YYl
 YsO1HVbeymBV7dSSGjPfX6OcIlT/8fnddv2kVVxcXq2fesqc7jyWtycm88obYYx3CPsb
 R1czlqv4a36qqBXhRiNn/Cqpsz2ehKwwfUM149SUhqTKE9ZUWPUxRQABBSHdzQl4g2cV
 YDwfTx9zNz+M+sjNyg6vcYdUKjBT/hJwRQM4XrIoqgSwGdHVscDFzp81n8Wdee2hNv0Y
 ecAoqehxTyn06C30/1CXuvtKUl5SVs13rYMsQPNh8Ydb3p85h6AmzDw0mzY2IpNWzFsM
 h3Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8dvArNYG2VcgXasxh66QefY/UswCf9UFO8aCDGQyFFExEerOHtwaMUk6y7MYNOUZONlUnWiIH78g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kA5CGTIMWq8V69HhofNT4vF/wjygjUEZRvY2owm6iRz3la84VU
 LOPTkv5Lx6JS2i9Cr7tz2Ea4ZNfk+W5Kx+y64wWfpRKSpyE8sWyUDqZy
X-Gm-Gg: AYBFou0PxUA2PWj8zPwK/KDAHsW+NIFIr6Q6zgGfvrkEDebiF1yRkKkgSH8vLB4LTft
 twV6V6RVUi5FqtYGqoVIkYIwmzlDb1Kh9gqTPRV9jW2XQd0LE8MQugKeLeWQ75RUe2azLvz77zb
 sfbN+lTsfyQIkJtHXjXFueoFlGTXmhuWz87KRFTsXQBYXWJstdJ97Bn/Beq+x+wIBSWX0oMzu4Y
 npBg+TSptsjoKUsJNhIURxPYO5kYOh4oYXoxKZ7Yc8GHbC810h4VwKdvOTlZjjWoJfwrFtnyS8D
 tZewswF2xpfvrXw0+0aCDea30wc+odhgiIMmMwY6MIPIpiez8ZNinv/UPU4wSYPdtmeBA/+zyWn
 sMzkLKMUowvFuO+fME4AoCbSSXMesMPZR6JZZ5qDxnKl7L3rOCj6xFWtlq81kLpxqS65ku4Ptzy
 hKBif8n8fwxZeo0CCj1fqjviArqJhmESHr7bGlhoxMPZeY06qG3r7ytjOkz4oRq7TK4daRF2ZHr
 9yYLzGT4+DR+RUk2NcZRKwdAA==
X-Received: by 2002:a4a:e914:0:b0:6b2:69bf:c8d7 with SMTP id
 006d021491bc7-6b6fb3df17emr3896155eaf.10.1788523579864; 
 Fri, 04 Sep 2026 05:06:19 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm6321674eec.22.2026.09.04.05.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:06:19 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] drm: fix repeated words in comments
Date: Fri,  4 Sep 2026 17:35:57 +0530
Message-ID: <20260904120601.18363-3-hemanth.selam@gmail.com>
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

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c  | 4 ++--
 drivers/gpu/drm/msm/msm_gem.c          | 4 ++--
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 2 +-
 include/uapi/drm/msm_drm.h             | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 27cac853975f..16fed0066f00 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1759,7 +1759,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		}
 
 		/*
-		 * Look for a level in in the secondary list that matches. If
+		 * Look for a level in the secondary list that matches. If
 		 * nothing fits, use the maximum non zero vote
 		 */
 
@@ -2378,7 +2378,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (ret)
 		goto err_memory;
 
-	/* Allocate memory for for the HFI queues */
+	/* Allocate memory for the HFI queues */
 	ret = a6xx_gmu_memory_alloc(gmu, &gmu->hfi, SZ_16K, 0, "hfi");
 	if (ret)
 		goto err_memory;
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c4cff3d53d81..7ad450b574bf 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -502,8 +502,8 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
 
 /* Special unpin path for use in fence-signaling path, avoiding the need
  * to hold the obj lock by only depending on things that a protected by
- * the LRU lock.  In particular we know that that we already have backing
- * and and that the object's dma_resv has the fence for the current
+ * the LRU lock.  In particular we know that we already have backing
+ * and that the object's dma_resv has the fence for the current
  * submit/job which will prevent us racing against page eviction.
  */
 void msm_gem_unpin_active(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 9d2788f79ace..d84cbb64bc56 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -47,7 +47,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 	      struct drm_gem_object *obj)
 {
 	/*
-	 * Track last locked entry for for unwinding locks in error and
+	 * Track last locked entry for unwinding locks in error and
 	 * success paths
 	 */
 	struct drm_gpuvm_bo *vm_bo, *last_locked = NULL;
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 3d363f12f66a..9b6b30189230 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -102,7 +102,7 @@ struct drm_msm_timespec {
  *
  * With VM_BIND enabled, userspace does not include a submit_bo table in the
  * SUBMIT ioctl (this will be rejected), the resident set is determined by
- * the the VM_BIND ops.
+ * the VM_BIND ops.
  *
  * Enabling VM_BIND will fail on devices which do not have per-process pgtables.
  * And it is not allowed to disable VM_BIND once it has been enabled.
@@ -366,7 +366,7 @@ struct drm_msm_vm_bind_op {
 	__u64 obj_offset;
 	/** @iova: Address to operate on */
 	__u64 iova;
-	/** @range: Number of bites to to map/unmap */
+	/** @range: Number of bites to map/unmap */
 	__u64 range;
 	/** @flags: Bitmask of MSM_VM_BIND_OP_FLAG_x */
 	__u32 flags;
-- 
2.48.1

