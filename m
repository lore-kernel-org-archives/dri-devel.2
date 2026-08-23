Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F749C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281EB10E2BB;
	Sun, 23 Aug 2026 15:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="GFHyuBp8";
	dkim-atps=neutral
Received: from sonic309-20.consmr.mail.gq1.yahoo.com
 (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3281310E2BB
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787500778; bh=rGVN6LVN0knZAkgw/5uqdLSqmmnAgUADX28q0ddAB74=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=GFHyuBp8HgDrGoiniFWlcq3kh3GkDK0hE8q7IXBPmY5JU7kdE0AHxHbPVc6vBiLhV+nU7Rd8pToGCZy5qSwT2V8UeROD0+w57ss5dLwzcNYdfBtw0t4asm6FE/AcTVTEqw0tJex4AjYHmbfo3p/SjmbLc/wtV3prHj7wikfWrfI9Ru9UWnOb8o9p5/9eAjKDJtPVeHVuJquJARxF36d5NCZgZ9hVLNUBgbdyOKxDGTgA5ML9PyMr+e9qpxyxS8FYPigolLfaz9Hqj3Hl6NMZIfBVdjG5dLG5ThRzriJy/ucVN/2u9rkqBXWeLrwxaIiVa8BJwIRza5Ia3gpVxzIwmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787500778; bh=rHYkAPUQdHk+ZpaguaB5z2lrezRwBEhzwKNfvGur1B7=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=UElegKjLdhmMOdKu+8/j1aw2xOOVpQmpZh8NxFyUq3b6kRZpFDW1buh4utttjYXCvGYu3Hj6bPuoaEti+z0eB+dswhWzSOxkdAMmSkvyE2qCJzTmoCpNim88iRCqV5+sb+/7bngDEEjLgAlnzfQJSbhuCHLNlenB/ok1e59lATyEzXJqwLRnAXCEZy+DL3MBY/CuFKbeaNVM2xbFDTfh5QfAvzjCHbnFqnznhwd0FykbarG0rS0skgwC5VYCTG/52Ny2XIYzkzwiCD14UvluiY4zjGCAAB3t6pBpyboT64SiTnJMNO7LK1NwEq6LJ59NByx5bjsAztjGjRNPprFTIg==
X-YMail-OSG: vJloPZ4VM1kK1dc9rlOl04gJm.Vcv5q6zx0TIo_QR7Q61oQa2qGXH0DReilM0JQ
 CR4yHe2W1FFuf2O17SCD9gXe3qy8L3uMFmj44upWYwTp9xTi1n6z17GmDJDXthfbENpJXzEZcVii
 8F0.JOQz9pqKiD1NSdtbKX6RDRVjqC6wsesoWMByK9u_NxNbqgu6JOWuyhgdmS4VC9hBhdQTi.jg
 Ukoi_SSI2Xr3On859mKW2XLMi37Lnc89oJ5uDTWldyz8A72RbqwItsq8OBob.DIRT3WV2C_LqUS0
 LBqOP4pQIRbNIK1XVEFXlEtKgPLZYXKXveLGftc_y6mop7I782aW1fVIWvbG2t3_R_raRipZW61m
 UFtmbYxrlDCWBeuI6FHxxsZrDImbjiBqdZZvY.cjGgL4OBA03MdzY4wcwYFJ6JTFJG1f3nuqOwFZ
 y4ETnaRJpF3ZqgAC4Gdu8vBmVYat8ftu90pGzpbvUmcE6hUbDbuK1DOrJYDMABPGgRldIVWuJn0X
 EggqRw3DZVNeT_DbHhuaQE8A9RDr4ZV_tyGOA89D6Mz9iS2i.vrkcBRNXlX2k6Go.iCKY1SVTfTU
 pAEgCRzmzG2xl6tCBCAKolrmbHszTSb8o0OrhOjkg8yrrBDfQGMKBlJ.EZdaXa_9BR1gyo0fK3R4
 Df7gVqIhTntv.AtBIl_7LTNqvJXu9hZ9jnhLgJ869Gw1ywZv4UBC4szB9G4wtN6sc.Z4z0p9zBA8
 QtxqNsz4haT5zQKnOWzkMr0K2h5vS0T0g.rqudkCnDEi_J9PQ5in0.uKvRzgyCbh_u89DYqIl9Dz
 4hB2fyof_heL.LV7sWSVIg1ljQmSRIODlYS9RTcqy4mCZ939xiu0KcYdOmPoeoxBT4DS_d2saK8u
 bSnExAxSAn.osm6K4dsxSdvea5.WYqEnIsiWeJv9GUxoR_g77_cqZ3Su.3gwiUFKW5WFL5PGQdL4
 NXHNkMbWSYBZ5Uf4ERKNaJiRS.Tv8l8AZzh3Rzq9gTPq394jkvb0F.Vwg2P6vZVS8y64EYUfK83r
 u2rJGrFWsZO_.XlYubwCtbWzaDN1HPnq2nELKmr3HTwqkscLlayd54QZpMV.f3VOIIA.3.Piy2Xj
 Sxd23kEnXp_GFFs342WGZj1jv7JMij.8XeyOBDNHzFcSLHVY8jGyfohPwc1_n17.jTiFe8dvq_Pf
 gyJTd2Wn0Ceg.ZT195SaLrX9aLn_76iXgEOg7kto42weEuD9q40UoDr7nnTNv.WEqbQc5kRZI0zl
 x2yJWWtGjpLTTKLf.Axdnf.bup0.ENzu3_KBIGANx2uvF8CxgcivMPXlpC2LFngh1ituAMOX_U0O
 BUckKcIKMWTZSIm3JvoQcP0vlZRi1_faaVIivjdz1_R54ytavAyRFfJ_uQHBeT.F_IBn1v50Od9e
 jAhYftQN56oHeL0M55zO18Cc4poS0cR5elB3GX0Fh9dNQoNRbi98S37EhliBtLtc45AGgE13Hr6j
 32ncsaEsvesyfyY.A2AbFpF.cuk0BtkTg64rX09ilS6IKmmUg2gANMFbT2DtxFaGZedHOVSCkej2
 ZR1T1lwLCW42N6JahQdfD4XiDtiktwHE_bEGk8nodleUj5vL_9EUeoid.3NHOhNw4YyaeLdhUwO8
 xE8vUzcptBwBUgqQgsUWc1TjuVJATS3ioHCutx7qIh4aulZB1aQCfn0BrxK282efIhWOL6ouw0Ny
 4i1HMr0avk0eF2EYlargNkk0TG1aLvqqwn4T7x5Ld1bQmMd_qm.s.eeopfGl0qGxhYho4hgnfJrN
 gppmZUkORPTi_lp6adumixpdqhnpKBfEzMgsv4tjTppHtlvAhfjgNPINMY8JxopxnNCWWAU1rw.R
 _OP57mp8QcGxAV_X80xJdXpuOfVTbp6OtbkqrhSjmOC7Fu_MI1e5AR1XLHwxO8DJ7NHOdE0jDeMy
 AYkR6Ulfhn5dEJbOuL5ojPAD7.a3724LjKFh5eSTBZjV5TZcT6FO_0FqbSPQ3YphEB67sMOSsEA5
 RUKxkhhUqMBhF.q.DO_8Rw4FjyXIX8vboyTi4yrJ8CcpaYp8pMgqMcYHGP8reUWkBeoJ4EnSPmyN
 OME_rr9AuJvdWo5wHSa8UWUg1QNw7nSjZFkhyK1lsa6LpigJMBNq0pMyCcdrLlL.Rs2qD2wuFf_c
 hgoNX8JlSwiDK9LtvP9Sb3sfO5GofA3ZHKveFlP3EFKdNMxuTsLKdg8Q7Owwt9jQ6lR8TAC5ysu8
 c6joBDNQwFYCGe4t7LzZIjQfTQFZuFzAk1UjHORogIYLCPGQqmLdqZEFAMZaaKnx_prSgOpKPNwK
 v75DlfgY-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: d3c47751-95de-405b-afc0-902eb3f51aa5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Aug 2026 15:59:38 +0000
Received: by hermes--production-ir2-cddf86dcf-shm6w (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID cc183acbe6c86b0f5fef479d9db2781c; 
 Sun, 23 Aug 2026 15:59:36 +0000 (UTC)
Message-ID: <b0670075c3325e9264b518508f68d35c8e2b56ed.camel@aol.com>
Subject: Re: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
From: Ruben Wauters <rubenru09@aol.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: peter@stuge.se, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Date: Sun, 23 Aug 2026 16:59:33 +0100
In-Reply-To: <6c3a749f8d377b122ba33fd06825d8faff345006.camel@aol.com>
References: <20260816085234.22053-1-kartikey406@gmail.com>
 <2973ae0d1d7ca4c39ef2cb07236ace25d400fdd0.camel@aol.com>
 <6c3a749f8d377b122ba33fd06825d8faff345006.camel@aol.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-WpZK/lQdId3P/XDcv7o0"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26380
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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


--=-WpZK/lQdId3P/XDcv7o0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-08-23 at 16:41 +0100, Ruben Wauters wrote:
> On Mon, 2026-08-17 at 16:36 +0100, Ruben Wauters wrote:
> > On Sun, 2026-08-16 at 14:22 +0530, Deepanshu Kartikey wrote:
> > > gud_connector_add_tv_mode() reads a buffer of fixed-size mode names f=
rom
> > > the USB device and passes pointers into it to
> > > drm_mode_create_tv_properties_legacy(), which calls strlen() on each =
one.
> > > Nothing guarantees the device NUL-terminates a name, so strlen() can =
run
> > > past the end of a slot and, for the last mode, past the end of the
> > > allocation.
> > >=20
> > > Terminate each name at the end of its slot before use.
> > >=20
> > > Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> > > Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D916c888ba5f1a54c952=
6
> > > Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > Acked-by: Ruben Wauters <rubenru09@aol.com>
>=20
> Thank you, applied to drm-misc-fixes, Cc'd stable

Hello, my apologies, upon checking other patches received, I found a
better implementation that returns an error and avoids truncating, as
such that one will be applied over this one instead, apologies for any
confusion.

Ruben
>=20
> Ruben
> > > ---
> > >  drivers/gpu/drm/gud/gud_connector.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gu=
d/gud_connector.c
> > > index ea0cca58b7c8..5c0065c876a7 100644
> > > --- a/drivers/gpu/drm/gud/gud_connector.c
> > > +++ b/drivers/gpu/drm/gud/gud_connector.c
> > > @@ -396,8 +396,13 @@ static int gud_connector_add_tv_mode(struct gud_=
device *gdrm, struct drm_connect
> > >  	}
> > > =20
> > >  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> > > -	for (i =3D 0; i < num_modes; i++)
> > > -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> > > +	for (i =3D 0; i < num_modes; i++) {
> > > +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> > > +
> > > +		/* The device is not trusted to NUL-terminate the name */
> > > +		mode[GUD_CONNECTOR_TV_MODE_NAME_LEN - 1] =3D '\0';
> > > +		modes[i] =3D mode;
> > > +	}
> > > =20
> > >  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_mo=
des, modes);
> > >  free:

--=-WpZK/lQdId3P/XDcv7o0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqLGOUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhA/QP/3/2v2sgfSf1kwBXitWC
tWOwTHKHt5o20IBCVTPKlhUYt7A7Uh1ZljmA2dLOBcqNJwbjeTfnukNRYqeOG1l6
NdSnyet2Q02RjsoS32gVmgM7agfnPgYUHgeNkyF+ka5Fbx2P7QpkugKEv/bpSbK3
+jsgxRjru+PpX1FEgEFWw/vcSjsaAtb8U8XKPjsrBD0sQ+UZJplaE47RAANYCzNY
iyNsPxCTJj0lsU6KUpjW2uVtBoumZuFI9qFMoipx6vn6LbxcLf5F0A0BouQrDRap
iY8rjBX1HCsHaeMxqj371Q49VuYkfzdaXC9UzjvknSQNSkphESurf4LHcf8zlEpc
NYuhXlxtvEsfDxnYMPVTRbGnZ01wFuYfIBPQo8qT8RA7buA26rOid0kNRAEPmsh+
NoZlolYfzFz4x9a2Ll6CEANLwtfQy3ZraB4ZQfAfQYmfDscs61OcIaHR0GCKT0G0
ZeytESBmvIgD2TulizaAKldwXPMl5AtE5C6p0XjIihpjjzwN+X5sBjbbjRJu6Ib5
6ul0Q2Ftmn7NL1+qM8+1RB7decLUY3/G/YaCof9JGk3GYC5Dh0aSSKX6sXEEjVgX
je6B/jridsQd7r+a51PiyI7/dKx+7K5lw1gDcARat5uBtL9+OExvLeGh0Rkqwzzf
8Cefj9uSLfHMhOPLPDDsP35F
=NoER
-----END PGP SIGNATURE-----

--=-WpZK/lQdId3P/XDcv7o0--
