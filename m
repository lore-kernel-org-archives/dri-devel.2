Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DDEC5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA3910E686;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kh20p7jU";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187610E0CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:30 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so400033a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252410; x=1786857210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8on5LBVsYqwWr9ndoV0oVFp6EULFueLmmkrZV0DJAg=;
 b=kh20p7jUQ5Gr/h2SCSzSPuO2TU8RlKefwLDJaEY+O8zCmFg/egQpN1Mly6sw4NGVKh
 GM4DYu1LN92a4LUbQycg8KxICBGnxaaFiIAiB0j1CihpsHX7gzQXpHnDWM3k59lnbX2E
 Cwf/kjW8mwnPEaG0E484i/A5/rPiP7XXSn+J3JrkMHpAm8ASOQHp4/FQVbdD44mfO311
 de+pi8Kh14WTgiRUYFqoUI5Mi9S4jscidYTcu+m4sKwSqWGPSODQWn9Mank+d3uvo3qB
 Ev1YbTm/9IeAzc2nniZnA5f5scKXyRnnKqJZWlYNoPb89sdAQMqpbY/EEC+ZzulNU+yE
 fcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252410; x=1786857210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8on5LBVsYqwWr9ndoV0oVFp6EULFueLmmkrZV0DJAg=;
 b=I2GmWDtfbpDyPcbxbPtNGjbrG5KBDoxqJgozWFDC0gp4I/GPzrvgfIRXAK4T1uca+W
 TU40DMF2T3P7eG5Gofd6vYoAcP0dJ+l9M3hps3z0OvQX4BNEQprkx8MjcXiX6zWDyc2r
 TUSlu4h1qZOLbki9jPkhlv+nylEhYepyxCe4oH91l/C72p/QzTQEOnfqw64up0MS7e4w
 QtKDH8lii9MSxoX+Po842mDoNaNlsczycnqgVwEqtZSAEy238eo/is8z5AVGclhMdeCH
 3xyAMALl01zsFdSyghzLIVdy6zDtGNr7T9wqfp7GSwIWsGBaEypsYqQhTJ+6y7L+y01P
 RPNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0KIEEu3PsNsHrlIQPnlaZ4jO3o5ttjlyBrQ1xMNEqYkF/LdHjRvxMTPiv3NO/Cu0k4Ys/CrUvBvI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0fMbvEYuX+CnicGRLh9EH2VorDUjgeRZAebnhNruSSQPaho64
 h9kx33SxIQnLul2rFlV56czm8OeNi5HjtnQ3KX91kKbNYof6CLdzfCeC
X-Gm-Gg: AR+sD13A3uLOgFT59Y0UltOJBuZg5QxHIybE/86M+LeyMKamFLp36F2c8O4MjIknR6x
 pR7paEcszJ/kxQiRiKXMts191HxKS09BwhgufwoR3LtN0fy4rDTC8AJ2rm87pVwCZhTy4QbMw8l
 lpI3SbF0P32zTfTwaK8wPh+nBybZaFoYFKfwgh+nHE3RbH2PIM0izVXx/DL+L/7rEZ1D1A+UZDr
 9laPMLTkzH4XQpQ7RXuQ5b5uhooBU59lxEgaAXAPb3CtuSuzSDhviYFPgZIVe72RNaMUNj4e5SV
 uF6gBVpgaUSIa/TW5aKPkcEXoG5kAkaVcc/8YVKJLYcuGmSiR8LWdwzLuItzDowcpXGhRpqZ4Ry
 3vcHC/VZ7Ai/2t4PUcG7svROik0sewFNybCfelgf/YYAtAJpz3a060c6orSi0iMgSballhUNqse
 bvLcL8EhCSvmXVLqJIffvHgaXRV3MwetchTbeBoA26wZ7xbGKzMknQTzr0Q1TToAXiwtZh6q8av
 rtm77m+TLb4
X-Received: by 2002:a05:6a21:3117:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3cbadc97c22mr27425139637.28.1786252410244; 
 Sat, 08 Aug 2026 22:13:30 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:29 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 4/6] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sun,  9 Aug 2026 05:11:58 +0000
Message-ID: <20260809051200.3276-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 06cb3ad1ce62..79326389d75c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

