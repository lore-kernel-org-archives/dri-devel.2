Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0D8C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B35B10E720;
	Mon,  3 Aug 2026 16:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qo/DJlUE";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1CB10E720
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:31 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so12696895e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773490; x=1786378290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/erqd8k66TTCAw8PMmbwYLxInnN4rdx5bNv3CpPzY8=;
 b=Qo/DJlUEpjOhvVB3m02bhe5+0BdUC4g90Hec13cl9HgIiqlfi2p7bBPRnbf3UYh1Ux
 HUHuL2ECAmmu6+sIguDcqu8KKgutJ+tDjX7QnfkUmAwOT5CHzF/WQ8CjiC7RKjb0akCV
 l9GsDghYHNIjblaXeWPrNGA0QnkTBkRtkuNR9ejafM3E8/vGdh5LEYbEE9MUPrhnOt9C
 SQRzQBHUfB8zkOoVhqZelWrxQQjJLNJe6FsuNR52iIEG++MHUL1QXANcx/dB5BPobG+v
 ZCeC08dh7c05JeqYIgZ4KciMIq46r0i9nswhQWSpYntoV0X7ynisR5uwAjDF/+Qea3hy
 1Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773490; x=1786378290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/erqd8k66TTCAw8PMmbwYLxInnN4rdx5bNv3CpPzY8=;
 b=hlWJt+OQqH0rYBpd36h3LH7H8YJFUp/Rai/ASQNXGgojRux3HLRFJ/OJVHL2DiBiCD
 L6pPu7oarq8RRCP5N7jRImIKVnoiyT7IWQKsWizAmGCzxlByqP4+hnPecBR8ButsxtHv
 p78GvumtD0pc8WWFin36WuWICRy3jO+gxXOQ4cZP9RUdOfZhRrlYXjPlSwKNz5xFyt3a
 ESeXsPJS4OindhsgskkI8u/tzsR057J7xBc7Ha+/gttAJqvIWE3d9MG4Gr8ol+B0Jyw8
 3gGxDi4pw1cfFnN/1XR18s7GXWcwtYIsqh6NKw4bL1VtjwMBWip5e0SNf/Gv+Pv8JEqX
 mdrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbrgWQhBLKsnnYX6YhH1uiG0XqVhH6j1Cx4mh2tXFF7FqYYMOyvlwEnzwnH0QonDa5Z6vqfguT5d0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY7NqZv6WkRlxbUjU95hZK9Ltqezw9V0vRw13Si5tgIiqM7fLK
 L284EiQhY4mOzaSlIjiAaRhN8lPmVVEevdoheUIWmXbFBoywdUMQSQnu
X-Gm-Gg: AR+sD13PaX93jGm/RFuuIvHuy3ST4gVyqSEUzYL4rJsquMAgRycRDGrT9LZsf/a9bkR
 Fa6fBYvdw66gMJ+9X3CukV28vM9i3qmzf6algZV+RvPY6Eqt1OV2LAV7BzmjP7731akcczUF2os
 bzRvm+xx7zvpysM90SA8z+01S9tHSp7kqQqs0CgCQau2US9Wti0726fcfIGlogwUMJq/dFu0X3I
 CHN1FehNgk8VMpXNFsh3HxLgE7dRRAPtJeH8TLVrm5Qp5orxQysylnR9elt4K6w5Nqph5wns/EY
 4JIZqcQ+2lXW3zaSMqxXI96OFjzUjCLvd2o0WxXZQAkw9Atlg8w6VzRnwN6YBT4aRKWcbIAkQzK
 Iq9MJRDujiUFpefPaSgjB8Whx+5/aXYvNF2Nx9dbBWB6ODrxiteRKN6lQYUZ/yzdioGyYr5hPeQ
 EA0WID+YE/zQ8juPMX1SwWCkTXlYzwnxTowDdv8d5AtlbDxwqwx76fy6xvDhtLB0aR85vlC5l8M
 HBugkfDbJwg+W1kDH6ukKpimxyTGjNEM3kNONxx4BMLcGQOqvHY8YrfyIS52wx9jONVhMKQDypo
 Z1NA8phy5iDzMxkwsqWqwTdRdq79hw6ZHyY/0r7cpltVwjFUbDeqrBBHfmapgA6ukw/lQfWXn4K
 iodHFMCMFX2ELRyo1vT9ywUZRkqnDPJoIZrMLAmTAbPlxl8jvkCqQCueZ8BZUl65O3fmr7RVFF9
 tTkA==
X-Received: by 2002:a05:600c:3f0d:b0:495:4cb6:71cc with SMTP id
 5b1f17b1804b1-4980c66b530mr267029485e9.5.1785773490118; 
 Mon, 03 Aug 2026 09:11:30 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:29 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 07/13] drm/sun4i: hdmi: Don't leak sync polarity bits into
 packet control
Date: Mon,  3 Aug 2026 18:10:45 +0200
Message-ID: <51ba0918ce016a4b45313d5df1b6ce31b8c8731e.1785772659.git.jernej.skrabec@gmail.com>
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

sun4i_hdmi_enable() keeps using the same variable after it programmed
the video timing polarity register with it. The leftover TX_CLK, HSYNC
and VSYNC bits are then ORed into the packet control register, where
each nibble selects the packet type sent in one slot.

As a result, slot 0 selects packet type 3 instead of the AVI infoframe
whenever the mode has positive HSYNC polarity, and the TX_CLK bits set
nibbles which the driver never programs.

Assign the packet types instead of ORing them into the stale value.

Fixes: 9ca6bc246035 ("drm/sun4i: hdmi: Move mode_set into enable")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 74c7c3720ba8..a27d394d0570 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -161,7 +161,7 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 
 	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 
-	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
+	val = SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
 	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
 
-- 
2.43.0

