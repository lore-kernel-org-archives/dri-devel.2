Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E10EC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA6510E5F6;
	Sat,  5 Sep 2026 15:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1iBZYJf";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F00110E14E
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:22:56 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6b1b881a8e9so373814eaf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788524576; x=1789129376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpkKAog1QJLuRwkyLizAo0StvAtiJvsvlNaL98jaQbU=;
 b=W1iBZYJfnZHML3rnHAb066gADtgGm/WRM6OARNLh3En1ekvYB78GNmW4iXIpp6opwQ
 ndSwIELf+VC+SJ2cSPOALmTFHSO9hVtGGi3Fiv1qJLm/Lx37f6z4dMUC5Ng+1El9YtYl
 NuAOyTLYo0VVb9O9A+l/FDODHn0l2r7INPnEdkGB8dQzbS9vlmPs6CckcrrYxDx5JB/Y
 uWRy4qlFhvYfN+8ajsp/iiYu7dow2WkJoIh4O4x/R/kqv+TIfNKPzf1TFgAuK8z2amlS
 hD/FZFHeS4RS1P0pnJ36aMRbiIDvSeJ15PcPpkAXf2tt6MDfOUG3b/qgVbBsFFP+0yXs
 sWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524576; x=1789129376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpkKAog1QJLuRwkyLizAo0StvAtiJvsvlNaL98jaQbU=;
 b=lwhpv3Nn035svu9Hg7VW78Dk1DYTwtM1vvD9cjBQEIOiegUGzzWTFLt+9dIHkM18E7
 +w23fBtk8Zt6X+AlLtpmsOdMGehV/E4pZhI1eZdPZcp728645jXGIjbB5PaCg2akIgOB
 OI7r9f3Jdis3sQN4SoS2MXKY1DhU9cGD6etRgkqXJzZThieC78HX3/JaDSByuyv5d468
 NTDeDmNNAqOk1yN/yXEchCKkwv5Gm1+PU6XFhJdwMDGezasw0HE62lvnOdEVHpIORrx2
 FzorzQrcS1JMOR7ia6KYWiT6n95Ky+jl41z+8iJ/3aVvbuJlMQ9hUPjjVFtxamCCXvBG
 Hd+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx354JzQPZbnSU8XA5iOCLd7s7ZCel+wVC3m2wxf77YBW1r25oV6ipWX6pqVf2MT2pN1iNsu71pnU8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkDkb45IpiOtit7pmLSoDBcqaaDgZq5Dv0lnLRVntpzDkptctw
 RXWM0vQiASY8EqvtoWKVrldv9FwvPsXhDbnAw/iUvZOaBkgJxvzoJV3z
X-Gm-Gg: AYBFou2nIi5dDQVRs4JjstwAdfUHEJP/P8sRgW2OFZgqyiji0+w8b5z6dU4exYfJj0f
 uhJv3+YN0QqztHtdsjFdbYeZ0yRMNcCQK1XskET8jKuea0gy37ZhjsLrgH2VKeEck+4w0AonPOh
 jZIwW9/1oPG6daiVAd7kMnIglvvviNQUya+gVHymPHIC0Dfp8+PQ9EM1ITRXjSjrdTkNWHBwffi
 tNTV0kuyAftLnqcmLKstWCT93udwuwudgANCdHcABDziyyF96f8+TIidQfIuQ7zCg4JKJ0ldn67
 ZqxI92rRSrQcinpLQrricLSNz1m7KCuF/38o2KsZXz1bZBJDdy659f3VjRviooBgVkqzRdJMJsn
 ygb1xGtuYEQW7kjw2njmGqvKRW4snFte/f1V7lhBBZpIOLXohRQw2GLdo4JW0ocQ/kG3Q7gyc8r
 32FX+IxpMZ6Lear4RiJr7Ocwwgoo4VNOWFgG6h5p8olBvosq7Sx1Lq8b348MuSLcidPVMIhjtQQ
 zSqXIqRKuFYJY4=
X-Received: by 2002:a05:6820:160b:b0:6b0:1b86:fb0 with SMTP id
 006d021491bc7-6b6fe59c86dmr3811462eaf.31.1788524575594; 
 Fri, 04 Sep 2026 05:22:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm7440220eec.1.2026.09.04.05.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:22:55 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: fix typos in comments
Date: Fri,  4 Sep 2026 17:52:49 +0530
Message-ID: <20260904122250.29879-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/video/fbdev/s1d13xxxfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index e80c806ef520..ab09790d6268 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -400,7 +400,7 @@ s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 
 /**
  *	bltbit_wait_bitclear - waits for change in register value
- *	@info : frambuffer structure
+ *	@info : framebuffer structure
  *	@bit  : value currently in register
  *	@timeout : ...
  *
@@ -426,7 +426,7 @@ bltbit_wait_bitclear(struct fb_info *info, u8 bit, int timeout)
  *	@info : framebuffer structure
  *	@area : fb_copyarea structure
  *
- *	supports (atleast) S1D13506
+ *	supports (at least) S1D13506
  *
  */
 static void
@@ -516,7 +516,7 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
  *	@info : framebuffer structure
  *	@rect : fb_fillrect structure
  *
- *	supports (atleast 13506)
+ *	supports (at least 13506)
  *
  **/
 static void
-- 
2.48.1

