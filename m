Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850C1C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECAF10E728;
	Mon,  3 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K286SQLy";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5770910E728
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:36 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso19346115e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773495; x=1786378295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQSiWGawSQuy9JjtPPgjfFND1Bm19QyKn7xZ0H2UpZ0=;
 b=K286SQLysZoN0PBIunPmgXhao7yrM19Py/FiP0BtGb27hM6dTchVQgChGbjoMOEeNW
 zAfsBFwdMotrSX475pRPNOWtu1MxmwSEyRLWKM4KYJGVT76WQMrY7rjNmQKl8uhxhHyO
 bNkPufd+orrT4GhFyfJO3hnZCrSLyknHCi0ZPSRqAQ84+Ui+LJYbbXLMTqaRYj8SsTVE
 W74yHhsoiATuEoox1d9/+MCi3fdQZ64BrzlIdw2dTBSEulP8ct3MfigBOL4bplUFUBGT
 Rm54QLq5Bp+Q8fDxLoQaYwd4gomXvE1w4dQEUwYaufXkmX77c5JqU7TRq6f4thXE7XCD
 JBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773495; x=1786378295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQSiWGawSQuy9JjtPPgjfFND1Bm19QyKn7xZ0H2UpZ0=;
 b=fyCqi74j+Yf2OmEmVGt5NtwsE5YijJtdh5uxiuHvi6eg5YjhrFYZ9XqbDDDUfG7Vgs
 DOksug3ELx5lmct4vWwO/ih1tXRg978pDt/kbxd0ic6TOtltdHJUWCQVxrl9tdXK7NqO
 zi6POrIBu1r8tmueqzTUXyJoTTqNclKbrTqUnJ1eT54pnDsy8I723ZjmzemvHptT6+Da
 yCqo+qG0VX7J4Rrtbu4bGA1asLmnOFRpWiC+iVd5vf05IgHAZCxguCc0ZyAMezLABK2t
 m1Pb6XEKE61PP/BGyT6Rv+coEwnme8c7g4Ox2KN2ypfbqsBRq01/uJ36Bgbu9pZmYKNF
 s5Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoaQ2sGolx/onbtFvg2Ij3stBIt2qX9Hucg8umN4rcDNFaL//gtB2XYFcq9y5IX1LH5t8gTt6DfH1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzk99ZB31QNVziRqCMUydCPKisLnweaxGLtICL3tDVTBpIhS3En
 BWUAEsNirTpwnoRTmlhZhEIzgqIMCibRk7doyBez0DajNgdl8KaS2alP
X-Gm-Gg: AR+sD116TtiACqPsokcVt5dHkmMMenvztcbnPrSByobPxhkLqID/u3NHm90UweFNLdu
 VYx5k3aGFogb3r4GqJy+JkD+qurM7ziYcUKADme4TkO5T4DPXjk91lr1OXDZRhXFCYeX8ypQxjQ
 MYnE1bOLUPWRz8W/qt2a39sHl5zr5jLONEoZZ7Zhid1QrVOevDxLGnu+giSdvGxOkP7U43ftckU
 P7m2SZqxUHFeoeKLwdtmMKdGKni6vKa8jq2YCBIPkfn9OB6vYTGtK5Jr8EkIE3P3ZH4ZkuGeStj
 rV/anVpauAj10Sqc50tcdt7kehm2xjEVh7wrPp0nP12VdI10/pQxeCaipQL1hbxIOc+ZkE3TMIg
 GDcLzHTKkdOD7o5ifeQN+Tfq/6IHkJAinh0m5kwAHwXs+7oARbrlm+grcMuMjQ1IMoehYMvD4fy
 gmkW1IvCdtx5bsb6FYb4wcNiNgel1Ts7OdG/sGiwfDzW+USFGUT5cqqZeUfvjXcLadai/voE4Zp
 Pp9wccoiFGD64thhByl9aVxr3sVc9Y03VQ5d0tw9n6sAly8bnZB//9d1rAmOMRm4ID12wWrtq8U
 1awv6EulVc/sT1E7hMHOnl4lTr4xbAUxvlZpnk0nzO0MmhxYHJZQSDLd5LlPRSA7kZw5KNLBwea
 FzZLZ5Ewp4YFdxUHoGcwwD+4hcGRa9UYirQwsq/rolTsJr/bHSXboGTta+6N004eiY8n2UowGMo
 gdsg==
X-Received: by 2002:a05:600c:354a:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-4980c673874mr224712255e9.15.1785773494475; 
 Mon, 03 Aug 2026 09:11:34 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:34 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 09/13] drm/sun4i: tcon: Drop remote endpoint reference
Date: Mon,  3 Aug 2026 18:10:47 +0200
Message-ID: <3f5ec952ad80cb51efebf2fe230df50259041a23.1785772659.git.jernej.skrabec@gmail.com>
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

sun4i_tcon_of_get_id_from_port() never drops the reference taken by
of_graph_get_remote_endpoint(). The function is not only called during
bind, but also on every mode set through sun8i_r40_tcon_tv_set_mux(),
so the leak accumulates.

Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine with remote endpoint ID")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index de2d66623f7a..67047e3b657f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -972,6 +972,7 @@ static int sun4i_tcon_of_get_id_from_port(struct device_node *port)
 			continue;
 
 		ret = of_property_read_u32(remote, "reg", &reg);
+		of_node_put(remote);
 		if (ret)
 			continue;
 
-- 
2.43.0

