Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D5FEDA1A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1AB10E1B3;
	Tue, 17 Mar 2026 19:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/o80Yno";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174E010E1B3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:41:39 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-128edc72f3eso436008c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776498; cv=none;
 d=google.com; s=arc-20240605;
 b=guIB83ArV48pLPPl96sQOMcvc5YXL5PARa0kEbJrzqgX6wBiy4E+X/KA3l5cMrePO3
 yCU2XkWmSEoERtMT0QfKQFNXgmrUQHBUhCjOxUadobLGKhcO4G+qGfuhYZKNzY3dCoeD
 68MNDcOZe7PM6EjkZutMV8AB/Y4lcKY/07VSwjheocj+kFdaLH5P2SMS8ddMi8yW1HHm
 TovGNsP+3NkD1LOkTlzgg3sW2gmZDTzgpEfOkZ/ZvmGtVq6DJDETnm1JPIGMvWuzQiuX
 jR77Sa8y8Er++Y9iQBb70YZRokMLybIb8/ISm5sPdSzRsddsD/ysrN19zWVXx6Wyxlff
 8JQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wlFA6oh9h2Uqk0U3FytL3VE7dGDdOrHtz15OKY6zjA8=;
 fh=yS6SJr4N4vod5FcYD5x82QExKWewNh1HadNWudNXNK4=;
 b=dN97qQ/ozw3rCA+WXvqgMsHAP3x7NUsvJnh8VG0Swrp4+7AJNTgcXJekTXE8aTMJmj
 QAy2EhL+6pTSXhfvCbgTl6+GqScvK0B/rL0o0IXK52TE5Y/jpwhmqg/YO2ft+OxKf/0G
 WhAjGlPEUChJrfnwZ5rQCEgUnRCb1dxyKXllbR+Pw/gWEs8wpGPxsqxuHuakMXUc/tYi
 oMfiY0tD3cspYYfGkfDsQ9LP4EYTX8fOT0k60n7p6lMEWFpNZICUNMukjLF0OE5b2AEr
 kf8xdO6VS1OTOEWukwrGAtoisnIdeIHBuzMS4yR+CXsRIjNxjSwJmrqKN3h/OG+Rm7Gk
 n46g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773776498; x=1774381298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlFA6oh9h2Uqk0U3FytL3VE7dGDdOrHtz15OKY6zjA8=;
 b=C/o80YnoVsKEcghoy3LfrSG48rHjFCA1DRi02BzMgMRuw3YrRfPj/LIt9WlUrHtJVc
 JHzYzjD+Agrn/akzS3eBqn4rEqQvwK5Xy+I4Q3afh8W5eGKPD+74OiSbzfopb1g7/Gb9
 PxMgcGXezJtx5PYPSXTQKJE0g2ByxOItDN37uQTrGwUCiRX5kRYqDM0Hlz1haVkKwOds
 NEcPTRf9ZXmikk1x6chX55gYHZAiMgPiZ7cz7GVCZQRTw2847mm63TLmsj6gC4f8dtPW
 Q8adLeepG5of7y8qtj7aKY4gVSekLg6Z/hRRjyppB3HYEbbbfbHYk0c5Eljmozuqnhga
 HzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776498; x=1774381298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wlFA6oh9h2Uqk0U3FytL3VE7dGDdOrHtz15OKY6zjA8=;
 b=Lnh561ZU5ljoPvxYqsJo4gvEEJ7zBIHD+e8Wn8VUPlT5q7lguP1HgCFI1ayX6XWP1y
 eNitcZaBguXpbUmFmHtsfmos2Izt2MGn1uwuzP5fCoPm8FYFxO68bwtnaQpMKDyRJcVW
 oOZVuI1/Zo98RPnUQaraQYMkNv/pl6oD8Vd7QsIxrHIbxVlLMDhAKMWuVmpLEIJvebGr
 4Bbg1g8KCpjEOpPZjT5wdbc1F3OMjT9+GsxpUWX0GMoJLXz9df05Bahn5ln8cYPZSQ8I
 NU2U0gQ1XolXhxQS83TcvDbe6h2w7mS5AsRYUhZNs08qgoanrhjkH7T6w8G8+LUm9NYL
 3n7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnLgUJWvVK1lPGuRQp+giqmmmIZUImifWlHk/cxIV8B38qJlyR4YiRFpOT/a5oTtJuA6IW7+PYxDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM64lz0Dfk001LkyNont6R2WKFEfwNr2tLL3S2LsoRF7qzGiVn
 j3z8nn7U6t6FY8a04NxTz/6WWqHjSOsfEuwHOv+w1O0Tekr1XFFjuVL9MIOunfrpS0gTG/0lqzT
 NbH0Un/vUZdW2bbSndvnBQjkO88mSk9U=
X-Gm-Gg: ATEYQzzHNWdn+ovI1aAGdotAuwN4Uw/mg+pCY/hfHoNQb3gO20Ld9V2gWxRdFDIszlF
 /oga2u1Bx5fJSCJ8LHbQMk9pI7nrGWRBX7Kq60CYb0wSL+a9G2h9tG0naYsnlVAS2ca9wHRZH3J
 FU6sZHQwB6p7kW2IgS+Rnulu8PMOvSit+DHuU7hbbq/HATStIwAFOkK7tPgHybIthWpH6JkRbtD
 zK/6BCGxcCRza+SXRSBy8t6lUtuySdUmxQBWHslLAZ1PhGQxs0LdkNqCRB5/fSEDZjLF0JpAidj
 vwibUiuCH8ZRa8VNk5w+Q2MCfrz3o0nDpxJRCQMO8NGv0cNf67riWrY7a5wntnBQbgk3/2FxTGS
 IjSI0rxBBo/kndDYlYEbfEAE=
X-Received: by 2002:a05:7300:dc8f:b0:2be:687:5dbc with SMTP id
 5a478bee46e88-2c0e5267586mr145307eec.6.1773776498156; Tue, 17 Mar 2026
 12:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
 <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
In-Reply-To: <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Mar 2026 20:41:24 +0100
X-Gm-Features: AaiRm53yINyatDJ_WJZjRpETpmBvLRs2cRRQIisdD6TKDINCtuP52WidZCuGK0o
Message-ID: <CANiq72=gHArzFS=SkiZyPpEfSL+0AcU3ifKRnwfEyet42662PA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Stone <daniels@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, shashanks@nvidia.com, jajones@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>
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

On Tue, Mar 17, 2026 at 9:27=E2=80=AFAM Matthew Brost <matthew.brost@intel.=
com> wrote:
>
> I hate cut off in thteads.
>
> I get it =E2=80=94 you=E2=80=99re a Rust zealot.

Cut off? Zealot?

Look, I got the email in my inbox, so I skimmed it to understand why I
got it and why the Rust list was Cc'd. I happened to notice your
(quite surprising) claims about Rust, so I decided to reply to a
couple of those, since I proposed Rust for the kernel.

How is that a cut off and how does that make a maintainer a zealot?

Anyway, my understanding is that we agreed that the cleanup attribute
in C doesn't enforce much of anything. We also agreed that it is
important to think about ownership and lifetimes and to enforce the
rules and to be disciplined. All good so far.

Now, what I said is simply that Rust fundamentally improves the
situation -- C "RAII" not doing so is not comparable. For instance,
that statically enforcing things is a meaningful improvement over
runtime approaches (which generally require to trigger an issue, and
which in some cases are not suitable for production settings).

Really, I just said Rust would help with things you already stated you
care about. And nobody claims "Rust solves everything" as you stated.
So I don't see zealots here, and insulting others doesn't help your
argument.

Cheers,
Miguel
