Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465E4FF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6528C10E5E0;
	Mon, 27 Apr 2026 07:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cTk0AHzU";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7DB10E5E0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:53:58 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so8942299f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777276437; cv=none;
 d=google.com; s=arc-20240605;
 b=VFtG++Ht2OHeFCbQVEPSV1mEe84uo8GT7s0vqUiaQM6hLNqrgU3wjtqQ/m85acHz0q
 TxlZewMVhVWtqQ7e0ob4jQCwf3SiYBUakolNuNN4TcjDcNKaNqUY5Ga2XSjkbSFpt7iY
 qjMHaJ7HcSzJjTFsK3P4sCItbyDT32V/zugDU/hgigfC5Wi6/lgTvy08wB42hV4ToTWo
 mPNFSEJpNpHDfPVd8C2NVTtJwBn2TPmVORC8YSPANsfjNIuEQkRLAmgs5jlTmYPC8OXa
 oIlKGMcRS01QNzANI8TTYY8RjNUohysEhcGmeVvXYUB+d3h1/yH2XpNDoAQBueghvjsY
 kkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OcNxXuuIa/G7743UoUO33DzGwgrzsKsdOhQxGQZwPXw=;
 fh=KY2wth6qp9l+kGT1G6YQ3ucXNqw/H4tNUReoNvatTg8=;
 b=Ey3A5YTdNp8kE/PxwiyKeWKMQWi1IQIE5pzm7qqs01ofWjIUjTs+KK+yFzJkQIL7Tq
 jupHVtXlTiUzK5ZeeBsvc5hS192no9JjmjUxuAY3QjclTTPF4im+ZGo9D0Ek2VTDe6CV
 B67yQvKU0hd2jaDr0MfmrIlll7FD5WjAqb8mAApSDeVKmYhKC7woqcE8ar+LRcQboRQY
 OgCeM06hr8FIQ+WC2hF98Ai6AaOuXJMD/D5FeT9HXyY8qwoRBRPQN4GyqnhvhhHfEZWf
 TR30HvwrC1oYmryvvYr3N3pgFzIvq9/rSBD4i6WiSft5Hl+8JYjyHpDQ4Yh9XPKpXYwi
 rYiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777276437; x=1777881237;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcNxXuuIa/G7743UoUO33DzGwgrzsKsdOhQxGQZwPXw=;
 b=cTk0AHzU4TRUoI49ApxRRaRtXgUKB/0wiVU36Tud7yqxQm3tcMPbRlEgtQoSl0cUXP
 p0BlYp08/0jP0zRPQDkp7EZ5fbmJFK2qh16/4URtsn8QbGe2Yl5T4m/oZTZtTp0PTRMp
 CVV/a5QCYlVsHsuV3smJMy4jx0jf9SlTv36Uc+HJBVVAJYUMRPCsyu4Ovb4l24AUMKvE
 oTQ8hJsuKr23eqLa3AvYDfNomFVolIoyB1d/GRC3oC21lEnp7LtlsdizT7a40ST71M+J
 PQosBTPhL7QHeNdRUjBefr90OPUewuyOcJlIF61zLmXDt5I5kxyVbf7Qov0hjwfPX1FO
 Q3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276437; x=1777881237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OcNxXuuIa/G7743UoUO33DzGwgrzsKsdOhQxGQZwPXw=;
 b=bKymTUb+TyriihuhZsR3AaKZMm4hGaf3BYukFqec5VwqocMJVEg54TTWrgYSlToUmj
 iXT5XpgMxkdm1puBggGr4dxABSOA3ri6f+/lOw5NptMfdfIwmN5uJrmBkHDMMo6mUaOl
 8nQ/9dDUPKXMcmT54+daBphcvyJymLSx8fhiF0Ic92tckfbjWODJRinHxgbty02EQPbo
 w/LOUrPXJdeLa1Yc9i3lu7MEIynK61kAJj+RmCFw1Pyut0HSz9BhaxQ+7mH+IhhDXmBp
 ziIT6sAXsp70mYqoFH/sr75F6Ehnh3DZErpVHuP3C4F77bzXTXOvg8QyqYTcQv9V94Mv
 ewbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Mgyq4uBlLyZenmyXN2lV0GtRC2WY3DuCNtHgeVuPib2EfhikUqS4UYQoOdNKXhW9zD98uiFHKBiU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI4fRfECy8h/S3o7xg6f/C1I/RDN3+Y050j/begL9WAwD9flOJ
 r8ZkrkQzTGvuqvwF9YwGHfTcOl1RhXl7r0tHgxVCuhgfVGemksvW2RKf2x/bBsc75Jbzu2hYdzi
 y3R61mCpdW2ku1V7AqPn6TK4fm5b66mY3BjAn06cS
