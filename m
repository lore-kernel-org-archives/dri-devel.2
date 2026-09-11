Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D61C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6361D10F6AD;
	Fri, 11 Sep 2026 18:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WM+463lu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0137710F6AD
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16900600AA
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11391F00898
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789150936;
 bh=XMAq51nLinXtWCC+28sDz0PRw1zoE1bs9OWY+JtUJ+g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=WM+463luBFRF0nRHhBgmeRbJCP21K2IEEkJHsAfLf8uKAWVjQSxNHXq5F+WPoOrFm
 k8MMtQC+nqjc9/+hBcyukCjC96KcAf+ZTjBcP7NoU9eToOOBi/DzvlJHFKlcsbWVVA
 jn21HJyuMGL3guULHNCAxmJuwpa9HS7N5s5o64W+6IIvbCIOQP0Ncv5hc59Agjv2eD
 X9deTiBRRX8MpXkZ63aUMtpAZTVjIhfVpHFocJUOYTl+9DboYhDEw0TGwgI0vOxURy
 ghxQW/fPwknhj0+5wQDftzgQYyVFmW25xO8l+ea+GNEvjar+3fADdv2ljP6vstsAkN
 a0TcuvpRqzl4w==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so819146e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:22:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwy/P8eKD/N65PFR22Kcc9JiqeKh3wCV8MW/9N0YxNtSKeFu+A1XMZiIuO8LyevSylCHTFsacZQB6U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVqEE/vzTTO1uQfu8TWHGCpSZCxrKR0Kn72lY5Jn5L7q2dDXhs
 WlTSHNrDWiPCfNuYOXqp4oyYgb5HAflIVVyLl8WioxJ1YZ3tm2zV9iOmu7GE4fplJjXqH1hj3FG
 a6TT64gLHzcvwC1rOKKasKYv1e4deQnk=
X-Received: by 2002:a05:6512:3d9f:b0:5b6:172b:7ba1 with SMTP id
 2adb3069b0e04-5b89a2e997bmr2294190e87.9.1789150935495; Fri, 11 Sep 2026
 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <2684f2f8-d349-4096-b005-b2d040d4cebd@suse.de>
 <178915002849.197282.4107045001044510370@gmail.com>
In-Reply-To: <178915002849.197282.4107045001044510370@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 20:22:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
X-Gm-Features: AcwNN1WGHMc2rQ38sX_-7u1LqNdBRn0MNwViEFTBlcrNZPaUiLhGFatlIm6z1xw
Message-ID: <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: Roshan Kumar <roshaen09@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Ze Huang <ze.huang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
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

On Fri, Sep 11, 2026 at 8:07=E2=80=AFPM Roshan Kumar <roshaen09@gmail.com> =
wrote:

> Sure, I tested Ze Huang's patch on the QEMU vexpress setup I used for the
> format testing (master 7.3-rc2, vexpress a9 + CA9 DTB,
> DRM_PL111/SII902X/panel-simple, panic_on_warn).

Is that this patch?
https://lore.kernel.org/dri-devel/20260716-drm-simple-kms-removal-v2-4-1133=
a8fc3785@oss.qualcomm.com/

> Tested-by: Roshan Kumar <roshaen09@gmail.com> # Ze Huang's patch, QEMU ve=
xpress

I can just apply that one patch with your tested tag if that is
desireable, I don't know about the rest of the patches
in that series.

Yours,
Linus Walleij
