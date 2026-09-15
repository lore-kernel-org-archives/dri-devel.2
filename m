Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B83BC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F7110E16D;
	Tue, 15 Sep 2026 01:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wm7df/Fs";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BF810E16D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:24:31 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-86309e1a213so1737696b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789435471; cv=none;
 d=google.com; s=arc-20260327;
 b=stz0F9XF1U0oXHAh/UymKCM+orke3+88UaUGAkErUXqdAYWTGETBs6PixTXR7u3IUX
 7swehvhasXSzoTla5jcncdQ6suIaoTSm3tQlW0b/fuSTzAeFJmBxV/Q01JZVZH6/fY+V
 MIBziV1hVdn2tGcBhGi7OlJWdOBJFHhsWM3zYPaclVMVYZvyA3cDGKWDIghkUKMNCLFd
 j4yQk/mwHz6HIw6OYnZFtJohVwsLXccpDDtpQR1IAoepgXsZ/fHzlUPGXYxWSIhVIJtT
 YwnJaBKSa3iCVzl31bh9MWbp3ZfqVBPtaxzzUE2sFIp/1Q2deEv77XaVAKIbI/Hoxud3
 ruGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
 fh=FEseRBs7u6xBD62FiUj2LUYhtd4pHuOFpxyuOqvJ/yE=;
 b=WLlSXFgla+K9qTFJeerVeIt9JHMVPRVbM1iZefaM9pwHCjY4c+v/BHa4dgWw/zQNQz
 LRBWYhqDKrmWK7GccWbEw/yEInsVnrTqIqkw9Ajnuu/yPwGBRofot9ZuQ9IInOp4osIn
 FUU0vqw2xD3pwSlRke6OrrJD8pk61KkFp2NizIMvyPqqWlU3D1nMTOSpXN5jg8uedES9
 UOd/xWw/xZPS7o3R+/uDp+MJ1qDMeD6VK77C8kR+TfkTJvM9vUsN5YLyyoIgB4Ics9Yy
 0EqqDbxg82Mk6QjQTGm8BaZSIhsYvaADUpxJrLeJDA6cisTy2c64CfQ7LKT9gssj/S33
 fNbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789435471; x=1790040271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
 b=Wm7df/FstneUZ+oEP2tPRDrRAe+IcHtmF8OhwzqrCxHzHrwO4+tCdI1cJKW9WEOjEj
 zp1S78NHAl0nJzPz0N3R9FAv+vMERPbeFZvBJcPjckQkI5q4VZQxXYyKgHCRP87fcqM7
 JHu8ToOcJESGxgBEddZJVgjIAkpIhltJ//2TjVgDDe4ij7H0pPoOAoi4sJf4ta+EQZjI
 5isixU6D+w6hn5FKzLVfpfK/tF2iwjxfe46NXPVqIgAlekrBQlVqLtldwP4tb9vSmHyM
 YlcWieiwwhXLdLYXvwmfQrpcGsvXNQA6C4RTHQmG9npNjLu9H8VKEghBua/MHPDPqIio
 IiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789435471; x=1790040271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
 b=q6lrcf9pQJ/5nCUUpReXg3i8c9VoAsMlgIH7Pqw9X4DW95VNR1+zTcRNaopGbI1OhU
 zYHbpY0iPTLWiJ4sJNC1Cx3hHypjDui2xa/ObTRg00vgIh7z5mxlQPuYPsJD202CYvk+
 dESbCGfEdAMJwCjrZG0woPNmy2d7rtcI6L+0D8IJrXuYCTl4WgKnGeI2NVjGpYfHS0R6
 wQeBMoI8EB+5PwGYArQChLYw3mbK1VqOS7jwGI681QsA2Ytp/ITdxLlhZigI04cSIjXS
 R001glC8gBazs+m27sdH9osIGxw4/ptJ1K7BFFZb7jOe9uRkfzQlvOshkAV0rMuZ+Lxt
 wz+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzheAgqacFtw73uMvnPEfZmjWf6G1j9IVms5OuS6CXX3HxFX1eHg7DSsKrvxTPhXxpBa5G53rOEq9A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lIClV96dRYhhXV9JfTMbxhJnjNN7utHQ1abFjkxlE1NXO72kaz
 VRlsQgt6R4q2IsqiOFcZIa1G8mcdp6EHg8cM+8EmMa3g1zB5hqjZvltX46x0q7s2iI7tpsMuVD6
 6MJVy84q18zE1qtCzwkK+OEDUZORgFA==
