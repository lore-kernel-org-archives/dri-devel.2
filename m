Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B5FC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B6610F247;
	Fri, 31 Jul 2026 12:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="jBSah/k2";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA8B10F247
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:32 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so980379a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500372; x=1786105172; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2f94xloHl4xvf0KqfbafdGgU1JTOpluCmeN1ZaakJsw=;
 b=jBSah/k2xXSQ0P2HmPeWRTY0HxT4U+7XfbXjwA8SMXJJL0um+NC5Q39MTfKdY6vFfD
 DTD0vChnJlqn5POG3MEPvuT8802fDqhKtTinqSFeBeLSt7I2TNq2pxmg6T+hXpvjr6UZ
 TkQqMh40GrTfvvhDuExcdgtjGtrC9GZ8HFlF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500372; x=1786105172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2f94xloHl4xvf0KqfbafdGgU1JTOpluCmeN1ZaakJsw=;
 b=sEtScOC8unuK52yTZ7GEqi6ASjxmQNmA2TACmZWA+YHNe4PjHljXVbiCktDEguJbHG
 fgYN2S1v7yr+bVC+n/wJ54M6GSTBPl7660XRhjpF2x8BInsSfN/5p93uDvCp21zF7U8H
 elV2ErnDoZayLx3dACeUHvhN+IrFRXyENjUxpDmqDQu5Kj8tBLrVEXqoVGz/W2VpV7Wl
 UpRdrma2wSVwo67uE2L/xKsFTbu89VS6/pzKSlqafuPBXEsBZKVke9kygIt6pxHHgBGK
 JlKSKCxaaxWnwbo4IDZ5zsSW+gGVzqP1j+tGioH8JjvnvBrie2OISPkhwdtslkEZow/3
 +W7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5v1hpovhU6+n61p+IyQCZ00wUyq/mvpgZn6Cce+YQWZu/O6A/rmklYWSf0tDQ0Q5Umq3ae3iVC8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfd9E9/KqNdQ6ljm+jA238NGt5boHMpJ83Xi97rZ0zN3BNhsA/
 exay/DBcWDqy/BWsiru9UbuSQa182m6pTL2RWA5tzF/JvomwofXfgHp/MQiZyv0qV80=
X-Gm-Gg: AR+sD12//AqjBZcNRG8fQxwDFqpo9FaPpE5u2V8YWGSPeX4rhzmgc93D5RhMi6TjwR/
 jpVWOS04Mj2lY1TBJYP6KWxyco2sjODpV1v2u3JBhOox7RAuDTNuYlE+QuF9uK5eLGUpOhTGm+E
 UO/ycIYH4OSiRUJ9TGWmDgQp4AHnJX4oGPWImlR64mA5++kiB0tNWMVKx7oHwE/jT554qMQi35v
 nrsjbOIruj4oBPHdMfssOrOD+/AIuFzHmyEzfu2lQhy62qJKd2084ednXtnI2tKmce0vZpm8gVm
 akP6gvc0YrOkcg16Eg5PXynH0u1gWNfGnp+0TmCjhELS6g8b7bT6QSY0dm/ncLZWQWjGCOyJw4J
 QKVCwiq4fb1P+w14QVOvBwRDP6tc2oMni8q+nTmtfOt2IRmRx2k1S0gcHrXrPn2hcxhc2Pw8e8x
 zvALscJIStn+29IbbQaOffqGtFUWu0ugFYvlakDpZWxRxjQyhYwYwil5U6sK1snic=
X-Received: by 2002:a17:90b:57c7:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38fb1378a80mr1615857a91.26.1785500371570; 
 Fri, 31 Jul 2026 05:19:31 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:31 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 4/5] fbdev: tdfxfb: Wake the VGA core before programming
 the CRTC
Date: Fri, 31 Jul 2026 21:19:13 +0900
Message-ID: <20260731121915.3362232-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
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

If the card was unbooted the VGA core needs to be woken up before
poking at it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 4d92ab5b5430..f2b658a47135 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -485,6 +485,10 @@ static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 
 	tdfx_outl(par, MISCINIT1, tdfx_inl(par, MISCINIT1) | 0x01);
 
+	/* Wake the VGA core if it hasn't already been woken up */
+	tdfx_outl(par, VGAINIT0, reg->vgainit0);
+	vga_outb(par, 0x3c3, 0x01);
+
 	crt_outb(par, 0x11, crt_inb(par, 0x11) & 0x7f); /* CRT unprotect */
 
 	banshee_make_room(par, 3);
-- 
2.53.0

