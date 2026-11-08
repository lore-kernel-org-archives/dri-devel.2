Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620D606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlCBL85R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBDD10E832;
	Sun,  8 Nov 2026 19:33:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FCD910E832
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:33:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so1321945e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166423; x=1794771223; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULPlCRcRnS9OCU3V953l4VzKGw19SLsXrW05Cs1Xiyc=;
 b=OlCBL85RYxcWixZYqbs4slnc3+FMHdRYcV73ZnEPj2zoNagmQiol8HX1y5jV5Cp/hr
 3cuavHiaFkW7JCx8Ws4r/O8qGYIhPrUDoCwX9Fp5Vic4OXe1GvIK1j65/bXb/bYi0QTc
 5lbXGle6uyN1CGRfhHVXQLK5Z879f/qAb0EqfgYQ/IYcG/1wCSoqqRGBXmlt5b5IOA8b
 rYTldFldliloDo+um4Sid/nO4BDAM+LYjiR3bbk/5C77jd4bhyZUlMCf+Bc03xdbE5ok
 DjhffPpaTzZRJnzwGN5k0aqRualtiFYZIrHHCzoNTbJIigVb5NCt2u9uFpLJNybUdzXO
 6npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166423; x=1794771223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULPlCRcRnS9OCU3V953l4VzKGw19SLsXrW05Cs1Xiyc=;
 b=KGW/ol2pVPsFtioCBGFNlZ+7fRczmHoSUuVQDFsYd0BcLOl9NuuJH4bIGDC/fyomws
 LCZ64PTZD5YvOpdpAY3StwZFFzUQSbDnkLVut5ActDDP/Y5lhsZzTKdEXMfRVCyxQD5V
 kqnpOaKnTzZgl6mEZOn2f3OezYi6Qzjg1+RXZh+9wSr6+WbZbfBCzAj/204R9dCdyEF+
 nb9CD66RVku/y4NYc7onAFkM5yfKY6o/hKBKUwlAjb5cq7aOy8vfQSqtv6zkjvlgkk7w
 SDmHPu/qcYK827foxvS4vMmt0lqyUzOk5gkM1Xy8yKZSuxJebxnPOdQR7P05tL+RJnBd
 dxpg==
X-Gm-Message-State: APuU4Z9vIz6H3BdqlVIRJhpXDx82cy47tAzisicsQT7A0Df/eAPIGdlv
 Qy7BJLX9JFt0Q8IxotqKvlunKKgucYUn0/K56Tg9duPh0ikrkyuSSdMW
X-Gm-Gg: AYBFou1QBPT6oWMroznr+XMJ49qt5wSIjU3pFc9vTy2/ocbWyCoh7UoDyh5EXzKsi9f
 pI/wPxxiQI2H9c8SH2wRjx89siSXEOHYuNwEgAt4sOESvitpflLWkG1PgKNKtH83n3WDN7XBYPT
 XzZUcTsJxKgls+UdE69qd/GJkEe7f0zCan3kbSHrUGb0HNyQYm5eqaPGrM8alZMlIlt9LabFH37
 nY4nZogZkHzKaQHBDqO5UKIr8tfJ2ZpGCB2QvLzbWj/kTCG/+n0RCBgKD9TK6QWGhV8xapFCpgT
 PPdOmyIOO6hq+U7Myova848d9OlEC4owZaz1Khq/ZbHGGqbSX6p1S0PlsWf1w0OOL/FD9nXwnez
 +B5noXzjgpDVI4mkYq25GELnY2c9gPWd3+nMqPHg0FXHBYxG4sZx2a7Zflm7DKD4a1BvJaAf31d
 drLtju8AX1gjdATnzTve2ryE3UzKYBo8Yxkk0+Myde9Id25GJlu9nCJQPIiHWR51zu7ZGyMJfcH
 RD7JeqUHhAsjiPTAI/MWaKQc1sAL8eDLs1ppSPBVBbCCjl+0Jre7iR99mjAwKLgJ6azDJn8WnDE
 6c0xtlhTWw4gEP9ErUpSsjXi5CFQJ9aTK6kQVXxTRQ==
X-Received: by 2002:a05:600c:8b34:b0:4b4:49d7:bc25 with SMTP id
 5b1f17b1804b1-4b963c6d78cmr39472145e9.21.1794166422600; 
 Sun, 08 Nov 2026 11:33:42 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm105422115e9.1.2026.11.08.11.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:33:41 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Sun, 08 Nov 2026 19:33:12 +0000
Subject: [PATCH 4/4] drm/ci: drop the kms_plane pixel-format xfails for
 vkms
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-lut-v1-4-f762d70ae4cd@gmail.com>
References: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
In-Reply-To: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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

kms_plane@pixel-format and pixel-format-source-clamping are listed as
Timeout in vkms-none-fails.txt. With the per-pixel interpolation they take
160.1-167.8 s and 78.9-83.8 s locally; with the precomputed LUT tables
they take 9.70-9.84 s and 4.87-4.90 s, so the entries no longer describe
the driver.

This patch depends on patch 2: removing the entries only helps once the
subtests stop timing out, so a job that takes this patch without patch 2
fails.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
index 029bd4956e85..6ebcc7d89fbd 100644
--- a/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
@@ -16,8 +16,6 @@ kms_flip@flip-vs-panning-vs-hang,Fail
 kms_flip@flip-vs-suspend,Fail
 kms_flip@flip-vs-suspend-interruptible,Fail
 kms_lease@lease-uevent,Fail
-kms_plane@pixel-format-source-clamping,Timeout
-kms_plane@pixel-format,Timeout
 kms_writeback@writeback-check-output,Fail
 kms_writeback@writeback-check-output-XRGB2101010,Fail
 kms_writeback@writeback-fb-id,Fail

-- 
2.55.0

