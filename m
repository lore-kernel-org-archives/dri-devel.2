Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2EAC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C7610E331;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=7mind.io header.i=@7mind.io header.b="DtyMn0nk";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aL7VW6Va";
	dkim-atps=neutral
X-Greylist: delayed 400 seconds by postgrey-1.36 at gabe;
 Sat, 19 Sep 2026 09:01:25 UTC
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0558610E1A3;
 Sat, 19 Sep 2026 09:01:24 +0000 (UTC)
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
 by mailfout.stl.internal (Postfix) with ESMTP id 5DD251D000CB;
 Sat, 19 Sep 2026 04:54:43 -0400 (EDT)
Received: from ams-imap-09 ([10.64.2.29])
 by ams-compute-01.internal (MEProxy); Sat, 19 Sep 2026 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=7mind.io; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1789808082; x=1789894482; bh=avyF8HB0F+
 iMLh0xIXZVVma4WaeumreLJal6c/9H5uA=; b=DtyMn0nkzHGZ821WpOeskSTyee
 Lby5PIxXemO39seH5Y6UkU/pR+juW3oj/Ey7qd1krDyZKumXKySp9y6cNktXbJtO
 9AP0cJYlzcOOLEN/d1Vi3csvrRdTJ8b/fZydTvyivvRFSnsHYp+jWuhbuTDYgOAu
 B7XBbmdg0rxssnIFcMUjJ+TQPDil5UXZJwD1L1HyU98797bt2coBvXQbQskzgECn
 jgcvpVUU7emgJohshtb04/p0SaULnMfdpOJwT2ADiwiKZUmtpTS+Os1F9O9V5POR
 DXtraVlbNFJUakhkJRQ8qBzMhZbywnHAa7SUM8sh1mJNbPPJALckokQhmI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1789808082; x=1789894482; bh=avyF8HB0F+iMLh0xIXZVVma4WaeumreLJal
 6c/9H5uA=; b=aL7VW6VaC0QQdqoZ1XdPsBTmHGGhfx+9MPx/6naVhRSE4ysVe+3
 Dpew9kAI7nu7fTy9V46RkDGCVCUYxqYoAS2W6yPWAdXxosgeYgMauwUVJ/+XEuO1
 sa5VFRCFWgaEfwD8LlR14bezOWL9YUTj/TnkXgm3JfMVmZ8IsTLVNQrSzHM3rRJ7
 quGdg3x9gbxKW0es1r0n1dYADEvViR4YerinpsGXuX9gJ+TEfQVD+3VIaADssPB/
 fRmhANWxj5SiPtugHBXhO97ytPNY9OMigbd0PRepivq1yXGo5Hz5hnUqFz8iZeqk
 mqoYr33+2V5vns0CrxtY0zEnsxMl2VTeJJg==
X-ME-Sender: <xms:0E2uaud3x5b_mcXvOUXAvWYQY0NZ5CCaWDSMyiginBTBulp4LJTz-Q>
 <xme:0E2uajBrKh-PGTecwMWHDmqau5V85_0wXnMYGNhWqYXot1ZI8d0UKKKGra83ShDz5
 BKDCZQjeUOyN1UasbP_8lSI5nI_Bf_BB469iqGAWUkmRkrLx_TIZJk>
X-ME-Proxy-Cause: dmFkZTFV+ZTsJoG6mqcin+yHJw8W+Cmq5TB8GjSjGqp0p0bZIdk7sjNRp18WjfOg6QOjc+
 /2q64ll0Nb3GhdfP4V6t2daP5ohQvykPSjMTKI39DD1lhLA2LMFvfVPa7BVarGyYu7E+m0
 rhIAV8uLj+hiFLBNLI7YoHaI6zEvPQaScP2uiwT3SrBRUPseWW4xpfr1ubFdfCrKRekj1I
 sGAIYGXbFcEqNxjm1Bz45mewItV/UDefDrtH+G76/fJbQFdcd/K6Y0e8Wo6T4JWN/WW1bg
 yK0NcEnQMtakI+cZiHN3ZMcFsuhAQQGFigjQZVGZAJleepgeo1YY+TXsyhmUFSvf3mx0LH
 QTyO1AxUFwraAREPJqFvdWEGn4GH0mb+jUxAX5+eqrz4AwM5DOxdi7DhDJTneBcwmrh88z
 JrE4It93mxz5K0vWRVfG09cbnAcjkC7NWFKeP5zsXrA7M+N7lncHHHq3rClL1aDw8Lgx4m
 ihAuybHhpZKCGxpbApqoXRbEndpQ8E9TSQ4Gjscjc6pwQorWz4KNyrVq5y+3r4U0npQpMt
 b5o7ErNDZp3hGvC+4MlRB6xpa0D58mjka++5nCUDgdkQjY6hB17z6ptQQGpgguW7ZSwC2b
 s6X/23nGEre2tiRt0ynpXHvLaY5G+ErjD8r/T5cFKFENxgPqRjZ0MNwOuzkg
X-ME-Proxy: <xmx:0U2uagICcyfRLT9oOYA2LyvFAv5LBVVd8xFFA5tTlljUb7p4KX2cfw>
 <xmx:0U2uapcWi5kJOdHBHOgdSbM2skgvTtN7BEWgjW5A-9PJkdX_n1FOQw>
 <xmx:0U2uan8XLoKBk6gE9uVm0XTv1Edefm58wJWkiQ_uzwXld50LmpDQEA>
 <xmx:0U2uauo5ADE3pDVTu2Q4OjoDwVHGkVlyvfq9j5r84_PyBRFKIGU0wQ>
 <xmx:0k2uaiScm8we_pHMNUVS651VYQ9DGc--WGt7c7hto1G2tNDsWJFHu_Eo>
Feedback-ID: i0c9946bd:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id EDEE7180088; Sat, 19 Sep 2026 04:54:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AqIJOT_iLe_V
Date: Sat, 19 Sep 2026 09:54:19 +0100
From: "Pavel Shirshov" <pshirshov@7mind.io>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <323e4469-4460-4141-88db-e5526a560c44@app.fastmail.com>
In-Reply-To: <20260918203307.GA1192845@bhelgaas>
References: <20260918203307.GA1192845@bhelgaas>
Subject: Re: PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at boot when
 `pcie_aspm.policy=powersupersave` enables ASPM_L1.1 on AMD root port link
