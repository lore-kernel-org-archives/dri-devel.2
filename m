Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D2C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C08710F3E4;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkTkyH85";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2BC10E698
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:23:26 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc6ae3e7f1so9461895ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783578205; x=1784183005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fU1uqDg4qTxMWuauQeSDTacxZRC0Mr8WsWfk9k2wgi4=;
 b=dkTkyH85Rq0SJmpAS3jldJTkckzyPbq2zY7dqohLuDZ0Ec2kVWq0UFNSK1QMi9aSN8
 8KZMbjO4E0tglO6kqTnJ+Zxwr2U+rdivo7OglJSop4lTSQNscD48AME/jIOwE6Ea1eTD
 EnFhbZSNFTHL2DPFRLjMPzWqmR5304xtqjsApLA2qX+nf0HAMGP/bMFASxOtYirlTRkG
 NL/BrM0lmC7M1L2cVP+SvQQoFfO50TMhgCPmymf+Mxhb4/tfEErFDuDjvMlPd/kNCVHt
 tkal+MzGRs/9dSy/lVAY5BvfwxF3P/KTACG3Z2cGwpMOUQPjpvaH5BjhFOUEtol1hIo7
 dOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783578205; x=1784183005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fU1uqDg4qTxMWuauQeSDTacxZRC0Mr8WsWfk9k2wgi4=;
 b=MNXIiK9IUz0Oulft5cua1gCex/Ke7ainlWO09Im0L8wHCdBCFdZhkUoi+99IorRc8d
 ln9Hmd0NlCWhFWzHYq0HGAMxpmPeRDKLToZFFHPShtUPzaFde9HqlYSGTYlUUbARkQ4E
 Z60l1UliIvXbSfJHUaQmyZQ2pGLfjp2LThoFmi1qHhIsyhWiLPSPgqoqVfKD3xZkrhE3
 896jhFBdxzbFPgWEWfZ/6NU+Rljna4DrCEC3usesIhJpQKAT3teAccXapKlaiklcub/W
 8oEnDyUkIcM7nmNncIKghT19g1odkVDnI5gKgxFzRw/szR6UIBjIEXDyx/1p15K+0p+x
 0CEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSOT4Nn4dQRXpJkX7u/jpWfceR+8YB4TE3r53CLpvcGJTuDkPX8cTKllUYsTKM/SJyOGk0BqEqDBM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxinGs+uyV7mykMIrdJWSotYLKHvJYKoaKBAZha35Z4CrV85Lry
 aVQdbW1ycz81gM6iJfSCJrCb3RoI8DOmiMNLjNbKUq1v/P8W4d0UQWKLICnM+FdrpcU=
X-Gm-Gg: AfdE7cnciQukJnh/82Jeolbaz0wzqDyVEZPcR60bAySTIl7XtwPbul3e3xuzVaTEZ1m
 4dY9OvKh9dVNc00WcijZYZgTmZOzIqiu6KN5AAUeyBJGTygLu3xL8ky5O/6uZcJH4Qp7m3GRvK8
 Ljzb6UYCqQJiFqo2doO4sW+VUx2SZC/rGLowx4HGHarRlWtimio6JVtgNO7hcE1okY2fd8tDcFd
 ipUzMb1qzG22+YFL/CM+firpIQ4eVGhzwEwml6/CWGdukPYchjapujiueqjhv8EHaH2bf762p1n
 +qS1m5KzdPPIjPONc0YoR3kBjEjpNNfBTEXKVp9to8lyEuICmHlmgoLHeMKe0u7Ko6lwae2sBbN
 H6PD2s57SyEERleDtQh67Kpkk9huCxHPzWdbI0KvHXx2kP7lgK3fhATxeKyvLnxHwQmd9sxYpdf
 NKGCDbaRCJdoi4NZTRmGFUykgGtsHq/rsJEURXe1YJre0=
X-Received: by 2002:a17:903:298f:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2ccea3485b7mr72436645ad.5.1783578205434; 
 Wed, 08 Jul 2026 23:23:25 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm38501885ad.24.2026.07.08.23.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:23:24 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: karolherbst@gmail.com, lyude@redhat.com, danilo.krummrich@ffwll.ch,
 airlied@gmail.com, simona@ffwll.ch
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/nouveau/gsp: Preserve BAR2 flush mapping on kmap failure
Date: Thu,  9 Jul 2026 14:23:18 +0800
Message-ID: <20260709062318.4169329-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

r535_bar_bar2_init() warns if the FB zero object cannot be wrapped or
mapped, but then continues and maps bar->flushFBZero through nvkm_kmap().

If the object was not created, nvkm_kmap() dereferences NULL. If
nvkm_kmap() returns NULL, assigning the result to bar->flushBAR2 clears
the existing physical-mode flush mapping and later r535_bar_flush() can
dereference NULL after the generic BAR2 init wrapper marks BAR2 active.

Keep the physical-mode flush mapping unless the BAR2 flush mapping was
successfully acquired. In fini, call nvkm_done() only for an acquired
BAR2 flush mapping, because nvkm_done() is not NULL-safe.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 5bf0257136a2 ("drm/nouveau/mmu/r535: initial support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
index fae08ac3b18c7..eb3a7ddfa3355 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
@@ -71,8 +71,9 @@ r535_bar_bar2_fini(struct nvkm_bar *bar)
 	struct nvkm_vmm *vmm = gf100_bar(bar)->bar[0].vmm;
 	struct nvkm_gsp *gsp = bar->subdev.device->gsp;
 
+	if (bar->flushFBZero && bar->flushBAR2 != bar->flushBAR2PhysMode)
+		nvkm_done(bar->flushFBZero);
 	bar->flushBAR2 = bar->flushBAR2PhysMode;
-	nvkm_done(bar->flushFBZero);
 
 	WARN_ON(r535_bar_bar2_update_pde(gsp, vmm->func->page[0].shift, 0));
 }
@@ -86,6 +87,7 @@ r535_bar_bar2_init(struct nvkm_bar *bar)
 	struct nvkm_memory *pdb = vmm->pd->pt[0]->memory;
 	u32 pdb_offset = vmm->pd->pt[0]->base;
 	u32 pdbe_lo, pdbe_hi;
+	void __iomem *flush;
 	u64 pdbe;
 
 	nvkm_kmap(pdb);
@@ -106,12 +108,16 @@ r535_bar_bar2_init(struct nvkm_bar *bar)
 			ret = nvkm_memory_kmap(fbZero, &bar->flushFBZero);
 			nvkm_memory_unref(&fbZero);
 		}
-		WARN_ON(ret);
+		if (WARN_ON(ret))
+			return;
 	}
 
+	flush = nvkm_kmap(bar->flushFBZero);
+	if (WARN_ON(!flush))
+		return;
+
+	bar->flushBAR2 = flush;
 	bar->bar2 = true;
-	bar->flushBAR2 = nvkm_kmap(bar->flushFBZero);
-	WARN_ON(!bar->flushBAR2);
 }
 
 static void
-- 
2.51.0

