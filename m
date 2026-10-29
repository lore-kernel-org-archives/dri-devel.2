Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C4606A327
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1i6nC60
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BFF112336;
	Thu, 29 Oct 2026 14:13:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8EA11233B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:13:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A64E841074;
 Thu, 29 Oct 2026 14:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4BC1F01828;
 Thu, 29 Oct 2026 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283215;
 bh=+pE9WiVmUOYqW50PCKiS/ra/HVGFNnSngvzlVshgGrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P1i6nC60DxADynjhMVLnkCFwX/ExF3rCfE7UVU8GHzCkzsRwr+2hFlbgOjDb+PV7N
 vT6AGp6S654xehJSDyDGSwMofg04FVzYwXRpMb64iFa2JQ0qoKh0nhiqL2RxE7oVx+
 7ksDo/iPcjBv3EAETAJeoiApCFPAHy0xb3+Tn+VKvNWb4sGMFCzbcI+nGkjYLIYz3r
 8kmaWgeIQDcHl/F32dudUTpSOSm6JAduPn311MwLnTeOTYtfpXl7xYGKs3kGYEsX+u
 r1xO0xaZCwT4rYyRSOTpUmq5GNlmlosHgsILsZRVeV93w+EhWGKR9f1aLbWH9CjmED
 sKkVoeEIjIeIw==
Message-ID: <sashiko-outbox-189487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/14] iommu: arm-smmu-qcom: Fixed mapping
 between sid and cb for gpu and lpac
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-7-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-7-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:13:34 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/arm-smmu-qcom: unconditional CB 1 reservation for LPAC shift=
s GMU CB
--

commit 51e5e8227679664f11df23a51921048a054a1310
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

iommu: arm-smmu-qcom: Fixed mapping between sid and cb for gpu and lpac

This commit splits context bank allocation and initialization in
arm-smmu-qcom so that the gpu device (stream id 0) is assigned context bank=
 0
and the lpac device (stream id 1) is assigned context bank 1, while other
devices start allocation from context bank 2.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index ae6152bddf8fe..9413b748e79d1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c

[ ... ]

> @@ -313,12 +330,14 @@ static int qcom_adreno_smmu_alloc_context_bank(stru=
ct arm_smmu_domain *smmu_doma
>  	 */
>  	if (qcom_adreno_smmu_is_gpu_device(dev)) {
>  		start =3D 0;
> -		count =3D 2;
> +		count =3D start + 1;
> +	} else if (qcom_adreno_smmu_is_lpac_device(dev)) {
> +		start =3D 1;
> +		count =3D start + 1;
>  	} else {
>  		start =3D 2;
>  		count =3D smmu->num_context_banks;
>  	}
> -
>  	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
>  }

[Severity: High]
Does unconditionally reserving context bank 1 for a separate lpac device and
forcing all other devices into the else branch with start =3D 2 cause a
regression on platforms without a separate qcom,lpac device node?

In drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c,
qcom_adreno_smmu_alloc_context_bank() now assigns only context bank 0 when
qcom_adreno_smmu_is_gpu_device(dev) is true, reserves context bank 1 for a
separate device matching qcom_adreno_smmu_is_lpac_device(dev), and starts a=
ll
other allocations at context bank 2.

On platforms that do not have stream id 1 (such as sdm845, sc7180, sm8150, =
and
sm8250), or on platforms where both stream id 0 and stream id 1 are listed =
on
the main gpu node rather than a separate qcom,lpac child node (such as
sc8280xp, sm8350, sc7280, sm8450, sm8550, x1e80100, or sm8650 with an older
device tree), the main gpu device matches qcom_adreno_smmu_is_gpu_device(de=
v)
first and allocates context bank 0, leaving context bank 1 unallocated.

When a6xx_gmu_memory_probe() -> msm_iommu_new() -> iommu_attach_device() ->
arm_smmu_init_domain_context() -> qcom_adreno_smmu_alloc_context_bank()
subsequently allocates a context bank for the qcom,adreno-gmu device (stream
id 5), it falls into the else branch with start =3D 2 and receives cbndx =
=3D 2
instead of cbndx =3D 1. As noted in commit afc95681c306 ("iommu/arm-smmu-qc=
om:
Add missing GMU entry to match table"), having the gmu on cbndx =3D 2 inste=
ad of
cbndx =3D 1 on sc8280xp causes the smmu to wedge on gpu translation faults.

In addition, on platforms with only two context banks available to Linux,
such as qcom,sdm630-smmu-v2:

drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:qcom_adreno_smmuv2_cfg_probe() {
	/* TZ protects several last context banks, hide them from Linux */
	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2") &&
	    smmu->num_context_banks =3D=3D 5)
		smmu->num_context_banks =3D 2;
}

entering the else branch passes start =3D 2 and count =3D 2 to
__arm_smmu_alloc_bitmap(), which immediately fails even though context bank=
 1
is free:

drivers/iommu/arm/arm-smmu/arm-smmu.h:__arm_smmu_alloc_bitmap() {
	do {
		idx =3D find_next_zero_bit(map, end, start);
		if (idx =3D=3D end)
			return -ENOSPC;
	} while (test_and_set_bit(idx, map));
}

Could context bank 1 only be reserved when a separate lpac device is actual=
ly
present, or should the else branch still allow allocating from context bank=
 1
when lpac is not used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D7
