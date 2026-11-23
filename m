Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B2606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=gFPI4GSc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951FF10E640;
	Mon, 23 Nov 2026 18:13:52 +0000 (UTC)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E1E10E640
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1795457620; x=1795716820;
 bh=x0kr1cDZLM2J/Od71XUbuvFQlM07AOKq8fnDsRaeOtU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gFPI4GSceUGJhtUhlapm287AolRPmbwLr5a1cW2eyfZonamk0YS4kTzo1GbwAYpq0
 E/ZrAClPeggrU84oX23s9ZvSte8XqnGyFJn1scVmTa1UMhPGQkGSGZhydEippq/C8c
 wcjdLmEUMC8XWPF24oxh7K30ERPqU17T6e+RVD0jd6wWHkTkStQ6mGCr5N2jW2dWb1
 4Htenj2vXj1CXO4PLfvx1OI1Dru0wdXCeyHnPVig1lDatGcqcdyptoH8MxiCSWhkWt
 qfd7hoxpPP5o4to0RA5Pw008DI8zMMjjDhecCntf12IV0yZb8Dh0tjnXf9EOfz/ioO
 pw+4dCB4ZwcXA==
X-Pm-Submission-Id: 4jYDb42p0Qz1DDKY
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Laura Nao <laura.nao@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 kernel@collabora.com, Onur Ozkan <work@onurozkan.dev>
Subject: Re: [PATCH v7 1/3] drm/tyr: add HwGate::try_access_atomic()
Date: Mon, 23 Nov 2026 21:13:31 +0300
Message-ID: <20261123181334.18856-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260728-tyr-irq-v2-v7-1-4e172e58e28c@collabora.com>
References: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
 <20260728-tyr-irq-v2-v7-1-4e172e58e28c@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 15:58:45 +0100=0D
Laura Nao <laura.nao@collabora.com> wrote:=0D
=0D
> From: Daniel Almeida <daniel.almeida@collabora.com>=0D
> =0D
> HwGate::access() takes gate_lock, which is a mutex, so it cannot be=0D
> called from atomic context. IRQ handlers need to access the GPU=0D
> registers, and those are only reachable through the gate.=0D
> =0D
> Add HwGate::try_access_atomic(). It enters SRCU without taking gate_lock=
=0D
> and returns None if the reset worker has closed the gate. close() now=0D
> sets a closed flag before waiting for SRCU readers, and HwClosedGuard=0D
> clears it when dropped. SRCU guarantees that a reader either sees the=0D
> flag set or is waited for.=0D
> =0D
> An IRQ handler that gets None cannot acknowledge its interrupt, so its=0D
> interrupt has to stay masked while the gate is closed. Document this on=0D
> close(). No caller needs to do this yet: the only reset runs at probe,=0D
> before any IRQ handler is registered.=0D
> =0D
> There are no users yet. The Job IRQ handler will be the first one.=0D
> =0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
=0D
LGTM=0D
=0D
Reviewed-by: Onur Ozkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  drivers/gpu/drm/tyr/reset/hw_gate.rs | 55 ++++++++++++++++++++++++++++++=
++++--=0D
>  1 file changed, 53 insertions(+), 2 deletions(-)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs b/drivers/gpu/drm/tyr/r=
eset/hw_gate.rs=0D
> index 201f8c953078..40b38f07c472 100644=0D
> --- a/drivers/gpu/drm/tyr/reset/hw_gate.rs=0D
> +++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs=0D
> @@ -6,10 +6,18 @@=0D
>  //! access with reset. Readers hold the mutex while entering SRCU, then =
release=0D
>  //! it before accessing hardware. The reset worker holds the mutex while=
 waiting=0D
>  //! for admitted readers and resetting hardware.=0D
> +//!=0D
> +//! Readers that cannot sleep use [`HwGate::try_access_atomic`] instead.=
 It=0D
