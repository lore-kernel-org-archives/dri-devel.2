Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A982DCD8C89
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930A510EADB;
	Sun,  7 Jun 2026 17:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOzP1x+E";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA6E10EADB
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 17:19:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so2101715e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780852762; x=1781457562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmgHB6tze2Xss/dF/g3O35dG4S4EFs7DvnlvIwWXTEc=;
 b=WOzP1x+EatxhAMIcIQf6VY/NbMU+TxuzAvjJqd2RHOJGdVHUCbwJsaZv84tNqdnMSd
 N6cpZ/vH6fdYT8XmmXzdXUnIMNNsZN3p7XnYMYbCmkU4w5G/o8mWP4/jbKvbP0G5/Ojw
 vgEj8eEkKj2sHKeyau65stIJMXYWrRCECvYLaKqy9dr2ox5mWO1RQSppB5twb/udbX5+
 fVBnVZxgqwfeRE6oajxcCZe3m75IWf9ESMZrJEaDGA++onlwVubLmahqZKrGR/DbL8aL
 rHNW+OG+9i+S/g3Dp4QwKuaj49q7EYqSAZp2uvOgExPGTt8Pr/x6aQBioC0gLzRq5emZ
 UAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780852762; x=1781457562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tmgHB6tze2Xss/dF/g3O35dG4S4EFs7DvnlvIwWXTEc=;
 b=UD5SNIcVS80utF6NYZMZocFr684i+PeK5QIUES1pmHLzW8HtPUUdMKRYwQAv1EOi8i
 WtrCn6N+A2kINbMqf/1HglY126YTxvROsRxjU/B2gzOKfLP/ggSZcJzNldWO/D2sv9ew
 ekAWl3SKbywRnuStAQeJAW2P3pfcWHAjlli3kfXe8nRq1tjj3Rfu6i7ADW9Vs7Sgt+kF
 q65fWdlGoXzvVZ9iULob03pRVjC+kIJUSf/9SsdPgJ185SZTsGF7N1u8i1FNvOrIY12p
 NxOWlTmNoNG6+UcvWo5ioaG2GCHHacJO0C+VMRWQ+Ex7j6RobihOx8Zs3VLPoIDdV9/d
 h95A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tUYknsjxmiUmY3gybdcvSEoQhYW5c/0EqLM6Hbm0pELzWUcALh+G62fx6lBI8q1vw4MBsvoH1urU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzItZD73GqnstMIWSMXJLQb4/qIP0BvLkdYIBUJRb/qZz8F4fdo
 u3rNwU9k8fTJd5qwDSi6MXxy5WA6R2zlFiLGPOeWxuHpWNhi4aXBXyzQ
X-Gm-Gg: Acq92OFIyRi3QGIMaV3R1c36BFfrakv4J+uXwUnHnnyFsKBskqms+BUrvg2BOQhNNSz
 lUIA4FrdbA4VQoVI46fLMQm+YWMXDNY+1j/pvFir2+RHRQ+DLo4TnyHGCgMWnDtzrgffuU83Sx8
 +Kxnm3y6nZ7w88LhD4liPDeze3jfN96GQIGvCpzQ5Q17ktupcVNlfPb8wHnfzn0UpegZT175fKK
 swuokGX8Cb7YSvnyvbV6Iz4y+XxqItp1qvIrHxJxrb1SsT0GYW9T8siSMSumq67L+yb8FX9U/Fe
 rXnNUbwdqwXiWjs37zi+5mJEvXsBgeFn3p1vyQxoS34yY3FtzWSenk+k9smymHUSPzxNi8L9ddI
 t2I2dbMGmA8ajx454TQxmh6RpbGzrdvJYB/Q3ieKVUR26FBSrbbBi09CdTmljy4E6D9hA6HRAN4
 mR1Vhr2AUwGKDuac4ObsjwEb2md+l9qB7HOThd5iJMtsswumztxxkNfuZbumX2lAFr87qa550=
X-Received: by 2002:a05:600c:1c1e:b0:490:bccf:2bd6 with SMTP id
 5b1f17b1804b1-490c25f1143mr218800505e9.15.1780852761462; 
 Sun, 07 Jun 2026 10:19:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2cbb4cbsm162470085e9.0.2026.06.07.10.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 10:19:21 -0700 (PDT)
Date: Sun, 7 Jun 2026 18:19:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] drivers/video/fbdev/sis: Replace strlen() strcpy()
 pair with strscpy()
Message-ID: <20260607181919.2b916ddf@pumpkin>
In-Reply-To: <a2ed1741-f49c-4a16-8d4c-e6698bd3dd8b@gmx.de>
References: <20260606202744.5113-2-david.laight.linux@gmail.com>
 <a2ed1741-f49c-4a16-8d4c-e6698bd3dd8b@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 7 Jun 2026 17:50:00 +0200
Helge Deller <deller@gmx.de> wrote:

> On 6/6/26 22:27, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Use the result of strscpy() for the overflow check.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Hi David,
> 
> I've applied your 5 patches to the fbdev git tree.
> 
> Thanks!
> Helge

Thanks, that'll be 5 that don't come around when I try the same test
in a couple of months time :-)

David
