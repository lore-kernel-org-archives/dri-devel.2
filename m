Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F48CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F61C10E594;
	Tue,  9 Jun 2026 17:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gp02zwOw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA4C10E594
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:53:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF8F260258;
 Tue,  9 Jun 2026 17:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABE81F00898;
 Tue,  9 Jun 2026 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781027636;
 bh=OQzUs9n1Xktnez4S8uJrCM1RCxAgrbQRBMYhq6AxIjI=;
 h=Date:From:To:Cc:Subject;
 b=Gp02zwOwuExUzvYFQ2QVSyf4pEC2lSzxxYcTjkMRiXwApmpGT4JS3asuur+E8Agwk
 u8uUR6HCWJ3hLyB2ScjCRFvmDjrl1iq75eNQWSIJWfwjtnLnWtEYqX72XhOQP7RDkK
 9p4AREIbPCJFTKgk5MU7lOyqTTNNW0Ck9+TFwLtukQ6FoyrpTho5MYB/NwkQatPTcT
 TwEmH5Hgq/rOnCZvYr+8ja9CVatdkzaS+5JBjhSpDCgxag+XIEdmwbPMtbheunm2Tk
 OPpxlmw7FSHg3z6ncR4aLpsxLs2PaqDXk83pnXcnLqN9mTTOlQ7NzW2b+Ef3cKlb65
 KvgAVgYjDIeUQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 876741AC56B7; Tue, 09 Jun 2026 18:53:54 +0100 (BST)
Date: Tue, 9 Jun 2026 18:53:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drm tree
Message-ID: <aihTMkjR4v3MgwFa@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zXPSOvXy5Xj8FJPZ"
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


--zXPSOvXy5Xj8FJPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The following commit is also in the drm-fixes tree as a different commit
(but the same patch):

  01112e241e37f9 ("drm/amdkfd: Unwind debug trap enable on copy_to_user failure")
  0ac98160dfb6ab ("drm/amdgpu/userq: Fix reading timeline points in wait ioctl")
  115bf5ca318e18 ("drm/amd/display: Consult MCCS FreeSync cap only if requested & supported")
  39eb6da7acee8d ("drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS")
  92a8dba246d371 ("drm/amdkfd: fix SMI event cross-process information leak")


--zXPSOvXy5Xj8FJPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmooUzEACgkQJNaLcl1U
h9AIRgf9GVZRxu0fRT+o0GpKvyvnl4bqVl7WxSAK2v62aUwiuDMBvSXedgk9/SgD
vzpDzB+QLxi0LsY+9IUXSIGim3ruAJ81gmo73TcB6YPnDEvXVY5Liqi2syKnk/MY
x+VP4+d392MFmCuw36q8vjfCWPd7XK05K4iJu2PChBQOlEphWo8tLGwwobiZnAGs
4/2avkQDtCQPeQuc4Peapwqb4/41PzXGVO+WWShlysy/Hy5Z+4IQIbOX2CRgKzio
5c62mGGnMqLGLyu+01syXNxCb+/jyQlkERJBgfDAifyXwOpiCjPz2aYOCKSNm7f7
AKoFwWkw4fOLTXU5YJ7Q8p0ALvKOAg==
=QDp+
-----END PGP SIGNATURE-----

--zXPSOvXy5Xj8FJPZ--
