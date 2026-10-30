Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D0606A335
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mCg6rlqj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD91B112603;
	Fri, 30 Oct 2026 01:40:49 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F32112603
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:40:42 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-91c19fc50abso2906946d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20260707.gappssmtp.com; s=20260707; t=1793324441; x=1793929241;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RqGRKBlv89UKnAE8+LCS4f2GqK9XGXmUTqEzxUZrwbk=;
 b=mCg6rlqjL5vsE1MwXfqYHG8SQ5Av1BBrpaZnOqMiA7tDhKsicvNEYWuafxgrh3mkKv
 tJIsz3OgQH6FWMQovAMBrwZcJFTdXsNRTRYV6WXl/w0ozioGv49eAtC0Vbo+GRSBxuAc
 pNLiGR2aFyz7Kw/UtPVX0nhX66QtZL5+g36wyJUuRwGEwl98G90tG96oofsaejWz1p4D
 A1DPdmSMW37vOoAlZ4TAL6Wd9p19J687dTS9wGJvnIqOYUdKNRxf/QBFtMKXrDuCEsNY
 PIOvwt0Aq+0k0j7Wcdo6ixmYAcLDkz60uXz9OsVSWsltPGMunCXcN2f//A3XljlpjWav
 9p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793324441; x=1793929241;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RqGRKBlv89UKnAE8+LCS4f2GqK9XGXmUTqEzxUZrwbk=;
 b=WKUU+KwOKMPovmy64sPc+B5CV8xvTKV1eHMTYkoChOl29Doa1hsFqf2/cxUvUmo2M1
 QY4a4s51YlcPAu9tq4f1Bpd3hAsk9PRbA7Do3eTc6L3VHl9OD756SRHIj/cfrcNkQo10
 liMQ0N35xxkI2NHRpdwAxaLVgL3o8Q0nBTEumRcLKyiDuQMd/k7Sl9eWAhSPA41/TYHq
 Jkn15YlyDzJESV2xzLU3vovIhOXUTNMCYbsOt9/01iT7aJTFZfznn2PBBOE3p+v2SgD7
 PS6y70lqdAuhw9Bh33/8zqzH6Ldrn4oIelFRyHpIbCA+a8OIb15Nuf4t3ZG5d6jLXjvy
 P4Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBytzXCQdjkp5RhtRFbaXe6CkUIWet4UQIptNKgBiaUGry23RuxmiBNYq1nBJeGK+9jMdiRjcI890F0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuyKsm44RNFfaZYzd5Bs7gLLskueLyNtd9VzZEuu8Cl/qrcpZl
 6Wi5zTSTCW5CkzAMoQ72++eW7BYJYW9h4LMPQGCPgNn3uEdrr6ep+d2D1SrO7uTc4NQ=
X-Gm-Gg: AYBFou1ib3IAI39ebpZJX0IiVX3Fqp1sPD1G8D2svUagBCB2yEXtDQWkUtiwb4f/OpS
 1n6EIp1lh6/Yu3Ct8QojXIKWE2g6CkrtvnX7eCOW7pmYQWRCLmYKBMWHGwmpJZtVUI6Z3EfvD/9
 zPDUTSh0eXlc320rV21iJ7h0BxiMbLKk/P+lYa6OvcsNIuedOdnRTr9zuGt1vy3cfR4y2fiXlF/
 rdKTjyResIuektDQVNOZuyRAqRzHaKAV+i50N1p6lOCuFEfUQw2XwCrFzEd6icqYrYKhLSVEHhQ
 +QJy3O9pgRe4Qosz43mMWL9xr6WbOCt1uX4jqUKFN3bs1MnU81itbjyYHCiPJ4Wa2emD16Wz9kW
 CHYzZ7fltn9lGcHHOU91bhZWKgxOsK3yeZgSnele/xXX31HaSHoDk+B7pwzm9v7vkHpl7eHg5h5
 aTegEPwZiNR7z5G/33vkKmwFrT59HVmq0UIwaVdyzBaVPVrD0djbPQpRj/5qA5E1bwz61H/sTMd
 AnPzMT+f41+XkB6zhA6kbyB5L4tirJV9fGcHR0J6sG1BsEhUsDUxbZWeptjtcwAABRxYTjSbIBn
 feHtgH5ap687oIn23vf31hs3UWpNBQjDvANAqNGjSUxWSTdWJROdG0Q=
X-Received: by 2002:a05:6214:5083:b0:91c:7997:615d with SMTP id
 6a1803df08f44-91ca49f2c47mr12813436d6.4.1793324441578; 
 Thu, 29 Oct 2026 18:40:41 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f254a1sm1827526d6.7.2026.10.29.18.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:40:40 -0700 (PDT)
