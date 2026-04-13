Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AFCF34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DCB10E49E;
	Mon, 13 Apr 2026 14:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQF4wZyL";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0BD10E49E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:13:41 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2b461310af5so3509895ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776089621; x=1776694421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+qqSEWuusa4ngNGb7Rrw9FBrzRc6uTBdINaFH/HdeE=;
 b=BQF4wZyLnX4JMZom4demDPYHfmbUz9gwXEsnH7gm1sP0Vadj335Dq5YAJ1rRG5lPjN
 mHvFko2bqj4gXwIh98JKO3ePlZl3j/9Ssic8xTOqKzovtYbrllYmhcFixU6DUa/KmDkX
 763oytwxFPNszKl6382Gxj2c5fD5ee+FI6pY8K2mJzYWaRW83LCRRTB9B4W3g7bJq8zq
 4u7uQAmdAyEqFhmBpShkUfihF5HTiinUBnCDxsMV2b/LXmWrsl9q175DkcMZufsI7mXV
 X0PxBl5B7KkWdJ0ZRLa3dIMQfPzIUl7Cl0UMnngpbpo+u9Baj10seliZ2sTnKS8H6uFG
 fkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089621; x=1776694421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+qqSEWuusa4ngNGb7Rrw9FBrzRc6uTBdINaFH/HdeE=;
 b=K0vaLYk09f9IlDgLwo5S02rtlGuNUR8L6H19A4dTeLvhjY5gD39XvKYSlfEBjYCmy3
 U1UBn4TIFL3tYmoAafg/ghTgpWk+IVlq/V1ZwWYD1fGE62lcl92LVZqpsGWJkihwSymY
 NYPgWGK0kcjJl3OOqkKnj1Kkv073dQQVCBNkJ3rCYovSVxnVbBc8mvX5rosBezTKnL1S
 Oa9X12HxYYgYo/EdHNMLD4ViyXs7DQk5eln2NLQAvLTF+PyozkqxPIoL8gEfSqP8dTRI
 psh3HXjDVFIuYyCqdRvK96bB4dzc29/gBhdnZPVDAd41AxvpJSwpHEGP+2+KP4ozBUbP
 uUVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Enebtl1eMgc/+wUGrB+Ah3mcM+9JC3ourNXwbO0GIlR7ty0RfEZdt/umCUxsapDcooPNbEMEKd6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnFnleQ5QXJ+5egReNK90fTfAwW9diRLynQ+NRCOe1QUD01nHZ
 ieetkW/XOXeU+bFWzrM7RLF/deZcmL4BjItRQW3UlQmGdptExjYnPXGa
X-Gm-Gg: AeBDiesP0p0sLp7oKbLS8AjYnRCrI25+b3rB5KKVyk2UHzT4B4/REp2n7Uke1DFHY1u
 VhSboC946lI5BIa/9MIynHZm6QsRrNTkPo48svUKRbll00h63CfmOY1g3DXM0J79dQS8UV0gvpw
 6NfGlo7mo+TtlzfzYEtwUGYDlsPqO7k2XNzXpVpzYyGe76Dtd2Q9OS7D8xmE4OHF6aBiR8zVzmu
 WoHaKBp1mYyrcco3ih6UJWw8uNHreKGdg/W7Ak2gdA6qaI7jKY60bA7qTvbVU5OZTy1SX90H0WF
 85DCJCzjnhHjWhEEAfKcVfHKz2QU+8sPDrS38PEXjsrNp4ncJca/fdrJRaSnQZVr2JeuOTUrfyi
 uts6b1RuvNi++2Z/dXhSbYNwGDv9f3dzHkBPK+9Y8jNCpzefU76917tbz3sp3lOTSOWdBh7XF1J
 Oe7h2TR5LNPCqJPsPAcd5P67Pl7TDN+hcsRCmUPywmEQ==
X-Received: by 2002:a17:902:e78e:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2b2d5d0e8b6mr126999785ad.14.1776089620819; 
 Mon, 13 Apr 2026 07:13:40 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4dd5cfasm144226695ad.18.2026.04.13.07.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:13:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Guangshuo Li <lgs201920130244@gmail.com>,
 Vamsee Vardhan Thummala <vthummala@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Fix device reference leak in device_add()
 error path
Date: Mon, 13 Apr 2026 22:13:28 +0800
Message-ID: <20260413141328.2954939-1-lgs201920130244@gmail.com>
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

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), the empty-subdevice path calls
device_add(&device->dev), but if that fails it only logs the error and
continues without dropping the device reference. That leaks the
reference held on the embedded struct device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by removing the device from host1x->devices and calling
put_device() when device_add() fails.

Fixes: fab823d82ee50 ("gpu: host1x: Allow loading tegra-drm without enabled engines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/firmware/edd.c   | 2 +-
 drivers/gpu/host1x/bus.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 55dec4eb2c00..82b326ce83ce 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,7 +748,7 @@ edd_init(void)
 
 		rc = edd_device_register(edev, i);
 		if (rc) {
-			kfree(edev);
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 723a80895cd4..63fe037c3b65 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -477,8 +477,12 @@ static int host1x_device_add(struct host1x *host1x,
 	 */
 	if (list_empty(&device->subdevs)) {
 		err = device_add(&device->dev);
-		if (err < 0)
+		if (err < 0) {
 			dev_err(&device->dev, "failed to add device: %d\n", err);
+			list_del(&device->list);
+			put_device(&device->dev);
+			return err;
+		}
 		else
 			device->registered = true;
 	}
-- 
2.43.0

