Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBB606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xo+kh0V2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0D1112370;
	Thu, 26 Nov 2026 11:45:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2661112370
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:45:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F43B6062E;
 Thu, 26 Nov 2026 11:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601801F000F0;
 Thu, 26 Nov 2026 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693538;
 bh=bhvFwtF3U6kOOLH4HNUlH3bobwyUeQvz0yMfUYKwy/0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Xo+kh0V284JacJ6eZoC4IYjN+CakyB8Z5Klvt2Vni7FbVu1WTGPD5SBshDMR1j0Kc
 fiQVRZxlshn6MDqSO7bhcYJ+EXmfMnBdNYJ6a4ROkGrKJ0RH03LLbdGVpzYjlQYss1
 Y2XQD9JUhk3Y4B/y/2fiiugCt+nh6pSeDGVv7wzkiqZhwWMkE7ry5ECI8E4ghO8Fxf
 9g/fqymyOM/EyPLdYPI3U4M859AoO2J7haFUYHF7kyW/qqAeGn3HtDkJCz7GDWoRS9
 s3wgwD045CXRwFDLs4xDX8YxmPd08GANuWJO5IkBQNmcgY0rDXrQmqECgpUO/uApmJ
 pVyzFu+NUe9Kw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 12:45:33 +0100
Message-Id: <DN548CRVXMGK.BOPO5J56Y1OH@kernel.org>
Subject: Re: [PATCH v7 3/3] drm/tyr: add Job IRQ handling
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
 <20260728-tyr-irq-v2-v7-3-4e172e58e28c@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v7-3-4e172e58e28c@collabora.com>
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
> +/// Requests a threaded IRQ registration for the Job IRQ.
> +///
> +/// # Safety
> +///
> +/// Callers must not `mem::forget()` the resulting registration or other=
wise prevent its
> +/// [`Drop`] implementation from running.
> +pub(crate) unsafe fn job_irq_init<'a>(
> +    pdev: &'a platform::Device<Bound>,
> +    hw: Arc<HwGate<'a>>,
> +    events: Arc<JobIrqEvents>,
> +) -> Result<Pin<KBox<TyrIrqRegistration<'a, JobIrq>>>> {
> +    let job_irq =3D JobIrq { events };
> +    // Ensure interrupt sources are disabled until the handler is regist=
ered.
> +    job_irq.clear_mask(hw.access().iomem());
> +
> +    // SAFETY: The caller guarantees the resulting registration will not=
 be leaked.
> +    unsafe { TyrIrqRegistration::request(pdev, c"job", job_irq, hw) }
> +}

You could implement a constructor in an impl TyrIrqRegistration<'a, JobIrq>
block instead, which is think is cleaner than a free standing function.
