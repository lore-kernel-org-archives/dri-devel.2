Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D492FFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC9F10E07D;
	Mon, 27 Apr 2026 09:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="X9RD7YJN";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919F010E07D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1777280903; x=1777540103;
 bh=uvNSzDN5dpXMTauO2A7BaiLIsSpbvnB6CUsJgTwXpak=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=X9RD7YJNWNuqauesnc9e9Subqfrd8gTF+2P1L4PYDLy/gBVbbjo09i4fIX+PbwEZM
 BQH6LmwIo6xdZRxvBwbTUj5lSUWTEf2eaxxnYdt5As4LxaJLxp/Bm9P/ei/6MsOQTw
 1nFRwrEW9+/Bbv6q6jDYwqqyroptjhmmB2MDPF7VOSq1/jM1aDY/HXKL5otCJ+Llg0
 j8jilzlVajZNMfatfxdgWxJhmgi0tlNmdhvKHzbghEkZKvPXP71saVD2FBNxmpEnAB
 agviRzxYFvxHeGmSBkghvjEshxZNm6hJdfJd+HUbv7nXvhZt/YX2/Vyu7Yu/zsohT3
 Trb1CIensDlaQ==
X-Pm-Submission-Id: 4g3yQq25kjz1DFFW
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
Subject: Re: [PATCH v4 18/20] drm/tyr: add CSF firmware interface support
Date: Mon, 27 Apr 2026 12:08:16 +0300
Message-ID: <20260427090818.112428-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260424-b4-fw-boot-v4-v4-18-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-18-a5d91050789d@collabora.com>
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

