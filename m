Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D41C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF6510E449;
	Tue, 14 Jul 2026 03:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J1POJdXa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC3310E449
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:34:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF7D6601EC;
 Tue, 14 Jul 2026 03:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B8B1F000E9;
 Tue, 14 Jul 2026 03:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784000093;
 bh=4e1/rHpEbIYgR2IML+AHGYSgM0oVz6M2HoanrlFzrqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J1POJdXaWX3Pp76A7MbL05U7B3i4xYjaiSw8fvErBc6sq0V9BscAYhHQ04bEdcT/j
 irXq5+R4uBZx6aSDzzGM3qAb962t3TUCZX0YW/JOqx4+lTyHPRsTV53uGtBSFhKPhb
 igqqApbuWu1V+qwdw28rkvBeg4axtwQiEH1IF8n74IpMPTuuCogXm689ySz3R0GBhS
 SFeSlGEpdckNSrd6GtO93pi2CBFOU3Yh8EgtgrIX15FuWHdsoCHL8qmd2DmPbivwBJ
 lH4ZTa80whtnoia6FZgUs55QDGI7p1zA4KPEh8ii4fM/1R+smWzq3jFCkZpuMjjFgF
 YcyYXRrosUopw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-fw-boot-b4-v7-7-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-7-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:34:52 +0000
Message-Id: <20260714033453.34B8B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hardware address space slots and `Vm` memory leak on `Firmware::ne=
w` error paths.
- [High] Integer underflow when parsing firmware entry sizes causes a kerne=
l panic.
- [Medium] The firmware boot sequence polls for the global interrupt to sig=
nal completion but fails to clear it.
--

--- Patch [7]: [PATCH v7 7/7] drm/tyr: add Microcontroller Unit (MCU) booti=
ng ---
commit e1820d2f1cae463780da8954dc7c2dd33531c48e
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add Microcontroller Unit (MCU) booting

Add a firmware module to load, parse, and map the MCU firmware sections
into shared GEM memory at the required virtual addresses accessible by the
GPU.

> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index 0000000000000..554808a792aa5
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw.rs

[ ... ]

> +    fn load(
> +        ddev: &TyrDrmDevice,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
> +        let fw =3D Self::request(ddev, gpu_info)?;
> +        let mut parser =3D FwParser::new(fw.data());
> +
> +        let parsed_sections =3D parser.parse()?;

[Severity: High]
When parsing the firmware entry sizes, is there a risk of an integer underf=
low
if the entry size is 0?

Looking at FwParser::parse_entry() in parser.rs, the alignment check doesn't
seem to reject a size of 0:

    if self.cursor.pos() % size_of::<u32>() !=3D 0
        || entry_section.entry_hdr.size() as usize % size_of::<u32>() !=3D 0
    {
        ...
        return Err(EINVAL);
    }

Since 0 % 4 =3D=3D 0, the check passes. Then it calculates section_hdr_size:

    let section_hdr_size =3D entry_section.entry_hdr.size() as usize - size=
_of::<EntryHeader>();

If the size is 0, subtracting size_of::<EntryHeader>() (which is 4) will
underflow, causing a kernel panic. Should there be a check to ensure the
size is at least size_of::<EntryHeader>()?

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
> +        let (fw, parsed_sections) =3D Self::load(ddev, gpu_info)?;
> +        let mut sections =3D KVec::new();

[Severity: High]
If an error occurs after vm.activate(), such as in Self::load() or
KernelBo::new(), does this leak the hardware address space slot and the
Vm allocation?

vm.activate() creates a circular reference by storing an Arc<VmAsData> in t=
he
hardware slot manager. This cycle is normally broken by self.vm.kill() in
Firmware::drop():

impl<'bound> Drop for Firmware<'bound> {
    fn drop(&mut self) {
        // AS slots retain a VM ref, we need to kill the circular ref manua=
lly.
        self.vm.kill();
    }
}

If Firmware::new() returns early with an error, the Firmware object is never
constructed, so its Drop implementation won't run. Should vm.kill() be
called on these error paths before returning?

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
> +            pr_err!("MCU failed to boot, status: {:?}", status.value());
> +            return Err(e);
> +        }
> +        Ok(())
> +    }
> +}

[Severity: Medium]
Does this leave the global interrupt asserted in the hardware's RAWSTAT
register?

The polling loop checks for the interrupt:

    |(mcu_status, irq_rawstat)| {
        mcu_status.value() =3D=3D McuStatus::Enabled && irq_rawstat.glb()
    }

But once the loop succeeds, it returns without writing to JOB_IRQ_CLEAR to
acknowledge and clear the interrupt. Could this cause an immediate spurious
interrupt to fire once the DRM driver registers its interrupt handler and
unmasks interrupts at the GIC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D7
