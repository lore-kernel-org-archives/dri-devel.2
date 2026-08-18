Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52417C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A54110E43A;
	Tue, 18 Aug 2026 15:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="irfFaYh4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A39610E42B;
 Tue, 18 Aug 2026 15:42:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 596F043277;
 Tue, 18 Aug 2026 15:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0FD1F000E9;
 Tue, 18 Aug 2026 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787067764;
 bh=ep8WVW5wggj4SjcnlOIIohjCQvEimQ4ZMdS3UobKK5g=;
 h=Date:From:To:Cc:Subject;
 b=irfFaYh4/6PiYkf9+J5Cmr9pLjxq/T7mvuokI0saQlyhZt9zEM2cPDaTu+62IxIMd
 7voHznNDPhl9AjNsYmrCFbIgfr8cw0GI6HUSPoq9pR2FZMatKGwGo0PJjf8ztusPPm
 MIdeWydAIMGios9Nwiqg7KaXUqyfRyMYIlBEfYoPoOkibSbN2TZG7oSogVPZCvjyEs
 GgTuPO1e0Xqu0Ql+FAnlLvBjqR4UbmOI6L9khSg3WzjMbVhy06o85mpFwniOnTfQNz
 VyY7y8qlQIh8HUN0jV+LeUK/fk/u51dmdsjNqj5cxS+fdWmyRLh8CZkDao5nIKnDoH
 tQQNLbWjd2SBg==
Date: Tue, 18 Aug 2026 16:42:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm-intel tree
Message-ID: <aoR9bznCkJHwK4DY@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ytBpLuxRCFmmqAtX"
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


--ytBpLuxRCFmmqAtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  0aeed866cb938 ("drm/amd/display: Fix dangling pointer in CRTC reset function")

Fixes tag

  Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_crtc and dm_crtc_state")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--ytBpLuxRCFmmqAtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEfW4ACgkQJNaLcl1U
h9CWaAf/SD2WxId2eOOczlzMXZfiBuIEUELJM4rnLEjvRJYRhun/4NtjY2c8Tfhy
jOoI7jpczSpS0JjEWYftRYuq3FPA2nqIBjWwQdA0T4OjHshNq7+znjsat2NBEAjF
rfGihYVyZ/znIQRvcw9NfNpyFCwXn+Sa03Iguci8/iM5NB9ZV/uoJC7mKy72CXlJ
h9J21RzHVaHPiCV/Oz896oKGh63GArozu47ctS2wAV/48j1P3uzsFSWVekyhEMZ4
NoIPRzJi2nYBsAhgpkqROw0GPAQOdZTISAk01BO3sBQKm4wK0cG5wuRghQ644/Qp
zspuTYKqmur4u7BNW7fTE9ZST+oEfg==
=beVb
-----END PGP SIGNATURE-----

--ytBpLuxRCFmmqAtX--
