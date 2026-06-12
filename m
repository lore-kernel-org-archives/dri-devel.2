Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F69CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3553710F657;
	Fri, 12 Jun 2026 18:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GpDmB1Lz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5286310F657
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:44:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B7BE43405;
 Fri, 12 Jun 2026 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CC1F00A3A;
 Fri, 12 Jun 2026 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781289858;
 bh=NGGyYPvZKhfJWH1ghv7K9nFMhvSw06uy95Z4ZOpDoTk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GpDmB1LzlcbJgQn9cNnO57JWIMDeDFssNh7KnkHUGDvu8RaovIht1xDJmOQAywWkO
 HHjYLYqUwpdidDFdqKVLj2nhl6r4iN4x5JueyJ2VN1m/BnBPIcS/umTkty2QDpR20z
 yWz587lufpByvSioO+dz8eHe8B6cY8UaSAY23pmj2YrgjjJpO5b1XMGzApI+e8egH5
 5htVUy/cpW3reEl1+WBvbb5E64Zwrm71PdCXfG7hc+/PEum6CXlrQa1AFmr0YuwyFc
 z302BsGSHVLxQ+IEysolVt6z1IyifrDH91OwFh2FjEVAyJ52e61XBSPB93dnMwavT8
 E8GFULTR2+vAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] drm/amd/display: use drmm allocation for
 writeback connector
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:44:17 +0000
Message-Id: <20260612184417.D34CC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Compilation error due to missing argument in drmm_kfree().

Pre-existing issues:
- [High] Use-After-Free of `aencoder` and `aconnector` on error path.
--

commit 0f53c9b8f894290640afe2ed4a23503b2ea87d24
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/amd/display: use drmm allocation for writeback connector

Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 97ab1e83b3186..638335ff7d019 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -5874,7 +5875,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
> =20
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback conn=
ector\n");
> -				kfree(wbcon);
> +				drmm_kfree(wbcon);

[Severity: Low]
Does this code fail to compile?  Looking at include/drm/drm_managed.h, the
function drmm_kfree() requires both a drm_device pointer and the data point=
er,
but it is being called with only the data pointer here.

[Severity: High]
This isn't a bug introduced by this patch, but can the fail block in
amdgpu_dm_initialize_drm_device() trigger a use-after-free during teardown?

If amdgpu_dm_encoder_init() succeeds, the encoder is registered to the DRM
core list.  If a subsequent step fails, the code jumps to the fail block:

fail:
        kfree(aencoder);
        kfree(aconnector);

        return -EINVAL;

Since the encoder remains registered in the DRM subsystem, will
drm_mode_config_cleanup() later traverse the list and call the destroy hook,
resulting in a double-free of the encoder?

>  				continue;
>  			}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D2
