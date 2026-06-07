Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BADCD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 16:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC74610E287;
	Sun,  7 Jun 2026 16:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="RjbyGt4w";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D42610E287
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780848727; x=1781453527; i=deller@gmx.de;
 bh=P9ygVdcRNdatwiZ+8FSG/CVxCwHJf6EZ0uOJ8eEeaxk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RjbyGt4wS2SBAatqBZ4x7GuhUhrCGJgJfRp7MXm+3xYLBLWnt/dBvUeUdr+5/+fm
 2gRBxh+7afxBd66cY+2qLHLY0xrLGRycrKRQJe62/reKEfbSdzYIocA05p6DbwB8Z
 7+AApPTQ74X2BcEzu2aQIw3FFF8v/WNsu1ngjc6C9NXI+GRQyOYZFsVD9ZMvvEhSd
 88HuSRLVcvFePRNGf0AhKnnXRcgCyFgDw+1/qeEmSRxNXDVDqf9WIqgaSyaUOjY3E
 993+JmpO5hl2xy276F5alDFMAyFo2gEpVF7d+kaZUzwjN897IMD49yI1Ytx8IS1P6
 cPkNHX3PzezaWnK0Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1wljd041ZQ-00KooG; Sun, 07
 Jun 2026 18:12:07 +0200
Message-ID: <2d96dd04-855f-45d6-8bf1-7b6704181397@gmx.de>
Date: Sun, 7 Jun 2026 18:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Tuo Li <islituo@gmail.com>, simona@ffwll.ch, kees@kernel.org,
 tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260526091507.421730-1-islituo@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260526091507.421730-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dgx3mkPQtp1Jo3Ch0tWWk8rZICGW6IALCH1GTHgK7mxf1eTHqFV
 kSfS7AVjEyEiAiDpXQ+Qi9ZIUti4LPkUGepuNKzY4itMYifeuIumx3s1nTER2LhQ2v6OEDl
 U8YZxztIiBMXQVBj3dht8z1lJKe61qK8VIAfesJRDiTkx894wq35dHTpBG3kvCWi00tidBQ
 qSxfZl8L55SUEZ4Slam9w==
UI-OutboundReport: notjunk:1;M01:P0:JbYK7FtmZ3s=;TdhUvvcnAubpr1xpAqwC84qAZ7X
 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
 bS4tBw==
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

On 5/26/26 11:15, Tuo Li wrote:
> If mode_option is NULL, it is assigned from mode_option_buf:
>=20
>    if (!mode_option) {
>      fb_get_options(NULL, &mode_option_buf);
>      mode_option =3D mode_option_buf;
>    }
>=20
> Later, name is assigned from mode_option:
>=20
>    const char *name =3D mode_option;
>=20
> However, mode_option_buf is freed before name is no longer used:
>=20
>    kfree(mode_option_buf);
>=20
> while name is still accessed by:
>=20
>    if ((name_matches(db[i], name, namelen) ||
>=20
> Since name aliases mode_option_buf, this may result in a
> use-after-free.
>=20
> Fix this by moving the kfree(mode_option_buf) call behind the access, an=
d
> add corresponding cleanup before early returns.

I wonder if this isn't a typical good use-case for the new "Scope-based
resource management for the kernel" [1] feature.

Instead of adding kfree() at various places, we could do:

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/=
modedb.c
index 703d0b7aec32..b6926764a99c 100644
=2D-- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -626,7 +626,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
                  const struct fb_videomode *default_mode,
                  unsigned int default_bpp)
  {
-       char *mode_option_buf =3D NULL;
+       char *mode_option_buf __free(kfree) =3D NULL;
         int i;
 =20
         /* Set up defaults */
@@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
                         res_specified =3D 1;
                 }
  done:
-               kfree(mode_option_buf);
                 if (cvt) {
                         struct fb_videomode cvt_mode;
                         int ret;


[1] https://lwn.net/Articles/934679/


Do you want to check if that's correct, and if yes resend a patch?

Helge
