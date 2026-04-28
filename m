Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32301FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DC010E095;
	Tue, 28 Apr 2026 16:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HFJuzpxZ";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B6A10E2F8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:39:56 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so6529592f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777394395; x=1777999195;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UGZ5OH13xNNWGffq+mixPjAxeqdRTmGto/YCnxWBxN8=;
 b=HFJuzpxZ+zUxwRNvwE15DWP4tbgLeg8K5N2M3bFwdBY3gRQMqxoPJkfpSgyN/Spajn
 Srdxe7vIj6jbvsQzKBVdyUVWdW1QMxx70aD3ql4HkrVgER4a9OxpN3ysNcTkJSrKsGKz
 6EW9c4G0VrXTxdchv5jUk8YimZpg92NKyYKzu19rl+t31EV2o9Ij3EteIKACpWjeo3c6
 9H1jcKhVS6bNUaJjbvIGzlt6FdBzQU2P2+3z3jvfqozHlww6dVL18oBPD7EO85ohxbWL
 5Cyj0FOxNshU6qvlYPvuD3/DJPY0I4zAbdCiL9V6qzjD1kAGd3xjzmpr+1Rufb9nS2jW
 dbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777394395; x=1777999195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGZ5OH13xNNWGffq+mixPjAxeqdRTmGto/YCnxWBxN8=;
 b=X7me6oqNvMZ2B/FQ3Vhtjr5O+Z7JZCZEncKTY9+/9jYy+TzSlb+dUaeEWoq3eaWXcv
 0GWqRwHvt9SeCYk2q8i5vFRUTGhmkUBAeGaH+JxMUkvPWApCmS3UJLxxbh5oXhVj9jRo
 19KzUJK8ljbxOFPg2iLUdcosVHV6gynYNHsorlEgaF2IqxbJk4bAeUXJqujNprPs9LRm
 r/BQKXBhzHC6wJRlrp/rL1Xmq9CXqhEiAcyXgKBnBTSEEWa5BKUiK7KGsHxYEcdyTfO0
 Du1zoL9k5yrcgDDU00UpZwl3cVCXNICxQc8LnkMzLG4BbCYb++E8s9M9O3TxYo+VKMHC
 +FrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PlGDd1OcYgHDiBMXPBXzb3G22mxUFSEvxQ3cZlKjLUD4OxwiQ3mzgvZri36LYhjRIjyBYjvJnfkM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSJbuf9tceAU5krIyVcVqYEJ2gKy3fvlYn4PV5fqDUoQMx1VGM
 pDHQeGva9IGjme5xIjiAQzlM1ehlDULmMMgajI25sBcxyxB1xy3AUUHZGFQKr/FF83Q=
X-Gm-Gg: AeBDietkQE39gEV09HKhR+2Tsrz3Tsm5DgGK12HWAbBIMyi1d0epqaa1lAViHTLeWkz
 Qbq93AL9UQyA4qnEgrCaNytJaQBacWvFLqokMLV5gZrJ832sIGCBQOX06m7rT44nvJtmM0v2ypY
 CijmPkclpVlptw9Bn6TXgfvPEzT+UwGuwFTxXOqrqqcREf++xqERGgt5GZWJQEc29+KCR9umi4x
 2mawa7QCmO7zcPiY1qo0EL3hOANgeBueAb7RdXNgwRDAFPO7Ceu1S2pFXNpXuGJrM9/Dav/Dk4B
 7by5473DhRQckubVj1vRWs1sIDyHhi49rLZbUfYmGdIcfLtLZBLlkRPjPnMJKYSj11LMcx4AZ+o
 n14tr1q06s/OFDqV4Z5VrEx5gL9ZfygD2ahVkSX+TekVIBZgjzXt0ULM+rEGQkFnwCFU8UGNG6x
 y4nesKzLS6a8eZEUorLpe+ANpWQW1hsYe5AvgXRq/+844ljixPYxiaw5qegoEM0d2WAPDxTR32D
 JO8edAHKc180jUy/xYzCeCCwQ==
X-Received: by 2002:a5d:5f85:0:b0:439:fc2c:363e with SMTP id
 ffacd0b85a97d-44648b51201mr7294713f8f.13.1777394395342; 
 Tue, 28 Apr 2026 09:39:55 -0700 (PDT)
Received: from localhost
 (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4463fb7e2afsm7393191f8f.28.2026.04.28.09.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:39:54 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:39:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
Message-ID: <afDiNw30ud7hA4CN@monoceros>
References: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
 <afDYn8Uy6PwvOVbH@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5wg4hxtb2iskpprw"
Content-Disposition: inline
In-Reply-To: <afDYn8Uy6PwvOVbH@ashevche-desk.local>
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


--5wg4hxtb2iskpprw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello Andy,

On Tue, Apr 28, 2026 at 06:56:15PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 04:45:53PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> > uncommitted changes in the source tree or new commits). So when checking
> > if a patch introduces changes to the resulting binary each usage of
> > UTS_RELEASE is source of annoyance.
> >=20
> > Instead of using UTS_RELEASE directly use init_utsname()->release which
> > evaluates to the same string but with that a change of UTS_RELEASE
> > doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.
>=20
> Would you like to submit similar changes against driver/auxdisplay?

These didn't pollute my build results so far, so my pressure is small.
(Two of the three are not relevant for an allmodconfig build and the
third depends on PLAT_VERSATILE which isn't in my build matrix.)

I assume you ask because if I say no you'd address that? In that case
please go on.

Best regards
Uwe

--5wg4hxtb2iskpprw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnw4tcACgkQj4D7WH0S
/k7N1QgApisEJnKTkOhLymWxlJq5f+uGc07LBKxZRs2Yu4UsC4pfh8kciX5dOl10
yoFQyQpMG35A8DLdGgpW37An6KaLzq0Lpb+4YWso0vcyOBcNd+zhiU9YkTJGPstU
Xk5/dXB+nseXqRku4tb/x85eW8hMUQIONNQeQWvoaeuyxomXlKYoMX4+53dILFnE
x4uIEPyWVe2igixQlgcfYS8Tq2bEM97yzhOCewycVl7iX5OK2EEmCAsC/FV7YLei
O4IYo7YXWDRPdj93wBnHUOYMLfGtnQ0muy8Zinp24ak8Rixqe0yI9jCc2RK0D5AA
uu4Npn9tyrK7tAPEzvTlCS0n7uqDqA==
=iheh
-----END PGP SIGNATURE-----

--5wg4hxtb2iskpprw--
