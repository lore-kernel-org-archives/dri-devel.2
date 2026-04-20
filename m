Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C720EF327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FDA10E807;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NxC5ofpt";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7623810E422
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:53:16 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so14292375ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776667996; x=1777272796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BV4/TIc6lvQCLx3YXJXaDGGdHXv2imnxTR630cNtZps=;
 b=NxC5ofptdAAFhftGHw7+AKuH6t2wNpn5UivVp9/+2Lbbr0ri+uU4Hy7I7geFVpAttG
 Mb1MrmwUUd7jHOQUgufvBTCOxf+qE9PuuVjuWMS4NuluiWLu8V0m2KduKekWh0xWyGx0
 l4X2bfpvhxnQLxm2AkYOcaiSmXz1CKZktesu8gIJc5G7Rep/v/3mizYVaY13l76mTQ2+
 S75LDQ4AWVQ1cQJ/EuQs86R8m8wn+JIJCR7QaxDpjvPqECgx/4tiPuK/nTDjE7C+BgVJ
 QEhpPKHJ6izs5PgMtRYm9p/8TfV/Ur8Q3Ql81r0VMunW+qulnDS/AJalga1It5jW3LG2
 m2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776667996; x=1777272796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BV4/TIc6lvQCLx3YXJXaDGGdHXv2imnxTR630cNtZps=;
 b=aBxVkZc8vGA7Rw8yAWHANi0jGhdl+1tbL08oAx4Z8LNueez9R+o2hN/ABtUYlVWyMa
 9bApKG3C0s4RM3yZHeG34InX04bB/as0UYnikxoNqwl7/oRwYZh3+YkTKe3t1tIsIyx5
 lx52Ce2S1ajQ1GMr4fD5gOr7DXAouy9vK2J9RMvBq5/WroykI4T739gwdmzKkaoyWqa3
 P4OsQpnLsD9RSpbiJfb7OM2Ady/hFf12gCBTOhmU3cHVZPrpXsLxYeeIesdK/GaHQ48u
 VYW1ktpDAMU0qY44BCFLFP9whb4sNfwLTaqFQDWsIZqhO4kKgo815ov0ssw7bSRtkhXB
 Ufug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MzYu5o16SODH7D1CfoU55cBO41ClccIdB6UEhBepmEkiyiVsG4RDWucvncZqzNYieBG6XW/+ahK0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA5idEvAxHEkoRN1XwwcjkHrZcPGYzfE0V6Q+8TDAjHfqguR9G
 uHbhnQ1GbgAnRZBMu8OsW44u2UlXbI3Vq7IGtHvIqNeiXs62NdX/0sE=
X-Gm-Gg: AeBDievDx52EhlYOGMTKQPuYpWszSu9o3QDpvQ0lKczzzPiwA37wHq2ivJI/ouwhUaY
 JhutVRag5iEgoRaoYR6HlSf+uk20tedTdmpdiXhSqdTJihlLsGeGsbvV4nz6eg4sX+wLR8XDqPc
 8MDgrcaYiNkk+tagph6nHWfXh04l+ubMIcJTTshtb8YsvQIDwvhFXwXcXjmROCNON6qUYj7ODVu
 6foo1EtO6V139sWN5wQm9d7FQJHJDHgJ436EzRrtkGOlHtv3BRmn2HNsgpmjNFDViJGb/aQMRz7
 4U8S6bGDc07JyIJggmHOEr/EbFLEqT5EQNu6w0mY8M3vwFHqdno1zQBKXp/Pb/lgIbRFNktRMx0
 Xyb8yrrNyJEzPCAc94y3ruUAm6wgYG8gmE2HzAq0YHlN0ms0oNz8jWIT38JsMMnVJF2Dntaiphe
 px45zQe/mRl3lzcH22xk/K+KGh9vx5XRvOzs3E4Vn49o/clvJoIDK9EJ6Td/4PS4imPCPpcHwk5
 nIwZVaEOQ==
X-Received: by 2002:a17:903:46c8:b0:2b4:5f83:a9d6 with SMTP id
 d9443c01a7336-2b5f9fbba9cmr138627665ad.34.1776667995926; 
 Sun, 19 Apr 2026 23:53:15 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff390sm91821395ad.9.2026.04.19.23.53.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Apr 2026 23:53:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH] drm/panel: jdi-fhd-r63452: remove panel on DSI attach failure
Date: Mon, 20 Apr 2026 15:52:15 +0900
Message-ID: <20260420065305.8781-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

The probe path calls drm_panel_add() before mipi_dsi_attach().

If mipi_dsi_attach() fails, the driver returns without calling

drm_panel_remove(), leaving the panel registered in the global DRM
panel list. The driver's .remove() callback does not handle this case
because failed probe does not transition through the normal bound-device
removal path.

Fix this by unwinding drm_panel_add() when mipi_dsi_attach() fails.

Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index cbe354b51..4356c07c4 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -205,6 +205,7 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
-- 
2.47.1

