Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD52C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFA210EBF9;
	Tue,  8 Sep 2026 14:07:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB73410EBF9;
 Tue,  8 Sep 2026 14:07:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D4E540BF1;
 Tue,  8 Sep 2026 14:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBFB1F00A3D;
 Tue,  8 Sep 2026 14:07:00 +0000 (UTC)
Date: Tue, 8 Sep 2026 15:06:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Alex Huang <Alex.Huang2@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <5d3de44a-c382-4ce6-8f52-62696e67fcd0@sirena.org.uk>
References: <aqAVSgsypMch2c0v@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lOeEdv7AiO3TZxIk"
Content-Disposition: inline
In-Reply-To: <aqAVSgsypMch2c0v@sirena.org.uk>
X-Cookie: The heart is wiser than the intellect.
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


--lOeEdv7AiO3TZxIk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 03:01:50PM +0100, Mark Brown wrote:
> Hi all,
>=20
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> ERROR: modpost: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amd=
gpu_dm_connector_test.ko: symbol 'parse_hdmi_amd_vsdb' undefined!
>=20
> Caused by commit
>=20
>    65198b3d0738 (drm/amd/display: Use HDMI FreeSync range from common EDI=
D parser)

Sorry, that should be f65198b3d07389afdcb48e4ad00fea2aded95dfd.

> I have continued to use the version from next-20260831 instead.



--lOeEdv7AiO3TZxIk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgFmMACgkQJNaLcl1U
h9DHlgf/bWfZ0Bc/2mHhv2tpOgPyltTb5KGNuzhTCET0U2SXgPR82UeHYmsnUBCF
fT2zq3X3e4Q5MWIWcGElfhJ1F7m24HK9ZAHjRqdsV4+rZt7smt1C2oJDfbRa3/i6
e/E7RcBk4x16bTBHFf+83uw5GRZ+JSB8YGu7UHlAoNJOQ1KfHXAV0LAWsqr/PNpU
TBHMEpnf+K06ArjafUUXDSiVN2sClsyRiBr/hMXaRlUwFhcVfjfvT7YPKi2HxiNm
27Jhv9hK7/Eo3vz9Ud+kGd8Z+8kAZHlkB5hE5ewn833JVjk05JxSeej9R/XdTLqY
Oems2SAKeHZW5+ktGduJHrQzaKQQyw==
=ic3F
-----END PGP SIGNATURE-----

--lOeEdv7AiO3TZxIk--
