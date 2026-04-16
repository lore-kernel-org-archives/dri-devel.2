Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64222F8E4B1
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21ABF10E95E;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kkMs3uR5";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BD810E8E2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:47:14 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82f69adeecbso937441b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776358034; x=1776962834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzDxwYfpurj8xr015y/mH2mke+/hLRvGAF/fQ7dIVG4=;
 b=kkMs3uR5/9zhSeQ7ZJ5F35+39YZy2FQgpSewo2VCQ9HX1XJ9U+0hNugiwDOV1EwYbF
 f9o3XQMZXm2xMtxAWkSs0L3lZNslujs6DfF2FZ9oy+hUMFkzUH9JvAN08GoN6MA3nfFd
 5k0/PM+T/yx1/BGkZWaFmcUQ03812RzilcOIxW3TEHc4XaaHuQkYNPDSUJNvcg1YHs4r
 GOHXy7t1ObtrwmvqjvcNkg4Kw9ITWxoACaWml/zri81RwNEoXStJa+bGNkjy0Gpofled
 EiqAfPnScGXF6/61jxKnoyHeN/4ylX6dTa7slGqPo35z6hfB98CIg05V6XwQaCa7ypFb
 sQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358034; x=1776962834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzDxwYfpurj8xr015y/mH2mke+/hLRvGAF/fQ7dIVG4=;
 b=I7Q5wEtFfzzRMyi3fGXb+plqkBnK8Y/PrR8fLU9FGwf15Y3HtzmT1NTMDBtpeDABzs
 N2ZzGTjr+Xe3SQ8RX+i0VI5Le/SuvwMD3WGvK7hAqkjgfAa5Q9pNO1l5AYRljD/SghHF
 y6hG18AXey1UmAiPSH7M0uBnX7zpLEtUUGel9+z6a9hyGsPPTvzSWA5oh2t41L5pI39d
 u9u+WgEiT1yDzZztPbF8N+iSVTGuH6LfkcwbDa66DAPxOLStRhRe+hfIG1PNc2vwby5k
 fhpFqxF0rM5Mwj94Q4808B4l4iou0T+KL+hygXLszLGBqOJhpJBCEMIiPRTROdZMKVXI
 rp0A==
X-Gm-Message-State: AOJu0YwUXjjipLqmeXC+0CqEaPMpydGQr0O66hR0eqdOPz29VOzxVSMW
 /8YOqO5av9enx0Vwrkuv38mUbG44akMRRscCP6SGFqCN4gLDasVLEXwqTC9kIMUFOcY=
X-Gm-Gg: AeBDietMrOm+DzY0YDfQFFsYL1lp4tHx0ZYxiA0/TyJbScCeiPgA9GuZ1wYmce8TdPh
 HiaJ+9rLZ/5AB+KF+TTwAyvguC9ho6aQINRl3E5njE/S8wy4HGVU7T7YOoLLQ31DGQ41EgnH0KH
 gel9Kxyrd5k1q2V2fXqwJgXHz1Ov7VvQ/iAEXOYz5z2WycZ6yKS57Av+HM5p54NE+5EJ3g4Q/xi
 ggW5bdce4OrL25Q42+e5HovA6DhQ9Yz9MKo2vsbxWiAEW11f4g7M/dHiRG2Pl29ubFmoaVFALvq
 cqJLfT8us4Z5bmpkvhOO6C87rZ4Vuczf4IxNx1QXsYlKWoVPFos8uAl3BzZsuPeBH+i3cN7Ut9o
 YRUt8vDxYbV5qgW1yQpkkh+Ylq4liVz9TaYRXhztIWPh71MY2+y7Ey8h6YopGsxerJ6zOgtQDiI
 zeSigVdzt6ovc1sm4clnUCWnOJVFXGpP+gWeYX1ITwMb0AF8rkbhFgWt21UQbSKc3bLAiYT7RAX
 UxSwivauvCxP3n+syQ+AOGCrS06Kj4lliI=
X-Received: by 2002:a05:6a00:21d5:b0:82f:2070:2683 with SMTP id
 d2e1a72fcca58-82f887eb97fmr103721b3a.21.1776358034016; 
 Thu, 16 Apr 2026 09:47:14 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local
 ([103.151.209.194]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f88a57cd1sm28808b3a.34.2026.04.16.09.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:47:13 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
Date: Thu, 16 Apr 2026 22:16:43 +0530
Message-ID: <20260416164643.153765-1-sachinkumar905846@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

Improve wording of a TODO comment to better describe the
intended optimization. The comment now clearly states that
only the changed display area should be updated instead of
refreshing the entire screen.

Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..4984aad9c 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -414,7 +414,9 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: Optimize to update only the changed area instead of
+	 * refreshing the entire display
+	 */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
-- 
2.43.0

