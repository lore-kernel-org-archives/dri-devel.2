Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99576606A331
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cY5iLcov
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ECC112044;
	Thu, 29 Oct 2026 07:59:03 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C7010E5DE
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:21:48 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ac7c7b3a90so377682a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179307; x=1793784107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0pQyQ0CR8Ho1izzTFJRZdAq2GCxbm4EhPXXwabrY3Jw=;
 b=cY5iLcovLNPT54I5fk2gr+RqbzfoUnmwiWxcXvBwnVmIbuToXsuvJ7eBMxUhpzv0mg
 zmJEB2Y/x9o/DkWHuZIO3Ngik//D6bJnJCd8dDp8fsnCOX1lc2Ee5/GB/QER1NVJpheg
 O6hWHzUAyiDYEIdbmdle3QFw0jcEcYQsvaCvsh6uTsDhlqep4rKA9y3TIxPJBIsvixbF
 cZCk5DPy6CJcYDdcOuFaHi3YPNzr9NYA2K7rVDE4P4Vtf6ff/Zvbg3zdQvunPio6JV7X
 WIzfoAuzFX/Q1KoAt9rY2WIEQLDMhKzu6TxT+x7usLqYVOryGnrNCm+gUHEREFBXHpHw
 5+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179307; x=1793784107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0pQyQ0CR8Ho1izzTFJRZdAq2GCxbm4EhPXXwabrY3Jw=;
 b=TeyM9S8tsyljtEQCb2n1JgFu9VaynPopwwCu3iuiyeBoZGrzdwR1E7tEvBo6gA3rwF
 XrRdwS+oFb5azbA+T+hMH7Gu2YclRC6l9ZH4eYXDcKY60qheQKlt9uzKSF7h1fy4Mmpi
 h194nQ3yYP+7O02S+Q3dKL+JC7Z6wXCVvMcjvnhUfBSL1rt2T4x+hrWrt6kcZBoIyg67
 sHO4d6Mhmbto9kQ0g94UutoWVZRj+QgWsxnDkjQ4G/gFn/UOhqL6Q+8La3Rsz9Ti5PAW
 a/3ugRHYlo7b9ixeYx+QSbIo+igGlywBxiYEPMSKyMhZDbf/zFnyz2I+fDrCR8OA9ebY
 Jlig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeIeRIU33ZAOX/Yro90nvnzbgyLlbRGJRxA4WJhYwAx7vSG2bUI8qscwg3sxmW3TU4VUu47EJY69Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBm2ecUkcVQ2qWR4apA5sAvJhdmfL9SHbozczib0+X0jNuJaF7
 FV0DdtSs4BzOJekyJOR2Ds7Tm8+Gu/vZaWEXIjVAlrZQk/mv2+aJ0ZJN
X-Gm-Gg: AYBFou0qp6kcCQzQy6rqY+ycw+kctA614RNg4xrnfIlxrASYwIZKal0ngfZU0s/g5Px
 cgkS+x2rw1U4U2jCC98n/9WrJQdu3JbChDIq7BcAQnL4En+ZRd+M32trXxXGUd5GzrJS9Zr+EUh
 Z8/w/uwz1q2f5NWcAPzhIPyOiJnwcgwZCN4s/RhtF/iTuhf+QPrcnltKh5eNLiZLqlFQZyJeTQf
 m4CIwq9mTxJYbrCSmSd+16v9Yq0oZyiy8tHv+E5HB/0ooJRQlZL6hQONRlhyv/bfcWGpAxZb4jd
 k1zZs5C2RxWHAnqfe27s8/02qsYl4JM3U069Aw48v0dDx0orRf69n669xz9y5QD0d5EjBoG64TJ
 kBFoD532E3x+QdoQjXjSkEqzPZnxH/O2oQCKhN1Nnen/Vi5aGfBQWPeg+K34Hxq+yfp5CmX7Ljd
 28AYaO5gkZax6CqxIJNzrlkSOoUeciAFiRgon2pDigT1AZdO/3Vcif/IOQJnO9UVbBIrJvfEOeo
 V0bm0PNndeFboD1jgxwrEuNizC+Z5tE4YNXC4+uyHejJBsGqg+REKb09RauGy2bU0RYyPnkXQsV
 4OeIOscjJ2T5GWmYksmo0BfLWIvTbDypfH1ctQr/o2Rk3eNrl0XFTlKg1m5rjCTTkDSGcEigXAM
 TTLOT2kkdhCU=
X-Received: by 2002:a17:90b:5863:b0:3ac:b3ff:b476 with SMTP id
 98e67ed59e1d1-3ae581836a6mr1316337a91.38.1793179307335; 
 Wed, 28 Oct 2026 02:21:47 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.65])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a27d594sm2256088a91.1.2026.10.28.02.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:21:46 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 jack@suse.cz, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, alevy@redhat.com, frankjpliu@tencent.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/qxl: Fix oops caused by missing free_irq on device
 teardown
Date: Wed, 28 Oct 2026 17:21:37 +0800
Message-ID: <20261028092137.1372286-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jianping Liu <frankjpliu@tencent.com>

After qxl.ko is unloaded, reading /proc/interrupts triggers an oops.
qxl_irq_init() requests the PCI IRQ with the DRM device as dev_id, but
qxl_device_fini() never frees it. The IRQ action therefore stays
registered, and its name still points into the unloaded module.

To fix the oops, free the IRQ in qxl_device_fini() with the same
dev_id passed to request_irq().

Cc: stable@kernel.org
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..e6c3d5ebd7c4 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -284,6 +284,8 @@ int qxl_device_init(struct qxl_device *qdev,
 void qxl_device_fini(struct qxl_device *qdev)
 {
 	int cur_idx;
+	struct drm_device *ddev = &qdev->ddev;
+	struct pci_dev *pdev = to_pci_dev(ddev->dev);
 
 	/* check if qxl_device_init() was successful (gc_work is initialized last) */
 	if (!qdev->gc_work.func)
@@ -306,6 +308,7 @@ void qxl_device_fini(struct qxl_device *qdev)
 	wait_event_timeout(qdev->release_event,
 			   atomic_read(&qdev->release_count) == 0,
 			   HZ);
+	free_irq(pdev->irq, ddev);
 	flush_work(&qdev->gc_work);
 	qxl_surf_evict(qdev);
 	qxl_vram_evict(qdev);
-- 
2.43.7