Content-Type: multipart/alternative;
 boundary=45621f1d45c0b2532bd65f862dc8ff0c0dae435b
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

--45621f1d45c0b2532bd65f862dc8ff0c0dae435b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Yes, still a problem, powersupersave kills BM cards, at least on my machines.


On Fri, Sep 18, 2026, at 21:33, Bjorn Helgaas wrote:
> On Thu, May 07, 2026 at 11:14:04PM +0100, Pavel Shirshov wrote:
> > The report and the patch below are completely claude'd but the quirk in the patch works.
> > 
> > PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at boot when
> > pcie_aspm.policy=powersupersave enables ASPM_L1.1 on AMD root port link
> 
> I happened on this report that we never responded to.  I assume this
> is still a problem?
> 
> It looks like it's not a regression, but should still be fixed.
> 
> > ================================================================
> > SUMMARY
> > ================================================================
> > 
> > On Linux 7.0.3, an Intel Arc Pro B70 (Battlemage / BMG-G31, GPU PCI
> > ID 8086:e223) plugged into an AMD Ryzen 9 5950X system fails to wake
> > from D3cold during PCI core enumeration when the kernel is booted
> > with pcie_aspm.policy=powersupersave. The card is permanently
> > inaccessible until reboot with a different policy.
> > pcie_aspm.policy=powersave (L0s+L1, no substates) works correctly.
> > 
> > The failure surfaces in PCI core first; downstream xe driver bind
> > then fails with -EPROTO:
> > 
> >     pcieport 0000:02:01.0: Unable to change power state from D3cold
> >                            to D0, device inaccessible
> >     pcieport 0000:02:02.0: Unable to change power state from D3cold
> >                            to D0, device inaccessible
> >     xe 0000:03:00.0: Unable to change power state from D3cold to D0,
> >                      device inaccessible
> >     xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
> >                      [misdetected: dead config space reads as 0xff]
> >     xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset
> >                      GuC state (-EPROTO)
> >     xe 0000:03:00.0: probe with driver xe failed with error -71
> > 
> > After the brick, "lspci -vvv -s 03:00.0" reports
> > "!!! Unknown header type 7f" -- the canonical signature of a PCI
> > device whose config space reads return all-ones, i.e. the link to the
> > device is dead.
> > 
> > 
> > ================================================================
> > HARDWARE
> > ================================================================
> > 
> > CPU / root complex:
> >     AMD Ryzen 9 5950X (Starship/Matisse). The root port hosting the
> >     BMG card is 0000:00:01.1 -- "Advanced Micro Devices, Inc. [AMD]
> >     Starship/Matisse GPP Bridge" (subsystem 1022:1453).
> > 
> > GPU:
> >     Intel Arc Pro B70 -- 8086:e223 (BMG-G31, subsystem 8086:1701).
> > 
> > On-card topology -- the card has a two-layer on-board PCIe switch:
> >     0000:01:00.0  Intel 8086:e2ff -- BMG card upstream switch port,
> >                                      PCIe 5.0 x16 capable (currently
> >                                      downgraded to Gen4 x16).
> >     0000:02:01.0  Intel 8086:e2f0 -- BMG card downstream switch
> >                                      port, PCIe Gen1 x1 internal.
> >     0000:03:00.0  Intel 8086:e223 -- GPU endpoint, PCIe Gen1 x1
> >                                      internal.
> > 
> > Other:
> >     BIOS has PCIe ASPM enabled in firmware. pcie_aspm=force is NOT
> >     set on the kernel command line. Motherboard: ASRock X570
> >     (specifics in attached dmidecode.txt).
> > 
> > 
> > ================================================================
> > REPRODUCER
> > ================================================================
> > 
> > Boot any kernel >= 7.0 with kernel command line containing:
> > 
> >     pcie_aspm.policy=powersupersave xe.force_probe=*
> > 
> > (Also reproduces under earlier 6.x kernels.)
> > 
> > Reverting the cmdline to "pcie_aspm.policy=powersave" and rebooting
> > restores the card. No firmware reset is required between attempts --
> > the brick is purely a runtime link-state failure during kernel boot.
> > 
> > 
> > ================================================================
> > ASPM NEGOTIATION
> > ================================================================
> > 
> > Captured with "lspci -vvv" on a working policy=powersave boot
> > (attached: 20260507-204348-powersave-7.0.3.tar.zst).
> > 
> > Link 1: 00:01.1 AMD root  <->  01:00.0 BMG upstream
> >     Lower end (AMD root, L1SubCap):
> >         PCI-PM_L1.2-  PCI-PM_L1.1+  ASPM_L1.2-  ASPM_L1.1+
> >     Upper end (BMG upstream, L1SubCap):
> >         PCI-PM_L1.2+  PCI-PM_L1.1+  ASPM_L1.2+  ASPM_L1.1+
> >     Active L1SubCtl1 under policy=powersave:
> >         PCI-PM_L1.2-  PCI-PM_L1.1-  ASPM_L1.2-  ASPM_L1.1-
> > 
> > Link 2: 01:00.0  <->  02:01.0   (card-internal switch)
> >     No L1SS capability advertised on either end.
> > 
> > Link 3: 02:01.0  <->  03:00.0   (card-internal to GPU)
> >     No L1SS capability advertised on either end.
> > 
> > Conclusion: only Link 1 -- the platform-facing AMD<->BMG link -- is
> > L1SS-capable on both ends, and the intersection is ASPM_L1.1 only
> > (the AMD GPP root port advertises L1.1 but not L1.2). With
> > policy=powersupersave, the kernel arms ASPM_L1.1 on this link. After
> > that, every D3cold->D0 transition fails.
> > 
> > Both ends advertise multi-retimer support (Retimer+ 2Retimers+ on
> > the AMD root port and on the BMG upstream port). Retimers + L1SS
> > have a history of wake-recovery problems on other platforms; this
> > may be the same class of issue.
> > 
> > 
> > ================================================================
> > TIMELINE -- failed boot, kernel 7.0.3
> > ================================================================
> > 
> > Excerpted from dmesg-relevant.txt in the powersupersave capture:
> > 
> >     28.792s  pcieport 0000:00:01.1: PME: Signaling with IRQ 48
> >                      [AMD root port for BMG]
> >     28.842s  pcieport 0000:02:01.0: Unable to change power state from
> >                      D3cold to D0, device inaccessible
> >     28.843s  pcieport 0000:02:02.0: Unable to change power state from
> >                      D3cold to D0, device inaccessible
> >     ...
> >     29.034s  xe 0000:03:00.0: Unable to change power state from
> >                      D3cold to D0, device inaccessible
> >     29.035s  xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
> >     29.035s  xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed
> >                      to reset GuC state (-EPROTO)
> >     29.035s  xe 0000:03:00.0: probe with driver xe failed with
> >                      error -71
> > 
> > The PCI core's first wake attempt at 28.842s (the immediate parent
> > bridge of the BMG GPU) fails before any driver probe runs. This
> > confirms the failure is in the PCI/ASPM layer, not in xe; xe just
> > sees the resulting dead config space and misclassifies the PF as a
> > VF.
> > 
> > 
> > ================================================================
> > WORKING-POLICY LSPCI EXCERPTS  (relevant capabilities)
> > ================================================================
> > 
> > policy=powersave baseline, root port 00:01.1:
> > 
> >     LnkCap:  Speed 16GT/s, Width x16, ASPM L1, Exit Latency L1 <64us
> >     LnkCtl:  ASPM L1 Enabled
> >     LnkSta:  Speed 16GT/s, Width x16
> >     Capabilities: [370 v1] L1 PM Substates
> >         L1SubCap:  PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
> >                    L1_PM_Substates+
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> >         L1SubCtl2:
> > 
> > policy=powersave baseline, BMG upstream 01:00.0:
> > 
> >     LnkCap:  Speed 32GT/s, Width x16, ASPM L1, Exit Latency L1 <32us
> >     LnkCtl:  ASPM L1 Enabled
> >     LnkSta:  Speed 16GT/s (downgraded), Width x16
> >     Capabilities: [244 v1] L1 PM Substates
> >         L1SubCap:  PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> >                    L1_PM_Substates+
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> >         L1SubCtl2: T_PwrOn=14us
> > 
> > 
> > ================================================================
> > PROPOSED FIX
> > ================================================================
> > 
> > Disable both L1SS substates on the BMG card's upstream switch port
> > (8086:e2ff) via a DECLARE_PCI_FIXUP_FINAL. Standard ASPM L1 still
> > applies, so the link still benefits from the deepest substate the
> > BMG silicon handles correctly. The quirk keys on the card upstream
> > port, which is shared across the BMG product family, so it covers
> > all current BMG SKUs without enumerating individual GPU-endpoint
> > IDs.
> > 
> > The patch is in the attached intel-bmg-disable-l1ss.patch. With the
> > patch applied, pcie_aspm.policy=powersupersave boots cleanly on this
> > hardware (verification in progress at time of report).
> > 
> > Empirical narrowing -- ASPM_L1.1 specifically is the trigger.
> > 
> >   An intermediate version of the quirk passed only
> >   PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2 to
> >   pci_disable_link_state(), leaving the PCI-PM substate bits armed.
> >   After applying that variant, lspci reported
> > 
> >       L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
> > 
> >   on the BMG upstream port -- i.e. only the two ASPM substate bits
> >   were cleared, the PCI-PM substate bits stayed armed -- yet the
> >   system booted, xe bound, and the GPU operated normally. Combined
> >   with the AMD root port advertising only ASPM_L1.1+ (not L1.2),
> >   this isolates ASPM_L1.1 as the specific bit whose activation
> >   bricks the BMG card. The PCI-PM L1.x substates were also disabled
> >   in the final patch for hygiene, but they are not load-bearing for
> >   the fix on this hardware (the GPU does not enter D3hot during
> >   normal operation, so PCI-PM substates are inert).
> > 
> > Remaining open questions for review:
> > 
> >   1. Is the underlying defect in the AMD Starship root port (cannot
> >      wake the link from ASPM_L1.1) or in the BMG e2ff upstream port
> >      (cannot exit ASPM_L1.1 cleanly)? If the former, future BMG
> >      cards on Intel platforms may not need this quirk; if the
> >      latter, the quirk is correct for BMG everywhere. We do not
> >      have a non-AMD reproducer to disambiguate.
> > 
> >   2. Should the quirk also apply to the AMD Starship/Matisse GPP
> >      Bridge itself (1022:1483 / 1022:1484-class IDs, see
> >      lspci-nn.txt)? That would be a broader brushstroke but might
> >      protect other devices presenting the same negotiation.
> > 
> > 
> > ================================================================
> > WORKAROUND IN USE
> > ================================================================
> > 
> > Until the quirk lands upstream, downstream users on this hardware
> > must boot with pcie_aspm.policy=powersave (or default), losing
> > ~25 W of idle savings that the deeper substates would otherwise
> > provide.
> > 
> > 
> > ================================================================
> > ATTACHMENTS
> > ================================================================
> > 
> > Tarballs produced by debug/20260507-aspm-capture.sh:
> > 
> >     20260507-204348-powersave-7.0.3.tar.zst
> >         -- working baseline
> > 
> >     20260507-205055-powersupersave-7.0.3.tar.zst
> >         -- failed reproduction
> > 
> > Each tarball contains:
> > 
> >     manifest.txt           kernel, policy, hostname, GPU BDFs
> >     cmdline.txt            kernel command line
> >     uname.txt              kernel version
> >     nixos.txt              userspace metadata
> >     dmidecode.txt          BIOS/board info
> >     lspci-tree.txt         PCI topology
> >     lspci-nn.txt           PCI device list
> >     lspci-vvv-all.txt      full system lspci -vvv
> > 
> >     gpu-03_00_0/           per-device captures for the GPU and
> >                            every PCI ancestor up to the root
> >                            complex:
> >         lspci-vvv.txt          GPU
> >         parent-0-02_01_0.txt   BMG card-internal downstream switch
> >         parent-1-01_00_0.txt   BMG card upstream port (e2ff)
> >         parent-2-00_01_1.txt   AMD root port
> >         sysfs.txt              selected sysfs attributes
> > 
> >     dmesg-full.txt                full kernel ring buffer
> >     dmesg-relevant.txt            filtered for PCI/xe/ASPM/L1
> >     journal-kernel-current-boot.txt
> >     journal-kernel-prev-boot.txt
> >     drivers.txt                   xe / i915 driver state,
> >                                   /sys/class/drm
> > 
> > Patch: intel-bmg-disable-l1ss.patch  (attached separately)
> > 
> > NixOS 26.05 (nixpkgsRevision:
> >     549bd84d6279f9852cae6225e372cc67fb91a4c1)
> > 
> > Kernel:
> >     7.0.3 #1-NixOS SMP PREEMPT_DYNAMIC Thu Apr 30 09:13:05 UTC 2026
> 
> 
> 
> > PCI/ASPM: disable L1.1/L1.2 substates for Intel Battlemage discrete GPU upstream port
> > 
> > Intel Battlemage (BMG-G21 / BMG-G31, e.g. Arc Pro B70) discrete GPU cards
> > expose a two-layer on-card PCIe switch:
> > 
> >     AMD/Intel root port  <->  8086:e2ff (BMG card upstream)
> >                               8086:e2f0 (BMG card downstream)
> >                               8086:e22x (BMG GPU endpoint, e.g. e223 = Arc Pro B70)
> > 
> > The platform-facing link (root port <-> 8086:e2ff) is the only link in the
> > chain that advertises L1 PM Substates support on both ends. On AMD
> > Starship/Matisse (Ryzen 5xxx) root ports, the intersection is ASPM_L1.1
> > only (the AMD port advertises L1.1 but not L1.2). When pcie_aspm.policy=
> > powersupersave arms ASPM_L1.1 on this link, the BMG card cannot recover
> > from the resulting low-power state on subsequent D3cold->D0 transition,
> > leaving the device permanently inaccessible:
> > 
> >     pcieport 0000:02:01.0: Unable to change power state from D3cold to D0, device inaccessible
> >     xe 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
> >     xe 0000:03:00.0: [drm] Running in SR-IOV VF mode    [misdetected: dead config space]
> >     xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset GuC state (-EPROTO)
> >     xe 0000:03:00.0: probe with driver xe failed with error -71
> > 
> > Reproduces deterministically on Linux 7.0.3 with an Arc Pro B70 in an
> > AMD Ryzen 9 5950X system. pcie_aspm.policy=powersave (L0s+L1 only, no
> > substates) works correctly; pcie_aspm.policy=powersupersave bricks the
> > card on every boot. The 6.x-era blanket `no_d3cold` quirk for Battlemage
> > was narrowed to ASUS NUC13 only in 7.0, but that change is orthogonal:
> > the failure here is link-state, not device-state, and surfaces
> > regardless of d3cold_allowed.
> > 
> > Disable all four L1SS substates (ASPM_L1.1, ASPM_L1.2, PCI-PM_L1.1,
> > PCI-PM_L1.2) on the BMG card's upstream port via a final PCI fixup.
> > Standard ASPM L1 still applies, so the link still benefits from the
> > deepest substate the BMG silicon actually handles correctly. The
> > quirk is keyed on the upstream-port device ID 0xe2ff so it covers
> > all current Battlemage SKUs (the GPU-endpoint ID varies by SKU, but
> > the upstream switch is shared).
> > 
> > Empirical narrowing (verified post-fix): with a partial mask that
> > disabled only ASPM_L1.{1,2} but left PCI-PM_L1.{1,2} armed, the
> > system boots and operates correctly. This isolates ASPM_L1.1 as the
> > specific trigger of the brick (the AMD root port advertises ASPM_L1.1
> > but not ASPM_L1.2, so ASPM_L1.2 cannot have been activated). The
> > PCI-PM substates only activate during D3hot transitions which the
> > GPU does not undergo during normal use; they are disabled here for
> > hygiene rather than necessity.
> > 
> > Reported-by: Pavel Shirshov <pavel@7mind.io>
> > Signed-off-by: <FILL IN BEFORE SUBMITTING UPSTREAM>
> > 
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6289,6 +6289,34 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
> > +
> > +/*
> > + * Intel Battlemage discrete GPU cards (BMG-G21 / BMG-G31; Arc B580,
> > + * Arc Pro B50/B60/B70) expose a two-layer on-card PCIe switch. The
> > + * platform-facing link, between the host root port and the card's
> > + * upstream switch port (PCI device ID 0xe2ff), is the only link in the
> > + * chain advertising L1 PM Substates on both ends. On at least AMD
> > + * Starship/Matisse root ports, where the intersection is ASPM_L1.1
> > + * only, arming L1.1 leaves the BMG card unable to wake from D3cold:
> > + *
> > + *   pcieport 0000:02:01.0: Unable to change power state from D3cold
> > + *                          to D0, device inaccessible
> > + *   xe 0000:03:00.0: probe with driver xe failed with error -71
> > + *
> > + * Reproduces deterministically with pcie_aspm.policy=powersupersave,
> > + * works correctly with policy=powersave (no substates). Disable L1SS
> > + * substates on the BMG card upstream port; standard L1 ASPM is
> > + * unaffected.
> > + */
> > +static void quirk_intel_bmg_no_l1ss(struct pci_dev *dev)
> > +{
> > + pci_disable_link_state(dev, PCIE_LINK_STATE_L1_2 |
> > +     PCIE_LINK_STATE_L1_1 |
> > +     PCIE_LINK_STATE_L1_2_PCIPM |
> > +     PCIE_LINK_STATE_L1_1_PCIPM);
> > + pci_info(dev, "intel-bmg-aspm-quirk: L1.1/L1.2 substates disabled on BMG upstream port\n");
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xe2ff, quirk_intel_bmg_no_l1ss);
> >  #endif
> > 
> >  #ifdef CONFIG_PCIE_DPC
> 
> 
--45621f1d45c0b2532bd65f862dc8ff0c0dae435b
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title></head><body><div>Yes, still a=
 problem, powersupersave kills BM cards, at least on my machines.</div><=
