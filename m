Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C27C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B88310F1E1;
	Thu, 16 Jul 2026 08:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sKjshJ2n";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F87010E057
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:11:08 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so15691965e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784056266; x=1784661066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V8cflk1NhiWz6I9y7ZdfFj/dVqPOluavFLdFslOwS/8=;
 b=sKjshJ2nJ7VLtcTC9NAGTz1hOfI8nX8EOIfIJnt+6mu+JEv7C3/UMQkaVzr6U5GrwX
 BguasDdSsIEuEBBNs2hagp4DcwrQ4DIxgBNiVIPnPeGDevZ+T0Yh2+F6nV8IT44HKfmV
 s2Ard/I0hpNEmDMcXPTQFzlOy6SRmVpozasn/8lV1/QUZK/nNVTA5hz28JJgorfy0W+g
 hgqk9R9b7EiboolmaqsjLmlHp5QR5COC2K3cb1z27D+dpTY4ADqQxXazpQ5UjRMPdrgs
 TLGfUyKfePhq/5hn5JN1hy9MlkOvnUt14kUBlmPqqBo6j47V8dizrpa27J+RT+tuQwDh
 0TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784056266; x=1784661066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8cflk1NhiWz6I9y7ZdfFj/dVqPOluavFLdFslOwS/8=;
 b=HGY1cEu81f9535cgr8KDIapL5wYrYt70GmzQlAzZv+3AWebJZWNXWmG3EatmvHJwXz
 SrqEaEamMjhAk8MyV9IqL7L5OrWxEcyUjttqWxbzeTJic7ZkGeuRcBeYYXr1wH9/jQAB
 zI9+Wm84BkerZiUCQusqGvp7qp7Svg33sSz9n1mtM5AJ1VyJzuRLExJ/DSc377QUi77I
 a2w8f8JzPbiVU790lQneRWgNgsAoWgqDfIdtcLKkKUNOHMht6aJm4QBO5AvPHlW4XG6Y
 7+BkPeKCvadIE1Mvy/0Plk27Angj+iSgtCTiZ3C9Hb1K7Y1dQNb0DEI3c0LO65RRBybk
 Oscg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIjgAT4kfxEIN1klsGHdmiCXWAzUY9IMm8LyRNzSaMcqPtZDp8YPpg6FLKT4vizJADH18i0j3lWNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUgUR7TlKa27wTYMK0BsElDl54YQ3qU135/mI2n5FkgJtkZGAD
 DR+uh7YYUq2kGvwaf+uH2EKayozgY1eR9s4S/rv6B6L8iLlqCJX8D8Cu
X-Gm-Gg: AfdE7cng4YOlZZS9cu+W7/IPfEB7MfvzII+yArV6Ud94WrXUOZo1ziuBe4dp9GH8o6b
 L74qZ4ApbeXK0WTNtTkUorrCM0QY/IGLV0tMfI7znsLlNqnBGLT3wmmevLqCE5CycLj0xvS4RFv
 RtTP26uZd0pMBCw/kSXk6BrSmzBGWAlwOIxNA/Vc+rofxUjbMuHwEf7LUGJXrpVkGh0wX0Dbrc5
 cTIXdgTNS1vR9A1Jj3+K/Xo8CHtvHbdAw6qdNPocZS7jJvPyVLgcpvpkCJMSO3PkSqNQFvf9skw
 v5b/6t9m35s1Ti4egdvmo+86XY8siG4W/Z+sTQf+kof57DDKE93WpWoOKEcdejQDkXHCQK8FLZh
 3iNPgpwV7LTccyl5+Dus19u1p3adzRCQOvavzXLMtqw7Y1M4ZdEQd/I/sBS4A20+Va8OoEeQz19
 uQut78s2C41dWYZWvCCGvMB7kSUhpd8+yAuqeHJYuyjUM/0qa50Cz27Rt0ZlVHDviMJYYnJrbRw
 4K0wTyvngEGNd7yay2Qzg==
X-Received: by 2002:a05:600d:8444:20b0:493:e2c3:af25 with SMTP id
 5b1f17b1804b1-493f88bd90emr119328685e9.12.1784056266292; 
 Tue, 14 Jul 2026 12:11:06 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net
 ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:11:05 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de, tomasz.unger@yahoo.pl,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 0/3] staging/fbtft: Minor cleanups.
Date: Tue, 14 Jul 2026 22:09:38 +0300
Message-ID: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

Solved some style errors,
parenthesis spacing, aligning arguments, replacing udelay() with
usleep_range().

I hope this makes future checks with the style script cleaner and more
helpfull.

Panagiotis Gravias (3):
  staging/fbtft: Remove prohibited space before close parenthesis
  staging/fbtft: Align arguments to match open parenthesis
  staging: fbtft: Replace udelay with usleep_range

 drivers/staging/fbtft/fb_ra8875.c    |  4 ++--
 drivers/staging/fbtft/fb_tinylcd.c   |  2 +-
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 drivers/staging/fbtft/fbtft-bus.c    |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.55.0

