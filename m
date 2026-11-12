Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIWzG14g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEEF112372;
	Thu, 12 Nov 2026 23:21:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5426112372
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:20:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 74C3644801;
 Thu, 12 Nov 2026 23:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE131F000C4;
 Thu, 12 Nov 2026 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525657;
 bh=aSh8cUhPu2eJjwVUvjrVp5lI+mTwzGKKWhb4U4T+Nas=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JIWzG14g0eX40BQan7ecvJAJAJTQwmEeZDxPdPjY4g/HdtiEDrmGiUahf0ijso2fm
 E0HYoWo0rpFGgXVTixDvPkQuwK90rQzCAXiQ7WpC/6DnB60OR2qEzKFV7y1zs08WvP
 XO2TTm8yhGjbnJUcUtYs7llQvUq+mSIf7xertfXLXBFzCsdaAGePn84FqYW1/q0gkN
 Im+pLV7whBv/oiwGbF7s5vXbQFZG5LZypEWXchu8naKTOfx0FKc4qwcOUZEKpZCbX0
 BVwfBf0TnBg9V2HFAehxrU4xDwKIiY5PiCbAeMvedvhD51fnqjz5dKfeyYzQpYpHgU
 g1MYvaFzVOVew==
Message-ID: <sashiko-outbox-211949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/13] drm/powervr_sgx: Load and start the microkernel
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-6-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-6-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:20:56 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] drm/powervr_sgx: unlocked CCB offset access and u64 underflow
  in pvrsgx_ccb_consumed()
- [High] drm/powervr_sgx: race between ccb_lock and inval_lock in
  pvrsgx_ccb_after_invalidate()
- [High] drm/powervr_sgx: sdev->powered set while clocks are gated in
  pvrsgx_fw_start()
- [Medium] drm/powervr_sgx: unlocked sdev->fw.cache_control update in
  pvrsgx_fw_start()
- [Medium] drm/powervr_sgx: stale fw_running state across
  pvrsgx_fw_halt() and restarts
- [Medium] drm/powervr_sgx: missing deinit_script() on failed-start path
  in pvrsgx_fw_stop()
- [Medium] drm/powervr_sgx: premature timeout calculation in
  ccb_split_inval()
- [Medium] drm/powervr_sgx: missing flush of sdev->irq_work in
  pvrsgx_fw_stop()
- [Medium] drm/powervr_sgx: PAGE_SIZE used instead of SGX_MMU_PAGE_SIZE
  for pdtable
- [Medium] drm/powervr_sgx: map f->pdtable with
  SGX_MMU_PTE_CACHECONSISTENT
--

commit bc7aa5d8fb93051c08d3332346834aa8dbfc0eb6
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Load and start the microkernel

This commit adds support for loading, validating, patching, and starting
the SGX microkernel, along with PDS entry program assembly and the kernel
CCB command ring.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c b/drivers/gpu/drm/p=
owervr_sgx/pvrsgx_ccb.c
> new file mode 100644
> index 0000000000000..351a7f930a08d
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c

[ ... ]

> +void pvrsgx_ccb_reset(struct pvrsgx_device *sdev)
> +{
> +	memset(sdev->fw.cpu[PVRSGX_FW_CCB], 0, PVRSGX_CCB_SLOTS * PVRSGX_CCB_CM=
D_WORDS * 4);
> +	ccbctl(sdev)[CCB_WO] =3D 0;
> +	ccbctl(sdev)[CCB_RO] =3D 0;
> +	*(u32 *)sdev->fw.cpu[PVRSGX_FW_KICKER] =3D 0;
> +	/*
> +	 * @ccb_issued carries on: a job sent after a restart has a higher sequ=
ence
> +	 * than any count read before it, so a stale count can't complete it.
> +	 */
> +}
> +
> +/* Commands the microkernel has taken off the ring since the driver load=
ed. */
> +u64 pvrsgx_ccb_consumed(struct pvrsgx_device *sdev)
> +{
> +	u32 ro =3D READ_ONCE(ccbctl(sdev)[CCB_RO]);
> +	unsigned long flags;
> +	u64 consumed;
> +
> +	/* The read offset is GPU-written: trust it only as an index. */
> +	spin_lock_irqsave(&sdev->ccb_spin, flags);
> +	consumed =3D sdev->ccb_issued - ((ccbctl(sdev)[CCB_WO] - ro) & (PVRSGX_=
CCB_SLOTS - 1));
> +	spin_unlock_irqrestore(&sdev->ccb_spin, flags);
> +	return consumed;
> +}

