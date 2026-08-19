Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A835C5DF88
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07EB10E17A;
	Wed, 19 Aug 2026 19:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oYnG2/Qr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83C110E17A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:06:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70DC443590;
 Wed, 19 Aug 2026 19:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407EF1F000E9;
 Wed, 19 Aug 2026 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787166392;
 bh=lq/xuKIMeT9euVXxs8faoNp57/zU4hJ6wQq920lhtOA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oYnG2/Qr04JhBBqf2hmdlsm2Lk/fEgO6H7+590Bm0vj7d7VPH8/F76IeT88udErsC
 1BVcj2jLrDu4VMdLPBCDIbbAwbJvHdAL/sDvdo6MJ6rE7Xq42MTRQ1hohqzFLSrAIe
 XgTQ98RiEtD9YbR4WaGIKHx7QRR1ldem3N2QH2mdHppPtfYIZjJUPnBywqWfPN3Fm7
 TYcHkjlXJtFT84LSrmsj1APcHav3yMIGfwETZB5DPF4dvAC8C9JEVz30+0m63CLaCb
 VHvh4OzVQgQIXT727nJJyQk3Wp05c9o2leJ2tlQVTfG0o+XZVvHEKtu/9XLHY8jCsz
 GhIBY6YADq6cw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: fall back to MMIO TLB invalidation
 when KIQ is unresponsive
