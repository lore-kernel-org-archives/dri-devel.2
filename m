Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505EDF8FA97
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAB410E237;
	Tue, 21 Apr 2026 15:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcTni0hR";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2637610E250
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:49:07 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6715006f4f7so6784335a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1776786545; x=1777391345;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n5LVhHEbAFGeYdYpuIjtzXkOyRculOaXylRaFQaQac0=;
 b=TcTni0hRbhywRHa/lqUd5djrowU6OLFOuVR9nysQdV48OM3cTI7lP1DCiZUdgPOe0N
 LJ9XQkowsRvZoAcl6ucA6L4T/5pWPm/AYkcqX64e7PzXECWHFlGfOc/9I+Li3AovTUIn
 s4Q5/odzpWGz4TLjZYw63oqyKrXq2yhX0kk7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786545; x=1777391345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5LVhHEbAFGeYdYpuIjtzXkOyRculOaXylRaFQaQac0=;
 b=Idhzuv8+fqEVyYAsjLBN0ujWIO3cAHhX6tjddN1p0hOayXmVBCHD33ib2CwFe9BZV2
 cPQLjR+DgLqai23lImbSesQTG7ZsnQukFr8XkWN4Ke3SV+bzOqGDF3nThu3Ukq8l+JQ1
 xTaDdJshoDO/Pw3mbZ9dIvcwZ1nICOmioggbc5lk4y2uIxvQcZTkhhelsQejyRONLgYi
 jX6A38jWHEALgv+dts/6bk6GdDybj7cUKrQ8Spv7vfnWxTCkGSKZO/V4AN9THl29cILl
 GaR3JBCgIWIx/mn0ux81UL29uNhKHDrAi94rdbVL33W3EFRP2C3eHDIi/9ivqVoqou68
 Ameg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tDDKucQjnydheygfI10Dx+lmNWTE0vlO0m3A9EsbBzpdMdjzL4F/u9hXIi9DTD+DKlABzSIzxUJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy4ODN7V7CLAd0QGIaUBQelZbM1VB/3C3MdpY3qgdawFFWlyaU
 q8CIbk30SMy/OCpUb9ICQPzfgcheY41CDbh8GlS6Mkub7EFHffpdR6n6OHShfgzkpHTmAuWEljn
 K740WZWk=
X-Gm-Gg: AeBDiescRumLSfYh+BCRR5IgSzZ6ZrkWdAPjTn5RZEpNSPzHynf0MbwQ3aSXFES2Ct7
 O9VQ5+3/LRGTou4v0O9rhKtXYAde9Jw+alD9Vlk8hEgyFpacaovtWhvSu+IiqiAhMjwp9wDiCmu
 kM3FVEd1szsBUE1dm7EzPFQSr4gIaynPLBiYH2Rca8DnnG16OelcW+tMbvpfqu4+of9l0dcfRcP
 zVRgzvPA/i6FErqHg0XnMNZvglAgT+oJjFPl5yaZF2/5kHZyv/Xp1cR7OSXSTZlfSY1AZC0RC+D
 WynvotwA5h4yQonFqnEZD5FsCwmjDO9+s3a4C5CQ4EDPxqGljxk7jWlghBpZoWn1ssxH4IXwY+5
 L9X6iITSaS5rGNblnMvqcejN+mBW0N9jzMPcyoIEER3Me1cPVwaIo11uc+JuiEO9N0Le7G9Tsf6
 vbTIFnP/JwWLl/jckg4K8T6fg38Gj3PTPjgZDMf0AWR11MWXh2LLUDLMH6WUaectCjADxRG+Wud
 KxSpyPG5uTLXOkFKU502A==
X-Received: by 2002:a17:906:ee82:b0:baa:49f4:8eb0 with SMTP id
 a640c23a62f3a-baa49f4953dmr80944166b.14.1776786545225; 
 Tue, 21 Apr 2026 08:49:05 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba455533b79sm451035466b.54.2026.04.21.08.49.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 08:49:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6715006f4f7so6784306a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:49:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8LRTSzgqi9zzqVuslZF6hZkHCTT9fZOIlL10PxbBOY59o8sIEGiNQ49dR9wnXM++ChEoE7lvAY6Xw=@lists.freedesktop.org
X-Received: by 2002:a05:6402:159a:b0:66d:d31b:e553 with SMTP id
 4fb4d7f45d1cf-672bfdd41b5mr7188534a12.20.1776786544458; Tue, 21 Apr 2026
 08:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
 <CAHk-=whT=pCZGWxgT6+5vj37quG7QkMUBaCc=p0G+G5pzxemUA@mail.gmail.com>
In-Reply-To: <CAHk-=whT=pCZGWxgT6+5vj37quG7QkMUBaCc=p0G+G5pzxemUA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Apr 2026 08:48:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4EgR1CGU9Bw+4iTChK6c35Q6w7vdDE7_3zVGUQ3HOOw@mail.gmail.com>
X-Gm-Features: AQROBzAS0H6nqdGG0YLebq0JwaJa4Z7DVAbMb-CIKzVRiZLzbDqhqQl7wt8Wc_U
Message-ID: <CAHk-=wi4EgR1CGU9Bw+4iTChK6c35Q6w7vdDE7_3zVGUQ3HOOw@mail.gmail.com>
Subject: Ping ... drm part two
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>
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

On Fri, 17 Apr 2026 at 18:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The reason pr-tracker-bot immediately told you it was merged is that
> this tag seems to just point to the v7.0 release, not the actual drm
> branch contents you presumably intended it to point to.

Pinging on this, because I suspect you saw the pr-tracker-bot reply
and thought this branch was all merged and ignored the mail due to the
subject line.

Not so. The branch didn't have valid contents at all, and
pr-tracker-bot said it was merged because there was nothing new in
there to merge.

           Linus