div><br></div><div><br></div><div>On Fri, Sep 18, 2026, at 21:33, Bjorn =
Helgaas wrote:</div><blockquote type=3D"cite" id=3D"qt" style=3D""><div>=
On Thu, May 07, 2026 at 11:14:04PM +0100, Pavel Shirshov wrote:</div><di=
v>&gt; The report and the patch below are completely claude'd but the qu=
irk in the patch works.</div><div>&gt;&nbsp;</div><div>&gt; PCI/ASPM: In=
tel Battlemage (Arc Pro B70) bricks at boot when</div><div>&gt; pcie_asp=
m.policy=3Dpowersupersave enables ASPM_L1.1 on AMD root port link</div><=
div><br></div><div>I happened on this report that we never responded to.=
&nbsp; I assume this</div><div>is still a problem?</div><div><br></div><=
div>It looks like it's not a regression, but should still be fixed.</div=
><div><br></div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</div><div>&gt; SUMMARY</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; On Linux 7.0.3, an I=
ntel Arc Pro B70 (Battlemage / BMG-G31, GPU PCI</div><div>&gt; ID 8086:e=
223) plugged into an AMD Ryzen 9 5950X system fails to wake</div><div>&g=
t; from D3cold during PCI core enumeration when the kernel is booted</di=
v><div>&gt; with pcie_aspm.policy=3Dpowersupersave. The card is permanen=
tly</div><div>&gt; inaccessible until reboot with a different policy.</d=
iv><div>&gt; pcie_aspm.policy=3Dpowersave (L0s+L1, no substates) works c=
orrectly.</div><div>&gt;&nbsp;</div><div>&gt; The failure surfaces in PC=
I core first; downstream xe driver bind</div><div>&gt; then fails with -=
EPROTO:</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; pcie=
port 0000:02:01.0: Unable to change power state from D3cold</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; to D0, device inaccessible</div><div>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp; pcieport 0000:02:02.0: Unable to change power state from =
D3cold</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to D0, device inaccessible</div>=
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; xe 0000:03:00.0: Unable to change powe=
r state from D3cold to D0,</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; device inaccessible</div><div>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp; xe 0000:03:00.0: [drm] Running in SR-IOV VF mode</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [misdetected: d=
ead config space reads as 0xff]</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; x=
e 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset</div><div>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GuC state (-E=
PROTO)</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; xe 0000:03:00.0: probe wit=
h driver xe failed with error -71</div><div>&gt;&nbsp;</div><div>&gt; Af=
ter the brick, "lspci -vvv -s 03:00.0" reports</div><div>&gt; "!!! Unkno=
wn header type 7f" -- the canonical signature of a PCI</div><div>&gt; de=
vice whose config space reads return all-ones, i.e. the link to the</div=
><div>&gt; device is dead.</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;</di=
v><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&=
gt; HARDWARE</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D</div><div>&gt;&nbsp;</div><div>&gt; CPU / root complex:</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp; AMD Ryzen 9 5950X (Starship/Matisse). The roo=
t port hosting the</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; BMG card is 00=
00:00:01.1 -- "Advanced Micro Devices, Inc. [AMD]</div><div>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp; Starship/Matisse GPP Bridge" (subsystem 1022:1453).</di=
v><div>&gt;&nbsp;</div><div>&gt; GPU:</div><div>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp; Intel Arc Pro B70 -- 8086:e223 (BMG-G31, subsystem 8086:1701).</div=
><div>&gt;&nbsp;</div><div>&gt; On-card topology -- the card has a two-l=
ayer on-board PCIe switch:</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 0000:0=
1:00.0&nbsp; Intel 8086:e2ff -- BMG card upstream switch port,</div><div=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PCIe 5.0 x16 capable (currently</div><div>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; downgra=
ded to Gen4 x16).</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 0000:02:01.0&nb=
sp; Intel 8086:e2f0 -- BMG card downstream switch</div><div>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ort, PCIe Gen1 x1 internal.</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 0000:=
03:00.0&nbsp; Intel 8086:e223 -- GPU endpoint, PCIe Gen1 x1</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; internal.</div><div>&gt;&nbsp;</div><div>&gt; Other:</div><div>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp; BIOS has PCIe ASPM enabled in firmware. pci=
e_aspm=3Dforce is NOT</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; set on the =
kernel command line. Motherboard: ASRock X570</div><div>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp; (specifics in attached dmidecode.txt).</div><div>&gt;&nbsp;=
</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div>&gt; REPRODUCER</div><div>&gt; =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; Boot =
any kernel &gt;=3D 7.0 with kernel command line containing:</div><div>&g=
t;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; pcie_aspm.policy=3Dpower=
supersave xe.force_probe=3D*</div><div>&gt;&nbsp;</div><div>&gt; (Also r=
eproduces under earlier 6.x kernels.)</div><div>&gt;&nbsp;</div><div>&gt=
; Reverting the cmdline to "pcie_aspm.policy=3Dpowersave" and rebooting<=
/div><div>&gt; restores the card. No firmware reset is required between =
attempts --</div><div>&gt; the brick is purely a runtime link-state fail=
ure during kernel boot.</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;</div><=
div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt;=
 ASPM NEGOTIATION</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; Captured with "lspci -vvv"=
 on a working policy=3Dpowersave boot</div><div>&gt; (attached: 20260507=
-204348-powersave-7.0.3.tar.zst).</div><div>&gt;&nbsp;</div><div>&gt; Li=
nk 1: 00:01.1 AMD root&nbsp; &lt;-&gt;&nbsp; 01:00.0 BMG upstream</div><=
div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Lower end (AMD root, L1SubCap):</div><d=
iv>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI-PM_L1.2-&nbs=
p; PCI-PM_L1.1+&nbsp; ASPM_L1.2-&nbsp; ASPM_L1.1+</div><div>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp; Upper end (BMG upstream, L1SubCap):</div><div>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI-PM_L1.2+&nbsp; PCI-PM_L1=
.1+&nbsp; ASPM_L1.2+&nbsp; ASPM_L1.1+</div><div>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp; Active L1SubCtl1 under policy=3Dpowersave:</div><div>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI-PM_L1.2-&nbsp; PCI-PM_L1.1-&n=
bsp; ASPM_L1.2-&nbsp; ASPM_L1.1-</div><div>&gt;&nbsp;</div><div>&gt; Lin=
k 2: 01:00.0&nbsp; &lt;-&gt;&nbsp; 02:01.0&nbsp;&nbsp; (card-internal sw=
itch)</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; No L1SS capability advertis=
ed on either end.</div><div>&gt;&nbsp;</div><div>&gt; Link 3: 02:01.0&nb=
sp; &lt;-&gt;&nbsp; 03:00.0&nbsp;&nbsp; (card-internal to GPU)</div><div=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp; No L1SS capability advertised on either en=
d.</div><div>&gt;&nbsp;</div><div>&gt; Conclusion: only Link 1 -- the pl=
atform-facing AMD&lt;-&gt;BMG link -- is</div><div>&gt; L1SS-capable on =
both ends, and the intersection is ASPM_L1.1 only</div><div>&gt; (the AM=
D GPP root port advertises L1.1 but not L1.2). With</div><div>&gt; polic=
y=3Dpowersupersave, the kernel arms ASPM_L1.1 on this link. After</div><=
div>&gt; that, every D3cold-&gt;D0 transition fails.</div><div>&gt;&nbsp=
;</div><div>&gt; Both ends advertise multi-retimer support (Retimer+ 2Re=
timers+ on</div><div>&gt; the AMD root port and on the BMG upstream port=
). Retimers + L1SS</div><div>&gt; have a history of wake-recovery proble=
ms on other platforms; this</div><div>&gt; may be the same class of issu=
e.</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt; TIMELINE -- failed b=
oot, kernel 7.0.3</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; Excerpted from dmesg-relev=
ant.txt in the powersupersave capture:</div><div>&gt;&nbsp;</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp; 28.792s&nbsp; pcieport 0000:00:01.1: PME: Sig=
naling with IRQ 48</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; [AMD root port for BMG]</div><div>&gt;&nbsp;&nbsp;&nbsp;=
&nbsp; 28.842s&nbsp; pcieport 0000:02:01.0: Unable to change power state=
 from</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; D3cold to D0, device inaccessible</div><div>&gt;&nbsp;&nbsp;&nbsp;&nb=
