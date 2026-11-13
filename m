Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59979606A336
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUpubfOB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B21E1126DF;
	Fri, 13 Nov 2026 16:44:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF061126CF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8378D61882;
 Fri, 13 Nov 2026 16:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB46C1F000C4;
 Fri, 13 Nov 2026 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794588237;
 bh=SnrOxxyXskTzj64rBmLghaWVBlsWoyfEZUJsvyzwTTo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YUpubfOB0oRAsMZ3s341lxbZmb4j0K9E06d+SnqZjysJGaLavZed9P3afnULKxnQ+
 xMiJVV0iNVTHqDOnTXwA/90KrRDfH9iSbM9E8Zyuv0LHSQaFq6Oglkb9xO8+oB5F4I
 Xxm6w3f5rj0up5nnUekRnn8eIY8nQonBE10Q5M3bCIvOA8IivLsIE9s5wAdw56bXnf
 aQHFCoGQ7qlmswKIwM9y1tGA9lUDkmMYhUD4mZU/4YjBMazHE8FRagx6FmHPbxgZtx
 49lmcqSk8k7TD5S3HGLK8CVC5lfMJWu2Kcl9pV3kjTax+YPe5P04VTsx+c8nuK24cy
 5aI5j7RA+qvsg==
Message-ID: <sashiko-outbox-213221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/10] staging: media: tegra-video: Move driver to
 media/platform/nvidia
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261113161819.36847-2-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:43:56 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] media: tegra-video: dangling staging path in MAINTAINERS after
  directory move
- [Low] media: tegra-video: incomplete destaging leaves TODO file and
  staging hacks
--

commit a8916ec654eff39d7e3b979839383852a183e987
Author: Svyatoslav Ryhel <clamor95@gmail.com>

staging: media: tegra-video: Move driver to media/platform/nvidia

This commit moves the Tegra Video Input driver from
drivers/staging/media/tegra-video/ to
drivers/media/platform/nvidia/tegra-video/.

> diff --git a/drivers/media/platform/nvidia/Kconfig b/drivers/media/platfo=
rm/nvidia/Kconfig
> index b211b46877f63..53f34308f5aff 100644
> --- a/drivers/media/platform/nvidia/Kconfig
> +++ b/drivers/media/platform/nvidia/Kconfig
> @@ -3,3 +3,5 @@
>  comment "NVidia media platform drivers"
> =20
>  source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
> +
> +source "drivers/media/platform/nvidia/tegra-video/Kconfig"

[Severity: Low]
Should MAINTAINERS also be updated to point to
drivers/media/platform/nvidia/tegra-video/?

The TEGRA VIDEO DRIVER entry in MAINTAINERS still lists
drivers/staging/media/tegra-video/, which causes
scripts/get_maintainer.pl --self-test=3Dpatterns to report a broken file
pattern and prevents get_maintainer.pl from matching the moved files.

[ ... ]

> diff --git a/drivers/staging/media/tegra-video/TODO b/drivers/media/platf=
orm/nvidia/tegra-video/TODO
> similarity index 100%
> rename from drivers/staging/media/tegra-video/TODO
> rename to drivers/media/platform/nvidia/tegra-video/TODO

[Severity: Low]
Should the staging TODO file and remaining staging workarounds be resolved
or removed before moving this driver out of staging?

Renaming drivers/staging/media/tegra-video/TODO leaves an open staging
TODO list (ganged mode, Tegra210 RAW10 packed format support,
suspend/resume, and v4l2-compliance verification) in
drivers/media/platform/nvidia/tegra-video/TODO.  In addition,
tegra20_vi_enable() in tegra20.c still calls ioremap(TEGRA_APB_MISC_BASE,
PAGE_SIZE) on a hardcoded physical address for an unsynchronized
read-modify-write on a shared APB_MISC register, and
__tegra_channel_try_format() in vi.c still calls the internal
__v4l2_subdev_state_alloc() helper with a FIXME noting that drivers must
not use it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161819.3684=
7-1-clamor95@gmail.com?part=3D1
