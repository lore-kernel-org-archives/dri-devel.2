Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C8DF589D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7033B10F12E;
	Thu, 23 Apr 2026 13:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="FT2l+D/m";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2997D10F12E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:27 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7dbcf927395so3867336a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1776951086; x=1777555886;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OkIYMUDB7SvQNczi+a/z9LNo3qE9So2rbHE3TpVf25k=;
 b=FT2l+D/mDrkrOpU1Rwv4qSpVCSF15wZGH+ZfWe9h2lzeOEFly22stTngE0Xk+tPq83
 8niamWvNFdRwc324J11doPenaE1wE0daUDiPOB8eA6RmuUngO6SCNe4QBeMymN1vZ6on
 oc8OI46LA6kwW102tq4MUsG2o0+fuspkQODhLRWLAw1lnrILmJDb7GTns2OgETcf+xca
 ZjB1wlawvvGT4bwDHuKJPwoGidCSVZoquoCNPtGFiavkchfjhCY+U57GRfJVf3vW3X+t
 P0JkrbgRdJZMVmBLFIvsT4hHVXQOEHFDGxEqYP9xUFSgISxjQEN/FnUBjgx/tgiYBgJQ
 qT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951086; x=1777555886;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkIYMUDB7SvQNczi+a/z9LNo3qE9So2rbHE3TpVf25k=;
 b=lL+MPVgecFs8ivDmKpy6M3QFFdAXn8k2sRR6SO9rjJEAhCtIuYuGZnakTD5A8Hr4NY
 IQORfsMuPLHbV6eV7PS0boSjUe+Dj942s4kc/0Nwda0qm0w4cFNlNF64IJ74Nemq68Pu
 +uEv4NR5VTz4KCTjXiUuFjIB9NDbzJY0yGZqD9FVmfb06ZMruDYE7+IDn0ccdLm6Yrcl
 mbGM+otpF52++GYjqRwAQCFmBO98k7wiLR3z3EcbuUmmUY5/N76A3Y/jIVc1JkrAarpM
 jzeO1zr8Wp6V08TdhfAuM3le3KgoBZeHMdUwvi62irEIvJAfg8r5M45MkZlq9xXeZmtC
 3jQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Zp0RQjrTjmkPjWniz1MEc3j2Hfnkk6t3hpCQU9veJUYo2fOJkcdJA9xjYqrPUaGaKkCrDwKShueg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywuwn7o57tUHebEamvaJfxCeuCkyQL17TJa52InXRbVxUBJi98C
 o2429TBHXculCaNUOWXG8lFW8Tt+0EhzLPlL7msSdIKj81mp7Dz7eGG2//spFQ1vsT8=
X-Gm-Gg: AeBDieuQ40ngVxsvFpRWefGNmUfPNhU52jtP+j3iZEKeY5zOZPZZL3kN8AB3///wwgA
 wK5agbOAFDQ2/oIuv/aGNITd6o1URZygQxl7hEQjkt3nsfaYQ9j+AC4kY3w+gFbY1cgFlVjjYBD
 WKCw6E+P21n/2RW+ib4pk5ynx3uO+Amw1Ef3bGTQ7OwCCuifFYJELQd3UspLO0OganCB50zG4hD
 RpUOG/D2SxmTYv97BLR4iJF9dY3T9XgMEuDbxe8Tta0t/3dA5nz3TYUai1+s+CNu7PVf/Mu6Fx0
 P3RokDlox31Owu8kyikZoXtQFY7hy7UXRbn4D2AsotfppTOqOWdlSX5/pbcNtOy2JqBqmCO0frG
 5tNfif0nU1GNSxJKnqjDh4n8pTRXM1A8C8/bUIEXstFRcAJK6rzFhyFghEfi33lUvlBtxaOw1ut
 K1YxXUSoKonfZWpANdYzegZ2jRUZOI5uRsrAZ0pI05q0XBARUHrw==
X-Received: by 2002:a05:6830:67d5:b0:7d7:d615:3040 with SMTP id
 46e09a7af769-7dc951a8f7amr17141856a34.17.1776951085943; 
 Thu, 23 Apr 2026 06:31:25 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac462d9sm161750556d6.7.2026.04.23.06.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:31:25 -0700 (PDT)
Message-ID: <89390648a5ed37ccb61731d54b6241cfc6058882.camel@ndufresne.ca>
Subject: Re: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix
 cacheline EEXIST warning
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "sumit.semwal@linaro.org"	
 <sumit.semwal@linaro.org>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>,  "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "linux-media@vger.kernel.org"	
 <linux-media@vger.kernel.org>, "linaro-mm-sig@lists.linaro.org"	
 <linaro-mm-sig@lists.linaro.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"	
 <stable@vger.kernel.org>
Date: Thu, 23 Apr 2026 09:31:24 -0400
In-Reply-To: <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
References: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com>
 <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
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
 protocol="application/pgp-signature"; boundary="=-Upe9IeD/YcP+xQYdAbXn"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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


--=-Upe9IeD/YcP+xQYdAbXn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 23 avril 2026 =C3=A0 16:49 +0500, Mikhail Gavrilov a =C3=A9crit=C2=
=A0:
> On Wed, Apr 1, 2026 at 6:15=E2=80=AFAM Kasireddy, Vivek
> <vivek.kasireddy@intel.com> wrote:
> >=20
> > Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > Will push this one to drm-misc-next soon.
> >=20
> > Thanks,
> > Vivek
>=20
> Hi Vivek,
>=20
> I see the patch landed in drm-misc-next (504e2b4ab97a, tagged
> drm-misc-next-2026-04-20), which targets 7.2.
>=20
> Since the patch has a Fixes: tag and Cc: stable, would it be
> possible to also cherry-pick it into drm-misc-next-fixes so it
> makes the 7.1 merge window that's closing soon?

That would cause the same patch to exist with two different hash, which is
generally causing trouble down the pipeline.

Nicolas

>=20
> The bug is reproducible on current mainline and affects users
> with CONFIG_DMA_API_DEBUG_SG enabled.

--=-Upe9IeD/YcP+xQYdAbXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaeofLAAKCRDZQZRRKWBy
9LE6AP4zbpIjsamlcu/G6Lqh82xunsoqtFZgRGnace73ZbfDFAEA6PEngKC7M3Yo
K0RGNiwAl4iugWAP62doSTdmh9OX8Ac=
=JOLV
-----END PGP SIGNATURE-----

--=-Upe9IeD/YcP+xQYdAbXn--
