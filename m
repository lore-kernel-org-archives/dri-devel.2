Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB4AF506CF
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D5C10E51D;
	Mon, 16 Mar 2026 13:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AFYhq0jW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59E410E51D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773667253;
 bh=sDV67PGEmseaRiaBTtJWu4NmBwGs65J+rk5OtufCYmE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AFYhq0jWkCgH0JoGewY61aEU21dhGiR+UwhMDWJGZC5N0v15uWWAD1Y3qkOeU13dC
 zNXyIGs7Acmo1ha2yoruTZyKa5jcRijJAj9Ru+A+O+CNbIPIlcFs94x7HGcquCr90x
 loIgxeIXqGT2E8/OL8ajPhY9UorijYUVZO3qmMVeogORoXjEj2kxLkKzBTEZ1Q/UJA
 yQ/IQkIsZT0pORZaCHhucHAhaJj7NCmzjoTxC0u4rz2ISC3WTSDwBjqOPYho6XeMad
 2Rh2CL+1xjoh0Ux9W0KDo/IB7zET68wykL0Zc8AzAWuvggFQ2zai0xVnH0+sCfQufM
 M0CYea65wQSZg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4414A17E0EF1;
 Mon, 16 Mar 2026 14:20:53 +0100 (CET)
Date: Mon, 16 Mar 2026 14:20:49 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <20260316142049.6dc7093e@fedora>
In-Reply-To: <87aba1c1-55a4-412c-b158-325acb65ae42@suse.de>
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <20260316105043.115ba8a3@fedora>
 <08112162-7939-48b8-be57-790a8686bc46@suse.de>
 <20260316113637.63a5031a@fedora>
 <87aba1c1-55a4-412c-b158-325acb65ae42@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Mon, 16 Mar 2026 13:10:43 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 16.03.26 um 11:36 schrieb Boris Brezillon:
> > On Mon, 16 Mar 2026 11:14:40 +0100
> > Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > =20
> >> Am 16.03.26 um 10:50 schrieb Boris Brezillon:
> >> =20
> >>>> Avoid this race by adding a huge_fault callback to drm_gem_shmem_vm_=
ops so that
> >>>> PMD-sized mappings are handled through the appropriate huge page fau=
lt path. =20
> >> This patch will conflict heavily with the folio-tracking patches that
> >> has been merged into upstream DRM. How do we deal with that? =20
> > We need a fix in drm-misc-fixes since it's a bug that exists in v7.0,
> > and a conflict resolution recorded in drm-tip to deal with the
> > drm-misc-fixes vs drm-misc-next conflicts (I don't remember the exact
> > process, but it's documented in dim). =20
>=20
> I can easily do that when I merge the fix into drm-misc-fixes.=C2=A0 I'd =
only=20
> need the fixed and tested patch that applies to the current=20
> drm-misc-next beforehand.

Let's wait until we've settled on a version we're happy with for
drm-misc-fixes, I can provide a conflict resolution for drm-misc-next
based on this final version.

