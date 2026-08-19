Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD723C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BD210EE53;
	Wed, 19 Aug 2026 16:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="M0QT3ZyC";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE8F10EE53
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787155648; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UO6IV1UhgEZ1g/bKGUtV8RyCUWycCpWgSu5/c2uZyE1xnu+0858EvgQJxEQ6qHp//a8Txb5oYCRVrnrfzQ3+5XBahIQ5+obRWWnJR3Njn4A28fEPk9RNU1zZ6ruHrwKYRjwKNswMmhzfaJuHYuZabKd/syTtphDjvXvZXsqw4Lw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787155648;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2xabvlj5sQOVFhU9bWVjggoXvyscfsuMlo/xx3gc9sc=; 
 b=CXqqLR2hKm8ROrQuEaNbzdaGsA2X5lsEvE4o1CKjWgA2EP7YLIl4bl6JI9nyw5NBxhK7udGBjjEQ+87d1Am7fydABd2KK98MryC8rTtLVxJjIbH1J7+8wDYWHWsvdXy1dBXFV2AJ/4OWc8o2XSqAQF+VIN12UFZIu/km2Wiuyug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787155647; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=2xabvlj5sQOVFhU9bWVjggoXvyscfsuMlo/xx3gc9sc=;
 b=M0QT3ZyCxdfDTIaUEzEqbgRCRkJWfJtYhJywiahz3E467DVBmcwcM+QgpWAUgVL4
 qrvVwxDnI1vuYvGlqHeCLMefIP3G73tOUtGlIND3MUr89rtwXtrl3Dg9Gz6p8TOTz8D
 GVvMaU2gNQT+NmRzppODuIZ28Px1rnRHmFJ700zRGB37rwpRrW9lXnJ+Z6gmJrhu1+P
 r+t/nrnrDlFXKNG6mHWF0KuGagTdJztj9DprWCPr2KzPFipNnrhs2RTXrpqReBmZR+H
 M8XdhgKWt1+smmemymBx4lExe6v1fT5dIuOs8R9HPAyUujotGLpvZuqS3JfiqEjCm6b
 5trFF779Eg==
Received: by mx.zohomail.com with SMTPS id 1787155646261408.0330107430441;
 Wed, 19 Aug 2026 09:07:26 -0700 (PDT)
Message-ID: <1e96490ce0d9435d7388bc59eea94ba78726cc04.camel@icenowy.me>
Subject: Re: [PATCH] drm: verisilicon: fix cursor offset field update
From: Icenowy Zheng <uwu@icenowy.me>
To: Chen-Yu Tsai <wenst@chromium.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Aug 2026 00:07:20 +0800
In-Reply-To: <178712436551.483858.6257003457851836320.b4-ty@chromium.org>
References: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
 <178712436551.483858.6257003457851836320.b4-ty@chromium.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-08-19=E4=B8=89=E7=9A=84 15:26 +0800=EF=BC=8CChen-Yu Tsai=E5=
=86=99=E9=81=93=EF=BC=9A
> On Wed, 12 Aug 2026 23:48:29 +0800, Icenowy Zheng wrote:
> > The 4th argument of regmap_update_bits() expects a pre-shifted
> > register
> > value instead of the field value when it's used to set a single
> > field,
> > however I forgot this when writing the code setting the cursor X/Y
> > offset fields, thus the write operation doesn't happen at all
> > (because
> > of the non-shifted values being masked by regmap_update_bits()).
> >=20
> > Fix this problem so the cursor is correctly clipped.
> >=20
> > [...]
>=20
> Applied to drm-misc-next in drm-misc, thanks!

Thanks for applying.

I think these should enter drm-misc-fixes instead, but at least we
always have the option of cherry-picking.

Thanks,
Icenowy

>=20
> [1/1] drm: verisilicon: fix cursor offset field update
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 6575bb5d0d3c7db0d7d293428ecc07cb38=
e46ecc
>=20
> Best regards,
