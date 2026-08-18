Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2ACC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C88F10E1FF;
	Tue, 18 Aug 2026 06:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NuGMAc0Y";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9FC10E39D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:41:24 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d03fcd26a6so6832255ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787035284; cv=none;
 d=google.com; s=arc-20260327;
 b=qAxCwUevZWyiv2NXH9rqCIiVb/OGhUftq7n0LVq7TpeSaYfFSUQ1snyBRJerc0arC9
 htvxEC20Fm0pxMR0Vu/q7L4zGErGuXe3dmJvpkeX7b+UK6enm1k0cso/6D1IRSKmpoff
 RRc/g/Fiw4VqeWWCl/05m/dqmQ17fnPnR8bCnqs0bWGlC4Rw0QFb71e4kh1nk2x8ouGE
 PtwfF61Wse0t6903IB29/LBEyxXALf1eXhanKbkA834JnxaAy926KcFUH8tfsui3tBAC
 vBck70kPhPjgLOroRz+Y7IGytd+bdjzhGsBhuCAL9fhV/Iy2v4nntXhx6Ld3cVJklsRD
 a1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F66vDlwnqNRvpNa85V4+GIKOYUyq40PQaHNUdB5z/NM=;
 fh=fIyFsabarI2FNfQULC46CSnbPvhqVaB/o58z5/nDNTo=;
 b=f0UW2ie3cZHqI4GDiRiI8xwKyKY4adzhpKIdT36AvYiW5bIWGkV2p9R9k+4d0AH4Rr
 pWdU4wCwKdALt+mJ3VfWU21gC7HmFtBS5kcZNXyLOlAsSRjZYROfLphfsYThCKja1oXc
 u5YpStnH05nRtrQ4DqRJh1XIvEnrBB9RISgOOJEPLVw0x4a3Re06L9QmZgy2RIGVQOe3
 v466R7/64PeLjopThUIBsWmjn9I63kqxqst9naBvEV7Br/pPsSKZu0L7vQNav8NGqkfo
 zlcbjLxHnHflBDET67Cesq2/YVOWQPkRueqOT0pIox+TMIrJbgVrJ4qTAlCMAEWue8xe
 6KuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787035284; x=1787640084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F66vDlwnqNRvpNa85V4+GIKOYUyq40PQaHNUdB5z/NM=;
 b=NuGMAc0YBTieAC7FDX4ib+PseADKJVZ5JBd4w81W4q4xkZOJYKqc/HjGNWiAqw4NMo
 RksUXPOZNcxVjtVF8ccVbHu0byLlpNAd2SmtbrggJl6Pfs4YqsHort1h6lm38O86HYIb
 s9qI6p7G8O8HXuHgGQ9cu090E3Y8dxAM1etreOxYS/mubK/EKbdQ6KY7jJH0Bj4MIlWX
 +YuHdk8argu8jGz6xTmzHAIFypEq1Y9r6nHt0y0eKil7OLBJ9LICjJA+1Dwnw02mbmpy
 Xd3fb6lWoGujgJ+Z0Alm189AmMJOYfrZ2s4dfoptNBIrwPnxtYMBeQmujORX1KmN3bXC
 QuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787035284; x=1787640084;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F66vDlwnqNRvpNa85V4+GIKOYUyq40PQaHNUdB5z/NM=;
 b=SA/LD2tP1fwHRufyhib7WcQR0A6q5ipOTosakuKFM3q2SccmupZ0GEhBTBu/q6p6bT
 Y+iH6Cgn725pCCRyTEfBHKQOOjUBC1jzdhUaC+bLJqJ3dpAa4uxr2JqjogCyEjMQw8yY
 i/lmiPNnFGgP6fRJ5uapvfHnuCoYiwStpz2/AGVSvxMYwwD2/lsFuIrjtL5K2W9RnRBi
 gIiNPUmx4P+GhzNZfNUoZknQkHeEh2Db5i0ncrG/uAdvGQp21REKrCI6caT+FiGa106T
 YgG6kSiJBugJXHIgmRUI3DB2Dp0JlvQMjHK7nWjMV++TL4Y4awALZwD8k8PupUs3oxC0
 jO1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6HCIs/TgTjhBCD2OrK1oYdLRREpYRKEd1oO30U5oNIL41kuGB5vzgBcfeNJIW8ZAbfPrKQ1nndxE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZmrmBX0BtcENp3k91jriVf7C+IkDMA7O/PbqMd8NfBB65IQU3
 mnPOWKev+LsefM7iZGPvziEBPlRV9edt/du59eFIYGgziXwKPalgbVK9pSuR8eBunAG8CrKr14r
 c+hjz4Phbc8yGI9B+GSGAwU46zV6HMFE=
X-Gm-Gg: AR+sD13VLGBJ5akbK+M+fWELZa3n1++SHpcRblv0ejU70/cuF4wZPPdreiBzWMlItgN
 L7gg1ryuiohGkGQMf+/DtvcHMXLMv3qiKbEcTd2JsQhQCVGpurBsBrhK8cEC260XgI2DUpmtUUk
 1fTy5KUx7ag3m/pT9COkfA/gmCNOwYuydcI2/mvNTnqpVZkSrqdyKD2xfAgE5EVul84lHyq3mve
 BvKjxNTSccPpxdlupDlMNQ90rACmHuHBfA92a1M8GTYSBtcXIjvt5SnjZD7wDG5YhiBBEKUnnDE
 LKTK+FgpbyPC2br91axOGZmaIe8LOh2UX6N7O+K5Z+oZA9kMmDoOJMVbEUYHklpGfsvLUM0XFBw
 tBId1eKf/Fj6tomXar3f4r+MoBMn1u8t2dnHSJ/x6LMYHRiFZMInlk9X5+cGxgeb2Nyb0sKI=
X-Received: by 2002:a17:902:e54c:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d3b0503575mr218175045ad.0.1787035284410; Mon, 17 Aug 2026
 23:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
 <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org> <aoON0FepAUw1b003@yury>
In-Reply-To: <aoON0FepAUw1b003@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Aug 2026 08:41:09 +0200
X-Gm-Features: AcwNN1XoW3I66H8usbqd_WxG6tEFGRwBY_Sn9lhKHblIF3shDY3QyhmlBc9AX_0
Message-ID: <CANiq72nFwdXcN+C8nJhd5Yq-cdUp1CDw_2u-D+zkgvW1-a5dLQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Yury Norov <ynorov@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Tue, Aug 18, 2026 at 12:40=E2=80=AFAM Yury Norov <ynorov@nvidia.com> wro=
te:
>
> Again, any kernel API trusts it's caller. It holds for assembler,
> for C, and I don't see any reason why it shouldn't hold for Rust.

Because the more you trust callers, the more complexity you are adding
to keep everything dancing in sync, and thus the more perfect you have
to be on every subsequent patch that modifies any code.

So this is all about not having to trust callers as much as possible
-- the point of using Rust in the kernel is to prevent mistakes using
the stronger type system.

And preventing mistakes is not just about memory safety. That is, even
if `f(0)` is not UB, we still want to consider whether it is worth
using the type system to prevent such an input.

In other words, yes, restricting inputs to functions as much as
possible allows us to convert certain functions from unsafe to safe
ones, but it doesn't mean we have to stop there: we use the type
system to prevent other mistakes too.

We can even have types that do not restrict in any way the inputs
value-wise, i.e. they may be pure wrappers of a primitive integer, to
prevent mishandling such as passing the wrong kind of unit or mixing
up two parameters.

Now, particular cases may or may not be worth it, but the general
principle stands.

Cheers,
Miguel