Message-ID: <7e4c7707880e9092180d28484ecf674be29b40a0.camel@ndufresne.ca>
Subject: Re: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa	
 <tfiga@chromium.org>, linux-media@vger.kernel.org, Marek Szyprowski	
 <m.szyprowski@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard	 <benjamin.gaignard@collabora.com>, Tomasz Stanislawski	
 <t.stanislaws@samsung.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 21:40:39 -0400
In-Reply-To: <atmKXkOJiGJXgRz-@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
 <20261021175900.GG15441@killaraus.ideasonboard.com>
 <3084b9bc0d4b5593d2bfbfecb0ce272cb813ece9.camel@ndufresne.ca>
 <atmKXkOJiGJXgRz-@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-SYeMQ3pQJ6t3SdKBYJiJ"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-SYeMQ3pQJ6t3SdKBYJiJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 22 octobre 2026 =C3=A0 06:04 +0200, Karl Mehltretter a =C3=A9crit=
=C2=A0:
> On Wed, Oct 21, 2026 at 05:03:19PM +0100, Nicolas Dufresne wrote:
> > > I think the dma-buf API doesn't give us what we need. Cleaning the CP=
U
> > > cache through end_cpu_access() when the producer is done writting to =
the
> > > buffer is right in some use cases, but not in all of them. It assumes
> > > that the next consumer will access the data through DMA, which isn't
> > > always the case. What I think we need is to track the state of the
> > > cache(s) in the dma_buf, and perform cache management operations
> > > accordingly when needed. In the uvcvideo -> display use case for
> > > instance, the dma_buf should track that the CPU cache is dirty when
> > > finishing CPU access, and should be cleaned on the display side befor=
e
> > > performing the DMA. In a use case where the producer would DMA to the
> > > buffer, cache management would be skipped as the dma_buf would see th=
at
> > > the cache is not dirty.
> >=20
> > I also second this as the only viable option. Its not only about uvcvid=
eo, but
> > any memory imported by a driver doing DMA (which is not also the export=
er). That
> > includes udmabuf usage. These days, cache artifacts are visible with In=
tel
> > display controllers, and Intel mobile GPU drivers. Note that GStreamer =
properly
> > signal CPU read/write using DMABuf sync ioctl.
> >=20
> > For most Intel laptop user with GStreamer 1.28, these example produce a=
rtifacts
> > on movement. To me, the solution is to track the cache state according =
to the
> > access signalling (either userspace or driver), and let DMA user/consum=
er decide
> > if a cache flush is needed. There is a obvious challenge in keeping thi=
s state
> > coherent whenever there is multiple consumer, of if some broken applica=
tion do
> > concurrent write. Result for the last will always be undefined, but the=
 dmabuf
> > CPU cache state should not be undefined.
> >=20
>=20
> For a persistently mapped attachment, where would the transition to
> device access happen?=20
>=20
> dma_buf_map_attachment() may only run once, while the importer can
> submit the buffer many times. Would this need a new per-attachment
> operation before each submission, or can an existing event be used?

In my perception, the mechanism in place, attach/detach and begin/end only =
work
for very specific cases and breaks in most other case I can think of.

>=20
> I tested that distinction with one persistent V3D attachment on my Pi
> 400 and Pi 500+:
>=20
> - If end_cpu_access() only recorded dirty state, with no sync before
>   submission, V3D read stale data in all 64 frames on both boards.
>=20
> - Synchronizing the attachment immediately before submission produced
>   64/64 matching frames on both boards.
>=20
> This only covers V3D, but it seems that a dirty bit still needs a
> device-side use event. Is that the model you had in mind?

In my mind, we need to introduce new API. The problem with the being/end de=
sign
is that it only works for specific pattern. Typically, on begin_cpu_access,=
 you
want to do specific action that ensure the CPU will see the right value in
memory. One of these action could be to flush a device write cache for CPU =
read
access. But unless only the exporter see these calls, and unless the device=
 is
the exporter, eveyrthing we have fall appart.

With the new trend of always allocating from unified memory using dma heap,
udmabuf and other non-device specific allocator, both device cache just bre=
aks
everything. Just like, an importer that need CPU write to be flushed breaks
today. This last one seems obvious, just flush, but if the data came from
another device, you might just kill the performance.

I think if its just for the CPU cache state, to let importer that needs it =
know,
we could introduce some sort of a bit mask (and some locking probably?) to =
help
solve that. But we still leave the concept of device side memory cache brok=
en.

Nicolas

>=20
> Thanks,
> Karl

--=-SYeMQ3pQJ6t3SdKBYJiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauP1lwAKCRDZQZRRKWBy
9BGDAQC/E/RPY2ek3JSbLyrgIL8MsvucTMSh5z3xFEul5NU+/QEAzGcRh7x7KGrs
b5Pdbz0AZo4N9fWgABBMs+tBtTHRDg8=
=XQRj
-----END PGP SIGNATURE-----

--=-SYeMQ3pQJ6t3SdKBYJiJ--
