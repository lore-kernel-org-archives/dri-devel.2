Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97602CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF05810E07C;
	Wed, 17 Jun 2026 15:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Mo5VQEpi";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0479010E07C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:30:05 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36dd65b95f2so832167a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781710204; cv=none;
 d=google.com; s=arc-20240605;
 b=Vt70PTo1qnEz22QS+mBsHZ3q9MwMmuVe4MEw61ggbDfvF5fDx5J/gy/5Noktzto7R/
 BCgFGu93W0oRnneW+FfHLg43EmWv2mLkJTtb6YPIqV0mNxxfJxrZc+bQs+MG8jgpDCA1
 9YfSXzSQaMPLokqpT2UXAhL5jsLGakxDD4Y5V3DLMvmQnM5pGq70oJuRWmYFIw8BMw/j
 DSJrujHZkatLUFnExsWqJOSRohIVoFafMtH4Pz+piYmNeZ3cG5R8j9qNgm4cRIvzpKgn
 PRx0jIFRYdJnS2q0ReAICC/QXNOypT+Tkz8UYbECZwjNHfzjGrMWCjOKQrgRx09+vVGX
 DUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KnIqpH6OGDbGzTcOq8kvIxcRXrOB9Mrj3jiIKAa9ZIc=;
 fh=5d8RXmioaF/Um8ewvldC6vEv31r1Silvt0yjThseSQ8=;
 b=ANcELCththyXbeOhxGgrVBNh5qzR8llIWJFoDg8dZ+2P9/wi0/ybF9m1X/RAXMxUQ+
 39cgYVppcgW6VCQsbfvQ1JkYOes1NcLwxm2Olle9tK48ylJ186rp2o84r+LXemuB8xe4
 rIHqMCT4ZmBTnrMeeVO47eTQRkHRra6l3BLV+91kmblaYAQOhtK2Q8s/EiIT661YMK9v
 rZaeBSRCjXwnafrlNuGYrWa7QGefHAXrqhZTaOReeKAzlDxflgDhokbLktX2wU9tn5y7
 Y9uK9sWvRXGUfslliHwjzXkzEgD9i1P/hkFnfe+tjagemnCcPJu4MeN21NgRoSBU/SzM
 24Qg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781710204; x=1782315004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnIqpH6OGDbGzTcOq8kvIxcRXrOB9Mrj3jiIKAa9ZIc=;
 b=Mo5VQEpi+CsifVV00yvvlp3ffycjEEMz7akKXtK/jYZU7mGKfo3lNlVHS/gj/p0guN
 aj88VrfqmN340go/rHV67yrG87bmzRU1tkbOmPGjuiVcGd9E5Xv1AAeKWcEOjDmdclgv
 FgQFkkd5k/eHJ6qw9o3vCh0gir0ELf0gvy9cRtQ+J+OlC19x8iXqDBPpe8m9O0fSA5Xc
 r1Efw9eNhHWao8cHdu0nU6sgfgiuQNzNPK75ucwZ+2ti1aAbCyygvO7HkRYBf/Vdmx8m
 4ju/ZLO294ZuTwWafGvpKp2rHsoAwdHGXnnzeYQ9PuEb8D0ZMLFFLbSo1IcgA3bFNdFp
 e9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781710204; x=1782315004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnIqpH6OGDbGzTcOq8kvIxcRXrOB9Mrj3jiIKAa9ZIc=;
 b=fwJiBusVXpLhuiotbESePKybLWWrfi4eKZ9rg473b6NcjfXY8483ZbzMCEuWHcPXUT
 pqFCVYzJ0FZQldNhg1NU4n9FoMB2PD60D7YVqIOVNrNeboTFA3gJ8rokwhwfNpQuK+ZT
 zb0Y8xttRqu5ezqcYGQBpvRWjet/J0pqR7kPShc2gc7HAQKHiWURAagX90qLCdBwK6GW
 Ct5mxWNUDkOTEUHgu/1J+MVqE2v1xIgqQf4wR/Q7Um1mKQ39jy30zpNquUssXq3jojtk
 mARYr8/resIYx5CWkHp6s5IxyItEUo4cV1bfh3DoktoyVTih6il/NKegSCz+P1aIBC8v
 WwCA==