> +//! enters SRCU without taking the mutex and fails if the reset worker h=
as set=0D
> +//! `closed`, which it does before waiting for readers.=0D
>  =0D
>  use kernel::{=0D
>      prelude::*,=0D
>      sync::{=0D
> +        atomic::{=0D
> +            Atomic,=0D
> +            Relaxed, //=0D
> +        },=0D
>          new_mutex,=0D
>          srcu,=0D
>          Mutex,=0D
> @@ -32,6 +40,9 @@ pub(crate) struct HwGate<'hw> {=0D
>      /// Drains readers that entered before the reset worker acquired `ga=
te_lock`.=0D
>      #[pin]=0D
>      srcu: Srcu,=0D
> +    /// Set while the reset worker owns the hardware. Checked by readers=
 that=0D
> +    /// cannot take `gate_lock`.=0D
> +    closed: Atomic<bool>,=0D
>  }=0D
>  =0D
>  impl<'hw> HwGate<'hw> {=0D
> @@ -41,6 +52,7 @@ pub(crate) fn new(iomem: IoMem<'hw>) -> impl PinInit<Se=
lf, Error> {=0D
>              iomem,=0D
>              gate_lock <- new_mutex!(()),=0D
>              srcu <- kernel::new_srcu!(),=0D
> +            closed: Atomic::new(false),=0D
>          })=0D
>      }=0D
>  =0D
> @@ -60,15 +72,45 @@ pub(crate) fn access(&self) -> HwAccessGuard<'_, 'hw>=
 {=0D
>          }=0D
>      }=0D
>  =0D
> +    /// Enters a reset-sensitive hardware-access section without sleepin=
g.=0D
> +    ///=0D
> +    /// Returns `None` while the reset worker owns the hardware, in whic=
h case=0D
> +    /// the caller must skip its hardware access.=0D
> +    #[expect(dead_code)]=0D
> +    pub(crate) fn try_access_atomic(&self) -> Option<HwAccessGuard<'_, '=
hw>> {=0D
> +        let srcu =3D self.srcu.read_lock();=0D
> +=0D
> +        // `close()` sets `closed` before waiting for readers, so SRCU g=
uarantees=0D
> +        // that this reader either sees it set or is waited for.=0D
> +        if self.closed.load(Relaxed) {=0D
> +            return None;=0D
> +        }=0D
> +=0D
> +        Some(HwAccessGuard {=0D
> +            gate: self,=0D
> +            _srcu: srcu,=0D
> +        })=0D
> +    }=0D
> +=0D
>      /// Stops new readers and drains admitted readers for the reset work=
er.=0D
>      ///=0D
>      /// Callers must serialize write-side access. The reset controller's=
 state=0D
>      /// machine provides that serialization.=0D
> +    ///=0D
> +    /// An IRQ handler that uses [`HwGate::try_access_atomic`] cannot ac=
knowledge=0D
> +    /// its interrupt while the gate is closed. Callers must mask such a=
n=0D
> +    /// interrupt before closing the gate and keep it masked until the g=
ate=0D
> +    /// reopens.=0D
>      pub(super) fn close(&self) -> HwClosedGuard<'_, 'hw> {=0D
>          let gate_lock =3D self.gate_lock.lock();=0D
>  =0D
> -        // Holding `gate_lock` prevents new readers from entering SRCU. =
Readers=0D
> -        // admitted before us are enrolled, so wait for their read-side =
work.=0D
> +        // Stop `try_access_atomic()` readers. This must happen before w=
aiting=0D
> +        // for readers below.=0D
> +        self.closed.store(true, Relaxed);=0D
> +=0D
> +        // Holding `gate_lock` prevents new readers from entering SRCU t=
hrough=0D
> +        // `access()`. Readers admitted before us are enrolled, so wait =
for their=0D
> +        // read-side work.=0D
>          self.srcu.synchronize();=0D
>  =0D
>          HwClosedGuard {=0D
> @@ -104,3 +146,12 @@ pub(super) fn iomem(&self) -> &IoMem<'hw> {=0D
>          &self.gate.iomem=0D
>      }=0D
>  }=0D
> +=0D
> +impl Drop for HwClosedGuard<'_, '_> {=0D
> +    fn drop(&mut self) {=0D
> +        // Reopen for `try_access_atomic()`. A reader that races with th=
is and=0D
> +        // still sees `closed` set returns `None`, as it would have befo=
re the=0D
> +        // store.=0D
> +        self.gate.closed.store(false, Relaxed);=0D
> +    }=0D
> +}=0D
> =0D
> -- =0D
> 2.39.5=0D
> =0D
