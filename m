Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437FCCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6C210FDEA;
	Wed, 14 Oct 2026 15:01:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA7810E96B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8CB142436;
 Wed, 14 Oct 2026 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49401F000C4;
 Wed, 14 Oct 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791990087;
 bh=uQtNw5apxFTSDYwVirEsr/tZDEYPYvkyMkL/ct4mmQc=;
 h=Date:From:To:Cc:Subject;
 b=Gy/tEyE1a95dvOF8JXe+mDWJcHZ21YgpcolKMv1cBfqrCENMwATaKfgHdA9Fw+1c0
 NrPhXeODEN5Wu9COlFD4fZSks/OeOq+FFVbXkBip29GiP+0gqC4HjmL9Saiw31+y8j
 0ipRqku1wrj/96PvrY97AsN3abH05oHFJ2ur7bYI5hrYUyNwnpgOISldMHDcOUfFkO
 eSu4hSHC7j+BpiM3SYSNvmweIAATH9Au0p3Txvin27QWoJ4Xqh9Vbj/FbHCa2fAL1u
 W++RNODVv0qBTjNHEJvs8JLs6hn/YPjkgC8E1KX/41XAoVwBqqz4GlfC4EE0pW3o0n
 QE/xjlOGfpIFg==
Date: Wed, 14 Oct 2026 16:01:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the modules tree with the drm tree
Message-ID: <as-ZQxI6N4rR0qNN@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jh4TGVSxnZtLjnkx"
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


--Jh4TGVSxnZtLjnkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  drivers/gpu/drm/clients/drm_fbdev_helper.c

between commit:

  6ccc5b5fc1d36 ("drm/fbdev: Move fbdev helpers into client library")

=66rom the drm tree and commit:

  df2908090cda3 ("Linux 7.3-rc2")

=66rom the modules tree.  I think.  It looks like git got confused by the
backmerge of v7.3-rc2 and the file move somehow, I can't actually see
any relevant commits in the modules tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/clients/drm_fbdev_helper.c
index af8f15c947f03,36009bb02c257..0000000000000
--- a/drivers/gpu/drm/clients/drm_fbdev_helper.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_helper.c
@@@ -31,10 -31,11 +31,11 @@@
 =20
  #include <linux/console.h>
  #include <linux/export.h>
+ #include <linux/stringify.h>
 =20
 +#include <drm/clients/drm_fbdev_helper.h>
  #include <drm/drm_atomic.h>
  #include <drm/drm_drv.h>
 -#include <drm/drm_fb_helper.h>
  #include <drm/drm_fourcc.h>
  #include <drm/drm_framebuffer.h>
  #include <drm/drm_gem_framebuffer_helper.h>

--Jh4TGVSxnZtLjnkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPmUIACgkQJNaLcl1U
h9ARHgf/Wc4xGw4DOU0BgcqwcQ6fj1Vw9MhZbqMRCXKMTGF3WxTxdO/GUfEJ0u6F
IC98G54BG/9T1xJX2TOI3qIOso/wdqpzgJR4eVlZxIsM8jZqiOYvobp+iVa2iJCI
cFi44pYUkDpGUb3Z11xTkPCsltkbqlaGv+7utrkkmGbZ61cmCJTxGhOklkOUGjWn
gT0EYj2/B5c8srP0XgvdlbAP6+R+L0PJeCEEPEpSLZIpL84zWjGyixv/lervY7jf
GILs5pBKneV34kmlQuEE06gd8sN1Y3i2i9+vM27PK1in7gBhFhWBFATyq6bYMomN
AznPbYsdofreA6tCSWCqSFAw3+QmMg==
=KWN0
-----END PGP SIGNATURE-----

--Jh4TGVSxnZtLjnkx--
