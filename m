Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA66EF8E4A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4799610E28C;
	Fri, 17 Apr 2026 04:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHb/EEmG";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B6310E8BC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:21:08 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8d65f4073bfso36984785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776399668; x=1777004468; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YAwqAUgFWlz1WbkXOJLiW/ZHx5MHrngRVjGH/BFqAUA=;
 b=dHb/EEmGuwLG8bcI5UgN4xIDMBAzqt3ei6JmQ6RruQhfKYuODLRtg9cjxEn6HeQiRx
 /5EibZcCbo2OOtnNR36c0ukLo2tHlQ6xriWgYtp1qwVq8qOz8YNSnDatkH/2wjrmt8r3
 4NoUSXvZ9Yf8FUdAgbtskay3JUnZE0ZtqCQwdqAx7x6UbHsvK641bud7o58EYRf5YJU3
 7Y1PsgfRJOprwt3mM7Mob9Ek3q+8PwjZLJ3tjbjHLyptPWR0WmtwgzbBrlOaS+ZMtcP/
 iW1MRPZfJTnrx3V8ABScVAbRrPVeIirr37K+pahMGcxBI8d/MHujKPawcwHCBt9YidK6
 JM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399668; x=1777004468;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAwqAUgFWlz1WbkXOJLiW/ZHx5MHrngRVjGH/BFqAUA=;
 b=eBBarS2NSc6aKALImkRZ2ZdViWKE5CegwbAUbsGICm7Bp4VqWD0NqPG5uij2egFofQ
 mB5nhvpp+6tFp6XMpLwIIA/IOm9y5fR1CE3OA5VFa8zizvy8obUb7cRbBv5OTUtgon/d
 Rj21DbEiMTFJcd8KiM1L6SWioI0j4bbJnBwGAUGTTYOsJNTvAfDLCggHnSFwo9aOVsWp
 wSJHnGgFmdGsAigDN5THmOOZhSeDrwht978nRQqcpusOzStIGeN588WqH7z6H1rIwUGm
 2FdvdLJimIsBzMTe1jwGp0x9MrC9mSKg/GQze74rVEA5kjSukRiUBenypw7iKQLISIef
 s+lw==
X-Gm-Message-State: AOJu0YwOoEi1arUKm6IjZXRllXMNRkzThu+QYTMG1CJhOAPkyL2NATCV
 ckqXATUNlYo24P32zNq4L899v4xWcRi6gcATXrQFbnBx7I/gwUMrqMud
X-Gm-Gg: AeBDieuYJPZ+ZMCaUgLra1vZmfzWBMUC9lU2WmpnbK7sLpHSBDwIOy8O/h/yvUA+Bdx
 IDzH55Oz/L8QZVlrsjLR3skW+zCcBKcJzGrYQx7QX9+VCYAVH/gLCnTZbXRgMNr8rZsjKSL7ULg
 MMWR7TKCaMXr0aYVsVYLovO0HEBqSmBWhDrl0QjUpkMWij05HPhGcFu6JXwDLk4i12rJo10KpFr
 jxjTfgPXmsXhmlyBRMdlebGkV+SXiu/PLFgqVJVKNuT/wBF3lRR7pjnuOsXBz9X8exw+6ZnwWSw
 sxZsc3I6h4wU9aTGC6QWQhaOLn0Hn/1hAe5+txmZi2JIxmn2BKEKwo/XZ8cVMgCxjk7GOmOvMSG
 gFj07oQXf8qdi/L5CBIZRRk4c+IkgJZSWoSP8sMCfJ1aTF0bKqOMlxdWzxF4hCqtVj0XSAUHGkL
 IzprQFJVdErizol/rE3m1w0x684B7nIoAwhDPiCiwF5IwGsnjjNNd4t1U38QQ=
X-Received: by 2002:a05:620a:4591:b0:8d3:e8d1:e2b9 with SMTP id
 af79cd13be357-8e792466e29mr155598085a.57.1776399667789; 
 Thu, 16 Apr 2026 21:21:07 -0700 (PDT)
