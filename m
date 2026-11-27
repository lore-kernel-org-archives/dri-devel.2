Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E1606A327
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnFkbc4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC7E1129A5;
	Fri, 27 Nov 2026 10:15:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A6B112984
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA1544505
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6671F000C1;
 Fri, 27 Nov 2026 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774549;
 bh=oA15S41djRxnINuMPkdfggALPMoaT/KDR43EedBUcIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AnFkbc4bK0jNW94KMz7qPu8KQpmFHBdTZn2AA9jg+7zjGUlV3zlAVhwC9MDvYIZkT
 MmNVuOc9EZAeUK5+rgme0ADmLy28cr8xaKRLBLFCjKDU3PqDCAmH9rV7kNogZXvGHG
 jEamyWmsv2NZkOPXg/xkkSOL1D5Ij74ic1aUCam/wxtmN1SQ4SvWkIcAroThgFnJAR
 51vSXsaMI0f2dUequPjSbuGctGwU1GELsu1u6sSH7NBDbG6De+RBMfmYG0iLh0BRq9
 HsbxN2QP2hryQrHHWng7FBPRmTty0o/Jt4RsRfXP5KVsGh2kH4M0JH/oqQc37qQnp7
 Vmdl3VeHxljpg==
Message-ID: <sashiko-outbox-237076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/36] drm/atomic_sro: Provide helpers to implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-12-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-12-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:15:48 +0000
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
- [Low] drm/atomic_sro: missing linux/types.h include in readout helper
  header
--

commit 160ed062541d8710e5efc0797d1320aa912540b0
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Provide helpers to implement hardware state readout

This commit adds KMS helpers to build, install, and read out atomic
hardware state, along with a helper to create a DMA GEM object for a
read-out buffer.

> diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/=
drm_atomic_state_readout_helper.h
> new file mode 100644
> index 0000000000000..315a541412498
> --- /dev/null
> +++ b/include/drm/drm_atomic_state_readout_helper.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef DRM_ATOMIC_SRO_HELPER_H_
> +#define DRM_ATOMIC_SRO_HELPER_H_
> +
> +struct drm_atomic_commit;
> +struct drm_atomic_sro_state;
> +struct drm_device;
> +struct drm_gem_dma_object;
> +
> +struct drm_gem_dma_object *
> +drm_atomic_helper_sro_create_gem_dma_object(struct drm_device *dev,
> +					    dma_addr_t dma_addr, size_t size);

[Severity: Low]
Does this header need to include <linux/types.h> for dma_addr_t and
size_t?  Without it, standalone header compilation under
CONFIG_DRM_HEADER_TEST=3Dy fails with unknown type name errors.  A later
patch in the series, commit "drm/atomic-state-helper: Provide comparison
macros", pulls it in transitively via <linux/string_choices.h>, but the
build fails at this commit and the three following commits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D12
