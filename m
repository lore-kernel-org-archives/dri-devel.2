Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD45606A339
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pstMdRDD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B76710EF82;
	Mon, 16 Nov 2026 15:10:51 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE0A10F167
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:40 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c445c95d553so511518966b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841838; x=1795446638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtudfLKjbr/2/c1OhhlQVNFuLuefvprrOWVYAN7fjDI=;
 b=pstMdRDDI2ZOfoV5SJu6UftWaxRISKqs2HFXc5NmiQPVkAZrS9NYSs0DVFNBFvraYd
 xj9kwPUEA9jVihMjN4kkE1UGlsJmMg0iLBaU12Ze0T/2juX4mGOhuTSVqlMDsNUcykjG
 G4e3W0uicoXYE7lIRCh+SJQnldWMgunmw/GdZSlDuk+afq99FsgOt100iVaAPQSdHhrp
 8zBqyXEDSw4QrFRCNSfl+zqTHAa/FmQ89FI0ZujovMDKucEujL1E3vULoybO5gJ4moiB
 7YwccsH4w1Fg0vWibnhD87Mlr/ZnpKEeWP3ss3eCZyS//XH8+z4R2A8RY6NaFvIaYvTw
 d14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841838; x=1795446638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtudfLKjbr/2/c1OhhlQVNFuLuefvprrOWVYAN7fjDI=;
 b=w2EhvUwKuMKC/LkS0pNAPybkCB1Eb+jLgAsVz4MizJ49kSF1au4A2YiMZVBFztYXJl
 /ByEEj+TTbv8yODDrRoq+HwcWiVde5+DXMU08OLHSugTiiA7mFzV7R/sD1l1zYaaK8qE
 OUDniebS6W3BihAwTiRfmexTuv/dPN+m2eCdOcq/jkvUXfih1y9vGWx4xYhgFIie+I+u
 oTo1OuUi28S5V22+PcO7Em7s8C1FlU8ZWgA5S5kyU51VZB8XDTSihh0cAQKikFs+UyVl
 VeI7MMoiBnEbfy8P/oALZKVp/o7K8v7l1WBX9uJ5mC/iBRMUU1C49xcodT5jKj57HXio
 B//A==
X-Gm-Message-State: APuU4Z9kb8GbCMdYoshfO0fkLI4RpPhneFItvnT3NijzxMQjzZnBmDuU
 zLZvBiVx+AmSvjXyWD3x2DaEroHvdEu6JOIlax7QxTkaOYyL1CjXo+6Ccc2HDw==
X-Gm-Gg: AYBFou1Ts5ABL+/nKSek8Mn6fak3LCPfQp8aRVgfvkKSCKr3RwhsiUDzxEaF+O8L0nH
 PdhA2VyEStoPZqSfq18TN2OyMNjI6sPEDTDRKwvKvHB9CFezFxBtFGMGvoOoEmVV+gMjNCsLfkR
 R5HOW4HzQuKcK7jNU3Hk0NjBFSfTFr2TRtre0n0rGI1NBB7FM1VwJ5wfBCMtuehQayTAIHNjf82
 tXpe1zrZcj3uR/dzzWygIn59hn7peYcvcQW3QipAvZ0QtI7ctNd0mzxRbTgVPJ5apZRN/m/0hkp
 DQX7gkIh0L1GrsFeX3trXEFaCLAYepoFvpR+I31Rs9ipM+vGyACz1IrEfRBADN8ZRrLOlzAq1BT
 j8n01J+0aOloQP3QZ+9y7iA5Htex3APwCoDSRwsw5YbJEFlnpBnIzrbKfM9U48F3192Snmq97fJ
 rt420PANfuvzUR2/2cJwpjWnHFU5KLxeAFpdl5IB6Pnwl4AfKEw6xfjYIaRmno1S1DDguQTWghf
 jRnmflB9Iq2inCmwN1ffQq/dM1tvT8J1c45FDANZ6sO9CmpQ9N0ZwErRlzhtSQr/4iyCHJw8G7M
 eXn5pcytr/lyVI8iNMs73zFXCyce+bppmvKJpliLm2chwnqA7IccRzd7UpGqXlJSjDdghZhdg4g
 sdyM7Z8TYaw==
X-Received: by 2002:a17:907:3e10:b0:c26:19e3:e98d with SMTP id
 a640c23a62f3a-c50963fae20mr823362866b.45.1794841838314; 
 Mon, 16 Nov 2026 07:10:38 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/12] drm/panel: panel-hitachi-tx10d07vm0baa: Drop
 redundant disable() operation
Date: Mon, 16 Nov 2026 17:10:08 +0200
Message-ID: <20261116151017.274764-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Squash the disable() and unprepare() functions, since there is no need for
host adjustments between them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
index 318ece68b7806..153717ca6c90e 100644
--- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
+++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
@@ -177,7 +177,7 @@ static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
+static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
 {
 	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
 
@@ -187,13 +187,6 @@ static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
 	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
 	msleep(50);
 
-	return 0;
-}
-
-static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
-{
-	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies), priv->supplies);
 
@@ -236,7 +229,6 @@ static int hitachi_tx10d07vm0baa_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs hitachi_tx10d07vm0baa_panel_funcs = {
 	.prepare = hitachi_tx10d07vm0baa_prepare,
 	.enable = hitachi_tx10d07vm0baa_enable,
-	.disable = hitachi_tx10d07vm0baa_disable,
 	.unprepare = hitachi_tx10d07vm0baa_unprepare,
 	.get_modes = hitachi_tx10d07vm0baa_get_modes,
 };
-- 
2.53.0

