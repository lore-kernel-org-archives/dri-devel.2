Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B0CFED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC5A610F659;
	Fri, 24 Apr 2026 17:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjPmBrTS";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A6A10E3CD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:55:07 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so7396643a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777038907; x=1777643707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
 b=ZjPmBrTSQ2t2HwKelCrnn9XPrJ46eqBR2imTuQUvmRRxYY+iyA90z8w2djUBaHpqsP
 CrBU2d9BGTJyo6x6pNNuLL6iY321lCcgxYRNpo+XfQMS4mn0YxWXtsfpB8t2nsqidTZn
 uzLoaBw4AP7exHXBJsVizpwiszLua5DzSPDYdSPAWvZosxPHJEuPxR0acA5F6N8thnOi
 IOyawPWBqr4oYM5Rs+sdIzspqv2Vyxde6kT281yyy7Fshn192Sk2jtXy5ob8/R4FD8T+
 QtFjm/t23m6fcYZnZHhf4cA5hooJSnTG4g0YdCB+qpJvkZzzkaS3WiHxEmbvAMroTGQ7
 dZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777038907; x=1777643707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
 b=BCi4L7qWEzEbr0SryTFsBqJIXrvU4EY5djPXOh1mVA6CIbafXLUx3DhGBE0l2FjRWh
 CBH5gGSWVs8gDSEsaAOHLZQpfTPMtsaQ5QIo0/EdWhgZmxvZ+cc/0BjiWPDjLUuOOc+q
 4g/OlG4TeDA0Sv5vPlfER9fwG9VyF39jwyAOndQsbqjo1u1s+TSzLGihie2iHVcltIYu
 61iuDYHEOV8rfKysk0fd4Xvyup2OjRd0OBZwHY0btbCeV1RSRVmpR4AfzkHZ07Wh/oyN
 xmGkyNqDffTbUXMRMA4zczRUAowyPQWnjnH+f8/rry8a1+CkHBPYm+2uYSWk4HEIXCyO
 3Icw==
X-Forwarded-Encrypted: i=1;
 AFNElJ83s2fRBS3Vt08li17kRjTQNBt/eyJCVcWor4Heza+VRNiydqixq++WVQa0Bs9nbItmvaTZwh+xilo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZWdBX6ggfWq2MmepD7RjqKSr/pqr5+9jAP+DcaxnLsE/yeT5j
 f/KyETIJAnExHXHG6akgbs2DAM7LkXAst7QV5B09zKIJZUGOwQ06XA0=
X-Gm-Gg: AeBDiescrbrEn5XmkH/o88cAouU9ry2JyJJ2779+UvgnG8JGvHcPY4EewMtUOZ7ZVYB
 KQF0jNDAtp5RQq+9E7I6kvLbuuSGpWNcfI3UXUgLq8fxMFp3nRAtyEqiWRu2ws5CD/LD6fMIMTl
 aEcYyXNmXftPO4ky2SEWjPfbgArne1tSeo/neTUgNwroa0vUDhnyWsEjjRjN8A6IxSAd0pxMmO5
 zcMAyzGpSbmOmTFbm9VtFzrPiGtjmw9tJMY4MZSyiCoonW5G9xp4q1JBGlqJgp7hAba/4vdAWtw
 Mfp82tLsfxyQSkrrUypckJhdSj8bzdD4alR4k6Bw703MKrsXxEsqiEQJsad131RUUrqYGY9YWlb
 Mn7Gl0XcQqITOz7iH/rmuaIAa7aJ4tiTWM2e2DNWsFv34EFfakjwKkYPASwNLCWmjjD2FCiOtfS
 kj72H1O9LcjgZAA565imFQd86ARMRU8UQ7vINpx2q/cz9bXLnSD4wacapXP3ohf4pllo6mnKKpP
 cJUBSqkzj4Csu0=
X-Received: by 2002:a17:90b:2dc1:b0:35e:30bc:96e2 with SMTP id
 98e67ed59e1d1-361403f1901mr33384481a91.10.1777038906954; 
 Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm24427479a91.17.2026.04.24.06.55.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Drop manual put on probe error path
Date: Fri, 24 Apr 2026 22:54:42 +0900
Message-ID: <20260424135501.18483-1-mhun512@gmail.com>
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

bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
which registers a devres action to drop the initial DRM device reference
on driver detach or probe failure.

The error path currently calls drm_dev_put() manually. If probe then
returns an error, devres will run the registered release action and put
the same device again, after the first put may already have released it.

Return the probe error directly and let devres own the final put.

Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct bochs_device")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1ab..5d8dc5efec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(bochs);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	drm_client_setup(dev, NULL);
 
 	return ret;
-
-err_free_dev:
-	drm_dev_put(dev);
-	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
-- 
2.39.5
