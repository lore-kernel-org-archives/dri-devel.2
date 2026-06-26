Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836AE10F633;
	Fri, 26 Jun 2026 13:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IsZG0p1K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D441D10E397
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 803E841238;
 Fri, 26 Jun 2026 13:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2131F000E9;
 Fri, 26 Jun 2026 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782481705;
 bh=M0DY0NZiKdSwJFeKBUrJJCO5UPSjm4/y4LFJ02pAHys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IsZG0p1K8YxD4G6sauClb2Je8zXCq9KUk+ut7uRR7GxsueAij0x6xailIjXj45C8e
 8XWBLCclf2UdeFaz0aopRAH8N3xh4GztvHWZQifg5XqTX8KBe6oACwLu4BQdF42eR6
 iZdO9SrupqvbWomqy4pZ2dsaEM9heGIjtrbNA+TdXruHatDIIzNWXlviGgGb2GkRJh
 352W9ueR6nQ4qYYqjX4sAcJ1F/fmDPjVv2RBZyFPPcVnYGq7ZShZZjrCsa2K8EYXR3
 yAFO0P+pB/cQjwScdJjnNTZBgHDjplAYXZjx+kL72bDS999nfh4mRDpVdvikd2ce87
 x6vhfLR73jpaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Fix dangling pointers in state
 reset functions on allocation failure
To: "Evgenii Burenchev" <evg28bur@yandex.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133859.21492-1-evg28bur@yandex.ru>
References: <20260626133859.21492-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:48:24 +0000
Message-Id: <20260626134825.2F2131F000E9@smtp.kernel.org>
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
- [Medium] The old connector state memory is leaked during a successful con=
nector reset in `amdgpu_dm_connector_funcs_reset()`.
--

commit 48ece48fead57764b257711d256ed0e86eefc3c4
Author: Evgenii Burenchev <evg28bur@yandex.ru>
Subject: drm/amd/display: Fix dangling pointers in state reset functions on=
 allocation failure

This patch addresses dangling pointers in AMD display state reset functions=
 by
allocating new state structures before destroying the old ones.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eb5696b5daeb7..c7fe28758e962 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8151,33 +8151,35 @@ static void amdgpu_dm_connector_destroy(struct dr=
m_connector *connector)
> =20
>  void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  {
> -	struct dm_connector_state *state =3D
> -		to_dm_connector_state(connector->state);
> -
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> -
> -	kfree(state);
> +	struct dm_connector_state *state;
> =20
> +	/* Allocate new state first */
>  	state =3D kzalloc_obj(*state);
> +	if (WARN_ON(!state))
> +		return;
> =20
> -	if (state) {
> -		state->scaling =3D RMX_OFF;

[ ... ]

> +	/* Destroy old state only after successful allocation */
> +	if (connector->state)
> +		__drm_atomic_helper_connector_destroy_state(connector->state);
> =20
> -		__drm_atomic_helper_connector_reset(connector, &state->base);
> +	/* Let DRM core install the new state */
> +	__drm_atomic_helper_connector_reset(connector, &state->base);

[Severity: Medium]
Does this code leak the old connector state memory?

The original code explicitly called kfree(state) after calling
__drm_atomic_helper_connector_destroy_state(connector->state). The new
implementation removes this kfree() call.

Looking at __drm_atomic_helper_connector_destroy_state(), it only cleans up
references to nested DRM objects (like CRTCs or properties) but does not fr=
ee
the connector_state structure itself. When __drm_atomic_helper_connector_re=
set()
then overwrites connector->state with the new pointer, it appears to
permanently orphan the old memory.

Should the old state memory be explicitly freed here as it was previously?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133859.2149=
2-1-evg28bur@yandex.ru?part=3D1
