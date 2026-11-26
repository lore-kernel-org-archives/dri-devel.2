Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ep+UVvBM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D574410FE26;
	Thu, 26 Nov 2026 06:43:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C73310FE26
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:43:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D851609F6;
 Thu, 26 Nov 2026 06:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B712D1F000D1;
 Thu, 26 Nov 2026 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675380;
 bh=ED9Xju4A1pN3MiAO2pNjfF53HKhT4ir670uZL96vO5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ep+UVvBMpqS6RpzQ+zfAOlGNfqVwMlalXJyf77S9LLEV7jhlapf8EVY0QNuDYnq1z
 y/AYjAlKvOqB4D3XBzP4iL3d/y5oBIfCcjMjXhghvKzOIlzd+nmQ7OKqPJJD9gBzBd
 APqBkSbcWkTWuM2wGVbkg0OxoOzxRzyYIrvGmqyB74lfxuNc0g31riEM6i5GlOD/Ot
 ZahpqfIbemhmlQrP31XeH7TuLdSSnb2wnJODrAdYF+5y+txhGonNBYMfnxP5YYBfaA
 NBedi2XQEpQ9zAcJx6+e/dAOgxQMjCVL6XloA3MKDhuGB/I/y66riPoOZt485GtiOY
 WTwsiIYQfmRBQ==
Message-ID: <sashiko-outbox-234885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/21] drm/msm/dcp: Add DCP encoder
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-13-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-13-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:42:58 +0000
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
- [Low] drm/msm/dcp: dcp_encoder_init() duplicates
  drmm_plain_encoder_alloc()
--

commit 670fd16befa378857922db7aa3647d8ae8930c7c
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP encoder

This commit adds dcp_encoder_init() to allocate and initialize a DRM
encoder connecting a DCP CRTC to its output bridge.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/=
dcp/dcp_encoder.c
> new file mode 100644
> index 0000000000000..e7a64c960bdc9
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP encoder wrapper for the CRTC-to-bridge connection.
> + * Hardware programming and mode sequencing are handled by the bridge an=
d HFI.
> + */
> +
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_managed.h>
> +
> +#include "dcp_encoder.h"
> +
> +struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_typ=
e)
> +{
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder =3D drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D drmm_encoder_init(dev, encoder, NULL, enc_type, "encoder%d",
> +				dev->mode_config.num_encoder);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return encoder;
> +}

[Severity: Low]
This isn't a bug, but dcp_encoder_init() open-codes
drmm_plain_encoder_alloc(), which already allocates and initializes a
non-subclassed struct drm_encoder in a single call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D13
