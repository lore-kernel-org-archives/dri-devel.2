Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC36606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERkFMszW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47D510EBCC;
	Mon,  2 Nov 2026 08:04:04 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9659910E41B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:49:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so1704104f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793558969; x=1794163769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i4kMYe4pF05BAeSRiIgaVbEHMlhyZzqAIkz58RqSejo=;
 b=ERkFMszWS6bqCcDhW8Im1d66Tj7vNBK3X7OC4b42sKjlLLGtmzaR+xM0/b2g7qrTob
 yAx3uVmUoD+Y/j5lahcFvTJSmi1CEBOe15TfMRaMgxxfoRwyruZH+UXTthU6W0zOyzmy
 GjFKH8P7nwdTm0M/io8fIU9DV8JtjK4Izto5akH1yJ8p1e0wc9MSIsLR9216Nt3YXRpK
 9ueN5iJBcjPt87BSqe3XK/1NnZx3E5W1J6IbA3OSQlFOhu/roYyOLLo2MeNeu+3u8zH3
 pwOIjBDDLy/ioscKdjKmzVaaQoyJaGy2T6cOTB5sXStHqvZ2aeiYreZJyyfSTcWBCXFz
 DYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793558969; x=1794163769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i4kMYe4pF05BAeSRiIgaVbEHMlhyZzqAIkz58RqSejo=;
 b=kUWHdcD/ZrQeBaW/cAje4O4WEaGV6VFQLjLn0VwyrJ034+2cqVZXgErBPji8seND19
 /jQ8OGbHahtFHcXqVT4Lq1U07p6w8REMCT+AWW4vCBrcVizgESk1KMqmvJSUIoO7xpyT
 zE3WWwO2PFIF28KexIxZFzRxiQ/iSv5XDBg3KwN6DueKA+A+siugu6qR6Sm4YGAf/z1s
 REFm3kN+/PfWwB9GEzjCuUGqMYsuZxm2GK53ryvPA4kHVG/5nh2AZJ2tcyzbaOuX7BLS
 kJN9fShe2yrrY5bCmieD7Xc/nv1BV05tDVEqWvhRDQ84BFm2S+taUj1i/tfSZUr4EsPm
 JkDg==
X-Gm-Message-State: APuU4Z8AtuPJTHGIvLV8EoSG0+SJzzvHUaj6XOtbaOyqVmdQn6hMeDFD
 4blgjh02E0Ii2sGfdCrBJnJq3y629E/Pak2sWOXPDcmhjAMpuyrYJlw=
X-Gm-Gg: AYBFou2MeI2MeDTIdyK+4SO/58EVV/1UQQ/TrBXtXX2i21znHV21WSKqn/4HlxG17uZ
 muCO1xuto2CKCs5atnkm+gJV2D7y3c2ragzlEa+3OqfUWmOn8JD+reb6iqkWoN2u5k1pKi4TsTg
 NRXxBgSn3oiDrM1FaafodhBymC8fxr0/7ZiDNlG+W8514W6WAZqrFPwMpp3Zu0S2AkxSUDQEnmq
 P/sg3xM9C+dumctAzIBIAJN7V6wPcv9LMVvMHKqOiz+uYYe8p7uPS8DI5F/7lk407Yu03mczUb6
 6pfSSbg6ulUl4Kay/gOiaE3IXPq8D0DxHRIpERSCZiZqvkswTrsIXHFGNn4CsNzsNis03b/rJ5t
 wSHN4Lk4VGiqMEfV/oLqxWU1Y8jdcK9DAaB2hJHKb0y77YFkV8x7FD8bGYLyjaNmFMIrqez3Thv
 hNdbjqN7GLA7udKsEid+6rSQKr0OcckRWLQJNo2jyCje+rZvGTzNMIC2R9LDTflfCbE4dDpj2kM
 x8yA9CmMSP1twE70jUf1hvPAJkMm8C1E10pCIo3sln4y5Dl+uuZv7jFhF9vIFnLYvXDthAmQDLo
 6dORwwdEsghnH5qmTyz2jFi7jQE9Nx0m9SDbv7vpvmjrRITt/ovgZXjbw/NhUYNOugb1fRVbUiN
 0IfOFGE11HCMABKLOTJvIA6o48lqvNMT4RvivtQ==
X-Received: by 2002:a05:6000:4012:b0:48e:678d:396e with SMTP id
 ffacd0b85a97d-48e678d39eemr26985417f8f.9.1793558968758; 
 Sun, 01 Nov 2026 10:49:28 -0800 (PST)
Received: from localhost.localdomain ([81.199.56.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm15530548f8f.11.2026.11.01.10.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Nov 2026 10:49:28 -0800 (PST)
From: amit <amittibi123@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 amit <amittibi123@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused ssbuf member
Date: Sun,  1 Nov 2026 20:49:15 +0200
Message-ID: <20261101184915.33899-1-amittibi123@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ssbuf member is documented as unused and has no
users in the FBTFT driver. Remove the unused member
and its kerneldoc entry.

Assisted-by: LLM
Signed-off-by: amit <amittibi123@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df..3b58bb9d7 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -155,7 +155,6 @@ struct fbtft_platform_data {
  * @pdev: Set if it is a platform device
  * @info: Pointer to framebuffer fb_info structure
  * @pdata: Pointer to platform data
- * @ssbuf: Not used
  * @pseudo_palette: Used by fb_set_colreg()
  * @txbuf.buf: Transmit buffer
  * @txbuf.len: Transmit buffer length
@@ -192,7 +191,6 @@ struct fbtft_par {
 	struct platform_device *pdev;
 	struct fb_info *info;
 	struct fbtft_platform_data *pdata;
-	u16 *ssbuf;
 	u32 pseudo_palette[16];
 	struct {
 		void *buf;
-- 
2.54.0

