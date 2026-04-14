Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4865CF9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9256710E649;
	Tue, 14 Apr 2026 17:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="atHnFyN6";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F7C10E657
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:55:20 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso61113745e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776189319; x=1776794119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rf8OgzXCc3GK03N8Ybyu1WwrQsy+n9LdPm4jLPj8t8o=;
 b=atHnFyN6sKT3zsG8iLwjC4Bp/A754c4BiJ9K9KuPmnDz4WZY+z3mp/sg3jtI8+VbZ9
 A9NjCSoe5Q78Ff7Ul2Auz0DgVHRVPGJ4tEr/AIYSJV/jXG70uHNMNrPKoCbDQmiDKdj4
 h+sSxetY1CNisSzFmx0lh1ftiiJtAg3k9slVnIbqNGugVrgzswjHrFV6zVQu2tW0jLZA
 i/6UszeaXYbLiiqRIkmhfNEmVfA+DT1rcmMVxJIryH5iYMTCg7Wz1cruG+uU9NM+Dzz9
 yfMIr6dICp2LSQrkYCe4HfL97OSazrucFb2x+aY7QqBvKPuqFi4e61bnukZgovRZ8WIn
 lfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776189319; x=1776794119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rf8OgzXCc3GK03N8Ybyu1WwrQsy+n9LdPm4jLPj8t8o=;
 b=hFzkw5O7OyUS/R3oBeHLyAKtuCkIjk4fv/2IpND4nz1Dn4kybv5OhA5/1wNRkDncpd
 mmnLwUVH6x162G8l78Fluoi3OvOAsiof8X2od0d9MboelNcAay6f0lbzK4NORYfj81op
 aeJfktuKFkYMK/z7O7c/dQh55m3PKiXJJIXLom0UGgidJFU0PULqnjMJos6YG6j4YxW1
 RI64u2IMl4M4WDwAylRJx6/eDLt11QMc4rlvHwr0dpsoM4Qpw4DFxbvPi/eDzA4jZ32R
 Jk2R2D8fsLD6TOyPg+aqkVgw05sBZqLt/bLox2cjzwqDs64T2fHbIJYVSVnEKNtFdukW
 l4UQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IGGYB/zmSZqq0w5bMKDYta0gnWXVVt4fCxAGMLiDGVumXvq3ZmTeS7mIc7qXwLbKGlKescXVzmd0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU2GftPWEDn6qjEQzXEVOJu9mMR+CfEcQvnRgl7Kwt6L14rsK1
 54rrxO75cqcwXC5rF9sVKQGYFFTTiCSo/eny66OjDbIs0CVPOgnHzjjH
X-Gm-Gg: AeBDiethitTpMw81Wg7xArXjLGvUp84jfgMiN5iuDpVWxbvTtUx/WU57UPFtESnRWMr
 WdF3kD0HyYENVPhDRBwLtPAagq2uIq0kWi7DJzymxnSxcG4ec+Z7VnWFpvPQHkKDa/0HYtD1JFQ
 yIcLbx+guT44deJwPwrX+Mt35L+7a5YHu3nlBoSPtrgmXMV1+G11b3yxRyOf521oI6l+sJEMsCO
 5Lrb3yPqDMAiXHQDqD5cxNabfzxnQ+PvunIBRGYtkeR39o/U93n3bm6BpDQF3jzK+kw/XqS/2Gj
 qCCBGkV3E7K7doxMnDh2G6iNQY96of/A+otYqhkKDUZ6gQ1Ju28o6/rzs2ITRlAcqskwrH1E3Ac
 PtVP9D7uC0ZLbRWQEkm3K7UAkay/kSTwL9eiar7+xl0BDMinZfku5MQgFH28L+u1SvaIxsJ8UhW
 nPWaz4UR3G/ofiqDfZ4Xg1ZIXWAO2F/dLS0cfG67V96RJvn0o+DF0YVYgIi0JazxmeI8bzBYI=
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-488d680079bmr245982525e9.13.1776189318981; 
 Tue, 14 Apr 2026 10:55:18 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:cb49:f403:bb20:cc84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1df12sm150436425e9.4.2026.04.14.10.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:55:18 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2 1/3] drm/sti: remove bridge when sti_hda component_add fails
Date: Tue, 14 Apr 2026 19:54:14 +0200
Message-ID: <20260414175417.144625-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414175417.144625-1-osama.abdelkader@gmail.com>
References: <20260414175417.144625-1-osama.abdelkader@gmail.com>
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

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/sti/sti_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b7397827889c..360a88ca8f0c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -779,7 +780,9 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return PTR_ERR(hda->clk_hddac);
 	}
 
-	drm_bridge_add(&hda->bridge);
+	ret = devm_drm_bridge_add(dev, &hda->bridge);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, hda);
 
@@ -788,10 +791,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 static void sti_hda_remove(struct platform_device *pdev)
 {
-	struct sti_hda *hda = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &sti_hda_ops);
-	drm_bridge_remove(&hda->bridge);
 }
 
 static const struct of_device_id hda_of_match[] = {
-- 
2.43.0

