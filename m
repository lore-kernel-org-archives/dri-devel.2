Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C979CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 04:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B367510E025;
	Fri, 15 May 2026 04:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0asgAaS";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BF210E025
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 04:30:21 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-38e800deae4so74363991fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 21:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778819420; cv=none;
 d=google.com; s=arc-20240605;
 b=OJAc6T6pCN4151XIM7nXBCrbi+9r6WSl0rdH3OVC53CgELzMwOcjsxolKV+h3O+l2m
 loNLhIPHm0FfgMUCIML4e/IlmQDtc5cfsabKhxN8BW+NXZ/eLmZcYOxRtyPsGMorZxG+
 317Zc52VgdAGjEIvgYHE6b2QJPZtyznt8ZOMv9Euv+ZlMpRxlNhTd4sTd+As2cTCcjYH
 znb1q4VsjpGzg3IRggi/shcoRwNFsG5IekNyti9PYX/zqF255A9GOc+UiStEkH6hP/Fe
 05Y68dYnSrSCX26DGuUWNPlcgevhh/dDxAWIZ0qnu0sSiAe7uEkP4PZuDCfnnLwTwyF7
 n/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ErpV5Q9aO8CtpXnIYlr1TjML/GGAT1epacCJTC2ieJw=;
 fh=MusZ0N5jBJxkjHYvS6DCv363NFaqKsVOsyVLIqTJw+E=;
 b=Mn0uW+B6baZf9u2PM2YubNl+d3sB37fICA1OeFk9ttbI9WbVvKvfW4Grr/2GwOmqjM
 I5i1/fg5Z8/0C1ianIIsBkf/FpgARayWGWpoKzKF1sPMgf/wY7reaedH3DeYUi5ZtBwK
 1yOSbfGK41BcCJjvEix47LMpDu1SbCd01fbEVOuhoQfQ8He/5anzzxYJRKD0rfNcTfBB
 JTsKgnog0smAx8+hUD9FgFKS03ITbou5F/X99oLo0MQMqS7Vs1RyT1MfOvPcp0kVMtcu
 QgOmXi2nL9w4Z2dRpbKr2GBHFyz6ESMouiHGhGgbHtEnA5aBGKfetq9u9BhWsYvtDzeO
 joTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778819420; x=1779424220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErpV5Q9aO8CtpXnIYlr1TjML/GGAT1epacCJTC2ieJw=;
 b=P0asgAaSClBD8OwQzkdhs6v4zFAKqoHZ+YyceXGdOsTfy7uhNjMKQzKOj4n6SsNEFG
 7JDZTV/30Kh0Do2oCIv6o2Fl/gB+9dDIKN+j7DT4iyieOD9CO0Lp0HxfE0FHZJXuBfK9
 KytKJp+d+4uhKT7tgskOayewIUMN4z4kVgGCgOytjd+pdDpBSwkYN54B4u+lE9neTP9u
 +/Xx7Vy5ONoAHSHT9Wg0HyW3WdF9ePlAxn3iRMeFyeML7k8ouu9SCxsRjKMWRK/TER/U
 /7pxfG7tX5IwMpg77qHuK22BjkH2D3WWzWZAvwaA6anumS5UmRHM8pfM7Bu/VtPfJMFj
 5TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778819420; x=1779424220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ErpV5Q9aO8CtpXnIYlr1TjML/GGAT1epacCJTC2ieJw=;
 b=ombqaEd/nb2wNhHh7tM8KVku5Bt6NEyqsaPcstOoRPPTapDTZV7qRgEPirLoW7eVQ4
 mkWrxuczgE5Bn2vepUmM/hxT2UbCNWuMO55V1Oqh9s6/0lKNL1PYa1MY+VsXnXUpoJsu
 d5oHI4IfvCl5Iojxgk6qTddZzk95LDMmxPI+H0sppJhNTfopx+HAflL3WADTcQ4diwr4
 fOQAebN/0E6jmTrzaa3NiIu2hksZciPgB7qOyDo9O/8uLMkCb3VuXaY1QWh8f4yBrirl
 KXS7FqX02UXFo6bsC0qJA/xjg6ANHiVbTtm5riFbOEXDhl0xiNEBYcaEndKZ/FB3/NNf
 c0zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bf+PVs/jiKwCkXIrhSSpw7HOvzXXhyZK6nVYLLjb1Bnv9lk3YCOYTQFjAU1q5aZg7uNqDUHnFYUI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrFTaXZUhOhtpkHNO9cfZNJ2A7A+KfIOTp212xKCJR72o3gdwo
 mUcaqlP3zz9i0Rvzk9ebkeHRYP9EteZtPu/ehOBpnqIXPkyJDQqyHZyHERQcUbnyX8NF8D0X37n
 OFBL4KMLp801LsDHmTc+0GavFpvA35iIKbQ==
