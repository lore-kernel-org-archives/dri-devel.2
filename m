Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C46DC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845AD10E817;
	Wed, 23 Sep 2026 08:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V8RvteeT";
	dkim-atps=neutral
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094E010E817
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:50:06 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a1188c8948so837053a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790153404; x=1790758204;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/V4JJZVNuiDLsMZrmNpJjlcNEhUviMYM4KAzEYYNoVE=;
 b=V8RvteeTPudelQVeCG3+dKh1zDvwJhzvv+fbNkkCMSpBjKzQbZxiOAncEL/Fs7HCSw
 wYS81WR1vr9P+mS2i7JrZqftSu40GnjvNhAizwfDIXGKlvhYi954vaSYfrtS3AaBqA1Q
 rjx5RsX+Z2JOdnu+6FddBgR1P5TWgrT+GOhXhtC+g3obBeSeO5djKNJQ2yx36/GZ1Qwo
 oXchoGG4NPx7YxbGZvK29STfA3FVa86iM85dmOW6qndXw2OQQX6uG/yeEh9gvP/SKQN2
 7fPGyEwey4gBNC176mMC+W8eG9hgadUHW6kO8FqWo9HmxZRgM7yqWLMC1f15oyWmhE3a
 eCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790153404; x=1790758204;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/V4JJZVNuiDLsMZrmNpJjlcNEhUviMYM4KAzEYYNoVE=;
 b=crjMq7KxBNmJ2AcF22iNlLMSWShTnLH8QQ4/2nWEqEEpt4jSe1SncjgX6+Gb6PVrvk
 MkUAYhPXnDbARR90yYDk+hV0p7sjWULivrNNAes9HTrp7hdMWktSvNOe68Bv8w5u4A+0
 89Ehca64G0Ew2jxWA6RdvHUza4fa3E5wRZClhCJYB36UV9cKR7NP47Y1V2cxcKOlxPn4
 55qCqJ8Mk9BSNX6+YLW4mCIXIeXvSJ//ms/uBkiq3Xo+Pk/CzBdhUxAKAqbMFz2qRwNj
 /+LlcreM1/Ok0QBPvieMqlvzhtIuNaHvCwEkcZXE3EGrnIPybct0YrqTCXdPX0a/Y6I7
 T3Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAYdhoDJdtqgz8k/KERVTYOgUntcXPclTi3WAvlyK1gDUsT4jlcOM6PzdkUtUleLTySvVCHQGj45k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnrA3g3IuYUC91kEGwhCAwJ3AXs2dLpsVrWiIag6slBdDuGJnL
 F9jtQdK7Zx8Cm4SJWqPwK9vlWYQAuxqBwQ1PlpKR7smHMjjviXrgGpSiASNAr/Pdk6I+Gi1mRI5
 C+p0uQCZKt+vEH6Xjcw==
X-Received: from edxs21.prod.google.com ([2002:a05:6402:1655:b0:6a6:6326:bdd8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a0cc:b0:6aa:734b:1a1f with SMTP id
 4fb4d7f45d1cf-6aab3b5bb34mr1568561a12.25.1790153404051; 
 Wed, 23 Sep 2026 01:50:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:50:02 +0000
In-Reply-To: <20260915-tyr-interfaces-v1-9-5d28f1f75aca@collabora.com>
Mime-Version: 1.0
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-9-5d28f1f75aca@collabora.com>
Message-ID: <arOSuojQNLcO6m8r@google.com>
Subject: Re: [PATCH 9/9] drm/tyr: wait for global interface readiness
From: Alice Ryhl <aliceryhl@google.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, kernel@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Type: text/plain; charset="utf-8"
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

On Tue, Sep 15, 2026 at 12:57:42PM +0200, Laura Nao wrote:
>          io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
>  
>          if let Err(e) = poll::read_poll_timeout(
> -            || Ok((io.read(MCU_STATUS), io.read(JOB_IRQ_RAWSTAT))),
> -            |(mcu_status, irq_rawstat)| {
> -                mcu_status.value() == McuStatus::Enabled && irq_rawstat.glb()
> -            },
> +            || Ok(io.read(MCU_STATUS)),
> +            |status| status.value() == McuStatus::Enabled,
>              time::Delta::from_millis(1),
>              time::Delta::from_millis(100),
>          ) {

Does the io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true)) line after
this read_poll_timeout() also need to be removed?

Alice
