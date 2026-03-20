Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBB51098787
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD4F10EAFE;
	Fri, 20 Mar 2026 14:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PaSa7CVO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A9010EAFE
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:17:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 141D2409D1;
 Fri, 20 Mar 2026 14:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7DCC4CEF7;
 Fri, 20 Mar 2026 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774016271;
 bh=fyE92RrNSjFykE3xg3omHI7o5AaRXCfOVEYitwt+Jco=;
 h=Date:From:To:Cc:Subject:From;
 b=PaSa7CVOs9YElTSyhaoDDnAWYJJ9soyEwzI1uYditKXqOCSaRe0YZseUUKX+C+wpa
 xmzYMuGw90rSODetsZ6TjdGixAo7vXn5B7wAjEzKxbRwEF6qMh+YITJCOHSnInVvh8
 UClVbfORuAU6f2KSXBy47a150+qmrRRZ4qAkM3Nqs4hh0LTVg+Pm9owkT8PDZVwrI3
 UgcguxCOdIB7QVQ+ushUq4XeomHpdvdyEc17LYkAwP+ehi6qqwkehewshEfeJf71Ik
 1vFKfnahiAVAPMQGc/iEgTzXXAN3RSq7TyzO6mHC7RDZLn5PHt8TZ5aOyo9ZXvdIV+
 4rrjUR7+q8bIw==
Date: Fri, 20 Mar 2026 14:17:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <ab1XClKfaCMYzg5-@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EP0MMgVQ6S74X9GM"
Content-Disposition: inline
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


--EP0MMgVQ6S74X9GM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/drm_gem_shmem_helper.c

between commit:

  fc3bbf34e643f ("drm/shmem-helper: Fix huge page mapping in fault handler")

=66rom the drm-misc-fixes tree and commits:

  5cf8de6cd1620 ("drm/gem-shmem: Return vm_fault_t from drm_gem_shmem_try_m=
ap_pmd()")
  06f3662cb3ba9 ("drm/gem-shmem: Refactor drm_gem_shmem_try_map_pmd()")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/drm_gem_shmem_helper.c
index c549293b5bb61,4500deef41278..0000000000000
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@@ -550,27 -554,23 +554,23 @@@ int drm_gem_shmem_dumb_create(struct dr
  }
  EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 =20
- static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
- 				 unsigned long pfn)
+ static vm_fault_t drm_gem_shmem_try_insert_pfn_pmd(struct vm_fault *vmf, =
unsigned long pfn)
  {
- 	if (!order) {
- 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
- 	} else if (order =3D=3D PMD_ORDER) {
- 		unsigned long paddr =3D pfn << PAGE_SHIFT;
- 		bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~PMD_MASK);
+ 	unsigned long paddr =3D pfn << PAGE_SHIFT;
+ 	bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~PMD_MASK);
 =20
- 		if (aligned &&
- 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
- 			pfn &=3D PMD_MASK >> PAGE_SHIFT;
- 			return vmf_insert_pfn_pmd(vmf, pfn, false);
- 		}
- #endif
+ 	if (aligned && pmd_none(*vmf->pmd)) {
+ 		/* Read-only mapping; split upon write fault */
+ 		pfn &=3D PMD_MASK >> PAGE_SHIFT;
+ 		return vmf_insert_pfn_pmd(vmf, pfn, false);
  	}
- 	return VM_FAULT_FALLBACK;
+ #endif
+=20
+ 	return 0;
  }
 =20
 -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 +static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned =
int order)
  {
  	struct vm_area_struct *vma =3D vmf->vma;
  	struct drm_gem_object *obj =3D vma->vm_private_data;
@@@ -644,13 -645,29 +650,32 @@@ static void drm_gem_shmem_vm_close(stru
  	drm_gem_vm_close(vma);
  }
 =20
+ static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
+ {
+ 	struct vm_area_struct *vma =3D vmf->vma;
+ 	struct drm_gem_object *obj =3D vma->vm_private_data;
+ 	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
+ 	loff_t num_pages =3D obj->size >> PAGE_SHIFT;
+ 	pgoff_t page_offset =3D vmf->pgoff - vma->vm_pgoff; /* page offset withi=
n VMA */
+=20
+ 	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >=3D num_pages))
+ 		return VM_FAULT_SIGBUS;
+=20
+ 	file_update_time(vma->vm_file);
+=20
+ 	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
+=20
+ 	return 0;
+ }
+=20
  const struct vm_operations_struct drm_gem_shmem_vm_ops =3D {
  	.fault =3D drm_gem_shmem_fault,
 +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 +	.huge_fault =3D drm_gem_shmem_any_fault,
 +#endif
  	.open =3D drm_gem_shmem_vm_open,
  	.close =3D drm_gem_shmem_vm_close,
+ 	.pfn_mkwrite =3D drm_gem_shmem_pfn_mkwrite,
  };
  EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 =20

--EP0MMgVQ6S74X9GM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm9VwkACgkQJNaLcl1U
h9C9Awf+Lzvqx1wZE8b+Udz9D0//H0GIa6xfZUdVZGlUNTSlE49SF5/I5luFWa10
oEYbjghiKwRcUAVEvdJjSU5dVAoAemjibpy+9LHBwFaGTs6O4zTwO5V7m7PN7Ifp
GaCfHZwnEuKjvTC0dzKC2ej+L6CVLM9Y/oBuEL4hLq6XW3rlY2YY1O22mtdYod7e
IPzKJ29l9GSexAsiy8CzntJ70PQEIdOtmrcK5xo8Rw+0Vz3G6ZZWVzBalD76Pop/
yf9IVY0pyTJdpVocj5g9vyfoMecHSjhI8rDcmmjPOPJNU2IJRtc4zJh6YHHblk1e
byWpHP+lHIjgGwXziwHpo4bFQavZsw==
=ZAkP
-----END PGP SIGNATURE-----

--EP0MMgVQ6S74X9GM--
