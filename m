Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A30ECD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B293010E4F0;
	Fri,  5 Jun 2026 08:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="srtREWDp";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5E210E4F3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:36:42 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304d2c56402so81510eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 01:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780648601; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKh8pQtIIss+PWy7c+NGrsxurCYlAbl80K9LTQYyE2zMYKSmpqzA+Tl/DNkNT4M7rz
 i3z4Lvf2/kK/qOYMHgrB63h1gPU1G7t5R4e8lrQrK4MZhRgM4gqK8yjmX7mHkQtpVPb+
 zhf9Ndz8XuGKsHODtxjZvexhoPtX7noyuOS+ZKeCFPYQMRO1/fvxzHxeuMyG3mjHI9C4
 yCeqOX4s6041p3hieIokvY1fSqBJwbZpTJq2bd3MMOPsK79D7eRVy6ECNbVNULw3q+kd
 kKCqcKvN6nWAV78rEIl1jCUs/MiLBEVlsu/j2ARpAkVHXIQscd5ovh/H1gGgrMa55Ddw
 Y+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSgvPmECu35Tw7MMm3j47U64E8vDrNkepG2EWMTevfs=;
 fh=ILLfuCloGUpXWP9WcRPzO4ooZ+NNTc0nDwOCh/PH0n4=;
 b=hBMdDAPrOC6xGjnIZ2TlFjNAS/Ye4r7g459hCFv8Wb/UdWCEFntS1gMH8T1AMkXsNQ
 /TodGPWdwUeT038hkWytb0OMdqqanez5YbzGOIW5rX+Vwj+IYFtRyPiphhm+sMoPbdsg
 V8/d/O6C+hKFlO+GGq4g3Sh+d534OMkccRvRkIvV8TuNfsBEEFJTef61dvDi5rxNeb3Y
 jYbB3EHYKQ+vLlni/xs764aRdHU/mbhSIrBRR7+E4h/nWjswNEEcd4pzbCkTwZoRdgZX
 WeEFJAynqXaE0KTYrcX7/H8J9hzejiSAfmqrsGbSorVS0QnDxZVlvE/djZcqOHyxr8Ls
 9cQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780648601; x=1781253401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSgvPmECu35Tw7MMm3j47U64E8vDrNkepG2EWMTevfs=;
 b=srtREWDpIPjuALo2OPc9HSd3lCrG0rlk0b3UKV8CDtBNb7HRyDbXEiDz4aglKwIcyG
 ZmwhgHauRaNSOfjdcb1G+vyBVGkJ8YcE6m1s2FQd/ljqzFLrDcscklB8Ex3MNDVtmMec
 DVZW7HTE+HK796wCG59MrVHHq75zPJZdO7ONIM30646rD4iXHqeNe0dxRlZX9OYW3fnz
 7rE31jP7/nilwJCpo+VzwlK8fiw8Z5SOQBATTe33TFLxf5vGVzQGkM9J/5Jv2vG9gqgZ
 nxtWYSzPdLfDo0YzNIJJE4Gt8oSI4rMMgNIwTZtjH1Xtn6ZfEJTZ46CNCrEZ84GYDo3t
 Sqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780648601; x=1781253401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSgvPmECu35Tw7MMm3j47U64E8vDrNkepG2EWMTevfs=;
 b=WyZp0xnDna1lDx5sGgVziHlN8KQqAdBdjzFd7PdxZsfI6DyTbhKRbprMlkXB+1DdH0
 fO6RhfuPUuhVStzUSKjPVCU+oYf6a4JtOVdkC4SYShJQF7o2aPIiaAaHfJCJR7nEOWSP
 Az00h2ICsdk8M5nMgNkK9UDIxB1OqBIPQqHLkEZMDKcZire4K+BMd6mzqFqlbNfHuZuH
 LI9+wpWxHaIuLcUUIagqqO87h6RLsEjTXdXpSh7zJDgRryq83Tie0WQe242YRbk8jINH
 ydnwJA4RFlTJEGkHjEXR2WD7HyHVs/OjTtqBuJquB/EHjG5u2RQ+Im9TOLcNR0cVxc1Y
 C4Lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FgzR065l4qTa1e8sIQp4CYUU2v1rfmTYmjHQVTP8t9nQ+3llEnvS3Kj8DQijXNX9eJeoRi/tvEMo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyks7btQ6arOpGZ8b971Qok27b9Z810i0iV0Sspp6EDm/0wnM+D
 ezwTA7YiTtRl0Tg9qYSNygq7ygUtpO7IBuqFOFzBEOjA5cU/BfV/jIj46TupP9yp1tNheYP392g
 9Jwz5LMU8vwOENznWjxXBT2sio1ObUyQ=
X-Gm-Gg: Acq92OE6QmRt9DRh0xvnXOFd9muIc28ukEVV45Ns7PPWzFhP1EqCU/WbwnBu0J36oGc
 tfa1CiScUYbvzBjHf8Sfg6s0F6G0845a09DBSvIjiFZKJJd/OEmGyhmidgzoK9cxkwbYIjqFzRX
 ME87W9iqDzghC9OVPLxgLuDSoiKdwrIjdB23YI7E6hpfUL7CMbX6H6fPFRn8MSDA2BFKOayQOPp
 8J88lV/H/YlfOpg0Yd2PwRKJqvPIlHyL7IPjOS6ZanYDETsMqMB90h3h7JJp7/0djF3MR6fwd9e
 e0tRnXAEtdUJYNCRLG8zSEFBpH8v24Q41XjUhq9mzUx1dma+gbXqyZapYPeLCrktiUrKpO+Etgk
 3GvR7FYMugJG8/0r71zWZJWjPSDVggnB+ig==
X-Received: by 2002:a05:7301:9f07:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-3077b5eabbfmr547169eec.5.1780648601370; Fri, 05 Jun 2026
 01:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
 <20260605-nova-exports-v4-4-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-4-e948c287407c@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 10:36:28 +0200
X-Gm-Features: AVVi8CcQyHZaxrVm9l3w8nQkPTRE7ixo9gqTVbYy1F9Fup8-NkOcmlFkT0pwkvM
Message-ID: <CANiq72mFouTJTKePtQsDONZr2H=JbAEZOuGO6LoK4EVCSvAFOw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] gpu: nova-core: emit Rust metadata for nova-drm
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jun 5, 2026 at 10:32=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> +libnova_core.rmeta

This should be already covered by our global `.gitignore`, unless I am
missing something subtle here.

Cheers,
Miguel
