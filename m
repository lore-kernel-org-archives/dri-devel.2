Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE44EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4723D10E94F;
	Mon, 13 Jul 2026 12:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MgBEBQZC";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69BDA10E94F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:09:57 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1785533a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944597; x=1784549397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R5VN0Op/PYgxXXGiNzBVb7Bc2A/YDsd2gosba72MniQ=;
 b=MgBEBQZCskYeCLtyuur42Sr1YXUqrcuk6mbs7dgC6zdkrSRXvcLPRqthBu8veL+Qxw
 kqXXLCOAdjmBQ2vCKrIN/0ZyDQwYNypsI9yRu0SAZGWdX+Xde1HqVRZOn46LfBhByM6a
 CXBt5K45HgVi5hyUY9MNjiXz6DV/JmAyltPjCrZ4Nhipl5HcyJru3DLcBgMGt2J1hR54
 8bYoJo5B+rOP9Z5bPF92UsDnMJoFL6nl5j1Mwlp7W78Y/PkIUDbs+r92QqRpu1UoBt2m
 QGh+KuL3E+YlYln2rf98sd3Cu7TK2ney7TplqR6ac9iWfyFwpqv7AAEJrn3p4lfZYx7Z
 IrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944597; x=1784549397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R5VN0Op/PYgxXXGiNzBVb7Bc2A/YDsd2gosba72MniQ=;
 b=m1fjIt1Bj50kTPRTQbKpfEv2uoxUFoNYRtIf/K+D19r+YpaQntcrnABeNiTxrTFkdj
 Hb8KFPtOomrVAEhUn0MlBYpaGbNqWPpbBGgR04Ph7pCI87kqfS4B1jVII3pZBLajkzIC
 +yh/fyMRK/C4dScvqg3hJX7pZ7BfMiad2/Fm6Fwdg4KzjaonAsvZUu7ZJMgTm1C30rZ9
 s7tmDCaF5IESJsQw/UQmj6eSgzKlIRwnex37f7B4f3Lebq3kNilxokcG2HqkmXJH0hfL
 +ntF0aziXlUChNPIpaikdu+qdQ1uqNHh/C19U7yJu/iS7N+JWqDl3jMMuwbaP7NAXuMb
 UDXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7pWemWTTTnqaXA27lZDTqIacvWTBonYbyh+L4P9wxWwhdddaqZhWiOYlUzDe3t9PAJGWei/pOwpo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYlkUARdTrnCVVSTZ+2fzXatzbNMT/FDxh9jIoBUr0ysF2iifN
 SCZbkidqAqZdgoQOtNDw6fQcjZwxGqB33kE+/+qYHPWcFiAZgpn7QzwL
X-Gm-Gg: AfdE7cm1QzJSpU0vK2Mi9awuW721t1L86vi889cPrvVT5pHKrejFy9ihrpFj2WmpLpk
 wPPdKhJr30wy0k8U7vvrst4dSHvaWfxQeFZxDLk2pWqTeaTaOHKSmJ+UHr0JuOzYYuXjfV1cStx
 mUSMuHHfppxTGHNRIvUPohnbcAKvN3o24jcrXC/fMJnlXPJVSXyWkDq85hI/neGFb5aO6RAnruZ
 abyNuJNbJINszC0UD3N7q2j4HADz+gVHjbvLvlzvyikKW5QRd6SecktoARg7k8U7EAoU6heBGda
 t35r5KkaT+4s+HHx5iTfMkpPaHCfdaHoaBS4sHW/GLOhHHStRxW1yt5lJXhapL4cip/GOa2f9cv
 79uQN68sELPBxZvSuwZyCKAtYihsU5MNmO1zQnlRZXt+cn+QHhDBhrtFzo5N1S0erwCpBsqhIc6
 PnZ8eh4aPiuQ==
X-Received: by 2002:a17:90b:3c43:b0:37f:9ce3:ca97 with SMTP id
 98e67ed59e1d1-38dc777b8a2mr8263084a91.32.1783944596948; 
 Mon, 13 Jul 2026 05:09:56 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:09:56 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 06/19] media: meson: vdec: Fix race condition by canceling
 work sync
Date: Mon, 13 Jul 2026 17:37:01 +0530
Message-ID: <20260713120840.17427-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Synchronize work-queue states cleanly during streaming teardown and
close operations to eliminate asynchronous pipeline race conditions.

The esparser ISR can schedule work onto 'esparser_queue_work'. While
synchronize_irq() ensures the ISR itself finishes executing, it does
not prevent any already scheduled work items from running concurrently
during driver teardown. This causes a race condition during stream
stopping or file closing.

Remove the scheduling of esparser queue work during destination buffer
completion, as freeing the vififo is handled elsewhere. Add synchronous
cancellation of any pending work in vdec_stop_streaming and vdec_close
before synchronizing interrupts to prevent use-after-free and race
conditions.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 7689ffdb2e500..6fe9722577179 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -484,11 +484,15 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 			}
 		}
 
+		mutex_unlock(&core->lock);
 		/* Synchronize and flush pending hardware interrupt service routines */
 		synchronize_irq(core->vdec_irq);
 		/* Ensure esparser ISR finishes executing */
 		synchronize_irq(core->esparser_irq);
 
+		cancel_work_sync(&sess->esparser_queue_work);
+		mutex_lock(&core->lock);
+
 		vdec_poweroff(sess);
 		vdec_free_canvas(sess);
 
@@ -999,6 +1003,8 @@ static int vdec_close(struct file *file)
 	/* Ensure esparser ISR finishes executing */
 	synchronize_irq(core->esparser_irq);
 
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
 		kthread_stop(sess->recycle_thread);
 		sess->recycle_thread = NULL;
-- 
2.50.1

