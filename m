Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BAECD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 02:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9F710E318;
	Wed, 10 Jun 2026 02:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oUWQuyld";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49DFD10E318
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 02:21:53 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1370417c01cso8231331c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781058112; cv=none;
 d=google.com; s=arc-20240605;
 b=Ua8XOPVNSHfkPgGhZlOQSFmDuPJ1ooD7PI2EnbHm5szLNZcwtYOEKAKcccz9I/lb6s
 Kbqkwvrds0oJEIkzA0LMsw+IqXZYJHSdnDQ9oGgiu8B1KoX+EVd/OGrhQnNwH6JZsANC
 DBH04JW3DvbJ1NP8BxpcdpHJUVJXmIECyumbx59k7kD/+PqEfpMvxYm5N8xHM7WQPTzX
 udlGePgw5BvYbtQZvqEuMYijV4UJPfTjCT0xDx1xni5XQqiqBzUQhKTsQU2z/nv5ODP7
 Bv9gj3SSUYTaV+/l97/E6wDiei3+wr4MKUvH5MaC8pq2yZrolNkZ8LQy8RhsWA/tcTuU
 ZikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
 fh=2BvCaIhIZyGPOHmam75xWk0C3fjzNHVHPlej/eH/TvQ=;
 b=jEgUPq0VDyyF5oIemdKnd+nRIAOcl6ALn4L5MNGy1FeogSnhJfnikql15CRMyxq/p3
 M4skuC8XUYLONzObsMbfEoMbnDdzzFPDYEGUNwytgPyhE6soCwjvbNZ8OV8nRa6ymIaM
 dZl4PU/wXuAtkZryodAfkIv1OcIEkPvdAxeUBxZp2t+e4pC1kA74O8OdJSTgXnieT+tX
 l9iqMCm/FJFg23ILRLQfp9T2nQoqVtYyVJ9LPfyd+s+lptHIHEQ4QN0SfZGM6AcdOQaN
 G2qcTO1WTdsJk6zSjCTkifvFU3MGnFRNv07xeXQ0SoHGfGa0LL9FdWqKNWmXN2J3u5kB
 s1yw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781058112; x=1781662912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
 b=oUWQuyld2pOqygLPOBuq8DrOK6vBAdQKyk/k/6viz1GJEQssUhmhMTqzFZ1WPy5e/B
 kUzr2eAOlZO5esTVojMSwzsm7BFCGhpdkIXhQBfB8MFC6mOx91NoVYFxVR68b4FBSFy2
 +4L5vTi5Jym7pgL1h2yjpkIG7x/yWid5e0Omx8MWRRGtiKMDnltH9Y99Q4ncmpaX79Nn
 d1FB8zOs5ibQJMgs44oXPBliSw2yD21XloWM4beTo5LbUsXMMjn2lBHk8AdSXi1icnV1
 svopwY53tnwBxru9vn4yhwNHZ0GutBs4keyYuGb/i+8hHsLB3VNXe97Nxxu/QbfKS9BR
 uL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781058112; x=1781662912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
 b=eIVq3xMkKyzAFmLU1nCf4jc1Q7PuPddwfsRcRiVMVB4x0jn6wy4PqL7sbrtnBzS2FE
 PgAiI/KOqLmoGl73t2SazHybopYjeOd80bA8/ZE5gL8B4G7ltF1EW8QIRkUC36maTlb6
 sostuaQOtdEYWWownOFLSmuLI47oGabDCVbkS8W180Hp5aQ+iGdApmo+mmzA8juHvGhL
 YEnsEsbRBE6s58fejjnmnrUGOqa9HceXtCu7flQ1DklnCcbFGy/xsdVpx/GFnQkTZbih
 CF0cHwBTAuOtz8iEyNIiYmO3Mde8Q2xuvHVp5fLyrctft2mTww7DFX+H9N8NxcuHTFtw
 OFnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8jgI+1qoj/W05lwDuQDVg+OSkUuPYgMn+CRBOU3OAAUeYPZx1cdLqWUoKrm/pFGuQGWLwU1eF5eY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9HJ7c/RC12do+QDusG39/sT6BezCIPawlS3/2/dBgoSGH6d1l
 9nh8EsikgKS1nKsPP8VZgcLgBvxqfSa3mkB9b0EhZmQ+yjZMYFpW/VL5d+wZtu4wJdTuDKYoAV6
 uXsHYs+6Rh1KvWAGk1UH28t6cZzqhYK4=
