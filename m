Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E989FC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5129610E04C;
	Wed, 29 Jul 2026 16:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dpVBxvEt";
	dkim-atps=neutral
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7A810E04C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1785343886; x=1785603086;
 bh=Omxuft661B6Lh7zNVVMGlIeHL8DmUyOf+lDGx6PO4FI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dpVBxvEt4tGMBa79ab0reffIcO4CvSQdJwOeTU7H4/ckuvZAaRR3XViQHGmLL6PZB
 tumPUtND4OPt8R5RSnxdpA1LXBgGtjl2hjm9wQ4XcqmCJlrRSnbxQameyw7uAXxOJ3
 zMjvUu1fmvbwSk6QJs67eTTZxXJVeL+0blkXNbOkMz4XalXtBM6q7J5IiXxSmrlZGA
 bQM10F2FL7nb9bJzBejxEfpBK/n5O4jBHAbnlSvzur/OTXYqwqkx+AE6x4dqSQEThm
 3IlN6FT1Y9J4/NPy2DGi0ZwcN8Txs2jeunAReWCUa35bG8VQj4s96mBUiddsqY6ZjH
 Ey3zIWY8HFGRw==
X-Pm-Submission-Id: 4h9JJ96tPBz2Sd58
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
 kernel@collabora.com, Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v2] drm/tyr: add Job IRQ handling
Date: Wed, 29 Jul 2026 19:51:17 +0300
Message-ID: <20260729165121.768013-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com>
References: <20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com>
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

