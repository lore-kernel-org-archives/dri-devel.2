Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F6C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 11:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078DE10E1CF;
	Sat, 15 Aug 2026 11:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mL9BWLcl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA9E10E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 11:33:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86C18414B9;
 Sat, 15 Aug 2026 11:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8E31F000E9;
 Sat, 15 Aug 2026 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786793586;
 bh=Uatdy+zH9EboeEXWcuokGMv/6bFcMMJ3Su9Y3rxZ7tU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=mL9BWLclHTwq66p36QQFF88JHzZX07fwnyueNWTPSTd+kJmLwEGSIbJbMcv6v8pEn
 NLHNE8Dhi03Jf1k7rmy6SmKS5OoFMrKEd2g60Fr3U44Q/2HPXFEOWJTqIaO7M/06eM
 FbGCtcucjNWTctcx7N9REpyuvYp8Se850f9ZHRN/eEEhJsyCKy6KyzhFRDkoYdpdvT
 UxkHf/ExGmmRksVA7WrH09KO8xf5DJOC1noBzPtc+MgqlDbh3NBGTj1hNbzcP328cD
 aTc4hDiKAo3MmZ7DmuiJxXeE5XrczntGga4UvPbdFUZn7I5itlqjXfmHjjWA38lA0m
 umBNMzU2+Nakg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Aug 2026 13:33:01 +0200
Message-Id: <DKPHGNOPN7PT.2HF3KUPO3VM79@kernel.org>
Subject: Re: [PATCH v4 3/4] drm/tyr: add GPU reset infrastructure
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
 <20260815-tyr-reset-impl-v4-3-578df9a5e576@onurozkan.dev>
In-Reply-To: <20260815-tyr-reset-impl-v4-3-578df9a5e576@onurozkan.dev>
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

On Sat Aug 15, 2026 at 12:23 PM CEST, Onur =C3=96zkan wrote:
> +#[pin_data]
> +struct Controller<'bound> {

Please only use the lifetime name 'bound for bus device private data (which
defines the 'bound lifetime). Everything within is shorter lived and should
carry a different name (see also [1]).

I'd suggest 'ctrl or just 'a, once you have self-referencial fields 'ctrl (=
or
similar) is preferred.

[1] https://lore.kernel.org/all/DKAINVQDNE79.3JRKZDQJCSX9@kernel.org/

> +    fn reset_work(self: &Arc<Self>) {
> +        if !self.try_transition(ResetState::Pending, ResetState::InProgr=
ess) {
> +            return;
> +        }
> +
> +        dev_info!(self.pdev, "Starting GPU reset.\n");

Please use dev_dbg!().

> +        // Wait for current hardware accesses to finish before resetting=
.
> +        let reset_guard =3D self.hw.close();
> +        let reset_result =3D run_reset(self.pdev.as_ref(), &self.iomem);
> +        drop(reset_guard);
> +
> +        if let Err(e) =3D reset_result {
> +            dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
> +
> +            // TODO: Unplug the GPU.
> +            // There is no API for unplugging the GPU and this is unreac=
hable
> +            // for now since there are no hardware users for reset API.
> +        } else {
> +            dev_info!(self.pdev, "GPU reset completed.\n");

Same here.

> +        }
> +
> +        let _ =3D self.try_transition(ResetState::InProgress, ResetState=
::Idle);
> +    }
> +}
> +
> +/// User-facing handle for scheduling resets.
> +///
> +/// Dropping the handle drains any queued or in-flight reset work before=
 the
> +/// [`ScopedQueue`] and the clock and regulator resources are released.
> +pub(crate) struct ResetHandle<'bound> {

Same as above 'reset or just 'a.

> +    controller: Arc<Controller<'bound>>,

This can just be ScopedWork<Controller<'a>>; no extra reference count and
allocation needed, as the constructor gives you an impl PinInit.

It also gets you rid of the open-coded cancel_sync() call in the destructor=
 of
ResetHandle.

Also note that [2] already has Send + Sync for OwnedQueue when OwnedQueue i=
s
introduced, so you can drop patch 1 of this series.

Thanks,
Danilo

[2] https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.org/
