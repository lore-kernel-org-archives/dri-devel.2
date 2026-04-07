Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDC4EDB7D8
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9284B10E37E;
	Tue,  7 Apr 2026 09:18:54 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699F210E37E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:18:53 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-56d9ed609d2so1375675e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553532; x=1776158332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR9HGabiBXNm33M/l0GZLFmidathx2ZfsEf0OcHHACY=;
 b=l7/1EUM1fLHvcqvGqjz0re8zw/GIqIZMHCS2gUuon5150fGrJr0uvdn2R1xGkTcXUW
 kpWQrZiNDuSPx2twLJvonneeNB9/TC8Zo2owNT9oIB2rubHnUPP3F5LCjqrkPa1RqNL5
 A10ddKel//4EeAa1AW807ijmCV/GEhqProNgmugNESM/oZjyMNKYFec3mk8cWI21wDjv
 YqQvPF1lDj9U7UUI7B8wt/C2u4EzeZQW7Cm26Ldfk4uThoXxrAR6ha6Kk1LMamkvlsqO
 jEHAazDfTW4Ppn1ifrphKXgdL5f39sMKwbsgGsOVuzUjSD5MK8d7kqnBZRSNxmRg/VSK
 ctjA==
X-Gm-Message-State: AOJu0YwThUmDL66Ertqcn7Al/ilecXZMyeJNiRJCZJDw+f7/rDgt/2lt
 SonQEZhdraum08zwX3hv0IXwb9fi4j0pcrJGSGwRgnl9+pphxUc2wqMVg3/aOkN7
X-Gm-Gg: AeBDietSqS5iH8hLvRhTnN0TidKwCBq14ZQTILmKG+tzJ8tqazN7sTufyIzAAsngQPq
 81CvEKxGX9X6f+8azaefPkHs+mg10r9THIDAKUmtTKAWkYwF6D6E82kHLuCQKRdr48i61Qkl/HZ
 4wyEgTEfW9IS9qTCuwgGlPMc9Gy94iY5ZhTnc0S1/+KaD7PcWvVMcSVeeZ/2UcSToE4zuds3wLi
 eUatvRaPZJiJSVluwfssRjvdw/H7kPrfaRSg30FLHzmK4I0GCF9hk9A+KuPxrpdyI/5cS7Ho66U
 wlIYtqxqQ7M6Ehnwu7dQmOE6zR4oamTCxgI7ue76lF9sXVjnmhvLmuMBze02B9NXJJHQtdsnpq2
 RNqwtv3BzelvDwB3r8uF44QTL80NXmw4oplu5BbWfNlGRQJ6uFaVMWIvbBrj5fm3cXQ4PamPYrb
 mHg3UIKk5lczfA/dNzg74ZuahIoaHXnEgZ+B2n4+FnXE8P2GfO67xCFd/QOiXD3lPW
X-Received: by 2002:a05:6122:a05:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56dab90cf81mr5067313e0c.6.1775553532185; 
 Tue, 07 Apr 2026 02:18:52 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com.
 [209.85.221.171]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9bceb2e6sm17990988e0c.15.2026.04.07.02.18.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:18:52 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-56d958880ecso1332741e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:18:52 -0700 (PDT)
X-Received: by 2002:a05:6122:1d15:b0:56c:ca50:e963 with SMTP id
 71dfb90a1353d-56daba4441amr5183687e0c.14.1775553531657; Tue, 07 Apr 2026
 02:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260323164526.2292491-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com>
In-Reply-To: <CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Apr 2026 11:18:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLcat1BegoTH_=ir9svJ2CECw2g672pfz-5CGg6xtWuA@mail.gmail.com>
X-Gm-Features: AQROBzDsnfwxgRbWuNYO6rWIlZEto2LwHPdqUIPoMgm27H9bZD6G-qlMJsPH2Ss
Message-ID: <CAMuHMdWLcat1BegoTH_=ir9svJ2CECw2g672pfz-5CGg6xtWuA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm: rcar-du: Don't leak device_link to CMM
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 7 Apr 2026 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 23 Mar 2026 at 18:22, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > The DU driver creates device_link instances between the DU and CMMs, but
> > never deletes them. Fix it by introducing a rcar_du_cmm structure to
> > group the CMM device and device_link, and deleting the links at cleanup
> > time.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Thanks for your patch, which is now commit 3bce3fdd1ff2ba24 ("drm:
> rcar-du: Don't leak device_link to CMM") in drm-misc/for-linux-next.
>
> This causes koelsch to hang during boot when a display is already
> connected before boot:
>
>       [drm] Initialized rcar-du 1.0.0 for feb00000.display on minor 0
>       rcar-du feb00000.display: [drm] Device feb00000.display probed
>
> When no display is connected, the system boots fine.
>
> While looking into this, I noticed that hotplug after boot crashes,
> but I haven't bisected that. It definitely worked a few months ago:

I am feeling lucky: reverting this commit fixes HDMI hotplug, too ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
