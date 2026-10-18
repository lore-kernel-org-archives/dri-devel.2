Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B833CCF2D3
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D388210E676;
	Sun, 18 Oct 2026 14:53:20 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134C410E5EF
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:35:20 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so521945f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792326918; x=1792931718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZRC1saK2lzqhpBjjhBU/Y8Q9XNxMDtAH2y6pyCBfUk=;
 b=Qz5SkEWyhQ6SCOcCmkYBoXGJvmrDPaa8eUjzEmBJRMwIAYC696Uw0NlF42+5OOFEWg
 n5EL5hxeDXbHTavFj5AIe3crMXgLhxyhyCpvj71/YtCI4KogNs+oJs6C3lWoadZpy08g
 zG5+zDaSKvG7JTutzQrVKx+ZqN4GG/GZ/2AMsmlClWk8WS2UcUKNTdDhqGQsgLCtD7qn
 2uv+PbXVJ21ZMVjNYG40GLc0s+/85UlR13nt+2AKBOSBtNq7aipN3RR0OzZZx73ruZVZ
 Mxc4UrC4JqGLnetq9O7+XriWNe4W6Fun8FkRLaZsUqVhecJ3cTyiBJAcUjE1sW/MMgX7
 qZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792326918; x=1792931718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yZRC1saK2lzqhpBjjhBU/Y8Q9XNxMDtAH2y6pyCBfUk=;
 b=Jh+E8fH29BM9ulhoBkXZXjG+RgO2u1gCiACGJJD0/MTSc7u9qW8l0XMxTqz3Bvcwdl
 6/8CZnJTOWV53I6fCcS8ZFnAdYW3pkP73kqoCwovtG+XCRn6QSMdvES7nEm2ICC/tkuz
 rE4ZQtoItp/WlRrxEjwUh7bJQ1oUvGF6G0LrhOo+ejcg0m26OBaYjJuGHu2NeigXh7hx
 C/arG4H99BqeMzc3tdWONgOVdkIFr05lSIHSyuXVHOcEcr3YGqayLmCWg7Qgw1mGrR+d
 ul2JQWJpBWeGgZQ9Cl7cuwj2yswj8CpcVgOugZCd4goy8pEh/hiIrMB+BK+4vheeOE9a
 yNGQ==
X-Gm-Message-State: AFq9FYKpUkW271akX1m+0M14qVmo7gTfg7CeCSRu4NEONXDrMnbZW0Wv
 3XwQvE3bAOhkLeNl93507MGIQBdPXIouMi800k+RPYAjsTbmdQWqc6o6
X-Gm-Gg: AYBFou2Lpch9TmL3/RSj6ZGUu6F4oPRwlyXvPo6mh0GGgb9A+EKQ4Sx4TKMzvsai3oq
 AF9uvx+y/4psWXbsVZ+CSGpk2iJhPJdPhFXHW52y3IICyNO3VttOWSj0BK9ChOZybtikMdgzsvE
 JVlsaUXndghwKo6K007y/PPms8jotD1TjNiamZNLgsLxik5YYMhZ/KamZs6gG67Fy9HhdRj1dHa
 /8C6lbNvLslOsCaipyuQn1wnjfU7jfY5b3NDBjSpUsNSjoK9r2TLHurhYMQNgVjIkD5B3dWjDTj
 zG98LqGln2pNxNoEKNVjizAa8g/Wa9emJJhDrn/hwJH1m81ZTtxffoQn/UbdxvsTrQ/hS/h9fW6
 t1yhCizlD9RvKUFPs9fjPCv2l9dPWDLMyhsPpcEGkE8H7hUi4DojdJ6n2dgRh2pYXT7vJgDz6wX
 mjjxtFHUVg0e5pMigNo4J2HIkS/Ffz1JI8WUoqcjXgQ/+j1nluwQeuoayqIkVDJhf6TdzMh9oEJ
 uVbgGuB8A==
X-Received: by 2002:a5d:584b:0:b0:48d:f831:2688 with SMTP id
 ffacd0b85a97d-48e079767e7mr10390179f8f.3.1792326917977; 
 Sun, 18 Oct 2026 05:35:17 -0700 (PDT)
Received: from kali ([102.89.22.178]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a0dsm17000429f8f.47.2026.10.18.05.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:35:17 -0700 (PDT)
From: Bashirah Lawal <bashirahlawal017@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
 Bashirah Lawal <bashirahlawal017@gmail.com>
Subject: [PATCH] staging: fbtft: Fix continuation line alignment
Date: Sun, 18 Oct 2026 08:34:30 -0400
Message-ID: <20261018123430.148379-1-bashirahlawal017@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

