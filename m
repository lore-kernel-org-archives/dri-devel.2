Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28620606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsQD2UTa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833E0112604;
	Thu, 26 Nov 2026 16:59:26 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1FF112604
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:59:20 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso72067775e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795712359; x=1796317159; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bvHu9PdIza3tZOErw9g2L0SR3Amj/3cA4iNu6SeWynk=;
 b=UsQD2UTaLQrWs3G73I/fyUmuObnxSg/nF2f9bB1GcPb/5lF2xBIGSsMjhid0sRnS4Y
 a7eSGNjK8EJlt3pTy1IvJUb3FPLWmXtvsqqdaHl8k8t9uUKHhNgbDqJQCAmBM5ivCGP5
 PeYtDIWgznNN+iZwW+kMdccTRzyBZ5kGMcCIXgKBIncDfSjSrH6hm+ptAy+VtJNhsgvB
 /AwxfdS1Y300KNV3oFDstdtyF0ms4QrXqBALqMYDMRFqStbxkTQh9pnJXJ3xwJcFxp+c
 vbQWop+qPHUr5l9dHVK0NEUitYrf17585F7L1533NpJUKnCn/UQjo7PyYg2yMHVYGkdy
 qU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712359; x=1796317159;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bvHu9PdIza3tZOErw9g2L0SR3Amj/3cA4iNu6SeWynk=;
 b=r5JXlx6p9z3vOBgxlZi3XWnUElJe3VyeMST9ijVhLzcUSw1jwTIOVObZwO1pUUGS2j
 MBil2z9XAPmqcIqO8w4KxxD3JE8ICk4qTZFqhFuEjb9d1V2zm0IthFGhNSzVcOf6/N65
 Q1oJofSq78pvI2aSNOM9VtM+lGqZUTl3DAzKNbMy2fMvMBEzkAB6l3H5vBj7KonEdrbD
 M1UMc3ASqyBqZU3mOh5HbbeAieP9Bgt3Ky/acdRHLeLg+fTQdQ0gh0ebUwkgVVa9L93e
 2KYTTjQdxEsRBUzdLlj+mFp4oR02t+WTTPfnKzG4yj5FZ35AqLlyUD8rKHYh/Qa2+RDV
 LTZg==
X-Gm-Message-State: APuU4Z8rlZtQR1iyimVK7NBwJtqHApj+F45Kiha6zV/8pk3Q5TxOW72c
 tNPOlcGCqPmogmAmZ4suiV2a+6z4eEZT7ubKIexnQ4zOBW0/rvkgRbsH
X-Gm-Gg: AZFdTZcIeat6TIbsVPL1ajzhixt+xgHyW/uXbZ/+5KHimV7xWWmdYfusT6SzWPbkLLp
 C7BcIqA1L2rYmj0IjOhTsnvwN7i/SXdXMfSvZQWJpcmq8aCP0JyL0wEGBItn0prFcIW10XtEfVb
 ogR+0jjMb3tf8hQF/8ZDxUBWhk1LjNUTvakDpkQ74Ntgh9DTF0Hyl+wpvcv4SE2KaJb1cj0mG1e
 0wbNcTthv19ByAne/aLitbto6gV17/c9e2tGEHeXOKEQ0J6mEGhm1xpmIGg3bR72EdlQv/xd1vL
 +srEfwW5TKd2wOBPz3Yx4FHzsN/M2fH+na+8kneRu1eyMxi2qa43/ava9uqv7A3CG29Z/f7+dqt
 WQLE6EA+/o7d2RMIDJ5mMWDWU1BNCrqTbboGLuD7uPYQlFIuO0OMDsA0b3O3kkLTDWNQHt17dZu
 i6o44u0wKB9YdYHZnSkvnVw6aoc67BPCvh0If+tpzvsokphQPwp5+ZrOBdNsHL9XLjqMC/YvT1O
 pMMixQDeJhWVIdxjHzhYeA7bMT1oBVtRFjR+NDPn1rwLwv3WIYvPMe0XHT0tMCke1enUSCWPc8P
 EHVdNUznflgtJDYIjniU88oAYHn7OUbbvBlehUw=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4bb88818156mr434532475e9.16.1795712358587; 
 Thu, 26 Nov 2026 08:59:18 -0800 (PST)
Received: from [10.56.169.198] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm17700731f8f.54.2026.11.26.08.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:59:18 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH v2 0/2] drm/vkms: skip composer work that changes nothing
Date: Thu, 26 Nov 2026 17:59:02 +0100
Message-Id: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4Xs2Zq2Adp48j8Mh6UsUCO0aSvRE
 P7dgvHmcZJ581aIFCxFuBQrBFpstG7OIE8FmBHngZjtMoPkshZCcmbc5F0esR5j8phGpqnmRvW
 KKk2Qdz5Qb19H89Z8OT7bO5m0h3ZjtDG58D5OF7F7v379p78IxhmiKivd6RJVex0mtI9zNqHZt
 u0DgeFoJsQAAAA=
X-Change-ID: 20261120-composer-fastpath-8e60c7f7e58e
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 reads a full-screen plane straight into the output line instead of
blending it there. Patch 2 writes the frame straight into the writeback
buffer instead of going through the 16-bit line buffer.

---
Changes in v2:
- do not queue a CRC for a frame that was copied without computing one
- restrict the direct copy to XRGB8888, the only 4-byte format vkms reads
  and writes back
- describe the new parameters in the kernel-doc
- Link to v1: https://patch.msgid.link/20261126-composer-fastpath-v1-0-aa7458d84a7b@gmail.com

---
Oarora Etimis (2):
      drm/vkms: skip a blend that cannot change the frame
      drm/vkms: copy a full-screen frame straight to writeback

 drivers/gpu/drm/vkms/vkms_composer.c | 124 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_drv.h      |   5 ++
 drivers/gpu/drm/vkms/vkms_formats.c  |  26 ++++++++
 3 files changed, 145 insertions(+), 10 deletions(-)
---
base-commit: 5ce32a0c94a827ff44ee60898c28060714dcff75
change-id: 20261120-composer-fastpath-8e60c7f7e58e

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

