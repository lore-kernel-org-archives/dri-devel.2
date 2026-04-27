Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800FBFF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD0710E266;
	Mon, 27 Apr 2026 06:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+FmbZf+";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25AC10E266
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:22:38 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so7234402f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777270957; cv=none;
 d=google.com; s=arc-20240605;
 b=OrpysMzMBueu/nFZWeKRYcz8Drf96W192uv6rCnQj9FWdO0FPRdQ5L+buVuwuGSYPd
 aNucw6x1VyELgZxjW6illwW7K1YnTD2wNKPYO2JVJ4BplUbhajWXOSAH6qBIGJvWBxYg
 qg5AczFQ/KxJLd00n78ir3ZS16/lrvssRLWr0IOym77/gGbF5lAC7XPIvh9VEH8H5T4E
 xdLOEhRcaVlumlWb0s1a+lcvNG6mXHoumMFrjEfylz3MhJzeAhFH0A5RypGbDM9Kdn6D
 E8kMcQPmZkwsgzA3wEGKuTs0F0DwLzJPn5k1icKdKmI4z6tN7XcZ1hkyH31Foib4UZCw
 aGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TAPUtgLCeg2rPN5wb/LbwTrSRKf1znENF+kSWITCphI=;
 fh=e0cJOoSpiXGHxhskGGpoAl8VZFFYuD/kVKU2vyNhjfM=;
 b=iAaRQNKsHgE5QOSXkodHTUT1kK5XKSmpbv+Gu+dDuPVj3/+SGOodJFxUxvF542V5cQ
 n178NdgEEvUzMaAacGfsr7zYdEJUgzMVvQpg0GJSV+U0cHOeE80Ju75O1nFH6VJeGm3f
 tl0YM/7sLODVzcw9ygpH08WWDuLDiOfwHxTdYXFZnfLqipJRR/kCin2aibjtxmkwa54q
 1QFhD/7O2jEWdgiIQ5p0N7TweBuvWX2UdXuSt6yApNmLMswUNI47b5kGo7tipJD6sntI
 DyGMg9FON9+u6GlNbrtF9c/GOcw9OAfK2XCWOqSOZ2Cz4Kte2cjnb4t2kHaWSIOiem4T
 bclg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777270957; x=1777875757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAPUtgLCeg2rPN5wb/LbwTrSRKf1znENF+kSWITCphI=;
 b=s+FmbZf+bAre1CDLvMoafVJceORi9Q2uc3iP4kmJguOGhrOi3USwMrPpGCrGL2B3NX
 5z9K326/qskci60qpcBiVwOwbno47D54nUfPtBn2XFOJSXSrJySqVpilooQBeDq+Hw2V
 dzmXZ1oikhGvMKqfXvG6i7FeWlYulQJbA1xlegtzk7vZFNPp7WbwlR159LUUxPSjerqW
 YLYeyt71aOP1sxyA6dg/xTlPkmOFTSHMh50G5TiQrkJ97sybp6cyIT5eI5b7VkV5uF/M
 fnR0Hi/OECv3iFp1WYsr3SGqJsjCsjBqbfbnFV+oRqaSRifDoBWgneFDZIQla1f+k/nL
 pVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270957; x=1777875757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAPUtgLCeg2rPN5wb/LbwTrSRKf1znENF+kSWITCphI=;
 b=G88B36dKyz5gvGKCDFXQ8e7MgkJY5k+IYbAOkpgKYzYjU12BSsuuUOxni/Hfvruo2f
 WZaC1aOpmxoBnGqoIlrkbr91oJ3wIgeWHWMtAI8+Fpw7V4DmLXdFjMdz0c2jO/KpQ8hF
 KiB/C1xfHUslyHgweMyPVl11m3MgrNqQdtFpNO/I1Y69swRVa9uzA37sYlYQUyzFEdNU
 rZibVT6mTwe5fi91dT1xYVDNn+vlJn7uVWsGnAHFdW7c4Rd/PGvLgYzfo4uOny8B+0s3
 gLXU/DJhpCFDeIknxMGCvacttpNbdgz6smmrYOVWpGM/MrUPMZS8qO51VQO+XW5f1DPI
 vJlQ==
