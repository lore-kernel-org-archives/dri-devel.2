Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41843C5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905F810E2F6;
	Sun, 16 Aug 2026 14:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qxiI+RT7";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D2010E142
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:39:59 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2caced6038eso11555335ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786714799; x=1787319599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFlMnEpfoNO0V7ZJ+JnOg/5mm8WDZWgSDP9SMNfE/Ss=;
 b=qxiI+RT7lc6koxHvh6T87X4mCK/4CC3KwhDSdxluknMduwDBrU4CEaodjDb9xrkN43
 B232dvkWKPIhmimGAufR6SX1T06WxYI7meydDUAiVAX+sTo46YZoY4juSF7ScduoR055
 Gef/AjisJaXTSvxMrSI4MGQS34lhZNkefxTf1pVCrLZxw4u+9uISVrYgp4oSfjvkz0FO
 rPoI0sZsfYcTNyTSZQkTqMX9vv6hjPb4+tFSv/aqE/HT+XZDJO6Nu+xXNgHR8e9FXJFE
 eZ15UPNfMdcGwBh+Qwbxe76jU7L1BFMNcvm5OEAlfnmhygAbPrK+YsPvmNJdF4G1RPKz
 YFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714799; x=1787319599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFlMnEpfoNO0V7ZJ+JnOg/5mm8WDZWgSDP9SMNfE/Ss=;
 b=tKyD16VWPpP7cgx4/pPjpumycYrNyAIN0cYher+Zv+s6rL4YYEWhxK/5eFQFXs14G0
 ShyZfc3d+aOlf3zrNt1S5T+c9fWcLaqYQFo07mlJ2nKV+3IA3Dyinu8a8aBQNlXCFB06
 nKr86aSjx87lMNoXJU/R/cIrNu8mGwTK1g1rEWJ/lYw+20ZzmyA8btJ+JU/1ayg2ISAP
 W7jK6Bd65GnLATL1o6Plbc8NjEp/2gA8aNZXES4ryoovb43nLbBNMaVd1/ufje77+9BA
 WeI1qwxrrjYyCRrXGeNX17cTkXUtAe63NSckBq3yanU/7ni5wsE2JbuxZMgtdfV/jNnK
 gt4g==
X-Gm-Message-State: AOJu0YxBPXhOw9OxEtjvRU0q4b5M8kw9IpL+YMGn4fAG5AYsxHYl/ul9
 C3K0fmG9Ad6OndRN1PvaJ4DDijUQMYttUyEOYxT+rExJm1iD5On6ue7l
X-Gm-Gg: AR+sD1009H6ZbIOq/UuVw26yBGteZcoJqsBNcRd1fgQ4gY4uPIGyZDcZ7FdR+JVXp3y
 GwbkyWv4PCywf2xxriAZXr+xcEtjdUBNKoXzdeC3IAW85i+34f+315EbACcRatqnmFETgVpkqkN
 RIAzjGXflDgBwFgxFsTxdwGwZWw7CUs0F8C+YBKzOeE0V0qxWPoE0jWddgFCmikk0Au6K8R7ayJ
 JHwjDaw8c1VipRsn/8Tw2cAyv/FSCyq6aJHZ1YtTOX71YUlpy7ggx44keoboBj/RWir0wOITW+S
 SbHtuMmRY+hGIOs80Wvl/OGyGJxwPjR+EPywcd1APioIdz3BfVX+2WG7XuTWNURksI2xhHHLiTf
 o+h0WPOFjWJib4UfnJjlwXzBez0lIvacWVPOKH+cE0iDOixMTvPLOEVZr79Lu9OeRdRWg5M5Kl5
 nrwlMN9Fmi8D5cx/R7xRzVbhR5auTFeVGbpeaaX1fTJJkP36fPJK50a3I0/jSI7zvjjnfFWMBF3
 nf1r3wwbfYtBg==
X-Received: by 2002:a17:903:285:b0:2cc:841d:cd7e with SMTP id
 d9443c01a7336-2d3b009a1efmr52582635ad.21.1786714799102; 
 Fri, 14 Aug 2026 06:39:59 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aeb271acsm9717535ad.52.2026.08.14.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:39:58 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/bridge: tda998x: Handle short CEC register reads
Date: Fri, 14 Aug 2026 21:39:52 +0800
Message-ID: <20260814133952.1386158-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

cec_read() uses a two-message I2C transfer to select a register and read
its value. i2c_transfer() returns a negative errno or the number of
messages executed. A short transfer can therefore return zero or one
without writing the second message's buffer.

The current negative-only check treats that as success and returns an
uninitialized stack byte. The value may then affect register
read-modify-write operations, interrupt and HPD handling, or connector
detection.

Require both messages to complete before using the byte. Preserve the
existing zero fallback for failed reads.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 14e5b5889d75 ("drm/i2c: tda998x: allow sharing of the CEC device accesses")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 6c427bc75896b..7e82c918277fa 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -438,7 +438,7 @@ cec_read(struct tda998x_priv *priv, u8 addr)
 	int ret;
 
 	ret = i2c_transfer(priv->hdmi->adapter, msg, ARRAY_SIZE(msg));
-	if (ret < 0) {
+	if (ret != ARRAY_SIZE(msg)) {
 		dev_err(&priv->hdmi->dev, "Error %d reading from cec:0x%x\n",
 			ret, addr);
 		val = 0;
-- 
2.51.0

