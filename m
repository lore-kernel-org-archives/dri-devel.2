Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C0606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E8b2fdDr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E285810EC8D;
	Mon, 26 Oct 2026 08:38:22 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1717810E292
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:46:02 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso7725397eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792989961; x=1793594761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3DoOx+7KwqVIr6jxYa/DyB1bbCV4XdJJBW9Yy/mfpI=;
 b=E8b2fdDrdwIT9xf9+tNa8w27GUdDksUyYevxqcvdox+0O0W2xEywMhQ5W/NFdiQSnf
 UFXEr8prS9mQR8Fyv6AGnAT0u4Ip/TvM0AFHW9hkkeY+jWy89q1wNqri8l8VUoaeKL1s
 VwSmNmCe20EQCA/ETrbxiGHuaVnZ2t4UHj9yJpg5D+bWec3E6Bs+p90vuG0IxSnnKJlc
 yxH/EkaYGgHcf5mRR/1fxIQPVRnfyuks5RlD6RVgxFyYyIlojXO5lfcCPc8IgpPK1s/D
 v5CzQmN8Cq4OCRmP8+0hxRhr1RKU36FUzDfJUlo4YAdYPI6BB6o2a4PeUyr/OEGO21n4
 3wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792989961; x=1793594761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3DoOx+7KwqVIr6jxYa/DyB1bbCV4XdJJBW9Yy/mfpI=;
 b=Aat0UWv5IjS1X5gWWn6f3mqoL7DO0vN8Fq05mQVWRyQUSe0urwyv+jKVA+rA37b7K2
 csElLT7b/yK0lggHjzxrO84QOK2BmA4MSNmAtJQU/CSJsDv/yWYCVYnt4Z1IQGzEjUqA
 b4I8U94aXR937Xwiop2iSwGsjUdc8UQ6ztIUcyv0i72KDo+6ghm3nWOwGv/X+9fp8iS5
 v1iktpbxMkYTt3IecPxu4ZHx+iKvynWqJ1xr9hknZp3RQztfavW+xmDhHE31qyLxF8yw
 lUx8j62LPxWudFOwpal1aaassMd7OgMJX7PNA8YnOZkQdrxnrjGm3cncfpS40dqM7AS7
 GuyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHCJNYd7yzJcIh6828Vy+zIJKcYz6MwScnu/M0Q5w/n/Njfo2Fz5lXBX5bcyGBN2Fp1XRGQ8O7SBE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6mXhhPitSmgzO2NpPHXci1roh1PbqRGnntFCWO+1jipl6uR0F
 doQUgxyKLDEorBsAQkEIJSayJ9QLQk5u9cAyFH5h+2AtHUpFJ+vafzY0
X-Gm-Gg: AYBFou2DJQoMlZu37yWQK/+SGr9zf9UK0RjrtQUVOSN66MaDFWj4bispWaMEB6SvO+5
 fSe2cAn01wcoYhIp0XHdCpr7xL3VGjLIh/uMVTudEc3EGXGX0m6E8FkPJu4mRLLgZM6caUdf49a
 qLDeKuwRg3CHZc3/VD/jtV2EvDxUSi9SPfv2Z5W8cwomsp/tIxcDDZY4LVxma5sP8GEZvwfzQ+v
 uTAFxKjW6V7wkz3r8CikkLROgYw8YCh8iDmenAHaZv1pzOwsbFA71uQ6lOk3jwpFRcAL7XUzitz
 x8x6lxTyDugMHj+us12BhGw2eCvaEeWhfWMskv8kXvHsv36uVH4CgM2Woxooonhh4G1dS7Yhvu+
 2751w1WnBj2nXsgGPN5FJrKSk9D6Fo79y/qMTEVqDqUQJh6zFb6i13HVy8mOmUZPp2Q82mgqz7J
 KwOF8lkPcuY0bK9JvUPGezYMQyfFcplsnl6CoolcxNbnvww7897qEFKmuEnemgCT7+ZA2s+JVvi
 7qup4iEc6Gt4j4SlGJyB6PlD4nNL2Rnmrvv5p2lfP44Ma6k4YyyqL2TBPmEcpnJSMwrWm4+kXpN
X-Received: by 2002:a05:693c:4195:10b0:360:905a:7c27 with SMTP id
 5a478bee46e88-369e84e701dmr9620677eec.26.1792989960862; 
 Sun, 25 Oct 2026 21:46:00 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a005c0188sm7281133eec.9.2026.10.25.21.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 21:46:00 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Fix line length warning
Date: Mon, 26 Oct 2026 10:15:23 +0530
Message-ID: <20261026044523.18516-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
columns and address the checkpatch warning. Also aligned backslashes (\)
for the macro. Added a temproray variable for platform data.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index fd7f8fc2afba..ceaa9a3906ef 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -421,12 +421,11 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
-	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
+#define fbtft_init_dbg(dev, format, arg...)						\
+do {											\
+	struct fbtft_platform_data *pdata = dev_get_platdata((dev));			\
+	if (unlikely(pdata && (pdata->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS)))	\
+		dev_info(dev, format, ##arg);						\
 } while (0)
 
 #define fbtft_par_dbg(level, par, format, arg...)            \
-- 
2.56.0

