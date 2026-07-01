Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8ACC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459F210E1E6;
	Wed,  1 Jul 2026 17:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="g0vdzVS5";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9403910E1E6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:05:38 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47721cd669cso233861f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782925537; x=1783530337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HrG3PRlY2nI3ihDFK93hWp4oS9XsKzt4hSWU1Z2kul8=;
 b=g0vdzVS5tqOLGw1RKE4vD2O6wAqQuXOXwaR5IuFmGaXJMqw2kR9q+x9hOjyeGevLtJ
 1C83SljLgF1reqFBumEJ+NDbdLFv+576sWNcruKLFDeuOK5lJNISKpfOvuroX+dvzvgy
 s5NpIjkFmfkl7wEzkBpnOtWATFasfhTO6NC5jX6BNVWTpvww7Vn8H3uHjap9JNCBm0Zv
 PELp9YIppgNf8L4tgWXcgJakKZWNG3Gsmpdw7MMDSqxVKIxnBwFp8t2OA4aXNP3sHhvz
 oKetvkg1iuDpXbmn0Iwjp2XeBXTKe0rwTlTLP0dUtvHzNeqYm62AnQUv20ijUcxMArp+
 XNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925537; x=1783530337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrG3PRlY2nI3ihDFK93hWp4oS9XsKzt4hSWU1Z2kul8=;
 b=Bsn4yXFpuiDzkFFIjD1+/nHi4458ERo//dX6G60+Zk2c//sGonK5opfekBsVLwjjeR
 a+cGIKi4wqDZeo37GdttZdCXoOEKfbiJNT7Db/aiSnfH9bxOwEX2l984x//N/gs8RZQa
 g8u6bfTFe3GAslj4BO8fR+NP70sYR0cO0inclkfs62m1P5TxuFpgxrWLk1QkFtu2a7IJ
 LejRDFPOvLQ2DVAI7LAGiWj11AClR5Wk12N4xgCbgrEjJzyL24exrNrWMb0/aS6S2uEc
 A0FN+WaXDR1WzEPdf0Mmz1u3z2SDS6MGG53jVy3UrhiBITeL1R09XWcCvgTT6Yf0VSBp
 3sCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RovS5/5bsoru+SbvsmlyS6T41kLePl15pGEPRD+NHZttJGeQ4Gx9+ejR9j+w9k/b4UuyUbqsbENVjw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMx1Wahpsi6sPkzLa9tUXq2dKg4FLEqdNtKiiE3o6td+sBk2DS
 hRe3+6SZ9qyAgQl6NFdNpOvn+oaXXlduEbl6TfvMgGzVl9EJaw2pa+cgAFe+W3lTUOPUzXI6jkm
 +/xVLynvK1Q==
X-Gm-Gg: AfdE7cnNAlwEfmCi03w/egSZ2Zg4OKMWhob3X3b1VKUf2mG5qhpsCxXkCEyuOuoqNLX
 VcJvJptmu7T2b6dycJR3+JRLvbJNxOzOvEQjT8Ar6dcAevsI1IFDW6eTrvzT+tdL86gXeFL9BuQ
 cb04ajzFrfq4c/QpnxrdRBmvJOvO1APiGRJ0lv7ggkRwEU6E4NwzT85IxrYmoHCscI/9MsKoWXv
 Gf1w1YJpiE1iCLGf+dd9qcys8gBkbG2phvJyEEEqstV+rzU7oxkp7B+wRw5XiEGVJvr7MPont7N
 r2PuE+DFL8zwfOwrzUjY5vUCDctqAj2BmDOmNP94Y0GY7K2EqQQYKOp4g7Tzs4/YSzYNVp5LAk8
 aVeGSgH43LV3ial2HebgCFFW1gfF0TIf7CuhpSsSdFkqBRWjwQ/btgfJKwIRqUNF4GnP+ti9MIT
 PWzXV5ibhKwVp1ReeyKYQYGm6L2aBWqBgN2jM/fSpFLsJEwcQzm8v8Rj6hb1ykFk9BNXJKY2hkw
 XRD
X-Received: by 2002:a05:6000:178d:b0:46f:7127:9f70 with SMTP id
 ffacd0b85a97d-477b3889564mr2285598f8f.18.1782925536585; 
 Wed, 01 Jul 2026 10:05:36 -0700 (PDT)
Received: from localhost
 (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-477db3dba0esm1205869f8f.7.2026.07.01.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:05:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Date: Wed,  1 Jul 2026 19:05:18 +0200
Message-ID: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=830;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=rwvGk64/KqGl/3VwHg3DfEAfs9Xz+w5wS4bol/ORnhA=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjORN26Upk1BzKM8GBO2F3OHSluAPF8+Oom2
 Ia+fLtfEJGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVIzgAKCRCPgPtYfRL+
 TmZJB/9MIsOpFCpH2Rs80TZubgLNnhh/OdPfNkjQEQ54y8TfXuR6VUxMRhZzPjOQiuXPs49rQm+
 z1ivVlCY/u6Is6tVLa3+Carp56kKNfUwFVsbHUiBrn+s2k4zcwED+S1Z/S3njUeulnGjoZ1dubU
 6FwB/Qd+ttLWD/n4yolloc3o+EQUW5krvjPnJLZHaTQiN7Ncj8oULnqRf+6e+725pHwNtxNXCaE
 qlGu3muHkBBH8cXpua7Csfpoiv1xNfNfE3gPtLjjXyAyAwYpNsZe4jqjVH8ME6rseUD5YOtI6VY
 bslewLxFNQYDzbrqHi+0Dn6wZ+/u+jri4Az/aJxLA8I5ZxDH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Hello,

while working on a tree-wide cleanup I found a few issues in the
drm/hyperv driver that are addressed here.

While the first patch is a fix, the issue is so old (from 2021, included
in v5.14-rc1) that applying the series during the next merge window is
probably the right choice.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (4):
  drm/hyperv: Unregister pci driver in error path before module unload
  drm/hyperv: Explicitly set subvendor and subdevice for pci match array
  drm/hyperv: Drop useless empty remove callback
  drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)


base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
-- 
2.55.0.11.g153666a7d9bb

