Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02386C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2542610EAF4;
	Tue,  8 Sep 2026 11:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GgWpoacy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119A510EAF4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788867110; x=1820403110;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SICPIr9PTabn0tZUwKC6Hs60av/WTxJeDvmAxJKd4gk=;
 b=GgWpoacyFTslbSB3UT743n/AX0oRjusnW5+09PtFqIeApFlMfuIclmyw
 vPE6J4bEM3VkJOWdU7K7zkRkd75lGDLanFF+7u4YFDYTxLWehivQbO31g
 NHyyUAzTb616LxAUyNHRFcJgFaRm6zfP7+Xsy4I9rNhZJz/V2L+eIT82s
 ZVCFmVSxc8pEJW46Xle+iryGb/2l8huc3Hzn4128COHxTKQg08DSWQJNS
 Q1/zo05sP4FaaGQXdefrh1hVQyZ62lhYLc2Q/gXZpI3XlO4Y9a0V8+VLs
 wttzh0/qK2M9kxX6Oqx5ohgf99CcGOQ1swnQdgNA4q8J1OTO2z8FhcOVy w==;
X-CSE-ConnectionGUID: Pe/aUMSkSdOOhx6KZoTRgg==
X-CSE-MsgGUID: 0vIcxX2ESB6yvtr0KQ+u9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100425724"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100425724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 04:31:50 -0700
X-CSE-ConnectionGUID: HJtQmx62TQq/xO3eUFcSNA==
X-CSE-MsgGUID: eCuaL6P+S+Wj2kQQfYWnUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="270482992"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.174])
 by orviesa008-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 04:31:48 -0700
Date: Tue, 8 Sep 2026 14:31:45 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Haram Choi <haram@choiharam.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 -
 PCI bridge left with VGA enable set and VGA 16-bit decode cleared, aliasing
 legacy VGA I/O over the gmux ports
Message-ID: <ap_yIeUyNu5WxSnX@intel.com>
References: <CAAKWd2_MZSC=A2EHuEw3=eECr1QfaqrhYawW=njt5muk=5sA_A@mail.gmail.com>
 <0102019fcb5d411c-e0a555b7-46da-43a1-bd9d-6cb120f58a7f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0102019fcb5d411c-e0a555b7-46da-43a1-bd9d-6cb120f58a7f-000000@eu-west-1.amazonses.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Tue, Aug 04, 2026 at 06:01:54AM +0000, Haram Choi wrote:
