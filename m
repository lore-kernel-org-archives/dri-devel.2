Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F552606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W13DNdms
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54BD10E100;
	Sun,  8 Nov 2026 06:22:08 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BD810E100
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 06:22:02 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b571a45a2aso224a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 22:22:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794118920; cv=none;
 d=google.com; s=arc-20260327;
 b=aJxlKqnMvbHeEHaEkwx/mhEKX3BtibJjGlccqnNx032CYYL8QYS5+ZLiWxxhkGJ6MG
 AORMCgR/GvZFwNCAu05lctVO7Z2ax56vH2A7xILprDYuh+d9+YidwJOYa91j4+wO+aCC
 CrVva49cWvSLvfh2hKNWuQXN5+uz4cQy5ZVlDqaCM5ToVnOJ/xLA1FB0GeDggJypv9vQ
 3gCX9ODNsVmkKmNI1iximqhr3CLyogjnUOmmHa9yfcKwleWItuxi2FiL6BpdRF74ZVWB
 QBungLwvBd4k85+cuRbeKP+9xXaGN3O1orffx8wgMFY/WNHmFo36yY0RoNlSHWjEpvIZ
 C4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
 fh=+Gd8MexmEO/Zs0bXhuXJaMkn0rLQSxM7Fl+wpBJdLWM=;
 b=S1Z2f52vGlGf//wpEDEqDVocoXwXAY/x3ZqJBYPSHfed+MZviUMLUugLGDSTy4YnFL
 XH3iaBmcOsvj9jH8OH4Xx84o19xConKTwbQJMrE7sszjWeyn76FoJJSv78W2Zmu9S29v
 dQ+CF9KTk4xjNDdVBJKsPwUZY0IFBKG90vVqlfGj71HGSh+uFzVukuswmw61IdQL5JSV
 q20GCcMhRltBKaOI6Z8Uxr0NjIR4IiQbBdTYibfQy4tflT3QaGR4AlVATjFLLLIUZD3X
 yeIu7cP2V56vzB854Pewp/2rGRJ06dLVnbnioGorshUZljf3cMwgeAOwGKJLEpZb+K+C
 bisA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794118920; x=1794723720;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
 b=W13DNdmsnqegxSDes2ggcetn056WJvMtprRPJv/4UmQBqdRwHIWsX1VCxgn0JDfIHm
 oeN/eoytN+CaUlQuFPZCJobnQdOEnq/5ZocbZq6go3iHbcUceiconM31pUF3am/H6caD
 fbD9EhOYGDsC+uyWPPPufYcJ2fuh5wnTKD9mPe2A22kQ+uNGSGPL+m+iL/EW/6awZcv4
 fFECKsq4TuSIL9ahV6pnnCZ7l2VkbopcokP4mVhXurcKyQWSHi+rJPfgiY6Qouzx15HM
 JTexJu6x640e0WxCTPnv4qFxFh0L/hIK6VKZfLl9D6Tha13Jj7bt6KOMgOCaEWAWPpnA
 k23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794118920; x=1794723720;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
 b=AHpU9Gd+AEL/2aQmMCfsJSlx7amFNxVx/oxrewjs8HRcRmIduFkDo9XXD977nTJVl7
 X+dirVkxAn54IKWs7w02pddXAVgqUr7TCuCfNMmQLBUyAxRsrlK5rW8nAZVHTT3o7r4v
 bzY2WyAa9coj8zWVttkkx/fMWRnrpYTgri2hIO/pSPgXg7WKrMimeHQDtoKoQ20PD7e6
 XImttjvByvTB0Z1iY4qxi1p7NKoGORK0q7Suz2i/miboijXNzj4wFcfRC7wXFbGV/+8V
 i79Tw82Ax/1z5eWi53dgq15b3vSB1yvw5PEiKrH8DB1nVKKBWrU+cOIdJ7r4wHt9HHOW
 KWiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGifA8ZioDzZPIXiZD5EvvhCqiJklKOthd21hoH2Wmg0hhy6bEk4c3/HbEA4TAQ1NxiWRL/ttIU0fA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iZI6uGKAmam+vtf52F4PqfVQWwcfC3+n3ZAgxUnUl+UJtHhuL
 j/+edKShIWM7weQKNtlrMYwqaHTuI2aKk6JjFi1RsDKE19BLICb4D31VaD7eTpoBSd9y06xMXW0
 jhJFrs5k4eVflw4E1+lpEP4Uq6PyNVVJbwKhAeQ8u