X-Gm-Gg: AYBFou1O8dWI9pzgrgn15GgiStZG9gBqrVLZpYa27O7RGRk7rZ6HP490JDpHBDe+RCx
 AKKR2jzxgrtfjeUzovGlG01/ZRvFmTP3GhD9TH0wx7QqdAbHAJujOB3WMlycXStM6zwH3lLPmnI
 Pjs+rRvQR3ZzeqS+Dyz6JgfJPJvjXUEYWjAGcc0duV5I8ZCINDEsq2zcMcgfOwKVf2AYYKeIyzW
 0YqQv9pIaT7CESciuBd85Da8PxtA8QkmZqRCeSt49FU2hGW5f7/5ayE3YgN2ZiDVvocamqOr3v+
 BjfeKouOhSkc906zDA/ls7NygoDGbNIkB4VHNJajz4wBOKz6g2dqW0Ine4pFjOt/YX9Y8Rb2u2V
 jAzAi2c72yXFlLFwwV0Fa0khNOuRSvPjQkcDq5gufUCArMvH11jpMI9qw6IwF6P5b9w31
X-Received: by 2002:a05:6a20:ce4a:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3db4046c09bmr11645431637.12.1789435471071; Mon, 14 Sep 2026
 18:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260524155735.13865-1-mhun512@gmail.com>
 <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
In-Reply-To: <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 21:24:14 -0400
X-Gm-Features: AcwNN1XGN3vWYnZMelCtuY0mzPxTvaG2W81_3N9COhlxDNULIMfbhXD5Z_s9EoM
Message-ID: <CAGEsz8E6oZRuLS2kXTw6bnYBCAmg_OvLDrhqXBDUC--qV-5x8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: clean up modeset on backlight init failure
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
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

Hi Patrik,

Thanks for the feedback. I'll address this and submit v2.

Thanks,
Myeonghun

2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:50, Pa=
trik Jakobsson <patrik.r.jakobsson@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Sun, May 24, 2026 at 5:57=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
> >
> > psb_driver_load() initializes KMS polling before it attempts to
> > initialize backlight support. If gma_backlight_init() fails, the
> > function returns directly and skips psb_driver_unload(), leaving
> > drm_kms_helper_poll_fini() uncalled.
> >
> > Use the existing error path so the partially initialized modeset state
> > is unwound before probe fails.
>
> Hi,
> Yes the existing code is faulty but calling psb_driver_unload() to
> unwind the init could call backlight_device_unregister() on an ERR_PTR
> backlight_device which is guaranteed to fail.
>
> The correct fix would be to convert psb_driver_load() to use devm
> and/or goto unwind pattern.
>
> -Patrik
>
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/=
psb_drv.c
> > index 005ab7f535..7218026fe2 100644
> > --- a/drivers/gpu/drm/gma500/psb_drv.c
> > +++ b/drivers/gpu/drm/gma500/psb_drv.c
> > @@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, =
unsigned long flags)
> >         drm_connector_list_iter_end(&conn_iter);
> >
> >         if (ret)
> > -               return ret;
> > +               goto out_err;
> >         psb_intel_opregion_enable_asle(dev);
> >
> >         return devm_add_action_or_reset(dev->dev, psb_device_release, d=
ev);
> > --
> > 2.47.1
> >
