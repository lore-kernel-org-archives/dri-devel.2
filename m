Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61133CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EDF10E2DC;
	Mon, 22 Jun 2026 09:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qeCMwZo+";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F2A310E2DC
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:06:06 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so5661502a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782119165; x=1782723965; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rKi0tpNxnV7aF2Y2gDvU0xwj8sSkYkSXh8nfiFV0TdY=;
 b=qeCMwZo+XSoqIb+e9qDQVQKUroLWI+QyAGUfpYwDRuoB8mIQSNt7eXbWgSk9bpOQOX
 kkMZQiZaNOBTXDITZdn6pwSPiYnm9xpvrhdQws18B6WdPn6EOqEPkWzL8ylfxKuzDKth
 vDgEZWufBsoDa8aBOwtJSQfaEARIgRX4ZbJ/Z7Xup8MYfkcMUk+/bdONP0Da3noQ/h91
 DRd6xEEzvQV0Nt+Pg0uw2W9zFIfnjHnqEpuSeJ26Kvc55QOEl83ntu4qnoxlPoxkJPXy
 d3l3hFve+ZUSYqMHmlOiAtTPlpjGHMXNxHr/pnabKncTbvLZxpDXXOvtSYP9lhwu81jN
 PkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782119165; x=1782723965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKi0tpNxnV7aF2Y2gDvU0xwj8sSkYkSXh8nfiFV0TdY=;
 b=G7dAPCXbSpi54fdnZDJl2QRED6o7TkaUa5CRwJXdQXBrOsE4MNY/8lskDTppMV17Sd
 ape0DvozSTXar58uqJMp5dvmHUP0xzGVq+Y8LhOwr6uGiR14x7f/gidgh/AEUJnX7Up3
 106jVyLO5y69n71IOeXa8BlkCq9AUg4Hy7zDFSpKDevFAy7cnm4q5Cpm58vgRZ7aXusZ
 AeunMYUwB6hLWhkjCPBZ0Wqm/PpMMCq9lXpOpW3SNGnBLDrLeTmHQIWsSMaxBk6bI1NK
 nZgtXlcjsTnZJETle4U2qhdJJ7IUYLnBemGdLKpDhTMhaMyCdKKeprBHs2H90P4TracK
 qx9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oEtsNZyTRQ/2fGhYDK8Zar9wjg+GDMRw+oFD85g5pnL/WiewsQDVZ4Kjb3baJvGeL0gyAzSeBdcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyneeCFEXkcxhn6+i2+8KfUFFHoB4kdOHWnOiRDK6EsmxBfJZO3
 gPIYl/+FZ3C9CzdvsBIeNebE1aTIh6Fz/FsZBifVgGRm/PKWck16bXBE
X-Gm-Gg: AfdE7cmFLF94FtL8aUS3SA2qIANLeOejy0MYtFsB9NRZlZfVIPFNp7Z60WB5tH/rOA6
 XvSl8O07TbrdHWKdn+UHMnJVlv/d9L47SeoLr5nvEQ6UyGLKTVudiOZrfvJE2tPVksIBi4LQBTD
 ESA96r+LImYDxwy1G1+Na3k80P27374VJwNwBegPL44jb6lmJLC/h057wzgHFl7UUoRtS/MzRfB
 DAY+hhjq4RzgZoShPpL/iv+IUTsRBO34JQryN2BI7XGbp/L8Yfm0X6fgUkZ+JOrFLrV0077gqCM
 b5vIRutxTvFCJhpURY63Nv2J6hqF8tyDOtmVpOK64sj8Tx7x9l7/ATLb2h0tiDciGb8RQgZgbbK
 HU/aW6NtU1st3+LCjE+flMS7FRRRRtp9R3N31/6HYD3qDfBhT8PKNKE5wrV8vm5SpDu+dLWoZW/
 a1aJV8zIJI
X-Received: by 2002:a05:6402:1941:b0:68b:d82b:fc2 with SMTP id
 4fb4d7f45d1cf-696e5237c1fmr5954025a12.26.1782119164183; 
 Mon, 22 Jun 2026 02:06:04 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697c1ec13c3sm300017a12.7.2026.06.22.02.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 02:06:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 12:05:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aditya Chari <adi25charis@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix parenthesis alignment in fb_tinylcd.c
Message-ID: <ajj69VJU6A2AjHDY@stanley.mountain>
References: <20260621062945.42519-1-adi25charis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621062945.42519-1-adi25charis@gmail.com>
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

On Sun, Jun 21, 2026 at 11:59:45AM +0530, Aditya Chari wrote:
> Fix a checkpatch.pl
> CHECK:PARENTHESIS_ALIGNMENT warning by aligning the wrapped
> argument list of write_reg() with the line above it.
> 
> Signed-off-by: Aditya Chari <adi25charis@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c74..d58b12472 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

The original is deliberate.  Just leave it as-is, please.

regards,
dan carpenter

