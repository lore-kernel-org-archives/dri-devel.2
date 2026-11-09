Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687B606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxtFlDjB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4F710E0C6;
	Mon,  9 Nov 2026 14:32:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D666710E0C6
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:32:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F8D64009E;
 Mon,  9 Nov 2026 14:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653071F0089F;
 Mon,  9 Nov 2026 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234722;
 bh=q2mJOIwI8LCYRn2Urdl0pcmFT84hZA/eRMXjOhP6lkM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RxtFlDjBF0xZlUM2iSt/82uJPCwvDElM5AinGwx0Xhhht/TS4MmmG7L5sWjr6ebH9
 5BI0eqsj/ylp6oC8X+Lxrd8jZQb+8ut8wvZ6strb8Fx5KmXSTYpOTXm2r6TdOl/e9l
 HreVDZY6c6oCMLguosOQt7T6+1zTmkUa35DgP0Qeica65BsyLVVN8VWg/S6jO74nk3
 hT6hPU7sRyy7uT25QeSvEds2FPawInHPo7Coom4BKZsy49Hym62qpAU3tKHWcgfZSK
 Ft2G/qqggZwLLdbj9XViUlCSDeP0wVkxF6Q5iwLeTQK4ac4g+gKCEPiBXMamEtJdg1
 7RY7VnenLYefQ==
Message-ID: <sashiko-outbox-205108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] drm/msm/adreno: Fix PROTECT span length
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261109142111.256630-9-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
 <20261109142111.256630-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:32:01 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/adreno: missing Fixes trailer for CP_PROTECT span length
  mask fix
--

commit 5455227077ec9a734af8ae2cb6c6ad6e8aa84875
Author: Rob Clark <robin.clark@oss.qualcomm.com>

> drm/msm/adreno: Fix PROTECT span length
>
> Don't let the length bleed into b31.
>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone =
3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

[Severity: Low]
Both macros were introduced with the 0x3FFF mask in 4b565ca5a2cb
("drm/msm: Add A6XX device support").  Should this include a Fixes:
tag?

  Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109142111.2566=
30-1-robin.clark@oss.qualcomm.com?part=3D8
