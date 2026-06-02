Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F3CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E34E10F622;
	Tue,  2 Jun 2026 22:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Ww1WEwSv";
	dkim-atps=neutral
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFE210F622
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:33:03 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780439581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p2pdA7IsrJUFbuOF7AQF9KoJ6BHzMSVzye1Drvp8Mrg=;
 b=Ww1WEwSvOjBzApBzU4cdDwrejPSdDtlQoxYW5RpS3rElBhepyaylZrbxjwL7G+DfYufrAi
 D1xHsb/W1A1nVm5UaAbVfYsSipempnJ75vZCjKUrq/1BXzkjOsgY584NSS74ZM2GML/kg7
 EwMsqylxNyOz2y22j/KDdYA3vxc0row=
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
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/bridge: sii902x: inline i2c_check_functionality
 check
Date: Wed,  3 Jun 2026 00:31:04 +0200
Message-ID: <20260602223102.1087000-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=thorsten.blum@linux.dev;
 h=from:subject; bh=KP7pXXbJMYNRZE4fBUCTy1AbXu2eABNLmxpN2JAu81k=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnykcu25ayNWJo5V0eg6e7brCN/ik6ZnSrfkG7+8Ypo8
 PN5mVxLOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiZy8wMqzQ/St8KzL2RPzR
 3UWzU7f90lqWvXed6r2DOddfP/r5XUaM4Z+ec9ZT/Tk3zbgP14hOOPxKPohh0v3mm6zSq7dqOkp
 Kz+UAAA==
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 12497f5ce4ff..0cc738e2dd63 100644
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