[Severity: High]
Can pvrsgx_ccb_consumed() underflow consumed to near U64_MAX?

ro is read outside sdev->ccb_spin, while pvrsgx_ccb_reset() and the arena
memset() in pvrsgx_fw_start() zero CCB_WO and CCB_RO without holding
sdev->ccb_spin (and pvrsgx_fw_start() queues sdev->reap_work before
pvrsgx_ccb_reset() runs):

CPU0 (pvrsgx_fw_start)            CPU1 (reap_work)
                                  pvrsgx_ccb_consumed()
                                    ro =3D READ_ONCE(ccbctl[CCB_RO]) (1)
pvrsgx_ccb_reset()
  ccbctl[CCB_WO] =3D 0
  ccbctl[CCB_RO] =3D 0
                                    spin_lock_irqsave(&sdev->ccb_spin)
                                    delta =3D (0 - 1) & 255          (255)
                                    consumed =3D ccb_issued - 255
                                      <-- u64 underflow if ccb_issued < 255

An out-of-sync GPU-written CCB_RO while sdev->ccb_issued < 255 hits the
same subtraction underflow.  Once consumed wraps to near U64_MAX,
pvrsgx_ccb_inval_reap() and pvrsgx_kobj_reap() treat all pending and
future CCB sequence numbers as consumed, freeing unmapped pages and kernel
objects before the microkernel has taken the BIF TLB invalidate.

[ ... ]

