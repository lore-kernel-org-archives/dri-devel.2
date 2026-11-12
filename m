Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69F606A8A4
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCBoQR6s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F43910E36C;
	Thu, 12 Nov 2026 02:01:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1062910FF14;
 Thu, 12 Nov 2026 02:01:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32C8C614A1;
 Thu, 12 Nov 2026 02:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53641F00A05;
 Thu, 12 Nov 2026 02:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448899;
 bh=6LqtdZIUauJFFwXkth9uK/99vO4VQKkwoGAcOqY/eK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HCBoQR6sjIbI7uRrQsQwHydP88w80jelqIcQHkU/g/HykpwVk0Wx7iJQ+GsbtRs3x
 Ig45cCfk3VxMFsCSq+ca8AgjrhihIPq5iBG+40aVkazAbXaOAJuidvgWEuF4SmSrOb
 suevn/RE2rmI+FlAyys/sesD9sy0kbEJPdF8N98zHd8SXI8Dg5Dmu9U256dGtazw1/
 SMMPGGDrGsEI9fWYFR6G5SCoTA1Ol241RaKKDPykfD1XbcQTTyk7FuW7GeUpXBAQOe
 x5PL/gHrUTfQ0Su4dBKZkqR6VjH2QNc9MNYrGY2gEvkGBJDxM5Al+H0mv4VQ7W2foe
 nkVfsxd9rH1Ww==
Message-ID: <sashiko-outbox-210136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/19] drm/amd/display: Add DC primitives for ABM
 hardware programming
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-16-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-16-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:01:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd/display: dc_dmcu_is_initialized() duplicates
  dc_is_dmcu_initialized()
--

commit 73f1ba49a5d9e363674e88529801b1a9200d901c
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display: Add DC primitives for ABM hardware programming

This commit adds DC-side hardware primitives for DMCU iRAM loading and ABM
configuration and event programming so that modules/power and amdgpu_dm no
longer access struct resource_pool directly.

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_abm.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_abm.c
> new file mode 100644
> index 0000000000000..1ed4b5fb6f937
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_abm.c
> @@ -0,0 +1,121 @@

[ ... ]

> +bool dc_dmcu_is_initialized(struct dc *dc)
> +{
> +	if (!dc->res_pool || !dc->res_pool->dmcu)
> +		return false;
> +
> +	return dc->res_pool->dmcu->funcs->is_dmcu_initialized(
> +			dc->res_pool->dmcu);
> +}

[Severity: Low]
Does dc_dmcu_is_initialized() duplicate the existing dc_is_dmcu_initialized=
()
helper?

drivers/gpu/drm/amd/display/dc/core/dc.c:dc_is_dmcu_initialized() {
	struct dmcu *dmcu =3D dc->res_pool->dmcu;

	if (dmcu)
		return dmcu->funcs->is_dmcu_initialized(dmcu);
	return false;
}

dc_is_dmcu_initialized() is already declared in dc.h and has no other calle=
rs
in the tree, so these two public helpers could be consolidated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D16
