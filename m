Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0637CCD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601F9112FEE;
	Mon,  1 Jun 2026 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmjaEdYi";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED88112FEE
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:51:37 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso101635615e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780303896; x=1780908696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8h0Vcf8skzh1HCkF+Baql0QKCO6gO9JoIlPn80JDVgY=;
 b=gmjaEdYiAZy/8Mbfc57SVtFx/tcr1SR0q99V5ATL6VedRFFiFaQUkZ65zEAIt1T5uO
 VF+s/2Z1p6f/iM6klKJvCY3PIrmoQiDUbCri1eAb+VS1emd5gSCC08DDLz4pC6D90fvz
 sMzAlyA8cAQscmwlm74wjqWWaQHPKSvnC+6h2vlNKKvMUB5hfzvAQRgD3xcPrlmt9cys
 ztXuBdDWLzMsR7TFpU9FDOrYuXqmR5uj6pRtcL2oyD0nvGQaCKFJ2+T+28KJC5tJ1nsx
 zuC1Sr6Vh6nFKF9XjgJT2ufcbtirkgTLkz8O3vXdmZXbEYsQlRDgTv3vQxKmmZDCAEeY
 v1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780303896; x=1780908696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h0Vcf8skzh1HCkF+Baql0QKCO6gO9JoIlPn80JDVgY=;
 b=rlBZo589MvUPCV0SKjT5mC+6n+0wCGeMznKgo7slfYDXabO/c1f614ZnuuYJNXDjFx
 p6RsFPqr4b/B3qWRKZRNp6MEk017fW3xmk1bVg/mVPemQgsUjTkmJyl+IYQu/J1Dv4GP
 AfxDEA84wKVOsuvQbwh6KJ/ryhvSeVGgtys5i6bDSGAswDKmfPgA0Vqg159o7T5EPm0h
 zmGkTPfO4l4+AfkqM4ogbOYVXlCEiGrE7oqT96SGO8St335mjpHitUYEnktmqdX6TKDx
 Zba3YcOPdV9kzFGmyu42O5iL5YjXDUbO7K2c+Hci3iGRx/WdBcOg0dxOL3+rYP1YldyY
 kFNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GtYFyMCH6JUYeiCp7PCjZU6ZLo9SCd/hvUKihitYfPHjW/FU/w69dCjcc8rQCD8o2MM5ljZ9Kjb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdLrM6uctaeg5QNW+11Y9Awnn9kLpaqMDRsc5DD4JMZrDDxcEM
 WXCPjmZM4gvTmDTmWFHVPe9lX0sLodK6qIGFm0u+AkDCRwY9PE3f1RE+
X-Gm-Gg: Acq92OHRXrHi6kI2GOw/t9/20GAfF0wFSTZF3Sr3+NYZzWZXZFXy/pUVf2PUx7hRjqr
 lwYZNm7yu0NKhwY6T3YTQevcD4UgXlesgwT04eFnWzcdUda0JxFmxryOeA81F27d8i2GdTYru3t
 HNZBeZsEV4vYdDTtrBDCtEixd0NSn2q8YXu0nZK065qcvHWti4m/A48KVUVzpyojGjDHaMcY4bN
 qy6JAuTkW4K9/IDWTVaqXTugt+CjiikkJDBRGZrZpcvU25PyrKZb94xKBzk0B8stprnw8+svbGQ
 7dIn2uId+lKqhxrItWWqMePLuiF3GwCZ/He0/T2eidqEoafLakuI9O+P7t6TBVcMiU6kTFADDF0
 NKGdOsKw4LrhhqED0nGRLb9pays3PSZXf0brU0jDPor6kRqo4CHq0ZLPMvHVrR+coi7gZN0AqhZ
 c9v97qAgg1KSZ8iL3mMtpp7Jo5SzwPB3ezsG7kWaN3zzl6xm761g==
X-Received: by 2002:a05:600c:c092:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-490a2959113mr166624725e9.21.1780303896013; 
 Mon, 01 Jun 2026 01:51:36 -0700 (PDT)
Received: from laptop.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09ab80sm72337915e9.5.2026.06.01.01.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 01:51:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: michel.daenzer@mailbox.org, tvrtko.ursulin@igalia.com,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/todo: clarify drm_syncobj error TODOs
Date: Mon,  1 Jun 2026 10:51:32 +0200
Message-ID: <20260601085132.683087-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Before I get another mail asking if somebody is already working on this
clarify that the kernel parts are already implemented and we only need
the userspace parts done.

Add Michel as additional contact since he wrote a really good summary
how that could potentially be used by compositors.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 Documentation/gpu/todo.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index f5a6139356da..f85c4585750d 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -896,10 +896,11 @@ complection of submission.
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.
 
-This should probably be improved by implementing the necessary kernel interface
-and adding support for that in the userspace stack.
+This was already improved by implementing the necessary kernel interface
+(patches are on the dri-devel mailing list ) but adding support for that in the
+userspace stack is still missing.
 
-Contact: Christian König
+Contact: Christian König, Michel Dänzer
 
 Level: Starter
 
-- 
2.43.0

