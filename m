Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF7F43854
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A9610E1D1;
	Wed, 15 Apr 2026 16:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LW9TohWP";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0E610E1D1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:41:16 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-66d65646c65so5148453a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1776271275; x=1776876075;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y7Lb39tX80cyqh4EoAouwl4tDKxTNBcVjFCL5GxqOEY=;
 b=LW9TohWP/DstWBTR4GKNbo91+AsuljF+5crXxPrQgKfMY2Xg8yfRBs9PBArEgSlmMg
 aUSaD2o5MI2ozRTJJuZXoR2+GNvGoQa/Oo5BvV9eBzp8XzbzlpqanGmfa0ZAtoqrhURn
 ZWN3A8YnB61Cezf8UtpjzknRP3VU8W/79884c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776271275; x=1776876075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7Lb39tX80cyqh4EoAouwl4tDKxTNBcVjFCL5GxqOEY=;
 b=bt6Jd6e2NhDceCD70ki0kDo59YjDxdCVm7VpXMW1W2prLfHhx/TJV0sW8qJ4kgTLza
 fFrgRLsTjih0PO2JOQzItMGIfFsio9IwBmhW/xv0W10OSzWBMLMvTkuKFZ0S+dKyegtj
 XdWeAfk3qBJVWOp4wX+f96idDOYIedgcm1gXvIpjs+cjqEZIAFY7VsIWuXPHJKn4/MVy
 N9/cWwzl9PlFq0uDrimt6wr5PCtOiCaq5mu1qHARUeK3UJCSxziSkhldCJFfzJd571uy
 Xs3CYaqB9tAAZDJHChPx7ua3TBnvI06mjq4YylOoMlJOW0fkqTL6SrlaEGmRK2gHf2XX
 M8Gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uAzQnCUnKbQ7oHrU+s7+RborakHYkogUxb+HjOgL7oz/oXFGz9e/T79eRtwaxEdTWSFahlxNgFko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmeCK3N7mFMl0rnLq7XjasI99WIvg0JSt+V5+D5E7U9Q8mLJQL
 j5eHf1/lr1NwCLztodqq46BbQmSrCdvgVnl6sfejlF86Ap2k3vAZWuVVxZSGpCdJb8ZQypj1GbF
 6W0wOdhE=
X-Gm-Gg: AeBDievDlO61dZQAU1QbMGRndVQg5RbJgQXRpualg6ms+MTlFYjC3Hq6ULvghwfUdjZ
 +OIU0xJGC2lMFgJ9dyedNm/4HnlBp5zzcEhhBxb2czPu69pUSDE6pvvg+wn6a5Vx11ZB5b6OiP1
 5yRe3xnxGYzNt7vDN1NnwnK4sKaUYXYAaMlt/BnLxih0iOas2u/gxm/qKSxD+I/COqw+2l9Wgkk
 ydjByZszO5CF/EVaVF8ovMXz/u00Ju5aPy0CXpC/i0drVLcSr5W2IcF8Kamw4xH4Lli7D05jGHK
 FeAmIWoM5N2wgzHjdsx3tZ4FgzPk81osNKqdp9/S0Kd5+c4ou2s8GB/qJpilmfNkEyYM2hNFmKH
 p6QsMHXpUYLd/JpNfA/QRdluBT4dhUKMs4FzesoZ+B35yZt8DKNOVNuoxcZkYt6Y3/yUx5gXzXQ
 3mEORsI+TOOf5ThuGtIBypVehqqbXuAmstxIFOResdAdLjEvYdd30nLrLaxIPeZv+I889LkvSYN
 NamFDxEFxI=
X-Received: by 2002:aa7:d1da:0:b0:671:d016:df0f with SMTP id
 4fb4d7f45d1cf-672711b1328mr110675a12.4.1776271274751; 
 Wed, 15 Apr 2026 09:41:14 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67237d7888dsm602825a12.2.2026.04.15.09.41.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 09:41:13 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-66bd4e0560fso8921982a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:41:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9SeOT6IpS6BzP410e29KJWrJ4CSj5slcUj1XPckS8RDa6xqerUJnlBxwak6qnTXElzN8HkR0ftmF0=@lists.freedesktop.org
X-Received: by 2002:aa7:d88c:0:b0:66f:76c8:f747 with SMTP id
 4fb4d7f45d1cf-672711c49b4mr83740a12.6.1776271272830; Wed, 15 Apr 2026
 09:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
 <CAHk-=wiAGevirr3=xC=u5_kN+m63JtjqA0C9NJLrd5PGrM0suw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAGevirr3=xC=u5_kN+m63JtjqA0C9NJLrd5PGrM0suw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Apr 2026 09:40:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmTh4ESQE7ntR=ddF5JBToNerf4Dzt2zQQ2-Y3OEre-A@mail.gmail.com>
X-Gm-Features: AQROBzAzrmt1r9Lcsx11hYqA7ZFPDheNDl4Usu75n-ImSxQhTSjJgoByqAuzn5w
Message-ID: <CAHk-=wjmTh4ESQE7ntR=ddF5JBToNerf4Dzt2zQQ2-Y3OEre-A@mail.gmail.com>
Subject: Re: [PULL] topic/pipe-reorder for drm-intel-next and possibly v7.1-rc1
To: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dim-tools@lists.freedesktop.org, 
 Ville Syrjala <ville.syrjala@linux.intel.com>
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

On Wed, 15 Apr 2026 at 09:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I'll test it just to verify, but if this fixes that known
> issue I'm all for getting this fixed sooner rather than later.

Well, that was easy enough. I assume this was expected, but I can
indeed verify that that branch works for me as a replacement for (two
versions) of the local patch I have been running for the last six
months or so.

And maybe I'm the only person on the planet that runs this setup, but
it gets an ack from me. So I'm ok with a late pull as a fix, but
somebody who can better judge the risks for other setups should
eventually make the judgement call.

                Linus
