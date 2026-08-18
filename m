Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A96C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6785610ED33;
	Wed, 19 Aug 2026 06:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrzyeNei";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA89510E4F1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:09:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so940289a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787069362; x=1787674162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sfYSNpVH5oSrqsx8hGUCJWHPk5k84ojPbTptWRX3wbs=;
 b=XrzyeNeiv9TWfmlm2Eujv5Xma3Tn+xkxxyiqkPH6D75DVMXS9vQBbb3U/RViHOLFm+
 wXSJLTW7lYW09CjAIM0W6lKkUPaYU3IMee9AFL6nCC9izrbjbV1BhWXPvXM1JVFme+7J
 5ADIsHPfHBAofOvg7QVUyiTRsKAE2bDa8Be9sNR/YoRVAolbVfCbfPIzYxOGjXoW4HiZ
 8jerfpN3u0upIdKkguLO5BT9Ob/L4R2sBrzCKpSc2yAATr4t/WRPT+1skX+YunK9Vn+v
 2wBO39fmBiuab0i+NyMZOwbC0XpXrEbbQyD2RceQmMARWEMDh+Qe3YOOAK5vNEOKgHXG
 vcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787069362; x=1787674162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sfYSNpVH5oSrqsx8hGUCJWHPk5k84ojPbTptWRX3wbs=;
 b=gkF2msiB68PgkkIStEt2v7s6nKC4Q5RN/SJfOIyONDBsjxF/dwDeMxmYBhPNUEe6bE
 wyhsgp+1/dRG7J5qUwiD+ckahurJMnZ6E3MVBFWcHTPS0tQljmERyLvmJApJ3LyXjGsx
 sgrXm4FMXbnWS69QzmDORcutLlaH549+fleg3k0Whwce0F9F/2D042gT4jhSDZ+OHvvF
 ib7DY6fsay+S6OFQjuBjOrt6ElnIYwg/lWd5/Z0f4mvBgGoOw54XECVo7tTBAmWQYVxH
 r4hQJHmgZrwNEFbBbOZJBaNXZlXBFTpsd3tI5OqWPtF/flcMf8KmEzXUZb3jRJyGZTc+
 F4hA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH1twsrPNX0dieGnuozZpLK3f+2m0uMNet2w5SwN8jZTAnsYU2vCq4DZYwWjU43zx497HPJj/5SmI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWYG4IRt5AwadmjANpYKiLdT0yEfRFluTDFYCnJUHMpJpoVr7L
 G1Nzrhb8eEqPHQFnNwvj+5xW71BO+kPtK0HdZLIutxsa0txWeUWTQCID
X-Gm-Gg: AR+sD1150YyALBCGjdcerKgh6/bGvi0G3m6J2AyqyQF7l+WFMLd1ktuOJRdJU5RHpR+
 OO4xDP6wkdzzCk+vwyzwvJcK0eB6GdD1XtyBFCtSXWvuW7Fd7WM3gvu1r5SwKDojI85eqKWZ1FO
 NQtT8/E0QNB+MmwSjYdKf3q/NuGt1oXd0IObD/wVPKu29w2qZmKENzlo1b+jL+LK/WoGu2DWy53
 Y7s3EdMplWjdTJh4T1dAwGvrkd6oahpNcMVWLX/rCjuJmpJ8UeL3UsAcWhlx0kuIQR6BVWbKSY+
 xaCokr40tq1AwBIg+2mEW3BOyOKuaQ1Sa3uXcdU+R8CJZZlkrz1RZ9PZa3loP2sxKplZe6nAY7y
 NhQ5YoF5ndopnjF5jUWfWkUnDn3Czt6fyIgqzWC9bkWgoI6xXRuf4I/Kp7e34uRCvutGRBVp1Ll
 hQb/k2JRiSpxonUUCp6mvh8o7YhVw3cKLybfcCmLxKrrkPz1BN1FzYU4FJ/dcetcj5737DJuQti
 DbUlGb+H2L+j1uWYNJPH/mu27HrXMb1aZrkj+A3/5cCCZFDJPwFnH7Bzg==
X-Received: by 2002:a17:90b:5404:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-3955f0c0364mr8769031a91.3.1787069362150; 
 Tue, 18 Aug 2026 09:09:22 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1469e2e5esm1007767a12.5.2026.08.18.09.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:09:21 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1 0/2] drm/ttm: two small ttm_bo.c cleanups
Date: Wed, 19 Aug 2026 00:09:12 +0800
Message-ID: <20260818160914.108313-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

This series contains two independent, minor cleanups to
drivers/gpu/drm/ttm/ttm_bo.c found while auditing the file. They do
not depend on each other and could be applied in either order or
separately.

Patch 1 removes a stale @ctx kernel-doc entry left over from an
earlier struct change, fixing a kernel-doc / W=1 mismatch warning.

Patch 2 gives ttm_swap_ops static linkage since it is not used
outside this file and is not exported, fixing a sparse
"was not declared, should it be static?" warning.

Both patches were build-tested with make W=1 C=2.

Sean Chang (2):
  drm/ttm: drop stale @ctx kernel-doc entry
  drm/ttm: make ttm_swap_ops static

 drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0

