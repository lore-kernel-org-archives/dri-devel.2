Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747AEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CC710E094;
	Fri, 10 Jul 2026 14:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ODUldz5r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31F110E094
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:05:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD47D60052;
 Fri, 10 Jul 2026 14:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C711F000E9;
 Fri, 10 Jul 2026 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783692336;
 bh=Mee4Ve674+kXW8lX0M1/6Fz60I7CFp6y5B5h9SWN4Fc=;
 h=Date:From:To:Cc:Subject;
 b=ODUldz5rjDEL7RdE03pbAPvPUH9DBZltqBETD4hB5ttlhJrRgiehQppFCZISosmLM
 qMSEggsQMX+tc00d4f6MhXjV0W8yyYBUMMVosiUM8ygwQfUeIJSrR/TBv4p+dgJjob
 cp6HQLpIFSRHE7rgKK1Zj+e8SmZduyH8Gz4/+hNT4tpX7lKYjyUjpadQG5yjJ14F5n
 y/NMgjNEWVS0n48Z5tz6FNfCIzl+GVfworLeHG1BIz9Lz5BO8+DW/IBtrCcb1U2sPJ
 Ixdf1Gk94iQB1SrrMMklCtvf90Qd9pWPfVuBcsO/vSAPeMVsCerKFUYMSkxhj16OJK
 6RFR8lbNL2Dug==
Date: Fri, 10 Jul 2026 15:05:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 David Francis <David.Francis@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drm tree
Message-ID: <alD8LLeWXZ5t9TgK@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zt3J7OzN25muvLFf"
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


--zt3J7OzN25muvLFf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The following commit is also in the drm-fixes tree as a different commit
(but the same patch):

  f19d8086f6644 (drm/amdkfd: Check bounds on CRIU restore queue type and mqd size)
  1cafa8b29e029 (drm/amdkfd: Don't acquire buffers during CRIU queue restore.)

--zt3J7OzN25muvLFf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpQ/CsACgkQJNaLcl1U
h9BiLQf+Ko9ezryOIXuQ2Lz7wLZBRv2yDmIIHA4lmWYcrTxESbCwZpIl4fusYFrG
/UJpZEiXu7WVIBkchoDhReuV2zG0zN2WabW4ZCie+Ggp+Z9rUtUeyxCKCNn2YzYg
wJkm5ud+7L+yNWd+3//jUVsmlXqnSGAgMfBkNxVLKtezFIRdK+osNM5eWFQo2uH8
bt4WiK1jnUGN/EHgna8xcOC8O2YItlTAKUtcL7OrPmQeEQlAMa4sRVo78PAQ0Ngw
H1qQYhD054SE5jt3FWOXsDcqqpwLjbHCAhSseUfGmAk1a9vyOsviQNR80K30/B4C
ObS8QA3BrCxfSYvPWQPQDNFrzflx+g==
=GYyV
-----END PGP SIGNATURE-----

--zt3J7OzN25muvLFf--
