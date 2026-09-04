Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E748C79F91
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D0E10E5FC;
	Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cjgr5zE/";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C10110E186
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:02:42 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6aa9606ddadso656832eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523361; x=1789128161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WyOGs2boUFikBi3LHkvK5aXbsrwegofPuEOMZO3Ochk=;
 b=Cjgr5zE/ekMSxcfLymosGcQafWzLZ0NHbDq/PikquZSA+jmyt1sVzHBXdj4Uxt984/
 3n6Z8YqEspqDNChCE3tqvknGDEAw8tE9wmKm2wFMPAhkYT1kFuasvaDLP32PtkRf/AZJ
 v1Yj5GqhSVYTerexh79/md+bIFqniST5sEI9Atz/heybWkpfGjqmd+Fxcb96oZ7MQZB5
 AP8/Ime+1lGvNBzFwlrqvrruVy8FOm6EZPHaQ8cFMwggHb5opKpuRsKX1aFtrBouUtud
 4GCjwxUdxTnr4LjZTN5FHjMCQo3+/A/TV3Gd1ecOVNJYX2oGPb13e9WuN5wmZVqEfTkq
 IzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523361; x=1789128161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WyOGs2boUFikBi3LHkvK5aXbsrwegofPuEOMZO3Ochk=;
 b=AS8GqvxRPjj/361pOgKZ06SUD8RG2cZ7+H9qp9IWvAZEuLLeBedw0nJIQntr7EE9+M
 Et1kCfTiIw8k8zlLrp2UtFghy/vpj75cBUnnjwPJ6PVWGfVILu2SxGrxenXPjB3N0Jyc
 0t7YjO9bzAkMdUsEE2w5UBav1AI+GLRVp3YcHiMxUVvc57Ng+QaG3tQO3YJdL4ihUB0D
 QLvA1NBKXRV6NfPel+rcV902uaKoTKVNAG2mJhI+IIh0f5AVsQeftdB2rLp5OEqR3yBI
 L4t8hwHu98Bu7lnCm6oVUU6e0DIKGrLbqXv9yDtJ//4U5uUdvgCDyNoplm8JEt+cXjus
 /DeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/P24/1JNjp4gfWB8x63JPSalzoS4AR2sh4WHC0q4jEzAdB+c+BuDeR9V7fPCd4r5z3pgRHuWMFnE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHEfNjBK4SFVXkQLWJLaGCJaZvQMX587lBxSOHbQ9vmqaZxLcg
 IpMohQ9R89b0Tkl+Vr7AdQxEbkAbXqUb+6jKKfi0FuW2h7YWK/rOoLQt
X-Gm-Gg: AYBFou1k50NEZ7sTebL4n2TdMn8iUSrHXVg/GbGQUbkwZDkWsnPrzLy3/P5vFXDREnm
 rHzZzy3ROd72Xbha7mmZXOZ+SYsJYilYNadIAtT4m0S2RHoCKn+5vHH06PEjrJ+xr3meIJD8JqJ
 uhJGZpSNXYEz4QmKyulxlTM5xky+k6pGHiicb85Q2QCwiu4eAKTit5ZJUa1BSq+snbNAwAb/13Q
 x/H5k6GXJ81UyN9Bxp7Xgpfd0uBjY4KYq5D/HUlNJ5q3TL2Hk/YIhowiJIbe+hR2qTJhBp0BFGl
 +vdwsRjDaLt378FDaSskeO082AxAsPDZxRFyBirSokPSxkFBviqioKLggKKOrKhlbm43tn0RRId
 aSjw9ND/RJYJCUytrZRlPIjdflDWeA75dEGYpBCSAwIsZ7WGuQAGUTPleIyVf2Q5RiC+UA8S6Oz
 V6kl8WNiDSwOod8lZpKvFSt5dpK55GEASb4gkHWZMzdEBbk9rIlTMCDiYy3/FRXlsdLf0bblv1t
 4oCgl32CUPVweM=
X-Received: by 2002:a05:6820:a284:10b0:6b7:2cab:be9a with SMTP id
 006d021491bc7-6b72cabc77amr2109673eaf.28.1788523360181; 
 Fri, 04 Sep 2026 05:02:40 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432435648esm7713194c88.5.2026.09.04.05.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:02:39 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/i915: fix repeated words in comments
Date: Fri,  4 Sep 2026 17:32:21 +0530
Message-ID: <20260904120225.15868-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120225.15868-1-hemanth.selam@gmail.com>
References: <20260904120225.15868-1-hemanth.selam@gmail.com>
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
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h | 2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c            | 2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c              | 2 +-
 drivers/gpu/drm/i915/i915_gem_evict.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index 0267c924634b..2c1f81d9c0d7 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -208,7 +208,7 @@ struct i915_gem_proto_context {
 	/** @legacy_rcs_sseu: Client-set SSEU parameters for the legacy RCS */
 	struct intel_sseu legacy_rcs_sseu;
 
-	/** @single_timeline: See See &i915_gem_context.syncobj */
+	/** @single_timeline: See &i915_gem_context.syncobj */
 	bool single_timeline;
 
 	/** @uses_protected_content: See &i915_gem_context.uses_protected_content */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
index 1c2764440323..c007faa54f2d 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -769,7 +769,7 @@ int intel_guc_resume(struct intel_guc *guc)
  * This is a wrapper to create an object for use with the GuC. In order to
  * use it inside the GuC, an object needs to be pinned lifetime, so we allocate
  * both some backing storage and a range inside the Global GTT. We must pin
- * it in the GGTT somewhere other than than [0, GUC ggtt_pin_bias) because that
+ * it in the GGTT somewhere other than [0, GUC ggtt_pin_bias) because that
  * range is reserved inside GuC.
  *
  * Return:	A i915_vma if successful, otherwise an ERR_PTR.
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 15fdd514ca83..3c3c9b695487 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -201,7 +201,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 			workload->ring_context_gpa);
 
 	/* only need to ensure this context is not pinned/unpinned during the
-	 * period from last submission to this this submission.
+	 * period from last submission to this submission.
 	 * Upon reaching this function, the currently submitted context is not
 	 * supposed to get unpinned. If a misbehaving guest driver ever does
 	 * this, it would corrupt itself.
diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c b/drivers/gpu/drm/i915/i915_gem_evict.c
index c02ebd6900ae..11855d9a1210 100644
--- a/drivers/gpu/drm/i915/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/i915_gem_evict.c
@@ -273,7 +273,7 @@ i915_gem_evict_something(struct i915_address_space *vm,
 	goto search_again;
 
 found:
-	/* drm_mm doesn't allow any other other operations while
+	/* drm_mm doesn't allow any other operations while
 	 * scanning, therefore store to-be-evicted objects on a
 	 * temporary list and take a reference for all before
 	 * calling unbind (which may remove the active reference
-- 
2.48.1

