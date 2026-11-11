Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E66606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVuh6mi4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30105112102;
	Thu, 12 Nov 2026 12:56:27 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEEF10E409
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:02:26 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1960224f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794409344; x=1795014144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=meWNXvMASPE39vwE27i8e5aNRxxg/xlneQl/BaplwNw=;
 b=LVuh6mi4rpSQQDd32qHuXn+ehL3uBK2udzZk+2HR62381Yf5haLZpGM+m0k21tUicl
 kB2Vnt1dZPHvqkC2ErATsjvMmDqyX2VJeNsLMZMdbzIOvLDwIfURY+HsQ/Qa2mZAZBYE
 J4CCvmCb+9gZjYGc7qclAMs7GJvqreAqy650MOEtLYsOaXeUh6JuFRy2f5kQiYwuIHCz
 7BjV6eSgTo4/N4YvVrC4DlRtrFyXrr2FIZ3iXHcn8UHmLebcboUlJnGiv/DaGW7hw6kf
 r1Mv7XHyydovLJbxSl1BsfjXZ4MrHaQotuyebbCLAUx1emktnoDAxTM8n+3tukZV6Ii0
 UfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794409344; x=1795014144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meWNXvMASPE39vwE27i8e5aNRxxg/xlneQl/BaplwNw=;
 b=btJd2jKgK3DUAHaYzXcAkkUjTH/1uORW7vHVXedBw1Ok4WQz5crV1HbPrYWeXliwUv
 nr8wXRSxQTTa7cOZCe8bqAHTJfEM3Xilam+xJ1kpCXXM8iCFc8jcEwE+dKXNiiYB8iBc
 nwXQK6G5CuB3hCs7tk8gB3AcZMl/U30nmQ/Dy0saejl2Yzpf8/+epyiVW6IW7nOtUKJJ
 qatmXf38E/Si3bnVeRYZb+cpfASwoid4kxpweNxeWoEMQXEySNxj0V2koWdjkpr2Eqz3
 gQj2H7KRouIYagrfWwGxfQzdgHRBknnWBseDU+D+KsmvF2mht6s/0ScRWzgLhAGgM5tC
 j/xw==
X-Forwarded-Encrypted: i=1;
 AL+hErHXkuSbPNuw8hO8O99wruMPzgH4eA/TkKCMnXEDt4wjSuhr7fgecGdo6QbMHH5kMdsMUtsj+ZrdmCY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/U3dNphfjX/3BZ5QYhVkUemG/byJpZum0ZlAXP/rNEJ2/Yk4yb
 0oUbKWDpR21y/GA2Ij09QUOnknd7wwtwT11f/r6XHj/TRJQEQ+4VTwA8
X-Gm-Gg: AYBFou2rQQwryDjtJQDC6YW/H6g15rynzo/K8weGQxB03d6l3WAw7nDvxAbDGGvzkLf
 oIGgI61RlPXz0yluRtGZBWyWBa3YlJXhnT+cRTICnrDJKudTOjunbkiCnR3+qoIoRihW6PJHaLp
 xUXbWsgMa3oa/TxPXGCrnN3lkfure+oHB3dKSt7rDbLlfzToP/ngDDPjRQwhdLjzra213uY7vGa
 MhDdtlw9Agtfrs7v/uTXw81TYkMTTq6zHTNeF7LX6+Euwehre2mBCeU1+EQi1aHBwby9ruKBI50
 0BEAfILqwUKKuxPzkVlO+klLrQzoUt0cGR8MECVIpqiNRO010a/6U/AF4m0CxTXCfIJCzDS75He
 UNF1zodf6WnyL4GED0xqREoSnWNOG/bd1XywrRLbz1EoORYp1tpUHxsbCYZqFDwqrL/3P2A6mmE
 YJDwwdqed6ItZAZZG76qRV9R203UfulrnHMvyc6rgpNt0R6ZEgLa0bvlJDtex65dscsYLO8ZRdh
 s9K1Wk1IFjBMAxGa7r59fm3KjGmtDALTxEP2BdoQPwalmow1uNLQllz6qJyc8HjKVRglARv1Hcm
 QXIIwSoV4Ebsqfcc3AMIr/zh04cgK1cN3QOjxcj/HTyh6NcEeCA7ELs=
X-Received: by 2002:a05:6000:40c8:b0:488:8ab9:f74c with SMTP id
 ffacd0b85a97d-499c425746dmr5287776f8f.3.1794409344157; 
 Wed, 11 Nov 2026 07:02:24 -0800 (PST)
Received: from localhost ([82.77.126.113]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20327sm12054259f8f.26.2026.11.11.07.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:02:23 -0800 (PST)
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: Jaya Kumar <jayalk@intworks.biz>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Matyas <matyasdaniel006@gmail.com>
Subject: [PATCH] video: fbdev: Request IO ports
Date: Wed, 11 Nov 2026 17:02:17 +0200
Message-ID: <20261111150219.239706-1-matyasdaniel006@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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

Some fbdev drivers do not request their memory correctly. Request the IO
ports' memory so no other driver may access them. Only request 1 byte,
because the inb() and out() are used for reading and writing.

Did not test on hardware.

Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
---
 drivers/video/fbdev/arcfb.c | 8 ++++++++
 drivers/video/fbdev/n411.c  | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index b807cf07522d..6771a7409cde 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -481,6 +481,14 @@ static int arcfb_probe(struct platform_device *dev)
 		printk(KERN_WARNING "no IO addresses supplied\n");
 		goto err_addr;
 	}
+
+	if (!devm_request_region(&dev->dev, dio_addr, 1, "arcfb") ||
+		!devm_request_region(&dev->dev, cio_addr, 1, "arcfb") ||
+		!devm_request_region(&dev->dev, c2io_addr, 1, "arcfb")) {
+		retval = -EBUSY;
+		goto err_addr;
+	}
+
 	par->dio_addr = dio_addr;
 	par->cio_addr = cio_addr;
 	par->c2io_addr = c2io_addr;
diff --git a/drivers/video/fbdev/n411.c b/drivers/video/fbdev/n411.c
index a3677313396e..ed0281939d37 100644
--- a/drivers/video/fbdev/n411.c
+++ b/drivers/video/fbdev/n411.c
@@ -165,6 +165,11 @@ static int __init n411_init(void)
 	if (!n411_device)
 		return -ENOMEM;
 
+	if (!devm_request_region(&n411_device->dev, dio_addr, 1, "n411") ||
+		!devm_request_region(&n411_device->dev, cio_addr, 1, "n411") ||
+		!devm_request_region(&n411_device->dev, c2io_addr, 1, "n411"))
+		return -EBUSY;
+
 	ret = platform_device_add_data(n411_device, &n411_board,
 				       sizeof(n411_board));
 	if (ret)
-- 
2.55.0

