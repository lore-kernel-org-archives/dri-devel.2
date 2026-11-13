Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B39606A8AB
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXmohKPG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4333A11251E;
	Fri, 13 Nov 2026 11:03:50 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5412711251E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:03:44 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b5973a4b4cso1585616a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794567823; cv=none;
 d=google.com; s=arc-20260327;
 b=UxPAsCb15MKHe8GqCI7VTJJdpqUjzv2nv7zcmO0v3ADdcHHe1TRE8Hlcb+O5e9Q88k
 OSJNrpOsqdR3nUHKfY7gq0rLqKEsAjtGzGPvgQCo1bG42RvCmTOZ1gqdo3Yl4FiGQ+7E
 HLI8tiwzBqZQ3AGdLov4DSizGvWmlyQFQHvELHoWnH5LkV/yJkLOxZ+BDfBkuxVAw5hJ
 9MktMIXUoh6h9lOUDwhVfsp7taVrgtwit9Zt1XcBZQvbvR3cV2eSpsFhJZ3fj6eQg05N
 z2ADSJJyTnsdoY6THqvZvsAJtmFOncJOlsBFI67DJVXZnSxjq6296fGONlkUfqm4412P
 D/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+XFgRA/qctOq8KxdJ898btv3m6eGy5oWLsFTgKLCv74=;
 fh=NuXnrqMrLeu0UVpma1mhOJvCwBikHgavuXTfipAW8Uo=;
 b=r4UP/SmpEym2EDNBNd2oT2fFuZyPDa0H00dLvxsnsAzX0jbtUXyKL8LjF7hOaXW3hd
 qTFkeswzfBfkkPs3p+3r+OMNq6fxxDGQmvAr/vC7VBTuPgZdEAWtviTf8YQ9RC/iuxZ2
 F+pec4fZ02K+kPaGCljHH+wja7Qz0ta/voKAd/Chbwm+hr7Po7LoxTwAPIpg9iZ67ufy
 Y4gyt/UUpIKI8gO3Xh6n/ELAb4TyB+GVW40ZEulx8UqlEpn57jb7jLqh2GBn6tKcQON6
 IyL38QgkNId12xHcjDe+vmuMgBydLDIulEeGDfM2Q+8mylh/A/8FvwVSDZR/Jwe7szY6
 PZdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794567823; x=1795172623; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+XFgRA/qctOq8KxdJ898btv3m6eGy5oWLsFTgKLCv74=;
 b=xXmohKPGrCdhV9Qk/2qfMi9MytQQFT94u8tHQ/JfsF6XSJZSPg8CV4bjkarAvhjJko
 wlfbJRJG0Tq+iZtwZ8r0D98Ypi+DHTcpwLtvnw9dG7wZ7HcmNCZ01qoDzE12BR95u2vK
 MANwl2gxamnamMpU+Q9LIyNx3O1+JDO/WFk2S3T26SNzK234tKmcWQr+NsOA3cVJkxGT
 7ErnTccD7bCaNuhq5eARn3NmhTJ4Yqk/WQ7Xn5btezMlDczYO1SzjWkET+I8kBQYSh2c
 aNkCFrR/Oe1R404sK/OTw1wwaq4iIPY1WMgfQYUq7QpXCE8X13rbVRa6tTfxLHZRp7y6
 IpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794567823; x=1795172623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+XFgRA/qctOq8KxdJ898btv3m6eGy5oWLsFTgKLCv74=;
 b=Dxgf/p8fj7lBvtPOsLjmS1MKnz0cr96Njbat+qOhpNszWHVlGzlotBApgurmQq3NVv
 hz7lqRoKKJdP4/3UppMz4+NSB6G/PfSJnbUUhP8fexMzRNjZZNuEOgo1vmq9iu2O9Ncg
 O89GxKhGLT7ZVXC+m5aM7YnneXxu1k4vO7nTm4RviIA2lJVCFjzhkj8+fWf9j7SjY9ct
 8nHuT0GN2GEPTTTMeeh17MGr8ZGO6N4g6uwSnqwneG7O91NtMqNOS/iDzAylKzR/iVJB
 2lcrDA0goRbCMmpiuq+eVRgd2JujSVB8++pdRBDD/PBYUdYj8H5Cn3YPGEsoW9s1uM6l
 x+Uw==
X-Forwarded-Encrypted: i=1;
 AL+hErHsXY5gpElqSHzAT8NF06AuCwBOH74Mxp1L2x4pSkw1ke7cCKf8t4iwCbHI7GpLmQGZJGo7g3gd2yc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ML7rlL9jHmEIxnmvYhDK23Z/5MAYVC6cnW1c+AAtWv9P0kDxp
 7PM8aXnCN1MnE5d8vnifsc4i0OUQ7rj9P5m5xTcnfL6ba+Ok2BGgqpaAxrImkDscLTrDlRoUC2s
 x1+g5X+ryDXthP/e9WlsVpKuvk0jdRPo=