X-Gm-Gg: Acq92OFbzPL51qwOWbi+bnRivzvTecTj/OEYCBZ9sh2cnyXvtP57KRoyy5spGt/oUlA
 1+j1gufoe+fONWCZmCSoS8Pg6OKgPtMkwJXZJQdIZB0R6QWJHZKcWkGwUFOHHgOgpv4/NiYXxIU
 f3vQtyS72RpmewvIw+SgenUcQJDSFfh9G4oiwRCUm9EGJb33Vo0FJ9ElG/aLhARKDeWp+HaTPmZ
 inveFF2gdUes5Sn/BwwsQGW//QR3207B2hIMQ+9KMqi2FzMrEzKFg4QacErfTQwpfu3UJzeqU4T
 4CMdjFsXePAAoFT6QumWWF1MvqMtlAs4CJx08AmeCOD3ZZr0XmnOzgpiZxmpQG1gS+E07IFX7VV
 NjoI=
X-Received: by 2002:a2e:9059:0:b0:38e:58c7:cd1 with SMTP id
 38308e7fff4ca-39561dc13c1mr3692541fa.21.1778819419755; Thu, 14 May 2026
 21:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
 <I47hlmySTbquW1VgZFOofQ@nvidia.com>
 <CALHNRZ_EjqA4aeqZhmicRwdpMxjKp1QpwLW98dyRa36HBX8aDA@mail.gmail.com>
 <QKr0fha2SnWy9Cj9I74wxw@nvidia.com>
In-Reply-To: <QKr0fha2SnWy9Cj9I74wxw@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 14 May 2026 23:30:07 -0500
X-Gm-Features: AVHnY4KMxQxcdb0xOeM8iOKKVIXWOA-iHaJh2OHO8vszrzLtndX_JaZ-2BAd_9Y
Message-ID: <CALHNRZ8MZmPiWtKHkcQwu3_1Jf5rU8pZQL4h1AfHtuEdY3XjPg@mail.gmail.com>
Subject: Re: [BUG] drm/tegra: DMA buffers are not always freed
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, May 14, 2026 at 9:39=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> On Wednesday, May 13, 2026 1:26=E2=80=AFPM Aaron Kling wrote:
> > On Tue, May 12, 2026 at 10:26=E2=80=AFPM Mikko Perttunen <mperttunen@nv=
idia.com> wrote:
> > >
> > > On Tuesday, May 12, 2026 2:29=E2=80=AFPM Aaron Kling wrote:
> > > > There is an issue with tegra-drm where some buffers get created, th=
en
> > > > freed, but the dma buffer never gets freed. Causing display control=
ler
> > > > memory allocations to start failing after the leaks fill up cma.
> > > >
> > > > I created an issue on the freedesktop issue tracker [0] with a patc=
h
> > > > with some debug logs I added, then a log from Android that contains
> > > > these logs. CMA is set to 512MB, and when allocations start to fail=
,
> > > > the unfreed allocations add up to just shy of 500MB, where it's
> > > > reasonable to expect that 8MB contiguous is no longer available. Th=
e
> > > > log was generated on a Jetson TX2 NX, but I have seen this leak on
> > > > other archs as well, this also does not appear to be limited to soc=
's
> > > > with nvdisplay.
> > > >
> > > > This does not appear to be a userspace issue. The graphics allocato=
r
> > > > works as expected for other soc vendors. And as the logs show, the
> > > > delete dumb buffer ioctl is called, but is not always followed by t=
he
> > > > dma buffer getting freed. I have also observed this issue with a
> > > > gralloc that uses the tegra gem create and such, this is not unique=
 to
> > > > dumb buffers, that's just the last log I had when deciding to post =
the
> > > > issue to lkml.
> > > >
> > > > What I primarily intend to ask here is how to further debug this
> > > > issue. I'm not finding any direct path between the delete dumb ioct=
l
> > > > handling and gem release or tegra bo free. Can someone point me to =
the
> > > > pieces in the middle I'm missing, where the logic is to decide is a
> > > > buffer should be freed?
> > > >
> > > > Aaron
> > > >
> > > > [0] https://gitlab.freedesktop.org/drm/tegra/-/work_items/9
> > > >
> > >
> > > If the issue is specific to buffers that get used with display, I hav=
e
> > > an idea of what the issue is -- there is some circular reference
> > > counting with the BO cache in the host1x driver, and that means that
> > > BOs that end up in the cache never get released.
> >
> > As far as I know, this only affects display controller buffers. Though
> > unfortunately, I have limited ways to test the media engines right
> > now.
>
> I've been working on some more userspace for the media engines.
> Hopefully I can get that in shape soon.

Great to hear. My android use case unfortunately has some very
specific requirements, namely a c2 aidl hal. But maybe with more
examples of the uapi in action, I can try looking at one again.
Though, my last attempt using the existing nvdec example had my head
spinning in about 3 seconds flat between that and the c2 api.

> >
> > > Let me do some testing locally and I'll send out a patch once ready.
> >
> > Sounds good, thanks.
>
> I posted a fix, please give it a try. Incidentally, on my side I don't
> have that much testing set up for the display :)

My initial test run on p2972 using swiftshader is looking good for
this specific issue at least. Part way through a vts run and I haven't
got any allocation fails, far past where I got them previously.
However, this may have peeled back that onion to another problem. I'm
getting stack traces from shared plane atomics, and a lot of mmu
faults during the graphics tests. I'll see if I can narrow down a
simple reproduction and trace down the cause. And I'll check the bo
caching patch on a few other devices, then post a tested-by on there
if they work.

Aaron
