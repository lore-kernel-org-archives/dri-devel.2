Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650F2C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B352010EB54;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=0sec.ai header.i=@0sec.ai header.b="nwhh/BOw";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276A78992E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:30:37 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso30584725e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0sec.ai; s=google; t=1783963835; x=1784568635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bhFRmtEAl63b5XEQYkBemzUeown6Ez5I0lj5DtalopQ=;
 b=nwhh/BOwRhy7s249UsLLXGj20NpNqLJFircPaL5Qle4M5iARl6a2rowDdOIJLCs0uO
 n8JgUljH1VitOgSoHB/WNX0mfMsjXsimwF26anEASR2XJjcj0CXalTsNmnDk/hn+LBRo
 cAh4znuWQOcPBVP9o9smDh0QQOeDBNKOdStYgERO8bldvlU/LCkY0tlCzSlBbzXxqgx7
 GdWZz5/7XvqXmchils4lX9GM5Y4fm48/0PK5VNqbRnHgAPqBB3Hn3ZpOu04b7ayVyQOX
 /T0KlR4ZgIHdPGAO6bKupyZFCbDnm4R25EYYr3iDqq4NF6UH4paMo+NI9gdQTNel3+rd
 OYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783963835; x=1784568635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bhFRmtEAl63b5XEQYkBemzUeown6Ez5I0lj5DtalopQ=;
 b=rbtzxf7ZjiBGyVhYlZOwG9iILY23twsljmnAzCD9fbc/y//WznikotU9bVxMI5MxK6
 v4PCYBFHa3CUSgAyY+qtWleoza8IhVX4QrNeo71pCUB21Jov/pWLXIvpws3u78M5Qgx9
 H0+eRN3RPvfZ62i6DJ2NZ6P0VkjLt2ImKL+PpTsazHPN/ndI4BN59tMl96sLQ2OEjDZu
 +UTgKI3V9KKpBcrdE22aQxHA22Fq2yqXxc4tA3S6Tt84VU4xME/UlUZKmFj1eh9vlh9G
 oTW+UNrlOPQn/5YskRftlxNyF+/visecgKKjdv/d/aNRYBnLpp5S6ylNFfl6uMseODGD
 aGLA==
X-Gm-Message-State: AOJu0Yzgp6aI+AI4hy2CcBbBMhXsl1gbD9A5zi5O6ZL5c3evk3j3inye
 RQjxFGYFJUAghHfQLezhuoTwqortfmVgvx5Zz0/zcv4d1unumhVHnLW8LEjywAovnGlV
X-Gm-Gg: AfdE7cknKgOB8GQwTtVyTrRKvxSM/XsyzBvUDA725OA5vpExn53al8AgxO//ZDV6EAB
 ByP1pomF5ukkkez1chUYrSYhfh1qdAsGduJpM/r44lyFTAcn0pqRFL48HSgQIq/5KQRafNr/cQE
 CLYNcyubR+zjuwdH6ZM1a2Py5LtqrVmaKlXB2aU9ulcoJZ+0oyj6u1q3l5llNB9d/dzqlJ/FM2k
 CWXNp+R9SRNYdtgUDwdUW+Pp654YFApsDeDGGWLMviQ0NXqf6f7QyTAi4u3u7iVDNs/BGfiuu/u
 CHosuHrZAkC4XBH0rNDody6lFvdnlsWdLTevfWAS1OQLcbJo8kxmg5156iSm7fZ0OSdp1bX295+
 CsPrpSTdvUbm2B+0O6ZbTMYX7VkwXAE0xENDZdeHdu7MLJPs0IlQpCzL6fGQY+RBWbovBgcvNhz
 cBCTwzZaidcsTyjLQrj6TdHr3XS7coXxsmQ+GSMI4y/g/LuQvuD5+BMpc2q2bcbwRORra05cqua
 9SGa4gMMz5abLBxD92lNTwHvIlhKreTXTaL8FBEVvbNdA==
X-Received: by 2002:a05:600c:8718:b0:493:c1a1:68f0 with SMTP id
 5b1f17b1804b1-493f881f0f1mr96584005e9.20.1783963834676; 
 Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f3a60404sm260075855e9.1.2026.07.13.10.30.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Doruk Tan Ozturk <doruk@0sec.ai>, stable@vger.kernel.org
Subject: [PATCH 2/2] accel/amdxdna: reject command submission on devices
 without a submit op
Date: Mon, 13 Jul 2026 19:30:29 +0200
Message-ID: <20260713173030.87541-3-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713173030.87541-1-doruk@0sec.ai>
References: <20260713173030.87541-1-doruk@0sec.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
unconditionally, but only aie2_dev_ops defines that callback.
aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
call and oopses the kernel. AIE4 submits work through a mapped user queue
and doorbell, not this ioctl path.

Reject the submission early with -EOPNOTSUPP when the device provides no
cmd_submit op, so the shared EXEC ioctl is a clean no-op on such devices.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index a5c8c2c4de6d..bdbd3db12a6c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -590,6 +590,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 	int ret, idx;
 
 	XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", cmd_bo_hdl, arg_bo_cnt);
+
+	if (!xdna->dev_info->ops->cmd_submit)
+		return -EOPNOTSUPP;
+
 	job = kzalloc_flex(*job, bos, arg_bo_cnt);
 	if (!job)
 		return -ENOMEM;
-- 
2.43.0