X-Gm-Gg: Acq92OFlBmWssiV/gThQ1J/vbjtzKQrWq84p+5oMcp/5IERxDfqtXttZ/0FuRSeSGAm
 nnj9p4JWvy67X1CMF7acGgzpM9D4+aWuUNGUKwWAeCYDvyLfLwUyoCtg8Gvw2SyxtSLQITDNGw/
 Y0HA4kGqBU0AdJIxkhmmiRNRwNgZQNHcyTF+px+JIz9NEcmqqmOBrEE6tz2rxgkWReiu4KT4zXB
 rqUIKvKWPY9+02gxEZcNHkkUx6lv/hYB0zGO0JvYbfBrYLMFeOiPuZQtrpcyXfwLYphi9RnrRPd
 oB/NCzWsbvh/Xcer4Wo=
X-Received: by 2002:a05:7022:111:b0:136:6230:5834 with SMTP id
 a92af1059eb24-138066fe7a4mr11542095c88.31.1781058112318; Tue, 09 Jun 2026
 19:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260526091507.421730-1-islituo@gmail.com>
 <2d96dd04-855f-45d6-8bf1-7b6704181397@gmx.de>
In-Reply-To: <2d96dd04-855f-45d6-8bf1-7b6704181397@gmx.de>
From: Tuo Li <islituo@gmail.com>
Date: Wed, 10 Jun 2026 10:21:39 +0800
X-Gm-Features: AVVi8CcPjWyZW8sK8-ajf2c5r8G03jQW0fWCJo0Om5yrHDG--NDHYOZmUxzofhM
Message-ID: <CADm8Te=BiTgpzAnkeiZ4+bY1-Rr5-mb4M0oUxV42Yy33RMuN4A@mail.gmail.com>
Subject: Re: [PATCH] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Helge Deller <deller@gmx.de>
Cc: simona@ffwll.ch, kees@kernel.org, tzimmermann@suse.de, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Helge,

On Mon, Jun 8, 2026 at 12:12=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 5/26/26 11:15, Tuo Li wrote:
> > If mode_option is NULL, it is assigned from mode_option_buf:
> >
> >    if (!mode_option) {
> >      fb_get_options(NULL, &mode_option_buf);
> >      mode_option =3D mode_option_buf;
> >    }
> >
> > Later, name is assigned from mode_option:
> >
> >    const char *name =3D mode_option;
> >
> > However, mode_option_buf is freed before name is no longer used:
> >
> >    kfree(mode_option_buf);
> >
> > while name is still accessed by:
> >
> >    if ((name_matches(db[i], name, namelen) ||
> >
> > Since name aliases mode_option_buf, this may result in a
> > use-after-free.
> >
> > Fix this by moving the kfree(mode_option_buf) call behind the access, a=
nd
> > add corresponding cleanup before early returns.
>
> I wonder if this isn't a typical good use-case for the new "Scope-based
> resource management for the kernel" [1] feature.
>
> Instead of adding kfree() at various places, we could do:
>
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core=
/modedb.c
> index 703d0b7aec32..b6926764a99c 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -626,7 +626,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>                   const struct fb_videomode *default_mode,
>                   unsigned int default_bpp)
>   {
> -       char *mode_option_buf =3D NULL;
> +       char *mode_option_buf __free(kfree) =3D NULL;
>          int i;
>
>          /* Set up defaults */
> @@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>                          res_specified =3D 1;
>                  }
>   done:
> -               kfree(mode_option_buf);
>                  if (cvt) {
>                          struct fb_videomode cvt_mode;
>                          int ret;
>
>
> [1] https://lwn.net/Articles/934679/
>
>
> Do you want to check if that's correct, and if yes resend a patch?
>
> Helge

Thanks for the suggestion. I think that makes sense. Using __free(kfree)
can simplify the cleanup logic and avoid manually managing multiple kfree()
calls on different return paths.

I'll prepare a v2 based on this approach and send it soon.

Sincerely,
Tuo