> I think I have found the commit. It is not in drivers/pci at all, and
> my previous suspicion of 94555ea9a048 was wrong. Apologies to Simon
> for the noise.
> 
> The regression is:
> 
>   cc6ed470caa2 ("drm/i915/vga: Avoid VGA arbiter during
>                  intel_vga_disable() for iGPUs")
>   Ville Syrjala <ville.syrjala@linux.intel.com>, 2025-12-08
> 
> I have added Ville, intel-gfx and dri-devel to Cc.
> 
> Two corrections to my earlier mail while I am at it:
> 
>   - 94555ea9a048 is not involved. My instrumented build shows
> pci_set_vga_state() returning 0, and no -EIO anywhere. The
> bookkeeping-mismatch theory was wrong.
> 
>   - The bit 4 (VGA 16-bit decode) "open question" from my last mail
> dissolves. The firmware default on this machine is BRIDGE_CONTROL =
> 0x0002, i.e. bit 4 clear, on working and broken kernels alike. Working
> kernels are fine only because bit 3 is never set. Bit 4 is not a
> second regression and the kernel indeed never writes it.
> 
> ## The mechanism: whoever touches the VGA arbiter first wins
> 
> The topology matters:
> 
>   00:02.0  i915    - directly on bus 0, no bridge above it
>   01:00.0 amdgpu   - behind pcieport 00:01.0
> 
> pci_set_vga_state() writes PCI_BRIDGE_CTL_VGA by walking the bridges
> above the device. For the iGPU that walk is empty and writes nothing.
> For the dGPU it writes 00:01.0.
> 
> vga_check_first_use() runs exactly once per boot, on the first
> vga_get()/vga_tryget(). Whichever GPU triggers it determines whether
> any bridge gets written at all. __vga_put() never calls
> pci_set_vga_state(), so once the bit is set it stays set until reboot.
> 
> Before cc6ed470caa2, intel_vga_disable() unconditionally called
> 
>   vga_get_uninterruptible(igpu_pdev, VGA_RSRC_LEGACY_IO);
> 
> during i915 probe. The iGPU therefore always won that race, and since
> it has no bridge above it, nothing was ever written.
> 
> After cc6ed470caa2 the iGPU takes the display->platform.dgfx == false
> path, bypasses the arbiter, and just sets PCI_COMMAND_IO by hand. The
> arbiter now has no user at all until X starts. X then opens
> /dev/vga_arbiter and targets vga_default_device(), which is the dGPU,
> and __vga_tryget() reaches enable_them: with
> PCI_VGA_STATE_CHANGE_BRIDGE set. That writes PCI_BRIDGE_CTL_VGA on 00:01.0.
> 
> The commit's stated intent was to stop the iGPU from clobbering the
> VGA routing of an external GPU. On this machine, removing the iGPU
> from the race had the opposite effect: it let the dGPU become the
> first user and turned bridge VGA forwarding on.
> 
> ## Evidence
> 
> I built v7.1.5 with a printk in pci_set_vga_state() and in the bridge
> walk, and did three boots with my workaround disabled.
> 
> 1) v7.1.5 + instrumentation, normal graphical boot (X running):
> 
>   [10.716117] pcieport 0000:00:01.0: BRIDGE_CONTROL=0x0002 VGA_en=0
>   [10.716695] i915   0000:00:02.0: set_vga_state decode=0 flags=0x1
>   [10.717607] amdgpu 0000:01:00.0: set_vga_state decode=1 flags=0x1
>   [10.718134] pcieport 0000:00:01.0: ctl 0x0002 -> wrote 0x000a
>                                      -> read 0x000a
> 
>   # setpci -s 00:01.0 BRIDGE_CONTROL
>   000a
>   # cat /sys/class/backlight/gmux_backlight/actual_brightness
>   16777215                                        <- broken
> 
> Note the write happens at 10.7s, which is when lightdm/Xorg starts,
> not during any driver probe.
> 
> 2) The same kernel booted with systemd.unit=multi-user.target, i.e. no
> display manager, no X. Measured twice, 60 seconds apart:
> 
>   [10.167675] i915 0000:00:02.0: vgaarb: VGA decodes changed:
>               olddecodes=io+mem,decodes=io:owns=io+mem
> 
> ... and that is the entire vgaarb log for the boot. No
> vga_arbiter_notify_clients(), no pci_set_vga_state(), no bridge write.
> That single line is vga_set_legacy_decoding() from intel_vga.c, which
> does not count as arbiter "first use", so vga_arbiter_used stays
> false.
> 
>   # setpci -s 00:01.0 BRIDGE_CONTROL
>   0002
>   # cat /sys/class/backlight/gmux_backlight/actual_brightness
>   808  <- works
> 
> 3) v6.18.41 (before the commit), normal graphical boot, X running:
> 
>   [9.160032] i915   0000:00:02.0: vgaarb: VGA decodes changed:
>              olddecodes=io+mem,decodes=none:owns=io+mem
>   [9.166861] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
>              olddecodes=io+mem,decodes=none:owns=none
>   [10.053446] i915 0000:00:02.0: [drm] [ENCODER:105:DDI A/PHY A]
>               failed to retrieve link info, disabling eDP
> 
>   # setpci -s 00:01.0 BRIDGE_CONTROL
>   0002
>   # cat /sys/class/backlight/gmux_backlight/actual_brightness
>   808                                             <- works
> 
> Here arbiter first use happens at 9.16s, during i915 probe, well
> before X. By the time X calls vga_get() on the dGPU, vga_arbiter_used
> is already true and vga_check_first_use() is a no-op.
> 
> So: same X, same hardware, same userspace. On v6.18 the iGPU gets
> there first and nothing is written. On v7.1.5 the iGPU is no longer in
> the race and the dGPU's bridge gets PCI_BRIDGE_CTL_VGA set.
> 
> This also narrows the regression window to v6.18..v7.1, which is where
> cc6ed470caa2 landed.
> 
> Boot 2 is the clean control: identical kernel, identical firmware
> state, and the only variable is whether a graphical session starts.
> 
> ## Why that kills the backlight
> 
> Recapping from my previous mail, since the audience has grown:
> 
> MacBookPro13,3 has an apple-gmux at PNP resource 0x700-0x7fe using the
> indexed protocol:
> 
>   GMUX_PORT_READ         0x7d0
>   GMUX_PORT_WRITE        0x7d4
>   index magic            0x7cc / 0x7cd / 0x7ce
> 
> With PCI_BRIDGE_CTL_VGA set and 16-bit decode clear, the bridge
> decodes legacy VGA I/O with only 10 address bits, so 0x3c0-0x3df
> aliases onto 0x7c0-0x7df. Every gmux port above is inside that window.
> The bridge claims the cycles and forwards them to the dGPU, so every
> gmux read returns 0xff and every gmux write is swallowed.
> 
> apple_gmux has already probed successfully by then, so it reports no
> error. actual_brightness just starts reading 16777215 (0x00ffffff,
> which is GMUX_BRIGHTNESS_MASK applied to all-ones) and nothing
> controls the panel any more. brightnessctl, the Touch Bar keys and the
> desktop slider all go through this one backlight device, so all three
> fail.
> 
> ## Workaround
> 
>   # setpci -s 00:01.0 BRIDGE_CONTROL=0000:0008
>   # modprobe -r apple_gmux && modprobe apple_gmux
> 
> Since the bridge write happens exactly once per boot, doing this once
> after the graphical session is up is sufficient for that boot.
> 
> ## Where I think the fix belongs
> 
> I do not think reverting cc6ed470caa2 is the right answer, since it
> fixes a real problem for dGPU users. But I would note that the iGPU
> was previously acting as an unintentional guard: by always being the
> first arbiter user, it kept bridge VGA forwarding off on machines
> where nothing needs it.
> 
> Two things look wrong to me independently of that commit, and I would
> appreciate an opinion from the PCI side:
> 
> 1. __vga_put() never calls pci_set_vga_state(), so PCI_BRIDGE_CTL_VGA
> is set on first use and then never cleared, even after both devices
> have settled at decodes=none. On this machine the final arbiter state
> is decodes=none for both GPUs, yet the bridge is still forwarding
> legacy VGA. That seems like a leak rather than intended behaviour.
> 
> 2. vga_arbiter_notify_clients() drives both devices to decodes=none
> when vga_count > 1, and the bridge write happens as part of that same
> first-use path. Enabling forwarding on a bridge while simultaneously
> telling every client it decodes nothing seems contradictory.
> 
> Either fixing (1) or having the iGPU still participate in the
> arbiter's first-use accounting without doing the I/O grab would
> resolve this machine.
> 
> I am happy to test any patch on this hardware. I have an instrumented
> build set up and can turn a test around in a couple of hours.
> 
> On Mon, Aug 3, 2026 at 8:01 PM Haram Choi <haram@choiharam.com> wrote:
> >
> > Resending to linux-pci as requested.
> >
> > Since the first mail I have narrowed this down further, and in doing
> > so found that my original description of the root cause was partly
> > wrong. The corrected analysis is below. The short version:
> >
> >   - The regression is that PCI_BRIDGE_CTL_VGA (bit 3) on the root port
> > 00:01.0 is left SET after the VGA arbiter has settled with
> > decodes=none for both VGA devices. On 6.12 and 6.16 it ends CLEAR.
> >
> >   - The 16-bit decode bit (bit 4) is not the cause. The kernel never
> > writes it. It only determines whether a bridge that is already
> > forwarding legacy VGA does so with 10 or 16 address bits.
> >
> >   - The subject line therefore misattributes the cause. The aliasing
> > is a consequence, not the trigger. I have kept the subject unchanged
> > so the thread stays intact.
> >
> > I have a v7.1.5 build with instrumentation in drivers/pci/pci.c and
> > drivers/pci/vgaarb.c ready to boot; I will follow up in this thread
> > with the traces.
> >
> > ## Summary
> >
> > Since Linux 7.1 the backlight on a MacBookPro13,3 (15" 2016, Touch
> > Bar) cannot be controlled at all. apple_gmux still probes successfully
> > during boot, but the VGA arbiter leaves PCI_BRIDGE_CTL_VGA set on the
> > root port 00:01.0. With legacy VGA forwarding enabled and only 10
> > address bits decoded, 0x3c0-0x3df aliases onto 0x7c0-0x7df, which is
> > exactly where the gmux indexed protocol registers live. The bridge
> > claims those cycles and forwards them to the dGPU. Every gmux read
> > returns 0xff and every gmux write is swallowed.
> >
> > - Last known good: 6.16.10 (Arch linux 6.16.10.arch1-1)
> > - Also good:       6.12.51 (Arch linux-lts 6.12.51-1)
> > - Bad:             7.1.5   (Arch linux 7.1.5.arch1-2)
> >
> > ## Hardware
> >
> > DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C,
> >      BIOS 529.120.1.0.0 03/14/2024
> >
> > 00:01.0 PCI bridge [0604]: Intel 6th-10th Gen Core Processor PCIe
> >         Controller (x16) [8086:1901] (rev 07)
> > 00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2
> >         [HD Graphics 530] [8086:191b] (rev 06)   -> i915
> > 01:00.0 VGA compatible controller [0300]: AMD Baffin
> >         [Radeon Pro 455] [1002:67ef] (rev c7)    -> amdgpu
> >
> > gmux: PNP HID APP000B, "Found gmux version 4.0.29 [indexed]"
> >       PNP resource 0x700-0x7fe
> >
> > Note that 00:02.0 (i915) is not behind 00:01.0, but 01:00.0 (amdgpu) is.
> >
> > ## Symptom
> >
> >   $ cat /sys/class/backlight/gmux_backlight/actual_brightness
> >   16777215
> >
> > 16777215 is 0x00ffffff, which is GMUX_BRIGHTNESS_MASK applied to an
> > all-ones I/O read. Writes to brightness have no effect. brightnessctl,
> > the Touch Bar brightness keys and the desktop brightness slider all
> > fail, because all three go through this single backlight device.
> >
> > ## Root cause
> >
> > PCI_BRIDGE_CONTROL (offset 0x3e) of 00:01.0, read after boot has settled:
> >
> >   6.12.51-lts   : 0x0012   SERR | VGA_16BIT,  VGA enable CLEAR  -> works
> >   7.1.5-arch1-2 : 0x000a   SERR | VGA enable, VGA_16BIT CLEAR   -> broken
> >
> > I originally read this as "VGA_16BIT was cleared". That is not what
> > matters. I tested all four combinations of bit 3 and bit 4 at runtime
> > on 7.1.5 via setpci, reading actual_brightness after each change:
> >
> >   bit3 VGA_en   bit4 16BIT   value    actual_brightness   result
> >   -----------   ----------   ------   -----------------   ------
> >        1             1       0x001a          808          works
> >        0             1       0x0012          808          works
> >        1             0       0x000a       16777215        BROKEN
> >        0             0       0x0002          808          works
> >
> > Only the single combination "VGA enable set, 16-bit decode clear"
> > breaks gmux, which is exactly what the PCI-to-PCI Bridge specification
> > predicts: bit 4 only has meaning while bit 3 is set. So the regression
> > is that bit 3 is left set, not that bit 4 is clear.