sp; 28.843s&nbsp; pcieport 0000:02:02.0: Unable to change power state fr=
om</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
D3cold to D0, device inaccessible</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
 ...</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 29.034s&nbsp; xe 0000:03:00.=
0: Unable to change power state from</div><div>&gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D3cold to D0, device inaccessible</div=
><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 29.035s&nbsp; xe 0000:03:00.0: [drm] =
Running in SR-IOV VF mode</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 29.035s=
&nbsp; xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed</div><div>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to reset GuC s=
tate (-EPROTO)</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 29.035s&nbsp; xe 0=
000:03:00.0: probe with driver xe failed with</div><div>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error -71</div><div>&gt;&nbsp=
;</div><div>&gt; The PCI core's first wake attempt at 28.842s (the immed=
iate parent</div><div>&gt; bridge of the BMG GPU) fails before any drive=
r probe runs. This</div><div>&gt; confirms the failure is in the PCI/ASP=
M layer, not in xe; xe just</div><div>&gt; sees the resulting dead confi=
g space and misclassifies the PF as a</div><div>&gt; VF.</div><div>&gt;&=
nbsp;</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</div><div>&gt; WORKING-POLICY LSPCI EXCERPTS&nbsp; (r=
elevant capabilities)</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; policy=3Dpowersave base=
line, root port 00:01.1:</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp; LnkCap:&nbsp; Speed 16GT/s, Width x16, ASPM L1, Exit Latenc=
y L1 &lt;64us</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCtl:&nbsp; ASPM =
L1 Enabled</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkSta:&nbsp; Speed 16=
GT/s, Width x16</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [37=
0 v1] L1 PM Substates</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; L1SubCap:&nbsp; PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L=
1.1+</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1_PM_Subs=
tates+</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1=
SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-</div><div>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1SubCtl2:</div><div>&gt=
;&nbsp;</div><div>&gt; policy=3Dpowersave baseline, BMG upstream 01:00.0=
:</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCap:&nb=
sp; Speed 32GT/s, Width x16, ASPM L1, Exit Latency L1 &lt;32us</div><div=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCtl:&nbsp; ASPM L1 Enabled</div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp; LnkSta:&nbsp; Speed 16GT/s (downgraded), Widt=
h x16</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [244 v1] L1 P=
M Substates</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; L1SubCap:&nbsp; PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+</div>=
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1_PM_Substates+</di=
v><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1SubCtl1: P=
CI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-</div><div>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1SubCtl2: T_PwrOn=3D14us</div><di=
v>&gt;&nbsp;</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt; PROPOSED FIX</div><div>&gt; =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt;&nbsp;</div><di=
v>&gt; Disable both L1SS substates on the BMG card's upstream switch por=
t</div><div>&gt; (8086:e2ff) via a DECLARE_PCI_FIXUP_FINAL. Standard ASP=
M L1 still</div><div>&gt; applies, so the link still benefits from the d=
eepest substate the</div><div>&gt; BMG silicon handles correctly. The qu=
irk keys on the card upstream</div><div>&gt; port, which is shared acros=
s the BMG product family, so it covers</div><div>&gt; all current BMG SK=
Us without enumerating individual GPU-endpoint</div><div>&gt; IDs.</div>=
<div>&gt;&nbsp;</div><div>&gt; The patch is in the attached&nbsp;<a href=
=3D"http://intel-bmg-disable-l1ss.patch">intel-bmg-disable-l1ss.patch</a=
>. With the</div><div>&gt; patch applied, pcie_aspm.policy=3Dpowersupers=
ave boots cleanly on this</div><div>&gt; hardware (verification in progr=
ess at time of report).</div><div>&gt;&nbsp;</div><div>&gt; Empirical na=
rrowing -- ASPM_L1.1 specifically is the trigger.</div><div>&gt;&nbsp;</=
div><div>&gt;&nbsp;&nbsp; An intermediate version of the quirk passed on=
ly</div><div>&gt;&nbsp;&nbsp; PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_=
2 to</div><div>&gt;&nbsp;&nbsp; pci_disable_link_state(), leaving the PC=
I-PM substate bits armed.</div><div>&gt;&nbsp;&nbsp; After applying that=
 variant, lspci reported</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2-=
 ASPM_L1.1-</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp; on the BMG u=
