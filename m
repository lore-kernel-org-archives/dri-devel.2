Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECE5F45A0C
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212FB10E14D;
	Fri, 10 Apr 2026 19:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQnYfFa5";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3F210E14D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 19:42:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso25806985e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775850143; x=1776454943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pKFmylcZHwINDUdrqzoRnUP/ALqk61OT4L3P94CMUZY=;
 b=QQnYfFa5oQBMBlmOSyMASytn7WJGMwD/fw5uivkEn5ABNEBOy4tu7DiaLGyjHAIVn6
 UiR5/DE+8ZODPSx5Kj/NVQX+kq0tno/wOuSb5Xr11D7LREdBPuVZLriIpvneOr+rawka
 B8zVYSh9Ftp/SvzOlVMRRDWYanQsJ5t0SzirDt21EyZiKpPV/LQVolF8BRj80mjagJ+e
 MPCqBBZd86njDkluI3zDPntoRniA41jWzuyNsHsa4Ictq3VWDpSlH5E61TjlWOq2QHnB
 DCAVCrhoQ+tt6c4br7v3nru3P4uTeAbhws0hlwRxA7oqM4aqu827JLqOc2AD7vI+MPP/
 lHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850143; x=1776454943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKFmylcZHwINDUdrqzoRnUP/ALqk61OT4L3P94CMUZY=;
 b=fJ2oZYOu0fER1hKdCo4A22vicgiFMx0RaYwe93B1BcVWP/oJXBfdcpO56P9GR9xSWO
 OkVaEOhgWQNFJVlFZ52FZLg74E9gohVsi9B6RsB7r8vAZxjBtiKVS/6QP65Hwnym8yo1
 mLnVBwSUOybLtDZxOaeIWP1vwudWrhcKorXXUpG6JJoCQPMFN5/1nE2BKB0fOVr/3PUm
 63pLXKHprKi9wgAZBQMuzE6W3fX2HvniaHgRtH7G74l1ZczzpHp6clLH1Ma7SeXN7Lqk
 2nMRBJr1uDrMkllUAxmk3hWJeZSjbjC8bYDjCiOODX9TVJgu+mzZoji3tJQG4/rRKiIX
 gOfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIIYwdGNApWz9A24QsFtU6+XXEXCHR7GFwXBl6UMdw2VrWmlF2JEGX213O38qLjjVZWB37knHTmq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzB55RvL8b7rY4PbSTW3dNOVKh6jDEqSG4tyj71mhjgEceFcAZq
 fvjdC4NCFOxFbcqBpbherA65MWyQzXvwlMWovBEJi0uoCUsx5KMD0G9x
X-Gm-Gg: AeBDies4/YE1DdEc7YW8EqoeAPAOznGx2aOEBFQD8BkIOGOH/UIlqFHBAtv6pM9mR4h
 L1rFI849mQm/OKiE5faUc7lgVnUlpR7U72FRMSiAiCvArVAecUlSd0r1fJsraFoN8RpV8S+1pIg
 YlckTy9fGQZ2EnUzdxD/Ezvu3sldATitVWlCu/tIN1IBqnKezpxy7PyYZlyUm4gElG7ZB9dgFO+
 k1LskWwrW4V1JBfiuwSNNF+qfgM6gnwXSDZva3Cl25lfc22G9OaHiSybfUl8SbN6ewhlFyz8j4X
 8FKOFyE+roDTCa7FFLE2gpIwaSmRZzyh4r5RPJQcHXDdCPXNmG7W79jn2MtApTSRU5QbbRID1ql
 3tk8utAQJKjmd10VFsr1NcRnCNWik7/Dz0a5Kl0odtQUyqCIdQ2UvZUQeFzF71EN2uEh1iShjd3
 cFm2WQy6eM/jZoFXh9o5JH290ExHoJRUYOssLGQPBzxEajyTHmXkQXQ6vRtwKmdeAOHxGFng==
X-Received: by 2002:a05:600c:46d0:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-488d689dbfcmr57099565e9.30.1775850142814; 
 Fri, 10 Apr 2026 12:42:22 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d538c03esm95714015e9.13.2026.04.10.12.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 12:42:22 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/sti: hdmi: remove bridge when component_add fails
Date: Fri, 10 Apr 2026 21:41:40 +0200
Message-ID: <20260410194141.275998-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

when component_add fails in sti_hdmi_probe remove the drm bridge
and put i2c adapter before return

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f8222e60b1e0..839c80a7d954 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1460,8 +1460,13 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hdmi);
 
 	drm_bridge_add(&hdmi->bridge);
-	return component_add(&pdev->dev, &sti_hdmi_ops);
+	ret = component_add(&pdev->dev, &sti_hdmi_ops);
+	if (ret)
+		goto remove_bridge;
+	return 0;
 
+ remove_bridge:
+	drm_bridge_remove(&hdmi->bridge);
  release_adapter:
 	i2c_put_adapter(hdmi->ddc_adapt);
 
-- 
2.43.0

