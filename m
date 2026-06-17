Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BC7CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 21:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E29510EB65;
	Wed, 17 Jun 2026 21:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pUlpN24V";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FCA10EB65
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 21:25:27 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b7866869so1554475e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781731526; x=1782336326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HAtfWviJA5Ta3x4TaRbQCu1oUr0pP0uRG2VDuoJPUNs=;
 b=pUlpN24VILJM79FYt/771Dr+kuzJ8nU8g0VEKnD0wnBrvbVRpySDmI26LuEiY15lsi
 k4pfFg09/8tnDcb+9gQcIT7GbFL8xmv8bQ9TePzTX0MwSdj8zw3TZGdBBM60BQzZJvEb
 ARn0GnfWbYu/9FjMRi4TfJGpAMGdSlmOpa8qbr2dpw/ESkornKgsIupg+yMhoewaUb+4
 FgF/r0DBMbWwbd/9h7y2U3ysEa5oQzq/LV7pDyeM4QHOTr+zDqCFAwPXkKxOZEx5EtNZ
 ZLotR2Z6jecZtgEj5ckLKswbCiss/mQUWN8bufEwhehwYvRg9wgPz6O5ROMQelf5ZPYw
 yIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781731526; x=1782336326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAtfWviJA5Ta3x4TaRbQCu1oUr0pP0uRG2VDuoJPUNs=;
 b=oBVVwEZoJNbNUeZl0VTPsBf9JriwlKNYFWA31+pDfpzuK2Ar5l3A70i8ZaBkKgrPEj
 QOm7n7+qVGLrarFdJhHW0nEXFmhttuV7svu89b5Ow0yVCg2lbu0/i6jS9WaU7/hfWatQ
 cel7EzxBS7UVKleRhzUwHMoP19ZagCoonB05ZY4t0cGbqkm9pTlbgQfH3iyzQYnQUPxd
 1d3f6N9OgvZAKT6oGY6/ltkRa8OLU+VAsFnr4WXd/3xJ0LC8D3odcUO5nQqiUDs0VfT0
 42sohVT9pD9dqImtEhdCR/K0dqKCEv2tPg+cSSdrQaUPfNYjaF89hI/t+hd8Y2MbfrjJ
 PQnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vNzmJCYfCvWwwaCAWs0jPoIgqEkkpqHFeOb6yhji24gDKTiFm+F+GIQnRN6wj4ioquN/NYxQRx2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS6uUk+7ZjlJ/4qcdoB+qdhJjk1DNJpuU1tcDSqoXZOrny6sWs
 ROQMxMCoRspEdLGkW5ocJASfCSRj2lSHl/0eorMPaqkyKI9omcuC1uyp
X-Gm-Gg: Acq92OHAmmnXN3l7zdTmbIPpkbDbK6LzYuOH1q0JUcmTT+/91tXZsemr78oY9AV+Tkd
 COULI0jRzzRs6JlyVNMDpgmq+CSpLBYC6wseKujG2ruFmdIEyByBjeNlV/fPiAZXYice3LyGvmt
 BJoonOZZHYEewDv/68oxESBThco4ub6jy+SDluG2rA/NMS2iXhIE/iHj+h9L4zF6nUKb8Zsl98y
 S3xUzfueUDQWkHse6iwBSH59bb48Jq95b6cNmfDnVhZH2oJ/K+a9pxS47IXHalSX7x9hnNJXexi
 WC+s0eTwQU0JNhcIde1/dZAXVeTajBcpG6YjxO+yWol7bVcrVLXy8yKM6sv3VFe7gFy3o6GZiDr
 n1GKkj1oaL35NPBmIfYkZogtk1WH8fW8d0p+dxGEUHuQcQ0mqJ1yJhrGp9kQySVpWU5D3YJE2HQ
 fLAO5zgEoTWjEp0VrQqSOQ4on/lxu/AnpeJbEt5IEw3haQaqMtS8+cXUCd1mZXnzg=
X-Received: by 2002:a05:600c:21c1:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-49234103867mr52477455e9.9.1781731525964; 
 Wed, 17 Jun 2026 14:25:25 -0700 (PDT)
Received: from node ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm58396109f8f.37.2026.06.17.14.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:25:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jeff.hugo@oss.qualcomm.com
Cc: carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 dan.carpenter@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/qaic: use sizeof(*trans_hdr) for transaction length
 check
Date: Thu, 18 Jun 2026 02:25:20 +0500
Message-ID: <20260617212520.59801-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
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

In encode_message() the per-transaction lower-bound check compares
trans_hdr->len against sizeof(trans_hdr), i.e. the size of the pointer,
instead of sizeof(*trans_hdr), the size of struct qaic_manage_trans_hdr.

Every other length check in this file (encode_message() at the loop
guard, decode_message(), etc.) correctly uses sizeof(*trans_hdr), so
this is an inconsistency. On 64-bit builds the pointer and the struct
are both 8 bytes, so the check is correct by coincidence and there is
no behavioural change. On 32-bit builds the pointer is 4 bytes, which
weakens the minimum-length check below the 8-byte header size.

Use sizeof(*trans_hdr) so the check validates against the actual
transaction header size on all builds.

Fixes: ea33cb6fc278 ("accel/qaic: tighten bounds checking in encode_message()")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/qaic/qaic_control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 43f84d4389602..4d4e789d5fcb8 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -786,7 +786,7 @@ static int encode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 			break;
 		}
 		trans_hdr = (struct qaic_manage_trans_hdr *)(user_msg->data + user_len);
-		if (trans_hdr->len < sizeof(trans_hdr) ||
+		if (trans_hdr->len < sizeof(*trans_hdr) ||
 		    size_add(user_len, trans_hdr->len) > user_msg->len) {
 			ret = -EINVAL;
 			break;
-- 
2.54.0

