Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314BF419B6
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE52410E227;
	Wed, 15 Apr 2026 13:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ot7O03LK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544C210E227
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776260476;
 bh=PpKzSxbMvOFeZ/D9zHre+b0V+NnMpkVr14gy4+ImPkY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ot7O03LK+EzhNbNVQYM+2QKL0nVzEVuFWTH/OD2YDi0+Ujb3reLdvuR9lAxeSuYbR
 hVURI7n28easwEHcDrUKM6is2EMHaDW7ZUUU9h8rALj6GVV2EoLrm9+jMAkDm0aSQG
 st6vIHy4Nj9xrdOu4w+w3H9wWTgKL1LXrzzTMIyV+jy/UOFecBoispxmkHR4IsIA0+
 K8MLwAIUdm1LO56n/btJuFAASWA2B0tGaNKlre8L13AzsCGLCew+Vok7iAnqAPGkmb
 KCcg+pxe1IL0hIYSycE195QU90aUCE8T5Opu7BRARnkwOBAeEkx16qukpkY5xVu7PT
 i834XhbwbTzvw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4787817E1166;
 Wed, 15 Apr 2026 15:41:16 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:41:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Liviu
 Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v7 3/6] drm/panthor: Delete spurious whitespace from
 uAPI header
Message-ID: <20260415154112.0c472785@fedora>
In-Reply-To: <20260415112900.681834-4-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-4-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 15 Apr 2026 12:28:47 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> There's no extra blank line after the last member of any other uAPI
> structures, so delete it.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  include/uapi/drm/panthor_drm.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index dc2704fc2829..42c901ebdb7a 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -677,7 +677,6 @@ struct drm_panthor_vm_bind_op {
>  	 * This array shall not be empty for sync-only operations.
>  	 */
>  	struct drm_panthor_obj_array syncs;
> -
>  };
> =20
>  /**

