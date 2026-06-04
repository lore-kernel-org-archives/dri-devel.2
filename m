Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E874CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9B911280C;
	Thu,  4 Jun 2026 14:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ebFYczjO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7C611280C
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:04:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D7D343C25;
 Thu,  4 Jun 2026 14:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4771F00893;
 Thu,  4 Jun 2026 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780581872;
 bh=25cbMgPk5RbMB0zgQn52YgaiZnbZnNYLgFuy17++Xwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ebFYczjOlEWnP0tsoXb1an+IeO1cDcxD9hRiuCFVzs5R43T+XwAy/osfePshYqlRB
 Avxq5r1xMgOcqOnzepRj18xN0fkUt7jWeGbVhH3TxdBIhF4HM17POQL+SkzZhyvwGc
 yl7exOIWtwizum/L7rnpjGeF1uXvuvtsA8vH8ageKHaiyOv0nKk6IZmK4g4z0/1ISQ
 nq2CXr/fRq9NKIk0+ixeXAutXpIdzvZNgfXSRBY3kCYyGmPq5XwErynm19piR30ufM
 N9+9t/4UAAy4/6tZfnRNFylkfaTi7AdCC4BeoEi5ysSX/nvQkEoy/5ex72w7WNwd+0
 WQJRXrlKWdGXQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on
 the RK356x v1 IOMMU
To: "Midgy BALON" <midgy971@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260604135255.62682-7-midgy971@gmail.com>
References: <20260604135255.62682-7-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:04:31 +0000
Message-Id: <20260604140432.0B4771F00893@smtp.kernel.org>
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
- [High] The patch writes 0x2 to RK_MMU_AUTO_GATING to clear bit 1, but thi=
s value actually sets bit 1 and clears bit 0, doing the exact opposite of t=
he intended behavior.
- [High] An SoC-specific workaround is applied unconditionally to all Rockc=
hip IOMMUs using a brittle hardcoded register overwrite.
--

commit 86bf3e3b9a68d419b8e6ba9d4d3cf8afb0c324bb
Author: Midgy BALON <midgy971@gmail.com>

iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU

This commit aims to fix a hardware lockup on the RK356x v1 IOMMU by
clearing bit 1 of the RK_MMU_AUTO_GATING register. This change is intended
to prevent auto clock-gating of the page-table walker.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 0013cf196c573..7d40ecb26123f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -952,6 +952,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> =20
>  	ret =3D rk_iommu_enable_paging(iommu);
> =20
> +	if (!ret) {
> +		/*
> +		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
> +		 * auto clock-gating; the walker's AXI master then loses its clock
> +		 * between transactions and a TLB-miss page walk never completes,
> +		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
> +		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
> +		 */
> +		for (i =3D 0; i < iommu->num_mmu; i++)

[Severity: High]
Will this loop unconditionally apply the RK356x v1 workaround to all SoCs
supported by the rockchip-iommu driver? It seems older variants like the
RK3288 or RK3399 might unexpectedly receive this register write in
rk_iommu_enable() without a check for the specific SoC version.

> +			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);

[Severity: High]
Does writing 0x2 here achieve the intended result?=20

The comment mentions clearing bit 1 and keeping bit 0. Since the register
resets to 0x3 (binary 11), writing 0x2 (binary 10) actually sets bit 1 and
clears bit 0. This seems to do the exact opposite of what is described,
keeping the buggy page-walker auto clock-gating enabled and inadvertently
disabling the working slave-port gate. Should this be 0x1 instead?

Additionally, because rk_iommu_write() completely overwrites the register,
could this clobber other bits in RK_MMU_AUTO_GATING? Would it be safer to
use a read-modify-write pattern here?

> +	}
> +
>  out_disable_stall:
>  	rk_iommu_disable_stall(iommu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D6
