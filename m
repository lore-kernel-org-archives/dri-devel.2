Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851BACD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 17:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5D310E0B7;
	Sun, 17 May 2026 17:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="BFon1sMy";
	dkim-atps=neutral
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4498810E0B7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 17:22:06 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779038522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZmaAymEf94w5ri0n7R2r9elxJpUR1I7BbcC1iYQPFk=;
 b=BFon1sMyUxgtZ9EwV0Zjebho7wZlRIcgOzhTZgBAAI6SCEpiXJKSpLl9ooHVHDgWMuc/55
 XOP/4aTutVKdr0JqDkdNOjgOh5cua7tLqAxSG3rwJT4P1JFUqpTk12zJRwuhRdCFmoCp0m
 thRrxBIEYUQNFGkPRRP5vpxgEDgf1Gg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/bridge: sii902x: inline i2c_check_functionality
 check
Date: Sun, 17 May 2026 19:21:37 +0200
Message-ID: <20260517172136.3321-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=thorsten.blum@linux.dev;
 h=from:subject; bh=4i3U+9Yy4ls9YwFIxzycxJuN/TJC62hME9rytIzY3pg=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmcPxV4+jOT2wK7vgReePpp8pv73KUGq1dcffLyZBBf4
 N1vzOwXOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi7K4Mv1kNbC50+pzKlny5
 c+2nKws+ZQkc5kjvuJ7pbxj97jtXXC/Df9cG993ut9nmXj44r+dSYLD2y5aezzlvvwa3NOxfJP5
 XmBMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Inline the i2c_check_functionality() check, since the function returns a
boolean status rather than an error code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index ea543be4ae3e..38d176d4eef2 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1158,9 +1158,7 @@ static int sii902x_probe(struct i2c_client *client)
 	static const char * const supplies[] = {"iovcc", "cvcc12"};
 	int ret;
 
-	ret = i2c_check_functionality(client->adapter,
-				      I2C_FUNC_SMBUS_BYTE_DATA);
-	if (!ret) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		dev_err(dev, "I2C adapter not suitable\n");
 		return -EIO;
 	}
