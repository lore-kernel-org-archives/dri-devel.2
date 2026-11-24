Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0A606A329
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=EqGOsOZR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF61A10E8C0;
	Tue, 24 Nov 2026 20:49:44 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C3E10EC23
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795553365; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TozeQZGyOqUFcnEUTLGcR38H8GdZ/y4eh+B5BG9Tq+1xjsfiiUk4OJ1fzxOT1dtQgKboNNX7wOKnuyCNak1EyeVeToCl8R9+vXwdgLyLPt9uH4Bs2Lwj48iZbpWRR6+AVxPKWr+Adg8ElIx6ztnjkjpj7+LwEAdJeBES7c6tLEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795553365;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9B9bTwB3nnMr+exBXeCJuZEOmi14vsPeF4NsKFNnfdY=; 
 b=TmaYPpkiC2QwXK61FYf/kARTj3SaIoTbfLlVp7i7DygzokQ9pRhabYq2q5riEc0tu92VHlnNhEiCf/87/O29USyjXEjgrj6878gcVY8TnCopsJaSjiMicHsIafYyk3Ubbg3vE56WKQfXuJ1tCOCvtx9KEwxyzR83qsPPNWjb5tE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=EqGOsOZRwTrPwDhqBVCr2cMKLazxBcp6GGvT6BUzLTK0Tc0A7K02KzXFN4tJaZ3KqNaTiTZcxIor4zmF97xEQs3+a1A2CoCGTrE9FdUY7T3L7jn0SEejAKi0UJ9t0+iEnj7gvPjE7vV245P2Efg+TqMlWeJ+Ybg1TmYucTfS/3M=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=9B9bTwB3nnMr+exBXeCJuZEOmi14vsPeF4NsKFNnfdY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795553363172222.8218597760449;
 Tue, 24 Nov 2026 12:49:23 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 3/3] drm/tyr: add Job IRQ handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v7-3-4e172e58e28c@collabora.com>
Date: Tue, 24 Nov 2026 17:49:04 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03D5FC68-0E3B-47B4-A3E4-6F2EABD54096@collabora.com>
References: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
 <20260728-tyr-irq-v2-v7-3-4e172e58e28c@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Laura,

> On 23 Nov 2026, at 11:58, Laura Nao <laura.nao@collabora.com> wrote:
>=20
> The Job IRQ reports requests from the CSF firmware, including global
> interface requests and CSG attention bits. Only the GLB bit is =
currently
> handled, as it will be used to check firmware readiness. CSG bits
> handling will be added at a later stage. The Job IRQ handler masks the
> interrupt in the primary IRQ handler, processes pending raw status in
> the threaded handler, clears the handled bits, and reenables the mask
> before returning.
> Add JobIrqEvents to hold the wait queue and the ready flag used to
> signal firmware readiness when the GLB bit is set.
>=20
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
> drivers/gpu/drm/tyr/fw.rs     |   1 +
> drivers/gpu/drm/tyr/fw/irq.rs | 148 =
++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/irq.rs    |   1 -
> 3 files changed, 149 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index f2e0404addf2..ecf2ea171bc9 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -69,6 +69,7 @@
>     vm::Vm, //
> };
>=20
> +pub(crate) mod irq;
> mod parser;
>=20
> pub(super) const CSF_MCU_SHARED_REGION_START: u32 =3D 0x04000000;
> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs =
b/drivers/gpu/drm/tyr/fw/irq.rs
> new file mode 100644
> index 000000000000..a736d8cd4374
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! IRQ handling for the Job IRQ.
> +//!
> +//! The Job IRQ signals events from the MCU, including global =
interface acknowledgements.
> +#![allow(dead_code)]

In general, please prefer expect(dead_code) instead.

