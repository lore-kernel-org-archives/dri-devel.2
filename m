Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E2606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eSOBkzj1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9734910E9FC;
	Thu, 26 Nov 2026 19:14:25 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DDE10E9FC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:14:19 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6b879130a02so6610504a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795720457; x=1796325257;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8q/VB3c/73wlCZkx7DvMv3nIBqo12V1N1B2GG0LAjuo=;
 b=eSOBkzj1LMpRFZjXcc8Lqi7FVgeA5BdJEGOI7ihf8jGw8LCqCDCXbWJ7EvQMOoNBSu
 ObZXPUy8ONDJi9R4FDk299Z7fwMlf9vos2Vac9r9OcPCHwxSBppTBFSrL8bMwNPaeivz
 mct7Ku39PtePKVJJW7jq1UwE+i4dG2IuYXHehWKksdd5T4qj0z5oIBbtrfTdBdAoJA7C
 +tnBXSW7Drwb+BuAvD7tObJjHpfvJTIJNhVSZh9Z1xMqm5gauZy8zBXcsr//h9wIIEO2
 ql04mxUxhuMPi2lMFDR3IAEz01vt9/EJEYaVrG+bfNNo2mFiPqS8bxh1qpCnwj/qUKG3
 EzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795720457; x=1796325257;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8q/VB3c/73wlCZkx7DvMv3nIBqo12V1N1B2GG0LAjuo=;
 b=SEe7XJhYWUyjc0P3n/APmrtmRC524vd4gVXiXk6Wgb6d9wOYgDnlDhSb8s/86d8MKx
 LYBDH6G6pmCUS9XbDOffjEMYMbF8EVyp0Ud1IHTHPxr0iPk7pCsIHKVoVb/ER+NdRoRJ
 NQoDc0QO4gk2p9kPFTnitq9VTZwUUtkWgQ43XMhP1H5fn5o6/1hOwQ+f8FZPehnQNGgN
 mFNC+8OxZ4XKYeccDhBqXRrnOBFH5FJOVy5W+WbFVJHu9PV8PWECCnNvnghW/ETCv/nz
 awrGCXhI9H9a4ENsKEDg6D+kHaDjmVZCu0q9AVMVRCv3g8Na95VcxPds82+mhgUD9qau
 J7wA==
X-Forwarded-Encrypted: i=1;
 AL+hErHIlxDtkd0ecgW8/Kz9kcbFaE271CT65Bb1BgZMGhMZqosvXn3luZKGIJh1HdRy0v8cs7jlxM1P3HA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vxWPjJSOOzoxir0fnHpYvEYRAyssPlejFpAikk53CiKcAa394
 O/x2JPttifZOV40NF9GKaHh28GSN1p7zcGa8RYmIBhEKkIipIGXpGHvOuC8x+yDmw91oE0ly81X
 obffzi6YJCIWmUSBbQA==
X-Received: from edgd12-n2.prod.google.com
 ([2002:a05:6402:a50c:20b0:6b8:8b9a:86f6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:c0c8:0:b0:6b9:278a:99f4 with SMTP id
 4fb4d7f45d1cf-6ba37d5bcd8mr11922168a12.10.1795720457280; 
 Thu, 26 Nov 2026 11:14:17 -0800 (PST)
Date: Thu, 26 Nov 2026 19:14:16 +0000
In-Reply-To: <20261126-b4-rust-reset-v1-5-9c4c3d029080@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
 <20261126-b4-rust-reset-v1-5-9c4c3d029080@collabora.com>
Message-ID: <awiFCBnJ_i-N_Blb@google.com>
Subject: Re: [PATCH 5/7] rust: reset: add SharedResetControl
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 01:04:32PM -0300, Daniel Almeida wrote:
> +    /// Deasserts the reset line and moves the [`SharedResetControl`] to the [`Deasserted`] state.
> +    ///
> +    /// Equivalent to the kernel's [`reset_control_deassert()`].
> +    ///
> +    /// [`reset_control_deassert()`]:
> +    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert
> +    #[inline]
> +    pub fn deassert(self) -> Result<SharedResetControl<'a, Deasserted>, Error<Self>> {
> +        // INVARIANT: The reference that `self` owns moves to the value that this returns.
> +        let reset = ManuallyDrop::new(self);
> +
> +        // SAFETY: By the type invariants, `reset.inner` is a pointer that a C getter returned, and
> +        // `reset` owns its reference.
> +        to_result(unsafe { bindings::reset_control_deassert(reset.inner) })
> +            .map(|()| SharedResetControl {
> +                inner: reset.inner,
> +                _phantom: PhantomData,
> +            })
> +            .map_err(|error| Error {
> +                error,
> +                reset: ManuallyDrop::into_inner(reset),
> +            })
> +    }

The C side here interacts badly with the error path of
`SharedResetControl::deassert()`.

In `drivers/reset/core.c`, `reset_control_deassert()` does:

    if (rstc->shared) {
        if (WARN_ON(atomic_read(&rstc->triggered_count) != 0))
            return -EINVAL;

        if (atomic_inc_return(&rstc->deassert_count) != 1)
            return 0;
    }
    ...
    return rcdev->ops->deassert(rcdev, rstc->id);

Unlike `reset_control_reset()`, `reset_control_deassert()` does not
decrement `rstc->deassert_count` when `rcdev->ops->deassert()` returns
an error.

Because `SharedResetControl::deassert()` returns `reset` in the
`Unknown` state (`ASSERT_ON_DROP == false`) on error:

- If the caller drops `reset`, `deassert_count` stays leaked at 1, so
  future shared users will see `deassert_count != 0` and skip
  `ops->deassert()`.

- If the caller retries `reset.deassert()`, `atomic_inc_return()` returns
  2 (`!= 1`), so `reset_control_deassert()` returns 0 without calling
  `ops->deassert()`, leaving the line asserted while Rust treats the
  control as `Deasserted`.

I wonder if this is a bug on the C side we should fix in core.c?

Alice
