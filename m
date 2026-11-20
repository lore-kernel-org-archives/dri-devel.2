Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96B606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5MIlsoX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69B410E64F;
	Fri, 20 Nov 2026 15:31:40 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F7A10E8F9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:31:29 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3863db981d4so727795eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:31:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795188689; cv=none;
 d=google.com; s=arc-20260327;
 b=bz8w4sbEdYpDVBelV+yX7JdcYRtbVBd3POqFr/WFSR/sWXMnk2w6fdLt9lFVZ0Szjw
 S698JAfW5bF5Bt061jiy7Tz7P85jamlm2RBisRbHRagXMzg4limcrKvhrOFQ74/fF7T+
 GYQnoZ0Hh+Aok55z7WexGivhFQU+Zygql+e+kjkwVLGF1MSEwjoz5C8r7KF9Lxd7zD/X
 Dk3a1SQ303mZNF75CiWXQC9traZ1EVXgVg15g+yETaOke8iPx7xtU1swhe3dDYDfW97j
 mcchMbKY6+w8yHk99dvK67BitYn7aa8umjEB6mgaljOWmAFt9RuH2gWnI57fd/a9x/ll
 +1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FJdGxpeLcA+HNojMQbXEX8uXEAU5T/sehUXMK1DtacQ=;
 fh=KnlcxB0igq8Cy9dxvvzhJvwvxYz7F5HEqIaw0MO2JsA=;
 b=AQjxxkhmYFnyCgynUy+9agh1fw39PM2hsQX2772PeJTgtFbG7+Plmvry8WlD/P15u6
 0IusIP0bxkv9ugXgJ310QNy4MsIVtAkNhfKwRagPL51TYs7vExBHVAjAjEwvmRMD6IgZ
 D0zcJDtSW67dmMFzB4eu9ZCVpv8JgI7jVq+u6MnoEk1ljW+61LNTlFiCrx+VCl22Zo/J
 /LL06oV4a5Az6KeMcxMaPNEIohPqiuIUqcRcKn0HcfwOHIU0jvAGEX4MInVD/mA/9nnI
 p44iTm5pDYXHORHwh7O4D2TLO7YARiYk09QMFKtfwvMQMcQGa3r4/JkXK83DzWT1HSuO
 ACdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795188689; x=1795793489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FJdGxpeLcA+HNojMQbXEX8uXEAU5T/sehUXMK1DtacQ=;
 b=F5MIlsoXh7VqGqB0/9Ayt7pvbDH/yQMtbHjJcsbsbno/rHXZ0NlSF7ehJglUC7Scv+
 4+8RAPPZ2nPH3AxWprsxanpEVAnDrd7mQsa0dAtSlsJTtkD/x5vQRG06za95QNmV31rs
 xa5iV1X5Dh9jLRCavxV1aa4+8kGEkvBiAPgpyKUYPSv5ue9UBfy4uplvnJG0Nwt9V4lK
 3ruia/0FJ21fLTl/DhSwmmrojlBe+harI8r3uBtYMdwpDkWJwJVHu8xvtDwEgV1D5ESv
 dtfYJ0CihnKotq+ufb6twtu7d9+fEoL9N5GZV7GPa0EI65d6PD3E41wUrl6202ihjCcl
 uf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795188689; x=1795793489;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJdGxpeLcA+HNojMQbXEX8uXEAU5T/sehUXMK1DtacQ=;
 b=TVaCethODp1XdA6ofXYiXXZWQW5PhAbz6zs9RHJyBNgPGyHX7voTJnQYY/asYeMvlr
 lVj5FS91zQyTVwrpVqLNyyrTR30mSNRw009e+/Hq5w7vNifKK6AzsTDQ2b6+v2MpfXzC
 0g3SKNz2wYWYQR7FuLpBr1xqNjmA5Aq/III6JgPqs/vhr3LDIG5gcWNC4IBN84dObD9a
 H9qauIqFDelKpnB75rZTvG5ncfQNrYAQ8QZrmRrEHLxQfeE/TY/6H9bsDJCJM5BXSbQy
 e0qlWhyLTR2i9juzQJcxuPr4AmRfS5U0NjqTx0QixdDWF0gMvhXwQp72Rq6tiPBjRKGT
 bsFA==
X-Forwarded-Encrypted: i=1;
 AL+hErEPdhGLo/DL4mfQuSZBmUuBJP1Xrt/LBWcYXIjV63m07zHFVdxRSVeM3ePkoSrM0GDQLP9vjsiOZR0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8BtVBXDjZmbuPMNgrSYrfk0T/mQ4V9iSBOYzNG/mrLU4brl9pt
 gIP57Ws2j9LouTM0r2Ua0ULYExW4GVNidQu9d72ey++El5Oqmf56QRwvSEo3dICXql9nfGvygRG
 AM+eE7os3rCeJR/HBq7Zn4SJ6EUodtZE=
