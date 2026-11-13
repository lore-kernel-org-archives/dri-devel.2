Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3A606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/TOetnd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AFA10EC19;
	Fri, 13 Nov 2026 08:48:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E581710E380
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:48:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2A226022B;
 Fri, 13 Nov 2026 08:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBC31F000C4;
 Fri, 13 Nov 2026 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559725;
 bh=uKq6wLA1C2ATw9tRTDarOk8wN/A14cZo70rMsUfL3RA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y/TOetnd7WvK0w+pS1yH3qjamzPHd00RQIySkE+dtWXHQL1d/EVrDK1dYYSN/VFWr
 DxIaxRM4PU6OvisT638yCs8/MJL4ZlS/TNAoBakrpxXdvkuaiM7uR9pDfgSwvJM5NI
 w37fVZXXFRUnGSTyTM64loAG8CHFPPL4DeYbA476Qtd6b0isOoeLFTIWxFWn0QAAPJ
 1V8sKlOgxDifSfYtzuU+pLkfOF2E9ljmI8yOrffF9539FfOM0V5xjFrheVtoZFi3fz
 ggVuKj8fzRj0UuAk1hKRArAw89HTgMxTFYGEk+XSCn5wuX3RAWl/31tKQZwmw/t4GR
 XdHpE40Muo/3g==
Message-ID: <sashiko-outbox-212462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/18] drm/exynos: exynos_dp: Unbind bridge when
 connector init fails
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-14-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-14-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:48:45 +0000
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
- [Low] drm/exynos: missing Fixes trailer for commit 99a49ff5ef7a in
  exynos_dp_bind()
--

commit 031ca4f7c94604cc44551c28df5e4025d4ecba48
Author: Damon Ding <damon.ding@rock-chips.com>

> drm/exynos: exynos_dp: Unbind bridge when connector init fails
>
> The exynos_dp_bind() returns without unwinding analogix_dp_bind() when
> drm_bridge_connector_init() fails.  The aux device registered by
> analogix_dp_bind() is then left behind with a dangling drm_dev
> pointer, which could be accessed on later AUX transfers.
>
> Call analogix_dp_unbind() in the error path to release the aux device.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

[Severity: Low]
Should this include a Fixes tag for the commit that added the
drm_bridge_connector_init() error path without unwinding
analogix_dp_bind()?

  Fixes: 99a49ff5ef7a ("drm/bridge: analogix_dp: Apply drm_bridge_connector=
 helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D13
