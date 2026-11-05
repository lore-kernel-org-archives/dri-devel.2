Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A3606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nQM419CO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B0110E331;
	Thu,  5 Nov 2026 20:30:36 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1564510E331;
 Thu,  5 Nov 2026 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793910628;
 bh=z2B4+zk2KWIKAV/qyCewX7SUwHDfHJQcBF5+1YFub7E=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nQM419COec+J8gtI5buzf4zbDQvGTooRfJG3XFahE8T3H50Djxo3O2FVndG+aUnC4
 2a5+/SBEvpGMrxxdmM1ujYqYwjhW6H2q7DstzghjHdZxAVShULE9tom76gN26JqxRX
 hJhHEAS09KrIvlTSMv+Ud4Tacrc36mRlm1y+0p/Vqg88GhepkxTQDJjkt0nllpxfQl
 WJzS2Hcz63Fm4MMBjvMu+jfZi+yyP3mTzEDc14gfoRyHc1gEfLxdFsxtwhwCND+ipJ
 uns/Zpk59mOVHBnwOZ0SCgkSk0LXfos7TK0advJTjg5KX2msqzYps5geD17epCsL2/
 lBRTA32tHBSgw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D2F5817E078F;
 Thu, 05 Nov 2026 21:30:25 +0100 (CET)
Message-ID: <062fe7dca00f77dac05197552d22897b28dc2143.camel@collabora.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: rob.clark@oss.qualcomm.com, Robert Mader <robert.mader@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Dmitry Baryshkov	
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten	
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Bryan
 O'Donoghue <bod@kernel.org>, Stanimir Varbanov	
 <stanimir.varbanov@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jordan Crouse <jordan@cosmicpenguin.net>, 
 linux-media@vger.kernel.org, Vikash Garodia
 <vikash.garodia@oss.qualcomm.com>,  Dikshita Agarwal
 <dikshita.agarwal@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Date: Thu, 05 Nov 2026 15:30:23 -0500
In-Reply-To: <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
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
 protocol="application/pgp-signature"; boundary="=-NleRU42AqOYhgAgxJXBY"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-NleRU42AqOYhgAgxJXBY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 04 novembre 2026 =C3=A0 14:11 -0800, Rob Clark a =C3=A9crit=C2=
=A0:
> On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@collab=
ora.com> wrote:
> >=20
> > Nice, very happy to see the series!
> >=20
> > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > The comment describing the QC10C buffer layout calls it a compressed
> > > P010. It is not:
> >=20
> > If I'm not mistaken the display engine / the DRM side (including Mesa)
> > describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire tha=
t
> > up everywhere etc. OTOH if we want to keep the DRM side as is, then the
> > comment should reflect that, IMO.
>=20
> IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> as distinct formats, both with and without UBWC.  I'm not sure if the
> same is true on video side but P010+UBWC was never exposed, or if it
> truely only supports linear P010 and UBWC TP10.

Xilinx ZynMP is all matching TP10 (they had GEY and YUV semi-planar variant=
s),
but they never upstreamed it, hence why we don't have it in V4L2. Just fyi,=
 we
named it creatively NV12_10LE32 in GStreamer, but careful, I cannot guarant=
y the
padding in on the same side.

Though, how do we deal with backward compat here?

>=20
> BR,
> -R
>=20
> > Best regards,
> >=20
> > Robert
> >=20
> > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/=
8195
> >=20
> > > P010 stores each sample in 16 bits, QC10C packs three
> > > 10-bit samples in each 32-bit word, which is what the stride computed
> > > below (width * 4 / 3) assumes. Name the format correctly.
> > >=20
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >   drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers=
/media/platform/qcom/iris/iris_buffer.c
> > > index eb8de60c1177..ec2bf2a2d953 100644
> > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris=
_inst *inst)
> > >=20
> > >   /*
> > >    * QC10C:
> > > - * UBWC-compressed format for P010.
> > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed =
in 32 bits.
> > >    * Contains 4 planes in the following order -
> > >    * (A) Y_Meta_Plane
> > >    * (B) Y_UBWC_Plane
> > >=20

--=-NleRU42AqOYhgAgxJXBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauznXwAKCRDZQZRRKWBy
9EBNAQDtA/orEuTFMsZ9i5LtznNukMM+WqfXUnVsGG35kn1WfQEA+1VvAZJM1/M1
fZ3cgYQs51+X7QU6N3O6tOz4JPeduQs=
=+PFk
-----END PGP SIGNATURE-----

--=-NleRU42AqOYhgAgxJXBY--
