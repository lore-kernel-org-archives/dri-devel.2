Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776C5FF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D17893DB;
	Tue, 31 Mar 2026 10:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bpj5h6x6";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB984893DB
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:10:19 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a133b686f7so6386535e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774951818; cv=none;
 d=google.com; s=arc-20240605;
 b=CjFgpad+HETbLQo7uF+gYAgve2HeYQv355aLrH7Gbl5WhYMe9LZfKn8giP5e0DG/YV
 kUzy3SELMQ8UhWobtcI4ChAvOK9g/0vITI/jSNkpMjs3SYEFeiGUfVGWeYVoDmTyViff
 zsFw4Tyi0G8jkQXc3boXh7t96htDrZpU9EVYx9Rr6hYfza3lSNvfU98deui7LAL9ZmW5
 4O/gQTf2IlwajCqYWzwcI3+SPD5n/M2zD3NNpBBeU0FGp9OKILOVBpynDiA5h5lYJpTa
 jxJ7wGWe3YMBK2caaMEpNscyf6IMsmjj2JJueSyBRAHtUjyyNx2hJAVJqWYCSH4Fl8ce
 8sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xU4kD1BlKaRSvG+5fYkuF0DasqmTCyEb7tbYjz9W+cY=;
 fh=yFn3tAp0zdk2h9K/JtAvSw4gal1tYD9iAGgYXOHg8Jk=;
 b=YZa2zPVgh9Fxh0rQju4YB5CcWXE+jspLDjtfgkO4Y+cCxeMORXcPYBJwOoU1Ufo42E
 /krjkuP9rNzBLSm5cW/CFtJIGofk+PPCvLN4g6RuH99Ae1qv4ede2ncR7z0TY7GbzSuY
 yLC83ompAAR0NRWMGlLC/JgxSIEoG7KClfnjALnRlxzLNuHcK41guBxehymf7KVmINAq
 QRwBTojNvVa6a8YORWt26potq4Ct0J4id7bhOstn0qInWcAHkrXNQvYaWOC3R7ubFH7y
 ZFW2fL/SEW5bIde9tgJjs7dpNXr4rsc90OC/3DkwkCQUZiKOwCRZuBCCUlU7o/vcQXIk
 g3vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774951818; x=1775556618; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU4kD1BlKaRSvG+5fYkuF0DasqmTCyEb7tbYjz9W+cY=;
 b=bpj5h6x6T+4MGQi16l0eWBNQ/NpBICM0Fdx6EG8IucgBlsjhQVIOHQk1XtccOLn9J6
 6dOMmROn/et0024a3ZQjhxc6wESb7JSFkDuSSAmb6Ly8hTtN45d9GGdjTLrKHRozbJ9s
 xUCdU9KsPGsWLpUaw8C4k7Y5Wb4IKbeNASMetxOseDj1BLWo6+jgZh6UbZS4TTd86q+V
 s0+HcvKJ61LFvojCUgTULK3uOIZ6y5QCQbz2YgWy2JRs26GUxELhRx1E+VEUP532kZsl
 DuM4if1TN+4QjTEpR3kmnextbBBSLYDT9xXi3w6Gzf5Jw255IWKgNHMypnQ+AgWSS9Uo
 J/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774951818; x=1775556618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xU4kD1BlKaRSvG+5fYkuF0DasqmTCyEb7tbYjz9W+cY=;
 b=a4Hn8UchGKyTskodFroFJe7odnGBUy3KYRu0xTOoJA3HayRZWaB+aizl2VwzwaY9tV
 PXdaBgymnUP15uPrdhzhwDPxDTdGFXv/hfyTL8vcu1J7ODWd88v63HcEXogGDcNT/3le
 1ZPjWjYq7VEhiwM7DirbmFNxgbt/2dild7vU+VL065WoY/IQSUmZ4awX9rnFeVB2RgnI
 JDAGQ0NuCl3wrAR8/FsNt2zRT5lC1k4zlTMxSCowWnVNhOSDZKdr8dt84mqpp9j2QsYy
 Hs4vGQQR3ZqTlJC9DlWjvzGEwU78fhsVtRyv3W1GaUaqAcIUuQF5F/wpHGQQT3bbl6SN
 Dq7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ+xmLFCKwx/7L2uCQQqXNfba3w0ycCmBMi6/Ydq4VGCc3JKaxidBXsx1tfE20/tgV7Axwt+O3eOA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymU5tzjccR7z8j4Syuqp6c6iM2NFSBrkt3gBprEHZonQWvfBP8
 PCLA5O8Vane1YqaX+j2RzByBPIURIqzliVQda4DTZYLnr7RcFcFDF/wyz6IRL6I9KHx94ZItMaJ
 I+KMjwyoLNNVBk/Do7xdwuTmqDXkxFVbTUuwBQRC4HQ==
X-Gm-Gg: ATEYQzyfgTfSQnyvPJgtUFK8rGdqrYbpucFO/7jHXCS+Hv39inUO/qr71BsP32XBVa3
 DtwZKRpNQpE4MIgT0XUSNr5p2EE051q1jSpiRbyRecqgb+aW1pAvq29684y8Bzqr3ca7Vh4f4SM
 8U3ZlYJNqxC5Dzr0ejpaHjcRTihNXCikHZRg17txvnGhacCKaaEiveT4brb4lzRejENQDuFL0MT
 tTm65yRLFfIbdWy5iq7PMo4Cj2Mfw/vYr8pxO0Me9y/H/oZ7qPDR4D8210pR9Ac+XzeQmY2UNjw
 CK18EpG0Ry/eUgyEJHiFzp6ZqLGYEoaNKH7GMTvN
X-Received: by 2002:a05:6512:138d:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a2bebd4749mr629831e87.4.1774951817995; Tue, 31 Mar 2026
 03:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251104111339.128685-1-marco.crivellari@suse.com>
In-Reply-To: <20251104111339.128685-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:10:06 +0200
X-Gm-Features: AQROBzBUbDwH88HF-IoMgfvwmqiiZ71yrZ8UwIUsNQ7pfMFzo62s57juAGuzqtg
Message-ID: <CAAofZF6shxSrmj_UREp90cWV-fOf4Ce5d-5-iAueRszPH5LO-w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: replace use of system_wq with system_percpu_wq
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

Hi,

On Tue, Nov 4, 2025 at 12:13=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
