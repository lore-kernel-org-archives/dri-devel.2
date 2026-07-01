Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1BE10E2F2;
	Wed,  1 Jul 2026 03:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="pn7KZioB";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BF010E2F2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 03:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:To:From:Date:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=nApW0TbiTJY7J1m6P34EZWWiq5RdRdYwQqXDhkOn3wI=; b=pn7KZioBdcGJCWEiOF2drr9WrU
 Rsyjet+cONr5A88PON0hzE0H7TwZSG+Y88HyF05ArHZOE7RuERs2NzCxWfvSYVfX6i9e14cnIRAgc
 VDRXVtX10rKfVZesUl00lO3v6VdXQ+gKeCQwuy2nl3ChRZIePUU3hRNsKAXc+h89HQw4WqUlQtwZI
 b6RbHhw/IJ0+z/LAE+ApSYqKZJB6De/xeEH/8lfut0o10m2rBBJAkpGDtBbvHA7Ij2WAOsd0jxsiT
 H2gxcNKTA7dG1JYevQGS7xHyaZWih3Z+kfQlVLra6J46tpAFirLY7nCuM1SYkSsv8R70RD+nWKJ+G
 9FD+Lj2w==;
Received: from [129.95.232.135] (helo=ehlo.thunderbird.net)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1welvN-00000005x0N-1gwI; Wed, 01 Jul 2026 03:47:45 +0000
Date: Tue, 30 Jun 2026 20:47:41 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: Baran Tuna <barant@fastmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix typos under GPU TODO
User-Agent: K-9 Mail for Android
In-Reply-To: <20260701025233.594162-1-barant@fastmail.com>
References: <20260701025233.594162-1-barant@fastmail.com>
Message-ID: <01433E06-1132-4580-93FD-D6E82341A041@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

On June 30, 2026 7:52:33 PM PDT, Baran Tuna <barant@fastmail=2Ecom> wrote:
>Fix minor spelling mistakes in GPU TODO section of documentation=2E
>No functional changes=2E
>
>Signed-off-by: Baran Tuna <barant@fastmail=2Ecom>
>---
> Documentation/gpu/todo=2Erst | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/gpu/todo=2Erst b/Documentation/gpu/todo=2Erst
>index cdddf8db35f5=2E=2E3b9999319829 100644
>--- a/Documentation/gpu/todo=2Erst
>+++ b/Documentation/gpu/todo=2Erst
>@@ -55,7 +55,7 @@ There are still drivers that use drm_simple_display_pip=
e=2E The task here is to
> convert them to use regular atomic helpers=2E Search for a driver that c=
alls
> drm_simple_display_pipe_init() and inline all helpers from drm_simple_km=
s_helper=2Ec
> into the driver, such that no simple-KMS interfaces are required=2E Plea=
se also
>-rename all inlined fucntions according to driver conventions=2E
>+rename all inlined functions according to driver conventions=2E
>=20
> Contact: Thomas Zimmermann, respective driver maintainer
>=20
>@@ -278,7 +278,7 @@ Various hold-ups:
>   valid formats for atomic drivers=2E
>=20
> - Many drivers subclass drm_framebuffer, we'd need a embedding compatibl=
e

   an embedding

Otherwise LGTM=2E

Acked-by: Randy Dunlap <rdunlap@infradead=2Eorg>
Thanks=2E

>-  version of the varios drm_gem_fb_create functions=2E Maybe called
>+  version of the various drm_gem_fb_create functions=2E Maybe called
>   drm_gem_fb_create/_with_dirty/_with_funcs as needed=2E
>=20
> Contact: Simona Vetter
>@@ -303,7 +303,7 @@ everything after it has done the write-protect/mkwrit=
e trickery:
>=20
>       vma->vm_page_prot =3D pgprot_wrprotect(vma->vm_page_prot);
>=20
>-- Set the mkwrite and fsync callbacks with similar implementions to the =
core
>+- Set the mkwrite and fsync callbacks with similar implementations to th=
e core
>   fbdev defio stuff=2E These should all work on plain ptes, they don't a=
ctually
>   require a struct page=2E  uff=2E These should all work on plain ptes, =
they don't
>   actually require a struct page=2E
>@@ -891,7 +891,7 @@ Querying errors from drm_syncobj
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The drm_syncobj container can be used by driver independent code to sign=
al
>-complection of submission=2E
>+completion of submission=2E
>=20
> One minor feature still missing is a generic DRM IOCTL to query the erro=
r
> status of binary and timeline drm_syncobj=2E


~Randy
