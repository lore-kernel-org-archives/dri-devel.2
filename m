Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5961AC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 23:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC1A10E1B9;
	Mon, 10 Aug 2026 23:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vd0HOoBN";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DCC10E1B9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 23:55:06 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4994d67d260so14455e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786406104; cv=none;
 d=google.com; s=arc-20260327;
 b=f94/SjE1VhC2YsLM/LhfA0RidlKLjC0VeZBx8AAMtrUTvGskdKm3ZPR+jeO9/Y4brG
 a12DBAEoMQdNVhW1cRgBt6gjK4X46NtiLohf8x3LHyxXD2A2c7z/ViReuuXCTigy4i3/
 9TH8dkI+xAMnYJVnm1vLmPAE9+7DuyLI9JXyUbQcGBlKpIeJHrk99dP6rD0UvkCBXKTb
 wZkJ9+RLNlhbGUkypPWmyUHgRri1rY4F6Jm3Fb5cpb4zDQn/gwCFASAMeyuj3MTz+j21
 jGPEulC9EwHBpl1vDzb87dRUkSwSiPwKUhHne0nG0DgHDQ0viQ+3euYpe74IviGOT9KL
 Dz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
 fh=qcmYIuMfmkmV1qtw1226FM0SkrM8F6PP55FGUO1tZP0=;
 b=MX3RQI8klPUzti+S+a2Jw8A0DMaYvFdWY4vkiwlEjZ5BGkwLUFWC7Vl23F94CitKXD
 w3GhkrD0MiSta6PTs3NahHc3fUTQCdNL6niBf3HhzJGBJeytlo/3pEe1nwAASfXlKlX6
 HKg4KMGoQB7a6sPdgxzNDWdjEwshlm+LNgA2RMv78ZTOAWRL3KSTE7W/3BDHqEG+UB+f
 HDmEin/XUSJ7TFmAIvrCnac7m76ctDK+2cvXIJZXKFqDtSHNDqmInzMo/W+mXVnFUtpq
 JsrcZwoeLppj4uZfNoMfpfMcRhMLlvecBKfOd80BneeGYk8J8Wj2g8Us5IYSYGuKMWX0
 axJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786406104; x=1787010904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
 b=vd0HOoBNguVsiKVcdXNR0VSSqR0G12/R3vxR2ngWg5X90aZL4qOd5O3OVqHn8T0qQr
 e39YZtWSfnzRpwVX1mZl3wnUWc6HDW17sOCGodJIz4qcRHPxtJGUm9NSYd3poe9FeDuk
 /ksmB3LjCeOSFHQGUAf/2Pr1HEoReGJNXC/dBrgrssyGqp7qgS+avJZbfnxy6JJC9qbR
 mgfpASvZf1Ug2Y1bEKks2t5xm8UeOINV1jd5+WjAWij7Kf6h/lTIK89OtjaYvhNYZiBO
 lhsWQPzaIkYxtl7ZUD7a16ybImvt3sA2fw9U6BfOhBIflwNtFrggOo51l5xXO4VvSwnj
 DSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786406104; x=1787010904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
 b=Az2T8AJzXxnpHpPsY/rKpC7mWsysR+jDnakJbo6xp5UHXj8Ixzqkpqdnn8YRHfajoG
 nJVIzI9glAm7BW1XIJdf1R4gT3lORskTWTSPtNLxSCdqufpsI9Xiz/QYjwVbePiDZJGU
 wwc67yAG+MPJv14SE+VhDOrLWNHx75ID3Bgpbb68ly04kPsR1JQtBmgOCxTEucugluUU
 6Lc/GaOLNeZ4o0ORRWytdcMBD9dx1k0UVBp5DUGTlcXBYvTI47GTAEJrf2C/vEzTKIPZ
 JcO5ux1alHFYe+E2dYlxagNfd1lXi7PyxsoavCod942V7zO3RTg17xMiAxDNbR4YKe3B
 lFvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpE2RWkj1WX97TLgAol1rc9YamBTuazxrwrsvlxt788ompS/oZIcF9RcRZGTVrqUi3yD0cJpU+rXJY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSD6EmtfmzErIxItdXc7xfQXr66lf1b3Tg66upfVoLcaXgaDpI
 5Y+tCVNla+sfX5FEMQ3ys9JeVkIA8TGUQvo9DMcEF3VipP8jMprNkCokhhNvCbXFJszjMuT2uIC
 ybzGWlZqhPQ//J1DNh6WVezD3a65hEqiP6USfOBNr
