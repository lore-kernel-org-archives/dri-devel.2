Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548EBCA5FF5
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F7F10E1C3;
	Mon,  5 Oct 2026 22:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="bUgjn8iQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7AE10E1C3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 22:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791240584; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RcYwHBqWZ15+iEM5RiLujJWlBVELidKGw3sXMC7t+M++X2uQrORaKDeMANPrDRgOUzqGwdvZ2LXrS6sbVTjixCizJQhRQPOg+knfzdeYUJY9rUbfaatXMqDQTiJVJdiNstACQi10AfLRSIzl7bLm+yPtA6unytDlAVqg4PxtSmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791240584;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KbgkUmImB3gJ/Dbx30iIP/KkThXAz28Dg0j80jo2Deg=; 
 b=QbUumb3KsAzMa3CmAT8aLJjkUct5suvA7HAwx9JQBkyRe1gxKCEvuqXb49CB9H6YIOT75yskmpfo7t3bh+Ra5yX82rvacZYBr7YHzrdhBLlN+xNBVWrvj7WmyaFWewe6+ktDx4aTM3uuwFhVT1hN/Lo/5lipo1Gy8qwVW2ISZOc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791240584; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=KbgkUmImB3gJ/Dbx30iIP/KkThXAz28Dg0j80jo2Deg=;
 b=bUgjn8iQ8aiQnhTY/6FCDgwrnStJJnQWpl8dzBNrDiRZiDet0FTyXsae2FDVlIAG
 g9JmI4Jpy1+VLvzYb61B/JkLNPNiqFAgWi1EKTuGttaxyCEmeKnbq6ZY84M1j/QYljW
 /cdmwbSGqw1fNj2m58CbStEp+/aV5PylejjN0fZQ=
Received: by smtp.zohomail.com with SMTPS id 179124058317319.807065784842052; 
 Mon, 5 Oct 2026 15:49:43 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:49:42 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
Message-ID: <asQphgGWe9KmQa5r@um790>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
 <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
 <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
 <DLPKN532X7JJ.14Z51ZIBUIK94@kernel.org>
 <DLPNFF0JNNOQ.14JE7RL8LT79Q@garyguo.net>
 <CANiq72kvkAWmJEgOathMVwuXFzUURK1dVN=OWmczykVWpSTv6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kvkAWmJEgOathMVwuXFzUURK1dVN=OWmczykVWpSTv6A@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.236.60
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

On Sun, Sep 27, 2026 at 02:08:36AM +0200, Miguel Ojeda wrote:
> On Sun, Sep 27, 2026 at 1:49 AM Gary Guo <gary@garyguo.net> wrote:
> >
> > I think the skip-on-error default was added in a version newer than what we've
> > vendored.
> 
> I was going to update, so that shouldn't be a big problem.
> 

The skip_on_error() method is available in the kernel’s vendored copy of zerocopy-derive
v0.8.54 and it doesn’t change in the latest version so I don’t think that updating to
0.8.59 would help us here if that's what you mean?

The problem is that skip_on_error() has a small scope; it only skips errors when
generating the implementation blocks for these traits. (For example if it’s a binding
for an unsupported representation type.) Otherwise, zerocopy-derive will generate impl
blocks with trait bound requirements (e.g. on struct fields) which only fail later at
compile-time type checking.

For example, when I tried deriving most_traits for all of the generated structs I got
about 300 compile errors due to unions inside structs that did not implement KnownLayout
When I derived most_traits for unions as well, I got an error that deriving IntoBytes
for unions needs a special cfg to enable because its soundness is still under discussion.
  error: requires --cfg zerocopy_derive_union_into_bytes;
  please let us know you use this feature: https://github.com/google/zerocopy/discussions/1802

Also, I get about 200 compile errors complaining that KnownLayout can’t currently be
implemented for bindgen’s incomplete array field helper.

So I do think it’s reasonable to implement these traits using zerocopy-derive on a
case-by-case basis.

> Cheers,
> Miguel
