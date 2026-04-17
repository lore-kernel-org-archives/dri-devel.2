Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9191F99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F0E10EAA9;
	Fri, 17 Apr 2026 21:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXrTLsz2";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B62810E058
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:17:53 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so237255a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776421073; x=1777025873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8iE4usfHbukw4GyIkJMsnZ0QQYr3hxZC7HTo6J/YluM=;
 b=QXrTLsz2178OrzJAqcFLKOATG5sq8jMc8lGaITPKCeqZobHS3FZPC9RaYF2bdNW+l5
 tCghIQeLHyydxiHJXAcC9uyc/gg44v3bd8kuMMhqUOIVL0xhdZjSAnceDdqNDeNPFr7/
 oifzuG+gUlrfPW7UhQijG32Vmpf6jO+aHKbVyxObBTUv3w41CAKobEZSDIeRSEwFFvPA
 C7UoaKTN+K7SJ/6kQSkoPChMvAYDmDh+MjEq11Zy3c3B0vRwwosRkB0HKRxbPs8KPEov
 Qn843MXfsoduuNtLibQfVePcVVIfr0P9NcgmMvSjqftQY+kPIJU+Wy6NNka1v3Rl80IW
 iC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421073; x=1777025873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iE4usfHbukw4GyIkJMsnZ0QQYr3hxZC7HTo6J/YluM=;
 b=Ew1H54BuX5TdaEhjFDocQ/zV1cGIedMg8LdmQX5ZVPHVIsUZJzJzQId1++zdAS/jB3
 WTXmvEQ8aTLYAi9gpTX4i3C+fOtjtSCX6mL/MUxnRuhzYij5k3R8zV/U04y4/JylWp8Y
 Thsj6K9obL94PVT47is667tSm1DI8TbpZxPmY5sOPQ6/4nHBEk1HBNFH0oxoVlFXlzI4
 kIpBZS8sKIJTZIMUZ57Q0zM38lFE8U7cHGGQgn6DTKgxHNac7VvzeFeOI95tLzqPUVcz
 JQlPIigWQJUjvFCCnui7GfRSfhXwnBjudDfE6eUNwxjgTj7V+OsqAqjHjMWgHmw1T8OZ
 G5KA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b/KC7E65NsHV+JMp4QlAKQoNr5BC+1Xsd71SRL5z5xoDMYlXPvZNPenlHH9rKK73z2bMfUTFYRs0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/O4ZQTNgG8yWK8uZlkZsz2JEjGh2EVukdS6sPZzapB/faoCM7
 OkdQ0SVy9tJzLFVkMZ5fC9t2bICirBdKFtSXTTwbqHQv4OsLNdCuHTiR
X-Gm-Gg: AeBDievH4zprUhYSeYZER3V0ayyRAkrKMP9/kEhcLSYL7YEpVHSrVhZaAJRJUvOfAiM
 7CNWdDV1jBwJpUP+XVJfZaV2pYVM/dOVFcC7njK1VWMinlQOoIxc9eWJopD5guGY1blWgHydR5I
 zS2laQotDp8bf4ZP6qSLiFG0MXdpOv+3H0mSkx6NO8SGhFWGWpxfrY/xglU9yYqNSVv2Vo0OMU5
 60BzPXiMItRCWS+1FKFdn8aNY0/W3B+knn4E0s/rJZMfkMSZgh5N2t1zzHPIp6pjK6WHMPn3Kny
 pdsmpbhfkkt6JO1eDIl0yRSZ5IlLqAa7bxsP0IgwNqidJIpl0BFr+H54nbDUM1SstgAEzknU59T
 I+b+gEeP9N02aBKeTw5/sUHOZ+gNoelV+AY3lF9c0rCql+9sst+HoxSZYnar9d4dtWw/4HXmNdB
 bMFD1bMLcIgi0Hik4DV/iNq5ftaNbN
X-Received: by 2002:a17:90b:4a09:b0:35f:b7f5:9cd with SMTP id
 98e67ed59e1d1-36140490614mr2164284a91.20.1776421073015; 
 Fri, 17 Apr 2026 03:17:53 -0700 (PDT)
Received: from fedora ([157.20.226.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f8f370sm1280728a12.7.2026.04.17.03.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:17:52 -0700 (PDT)
From: Prasaanth <prasaanth2k@gmail.com>
To: linux-staging@lists.linux.dev
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prasaanth <prasaanth2k@gmail.com>
Subject: [PATCH] staging: fbtft: fb_tinylcd: fix alignment in write_reg call
Date: Fri, 17 Apr 2026 15:44:57 +0530
Message-ID: <20260417101457.7599-1-prasaanth2k@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

Fix alignment of multiline arguments in write_reg() call to
match kernel coding style

Reported by checkpatch.pl

Signed-off-by: Prasaanth <prasaanth2k@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2..60cda57bc 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.53.0

