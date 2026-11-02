Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BF606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2Xvax5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F8410E606;
	Mon,  2 Nov 2026 10:27:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA6F10E606;
 Mon,  2 Nov 2026 10:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 207AB404D9;
 Mon,  2 Nov 2026 10:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72441F00A18;
 Mon,  2 Nov 2026 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793615267;
 bh=JUaK/AQp2n0HoKgaX2Glf8rq4/z4664NSSITmzx2Ff8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A2Xvax5w7dSR3ioJZVr2bNooYFSFbvyrnspniJ6ny3IZgF3IaHA6cJBFNhkE0kpTk
 KLhJU/cNPHnbN9QP51gNlcfpaX16KQUxfKPZPrXqCm97WoGh2YRus9gkZqT3hNQC42
 cyg+5jiBs4UhpOlhtOR4fhYw1it5O5OfRjB2yunadHw5xyC+S+lpkMttPlFoMzOKKk
 eyjl7dlyhjj44XsQBCLkIpD9U/i1HvAhQuY2+NGPWlSj8TuDiEKGxDLOtjA1SoOlPQ
 fG0rXPpV271w8lknIgZAkTAv3uo845ecbPMjr6P8QyX+wzsCnj5J5q8VBc7fCQJ2OB
 6O0TtBKcqvqtg==
Message-ID: <sashiko-outbox-193256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 6/7] drm/xe/uapi: Add GEM_CREATE NUMA node placement property
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261102101803.455921-15-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-15-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:27:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/xe/uapi: inaccurate comment and missing kernel-doc for NUMA_NOD=
E property
--

commit 3afc5386219df9a82a534e249ba21444e34868d6
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/xe/uapi: Add GEM_CREATE NUMA node placement property

This commit adds the DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE property to
struct drm_xe_gem_create so userspace can specify the host NUMA node for
system-memory buffer objects.

> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 578f0c1eb43e8..0b39081330eeb 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -843,6 +843,13 @@ struct drm_xe_device_query {
>  struct drm_xe_gem_create {
>  #define DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY	0
>  #define   DRM_XE_GEM_CREATE_SET_PROPERTY_PXP_TYPE	0
> +	/*
> +	 * Host NUMA node (as a signed value) to allocate system-memory
> +	 * backing pages from. Only honored for objects with a system-memory
> +	 * placement; ignored for VRAM-only objects. Use a value < 0 to keep
> +	 * the default device-local placement.
> +	 */
> +#define   DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE	1

[Severity: Low]
In the follow-up commit ("drm/xe/uapi: Wire up GEM_CREATE NUMA node placeme=
nt
handler"), gem_create_parse_numa_node() in drivers/gpu/drm/xe/xe_bo.c checks
whether XE_BO_FLAG_SYSTEM is set and returns -EINVAL when a non-negative NU=
MA
node is requested on a VRAM-only BO, rather than ignoring the property. Sho=
uld
this comment say that specifying a NUMA node is rejected for VRAM-only obje=
cts
instead of ignored?

Also, struct drm_xe_gem_create documents its
DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY properties in the kernel-doc comme=
nt
block above the struct definition alongside
DRM_XE_GEM_CREATE_SET_PROPERTY_PXP_TYPE so that they are included in
Documentation/gpu/driver-uapi.rst. Should the description for
DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE be moved into that kernel-doc list
above struct drm_xe_gem_create?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102101803.4559=
21-9-himal.prasad.ghimiray@intel.com?part=3D6
