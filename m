Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF6606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EsbygLqL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5A210E0BD;
	Fri,  6 Nov 2026 19:09:12 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C7B10E0BD;
 Fri,  6 Nov 2026 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793992145;
 bh=r6VDpg3FAxOwfz4ISFxVWsC4rSt8VUYBM2cnkHmSp+U=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=EsbygLqLPWd0rmghvY5UCxhMhDSZWcS5VFmeTbrrpV7uViRl31ScU8dw4/v/oAuCO
 cTChOITZ/SIqYTBkqVKnNpUZcq3aYEoDiOz9dMGSImoOsYw9dfcNt6oXy05l7JHx9f
 8gM35kyfDF4sghgXyAYrvXgwaf1f6TB97a3UJFkDJPChIbxF24+Qsltaf+bF/Vhqyi
 7+sRiFvqROb+M2NxQ8w7rixEFRxgv/V7YzW893/WnDoGTmoe66J8ekeRgNRppcXedH
 gJqKDnvycf/t6Axq2D72A+dpN5d5uDWqsy7BvLaKcjukXEPfHdpeoBsxsEzbIVFTSO
 w5MFs93Ruhk/Q==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 327CF17E0411;
 Fri, 06 Nov 2026 20:09:02 +0100 (CET)
Message-ID: <8f3c80b4b518835e2d8b3da62e84572338657f68.camel@collabora.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: rob.clark@oss.qualcomm.com
Cc: Robert Mader <robert.mader@collabora.com>, Dmitry Baryshkov	
 <dmitry.baryshkov@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,  Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>,  Mauro Carvalho Chehab	 <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Bryan
 O'Donoghue <bod@kernel.org>,  Stanimir Varbanov
 <stanimir.varbanov@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jordan Crouse	 <jordan@cosmicpenguin.net>,
 linux-media@vger.kernel.org, Vikash Garodia	
 <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal	
 <dikshita.agarwal@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Date: Fri, 06 Nov 2026 14:09:01 -0500
In-Reply-To: <CACSVV03Nz=das+fneMqx9UE1Vzps55=_An-DtmufRTxdhv2idw@mail.gmail.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
 <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
 <CACSVV03Nz=das+fneMqx9UE1Vzps55=_An-DtmufRTxdhv2idw@mail.gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
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
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-MRU/X/3RbhtvxHzHto3I"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-MRU/X/3RbhtvxHzHto3I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 05 novembre 2026 =C3=A0 12:52 -0800, Rob Clark a =C3=A9crit=C2=A0:
> On Thu, Nov 5, 2026 at 12:35=E2=80=AFPM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > Le jeudi 05 novembre 2026 =C3=A0 13:35 +0100, Robert Mader a =C3=A9crit=
 :
> > > On 04.11.26 23:11, Rob Clark wrote:
> > > > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@=
collabora.com> wrote:
> > > > > Nice, very happy to see the series!
> > > > >=20
> > > > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > > > The comment describing the QC10C buffer layout calls it a compr=
essed
> > > > > > P010. It is not:
> > > > > If I'm not mistaken the display engine / the DRM side (including =
Mesa)
> > > > > describes it as P010+QCOM_COMPRESSED as well, and so does my pend=
ing
> > > > > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > > > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wi=
re that
> > > > > up everywhere etc. OTOH if we want to keep the DRM side as is, th=
en the
> > > > > comment should reflect that, IMO.
> > > > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P0=
10
> > > > as distinct formats, both with and without UBWC.  I'm not sure if t=
he
> > > > same is true on video side but P010+UBWC was never exposed, or if i=
t
> > > > truely only supports linear P010 and UBWC TP10.
> > >=20
> > > Oh, do I understand you correctly that the P010+UBWC implementation i=
s
> > > not compatible with QC10C, meaning on the GPU side (Mesa and display)=
 we
> > > don't yet have any support for QC10C exposed to userspace? If that's =
so
> > > then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?
> > >=20
> > > On the plus side - this would allow us to make the format single plan=
e,
> > > matching what we get on the V4L2 side.
> >=20
> > Since its single plane, we should aim for a variation of
> > DRM_FORMAT_YUV420_10BIT. Similar to YUV420_10BIT, there is no obvious l=
inear
> > single plane packing for that, it would only be there to support the
> > compression. Or maybe this one is abstract enough to be used anyway?
>=20
> Oh, sorry, maybe I was a bit misleading/unclear.   TP10 is still a
> semi-planar format with a Y and UV plane.  But each of those planes
> combines UBWC metadata and pixel data.
>=20
> Within each plane, the pixel part of the data combines 3 samples in
> 32b (compared to P010 which is a single sample per 16b.  So not quite
> the same thing as DRM_FORMAT_YUV420_10BIT.

I believe DRM_FORMAT_YUV420_10BIT is defined as fully packed, no padding in=
deed,
but I'm not sure if it actually matters considering there is no linear
representation of these. What really matter is that its a single stride/off=
set
format, which TP10 is not. I would not mind to see another pair for format,=
 but
I just wanted to emphasis about the number of expected strides.

Nicolas

>=20
> BR,
> -R
>=20
> > Nicolas
> >=20
> > >=20
> > > >=20
> > > > BR,
> > > > -R
> > > >=20
> > > > > Best regards,
> > > > >=20
> > > > > Robert
> > > > >=20
> > > > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_req=
uests/8195
> > > > >=20
> > > > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > > > 10-bit samples in each 32-bit word, which is what the stride co=
mputed
> > > > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > > > >=20
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.=
com>
> > > > > > ---
> > > > > >    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/d=
rivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struc=
t iris_inst *inst)
> > > > > >=20
> > > > > >    /*
> > > > > >     * QC10C:
> > > > > > - * UBWC-compressed format for P010.
> > > > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples p=
acked in 32 bits.
> > > > > >     * Contains 4 planes in the following order -
> > > > > >     * (A) Y_Meta_Plane
> > > > > >     * (B) Y_UBWC_Plane
> > > > > >=20

--=-MRU/X/3RbhtvxHzHto3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCau4lzQAKCRDZQZRRKWBy
9FnqAP49S1oZaKGOY3Hv3ojnOCcc44EO1hORyLd//hdYPKnC3QEA75cJxJYAPQ2S
4kb8vGbFauZWYlct28W1Lw1n+jFKpgY=
=RDiY
-----END PGP SIGNATURE-----

--=-MRU/X/3RbhtvxHzHto3I--
