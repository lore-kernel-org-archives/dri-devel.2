Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtShAvg+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1AA10FF0D;
	Thu, 12 Nov 2026 01:58:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C2110FF0C;
 Thu, 12 Nov 2026 01:58:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD88543EBB;
 Thu, 12 Nov 2026 01:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C9D1F00A08;
 Thu, 12 Nov 2026 01:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448701;
 bh=GG37Y5dBJRMLPIhEE7Led8Ih87D3YydirPs9fUqIX/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KtShAvg+6rLkk2PJbGv29ZMZtKNf7gF5aoXaama9pWt/SC/GsnikgbS90ZVgD8gD0
 Ne+YKRSTDm0sQZ7YaAOwOvL6kBNetM2TaIuBfg3BW/T7aZtPSiXxja+CpQFk3g4b9j
 N0o3X47cm9tAq8IUZ5nJuj2Rmc2wZkHHw3Gv00LGnmODPUBLljwUfbADNrSkTKwLqc
 GFYHGAOMdB+1lBqoICR/qQ3mvlC3553RuPComEbU1wdbFYQxrpne41SN5b+5Thw8JE
 RjcJWFsnYjJRneLKjE+vyKRlTUkEa6mIFcLVok5FRb7AvS4F63vsYpjo2Elo0Lyvd3
 N5metNOJkg+BA==
Message-ID: <sashiko-outbox-210128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 plane/crtc/helpers paths
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-6-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-6-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:58:21 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/amd/display: memory leak in dm_helpers_read_local_edid()
  [1]
--

commit cb81c7873176d93f0193d77abe7f41c76b00d56d
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display/amdgpu_dm: Use DC accessors in plane/crtc/helpers paths

This commit replaces direct struct dc member dereferences with DC
accessor functions across amdgpu_dm_plane.c, amdgpu_dm_crtc.c, and
amdgpu_dm_helpers.c.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3067ac5bb0cd0..02a8cfde9f1aa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c

[ ... ]

> @@ -1291,8 +1294,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  	else
>  		ddc =3D &aconnector->i2c->base;
> =20
> -	if (link->dc->hwss.prepare_ddc)
> -		link->dc->hwss.prepare_ddc(link);
> +	dc_prepare_ddc(link);
> =20
>  	dm_helpers_wait_for_edid_ready(link, ddc);
> =20

[Severity: Medium]
This problem wasn't introduced by this patch, but does
dm_helpers_read_local_edid() leak drm_edid [1] when returning
EDID_BAD_INPUT?

Later in the retry loop, if the raw EDID check or length validation fails,
the function returns without calling drm_edid_free(drm_edid):

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:dm_helpers_read_l=
ocal_edid() {
	...
		if (!edid || !connector->edid_blob_ptr ||
		    connector->edid_blob_ptr->length > sizeof(sink->dc_edid.raw_edid))
			return EDID_BAD_INPUT;
	...
		drm_edid_free(drm_edid);
	...
}

[1] https://sashiko.dev/#/bug/linux-5db7be8c-2e59-46d2-b3bf-37e1b52f73e4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D6
