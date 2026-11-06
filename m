Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE768606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDTWOVXb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D08F112DE4;
	Fri,  6 Nov 2026 14:01:31 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEE0112DE4
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:01:23 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-37000e7234bso1436681eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973683; cv=none;
 d=google.com; s=arc-20260327;
 b=Jh0ENgpuc8s1inkN8VoQtMMeVEP0/xIMYauVVAVAgoYdjFcbSmp9Nv/hctb+48xdZn
 VYK+8jEHe1mCvqoLyKwn5CDYUy2I9MbBv3ZAIzgDYHv0WhuMpTbhLTnLOH39Adz5jvMK
 53ScVVOqYr0C80/Yrs/xNjZvawDJZ1ct4buUeKSKV/T/30fnhc59o57o8PsZYXeHeqEU
 hK52s4uTMrubpa2xPAPjXTzkG1nNJuKaMf3UTxFdp4ZPepXCs6VQmTppGj+/p6gqd34l
 bUDYdM2T/a0k8pE6AG3FKIC38qWF96dirhzxmVWylIZP1uVIzr3uqO77Sh3k39cJmP2C
 i38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YXw7NOr17pjMQ7VC9050ylNljX4Kxe1Gs6cyljUb+Z8=;
 fh=XjyuSqlVMExAj82e/CoSjWSDE45MpCq4SQoxPNTbiXY=;
 b=gkCEh9rQQcUOZfzZaEKQOwGEmMs8WVQJxstBdIBUGiXyn4sXgmj1rXkE8HwC0Fle3s
 mMUWfgFD5kfGIR02vJSv9QgVPpOlX3H6KKlC7ljXiu7G98vGksugl8+pIH1Dar+Y2KBc
 vf9dtd4eneh/0h/1LncEwTYQjVphOPTDslCVr9id5jBpW+j1JJ1UkXVcDYbNulIR40wk
 4tREHFsX4UX6RoKscxJPNgol+T7VWHyJteTpB/oxrUWRpNMnQCYMAr3qJ3Zk7oiSxLpE
 nD4ZhtJiea3IKWXrB6ty1vkWTt0lxJyTHIwuVZxKJO+y3mKqmjW5VyHeNUqGtcoMDJXW
 VyVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793973683; x=1794578483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YXw7NOr17pjMQ7VC9050ylNljX4Kxe1Gs6cyljUb+Z8=;
 b=lDTWOVXbEWPuso5qR9NTkgGxaTjjDDeLN/jC0aILU2dbG9KL4GYnuahbno6DhBrF3D
 KzAUDQ4jr+OCfGbhiXO7CZMxFer1dXXZTZXH0rOj7jUiUXFA+IWxyQ/SRbLf6DQTCfSD
 qOCQXPjZB+Ely1Rt/RRQkQYAKcM1p6edAs1z1nXp2A3Fua8Bf0z7SNAScPR1pRYcWmu6
 AyKAZTpXfvIrAO1WO3eVpvY6/ILB6M064LTAfcqDUvTpAjvkiRhIMZ6WSVMriQK6rZbA
 UZhL1vUAPQXLLnlkahahODgDn+tbV9+ruCvrujLE0I90W2s7DjwfqGtC+YIq9lb/Tys1
 gjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793973683; x=1794578483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YXw7NOr17pjMQ7VC9050ylNljX4Kxe1Gs6cyljUb+Z8=;
 b=g5GxJ7Oa6fbn5MT0xp9rp3DixVPTEpvaqtBA+Zp9l63ULNt4Pohb7fH4xA6mtJ3WJa
 5WNXTxToEYjzP9d+cv5cJAekzzz/WKKuPfA6TVgLyMwaUtabAh22iFyURbXMcnV9y2bm
 9dNaxRtNdsRB0NcOlsZTVuZ+bp2PLW2KSctKx31o2D8F9qUA6i61UMnpVuHQfdetlqYy
 BVoV8tPeS4id/NFFeKGONVUVOINs5dyyRL7TXV0TKAtWn3i6CXgIiPU9Q7p9dJpA8vrg
 27QlzoFwdHYju5wgycSBCbPdtRTHpCc6WXQ9Og1GYkjLJimjywzit4m/ADZ9edbdoF6V
 fzAA==