> +static int ccb_split_inval(struct pvrsgx_device *sdev, u32 *cache_contro=
l)
> +{
> +	static const u32 none[6];
> +	unsigned long timeout =3D jiffies + msecs_to_jiffies(500);
> +	u64 seq;
> +	int err;
> +
> +	if (!(sdev->family->quirks & PVRSGX_QUIRK_BRN_28889) ||
> +	    !(*cache_control & PVRSGX_CC_INVAL_DATA) ||
> +	    !(*cache_control & ~PVRSGX_CC_INVAL_DATA))
> +		return 0;
> +	err =3D ccb_write(sdev, PVRSGX_KCMD_PROCESS_QUEUES, *cache_control & ~P=
VRSGX_CC_INVAL_DATA,
> +			none, &seq);
> +	if (err)
> +		return err;
> +	while (pvrsgx_ccb_consumed(sdev) < seq) {
> +		if (time_after(jiffies, timeout)) {
> +			drm_err(&sdev->base, "BIF invalidate not taken (BRN_28889)\n");
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(100, 200);
> +	}
> +	*cache_control =3D PVRSGX_CC_INVAL_DATA;
> +	return 0;
> +}

[Severity: Medium]
Can ccb_split_inval() return a false -ETIMEDOUT before waiting for the
microkernel?

timeout is computed before ccb_write(), which has its own 500 ms wait
loop, and the loop checks time_after(jiffies, timeout) before sleeping or
re-checking pvrsgx_ccb_consumed(sdev) < seq.  If ccb_write() had to wait
or the task was preempted, ccb_split_inval() fails on the first iteration
after already queuing PVRSGX_KCMD_PROCESS_QUEUES.  ccb_write() has the
same missing re-check of ctl[CCB_RO] after time_after() when preempted.

[ ... ]

> +void pvrsgx_ccb_after_invalidate(struct pvrsgx_device *sdev, struct pvrs=
gx_inval_wait *w,
> +				 u32 cache_control)
> +{
> +	unsigned long flags;
> +
> +	if (READ_ONCE(sdev->lost)) {
> +		w->done(w);
> +		return;
> +	}
> +	mutex_lock(&sdev->ccb_lock);
> +	sdev->fw.cache_control |=3D cache_control;
> +	w->seq =3D sdev->ccb_issued + 1;
> +	mutex_unlock(&sdev->ccb_lock);
> +	spin_lock_irqsave(&sdev->inval_lock, flags);
> +	list_add_tail(&w->node, &sdev->inval_waits);
> +	spin_unlock_irqrestore(&sdev->inval_lock, flags);
> +}

[Severity: High]
Can w be stranded on sdev->inval_waits if the invalidate command is sent
and reaped between mutex_unlock(&sdev->ccb_lock) and
spin_lock_irqsave(&sdev->inval_lock, flags)?

CPU0                              CPU1
pvrsgx_ccb_after_invalidate()
  mutex_lock(&sdev->ccb_lock)
  w->seq =3D sdev->ccb_issued + 1
  mutex_unlock(&sdev->ccb_lock)
                                  pvrsgx_ccb_send()
                                    /* issues command w->seq */
                                  /* GPU consumes w->seq */
                                  pvrsgx_ccb_inval_reap()
                                    spin_lock_irqsave(&sdev->inval_lock)
                                    /* sdev->inval_waits is empty */
                                    spin_unlock_irqrestore(&sdev->inval_loc=
k)
  spin_lock_irqsave(&sdev->inval_lock)
  list_add_tail(&w->node, &sdev->inval_waits)
    <-- missed reap

The same window against sdev->lost =3D true and pvrsgx_ccb_inval_reap(sdev,
true) queues w->node after the final drain has finished, leaking the
waiting VM, GEM objects, and drm_device reference.  Acquiring
sdev->inval_lock (and re-checking sdev->lost) before releasing
sdev->ccb_lock would close both races.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c b/drivers/gpu/drm/po=
wervr_sgx/pvrsgx_fw.c
> new file mode 100644
> index 0000000000000..b3c0d18912190
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c

[ ... ]

> +#define PDTABLE_OFFSET	0xf000
> +#define PDTABLE_SLOTS	(PAGE_SIZE / sizeof(u32))
> +
> +/* The PD table sits past the code arena, inside the kernel code heap's =
first 64 KiB. */
> +static_assert(PDTABLE_OFFSET >=3D CODE_ARENA_SIZE);
> +static_assert(SZ_64K - PAGE_SIZE >=3D PDTABLE_OFFSET);
> +
> +static int pdtable_init(struct pvrsgx_device *sdev)
> +{
> +	struct pvrsgx_fw *f =3D &sdev->fw;
> +	int err;
> +
> +	if (!pvrsgx_core_single_context(sdev->family))
> +		return 0;
> +	err =3D pvrsgx_kmem_alloc(sdev, &f->pdtable,
> +				pvrsgx_heaps(sdev)->kernel_code.base + PDTABLE_OFFSET, PAGE_SIZE,
> +				SGX_MMU_PTE_READONLY, 0);
> +	if (err)
> +		return err;
> +	memset32(f->pdtable.cpu, pvrsgx_mmu_pd_addr(sdev->kernel_mmu), PDTABLE_=
SLOTS);
> +	return 0;
> +}
> +
> +/* A slot naming directory pd, for a new VM; its HW contexts carry the s=
lot. */
> +int pvrsgx_fw_pd_slot_get(struct pvrsgx_device *sdev, u32 pd)
> +{
> +	int slot =3D ida_alloc_range(&sdev->fw.pd_slots, 1, PDTABLE_SLOTS - 1, =
GFP_KERNEL);
> +
> +	if (slot < 0)
> +		return slot;
> +	WRITE_ONCE(((u32 *)sdev->fw.pdtable.cpu)[slot], pd);
> +	/* In memory before any command names the slot. */
> +	wmb();
> +	return slot;
> +}

[Severity: Medium]
Should PDTABLE_SLOTS and pdtable_init() use SGX_MMU_PAGE_SIZE instead of
PAGE_SIZE?  On architectures with 16 KiB or 64 KiB pages (reachable via
CONFIG_COMPILE_TEST), static_assert(SZ_64K - PAGE_SIZE >=3D PDTABLE_OFFSET)
fails to build because PDTABLE_OFFSET is 0xf000.

[Severity: Medium]
Also in pdtable_init(), does f->pdtable need SGX_MMU_PTE_CACHECONSISTENT?
pvrsgx_fw_pd_slot_get() and pvrsgx_fw_pd_slot_put() update slots in
f->pdtable while the microkernel is running without queuing
PVRSGX_CC_INVAL_DATA, so without SGX_MMU_PTE_CACHECONSISTENT the GPU can
read a stale cached directory address from the same cacheline and fault.

[ ... ]

> +int pvrsgx_fw_start(struct pvrsgx_device *sdev)
> +{
> +	const struct pvrsgx_core_regs *cr =3D sdev->cr;
> +	u32 *hc =3D fw_words(sdev, PVRSGX_FW_HOSTCTL);
> +	bool first =3D !sdev->fw_started, was_powered =3D READ_ONCE(sdev->power=
ed);
> +	int err;
> +
> +	WRITE_ONCE(sdev->powered, true);
> +
> +	/*
> +	 * A restart starts from a fresh image and empty arenas: the microkernel
> +	 * changes both as it runs, and a module reload (which recovers) is
> +	 * exactly this.
> +	 */
> +	if (!first) {
> +		sdev->fw_gen++;
> +		/*
> +		 * After a hang the clocks are on and the cores may be busy. After a
> +		 * clean stop (runtime suspend) they are gated and quiet already, and
> +		 * a register read there can hang the SoC.
> +		 */
> +		if (was_powered) {
> +			/* What an unload and reload (which recovers) does in between. */
> +			deinit_script(sdev);
> +			sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_c=
ores);
> +			sgx_rd(sdev, SGX_CR_SOFT_RESET);
> +			/* Behind gma500 bus mastering is the display's too: leave it. */
> +			if (sdev->pdev)
> +				pci_clear_master(sdev->pdev);
> +			fsleep(10000);
> +			if (sdev->pdev)
> +				pci_set_master(sdev->pdev);
> +		}
> +		memset(sdev->fw.data.cpu, 0, sdev->fw.data.size);
> +		memset(sdev->fw.code.cpu, 0, sdev->fw.code.size);
> +		err =3D fw_build(sdev, sdev->fw.image);
> +		if (err)
> +			return err;
> +		/*
> +		 * Nothing the old run pointed at matters any more. Freeing can take
> +		 * locks a fence waiter holds, so the reap work does it, not a reset.
> +		 */
> +		WRITE_ONCE(sdev->restarts, sdev->restarts + 1);
> +		queue_work(sdev->free_wq, &sdev->reap_work);
> +	}
> +	memset(hc, 0, layout[PVRSGX_FW_HOSTCTL].size);
> +	hc[HOSTCTL_UK_TIMER_CLOCK] =3D sdev->core->clock_hz / UKERNEL_TIMER_HZ;
> +	hc[HOSTCTL_FLAGS] =3D HOSTCTL_HOST_BGBLOCK;
> +	/* The power status starts clear at every start. */
> +	hc[HOSTCTL_POWER_STATUS] =3D 0;
> +	pvrsgx_ccb_reset(sdev);
> +	ta3dctl_fill(sdev);
> +	/* The first command invalidates the directory cache, keeping what a re=
ap queued. */
> +	sdev->fw.cache_control |=3D PVRSGX_CC_INVAL_BIF_PD;
> +
> +	/* Every unit's clock gated automatically, but the DPM's: it stays on. =
*/
> +	sgx_wr(sdev, SGX_CR_CLKGATECTL,
> +	       (SGX_CLKG_ALL(cr->clkgatectl_units, SGX_CLKG_AUTO) & ~cr->clkgat=
ectl_dpm) |
> +	       field_prep(cr->clkgatectl_dpm, SGX_CLKG_ON));

[Severity: High]
Does setting sdev->powered =3D true at the start of pvrsgx_fw_start() allow
pvrsgx_irq() to read SGX registers while the clocks are gated?

sdev->irq is shared, and pvrsgx_irq() checks only READ_ONCE(sdev->powered)
before reading SGX_CR_EVENT_STATUS:

drivers/gpu/drm/powervr_sgx/pvrsgx_device.c:pvrsgx_irq() {
	if (!READ_ONCE(sdev->powered))
		return IRQ_NONE;
	status =3D sgx_rd(sdev, SGX_CR_EVENT_STATUS) & sgx_rd(sdev, SGX_CR_EVENT_H=
OST_ENABLE);
    ...
}

On resume from pvrsgx_fw_stop(), the clocks are gated until
SGX_CR_CLKGATECTL is written below, and on hang recovery (was_powered =3D=3D
true), deinit_script() gates the clocks before sleeping 10 ms in
fsleep(10000) and zeroing the arenas.

CPU0 (pvrsgx_fw_start)            CPU1 (<hardirq> on shared IRQ)
WRITE_ONCE(sdev->powered, true)
deinit_script()
  sgx_wr(SGX_CR_CLKGATECTL, 0)
fsleep(10000)
                                  pvrsgx_irq()
                                    if (!READ_ONCE(sdev->powered))
                                    sgx_rd(SGX_CR_EVENT_STATUS)
                                      <-- reads unclocked SGX, bus hang

Also, if fw_build() fails on a restart when was_powered was false,
pvrsgx_fw_start() returns with sdev->powered left true while the hardware
is unclocked.

[Severity: Medium]
Just above SGX_CR_CLKGATECTL, can sdev->fw.cache_control |=3D
PVRSGX_CC_INVAL_BIF_PD race with sdev->reap_work?

queue_work(sdev->free_wq, &sdev->reap_work) is called a few lines earlier,
and pvrsgx_kobj_reap() updates sdev->fw.cache_control under
sdev->ccb_lock.  Updating sdev->fw.cache_control here without
sdev->ccb_lock can clobber the flags set by reap_work (or by concurrent VM
unmaps) and drop a required BIF TLB invalidate.

[ ... ]

> +void pvrsgx_fw_halt(struct pvrsgx_device *sdev)
> +{
> +	const struct pvrsgx_core_regs *cr =3D sdev->cr;
> +
> +	sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_cor=
es);
> +	sgx_rd(sdev, SGX_CR_SOFT_RESET);
> +	if (sdev->pdev)
> +		pci_clear_master(sdev->pdev);
> +}
> +
> +/* Ask the microkernel to power off, then hold the cores in reset. */
> +void pvrsgx_fw_stop(struct pvrsgx_device *sdev)
> +{
> +	const struct pvrsgx_core_regs *cr =3D sdev->cr;
> +	u32 *hc =3D fw_words(sdev, PVRSGX_FW_HOSTCTL);
> +	u32 data[6] =3D { 0, POWER_OFF };
> +
> +	if (sdev->fw_running) {
> +		if (pvrsgx_ccb_send(sdev, PVRSGX_KCMD_POWER, data, NULL) ||
> +		    pvrsgx_poll(sdev, &hc[HOSTCTL_POWER_STATUS], HOSTCTL_POWMAN_POWERO=
FF_COMPLETE,
> +				HOSTCTL_POWMAN_POWEROFF_COMPLETE, 500000))
> +			drm_warn(&sdev->base, "microkernel did not power off\n");
> +		/* Wait for the clocks to gate; the DPM's stays on. */
> +		for (int i =3D 0; i < 500; i++) {
> +			if (!(sgx_rd(sdev, cr->clkgatestatus) & ~cr->clkgatestatus_dpm))
> +				break;
> +			usleep_range(100, 200);
> +		}
> +		WRITE_ONCE(sdev->powered, false);
> +		synchronize_irq(sdev->irq);
> +		deinit_script(sdev);
> +		sdev->fw_running =3D false;
> +		sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_co=
res);
> +		sgx_rd(sdev, SGX_CR_SOFT_RESET);
> +	} else if (READ_ONCE(sdev->powered)) {
> +		/* A failed start: the clocks are on, the microkernel isn't. */
> +		WRITE_ONCE(sdev->powered, false);
> +		synchronize_irq(sdev->irq);
> +		sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_co=
res);
> +		sgx_rd(sdev, SGX_CR_SOFT_RESET);
> +	}
> +}