X-Gm-Message-State: AOJu0YwdUEcMivYRrZHkbxmcqXdnGEwmccW20AlITRBMvwGV+BAYC2de
 lj0XHFdT1ekOTuulHdlFKwy6tJgoseLdd592Vmu2s66VMFrEdN8sH253WesEnXncsT/FPmSBI+E
 AZGvKErdz6ezHRlE2FZJ3eTkYeU8Klro=
X-Gm-Gg: AeBDietUW/mZUWdHZbIb6Ujoe60g/Einy8VgB3+TbzF1Oaw3EtRJKMYkfbjfetnVDhq
 WZpg0OxtW6G39o89rVJMX/ozJdwA2z10bQURdYA+o0e7L/KuIBfbtp/1+3PMzwNleWqXttJ4VjS
 Qaqv9fK+3kzDx5IAMTZc1TQs/z11RfXZziV3rXJ4UyQDtK/G5xjGZYKABQfKWTtStLnOUcX4/+u
 xHfFbwjQrjbqcD3oOF77F/iAZyab0LNk56ljxjwEcwn9cAbLgk2gGezCQ0CMVDU14r3BQLCBpBt
 kcYJo6WgogDNFwdjw98=
X-Received: by 2002:a5d:5f82:0:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43fe3dc842bmr65390987f8f.7.1777270956678; Sun, 26 Apr 2026
 23:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260309075248.47730-1-clamor95@gmail.com>
In-Reply-To: <20260309075248.47730-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Apr 2026 09:22:24 +0300
X-Gm-Features: AVHnY4LHLsGKQKTddU9Ol3ClWnqsWYnQ5Yf01s4atQPUjMHbboFRlCT-xHbdbow
Message-ID: <CAPVz0n2rc5M4FRxiCK5cJ6usQxsfPhWjMCEpFucoZEuTfY7Pvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] gpu/drm: tegra: add DSI support for Tegra20/Tegra30
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
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

=D0=BF=D0=BD, 9 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 09:53 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Tegra20/Tegra30 DSI is quite similar to Tegra114+ apart MIPI calibration
> logic and clocks. With a few minor tweaks, existing tegra DSI driver
> should work on Tegra20/Tegra30 devices just fine. Tested on
> Motorola Atrix 4G (T20) and ASUS VivoTab RT TF600T (T30).
>
> This patchset depends on Tegra20/Tegra30 CSI bringup since both share
> MIPI calibration logic. Ideally these patches should be picked after
> CSI bringup but they will not break anything even if picked before
> CSI patches.
>
> ---
> Changes in v2:
> - removed all MIPI calibration, it is handled within CSI bringup
> - added per-soc structures into of_match
> - added fix for hang caused by register access with uninited hw
>
> Changes in v3:
> - switched from version DSI to boolean flags
> - added comment regarding Tegra30 clock configuration
> - commits were picked:
>   "clk: tegra20: reparent dsi clock to pll_d_out0"
>   "ARM: tegra: adjust DSI nodes for Tegra20/Tegra30"
> - commit adapted to recent DSI changes:
>   "gpu/drm: tegra: dsi: move prepare function at the top of encoder
>     enable" > "gpu/drm: tegra: dsi: re-add clear enable register if
>     DSI was powered by bootloader"
>
> Changes in v4:
> - switched to device_get_match_data and added check
> - added comment regarding Tegra124+ quirk
> - adjusted commit titles and message formatting
> ---
>
> Svyatoslav Ryhel (2):
>   drm/tegra: dsi: add support for Tegra20/Tegra30
>   drm/tegra: dsi: re-add clear enable register if DSI was powered by
>     bootloader
>
>  drivers/gpu/drm/tegra/drm.c |   2 +
>  drivers/gpu/drm/tegra/dsi.c | 126 +++++++++++++++++++++++++++---------
>  drivers/gpu/drm/tegra/dsi.h |  10 +++
>  3 files changed, 107 insertions(+), 31 deletions(-)
>
> --
> 2.51.0
>

Hello Thierry!

May you please pick these patch if you are fine with them when you
have some spare time? It is ok if they end up in the next.

Best regards,
Svyatoslav R.