To: "Denis Pisarev" <pisarevden@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819185349.29407-2-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260819185349.29407-2-pisarevden@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:06:31 +0000
Message-Id: <20260819190632.407EF1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Falling back to direct MMIO for TLB invalidations during runti=
me circumvents KIQ's GFXOFF protection, risking fatal system hangs. The MMI=
O path directly accesses Graphics Compute (GC) registers via `WREG32_SOC15_=
IP_NO_KIQ(GC, ...)`. As noted in the existing comment ("This path is needed=
 before KIQ/MES/GFXOFF are set up"), this is only safe before GFXOFF is act=
ive. If KIQ fails during normal runtime and the system falls back to this p=
ath while GFXOFF has power-gated the GC block, the CPU will attempt to acce=
ss powered-off MMIO registers without first waking them via `amdgpu_gfx_off=
_ctrl(adev, false)`.
- [High] The patch implements a self-healing fallback mechanism that relies=
 on a global counter (`adev->gmc.kiq_flush_failures`), which fails to corre=
ctly track errors on multi-XCC devices. KIQ instances operate per-XCC. If o=
ne XCC's KIQ becomes wedged, it increments the global counter. However, any=
 concurrent successful TLB flush on a healthy XCC will call `atomic_set(&ad=
ev->gmc.kiq_flush_failures, 0)`, wiping the failure history. This cross-tal=
k prevents the wedged XCC from ever reaching the `AMDGPU_KIQ_FLUSH_MAX_FAIL=
` threshold.
- [High] The MMIO fallback allows concurrent, unsynchronized access to the =
TLB invalidation engine from both the CPU and the CP (KIQ) microengine. Whe=
n a KIQ command times out, the unexecuted TLB invalidation commands remain =
in the KIQ ring buffer. The CPU then falls through to the MMIO path, direct=
ly writing to the same invalidation request and acknowledgment registers. T=
he `adev->gmc.invalidate_lock` spinlock only serializes CPU threads. If the=
 KIQ subsequently recovers or processes its delayed ring, it will concurren=
tly write to the same registers.
- [High] The patch allows an SR-IOV Virtual Function (VF) to fall back to d=
irect MMIO for TLB invalidations if the KIQ path times out. However, VFs la=
ck the necessary privileges to directly write to global GMC invalidation re=
gisters (which is why KIQ proxying is strictly required). If a VF executes =
the MMIO fallback, the hardware will block the register writes or trigger a=
 fatal security violation trap in the Physical Function (PF).
- [Medium] The MMIO fallback path acquires `adev->gmc.invalidate_lock` with=
 a plain `spin_lock()`. Originally, this path was only executed before init=
ialization completed, avoiding contention. With the patch, this path is rea=
chable during normal runtime when KIQ fails. The `amdgpu_gmc_fw_reg_write_r=
eg_wait()` function explicitly anticipates being called from interrupt cont=
ext (via its `in_interrupt()` check). If `gmc_v9_0_flush_gpu_tlb()` is invo=
ked from an interrupt context, an interrupt preempting a process-context th=
read that currently holds the plain spinlock will attempt to acquire the sa=
me lock, resulting in an AB-BA deadlock.
- [Medium] The patch introduces a `dev_warn` message in `amdgpu_gmc_fw_reg_=
write_reg_wait()` claiming "falling back to MMIO" when the KIQ failure thre=
shold is reached. However, the callers in v10, v11, and v12 GMC implementat=
ions were not updated to check this return value or the failure counter. Th=
erefore, they do not bypass the KIQ path or fall back to MMIO. This results=
 in a highly misleading log message.

Pre-existing issues:
- [High] The patch modifies `amdgpu_gmc_fw_reg_write_reg_wait()` to return =
an `int` so callers can fall back to MMIO on failure. However, for the MES =
firmware path, the patch explicitly hardcodes `return 0;` instead of propag=
ating the error code returned by `amdgpu_mes_reg_write_reg_wait()`. Consequ=
ently, if the MES path fails, the caller is falsely informed of success, by=
passes the newly introduced MMIO fallback, and silently drops the TLB inval=
idation.
--

--- Patch [1]: [RFC PATCH 1/1] drm/amdgpu: fall back to MMIO TLB invalidati=
on when KIQ is unresponsive ---
commit 551bd0b3bbdf086c6bb58a378bdcd03f9d151f96
Author: Denis Pisarev <pisarevden@gmail.com>
Subject: drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is unrespo=
nsive

This patch implements a fallback mechanism for TLB invalidations on gmc_v9
parts when the KIQ ring becomes unresponsive. It counts consecutive failures
and falls back to direct MMIO, bypassing the KIQ path entirely after a
threshold is reached.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 2f6d20c00ce29..566f42140e13d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -886,7 +886,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_d=
evice *adev,
>  	if (adev->mes.ring[MES_PIPE_INST(xcc_inst, 0)].sched.ready) {
>  		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
>  					      ref, mask, xcc_inst);
> -		return;
> +		return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but amdgpu_mes_reg_write_reg_wait() returns an
error code on failure. By hardcoding a return of 0 here, does this mask MES
failures and prevent the new MMIO fallback from executing when the MES ring
fails? If the error isn't propagated, the caller will assume success and
silently drop the TLB invalidation.

[ ... ]

> @@ -917,13 +917,20 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu=
_device *adev,
>  	if (cnt > MAX_KIQ_REG_TRY)
>  		goto failed_kiq;
> =20
> -	return;
> +	atomic_set(&adev->gmc.kiq_flush_failures, 0);
> +	return 0;

[Severity: High]
On multi-XCC devices, KIQ instances operate per-XCC. Since this is a global
counter, will a successful TLB flush on a healthy XCC unconditionally clear
the failure history for a wedged XCC? This cross-talk might prevent the
wedged instance from ever reaching the AMDGPU_KIQ_FLUSH_MAX_FAIL threshold.

>  failed_undo:
>  	amdgpu_ring_undo(ring);
>  	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  failed_kiq:
> -	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
> +	if (atomic_inc_return(&adev->gmc.kiq_flush_failures) =3D=3D
> +			AMDGPU_KIQ_FLUSH_MAX_FAIL)
> +		dev_warn(adev->dev,
> +			 "KIQ reg access keeps failing, falling back to MMIO\n");

[Severity: Medium]
Is this log message accurate for v10, v11, and v12 GMC implementations? Sin=
ce
the call sites for newer GPU architectures were not updated to check the
return value or failure counter, they won't actually fall back to MMIO,
making this warning potentially misleading.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index b46b87291c512..271c179ed31ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -799,13 +799,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>  	 * properly under bare metal
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
> -	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> +	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> +	    atomic_read(&adev->gmc.kiq_flush_failures) <
> +			AMDGPU_KIQ_FLUSH_MAX_FAIL) {

[Severity: High]
If KIQ fails on an SR-IOV Virtual Function (VF) during runtime, the thresho=
ld
check will fail and execution will fall through to the direct MMIO path.
Since VFs lack privileges to write to global GMC invalidation registers
directly, will this trigger a fatal security violation trap in the Physical
Function (PF)?

>  		uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
>  		uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> =20
> -		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
> -						 1 << vmid, inst);
> -		return;
> +		if (!amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
> +						      1 << vmid, inst))
> +			return;
> +		/* KIQ submit failed - fall through to the MMIO path below
> +		 * so the invalidation is not silently dropped
> +		 */
>  	}

[Severity: High]
When falling through to MMIO here, the original timed-out command remains
pending in the autonomous KIQ ring buffer. If the KIQ experiences a transie=
nt
delay and then resumes processing its queued commands, could it concurrently
write to the same invalidation request and acknowledgment registers while t=
he
CPU is accessing them? This might corrupt the hardware state machine.

> =20
>  	/* This path is needed before KIQ/MES/GFXOFF are set up */

[Severity: Medium]
With this patch, the direct MMIO path is now reachable during normal runtime
when KIQ fails, where it will acquire adev->gmc.invalidate_lock via a plain
spin_lock(). The amdgpu_gmc_fw_reg_write_reg_wait() function anticipates
being called from interrupt context (it checks in_interrupt()). If
gmc_v9_0_flush_gpu_tlb() is invoked from an interrupt context, could it
preempt a process-context thread holding this plain spin_lock and attempt
to acquire it again, causing an AB-BA deadlock?

[Severity: Critical]
As the comment notes, this MMIO path is only safe before GFXOFF is set up.
If KIQ fails during normal runtime and we fall back to this path while GFXO=
FF
has power-gated the GC block, will accessing the GC registers directly cause
a machine check exception or hard system hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819185349.2940=
7-2-pisarevden@gmail.com?part=3D1
