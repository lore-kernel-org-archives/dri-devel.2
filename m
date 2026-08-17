Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABD2C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0B110E808;
	Mon, 17 Aug 2026 14:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RbSBNuz8";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3536510E808
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:38:01 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482938466a7so2097658f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786977479; x=1787582279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OBLew5lB37WQynm1dR6uSGp6+f7VUP2zu8Ib7jym3v8=;
 b=RbSBNuz8BhRlP6qj7+hTy5BIJbj9W+yXniuvVnPq4YvrYEtf2tywykkCn6Ul8zTkAg
 sI1PU1czsqEanR1hRuco2zKhYO2+k9v3kMIX8kmp4lQ2f2XaBfYiC5gCSUdd+Yt4h0LV
 sDUdDhGad/S7FDST7zOzUMcV/tNDba1rsEp0Fnb9yJ4BdkoiOPiqwjZKx1T/alR9qHtv
 nW/NiFkSvpfM0DBehU9UJ0CVgtWGyuD1GIcpj1vlOH6W/gwLpF29HZ188PMr2BA9pBon
 igRC1eYWDYZVOb0S8Pwcu+6J7lAK3U4iYukAb33kFRFEP8w4cK3zx/HGRzzzgo8A0RIv
 Wmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786977479; x=1787582279;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OBLew5lB37WQynm1dR6uSGp6+f7VUP2zu8Ib7jym3v8=;
 b=YdUM916IY9eiQ7F+ZhXuTEJYwNTE10AIqYFD99tYcmaFqihaJEKzWML7UM6eLf/yuF
 dDE5ArMxhTz3/PUhpjTwmd2eS8I/QABI9pnYnq7qNk/oU+1vuwdCgygsETgfePE3ZYAO
 EyEoQayFDZu4+vpMH/G1MQMaOqwmoOnLP9qcGFKOd6T7wkZZHbBDW6TCKQyTo5XzoLAr
 DPSj8Rsh5Hn17vPqRGIbpUVVksYLn9niBeSL9xpzM+7KsJuAAiAPjzs0L04p8fbBizvT
 1H1HM4KykeHaf2kAmRfJTfJlp6zXsHrR3FKk/omHjE70LL7wAq5Z64WEctyXcfyR0WBN
 qAUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcMvjiLmAhZvqe/MEFLqH0rTGVv4s5V9zJPE2Q66tBMH5GBQ6S6iiEVmRB7F5LNduwnBeqHplI+fQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhrMHd6RaHbkNimVr74IBERowicLCHmt4FcS+ylOLfmQPFa7zh
 TODRC+DBSEFhM2USH08CKC/0RnI3Q7qdXW98i2YQA91/4+aA4gwi15LUCELeSEI4
X-Gm-Gg: AR+sD122xkq7d1lgcu7lp8lYkVi+4AJh4jp0Sr7EvdyQDwRhKBPD6B8yy8WAab2X0Hn
 LXO8ZOHgLofR9mnbLYRjEZ9IMR9Bo01AtZyc38nr5YJfcS05LpMpDNClr8HKtcdHqoPFOEBX6lm
 QoebaW9liC3yQJruQcgoodzH+P+/nIeHdZiymoNDcTs+Af+2oKQA8VoK/FUqe83NiIfBILsDuul
 N+2PjQcFBTte5uFG1qVuI3Qk9VhITsXmMC6pWKtt5zgj628roY0DLZWxmM4Ew4yJLlPl8JWKlHF
 fP//uMQ9sOSAMDb2sOl2jz6ZFUX2FlWFvKUHRK8c9+PpHKURra0qWrSzzDIqbuHcwwV0uUluS/d
 74FEuaoljpdgQJhbv1lk+cx1HilGxAXxxYAuyPuLVJhZRev7zinD+VW/8xLV5Ey1F1P4mrS8xbC
 z3nZAbuRrcrP5+XEwmPTwcKzeRyyPgngkQFM3uO+kxNWO9mso0vecT82rAghu9jxqdmUsmF5bNx
 a2u03nDPnNRV89+x/5XPLHH/ByHwkq8bWpv
X-Received: by 2002:a05:6000:3109:b0:47f:e748:3ae3 with SMTP id
 ffacd0b85a97d-4816070bf1fmr37790737f8f.3.1786977479416; 
 Mon, 17 Aug 2026 07:37:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b816f7sm4136493f8f.34.2026.08.17.07.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:37:59 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:37:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
Message-ID: <20260817153757.4a683d24@pumpkin>
In-Reply-To: <20260817031816.188833-1-yuebingkun@kylinos.cn>
References: <20260817031816.188833-1-yuebingkun@kylinos.cn>
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

On Mon, 17 Aug 2026 11:18:16 +0800
yuebingkun <yuebingkun@kylinos.cn> wrote:

> strcpy() is deprecated for use on fixed-size buffers. Replace it with
> strscpy() to avoid potential buffer overflow issues.

There is no point using strscpy() to copy quoted strings into arrays.
Indeed, if the string is too long the kernel build will fail if strcpy()
is used but strscpy() will silently truncate the strings.
So strscpy() is actually worse here.

There are plenty of places where the destination size isn't known.
Which might be worth fixing.

	David

> 
> Found by checkpatch.pl:
> WARNING: Prefer strscpy over strcpy
> 
> Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
> ---
>  drivers/video/fbdev/platinumfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
> index a08d955d9b43..fa27a3a4f05b 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
>  	fb_alloc_cmap(&info->cmap, 256, 0);
>  
>  	/* Fill fix common fields */
> -	strcpy(info->fix.id, "platinum");
> +	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));
>  	info->fix.mmio_start = pinfo->platinum_regs_phys;
>  	info->fix.mmio_len = 0x1000;
>  	info->fix.type = FB_TYPE_PACKED_PIXELS;