X-Gm-Gg: AYBFou29xUmZZZKvpgSctYmzPrFHbTnDtMrQd/+2uz6vrNU01141SI6OBAJo8Qu5BQB
 eaBBfPp1ZCUBiSRGKapfoMKQ6PlKVcE3v67PxqwXBFa3ovyf2amrq4wyPdfSIA5w2qlgMZc3477
 +o8sghu/sIDnDuVE7M0zHbyo5uTiZn87B0qJUhQfhGyBNgPzxX9q7FVefB2c1Qzyz9gb4boi/+S
 xPYz/QIStQxtGhSYSgWHAKCkj9KJanvdO6WhKrSA4NiGirmKYg6l5/VKhyQ0yyOCwSAvF/TlIR3
 loWPDZluU+nyE4/nBomFDO4+2F7WMSL3JuQuoFr/NbpIpoVC27cNetEB92bGHnvgVrK7kO0b8or
 z4vXiW0i+WU0zAqJZSbP9T/qRzxNNe2QAMNPpcHALRX3oxut/S1lNwIZ0I2ZM01l27n3DsJ4=
X-Received: by 2002:a05:6402:2109:b0:6b6:f3ca:94c7 with SMTP id
 4fb4d7f45d1cf-6b7c0bbc6b3mr2149392a12.12.1794567822515; Fri, 13 Nov 2026
 03:03:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
In-Reply-To: <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Fri, 13 Nov 2026 08:03:30 -0300
X-Gm-Features: AclHuK_-rUbrVMnuoLFJYOCKlETg6rn8GK9cAmGlyB9wed9wpYm-CIfhIxx8z1I
Message-ID: <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <jttelaak04@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="0000000000009623b006602661d1"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009623b006602661d1
Content-Type: text/plain; charset="UTF-8"

>
> I would say that Poulsbo, even being a pvr SGX, wouldn't be considered a
> generic sgx535; it has features that generic sgx535 don't have, as well as
> 1080p video acceleration while generic products in the same line are
> 720p-1080i


GT, MMU, power-management and video encoding, These are also peculiarities
of the poulsbo, We shouldn't treat it as a PVR SGX535, at least not just in
name, because even though the 3D version is a PVR, Intel had a large and
active role in it
Moving now would bring more bureaucracy than benefits to Poulsbo; there are
benefits to the SGX544MP2, but to Poulsbo? There are almost none

The DRM itself is named DRM/GMA500; it had a 2D accel in the past, so
that's another thing to mention

I would say that for the GMA500 and GMA600, it's like changing the engine
while the car is running, There is also the question of an old kernel

I would say it's worthwhile for CedarView and SGX544MP2, which don't have
2D drivers or viable acceleration on older kernels, but in itself, I would
say that in Poulsbo, it's more worthwhile to continue with GMA500; and
fresh news: my investigation of SGX544MP2 is yielding good results

>

--0000000000009623b006602661d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container" dir=3D"a=
uto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">I would say that Poulsbo, even being a =
pvr SGX, wouldn&#39;t be considered a generic sgx535; it has features that =
generic sgx535 don&#39;t have, as well as 1080p video acceleration while ge=
neric products in the same line are 720p-1080i</blockquote></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">GT, MMU, power-management and video e=
ncoding, These are also peculiarities of the poulsbo, We shouldn&#39;t trea=
t it as a PVR SGX535, at least not just in name, because even though the 3D=
 version is a PVR, Intel had a large and active role in it</div><div dir=3D=
"auto">Moving now would bring more bureaucracy than benefits to Poulsbo; th=
ere are benefits to the SGX544MP2, but to Poulsbo? There are almost none</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">The DRM itself is named DR=
M/GMA500; it had a 2D accel in the past, so that&#39;s another thing to men=
tion</div><div dir=3D"auto"><br></div><div dir=3D"auto">I would say that fo=
r the GMA500 and GMA600, it&#39;s like changing the engine while the car is=
 running, There is also the question of an old kernel</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I would say it&#39;s worthwhile for CedarView=
 and SGX544MP2, which don&#39;t have 2D drivers or viable acceleration on o=
lder kernels, but in itself, I would say that in Poulsbo, it&#39;s more wor=
thwhile to continue with GMA500; and fresh news: my investigation of SGX544=
MP2 is yielding good results</div><div class=3D"gmail_quote gmail_quote_con=
tainer" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div>

--0000000000009623b006602661d1--
