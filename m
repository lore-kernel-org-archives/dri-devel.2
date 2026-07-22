Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8691C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438AD10EBF8;
	Wed, 22 Jul 2026 01:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GYoT1KAJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99CF10EBF8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:05:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7534743242;
 Wed, 22 Jul 2026 01:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE61F00A3A;
 Wed, 22 Jul 2026 01:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682327;
 bh=ssAx3MgARjfjZLu00VAj7fw+/rYvB2Nf93qffmjDu2U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GYoT1KAJvTxXpe7zYje/R4/AGMEr+s/5xp3ssvhBS4eEBPszyjlqfxc4Sn3Y/Fb2u
 /FJOGOjG+2sFrBO31kU1YsoSOe6VUmDdXy+Nu/1I3H9D9w6dNsOFjuATZc5FM8URQp
 C9WgbVNNWV4nhOQ0aLcY6otkr1KMZ/HX0iV8z2QMnPNVC58K0/0eXst4f3ukIivTZn
 IUWxpNIvVxrgM9EZHbnvo6JfXE+3DsGJCLx4xoZ+9zz+1/nSLwz/DfGhpJkUL77Zdk
 EDH+KBXduZx8E05QSbErLnOdzXi9+TbZiCR0qMCKEi+ylc4XUSu1oNS3M/XA8hiXCd
 Ph4vo5R2P0EpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260721-fw-boot-b4-v8-7-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-7-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:05:26 +0000
Message-Id: <20260722010527.27CE61F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Firmware sections lacking page alignment cause GPUVM mapping failu=
res.
- [High] The MCU is not halted before its firmware memory is unmapped and f=
reed, causing hardware faults.
- [Medium] Firmware sections with CacheMode::CachedCoherent are incorrectly=
 mapped as Uncached.
- [Medium] The MCU boot completion interrupt is not cleared before starting=
 the MCU, risking premature boot detection.
--

--- Patch [7]: [PATCH v8 7/7] drm/tyr: add Microcontroller Unit (MCU) booti=
ng ---
commit fab6374bf2ef501e789803698dbff3b27a24a705
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add Microcontroller Unit (MCU) booting

This patch adds a firmware module to load, parse, and map the MCU firmware
sections into shared GEM memory. It creates a firmware instance during prob=
e=20
to boot the MCU, and updates Kconfig dependencies accordingly.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index b6528d8cd3cee..ebfb74e89c4c8 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> @@ -144,10 +148,21 @@ fn probe<'bound>(
> =20
>          let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(p=
dev, Ok(()))?;
> =20
> -        let _mmu =3D Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu=
_info)?;
> +        let mmu =3D Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_=
info)?;
> +
> +        let firmware =3D Firmware::new(
> +            pdev.as_ref(),
> +            iomem.clone(),
> +            &unreg_dev,
> +            mmu.as_arc_borrow(),
> +            &gpu_info,
> +        )?;
> +
> +        firmware.boot()?;
> =20
>          let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>                  pdev,
> +                fw: firmware,

[Severity: High]
If try_pin_init!() fails, will the MCU crash because the firmware is droppe=
d?

When try_pin_init!() fails, the firmware instance will be dropped, calling
Firmware::drop() which destroys the VM (self.vm.kill()). Because the MCU was
already started in firmware.boot(), it will continue running and try to fet=
ch=20
instructions from memory that has just been unmapped and freed, potentially=
=20
triggering IOMMU faults or hardware hangs.

