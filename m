Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4515BC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFA610E044;
	Wed, 29 Jul 2026 13:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ik.me header.i=@ik.me header.b="rcUc2SLJ";
	dkim-atps=neutral
X-Greylist: delayed 3602 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 13:20:37 UTC
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [83.166.143.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ABD10EC39
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:20:37 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9B6L0XGlzVsQ;
 Wed, 29 Jul 2026 14:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
 t=1785327145; bh=/Mf6oc8o3rgfoSd5qIUTbDR7145wWJf1XLsdkjAYlNw=;
 h=Subject:Date:From:To:Cc:Reply-To:References:In-Reply-To:From;
 b=rcUc2SLJbe1wzDhxkVtnNpyfZuacNYzGkoWzztqh41/Q9OMgk5a1JTmH9v/vlMYLn
 6IU7fZUwGKjqot+2Qsy3EA/CfVct3kB0DTt4baZ+z8izxFAfL8cY4mMilelunAAiTR
 c/HmWP8hggNo+QgRqxxaBCn3XHlN1pU5unx6SNvM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h9B6J68gszHKs; Wed, 29 Jul 2026 14:12:24 +0200 (CEST)
Subject: Re: [PATCH v2] drm/tyr: add Job IRQ handling
Message-ID: <9cf1107a-3dfd-43a6-9f25-d8e01595c9e3@mail.infomaniak.com>
Date: Wed, 29 Jul 2026 14:12:24 +0200
From: Ewan Chorynski <ewan.chorynski@ik.me>
To: Laura Nao <laura.nao@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com, Deborah Brouwer
 <deborah.brouwer@collabora.com>
X-WS-Location: eJxzKUpMKykGAAfpAmU-
References: <20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com>
In-Reply-To: <20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com>
X-Mailer: Infomaniak Workspace (1.3.1317)
X-WS-User-Origin: eyJpdiI6InY2WER6UW9XQ0puUVJCN2l1NTVuUnc9PSIsInZhbHVlIjoiZWc1OFV4dktJWFJkWVlIbkdCL3h0dz09IiwibWFjIjoiNzVlMDczZjBkNThiZDVhYTlhOGI1OTgyYjU3ZGE5OWY1ZjFhMTkyODc0MmVmYzU2NzFmNWY1NjE0Y2IwY2U2ZSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6ImpKb3dxUHpkZWZvSWpyaW4zaVo0TlE9PSIsInZhbHVlIjoiWGVwbGprK1RQMkJqUVRsS1owNU12QT09IiwibWFjIjoiOGE0OTAxZWJjNDU0YzdlZmE3ZmYxMTI5MjhiMmQyYzBiMDBjZTA1NGU2YzdmZDE2MGE0YWQ3NjFhNDI1Y2RjYyIsInRhZyI6IiJ9
X-WS-LOCALE: fr_FR
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: :b8ff05a3410f642:ham:e74197f626dda86
X-Infomaniak-Routing: alpha
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
Reply-To: Ewan Chorynski <ewan.chorynski@ik.me>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jul 29, 2026 at 11:58:29AM +0200, Laura Nao wrote:
> [...]
> +
> +impl<T: TyrIrqTrait> TyrIrq<T> {
> +    pub(crate) fn request<'a>(
> +        pdev: &'a platform::Device<Bound>,
> +        name: &'static CStr,
> +        irq: T,
> +    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a=
>
> +    where
> +        T: 'a,
> +    {
> +        let handler =3D try_pin_init!(Self {
> +            irq,
> +            _pin: PhantomPinned,
> +        });
> +
> +        // SAFETY: The resulting `PinInit` is not leaked, it is consumed=
 by the caller to
> +        // initialize a pinned `ThreadedRegistration`.
> +        Ok(unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, nam=
e, name, handler) })

I think your `request` function should be unsafe with the same
requirements as `request_threaded_irq_by_name`, otherwise how do you
guarantee that this safety justification holds ?

> +    }
> +}
> [...]