X-Gm-Gg: AZFdTZfe57HT8NfSfQvNruvzIFdKIa4yinj51HO0UdZMRyqXfArtb6eQm9h7W5bAWze
 8TYwQnhz+ww/DM8g9sp4lZXW9/HLXeq3GMXdKNaP1U/1ZblnXrYMlOBZMMOimk1QYvnONZ9QKHa
 YtjrkCa05EdfydxhBnY23uFSLArBnuNr/myd9/pcJNz9gRV/uFOk2yh07XJUq6yf7te9Mg0P4xd
 se75vRrvzJUOFrf53UaN4ljHJCDgldd1RcWmaIOlVErHmrkBQFMll5dJ0xtNyt3KwcB9FiU/bbM
 rr7y5mCvbLKXGgGT0mKvyQTpCatTf+VyYz6NdVDaK2zdmtWrDNY28UaOmphqvfXn+p4p9A5YLls
 yb8nEA8vKcwF0LEyj07qtwfMDeV6Rnv9evSk3imS2Ac4cf862Yzgw0Y/y3mtEWj5OjIlrKEOt2B
 OnLvBHSHNF5GRJRbzKQAGREJbv440XvMTGJBWn1nDNUZ3K9ifthlQ=
X-Received: by 2002:a05:7301:6408:b0:383:1bfc:f1c0 with SMTP id
 5a478bee46e88-38570f27a56mr3129077eec.32.1795188688670; Fri, 20 Nov 2026
 07:31:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-2-clamor95@gmail.com>
 <20261120143147.GA2466366@killaraus.ideasonboard.com>
In-Reply-To: <20261120143147.GA2466366@killaraus.ideasonboard.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Nov 2026 17:31:17 +0200
X-Gm-Features: Aa3M54rmNUuNZyda5qhpJslp9i1jTMK9Hg275DVhPVt4wZMMMc9yhIUe9r0PTkY
Message-ID: <CAPVz0n3u3oe1+H_w9jE2afb9PQT0VLtYVqfHeVNc3D+tLN6NDQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] staging: media: tegra-video: Move driver to
 media/platform/nvidia
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>, Dan Carpenter <error27@gmail.com>, 
 Hungyu Lin <dennylin0707@gmail.com>, Hao-Qun Huang <alvinhuang0603@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:3=
1 Laurent Pinchart
<laurent.pinchart@ideasonboard.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 13, 2026 at 06:18:10PM +0200, Svyatoslav Ryhel wrote:
> > The Tegra Video Input drivers are mature and developed enough to be mov=
ed
> > from staging into the media subsystem. No other changes are introduced.
>
> The driver should at least be converted to be MC-centric before being
> moved out of staging. I haven't checked if other changes would also be
> needed.
>

Does the media subsystem deny video-centric devices from even being
moved into it? I have not seen this restriction imposed; could you
please point me to where this is stated in the media subsystem
documentation?

I would like to convert this device, but that may take quite some time
and may case regressions if not done carefully. This patchset apart
from moving to media is mostly fixes to work correctly with mt9m114
and tegra114 bring-up which is quite simple and straight forward
change.

BTW, may you ack mt9m114 get_fwnode_pad change[1]. I have updated it
to your liking, Sakari seems to ignore it.

[1] - https://lore.kernel.org/lkml/20261006153619.304520-1-clamor95@gmail.c=
om/

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/media/platform/nvidia/Kconfig                           | 2 ++
> >  drivers/media/platform/nvidia/Makefile                          | 1 +
> >  .../media =3D> media/platform/nvidia}/tegra-video/Kconfig         | 0
> >  .../media =3D> media/platform/nvidia}/tegra-video/Makefile        | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/TODO   | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/csi.c  | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/csi.h  | 0
> >  .../media =3D> media/platform/nvidia}/tegra-video/tegra20.c       | 0
> >  .../media =3D> media/platform/nvidia}/tegra-video/tegra210.c      | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vi.c   | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vi.h   | 0
> >  .../media =3D> media/platform/nvidia}/tegra-video/video.c         | 0
> >  .../media =3D> media/platform/nvidia}/tegra-video/video.h         | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vip.c  | 0
> >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vip.h  | 0
> >  drivers/staging/media/Kconfig                                   | 2 --
> >  drivers/staging/media/Makefile                                  | 1 -
> >  17 files changed, 3 insertions(+), 3 deletions(-)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
Kconfig (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
Makefile (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
TODO (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
csi.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
csi.h (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
tegra20.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
tegra210.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
vi.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
vi.h (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
video.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
video.h (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
vip.c (100%)
> >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-video/=
vip.h (100%)
>
> --
> Regards,
>
> Laurent Pinchart
