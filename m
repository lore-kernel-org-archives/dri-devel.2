Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F3CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A7810E0A8;
	Wed, 20 May 2026 08:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Hrw0C5Wh";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B23210E0A8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:46:41 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so2499539f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779266800; x=1779871600;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U53nOZsze2BOUUWxn8xrqWn0udiJAimX6PJ2o0xVGTg=;
 b=Hrw0C5WhNPZANkr4YpSqQvsW3RhPfRU1Sq6fEKOWE4V2Ub/LM0LnXcEHF9KFeDasOP
 Pq2NbE44r2QM1OFciWLKqHMYfzMqEqueiUArdacUixO8Ls//DwlgfxTwNQ6IMaeOthOa
 9v2XdQicSIBXVxwzRruFzSrRW5n6SuJGCJgve6BixReeGILULefx1KFwFFJjpi4wl+s/
 tkjb6K0FwpWYxn01BGznyuJY7EKh94k3GvqWE/vLI01MYCy1Yofa+sG9kEnHQ94X3ajq
 UwvVSrYicG6cbJl1LJLbVBWK6zrzSl8DmZCYF7wBGkOxbyumEZIKYvaS9m4Zx5RknlcP
 sXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779266800; x=1779871600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U53nOZsze2BOUUWxn8xrqWn0udiJAimX6PJ2o0xVGTg=;
 b=bjvpQBk5/V7pDYdVPtXWZAweAzBwc4SjxAI77bP6vMY5DObZ03DNUioSXGan/kOHtj
 cBnKcNdMolsEb9EFH5R23JVeUQRnaWbMjrTywgLA/22NZrjnSmRqwg1ISqLMDczWEh1S
 GYfIhYRTScFmx88KSacInPI5bpyLRxO/AO7Qjqn6+fgm+3XlrSvcj78TMJ5qjO8DUuAl
 FoHuLXXklTXqHBYz8j1gWM9GAkXosSpFU10cUd1w/H5tcid/e+dKTj1Yb8nia9zUxBgx
 EFdmwFDCCzgsKNSOrgIBthZlYG3KLBJzWBMv6/O1D5uGv6zNqlUI4TgXiTT1QL5RsLqN
 slgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ux9+lgjzL32sesJtsFLfBUQ+ie5GGrUw1aeLAF3zzyZd0BWW46owzeNbnIMcoEt/8P4mZoZquWIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHA6c1pWE4Z7x3CmP6PCEFl9sXArG/F03aTTGfsbqnhabg2hbg
 rerKWHwzmAgCAbmCxKAe6xAwGeKAuIeTTHq8c4HzpI9EA6IJytWqqPHJdynhBcfMwKA=
X-Gm-Gg: Acq92OERkAdXKpqJO+5Ikk1r9RJbay6Fz1jn3C4Ea71PVTlMn8CBPpUcqlH8fQRn+QH
 O90Pq1493pv5PKt0xOTTpDC6p593UavaVYJZwnQI9amjW+akofWL1FZ/epIQXSCEpesj0e5V1Fc
 IDIsVBCdNp3YOMlD9M7Lfhzl+rI69/WUoT07paCYfdJBAh4ZzSBoNLtSIc7yozg8vtf+Fe9JzQP
 E1cAVZtVolFAQIFbfE9VJMVq9zIufcSdFILTHA8vSC7rJRYQC3W16Kp4fSuMDPIqXBbC7J9wTlX
 +Q8vyEaujcYyDqtDESA3EekiO9le+8uLm6a9FwkLJWbcovss2DjMNTA4uATf5hUhcLRcnURj59z
 gk9+lm1GTrYdKeTTcPiMpDtaW0C2hHqVQqyH9tkNEBTcMZioTGscSw/ZdqSBXBId202nww3c/sg
 C9djrsoMbhchyXLJDy4LvbUgwkcC+mxVKvejkUhTasxhVULX07Ux00c3ZEyk2Y2wed9MKacykas
 EBmbFSbqjAxkps=
X-Received: by 2002:a5d:5d82:0:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-45e5c5cbe4bmr36382479f8f.17.1779266800378; 
 Wed, 20 May 2026 01:46:40 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a02ef40d8e5825ac.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a02e:f40d:8e58:25ac])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45da0a19b1dsm51573666f8f.17.2026.05.20.01.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 01:46:39 -0700 (PDT)
Date: Wed, 20 May 2026 10:46:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, 
 Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-geode@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
Message-ID: <ag1xQVCCzXkc_Ucu@monoceros>
References: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4j765bpqgzr2splh"
Content-Disposition: inline
In-Reply-To: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
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


--4j765bpqgzr2splh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

Hello,

On Thu, Apr 30, 2026 at 01:16:36PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/f=
bdev/matrox/matroxfb_base.c
> index e1a4bc7c2318..22774eb1b14c 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1642,7 +1642,7 @@ static int initMatrox2(struct matrox_fb_info *minfo=
, struct board *b)
>  	int err;
> =20
>  	static const struct pci_device_id intel_82437[] =3D {
> -		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
> +		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82437) },
>  		{ },
>  	};
> =20

after further sharpening my tooling there is an additional change that
IMHO should be done here:

-		{ },
+		{ }

and ...

> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 3f6384e631b1..06aefad75f46 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -993,9 +993,8 @@ static void pvr2fb_pci_remove(struct pci_dev *pdev)
>  }
> =20
>  static const struct pci_device_id pvr2fb_pci_tbl[] =3D {
> -	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NEON250,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -	{ 0, },
> +	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250), },
> +	{ },
>  };
> =20
>  MODULE_DEVICE_TABLE(pci, pvr2fb_pci_tbl);

=2E.. here:

-	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250), },
+	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250) },
-	{ },
+	{ }

Would you mind squashing that into the patch you already applied, maybe
adding:

	While touching all these arrays, unify usage of whitespace and
	comma in a few drivers.

to the commit log? I can also send a v2 of the patch with these changes
included if that's easier for you.

Otherwise I will put sending these modifications separately on my todo
list.

Best regards
Uwe

--4j765bpqgzr2splh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoNdOsACgkQj4D7WH0S
/k7n3AgAmiu0dkGSmVN5iwDMsbx9u5oGpxoTfYsBdf+ieZ5EzDYhZzjAd5M4GNMS
dajrNSdkatRRbEZFE3PYDscIkW69PVck72sxOJdTDyAVSPf2hgi3mbElPpXW5ZEl
V5s0iKhXHTafmLPl+5cAsDOdMG19WulP1A3QfTepuM0kOEAKsQ4UwUV4AWlpBgH6
GMiJdyUX4viX+gD8zOIgyKPCjqvBa8CMPkgQORFA1fuD+eEbv1Iw1b0xDr/AinyG
8Jfn/ZzaAAnTJje43x8rP+Q5hw6uVI6bBHTrhypMFQ0C9ofIZBsv2BUyQ8Hp5i85
TX3Z+lJoWmwknV9WI68+rtnMMOgSCg==
=on22
-----END PGP SIGNATURE-----

--4j765bpqgzr2splh--
