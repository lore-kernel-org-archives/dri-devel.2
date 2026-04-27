Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2EFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9918C10E28C;
	Mon, 27 Apr 2026 08:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="qy2uU3h8";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5F910E28C
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1777280350; x=1777539550;
 bh=5za67Y9x89GlwWt/aZxQ6MserLGP9uCm4g1yOoBm++I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qy2uU3h8alaPloUrD3UHweuSyZIiEDSfl6vbPeB5eu/MVAN6hW40qbp4MqJWLfC1r
 NcAKwXCPlnn6xzMHYSzBFZEHuYs8Y4cfdBEuGKEXsak+x1Z4OisOPOH0sCdO3Npm6z
 HKLMZCNk+xNDkhxqGQeKen4gn0Oh3Ffp0Mfr6rEYrrBJbgnLaRoNHnKi5eevZ4qcRm
 WQtdzklaRgoIpSoWRDBNpchCLMfRRi1xYOy1qc9kGTU+6/M+3cMSxao4p2ZKE8cNGh
 M7fnihdD0TSlIncDHnqni279B4u0qlUtZDOBWLCJBjO6AIxbIhSKCyySwH0Bvlwk29
 TbwfSvAvQRQzA==
X-Pm-Submission-Id: 4g3yDD3RHDz1DFFM
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 alvin.sun@linux.dev
Subject: Re: [PATCH v4 19/20] rust: time: add arch_timer_get_rate wrapper
Date: Mon, 27 Apr 2026 11:59:06 +0300
Message-ID: <20260427085907.106896-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 24 Apr 2026 16:39:13 -0700=0D
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:=0D
=0D
> Provide a safe Rust wrapper for arch_timer_get_rate().=0D
> =0D
> The underlying C helper returns 0 when the ARM architectural timer=0D
> is not available or not yet initialized. Map this to Option<u32> to=0D
> make the absence of a valid rate explicit to Rust callers.=0D
> =0D
> This allows Rust drivers to query the system timer frequency and=0D
> select appropriate time sources when programming hardware timeouts.=0D
> =0D
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> ---=0D
>  rust/kernel/time.rs | 29 +++++++++++++++++++++++++++++=0D
>  1 file changed, 29 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs=0D
> index 6ea98dfcd027..03ce96450fc8 100644=0D
> --- a/rust/kernel/time.rs=0D
> +++ b/rust/kernel/time.rs=0D
> @@ -359,6 +359,35 @@ fn div(self, rhs: Self) -> Self::Output {=0D
>      }=0D
>  }=0D
>  =0D
> +/// Returns the ARM architecture timer frequency in Hz, if available.=0D
> +///=0D
> +/// This function queries the system-wide ARM architecture timer frequen=
cy.=0D
> +/// The architecture timer provides a consistent time source across all =
CPU cores.=0D
> +///=0D
> +/// Returns `None` if:=0D
> +/// - The ARM architecture timer is not available (`CONFIG_ARM_ARCH_TIME=
R` not enabled)=0D
> +/// - The timer rate is zero (not initialized)=0D
=0D
Can we return distinct errors for these cases and return NonZero<u32> when =
the=0D
rate is valid?=0D
=0D
> +///=0D
> +/// # Examples=0D
> +///=0D
> +/// ```=0D
> +/// use kernel::time::arch_timer_get_rate;=0D
> +///=0D
> +/// if let Some(rate) =3D arch_timer_get_rate() {=0D
> +///     // Use `rate`.=0D
> +/// }=0D
> +/// ```=0D
> +pub fn arch_timer_get_rate() -> Option<u32> {=0D
> +    // SAFETY: The C API is available in all configs; when CONFIG_ARM_AR=
CH_TIMER=0D
> +    // is disabled, the header provides a stub returning 0.=0D
> +    let rate =3D unsafe { bindings::arch_timer_get_rate() };=0D
> +    if rate =3D=3D 0 {=0D
> +        None=0D
> +    } else {=0D
> +        Some(rate)=0D
> +    }=0D
> +}=0D
> +=0D
>  impl Delta {=0D
>      /// A span of time equal to zero.=0D
>      pub const ZERO: Self =3D Self { nanos: 0 };=0D
> =0D
> -- =0D
> 2.53.0=0D
> =0D
