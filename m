Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AABEC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A182410E4E8;
	Sun, 23 Aug 2026 11:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WWWhR61B";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD8810E4E8
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c16794450aeso360659966b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484036; x=1788088836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ITWcZ5jiF/pXFpj+1UU2crAZw5A+n08+7Om7GUXkowQ=;
 b=WWWhR61BgkRuYNqDGV8BHMB1rD3E61T5+ulCoif+XCb35SsVWAO7lAjipRFyBIkRsE
 PtQqDWmgCUKOoZ107YZ8zpSyXnKJwZQ173CqPN4Yec7/+Oxc5kl4reNjZpnaV9WeIIrb
 u/pzkK36bRJ2h/L6ojIE3hICp3HckkPLRp6apNxblBEG1CYC0zEP2s12AAFUAy1E4qJN
 yPu+4l0kFCEHV3EKApbZDzhFzocQX1n1uHjUMG2LpazB1E1ONjs9Gk2XfvGXxem2lRP7
 pQmoabwr9OCqOGfYVESm9i3xqbrqeZNZKoNIB5QjryEAC/YwovmLyPYAI3PL0OJXK7Ft
 f6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484036; x=1788088836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ITWcZ5jiF/pXFpj+1UU2crAZw5A+n08+7Om7GUXkowQ=;
 b=H8sGq/l/qpnuFsGzLB1bQ59x7hF1+fDInajyVphZRrja/pHn2cmFv/RM2x49jKC3mq
 AjZ3+Y8ZH5bR6reITgW5QD/jLKGom7RJiP6ei4Xuj2Dvs3EZoUb238bbI8It5avIZ1kP
 bRYNT9i8WjYvajv91lktTa90T0Pus5dI/MbE7/Ejf2g6KA+eX1awcIHpF+6HOKeAkQO0
 OSt72OH/jvemRzwBVNtYv9yEGbD7cw+ZTnjQehRzQ9YLXNT0B+pxrwSafLvVo8JTUTJS
 71O8YOYO+0/I1BSTWh1F9xLwms1Lfop1Xgq346pQKqmuoYVnsp12i34Q98NFXmehFS1y
 FTLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTVXjOGo5sANO3C0lVLA3bc3p87PXr5Vy8uwhgAtIQ66ydC+SiSblJF8UNxzvWGBaK7QjShKWIuHk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lA3G/q+zxfW5ofvNdra1/WcaZ2wl64nsfB529eZrygWz33EaBZ
 hZ5DCIel6nfB2faKnYyjeJIrp1cD+N+r9HJkuyI6rgygFBaFiM4bg5C2
X-Gm-Gg: AR+sD13E6T3NjOjfz4E3JB9MtxvnLGCOYwVWdZzHTpAOldjC3RCaX6kygDJlT3ToS1f
 hf/U+oLBjq3pTn20qPxCOuASj3I27fbvl/Z7Ku5FUu6dR60MuOZcxpn5fMQSVKLuVMaGVpRY2pq
 1YWzbDTb4+i6+Sres1BKRIdhcE8vX+Vr8W3K509Xz21D0zBIFjcMrH316tVOHTTjnQ6U6YVKjtl
 W/yq08PbnlITC/o9msY/hnamflcLSFGR0n7d+WVvR2yw556iTFwGUqFT8Neb+MmLQzR6e9o4HjF
 FKa/CbbspBwve/xu33Yr0qAfEKoeSVyygyg/ztAGsM1aSZNtJh+jIJAMohzVbQIV6gksZaadQb8
 IviSdeo/5ygFpdO99N26uTaBFjYfEpbg3etdvH7nC/LjeVSs5WoBRgVpT9HX60ebFbEE5owYfd+
 58Fp9rP0bImUF9IXHyyApJi6sTlX8ckVbJ2SSI7nShnszH/+Hc2KpzPuglgY2rgOHkdQ==
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id
 a640c23a62f3a-c246a6559aemr1554170866b.13.1787484035807; 
 Sun, 23 Aug 2026 04:20:35 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:35 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v5 3/6] drm/ssd130x: Constify ssd130x_write_data() 'values'
 parameter
Date: Sun, 23 Aug 2026 14:19:56 +0300
Message-ID: <20260823111959.17029-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823111959.17029-1-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
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

At no point does ssd130x_write_data() change the bytes it receives via
the 'values' parameter. Constify the parameter so const-qualified
buffers pass through without casting away const.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 8cf1e9c84a81..73e7f2a8b730 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -252,7 +252,7 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 /*
  * Helper to write data (SSD13XX_DATA) to the device.
  */
-static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
+static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
 {
 	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
 }
-- 
2.55.0

