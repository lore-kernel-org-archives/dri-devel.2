Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BAACA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1737010E383;
	Thu,  1 Oct 2026 11:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YaVwbJtz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6E710E383
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:58:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E329940BFB;
 Thu,  1 Oct 2026 11:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744FF1F00898;
 Thu,  1 Oct 2026 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790855931;
 bh=3MpH6uoFnriJyB3DmdJkKxxH3NSU+c7otgP34MdTSdM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YaVwbJtzIvT4BPePc42jLdf6iduR3E8H24um0u4fjXxCj0akwFNKls0hLoIWvzOHV
 J/eV6a9viIVFi4Oi52SKL2ijic8o/YDkKMeLuPRN9h/C7bfF6R24Ab8lp+FP3K9Num
 Nq6oV79dfVOxwHnaFSfwQ28gRwtlge90phFV/pBgwyvgHfFhQeOtYEG0kJkGvpVSEn
 6w+t513GymmlTs71qXESNzez1TVv7I4Ifxx4ZUzYtKi2sVahgdedQwtT/PWxk+oi5s
 TQoyEr/scstpVLlL5EzlN8gRxi3Z7fO2TWuBunEnO/Z3AyYTmmDtPuy9fScFtmarB+
 6Ko9NK3WBh8LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/18] PCI/P2PDMA: Document TLP-class routing
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-15-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-15-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:58:50 +0000
Message-Id: <20261001115851.744FF1F00898@smtp.kernel.org>
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

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The P2PDMA documentation stated that the mapping result is not defined for
> Relaxed Ordering or ATS-translated Requests. It now is.
>=20
> Replace that paragraph with what the three TLP-sensitive ACS controls do
> and the table of outcomes per class. Record that an answer relying on
> Relaxed Ordering Completions holds only for a provider that returns them,
> which the PCIe specification leaves optional.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D15

