Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F126606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBMdzzpH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227BC10E3B6;
	Thu, 12 Nov 2026 00:29:05 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6675810E3B6
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:28:59 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b350d5fe3aso3142717b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794443338; x=1795048138; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
 b=WBMdzzpHEd6D1rYr8APF99XPzRfzhNFvKoZohk9necjKwVLvVM/fFKREaXyRHs/cfT
 S7fNBIf+8Aw5E4BXb+4IjRCpGhdRNaqwb3mZFJrzUbLoIfQQ9TLXoiKouyFuukJehzOp
 iNp1LYsANMY0qIYMU6+3z5C8sVFU0JKeIcSvmGLKUq+TSyqxE1SVSPtj+/wxjpTWkzCa
 /O2enlLU2sH+4I0tYOGPoXAnLLQEcs1HIB1sFyYHcjRHx3dkr8U7WuqsOeL5D8WX/0WC
 gRBLrGOuzfekw/c+dWketxemY/8uzECd8kYp/yzVYRnFu/ojnouQRH7y8GMNRPQElNAa
 LNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794443338; x=1795048138;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
 b=Ly8L+GSzq56qZ9Ro7gkbQldt8NNoVXmDZjvTj2z75I2IXnlPrwG5JTS1FYCKXkVJhZ
 2T4fxN3h/wi0zlkUbHqxLDbzrDyKWwT3V+oYe4XcLAaVrWJXEG0W9ll0fW6h5ASKquXO
 O/+Fo4f3MSFRMdk021yx8pqSQ6DM8Wcv7FTid1mO+OxUTEeSPGdc9X3lDYhgVVMmpYz3
 ptLFU6KCdAoTb97iT1Or3Ge5NL3OrUB+3vItwHnzfZJo9Zvhp9QYl7z6mFpVbR7DIB1J
 j5S2Af1pCsFIjU/bMrmRjvHcZwPSQJCMoEh/YrkeZC4uDohQ94rKl4GuDBlF2F5PlEwa
 RGIg==
X-Forwarded-Encrypted: i=1;
 AL+hErEmQJth7DU0A2iS5f2SjIXjvz99nBJsZ9S9ig25Y0ihcXV/lpP3zp4o5ibaewCTIe8czjzAHufA3Ns=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8K96cKUU0sYigezwigP1ckKmg49Fq0ItfUon81/482Ou+yj8lA
 TRJJUeNDiz4uGoDePLjcNw14+HJwzXLW+n7T4zhqooZyq2OSa2sZUZ54E6DBVuIS
X-Gm-Gg: AYBFou1c6dSm3ze6a3YAwJSyC4enT22LRlCiBpP2NClejy4ABY5nFh/1s5buL/JflP6
 OCUEQD8YObsjezwvn6+cIy6H+dB1l/LJcC6dxFJ0UmEEtj+sr/1MOHQsvzF4jxUXVJvl/ZmOCZV
 RW7/S3hvEpQ+VcxlI2bdxfG4Y9YqBrxVr5KxXmO+z4cvpDSsE7fMIDC04kAq0/Xnk6ZtdpXNVRb
 JZB0wVQHlwbCMPiK20xdco/m6mE2iD3JcXD7onEFdVlo0vUy+4lRZtiAgYQ/gJQyEspuAvwfExv
 MJ80QJgGBYfxr29Al96Btqvegs6EY2emsBSIyQvOMZy4LBFaNVlqfXMw8JzB9wEyv28+wVgKM4e
 i2NMZCzIpnm3ZKL/QE78PRg26vrF26JMazLCrgLzxprnpOD9Xmv8dZzRjYP2qn/06IKrtVZAAB9
 Ob2vWstttCgXPwXvIgAbZtwnqtGKAy56x+kl5XpXJiRUPF6oo7FrTVbwKGfqAJIKoi+lQP2qiBq
 KvJ7U37GXviK0mR5Bra1DJNrXDHqBTOfHKmxC2g2/cyr7pfkGAD6gPhLM7olhGfwnuahDhGVwGZ
 TvUWw6nv6YZiVbaK/rG8DpJ3fLsDMTgRR4nVr8xgWMgyfpEbOZuKGJMJ0tnh0ZSzHfETL/E2a4L
 BvyffQYJdQGc7RIbmjq4URlOlNRPGeurCFx3TfQE5TKZ1CPZFBd2Sct/qMjopjg==
X-Received: by 2002:a05:690c:c0c3:b0:8b0:6722:6734 with SMTP id
 00721157ae682-8b3bb155926mr6839747b3.34.1794443338082; 
 Wed, 11 Nov 2026 16:28:58 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b3933a6554sm57571227b3.12.2026.11.11.16.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 16:28:56 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 11 Nov 2026 19:28:56 -0500
Subject: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE2iIoiriEW1gxFaaRFJ4+6Kt
 /sW7w/gyTF5aJIAjk72bE2ESBNQkzQjIetoyLO8FHF4jlJZg2wdrXJDcywLSl2oStRFX2cVxOf
 maODrq7bdb3/0M6n9TcF9P4NsHx93AAAA
X-Change-ID: 20261111-vgacon-ioremap-null-ad4c7184b807
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 stable@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=br3GFCtz3RXFRK3DsA4LkWP9fcwbxa8J0zn4MRkuUF4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLK+criL7v37qOiykO8rawfHuuk+WyP0ikzsHuj9nsVwQ
 sin7fCvjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmUTAjQ9v1oF3ZfR
 8OxC4xawm0WOOg2hj571rb9g/LopWvnRE9dpPhnybXhpaPzH/zz0vn7L19vfNZ3UWnSt4l31dM5
 BKapXb7CDMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
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

On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
NULL. vgacon_startup() then probes video memory through that NULL
pointer and oopses in console_init():

  Unable to handle kernel paging request at virtual address 0000000000000000
  pc is at vgacon_startup+0x174/0x910

VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
failure like a failed probe and fall back to the dummy console. If a
VGA card is present, locate_and_init_vga() still switches to vgacon
once PCI is up.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/video/console/vgacon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e7e6750f1f87..09f7c376b468 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
 	}
 
 	vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
+	if (!vga_vram_base)
+		goto no_vga;
 	vga_vram_end = vga_vram_base + vga_vram_size;
 
 	/*

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261111-vgacon-ioremap-null-ad4c7184b807

Best regards,
--  
Matt Turner <mattst88@gmail.com>

