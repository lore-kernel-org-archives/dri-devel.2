Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00159C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E7D10F3E0;
	Thu,  3 Sep 2026 07:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/7OQ2ZC";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70D410E9C5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 04:50:59 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso914413b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788324659; x=1788929459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gL9gEW7ayUvR98UbsWW5JS05cT2CnhJ1qoyjKu7J0AI=;
 b=I/7OQ2ZC90fv7n+N3sAemqdx56xnoTba1c+IwybVqByL36J4fR+6Z+n7i+/FpMZ954
 fVdbclsZWMInpC1RC5LgyIQ04NWfO6qhv6HuFsTFW2tj/K21yCVQHy2R6K+1WhhIQEFU
 m2NuFyszOOZYsQNEVauWS1NAGBwjJEdasKf52BeZTrerPtBRKtf3zjQgzWEDyhVRWl4x
 sfih3P2ALTKW2ox/2NqqqzzZRKLD/gAZaxgFAtVK3Ap+pTuQWM3PDvHZPGfP8RXtkgM3
 qzBQGWYPQ/E35yzu+0TAaMhpFOPB3C2aCbsW3S2x9OQ+tvi6AqfyTk03PPXUcNKxPuA4
 Maew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324659; x=1788929459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gL9gEW7ayUvR98UbsWW5JS05cT2CnhJ1qoyjKu7J0AI=;
 b=N3MOfgIrfty+/U8G5Yd8p6pgSKjRRaKxLYrL741DwBFQA1Uff5v8UNsdsOH1iFcCjm
 M7KTZA4g0+tOkD0SRTNhg7COdXiCeK3zs4Iew70KTM4J3Kt8sv75740B2kpa0XRvGgof
 grBOfBfSKLzd7IMuG/7KYhPXPQTYACT/I6ZW6D8RRhz4VqQ76KzbXpJYmQ9tIF3eqm3V
 9vUhbnvW5s/urQrZvFwq6I2Jx4FKRIVe7SR+tRIB3/rTIgiNJAsGZWigSBIr1rXb3S8j
 69W1EHs83zpDTZFNiAH1bsW3CLQAOLs5yCke7lfuiooucjzIf2NCZoPME83iCvPlkUnR
 n/nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgQXJb+uoc3kU0lc3oWJCHn7eJwxjqvVaTjIs4eE5o/5L4KkNr8GrRdELseatiLOsQkTw8c0WG4Vg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsiX4dqInHM0E9eNtDplQLrYwP7IsjAOj6GEI0iUHGxT8EmQn9
 7fDFeWaUjy36EJi60EvITpl7XYsu6ljYdId6Fs+Zya07ZhUvqOZgvPRH
X-Gm-Gg: AYBFou1V76MkEPPdH9qVk3yld80aD54MqnYDjSm/4LMZG1uuRWsETsVVVDU2CpEPstN
 VgHlQ3S6jiMJBrCFBD3iagJotOxSjyPzwfKmx36o41f5LrIISeXNeIluvaV2LHgobq13uHQqmQz
 nIXnUvCfdq5JSiL38nmyyfK97KtWReatw3jfQGZGHKYxiEg5D5ptsk/RPgMhd/GjoP0YNgwkYvu
 Fh18Wnt/bZPY4aZJnGLIkrbPaLyBVVmWIS1rLV4waRAQfP132IdcRdE7WDVQVapiuTs1u+9Ljfy
 TnMt1Ci3guJBaHdsWbM25El7utc3zMpUNEwj61W0tunsYrrasf8SpKFaczJRkzf9Gxr050eMhY7
 1wmIi4r5QkyGzppOjwPybMRngGSvIdF2QZ2Z0xkoMVqhq3VPoR7SIPDVpXqsXbPgdKVGYColFpD
 JsPqQy1vNZ97C/ugMWEv94Yo/Jk4rcXdXIjQSHuDhbzzWuFdXBRtLoqGKHyx3w3qM3v2pIsxYiA
 1HsF3sl
X-Received: by 2002:a05:6a00:148e:b0:847:893f:2d0c with SMTP id
 d2e1a72fcca58-85ed1d0414dmr4031929b3a.5.1788324659284; 
 Tue, 01 Sep 2026 21:50:59 -0700 (PDT)
Received: from Kalpna.localdomain ([106.194.26.137])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc11f44a8sm709997b3a.56.2026.09.01.21.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:50:58 -0700 (PDT)
From: Anshika Jain <anshikajain196872@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Anshika Jain <anshikajain196872@gmail.com>
Subject: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
Date: Wed,  2 Sep 2026 10:20:26 +0530
Message-Id: <20260902045026.7442-1-anshikajain196872@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

If len is 0 or negative when a define_fbtft_write_reg()-generated
function is called, len-- underflows to -1, causing the subsequent
while (i--) loop to run approximately 2^31 times and write far past
the end of buf.

This is a latent bug: nothing in the current code prevents two
adjacent negative values in an init_sequence from producing len=0,
and there is no guarantee future or out-of-tree panel definitions
won't do so.

Add an early return for len <= 0, matching the existing guard already
present in the sibling function fbtft_write_reg8_bus9().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260830161529.14500-1-anshikajain196872@gmail.com?part=1

Signed-off-by: Anshika Jain <anshikajain196872@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index e03aa251c..7d7135571 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -20,6 +20,9 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	int offset = 0;                                                       \
 	buffer_type *buf = (buffer_type *)par->buf;                           \
 									      \
+	if (len <= 0)                                                         \
+		return;                                                       \
+									      \
 	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
 		va_start(args, len);                                          \
 		for (i = 0; i < len; i++) {                                   \
-- 
2.34.1