> +
> +use kernel::{
> +    device::Bound, //
> +    io::Io,
> +    new_waitqueue,
> +    platform,
> +    prelude::*,
> +    sync::{
> +        atomic::{
> +            ordering,
> +            Atomic, //
> +        },
> +        Arc,
> +        WaitQueue, //
> +    },
> +    time::{
> +        Delta,
> +        Msecs, //
> +    },
> +};
> +
> +use crate::{
> +    irq::{
> +        TyrIrqRegistration,
> +        TyrIrqTrait, //
> +    },
> +    regs::job_control::{
> +        JOB_IRQ_CLEAR,
> +        JOB_IRQ_MASK,
> +        JOB_IRQ_RAWSTAT,
> +        JOB_IRQ_STATUS, //
> +    },
> +    driver::IoMem,

rustfmt produces a (small) diff here.

> +    reset::HwGate, //
> +};
> +
> +/// The firmware events published by the Job IRQ handler, and the =
queue used to announce them.
> +#[pin_data]
> +pub(crate) struct JobIrqEvents {
> +    #[pin]
> +    wait: WaitQueue,
> +    /// Set once the firmware has signalled that the global interface =
is ready.
> +    ready: Atomic<bool>,
> +}
> +
> +impl JobIrqEvents {
> +    /// Creates a new, empty set of Job IRQ events.
> +    pub(crate) fn new() -> Result<Arc<Self>> {

There is an ongoing effort[0] to get rid of Arcs in places they are not =
needed
using self-ref pin init.

Since I expect other users to be able to take a reference to this field =
as
applicable, lets drop this Arc for the time being.


> +        Arc::pin_init(
> +            pin_init!(JobIrqEvents {
> +                wait <- new_waitqueue!(),
> +                ready: Atomic::new(false),
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +
> +    /// Clears the firmware-ready state.
> +    #[expect(dead_code)]
> +    pub(crate) fn clear_ready(&self) {
> +        self.ready.store(false, ordering::Relaxed);
> +    }
> +
> +    /// Waits until the firmware signals readiness via the GLB IRQ =
bit, or the timeout expires.
> +    pub(crate) fn wait_ready(&self, timeout_ms: Msecs) -> Result {
> +        self.wait.wait_event_timeout(
> +            || self.ready.load(ordering::Acquire),
> +            =
Delta::from_millis(timeout_ms.into()).to_jiffies_timeout(),
> +        )?;
> +
> +        Ok(())
> +    }
> +
> +    /// Updates state and wakes up waiters
> +    fn signal(&self, status: u32) {
> +        // TODO: handle other Job IRQ events (e.g. CSG attention =
bits) here once
> +        // support for them is added.
> +
> +        // The GLB bit only signals firmware readiness once, at power =
up
> +        if JOB_IRQ_RAWSTAT::from_raw(status).glb() && =
!self.ready.load(ordering::Relaxed) {
> +            self.ready.store(true, ordering::Release);
> +        }
> +
> +        self.wait.wake_up_all();
> +    }
> +}
> +
> +// The Job IRQ, signalling requests or notification from the MCU.
> +pub(crate) struct JobIrq {
> +    /// Firmware events signalled by this IRQ.
> +    events: Arc<JobIrqEvents>,

If we get rid of the Arc, this would become=20

events: &=E2=80=98a JobIrqEvents.



> +}
> +
> +
> +/// Requests a threaded IRQ registration for the Job IRQ.
> +///
> +/// # Safety
> +///
> +/// Callers must not `mem::forget()` the resulting registration or =
otherwise prevent its
> +/// [`Drop`] implementation from running.
> +pub(crate) unsafe fn job_irq_init<'a>(
> +    pdev: &'a platform::Device<Bound>,
> +    hw: Arc<HwGate<'a>>,
> +    events: Arc<JobIrqEvents>,
> +) -> Result<Pin<KBox<TyrIrqRegistration<'a, JobIrq>>>> {
> +    let job_irq =3D JobIrq { events };
> +    // Ensure interrupt sources are disabled until the handler is =
registered.
> +    job_irq.clear_mask(hw.access().iomem());
> +
> +    // SAFETY: The caller guarantees the resulting registration will =
not be leaked.
> +    unsafe { TyrIrqRegistration::request(pdev, c"job", job_irq, hw) }
> +}
> +
> +impl TyrIrqTrait for JobIrq {
> +    fn read_status(&self, io: &IoMem<'_>) -> u32 {
> +        io.read(JOB_IRQ_STATUS).into_raw()
> +    }
> +
> +    fn clear_mask(&self, io: &IoMem<'_>) {
> +        io.write_reg(JOB_IRQ_MASK::zeroed());
> +    }
> +
> +    fn reenable_mask(&self, io: &IoMem<'_>) {
> +        io.write_reg(JOB_IRQ_MASK::from_raw(self.mask()));
> +    }
> +
> +    fn read_raw_status(&self, io: &IoMem<'_>) -> u32 {
> +        io.read(JOB_IRQ_RAWSTAT).into_raw()
> +    }
> +
> +    fn clear_status(&self, io: &IoMem<'_>, status: u32) {
> +        io.write_reg(JOB_IRQ_CLEAR::from_raw(status));
> +    }
> +
> +    fn mask(&self) -> u32 {
> +        JOB_IRQ_MASK::zeroed().with_glb(true).into_raw()
> +    }
> +
> +    fn handle(&self, status: u32) {
> +        self.events.signal(status);
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/irq.rs b/drivers/gpu/drm/tyr/irq.rs
> index 4a065c6272c5..5632f50b0a13 100644
> --- a/drivers/gpu/drm/tyr/irq.rs
> +++ b/drivers/gpu/drm/tyr/irq.rs
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0 or MIT
>=20
> //! Threaded IRQ wrapper shared by all Tyr interrupt sources.
> -#![allow(dead_code)]
> use core::marker::PhantomPinned;
>=20
> use kernel::{
>=20
> --=20
> 2.39.5
>=20
>=20

With the changes,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

[0]: =
https://lore.kernel.org/rust-for-linux/DN2ZFO94BZMF.2XTCCKEUDLZSB@kernel.o=
rg/T/#t

