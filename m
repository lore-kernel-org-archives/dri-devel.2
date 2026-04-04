Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A13E88D9B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A9010E3AD;
	Sat,  4 Apr 2026 13:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCmQcBFa";
	dkim-atps=neutral
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51EC10E458
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 13:10:49 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-56a8e0ea02aso3049034e0c.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 06:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775308249; cv=none;
 d=google.com; s=arc-20240605;
 b=LGCk1fCKmazRoJOP1clfv++EEkP7HYkD2Cg9uA0wnMM5CCipUR33HNu+ajzGH6aoYe
 xlsGmveC1qSqdeK1J9IbI9dBnkBnSU+3ffZHo7HuvZss/d4G5wVH3M6L6h+4JeQmOXq+
 5OMHqBivpybRwew+qYJ1AcRPPAZHHv0fVp/9YUW/mxNEUIiAI2yG5D8cZPCJVTqXAmBs
 LR1kLZQxcqF/Dd7w+qozY+ZHRRBlzGcyWze7XwXziGsISQ6GkYBHqfhlYG0JD8Lb3/yZ
 8puRfcTRgZFnc1JMBLV6wTjguFD23NY1hMbwkK//ie0txGcCTyueJyT6YWUjmPNULUcd
 znTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8HyqRbvBObQZXtQPHYrpXqo29d4/ZY4OJj9xIWAPpRo=;
 fh=4dwUaOWvpFwm6ijRPcTs93viOhmtF9LPgBZDgqbsb3Q=;
 b=NhhFZRIeu58n5EsoN1q2n4nqADmZam9MOTVggD5blJGJ0jL80dYPTvSygF7UQFgICG
 B80ofrp3Rcw+tBgV4CbzOVKZZD8anx+mrjD0NBfwBBW+Q/NX6Pk7pJ4TjcQlxB7Y8QTF
 xggTfM988HTQHT32WuGcbWfFOBVjKGDg08RpwRBDdfMUzf3a0ixF/A7DoH9qJnFXROG+
 jzBs03vOF/zLZzvDEZIYGDuIZJXjRGlsWr54CTomGDX+Wfijy2SMExZrcJV572+WoD7x
 KAQSO40wd/Tov/WAKkNXv+nrMD07EWGff6PAdE5BYJtnh5k9KKCecdxwFZiq5vA+JRWL
 G2vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775308249; x=1775913049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HyqRbvBObQZXtQPHYrpXqo29d4/ZY4OJj9xIWAPpRo=;
 b=DCmQcBFavWP9iDUJG1o0NetQwtS6f0VkfABXLfifzRt6dSnQaPZgBEtfRZY+ONfrfs
 HRX9bWxYroiTMncFrKlmPTKyDn6JlTBo9tHTmJOzWhZVgsOhelYnnVtDn77X6HsFlZOD
 Fsd90iLXHl3V+kmcX6El/g+Pzt6mw2FxMSqifxD06ysvcFQT7lxX4uXWTRFqTdvutYIx
 83pSKTy+IiMID54+YSvnrD+bwvuRPRy3hJX9G15dRcfQDYF1biWJ9/jWQCAKrVkDNTFm
 qnBN7xoAPBTHL3F5QlOcXzNu9ou0keIpU5yYdDw9pfE3x65cKO8NcoKoqNRQ4KmSE+Uh
 j/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775308249; x=1775913049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8HyqRbvBObQZXtQPHYrpXqo29d4/ZY4OJj9xIWAPpRo=;
 b=WGl1wb65G+YywFEU+rO0FPoexI0nqI8wnCS3n7pEgjfzGp4eTpPdKRZFwSjhbEz0hI
 jrrYUEMInEMT47rBmhHWIxiEuQdBeEqxpJGRXkJwigRJyurxAl/Ni5g+r0wKGL4Czt1t
 WzX4RBgkHRJ7Q2BMDCarRWfr0VwNKkGlZ5PN+OgfkvYLEYciVARUt6baHANntS2zxQC7
 WJOF70XCyBw2d5vzjRmZdPMNqivh1M+owrH4csSDrXAe6n7dUvOMkee8JoX8d+I2CcUm
 wp8XbrbIQZjFn0yeO3No/hpbyadSBagXsArZ/pYRAg/EWa+ql3nDEUmBBGwv4mSgZCAn
 t+JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLkGp/QNVdwKQ+66ePEAqKMSonr1OHgHZL3U58yNTFux0EhxkEHwnUwn4eaY4GmlGzqtxmt3mUW94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4lzoddcoFJX9ti0eIW0BQYIwWU6HQPaEAhKzxjmMN1oNqCRQU
 Een0t/+VXGqytTnGFUBGz4U881T4Sq/0MkHysaVXRPcdcFUe3oRfb7E69YTCzoLQKFrQet2Socw
 0apD8crktzk6SinQ9xVn1WKo4kixSbBk=
