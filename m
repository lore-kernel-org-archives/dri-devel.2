Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F430C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1D310E00C;
	Thu, 13 Aug 2026 09:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aByAJZoB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB1610E00C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:56:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D3AC600E2;
 Thu, 13 Aug 2026 09:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A7F1F000E9;
 Thu, 13 Aug 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786615003;
 bh=V7xRtDVYeylMNDmjSRgypDqgeEAvnRbgIcReeeuwJLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aByAJZoBushgqk9IzmHIUVgxGvED1ycMjhj0nMud6PzPdhtbyTVxP3F35IAEZGAJU
 Z4Iq++eHcqvI1H7F/g56KMGIdL0Up/kaHYPXDub/+YoNoSMRYD0j69z/aenDGCRgGw
 4/aYhKbstNdMWd1M2uj5FZuR/f0du4xdGKXZu4vdu2cGDvIkWuRIJPhtqlPrpntGwp
 QsyaX7QHGoAL0e8hpKGaSYM0BqpElE64XejF81DhdNh/HIpzkz0CvZ1leh9dvrm3KK
 zZvu2dP6jexov5eGboCqKmX3JmN/hg0JjzmMDF+2p3B/vaC75mQ7cKMRfRwUox7ONw
 HieXSYjIbhHJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/virt: fix integer overflow in size_kb shift
To: lihaojie <lihaojie@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813063418.2064270-1-lihaojie@kylinos.cn>
References: <20260813063418.2064270-1-lihaojie@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:56:42 +0000
Message-Id: <20260813095643.25A7F1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] kzalloc(0) returns ZERO_SIZE_PTR which bypasses NULL checks and le=
ads to an invalid pointer dereference when the data exchange table is omitt=
ed.
- [High] The delayed work vf2pf_work is not properly cancelled if the updat=
e interval is 0, leading to an infinite workqueue loop and a Use-After-Free=
 when the device is destroyed.
--

--- Patch [1]: [PATCH] drm/amdgpu/virt: fix integer overflow in size_kb shi=
ft ---
commit 9ad17a9be1058b6419621f31c0a9ac90b297b043
Author: lihaojie <lihaojie@kylinos.cn>

drm/amdgpu/virt: fix integer overflow in size_kb shift

This commit casts size_kb to u64 before left-shifting by 10 to prevent 32-b=
it
arithmetic overflow for buffer sizes. It updates the affected kzalloc and
amdgpu_device_vram_access calls, and modifies the debug string formats to
correctly print the new u64 values.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index b43fc643668d2..afa66d9fed906 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

[ ... ]

> @@ -805,7 +805,8 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
>  		/* got through this logic in early init stage to get necessary flags, =
e.g. rlcg_acc related*/
>  		if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
>  			pfvf_data =3D
> -				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID=
].size_kb << 10,
> +				kzalloc((u64)adev->virt.crit_regn_tbl
> +					[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
>  					GFP_KERNEL);
>  			if (!pfvf_data) {
>  				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
>  				return;
>  			}

[Severity: High]
This is a pre-existing issue, but does this allocation safely handle the ca=
se
where the hypervisor omits the data exchange table?

If the AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID table is omitted, size_kb will b=
e 0.
kzalloc(0) returns ZERO_SIZE_PTR (0x10) instead of NULL, which causes the
(!pfvf_data) check to succeed.

Later, in amdgpu_virt_read_pf2vf_data():

	if (adev->virt.fw_reserve.p_pf2vf =3D=3D NULL)
		return -EINVAL;

	if (pf2vf_info->size > 1024) {

The invalid ZERO_SIZE_PTR is not NULL, so it reaches the size check and is
dereferenced, causing a kernel panic. Should the allocation be guarded agai=
nst a
0 size?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for vf2pf_wor=
k to
cause an infinite workqueue loop and a use-after-free during device teardow=
n?

If amdgpu_virt_read_pf2vf_data() fails to read valid data during initializa=
tion,
adev->virt.vf2pf_update_interval_ms remains 0.

In amdgpu_virt_fini_data_exchange():

	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
		dev_info(adev->dev, "clean up the vf2pf work item\n");
		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
		adev->virt.vf2pf_update_interval_ms =3D 0;
	}

The work cancellation is skipped because the interval is 0.

However, the work function amdgpu_virt_update_vf2pf_work_item() uncondition=
ally
reschedules itself:

out:
	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_in=
terval_ms);

This leaves the work looping infinitely with a 0 delay.

When the device is unloaded, the uncancelled work continues executing and
dereferences adev after it has been freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063418.2064=
270-1-lihaojie@kylinos.cn?part=3D1