[Severity: Medium]
Should pvrsgx_fw_halt() and the restart path of pvrsgx_fw_start() clear
sdev->fw_running?

Neither sets sdev->fw_running =3D false when holding the GPU in reset or
rebuilding the arenas.  If pvrsgx_fw_halt() is called (or a restart in
pvrsgx_fw_start() fails) and pvrsgx_fw_stop() runs afterwards,
pvrsgx_fw_stop() sees sdev->fw_running =3D=3D true and sends PVRSGX_KCMD_PO=
WER
with a 500 ms poll to a halted microkernel, while interrupt handlers can
observe sdev->fw_running =3D=3D true while control blocks are zeroed.

[Severity: Medium]
In pvrsgx_fw_stop(), does synchronize_irq(sdev->irq) wait for the
interrupt bottom half when running behind gma500?

When sdev->gma_sgx is used, pvrsgx_gma_irq() schedules sdev->irq_work on
system_highpri_wq rather than waking a threaded IRQ handler on sdev->irq:

drivers/gpu/drm/powervr_sgx/pvrsgx_device.c:pvrsgx_gma_irq() {
    ...
	if (ret =3D=3D IRQ_WAKE_THREAD) {
		queue_work(system_highpri_wq, &sdev->irq_work);
		return IRQ_HANDLED;
	}
    ...
}

Without flushing or canceling sdev->irq_work after synchronize_irq(),
pvrsgx_irq_thread() can run concurrently with deinit_script(),
sdev->fw_running =3D false, soft reset, and arena zeroing on the next start.

[Severity: Medium]
Finally, in the else if (READ_ONCE(sdev->powered)) branch of
pvrsgx_fw_stop(), should deinit_script(sdev) be called before asserting
soft reset?

When pvrsgx_fw_start() fails in check_event_pds() or times out polling
HOSTCTL_INIT_STATUS, SGX_CR_CLKGATECTL (including the forced-on DPM
clock), SGX_CR_EVENT_HOST_ENABLE, use_code_base(15), and event_pds_* have
already been programmed.  Skipping deinit_script(sdev) leaves those
registers and clocks enabled while marking sdev->powered false, so a later
pvrsgx_fw_start() also sees was_powered =3D=3D false and skips
deinit_script().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D6
