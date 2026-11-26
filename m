Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C510606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LWRe8GZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61563112815;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02D610EA15
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso53472485e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795726697; x=1796331497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+QCDtjAYF4EgrAPbxgbLrZU1SIoHOt/s5+B/HO2kdU=;
 b=LWRe8GZg3rwM9Ue0AGPd0v0Lq6WddsgpA/AkVdNKo2lGmVEDVbF/2IeFzvZjvVEr7G
 3LldE5r/c5VbQrWSt+yhJXUMsNOe+bDccRvtXaAyCww9kt+WiY1IL+Yt/BXox/y7ri0D
 wXEFImwc5uNcyTdlYnhv6GW8nXDABegC3ajS4qVT1K8rVv8YVoAe7qUydZq9DK55I/II
 oxehHHxuAGex6T7tOirddREdZaRMhJwMD3olvoUnepUeA6uBr1zAMUk88n1RVnhy/n8X
 3Tma2n5IlmOvwKvfNhIdNFWkwIcxbfAAAWv4nGif2W5GxSxAOiGY4nqdtRqSuRcEkGlm
 xb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795726697; x=1796331497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z+QCDtjAYF4EgrAPbxgbLrZU1SIoHOt/s5+B/HO2kdU=;
 b=j23klVeA+CagC1ztAxDTfYm3kDfEN3m2mq8ivmB7ZrlBHnme2XDDK0SJovlOKQIS21
 qzJ60tZjjdrZ46T0vUlfN4c6tC+wgGS3mZoQfgxCCmwGeuOqBAsYAI55TlorYxjY6rN2
 prI/jL6KYwclPawsyIAKj0ufMxqDXcIS2ESSM+qTwD3pAScikeKzJtLEKToTT9cpe4gW
 delQn41ELFzEbWg1GVd9MpiDwkCFlzzphUyiINW7hORXFmHdhPFuyD/7hITFBOZvL32b
 C2jwf6ECSDzXSzE3PALmvH9QeIkLSlEcyrxVGlL8Z2HDVvuskyTiT5pfyd7wdo92bEii
 OsaQ==
X-Gm-Message-State: APuU4Z/fjmLOp9TlWRwKfFd/lUqjDKIcVKHMmF9c73ulyGj0NOwN8kLY
 WA7DiLpL2co8JY4OZWrUQZ+O9VWxwEh9eRQlr4QdQ7/RvGWwHg2lkp7aUQoQ3T8qgmQ=
X-Gm-Gg: AZFdTZcT+0TTSQ9ZacPfAzrN5Ish/CrE//GnW4f7IAww61GYypr6KIKR6p+fkD6kxrB
 MVV8oDoeyfxF7CY5Z1MAmFkgQGIMOMfMydR4lt0tsyNsa9yIRUfjzF1/OE9ca3emgp3UTQNhW5S
 Ru30yTXGw/L5dqEY5bLgeF4P+EDV9jgklSbrrbb5mm3xkGkIWZlM7WzAw//Vq2CWB/ShURVWQpu
 BqhO2EGzN+0b8adTZZJRwBcNhLJY3dAABNxpYHpjOoHW2qOVMWfhOPK6Uq5k0er/QTq3hSR8Qmy
 FXHL0YCdc7T/6RDO9tb5IlJClTUVZrcRUC1Yra8pjBaaJqqdweJEgNHXVjvr4BYLfsnlOuBm+in
 ptEaTBaRXIb++78Ve3VkPJ5/MPmLk93eR3KfygFNAdowlmxArOvoiuWSW1boxSGQPEnKRz5nIFF
 AbkB3OGMlyZD4DTCLG0SerOlVydMv4j+0SoVnWXBzLUuysdLekLrLeXySgt2RrU21A67aqZwvxH
 mGps8qCijBz95kgtuY3jT2uPIkCqYDpcJLeo73R9aZKw9HYKiHppTv+TARJDjOmLNsJQqszia/6
 WkWQjhzyhWJbUIWqYDNuiJ6y/t23Q0neeKtW+vQROx+h1rN+BwWzKn43DoWucoiF4ZIZxON+ne1
 Oyqk=
X-Received: by 2002:a05:600c:4f84:b0:4bb:5f3b:25a9 with SMTP id
 5b1f17b1804b1-4bb88820f39mr423362785e9.30.1795726696806; 
 Thu, 26 Nov 2026 12:58:16 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10--33.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10::33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm611178075e9.6.2026.11.26.12.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:58:16 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mei: gsc: bind the xe HECI1 device
Date: Thu, 26 Nov 2026 21:57:54 +0100
Message-ID: <20261126205758.49845-3-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126205758.49845-1-arisa.snowbell@gmail.com>
References: <20261126205758.49845-1-arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe now exposes the DG2 HECI1 interface as "xe.mei-gsc", the same
interface i915 exposes as "i915.mei-gsc".

Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
 drivers/misc/mei/gsc-me.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index b38ddb04f..69019d5c4 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -276,6 +276,10 @@ static const struct auxiliary_device_id mei_gsc_id_table[] = {
 		.name = "xe.mei-gscfi",
 		.driver_data = MEI_ME_GSCFI_CFG,
 	},
+	{
+		.name = "xe.mei-gsc",
+		.driver_data = MEI_ME_GSC_CFG,
+	},
 	{
 		/* sentinel */
 	}
@@ -297,5 +301,6 @@ MODULE_AUTHOR("Intel Corporation");
 MODULE_ALIAS("auxiliary:i915.mei-gsc");
 MODULE_ALIAS("auxiliary:i915.mei-gscfi");
 MODULE_ALIAS("auxiliary:xe.mei-gscfi");
+MODULE_ALIAS("auxiliary:xe.mei-gsc");
 MODULE_DESCRIPTION("Intel(R) Graphics System Controller");
 MODULE_LICENSE("GPL");
-- 
2.56.1