Sounds to me like the best fix would be to explicitly enable
16 bit decoding on the bridges on these machines. That would
guarantee that apple-gmux works regardless of which GPU
drivers are loaded, and in which order.

> >
> > This also matches the code. PCI_BRIDGE_CTL_VGA_16BIT does not appear
> > anywhere in the v7.1.5 tree; it is not even defined in
> > include/uapi/linux/pci_regs.h, where the bit list goes straight from
> > PCI_BRIDGE_CTL_VGA (0x08) to PCI_BRIDGE_CTL_MASTER_ABORT (0x20). The
> > kernel never reads or writes bit 4, so bit 4 cannot be the regression.
> >
> > PCI_BRIDGE_CTL_VGA is written in exactly one place,
> > pci_set_vga_state() in drivers/pci/pci.c, which has exactly two
> > callers, both in drivers/pci/vgaarb.c.
> >
> > With bit 3 set and bit 4 clear, address bits [15:10] are ignored for
> > legacy VGA I/O, so:
> >
> >   0x3b0-0x3bb  ->  0x7b0-0x7bb
> >   0x3c0-0x3df  ->  0x7c0-0x7df
> >
> > apple-gmux uses these ports on this machine:
> >
> >   GMUX_PORT_READ         0x7d0     (aliases 0x3d0)
> >   GMUX_PORT_WRITE        0x7d4     (aliases 0x3d4)
> >   index magic sequence   0x7cc     (aliases 0x3cc)
> >                          0x7cd     (aliases 0x3cd)
> >                          0x7ce     (aliases 0x3ce)
> >
> > All of them fall inside the aliased window, so the bridge steals them.
> >
> > ## Direct verification via /dev/port on 7.1.5
> >
> > Before:
> >
> >   inb(0x7cc) = ff   inb(0x7cd) = ff   inb(0x7ce) = ff
> >   inb(0x7d0) = ff   inb(0x7d4) = ff
> >
> > Clearing VGA enable, or setting 16-bit decode, either one is sufficient:
> >
> >   # setpci -s 00:01.0 BRIDGE_CONTROL=0000:0008    # clear bit 3
> >   or
> >   # setpci -s 00:01.0 BRIDGE_CONTROL=0010:0010    # set bit 4
> >
> > After (gmux_is_indexed() magic sequence, write 0xaa/0x55/0x00 then read back):
> >
> >   outb(0x7cc, 0xaa); outb(0x7cd, 0x55); outb(0x7ce, 0x00)
> >   inb(0x7cc) = aa   inb(0x7cd) = 55        -> gmux responds
> >
> > Then:
> >
> >   # modprobe -r apple_gmux && modprobe apple_gmux
> >   apple_gmux: Found gmux version 4.0.29 [indexed]
> >
> >   # cat /sys/class/backlight/gmux_backlight/actual_brightness
> >   118
> >
> > 118 is the value the panel had actually been stuck at the whole time,
> > which confirms that no write had ever reached the hardware. Writing
> > 100 / 400 / 700 / 1023 afterwards changes the panel brightness,
> > visually confirmed.
> >
> > ## Boot timeline
> >
> > 7.1.5-arch1-2 (broken):
> >
> >   [  7.947] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> >   [  7.947] pci 0000:00:02.0: vgaarb: VGA device added:
> >                                decodes=io+mem,owns=io+mem,locks=none
> >   [  7.947] pci 0000:01:00.0: vgaarb: setting as boot VGA device
> >                                (overriding previous)
> >   [  7.948] pci 0000:01:00.0: vgaarb: VGA device added:
> >                                decodes=io+mem,owns=none,locks=none
> >   [  8.005] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> >   [  9.494] apple_gmux: Found gmux version 4.0.29 [indexed]
> >   [ 10.059] i915 0000:00:02.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=io:owns=io+mem
> >   [ 11.150] i915 0000:00:02.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io,decodes=none:owns=io+mem
> >   [ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=none:owns=none
> >
> > 6.16.10-arch1-1 (good):
> >
> >   [  6.785] pci 0000:00:02.0: vgaarb: VGA device added:
> >                                decodes=io+mem,owns=io+mem,locks=none
> >   [  6.785] pci 0000:01:00.0: vgaarb: setting as boot VGA device
> >                                (overriding previous)
> >   [  6.785] pci 0000:01:00.0: vgaarb: VGA device added:
> >                                decodes=io+mem,owns=none,locks=none
> >   [  6.839] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> >   [  8.339] apple_gmux: Found gmux version 4.0.29 [indexed]
> >   [  8.348] i915 0000:00:02.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=none:owns=io+mem
> >   [  8.349] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=none:owns=none
> >
> > 6.12.51-lts (good):
> >
> >   [  8.480] apple_gmux: Found gmux version 4.0.29 [indexed]
> >   [  8.487] i915 0000:00:02.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=none:owns=io+mem
> >   [  8.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
> >                                olddecodes=io+mem,decodes=none:owns=none
> >
> > Two differences stand out:
> >
> > 1. On 7.1.5, 00:02.0 gets "setting as boot VGA device". On 6.16 it
> > does not, even though 01:00.0 still says "(overriding previous)" in
> > both.
> >
> > 2. On 6.12 and 6.16 the i915 legacy decode goes io+mem -> none in a
> > single step. On 7.1.5 it goes io+mem -> io, and then about 1.1 seconds
> > later io -> none.
> >
> > The final arbiter state is decodes=none for both devices on all three
> > kernels, yet only on 7.1.5 does the bridge end up with
> > PCI_BRIDGE_CTL_VGA set.
> >
> > ## Suspected commit
> >
> > Of the commits you listed for v6.16..v7.1 in drivers/pci/vgaarb.c, the
> > one that best fits is:
> >
> >   94555ea9a048 ("PCI/VGA: Pass errors from pci_set_vga_state() up")
> >
> > pci_set_vga_state() writes PCI_BRIDGE_CONTROL on each bridge in the
> > path and only afterwards reads the register back, returning -EIO if
> > VGA enable did not stick. It returns from inside the walk, so bridges
> > further up the path are left unprocessed and the ones already written
> > stay written.
> >
> > That error used to be discarded by __vga_tryget(). After 94555ea9a048
> > it aborts the function:
> >
> >     err = pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
> >     if (err)
> >         return ERR_PTR(err);
> >
> >     vgadev->owns |= wants;          /* now skipped on error */
> >
> > and likewise for the conflict path, where "conflict->owns &= ~match"
> > is skipped. Either way the arbiter's bookkeeping stops matching what
> > was actually programmed into the bridge, so the later transition to
> > decodes=none never issues the matching pci_set_vga_state(..., false,
> > ...) that would clear PCI_BRIDGE_CTL_VGA. The bridge stays enabled.
> >
> > The two-step i915 decode transition on 7.1.5 is consistent with an
> > operation that aborted partway and was retried.
> >
> > Two other candidates I have not excluded, both of which change which
> > device is selected as the boot VGA device and could explain difference
> > (1) above:
> >
> >   337bf13aa9dd ("PCI/VGA: Replace vga_is_firmware_default() with a
> >                  screen info check")
> >   fd390ff14451 ("PCI/VGA: Don't assume the only VGA device on a system
> >                  is boot_vga")
> >
> > I believe 2a93c9851b2b ("PCI/VGA: Pass vga_get_uninterruptible()
> > errors to userspace") can be excluded, since it only changes the
> > /dev/vga_arbiter write path, which is not used on this KMS-only
> > system.
> >
> > ## Workaround
> >
> >   # setpci -s 00:01.0 BRIDGE_CONTROL=0000:0008
> >   # modprobe -r apple_gmux && modprobe apple_gmux
> >
> > Clearing VGA enable is enough, and is what 6.12 and 6.16 end up with
> > anyway. This machine is KMS only and "amdgpu: vgaarb: deactivate vga
> > console" has already happened, so nothing depends on legacy VGA
> > forwarding here.
> >
> > (I had previously been using BRIDGE_CONTROL=0010:0010, setting 16-bit
> > decode. That also works, but it masks the symptom rather than
> > restoring the pre-7.1 state.)
> >
> > ## Open question
> >
> > I cannot explain why bit 4 reads as 1 on 6.12 and 0 on 7.1.5, given
> > that the kernel never writes it. The only full-register overwrites of
> > PCI_BRIDGE_CONTROL I can find are drivers/pci/setup-bus.c:907
> > (bus->bridge_ctl) and drivers/pci/probe.c:1571, neither of which
> > tracks bit 4. This does not affect the analysis above, since bit 4 is
> > harmless while bit 3 is clear, but it may be of interest.
> >
> > ## Notes
> >
> > - The breakage happens after apple_gmux has already probed, so the
> > driver reports no error. The failure is silent.
> > - drivers/platform/x86/apple-gmux.c only received cosmetic changes
> > during the 7.1 cycle, so this looks like a PCI / vgaarb side issue
> > rather than a driver bug.
> > - A machine with a discrete GPU behind 00:01.0 and gmux at 0x700-0x7fe
> > is the affected shape. MacBookPro13,1 and 13,2 have no dGPU and no
> > bridge in the path, so they are presumably unaffected.
> >
> > I am happy to test patches or revert candidates on this machine.
> >
> >
> > 2026년 8월 3일 (월) 오후 6:01, Bjorn Helgaas <bhelgaas@google.com>님이 작성:
> > >
> > > Thanks for the report.  It does look like vgaarb.c is the most likely culprit.  There are only a few commits to that file between v6.16 and v7.1.  If you have time, it would be helpful to identify the specific one that broke this.  Here's what git log v6.16..v7.1 said:
> > >
> > > 94555ea9a048 PCI/VGA: Pass errors from pci_set_vga_state() up
> > > 2a93c9851b2b PCI/VGA: Pass vga_get_uninterruptible() errors to userspace
> > > bf4afc53b77a Convert 'alloc_obj' family to use the new default GFP_KERNEL argument
> > > 69050f8d6d07 treewide: Replace kmalloc with kmalloc_obj for non-scalar types
> > > 0c61526621ec Merge tag 'efi-next-for-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
> > > fd390ff14451 PCI/VGA: Don't assume the only VGA device on a system is boot_vga
> > > a41e0ab394e4 sysfb: Replace screen_info with sysfb_primary_display
> > > a78835b86a44 PCI/VGA: Select SCREEN_INFO on X86
> > > 337bf13aa9dd PCI/VGA: Replace vga_is_firmware_default() with a screen info check
> > >
> > > I think the convert, treewide, and merge commits are unlikely.
> > >
> > > Can you please resend this report to linux-pci@vger.kernel.org?
> > >
> > > On Fri, Jul 31, 2026 at 5:57 PM Haram Choi <haram@choiharam.com> wrote:
> > >>
> > >> # [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 - PCI bridge left with VGA enable set and VGA 16-bit decode cleared, aliasing legacy VGA I/O over the gmux ports
> > >>
> > >> ## Summary
> > >>
> > >> Since Linux 7.1 the backlight on a MacBookPro13,3 (15" 2016, Touch Bar) cannot be controlled at all. `apple_gmux` still probes successfully during boot, but a few hundred milliseconds later the VGA arbiter reprograms `PCI_BRIDGE_CONTROL` of the root port `00:01.0` into a state where the bridge decodes legacy VGA I/O with only 10 address bits. `0x3c0-0x3df` then aliases onto `0x7c0-0x7df`, which is exactly where the gmux "indexed" protocol registers live, so the bridge claims those cycles and forwards them to the dGPU. Every gmux read returns `0xff` and every gmux write is swallowed.
> > >>
> > >> - Last known good: 6.16.10 (Arch `linux` 6.16.10.arch1-1)
> > >> - Also good: 6.12.51 (Arch `linux-lts` 6.12.51-1)
> > >> - Bad: 7.1.5 (Arch `linux` 7.1.5.arch1-2)
> > >>
> > >> ## Hardware
> > >>
> > >> ```
> > >> DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS 529.120.1.0.0 03/14/2024
> > >>
> > >> 00:01.0 PCI bridge [0604]: Intel 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
> > >> 00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2 [HD Graphics 530] [8086:191b] (rev 06)   -> i915
> > >> 01:00.0 VGA compatible controller [0300]: AMD Baffin [Radeon Pro 455] [1002:67ef] (rev c7)             -> amdgpu
> > >>
> > >> gmux: PNP HID APP000B, "Found gmux version 4.0.29 [indexed]"
> > >> ```
> > >>
> > >> ## Symptom
> > >>
> > >> ```
> > >> $ cat /sys/class/backlight/gmux_backlight/actual_brightness
> > >> 16777215
> > >> ```
> > >>
> > >> 16777215 is `0x00ffffff`, which is `GMUX_BRIGHTNESS_MASK` applied to an all-ones I/O read. Writes to `brightness` have no effect. `brightnessctl`, the Touch Bar brightness keys and the desktop brightness slider all fail, because all three go through this single backlight device.
> > >>
> > >> ## Root cause
> > >>
> > >> `PCI_BRIDGE_CONTROL` (offset 0x3e) of `00:01.0`, read after boot has settled:
> > >>
> > >> ```
> > >> 6.12.51-lts   : 0x0012   bit1 SERR, bit4 VGA_16BIT set, bit3 VGA enable clear   -> works
> > >> 6.16.10-arch1 : (not read at register level, but backlight works)
> > >> 7.1.5-arch1-2 : 0x000a   bit1 SERR, bit3 VGA enable set, bit4 VGA_16BIT clear   -> broken
> > >> ```
> > >>
> > >> With `PCI_BRIDGE_CTL_VGA` set and `PCI_BRIDGE_CTL_VGA_16BIT` clear, the bridge ignores address bits [15:10] for legacy VGA I/O, so the ranges alias:
> > >>
> > >> ```
> > >> 0x3b0-0x3bb  ->  0x7b0-0x7bb
> > >> 0x3c0-0x3df  ->  0x7c0-0x7df
> > >> ```
> > >>
> > >> apple-gmux uses the following ports on this machine (PNP resource `0x700-0x7fe`):
> > >>
> > >> ```
> > >> GMUX_PORT_READ         0x7d0
> > >> GMUX_PORT_WRITE        0x7d4
> > >> index magic sequence   0x7cc / 0x7cd / 0x7ce
> > >> ```
> > >>
> > >> All of them fall inside the aliased window, so the bridge steals them.
> > >>
> > >> ## Direct verification via /dev/port on 7.1.5
> > >>
> > >> Before:
> > >>
> > >> ```
> > >> inb(0x7cc) = ff   inb(0x7cd) = ff   inb(0x7ce) = ff
> > >> inb(0x7d0) = ff   inb(0x7d4) = ff
> > >> ```
> > >>
> > >> Set only the 16-bit decode bit, nothing else:
> > >>
> > >> ```
> > >> # setpci -s 00:01.0 BRIDGE_CONTROL=0010:0010
> > >> ```
> > >>
> > >> After (gmux_is_indexed() magic sequence, write 0xaa/0x55/0x00 then read back):
> > >>
> > >> ```
> > >> outb(0x7cc, 0xaa); outb(0x7cd, 0x55); outb(0x7ce, 0x00)
> > >> inb(0x7cc) = aa   inb(0x7cd) = 55        -> gmux responds
> > >> ```
> > >>
> > >> Then:
> > >>
> > >> ```
> > >> # modprobe -r apple_gmux && modprobe apple_gmux
> > >> apple_gmux: Found gmux version 4.0.29 [indexed]
> > >>
> > >> # cat /sys/class/backlight/gmux_backlight/actual_brightness
> > >> 118
> > >> ```
> > >>
> > >> 118 is the value the panel had actually been stuck at the whole time, which confirms that no write had ever reached the hardware. Writing 100 / 400 / 700 / 1023 afterwards changes the panel brightness, visually confirmed.
> > >>
> > >> ## Boot timeline
> > >>
> > >> 7.1.5-arch1-2 (broken):
> > >>
> > >> ```
> > >> [  7.947] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> > >> [  7.947] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> > >> [  7.947] pci 0000:01:00.0: vgaarb: setting as boot VGA device (overriding previous)
> > >> [  7.948] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> > >> [  8.005] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> > >> [  9.494] apple_gmux: Found gmux version 4.0.29 [indexed]          <-- probe still OK
> > >> [ 10.059] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io:owns=io+mem
> > >> [ 11.150] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io,decodes=none:owns=io+mem
> > >> [ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
> > >> ```
> > >>
> > >> 6.16.10-arch1-1 (good):
> > >>
> > >> ```
> > >> [  6.785] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> > >> [  6.785] pci 0000:01:00.0: vgaarb: setting as boot VGA device (overriding previous)
> > >> [  6.785] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> > >> [  6.839] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> > >> [  8.339] apple_gmux: Found gmux version 4.0.29 [indexed]
> > >> [  8.348] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
> > >> [  8.349] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
> > >> ```
> > >>
> > >> 6.12.51-lts (good):
> > >>
> > >> ```
> > >> [  8.480] apple_gmux: Found gmux version 4.0.29 [indexed]
> > >> [  8.487] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
> > >> [  8.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
> > >> ```
> > >>
> > >> The relevant difference: on 6.12 and 6.16 the i915 legacy decode goes
> > >> `io+mem -> none` in a single step. On 7.1.5 it goes `io+mem -> io` and then, about 1.1 seconds later, `io -> none`. The final arbiter state is `decodes=none` for both devices on all three kernels, yet only on 7.1.5 does the bridge end up with `PCI_BRIDGE_CTL_VGA` set and `PCI_BRIDGE_CTL_VGA_16BIT` cleared. The intermediate `decodes=io` state appears to leave the bridge in the 10-bit aliasing configuration and the subsequent transition to `none` does not undo it.
> > >>
> > >> `drivers/platform/x86/apple-gmux.c` only received cosmetic changes during the 7.1 cycle, so this looks like a PCI / vgaarb side change rather than a driver bug.
> > >>
> > >> ## Workaround
> > >>
> > >> ```
> > >> # setpci -s 00:01.0 BRIDGE_CONTROL=0010:0010
> > >> # modprobe -r apple_gmux && modprobe apple_gmux
> > >> ```
> > >>
> > >> Setting the 16-bit decode bit is enough. This machine is KMS only and
> > >> `amdgpu: vgaarb: deactivate vga console` has already happened, so nothing depends on 10-bit legacy VGA I/O aliasing here.
> > >>
> > >> ## Notes
> > >>
> > >> - The breakage happens after `apple_gmux` has already probed, so the driver reports no error. The failure is silent.
> > >> - A machine with a discrete GPU behind `00:01.0` and gmux at `0x700-0x7fe` is the affected shape. MacBookPro13,1 and 13,2 have no dGPU and no bridge in the path, so they are presumably unaffected.
> > >>
> > >> #regzbot introduced: v6.16..v7.1
> > >>

-- 
Ville Syrjälä
Intel
