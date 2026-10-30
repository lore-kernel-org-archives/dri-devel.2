Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKOWrRsJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FA810E67D;
	Fri, 30 Oct 2026 01:55:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D20112617;
 Fri, 30 Oct 2026 01:55:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F5A143B9E;
 Fri, 30 Oct 2026 01:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3951F00919;
 Fri, 30 Oct 2026 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793325307;
 bh=Bxo8jJFd0r8cFUbwZTI2sPMZTh9847a0AbtlpmmJS3Y=;
 h=Date:Cc:Subject:From:To:In-Reply-To:References;
 b=dKOWrRsJLVmZrcKzJ4TataGEgTAQ0s4UdHiybjyG4H3n0RXWwwhy6363+GHzqi7N5
 ix4oHUMEsiXCUodANrkqdl/1BVH+MZZXnCggVOGG0r9GU2RW0TMU64nJwXa56cdA9u
 bAib/zp9RRwmTaT2hZNVaAsLBgzmSiXSBH7fQ1mwDVBaQOIu9lUQwTItS0o4YgLH+i
 UbPxU9IVErjLR0bwv02yIN5az4AlaBXAhBQprNDbETEBIxc+QJYiFb3jQOPyvCVaBu
 40/zUJFqGRRZ6xD1wrBD2Nmu/++4d2PsUc5lmTUOsMam3lroK/eA556x8VogXi9bBU
 nARS5O1b3RKnA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0127f86fc4a58c91f388809e3d2707f04403f9e1da5ca1b482b2ae563e30;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 30 Oct 2026 09:55:02 +0800
Message-Id: <DMHSRIU2XCB0.35RV6ADY6W1IE@kernel.org>
Cc: "Alessio Belle" <alessio.belle@imgtec.com>, "Luigi Santivetti"
 <luigi.santivetti@imgtec.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Yixun Lan"
 <dlan@kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
Subject: Re: [PATCH] drm/imagination: retry runtime idle when firmware is
 not yet idle
From: "Troy Mitchell" <troy@kernel.org>
To: "Baihui Liang" <liangbaihui@linux.spacemit.com>
In-Reply-To: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
References: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0127f86fc4a58c91f388809e3d2707f04403f9e1da5ca1b482b2ae563e30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Baihui,

On Thu Oct 29, 2026 at 4:38 PM +0800, Baihui Liang wrote:
> Returning -EBUSY from ->runtime_idle() prevents the PM core from
> retrying the idle check. Schedule an autosuspend so the idle state
> can be re-evaluated once the firmware reaches ROGUE_FWIF_POW_IDLE.
>
> Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
> ---
> Tested on SpacemiT K3 (PowerVR Rogue BXM-4-64) by running vulkaninfo
> repeatedly. Without this change the device intermittently stayed
> runtime-active after the last user went away, because the firmware had
> not yet reached ROGUE_FWIF_POW_IDLE when the idle check ran. With the
> change the device reliably suspends.
> ---
>  drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f..6f38249ffcb 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -434,7 +434,16 @@ pvr_power_device_idle(struct device *dev)
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> =20
> -	return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
> +	if (pvr_power_is_idle(pvr_dev))
> +		return 0;
> +
> +	/*
> +	 * Firmware not yet idle; reject but schedule autosuspend so
> +	 * runtime_idle() can be retried.
> +	 */
> +	pm_runtime_autosuspend(dev);

If I read the PM core correctly, when this autosuspend timer fires it
calls ->runtime_suspend() directly rather than retrying
->runtime_idle(), so this looks equivalent to returning 0. Could the
real issue be the pm_runtime_put() in pvr_watchdog_worker(), which
perhaps should be pm_runtime_put_autosuspend()?

> +
> +	return -EBUSY;
>  }
> =20
>  static int

--=20
Troy Mitchell

--0127f86fc4a58c91f388809e3d2707f04403f9e1da5ca1b482b2ae563e30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCauP49gAKCRCYCe+A+TM0
L0hwAP9eNE++iKtZwfItKoa5Ce0VIc5lPf242yrrDF5VaIkx8QD+JwWLmwTRebkd
XinBsGjYMNrSzC78VKKxAT9MxMy9WAk=
=W/PY
-----END PGP SIGNATURE-----

--0127f86fc4a58c91f388809e3d2707f04403f9e1da5ca1b482b2ae563e30--
