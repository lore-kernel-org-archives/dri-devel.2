Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69F2CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AA910E626;
	Tue,  9 Jun 2026 12:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i7D7PMdq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB8E10E61B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:50:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6881342A83;
 Tue,  9 Jun 2026 12:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA4F1F00893;
 Tue,  9 Jun 2026 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781009448;
 bh=H0X3SoK1oDv74Mjvqjo8WMaV4wcVo6OhwA3cHGNGC44=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i7D7PMdqaBIDF3TbInLcOazZMJQ1Ud+pDClDA+t7oVQfBecyGn3A5apaMugpqxkZO
 7DFrF1V6SYHvV0uQI5myMYXarwMC11eBhuNR9sb3uN84iGZ/RspiSgJ75eJW44l/Zd
 eSmEMO9S6IMXN+fbqWn7fzwTMAEicTUgwn15UA97apQQupNr4cFRrFooNE6yZwxISi
 1Zd2sP40BFMwMQXh68ns+s/tpZ6di8nMmMDg0Lt0b+WlME7H/83CF0zu06I92/ae1a
 kvP51MNGR8WEo8wUbCJZJhy0DjLLbblul4tinG6dshmu6KgduliAhA1MG1231kOb82
 xnu6gHjCXbWYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] drm/amd/display: allow individual colorop changes
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-8-mwen@igalia.com>
References: <20260609121230.1358786-8-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:50:47 +0000
Message-Id: <20260609125048.1CA4F1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Potential NULL pointer dereference when accessing `blob->lengt=
h` in `__set_dm_plane_colorop_3x4_matrix` if the data blob is NULL.
--

commit f99935be74382989d52703e3315aeec4d0efd059
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: allow individual colorop changes

Change all colorop helpers to get the committed state if there's no new
state for a given colorop. This allows userspace to modify a single
property of a colorop without resubmitting the whole color pipeline by
falling back to colorop settings from the committed state.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 2d91d88a45742..51bd937153d41 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c

[ ... ]

> @@ -1561,43 +1550,37 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plan=
e_state *plane_state,

[ ... ]

> +	if (colorop_state->bypass) {
> +		dc_plane_state->gamut_remap_matrix.enable_remap =3D false;
> +		dc_plane_state->input_csc_color_matrix.enable_adjustment =3D false;
> +		return 0;
> +	}
> +
> +	drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
> +	blob =3D colorop_state->data;
> +	if (blob->length =3D=3D sizeof(struct drm_color_ctm_3x4)) {

[Severity: Critical]
This is a pre-existing issue, but could this lead to a NULL pointer=20
dereference if the data blob is missing?

If userspace configures a 3x4 matrix colorop with bypass set to false but
doesn't provide a valid data blob, the DRM core might leave colorop_state->=
data
as NULL. Dereferencing blob->length here without checking if blob is valid
would then crash the system.=20

Should __set_dm_plane_colorop_3x4_matrix() explicitly check if blob is not =
NULL
before attempting to access its length?

> +		ctm =3D (struct drm_color_ctm_3x4 *) blob->data;
> +		__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.mat=
rix);
> +		dc_plane_state->gamut_remap_matrix.enable_remap =3D true;
> +		dc_plane_state->input_csc_color_matrix.enable_adjustment =3D false;
> +	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D7
