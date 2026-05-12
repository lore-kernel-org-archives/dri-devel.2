Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB75CD37BE
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE3310E949;
	Tue, 12 May 2026 00:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="btjn3c19";
	dkim-atps=neutral
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF49C10E949
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:25:56 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so8226485ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545556; x=1779150356;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mvnx1syYDBetY3Se2t4QyUDEMb1h+VIeMK+wWLJEFEc=;
 b=OEcT/v0mn7djBpZLpgj8Sdqfh+aeUs8nbBCuETKP1c7Quk99pg1U7BqATXEG1YPIlF
 Za3TvP9AqQzfCev9lmqqLlxVPit3klbd4Dwr/XRbR4vSZGug1rmn7Oskf21U98JWmsr5
 6KBSO4oOfmgywD65Li+Q85F5etCcE38uTo1/ySHzehXnNyY6cC3pf7Xn8609rNVau3oE
 jAoJiDoA3RuEUuhOZxH1RH1w07ILt9rWUtrovL64LBn5q0o/ug0QVz9pSFMmqDyAUF98
 yfPBL62OuEzECswNwVhHaVmuNRc63NaGsJXI6wDqHPcS97oDu/MOMjCTjWx7s/yurG7g
 2Xag==
X-Gm-Message-State: AOJu0YyxqsAovE3ZIRFqlfMM2zfJR3pF2U+fUd6ENpe1goiPOP6RclvU
 daYe3KlEexzCEWx77Ou8z2g579ZxK+Bu60TZAccWgbJigERDTy67qwSWRxlMH0gJu54dY8sFlCT
 5EWLDpQ4GUXJrwNLK9IzNBjKCXrLwCrSsJTTIKplBTIvsbDpWHXpupCu2iKdKqRpr2J25YY+kxm
 FPRO3FufslJ35Ka+vviRzynsySnsH0cv2/X51TacsSFl1RD02WhqDhX076Ge4+tVif32NoPeU0f
 pVKqUr8cUVWQGgI86mcNefNvhFS
X-Gm-Gg: Acq92OFffLJ1NsT4F3pSyGNJbbpSMljiFunzTPNZ3IwnfN3fkTAZqP19IHUnh0OpszM
 rEUBgGvlf5F4B/X8BWVK2+t4/cOG5isb7+Cs79iUqdrNScTf4wkKgFjfFi5/ukXoVJJOrXCQHTa
 bCEl2ytETzmrIkccDsfBIpSLYqFBAbkd3oxYXvoJD0woZ9xC0Hs1mrN+mkf+Q4ejA2dkEdtmyVN
 j5OEsfwT4+v4XOaVK+Khk+64W0f4XIeqcNekLO1lMx2QiuhBFWjtbRHZPD7oRN/ZXZeFcwQ6kIJ
 T+Sr0EXCnSTZTe6vi8Omgl0/QiwqyHKu1eJHAu4FcAaEm6WX19FRoG0xWAilyHdLbhih85YWoJp
 LrwQajVqeaPvbGim5KtME80ckOHV/pd8zJ+5upxyc5/oVhuFTfB+yO4vq9I3Wy5begrH9m9lk2S
 BqDv3XrINL9YvLE4A1booduGUYPwcGWSC2q2V9PrDrtbuICZVX6Nlb65aYfOstWQ==
X-Received: by 2002:a17:902:ea0c:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2bcfd14adfamr13830245ad.13.1778545556053; 
 Mon, 11 May 2026 17:25:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2baf1ef1474sm9023405ad.52.2026.05.11.17.25.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:25:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dc1c0b7ccso5531786c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545554; x=1779150354;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Mvnx1syYDBetY3Se2t4QyUDEMb1h+VIeMK+wWLJEFEc=;
 b=btjn3c19w77Iukt5pt6s+H6utZFp8zPCtzZ3civcAsAXNYtuDjA8wgLaLjBbFlw6u8
 wKnYgiMfqfRg3qii/2hhyxWDA+9Iss2AHBEzMZen+mcw1GCz7A08ClPO03hEn2pUHUlQ
 bw6jlch0zj9zq/sEZkaJnSM4zgQVT+fEcvElE=
X-Received: by 2002:a05:7022:fd08:b0:119:e569:f86d with SMTP id
 a92af1059eb24-1333b1b5cb2mr1081772c88.10.1778545554134; 
 Mon, 11 May 2026 17:25:54 -0700 (PDT)
X-Received: by 2002:a05:7022:fd08:b0:119:e569:f86d with SMTP id
 a92af1059eb24-1333b1b5cb2mr1081756c88.10.1778545553511; 
 Mon, 11 May 2026 17:25:53 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:53 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 4/5] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Mon, 11 May 2026 17:27:51 -0700
Message-ID: <20260512002752.2826685-5-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
References: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Preserve a ttm reference during dumb buffer creation. This keeps the dumb
buffer valid for framebuffer usage and fixes all igt tests that use dumb
buffers.
Also fix ttm_prime_fd_to_handle(), which in the error case was leaking a
dma_buf reference. During vmw_prime_fd_to_handle() this function
is expected to fail for dumb buffers since the fd is for a gem object,
the dma_buf would in turn hold a reference to the dumb buffer gem object
and cause a memory leak.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c     | 7 +++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..f9042bafdc93 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -547,14 +547,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..256e7b89daea 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2328,11 +2328,12 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
 						struct vmw_user_surface, srf);
 	usurf->prime.base.refcount_release = NULL;
+
 err:
 	if (res)
 		vmw_resource_unreference(&res);
-
-	ttm_ref_object_base_unref(tfile, arg.rep.handle);
+	if (ret)
+		ttm_ref_object_base_unref(tfile, arg.rep.handle);
 
 	return ret;
 }
-- 
2.54.0

