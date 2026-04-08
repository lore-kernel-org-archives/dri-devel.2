Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF39FD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D94210E54F;
	Wed,  8 Apr 2026 07:29:33 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3231410E54F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:29:32 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-60579b9c0ccso4911708137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775633371; x=1776238171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ozK8AWnxAFkcwchuPJvYs/MG6e2got2QyqD+xaPhXw=;
 b=OA5f2+0v3bLMeW/PaXKXlOTHPuK5UBgNObaNGGQF05tsvOiIqVF7yvkcR+x0JjEvQx
 8fPcQfaQPprOWX1epEAIitX7CdoJwVzdcpo03SWT15PZm02yjY2PItYMxl40jQCmbyTL
 wQYaNUZH+AIY7Ata/nrxShdzm6xSnKGMlxiSac8CBwFD8qrPkhjRPyYUcBWwWCgw0p+D
 MYYwS2tNDlgBv5CWj6mOtrjIMsGMmEHZzn/8kziGI9ZhTxHIaJlYmmT8WT6int/RayvN
 410jJ4Bbi4B8e1s2BQH3JRIZA/xbrSHMrfJQhBYA8hqXs4mXgCfeShwQ+B/74iiz0Bl9
 AAig==
X-Gm-Message-State: AOJu0YxILzo7T7BRvztuDQHRbWt0Ovspf51H8ZAmaCwmhSn1ZwGegpxU
 0YpuEMJFhnXGch4YGegGLlPUtE0z8H4D0n70AqNkExlHqJ0794f8Gkt6APxYar/N
X-Gm-Gg: AeBDieukotTJ3qUvsMV6z4cEtNm+nZsj5kPxKiSs5vEGrl9HtZFeUbI+5bBJFMFy7y6
 clQigw7lrCdvAnuEHES6yIRTjK7Zb4trpdd2tbVCJYlNDbpH1c3xprDchCTqwAPQsBs60ey2gYi
 pPIrNtjg2uGhdGxp2xMtAXZbE2pL7gLBTF58VS1Y3U11RJEUL8E+WOsY94FDA0dZLcGXYSom/l8
 3pIgH38QPvxbamM0breMhNEVTHzl4maE+5V59h9zALQSLm1P7gAyvhqQjqdmZdJJjgSmdJECfHQ
 7wC0KqLyYUMbyHaSAyJ55fu2/osbQgYYvoQmU9u95jvDWHDPAk/kqJPN29h66vYLCK4hydcmDWv
 qdUb0Wzc4ErRBhF6K9htJ2yLbjt3AvVL4QK6DBujRuxYfso//p/grxAN/57uAjQXkms2x9hD1cP
 BtO49QQ35c7rcuHo4fC5cD04clEYRJvxrkVX8jYoQ6kvv+hF1oUh04upQ8vWt5scTe
X-Received: by 2002:a05:6102:c8f:b0:600:a2:138c with SMTP id
 ada2fe7eead31-605a5053cdemr7681753137.23.1775633370985; 
 Wed, 08 Apr 2026 00:29:30 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-605830999f2sm20038829137.12.2026.04.08.00.29.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:29:30 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-56d95bc93e3so3791187e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:29:30 -0700 (PDT)
X-Received: by 2002:a05:6122:8287:b0:56c:da22:6919 with SMTP id
 71dfb90a1353d-56dab9a2a3fmr8411767e0c.10.1775633370031; Wed, 08 Apr 2026
 00:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260323164526.2292491-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com>
 <20260407225532.GC1214579@killaraus.ideasonboard.com>
In-Reply-To: <20260407225532.GC1214579@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 09:29:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrYXvNNsMfyT+koG5b4RB=Ziu9+_kkqZGbe-y_j5w7Ng@mail.gmail.com>
X-Gm-Features: AQROBzCb_gr7zhd8JwKJc0p9V1HTJzZSLBC6fwmRXCulxQtb0CbDQWPMLx6g3uY
Message-ID: <CAMuHMdVrYXvNNsMfyT+koG5b4RB=Ziu9+_kkqZGbe-y_j5w7Ng@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm: rcar-du: Don't leak device_link to CMM
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

Hi Laurent,

On Wed, 8 Apr 2026 at 00:55, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Apr 07, 2026 at 11:10:52AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 23 Mar 2026 at 18:22, Laurent Pinchart wrote:
> > > The DU driver creates device_link instances between the DU and CMMs, but
> > > never deletes them. Fix it by introducing a rcar_du_cmm structure to
> > > group the CMM device and device_link, and deleting the links at cleanup
> > > time.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > Thanks for your patch, which is now commit 3bce3fdd1ff2ba24 ("drm:
> > rcar-du: Don't leak device_link to CMM") in drm-misc/for-linux-next.
> >
> > This causes koelsch to hang during boot when a display is already
> > connected before boot:
> >
> >       [drm] Initialized rcar-du 1.0.0 for feb00000.display on minor 0
> >       rcar-du feb00000.display: [drm] Device feb00000.display probed
> >
> > When no display is connected, the system boots fine.
> >
> > While looking into this, I noticed that hotplug after boot crashes,
> > but I haven't bisected that. It definitely worked a few months ago:
>
> Oops. Would you be able to test the following patch ?
>
> commit 6c66826668e73570ce7668069460538f1ab610f7
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Wed Apr 8 01:49:40 2026 +0300
>
>     drm: rcar-du: Fix crash when no CMM is available
>
>     Commit 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
>     refactored CMM handling, and introduced an incorrect test for CMM
>     availability. When no CMM is present, the rcrtc->cmm field is NULL,
>     testing rcrtc->cmm->dev causes a NULL pointer dereference. This slipped
>     through testing as all tests were run with the CMM present.
>
>     Fix this issue by correctly testing for rcrtc->cmm.
>
>     Fixes: 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
>     Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Closes: https://lore.kernel.org/dri-devel/CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com
>     Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thank you, that fixes both issues.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
