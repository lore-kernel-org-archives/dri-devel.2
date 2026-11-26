Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F0606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P23BxASq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1DE10E995;
	Thu, 26 Nov 2026 11:42:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2E010E995
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:41:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4A5743724;
 Thu, 26 Nov 2026 11:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B91F000C6;
 Thu, 26 Nov 2026 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693315;
 bh=uE98kEPGNlzmvdWON0vWwzGlXWIeDH4wPeHHoPm0CIw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=P23BxASqcKYz5WSnU/9SYEpl9vvwTb5U9dKXh0LHBbkOnkUnzEocuA2bnmDsBCcRP
 rk/PBL5tg1hBz8ZSz3gXcIChGageDvuaPS9y+QAJcd2Vbe0WVP61tnXHYCV2bpGcmq
 zRh6dW/PSV41j0WlZnZgO1s90jERP6zyjzvf5clRcFyM95OtT4GiiqR3vxK33ChLTf
 px0jSlqpcUsgM6jLVNepzy4mXpA+Sido78k4ZF9wuzuePBzf5Yq6VhOVhoVAkuihyx
 8Qq5fRY01OPWTKet++VwkIVzG3NVxYLCfBFnpGh0sRt9iQDOWo0SZmmjQ5vrEM+Upx
 oTXW/k5ii/Srw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 12:41:49 +0100
Message-Id: <DN545I66CKO1.2YKP99UIQQR43@kernel.org>
Subject: Re: [PATCH v7 2/3] drm/tyr: add TyrIrq threaded IRQ wrapper
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>, "Deborah Brouwer" <deborah.brouwer@collabora.com>
To: "Laura Nao" <laura.nao@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
 <20260728-tyr-irq-v2-v7-2-4e172e58e28c@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v7-2-4e172e58e28c@collabora.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 23, 2026 at 3:58 PM CET, Laura Nao wrote:
> +impl<'a, T: TyrIrqTrait> TyrIrqRegistration<'a, T> {
> +    /// Requests a threaded IRQ registration for `irq`, using `name` to =
look up the interrupt.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must not `mem::forget()` the resulting registration or o=
therwise prevent its
> +    /// [`Drop`] implementation from running.
> +    pub(crate) unsafe fn request(
> +        pdev: &'a platform::Device<Bound>,
> +        name: &'static CStr,
> +        irq: T,
> +        hw: Arc<HwGate<'a>>,
> +    ) -> Result<Pin<KBox<Self>>>

Why does this not return a pin initializer itself?

I don't think this has a user in this series (except job_irq_init(), which
itself seems unused), but I expect this to be stored in some other containe=
r
that is pinned anyway.

(Note that in C we'd also not need a separate allocation and just embed it =
in
its corresponding container.)

> +    where
> +        T: 'a,
> +    {
> +        // SAFETY: The caller guarantees the resulting registration will=
 not be leaked.
> +        let registration =3D unsafe { TyrIrq::request(pdev, name, irq, h=
w) }?;
> +
> +        KBox::try_pin_init(
> +            try_pin_init!(Self {
> +                registration <- registration,
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +}
