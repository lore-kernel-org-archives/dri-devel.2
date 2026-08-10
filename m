Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE12C5B570
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1EA10E921;
	Mon, 10 Aug 2026 16:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I76pR+Gt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E176B10E0F8;
 Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2420360052;
 Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA463C19425;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786378667;
 bh=Q+qdx6oRKdXlA4l6g9eyHfPrIoqSy/Lo6Jb4tRgnhO0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=I76pR+GtsYmIxx7++WdnINkB0HjzufkoAYoEPtGL5tIiBsXHrK8EzdHKnKDfyK1VX
 6EIoWO/5fn7z38/9XY/mAQ2/Dgjcsei8O/dQLFp3grFiU+TwIyKnCiOEvItOUG/KCO
 L2kIeCTlU51WKgL6HLUETgNJHxjRUSDqmtMgshlZFjQ4hVlDjaa7xAPYXqskgrCAAe
 +MQa+fRZYP8akGvJn/FrT2iLwdnlhKPOeKQSlvAdUBfhc7KgSlOS3e/j8bBy7CGKW9
 LFzaP9qUrK/zXTlAsxUzNtVHMj2ern3W2bS0akAC/c2Vh1fjaHM/2JvxOPIRTyP1mQ
 uC14XmIEeiU1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AB4E7C5AD55;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:10 +0800
Subject: [PATCH 1/5] drm/amdgpu: free prt_va on the open_kms error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-1-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=q+sGDSGgjTe169BOxCoszY1QMkkcItYVcawWxv7vRl8=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfS21uv6tOUDx47X7r4QuP/FZ8ClS7bTFpRZEoX
 +RZK0cG9yMdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBGWTob/xa1RtyoWnp8X
 01Y5487D+wGaU7rzbSqCD6xP/M5yOVx8FsN/zx72XsaG69aXLBa+bud7evlC06pi4xcHHzEwysW
 EbN3DCAAXk07f
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_driver_open_kms() creates fpriv->prt_va with amdgpu_vm_bo_add()
before mapping the CSA and the seq64 buffer. If either mapping fails
the function jumps to error_vm, which only calls amdgpu_vm_fini() and
then frees fpriv. amdgpu_vm_fini() releases the amdgpu_bo_va_mapping
objects reachable from vm->freed and the vm->va rbtree, but it never
frees a struct amdgpu_bo_va, so the bo_va allocated for prt_va and the
dma_fence stub reference it holds are both lost.

The success path does get this right: amdgpu_driver_postclose_kms()
reserves the root PD and calls amdgpu_vm_bo_del(adev, fpriv->prt_va)
before amdgpu_vm_fini(). Only the open() unwind is missing it.

Drop the bo_va on the error path as well, reserving the root PD as
amdgpu_vm_bo_del() requires.

Fixes: b85891bd6d1b ("drm/amdgpu: IOCTL interface for PRT support v4")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 242c48e85912..7ef1c1dcc207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1553,6 +1553,11 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
+	if (fpriv->prt_va &&
+	    !WARN_ON(amdgpu_bo_reserve(fpriv->vm.root.bo, true))) {
+		amdgpu_vm_bo_del(adev, fpriv->prt_va);
+		amdgpu_bo_unreserve(fpriv->vm.root.bo);
+	}
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 error_pasid:

-- 
2.51.2


