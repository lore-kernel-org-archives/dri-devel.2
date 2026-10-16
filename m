Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7154CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF92410E336;
	Fri, 16 Oct 2026 16:27:31 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEC110E336
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:27:24 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-17bc533fda3so62127c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792168044; cv=none;
 d=google.com; s=arc-20260327;
 b=ISflRE74Cj31aOerBHe8GiY00p3S5YKgsg8N8eviBt2MHgoZvGFU1EiZLxgWHeT2b1
 rE8CkbnLHa8EJFf4A1N6YJc5GPxwL0ciAZErD+/nu0atSEy6iRD76QU9940VI32qhbri
 wf3SelKdj03xomB3Tzjf9uAZEVMBnCFm9VKujU9QJ8spTGMdx/4WgMJcu6zmj01BaP1l
 iqKzO1VKjWfAEEg6kXhOP6P59ijMpAHiyob7HE6/85WKG5JaqPsxYeqQYTaE0IhBT8np
 gnmSQ5UpdAUDyWcwIDmtj7Km+MzhI2ehrpgpmMUomA4yKbEG+WBVx7mnEWt76PK+e0/6
 CV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FKkA/I1J3TnOXc1SCotCtaDkPFS5TVcFw8DzsF8Du/M=;
 fh=0X/HExqu+lw1g+dht0doPVoQA1CQp6p1sCAYee3KLnY=;
 b=a56SzOo51z1e6FJW2XZb0BUfv1drVKbq5Cs0kKwClMt3F3LFEV+QbvN0ryUZe6m33J
 +DQua6sdOEh0cYE2q6um/+7ZeaPCWWZNkNSrWLaO4JNN3obx1m5BD/NXKFGSgED5jcKl
 BOtcZ94DZtLJZdUkyuup81f3wkfd0EUoSL1vAhp0aL1QzMYepX+VOlWpXdBbkVQIa5Wv
 YaBEi2w/UUAGm/BouT9VYKFrXuwW8zBOxDWkpFhKAyoeQXxNFy2rRP56Z2SofHmx/NRV
 4aXNv4O1CGZAToqY7OCx3zB+EpZsNVpZZElDYzuwlkcfFcdBzfnP5af0YDrnHT3LK/jz
 KAeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168044; x=1792772844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FKkA/I1J3TnOXc1SCotCtaDkPFS5TVcFw8DzsF8Du/M=;
 b=CSWt0bHBCz5OHLLFsazV5+Iz4tr6q9PCj/qwNWI3YTbj/wCy/pxdYHFPwvftLpnXGt
 ISva8p5ndyB9AhQAmyhL3F+hvUFlUlAkl3HFOhdVyjOYx4b48cprtwXVLyuNyXJOv7eV
 kmY7WpVDhwRhtLJsyVxW1CS9HmlXZJJCXFs/3ywhR975HzCWJATM+wuqNWWtBD6g1riE
 /tpg2t4+h/xOuUJYML5cS/GKzckATO+y6eR4g+sKhHT4gfZ+w+t/KQld7DfUOLg+sSwu
 n6s/mBtN15xM3iSvu2UYFiLiDEFrNBYREuTDnxyF18rkmOQ2gBssZKSMcCNbrNqIGaJ7
 MMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168044; x=1792772844;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FKkA/I1J3TnOXc1SCotCtaDkPFS5TVcFw8DzsF8Du/M=;
 b=bk7yAkDOvZ3QbGGgnOgIiWq6kBfNQm9af7bi+NPIFBrsIbGFkFLytXi38m3ZBf5PBk
 Rj+4VpFVquH3I5pJzehTb0VZgInYbCcCArWnAdvLG4fc5k1S1o5h+jy8Vb2KftJ1zw66
 qLys4rTCrXl5xw1CtD4dtxXt80nUClwbYvIR8qG4EDUkwrSxlJpbSd7lXi3QG7M05yg5
 MkKFCHMYczg0AgmySHbxRLhUiy+CMbRiAbmLx2PHNWmfJ+bwiDz40M00tIZdKprhNem6
 J/EIMgWVF8s3KEd+sxdPAsVBLS+X2O2KKYdlryFyckgzB2HW9uV75gXFP0y6wDAK9kZt
 sezQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByoqHva9VmlcbCD1wu1sHrSX/myndjdt8qCOGA7X303V6IUdalj3ZcOEUhfEUSVOJjfKWTdq5c6PE0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjZBrYPVjZAa+gbpOUBxxGon26UAfpL8sTpSKJKKhI7YVDPf7d
 ac/QVTQXRn+oxTd/dM8d7CxUNGkZB4BzsGGe1HKzQoabJzBGJK9ZEmu2OH2lAsSzBV0w9Y6yJSH
 1SM5OjuV/XDLY3wF+i48RnA6OCLaq6xU=
