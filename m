Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C9DCD98D5
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF74310E1A7;
	Thu, 11 Jun 2026 11:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkeFMjMu";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A99410E1A7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:29:30 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c27fc587ebso20327055ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781177370; cv=none;
 d=google.com; s=arc-20240605;
 b=DJIjV+uFHgyJ1gJoiynx7/VG+TaSVf6ErWlb2Ka9fBdc8I5rkjohiQuMnKgkLFW5JJ
 FCBtJ6st1d06AgW1QWnUBb+saufSW+SLS3zPgNp6ZLs0//LWEDMnDzcWkfoWAQa5r+re
 S+/ss34zrlrZeUBLvUX4ZU8JUDesuzKnnawqGyzQMmdums1zNg60dTFseBWc1/SDYoI3
 a1QxYI3vZmjnI/no6AUXGXG5HIhgR/QjpMH9W4B55l0dTLo4NPWe5HHaODSwH7Lbc7R5
 hUDBruQZ72uKSLY2ybXggySzDs1zIeVsHL49iTPbAdjqoac2+XqMuljaSayMnmudtpqR
 lojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jg92tmAO+k66o2B5Of/8Nf2qLZy8ghLQqXh25wAN8Mg=;
 fh=L5XzckKlfmpTMg1dRQFXn88iRcYqkt7LN6oz594BoPQ=;
 b=jNBh9LqNQVjyQymJT07JGCcATn/B19sLKTej+5WeKdlmVtbMWGmP24q9tAVLjrgu+B
 gd4nP+2G1S+QPvBAUvohDWBl7xMPaNBukkANR4dGkDqCzi7kfd0Cwsvfn3WhDzE2cI6R
 ewnZoKOCGXeMPo0iRszTZ7Ry8PSlqBYtIpeBj0zIFxgmbc53/Lkiqm45NABXgb6XGcbI
 yVz5PgrCqiXiZmkkkZCcYKC6q3dyxmL/1G9ErKYK23n4iiQUdg8c5rLIbWCF3TuO22Os
 rsDs1RixIUEj7g8GEFRauXCXa6pxY+GxswtbfgY777FW4HEvjFdlekCHtwLmuPD9aeq8
 dqzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781177370; x=1781782170; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jg92tmAO+k66o2B5Of/8Nf2qLZy8ghLQqXh25wAN8Mg=;
 b=SkeFMjMuU/mKg/3Q90wIRfZDkRl6qkC5b10ojvr5n/HfO4W1RBY6WpRN8iAkTm6Ixc
 J257l37b57I/L+eJT977Q5PDSxDaK0g6ci7Kizegn/0ryWlAkmeGpnZZcOhWkjNIEVAf
 eOOf1ZZEyuvgOkbVRojCynycc8hrXGG2wtmcCR3WgqQngpT0l7hERbMDD3cnsJ7W8WYF
 AvMGe6FPzDpjHPMuiydi4pnqfvTBvZDZYL2FChh54HehaoXMypd8zSk+ZB3m9+Q1Pame
 44gHIGLPWKisFGdsRAZx9+X51XCrTLN6B2e8PlpzwEHEI7bcnQAWBENLP6hjoR1ZtrVu
 3oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177370; x=1781782170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg92tmAO+k66o2B5Of/8Nf2qLZy8ghLQqXh25wAN8Mg=;
 b=XGMz7pcEm2W5ejgHIxHjrGtjb2NxVmwzmZ9C8GxUrIASutKCURMnCRzP5dEPzUQz9s
 +zegiETReMVgIkCq/TYAPPPRUTygKxLey8XogZkJQwf5mECqee5hvkrD3YshE9ZUkUuL
 OWWkmvOJz+g/6CTMgXXfalGtjHKEhzU8b0e9pruHOwCEOgMBrcp4cHz+WDwO0kNoMCOV
 XtKac6Ipz7fC5i+3201yu8Jw2rVXhAO+tQ8KfIFxRxKajQG5lLnvnjjJA5XRixZsa7L7
 w+Uh7xpYTspNhjNUswTnymsHK3kxsox+1Wl4U5JB51pmpJWMXkVb7oSFtfszaB0QyqAi
 dGWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g7IIs1fyU/HsgP8naCLF+hUvOWd/6QQa9DG8sIUkb8CFQNC+wIV65M8g2DhhXdbilJ3iQ44dpivY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyffwgUNAyhvn2l/UkXuYKlhFsUfBkvIruULkh+el5kLTxWmYpp
 B/KeNgJ3e/niHJ79pxHDFSM+7LgbyKClPG9HCi0Jyr4FbrPQ//KPXMgXT112nzPmFbG2eIMFRdR
 ye9gC0fL1ACao8L0+OfHnaWH6ryFu1nkS1GSg
X-Gm-Gg: Acq92OEoCPjNjt9o20Lt8DKdcNzoiaCLljvNWVS0pW3bVtF84AI0kFGVp0V954AJDtI
 bG/hpsRDvc2iMS/0C0XLl8bB0SDUtgpCRpGjokdMouOqLxadtT471DbdUUJq57+PWjpEqKF4u0v
 l6GR7NfIf5BGTP/oExHkcLFuDSekyTsrMwL7VCBKgcP3fJ0v/N7W9O4c7QqwCg+zqLYb0yQ9j2A
 DiGd7XMj3wgRZgL0wvAAZOo1HaO0vyoSGzfmed4mg7DbBpzJ0MnXos4mrv3Eadqi1elK6spC8O8
 v6sxNpNUBpwByKFaf27DnNu3MlgsagRsJh4NYlNyLUkwUmrH
X-Received: by 2002:a17:902:e744:b0:2bf:195d:21d2 with SMTP id
 d9443c01a7336-2c2f0c1b5b4mr27995025ad.16.1781177370098; Thu, 11 Jun 2026
 04:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260511085148.652256-1-l.stach@pengutronix.de>
In-Reply-To: <20260511085148.652256-1-l.stach@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 11 Jun 2026 13:29:18 +0200
X-Gm-Features: AVVi8CfXfPcPU-CTPeK8vvYAg_xZHsziIqIT6JmDi8jRSfhyqrhMYiFsNLWMSuo
Message-ID: <CAH9NwWdZEzosaWGBWtb9QOCwr=mCsJKmLxCXe1dq0qZ98GgfWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/etnaviv: check all modules for idle after reset
To: Lucas Stach <l.stach@pengutronix.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

>
> While the FE is an important part of the GPU, which needs to be idle
> after reset, all other modules should be idle after a proper reset.
> Check all present modules for being idle to determine wether the
> reset was successful.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index a891d4f1f843..34fff36af450 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -585,9 +585,9 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
>                 /* read idle register. */
>                 idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);
>
> -               /* try resetting again if FE is not idle */
> -               if ((idle & VIVS_HI_IDLE_STATE_FE) == 0) {
> -                       dev_dbg(gpu->dev, "FE is not idle\n");
> +               /* try resetting again if any module is not idle */
> +               if ((idle & gpu->idle_mask) != gpu->idle_mask) {
> +                       dev_dbg(gpu->dev, "GPU modules not idle\n");
>                         continue;
>                 }
>
> --
> 2.47.3
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
