Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A04FC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F1C10EFA6;
	Thu, 23 Jul 2026 06:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="jXOCscFB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9KqN6vh";
	dkim-atps=neutral
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D033010EFC4
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:44:24 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 14D4114000ED;
 Thu, 23 Jul 2026 02:44:24 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 02:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784789064;
 x=1784875464; bh=HTbkVd6Wq6Ip4RQIXSUsnzOc5fWskilI0JTEv1l2AMo=; b=
 jXOCscFBczbYwISru5b0WlMcuYHyvtRqw2pmaH6OT3Lb6EnHg4e5bng8wUhqQiKK
 xgZt4o2JM5wf3TSoNfko74u0BizEFMJQcpUB0xyt8rUK/uh0Wxe3w6pkwJtMDrFp
 2HFxjBDBUBlRZvVzyIWpyQUitKEm+U1I5DX+S6phKqy8tKkeFuFQXiULWI7ls1Ae
 AMVYgGqBwdmK19Vue5knOzfL5SV2TX+U5sHBRjIZLXqHipbTDbd1YByau6/qxdI0
 523mhrbGTm+JGVSd3rQslUvS4VT8zeFVOfHFKqvXdGKTGdxMmayAvZTQUTJMgdkI
 9IeP9BOPkpalxWOxw2UeCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784789064; x=
 1784875464; bh=HTbkVd6Wq6Ip4RQIXSUsnzOc5fWskilI0JTEv1l2AMo=; b=G
 9KqN6vhM/GhgdF8t3p/RBW3V+i7nfswuhNpM9vscPu0k/KZlQRZKvmTqWXWthJWG
 wjO50yIoRaycr1bp3LBthGGuET/plJ+OyZ0YmXXUz81pH/xNb0NTEeeCKoXOnZeG
 LtDE7OKaQetYzrQUCg4RBHuIwQbY2vndGA+bFHSyNaDrSmgytmYTAFwjLnmQZCSG
 aUtJiXVukz/lO3jPDMfD2379ljH2+FhlRlN21wcjWJ9OOSxMy+p4PKphqEvbnoxY
 yUOX7sM7Sg0MvhUlAXrvq1VBwwcrh7Bi4x2Fw1CApahvhRV7ZabgVejC2ytijVyI
 TO5CV3cA11ehOG2y4YngA==
X-ME-Sender: <xms:R7hhagKj-Zpuv1jlefp8cJ7niGwEwOjxShIUSP2rnCsmtRLMT4LKXg>
 <xme:R7hhaq8HJSIluZXkhqZZydCpLGICihC5N3oMhhK898use9lPVR9zb528zRcCNSGxd
 KVKZNoOM5Aa9pU76zN_ydY0rwa1nYbZ9e4PQL2qfKiXhATTq83Jik8>
X-ME-Proxy-Cause: dmFkZTE6QZb+iHWpL1mO+WsK28M5HOJ6jSDCRX4MJVUuJmHkrp8fjQqcnHFMOWQPUMjSZ5
 0s8AasFJxawL3drXqEA4wDRNhL64B0zge06O2h3kUM5afAxmuuvgb8Qx08+jzxeNyg4/dI
 1C509wUMH/JyAZay4iFmSDPW1zzc9Nun5e7N8rEQs0a7yRhtOTjAyuNmL4Me2yxh5SgAvp
 r0zUoj/aqBjFaNW/Jz4ckeuWIPcdBo3ePlbRtqlskTSCkN6XNQftiAi3lJsoYPVY0kozXf
 ofydBXq4yrDomyA8hJ2sCZPhpfTdxDEyEAvfcGgizTxQVjP+6AwT252IobqADl7wftU0o/
 gXOFbQFdLQPN6Hq6O9Slz5YZNemy/9SzKBmLpsIJv247uq99NafRJUJs6UPMzWEAjKmXPP
 NWoq/3xjwKITazN5kSscyqH9sKe4rH5gwQ7T9Psi5qKNf6OBxMpexcyhEoylbCeWXu0E39
 MYedRrKHgFiXHo3bz1DjXVInFZxijiLT/E9VI8JFu7QETP3PrXNbEa3bHdM/qgJSgG1Ild
 /LfmHTZOU+8lLBEMJsQpFJ2wG2wNiQ0ht7ec336hH1SESCBgbPKVcMBrd5CJonKBBMdcS2
 VClczfly6pNpgG9pgAw68pejhtlHxQgzR8Y42k+9AtXcqpb9KKLcp2+hlUOQ
X-ME-Proxy: <xmx:R7hhanYltOus9jeW9PUOYpZ_XJN1B91raAupijg09bYoM4YE8GYRdg>
 <xmx:R7hhaj7aEYzRyHTIC-reNM0ynROz06C8gW_QzCK2zQoaSkaxBqRH-g>
 <xmx:R7hhasmTm0AqrqFNy8nDxKe-rnPZFyu2gaMzW51nqyEqXlWRU8XUsQ>
 <xmx:R7hhajHQx5v4uZGsRIavqVQZ9Lu3um34IE_eNR7FluBRij1opvW1GQ>
 <xmx:SLhhagizdM4t9BqIHhjFmoEGNfEAADeOSlJiNGCG5o8gcKRecpTFC-DJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id AACB6182007E; Thu, 23 Jul 2026 02:44:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ADWwDUKQibi3
Date: Thu, 23 Jul 2026 08:44:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Braha" <julianbraha@gmail.com>, "Helge Deller" <deller@gmx.de>
Cc: "Thomas Zimmermann" <tzimmermann@suse.de>, "Wei Liu" <wei.liu@kernel.org>, 
 ptsm@linux.microsoft.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 hsukrut3@gmail.com, rob.github@jumpstation.co.uk,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <99391074-24d8-4725-8e8d-ac310a666f29@app.fastmail.com>
In-Reply-To: <20260722220023.196029-1-julianbraha@gmail.com>
References: <20260722220023.196029-1-julianbraha@gmail.com>
Subject: Re: [PATCH] fbdev: replace dead select with dependency
Content-Type: text/plain
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

On Thu, Jul 23, 2026, at 00:00, Julian Braha wrote:
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 085d3a202148..1ed4506c0cb2 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1717,8 +1717,8 @@ config FB_MB862XX_PCI_GDC
>  config FB_MB862XX_LIME
>  	bool "Lime GDC"
>  	depends on OF && PPC
> -	select FB_FOREIGN_ENDIAN
> -	select FB_LITTLE_ENDIAN
> +	depends on FB_FOREIGN_ENDIAN
> +	depends on FB_LITTLE_ENDIAN
>  	help
>  	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.

I would make this one

       select FB_FOREIGN_ENDIAN
       depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN

to avoid breanking defconfig files. The default choice is
FB_BOTH_ENDIAN, and that should work fine here.

     Arnd