>                  clks <- new_mutex!(Clocks {
>                      core: core_clk,
>                      stacks: stacks_clk,
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw.rs
[ ... ]
> +    fn load(
> +        dev: &Device,
> +        ddev: &TyrDrmDevice,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
> +        let fw =3D Self::request(ddev, gpu_info)?;
> +        let mut parser =3D FwParser::new(dev, fw.data());
> +
> +        let parsed_sections =3D parser.parse()?;

[Severity: Medium]
Does the firmware parser map coherent memory as uncached?

While parsing the firmware sections, the code checks the cache mode:

drivers/gpu/drm/tyr/fw/parser.rs:parse_section_entry() {
    ...
    if section_hdr.section_flags.cache_mode() !=3D CacheMode::Cached {
        vm_map_flags |=3D VmFlag::Uncached;
    }
    ...
}

Because CacheMode::CachedCoherent has a value of 3, the check for inequality
with CacheMode::Cached evaluates to true. This erroneously assigns the
Uncached flag to CachedCoherent sections, which can break hardware
coherency expectations and degrade performance.

> +
> +        Ok((fw, parsed_sections))
> +    }
> +
> +    /// Load firmware and map sections into MCU VM.
> +    pub(crate) fn new(
> +        dev: &'bound Device<Bound>,
> +        iomem: Arc<IoMem<'bound>>,
> +        ddev: &TyrDrmDevice,
> +        mmu: ArcBorrow<'_, Mmu<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Firmware<'bound>> {
> +        let vm =3D Vm::new(dev, ddev, mmu, gpu_info)?;
> +        vm.activate()?;
> +
> +        let result =3D (|| {
> +            let (fw, parsed_sections) =3D Self::load(dev, ddev, gpu_info=
)?;
> +            let mut sections =3D KVec::new();
> +            for parsed in parsed_sections {
> +                let size =3D u64::from(parsed.va.end.checked_sub(parsed.=
va.start).ok_or(EINVAL)?);

[Severity: High]
Can this unaligned size cause GPUVM mapping failures later?

The size is computed directly from the firmware without aligning it to page=
=20
boundaries. When the driver attempts to map this unaligned size into the VM,
the underlying page table mapping code will fail:

drivers/gpu/drm/tyr/vm.rs:pt_map() {
    ...
    let (pgsize, pgcount) =3D get_pgsize(curr_iova | curr_paddr, remaining);
    ...
        if mapped =3D=3D 0 {
            dev_err!(dev, "Failed to map any pages at iova {:#x}\n", curr_i=
ova);
            if segment_mapped > 0 {
                let _ =3D pt_unmap(dev, pt, iova..(iova + segment_mapped));
            }
            return Err(ENOMEM);
        }
    ...
}

For unaligned sizes, the final chunk produces a pgcount of 0 from
get_pgsize(), causing mapped to be 0 and triggering an unconditional
ENOMEM error, which causes the firmware load to fail.

> +
> +                let va =3D u64::from(parsed.va.start);
> +
> +                let mut mem =3D KernelBo::new(
> +                    ddev,
> +                    vm.clone(),
> +                    size,
> +                    KernelBoVaAlloc::Explicit(va),
> +                    parsed.vm_map_flags,
> +                )?;
[ ... ]
> +    pub(crate) fn boot(&self) -> Result {
> +        let io =3D &self.iomem;
> +        io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto=
));
> +
> +        if let Err(e) =3D poll::read_poll_timeout(
> +            || Ok((io.read(MCU_STATUS), io.read(JOB_IRQ_RAWSTAT))),
> +            |(mcu_status, irq_rawstat)| {
> +                mcu_status.value() =3D=3D McuStatus::Enabled && irq_raws=
tat.glb()
> +            },
> +            time::Delta::from_millis(1),
> +            time::Delta::from_millis(100),
> +        ) {
> +            let status =3D io.read(MCU_STATUS);
> +            dev_err!(
> +                self.vm.dev(),
> +                "MCU failed to boot, status: {:?}\n",
> +                status.value()
> +            );
> +            return Err(e);
> +        }
> +
> +        io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));

[Severity: Medium]
Should the interrupt be cleared before polling for MCU boot completion?

Because JOB_IRQ_CLEAR is written only after the polling loop, a stale=20
interrupt bit (e.g. from the bootloader or a prior crashed state) could be=
=20
present when polling starts. This would cause the polling loop to succeed=20
instantly before the newly started MCU actually completes its boot.

> +
> +        Ok(())
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D7
