Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157FC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90F10E5DA;
	Mon, 20 Jul 2026 13:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Li06l+DQ";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8592A10E5DA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:48:38 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so976533f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784555317; x=1785160117;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QmCBjNjotMnuERLBel5nv9vg0rDycBvRi24F+jtO75Y=;
 b=Li06l+DQjNBJU1DcMW3Vz96LHLY4BLG5MOTlwqNvPNwXZTf63WMwYd1VjToEABO7Hh
 fK7FschTOY2g4hdBqDdkUjL1IpTC6CgFNbYORCpNmxJFvb9ew5TayPHz3X8B00jabUfO
 3sF5IYtHlmOCUyNOCgg4U/ouz3VDiZzlK+qGQTViP83Nof9TGIQLZqbgs3ZU57W7xbX5
 Ud1TzwHi9OrFbMbRy96IOoKqRUajSs+aNNadPkcTXYowR+hpDLR1Bd6nW/zJW576cMP0
 11JWhz2LboegBzR5YOehjbpRTOgExDOTHatogV88NeBTKdSy84a1Z9FeQazF3L2o41w6
 FGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555317; x=1785160117;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QmCBjNjotMnuERLBel5nv9vg0rDycBvRi24F+jtO75Y=;
 b=AL56RiAwzR2hQgv0TikGjgHfc+6zUzTU6GJV6Zgt/UESW7k0QBv7BVi8WXVHmFc9ho
 BwNMyUV+aZc3nqVN5gZTWQhvduYrRcxJsXwwz6r+yfITirA9dP5t6yMlZhu46xEvYOEK
 PpEybZu98EziqQgPo1gauA35p1IZiqpk/MZ0WfeiZkKLlbS19DylDS7UHIQ0Jo0Bqi2w
 CYxj+l7ek7WFFAHK0e4//UAcoUYLge7z0DC+uMC9yeOcezxncwJVTjVNN6YvRPXUoSUN
 tu1/tce44h5Xge3s8J+7q1h3OuM/G7P726ukEy29mXSMG7D3fPKbLvgLglSfUqTpN5WN
 xqEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RobRBNJXperqtVibg9bDjNsWCBYijR4VD0nYacoeKMqBsX40eeKYwIHjGz1rqHf280MmkbjPIVThAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9SPltRSY1V634gUUGe7++kMKpb02j+PDdllA1qfJvkNYOv5EL
 Nfjvjz0cYzqC8gDlSTQ9HTvPqGGxT1B/wsB2K1DLUOOWJlbIz8Y/798O5yfcfhn/Xxg=
X-Gm-Gg: AR+sD121N4vRp4SMtBnkWuxlKuWQAFRtr0LuPgsXnK3MtqKRoj6bkB437/3YS22GxcJ
 jlMp76VIm5OUFLy/GifJeWtmxsblZ51yRQ0a1xT0MzWT7aauyA1AbR0BxZz++YXlc9dXKEaHwNZ
 xuW2uolifnb1/Qrlgu8BpFx1DlgQKL0tsH17T9ZTyUFHlu4/fLQ/dnoXdtfyAraFntEbrVfTrdK
 +gY1Mqujnnq4A4nPud+6JEoR9hpb5kV2mL3pHzVtl/nK+/lRrU6myX00dOga+nfPUq4iRkyd2XC
 2A8R8oTzI3edrU8MKuCVr/AH1lXt5zAQedU97gnbEw2EVrRCmQ88qNlJ8qBXwPpPE++ceiVi9of
 Q3nyYvQDIaqaAAS6wyBaemxFb0/ZDzkgIiYrENbWJSKSouH7q3PTZL8Cgev+kneSFvc8zMh4o1T
 XCu8SOsYgoGwtVMKt6x3XH207n++v7riFzPSECvkAStUCFEQsceIDe56zl4x7+5po1Jw==
X-Received: by 2002:a05:6000:71a:b0:47f:2de3:b34d with SMTP id
 ffacd0b85a97d-47f6233498bmr16462661f8f.46.1784555316783; 
 Mon, 20 Jul 2026 06:48:36 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63edcd13sm29610037f8f.26.2026.07.20.06.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:48:35 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:48:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
Message-ID: <al4m34a1ZG5UTroc@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
 <56983c6a-6459-4145-bf6a-909d2f3ee9a4@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ere6fq2b6xkmdent"
Content-Disposition: inline
In-Reply-To: <56983c6a-6459-4145-bf6a-909d2f3ee9a4@suse.de>
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


--ere6fq2b6xkmdent
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
MIME-Version: 1.0

Hello,

On Thu, Jul 02, 2026 at 08:45:14AM +0200, Thomas Zimmermann wrote:
> Am 01.07.26 um 19:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > Having an empty remove callback is equivalent to no remove callback.
> > (The only minor difference is that with an empty remove callback
> > pm_runtime_get_sync() and pm_runtime_put_noidle() are called.)
> >=20
> > Drop this useless function.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_drv.c
> > index e766d87b7a9d..e3f41336a831 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -45,10 +45,6 @@ static int hv_drm_pci_probe(struct pci_dev *pdev,
> >   	return 0;
> >   }
> > -static void hv_drm_pci_remove(struct pci_dev *pdev)
> > -{
>=20
> It would be better to call drm_dev_unplug() from here.=A0 With a bit more
> work, the driver can have hot-unplug functionality.

I don't have the "hardware" and thus cannot test. So I won't tackle that
suggested quest.

Best regards
Uwe

--ere6fq2b6xkmdent
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeJzAACgkQj4D7WH0S
/k4kJQf+Oa7xsTZm7Dflio0AOE9QUQev3vXET7Qbxr5n4Pon9N8JnccwC2OYjrfn
maAAVo55m4s6vSSkJJ9JcsDwDl6ZeHu64t2C470QWl934h0XwjusVqUKMpvEAuzX
pJBHoNKWC89wSHuarv1TdzyRfvn/C3DOJrwuWKHwvGzycrTIBfrwZVB6Lx0KNET4
sWawarbS6BVYKjI2o5OcZJXpgb6rIU5hL3Hiseqv1No4vuNH5daig+RrFcw5QyaH
WQg6KKu0PZ8ESc6dsXc2Gg8mrg1exCAfVyprdWTq5bSPd8Py/g1lnWoYl5bD4i4a
TJiHLqHgaDVcKBkgSh5htoErLY3YVg==
=vy29
-----END PGP SIGNATURE-----

--ere6fq2b6xkmdent--