pstream port -- i.e. only the two ASPM substate bits</div><div>&gt;&nbsp=
;&nbsp; were cleared, the PCI-PM substate bits stayed armed -- yet the</=
div><div>&gt;&nbsp;&nbsp; system booted, xe bound, and the GPU operated =
normally. Combined</div><div>&gt;&nbsp;&nbsp; with the AMD root port adv=
ertising only ASPM_L1.1+ (not L1.2),</div><div>&gt;&nbsp;&nbsp; this iso=
lates ASPM_L1.1 as the specific bit whose activation</div><div>&gt;&nbsp=
;&nbsp; bricks the BMG card. The PCI-PM L1.x substates were also disable=
d</div><div>&gt;&nbsp;&nbsp; in the final patch for hygiene, but they ar=
e not load-bearing for</div><div>&gt;&nbsp;&nbsp; the fix on this hardwa=
re (the GPU does not enter D3hot during</div><div>&gt;&nbsp;&nbsp; norma=
l operation, so PCI-PM substates are inert).</div><div>&gt;&nbsp;</div><=
div>&gt; Remaining open questions for review:</div><div>&gt;&nbsp;</div>=
<div>&gt;&nbsp;&nbsp; 1. Is the underlying defect in the AMD Starship ro=
ot port (cannot</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake the li=
nk from ASPM_L1.1) or in the BMG e2ff upstream port</div><div>&gt;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (cannot exit ASPM_L1.1 cleanly)? If the former,=
 future BMG</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cards on Intel =
