Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F27FCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CCB10F3C6;
	Fri, 12 Jun 2026 09:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pu2ncVSs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EF110F3C6
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:39:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 127226001D;
 Fri, 12 Jun 2026 09:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557041F000E9;
 Fri, 12 Jun 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781257141;
 bh=qDyMAXCqyUqF8XCgfdc20QfAw5cyiNGgeMiu22J6uBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pu2ncVSsKVJ0AQV91ZjNl/PGvXKEtd3Fjm8WZ2bHPXuI6C1Y2DOEE51U3ciKyEK1I
 lv4R4U96lzUGjucl1JQcU64BfYlr8IcV4L560Ox1Vy0x9IavhkUzGvpqdc6lFu9lG9
 FKzido7ByPKY3z+vf9N1B4nfLuh9+UQJi41YuNsyMmG7jcmdgnoAzOcn7Uwudc5K/A
 GK/BWL2L7jfyM79cprzwkZlzDeTALcrRKTFjQob58U4z8wghR/AAOO7rnQjlSHcVYC
 7fNG2WFVaeinfH6sRCQcuo0AnZw8z25ijMHrLFhP7f0eajZntDrURrHaw2IW++BxRY
 HWd/436LCxr7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/18] drm/amdgpu: add SVM notifier invalidate
 callback and checkpoint
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-10-ray.huang@amd.com>
References: <20260612090928.29682-10-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:39:00 +0000
Message-Id: <20260612093901.557041F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing read memory barrier (rmb) in interrupt timestamp capture
--

commit 68fac45f9a2ee3c91fdd1807b14f88f10a5d382e
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: add SVM notifier invalidate callback and checkpoint

This commit introduces the invalidate_ranges callback and checkpoint
timestamp capture for AMDGPU SVM. It adds amdgpu_svm_capture_checkpoint_ts
to capture the interrupt handler write pointer timestamp, and
amdgpu_svm_range_invalidate to dispatch the callbacks with TLB flush batchi=
ng.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_svm_range.c
> index 57bcbaf0fdd2b..6ac785a3b5cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

[ ... ]

> +void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
> +{
> +	struct amdgpu_device *adev =3D svm->adev;
> +	struct amdgpu_ih_ring *ih;
> +	uint32_t checkpoint_wptr;
> +
> +	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> +		ih =3D &adev->irq.ih1;
> +		checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);

[Severity: High]
Does this code need an rmb() here before reading the timestamp from the ring
buffer?

Since the CPU reads the write pointer (which is updated by the GPU) and then
immediately decodes the timestamp from the ring buffer payload in memory via
amdgpu_ih_decode_iv_ts(), couldn't the CPU or compiler reorder these reads?

If reordered, the CPU might speculatively fetch the stale ring buffer paylo=
ad
before fetching the new write pointer, capturing a stale or garbage timesta=
mp.

> +		if (ih->rptr !=3D checkpoint_wptr) {
> +			WRITE_ONCE(svm->checkpoint_ts,
> +				   amdgpu_ih_decode_iv_ts(adev, ih,
> +							  checkpoint_wptr, -1));
> +			return;
> +		}
> +	}
> +
> +	ih =3D &adev->irq.ih_soft;
> +	checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);

[Severity: High]
Is an rmb() also missing here for the ih_soft ring?

Similarly, without a read memory barrier, the CPU might read stale data from
the ring buffer payload before observing the write pointer update.

> +	if (ih->rptr !=3D checkpoint_wptr)
> +		WRITE_ONCE(svm->checkpoint_ts,
> +			   amdgpu_ih_decode_iv_ts(adev, ih,
> +						  checkpoint_wptr, -1));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D9