X-Gm-Gg: AYBFou2BoFGzPCt7IhHapj4e8atn/TLi2cWIs1NVFWkhcd1uSUn/O9Ng/uWw65UL3Ek
 RveQUY+cl+86vD7187WviHSd7M4c6sj1pVZnD3890Kw49K/3+d47JyuH0vIRmPQZ5xQqh0vpWho
 AgVmFfDSO1OlgLWloAxP0mo/incaeBYZda/Zk9puplJb3jKMRwbLm/XnErjTGleB9n8VG3AApVX
 ybWo7e+peA3oZeZobkAeM6tXDsOmi+XdK+6yGw4oDOGmsTY+UuJrD/nLw7OdoabnwZLmQku0oCx
 zQPdI0gTHKa1BU9QaYPijgksd7ntGYLruxju+Ei/Jb9GXR4A2ouTqq1vLNlOOT6pSZATxXuoMQ9
 h/9wj8ncbghAh
X-Received: by 2002:a05:693c:638d:20b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-361a18634c7mr341911eec.16.1792168043963; Fri, 16 Oct 2026
 09:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-3-clamor95@gmail.com>
 <atJDFRXmgZ37GrCE@aspen.lan>
In-Reply-To: <atJDFRXmgZ37GrCE@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 16 Oct 2026 19:27:10 +0300
X-Gm-Features: AclHuK965ULDwrtLzaPZLgAMgTCNPq5g0it--pZ3MwPKJFECiLPJTV2LEV8Gatw
Message-ID: <CAPVz0n1RVDz0MsMBccanpynh=Qn4x6Ar7rXRUVitav88i-hWYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max
 current
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=BF=D1=82, 16 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:3=
0 Daniel Thompson <danielt@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Oct 13, 2026 at 09:09:31PM +0300, Svyatoslav Ryhel wrote:
> > @@ -69,10 +57,11 @@ static int aat2870_bl_update_status(struct backligh=
t_device *bd)
> >       dev_dbg(&bd->dev, "brightness=3D%d, power=3D%d, state=3D%d\n",
> >                bd->props.brightness, bd->props.power, bd->props.state);
> >
> > -     ret =3D aat2870->write(aat2870, AAT2870_BLM,
> > -                          (u8)aat2870_brightness(aat2870_bl, brightnes=
s));
> > -     if (ret < 0)
> > -             return ret;
> > +     if (brightness) {
> > +             ret =3D aat2870->write(aat2870, AAT2870_BLM, (u8)brightne=
ss - 1);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >
> >       if (brightness =3D=3D 0) {
>
> I think this could be spelled "else" ;-)
>
> However, other than this this looks good. With that change applied:
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>

Patch cuts part of code, this is the full context

if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
        dev_err(&bd->dev, "invalid brightness, %d\n", brightness);
        return -EINVAL;
}

if (brightness) {
        ret =3D aat2870->write(aat2870, AAT2870_BLM, (u8)brightness - 1);
        if (ret < 0)
                return ret;
}

if (brightness =3D=3D 0) {
        ret =3D aat2870_bl_disable(aat2870_bl);
        if (ret < 0)
                return ret;
} else if (aat2870_bl->brightness =3D=3D 0) {
        ret =3D aat2870_bl_enable(aat2870_bl);
        if (ret < 0)
                return ret;
}

aat2870 cannot read main backlight register nor channel enable
register to check prev backlight status. Hence this logic is used. If
new brightness > 0, update main bl register; if brightness =3D=3D 0,
disable all active channels, if it was 0 and now is >0 enable
supported channels.

>
> Daniel
