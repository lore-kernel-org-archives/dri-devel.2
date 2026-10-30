Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081A606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAF110E0D2;
	Fri, 30 Oct 2026 13:38:52 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 13:38:51 UTC
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E4210E0D2;
 Fri, 30 Oct 2026 13:38:51 +0000 (UTC)
Received: by linkmauve.fr (Postfix, from userid 1000)
 id 91F417229E1B; Fri, 30 Oct 2026 14:31:40 +0100 (CET)
Date: Fri, 30 Oct 2026 14:31:40 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
Message-ID: <auScPBpT79XKnBph@desktop>
References: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
Jabber-ID: linkmauve@linkmauve.fr
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 26, 2026 at 12:40:02PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Much of the VM handling code is a headache to read and maintain.
> There's a soup of mixed-signedness/size types which need to be compared
> and added and getting that wrong in C is very easy.
> 
> The "(range + obj_offset) > obj->size" check could wrap for a large
> obj_offset, which let an out-of-range map be accepted and then mapped
> as nothing. Oxidize it and use checked_add() to fix that.
> 
> This commit is a "get the foot in the door" type change to make sure
> that folks building kernels for Qualcomm SoCs have their Rust setup
> ready. It may/should be extended to the wider mm code once the
> appropriate abstractions are finalized.
> 
> Worth noting, the C UERR() macro expands to dev_dbg() and the Rust
> implementation for that currently doesn't support dynamic_debug.
> 
> The DRM_BRIDGE dependency is dropped because including RUST exposed
> some spaghetti dependencies ending at DEBUGFS and it's enabled anyway.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> (if this is rejected we may just patch the C code).
> 
> Notably, this will regress some ancient configurations:
> -- arch/arm/Kconfig
>     select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
> 
> Smoke-tested on Glymur
> ---
>  drivers/gpu/drm/msm/Kconfig        |   2 +-
>  drivers/gpu/drm/msm/Makefile       |   1 +
>  drivers/gpu/drm/msm/msm_gem_vma.c  |  66 +++------------
>  drivers/gpu/drm/msm/msm_vm_bind.h  |  16 ++++
>  drivers/gpu/drm/msm/msm_vm_bind.rs | 160 +++++++++++++++++++++++++++++++++++++
>  rust/uapi/uapi_helper.h            |   1 +
>  6 files changed, 188 insertions(+), 58 deletions(-)
> 
[…]
> diff --git a/drivers/gpu/drm/msm/msm_vm_bind.rs b/drivers/gpu/drm/msm/msm_vm_bind.rs
> new file mode 100644
> index 000000000000..164208e0a1b4
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/msm_vm_bind.rs
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//! VM_BIND operation validation for the MSM driver.
> +
> +use kernel::{
> +    bindings,
> +    device::Device,
> +    error::code::EINVAL,
> +    prelude::*,
> +    uapi, //
> +};
> +
> +/// Validates a single VM_BIND operation.
> +///
> +/// Returns 0 if the operation is valid. Otherwise logs the reason and returns
> +/// `-EINVAL`.
> +///
> +/// `page_size` is the granularity that `iova`, `obj_offset` and `range` must be
> +/// aligned to. It is the GPU's alignment rather than the CPU's, but no known qcom
> +/// SMMU lacks support for the CPU's smallest page size.
> +/// `range_valid` is the result of `drm_gpuvm_range_valid()` for this operation.
> +/// `prr_supported` is only consulted for `MSM_VM_BIND_OP_MAP_NULL`.
> +///
> +/// # Safety
> +///
> +/// `dev` must point to a live `struct device`.
> +#[no_mangle]
> +pub unsafe extern "C" fn msm_vm_bind_check_op(
> +    dev: *mut bindings::device,
> +    op: u32,
> +    handle: u32,
> +    obj_offset: u64,
> +    iova: u64,
> +    range: u64,
> +    flags: u32,
> +    page_size: u64,
> +    range_valid: bool,
> +    prr_supported: bool,
> +) -> c_int {
> +    // SAFETY: The caller guarantees that `dev` is a live `struct device`.
> +    let dev: &Device = unsafe { Device::from_raw(dev) };
> +
> +    match check_op(
> +        dev,
> +        op,
> +        handle,
> +        obj_offset,
> +        iova,
> +        range,
> +        flags,
> +        page_size,
> +        range_valid,
> +        prr_supported,
> +    ) {
> +        Ok(()) => 0,
> +        Err(e) => e.to_errno(),
> +    }

I think we usually use kernel::error::from_result() instead of a match
block in this situation.

> +}
> +
> +fn check_op(
> +    dev: &Device,
> +    op: u32,
> +    handle: u32,
> +    obj_offset: u64,
> +    iova: u64,
> +    range: u64,
> +    flags: u32,
> +    page_size: u64,
> +    range_valid: bool,
> +    prr_supported: bool,
> +) -> Result {
> +    let aligned = |addr: u64| page_size.is_power_of_two() && (addr & (page_size - 1)) == 0;
> +
> +    if flags & !uapi::MSM_VM_BIND_OP_FLAGS != 0 {
> +        dev_dbg!(dev, "invalid flags: {:x}\n", flags);
> +        return Err(EINVAL);
> +    }
> +
> +    if !aligned(iova) {
> +        dev_dbg!(dev, "invalid address: {:016x}\n", iova);
> +        return Err(EINVAL);
> +    }
> +
> +    if !aligned(obj_offset) {
> +        dev_dbg!(dev, "invalid bo_offset: {:016x}\n", obj_offset);
> +        return Err(EINVAL);
> +    }
> +
> +    if !aligned(range) {
> +        dev_dbg!(dev, "invalid range: {:016x}\n", range);
> +        return Err(EINVAL);
> +    }
> +
> +    if !range_valid {
> +        dev_dbg!(dev, "invalid range: {:016x}, {:016x}\n", iova, range);
> +        return Err(EINVAL);
> +    }
> +
> +    // MAP must name a handle; UNMAP and MAP_NULL must not.
> +    match op {
> +        uapi::MSM_VM_BIND_OP_MAP => {
> +            if handle == 0 {
> +                dev_dbg!(dev, "invalid handle\n");
> +                return Err(EINVAL);
> +            }
> +        }
> +        uapi::MSM_VM_BIND_OP_UNMAP | uapi::MSM_VM_BIND_OP_MAP_NULL => {
> +            if handle != 0 {
> +                dev_dbg!(dev, "handle must be zero\n");
> +                return Err(EINVAL);
> +            }
> +        }
> +        _ => {
> +            dev_dbg!(dev, "invalid op: {}\n", op);
> +            return Err(EINVAL);
> +        }
> +    }
> +
> +    if op == uapi::MSM_VM_BIND_OP_MAP_NULL && !prr_supported {
> +        dev_dbg!(dev, "PRR not supported\n");
> +        return Err(EINVAL);
> +    }
> +
> +    Ok(())
> +}
> +
> +/// Checks that `[obj_offset, obj_offset + range)` lies within an object of
> +/// `obj_size` bytes.
> +///
> +/// Returns 0 if it does. Otherwise logs the reason and returns `-EINVAL`.
> +///
> +/// # Safety
> +///
> +/// `dev` must point to a live `struct device`.
> +#[no_mangle]
> +pub unsafe extern "C" fn msm_vm_bind_check_bo_range(
> +    dev: *mut bindings::device,
> +    obj_offset: u64,
> +    range: u64,
> +    obj_size: u64,
> +) -> c_int {
> +    // SAFETY: The caller guarantees that `dev` is a live `struct device`.
> +    let dev: &Device = unsafe { Device::from_raw(dev) };
> +
> +    let fits = obj_offset
> +        .checked_add(range)
> +        .is_some_and(|end| end <= obj_size);
> +
> +    if fits {
> +        return 0;
> +    }
> +
> +    dev_dbg!(
> +        dev,
> +        "invalid range: {:016x} + {:016x} > {:016x}\n",
> +        range,
> +        obj_offset,
> +        obj_size
> +    );
> +    EINVAL.to_errno()

Same here, the whole content of this function could be wrapped in a
from_result().

> +}
[…]

Thanks,

-- 
Link Mauve
