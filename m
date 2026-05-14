Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CE5CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB6A10F164;
	Thu, 14 May 2026 08:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="XnaIzUgN";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9115110F164
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:26:19 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so2232673a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747179; x=1779351979;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
 b=XnaIzUgNmPEkPDeb1Eqo5PuJDDUO9JsrJgDjM5k8wRrnZ/LEyhduTROrAM3nBUMFgv
 3TMP2i1q0NCCkIsEl2KBRN06ruv7N9bzboUSGsrlLT/WB4kv/uZj4StgB+VnYCpf42Yn
 vBus7yubVxeuibnq3muASUBPxpZt6EyAxYgVHXxJB2abVB+ncwEgWMTYmRAWp54myK3a
 mKlral7UmU7sRt/9lMXHKolPg1rKnk4amtPlEwrOcqgKM9orHrgE1vudJtUkfIa87J7M
 eI0Nl3XbK5OFK2y+nzTQz1ltaGSKH9MntROjurjJpmNsVcxSDtf5jaoJlbzkoeIn82rp
 qDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747179; x=1779351979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
 b=YyFkTChVdZzng2Jg8Bb1l1/yQ0HEMos94QMJceXVv3Seeu32hcG4RVeXFbAl3XvSxD
 bh/qf3fLPvwaqgvsZgL5cziUCvWBM3dzTjiG842FdtYcMLwEy13lz3//IHJ38Gz35Oho
 oUQxKB+o2TYaOAk/uyuvJjMTfEfVsF/CBOsi10dcboLFJfI0D9jM4SvkyhSks/5UVH2C
 byBA8uvk63onHj1ig0DbHJhCfv4qWcAc0dxFvnouPdvXZacfYnBxTA2bh3MCB2UR/mS7
 crDYFyFDPGtTJBemqLcQgF1uBe5tTTZYdMvXc0YpwGQmXTVbmbcQ2iZuURs1eMbyHBLM
 w2VQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pX8QyY5uHljvZzm2TwPAaqksitMQ0jQMuUXFjqobhiFa/zIYqLhy+4Mlyv0yAAZ/M60sWXJEMSE0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgaT4LflAVImr8JWs7MpJIF075u6SaRjrIFoxtYTTlPo89FRe1
 wJJgPhDTJ28pScDN0w1rTR5mcSK/o7+tam2ESawEMkz8d5CdgeEDLa2JDcYPODYbQix+gyKbNfM
 0rq9SiHc=
X-Gm-Gg: Acq92OFBAzSR9X5yUYYVGJUE6VqJclVzkoJ6GCqenuF4wpa9o55N7/mHXz/NvxCISBO
 rkLGDPXy7+LHqi8L5eUdntxSeIysJK3ejC0htBCvO2xGSpRVpRRgSjmXq60Hj5eb6UkBiigmZXp
 x4SXM0Tfd3xKsIj963Ibj5F7sXzQiQL3pTk2+Et4GJlS2IPW+WBk78Ah/LaKpp0vX6GkgnY6rAO
 EHcHOLpuQyNN6GB4mpkbU3mRimvUetCDtBsWd46QccHKjk+XINnLW/kVOpMtqmkVom6MZ75AQ67
 GrMZYn54kke/FCa8h3qcSbI1496qqzzKJZ0ybgcuqDOyVzVeGPRPF82RnHY4D+sCOQ+EgYndNzk
 eU3ao+RqsoV1sadcntQm5DfaX4/OBHMQFuelqs2S6yD3zsdYi69FMYk7N0y7AdLrdIDm8P60pGr
 rTPlTjC/a8pe636Eqkkkef2/HMR894WZIDhCAqr/7dM9kj9ojTejvNULuHuubWsurWUcerogntM
 TDT8bgnmtC76qURplO2nNDU4t9YqeUm2aji/03h/Faa
X-Received: by 2002:a05:6a21:998e:b0:3ab:13f4:c721 with SMTP id
 adf61e73a8af0-3afaf522ea5mr6800186637.18.1778747178988; 
 Thu, 14 May 2026 01:26:18 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:26:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:41 +0530
Subject: [PATCH 12/14] fbdev: efifb: fix memory leak in efifb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-12-b3a2474fa720@cse.iitm.ac.in>
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

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller, but the string is not freed in
efifb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/efifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 47ebc0107209..ad8dec7807c3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -377,6 +377,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;
 	efifb_setup(si, option);
+	kfree(option);
 
 	/* We don't get linelength from UGA Draw Protocol, only from
 	 * EFI Graphics Protocol.  So if it's not in DMI, and it's not

-- 
2.43.0

