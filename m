Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32521C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B6C10E72C;
	Mon,  3 Aug 2026 16:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pS0n4062";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BE210E72C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:37 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so18630345e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773496; x=1786378296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5EYEilaxvTpzeLrRhoCx5eknHZ5V8aHsBlGVEU3TBs=;
 b=pS0n4062Y0fnLK/SjXGkUVMcrLefM/Wqskrhh+2/87v8YUfcD1kqusrjwiAMBoRgGG
 HRn1J5USs4AuiFMzLKMufrpzVOnjPrrIu7XqguFFBRHEV2pXeNaR+hjgZmT0wWQ7+7xg
 /EAGzfY9WTpmiAuS/zx6zCeTpAA3V5oinHeMg39B3aO7isZep69vxq2e9SkaIpMadvPk
 8zrZwqSYoKTejlpCIrVqXzokQof6as18ui/v+gOkPOsQLMda0AoVS8mulNr5wJr5TR9x
 Q4cB26KJELXZcZNrFMEtpCcpmJSzzExE0kRUTY7yuKBtvtcAwinNeerY/72FI753/SbE
 625w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773496; x=1786378296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5EYEilaxvTpzeLrRhoCx5eknHZ5V8aHsBlGVEU3TBs=;
 b=mhJS3RSAVVYr3Sriq0Ukn2IhuoAJKnk5wSXuh0wcjiUl+v4BSV3qm9TsuEJVDhBlGx
 xId+TT9LvL0MSJdUovT91oH1oYqto8D37AlhENlK0i8QewHb0o/QdWTM4WgZsYbSgw1V
 jaQOOfhogmBdmtQWiiQP+5bWemBEeL8qAMa4b1yXvq89I46HfadRAQyMimbKia9w3I/e
 WQaSUn0FTg4/pNXGDusAWRO/e8D/OhGarKQIxfzCyoBKrmgAT86MNrAyt/BwDd847ah6
 V0NY6QNfHs7SE3pEHACHf8ntu0m+iIOxde6uP7/a+mM5j5FJb7mvC1fMI0qaiDIezMma
 1FCw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2MwW23hj/nn1Ztc6avnGUuhLe8iKUh83d5CWp0LRWCM3GYnq9Ji3FuDkPM+wMwmUzY8Q09wzA8eM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywdo2qJb7JoeZeb0S2pAwoyiKm1yBPQ+xk58wy0Cn2lw4xx1quN
 BzKWxjhLgUvyHodB1Yzt0b2Fwfcs+emgOvQ8xBqvQ7BO+wgtKDx3DlnB
X-Gm-Gg: AR+sD106peQAet9B/vIzm+WPg04/O3f28hzEvsG+hQemm2uc2nmJawdIPpMgCn94/66
 /A9uHftDwrC6XfcRxSgI3z8W+P1TVSyK5pwxu4Wr1vRyectyKmu1dfjGp3ZknDb4SiVxv0phVcD
 wB4llK10N4nNAbD6/PC3iZPwjdQWhB4qqQcWBf+zSnsq9/3p/HMSsVarlfrWZTSEMgb5+balXIe
 10u1buaAMh6qyV20xg4VTRvWXcGRq9K60L+VFpnFfGuNtDqM7huDKJnpIF9alp8ictAdumUDuXa
 MbuffZwnXy0S9Zx+bsoqJgqDkVWbaFnZP2uT1Kfge4zEtipFaMPXOs0ZQXk7kZpcgHO84NEd/N3
 zWWK7KODSZWLWO8Aj6YF5z4GQP+jo+d6htzcQmb+/deG2f3uArNOG+4GWUTYqs1Ycisrgax+JEI
 d521XXvUcwQK9gV6vRLPpl/piF258ZHduDoho+vLGlUuTaZGUzxAfmUEwlifAGfM0AzmQ3I02Ox
 mwZ8XRmQjzj/RR80eAhYWbhA16vc3EPTY/6Q2buRJP/LqY3R30PkoAoEpYpDd18V+1kmSyT3jOv
 6fEUbZBM2e4VBIufoh0tdm84feFaM6dqQD0XZOvu5Qvpm8sf3f9AV/JoaaKVLlsef48Wy1W8mY+
 gbbtyqC+dfltud6wheGeffSwUSfG5LA1XbMtDz8spXsxVegYizk34PGEQLAWhsBXiwWYIF7yytb
 UNDrvM9CeUGO9K
X-Received: by 2002:a05:600c:470d:b0:498:490:3bbe with SMTP id
 5b1f17b1804b1-4980c679d1fmr255703765e9.16.1785773496293; 
 Mon, 03 Aug 2026 09:11:36 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:35 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 10/13] drm/sun4i: dw-hdmi: Drop TCON TOP port reference
Date: Mon,  3 Aug 2026 18:10:48 +0200
Message-ID: <43ffcc17f7c3f94c1d7bd1ee89134c766e84df35.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

When the HDMI controller is fed by TCON TOP, the port node used to
enumerate the possible CRTCs is never released.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 96532709c2a7..51cdfa1ae3bf 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -83,6 +83,8 @@ static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
 				of_node_put(remote_port);
 			}
 		}
+
+		of_node_put(port);
 	} else {
 		crtcs = drm_of_find_possible_crtcs(drm, node);
 	}
-- 
2.43.0