Received: from [192.168.2.25] ([184.146.175.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb772sm23405485a.27.2026.04.16.21.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:21:06 -0700 (PDT)
Message-ID: <bf14d241-1505-4082-980f-e43ef20ea13d@gmail.com>
Date: Fri, 17 Apr 2026 00:20:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101
 Thunderbird/136.0
Subject: Re: [PATCH] drm/gpuvm: Do not prepare NULL objects
To: Danilo Krummrich <dakr@kernel.org>,
 "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260130191953.61718-2-jonathan.cavitt@intel.com>
 <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
 <CH0PR11MB54449980CA120479A4ACC019E5232@CH0PR11MB5444.namprd11.prod.outlook.com>
 <DHUVF2NYOGWV.2DQ3FJIPDF4B1@kernel.org>
Content-Language: en-CA, en-US
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <DHUVF2NYOGWV.2DQ3FJIPDF4B1@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oPqUmnfDT5d4OpDoMDs31wmN"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oPqUmnfDT5d4OpDoMDs31wmN
Content-Type: multipart/mixed; boundary="------------5pKB70xWtUaRpNN7p57yzLlk";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
 "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Message-ID: <bf14d241-1505-4082-980f-e43ef20ea13d@gmail.com>
Subject: Re: [PATCH] drm/gpuvm: Do not prepare NULL objects
References: <20260130191953.61718-2-jonathan.cavitt@intel.com>
 <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
 <CH0PR11MB54449980CA120479A4ACC019E5232@CH0PR11MB5444.namprd11.prod.outlook.com>
 <DHUVF2NYOGWV.2DQ3FJIPDF4B1@kernel.org>
In-Reply-To: <DHUVF2NYOGWV.2DQ3FJIPDF4B1@kernel.org>

--------------5pKB70xWtUaRpNN7p57yzLlk
Content-Type: multipart/mixed; boundary="------------qN5IEXfVoPdSHjs6ZwKMaUWX"

--------------qN5IEXfVoPdSHjs6ZwKMaUWX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-04-16 16:44, Danilo Krummrich wrote:
> On Thu Apr 16, 2026 at 10:23 PM CEST, Jonathan Cavitt wrote:
>> Question for the future:
>> Is Lankhorst, Maarten a proper maintainer for this component?=20
>=20
> Maarten is one of the drm-misc tree maintainers.
>=20
> DRM is a bit special in this regard compared to other kernel subsystems=
, as DRM
> also allows non-maintainers to push to development trees. Yet, those de=
velopment
> trees still need to be run by someone and those people are the tree mai=
ntainers.
>=20
> Additionally, there are people maintaining the individual components, d=
rivers,
> etc. and those are usually the people with the strongest domain knowled=
ge.
>=20
> Patches should be sent to both the tree maintainers and the component
> maintainers.
>=20
>> If not, is there a list I can reference to determine who the proper
>> maintainers I should be contacting are?
>=20
> Absolutely, everything is documented in the MAINTAINERS file in the ker=
nel tree.
>=20
> The best way to figure out who to send patches to is to use
> ./scripts/get_maintainer.pl. The script should provide you with the ful=
l list of
> all relevant maintainers and reviewers for your patch.
>=20
> Additionally, it also outputs people who have been involved in the corr=
esponding
> component and may be worth Cc'ing as well.
>=20
> If you run it for your patch you should get the output below.
>=20
> I hope this helps!

That's a great response! Indeed, the get_maintainer.pl is a good tool to =
use.

--=20
Regards,
Luben
--------------qN5IEXfVoPdSHjs6ZwKMaUWX
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------qN5IEXfVoPdSHjs6ZwKMaUWX--

--------------5pKB70xWtUaRpNN7p57yzLlk--

--------------oPqUmnfDT5d4OpDoMDs31wmN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCaeG1JgUDAAAAAAAKCRBMFUeUMaM0r8uh
AQCv9AxF10p8kqP1ks+jBMinUjAXh2QJKAZTOhNTmSFVCQEAhU3gAaLhpyO349MiHeeFpRqceXwt
Zc6PCQu2fumyigA=
=UIDm
-----END PGP SIGNATURE-----

--------------oPqUmnfDT5d4OpDoMDs31wmN--
