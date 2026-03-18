Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6C8FCD0D9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4EE10E745;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lcfc-corp-partner-google-com.20230601.gappssmtp.com header.i=@lcfc-corp-partner-google-com.20230601.gappssmtp.com header.b="YJSgqMYi";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416F710E0A3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:24:20 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35a1cc6e478so3469834a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 21:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lcfc-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1773807860;
 x=1774412660; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgGwSskRp/s+tWVy4f+gDNVCOk4Xt/1XzAPz7N2eRjM=;
 b=YJSgqMYiBYjiTzu/dIeqp3HmII1d6Toag9SYbMYKWsX2zhZJ5O79ZxSE8bV0hXBPG4
 nTNGgVTcSvsfzzZbQY6POz2Wxs9hWyJVB5m86IHlcApUBNUasVjFIf5LKGRO8IVDy4Ys
 DVbceotPEctD7bTAD1nSKaZxwYcNn1GeaOGyOOrGg3J9S3gFWK9G4lY0neDpDL+Y9Iyd
 DURgNGzhNJbWzGi5p3NG4sfo5YfJH7dpzk2CL0uAwWgthh84ow902uslhArTGfJ6/yav
 ECXzmoLIsMvKw7ec8ONiIw40Jv5MLXq9e0WBZDplYXH0T7bId2QDE5gqrA+7LqeBSl88
 p/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773807860; x=1774412660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgGwSskRp/s+tWVy4f+gDNVCOk4Xt/1XzAPz7N2eRjM=;
 b=Pu7zTYsmc5xtqICLKq4HGpigsz2iSo+3MUBLk5m6z4b52Nt/N1AgDGrd6m6+vJ+JgH
 VOZxqegJolu4El2YkDj8gb4tx1EOJErTpjQXAry9bZyF1DDHsXukwpnWkSnzyJ90XBCu
 dEeU+qCfNlZxf6Hg5hQzR/RiQc0gj0hmz47SIZXQWegT80zbSodZ3fHTQYkG53HBVdT8
 evckEjSNl3Gy+AfaPqt45DvNEriUdU0vl+9tzBT5Hx1Oy1DykZhTuRFATkoow2rDgTHU
 NSBYt+NoiRg42XkS889gaTIjTwB8hdNlVm0jNGZFKczHoscaMe5PuOSG6NGu+UmbZg1x
 t9dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwvGsGkWvDnfeXYytHpz3lnBsaFMoYlV9mOCgnnCDYBdzB0k9jOO7+v33QzpTuKh9D0cnsxTShrW0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyykfB+m8Fn4RUEV+TjeoORMRTtL/4fMHTCdxdNzWARDMEp+V7
 hrpje2D8jFEEoM9FKq7W2HDxHI1sdtrEIFRXNgvDDqhlZAlwqqOjEOTRJjFUDpwSlE0=
X-Gm-Gg: ATEYQzzqq/NKio9zKbJ7csBvcubZ2EZedhf3SoOUsUoH6xRdrXFTBG/eIdM9OZMO7LL
 9y8rDBSzFFldGi9zaAT1hkzcXs+EWpGB6Vc96yTKgbzDbv0K3xDxGimTShvyJGgE3cI1fzLwDvY
 vUNZSr7ut8R74kbjYaCvnmNXZT7eMHNun1+JpdyygIMMTgMr4gMTE7HR8/1SCPUQKd4xbSAqHB6
 MOcGrkA7UESrzw38YgG3ZeLB2fdbD/6GkdVIa/InQfILEEZDD9ddlKx/YpRcfURt+rnfFcYrqCL
 fNM5HqXyvLHjvtq3KnecKWscH099UJpiwgqL402geWNUeI7F29/rpRuRt+NfyED4LL/d7R98Bp6
 vv6+u068YojFpqd5UVkGRBrAhfbp9a6m0EXccy2+jxXbmxfHzlgjT97+uqBptqlxHAJ3xtEA08T
 +M7p0nWpRqyUEPwJu/3V6Yck/9ZyHas0POVoXW9QafThEVaFPjwz5bueiUghqRLSXudapIj+j4Q
 SPCeO3g+A==
X-Received: by 2002:a17:90b:2d92:b0:35b:97ba:acee with SMTP id
 98e67ed59e1d1-35bb9f31e42mr1693193a91.17.1773807859732; 
 Tue, 17 Mar 2026 21:24:19 -0700 (PDT)
Received: from thinkpad.. (211-21-152-94.hinet-ip.hinet.net. [211.21.152.94])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5a2b09sm967768a91.11.2026.03.17.21.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 21:24:19 -0700 (PDT)
From: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add 3 panels used by MT8189 Chromebooks
Date: Wed, 18 Mar 2026 12:24:13 +0800
Message-Id: <20260318042413.2891692-1-alvin1.chen@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Add a few generic edp panels used by mt8189 chromebooks.

BOE: NV153WUM-N42
CMN: N153JCA-ELK
CSW: MNF307QS3-2

Signed-off-by: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 679f4af5246d..211fd0d06bf1 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1991,6 +1991,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
@@ -2026,6 +2027,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1565, &delay_200_500_e80, "N156HCA-EAB"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x156b, &delay_200_500_e80_d50, "N153JCA-ELK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
 
@@ -2044,6 +2046,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1

