Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F2CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 12:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3817010F0A8;
	Thu,  7 May 2026 12:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilKC27ot";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B0010F0A2
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 12:15:42 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so9706655e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778156141; x=1778760941; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c0hToDKSMnxbi/5ufvYd8KJ5BjxBoSfijUk4UFSKZpU=;
 b=ilKC27ot4EEvI21VKPUYtgZzCjaUSSEhXqvfKyBnio1jEnhBTYo9GwfbAAkkNUgG26
 76Pe44gC4KbhLuwwCGbiYTsxGJyW5QULuYFammpThnPg61yGCPgbGTk8xCvJzZuBu+5j
 Vv3ZEXXDZIuSTPVTcwfIlfiOQbSJLoxgCftuDz9Z/JE9KG0xpfMDz2NoMZg4gca+pNns
 0pb+S+ii8vn8POlVpGv/F83tCvIo1rbouJFfhjdIeIbnsw+qs35aiGL09sGresQUnbtj
 2jCCqN6+T2mUlESn0DtF1IRbyxi7s4Q/DtguAmjqgKjolKlhx9nqCJMyOsbnk+1cIjm1
 SQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778156141; x=1778760941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0hToDKSMnxbi/5ufvYd8KJ5BjxBoSfijUk4UFSKZpU=;
 b=TjTNK4UqptBFpGyDDk9GZKUbqQMpFVZI6OQhDxHPIAmHF3zBN8Xp5pRpPH0+MJrWdd
 1C4pXLMLrJKK2hH8/pqOQBhS5yWRrU1lCE6eFvP1scQtbLBesJckD/R0d2O8/+m/T9oI
 QFH6SMRl3pyBNA+vSecPtbrgxDPEmJnQdiJ1XO4OAOYIF0T+X+W4fydZX+Injuou4qNF
 fffLcAzHq68l3FCvklIk6vj15XzH++Zj1QaxtyPxF1t1sXnV7tmX/d+P1Ja5pXCcw55N
 p5SPnDVnzK/nR18iKO5b+joRAB4DHMwj1SLjnxGWclqE5Z7THUM7diwlB0dduLsjyx40
 JRpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Kb87rLDpPcQbdvpqKrIHBGFbYoWZoN5YIEh/pXcJWsHTCQrolFCLPsUXn1Y7uaXIwyTdRMGN+82c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOW0rTZ3C3l3UYc7/12v72DFZ6I3U05kRM0SZPoeTIYsNwYwXx
 Wxtwh0W2Wiyc+YTuZ7AMrQQ68GUM4lmBeWn6QtYCGEYTusfbp3hWWiiB
X-Gm-Gg: AeBDiesCkq9q6ADlxf8VTIng/VnFRet1x/7ROznks0M34kFHfEf6jgiwz65Gbb03y3z
 elAvSKugxwngVaZoHach1F6jeUJXTMFtxqBW7djdlStVedIX92tn16j+HkfCuM+ayNTXWH92nED
 eEOER8wAv4r7Twri7MeHfTMwWVggjfPd54bfWRcmOW9KBGKr1j6pwVusrlp2a1nNoXZ8y/m/jba
 im5AdETvca5Xq4FsjEm7EMkd9ytmDm6sReX0DbB4Y0KLzT3UlPGhQgxK4vnCONkWd18JK9YNk5z
 YfeAAFW3Rm6hIwlGSfEYcM93owyDIWAPvSRSMlhLyLgMCJ3heIuKNA6oIT9ML/Jhp09zazZG4PE
 gl0dn8zHGllxHXm9GGToRAGf3wi5awjjHdhLvYhDQWRTxZ0gcra+e/7V6yMr4Hb3+W9g03IG/36
 wcvajRz/AiCkJodDp1MoDisDfnAv4p/6/Is1oScB0AaMnR7wkXq+4pvm6JVmMWXwKtW6/MPXzJg
 SvJs6zon/GYwoT9k0bIW4k8
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48e51f45eddmr121794395e9.17.1778156140136; 
 Thu, 07 May 2026 05:15:40 -0700 (PDT)
Received: from orome (p200300e41f1c9800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1c:9800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b212esm52203795e9.1.2026.05.07.05.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:15:38 -0700 (PDT)
Date: Thu, 7 May 2026 14:15:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 DRI <dri-devel@lists.freedesktop.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>, 
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl-intel tree
Message-ID: <afyCC_FE9QL5VBBm@orome>
References: <3b729608ad4bc3bb161c3779a9768b12@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zxepztxp53sv2ewk"
Content-Disposition: inline
In-Reply-To: <3b729608ad4bc3bb161c3779a9768b12@kernel.org>
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


--zxepztxp53sv2ewk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: build failure after merge of the pinctrl-intel tree
MIME-Version: 1.0

On Thu, May 07, 2026 at 12:47:48PM +0200, Thierry Reding wrote:
> Hi all,
>=20
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Sorry about the misleading subject. This was indeed introduced after
merging the drm-misc tree, not pinctrl-intel. I need to look closer at
the templates that are generated.

Thierry

--zxepztxp53sv2ewk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmn8gmUACgkQ3SOs138+
s6HcUA//TIusmk3FnAe7we2CgaOJ+sqg8vpo8WhTR3tp61urf1xbiecKbG0xC7ou
QJykdzlYPfSJYlEnJrSEakUAfpohy/38qKYtmguUVBfCH2YA3tuCFVy+9ElidkpF
QWbUwHQ5NjJnr5rMIVnZDzcOM52NWfozCF+nXS4JRwA9krPK7FQI+yftv/ystF+c
o8ur3EofGq6BQg885XNFd2FRGlsJsYBA9v6OWwKx4M83tKvlA2u65+vUPsNbo9So
X+7fBWqK3P9jf/r0gBxImInqgkPcNwggNMG++u+Ngj9dxaNa5UDRAC+DgqJPAMef
8C/2nofhRjWRSHxlWSgoWc2wmjUOFv85G3rQDr5cipG0b9Ws2b0dJFPCJf3wIaUU
bYRGl3OoEMI6TP5vdNnST0P/Z/9NFxRWpBEA5tVogpEbVw29mfTeLzlQzNorjppq
ldulosvdNBuRNUhMelHYX6DQ47WmDSdCJBfLtsSvXiiEhtYGHmgg1Z0GtusVAE9j
yEWdNbQi6hJnj69wraT96UeW5YjTQkRqWlAcAYiIkQ/eUWlv85ComEu/IQZNsS4r
qYw4RSmVUbhAcPT1LBNPjYqQDc2kEESrZRnYWFXv4EwXvcDFgSpXIQO3YhHRXASd
GTByz1YcHtIBEjIRkVUGiICQb8ox/Fq3/wdK/F9NTLKnA5wzHcE=
=NXs4
-----END PGP SIGNATURE-----

--zxepztxp53sv2ewk--
