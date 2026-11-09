Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B00606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILbLjzH5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D68110E4B1;
	Mon,  9 Nov 2026 14:33:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F6810E4B1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:33:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7F61611A6;
 Mon,  9 Nov 2026 14:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE601F008A3;
 Mon,  9 Nov 2026 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234824;
 bh=hYakStvKMxLxj1LUYEzLSEL4kI7K0n8ybMv2yud9gTM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ILbLjzH5T6LCvXiUN9t2PnpE3vkP8jP/WjpH3ziVPauHxblvwdfZpFSD4FEM5XrSH
 82IqZsvuwFC3emV102JgQ5XHug2oLKQHceGwurNm+y9mfLYlf6JezXjS0Kjx3BYK4d
 O/4PMPtzYWFcEegxe0denY4duBDwPMNfICHQaM0tDALzFQlTb8ZO1EpjvMTTDxin8u
 X9ltw16MyjN5aZQVgxfJSuUGGBPwKDwgOLb47DRW5I/wWKAAS4H402eaf7Aib70zT6
 9SZIceT0xyTiNusPT8s3BO0qKMOtIlGDpCoZMHjYbb6fBbk08m+A/7/pK2dLaW0FwA
 rpG6l1JeTGVGg==
Message-ID: <sashiko-outbox-205112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261109142111.256630-6-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
 <20261109142111.256630-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:33:44 +0000
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
- [Low] drm/msm/a8xx: missing Fixes trailer on a850_ifpc_reglist_regs
  bug fix
--

commit 54d9bf20de92bf3a72deb192459f9ce0ff04d4f2
Author: Rob Clark <robin.clark@oss.qualcomm.com>

> drm/msm/a8xx: Add missing a850 ifpc reglist entries
>
> We want to save/restore all of the CP_PROTECT regs across IFPC.
>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone =
3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

[Severity: Low]
Since a850_ifpc_reglist_regs was introduced without
REG_A8XX_CP_PROTECT_GLOBAL(56..62), leaving REG_A8XX_CP_PROTECT_GLOBAL(56)
from the 57-entry a850_protect_regs table unsaved across IFPC power
collapse, should this include:

  Fixes: b0e029f7cf87 ("drm/msm/a8xx: Add Adreno 850 support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109142111.2566=
30-1-robin.clark@oss.qualcomm.com?part=3D5
