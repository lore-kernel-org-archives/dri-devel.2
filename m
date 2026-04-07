Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE876FEEF52
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2920D10E441;
	Tue,  7 Apr 2026 15:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWWFNl95";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE6E10E441
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 15:01:07 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cd71fb9f06so328488485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 08:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574064; cv=none;
 d=google.com; s=arc-20240605;
 b=NPV+1KAVBP0AsIjeZyvVi1XLVYJLRGBAbYMn6+KMJ2P0bcZcpVmjdNc0VNX6ey7jg7
 38wrnrOWb0tEzp2EfWLBNh28LrP8MHYx9mKJ5XYdPzB5rYq46/MWZPzkEyE3DODHlDgb
 Ct3Ro9XVuIgzkSicXzhz3NOOyIveHYXEUBHDzviNrFfExPipY9NQsm1dhsWU9b3ZI8WA
 SvwYtGbd9HUx5M2ULU8z9SyeQRoF/RTVY38bi/2yyjFJTh15w/SrzK0NR4g/rnv1ripO
 o1+UfIZkijKZiIzGTswoYIyiVPKC0V/KarFOK7aAKEOvX2/kKAh2SN6SqEcjWC25Leq8
 VCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3lNjW+dxr/buBuPTrI5vfayHnWO+C+X6rAlTXc04424=;
 fh=McaDjl/BWetYR5N+Gvg61UIyVSsIZnEhM32wk4r8ucA=;
 b=K6eNQYF0kHAsxmK3CG61q1WDCOQWaT67oeUw+WYlGQH4YHQ8FtuWGCEby5u14xhCU+
 WfbBPJbMA6mk0Wr6VUdDOvtRhe/yj8mays32jzxBOSz1jxWplWnCsohvZ2dB6PUP3ocp
 WdBY4KO+7Cr6toKlMZtPDrbcRzb4mU0pZd6WLnaU2PwJ5ZrhUotnrYsCxONUoXapqW10
 FyJtzTs3nTZUSY0mukWAbmp7VqO3M5rYdNYGQ3JrQB+LgoJMWl0+YsZvj/33Ac1MndNK
 fgraiuex+q97JynTmfh4jBiimsV7nn3p3pRhbXK3kM/ZCXEqgag3nn+YP+n6oWJM3QXw
 Witg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775574064; x=1776178864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lNjW+dxr/buBuPTrI5vfayHnWO+C+X6rAlTXc04424=;
 b=MWWFNl95CNKQOT6xxLabGVio0QDr4OZeMzjOmHqztmUC5FhXp/Pvde+HpWtrzThifk
 XHfeuXDZY1VN1+K6/FB3p0iTIPsGGerOzmGIWHB9DC5SIH10p0GFKmFElV8uEl+srsFi
 bC34xVX7smpRJxEEx6+NR9ecUJwWEm1tIjYztV0zcAi+24qIhM/Iv3K4kOQr7mjibv8o
 SwNoGg4HJuJXb2MbLu80C9PTOtMDTkJhhiBAdzOVV8IVbNBi35z96p9Kgp7fCjzf/C4h
 fEb9/siN2eHAKmmefdGcWtv0QnIPr5vCuG3+y8d0YjLm2h+opw3G9IFzayRjKS0L8tix
 dKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574064; x=1776178864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3lNjW+dxr/buBuPTrI5vfayHnWO+C+X6rAlTXc04424=;
 b=dZANw5+GlDgncDPLhQCt4GKMywfxpYfUp4QfDDczJGxnJipKX5xcSvqAFWXruRy3cE
 JjusEXTcnfKO23nuM93seTkreF3euVtgOJ21nEqMSxAg4z4usMKJLbdgb00ifvO1SGHR
 84Qudg1ieEKnZF97SsiNVTDHw+3DSpC2RK6HD7eXxaQFu7l2MDb/IQKMBeAgY318Xkjx
 Gc2IcdX4l63SjH+CN6SpsESzoQZow8HxLlilRM8Qlabgn3Mbxr5z3yeuRQzJacphc166
 jVRmlykwzr597yzAmByxFPEPtPJVW5x471jsT0glMPFi9zSAy0J4PTlXXy/ZEDw4vTim
 Mnmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjCyoiWS3HhryMpmG4VEJn+h5HdDzcom8+sGo1zAkCOa8dFjO7tMCsm0+islhVEfvyHDxI3Vy72NQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHrSHx+58K5MaeDh+vz3nAWQ0YyNQ0214GVA7hMNSeRdkH3/4i
 IJVLRujG5wJXHiL1tMApvjW0jQLce7PMPQuko5+QcbRhqErULkuz4ZCETPMffCcZ7JKunwn+o3o
 ap0uOfFDwoAOtDb+wr6o4N9+P0o2ikfE=
X-Gm-Gg: AeBDievxNZT1EvQBcADhaave9coYTluCfCYEvH6JfP1dN44Py2nEqtZ4yhjThN7vlj5
 ZUsHwH/8S+LwSMxo11Dv9sfueasnIur4GsGtI+1bzPRzvzlqZK6/f3UuHztU+NwI83dfx4wNRh9
 rbeAujBGkr9D5knxzk0Oq6jrSpLhWAGRMjmECQteHa/L5xaj4uxy8D216w4QP8sqorXPuAWchpU
 k4zLK+8kyg70V6YbhdSWCUoq8L9wTyL7wm9KXOSeBJ4MVZfURf6yWt/Vu/pw8MzwPWKTN/UV9CU
 LwuCEg==
X-Received: by 2002:a05:6214:2f13:b0:89e:cb8b:a77e with SMTP id
 6a1803df08f44-8a704abb8dfmr284541396d6.32.1775574064233; Tue, 07 Apr 2026
 08:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260326094308.1161335-1-wenst@chromium.org>
 <CGME20260327054445eucas1p2d1ac645faccf16272c3a12406400a364@eucas1p2.samsung.com>
 <CAGXv+5G2H3CSic5hCSd2g6RrfGyNSbpYS7Z9uo-XUn6No3a4Rw@mail.gmail.com>
 <52a26d5b-67ec-4a99-98f6-6216e930cdb7@samsung.com>
In-Reply-To: <52a26d5b-67ec-4a99-98f6-6216e930cdb7@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Wed, 8 Apr 2026 00:00:27 +0900
X-Gm-Features: AQROBzCwFYJ79nrP10FU2NCqyXv-mL-J9T-1EOFubFcU9cyDki20zWlIqj79km4
Message-ID: <CAAQKjZO=h9uegjBOi7dqq0DM3o2B9gJ9mkM+40pEXMHY87unvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/exynos: Random cleanups
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
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

2026=EB=85=84 3=EC=9B=94 31=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:39, =
Marek Szyprowski <m.szyprowski@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On 27.03.2026 06:44, Chen-Yu Tsai wrote:
> > On Thu, Mar 26, 2026 at 5:43=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> >> Here are some cleanups for the exynos drm driver. This was done as par=
t
> >> of the conversion of the driver to GEM DMA helpers. These patches have
> >> no dependency, unlike the actual conversion, so I am sending them
> >> separately for inclusion now.
> >>
> >> Please take a look.
> > I should add that these patches were only compile tested.
>
> I've tested this on the real hardware and it works fine.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks Marek, :)
Inki Dae

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
