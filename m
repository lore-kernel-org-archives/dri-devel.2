Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA07606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tty42.de header.i=@tty42.de header.a=rsa-sha256 header.s=rsa header.b=ghIVzN/x;
	dkim=pass header.d=tty42.de header.i=@tty42.de header.a=ed25519-sha256 header.s=dkim header.b=h6f9AXgy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35EB10F145;
	Mon, 16 Nov 2026 13:12:35 +0000 (UTC)
Received: from mail.tty42.de (mail.tty42.de [94.130.190.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A461F10EFE9;
 Mon, 16 Nov 2026 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tty42.de; s=rsa;
 t=1794832786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaY58mWYhtLGZrc9o83RlgoN8SKqhPsW/KlFBTGOdfs=;
 b=ghIVzN/x0nJcknR3vvjImvFGMBUEjT8LfCSLF4nZbXRxn1GO/zdXLHGvqhMBxkLz1iLvpw
 QdXX8vmlKklhlk1TjFoRyXNLoB/almAmJX5TE48awysWDdSQUelt7SBOWlrJ5eZu1JHE/n
 kFjSRSBUnTD8FFHqDSqYNfLwodDWTTcNCCgrtI1g3Gof/nSwLWkLnqxGloVnrsdM6KKtkc
 wcGxYjctS0SRMo75JgEXch6CT2gltaYDSorWB9biCMRhqMOH2gSyQUMe35qfxunqExPL9J
 7tksdHuvKPxJfPVx2bdlftkUDckSE8iNkTScnbmtNSaUV4tIGVqUG6HPAVSU3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tty42.de;
 s=dkim; t=1794832786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaY58mWYhtLGZrc9o83RlgoN8SKqhPsW/KlFBTGOdfs=;
 b=h6f9AXgyLdCn+vozv1q2XC/ThUKi70zhKomVVSyCB83iy8MGGbs4NMm3o6VRcDvM+Iq4em
 WJwua/3qAxXngzCw==
ARC-Seal: i=1; a=rsa-sha256; d=tty42.de; s=rsa; cv=none; t=1794832786;
 b=B6wtdxTV3INA5XnhZnuy/KVA65tVMTsm6AcPX/RCMSbUqYPt0ADgEbyYx9H9LbaWbyLHAg
 eYvY7hMTsJOS66G6xAmFuaBEkZjqHSKimXtMbNAblZF4MctGYDlo42UbvzTSboRq1Wm9WO
 sdzIP/Ok8WXCeWNJJXp8xIWv4rlpBQ4/4yTBZ3bFmI3KICaJuKOBkKk0TFo8/6uLv6sXtx
 JnHqXSVuxGSqCGgTtPXqNJaUcZe/sFqLM7z5k7nHWAmF+QjEvD0rcHvBMKD3WRfsjeVZTX
 Xs20HThRsUTZyWDhf/f9zs57d6UQtbTcBseZECCu1OuBDC7rih4Mx7eeJU1REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=tty42.de;
 s=rsa; t=1794832786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaY58mWYhtLGZrc9o83RlgoN8SKqhPsW/KlFBTGOdfs=;
 b=jW3m+pCXibj9d2e+rc2bDE50m5Weo/dP6GvZiHkjkYC+mVt+Ko0MvqIXNeRsojLkHdRDqy
 G5jWw/BD24EbbOx3kSSRIxsGesHPJ4YouQmGS4XjSycrWaItSKK2dhHLLZ0hP/ylVvPpL+
 Nrv9n3vTzb2qttJuoNj4DhjZGFz8P+g564G8C/af9BNn9/VWQM2v0mivamMH0RVCuR/5TR
 tcQjY4FrHIOkypFbOU6ZsEYDA9WGagwA3y6Xoraty6NUhLYXRYDDlnWX8NUznqELNA8Z5N
 qaja06dtX7ketbuHF7YV0ItoUxKMHN3TPRZrQCtnpKccvBgbZzkk+LNSARmQgg==
ARC-Authentication-Results: i=1; mail.tty42.de;
 auth=pass smtp.auth=frederik@tty42.de smtp.mailfrom=frederik@tty42.de
Received: by mail.tty42.de (OpenSMTPD) with ESMTPSA id 5b15cd8e
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 16 Nov 2026 12:39:45 +0000 (UTC)
Date: Mon, 16 Nov 2026 13:39:43 +0100
From: Frederik Schwan <frederik@tty42.de>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 regressions@lists.linux.dev, Imre Deak <imre.deak@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
Message-ID: <avr5VTYmuO4E1yax@mail.tty42.de>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de>
 <40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7bm3dnq5a2qgveyy"
Content-Disposition: inline
In-Reply-To: <40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com>
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:12:05 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7bm3dnq5a2qgveyy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 12:35:25PM +0200, Jani Nikula wrote:
> On Fri, 13 Nov 2026, Frederik Schwan <frederik@tty42.de> wrote:
> > Hi everyone,
> > I just upgraded my system to 7.3.x and found a regression with my noteb=
ook/dock setup.
> > 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I=
 guess that DP-alt mode then).
> >
> > Until 7.2 all displays worked. With 7.3 all displays work until kernel =
switches from fbdev (?) after
> > which the 2 DP displays have no signal anymore but the USB-C one still =
works.
>=20
> Please file i915 bugs as described at [1].
>=20
> BR,
> Jani.
>=20
>=20
> [1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.ht=
ml
>=20
>=20
> --=20
> Jani Nikula, Intel

Done, report continues here [1].

Best regards,
Frederik

[1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items?sort=3Dcrea=
ted_date&state=3Dopened&first_page_size=3D20&show=3DeyJpaWQiOiIxNzg0OCIsImZ=
1bGxfcGF0aCI6ImRybS9pOTE1L2tlcm5lbCIsImlkIjoxNjA3ODl9

--7bm3dnq5a2qgveyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iNUEABYKAH0WIQQFx3danouXdAf+COadTFqhVCbaCgUCavr5jV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MDVD
Nzc3NUE5RThCOTc3NDA3RkUwOEU2OUQ0QzVBQTE1NDI2REEwQQAKCRCdTFqhVCba
Cj7EAP9qoXLSd+4XA4mbOtNL0OQx/0vWNytf2LIpwA9c0EJ9YwD/ezl5ueUdtGnJ
bMhr6lmsZqeA/0GzpiE7zmZo1wgsygs=
=t7uL
-----END PGP SIGNATURE-----

--7bm3dnq5a2qgveyy--
