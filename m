Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A9FD3941D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED8210F246;
	Thu,  2 Apr 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPiwRK+Q";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007E210F246
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 13:32:47 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so99699066b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 06:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775136766; cv=none;
 d=google.com; s=arc-20240605;
 b=OTc/btmf6I2Q0ymrcRfQmdD1UYvAilT+T9x46kL7rkK1+DihtfRXmOFOZGKECJ00Dj
 p8Fjzi3U3Q9jsh4OmF2tDcryWmeszBCC3REK3pL8rJgcbTXQstVANFIczYkoe316zMsk
 rXGLXVbuqtME67XibGhQ29BOd7Bx8Bh02iO+0Xxrin9BBgQgnNMHiagWBOFNTVWvWmBh
 u7vfuNK4cr7x4b2CLYkwTO/CI3QLKTXlJ4DPAx/Bxl5vyCqBFBsHTpXDetcv6b5uGFna
 QHvMD0hiXLBaAF+75IjpDeHxEiTpaBgYyp5XgbkIBUoahDLtZA2CiBgJqQj0qamkNMmz
 RWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
 fh=TQ1uVgAG+sDEN5uep9AoV31upoz3duPKmnLbNPXchk8=;
 b=H5W0YVJ7x18hNBSfJ8ZtvT89RGJ0REPiPr6ZW7AoZwo82YadKnAXclpo00DJsKgauO
 En5ENY6JGoh691sx2T+FjhXddXsfxxLtT/4jJJQaNyUuDG6VyOMi31tljYsVcCv8wu1w
 oRT9S7oVThFohwdg9nxOtglitzftTTcJROuZDRdc2WtStXDlktFqIeTuUrYMQIMI2PyA
 wSeM/S8YOasuYKParFrWxrgwW62zIIs4R7kuXA3CtYYusNI06TxSPKIPFqaLuag4YdHp
 9i4FtPHBleMfFjoYSKLIO/b0Oq3aXSV7/+eP6ac6/w/JUcmGB9V+S6uIr7wfhXURjPxX
 Zpmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775136766; x=1775741566; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
 b=mPiwRK+Q8H+tCRcDC1S4T2B4g7V+cX7imehxeYx3ICjUZZ5ic3W73rIJ5rZ+d9wA0A
 ouFoPjG7Ydci+YixRE3Q8rhJYQGAXVYYkQvziEIdHbqLtuVXf9Jd/YYa37s797TLtoTo
 cYVbcUU3hxnLgIZH35KLIA11odTSkGdYBgenEG8hR+fbVoZsoysA9TydzWHIsafOCZh+
 VLyOoKLa4WI88L/Cs9C3wq+/gnYZVVzGOcwAYN+UfxmC4wmOPvP3cciyZRzxz25j/+un
 kTqqqIR2g5wG3h07QEAfwHOZTMmqj6WKwJ0CH/7TqE45SSRyjtsDyecSVRW4C2PGrgWu
 mlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775136766; x=1775741566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
 b=Erlrtnxw+ZUrN3bGWVyCjU0BJ+Tl29aNbYhi689jVy6sW1ARRS/QCsRQ/qAYpG52G9
 ONuWSV2JXn7N+rJxe9WWz5gpiN6inbCwzkb4oZG8eK/I0A9NGsJQEUHN0Gh7CFjLpBuk
 wabuL4IRUn+LQSBSzImY33S6ahsIzjcZ51Y1EmkuPJZPGZuyhuIQTpS0HrUV/x8kdf5j
 nTYDPnLPBwxpheR6i1cvljDUX7ld7P8VNR7mu8+0aOHf3EpWS9PWH05f7kUBwkvTiBGn
 mPsCHZ2b2JkBM3MTdXbPAs9cNRHjq5NZe06HbimTSDj9KzBPC9Aru95ib+vGUzNACaV8
 kYVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvj+AKSve3db1RJhP6ZxxHJOsOrZwrRkNodmpRieW8bis9suU4bFE5WCupxFYOq7s5akpnkGolst8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMcSBAJqoqC/RTx3tiak1TKgrFSD7uUhAy5lYuTBOF/gtYH5Ma
 02KWqhDQ8tmXqmuhSHD8M/SjAq8FFuVF7RVZbnFxMLZPTfH7G6VRSTzkoCJj9790IZWA/sUOKkC
 eGowcqG3kbpJ8yuEoW5F4kYwG0WxgghEsUeDfi4OHpQ==
X-Gm-Gg: ATEYQzzsxebg7X+ZGBJRNXjwWxl8qE7svBGzRwQASi29UwQrtwmoaRUoQ65lJIb4BVu
 mhz+/y2p6w3HyUX8ohqMFDYysxO+NoB7y+res6IOrpEYgn5mIw381nS+Y6RF3JylCiGz5GBWKvW
 zR/N1MsnTh+LkNd2yEHia4ZYAtz2UZUjCWyYks4HNwZX4i6Y9tck2DKiaUsyhQcPGfs9LmIaQHU
 rmGrBcF0+BFfwTX+lBz6YASl6iA3VPDmfuOVuV0znCHCGI8qPbpqFA2hwIJODSxIX2jap3UvENo
 pELspys=
X-Received: by 2002:a17:906:4912:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c138c110amr392586266b.18.1775136766273; Thu, 02 Apr 2026
 06:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260331100026eucas1p19bdc2aaca4c9a48c6f6ac8fec71478d8@eucas1p1.samsung.com>
 <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
 <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
 <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
 <20260402-burrowing-fine-bloodhound-afcebc@houat>
In-Reply-To: <20260402-burrowing-fine-bloodhound-afcebc@houat>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 19:02:34 +0530
X-Gm-Features: AQROBzBU7_o7IRQH6mzOKTP-KDFv7IkPoqq1yaLRTD3AfvGaKguQAkczWk5rypY
Message-ID: <CAO_48GHzMpKHQxmS9ADd_Z9G56uWOPfJ-qhNek7ubgkk_yjGDg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, 
 Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
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

Hi Maxime,

On Thu, 2 Apr 2026 at 18:42, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Apr 02, 2026 at 10:36:48AM +0530, Sumit Semwal wrote:
> > Hello Maxime,
> >
> > On Tue, 31 Mar 2026 at 18:24, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > >
> > > On 31.03.2026 12:00, Maxime Ripard wrote:
> > > > The recent introduction of heaps in the optee driver [1] made possible
> > > > the creation of heaps as modules.
> > > >
> > > > It's generally a good idea if possible, including for the already
> > > > existing system and CMA heaps.
> > > >
> > > > The system one is pretty trivial, the CMA one is a bit more involved,
> > > > especially since we have a call from kernel/dma/contiguous.c to the CMA
> > > > heap code. This was solved by turning the logic around and making the
> > > > CMA heap call into the contiguous DMA code.
> > > >
> > > > Let me know what you think,
> > > > Maxime
> > > >
> > > > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/
> > > >
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >
> > Thank you for this patch series; now that it is needed by more folks,
> > I think we can merge this.
> >
> > Marek, I'll coordinate with you on this - thank you!
>
> If Marek plans on sending it during the next merge window, maybe the
> best thing to do for us is just to wait for -rc1 and apply the rest of
> the patches. Otherwise, we can merge the branch in drm-misc.

We could do that. Are we ok to wait till -rc1?
>
> Maxime

Best,
Sumit
