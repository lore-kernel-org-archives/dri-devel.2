Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C7C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC5E10F019;
	Thu, 30 Jul 2026 18:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="WDzY3gef";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4445710F023
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:27:10 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84864086bfeso252742b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436030; x=1786040830; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JhElDLQZHukV2QsaThv4BOaHBxc1XzjF+Kx9MuUiQB0=;
 b=WDzY3gef6uaHeXpdddxZ2kH0klDo4wjgWiZvyA6BxfrNa6QGuCQtesnUr6nAw81okf
 Mxu0/0Fs+l+h/UM+X1gyHd04IXkDGBMyOpXOyfdV2xfohRoNa/kZi/aB0Q9Xqbj5rMHS
 ppwnd53+LuS441ZDZ3Ouob6sbnO8X3xPbhmg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436030; x=1786040830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JhElDLQZHukV2QsaThv4BOaHBxc1XzjF+Kx9MuUiQB0=;
 b=rDOs3lHs0xMzs/XkeJjGRqb0GSixuWCA9gWL8WFkW4W9YCU6lpYJU9SJhWKkneMNBW
 KK3CuwII/BZO9GxCgNrKr4ZcgLzLWLng8nLG9ag/eb4QV6peliLaHD3oTXujufKTFBcx
 JmuWmRL5XeH4mnBF7m6k8hq5HEfmCwVEgDkTBIqpEDcJetMWYCttE9L8flPk08epmQEC
 CrYo009CL/RENkvUf/M8/BBBNHC5yfZOALLeAWpvodTYH76zR5sXvbChmjqY/psEDh5j
 1PUDyQ569vRRklQoB3MxN5eqh5C2EmLr6/2b/sUG/jHkrUDWimVSGb2BzmHzoeyYOXUn
 dV8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX+iNz01T+FeztsqOUbY0pXXqxI5KG4D3pyKK4jZ+ObYoC/KtZA7TvHFTzSY8PR1LFWlrMdGbg6aM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHVnsl8SlZUlRD+tvwL3ezaq18pXOi0Lo9AnVtlPl1RipXoPPO
 8Y+AUtyjn/b8Y2CHnNzlUXuTFTJvaR7kU4XIIxdd1WGUh0S6EqAKAmD57X6xP/haEYs=
X-Gm-Gg: AR+sD12jrZwYMprutgjbb30ldDnnYWEMtGCJfyoiKoV5RKrBRGzJIZmTf77nMXxyidk
 GFmo9krQ88nEW/+4AAuQjxjb0AK8koULcIUetsCUO1Gl3LTdiFcnkIMTl2gENcWvM3iHjr9UnhL
 8A/gzN3DSAPLYOB0nOk/PxUKsevKB3L0QxHjusb/KmuXngC2B3yuseITl3jmFXw9EJ62l9024dg
 GukHOQBd+6NTr0u21FWlgKUlJ/ct+sBq1wkpJn3GFPpnD5fRZjbJXGz+M9s/zzG4TllsBEYOUgk
 FS3cKOVGdlrL5QSbwQl9cSc4UbBJYGik/RC2AwXiLCI6hgpvW0KvG9qj8EDOtlFZF16pPpg92ks
 EuZPO/WOmAg3IyMwU4LiBvABe9AmDXbLNIBx8w8cwe2lN/5reYP1CDEenxX/FHDfU4coYbv381y
 NL+jVWkHdJy7QgQNEbHCpPlTKiVRb9ItSj1q8rvx/SWKYgMwMYnlY=
X-Received: by 2002:a05:6a00:a16:b0:847:968c:a0f1 with SMTP id
 d2e1a72fcca58-84ebc3d0aa4mr3376460b3a.43.1785436029678; 
 Thu, 30 Jul 2026 11:27:09 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:08 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/5] fbdev: tdfxfb: Wake the VGA core before programming the
 CRTC
Date: Fri, 31 Jul 2026 03:26:39 +0900
Message-ID: <20260730182640.2808572-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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
index 4c1d847c89c9..9d55efd2c934 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -482,6 +482,10 @@ static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 
 	tdfx_outl(par, MISCINIT1, tdfx_inl(par, MISCINIT1) | 0x01);
 
+	/* Wake the VGA core if it hasn't already been woken up */
+	tdfx_outl(par, VGAINIT0, reg->vgainit0);
+	vga_outb(par, 0x3c3, 0x01);
+
 	crt_outb(par, 0x11, crt_inb(par, 0x11) & 0x7f); /* CRT unprotect */
 
 	banshee_make_room(par, 3);
-- 
2.53.0