X-Gm-Gg: AeBDievI9yfRh+DKa/cfdwzzfTmxc1edtHbea/u+pEKOEz4hwfu7OKaC7NmzbLd95HJ
 4rQR6expWl07F/Ory98Suwz1nd6HrWeJeSynPbHmetwovnPqU4IWSvhKYUu3GkLznJZae8g9sR8
 hm195niZfYzvB+JRMigM+fEsYKWi4ytRHmUjjjLBRGpbb1BqiriClTlNAyR9doi4KboL4YP8OXL
 9PEQmSVYqAMVltSh0DmVzxGGO4TN+cy5HIgYGl2OPKDVRvQuZl3e8vxLphyoHEnTTVwLmTnAws2
 4M7M5d3m2lcJrRtqs9+1bR5VTftyoc7wtUA0YdveLjeZhFps7iyxPLKaTXY=
X-Received: by 2002:a5d:64c3:0:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-43fe3e141bcmr61044080f8f.36.1777276436304; Mon, 27 Apr 2026
 00:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Apr 2026 09:53:42 +0200
X-Gm-Features: AVHnY4L5fXBRZRJQmLaD4S5rh4WMT75ujNXIGm44Nx2Pc3gQukpC6qqLTHco_DI
Message-ID: <CAH5fLgjV17zrsSQ7xD4dpeXjRJFLSR4Er-fsr3vhLg_5EF_ziQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] rust: time: add arch_timer_get_rate wrapper
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 boris.brezillon@collabora.com, beata.michalska@arm.com, lyude@redhat.com, 
 acourbot@nvidia.com, work@onurozkan.dev, alvin.sun@linux.dev
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

On Sat, Apr 25, 2026 at 1:39=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Provide a safe Rust wrapper for arch_timer_get_rate().
>
> The underlying C helper returns 0 when the ARM architectural timer
> is not available or not yet initialized. Map this to Option<u32> to
> make the absence of a valid rate explicit to Rust callers.
>
> This allows Rust drivers to query the system timer frequency and
> select appropriate time sources when programming hardware timeouts.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  rust/kernel/time.rs | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 6ea98dfcd027..03ce96450fc8 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -359,6 +359,35 @@ fn div(self, rhs: Self) -> Self::Output {
>      }
>  }
>
> +/// Returns the ARM architecture timer frequency in Hz, if available.
> +///
> +/// This function queries the system-wide ARM architecture timer frequen=
cy.
> +/// The architecture timer provides a consistent time source across all =
CPU cores.
> +///
> +/// Returns `None` if:
> +/// - The ARM architecture timer is not available (`CONFIG_ARM_ARCH_TIME=
R` not enabled)
> +/// - The timer rate is zero (not initialized)
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::time::arch_timer_get_rate;
> +///
> +/// if let Some(rate) =3D arch_timer_get_rate() {
> +///     // Use `rate`.
> +/// }
> +/// ```
> +pub fn arch_timer_get_rate() -> Option<u32> {
> +    // SAFETY: The C API is available in all configs; when CONFIG_ARM_AR=
CH_TIMER
> +    // is disabled, the header provides a stub returning 0.

The stub is inline, so to call it you must define a helper for this
function. This code will not compile if CONFIG_ARM_ARCH_TIMER is not
set.

Alice
