Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F54606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=YycGkbRR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B384E10E4D0;
	Thu, 29 Oct 2026 14:41:44 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E810510E110
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:41:38 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1423669f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793284897; x=1793889697;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HzJeCLzlRfY+DA3xu8RoLtymzokLqJDrTYYXhthDQMg=;
 b=YycGkbRRkSZhBORr6b5mNSmZkzvFQnuC0+RwuZ6mHCl1vvNJLz4EnWxsF9XMHH/fpB
 sMmKq8NW7DEben3QU+qwSwQPuuO8jI8kCtrNcx+lYS6ky5QQ6qmJ897vhaJYH43K5yqN
 WX/Qth2s/BBVrmgLU2UT7YpyO1F6OisMAeE94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793284897; x=1793889697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HzJeCLzlRfY+DA3xu8RoLtymzokLqJDrTYYXhthDQMg=;
 b=MwqP+7r2ZXsb6QwTOTVAfJJIPZt6JbjDAcjXI5MSgVKSkSzdAMHSdNcS9Rv/JCQ0jn
 V6IpJILbUL7ZLd4vBPo41plfzD4erHDRqeO3Ixj4wl4Vec+L8Cb5xmWy5grwFwhlevmA
 yQu1fgCgPVuWgk7dvx8Cn4AZnG4WPUhvYyhnpmbgH7ZfgWmYxsqTnzROONKIt7Ja1vw9
 lNQv1+k7UGLZgzqXPX/LhO0XJpXTTeKKu5OMhr8jg8mENkyKf6AHYORo/TZkR/QSeF7F
 q3ncTrQr4gHrXzzs6fzqrS2z0Lpcw6WzrVtgablZq4n9W3rSoOhN2cUqYlfngF8EEBpq
 nQ0Q==
X-Gm-Message-State: AFq9FYI0m5NcXingSS6qdQ82onL3B5gUtcX6jOdjrqhUBbSuEkwkbDil
 8azeoi2F61N2zQCQiMKihe24W7Bue15SNCXcXZd6mfPuOlPe/vuWgPTXJJhE4/8cVO4uVUQy99C
 9S/RT
X-Gm-Gg: AYBFou1z+GH/QrAq3Ph5Q90mtIysSTm5LINXnOOI8XiybuXbtMn1WafhqhnVJUeoWbU
 uBkL+zzUDWK4PS62Wqdl8xqBk8PdYVS8Fgla+4NW179KysEk5xSfS+06zboKgicd3NHopGCzhdt
 zBBmRC1XDhv6IjeC8oa2mFGVOtv0TSOM/7YuOqN4adH0O5ozlp9Fc6rC2Fi0YWnRDRF7niLjTOV
 QTdb6y5tKcVNVG5KpqunlsrYZsCiIo2lWyPXBfhmTQ6ICM7HXKNWvYAxosTbrZjqein+fOQoXNw
 e0PgdbagpfMYNnqorKtCxVwIju9XVV1O1IYoAwqxct9ZXQUhaF3dO6VHEDcH4vJpIA49ulplTeC
 GFxhyfzD9e81CdT25gIP7T2FiI5Taxg87x8ohVH9XQc+SmfNb58xmZeISQZtvvmt1+iUyW2zI/y
 VbkYHzig/Fw4Uk/8EWGx4YTG5gGwnC1+9ftGmjj/CSQLgxskszlskApy4oPYVgGsh79SUACBLhZ
 l/DYYQwUS+2HwgfuNjUphvetXvxU49OzesIneplsGfbMR1HtWzT3t0zUKbY5xp4QV4KCc0BlRT/
 P8RxGDg4ndAnqPA1deA7zLcInoG6LCeC/jqcM40qvcE1nSdxnBtx59LWDLJEgTfCbfrfvg6FEbs
 t+eycuC0C2TXpGXCgzUkHFQ9AwvoUkzyy6sm4dNWufBhxqCqVvff4Evru4lOspOwqHCX77kzx0y
 mif7m2Q4H6TqaKU0yzlspIbLVx2RAbH3tryRqDp4/eZmtrBiw=
X-Received: by 2002:a05:6000:4403:b0:48e:4561:8a17 with SMTP id
 ffacd0b85a97d-48e5d2e4a85mr9703282f8f.16.1793284897196; 
 Thu, 29 Oct 2026 07:41:37 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb958sm34829650f8f.21.2026.10.29.07.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:41:36 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: dri-devel@lists.freedesktop.org
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fsl-ldb: return -EPROBE_DEFER if the panel bridge
 is not found
Date: Thu, 29 Oct 2026 15:41:28 +0100
Message-ID: <20261029144132.572020-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

of_drm_find_and_get_bridge() returns NULL if the panel has not been
registered yet. Returning -ENODEV in this case makes the probe fail
instead of being retried, so the LDB is never bound and the display
pipeline never comes up:

  platform 32e90000.display-controller: deferred probe pending: imx-lcdif: Failed to get bridge for endpoint0

Return -EPROBE_DEFER, so that the probe is retried once the panel is
available.

Fixes: 802372cf316a ("drm/bridge: fsl-ldb: don't create a panel_bridge")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/bridge/fsl-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 7ec84c81cd78..420b3e08130e 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -342,7 +342,7 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	fsl_ldb->bridge.next_bridge = of_drm_find_and_get_bridge(panel_node);
 	of_node_put(panel_node);
 	if (!fsl_ldb->bridge.next_bridge)
-		return -ENODEV;
+		return -EPROBE_DEFER;
 
 	if (fsl_ldb_is_dual(fsl_ldb)) {
 		struct device_node *port1, *port2;
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
branch: fsl-ldb-defer-probe

-- 
2.43.0

