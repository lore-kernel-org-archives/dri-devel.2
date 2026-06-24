Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE42CDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B32110E1A4;
	Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqgqqGv7";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648FF10F014
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:57:52 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso1060865f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782327471; x=1782932271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3VY6GA4WYKqb1EhYh1Yd6EboXP9XWbFpfvj/dUpSvhc=;
 b=bqgqqGv7vzJAh+xC8zFt4vC15XPUf1rT2vNpvgVQ1pOpgb3mFf5satMrV0LUKOLX1n
 jvyrn/aVnl04rSBUfR3awUQ7d+4wO9dGK88kam41DOq72hiYVeq69OSUGuS2aVFQorH4
 Wukd1Q8CscLHK8uoIusveyvYwyvPWHs5UsriPlQTU2cB6roqJtR9KiLn9T5KpbhPLWh+
 ryachlcBPpnpRTuQTwIEPwqYbxIzJlLeWS1Ol/EzN5vMDUMTtwBX8GGLDo75HycI1E9i
 kaD+hIdEDWTdtZ/J3jB6PSlrYtdYwLhogT3I4FIbHTxMXz3DJZ4lW8s7xMdSPhHaAY/9
 Ycyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782327471; x=1782932271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VY6GA4WYKqb1EhYh1Yd6EboXP9XWbFpfvj/dUpSvhc=;
 b=jyrGZEAr7J2GDWFQKyw1H14H9w21brejyoADqOIoGa2aOT+5vvTomMeMJH5700gBPW
 gSiM84Q0K5TkWs6NOr4mFXHS+3IIFKtbikL2bc63od/W3Z/QZ98yFjWi21U0JgkXORC1
 JHQTUdemjZH7ZHcBWr8UppunRU4qB5EmTmNOdaixH3dsXSxgwo96aKdUk/Kv9URJZsvd
 yJx6P6bgFEZA0hfvWBuMrv9ZhheRZrnuJtwkC9mV2AKQ+0gHcMDEBHWNDfM86WENjPz3
 febT+K/Tc8BMsmDM2C5F9+nPPfovLuExCcM4Tp35kGv2Vwm7put6O0JXya2uyqDk7VRD
 UNYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9jpJln1xjntfbzgJsZpj3xynqgTvF+wYVsR5xvWCfDBppjeh60YOz0/F536TYXWbNWpRi+HKUOyY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4Szoj4/Vme7qzGdUiMj15E6Txf+bGVIO2KZIB3uP+/JuvhpsK
 zF5Mv2U72h1vvBec+8mb0Ascwe/m0ltUUR6MSF+J5QH2ywElVfQRJFOz
X-Gm-Gg: AfdE7cl8TXXXScTscgQCThJeQEDJwCdDyXJY0MimR8K9erFH8ZsaclKrp5CLHqcrL2T
 zaPE8FYR8dpo+GL2j1SGhV7T9OCUFNw5XyQMJMDuYoCtaLEZCKgrW/J+j45srvD6gJ3QHO98KKU
 f2Vh/4YpqDP7o26Ls3yt1ldA86kNXnEKRjFQRE1mUQ4vrHjSmgqoKrePYCM1NQqxBXASbn6+0BI
 f9RKjxk4dTgEY4gUFf5lvSlUVvhtUn7/tcWbzNr5ZA5cmBvbB4EAMlWzGSFre/OByX1xPqASS1n
 O2IIKFKp3HWXFc4CiWyMIy6CHYQAZuaLeEvtSXhkdI+gELtG565GUNf3NtCubSLwVVdJkOlayHZ
 GZLcQqNP904CN23AeV+O7TYxnvoMjuRQmB0y/ui3QUzLocBIjsyceVPk8H+egLnq64Ro36KdEvp
 ejao4+JVidzVLS2eUJwLTQUoBoMg==
X-Received: by 2002:a05:6000:41fb:b0:46a:6474:83a8 with SMTP id
 ffacd0b85a97d-46c0c05ce9emr6829286f8f.40.1782327470602; 
 Wed, 24 Jun 2026 11:57:50 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm8063181f8f.32.2026.06.24.11.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 11:57:49 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: keep invoke copyout state private
Date: Wed, 24 Jun 2026 20:57:33 +0200
Message-ID: <20260624185733.1885-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

fastrpc_put_args() copies output buffers from the DSP-shared metadata
area using the pointer and length stored in rpra[]. The DSP can update
that coherent buffer before the CPU reads it back.

Keep the kernel-owned inline buffer address and original userspace
length in the invoke context, and use that state for output copies. This
prevents remote updates to the metadata from steering kernel reads or
expanding the copyout length.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8dd8315d5..c91d5da42 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -247,6 +247,7 @@ struct fastrpc_invoke_ctx {
 	struct fastrpc_map **maps;
 	struct fastrpc_buf *buf;
 	struct fastrpc_invoke_args *args;
+	uintptr_t *buf_pv;
 	struct fastrpc_buf_overlap *olaps;
 	struct fastrpc_channel_ctx *cctx;
 };
@@ -570,6 +571,7 @@ static void fastrpc_context_free(struct kref *ref)
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
+	kfree(ctx->buf_pv);
 	kfree(ctx->olaps);
 	kfree(ctx);
 
@@ -681,9 +683,17 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
+		ctx->buf_pv = kzalloc_objs(*ctx->buf_pv, ctx->nscalars);
+		if (!ctx->buf_pv) {
+			kfree(ctx->olaps);
+			kfree(ctx->maps);
+			kfree(ctx);
+			return ERR_PTR(-ENOMEM);
+		}
 		ctx->args = args;
 		ret = fastrpc_get_buff_overlaps(ctx);
 		if (ret) {
+			kfree(ctx->buf_pv);
 			kfree(ctx->olaps);
 			kfree(ctx->maps);
 			kfree(ctx);
@@ -727,6 +737,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_user_put(user);
 	fastrpc_channel_ctx_put(cctx);
 	kfree(ctx->maps);
+	kfree(ctx->buf_pv);
 	kfree(ctx->olaps);
 	kfree(ctx);
 
@@ -1136,6 +1147,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			args = args + mlen;
 			rlen -= mlen;
 		}
+		ctx->buf_pv[i] = (uintptr_t)rpra[i].buf.pv;
 
 		if (i < inbufs && !ctx->maps[i]) {
 			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
@@ -1193,9 +1205,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
-			void *src = (void *)(uintptr_t)rpra[i].buf.pv;
+			void *src = (void *)ctx->buf_pv[i];
 			void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
-			u64 len = rpra[i].buf.len;
+			u64 len = ctx->args[i].length;
 
 			if (!kernel) {
 				if (copy_to_user((void __user *)dst, src, len)) {
-- 
2.54.0

