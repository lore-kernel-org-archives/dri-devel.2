Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBAECDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6D310ECC2;
	Tue, 23 Jun 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vEetVpjD";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BA810ECC0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:03:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4924933d072so3405e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782248619; cv=none;
 d=google.com; s=arc-20260327;
 b=Boaaq9lw9KdsJ7y0fxOv3LYJg6qBJLp90/pHinDbsZPZgwmbekEFWYnyruLlWBuFWR
 xgBQHgUuLhynLVJIt9BSV+SjFKCI2+WuQc8Aqi1vO4WAij+pgtBtz7bRs+kdHXBTHqQC
 tzGrUKYwFB+b8LHoLQVZoxI+pA7otqaOwLBt3FMYdcy5ovfszCG+z2+fM+ify1RWSdwl
 g/WFVuuoeeEa36OdceUX1TMD+JrMwPfcJFv603WhKXXd3xbmM3fDOp6sE0JsyCuivzwT
 mPzjvhOswY8NH3K9gvapolrIz2bP+MmCiUaA07Hka3qh2hlqdhRZDtK6sCea6ajh1gU4
 wiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
 fh=FwUjqNcVoxYkHWNwoYIM8VEhndGPU/DNG0idk4qfltk=;
 b=Xvn5QOyor2oF8kl3Vp6JwNuqsNMAXBBsSJmFVaF9SFWPNFemQwWr0SjT7evxDV8EGz
 Eat6xE9CW5XwKpXoiEP+YowQ5Tm/vOBjQzoJWji5ldHXbpzz8hmkYbYVen7L4ozL6UR6
 aAgJvcnse2x4/EaUJEl3aulr+bN0HzaqK1epyuYQ1smmtU9hoXGx0qmnfzKvpe5FVhQ4
 P/hBB0D9mfWwyIc6LWwdbJ5GBalTvD4z7SvuqjWOQ5Rl2AaHG07Su55pdkjbze+KBp7n
 9qPTbVynS6eBniJAehTPGEbCRnjX1ZZ65FL6AVJW6y+BKpV+eEyu+IwjYP3Zm7MnkX7y
 jzgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782248619; x=1782853419;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
 b=vEetVpjDkPWMuQzfFYgSlYKBr2Wfaywp7Q4z0DLSpsIFCzLcVpHBiYb3oFN0cy4V7m
 4KhnUoZL/MbbfyjTgf3AhpgUor5U3TJwYgbjJeu7QHIVLxd82H/Zwf+kD8O5nU2pQroq
 VfPiVqWHuKj1AF2oepgA1snG7klhdYWigr4aKSjUq8eVy8PqsTU6vXd6b182TmLfKasR
 oUrQYrX1bsGn5psdow5Ro/SxMrmzO1ZlolVNlyZQk0y1AccHS+fXZHWMZNSZe9wjIqCV
 IVnVFiMi7g3GYfiBZVrEOiJ2iqQ82bXNPLTp3B6/P2OVvNbNUjqXUNhIypCOt7m6+4fp
 5g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782248619; x=1782853419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
 b=iw8tofCVlUCRBiwz5FF7bMx9a9U/MvrGRz0t8B2T7hzDAEd/xE+seyDp3bd0jw+d/5
 ld8m2QEnfsNHuS9+O1DJj/RFkVn8eA1dQLZnV4+Jf6nZ955zZLUhFGgkELudGoMsqUFA
 jp5WwNS+uy72cHO/gJxadX4Xlyx1QrcaNDxsO86GUXMDjccbHxw7ZwdsxUOR5st9/IiF
 FAms0y9FJsxI7n+j0Vtf7XKvkfUz6Lm333HXSU5PGl2wEU5N/qquKwwXBngmd8u+0mw2
 Ne0PXkMTdCn0xYLhsOFg+iJATOBphmxmASlQl8wp2ihh2ggpS7UJ3TTrh+yAfolc8+Wl
 CdWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NVegq49ntIOsdRLJf5wQMGR9aZkYvmobC+PVe/v5zU936AhGGAzSqDtHVJ+/vyWQXzPBj/Alc8Gs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXaXXWLJ+O0wDa0Fnh7F+8j4AO/6CFNevsCGFOq33v+lDrIdaY
 B6sLnpwgUABtPj7V7IoQ/fS9u7rPWAC29U5ZZQQb7ypiuCoVHhGOhdrd7FMm8Z2veNbC6W9GuCU
 IHDT/4AT80cUxilh1uI5lmIFU10FWTSyLdrqUrvU=
X-Gm-Gg: AfdE7cm/lWFbh7SfRcRQYL4pmY5nr4e47JTo9lSSLnazPb8/4viTWrPlRD6jBZXGB2/
 OPFCnej2D/y0HognnnRstmRnKGTX58cdrlrhCA/tLjwnCHjWwo5C97wlGvXy0gT59nA/jY1dplS
 cK0CqE7HrDiZqPC3mmPu66tBjphYxKIdsqpTz7iEBaeqjgMA2hjlQ9Z3F+PLd+aghcSEfxSNYPV
 fAgQYGfJaeBc2xAUO3/qjy/RS8ptZqlz0A7QqZhILBC34NVT0QHntWRaQ0ODh4GkAXgOknHG5FC
 bM0=
X-Received: by 2002:a05:600c:16d3:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-492603072camr290785e9.0.1782248619190; Tue, 23 Jun 2026
 14:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260622091344.794e0d74@pumpkin>
 <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
 <20260623092501.17bef195@pumpkin>
In-Reply-To: <20260623092501.17bef195@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Tue, 23 Jun 2026 17:03:26 -0400
X-Gm-Features: AVVi8CftE4Qz-bzNimcxnNDxPCuT9w5jszdF7jgeQ4PkwmMrpP9oMduQaXpAyA0
Message-ID: <CAPd9Lg-i8Agh7_E5cd2CmtWww1cM2PW3A243qtQaHxhvHdjCQw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
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

On Tue, Jun 23, 2026 at 4:25=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 22 Jun 2026 17:26:10 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> >
> > Hi David,
> >
> > Thank you for your review. You raised many good points regarding
> > optimizations here. I'll switch to using 2G as the max entry size
> > (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> > multiplications. I'll also replace the `for()` loop with `while
> > (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> > to `size_t`.
>
> You shouldn't need a cast at all.

Hi David,

You are right. It looks like `min(length, CONSTANT)` works well here
without triggering any type mismatch warnings, regardless of whether
`CONSTANT` is `SZ_1G` (`int`), `SZ_2G` (`unsigned int`), `SZ_4G`
(`unsigned long long`), or larger. I'll drop the cast and send out a
v3 shortly.

Thanks,
David