X-Gm-Gg: AYBFou2G56epZEuBtsWxXFwOo8nSixuGdsWVyodbVPhwUyfQOHbFb9zkgxG86VWAZbw
 Q4cHkDzcaJMxonbF3TuHPYERUuGhJ1k5aBMTmfQ2/UY53u37aCiA0JENFy3LVK7dHDOht594udx
 CNRyfvqQN+DuMpsrKe/eCE4zZmgpvQeDUPdxnVjq0mu6jQpzvLDj7mUelF/OwrWZ505uO8h7vNr
 R71JhggMC/6SKe3S+YJ5M5xKrDBOx3wjsNyei3X5MQuQVvacY7wlV60UrtVgYIKX6gngK3QeuwZ
 qKduytcbAqabnhtYmc0jBL/QfUvcrN5Pm4reXAqa2mKCCbhOlmZ88ZfCIgjPmwnbUbVhIN2rfdF
 IrXF0NlRQjNEaDUwSaA/uZpRM/oQcZU5OMoyCsB2v+5xEMkF5d30oOdeF0A==
X-Received: by 2002:a05:6402:c502:20b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b6fef8853fmr25733a12.10.1794118919631; Sat, 07 Nov 2026
 22:21:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org>
In-Reply-To: <20261021132304.23e0a4e7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 7 Nov 2026 22:21:48 -0800
X-Gm-Features: AclHuK84A9Z4KJMCekRVvO906KgemJ7leA4F7qgUGSEUquHWR-U_KufDY8SuGMQ
Message-ID: <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > But on the other hand the test coverage is nice, and maybe one day if
> > we add enough devmem support in netdevsim we'll be able to fuzz the
> > data path or something. Is there a way to get the best of both worlds?
> > Like put a comment on top of netdevsim that this is test simulator
> > device and any missing functionality and/or bugs in it should be
> > medium criticality max or something? Or is it too much trouble and I
> > should drop the netdevsim support and tests?
>
> I already strip Fixes tags and apply the patches to net-next.
> But it's still a burden. If you're signing up to fix the issues /
> review the slop we can try.

Hi Jakub,

So I started looking into whether we can improve test and fuzz
coverage with an improved netdevsim. My LLM prototyped full datapath
(with devmem) and offload support in netdevsim so the hardware
selftests and packetdrill run and pass in a plain VM without physical
NICs. I posted the branch at:

https://github.com/mina/linux/tree/nsim-devmem-rx-tx

The main problem is the total LLM generated diff to netdevsim: 62
files changed with 5,525 additions and 672 deletions :( So it's a big
change.

But with this, we can do pretty cool things:

- All 36/36 drivers/net/hw/ tests, 18/18 drivers/net/ tests, and
164/164 net/packetdrill/ tests now pass on a linked netdevsim pair,
without needing real hardware. This is significant because a lot of
these 'driver' tests also actually tested unique code paths in core
like devmem.

- NIPA can now (I think) run all these netdev driver tests and
packetdrills without real hardware:
https://github.com/mina/patches/tree/nipa-nsim-hw-and-packetdrill

- Packetdrill can now run on netdevsim:
https://github.com/mina/patches/tree/packetdrill-nsim-default

-(best part) Syzkaller can now fuzz live devmem/zcrx datapath &
offload netlink APIs:
https://github.com/mina/patches/tree/syzkaller-nsim-full-net-coverage

You asked me to do add syzkaller devmem support before, but adding
devmem support to netdevsim was too hard. With LLMs, it's almost
trivial, but it involves a lot of generated code.

Do you think this (or a subset) is valuable to post upstream to add to
netdevsim?

--=20
Thanks,
Mina
