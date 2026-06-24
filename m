Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855BDCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE46710E070;
	Wed, 24 Jun 2026 09:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcmpE49A";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B93710E070
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:00:59 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8453bcf7276so566582b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782291659; x=1782896459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cpWHohyYE9TWYB3P2wMAp3c2YwKiLndmTMYD9SWzcTM=;
 b=GcmpE49ARGpwuVelfAtwFRaM9L+7v9gdWszMkbmpM1YJmGSCOUeAw/c7phwr0avP+D
 +Vf0qYgb29CFJVXCVWuRoQ4ZhcwNqVp4oXUwNy2o9O3GT+Qnlaevq15a+rN6GfqhucDJ
 HAWlJEO+5ItZG3CIXw6dfbkramE98R4tT71cwNn8xiXkk7QZnsTCiBC+J69fc/uuxADy
 J3uPtJe88CENB5uQawwjE3Trn9mAvb0n4RTq5DEgvMeSzqDvkIwBYD7txP1ButEbfwyQ
 pdgcUuyHyauasnM+g0QNLi5pCThVhCwGa2XM0mUSEv51rgEiyjHnXTF9VLjxkTvp6yz+
 r4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782291659; x=1782896459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpWHohyYE9TWYB3P2wMAp3c2YwKiLndmTMYD9SWzcTM=;
 b=b0fHOUHvABF38j/D957wXm7eApiUvDpoMLQ7kejY7PIPLpK/qlrKStPXUGOkRjVUTa
 Z9evpelPhX9c3l3xkosduKc6S8Vu/qLxQzMxRIum6u3APZNhu1EMlRRct8X2Z659NR9E
 qPLC9rvWqO7S0UUcuWHk1Vi1wqVXI97wOJ7003N85r+/uYO658kpszdFd4LxJ96w/R1k
 NKruoV4pONLBAW6ZFDx+iOHJMIwSNBT7U0enTVyr0JntV6TdQI873ffTz1hLtyqz8TYb
 zTV+iwByFXV1y3nqsKvcVY7p+hQduNyI5Iy7qNMScqAfphwO4wNIimQ0Esv6XTKORULj
 5r3g==
X-Gm-Message-State: AOJu0YxqkernhbFsVsiAOf9bkjvLWjW5+5ou4yUNEYM0Vv7L99QCk1j6
 jfL1EokPY49G4uQUSxhXJqGGKJdFhkUfKVdlpsef0HL4vJvp5F7kvZ4=
X-Gm-Gg: AfdE7clZCqgyvs+8At7uX3rgcQtDswTZxK6bCtZGePgf4H1ipHCenV3f+wuNrBo87BI
 CTrhP49Bkj0ZKatR/tFUrRKJu9riPkukgvelhpUPmNwTrfHzOIb/Si4eECbxeiFffy/nMbFhbWH
 YSQFhH79r7aT7k14eoSTSh53eAzQeEiFbTkLTe0+r8ljug0aA+W6know1EXFyw/FHZ7KAKrOV9V
 wy5D6g5etclRhNwgxb8TMIvWlgEwkpS1cUazXZQGF0KrOtG9CICZYNZI5FEipQsmB5ui25TPyew
 XHK5Gq44kVVQgAloS1aw/zJJTMf+wkg1xQTLJ4VMMHZrlFm/jKZ01vn3U+KhdCTipwNED7ENOrk
 52INyod4NQdVx9KnAQmi6DyxQRPxsEonfqGPvMOcQ1KMdvoEPVc7HqBeTGTFRUqWIhtBOeiyH+d
 aebQ9aAaarn+B2Z3vHX0bG2Qp3rAjlsuURq8CdmPd+APfk8GLk/94vdLpJhAK8Ks5DTYgMaQdZt
 Cs=
X-Received: by 2002:a05:6a00:94f7:b0:845:4f20:3834 with SMTP id
 d2e1a72fcca58-845a2a9666dmr2947535b3a.5.1782291658639; 
 Wed, 24 Jun 2026 02:00:58 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d1b0fsm1658035b3a.28.2026.06.24.02.00.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 02:00:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/adp: Free FE IRQ on bind failure
Date: Wed, 24 Jun 2026 18:00:43 +0900
Message-ID: <20260624090050.87051-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

adp_drm_bind() requests the front-end IRQ before registering the DRM
device. If drm_dev_register() fails, the function returns immediately
and leaves the IRQ handler registered.

Release the IRQ on the drm_dev_register() error path. The normal unbind
path still frees the IRQ after successful registration.

Fixes: 332122eba628 ("drm: adp: Add Apple Display Pipe driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/gpu/drm/adp/adp_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index 4554cf75565e..20f38543d04e 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -535,9 +535,13 @@ static int adp_drm_bind(struct device *dev)
 
 	err = drm_dev_register(&adp->drm, 0);
 	if (err)
-		return err;
+		goto err_free_irq;
 
 	return 0;
+
+err_free_irq:
+	free_irq(adp->fe_irq, adp);
+	return err;
 }
 
 static void adp_drm_unbind(struct device *dev)
-- 
2.47.1