X-Forwarded-Encrypted: i=1;
 AL+hErFB1ny3nx2wm0p/c8QiQVUcYcakd/c0IxGLRCdo64HDXnf0Q/5Jh8KOQNepN+DW61XZRz3669srfk4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8KW/CM9mxhvgVrIGMgHD5Gp+F7mzX+MUa66SstU01O0sihhnff
 2LAUhdHmJFRDvS3PK+vzbtj9pC+4uTJqaV2mszV0JgZlqjhQzg8EpkDCdxVqpX4pSBvmZpUfhlI
 LIuC4riTY/uXmdlW5bBHJoGfC2rcyItI=
X-Gm-Gg: AYBFou05HlyKbawAtcYEd9kyvkJLw3sW6xSo5/L/ISzEwKkVDkjaEMP/8//H9bk+wO+
 p7SVuTih/775ValltrCVzg5MOF2rq8UjOM52O2OvmwJysb3JmXBrGCHHqa0ehhwAbefctYPxblt
 bkQ9IQcaSB+77h51p2A7emQax/FByrtLWGb8AU5bEwt5t7TRFsYir1sfCwV2UsqnVbffthe9RQz
 aLLnYk0fmQ6kYt55xpYjLonsk0+5xP2C0cx5PpJjO8dOzE4DhSjOB26CN4+oc7o7/H6tESa7oK1
 RJIUalZatU83cxJ53u+oL/I03dRYHBzzvD9PWXmSegs1iEBP9ekj7nLCFkdaFx7DQIw+IVsUN0B
 lS6yFDklRWXYN1oBMxkjccXYFYGgX9MjOLi8sFQHaUln6/AsVJHp/LdtZi7hNFo58e+ujBWVgo9
 pgDnBCjRI88ZGANR1EOR2HG/5LI25TOg==
X-Received: by 2002:a05:693c:26cc:b0:36a:3005:aa65 with SMTP id
 5a478bee46e88-36f7611ec47mr2929151eec.15.1793973682246; Fri, 06 Nov 2026
 06:01:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-4-clamor95@gmail.com>
 <au3UDDpLUmeIOwEH@orome>
In-Reply-To: <au3UDDpLUmeIOwEH@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:01:10 +0200
X-Gm-Features: AclHuK-xODZ4BK6vgyhpVlnU3a_5DM9XqVLo8nBuS_cQ27Qs1NsbBJmpnu-OR1w
Message-ID: <CAPVz0n04Cuz8d+8m07oMVBpLGwcfVyMDu=uv=_U2zjoFVpfULQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/10] drm/panel: Convert LG LH400WV3-SD04 to use MIPI
 DBI bus
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:23=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:03PM +0200, Svyatoslav Ryhel wrote:
> > Switch from a generic platform driver to a dedicated MIPI DBI driver.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 103 ++++++++++------------
> >  1 file changed, 46 insertions(+), 57 deletions(-)
>
> Same comments as for the previous patch.
>
> > diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/dr=
m/panel/panel-lg-lh400wv3.c
> [...]
> > -#define panel_dbi_command(priv, cmd, seq...) \
> > +#define panel_dbi_command(dbidev, cmd, seq...) \
>
> This probably also applied to the previous patch, but there seems to be
> no reason for this change and the related changes below.
>
> >  ({ \
> >       const u8 d[] =3D { seq }; \
> > -     struct drm_panel *panel =3D &(priv)->panel; \
> > -     struct device *dev =3D panel->dev; \
> > +     struct device *dev =3D &(dbidev)->dev; \
> >       int ret; \
> > -     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE=
(d)); \
> > +     ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SI=
ZE(d)); \
> >       if (ret) \
> >               dev_err_ratelimited(dev, "error %d when sending command %=
#02x\n", ret, cmd); \
> >       ret; \
> [...]
> > @@ -177,14 +166,13 @@ static int lg_lh400wv3_get_modes(struct drm_panel=
 *panel,
> >  static const struct drm_panel_funcs lg_lh400wv3_panel_funcs =3D {
> >       .prepare =3D lg_lh400wv3_prepare,
> >       .enable =3D lg_lh400wv3_enable,
> > -     .disable =3D lg_lh400wv3_disable,
> >       .unprepare =3D lg_lh400wv3_unprepare,
> >       .get_modes =3D lg_lh400wv3_get_modes,
> >  };
>
> It's not obvious, and also not documented, why .disable is removed.
>

Noted

> Thierry
