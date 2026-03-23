Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE7AD58CB0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 00:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5417410E1B9;
	Mon, 23 Mar 2026 00:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DvA6/jeN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793C810E1B9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774224963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
 b=DvA6/jeN/F+bukrZilrk81irRXPAKgroaeLO0GH8WjfINB4OzLtMUt/YNewBacu1Bn0+yS
 effV/p+VO2AZ5tq+kAA7cpobvT+lBYa2hkQp0Kgd9dCrceqfBxuKFrAuHT9+q8ls7B256z
 qYCYomjr0ca6prESYeLw4x/hjNtwJbo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-MooOVAAXMp-xUtiq8D4Rjw-1; Sun, 22 Mar 2026 20:16:02 -0400
X-MC-Unique: MooOVAAXMp-xUtiq8D4Rjw-1
X-Mimecast-MFC-AGG-ID: MooOVAAXMp-xUtiq8D4Rjw_1774224960
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b9399d68111so278636666b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 17:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774224960; x=1774829760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
 b=luVvMOeKzMTDHxkU4PWWBWQkbaZTotY7ijucyV1dBSB/jBgefWMxgg3FLvh5pSxj84
 BktqqezZh9uz6nq7LH6tk79MNiGx6YfCUAGlD/lBPK9xnMJsR4hyDphLkhzayCgIdtT1
 keX4Bvo7XkRytofFGz+dPVCUKy+f/8vnfgmp0cqEDbzq5n4xCOYAVzLOvgFC+atVOi0U
 mroQNW5uvsfwkORTrVyatv9fwvZ+nPc/EFBmrLTaS9PvuBj6S8oNYiCR4tWm/JG+3Vi6
 YyKu2VDeIfAto2znO3RXmP0dczDho+2A1edvTJWVT0eSxrpCjC/BidheYRFYmgz7NM2Z
 Qs2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnHNLQkgqqlm70nye6up1R19FHAkzDtL5clWFOD+NFm9TLt6toVbN44LbFp7Id80EoWrLPCl35/aQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKGfptI/mIqSDM924b+Eg9VesYmBHn2uhawdYu3W6qk3xcdm/Y
 7dPDg59eawW+kxowkgWbYOUU6NjJyW2buE8F3Z4QlfBjarcdLdyU52mSre1pjZg91fvFSKviSyq
 IGpsWjrsd/z8tV+ndldujrsBZZm8EtxnbW500Hj1vwCVuK7OzsSgy429V5HOnV+Yf9LVRVE7wbB
 +lLyFRuIqOGyAK0mlfYF5T1Uz6PF4Has1PENCHrv7b6j02
X-Gm-Gg: ATEYQzyzZ9Qdctm8rZeIJ717qpuy7INv367HzoXHuaK8pfFCmjlpGUFP6bKj1hpd0uO
 91jTSnChw5sFJwCQLtlhVBGI3bwCXVpo/18gjjLnLc7kCFiFtZKTNxOOI/RPMYWiqlujTeym5GQ
 IsJv6jKsJ/AwoWtLQGwTERnPX53uFcxFd+c9j/gjWxpV4ZCj/V1MClGiRJ3yxbpWTdEMyW2qO3K
 BXhtA==
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-b9832c15bb8mr715930466b.8.1774224960422; 
 Sun, 22 Mar 2026 17:16:00 -0700 (PDT)
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-b9832c15bb8mr715927066b.8.1774224959860; Sun, 22 Mar 2026
 17:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
In-Reply-To: <20260321-awesome-hot-kingfisher-5d9f55@houat>
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 22 Mar 2026 20:15:48 -0400
X-Gm-Features: AQROBzAoTifV84Es4roNHZ7fg_jcFEWRuoYT-h9cCD6210iyG8-nf7F7j1kSz9A
Message-ID: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zF68DGmIKo1o0stlIJvaYUyjTq7hYs5anq9T5SP6pBU_1774224960
X-Mimecast-Originator: redhat.com
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

Hi Danilo and Alice,

On Sat, Mar 21, 2026 at 2:17=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Fri, Mar 20, 2026 at 12:43:47PM +0100, Danilo Krummrich wrote:
> > On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> > > The Clk type is thread-safe, so let's mark it as thread-safe in the t=
ype
> > > system. This lets us get rid of hacks in drivers.
> > >
> > > For Stephen's clk tree.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > Changes in v5:
> > > - Rebase on v7.0-rc1.
> > > - Pick up Reviewed-by tags.
> > > - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-7=
12bc7d94a79@google.com
> > >
> > > Changes in v4:
> > > - Pick up Reviewed-by tags.
> > > - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e=
48b2e2f1eac@google.com
> > >
> > > Changes in v3:
> > > - Rebase on v6.19-rc1.
> > > - Pick up tags.
> > > - Add fix for pwm driver as well.
> > > - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-4=
4ab533ae084@google.com
> > >
> > > Changes in v2:
> > > - Rebase on v6.18-rc1.
> > > - Add patch to tyr driver.
> > > - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-4=
8d023320eb8@google.com
> >
> > Alice has resent this over the past three cycles, but it hasn't been pi=
cked up
> > yet. Please let me know if there are any concerns -- otherwise, I plan =
to take
> > it through the drm-rust tree in a few days.
>
> Stephen hasn't really been active lately, but Brian (in Cc) has been
> trying to pick up the patches falling through the cracks. It looks like
> such a candidate to me.

I'm planning to send another clk pull at the end of this week and I'll
include this series.

Brian

