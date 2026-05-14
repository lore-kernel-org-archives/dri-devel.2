Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D54CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B91510E3AD;
	Thu, 14 May 2026 22:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ExBOPbi0";
	dkim-atps=neutral
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7781610E3AD
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:46:12 +0000 (UTC)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso3595446a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798772; x=1779403572;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mvnx1syYDBetY3Se2t4QyUDEMb1h+VIeMK+wWLJEFEc=;
 b=Awd235mnvxON/fCn2IEzqBSmp1hDswGZA6vrdZ7DYzCArBkhpjiuPIsSlMbl4wE+u2
 2DgP09K7+O5q22of6E5JpuWKRfx+zDdR4Xd1DWdwSxZYiAGBiGET2YjolGWAKOwVJ7Ob
 lH7CX6NkEthUPNnB1J9onZGZLpKBh24VsIrcembzCYZU2M2rsBcXbaUgDmrpH4u0AwRC
 gI3L5QmQfwHN0SYGE8auroSFMcd0xDqT2ZRUeEWAbj9xse6us2m482xlgzVPOOhajEYO
 3VpwMpI8Wu3Fo5tYYYaLl8UGBzpEBNNDlHX4kDt285/JEusOztoLSxqSrcfp/Gn8X+vw
 sXFw==
X-Gm-Message-State: AOJu0YxTFbfFD2CiVfKjLQ5DciDZr1t/C6zhHpxMWb4bhO2UuZiJPQ1q
 H8nvK4dSpHxPx6sZqn+76QaWyUpVFmmt8KXP+otv+xOV+XhX/wjXWDWFTWhshOmGRkR96HejPIl
 SlYd930X0aDKJxxizaUpZFHp1Pc7gjnsprAMA6M5dkFhPqIACzZcEjUqspH8TWbPZPJ0bfHNlCa
 3NYypT350x+2dZVfcfh4jlxtoh57vWIc/O/5aAFukNTIgrdFjImt0djinDZaJ1yZryO+mwwoiAC
 rFQto8l1dESCZdZULbyGe064Ohm88Q=
X-Gm-Gg: Acq92OFmM0GU/Zj4Ezb+EWxH/UuuvlpdzQ6PEn+JeCEoS5g1qjuJUFzknCuHMeRfWBT
 adprFuHGwy/3VpIV8RzOKgkOFI/++qCxbD9kn5n5CPDuWWu+636zxAZy62DYj/4D8xOBLqYy0hK
 KjkUrLlztsf8cjx+eUiGpoTpnh5nmLfGaSsO87vGVqmVUq4BwTbBossmxXxFLjRhHhWHHgEvh7c
 uUXFk4xGWvkHCjfy6b7TPuzno2hXwRIlNkXuq7jNxjPzN4DlcGGbsrzjRPQiuaLhERpv7suY8v1
 VFLuZyH4AMJBK8GBt+11DkurviFameZeb7dyHYlUqbC3phOHEhTyNa/ymEB+QenODI5UCIl0VS1
 NCWhQDrn4hsA42fCb8xQO7ArEZ49z1D95MXCJqR+Vn6yTU1hAutPEH1MT2UGGvMncVOP3Oc9Nuv
 t9e7tUdDNxz6Y6dPQO2z/XR0MflVIOSMlHFfTcwmzB6vMggorBZgiP9PtSsiXmPA==
X-Received: by 2002:a05:6a20:158b:b0:3aa:f9cb:d43c with SMTP id
 adf61e73a8af0-3b22ed00276mr1204210637.34.1778798771647; 
 Thu, 14 May 2026 15:46:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c82bb11a844sm271763a12.6.2026.05.14.15.46.11
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:46:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so9200689eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798770; x=1779403570;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Mvnx1syYDBetY3Se2t4QyUDEMb1h+VIeMK+wWLJEFEc=;
 b=ExBOPbi0ewqypbQPgNzDBf01FngdjPX0ND7WbWUB6NTQfgPsp66po730mFwJ65PdsJ
 o4OrKQV2lWecl+qIWBmfL6GH5Efa5Jc7m35TYbT4fQcC7QXxPM4g+hlWTYtrSfTBSt/s
 qpJPBUvXp8x/ZT5xMWInQ3ECaoffa2NhIqUGo=
X-Received: by 2002:a05:7022:128c:b0:128:d20a:2f40 with SMTP id
 a92af1059eb24-1350430e545mr597864c88.8.1778798769728; 
 Thu, 14 May 2026 15:46:09 -0700 (PDT)
X-Received: by 2002:a05:7022:128c:b0:128:d20a:2f40 with SMTP id
 a92af1059eb24-1350430e545mr597855c88.8.1778798769021; 
 Thu, 14 May 2026 15:46:09 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:46:08 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 4/5] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Thu, 14 May 2026 15:48:18 -0700
Message-ID: <20260514224819.3631763-5-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
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

