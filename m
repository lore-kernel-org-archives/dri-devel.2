Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9B606A338
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=m/rwaVYR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3F410E446;
	Fri,  6 Nov 2026 19:06:04 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D080910E446;
 Fri,  6 Nov 2026 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793991956;
 bh=6LdXT14KOb6OCBtyF62RqXz9icJXVGvFn0shQuZytOU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=m/rwaVYRyrhwiNzeDi/swPJtjeqJ6hzjz0zmjSpsv68KvWhW1dawlq7AtTJYMd2jO
 etDDXsOvYgoLbBFBtIuPEb+bHOXR8pFXqcyt5fHe4h9942XugEr6BUfACFw1ESD4Yv
 k87VluyvP3L0x9Fgpx0yzDJ/fVpqjzUT6ct7PU9CznK3Udf8lfhsWTeKoWtWfva9nz
 CaprmoSJvrXOPOk0SVzCGZTjbs27J5XpWj61DAYWuJzqtd+dtlvMFePjxuLiLC1o41
 ompPNeaZPvJLVwyfROMxEea2+WvzxpbUpEJmmpyJQpAm/cQNARuB4ZOdnDh0xBO49X
 9QqxIOIGV6KbQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A66E617E0411;
 Fri, 06 Nov 2026 20:05:53 +0100 (CET)
Message-ID: <2e69b386374ae46177a2fd975814a31e4016c3d9.camel@collabora.com>
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
Date: Fri, 06 Nov 2026 14:05:51 -0500
In-Reply-To: <CACSVV013piWuVo87SuAGK+j9i+rj4cHGiOTX9kznE4ROJup0Hw@mail.gmail.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <062fe7dca00f77dac05197552d22897b28dc2143.camel@collabora.com>
 <CACSVV013piWuVo87SuAGK+j9i+rj4cHGiOTX9kznE4ROJup0Hw@mail.gmail.com>
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
 protocol="application/pgp-signature"; boundary="=-XurZlOBuCgoi/+wYTJZt"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-XurZlOBuCgoi/+wYTJZt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Le jeudi 05 novembre 2026 =C3=A0 13:07 -0800, Rob Clark a =C3=A9crit=C2=A0:
> On the v4l2 side, I'm not sure.=C2=A0 But it is also not clear to me if t=
he
> viddec hw (iris) supports all four combinations of P010/TP10 vs
> linear/UBWC.=C2=A0 I guess there is already some fourcc translation neede=
d
> between v4l2 and drm, so maybe it is ok to stick with QC10C on the
> v4l2 side?

Commenting on this aspect specially, and Dmitry is really going in the righ=
t
direction, V4L2_PIX_FMT_QC08C and 4L2_PIX_FMT_QC10C was under specified, an=
d so
the implementation didn't have anything to be verified against. Just descri=
bing
what the format is and what kind of alignment is needed is a great start. T=
he
stride is not being used in practice by the importers (gpu and display), an=
d I
think we can turn that to our advantage.

What I lately ask, is to just directly document for V4L2 users which
fourcc+modifier should this v4l2 format map to. How many planes are expecte=
d to
be exposed, etc. When I naively asked, I thought the answer would have been
unique and well known, but we uncovered issues. This comes from a simple ta=
sk,
that we must do for every V4L2 format in GStreamer, which is to map the
format/modifier pair to its DRM format, as GStreamer negotiate DMABuf with =
DRM
formats these days. Whatever we tried, either failed to import in the GPU, =
or
failed in the display controller, due to interoperability issue, miss-
interpretation.

On your proposal, I'd like to highlight that NV12/TP10 usage is quite broke=
n
(though its fine if we have to live with that for backward compat, we'll co=
de
the exception).

We commonly deduce the number of planes (or I should say the number of stri=
des
and offsets needed) from the base format. These two have 2 planes, but the =
new
doc states QC compressed has one plane. Same discussion happened with Arm a=
nd
Amlogic Frame Buffer Compression. They both are single plane, and for that
reason DRM_FORMAT_YUV420_8BIT and DRM_FORMAT_YUV420_10BIT got introduced. T=
hese
don't have a linear representation, they reflect the depth, the subsampling=
 and
are specified as single plane (single stride). The stride in AFBC is still
allowed, to avoid forcing the width to be a padded width. The importers sho=
uld
walk backward the stride to find the padded width. QC compressed importer
currently ignores the stride completely, so you have to have the padded wid=
th.

hope this helps,
Nicolas

--=-XurZlOBuCgoi/+wYTJZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCau4lDwAKCRDZQZRRKWBy
9B09AQCiNR+l/1e2VeNu+RNjbJP0jSKScgnUcsZqLFd8m2lwlQEAgTgIn5070Dvr
MBTt0SmP8C/5crzqIXMK409biSzy3gQ=
=mcCx
-----END PGP SIGNATURE-----

--=-XurZlOBuCgoi/+wYTJZt--
