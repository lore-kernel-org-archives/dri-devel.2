Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7160A2610
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pPRcm+tu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A7D11266F;
	Thu, 19 Nov 2026 17:07:21 +0000 (UTC)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBC411266A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:07:11 +0000 (UTC)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso5084118c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108031; x=1795712831;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+O5fTVKRKtM/LnTlOc2xLfq4r025GdIDtJ3B9d4nmVw=;
 b=pPRcm+tuhAlTamXm8vjTJftrPdKzNnA2MUElb38VJrTA2/zaGxkzfGZzYPFZd6iCnC
 byJCxvl5Jnp7XwIdwBaM/BckBHaTtAwNJgmLctVGwH1aG0ZKN+jCoHaorMH7RZqDSM/d
 nbBzUcQNL2i7uzMppyreee4+MIgHQQC8cWdaLnRj9rPbVW5jocP83T/0Bo3EHdp915lc
 VuTCXx25R4+c3L2kDJeL/SlvEmpIZE0XQVn5w+jkaCZYdoLKDwCjO8NaSZVhQMwYlWsf
 1CNUwOCQRBZNGPIYFd+e1viu96S0I0vz5CJDax/BrjHVmIWNsBPpkWlmqpXV/gxrZznB
 BbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108031; x=1795712831;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+O5fTVKRKtM/LnTlOc2xLfq4r025GdIDtJ3B9d4nmVw=;
 b=qvvnn/AEhFirTBJn9b8Sr9G30ceUyo6yXcRJPrJdVytQiY2pc3v2qEZocTUsrzmTc/
 rE938mpJc+ZIUk9jQGPJP6t81d3DzfNSGpjz0h9xERdg8EllOPIiIJb/G3GHOuLIVWJJ
 /VGQK7dFIeg7cn8ATV02t3KVhcMf8nYTWRzVRaU6qGJP6jXmACDUX5MaQ5HLLRzxUhq4
 2k3RMaV53b1JvrssWrRJDWBIFOcT+gIEcNi6/J3QYS7jNCKmzQ8yKmtPSEanRRrFUxgk
 GfHXefdHQdW64O8RPtP54/2TY++bhbFaB9hB9PTyux6dRGGhx7XUjeblFt+xKEIMkEuN
 eBcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHYNTj5GgF9qXfuudxCNInk1/vNIxapRp50kqy1JjAILDXH0qVYbAfnJ9tre3T8dbH+IG+if1oD1D0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cpzsZtW0p4xAE8b4FBeHD5QQ+MzipwekuBJtu4muFeVCDEbTo
 d2tolzi0/epAqWXiSB6fb8K+gsjZWnobBzRCp3os6jpOkCAXqVzBWtdFuA9LUA6amI26THNOIME
 y63lcl2w7fQ==
X-Received: from dlai6.prod.google.com ([2002:a05:701b:2706:b0:1b2:375c:814])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea56:20b0:149:1feb:6d9d
 with SMTP id a92af1059eb24-1b55689e6femr287285c88.19.1795108030586; Thu, 19
 Nov 2026 09:07:10 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:04 -0800
In-Reply-To: <cover.1795106955.git.irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1795106955.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <e8d983aa6f81be52ea1bb9afc9c0f47d4632c1db.1795106955.git.irogers@google.com>
Subject: [PATCH 1/2] drm/amdgpu: initialize r in amdgpu_vm_bo_update()
From: Ian Rogers <irogers@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit bc566781845b ("drm/amdgpu: stop syncing PRT map operations") added
an 'else if (!bo)' branch in amdgpu_vm_bo_update() that does not assign
'r'. Because fpriv->prt_va has bo == NULL and is updated on every command
submission, userqueue validation, and KFD VM restore, calling
amdgpu_vm_bo_update(adev, fpriv->prt_va, false) when bo_va->invalids is
empty skips the mapping loop and returns uninitialized stack variable 'r'.

Initialize 'r' to 0.

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.

Fixes: bc566781845b ("drm/amdgpu: stop syncing PRT map operations")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 82b9b2d5d0cf..091589b2c524 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1303,7 +1303,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	uint64_t vram_base;
 	uint64_t flags;
 	bool uncached;
-	int r;
+	int r = 0;
 
 	amdgpu_sync_create(&sync);
 	if (clear) {
-- 
2.56.1.708.g77570a6a1d-goog

