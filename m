Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261DCCD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 01:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A7E10E038;
	Tue,  9 Jun 2026 01:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pAk1VsCG";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4BF10E038
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 01:55:07 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-68cb445dd5cso33628a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 18:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780970106; cv=none;
 d=google.com; s=arc-20240605;
 b=j/0zKj9xiKI4QSkW+A1njMXW7q4aBkzZUn4vtXVxhZc34WgEwdEDPE0Ff54dXnJQJQ
 oj4CAGG083w5AH7a5yNSdl+NTepjlAJaTDL3tc7rosBf2YCErCfBngydcyOJ0aGChasg
 U9OEtI9howf04UFHkMxV0sm5GUPvpvT22Gv28/DLlt0nu7vzNU4JaBS8cA7JB6choKCI
 2xgUZ+wnQ8HUINSyvsLWIXP8dnYdhQvASRYLuQYYG18j2l/WVTaZRASPYPRBDJmfrIm4
 b71iTQhe6IucsLawjjTc64JNHnWje10tXBC7Fm2qIhPoGvW49X3SQ2yGC9j8FlaSVyu2
 g3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d1Ufgws2QqgBrUSlA0IAeB1pShHP1a3QKfGqElkINXM=;
 fh=koS9XpSGivovc/xmZxGAK4mTZwKRJB1IPcqosn0TkIQ=;
 b=Sxswm2sJM0yzkYJwzAzQLcSCbYvH4CTRCdpftMb89IOkxFxHcdNRGJExJNIAw5vCxA
 aCokqEaEpZwHAksS9KnEGZeWfjMPXGN9CYdHwpid+7OvVBQtbTeU1mrZS1aFgkrfelon
 QBrfB8+lHg0dvfxEFEUyxxz91Q486f1slFCs0RSFnWCufSBIlaw/dlVSrpb60qtWrhlI
 VmHpFyMWSa9CrkwsLvIDQ7A0k4ruMHBvQ1CT3GuA5HOeRvfE7WNt3mXPhh89v6CTq0Z4
 y1aa1t6iGtsqhE8g3vsprCI6TiqwypzdtFowoX2FaXxaMVJNxhjKL3vIfsIBVYj7d4/G
 JeQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780970106; x=1781574906;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1Ufgws2QqgBrUSlA0IAeB1pShHP1a3QKfGqElkINXM=;
 b=pAk1VsCG+8gNkjoFicVoDt8OCmtnxfcOBDnWtDsc4d99JRK/VhWSede9maosmdwiVI
 wtdZrvMktwB5LXfSWkZlUlhlpiIF4J2/EWHw/IF5zKQDmTjO3PLiQbBc7pVJoQ5b3xzZ
 8VfUhtm1WDO6/zA0Y+8HdlMu0qFzbGp5wG6+vIxHEMSg9oyfO9DO9iDd4tJO68APSvM6
 O1PhO9pXhv+5X6KDEOo9tpSmQg2hpgbflaEpNsGiAq2Ar91LvOi3GCIZfau7VhoXoNd0
 +ljdzHCz9ORZN2apM6cd2yJBtr8SHLKTZlJ4sWMXYi4Vwa51etoE8klUh7Qq2uSe8Rb2
 hE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780970106; x=1781574906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1Ufgws2QqgBrUSlA0IAeB1pShHP1a3QKfGqElkINXM=;
 b=UezL0mBPsM0i+cuUssWm/0mMKa668rP2Rt9aWnPyCLTkc0PjAeQMPSb0B4l31GlKkt
 pbFiwOG6kd/n4EKT1hRTLmyovY1M3/1wdD6H4xw04fKWYBy3tbpBaK86KqengGd48rYF
 IR+k8AhRvwtOM67WfxjwXcqCb+aPkQO3m7p0ObLnZXcYXc8ktu6YuBD+ljoH3rvnci7V
 ms+oF+a+il06npLwdTQJEiuewhA7sf3i3wkhirO0Y/Qp3Iqa/q8XaHZOIAe9tmFuVR3d
 knGcSoSTrC8HAxIwGwTIO6Ngc22i69zFHkdhtv1WOSEphFOTwdLeC5+8p76ulUgcCokk
 7x3A==
X-Gm-Message-State: AOJu0YwPI+iUMV5aSoH/0qNUA3POdO7tsPFibDgu4ogU0nQXehn6Tpyp
 R7P6q2PMw1FQYwFzKkXCJy45F2XDSH1IJSB5S4wFKZBVCEzgGIURMSLpvOu3N7rfHbuRI7Rzfm3
 wUbCNoWP+h5b45/guN9GL94wGIwHeWFOInKuQm6qU
X-Gm-Gg: Acq92OHi7Wy8ZbgQk5N24BCTUoNgKnf1kN7G+CsSv5iJ8J2kg9P2gyYx7Mav3qXpZ5Z
 FmibUKFkShdjou5dB6a2sPsnCsCJmZQQKIINZyljlh5MwMXqe0OcBpeontc665bTGaaTrx5VIKx
 nGNHwFzVaLYjrtgSE+06YXxlRV0ussI7NrxelPVGJzrB0YPwCIlRlSaYPQw8dWJ0DBB/RqCoLkr
 chkKi2R6yP99BJmdVeA2Cg7/+VMkcDBlGn/fwjOYVhTsHQQt9jRqlHfbrt5m1nnB0NG/zPlswTt
 pJ6WrxbSTlgH3ao=
X-Received: by 2002:aa7:c908:0:b0:691:ae72:f443 with SMTP id
 4fb4d7f45d1cf-691ae730014mr72827a12.4.1780970105573; Mon, 08 Jun 2026
 18:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260609003256.1829625-4-samitolvanen@google.com>
 <20260609003256.1829625-6-samitolvanen@google.com>
In-Reply-To: <20260609003256.1829625-6-samitolvanen@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 8 Jun 2026 18:54:28 -0700
X-Gm-Features: AVVi8CdUHB5-wdt2Latvkt_2ytBWf4LV-lEVGr_fPw-ajdP5XPKxf5Djku4m0VA
Message-ID: <CABCJKucVW-FF2sti9gVoKkp-StLMof7kSqisbmUvjyEAaKLuTw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: drm: gpuvm: require Send and Sync for
 GpuVm's shared data
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Asahi Lina <lina+kernel@asahilina.net>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
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

On Mon, Jun 8, 2026 at 5:33=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> GpuVm implements Send and Sync unconditionally, but it shares and drops
> T::VmBoData and T::Object across threads: obtain() can return ARefs to
> the same bo on several threads, and deferred_cleanup() drops them on
> whichever thread calls it. This is unsound unless both are Send + Sync,
> so bound both impls accordingly.

Sashiko keeps finding more issues here. For the benefit of those not
subscribed to dri-devel:

> This is a pre-existing issue, but does GpuVm also need Send + Sync bounds
> for T::VaData here?
>
> Since GpuVm<T> explicitly bypasses the lack of Send on VaData,
> UniqueRefGpuVm<T> automatically derives Send. This allows safe code to ma=
p
> a VA containing !Send data on one thread, send the UniqueRefGpuVm<T> to
> another thread, and unmap the VA there.
>
> Unmapping via sm_unmap() returns a GpuVaRemoved<T> which drops the !Send
> VaData on the wrong thread, potentially causing data races.

Looking at the code, UniqueRefGpuVm seems like a better place for this
than GpuVm. However, before I go add another patch to the series, I
wonder if it would make more sense to just add these bounds to the
DriverGpuVm trait instead? I'd be happy to hear some non-AI thoughts
about this too.

Sami
