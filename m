Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxk6waz4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CFE10FF1F;
	Thu, 12 Nov 2026 02:08:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CF410FF1F;
 Thu, 12 Nov 2026 02:08:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8020F407C2;
 Thu, 12 Nov 2026 02:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14C1F00A05;
 Thu, 12 Nov 2026 02:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794449310;
 bh=NjJYnEwSClwlE54XxxXPI2D3zCxmTw7mBZJ1ydMSwQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gxk6waz4pPEWEkjWPS4rA+9moz1c+mTQ1E+HMv8gp++EvuOuyHZXrq0SfMNw0llSX
 paSDpYNUN0ghxKreQrvVagsqqUKMZEM8CdZa+LfLnS8NP/vaAq4WhFIIohA37p2NgX
 Zs8AjssDtWjhE31ikv2tOkqWOBQDDqcmuI2lXktRkYp/gyQD0e+Ht/RKd1JsRBC2BB
 6p2vgq2t4n40JRTuu4WfIg3EVNe6u3ej9N/WinWvxEPkIfiFF4ki0MAtslReMNKKNR
 LUKcihL2dLOQ2YsONRa1eeiRc9CL3s9ROZwB9pJG/RyUFWgRPzASwprvJBo/sIoux7
 3/oN32bgubPFQ==
Message-ID: <sashiko-outbox-210155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/19] drm/amd/display: Restrict the dc directory root
 to DC-internal builds
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-14-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-14-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:08:29 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: build failure with CONFIG_DRM_AMD_DC=3Dn due to
  missing dc/inc path
- [Medium] drm/amd/display: dc root include flag left in
  amdgpu_dm/Makefile
- [Low] drm/amd/display: stale dc.h path in display-manager.rst
  kernel-doc directives
--

commit a3254d30f8e563b4854ad67277856c56f8a96107
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display: Restrict the dc directory root to DC-internal builds

This commit moves public headers from drivers/gpu/drm/amd/display/dc/ into
drivers/gpu/drm/amd/display/dc/inc/ and restricts the dc root include path
to DC-internal objects.

> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 8687afc00c24c..55c89f8d764e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -39,7 +39,6 @@ ccflags-y :=3D -I$(FULL_AMD_PATH)/include/asic_reg \
>  	-I$(FULL_AMD_DISPLAY_PATH) \
>  	-I$(FULL_AMD_DISPLAY_PATH)/include \
>  	-I$(FULL_AMD_DISPLAY_PATH)/modules/inc \
> -	-I$(FULL_AMD_DISPLAY_PATH)/dc \
>  	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
>  	-I$(FULL_AMD_PATH)/amdkfd \
>  	-I$(FULL_AMD_PATH)/ras/ras_mgr

[Severity: High]
Does removing -I$(FULL_AMD_DISPLAY_PATH)/dc without replacing it with
-I$(FULL_AMD_DISPLAY_PATH)/dc/inc break the build when CONFIG_DRM_AMD_DC is
disabled?

-I$(FULL_AMD_DISPLAY_PATH)/dc/inc/ is only added in
drivers/gpu/drm/amd/display/Makefile, which is included conditionally on
CONFIG_DRM_AMD_DC.  However, drivers/gpu/drm/amd/amdgpu/amdgpu.h
unconditionally includes dm_pp_interface.h and amdgpu_dm.h, which pull in
dm_services_types.h, os_types.h, dc_types.h, irq_types.h, and dm_services.h
that this patch moves into dc/inc/.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/am=
d/display/dc/Makefile
> index 440f5d3581887..c0fc7f7d241d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -98,3 +98,13 @@ endif
> =20
>  AMD_DISPLAY_FILES +=3D $(addprefix $(AMDDALPATH)/dc/, $(FILES))
> =20
> +# The dc directory root holds private headers (dc_priv.h and friends) th=
at
> +# must not be reachable outside DC, so the global include path deliberat=
ely
> +# stops at dc/inc. DC-internal objects still need the root on their incl=
ude
> +# path for the many "subdir/header.h" includes inside DC, so add it per
> +# object instead of through a global ccflags-y entry.
> +DC_INTERNAL_OBJS :=3D $(filter $(AMDDALPATH)/dc/%,$(AMD_DISPLAY_FILES))
> +$(foreach obj,$(DC_INTERNAL_OBJS),\
> +	$(eval CFLAGS_$(obj) +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc))
> +
> +

[Severity: Medium]
Does drivers/gpu/drm/amd/display/amdgpu_dm/Makefile still export the dc
root include path globally?

The commit message notes that -I$(FULL_AMD_DISPLAY_PATH)/dc is removed from
amdgpu_dm/Makefile, but that file is not modified by this patch and still
has:

drivers/gpu/drm/amd/display/amdgpu_dm/Makefile:
    subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc

Because drivers/gpu/drm/amd/display/Makefile includes amdgpu_dm/Makefile in
the top-level amdgpu build, Kbuild adds subdir-ccflags-y to KBUILD_CFLAGS
for all objects in amdgpu, amdgpu_dm, DAL modules, and tests, leaving
dc_priv.h and other dc root headers reachable outside DC.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/inc/dc.h
> similarity index 99%
> rename from drivers/gpu/drm/amd/display/dc/dc.h
> rename to drivers/gpu/drm/amd/display/dc/inc/dc.h

[Severity: Low]
Should Documentation/gpu/amdgpu/display/display-manager.rst also be updated
for the new path of dc.h?  It has two kernel-doc directives that still
reference drivers/gpu/drm/amd/display/dc/dc.h, which will cause htmldocs
builds to fail to locate the file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D14