On Fri, 24 Apr 2026 16:39:12 -0700=0D
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:=0D
=0D
> Add initial support for the Command Stream Frontend (CSF) firmware=0D
> interfaces, enabling communication between the driver and the MCU through=
=0D
> shared memory.=0D
> =0D
> Implement the global (GLB), command stream group (CSG), and command strea=
m=0D
> (CS) interfaces. These provide access to the firmware control, input, and=
=0D
> output blocks and allow discovery of the available CSGs and CSs at=0D
> runtime.=0D
> =0D
> Store the global interface in the firmware state and initialize it after=
=0D
> firmware boot during probe.=0D
> =0D
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>=0D
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>=0D
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> ---=0D
>  drivers/gpu/drm/tyr/driver.rs        |    2 +-=0D
>  drivers/gpu/drm/tyr/fw.rs            |   62 +-=0D
>  drivers/gpu/drm/tyr/fw/interfaces.rs | 2005 ++++++++++++++++++++++++++++=
++++++=0D
>  drivers/gpu/drm/tyr/gem.rs           |    5 +=0D
>  4 files changed, 2061 insertions(+), 13 deletions(-)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s=0D
> index 3225385cd511..20ae114a4180 100644=0D
> --- a/drivers/gpu/drm/tyr/driver.rs=0D
> +++ b/drivers/gpu/drm/tyr/driver.rs=0D
> @@ -189,10 +189,10 @@ fn probe(=0D
>          devres::register(pdev.as_ref(), job_irq, GFP_KERNEL)?;=0D
>  =0D
>          firmware.boot()?;=0D
> -=0D
>          firmware=0D
>              .wait_ready(1000)=0D
>              .inspect_err(|_| pr_err!("Timed out waiting for firmware to =
be ready.\n"))?;=0D
> +        firmware.enable_global_interface()?;=0D
>  =0D
>          let data =3D try_pin_init!(TyrDrmDeviceData {=0D
>                  pdev: platform.clone(),=0D
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs=0D
> index 14815cdafac8..598e399a58ae 100644=0D
> --- a/drivers/gpu/drm/tyr/fw.rs=0D
> +++ b/drivers/gpu/drm/tyr/fw.rs=0D
> @@ -36,7 +36,8 @@=0D
>      str::CString,=0D
>      sync::{=0D
>          Arc,=0D
> -        ArcBorrow, //=0D
> +        ArcBorrow,=0D
> +        Mutex, //=0D
>      },=0D
>      time,=0D
>      types::ARef, //=0D
> @@ -47,9 +48,12 @@=0D
>          IoMem,=0D
>          TyrDrmDevice, //=0D
>      },=0D
> -    fw::parser::{=0D
> -        FwParser,=0D
> -        ParsedSection, //=0D
> +    fw::{=0D
> +        interfaces::GlobalInterface,=0D
> +        parser::{=0D
> +            FwParser,=0D
> +            ParsedSection, //=0D
> +        },=0D
>      },=0D
>      gem,=0D
>      gem::{=0D
> @@ -73,12 +77,16 @@=0D
>      }, //=0D
>  };=0D
>  =0D
> +mod interfaces;=0D
>  pub(crate) mod irq;=0D
>  mod parser;=0D
>  =0D
>  /// Maximum number of CSG interfaces supported by hardware.=0D
>  const MAX_CSG: usize =3D 16;=0D
>  =0D
> +/// Maximum number of CS interfaces supported by hardware.=0D
> +const MAX_CS: usize =3D 16;=0D
> +=0D
>  impl_flags!(=0D
>      #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]=0D
>      pub(super) struct SectionFlags(u32);=0D
> @@ -100,6 +108,11 @@ pub(super) enum SectionFlag {=0D
>  =0D
>  pub(super) const CACHE_MODE_MASK: SectionFlags =3D SectionFlags(genmask_=
u32(3..=3D4));=0D
>  =0D
> +/// MCU virtual address where the CSF shared memory region starts.=0D
> +///=0D
> +/// This region contains the firmware interface structures for communica=
tion between=0D
> +/// the CPU driver and MCU firmware, including the GLB_CONTROL_BLOCK at =
this base address.=0D
> +/// The firmware binary contains a section marked to be loaded at this a=
ddress.=0D
>  pub(super) const CSF_MCU_SHARED_REGION_START: u32 =3D 0x04000000;=0D
>  =0D
>  impl SectionFlags {=0D
> @@ -129,18 +142,18 @@ fn try_from(value: u32) -> Result<Self, Self::Error=
> {=0D
>  }=0D
>  =0D
>  /// A parsed section of the firmware binary.=0D
> -struct Section {=0D
> +pub(crate) struct Section {=0D
>      // Raw firmware section data for reset purposes=0D
>      #[expect(dead_code)]=0D
>      data: KVec<u8>,=0D
>  =0D
>      // Keep the BO backing this firmware section so that both the=0D
>      // GPU mapping and CPU mapping remain valid until the Section is dro=
pped.=0D
> -    #[expect(dead_code)]=0D
>      mem: gem::KernelBo,=0D
>  }=0D
>  =0D
>  /// Loaded firmware with sections mapped into MCU VM.=0D
> +#[pin_data(PinnedDrop)]=0D
>  pub(crate) struct Firmware {=0D
>      /// Platform device reference (needed to access the MCU JOB_IRQ regi=
sters).=0D
>      pdev: ARef<platform::Device>,=0D
> @@ -152,7 +165,6 @@ pub(crate) struct Firmware {=0D
>      vm: Arc<Vm>,=0D
>  =0D
>      /// List of firmware sections.=0D
> -    #[expect(dead_code)]=0D
>      sections: KVec<Section>,=0D
>  =0D
>      /// A condvar representing a wait on a firmware event.=0D
> @@ -160,10 +172,15 @@ pub(crate) struct Firmware {=0D
>  =0D
>      /// Latched to `true` by the IRQ handler when the firmware signals r=
eadiness via the GLB bit.=0D
>      pub(crate) fw_ready: Arc<AtomicBool>,=0D
> +=0D
> +    /// The global FW interface.=0D
> +    #[pin]=0D
> +    global_iface: Mutex<GlobalInterface>,=0D
>  }=0D
>  =0D
> -impl Drop for Firmware {=0D
> -    fn drop(&mut self) {=0D
> +#[pinned_drop]=0D
> +impl PinnedDrop for Firmware {=0D
> +    fn drop(self: Pin<&mut Self>) {=0D
>          // AS slots retain a VM ref, we need to kill the circular ref ma=
nually.=0D
>          self.vm.kill();=0D
>      }=0D
> @@ -258,21 +275,36 @@ pub(crate) fn new(=0D
>              sections.push(Section { data, mem }, GFP_KERNEL)?;=0D
>          }=0D
>  =0D
> -        let firmware =3D Arc::new(=0D
> -            Firmware {=0D
> +        let firmware =3D Arc::pin_init(=0D
> +            try_pin_init!(Firmware {=0D
>                  pdev: pdev.into(),=0D
>                  iomem,=0D
>                  vm,=0D
>                  sections,=0D
>                  ready_wait: new_wait!()?,=0D
>                  fw_ready: Arc::new(AtomicBool::new(false), GFP_KERNEL)?,=
=0D
> -            },=0D
> +                global_iface <- new_mutex!(GlobalInterface::new()?),=0D
> +            }),=0D
>              GFP_KERNEL,=0D
>          )?;=0D
>  =0D
>          Ok(firmware)=0D
>      }=0D
>  =0D
> +    /// Get the shared memory section containing firmware interface stru=
ctures.=0D
> +    pub(crate) fn shared_section(&self) -> Result<&Section> {=0D
> +        self.sections=0D
> +            .iter()=0D
> +            .find(|section| section.mem.va_range().start =3D=3D u64::fro=
m(CSF_MCU_SHARED_REGION_START))=0D
> +            .ok_or_else(|| {=0D
> +                pr_err!(=0D
> +                    "CSF shared section not found at 0x{:08x}\n",=0D
> +                    CSF_MCU_SHARED_REGION_START=0D
> +                );=0D
> +                EINVAL=0D
> +            })=0D
> +    }=0D
> +=0D
>      pub(crate) fn boot(&self) -> Result {=0D
>          // SAFETY: Boot is currently only called in the probe path, so w=
e're sure we have a bound=0D
>          // device.=0D
> @@ -303,4 +335,10 @@ pub(crate) fn wait_ready(&self, timeout_ms: u32) -> =
Result {=0D
>              }=0D
>          })=0D
>      }=0D
> +=0D
> +    /// Enable the global interface.=0D
> +    pub(crate) fn enable_global_interface(&self) -> Result {=0D
> +        let shared_section =3D self.shared_section()?;=0D
> +        self.global_iface.lock().enable(shared_section)=0D
> +    }=0D
>  }=0D
> diff --git a/drivers/gpu/drm/tyr/fw/interfaces.rs b/drivers/gpu/drm/tyr/f=
w/interfaces.rs=0D
> new file mode 100644=0D
> index 000000000000..07cdb1c76a3f=0D
> --- /dev/null=0D
> +++ b/drivers/gpu/drm/tyr/fw/interfaces.rs=0D
> @@ -0,0 +1,2005 @@=0D
> +// SPDX-License-Identifier: GPL-2.0 or MIT=0D
> +=0D
> +//! Code to control the global interface of the CSF firmware.=0D
> +//!=0D
> +//! For abbreviation definitions (CEU, CS, CSF, CSG, CSHW, GLB, JASID, M=
CU, MMU), see the top-level=0D
> +//! module documentation in [`crate::regs`].=0D
> +//!=0D
> +//! # Interface Overview=0D
> +//!=0D
> +//! Tyr interacts with the CSF firmware running on the MCU through share=
d memory=0D
> +//! interfaces. The CSF manages job submission via a hierarchy of:=0D
> +//! - **GLB**: Global interface - controls operations common to all CSs=
=0D
> +//! - **CSG**: Command Stream Groups - groups of related command streams=
=0D
> +//! - **CS**: Command Streams - individual sequences of GPU commands=0D
> +//!=0D
> +//! ```=0D
> +//! =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90=0D
> +//! =E2=94=82 GPU                                      =E2=94=82=0D
> +//! =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =
=E2=94=82=0D
> +//! =E2=94=82 =E2=94=82 MMU =E2=94=82 =E2=94=82  CSF                    =
     =E2=94=82 =E2=94=82=0D
> +//! =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98 =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90       =E2=94=
=82 =E2=94=82=0D
> +//! =E2=94=82         =E2=94=82 =E2=94=82 CSHW (CEU) =E2=94=82 =E2=94=82=
 MCU =E2=94=82       =E2=94=82 =E2=94=82=0D
> +//! =E2=94=82         =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98       =E2=94=82 =E2=94=82=0D
> +//! =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=98=0D
> +//!           =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 Shared Memory            =E2=94=82 =E2=
=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90 =E2=94=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=82  CSG0  =E2=94=82 =E2=94=82GL=
B =E2=94=82 =E2=94=82 FW =E2=94=82 =E2=94=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =
=E2=94=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82CS0 =E2=94=82 =E2=
=94=82               =E2=94=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98 =E2=94=82               =E2=94=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98               =E2=94=
=82 =E2=94=82=0D
> +//!           =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82=0D
> +//!           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98=0D
> +//!                          =E2=94=82=0D
> +//!                      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90=0D
> +//!                      =E2=94=82  Tyr  =E2=94=82=0D
> +//!                      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98=0D
> +//! ```=0D
> +//!=0D
> +=0D
> +use crate::fw::Section;=0D
> +use iface::FwInterface;=0D
> +use kernel::{=0D
> +    io::Io,=0D
> +    prelude::*, //=0D
> +};=0D
> +=0D
> +            }=0D
=0D
[...]=0D
=0D
> +        }=0D
> +    }=0D
> +}=0D
> +=0D
> +use cs::*;=0D
> +use csg::*;=0D
> +use glb::{=0D
> +    control::*,=0D
> +    *, //=0D
> +};=0D
=0D
Any reason having these imports at middle of the module?=0D
=0D
> +=0D
> +/// State of the global interface.=0D
> +enum GlobalInterfaceState {=0D
> +    /// Interface is not yet initialized.=0D
> +    Disabled,=0D
> +    /// Interface is initialized and operational.=0D
> +    Enabled(EnabledGlobalInterface),=0D
> +}=0D
> +=0D
> +/// When enabled, the Global Interface has control,=0D
> +/// input, and output system memory interfaces, as well as=0D
> +/// the discovered CSG interfaces.=0D
> +#[expect(dead_code)]=0D
> +struct EnabledGlobalInterface {=0D
> +    /// Control block interface - provides version, features, and CSG di=
scovery.=0D
> +    glb_control: FwInterface<GLB_CONTROL_BLOCK_SIZE>,=0D
> +    /// Input block interface - driver writes requests here.=0D
> +    glb_input: FwInterface<GLB_INPUT_BLOCK_SIZE>,=0D
> +    /// Output block interface - firmware writes acknowledgements here.=
=0D
> +    glb_output: FwInterface<GLB_OUTPUT_BLOCK_SIZE>,=0D
> +    /// Runtime stride between CSG control blocks (read from GLB_GROUP_S=
TRIDE).=0D
> +    csg_stride: usize,=0D
> +    /// Number of CSG interfaces reported by hardware.=0D
> +    csg_num: usize,=0D
> +    /// Discovered CSG interfaces.=0D
> +    csg: KVec<CsgInterface>,=0D
> +}=0D
> +=0D
> +/// Global CSF Interface=0D
> +///=0D
> +/// The CSF controls operations that are common to all CSs.=0D
> +pub(super) struct GlobalInterface {=0D
> +    /// Current interface state (Disabled or Enabled).=0D
> +    state: GlobalInterfaceState,=0D
> +}=0D
> +=0D
> +impl GlobalInterface {=0D
> +    /// Creates a new CSF global interface, initially disabled.=0D
> +    pub(super) fn new() -> Result<Self> {=0D
> +        Ok(Self {=0D
> +            state: GlobalInterfaceState::Disabled,=0D
> +        })=0D
> +    }=0D
> +=0D
> +    /// Enables the global interface and discovers the CSG interfaces.=0D
> +    ///=0D
> +    /// This reads the firmware's control block to set up the global inp=
ut/output=0D
> +    /// interfaces; it configures timers and shader core allocation; and=
 it discovers=0D
> +    /// available CSG interfaces.=0D
> +    pub(crate) fn enable(&mut self, shared_section: &Section) -> Result =
{=0D
> +        let vmap =3D shared_section.mem.bo.owned_vmap::<0>()?;=0D
> +        let va_range =3D shared_section.mem.va_range();=0D
> +=0D
> +        let glb_control =3D=0D
> +            FwInterface::<GLB_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range,=
 va_range.start)?;=0D
> +=0D
> +        let version =3D glb_control.read(GLB_VERSION);=0D
> +        if version.major().get() =3D=3D 0 {=0D
> +            pr_err!("CSF interface version is 0. Firmware may have faile=
d to boot.\n");=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +        pr_info!(=0D
> +            "CSF interface version: {}.{}.{}\n",=0D
> +            version.major().get(),=0D
> +            version.minor().get(),=0D
> +            version.patch().get()=0D
> +        );=0D
> +=0D
> +        let input_va =3D glb_control.read(GLB_INPUT_VA);=0D
> +        let glb_input =3D FwInterface::<GLB_INPUT_BLOCK_SIZE>::new(=0D
> +            &vmap,=0D
> +            &va_range,=0D
> +            input_va.value().get().into(),=0D
> +        )?;=0D
> +=0D
> +        let output_va =3D glb_control.read(GLB_OUTPUT_VA);=0D
> +        let glb_output =3D FwInterface::<GLB_OUTPUT_BLOCK_SIZE>::new(=0D
> +            &vmap,=0D
> +            &va_range,=0D
> +            output_va.value().get().into(),=0D
> +        )?;=0D
> +=0D
> +        // Read how many CSG interfaces exist.=0D
> +        let csg_num =3D glb_control.read(GLB_GROUP_NUM).value().get();=0D
> +=0D
> +        // Read the stride between CSG control blocks.=0D
> +        let csg_stride =3D glb_control.read(GLB_GROUP_STRIDE).value().ge=
t() as usize;=0D
> +=0D
> +        if csg_stride < CSG_CONTROL_BLOCK_SIZE {=0D
> +            pr_err!(=0D
> +                "CSG stride {} is smaller than control block size {}\n",=
=0D
> +                csg_stride,=0D
> +                CSG_CONTROL_BLOCK_SIZE=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        // Validate the CSG number reported.=0D
> +        if csg_num as usize > super::MAX_CSG {=0D
> +            pr_err!(=0D
> +                "Too many CSGs: hardware reports {}, max supported {}\n"=
,=0D
> +                csg_num,=0D
> +                super::MAX_CSG=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let enabled =3D EnabledGlobalInterface {=0D
> +            glb_control,=0D
> +            glb_input,=0D
> +            glb_output,=0D
> +            csg_stride,=0D
> +            csg_num: csg_num as usize,=0D
> +            csg: KVec::with_capacity(csg_num as usize, GFP_KERNEL)?,=0D
> +        };=0D
> +=0D
> +        self.state =3D GlobalInterfaceState::Enabled(enabled);=0D
> +        self.init_csg(shared_section)?;=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    /// Initialize CSG interfaces.=0D
> +    ///=0D
> +    /// This uses the previously read CSG count to create and enable eac=
h CSG interface.=0D
> +    fn init_csg(&mut self, shared_section: &Section) -> Result {=0D
> +        let enabled =3D match &mut self.state {=0D
> +            GlobalInterfaceState::Enabled(e) =3D> e,=0D
> +            GlobalInterfaceState::Disabled =3D> return Err(EINVAL),=0D
> +        };=0D
> +=0D
> +        for csg_idx in 0..enabled.csg_num {=0D
> +            // Create and enable the CSG interface.=0D
> +            let mut csg =3D CsgInterface::new(csg_idx)?;=0D
> +            csg.enable(shared_section, csg_idx, enabled.csg_stride)?;=0D
> +=0D
> +            enabled.csg.push(csg, GFP_KERNEL)?;=0D
> +        }=0D
> +=0D
> +        Ok(())=0D
> +    }=0D
> +}=0D
> +=0D
> +/// State of a CSG interface.=0D
> +enum CsgInterfaceState {=0D
> +    /// Interface is not yet initialized.=0D
> +    Disabled,=0D
> +    /// Interface is initialized and operational.=0D
> +    Enabled(EnabledCsgInterface),=0D
> +}=0D
> +=0D
> +/// When enabled, a CSG Interface has control, input, and output system =
memory interfaces.=0D
> +struct EnabledCsgInterface {=0D
> +    /// Control block interface - provides CSG capabilities and configur=
ation.=0D
> +    #[expect(dead_code)]=0D
> +    csg_control: FwInterface<CSG_CONTROL_BLOCK_SIZE>,=0D
> +    /// Input block interface - driver writes CSG requests here.=0D
> +    #[expect(dead_code)]=0D
> +    csg_input: FwInterface<CSG_INPUT_BLOCK_SIZE>,=0D
> +    /// Output block interface - firmware writes CSG acknowledgements he=
re.=0D
> +    #[expect(dead_code)]=0D
> +    csg_output: FwInterface<CSG_OUTPUT_BLOCK_SIZE>,=0D
> +    /// Runtime stride between CS control blocks (read from GROUP_STREAM=
_STRIDE).=0D
> +    cs_stride: usize,=0D
> +    /// Number of CS interfaces reported by hardware for this CSG.=0D
> +    cs_num: usize,=0D
> +    /// Discovered CS interfaces.=0D
> +    cs: KVec<CsInterface>,=0D
> +}=0D
> +=0D
> +/// Command Stream Group Interface=0D
> +///=0D
> +/// The CSG interface controls operations for a specific CSG.=0D
> +pub(crate) struct CsgInterface {=0D
> +    /// Current interface state (Disabled or Enabled).=0D
> +    state: CsgInterfaceState,=0D
> +    /// CSG identifier/index number.=0D
> +    #[expect(dead_code)]=0D
> +    csg_idx: usize,=0D
> +}=0D
> +=0D
> +impl CsgInterface {=0D
> +    /// Creates a new disabled CSG interface.=0D
> +    pub(super) fn new(csg_idx: usize) -> Result<Self> {=0D
> +        Ok(Self {=0D
> +            state: CsgInterfaceState::Disabled,=0D
> +            csg_idx,=0D
> +        })=0D
> +    }=0D
> +=0D
> +    /// Enables the CSG interface.=0D
> +    ///=0D
> +    /// This calculates the runtime offset of this CSG's control block a=
nd creates=0D
> +    /// a bounded interface to access it. It then reads the input/output=
 interface=0D
> +    /// addresses from the CSG control block.=0D
> +    fn enable(&mut self, shared_section: &Section, csg_idx: usize, csg_s=
tride: usize) -> Result {=0D
> +        use csg::control::{=0D
> +            GROUP_INPUT_VA,=0D
> +            GROUP_OUTPUT_VA,=0D
> +            GROUP_STREAM_NUM,=0D
> +            GROUP_STREAM_STRIDE, //=0D
> +        };=0D
> +        use kernel::io::Io;=0D
=0D
Why are these imported inside the function? This is usually done when the=0D
function is gated behind a feature flag to avoid clippy warnings when featu=
res=0D
are disabled, but that doesn't seem to be the case here.=0D
=0D
> +=0D
> +        let vmap =3D shared_section.mem.bo.owned_vmap::<0>()?;=0D
> +        let va_range =3D shared_section.mem.va_range();=0D
> +=0D
> +        // Calculate the runtime offset for this CSG's control block.=0D
> +        // The CSG control blocks start at CSG_GROUP_CONTROL_OFFSET from=
 the GLB control block,=0D
> +        // with each CSG spaced by csg_stride bytes.=0D
> +        let csg_control_offset =3D CSG_GROUP_CONTROL_OFFSET + csg_idx * =
csg_stride;=0D
> +=0D
> +        // The CSG control block's MCU virtual address is relative to th=
e shared section start.=0D
> +        let csg_control_va =3D va_range.start + csg_control_offset as u6=
4;=0D
> +=0D
> +        // Create a bounded interface for this CSG's control block at th=
e calculated address.=0D
> +        let csg_control =3D=0D
> +            FwInterface::<CSG_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range,=
 csg_control_va)?;=0D
> +=0D
> +        // Read the input and output VAs from the CSG control block.=0D
> +        let input_va =3D csg_control.read(GROUP_INPUT_VA).value().get();=
=0D
> +        let csg_input =3D=0D
> +            FwInterface::<CSG_INPUT_BLOCK_SIZE>::new(&vmap, &va_range, i=
nput_va.into())?;=0D
> +=0D
> +        let output_va =3D csg_control.read(GROUP_OUTPUT_VA).value().get(=
);=0D
> +        let csg_output =3D=0D
> +            FwInterface::<CSG_OUTPUT_BLOCK_SIZE>::new(&vmap, &va_range, =
output_va.into())?;=0D
> +=0D
> +        // Read the runtime stride between CS control blocks.=0D
> +        let cs_stride =3D csg_control.read(GROUP_STREAM_STRIDE).value().=
get() as usize;=0D
> +=0D
> +        if cs_stride < CS_CONTROL_BLOCK_SIZE {=0D
> +            pr_err!(=0D
> +                "CS stride {} is smaller than control block size {}\n",=
=0D
> +                cs_stride,=0D
> +                CS_CONTROL_BLOCK_SIZE=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        // Read how many CS interfaces exist for this CSG.=0D
> +        let cs_num =3D csg_control.read(GROUP_STREAM_NUM).value().get();=
=0D
> +=0D
> +        // Validate that the hardware doesn't report more CS than we sup=
port.=0D
> +        if cs_num as usize > super::MAX_CS {=0D
> +            pr_err!(=0D
> +                "Too many CS: hardware reports {}, max supported {}\n",=
=0D
> +                cs_num,=0D
> +                super::MAX_CS=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let enabled =3D EnabledCsgInterface {=0D
> +            csg_control,=0D
> +            csg_input,=0D
> +            csg_output,=0D
> +            cs_stride,=0D
> +            cs_num: cs_num as usize,=0D
> +            cs: KVec::with_capacity(cs_num as usize, GFP_KERNEL)?,=0D
> +        };=0D
> +=0D
> +        self.state =3D CsgInterfaceState::Enabled(enabled);=0D
> +        self.init_cs(shared_section, csg_control_offset)?;=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    /// Initialize and discover CS interfaces.=0D
> +    ///=0D
> +    /// This uses the previously read CS count to create and enable each=
 CS interface.=0D
> +    fn init_cs(&mut self, shared_section: &Section, csg_control_offset: =
usize) -> Result {=0D
> +        let enabled =3D match &mut self.state {=0D
> +            CsgInterfaceState::Enabled(e) =3D> e,=0D
> +            CsgInterfaceState::Disabled =3D> return Err(EINVAL),=0D
> +        };=0D
> +=0D
> +        for cs_idx in 0..enabled.cs_num {=0D
> +            // Create and enable the CS interface.=0D
> +            let mut cs =3D CsInterface::new(cs_idx)?;=0D
> +            cs.enable(=0D
> +                shared_section,=0D
> +                csg_control_offset,=0D
> +                cs_idx,=0D
> +                enabled.cs_stride,=0D
> +            )?;=0D
> +=0D
> +            enabled.cs.push(cs, GFP_KERNEL)?;=0D
> +        }=0D
> +=0D
> +        Ok(())=0D
> +    }=0D
> +}=0D
> +=0D
> +/// State of a CS interface.=0D
> +enum CsInterfaceState {=0D
> +    /// Interface is not yet initialized.=0D
> +    Disabled,=0D
> +    /// Interface is initialized and operational.=0D
> +    #[expect(dead_code)]=0D
> +    Enabled(EnabledCsInterface),=0D
> +}=0D
> +=0D
> +/// When enabled, a CS Interface has control, input, and output system m=
emory interfaces.=0D
> +struct EnabledCsInterface {=0D
> +    /// Control block interface - provides CS capabilities and configura=
tion.=0D
> +    #[expect(dead_code)]=0D
> +    cs_control: FwInterface<CS_CONTROL_BLOCK_SIZE>,=0D
> +    /// Input block interface - driver writes CS requests here.=0D
> +    #[expect(dead_code)]=0D
> +    cs_input: FwInterface<CS_KERNEL_INPUT_BLOCK_SIZE>,=0D
> +    /// Output block interface - firmware writes CS acknowledgements her=
e.=0D
> +    #[expect(dead_code)]=0D
> +    cs_output: FwInterface<CS_KERNEL_OUTPUT_BLOCK_SIZE>,=0D
> +}=0D
> +=0D
> +/// Command Stream Interface=0D
> +///=0D
> +/// The CS interface controls operations for a specific CS.=0D
> +pub(crate) struct CsInterface {=0D
> +    /// Current interface state (Disabled or Enabled).=0D
> +    state: CsInterfaceState,=0D
> +    /// CS identifier/index number.=0D
> +    #[expect(dead_code)]=0D
> +    cs_idx: usize,=0D
> +}=0D
> +=0D
> +impl CsInterface {=0D
> +    /// Creates a new disabled CS interface.=0D
> +    pub(super) fn new(cs_idx: usize) -> Result<Self> {=0D
> +        Ok(Self {=0D
> +            state: CsInterfaceState::Disabled,=0D
> +            cs_idx,=0D
> +        })=0D
> +    }=0D
> +=0D
> +    /// Enables the CS interface.=0D
> +    ///=0D
> +    /// This calculates the runtime offset of this CS's control block an=
d creates=0D
> +    /// a bounded interface to access it. It then reads the input/output=
 interface=0D
> +    /// addresses from the CS control block.=0D
> +    fn enable(=0D
> +        &mut self,=0D
> +        shared_section: &Section,=0D
> +        csg_control_offset: usize,=0D
> +        cs_idx: usize,=0D
> +        cs_stride: usize,=0D
> +    ) -> Result {=0D
> +        use cs::control::{=0D
> +            STREAM_INPUT_VA,=0D
> +            STREAM_OUTPUT_VA, //=0D
> +        };=0D
> +        use kernel::io::Io;=0D
> +=0D
> +        let vmap =3D shared_section.mem.bo.owned_vmap::<0>()?;=0D
> +        let va_range =3D shared_section.mem.va_range();=0D
> +=0D
> +        // Calculate the runtime offset for this CS's control block.=0D
> +        let cs_control_offset =3D CS_CONTROL_OFFSET + cs_idx * cs_stride=
;=0D
> +=0D
> +        // The CS control block's MCU virtual address is relative to the=
 shared section start.=0D
> +        let cs_control_va =3D va_range.start + csg_control_offset as u64=
 + cs_control_offset as u64;=0D
> +=0D
> +        // Create a bounded interface for this CS's control block at the=
 calculated address.=0D
> +        let cs_control =3D=0D
> +            FwInterface::<CS_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range, =
cs_control_va)?;=0D
> +=0D
> +        // Read the input and output VAs from the CS control block.=0D
> +        let input_va =3D cs_control.read(STREAM_INPUT_VA).value().get();=
=0D
> +        let cs_input =3D=0D
> +            FwInterface::<CS_KERNEL_INPUT_BLOCK_SIZE>::new(&vmap, &va_ra=
nge, input_va.into())?;=0D
> +=0D
> +        let output_va =3D cs_control.read(STREAM_OUTPUT_VA).value().get(=
);=0D
> +        let cs_output =3D=0D
> +            FwInterface::<CS_KERNEL_OUTPUT_BLOCK_SIZE>::new(&vmap, &va_r=
ange, output_va.into())?;=0D
> +=0D
> +        let enabled =3D EnabledCsInterface {=0D
> +            cs_control,=0D
> +            cs_input,=0D
> +            cs_output,=0D
> +        };=0D
> +=0D
> +        self.state =3D CsInterfaceState::Enabled(enabled);=0D
> +=0D
> +        Ok(())=0D
> +    }=0D
> +}=0D
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs=0D
> index 4ec373e0bcfa..606d446aafd9 100644=0D
> --- a/drivers/gpu/drm/tyr/gem.rs=0D
> +++ b/drivers/gpu/drm/tyr/gem.rs=0D
> @@ -151,6 +151,11 @@ pub(crate) fn new<Ctx: DeviceContext>(=0D
>              va_range: va..(va + size),=0D
>          })=0D
>      }=0D
> +=0D
> +    /// Returns the GPU virtual address range occupied by this buffer.=0D
> +    pub(crate) fn va_range(&self) -> Range<u64> {=0D
> +        self.va_range.clone()=0D
> +    }=0D
>  }=0D
>  =0D
>  impl Drop for KernelBo {=0D
> =0D
> -- =0D
> 2.53.0=0D
> =0D
