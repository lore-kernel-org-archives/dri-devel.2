Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE9C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F160010F162;
	Fri, 14 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QD6wAgTm";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BD710E0AE
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:26:19 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ccf2360620so20447725ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786616779; x=1787221579; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CheetA0FCd2QHli7re2NKbzT3knYEe7Te2BK6UHPkW8=;
 b=QD6wAgTmAZu90vE1N0Ne6sNEmzBMVw4jvWx9dqJhaM6oo10KG8ysPRiIDZboMmq5I7
 T4Of19+vsmAFFxCFEh8Ikrn5RDjNalsYSjQvY/IsRuj3t1OdqUXrWv541J+STT9btd/I
 EpGEh5JQ3R+W3Ea9gw2d0G5NwW28Yxt6vmRl7R5js6lz4miHgs7PiVIQ8EbfShUbnYPY
 VF8pgBoajCLnOguTGifqqYTg5hW8OKulApVvmeJ+OAts9rSITYGti+HipGrcs/QMXb4K
 hwECS26OwLq9P549fyO6v5cFPiMEHRslJekTcJ3faQKLFoUyn8zcHkZBdl8vZki92EOA
 wpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786616779; x=1787221579;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CheetA0FCd2QHli7re2NKbzT3knYEe7Te2BK6UHPkW8=;
 b=SFk2xHLY5P7damGiYJReRgF3u2itkBQ7TaO6kAlobmSV4zry5suU11wEsoI3np9xe0
 mGCp+/zbSkNwB+cw5xBtO8c1/+w8GMYHU22s2Yb3vWcbYBIw9lxeD02Ypxw/yafhymjM
 aZnrwFtV2Hwa2Yh9/3H8scuQPwXgZA2Pkf7PC/87njN3aphU1iDr6nsgTDYhJH142WGf
 cRwR8C14H5pfTfMGEUrqxbFZjjKRn7QBEx+XDdcpi9PUV/nIoXbo+p8EkASKPwQ54Ucl
 Cn1Cj0TKRI4CoNUpFEugvKmiU0hUrpj/tdEGDGX9VoeLqdrAPTvnsUuC+Q6q4LuylqDt
 bS+Q==
X-Gm-Message-State: AOJu0YxP5QWI7YKYf9z/kFihf/1YA8yZiTuuxmDkfVYjmYqGO/5hOzE2
 yJA2rhDdozqZcZNgRgjUbtdDwRDvHsUJJslgSng9rtFdjQ2gfEEr9iQ5
X-Gm-Gg: AR+sD121hc9tCymORKcUqGR3dfPAaAQMn/9/deQer8gcDpsYk86Avkhg7RNQpwE74If
 //BOINAd9iNwqP8BZ8OsKiIKoXGc86UMTQnxZeEJTzGx4qGgr5a3tncZi4mB2Zyzd3ZOHtsPllQ
 nDLDQnu8HHwRpmMHY+aJ/3qbVP9nN5JqLSoBtmDNevWZn8zY5IXRNs5UxG6+FE5YRAmodIv61pp
 MsChSXbm5Z/bvd36S0q+hTuoKn3JfO3zZ7wDj7esajK4K3OE55P8KcadvSt0r7ckJ5iRkG5aR7c
 UUOUf9Y/eE5z9cB2mtQ0sgCNJ8OGjI8j8SxRctoxJZTDG/ipqB0VjCk4p3cYx9rTjuvNXM+etIy
 WXFutkOL1HOI7S9aHegJ917YAOAj1/kuI4Hs140/mgVJMklc3PWlHEWKY11rgW5dS+p4yR7h/eW
 UYliGV46IlwT4v2XPb7wrO5LkrbVqHw3I8wt5TfxZl8/j09Xhy6qV/KJs0TnE=
X-Received: by 2002:a17:903:4b28:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d37e856ffcmr53648995ad.13.1786616778614; 
 Thu, 13 Aug 2026 03:26:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c49bd29sm7220095ad.64.2026.08.13.03.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:26:18 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 18:24:26 +0800
Subject: [PATCH] drm/nouveau: disable VM_BIND once a legacy BO VMA is created
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-gem-uvmm-vma-fix-v1-1-4f14d427f2c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFmbfWoC/yXMSwqEMBBF0a1IjS2IX9StiIMkllpCoiQmNIh77
 3Q7PA/evcGTY/IwZDc4iuz5sAlFnoHepF0JeU6GUpSt6IoK7REiyYArGQzRGIxG4sIf7GaxKKn
 rplY9pPvpKM3/9Di99kHtpK9fD57nC8WTXNF8AAAA
X-Change-ID: 20260813-nouveau-gem-uvmm-vma-fix-8d0fbac454b9
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786616773; l=2346;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=yrf9imgPzO8wlFHThXUTZ35rA60+QDuQrt+uQxh0u+M=;
 b=8up90CkB3EcBEnF95pzAf697k2mBINT6B819yhVrWyqIK8onVKU51wq9dVqfe1WponwGildgE
 n1Cbg8WGmwFBxQyZiMo/7nsnzQyn6HS1V+ThAo1prd3d45OWyzzzIbM
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

nouveau_gem_object_open() creates a legacy per-client VMA when the client
has not initialised VM_BIND (!nouveau_cli_uvmm()), but
nouveau_gem_object_close() only tears it down while the client is still not
a VM_BIND client ("if (nouveau_cli_uvmm(cli)) return;").

nouveau_gem_ioctl_new() calls nouveau_cli_disable_uvmm_noinit() to stop a
client mixing the legacy and VM_BIND uAPIs, but the prime-import and flink
GEM_OPEN paths that also run nouveau_gem_object_open() do not. A client can
thus open an object (creating a legacy VMA), call NOUVEAU_VM_INIT, then
close the handle: close() now returns early and leaks the VMA. If the BO is
flink-shared it outlives the client's freed vmm, and the next migration
walks nvbo->vma_list in nouveau_bo_move_ntfy() and dereferences the stale
vma->vmm -- a use-after-free.

Disable VM_BIND in nouveau_gem_object_open() as nouveau_gem_ioctl_new()
does; the helper is a no-op once VM_BIND is initialised, so VM_BIND-first
clients are unaffected.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..e33f76b5a239 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -108,6 +108,14 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
 		return 0;
 
+	/*
+	 * Opening the object binds it through the legacy per-VMA path below.
+	 * Disable VM_BIND for this client, as nouveau_gem_ioctl_new() does, so
+	 * a later NOUVEAU_VM_INIT cannot switch the client to uvmm and leave
+	 * nouveau_gem_object_close() unable to tear this VMA down.
+	 */
+	nouveau_cli_disable_uvmm_noinit(cli);
+
 	if (nvbo->no_share && uvmm &&
 	    drm_gpuvm_resv(&uvmm->base) != nvbo->bo.base.resv)
 		return -EPERM;

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-gem-uvmm-vma-fix-8d0fbac454b9

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