platforms may not need this quirk; if the</div><div>&gt;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; latter, the quirk is correct for BMG everywhere. We do no=
t</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; have a non-AMD reproducer=
 to disambiguate.</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp; 2. Sho=
uld the quirk also apply to the AMD Starship/Matisse GPP</div><div>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bridge itself (1022:1483 / 1022:1484-class=
 IDs, see</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lspci-nn.txt)? Th=
at would be a broader brushstroke but might</div><div>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; protect other devices presenting the same negotiation.<=
/div><div>&gt;&nbsp;</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt; WORKAROUND IN USE</div>=
<div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt;=
&nbsp;</div><div>&gt; Until the quirk lands upstream, downstream users o=
n this hardware</div><div>&gt; must boot with pcie_aspm.policy=3Dpowersa=
ve (or default), losing</div><div>&gt; ~25 W of idle savings that the de=
eper substates would otherwise</div><div>&gt; provide.</div><div>&gt;&nb=
sp;</div><div>&gt;&nbsp;</div><div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div><div>&gt; ATTACHMENTS</div><div>&gt; =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>&gt;&nbsp;</div><div>&gt; Ta=
rballs produced by debug/20260507-aspm-capture.sh:</div><div>&gt;&nbsp;<=
/div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 20260507-204348-powersave-7.0.3.t=
ar.zst</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --=
 working baseline</div><div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp; 20260507-205055-powersupersave-7.0.3.tar.zst</div><div>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- failed reproduction</div><d=
