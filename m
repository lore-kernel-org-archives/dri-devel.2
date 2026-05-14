Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5112FCD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B002C10E257;
	Thu, 14 May 2026 08:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="PfibdNxs";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326E610E257
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:24:54 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso5535748a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747094; x=1779351894;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
 b=PfibdNxsOrPol/QEvPeNxLt/IA1CE/JgExAf93kDYIiP3T41Nds0LFQRu5EBk1jT5e
 /6zYZYVXeHB/YIBvu46mmOcFpf0KDddSlFBsZphMHbxwDhIA1Lp7xgx9WmgRJDu08+gw
 ksU6ZouC/bEzl610hRvNx7MxN3xDwCb0qg+EaZPkipZF/QaPZSohYy7VBuvn8yduhYCd
 e2/4u/HOHBelwf0Uz+KmOkJ7j7Qn5QKaxRNVTm/n7gxJxJ+/S0CHh5+CRsCTwW6VryHr
 usuG2lg+AKQOPwnLZk5jYBMPChG7HIxyaC2ZIE7L6esBsnKD4HvtJzuB6jsjBJ8HINjX
 yTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747094; x=1779351894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
 b=ScQFfA+JZHKN07FRZJD/dQnk3/tFQK6i9WMAXiiSwB9zIhdY/ns/o4jj/m3xoLL7n9
 J7OQw1YctmiNbfngoNfmVT3LoJzygzB+FYNq3jgK6B0NHHY7AWbRkO+TAaEAculAz20F
 NLnVEhiul2OQj9Hv7SHgSOxph4ng/ON9GGAZsoeVNtFiFJ4S1sfxSG+HmrwShSKXk6YZ
 ManB12BG23n7FgNuL4vriSHVWo4z2bL527CRye6cmHEvQtGD1wVVCl8yGOMg/NZ1m6n6
 PhLVGnED0rkg0xY2wE2D8g92RZeN/9CyovDB3Q8p7ThgBdMT5OJDIeHivHmLUQYbUbw4
 1c7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ96gcvpAUPS2o8KcS+Gyc5bop3ncFOACP/SwcSOTdZEhAHfYcmWQphNKZ2nriZ0HD/BNATynLKlau4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyItu1RC7xmBInILOOOBltX0aGDfyCCUXieyHJ6LaV9L1RxYSnD
 BtdylSBxW/bRqIy3PcXrMGoTa3MiYfwwrMS2k6qq+NzonDiEMWHtnOop9VxUtRMb/0I=
X-Gm-Gg: Acq92OFGyFAu67es0RDgDPrMLopIFcn+gac58SfOaihPzXKDZ6jBA4S6WSvBi3uyDb+
 TeIQ3pAXu6cJJHMX39102NWr4cK6Z/dtyf5XV7wRsgT1ZehppF4snzKxM8qL29/cTxwzsunReTL
 vCj3lsujH38REV302S/J+KseBybf8fV8SwAgZ6V/3DPLqTnuJ+CgHhtQlAIVJKZ3m1hXDzqGAU3
 ZLPnewH/XTcBV7qgif1d0/IlDED8Eu68EZPZdApsrkdiCoUS/DI3f9F8K3+xZg+sxVrJCyYLXVI
 FLd/lVcMByNVsylGCo6V1JD23yWb89B7XpS4ugqbxtMyT0Y9JmVhGNzIpFgulYSPepV+OcV5J3O
 XaFSgjp9QfeEjqyq1SP2Tkxve/6nxZkFI4FWD7mUMe/ZHu0iSo5k/iMq6iE4J0adiev6eQcF5jX
 eqhtWB755+R5ekMFpw0V80lxg1G0VRvNgYgW7uQc2luQTK567RqQoAKpWOChWc7jJ0Ay9b0RlNo
 1+fusdmaJs4+UE9TzW5FWnaXXx9XNMeAs685prRg1AV
X-Received: by 2002:a17:90a:ec90:b0:367:b8ad:f0e9 with SMTP id
 98e67ed59e1d1-368f7990c58mr6047925a91.16.1778747093565; 
 Thu, 14 May 2026 01:24:53 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:24:53 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:30 +0530
Subject: [PATCH 01/14] fbdev: hecubafb: fix potential memory leak in
 hecubafb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-1-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
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

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/hecubafb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 3547d58a29cf..dd2af980f3d8 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -192,7 +192,9 @@ static int hecubafb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &hecubafb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_fbdefio;
 
 	retval = register_framebuffer(info);
 	if (retval < 0)
@@ -209,6 +211,8 @@ static int hecubafb_probe(struct platform_device *dev)
 
 	return 0;
 err_fbreg:
+	fb_deferred_io_cleanup(info);
+err_fbdefio:
 	framebuffer_release(info);
 err_fballoc:
 	vfree(videomemory);

-- 
2.43.0

