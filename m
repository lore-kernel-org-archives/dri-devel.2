Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43FCC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6890710EBE0;
	Tue, 22 Sep 2026 08:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2QVWxh9";
	dkim-atps=neutral
Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175AD10E4A0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:14:38 +0000 (UTC)
Received: by mail-wm2-f7.google.com with SMTP id
 5b1f17b1804b1-49fd4ea3409so5010835e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790014476; x=1790619276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8njTdDuR2VjcLI0zLlnQh6RcubDIwEA0WzrR3t+nYKc=;
 b=h2QVWxh9HL6o4eUMCCvWci6K4e7pM3SpRqb8qN98WY1C5kCNFh/zaVi56s/geiFLYb
 owTtXH2YOZ3Ka35lfVt0BYx/29CJTKjVNkw/4DgFtH9lIMbT+JoA/czMJeYTXuR6fgoF
 KeaA2Uq019Oc+M7QJs85KLspTDXqL5nb41YkkdLyXwLo55OLbrXd3oM9ZfBT42v6yHFf
 WPUGz7+e3ZjWlN4Wkl2mPL2MjJ5wyXp+lPEG8SuD9Kjs8Fiy6VnHEx907YndjsfwOigK
 1KDrUwy6FaD07N2vhJ7JekijEhBhlWTEl3rPjQ7iUF9KTDH2NzhGiZo3RNqDEDJwF73B
 9XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790014476; x=1790619276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8njTdDuR2VjcLI0zLlnQh6RcubDIwEA0WzrR3t+nYKc=;
 b=k46RtNhBfZKBTBgmG1fsOD7YY9Qp0U3VGvERtM8uXYUqdszglKCI2Aih/k0DGOc2jX
 qWh4Px9eQ1BpGwg+Fqc0MB5cvlX/eWctjlHLutlP8mcidU0M0iQthzMyysuj8W7lKhuC
 6X2xq0unHgQdLj222fo94RNYXpkb4UJWqtUmzxXDIrvMMogVePZ8bqlIEUfZ7NVhQ5oG
 DHAkwODH31q522yD9ur222h/jAEcLGiY2UeqQjKJvU2naYRAV8Y61ldVtBvl6Xgtq6BN
 P7OGFnZmBaGsT1NERDCF748Fn1AgoHIG0DqMQ7AcDKOkvW2c+urQ2vIO86fpPXhXt4CG
 uDWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBeh6OEd6MaH0isQOtS03FbrkMky30OPFnuqA5ttcqf+xEEERkHOqzqA+vGiN2kboFoCPhjlQTTew=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lEAk2cLI/zMaqSrV3D7ucOZkh5wHupAofcBf+ZfONT7UFDQTpd
 MXMq1G8VQwRDpGFwot7LOt9symrcHAcJkdy5cb2d546R/BpTHhyhGAVA
X-Gm-Gg: AYBFou0vJZ1x6LYDi6LSf/qG2krinsAycxwg02nPQQwr8//04PT5Q4ps1Fz5lh9I48S
 ZT5bZWGm9dREexI2aSxPePt4CilYAfX6ZwX373KEfY1Qb0bdDFw3xosfk3iisovQCB2OzhlRX4y
 Vv2gU0DPYCpbk+GBkaM/I/RReCdm5S61OYxknQJYO0lmU5BgvW8en8LRgM6gWz61R9lKgS9tk88
 1l54WG/LDyv/oP14XDQaUvpfbNn+Wxa5ONRQ3uFCp6COZPayG5fWUmTSDhqbHNw+e4btqiqplt4
 6/iDVp7gkBif2X4ASurewcqm0vv3MPYgvpP6Dz2InhlEXXM9VG5l5ZpRcxo4v6BvjmodVcMffQS
 hoKSCQx0jhT1KZUjyDiIeuiYt35uWKKrByie0VJ6eePi0efHv7KzL2vRmPPk3JUcHhLqgpWtpqJ
 IFSTncpmzR4W4XACBQ4PcNl2mA4Bf+0WYnny2l6fBAuOjJ0IMvrTMBqqJITR9LbQEdbv1X1h1Id
 l+Kjsr2NBhf306E
X-Received: by 2002:a05:600c:4f8c:b0:49f:c18a:61c8 with SMTP id
 5b1f17b1804b1-49fc573f858mr164351925e9.29.1790014476102; 
 Mon, 21 Sep 2026 11:14:36 -0700 (PDT)
Received: from gbox.chicasongroup.com ([197.210.105.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8a636d1sm10754875e9.0.2026.09.21.11.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 11:14:35 -0700 (PDT)
From: UgwuRhema <hikarialiyev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fbtft-bus: remove space before close
 parenthesis
Date: Mon, 21 Sep 2026 18:13:50 +0000
Message-ID: <20260921181350.89925-1-hikarialiyev@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Fix checkpatch.pl errors regarding prohibited spaces before closing
parentheses in fbtft-bus.c.

Signed-off-by: UgwuRhema <hikarialiyev@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..409770891 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.55.0

