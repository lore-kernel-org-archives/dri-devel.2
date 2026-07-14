Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E78C44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E032010E0A6;
	Tue, 14 Jul 2026 19:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iTPEQuk4";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77D110E0A6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:05:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso6637625e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784055945; x=1784660745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FmXhBG5qfGiwm5Sxpbw0Qfvk0I/spud/+tFxZ2U3z1s=;
 b=iTPEQuk48VTTbokbxCprN1SSRF2qHA7hS3SDeqUgSb0xY2uQAMXs7UjH+9bPkoj/6v
 jZ5r2aXNwamlpypGwSECeKhiPPHnnxmzKI8Dt/xg+l5Fy8Y7CvZn1DTSUYXmwcxJ0psG
 xLz12nfPKGgOhOgjyt9mbF3j9LwD3lXXqRkat9smoCZBmk5E+WwSD0967oXee6E6wqa+
 K7TcFwJUQb7b4Ts2kOMvF8fv11MylsSTVcZjsQBjqgkG1H6e3i2JyqqB2rqZ4ASj7yQf
 oM4bSWIqenmt86es0/5gvgYUi/8FiOQtuaIX+5SXRWI0vTxOg/kEZSpY6nSkd3kXwuXz
 E7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055945; x=1784660745;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmXhBG5qfGiwm5Sxpbw0Qfvk0I/spud/+tFxZ2U3z1s=;
 b=Oqeye2BZIdMOrSUZvewbve1ns1o6ZxIsmA0RwGlUi2WL8mjoQAqCcko77owyBsg4kq
 +1tyiEwk4FRiPyq+MWAF23IMtJSwnZhtI4J/zMBIbj4V7/LRNpkPKSVsLjJDoxb0cipF
 xPCHqDMWNiAsS9FOY29K8N2ieBnWpTlx39dLPrBipoGxu/ECNeWaocEUxY1pzv8kE0mH
 IO09U0O8S14CD3RwTXUmYdnSSnP64GzmMP5l0UoeYMsK8gqnOuPgZ+h8f9zcjTMHwX8z
 VJiLD7RgF611SCwY6kZExvuHped3U2hwnnv2py2wyCsTxXkK/9YWAU7ht9QAV11y4v0s
 0C9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDIl2jfD2pluoUkOsp1CaiZM6EfMGKpTNTe92GjcfMk7KI3ut17oxOz/9hE2xgrhDfD5ODAlcgJ5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw02SH2YJAJ3F5S3XLEQm0sBCNmn7ADRLk91hL+whCHV/HzLu1e
 Fi1diagYrg5MC2sWE7c6lA/PKiAVaDHvzPPZgfvT1cQtM1aCY2/AcT33
X-Gm-Gg: AfdE7cmtAXrgcCK/PQdWNAxCIq23ytFbFuzwq9NSSBHo0MW5NF7ZfwLy9sTONwpDsfF
 GhMsg/t5vm0uV1e76q6dE92NYrt5kp5TSpqEFPyvLJm0/3lf1EpMZZHCr7CYU3ODrlEp+1iT9aN
 pFhrIvx31vmBHGnma7gYVIEvtFwAZ3blrqh16/cXX+2a3PLmVdUHajwB2+ra+TjRu7WoLfTLAxq
 t/nvk6a3+NTukfao4ZEkGh1ExKMKkre4o8Rd14ipw6ZQgSbRB/zHGjYT9G3W2FE+clHOGrnwmhU
 /cYejp/vSJ8trb+C+L/m6TyrgtdrNRFUF2nFg+I1fWRXv+qrGx4nyU9U/dVgxXwNl6nSnB9EWei
 5Ds1EfCbKgs0CO6XUcPqkhHf3mzIHtBCtSFFW/Ip9ivFRdDLBVMBGhH5eHDZ9uxJH00DjF9LiH+
 t2EIu4Ty4wybk=
X-Received: by 2002:a05:600c:3f06:b0:493:b9cd:1272 with SMTP id
 5b1f17b1804b1-493f881de56mr142657415e9.23.1784055945154; 
 Tue, 14 Jul 2026 12:05:45 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e8f07sm86192295e9.7.2026.07.14.12.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:05:44 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/bridge: lontium-lt8912b: make read-only const array
 supply_names static
Date: Tue, 14 Jul 2026 20:03:59 +0100
Message-ID: <20260714190400.194605-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only const array supply_names on the stack
at run time, instead make it static

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 729b12b67470..62eabf0a3b88 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -673,7 +673,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(lt8912_bridge_pm_ops, lt8912_bridge_suspend, lt8
 static int lt8912_get_regulators(struct lt8912 *lt)
 {
 	unsigned int i;
-	const char * const supply_names[] = {
+	static const char * const supply_names[] = {
 		"vdd", "vccmipirx", "vccsysclk", "vcclvdstx",
 		"vcchdmitx", "vcclvdspll", "vcchdmipll"
 	};
-- 
2.53.0

