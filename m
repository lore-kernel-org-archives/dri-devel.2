Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2AFCCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4487A10E0D4;
	Sun, 18 Oct 2026 13:38:51 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D6510E0D4
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 13:38:45 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso13610005e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330724; x=1792935524; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KgtDcPhGOMWpmKP73xncVKfTZT69mE2yBqqaKdxCDiA=;
 b=IJ+AABp8BJ2xXVqofFk+safWYFV0U/Si00l8CH/8scNoPtaWnXGNdyx9t9d9P/8dFw
 aLT1Yg0iSfoG/3pTduISEFSrA61g4kTOXGzSxhzQ32rzSBIs6CNpPEC76/RG2cic26DM
 NHOJVoVx0sT5jDVwA+i8pG9KKOmCEZTrPdSWPJqYBx4nPsHA6MaQAWe6XCcKINGw3GL1
 F5aR1RJcS5YoIBPfhAO/TH4EcgjjN5bT0SiFIEFMcxlS4jrrtAUhp/PiIbBopyeHaiOL
 AVXTrgkpw614nMR+hYFEHkAdObLyNMDeJuKAwCVFy8cM20Im3tzLWYxky1xDB5FCFrek
 kcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330724; x=1792935524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KgtDcPhGOMWpmKP73xncVKfTZT69mE2yBqqaKdxCDiA=;
 b=Lx/xoY26ONASomabl+9Kffxp+Do+Gha9Vp+6juSVBAPm2jI6edrJ9B6TGeA3SVNsIG
 vjOIJUPqY5h5+nUWt3uUISryTBmwJ19JhuRygVnjSqlTOeDEiDwQGq31K3obYjskDA2G
 voBqnXA8D/p1DANCJdtaJOPiHNMDWm7upQjOXK9HETP5SGEwzh5wCHUogfTEjNhh8j2v
 Gh6KPJLD5pni8LoAwC80W3X9/gVtTR3cO1+s8d+khvZn7JPA5v2lZltmXG8BVJlr3hw0
 zWOjUbB/mossTYMcaBG/QZ9zOP//05nHru8Ts4eZoSzCXoMklwST7pfDJq2O0oMj2YsC
 ka7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYH1PsecoYphV4cymIvDabE0wsphyQw/4zUuQbZlxWg4oK6A2HBYM75vOcK2YROslbFo8VZXy2cwo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2W+oi8e6YEqEDg1VQjFuJYyUjxJ1t4fqsDv940r+/K/Hxoxcm
 iWNVEAQd76WADXQwpsLANXW7hAB/2aLZ51bEYICJ9qUeNtvyfrva7goH
X-Gm-Gg: AYBFou3dGPEN2MsO+23FUohB/ehB2MUTJntQQcgc3p6xB777x7bqnh6FH5N/cHenw5E
 cecQn0iofxMxwae+/lfjb9vnt+fffK6uHFfhCK0kAiIAxqREosr3F1eCQix6iHbC7pq+KkSnnyE
 EvFOQPNKiIMETgHaBJJsK6cycOV56IKi1jCaCskCIOQUC/88SfSrt3Ndt5u883+Vxe6rmKr1L2z
 mkpfd26oHQc6rDBYwDPoGxJXxNnfUr5ce4MxhVQmTuZ7DZQ6hKRVjkBTbuM9G6xpGFtaH8RPpci
 hy6tQzU16fFkEOVYk3DWdauaEZTRebW+vSebFwN4tQGPT9a5peI3L9575PBKgCrg+4ljGy9xTWB
 GxSvZ+dybOhghYO2pTyB769AXDLn4WBg0XM6jzHdw7hsjq5DdBIp1ozVmsZFnJaSeDgYbb26y+w
 oqG8jQ0fINm2yODrfPhr/HBOtfcKXRxQgq7gTPG9Pa/x/m+YcVslX2w52lTfvuUEHBEJg=
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id
 5b1f17b1804b1-4a1d760e327mr104897945e9.24.1792330723415; 
 Sun, 18 Oct 2026 06:38:43 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d2e93a01sm188694095e9.0.2026.10.18.06.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:38:42 -0700 (PDT)
Date: Sun, 18 Oct 2026 16:38:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
Message-ID: <atTL36chMY_21NCb@stanley.mountain>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>
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

On Sun, Oct 18, 2026 at 08:34:30AM -0400, Bashirah Lawal wrote:
> Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

The original was better.  Search lore for the function name to see ealier
discussions on this subject.

regards,
dan carpenter


