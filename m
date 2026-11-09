Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241E606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsYLqcIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0606010E6F2;
	Mon,  9 Nov 2026 17:40:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F83210E6F2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:40:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9832634D4;
 Mon,  9 Nov 2026 17:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22951F008AB;
 Mon,  9 Nov 2026 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794246014;
 bh=PGHaj5v1eucnI2aoBLw1wMKEmdqX6Pr1er5SmGRXIqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FsYLqcItsuzJc0Rv3llWN3jw8cYlo0yyyLpCsxnP+Bh3X5sjgt2KabdA1Zn8h0xEq
 eifp0gkNRUNX8MjvAFihNoF9/xmUMEiZUmYp9Kfrg2UHk5GZfd5ZMu+qjH6TASy87I
 IEd8USCFJtQcFyoQ2BLBuoNCc/B/vNubbU1fMSOchJaS5VxcFGd1BOqJ6US2xvg/2Z
 Gu/gJE7KcYuKCG/fkumpipBOK5zuXCqIRwfNpaR6bMx2cAva0M5up+ZID9vQjbP+Kb
 W0xCWOtlSL4HWq0B3wykDuFHz2MxmzA2fVxBaEWcyb8zTHy+JkIM0vp0J0aIDPxyHD
 myDFHQTJr7sew==
Message-ID: <sashiko-outbox-205320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/amdgpu: always clear stable_pstate_ctx in
 amdgpu_ctx_fini
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109171333.4329-3-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:40:13 +0000
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
- [Low] drm/amdgpu: missing Fixes trailer for amdgpu_ctx_fini() bug fix
--

commit b90ed859fa95af280f43e7bfda0184d737724134
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

> drm/amdgpu: always clear stable_pstate_ctx in amdgpu_ctx_fini
>
> Even if the hardware is not available we should clear the pointer when
> the owning context is destroyed, otherwise nobody will be able to
> use this feature again.
>
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric=
.pelloux-prayer@amd.com?part=3D5
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

[Severity: Low]
Since this fixes leaving adev->pm.stable_pstate_ctx set when drm_dev_enter()
returns false in amdgpu_ctx_fini(), should it include a Fixes: tag?

  Fixes: c1dc4ccb82c9 ("drm/amdgpu: Fix context pstate override handling")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109171333.4329=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D3
