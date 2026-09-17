Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654CEC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AC710F014;
	Thu, 17 Sep 2026 17:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ofBfnCUh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BB610F014
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:31:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D4E7600D4;
 Thu, 17 Sep 2026 17:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219641F00893;
 Thu, 17 Sep 2026 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666301;
 bh=1ooLm7hrXtQndWS3tT1leP5llkYGwrNxLD1Xfrvgqu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ofBfnCUhpRln6k+GHy2k0PlXWBDfr111QY+AgFq0gDqOsrrECKsFQ6p0EEnuwhSKt
 /zYTB0zat6vJ//+8tizwwbuHhUo6PZa2A2mFK6UWbnvNfbkYankAT4fP/O8PoUwJZ9
 9qA/ZRRyAMYEBcgdLRYCiHrUiTVOQZej8QvJ4AtIwbbM9JqgNMQpFy42nCbGau4CfJ
 SUug3adp/Xvm1eytP+1Rx7/ujrI7xb/E6TRZ+lgsSU362/Nb0Aff+UWdQkV+YcczgA
 xtE2h5vkh98nEWQXRjV86gy2D+m2x1Wk8fVK5qMFVCdiwYk9gOpnmvSIA9q4LW/1Ov
 K6Yp1SWgno+cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/40] mm: remove hugetlb_inline.h
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 selinux@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-27-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-27-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:31:39 +0000
Message-Id: <20260917173140.219641F00893@smtp.kernel.org>
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

> This header really makes little sense - every place it is included mm.h is
> also included, and the header itself includes mm.h, so it does nothing to
> reduce header size.
>=20
> It also oddly does an #ifdef around checking VMA_HUGETLB_BIT, however
> VMA_HUGETLB_BIT is unconditionally available, and will never be set if
> hugetlb is not enabled.
>=20
> Simply remove the header, eliminate the odd ifdeffery and place the
> predicates in mm.h.
>=20
> The naming of these predicates is odd, but to keep changes separate, we
> will address this in a separate patch.
>=20
> The file was never put into MAINTAINERS so there's no change required
> there.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D27

