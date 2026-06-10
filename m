Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0DFCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1603310E762;
	Wed, 10 Jun 2026 07:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GR5zbAR0";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BAE10E762
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:30:21 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304dd3bb7a6so566148eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 00:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781076621; cv=none;
 d=google.com; s=arc-20240605;
 b=CrZ6d72BNd7nueimD5DEG9rDLkJVjjSh7twRXVejH4940ZSXZkaoYEQtb17hvHS3jp
 4AQb+R4iwbrV6mR0fq9Hngn4rmSez2KY1pE5bX/D1JWIID40lB5OHEFrkXS9VG+KbrRG
 yj/kp2bLnaS/o0TyxKepLIGw729VBGZ9+bOLKVdw3iDhmVAuIGuISIrhR/1jmFuVqyrx
 uKSp7D0kqbNtdH3PiOst8O0Ggk0fyWIoNkVTGDz+zDERR3esuxWc9cX0ouH+Q3nmBVW/
 +ltq4BQTOBdnjO0gpiSAp/JOguRABZt6aX3rDxOyXRPzE8LXhJaU8jb4kvz+a4wsrSUw
 PjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
 fh=CR2+CUxdjO8kjDPiyaSNVfX8lgBTN45v2BMmtMLcYFY=;
 b=k5bsaGRZFyDSHBjQSEGBmH2VBttlQGiVGnI0lX/AM/CJTAgGb5rx7ehwnrpc1bAXA5
 TzasHm3vkiobvWu9HKUAihR9H1EenZ8bGHDdPneB+PvmytoYNOzS6Ph2cV+v6l4tKPAy
 X1NbUz/Mf1tvsj90BPBNSmAlKZNp55Wbj69FvrEYSxVvADNoShDJlgVU0ZLUZA3k+Evu
 zIzspyXfmCvnEHdnQ2dvamWkDwK2NztcvwXBPS4bIGYUIktgqY+BIvhanikPFfZvk+Vz
 G4dzQ4ptHG5YOtkSJjOtfcYdtRjTT29VR6IVhdcmW5KopdZwyRvfwuxnM1Vxfp0q84+e
 c7Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781076621; x=1781681421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
 b=GR5zbAR0tzPFzXmYDsplnVcjpt2kF4Nzz33fXk7OhERUuJuTNZs8XeHKhg8LM/h+2M
 rKzLB3HIAqpTaHRU4ucGvl89SShTWrsKEEPKm7l2bmq7BafXgl3ixLR9eAitc4mK+0oA
 L+Xb9wKa6WnzLKoVBuOSZ5Pg5xFkN1IqKKI4RNzDZjkATwzvZXBK/Ze+fqlPhu+tDu7M
 5b/PLZancfOBlGPhr0tKcNpvoXLi1j4zbiw6RLbBPXklcpc9tB1Kf1bb4TPsT/VCCIYN
 062FcM4/TNb12HSk2I7HIe089WChy4x5aB6tF5WieG4h9/2B0hE2dJ2G1Cu0uQRDptAS
 TpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076621; x=1781681421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
 b=R8muIfLbZADpMijLarZXlBkq8feGR0Hu9XSvm9cc9l1dyWkYBGT0HB6bE/mUe4/Ju4
 xw7zDfP6l7fc5ioVJl0y+Os5SOkWXj3eSMv4pDhwsHzTVMtIoc+4J92BzEny939Ykbd0
 Padyi3BMQCep+vHhbpm4LCuc/Bx+lOTxvYwTEfByOVZ6gkkyF4+w5TsCFk/XM6yP41KC
 SvAAth9FkQOTOUZIOuY3jnN9GtIxaQbFhwvlgzWifJrlqdKDiXFBo4Bq5JGCEM/Au+DY
 x6aHyOVKJ4I1ZNHqbxoljQouSUv7ftPAQZ5dWvoDavuXtWm6w2x8np+cg+fDysrGfOQ/
 h6kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E6jWtLgMEGWA6addeU/5QCs0o0cveUY5J7BFoyNVxdrlwRQTKRo5C1WchjWjmCmlESF6YEklWRGM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM4OmltYgzHCHVdajcpzf9D700WLvT5agbTBCdX1rtQoZIiT62
 DcEvzbwZpETFClS9VG8AW886+ZjpSAkKLs1o5s0KaILP7y/+RQ0t7IXnQlhzq9rDmEDb4kbCjE8
 XTrEpcUApuhATyKq8uqxkUyxCpB/GBrI=
X-Gm-Gg: Acq92OG8l3h0VaFhb3JJMLajmsD/Ho9K8ULv2ZZ+toqTJZThbE2v+8/9VztBex3tWch
 v8TKGT37YLga9UF2sbklNUE94BuccGB6X2owo5Yvd7Q7alXlqUWHTlFFYku0Sc9y+PIKDiRlsKF
 NH5NMoxtwWHGLluoh7AnxZYSGQFZt2SzzjmX7U1M3z4/4jiv2gjV9PAqEpVI3+Pq1nGBGzpqdZ4
 edar57x7BSU/22QVM6N4ov/aMMyMzATl1fi5xiRWYYaOr+XVeT+Atd3o1uzFrirx9Fub7oO11xl
 CRSy7E78wmhDnXcwtsm6KXmds2wrZ3b0PN/Gfy1f8jcgEttn2LVP9SgjLSazo9n+gGTVh8dDvWM
 9P6VAUGIiCclP456OHKt1tPe/SblrcseQhA==
X-Received: by 2002:a05:7300:bc0c:b0:304:8860:74dd with SMTP id
 5a478bee46e88-3077b57ff09mr6067698eec.8.1781076620726; Wed, 10 Jun 2026
 00:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142637.373347-1-gary@kernel.org>
In-Reply-To: <20260609142637.373347-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 09:30:07 +0200
X-Gm-Features: AVVi8CfhtUOUWqMJb81Bw-Ep_qKBuU8iXg5G_qpR2vrQ4E2KJJ25x_mDHtH0Smg
Message-ID: <CANiq72=H_box4dE2aFWcENE-UY9_1cAKMWzhxLUS_a=zHsFKrQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Tamir Duberstein <tamird@kernel.org>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org
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

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Given the macro scoping rules, all macros are rendered twice, in the
> module and in the top-level of kernel crate.
>
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Acked-by: Boqun Feng <boqun@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` -- thanks everyone!

    [ Sadly, because the definition is hidden, `rustdoc` decides to not lis=
t
      them as re-exports in the `prelude` page anymore, even if we refer to
      the not-actually-hidden item.

        - Miguel ]

    [ Kept a single declaration in the prelude, and reworded since they
      already had `no_inline`. Removed other imports from `predefine` since
      we now use the prelude. - Miguel ]

Cheers,
Miguel