X-Gm-Gg: AR+sD12ztxs9SZmxXEDXWxkwGF8MFb8PzFT+R47tuMCFbgWFDKTKrgQpb/4FEl5v3Nl
 eaZi/KEItKsrZzvlDJo8xB8QQOhERGq2glaGvT+/pNN3O4CWbWyS9cdg2jqj9ruyEl2svZQTce+
 JzcS94A4NqZ5U/ARwTKQmzoxISv2RiAyPng0HF7MYUn/U5FwALB7ITDUG74Mp2JLdtr7Vk8bOr1
 MZr0Q6GaFFa8ul50Ahr/S8y9lb5TU/xonD6fyqVF3zxxUuoOSERoLTGcR+g9sNc6mkGkLJGFD24
 klBj7P0L3JYApVibMXIItOdGvhM7edCnGdH5rrhu4F7aQGIvv4CgUN6302f0vNMMSxKQZyOhsuQ
 =
X-Received: by 2002:a05:600d:108:20b0:495:4593:616c with SMTP id
 5b1f17b1804b1-49975c21896mr314355e9.1.1786406103959; Mon, 10 Aug 2026
 16:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
 <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>
 <anSyU_-zArFch-an@orome>
In-Reply-To: <anSyU_-zArFch-an@orome>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 10 Aug 2026 16:54:51 -0700
X-Gm-Features: AUfX_mwf0uw3dVpzklPu-Nif3rg3tPQMirUP9IgK_6gn-zY2Jt3_SUQapkz0Yvg
Message-ID: <CABdmKX2Hn0cDw_aFW7Xr9v5mr=WvfhhTXgX7tpRaMMGstYp4=g@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
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

On Thu, Aug 6, 2026 at 9:21=E2=80=AFAM Thierry Reding <thierry.reding@kerne=
l.org> wrote:
>
> On Wed, Jul 08, 2026 at 04:49:31PM -0700, T.J. Mercier wrote:
> > On Wed, Jul 1, 2026 at 9:09=E2=80=AFAM Thierry Reding <thierry.reding@k=
ernel.org> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > There is no technical reason why there should be a limited number of =
CMA
> > > regions, so extract some code into helpers and use them to create ext=
ra
> > > functions (cma_create() and cma_free()) that allow creating and freei=
ng,
> > > respectively, CMA regions dynamically at runtime.
> > >
> > > The static array of CMA areas cannot be replaced by dynamically creat=
ed
> > > areas because for many of them, allocation must not fail and some cas=
es
> > > may need to initialize them before the slab allocator is even availab=
le.
> > > To account for this, keep these "early" areas in a separate list and
> > > track the dynamic areas in a separate list.
>
> Huh... going over this thread again I could've sworn that I had replied
> to this before, but I can't find any evidence of any reply.
>
> > Hi, It looks like you'll also need to update the CMA dma-buf heap's
> > add_cma_heaps init function so that it adds all the CMA areas, not
> > just the early ones.
>
> I would actually rather not do that. The case that we need this for is
> creating a special purpose dma-buf heap that's composed of multiple CMA
> areas. These areas must not be used by anyone else. Exposing these to
> the CMA dma-buf heap would allow anyone to allocate from individual
> chunks and throw off the accounting that we need to do in order to keep
> the protected memory from working correctly.
>
> Besides, given the dynamic nature of this means that the CMA dma-buf
> heap might already have probed when these dynamic CMA areas are added.
> So we would either need to have some way of notifying the CMA dma-buf
> heap of newly created areas or we might end up with an incomplete set
> of registered heaps.
>
> If you really insist, I could look into this, but I think it's actually
> a nice feature that the CMA dma-buf heap only registers these "early"
> areas and exposes them.
>
> Thierry

No problem, thanks for responding. I see there is now discussion about
subdividing a single CMA area for this, and that seems like it could
end up simpler in terms of the CMA code for this series. So I'm
supportive of that idea.