iv>&gt;&nbsp;</div><div>&gt; Each tarball contains:</div><div>&gt;&nbsp;=
</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; manifest.txt&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel, policy, hostname, GPU B=
DFs</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; cmdline.txt&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel command line</di=
v><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; uname.txt&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel version</div>=
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; nixos.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userspace metadata</di=
v><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; dmidecode.txt&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIOS/board info</div><div>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp; lspci-tree.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; PCI topology</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; lspci-nn.txt&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI device li=
st</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; lspci-vvv-all.txt&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; full system lspci -vvv</div><div>&gt;&nbsp;</div><div>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp; gpu-03_00_0/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; per-device captures for the GPU and</div><=
div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; every PCI ancestor up to the root</div><div>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; complex:</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lspci-vvv.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; GPU</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; parent-0-02_01_0.txt&nbsp;&nbsp; BMG card-internal downstre=
am switch</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 parent-1-01_00_0.txt&nbsp;&nbsp; BMG card upstream port (e2ff)</div><di=
v>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parent-2-00_01_1.=
txt&nbsp;&nbsp; AMD root port</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; sysfs.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selected sysfs attributes</div><div=
>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; dmesg-full.txt&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; full kernel ring buffer</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbs=
p; dmesg-relevant.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; filtered for PCI/xe/ASPM/L1</div><div>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp; journal-kernel-current-boot.txt</div><div>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp; journal-kernel-prev-boot.txt</div><div>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp; drivers.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xe / i915 driver s=
tate,</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /sys/class/drm</div><div>&gt;&nbsp;</div><div>&gt; Patch:&nbsp;=
<a href=3D"http://intel-bmg-disable-l1ss.patch">intel-bmg-disable-l1ss.p=
atch</a>&nbsp; (attached separately)</div><div>&gt;&nbsp;</div><div>&gt;=
 NixOS 26.05 (nixpkgsRevision:</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 54=
9bd84d6279f9852cae6225e372cc67fb91a4c1)</div><div>&gt;&nbsp;</div><div>&=
gt; Kernel:</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 7.0.3 #1-NixOS SMP PR=
EEMPT_DYNAMIC Thu Apr 30 09:13:05 UTC 2026</div><div><br></div><div><br>=
</div><div><br></div><div>&gt; PCI/ASPM: disable L1.1/L1.2 substates for=
 Intel Battlemage discrete GPU upstream port</div><div>&gt;&nbsp;</div><=
div>&gt; Intel Battlemage (BMG-G21 / BMG-G31, e.g. Arc Pro B70) discrete=
 GPU cards</div><div>&gt; expose a two-layer on-card PCIe switch:</div><=
div>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; AMD/Intel root por=
t&nbsp; &lt;-&gt;&nbsp; 8086:e2ff (BMG card upstream)</div><div>&gt;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8086:e2f0 (BMG card downstream)</div><d=
iv>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8086:e22x (BMG GPU endpoint,=
 e.g. e223 =3D Arc Pro B70)</div><div>&gt;&nbsp;</div><div>&gt; The plat=
form-facing link (root port &lt;-&gt; 8086:e2ff) is the only link in the=
</div><div>&gt; chain that advertises L1 PM Substates support on both en=
ds. On AMD</div><div>&gt; Starship/Matisse (Ryzen 5xxx) root ports, the =
intersection is ASPM_L1.1</div><div>&gt; only (the AMD port advertises L=
1.1 but not L1.2). When pcie_aspm.policy=3D</div><div>&gt; powersupersav=
e arms ASPM_L1.1 on this link, the BMG card cannot recover</div><div>&gt=
; from the resulting low-power state on subsequent D3cold-&gt;D0 transit=
ion,</div><div>&gt; leaving the device permanently inaccessible:</div><d=
iv>&gt;&nbsp;</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; pcieport 0000:02:01=
.0: Unable to change power state from D3cold to D0, device inaccessible<=
/div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; xe 0000:03:00.0: Unable to change=
 power state from D3cold to D0, device inaccessible</div><div>&gt;&nbsp;=