X-Gm-Message-State: AOJu0YyYGPSkxIcX5P4iE1bgXPSY5e32wnhVPMl9nbh+LPPwB6TjOKSC
 SabrAL+Y4RL2tHrXjLHJMR/NnUY55mG6ZYBfqFXsukGWw/IPwfHF3CxDO4KqLZacZE0TzEAnLJn
 UAlbN4tywxa3kPspkclynrn862ehv+/DHeeyb7CR4
X-Gm-Gg: AfdE7cmzkuTXF951+edHOK8nV690jYo1M0s/HeIiJbqBXd03Uz02xOQh5jqG9ZYTHFh
 x4jaTl41f40y43E2BZkPMus/UBPFCgVGwgipIlVfWiboS/4UIYz9nbBUkqr7ze1u3bOuTCCKfOm
 DSq6pxcem/ydTNJRCUBrJV9hrervBUFpWyhphchqsg5nq7k8YXHxbbEYd9++dvfH+Y7b4sG9K65
 425CTmmaashumrh3INsITJKvUc4EnUO+X7OIUmJD6qaPYiihzyT+dMYBK2lfUPBSb0xCyNAtaW2
 Dy7lHe3QuMqp20JOqWgzLfJ9lMIB1g==
X-Received: by 2002:a17:90b:3909:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-37ca685fb0emr2389867a91.4.1781710204524; Wed, 17 Jun 2026
 08:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <CANiq72=PBnUkJ6yGk-CiiR7972=oHTfv0ebw0EfRchVarwoEGw@mail.gmail.com>
In-Reply-To: <CANiq72=PBnUkJ6yGk-CiiR7972=oHTfv0ebw0EfRchVarwoEGw@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 17 Jun 2026 16:29:52 +0100
X-Gm-Features: AVVi8CdeYzV3lBLgNE1TxBP0vqCOSBnyeHYWBHRALq7HsVMP4IbnAjMBNhkfV44
Message-ID: <CAHbf0-G1ESvxMTYG9+a3rnwvoD5d1yCJGSBeYmOTQ7-X5PS2cQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] rust: drm: minimal KMS bindings, EDID read,
 rotation, HDCP defs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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

On Wed, 17 Jun 2026 at 16:11, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Mike,
>
> A few questions on the cover letter that may give context to
> readers... (for this and the other series you just sent)
>

Thanks for taking a look

> On Wed, Jun 17, 2026 at 5:02=E2=80=AFPM Mike Lothian <mike@fireburn.co.uk=
> wrote:
> >
> > It is deliberately an RFC and interim: it does NOT add safe Rust KMS
> > abstractions (CRTC/plane/connector wrappers - an active upstream effort=
),
> > only the raw binding surface plus the trait/visibility tweaks a driver
> > needs to call the C helpers itself.
>
> Do you mean this is not meant to go upstream?
>
> Or do you actually want to land this interim state? If so, then it
> needs to be well-justified why we would want to make this exception.

I'm aiming for this to go upstream, I'm a bit stuck though so I've
posted what I've got so far

> > drm::Device::as_raw() is made pub as a documented temporary escape hatc=
h
> > for calling the C KMS helpers until safe wrappers exist. That is the pa=
rt
> > most likely to draw objections, so it is split into its own patch (3/3)=
:
> > the feature flags and header bindings in 1/3 and 2/3 are useful on thei=
r
> > own and can land even if the escape hatch is reworked or dropped (e.g.
> > replaced by narrow per-helper safe wrappers).
>
> Yeah... this sort of escape hatches aren't great. What is the reason
> for not directly working on safe abstractions?
>

If you're happy to give guidance I'll work on safe abstractions

> > Factored out of an out-of-tree in-kernel Rust DisplayLink DL3 dock driv=
er
> > that drives a virtual connector and reads the dock's downstream EDID; b=
ut
> > the bindings are generic (the same path simpledrm/gud/udl use).
> > Compile-tested in-tree against drm-next.
>
> What is the use case? It is an out-of-tree driver? If so, the
> maintainers may not be able to take the code unless there is an actual
> user in-tree.
>
> Or is this driver expected to land upstream? Do you have a link to the
> source code?

Its going to be a complete driver, but I've banging my head against a
wall with the bring up

The project info is at:

https://github.com/FireBurn/vino-scripts
https://github.com/FireBurn/linux/tree/vino
and also at
https://gitlab.freedesktop.org/FireBurn/linux/-/tree/vino

I've posted these RFCs so make sure I'm going in the right direction
and haven't missed something stupid that's stopping bring up

> Thanks!
>
> Cheers,
> Miguel
