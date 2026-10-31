Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72415606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aR8i0C3L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7BD10E0CD;
	Sat, 31 Oct 2026 03:32:47 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A5310E0CD
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 03:32:41 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-369f33df08eso2753842eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793417560; x=1794022360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mnYw2aLxaOMLunU5/NMlexxvi/OdOgAm+kgTsrY2DdI=;
 b=aR8i0C3L/7D+Q8SclsWS7HZgqCYf1rhPyXMfO1Jfalp7jZx3D1QUPHL8E1YR4KT4ZQ
 1K0N6ByhhRz7KezoKl41S1/6b5FZ2R9Fpn73bFtYOaku1ym5N1P4vu9LhO9zRoXNTes9
 rmLt51c9Ma+Q+lQjf8TMx5ak7zP0DuI8rc7KYDrSOXtBB2+9/mqeo0e3bTw//0nNsrDU
 jBinT/uRmPITa0oc5ShDG99ei/GYs1e0hzcsYEtHdIl1HGUyLxdsPP6m04ABzQoo7K2I
 aw7XP+66hpaPryNqLmMqfz5JOVDdhvnr8Tq8GBHmB71AdTOsjO4pUqpBv0IKmQt/fyRo
 PtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793417560; x=1794022360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mnYw2aLxaOMLunU5/NMlexxvi/OdOgAm+kgTsrY2DdI=;
 b=CpP5lKb0hRHNkl5xIFy5NNq8/0KxzF5NOC7OgRsx0kOE5r0kq9EUAAxrw+1GyO3OaX
 ygJaZZlUMpyIjks07QnomtR65vFJ8a6aKTIfUrsdlewMRkQDEqBrKFMxt5S7XPf8TBpR
 J5oztiLpVAU5YDCX+/VdCuTjuNZ+LkXnfMPq0nXxaAyi2Nfhkv+2ZPv3TzRdJ/Ncg7Ws
 RP0J58OKzSBNO2TOU7cfz4H0rGJxJ5uSNVVPBVrZU/AJQljMID68h00Q48eWbuCTCa6D
 BcX+VKesO2Ucj8Du5YNgydAX+w6ZhMj1DQCcLl0mdIYV4oycyyv2KME2zllQA7aK2syR
 RsHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZgortbaxakZWUUAiuEydZRdD0EBqMzjZt2q/xZCdUaMo5m/RRpqyXL+qYkF5ZziLsNGJ7BZnOhOM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfOHXz3ER0bWHbn/6rQKeMxMoW4+//ufQgnDLJgoLhIwQ/jio7
 7gpOzU8gX1Gcwl7LccDGqYYvNoHw2bbFodpIIWsJzH2SNRM7aqBHKnwn
X-Gm-Gg: AYBFou1Qhgrdxw2rHfcnDDdV4MRI8pPF1Xsm6VcoEc/Ap9o27feAKMbVNXqKxFC5Nk5
 /fh03JAT7KIXYFEd4OEgDMBTweAUHwnRcjydd8A03jFcNfPxOUgHIr4TjAk3ku7xkvkXT1MNSaW
 D9IRWXQMvePUFjaz0R7dAlJojqLbZn4nI6pWM4MqE7t4TDbejT19kfurVIIcE07craUJ4X2Jj09
 KMm5NF4fNCnVbqMyQTMqtpQyfALH9trgTKLzqeDyO+hgoHSIf/kGwaRjugoW5QVAFOFNCCZoKaq
 DdbYviV/PG+g4c3r0hVx5Na/YDtXsdHLHfUkMdCR3S3kV3x+Z6d47rZu/gvrEY0DeXOonGncZ6m
 icUoQ7zgZdEhbjWI5TLIz98OE55rnSQpcKk0C43R2hh808QaBYutjrzvXJlesbWgVi/qyPUWd93
 jeK/ChtgXv7lU8/KxV5QNsoxinhMbfQ0QFrjE/fowye687YVvRCdwXT0SBSVXIZNm9VGfaSn+5j
 pLM8XvFMl7P7sc5d2l0lv5XkDJr6JDqf3s1RGmH9pyyhh/NWl3UrZqukExnUP3MCUdkrhY0d0CF
 ipUKW2tXK3ho2WYhcgsY9X1RW71f+qWU+q2GXPKJ+QRKbGTnJgH3SWulBpaZ9NyaxrjBary0ES3
 gvb+mUe8P6jP+Fe294TExNtBi/51T8Vs6iuB4BljcainHFzSgG6SKNiyqeSDaqLwlcY6ZqerpYo
 iTKzqC3F7Uw9EARg==
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id
 5a478bee46e88-36a4236a5c5mr6199404eec.6.1793417560169; 
 Fri, 30 Oct 2026 20:32:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429000f8sm11634639eec.13.2026.10.30.20.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 20:32:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: preserve IRQ probe errors
Date: Sat, 31 Oct 2026 11:32:36 +0800
Message-ID: <20261031033236.2490968-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Preserve platform_get_irq() and devm_request_irq() errors, including
-EPROBE_DEFER, instead of replacing them with -ENODEV and -EBUSY.

Found by Sashiko AI review.

Link: https://lore.kernel.org/dri-devel/20260722075803.570532-1-panchuang@vivo.com
---
 drivers/video/fbdev/pxafb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1682345fb9b0..1912cfce28d6 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2306,15 +2306,13 @@ static int pxafb_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		ret = -ENODEV;
+		ret = irq;
 		goto failed_free_mem;
 	}
 
 	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
-	if (ret) {
-		ret = -EBUSY;
+	if (ret)
 		goto failed_free_mem;
-	}
 
 	ret = pxafb_smart_init(fbi);
 	if (ret) {

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
-- 
2.56.0

