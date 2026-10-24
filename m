Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739B606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gkF0rniG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E7F10E559;
	Sat, 24 Oct 2026 23:00:40 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C2E10E0DE
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 18:09:36 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-33fb4680717so2798429eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792865375; x=1793470175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1do5SZCsNsXFNjC3kteHvHno5OZSZlN4oGD9w4JlcOk=;
 b=gkF0rniGI4lAu1vxURZJi7oQbjJ4j7V6RCbnx1vzO7kSsALRNW7oQP5EvtamanqTgA
 Cga3HL0WuNehjXHvhJYLAJYCCXDOsjslFD4s2TV6EXbQhfsKpG56KJjES0Dgyf7K+OqY
 4bKZ72YiaCTfmMaVgoiUyJlTWbVEws1A90toKk6l16CWvTgLSWrHQLuzCf2B7sX85zYO
 avCKyvZqvnrU6VI63JJvm+/niChHm1gowCy0tD05MkB2ar40SfyWOaWvFJhTf1MmIHmS
 isQuAWVGp3vyphFkT4i0tBk/LjcqEiKmQY9YgbSDPBf94IqlFgsAStcKEGKhqeBT6oW0
 c8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792865375; x=1793470175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1do5SZCsNsXFNjC3kteHvHno5OZSZlN4oGD9w4JlcOk=;
 b=tFb1ln84koV0Xe2tWLF7k2OORWOkKRg/XUrttxciyZzIWgisWtBD7fHpQApNG/QMXU
 5qp+NezbWdEgai4klsGDP3wm+1Gci6r3alN0JJegqEUZe3jzekUrchN2kqwvgUE8KweW
 NXufAkjaaJnysQNs88UMXwc2xGbxRKMkm1U5WJ2VriCpa6N0lIw5hePsO19B7ZLuI28x
 ZFVKxuYFkOM3IPoM+bi2npxsrNnRViQeEPJ3oHCmYIVGml4T9QrW5NoY577IJi/ik9OW
 nw9uduo3HSHF7UehHK3mi8Yj8vedaHQzvlrnZlS5kYQq/Fva8g9GsvKpO8uhRKdYz2Rt
 mjXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+o4GbExkLRA4qT7xBN/XTSgyhB+JNTirR/HIka9TWJA5FUlseeKIwf3w5zhu8FoZdOwJaac9NB7Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK18rxSgXzPAZBJTMOdtPAgpynIQaEBPsF35rciubLbQpHBIIUT
 5kAXFA0Q6XUEow7j9ZdQEQDdJFpOg0jWdEvshZ7tYpxlG1POwtvRw+RioNbJFqJo
X-Gm-Gg: AYBFou18rp7zX+/Sj/X8MOcEKfyzkU41HaPmBLbGGzOiKanD6TXRhq/UtCg5KokHi7I
 HcgfOalL9TkFzjX9zMvq/FImxilQQrq6gxdU44nItGCsOwLrbRshJU9SWGaYgqLgoygqfcmbhfS
 dfES7z66YCLL9yUAOtlTn5xgWRBHJOHHTqM4diIsAdy0f6PMmC38fALub8EhYTNnG75GzVcGg4U
 CaoFEoijz2UnbGWVWjB9kGAz9rhcL9sH+ozMuqSAGcMmJt8a9Z6lqCD415HC21ru+K7kQzo4FXh
 wHtHx4uMLfKpIHPpTUv3QVbIwwQsPnApB5X/2h47Qh8GkYjolj2fw2CvZipZH/JrHfji8Ise0r+
 cKjZTRzPehDHgWwPBdACIHmQpE5mKKTqsgGW99s1a08HGZwKktd8yyKbO1YXFuxU3mfln3Q9Im4
 IaqJOYCePRY5U7u9ESQbB0OrSIrqebcE9hT9OIcU5v8uUZB643C3VQGXArjnbsFVIlx8l6U02yw
 Jk7L6pthBvNang/CxKZP2GgVJAx3ruR6wvew6tBkE2VnXKTjKNOG2XmVSHdvBrOnICyehQr+68=
X-Received: by 2002:a05:693c:62d2:b0:360:8a6e:640f with SMTP id
 5a478bee46e88-369e8625854mr3682464eec.39.1792865375371; 
 Sat, 24 Oct 2026 11:09:35 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec865esm8020891eec.26.2026.10.24.11.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:09:35 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: fbtft: Fix line length warning
Date: Sat, 24 Oct 2026 23:38:03 +0530
Message-ID: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 23:00:39 +0000
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

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Split the line in fbtft_init_dbg macro to keep it within the limit of 100
columns and address the check-patch warning.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7afb0fd3943..fd7f8fc2afba 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -424,7 +424,8 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define fbtft_init_dbg(dev, format, arg...)                  \
 do {                                                         \
 	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
+	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
+	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
 		dev_info(dev, format, ##arg);                \
 } while (0)
 
-- 
2.56.0