X-Gm-Gg: AeBDietwuuDHXbJwGZvQoC8x9YZVN1omF+DKPUSHCUcMQayU5BVoq9AkYb0+0BsehSl
 WW9dhsnhcBkGYDi+lJtRlAuNkIVnHCvAEV+JLSPaMmKdA5y0s7rbSqYYn0jnsdXXs4xb4PWjg8W
 mHdlSrBwXOuK+AGFez6acK7skcWNQ7VQwHJzal5h2nCDn/BTFaJvIh3uWfvzQaGCrX5tCn2TFHE
 pp3OWnXsWxernSJspASiofWUP4XIpTRl97EQbas4uX77EE6CVNAqg/3zZkLj+EbI4hAko3KzCW+
 Fkr/
X-Received: by 2002:a05:6122:3117:b0:56c:d862:37dd with SMTP id
 71dfb90a1353d-56daba00310mr2416475e0c.14.1775308248826; Sat, 04 Apr 2026
 06:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
 <20260326185413.1205870-69-jim.cromie@gmail.com>
 <20260402201450.GA966967-robh@kernel.org>
In-Reply-To: <20260402201450.GA966967-robh@kernel.org>
From: jim.cromie@gmail.com
Date: Sat, 4 Apr 2026 07:10:22 -0600
X-Gm-Features: AQROBzDRTOzUzM599gp-nqIHu_gVlpR5oj_SwsKJNy6Z4X8KHhBApGeW-pcrUKU
Message-ID: <CAJfuBxwRst2GGZmFW6Lx1jb4CMNEsutvQoRfVg2RBSJCtVikoA@mail.gmail.com>
Subject: Re: [PATCH v12 68/69] accel/ethosu: call DRM_CLASSMAP_USE
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch, 
 jbaron@akamai.com, gregkh@linuxfoundation.org, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com, 
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Thu, Apr 2, 2026 at 2:14=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 26, 2026 at 12:54:12PM -0600, Jim Cromie wrote:
> > ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
> > to tell dynamic-debug what classmap enables them.
> > Also include drm/drm_print.h explicitly.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
>
> Didn't I ack this already? It is up to you to add tags when you send a
> new version.
>
> Or did it change? I can't tell as there is no changelog here.
>

Sorry, I missed that one.  (no changes)
and thanks.


> >  drivers/accel/ethosu/ethosu_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/e=
thosu_drv.c
> > index 9992193d7338..a0b8cb81a359 100644
> > --- a/drivers/accel/ethosu/ethosu_drv.c
> > +++ b/drivers/accel/ethosu/ethosu_drv.c
> > @@ -17,12 +17,15 @@
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_accel.h>
> >  #include <drm/ethosu_accel.h>
> > +#include <drm/drm_print.h>
> >
> >  #include "ethosu_drv.h"
> >  #include "ethosu_device.h"
> >  #include "ethosu_gem.h"
> >  #include "ethosu_job.h"
> >
> > +DRM_CLASSMAP_USE(drm_debug_classes);
> > +
> >  static int ethosu_ioctl_dev_query(struct drm_device *ddev, void *data,
> >                                 struct drm_file *file)
> >  {
> > --
> > 2.53.0
> >
