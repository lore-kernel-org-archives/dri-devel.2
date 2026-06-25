Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B485DCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F37110F4AF;
	Fri, 26 Jun 2026 07:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6VnDwvP";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFCB10F2C7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:54:05 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7ff05e5d009so20348487b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782395645; x=1783000445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9aAmr8/iGyamwXOE0x+7nRWzrQLtbEEZ6iUw+t3oT4=;
 b=F6VnDwvPLtkffmEFUTsKUCZA2oS4Mg0M8w8iCDsiJnRW/L9dQEG4DZoCQ2cv2CXZNU
 O0JQokZntyCNM948YsN9kQ+JxZPTe1FtavegXjcIkNctB1/OuBUz5VDFXoJwWzxQO+py
 xauVb4R8ZzARMG4XjARNx96nZVYW5X2ayC+AQa3BAiwXpWf6bxF6KieGrh35aeSIvNTZ
 7pxjHqVO181wqHxaGwB3aSMLL4kIt+fMGsuJHTqBbKxVXaPBab7+0h4F0hqCT+6z7ggz
 ZAL+6MF7BSgXBnZW6AyUEz0Rw2F6Kuqy3x096qp8THLBlLG5EYm4xBsEMn2DsLUm4CQw
 u/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782395645; x=1783000445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m9aAmr8/iGyamwXOE0x+7nRWzrQLtbEEZ6iUw+t3oT4=;
 b=pJntxIwKXEWH58ofHh4PJcfDt1gohhgQQkdPhLIVzQpaO5mLiKAx0Q6j50ZhiHg2fU
 fLeOU9PZbBjXibFkFVvltugfzs9JDmnxXTo9kVlJs17UiOdiHy/mua5oS5rEzusRKwHm
 eH8WJM/dTc7cB9c0hLjX1qEFpGkWYyci8xxlW2Fh901RpnE5zQSw9dlrxvot4M723rZE
 eW3yTi11A6zMLrS6jtpLXhAfWhSVjymNDfV2EHejxgG8VJJ+wsWViCCJHr3I/JCoMloe
 w758dCH5pK3kEbAG9rVxHPACnsCD9tUyyKB9pamzndJc5kP8v9Co148xo5ZPrSNJSij3
 fy5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYTBANtQRHLZwZBsSDMgUVRNc3mfBO+igm5/nOBKKYrVllEILyphYhrVPvdhqL2rV0BMCSiokFXF0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1foDysNKx/FnEs6S+11TBtMUU1nPGn0C5tev7z/LPYXUutHu8
 evf9/3F9DCOidhWKCgcuNry/d/1oGQ18t+x5bZZWWKhsjPrCnocuTjrQ
X-Gm-Gg: AfdE7ck+MLwf2m+LVaP4qbWyXgVH8BdwDfa+1kO6GBLxE2LBCprYEQSy9v7BQy0awkD
 xJmqh9r4uFc/TCP4j5z7r6i6zon1p/b7gkeNuCmPXo3g72w1PeKltMBWgODPZ87S2jgTC3apkYQ
 AIIfibvPaXTZ0a0YPyd5cftm8KRnSZG1ZDZ4gWwp+HF5AbtLrcqOdLxmA9cxOEAshPBVhxmYWNY
 LkTg1HZbcMq6ckVAkfvX/c1oVEbc17C0dqP1tN3Fjst3FC3iwaFk2uGhiAd9VH1swBJ4YyOS2+O
 jTQJ5MuTMQbHCdmY8St8qbPiE/yiy42WOUEpiasYoGAzHCEOOB+qdt2j6Idsvi26oHiPTYqJjW7
 C9vPU2F9bkG+2OCIl8FeVoE3fmDV0/rYZ3pWVsgn+/7nAJ7WYcm6BChUzCSgPkqX6RKEPetTULX
 rvd0A3t0MBN0moHTKPervbyr6jpbaIzwK7hMgI
X-Received: by 2002:a05:690c:6e02:b0:7f8:7e31:28ab with SMTP id
 00721157ae682-80a6b898733mr25315367b3.51.1782395644452; 
 Thu, 25 Jun 2026 06:54:04 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025f8da5fbsm72143407b3.30.2026.06.25.06.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:54:04 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
Date: Thu, 25 Jun 2026 15:53:41 +0200
Message-ID: <20260625135341.1159-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624172029.2508-1-alhouseenyousef@gmail.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
handle and then locks the object and VM before resolving the BO-VA. The
GEM object reference keeps the BO alive, but it does not keep the
per-file handle open.

If a racing close drops the last handle reference in that window,
amdgpu_gem_object_close() can remove the BO-VA before
amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
unconditionally.

Return -EINVAL if the BO is no longer associated with this VM.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Describe the handle-close race instead of an initially unmapped BO.
- Return -EINVAL instead of -ENOENT.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 212c14d99..6f5b6f4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_vm_entry *vm_entries;
 		struct amdgpu_bo_va_mapping *mapping;
 		int num_mappings = 0;
+
+		if (!bo_va) {
+			r = -EINVAL;
+			goto out_exec;
+		}
+
 		/*
 		 * num_entries is set as an input to the size of the user-allocated array of
 		 * drm_amdgpu_gem_vm_entry stored at args->value.
-- 
2.54.0
