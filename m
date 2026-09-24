Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD73C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD8B10F44D;
	Thu, 24 Sep 2026 10:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NxegDJ7/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF1410F44F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:22:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03AAF601EF;
 Thu, 24 Sep 2026 10:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C431F00893;
 Thu, 24 Sep 2026 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790245374;
 bh=nyWKpdPHcUsX4hzNUZswfNLX4eWwVSI/lyiHUGXWFyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NxegDJ7/Rg4PlVy/nCHIbPLxl2w8HcGH1cJ+GDy3aaM8Cj+oI8kWGYH61RnZ4/RCv
 mlwMSYcs+vAliSn3PmylkY2xsyoYNTK4IBEOsn2hViwi332zm+qVaBTRW9YuQoscTp
 zsrWulJGS6DPWBO8/yGrNexmR+LwDUyZCKvP8e8SDzYaLO7jxPSaWRuuZ9YkXtNGPt
 PDvU0zHnHzwVQY7R0csMN8krDuBZK1e3447CtC2A0w61uC42UCXpQkXKGh5UUWAvsx
 gMoB56tIjP6Xl+VMcUneNlZKxGCWIdevemLgNtb/cS4bpt7MI0yNAoWP13Kgfk5ZCv
 1Pg0/yESyKabw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 08/14] swiotlb: Align shared IO TLB pools to the
 shared granule size
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: media-ci@linuxtv.org, kvmarm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260924100529.1398790-9-aneesh.kumar@kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:22:53 +0000
Message-Id: <20260924102254.60C431F00893@smtp.kernel.org>
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
- [Medium] mm: infinite loop in swiotlb_init_late() when remap fails
--

commit 9e7f1b72520615870ee21508117e4c5c7e0eb684
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

swiotlb: Align shared IO TLB pools to the shared granule size
   =20
This commit aligns and sizes the early memblock pool to the common CoCo
shared granule, leaving the slot count unchanged. It replaces the default
and dynamic pool set_memory calls with helpers to keep alignment validation
and architecture dispatch centralized. Pages are intentionally leaked if
their private state cannot be restored safely.

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ded7016a46a71..394db93b7eb96 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c

[ ... ]

> @@ -578,7 +578,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		swiotlb_adjust_nareas(num_possible_cpus());
> =20
>  retry:
> -	order =3D get_order(nslabs << IO_TLB_SHIFT);
> +	order =3D get_order(ALIGN(nslabs << IO_TLB_SHIFT, cc_shared_granule_siz=
e()));
>  	nslabs =3D SLABS_PER_PAGE << order;

[Severity: Medium]
If remap() fails later in this function, nslabs is halved and the code jumps
back to the retry label to try a smaller allocation:

kernel/dma/swiotlb.c:swiotlb_init_late() {
    ...
	if (remap)
		rc =3D remap(vstart, nslabs);
	if (rc) {
		free_pages((unsigned long)vstart, order);

		nslabs =3D ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
		if (nslabs < IO_TLB_MIN_SLABS)
			return rc;
		retried =3D true;
		goto retry;
	}
    ...
}

Does the new ALIGN macro at the retry label risk inflating the halved size
back to its original value if cc_shared_granule_size() is >=3D 2MB?

If so, this would restore nslabs to its original failing value, overriding
the shrinking mechanism and creating an infinite loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100529.1398=
790-1-aneesh.kumar@kernel.org?part=3D8
