Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2C8C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 22:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2101A10E045;
	Sun, 27 Sep 2026 22:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=matt3o12.de header.i=@matt3o12.de header.b="QPxsBAyX";
	dkim-atps=neutral
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37FB10E045
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 22:46:00 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
X-Lima-ML-UUID: 7b21bed0-f515-40d2-8fad-e214b5c9faf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1790549158;
 bh=xC9euzdpfWQA6clWp09WVE/7sgF5HEkIjOsWgJhhgTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QPxsBAyXObGEqRuVtVwk+kG/MmUHlCLH7ftmtL5BWr2j8oaZf0M4V9Q3kIBZ9zV+2
 uylOzjCrgcHThRhe5hs4jq2HvGiNof6YkMwPPkWx3ToNAJplgp+cp0SpLJ0eZShIhP
 cL9aqqpJMKK1jiCRLqPoDgiKaEH3N2yN8bY7vVrd8qp8ScHRVQw3QGZxZ9UKv/+oAR
 xLVSKeXX1+T/jtMI9IQloUVQvaHzI/703WAmDE/7Jdc8d2wO5bvZAMStVQq6a1vbR5
 RNVGTGvhjnpL8x33L1GqLVpWnHzdQflfLmVHlzU0CgiRtDVX2EmxDPhXofOm2Jdl3V
 I/ygm44GFUvqA==
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Robin Murphy <robin.murphy@arm.com>, aliceryhl@google.com,
 ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum segment
 size
Date: Mon, 28 Sep 2026 00:44:43 +0200
Message-ID: <20260927224446.1053037-1-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com> <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
 <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

First of all, thanks for merging my first two patches and sorry about my late reply.

What I think Alex meant and what I agree with is that the new API should focus on
making semantic bugs harder, not to necessarily make it easier to write safer
drivers. That being said, I think we can do both with this change.

The key change here is that we introduce a structure that defines dma
parameters for a device. This structure deliberately has no default
implementation and new fields should be added even if they require changes for
all dma drivers.

```
pub struct Params {
    pub streaming_mask: DmaMask,
    pub coherent_mask: DmaMask,
    pub max_seg_size: NonZeroU32,
}
```

Suppose, we didn't have `max_seg_size` before and only discovered it later. We
would add it and the compiler would guide us to any drivers that will need to
consider an appropriate value for `max_seg_size`.

If rust was bigger in the kernel, this could be quite a bit of work, requiring
coordination with other maintainers, but I would call this a feature because it
actually requires everyone to at least consider what the right value is instead
of forgetting to set it.

The same is also true for new drivers. Authors do not have to be omniscient of
all dma related settings and instead just fill out the struct and already have
some important ones set.

If a parameter is only important for some drivers but those drivers should not
forget it, we could make it an Option so that drivers that really don't need
a parameter can set it to `None`, but they had to think about it at least.

I think, instead of discussing different possibilities, it might be easier to
discuss code directly. Taking Alex's example, I went ahead and wrote a small
LLM assisted PoC. I'm happy to share it here or in another thread, but here are
the main changes:

1. The PCI and platform probe callbacks receive a unique setup token:

```rust
    fn probe<'bound>(
        dev: &'bound Device<device::Core<'_>>,
        dma: dma::Setup<'bound>,
        id_info: Option<&'bound Self::IdInfo>,
    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
```

The bus driver creates this token and drivers cannot obtain another one from
the device. 

2. `setup.configure(params)` consumes the token, applies the parameters through
   the C DMA setters, and returns a `dma::Handle<'bound>` on success.  This
   combines the setters and `finish()` from Alex's outline into one call.

```
pub fn configure(self, params: Params) -> Result<Handle<'bound>> {
    let dev = self.dev.as_raw();

    // SAFETY: `dev` is valid and its DMA parameters are initialized by the bus. The `Setup`
    // invariants exclude concurrent DMA operations and other parameter setters. Consuming
    // the unique token prevents reconfiguration after a handle has been issued.
    unsafe {
        to_result(bindings::dma_set_mask(dev, params.streaming_mask.value()))?;
        to_result(bindings::dma_set_coherent_mask(dev, params.coherent_mask.value()))?;
        bindings::dma_set_max_seg_size(dev, params.max_seg_size.get());
    }

    Ok(Handle { dev: self.dev })
}
```

3. The handle contains a bound device reference and is copyable, but provides
   no way to reconfigure DMA:

```rust
#[derive(Clone, Copy)]
pub struct Handle<'bound> {
  dev: &'bound device::Device<Bound>,
}
```

4. Allocation and mapping APIs now require a Handle. 

For example, scatter list now takes:

```
pub fn new<'a>(
  dma: dma::Handle<'a>,
  pages: P,
  dir: dma::DataDirection,
  flags: alloc::Flags,
) -> impl PinInit<Self, Error> + 'a {
```

The PoC uses Handle for coherent allocations, owned scatterlists, and DRM
scatterlist mappings.

5. Each pci/platform driver that uses DMA configures its own `Params`. Let's
   look at `samples/rust/rust_dma.rs`:

```rust
fn probe<'bound>(
    pdev: &'bound pci::Device<Core<'_>>,
    setup: dma::Setup<'bound>,
    _info: Option<&'bound Self::IdInfo>,
) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
    pin_init::pin_init_scope(move || {
        dev_info!(pdev, "Probe DMA test driver.\n");

        let mask = DmaMask::new::<64>();

        let dma = setup.configure(dma::Params {
            streaming_mask: mask,
            coherent_mask: mask,
            max_seg_size: const { NonZeroU32::new(u32::SZ_64K).unwrap() },
        })?;

        let ca: Coherent<'_, [MyStruct]> =
            Coherent::zeroed_slice(dma, TEST_VALUES.len(), GFP_KERNEL)?;

        for (i, value) in TEST_VALUES.into_iter().enumerate() {
            io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
        }

        let size = 4 * page::PAGE_SIZE;
        let pages = VVec::with_capacity(size, GFP_KERNEL)?;

        let sgt = SGTable::new(dma, pages, DataDirection::ToDevice, GFP_KERNEL);

        Ok(try_pin_init!(Self::Data {
            pdev,
            ca,
            sgt <- sgt,
        }))
    })
}
```

What I am not 100% sure about is how we should handle drivers that don't use
dma. Currently I just discarded the setup token like suggested, for example
`samples/rust/rust_driver_auxiliary.rs`:

```rust
impl pci::Driver for ParentDriver {
  fn probe<'bound>(
    pdev: &'bound pci::Device<Core<'_>>,
    _dma: kernel::dma::Setup<'bound>,
    _info: Option<&'bound Self::IdInfo>,
  ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound { ... }
}
```

But maybe it would make sense to introduce a C API such as: `debug_no_dma` and
have the bus call it unless configure was called first. This would then trigger
a debug warning if a marked rust device calls any C APIs that use DMA
regardless. But this could also very well be a worthwhile follow up.
