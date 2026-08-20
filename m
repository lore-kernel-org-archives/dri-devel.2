Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD264C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D4C10E5E8;
	Thu, 20 Aug 2026 11:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XYVGWotp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDB110E5E8
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:11:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DE6260A61;
 Thu, 20 Aug 2026 11:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A861F000E9;
 Thu, 20 Aug 2026 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787224304;
 bh=fasbt8tAnOEG6vdRs+TxDaJqcr7L2VB8rKHSNY54nbI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XYVGWotp3K24rvhSJ/vQX2GcrKyJ+ekv/8HfFSXobLMj3NDdljILvZAtV0a46wM+o
 QFPrXTLN3eGi2kfnpo7XKtdrJY9c1W0OvIomjds8K0qJEdc4mxnr3ueYLs5y+7+/Xe
 /OgaIaVg7Em4xfcpw00V7IQEJBvHi/iZu4w82xZkiTBlZkJDhWP8aS0MYDwRyRpgqH
 DYhWR8sY8E9Ud1cDdFvwXoqOCp5yI6iFMieVfXoBqJdYNRIJFKAwROzPlDlGzdGGFE
 YCatZls3lMOyaZl5fvPQMkKJdPXZFPREn00uyI73CvE/avaxuNo+MpT+6h62IPKpGj
 9fkpNzARzHEUQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/1] drm/amdgpu: fall back to MMIO TLB
 invalidation when KIQ is unresponsive
To: "Denis Pisarev" <pisarevden@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820105716.148732-2-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260820105716.148732-1-pisarevden@gmail.com>
 <20260820105716.148732-2-pisarevden@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:11:43 +0000
Message-Id: <20260820111144.36A861F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] SR-IOV VFs and interrupt contexts silently drop TLB flushes once K=
IQ failure threshold is reached.
- [High] KIQ and MMIO fallback use the same invalidation engine, causing ha=
rdware register corruption when racing.
--

--- Patch [1]: [RFC PATCH v2 1/1] drm/amdgpu: fall back to MMIO TLB invalid=
ation when KIQ is unresponsive ---
commit 9356e0619308f1d18159aa347d78c9e8c47151eb
Author: Denis Pisarev <pisarevden@gmail.com>
drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is unresponsive

This commit implements an MMIO fallback for TLB invalidation on gmc_v9 when
KIQ becomes unresponsive after resume. It limits KIQ retries to 3 consecuti=
ve
failures before switching to direct MMIO, bypassing the long timeout window.
The fallback is restricted to bare metal process contexts.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
[ ... ]
> +static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t =
vmid,
> +					uint32_t vmhub, uint32_t flush_type)
> +{
[ ... ]
> +	if (adev->gfx.kiq[inst].ring.sched.ready &&
> +	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> +		uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +		uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		if (atomic_read(&adev->gfx.kiq[inst].flush_failures) <
> +				AMDGPU_KIQ_FLUSH_MAX_FAIL) {
> +			if (!amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack,
> +							      inv_req,
> +							      1 << vmid, inst))
> +				return;
> +			/* KIQ submit failed; error already logged */
> +		}
> +
> +		/*
> +		 * MMIO fallback: invalidation must not be silently dropped
> +		 * when KIQ is unresponsive. Direct register access is only
> +		 * safe in process context (amdgpu_gfx_off_ctrl may sleep)
> +		 * and on bare metal; SR-IOV VFs must keep proxying through
> +		 * KIQ.
> +		 */
> +		if (in_interrupt() || amdgpu_sriov_vf(adev))
> +			return;

[Severity: High]
Does this silently drop TLB flushes for SR-IOV VFs and interrupt contexts?

If the KIQ times out 3 consecutive times, the flush_failures threshold is
reached. On subsequent TLB flush requests from a VF or interrupt context,
the threshold check fails and KIQ submission is bypassed entirely.

The code then hits this check and returns immediately, permanently dropping
all subsequent TLB invalidations until the counter resets. Could this lead =
to
stale TLBs, memory corruption, or arbitrary memory faults for the VF?

> +
> +		amdgpu_gfx_off_ctrl(adev, false);
> +		gmc_v9_0_flush_gpu_tlb_mmio(adev, hub, vmid, vmhub, inv_req);

[Severity: High]
Can a hardware race condition occur here if KIQ recovers?

When the driver encounters a KIQ timeout, the command is left in the KIQ
ring. Once the failure threshold is met, the CPU begins writing directly
to engine 17 via gmc_v9_0_flush_gpu_tlb_mmio().

If the KIQ command processor unwedges and processes its delayed queue,
it will emit writes to the same REQ and ACK registers concurrently with
the CPU's MMIO accesses. Could overwriting the VM_INVALIDATE_ENG0_REQ
register lead to lost TLB flush requests, or cause KIQ to hang waiting
for an ACK bit that never arrives?

> +		amdgpu_gfx_off_ctrl(adev, true);
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820105716.1487=
32-2-pisarevden@gmail.com?part=3D1