&nbsp;&nbsp;&nbsp; xe 0000:03:00.0: [drm] Running in SR-IOV VF mode&nbsp=
;&nbsp;&nbsp; [misdetected: dead config space]</div><div>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp; xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to r=
eset GuC state (-EPROTO)</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; xe 0000:=
03:00.0: probe with driver xe failed with error -71</div><div>&gt;&nbsp;=
</div><div>&gt; Reproduces deterministically on Linux 7.0.3 with an Arc =
Pro B70 in an</div><div>&gt; AMD Ryzen 9 5950X system. pcie_aspm.policy=3D=
powersave (L0s+L1 only, no</div><div>&gt; substates) works correctly; pc=
ie_aspm.policy=3Dpowersupersave bricks the</div><div>&gt; card on every =
boot. The 6.x-era blanket `no_d3cold` quirk for Battlemage</div><div>&gt=
; was narrowed to ASUS NUC13 only in 7.0, but that change is orthogonal:=
</div><div>&gt; the failure here is link-state, not device-state, and su=
rfaces</div><div>&gt; regardless of d3cold_allowed.</div><div>&gt;&nbsp;=
</div><div>&gt; Disable all four L1SS substates (ASPM_L1.1, ASPM_L1.2, P=
CI-PM_L1.1,</div><div>&gt; PCI-PM_L1.2) on the BMG card's upstream port =
via a final PCI fixup.</div><div>&gt; Standard ASPM L1 still applies, so=
 the link still benefits from the</div><div>&gt; deepest substate the BM=
G silicon actually handles correctly. The</div><div>&gt; quirk is keyed =
on the upstream-port device ID 0xe2ff so it covers</div><div>&gt; all cu=
rrent Battlemage SKUs (the GPU-endpoint ID varies by SKU, but</div><div>=
&gt; the upstream switch is shared).</div><div>&gt;&nbsp;</div><div>&gt;=
 Empirical narrowing (verified post-fix): with a partial mask that</div>=
<div>&gt; disabled only ASPM_L1.{1,2} but left PCI-PM_L1.{1,2} armed, th=
e</div><div>&gt; system boots and operates correctly. This isolates ASPM=
_L1.1 as the</div><div>&gt; specific trigger of the brick (the AMD root =
port advertises ASPM_L1.1</div><div>&gt; but not ASPM_L1.2, so ASPM_L1.2=
 cannot have been activated). The</div><div>&gt; PCI-PM substates only a=
ctivate during D3hot transitions which the</div><div>&gt; GPU does not u=
ndergo during normal use; they are disabled here for</div><div>&gt; hygi=
ene rather than necessity.</div><div>&gt;&nbsp;</div><div>&gt; Reported-=
by: Pavel Shirshov &lt;<a href=3D"mailto:pavel@7mind.io">pavel@7mind.io<=
/a>&gt;</div><div>&gt; Signed-off-by: &lt;FILL IN BEFORE SUBMITTING UPST=
REAM&gt;</div><div>&gt;&nbsp;</div><div>&gt; --- a/drivers/pci/quirks.c<=
/div><div>&gt; +++ b/drivers/pci/quirks.c</div><div>&gt; @@ -6289,6 +628=
9,34 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_ac=
ceptable_latency</div><div>&gt;&nbsp; DECLARE_PCI_FIXUP_HEADER(PCI_VENDO=
R_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);</div><div>&gt;&nbsp; DE=
CLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_l=
atency);</div><div>&gt;&nbsp; DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INT=
EL, 0x56c1, aspm_l1_acceptable_latency);</div><div>&gt; +</div><div>&gt;=
 +/*</div><div>&gt; + * Intel Battlemage discrete GPU cards (BMG-G21 / B=
MG-G31; Arc B580,</div><div>&gt; + * Arc Pro B50/B60/B70) expose a two-l=
ayer on-card PCIe switch. The</div><div>&gt; + * platform-facing link, b=
etween the host root port and the card's</div><div>&gt; + * upstream swi=
tch port (PCI device ID 0xe2ff), is the only link in the</div><div>&gt; =
+ * chain advertising L1 PM Substates on both ends. On at least AMD</div=
><div>&gt; + * Starship/Matisse root ports, where the intersection is AS=
PM_L1.1</div><div>&gt; + * only, arming L1.1 leaves the BMG card unable =
to wake from D3cold:</div><div>&gt; + *</div><div>&gt; + *&nbsp;&nbsp; p=
cieport 0000:02:01.0: Unable to change power state from D3cold</div><div=
>&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; to D0, device inaccessible</div><div>&gt; + *&nbsp;&nbsp=
; xe 0000:03:00.0: probe with driver xe failed with error -71</div><div>=
&gt; + *</div><div>&gt; + * Reproduces deterministically with pcie_aspm.=
policy=3Dpowersupersave,</div><div>&gt; + * works correctly with policy=3D=
powersave (no substates). Disable L1SS</div><div>&gt; + * substates on t=
he BMG card upstream port; standard L1 ASPM is</div><div>&gt; + * unaffe=
cted.</div><div>&gt; + */</div><div>&gt; +static void quirk_intel_bmg_no=
_l1ss(struct pci_dev *dev)</div><div>&gt; +{</div><div>&gt; +	pci_disabl=
e_link_state(dev, PCIE_LINK_STATE_L1_2 |</div><div>&gt; +				&nbsp;&nbsp=
;&nbsp; PCIE_LINK_STATE_L1_1 |</div><div>&gt; +				&nbsp;&nbsp;&nbsp; PC=
IE_LINK_STATE_L1_2_PCIPM |</div><div>&gt; +				&nbsp;&nbsp;&nbsp; PCIE_L=
INK_STATE_L1_1_PCIPM);</div><div>&gt; +	pci_info(dev, "intel-bmg-aspm-qu=
irk: L1.1/L1.2 substates disabled on BMG upstream port\n");</div><div>&g=
t; +}</div><div>&gt; +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xe2f=
f, quirk_intel_bmg_no_l1ss);</div><div>&gt;&nbsp; #endif</div><div>&gt;&=
nbsp;</div><div>&gt;&nbsp; #ifdef CONFIG_PCIE_DPC</div><div><br></div><d=
iv><br></div></blockquote></body></html>
--45621f1d45c0b2532bd65f862dc8ff0c0dae435b--
