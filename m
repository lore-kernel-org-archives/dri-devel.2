Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E40FED3F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0052510F664;
	Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjoGw90o";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA10510F437
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:12:11 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso4636172a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777032731; x=1777637531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zM6Iyznzwn5aDn6I4+pyGHdSCpNCUHeTWc3+0jbTctI=;
 b=UjoGw90oJTLVN+3W7hW98vZa2Be71kgMjuRvc3ECw+m33sJtSeWphNqdT8YX+ri3VI
 iwcL5rehlaRkFMy8nmjB6N2OsWlT2MI6VR9g4nAxevjuJoEpghaMutS8igQ24URoXc9i
 QbSJ4zlDXKfQ70XKyTkWfYmVnXc5bIDyPGOOTXcgXwOIa3Z7z8tPsNmj7lwqVidEFU4T
 6zpV5LvXpHL/yiwS3kd86FaHlL0Rmqr3JDKQSIe5PaIcTsQ70yCH70Veit3195tTTD/s
 Av4be3XRpQPBbqjcaDCA0yfUED9mN0IP5DwpgKk+ZYOOU3BIVdNLuPEU/gpHarkz9k9F
 QOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777032731; x=1777637531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zM6Iyznzwn5aDn6I4+pyGHdSCpNCUHeTWc3+0jbTctI=;
 b=a2on0qzQOYtlH7hIxbpjMzttNAFSy3RC0p6rByu81W5cXFBaNWiqDgUa3K88aHCUnf
 0OVJfsXbVGo1OTaJhPn2ACyl4HB+qsdHem+Cb/6DRUuLI6x1I32oUAhhFV7cQzx/9gG8
 Vz0vaqA5opOjK7tjKNmVgyKjVxuudg0LqimO563SR3pjJpu+F8bUIbkxVZ9b1KpkU9qR
 3evE/BKgb4xdk6/qO054IP3SISOAemwzktjfnPadS208TmV+Zgo1FwrVA7Qjfob3yzaX
 Dhi9rvYCKAhW27WcZenDUWQkoqOvnzmLFRPJifitolhF6ztOrnLvYiQNUtyjROdmKlzN
 uz+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+N4pXpDU2Qz9Qbq4Xno2a5pbcimTMGN5VjBRv8Ucu0HY7w4cJdEtFmocHE9p0QXWJJ8YjVBjrJpkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm3j2Pz7lPn5U+bXIl2ntI5XD1EJoI+eqkALZ6j2BQ+4WleCQL
 kImmnLYDuf7ygfvkTVGtzyBIK+YE6gaj1dqUG2Ap6ZCS2lXxhIo9GaI=
X-Gm-Gg: AeBDiesxHAi9NK0J+naHWTFeSc9ofVN2cmN8hK0JDbiCjosZb/QdqLo1Y5A69n3g4R/
 3zLtVNCpQNhLokKr38EhHRT3/Y+EUbJEZorbMExGviZxEJ/0sWk6S2lAJfaQUj7o7s8hFI/sKg4
 auRX3Vri4oeeFo9ITF9dmH/5sU/bKBRrP9t601bGFuTepv8humCyLgydYx07k0zZ2BJlb8bZiTz
 0oXtBpxV5shcnbRZ4mnopxiG2xCtG14Z1EVshzSKhrGejdeyLVlIChomoGdf6FAHsnSgh/7w37m
 mkqkgDvCxz3Xt4QkFnXr5Ye7KV4ZMaR6iMtU+s1+bYDipSxGfSAHeF1Gab5ORvfk1JmwMlJV+BU
 BG3oCuUwAk5ByUslJyr2/97o5imfZBj6RxegBI5pTpBjHcAWnLa9fyyNWDCjgcgAddOkIYiQix4
 QID6/2VMdtC9erxdpcVOLwRj3CHyPA5JD/9JcVXrP858jT+N6dy8HrnQcBrLkmDjysX5UZwm+4h
 xaRr5rB7w==
X-Received: by 2002:a17:90b:3c0f:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-3614048b2f5mr30642540a91.17.1777032731227; 
 Fri, 24 Apr 2026 05:12:11 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm23482206a91.7.2026.04.24.05.12.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 05:12:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] drm/sti: hda: Fix bridge leak on component_add() failure
Date: Fri, 24 Apr 2026 21:11:51 +0900
Message-ID: <20260424121206.14558-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

sti_hda_probe() registers its bridge before adding the component. If
component_add() fails, probe returns the error directly and leaves the
bridge registered.

The remove callback unregisters the bridge, but remove is only called
after a successful probe. Remove the bridge locally when component_add()
fails so the probe error path matches the successful-probe remove path.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/sti/sti_hda.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b739782788..9223135c93 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -783,7 +784,11 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hda);
 
-	return component_add(&pdev->dev, &sti_hda_ops);
+	ret = component_add(&pdev->dev, &sti_hda_ops);
+	if (ret)
+		drm_bridge_remove(&hda->bridge);
+
+	return ret;
 }
 
 static void sti_hda_remove(struct platform_device *pdev)
-- 
