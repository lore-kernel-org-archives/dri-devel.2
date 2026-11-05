Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1D606D834
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=CchIVmcO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAF810FBB1;
	Thu,  5 Nov 2026 20:35:08 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C5010F908;
 Thu,  5 Nov 2026 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793910900;
 bh=Ad8kNBn6ea1rKcLdBncWP4sS0P7ZVgqFIjqnM+Vx+ew=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=CchIVmcO/I2BEc1zHQQHdUlGXs2hDmLp3A9nIXFKvYUqsc5LnY4FB8yD4tn1F1Jba
 rF6t5/LJLeMmxopc24UIVLoM+EnIQyaKFy/F+1TV/lMZCvSxyx5GO1oxO6MxrO0ovg
 BHEn3GfsZZXasg8YL5Imv0cvxKIPjlEXgtnAS7Xa5vxGioj0gN9CLsfokGvh9Cqzhm
 eOyuC1r0Hp7/1hs+uW9EAhBxZazo5BwlSWBZdek5+uAcCCcNlLS/eCA1+b7qJN3565
 //C5BPKMQCPeB6cx1vqAEI5FvrQ3Jtan+zCOekVV9M5JLgbkGzvEQfRCKvUUscLBro
 4kNgcevghwpYg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 67A0217E0048;
 Thu, 05 Nov 2026 21:34:57 +0100 (CET)
Message-ID: <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Robert Mader <robert.mader@collabora.com>, rob.clark@oss.qualcomm.com
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
Date: Thu, 05 Nov 2026 15:34:55 -0500
In-Reply-To: <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
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
 protocol="application/pgp-signature"; boundary="=-USq9votTJRjBAWEZ+O+5"
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


--=-USq9votTJRjBAWEZ+O+5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 05 novembre 2026 =C3=A0 13:35 +0100, Robert Mader a =C3=A9crit=C2=
=A0:
> On 04.11.26 23:11, Rob Clark wrote:
> > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@coll=
abora.com> wrote:
> > > Nice, very happy to see the series!
> > >=20
> > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > The comment describing the QC10C buffer layout calls it a compresse=
d
> > > > P010. It is not:
> > > If I'm not mistaken the display engine / the DRM side (including Mesa=
)
> > > describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> > > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire t=
hat
> > > up everywhere etc. OTOH if we want to keep the DRM side as is, then t=
he
> > > comment should reflect that, IMO.
> > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> > as distinct formats, both with and without UBWC.  I'm not sure if the
> > same is true on video side but P010+UBWC was never exposed, or if it
> > truely only supports linear P010 and UBWC TP10.
>=20
> Oh, do I understand you correctly that the P010+UBWC implementation is=
=20
> not compatible with QC10C, meaning on the GPU side (Mesa and display) we=
=20
> don't yet have any support for QC10C exposed to userspace? If that's so=
=20
> then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?
>=20
> On the plus side - this would allow us to make the format single plane,=
=20
> matching what we get on the V4L2 side.

Since its single plane, we should aim for a variation of
DRM_FORMAT_YUV420_10BIT. Similar to YUV420_10BIT, there is no obvious linea=
r
single plane packing for that, it would only be there to support the
compression. Or maybe this one is abstract enough to be used anyway?

Nicolas

>=20
> >=20
> > BR,
> > -R
> >=20
> > > Best regards,
> > >=20
> > > Robert
> > >=20
> > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_request=
s/8195
> > >=20
> > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > 10-bit samples in each 32-bit word, which is what the stride comput=
ed
> > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > >=20
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > > >    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drive=
rs/media/platform/qcom/iris/iris_buffer.c
> > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct ir=
is_inst *inst)
> > > >=20
> > > >    /*
> > > >     * QC10C:
> > > > - * UBWC-compressed format for P010.
> > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packe=
d in 32 bits.
> > > >     * Contains 4 planes in the following order -
> > > >     * (A) Y_Meta_Plane
> > > >     * (B) Y_UBWC_Plane
> > > >=20

--=-USq9votTJRjBAWEZ+O+5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauzobwAKCRDZQZRRKWBy
9BDSAP9cXKQq7K5F0gKq47dzESPiGmNAJzGtw7IvXvIhKR3EMgD/fzhUWIDpE+6R
qCrrzw8kwI/MdOykqk/E/2StgcPFaQM=
=TeMi
-----END PGP SIGNATURE-----

--=-USq9votTJRjBAWEZ+O+5--
