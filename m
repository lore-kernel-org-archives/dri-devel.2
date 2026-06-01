Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52600CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD7510E288;
	Mon,  1 Jun 2026 19:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="e+qS+iWb";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15A10E288
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 19:26:34 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5aa67ddcf56so159e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 12:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341993; cv=none;
 d=google.com; s=arc-20240605;
 b=TypI8dSbFfztSRpWJgnA0wIvqVLPOmzgfq57BRVHVPCu+p/Bc2RGf0FfpAXKc40g64
 JRonT0Sg9jT7u11/c2Lh/cxyFrOditoteHHkFP56otmXZrIf/9raBoYL7EYfwmNRxuAf
 xcqROVBpdXu14XBJWfgp0Orpn3kJcdApPaWmB2aQo+5R7+UaNyibfDDNSba6EaiGHqM+
 uytT2rvWy+sLYS+YxmEgeITmSKFq+PoCAEnGNAvazqpzolHgs1kePypjnCriQt7GFBcU
 WRv0vkmKD2voE75QA9eHZsfYFaLFS9nGJU+hcTE4R0oJMW87P5WQyVJOWsS/UWgzOymH
 zm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
 fh=+Lkeb3uUhlWBKLQMIXFoKc+89wzoqTtM3dPLbTFugx0=;
 b=keHXqSN7RgrNQayg0f/dVfANNtbey40R9va7EMHXp5aCM9F0dsxrHHViMDGipqsiol
 qHc2Bx/04T8NQQqa2fVm3TzeXPiIl119NqReYa/T70kKm0TpV9wOn/eKusjOcoIOTATU
 nFQ6H21HFNoLyXC5bju3DhJTsOF952NsigNR6Hlc47XDOshXxvHYDFvvxdRjI6bHIc5E
 v/3gGcHWdMxnX5bhsrkgvLqT+zMyOBs0YKZlY4GYGsnpeDjyUdQfJD7wtdHKfH9OYdHW
 5xONOlMXENU+OY2nSFJEiQ7sNu/WIQgtxKaGOytHK5cystHGn53iAV9L0bfl+MUWyAJ6
 I6XA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780341993; x=1780946793;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
 b=e+qS+iWb1xpl+x/W1y2kxC5hHQIzfwbXJeh49d+S98cMhRdsl6TGF9Sk0nDoUhiOfk
 qyKiaL3yOuSF0xsKJKf+MHO7lY5yteXcFLLdRgN07QCBMyJQz+fW/IIQR6qeClPIVCEF
 WMDXBEU566/1mc4RsMrD65D4P0/150bXQRL/48MCP9EuzQhwePmBy2yG9HNsmKfkB+fU
 xK8ecE1+v6CS9WInU9TKeW1eNDOu05O5mMKdCebwHLqSbcQe5EkKuYJpjjQTt2l/yox2
 vZjHMtdIRn8BUQwakEuODlhTb1YeHJbweoW581KnRYQLyfD9plERRD8Bg65Ga67PhTgP
 B0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780341993; x=1780946793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
 b=srUwBaKSdD/UBsgF9//UZaGhJxBp5jGtisJiNeOWttClZwEiTQC8Y5VxMwg5Pc6Ja4
 7z374HEdkb1E3DoyTYFs5opei61p/D8Khtn4BACKdALD/SdMyY3TYb5CHdnp3x5OFmB+
 +BZWKONT2Rmdscmj6i+VfwQ0/P+KEkIqA8+OyxncOW0eL4LEipvRw8Wqtr+x+OhfExGN
 rLRup56hs+v+i13NYFjiQFkgpXB8Rq2ygGo9NZL7+r3ZedTv5an247SIyNqe5kDPcn7Z
 z8+jWAtz4Ff64ZYK6Yr0W+3jZpPBquphgauRtlmzehyy3zXiYYZQY4XgxCop0NARd1y4
 wdDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qQc+69YDh4e9QGS8rURJreTpJNXYVxebZbEdb+KMLCFjyyvDVyNRMyaj9C5pxqTyeByN0Fi01CHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTC0m6QxKiaeSDYzpLEQhvKbEhAPj4WSzgaJ8zB9uMzmZDL601
 EF989atcGuy3ZDe30BmPcaZ/KhLN3owYN5ldRC2dvTSRuAhOKKfC+tNh3pH9QGyTLn9FVzQzv4/
 IJ/bs/OG/pNVXsq6pT4sWvHuksMhpX6v2pwMaw6U=
X-Gm-Gg: Acq92OH+Ue5DwJ3hgIhzYK0tGubWeOdhCpsbErJw3uuERjRqoHyqeSpZ0A9hMT7koC3
 P39Z4kbqvbJO5gdP9wVGi9SX6+2bVoxgp6BVx0FEYtv38uLnBoLzl+zwUjU2Boqa+W1sfzME+TG
 7u2nMazOS9g2Zwp1d1TuB3hmbKuGansOqTKJ00HCLryXcitXZYYv1d91zVCj+mbrQEaqXNVcaXS
 zrx7xtXgooG4FXSDxE/pJgYHOS/27jGR9dpyvynbnOzvDM59//kuZjQ7UbSt6sLZYpM1tz1tDdj
 UMCSM8FarzGULUO1E71NW5K+xO/EdBVx+laypMXmrJ9X2Hk=
X-Received: by 2002:a05:6512:3a8d:b0:5a2:9b28:d64a with SMTP id
 2adb3069b0e04-5aa75b3495amr52247e87.8.1780341992156; Mon, 01 Jun 2026
 12:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260528191658.2506362-1-xuehaohu@google.com>
 <20260601175252.GD2487554@ziepe.ca>
In-Reply-To: <20260601175252.GD2487554@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Mon, 1 Jun 2026 15:26:19 -0400
X-Gm-Features: AVHnY4KmXOz7naPVQt3RnYf5-sps0yuGM1iGSV6Zi0v2ewCpGm4R4O7z_6CO-gk
Message-ID: <CAPd9Lg8Um=0LJWB-QCqLyFksX=dTsu3hwuVXK9_CGRWTVBJppQ@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
 stable@vger.kernel.org, iommu@lists.linux.dev
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

On Mon, Jun 1, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..1aabc0ee70bb 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (WARN_ON_ONCE(nents > UINT_MAX))
> > +             return 0;
>
> The WARN seems a bit much, but if you have it then it should be
> arranged so the caller ultimately fails.
>
> But otherwise I think correcting the types is a good idea
>
> Jason
Hi Jason,

Thank you for the feedback. That makes complete sense. I will remove
WARN_ON_ONCE() to avoid dmesg noise, and instead add an explicit check
in dma_buf_phys_vec_to_sgt() to fail with -EINVAL if calc_sg_nents()
returns 0 (on overflow).

I will send out v5 with these changes shortly.

Regards,
David
