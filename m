Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5A4C44512
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2039910E085;
	Sun, 19 Jul 2026 18:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="g2VdAKwl";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D55B10E085
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 18:49:00 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-668432d50b0so1392395d50.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784486939; cv=none;
 d=google.com; s=arc-20260327;
 b=M6V8+y5TgPKsZlf8rLlwe0dnVPySusGE1sbfJr81l63PJu83vuQBrSXaYneN3c7rnS
 jKRC+aA0yiKxE6By5TdE+9buUBH4coAAF5Tor5V55yZyqrnM5Ua3DSEv8SFKQKiCny4Q
 2UsA7yQSfW7BFyKUsTyrh6CrccGEmceMCE4K8rLXV+8jEx8uvUzj5nAQoF9N7qB5QuXS
 UQMGaHPzflth/l0WQFUt91bLmYRp7xMrBNiZi7jRoGyV/H3DyQLC6cW3oOR+gAd00/qJ
 bNTXeUBRWyuqFNjI5+BRBb4BEu13+tQC2H78t27QP3w1nF1U4d2LIgEkZquvwU4KNfDC
 aNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 fh=U5UfUzYkOLAg4B7xEHr/AhECSWGIKvqsnvCkP5FPHlg=;
 b=YN6txcBHbleGQRtkY/a/IgNoChksx4xGGBPbyClCPoSORIQNeTzjzCiwTNk8Y4oi3Q
 c6qNE/kC99d3R0+jIE5FEMAPVzynSkU1Ou5kRXZpTeAGNhw1XphmiC9rb4iXNSH8r0XF
 EKeV2y0jXDY2zKoNWShRFPa51q02fEniwg9/Z/JQaAGchAWxNyh9BLXS/dD4uAxkeUfm
 EatD2kGbqltsqlXCv7JhKUYBHVm4KHY79Sh62jPnhzD99n/WE8FHeOXhzo4pwyG2Mwfr
 /AkLH86utEEZVD1Ygt1cmFqWCaFI/wDgmuwwucMnmv5DzGR+hkGYmvmH60Vtmujr1WaV
 MDbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784486939; x=1785091739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 b=g2VdAKwl09FKahCNER56Gave2Dnz01KjJtryyMISbD53OOzRWoYd0JCDA74Llr9XiY
 w19XXz8q4Q3IJVWx6ljdwRJv4lhAFhTIlN0QXoqrTZOtyPVHFN8ykNvqqrjt5gd4iUAW
 Fh2U1fTxynnKLPv1tNfj/JOUwG75BZwAGMKX8d2Jc97LRR+x3pDzr2ZZdgkmv64QBAlR
 6uIJeZSxHvvV07J1sOGQ0WrXkXZzjwKn/rHDpkDP2A7sVVK3KMXBw3rS9F9dN6JWix9R
 0/fWvVCZ4MnittJZNVi6Jo8gGWuzm6UiKZ19RmUT7uVWquX19VIjDp5yOEx+BzSCVip9
 aYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784486939; x=1785091739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 b=HlxGA6aLrTzoKGu5OveSoMnsrX/sXUEHYayJef1mWqKls1Q+uPtzOjuSnGWOnUKT98
 9+3tnILKegW7kG0Gy+sR3w/r7Jxzyck1xhPwRTahcFeAnhx+mXK3IkOS3FvvR9od7IN/
 qfJhODWtIRD74Ih/AvLz+O9cqJ5hYzZplU6fADsEavoRE7LM+5EuwloEX48T/OsjtY40
 V55lSOzlIChtavZP6a1pPU56PSupybUunURq2hIB/btnWSk/A6bX7wZQP9A5kf6vQIug
 0Zq22g2m+tm2nRi4a6XzVSCyUSXUd9tPHLZMwJoDkM+yKt/8BGItb6ytAKTw0OJnmNpd
 lWJw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2wH5nw8AjPat4X7JlGGiKY+QV6HyQFOT0C2XNP64R9b7cxTYCWf1HRUWz3MHdl6BNFzvFJm8aSIw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlPzqifNOFlBLnMqyrLgimcWyCJba868scBsUMzJk/33iatwEu
 JBuvoT9uo2xvQJnEJa+bXaBxM/hclbwkRmmBEdrberN6S1PEz0y7UR1BeAl+DpyZ5C93qx5gAJl
 DzZJffqgnLK9bzcilaMX7y9y2ZP1HwFqXO4K9lVtJ3w==
X-Gm-Gg: AfdE7clXTKGWG5W7GUWcNSvYkz7cTm6aetCYhc4SWhziu4ksVwY5mA07zdxokQsIN1b
 nvtvtLEN4F0jE8IeL/5yPJA6nnvGCojvfmZ4+276RjwKepe8ahfp+al82Pkg854SxDBs6rSDIkg
 pwtfY3rfwfo2StlFGdxFrmFJGqmoMXWHqOPjo5AJDhqInLwx6a6dLCxoGySH9Qzg/TUWVpHAUb7
 i+Z27mwhc3glcjaIBIa17pebQg6sFWU+q52EDjoQ+xgKBV/4+owzFKP4OatDqkJuZ8/Ll3PEkRn
 xNbtkBYIaPZ2JW8TNM6qJXeOeKXagFRewcCVMVvTrEV++gg=
X-Received: by 2002:a05:690e:1586:10b0:667:8b91:2421 with SMTP id
 956f58d0204a3-6683bdf0897mr2543977d50.104.1784486939236; Sun, 19 Jul 2026
 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
 <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
 <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
 <CAEev2e8e4Q2zgQxkodBzNpXCDCFhE4femijQ_K8yQrKe7bXn=Q@mail.gmail.com>
 <679e18a5-9402-41dc-bd7d-58bc7714ff62@amd.com>
In-Reply-To: <679e18a5-9402-41dc-bd7d-58bc7714ff62@amd.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:48:48 -0500
X-Gm-Features: AUfX_myTyI1c07sHOlj_UviaIekPWxJEsUXexFve-I2x4sfOS9IQksI4qi2DPZg
Message-ID: <CAEev2e8HfUEMCct6exgukAp+7eyj0E=J040UqmF8GsS7T4MBwg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Christian,

On Fri, Jul 17, 2026 at 2:37=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/16/26 16:31, Anirudh Srinivasan wrote:
> ...
> >>>>
> >>>> What could be possible is to add a special quirk for your platform t=
o not allocate the dummy page as DMA32 in the first place.
> >>>
> >>> So some kind of a whitelisted set of PCIE vendor/ID combos (with
> >>> working IOMMUS?) where we fallback to non DMA32 ranges?
> >>
> >> No, what you are testing here is basically that display is functional =
and not anything else.
> >
> > I think I understand this now. You're suggesting that we skip
> > allocating the dummy page in this specific case.
>
> Well that won't really work.
>
> We had some minimal fallback to enable only CRTCs in the radeon driver bu=
t that was more or less only used to print error messages and not let peopl=
e end up with a completely black desktop if HW initialization fails.
>
> As far as I can see you can't use the driver/HW combination on this platf=
orm when DMA32 isn't available.
>
> You could give efifb or vesafb a try, that is pretty much the same functi=
onality as radeon without acceleration.
>
> On the other hand what HW generation do you have? Maybe it's possible tha=
t this is something newer like SI or CIK? In that case you could try the mo=
re modern amdgpu driver, it should be able to better deal with the situatio=
n.

I haven't gotten the chance to test this yet. My chip is from SI, so
I'll try out amdgpu too.

>
> Regards,
> Christian.
>
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards
> >>> Anirudh Srinivasan
> >>
>