On Wed, 29 Jul 2026 11:58:29 +0200=0D
Laura Nao <laura.nao@collabora.com> wrote:=0D
=0D
> Add a threaded IRQ wrapper for Tyr interrupt sources and use it to=0D
> handle the firmware Job IRQ.=0D
> =0D
> The Job IRQ reports requests from the CSF firmware, including global=0D
> interface requests and CSG attention bits. Add a Job IRQ handler that=0D
> masks the interrupt in the primary IRQ handler, processes pending raw=0D
> status in the threaded handler, clears handled bits, and reenables the=0D
> mask before returning.=0D
> Add a wait queue and a bool flag so the handler can signal firmware=0D
> readiness when the GLB bit is set.=0D
> =0D
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> Signed-off-by: Laura Nao <laura.nao@collabora.com>=0D
> ---=0D
> This patch follows up to [1], which adds support for firmware loading=0D
> and MCU booting to the Tyr driver. The changes included here were=0D
> originally introduced in its v4[2], then dropped to reduce the scope of=0D
> the series, and have been adjusted to work with the HRT (Higher-Ranked=0D
> Lifetime Types) driver architecture recently introduced.=0D
> =0D
> The patch adds a threaded IRQ wrapper for the firmware Job interrupts,=0D
> used to signal events from the global CSF (GLB) and Command Stream Group=
=0D
> (CSG) interfaces.=0D
> =0D
> These changes will be later used to wait for global CSF interface=0D
> readiness after firmware boot, as part of the CSF firmware interfaces=0D
> support that will be submitted as a separate series.=0D
> =0D
> v1: https://lore.kernel.org/all/20260721151423.444175-1-laura.nao@collabo=
ra.com/=0D
> =0D
> Changes in v2:=0D
> - Dropped Wait custom type in favor of WaitQueue=0D
> - Renamed JobIrq lifetime to generic 'a=0D
> =0D
> This patch is based on drm-rust-next and depends on:=0D
> - [PATCH v10 0/7] drm/tyr: firmware loading and MCU boot support[1] (and =
its dependencies)=0D
> - [PATCH v2] rust: irq: make Registration compatible with lifetime-bound =
drivers[3]=0D
> - [PATCH 0/5] rust: sync: add WaitQueue infrastructure[4]=0D
> =0D
> Note: [4] doesn't apply cleanly on drm-rust-next at the moment, due to=0D
> missing changes in rust/kernel/sync/lock/spinlock.rs[5]. I've applied=0D
> all dependencies and fixed conflicts for the purpose of testing this=0D
> patch on top of drm-rust-next, a branch with these changes is available=0D
> here: https://gitlab.freedesktop.org/laura.nao/linux/-/commits/b4/tyr-irq=
-v2=0D
> =0D
> [1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@co=
llabora.com/ =0D
> [2] https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a=
5d91050789d@collabora.com/=0D
> [3] https://lore.kernel.org/rust-for-linux/20260719153631.559341-1-dakr@k=
ernel.org/=0D
> [4] https://lore.kernel.org/rust-for-linux/20260726223613.1242940-1-dakr@=
kernel.org/=0D
> [5] https://lore.kernel.org/all/20260302232154.861916-1-lyude@redhat.com/=
=0D
> ---=0D
>  drivers/gpu/drm/tyr/driver.rs |  75 ++++++++++++++++++++++++++++++=0D
>  drivers/gpu/drm/tyr/fw.rs     |   4 ++=0D
>  drivers/gpu/drm/tyr/fw/irq.rs | 106 ++++++++++++++++++++++++++++++++++++=
++++++=0D
>  3 files changed, 185 insertions(+)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s=0D
> index d78ad9d292ff..b9994aea8684 100644=0D
> --- a/drivers/gpu/drm/tyr/driver.rs=0D
> +++ b/drivers/gpu/drm/tyr/driver.rs=0D
> @@ -1,5 +1,7 @@=0D
>  // SPDX-License-Identifier: GPL-2.0 or MIT=0D
>  =0D
> +use core::marker::PhantomPinned;=0D
> +=0D
>  use kernel::{=0D
>      clk::{=0D
>          Clk,=0D
> @@ -21,6 +23,13 @@=0D
>          poll,=0D
>          Io, //=0D
>      },=0D
> +    irq::{=0D
> +        Flags,=0D
> +        IrqReturn,=0D
> +        ThreadedHandler,=0D
> +        ThreadedIrqReturn,=0D
> +        ThreadedRegistration, //=0D
> +    },=0D
>      new_mutex,=0D
>      of,=0D
>      platform,=0D
> @@ -236,3 +245,69 @@ struct Regulators {=0D
>      _mali: Regulator<regulator::Enabled>,=0D
>      _sram: Regulator<regulator::Enabled>,=0D
>  }=0D
> +=0D
> +pub(crate) trait TyrIrqTrait: Sync {=0D
> +    fn read_status(&self) -> u32;=0D
> +    fn clear_mask(&self);=0D
> +    fn reenable_mask(&self);=0D
> +    fn read_raw_status(&self) -> u32;=0D
> +    fn clear_status(&self, status: u32);=0D
> +    fn mask(&self) -> u32;=0D
> +    fn handle(&self, status: u32);=0D
> +}=0D
> +=0D
> +#[pin_data]=0D
> +pub(crate) struct TyrIrq<T: TyrIrqTrait> {=0D
> +    irq: T,=0D
> +    #[pin]=0D
> +    _pin: PhantomPinned,=0D
> +}=0D
> +=0D
> +impl<T: TyrIrqTrait> TyrIrq<T> {=0D
> +    pub(crate) fn request<'a>(=0D
> +        pdev: &'a platform::Device<Bound>,=0D
> +        name: &'static CStr,=0D
> +        irq: T,=0D
> +    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a=
>=0D
> +    where=0D
> +        T: 'a,=0D
> +    {=0D
> +        let handler =3D try_pin_init!(Self {=0D
> +            irq,=0D
> +            _pin: PhantomPinned,=0D
> +        });=0D
> +=0D
> +        // SAFETY: The resulting `PinInit` is not leaked, it is consumed=
 by the caller to=0D
> +        // initialize a pinned `ThreadedRegistration`.=0D
> +        Ok(unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, nam=
e, name, handler) })=0D
> +    }=0D
> +}=0D
> +=0D
> +impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<T> {=0D
> +    fn handle(&self) -> ThreadedIrqReturn {=0D
> +        let masked_status =3D self.irq.read_status();=0D
> +=0D
> +        if masked_status =3D=3D 0 {=0D
> +            return ThreadedIrqReturn::None;=0D
> +        }=0D
> +        self.irq.clear_mask();=0D
> +        ThreadedIrqReturn::WakeThread=0D
> +    }=0D
> +=0D
> +    fn handle_threaded(&self) -> IrqReturn {=0D
> +        let mut ret =3D IrqReturn::None;=0D
> +=0D
> +        loop {=0D
> +            let raw_status =3D self.irq.read_raw_status() & self.irq.mas=
k();=0D
> +            if raw_status =3D=3D 0 {=0D
> +                break;=0D
> +            }=0D
> +            self.irq.handle(raw_status);=0D
> +            self.irq.clear_status(raw_status);=0D
> +            ret =3D IrqReturn::Handled;=0D
> +        }=0D
> +=0D
> +        self.irq.reenable_mask();=0D
> +        ret=0D
> +    }=0D
> +}=0D
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs=0D
> index 47d25c901bd0..c425fd95bbd1 100644=0D
> --- a/drivers/gpu/drm/tyr/fw.rs=0D
> +++ b/drivers/gpu/drm/tyr/fw.rs=0D
> @@ -69,8 +69,12 @@=0D
>      vm::Vm, //=0D
>  };=0D
>  =0D
> +pub(crate) mod irq;=0D
>  mod parser;=0D
>  =0D
> +/// Maximum number of CSG interfaces supported by hardware.=0D
> +const MAX_CSG: usize =3D 16;=0D
> +=0D
>  pub(super) const CSF_MCU_SHARED_REGION_START: u32 =3D 0x04000000;=0D
>  =0D
>  #[derive(Copy, Clone, Debug, PartialEq, Eq)]=0D
> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.r=
s=0D
> new file mode 100644=0D
> index 000000000000..95077a93639c=0D
> --- /dev/null=0D
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs=0D
> @@ -0,0 +1,106 @@=0D
> +// SPDX-License-Identifier: GPL-2.0 or MIT=0D
> +=0D
> +//! IRQ handling for the Job IRQ.=0D
> +//!=0D
> +//! The Job IRQ signals events from the MCU, including global interface =
acknowledgements.=0D
> +#![allow(dead_code)]=0D
> +=0D
> +use core::sync::atomic::{=0D
> +    AtomicBool,=0D
> +    Ordering, //=0D
> +};=0D
> +=0D
> +use kernel::{=0D
> +    c_str,=0D
> +    device::Bound, //=0D
> +    io::Io,=0D
> +    irq::ThreadedRegistration,=0D
> +    platform,=0D
> +    prelude::*,=0D
> +    sync::{=0D
> +        Arc,=0D
> +        WaitQueue, //=0D
> +    },=0D
> +};=0D
> +=0D
> +use crate::{=0D
> +    driver::{=0D
> +        IoMem,=0D
> +        TyrIrq,=0D
> +        TyrIrqTrait, //=0D
> +    },=0D
> +    regs::job_control::{=0D
> +        JOB_IRQ_CLEAR,=0D
> +        JOB_IRQ_MASK,=0D
> +        JOB_IRQ_RAWSTAT,=0D
> +        JOB_IRQ_STATUS, //=0D
> +    }, //=0D
> +};=0D
> +=0D
> +const CSG_IRQ_MASK: u32 =3D (1u32 << super::MAX_CSG) - 1;=0D
> +=0D
> +pub(crate) struct JobIrq<'a> {=0D
> +    iomem: Arc<IoMem<'a>>,=0D
> +    fw_ready: Arc<AtomicBool>,=0D
> +    job_irq_wait: Arc<WaitQueue>,=0D
> +}=0D
> +=0D
> +pub(crate) fn job_irq_init<'a>(=0D
> +    pdev: &'a platform::Device<Bound>,=0D
> +    iomem: Arc<IoMem<'a>>,=0D
> +    fw_ready: Arc<AtomicBool>,=0D
> +    job_irq_wait: Arc<WaitQueue>,=0D
> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, E=
rror> + 'a> {=0D
> +    iomem.write_reg(=0D
> +        JOB_IRQ_MASK::zeroed()=0D
> +            .with_const_csg::<CSG_IRQ_MASK>()=0D
> +            .with_glb(true),=0D
> +    );=0D
> +    let job_irq =3D JobIrq {=0D
> +        iomem: iomem.clone(),=0D
> +        fw_ready,=0D
> +        job_irq_wait,=0D
> +    };=0D
> +=0D
> +    TyrIrq::request(pdev, c_str!("job"), job_irq)=0D
> +}=0D
> +=0D
> +impl TyrIrqTrait for JobIrq<'_> {=0D
> +    fn read_status(&self) -> u32 {=0D
> +        self.iomem.read(JOB_IRQ_STATUS).into_raw()=0D
> +    }=0D
> +=0D
> +    fn clear_mask(&self) {=0D
> +        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());=0D
> +    }=0D
> +=0D
> +    fn reenable_mask(&self) {=0D
> +        self.iomem.write_reg(=0D
> +            JOB_IRQ_MASK::zeroed()=0D
> +                .with_const_csg::<CSG_IRQ_MASK>()=0D
> +                .with_glb(true),=0D
> +        );=0D
> +    }=0D
> +=0D
> +    fn read_raw_status(&self) -> u32 {=0D
> +        self.iomem.read(JOB_IRQ_RAWSTAT).into_raw()=0D
> +    }=0D
> +=0D
> +    fn clear_status(&self, status: u32) {=0D
> +        self.iomem.write_reg(JOB_IRQ_CLEAR::from_raw(status));=0D
> +    }=0D
> +=0D
> +    fn mask(&self) -> u32 {=0D
> +        JOB_IRQ_MASK::zeroed()=0D
> +            .with_const_csg::<CSG_IRQ_MASK>()=0D
> +            .with_glb(true)=0D
> +            .into_raw()=0D
> +    }=0D
> +=0D
> +    fn handle(&self, status: u32) {=0D
> +        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {=0D
> +            self.fw_ready.store(true, Ordering::Release);=0D
> +            self.job_irq_wait.wake_up_all();=0D
> +        }=0D
=0D
You enable both GLB and CSG above but only handle GLB, is this intentional?=
 This=0D
means CSG will trigger the handler, do nothing and just get cleared, or am =
I=0D
missing something?=0D
=0D
Thanks,=0D
Onur=0D
=0D
> +    }=0D
> +}=0D
> =0D
> ---=0D
> base-commit: f04035d00132e898ba2e107783ac1f8419a452ac=0D
> change-id: 20260728-tyr-irq-v2-0b3c5022be33=0D
> =0D
> Best regards,=0D
> -- =0D
> Laura Nao <laura.nao@collabora.com>=0D
> =0D
