Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B412CCF2C7
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 09:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9050410E332;
	Sat, 17 Oct 2026 09:11:53 +0000 (UTC)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB9510E366
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 09:11:42 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 5925F1D000CB
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 05:06:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sat, 17 Oct 2026 05:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792227962; x=1792314362; bh=nVZZl6/Mu+
 b0pKxknf/5K0vEjUCByAfibexN3hnGTGs=; b=MoyatWcLwb7JrN3Plo/AYcROBU
 5cIsAg2GXW3NFBepev5xqGvx0ZhmeMCUQWPe4u2Eh2desbNeTmD/2ePXN8DtkjjF
 hIY/5yTVzJGuu2wZBb9Zcxr4HWhbDayHc7gvh5PaNO90iTb/2s3QHBj6J2/or/ln
 XbO3oRgaV+XBn326IrTr2QCEPg13J2V6M3RCXSp28Cyf5DVy7cmawYtFPAJKJhiz
 wSFp0YzS2zAxyIIZnDjRan46ZIqNx0IPkQf/7QeWlQAcq3O/Wb6Y+Yb2Vb1+gNSR
 vI7stgnrS1jlGvISMj9EHcQMopH2G85Vme4EXl+/JZ/xQlMK/vz5GZY1Gjpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792227962; x=1792314362; bh=nVZZl6/Mu+b0pKxknf/5K0vEjUCByAfibex
 N3hnGTGs=; b=UnkV1F+szvuzJqJYZ2dfWWiXErITbSqB0S1TGHw/zhtLcM3HwLs
 kpYQz/pgLx0xXtH9lruD164FcEAUx5ApvN2aGs9Zi3Zm9XH4y0uGIB0C4zluTBhQ
 VdUdeB3nkl2xn6mvOBS9BEvY45F/eiH+sSa7GNoKOPgTzMi4e6S+tC9N56v8M4kW
 zXtM9SGWedo1f7fj46PMUqziqXNzojSHL6Q7lqLPTIAQ6dd4+xcEjh9ACfzHYmTG
 D2zGrQr7PiagIvPwBh4zHz/8S9T5qsbHZFKJEnbgmhX7ZJOoV/rS2j7T7gZdkted
 4jAa4PK+JEWDQgbA5k6Pgd8T0RVhwncGdmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792227962; d=kroah.com;
 mf=PGdyZWdAa3JvYWguY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:UDEJuHQinfl6Zb8MfonhRHpaPQKQwvCTUQbibEehDhJk+Kd
 0EyykzbktUGS5EFjdgujdVuuU/qKClwcfbnJKAooeFDLfxcLxxDMZ2bXcLB7MiRo
 PFjZXtoOvh/8DsNfFeDbUWfZ3uEaXZA9McOTux1bzRqAbbaVItSR+p8Eh7eUibc7
 6l+xcilk3VNnxI+QGDkMl81WhmRyJm5h34WrzqpL7EDH8sJy7aAFeEvFeVKQ1hY3
 YZAl6EbunrVzS1NdJvxrjhYKy/H1AMmvKJAzUg4f6yAl4WMhwc20yCElbgw4kfCF
 ijDPZB+MKBW6g+UWEVD+KuIc4qF2cXqJPpjEonw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1KXjdkGRee6BPcWb+KLOanPCir7NKbfNOq6AHMIKUlQ=:PJIb4TRS1B7oZsCjZ5WW1IwlU12EO4LgK9NuEO1Pa68=;
X-ME-Sender: <xms:ejrTalod7NYQ2bWMzjc4pYGmkcUPmCeUsyVivHwdK9pqU3pxrZSNwg>
 <xme:ejrTasxPPtpZj3AHXroEzUh1Mivy2hNxU_9eH52OLOw0BDmVRzHeHfDPCr3PfpL3B
 P38oj0IrwB1eu1GSqVgiF85k9BGkoexGXtKahGZs-bg9eer9_U>
X-ME-Received: <xmr:ejrTalIZG93txse36Vkm9pKW4KotG_eOjZ0bWezRN5qJGNd3QevjzZyxcnq36UOdhGRKaCBLLW9W9Un1lsHZf1yDRqYCl9RA1ee6JjOEUyU>
X-ME-Proxy-Cause: dmFkZTGQQdqoEe7fwc0RF/hCGdyTrVrgrv/fnU4qZKHJGS2riRgYXePyEuB8jYXrA/NwyJ
 Z0NthuPRl5Y8EvXeHQskQv3bZgwpg3P3DaMcRxJA9Uy2j6fVM7G5rRUbOfv4r2nICpiN9T
 X0ktSIv8L+5R5AbDFYhEqj5bVBhYKCWe4vg3s3upCE6aIT9Nj/exGqzpCERYmci9UUh8jV
 0yTmhHW0HfhwiX/NzSy8krpjpF+py7AxDTHWhGNtdYoRCsGU9zeLfXFFSVZKZR/9/3U8+d
 KOcdu4AWDwTNqtwKGmypRSygBg9Cp/pMMSUs3XIvJtqY+jp34ZLjNz3SMHkmPqtamC+LfX
 tbDZgk4qdZdYrMzZ/Or/KxKRHlIClfmzgPzC8zQXaZWoVYEQIszmvp1ZOKKsvvp7+rBAw7
 qFZ4eH+wnYDnyVMWHSn44tcGCFfuw1daN2h0Ju5PxuZ3T/cc764GUhjjDd0TBQW7sT0An6
 ODeqV/0rCvQCyo9JhanqIFltNrHa5MuCYhWGS1g522XwYdbcJZWBLlC1BvwKdTX8372EJ9
 yNR7lQzyQGk+iX8NG6lnQZqSktMCp70eVEm3D7bgG0U5uE7y+G3uADLVrjsLeOaV1BsHom
 WM9XsLJb+QJnInfIO9DW5xJArpLY0x1UB7QSpkGEMPE8UBABWEL+vszFEWRQ
X-ME-Proxy: <xmx:ejrTam68LSS0A4lyRWBLF4ilGVoM2y6SXHxdiv_lf8f7w5F1APGVRg>
 <xmx:ejrTarxdL3TJJcbmBGiX5dC9OyhaDbB-e6bUEmwQKCTrESCQtb16jw>
 <xmx:ejrTag-4xYDnRSw7tNeQcA6X-TgZ9Ki1T7Q5vbudXo6J8DCc4JrDmQ>
 <xmx:ejrTanHC03pYjZ7Xl8J5Jd_YRpGRM6WlO4VR7ItZEBaBo0aq5lYdKA>
 <xmx:ejrTasXVeMAAS7YPNen_1oiOqc-0BwLu8DV1MsG6XwxjSbNd3iUJ2wYV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 05:06:01 -0400 (EDT)
Date: Sat, 17 Oct 2026 11:05:59 +0200
From: Greg KH <greg@kroah.com>
To: CatMe0w <CatMe0w@live.cn>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans
Message-ID: <2026101740-concrete-mowing-498b@gregkh>
References: <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
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

On Sat, Oct 17, 2026 at 02:53:37AM -0600, CatMe0w wrote:
> Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
> vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
> fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
> so after the first pan most new text is not drawn until the next full
> redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
> FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y.
> 
> Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
> use as the drawing area height. When fbcon does not pan, GETVYRES()
> returns var.yres, keeping the existing bound. When fbcon pans, it
> returns var.yres_virtual, which the framebuffer memory must cover
> anyway for panning to work.
> 
> Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds")
> Cc: stable@vger.kernel.org
> Signed-off-by: CatMe0w <CatMe0w@live.cn>
> ---
>  drivers/video/fbdev/core/bitblit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
