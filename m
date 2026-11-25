Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E8606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgT7q/Nr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149A210FC05;
	Wed, 25 Nov 2026 13:08:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E596910FBD8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F9256213C;
 Wed, 25 Nov 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612108;
 b=wjJqhX+fdbqISLcw4dR+ubga2EO42S24gsehbjA4C9BTjU8DgphR8MGV9sMoDtpA1BG9
 OL4br2UJu2esBkwDQguUg4O0sbVU9Vjca6faX4201LQHro0AZtxIhCrKRmC6AfxEpaUwQ
 PvtRQZVbR5cPFX5Tn8QNnSuSsrAPWT1aEDZze65A3SPlR7252vt4mTrm5HyY+hMAJoy9Q
 7qsDiajHE/jM1tKd7iSpSpLMhvreLM8yD75InN6xd2zhV1PEMpKbeu2ND+fKnN+MNjZYe
 nPcK2nSTXApJlwS2tLLEyBBc7YoiDDdBegWSpnZ38PTPMbN47aTqRLkX3xe7yRs6A7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612108;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=xD5ffAbmlqAPAsNuQWLkORiCRgPLqAADy8T77XTQEyE=;
 b=mw32k0Cy29fiJzQtJOkGIHTQq5gG1jfylvxb3S1cqNkjLAEDXqJ8lkML8kG2tvNnFNQ7
 wPcTTVwelQ401WcKKfk9D0PRYJHlvGgGhnpv7LMQYykkQXMf0QvxJ9vBOOkbkTQHag87+
 tNhdguRo6O7Q/cpURmLGJCdOyyDNteJrW8lRs2xCbvFlpqegN9znjXa9uM5gTmrAG+v2n
 cO++GoirpMESG/tDjAIJ/oynEK/QDV2m1pSGq/kNDd/viS97RhV+4cJR2XMBGnmSWkEeX
 ceg3tqez2mqql4rB3ICOeBnaOSbm5E8mhx637ku+v75wja5J0/3HrreWcr9dvuuT0bA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 700021F000D0;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612108;
 bh=xD5ffAbmlqAPAsNuQWLkORiCRgPLqAADy8T77XTQEyE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=FgT7q/NrOgCVMl4hkiSf9tDnVIMphOXDFgI1XAz8Q0uOWS9O6k1dfMEXs5ZaYuSWZ
 POB/W8Fco1xlqxsT9tOOOxNR+FMRjRAuZqtELmrtD48ZpTQc/DUfvqvbdJlloY+T3k
 uJ0kunTp9WMrYEV9+aaOVqST2zeI15iFOSpTaH/B+iDTLv2AQIDhZELloTo0wTgehN
 cllVo/xVIN09XBKSTd3QTmhVm/DyRbruwH8+yJkRRLBL9p+eLBTRjUn7h5G+F6Ub1i
 afPQs9MnNSRnLmWDuUPqVjQrCZoK9rU9+/Js5alqH9u9wBWsWOxAMfYu4kHDLYIZFS
 uc4MM9EECuGGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E6DD84CEC3;
 Wed, 25 Nov 2026 13:08:18 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 14:08:12 +0100
Subject: [PATCH v3 1/5] drm/panel: lg-sw43408: use the full DCS brightness
 range
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-blueline-panel-v3-1-914b4a30b73e@ixit.cz>
References: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
In-Reply-To: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=BTFoVtQ+iUfQkeRFRyilwFinpDXvmQQRSApa2qXLTP0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3BfYaMW928WOflnWdaGzyvapdChsW+JU+vU
 mLw7o1aUEKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 cizCD/9Q+0moQNafz3AdHRwJAvSxq/yQOdJqD/kUukDkcsb7HcP5EEsCAWxuzo5hP5IsoMWD+HP
 EY9ptHylH7xhn2CBnnbZo3JtG7+zzAMpNURQrzSBEyet5HP4MduD/Xr3+MdViWLFV3YssBbBuPh
 7KPL8ixG6yP+rnyV2IyBzXhGeJZ6LLgdOVVZ8gP8EJIGoiz1c5ecXeD6YKdH62sjkvA3NMQErdo
 SSBhcTZU7GCLJIEt4l0zeQ6rvVZfVjTJBLQOud511b9xjBTP2l9T4nhgyyzXvvC7rJA8pkvkErT
 4dzC3Aww5Czl+jn/9zhFUfRPp5HR7YM3wzHk761TkvRvpWiU5X20sOa7VjQiEnYv1iACwN1DXQq
 Mp0xf3zaucVTgKXgPe4Kn0K+qBlMiWqEv5h1gmP0AB4LahoPZsj7j5V1Mb2Jqt8X1MnMupOWJdn
 QjGbuVMrytRnI58OwfNsBu3JvBm7UkwAhMW59U8uGmnwfIWxCCouGkUjmJgJIhTXk4CcHLX+lQo
 9/SBxzU12zDHAOZPVTStv2liMnNonq8vcCPYYRSo7uCkVOc9Teg3ot4GPRd7T9JlmDOH2sV0eKf
 q2knHBpZhtujT68zot7eH8B67mHyko2wNfheDUfb5Gu8HfDfi0Wc9sGZGn7DxC4LobIBzHwoRZa
 bHi6StcgAj9om+Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

The vendor changed the value multiple times. Last value for production
devices was 900. HBM can go up to 1023, but keep value safe for now.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 822318f546ef3..92cab6478ea61 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -197,17 +197,18 @@ static const struct backlight_ops sw43408_backlight_ops = {
 };
 
 static int sw43408_backlight_init(struct sw43408_panel *ctx)
 {
 	struct device *dev = &ctx->link->dev;
 	const struct backlight_properties props = {
 		.type = BACKLIGHT_PLATFORM,
 		.brightness = 255,
-		.max_brightness = 255,
+		/* HBM can go up to 1023, stay safe for now */
+		.max_brightness = 900,
 	};
 
 	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
 							     ctx->link,
 							     &sw43408_backlight_ops,
 							     &props);
 
 	if (IS_ERR(ctx->base.backlight))

-- 
2.55.0


