Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856ADFB3D17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF59E10E5A6;
	Mon, 30 Mar 2026 10:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R81O35q2";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A561910E1C8
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:44:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso38436135e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774867494; x=1775472294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uX914YhuYkTgoe0kk9VM5sxxzK+tc1qOdfmAktq/XU=;
 b=R81O35q2/AeOMn/39SSX+yyV16NRJUacAKUYBXVKDCFxMKyAum5C+X5eS1Gikj/chn
 BxxIgalmTTccLv0YmQf7EhQc+zs9oGEHS2jb9j5PuobCSNmBYo/WEN7cqHiBDaLEkedE
 8qBBATauvkakmyCOUmo73DthzoAdEJ4XGD8K9qmaXdpKGETCTlGtcUcJNVT/Fk4OdkWw
 R49P2Uhr1dqwFcGYT3T/vihKp9Vm3SI4WhOsUZSXCWYpZn1UyPlcZ77OCI8Z3Gw4kFyx
 NwO9qlsAz9j/If498sA420qrAVQ11dpUkU6n8EVXjQik31BdH97Ez8AhQR+s+po9A1oS
 bbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867494; x=1775472294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3uX914YhuYkTgoe0kk9VM5sxxzK+tc1qOdfmAktq/XU=;
 b=i/bgzqDlifZzVKSTvYTtul9I63yNzSU6T1GlyeuzL15hQSK5gm4YzF096ZAXu6xatV
 8Ryh91T5wZaD+YImLTAZZbkGqCKr5F1BbCQQsX6EGSdpaL+RuH4iZRzaao0JKzDc3cwG
 ebinyx1Adefg/3y1LZcfh1+3leboq39PiicKY7YyF/SHi6QEwQgRmH2I+Lbt4jNhjS/h
 EABNfpQ99RCnkxtGdKtB3xQLbMJHEzCRQyh2HsrWgSNMSUuAR/mN0WWzX4TPlr/kra9r
 vukaogmNyl9Oft2muo4xcccfRPYH+cQaJlHLYU5Snz6TvGlzhofGdbTWSTilg2P6oWtZ
 uvTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU89W7CSdh5K6SGswcTJqweaGoRMF7Oi1iD8eB6polHbihbIvplOyts22HiecGCWHyuiXqvlaAkq54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk4v8A6LB9ma7hlVUkd7TgtqZXb93xRd/0tXZFNi8zHMezu3s3
 1klvH5ZDAVk2uCqR9l/UXnfEtnguD1NjtPFMQlvoQusCLLW19nhAz2jK
X-Gm-Gg: ATEYQzxwiDUFmDpyxpZZYhcLP6eXBeMI9Is6oMt5sBiC7X9R0rkeiR8OWK63mwGRFKj
 DLJYjhN9j1PaJmqUXLITeu4ZjgLdprgXcHGslQSKBN0kMyWX128ej1hAPhSwYvNymxgO5XhkpxQ
 kNSVNgwqDpZOHvCN89HlcLfD8Tnnm61h8Tymu8ONLDvRhl6xXvmJuURsqt6+R5od3dnddZ2Cuge
 QWppYB9OgY/Z2iMAqugxhm9GmOeu8Xb41J4KMYUCQcCxLwMab7qNLPf7XKvCoDBk+fZKCyskL2v
 s3lhUU55re5iqycM/kpgjREA5GQtyLX1HFnWDnAauk2eXmhPNvEOMn6ZG8gooVPNSxASIlin36A
 m48bdiLuTWmbFczVLCTALh88aoXY7nn1C0J0FfUKwKiyot5PQg/2F7k9H5Dm5n4DcPlCIrWCY/3
 ZmiZR7f02/RUO6i4KRrKoxZlmipkqUaQ==
X-Received: by 2002:a05:600c:3504:b0:485:3e20:4013 with SMTP id
 5b1f17b1804b1-48727f0b109mr170977975e9.28.1774867494040; 
 Mon, 30 Mar 2026 03:44:54 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:e60:2c8a:54bb:d692])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727bfc5ecsm185842685e9.1.2026.03.30.03.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:44:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm: renesas: rzg2l_mipi_dsi: Increase reset
 deassertion delay
Date: Mon, 30 Mar 2026 11:44:45 +0100
Message-ID: <20260330104450.128512-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
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

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
requires waiting at least 1 msec after deasserting the CMN_RSTB signal
before the DSI-Tx module is ready. Increase the delay from 1 usec to
1 msec by replacing udelay(1) with fsleep(1000) for RZ/G2L SoCs.

Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Moved the patch from patch#4 to patch#2.
 * Added fixes tag.
 * Updated commit description.
v1->v2:
 * Updated commit header and description.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index ff95cb9a7de5..9d9f77d8f949 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -528,7 +528,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	if (ret < 0)
 		return ret;
 
-	udelay(1);
+	fsleep(1000);
 
 	return 0;
 }
-- 
2.43.0

