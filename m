Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D0BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DA610F838;
	Fri,  3 Jul 2026 14:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MpxZkjLR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0562610F838
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:38:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0C634322C;
 Fri,  3 Jul 2026 14:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726771F000E9;
 Fri,  3 Jul 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783089531;
 bh=FdSfyK20yWj4X37Fi2Lwtz4YZpg3RXsVljpazlBCwYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpxZkjLRpcZFWChi/izrWJ5utKAyKsGurSAk/5PpCi7+oQWLfxOWlE2Hgx4yb8hhn
 l+snfVVkycP/kHH2QFzVY55vgQl1ULAIIa/+YJLK+sMq/3eiekJWA/VXHSTbCsOFfX
 sMYot6zSv3ruz+NAOdH9mOZW4yy3am3Gwu4WzGXDDyCSDnwF6gEIUo8jJi0W/bjvmk
 ZRd2iMb9bUAkNIGNHhY7GSJbMD88EMpQSJNNywcpineObsdRmnT3tGNcGYT95Cex1X
 XeXNuzKEu9r9eALAqKDhl5G852e0KHPcqTksIHCURGCzjJNSvkfpQXbF+W+Rh9oh67
 REYx8F/dJenmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/tests: shmem: Set DMA mask to 64-bit in
 drm_gem_shmem
To: =?utf-8?b?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703142749.4099-1-jose.exposito89@gmail.com>
References: <20260703142749.4099-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:38:50 +0000
Message-Id: <20260703143851.726771F000E9@smtp.kernel.org>
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
- [Low] A moved comment describes operations that are not performed in its =
new location.
--

Note: The format of this report has been altered to provide a free-form sum=
mary without direct code quotes due to recitation restrictions.

commit 80b1922edca70f8edc78748fddf0120eb2612fec
Author: Jos=C3=A9 Exp=C3=B3sito <jose.exposito@redhat.com>
Subject: drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem

This commit fixes intermittent DMA address overflow failures on ppc64le and
s390x CI systems during drm_gem_shmem tests. It does this by moving the
configuration of the 64-bit DMA mask into the test initialization phase,
ensuring it applies to all tests rather than just one.

Link: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artif=
acts/2643976103/test_s390x/15128551935/artifacts/jobwatch/logs/recipes/2156=
1049/tasks/220716793/results/1014626315/logs/dmesg.log
Link: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artif=
acts/2643976103/test_ppc64le/15128551933/artifacts/jobwatch/logs/recipes/21=
561041/tasks/220716705/results/1014628163/logs/dmesg.log

In drivers/gpu/drm/tests/drm_gem_shmem_test.c:

[Severity: Low]
This isn't a bug, but does the moved comment in drm_gem_shmem_test_init
need to be updated?

The patch moves a block comment alongside the dma_set_mask call into the te=
st
initialization function. This comment explicitly states "and map the sgtabl=
es
otherwise drm_gem_shmem_free will cause a warning".

However, the actual dma_map_sgtable call was not moved and remains in the
original function. Leaving this text in the new location is slightly
misleading, as it implies the sgtables are being mapped during device init.

Could we update the comment to remove the reference to mapping the sgtables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703142749.4099=
-1-jose.exposito89@gmail.com?part=3D1
