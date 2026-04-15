Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB9EF4198B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DAD10E6D4;
	Wed, 15 Apr 2026 11:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q0MZhS51";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA7610E225
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:39:59 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48374014a77so89469235e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776253198; x=1776857998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uSepOr97f4KGd6yzx67mHmWZD0NUs9mIs5ATwxGH8F4=;
 b=q0MZhS51zckJhM4kaEw0QBtBjU7GHqo62Wn7Z267xw18KrWLcJZjjarpyOYwIOrBtv
 SXPEtc1B/CFTrv53vUmACUPKa7O1w48KPwgO5l0sMoWNdyxj88uQj5UkAlP94NJS5u2A
 BIWel/rP9bkmtzZBNMifXXiqBL7y7zf9JE50rZuKtcih+HGgQFbJIWadLGV3FlFWU0I2
 Vbo5USXVeI/gDxrcv8zOxGZaAgon2OfIhiHJ65U6nvsccrBtFSyHDQoayMm66Zy7wY6o
 T6R2SV+/3IrDr8Asii/lEj8XCyaqDhlhZt8cscFVkePQsAM8EbQsg3grluU6CHjVNgfN
 aIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776253198; x=1776857998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSepOr97f4KGd6yzx67mHmWZD0NUs9mIs5ATwxGH8F4=;
 b=GQRz4dOIZ4JyhAT5ypSmUwryOYNu9JedbL+jkG3GTb9VN5whKJYVIg0B+lWbIIFNNP
 7HOPx/60byAGDYLjeZ4RfpBxVR2YpYhzERSyF25+Ewh32D2RBIyrzEDZN7p2htqBM7YA
 62o+EikzY79q3FUUcWvrTtYeg03zPNuzU742xaOAtRhOmyDhWfkyPgw4RIhFQ9gB9a3X
 gG5KaCnm3QjBixmLr8JguHpr5KcUiCD3u9yYiWo7MZOC1R+jW7bdLQFsNyBqWjiMzm/b
 QPyAwPPHZyyioQ+1MX7+AHtuS4c8pO27e2MAmecoQJXPrDdznHCfPOmgX09qzJXBVqpw
 SYWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9BRxt9Ck8M5f83iotJhZGxZbXWcofaupY0ZTzM5u9JnM/fpqtnTRCGhlMlhENdcRBdF6ERzoeJos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOX6GiG9jj1ldFxCkRjXgvUTaZCYVAAOaxWb8ed/lM3ygXwHIz
 fMDbpU9Qd+iHkJtt0kPvO67MgVfAiSBASkrBGry/6Gs/mGJtP+wIHeSH
X-Gm-Gg: AeBDietSW5JQs119Hh6AeEL4pIqXKYL3N0zQ+mDfxnIHnsIQuE+hwdBGVg9slw+v76c
 IVbx95ytD23tEu8N2Tf02IHoSpfxQGpMxMCtiPTP4GJvH4S/N8a4MihJ4LXiuViBEU0WFJ/JRPO
 Y4iQz2xTTxpZoQmzFYNm+5dAAmGE0cC7Am9jspFbcF+oIeYp5jpzxHLdeRLScFJG0DyE4kV4i5a
 Dxl8cLD+OEVALi3se+5ZKGpDpprPlJqaeqcq5hcxZnZqSuCX/jRIVifQIk6Of+22PAFgYGXSPn5
 dK82NmaNXU6HdHQ4bLmr9vKGgMRTK/z6KaSaC7AAkiR/x7nfu7T6Xr0nBocMWOHGCSxWmCQETKw
 WEqDtZgtcnR+4MKppD8c8Fff2Q89L1B7D1mwzCkVmaRl93rV3HxX1Toc7C2VfPU0tEqFmW7ra/p
 LJ1oA6H9zYjJ649FlmgJW+/1ZjEosuHiKibAnywrSqdOTRCXoq7tj+pOs84b8=
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-488d68af201mr299898965e9.31.1776253197457; 
 Wed, 15 Apr 2026 04:39:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:2bdf:4b8c:9773:211a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e050sm209976145e9.5.2026.04.15.04.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:39:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] drm/bridge: ite-it6263: Add basic resume support
Date: Wed, 15 Apr 2026 12:39:52 +0100
Message-ID: <20260415113954.179006-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L SMARC EVK has a single-link LVDS connected to an ITE IT6263 chip.
On the RZ/G3L SMARC EVK using PSCI, s2ram powers down the ITE IT6263 chip.
Add a minimal system resume callback to restore the bridge after s2ram.
The it6263_resume() callback re-establishes the LVDS I2C address and
reconfigures the LVDS output. Wire it into a dev_pm_ops struct using
SET_SYSTEM_SLEEP_PM_OPS with no suspend handler, and attach it to the
driver via pm_sleep_ptr().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..9727ebef48e8 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -906,6 +906,24 @@ static int it6263_probe(struct i2c_client *client)
 	return devm_drm_bridge_add(dev, &it->bridge);
 }
 
+static int it6263_resume(struct device *dev)
+{
+	struct it6263 *it = dev_get_drvdata(dev);
+	int ret;
+
+	ret = it6263_lvds_set_i2c_addr(it);
+	if (ret)
+		return ret;
+
+	it6263_lvds_config(it);
+
+	return 0;
+}
+
+static const struct dev_pm_ops it6263_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, it6263_resume)
+};
+
 static const struct of_device_id it6263_of_match[] = {
 	{ .compatible = "ite,it6263", },
 	{ }
@@ -922,6 +940,7 @@ static struct i2c_driver it6263_driver = {
 	.probe = it6263_probe,
 	.driver = {
 		.name = "it6263",
+		.pm = pm_sleep_ptr(&it6263_pm_ops),
 		.of_match_table = it6263_of_match,
 	},
 	.id_table = it6263_i2c_ids,
-- 
2.43.0

