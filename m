Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224561090255
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDEE10E890;
	Thu, 19 Mar 2026 16:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbP9hNpr";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D054C10E517
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:48:39 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-485392de558so7570255e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773938918; x=1774543718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko0JSoqc92if9jLRax/3q0IGpdS1ahpKtbD0W9dlNH0=;
 b=nbP9hNproQTkO4PjZSgECioNe65Nr3HHNbTo0ZqhnaDS/o9fxoGt9LFW4nkZiiWLOS
 39vM9A+K3m8I+6JOguGvd/aMNd2HpQID+9DhHXkHRKu5j4yLgLABQrMWen0XE191zO/3
 5h6XH4d9lVwuydgADb0vMWqzFxOxYrIiH052f3ryk7VxA5PK5+Z7DcEiOeZtSGvT7//K
 qAZjcXDH1woksEMSbTMA8gQ5fDj23VX7vf4X4JcFmXoT55+vmLlgEr7tQ/TwjrjAAZAo
 mBc2Nr2F+9nBV8/CYxV2+BpAC7PRRcpjtpr0I5MHuGhTzDNZfrC5bqV/zmFV7/sSAsbC
 eAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938918; x=1774543718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ko0JSoqc92if9jLRax/3q0IGpdS1ahpKtbD0W9dlNH0=;
 b=q8avIIVlJN3Q+tMAEiELD3xxlC/ZwjYV0vzHFFNLwJS+Rtd3nt7GkEL5aFl3OMhQr3
 J7CHj/Td2eHi1O8VxY042bg2/+eRxjW589BccVmPZmc5pKy6XGfWS54+9y75Fm07K1Pu
 QypZvkTAx5RnzTfwTTykhPTKgBjSiWic3iNi2oC1Aid1v9CMO52l502M5oO3FFVvfICp
 WuBQefslaqKl7JcDhSA2q5Ns+cU1b4ID5DTEQo/rJ8JugA08oHVLNoXT0UZpotoJWz/P
 s6PojLLlBpdjrOFwAg0cQc3u1DijYNw9pi/Dlv4hFItF8/uBQkYEweppJadgi61witdG
 J/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4G5m8oXbbQtsh8OCMEx8KKd4kkhF5K4IKV7ek+pY5NicuDqIz+DCFkfxCoxGHLZV1wPKQFgxJDII=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztLsnLhiv7D0HcTj4plQ189Y178SyJ6jzHI+NoNjqdpl63f9To
 dOUA8DWzbLM1HUnu+0GAE4yEpF7zMHSGpHDPtEZShhuXrvzPNsr4TdJ4
X-Gm-Gg: ATEYQzxBpg9r8Wd1s44PEa0AMkasFLpAUPVdBNQ6rzw2PiC6hmeRo+vssqzvK3ytowT
 iHBnn/TAYi1CMB+Dr6870RT4OW8TLgFd670SXN6SBY1B6Dn3WwqXfiXAoCCtCTpz+oItqENHM5z
 rm5+xHK7LM4HdIbX2nxNJswpnX/CmhzWvFYGqU83UVfGpEYB+Cn3xMJ/JUfb877oJ/+TPYZaf+S
 0IiDhmiGWlppDUNfM/87Q0IbCmJsB9eovBhu3P0ZJYWQ1ip0fGywG/v0q6xPFBGk9oRJS2vqvGy
 oJUbHRpmSpPVl0Mp/emRPW2UvfQj7mcvOgf8vsf6VR35CavBHvABMwNBWajGTYstmDWWF4qWX8t
 Cgn4TUn+l3RtxDko+W8+F0PIzSkqYCyCZ6AOsKYhPPsI/vkt3XVPe3URviLDQngyuHNxRBBlKkU
 DJxdggfGmgmCQGsgCo+maSE3iO3mwWCn0=
X-Received: by 2002:a05:600c:1d10:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-486f4421c4cmr140167715e9.3.1773938918105; 
 Thu, 19 Mar 2026 09:48:38 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:48:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset
 deassertion delay to 1 msec
Date: Thu, 19 Mar 2026 16:48:28 +0000
Message-ID: <20260319164833.409126-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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
requires waiting more than 1 msec after deasserting the CMN_RSTB signal
before the DSI-Tx module is ready. Increase the delay from 1 usec to
1 msec by replacing udelay(1) with fsleep(1000).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit header and description.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 5020be0f72ac..715872130780 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -807,7 +807,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 		if (ret < 0)
 			goto err_phy;
 
-		udelay(1);
+		fsleep(1000);
 	}
 
 	return 0;
-- 
2.43.0

