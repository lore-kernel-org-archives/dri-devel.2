Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C07FCC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8F410E0AD;
	Tue, 13 Oct 2026 21:46:50 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9D410E0AD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:46:44 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c2e7131b94eso316521366b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791928003; cv=none;
 d=google.com; s=arc-20260327;
 b=USGYuFXgh3rl9cVHA7YCh64Ar2M4JpIgGP+rn19/dWXfWmeLvKsUyNNjv4TfPb8R1B
 MJYeEj44ufZyWHzdVf4LfWvHxCotF56coVY+6P7BA3tzdJawPM+Mh1jgXHJJ31hsx1d4
 El6SaCeRDj6XK5QFdS8ynqico+AbMuD7S3MSXfbqAgSfUxcxwVbAojm6/e+YKriqOf2x
 myJeh0YaMUkETexH55Gvp0JjkN5iRFCWiO4hsf0/KsXsLid3qysReGBu4QTPQCNPj9+9
 1N1+53JTXoOyeooWzfwpLje5SEk//DH8jgp8cXLDg0vWcZ9dFdRYpzbEJcVGxGGOKSUz
 SdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AqZD4Ft9JyhRwT2DBarljuLbS5RYQ2WwnZPQWaQ6rj4=;
 fh=VpbDTx8XIz4FGb41FtN/KTwtvpIELL2ZAaIgIglG228=;
 b=c7TTIPz9p7vtWOEtI0+WtbzE9hoWtItBpKV6T508163IyOVga5zzo4iU4tt0Tegpn/
 MMNUB6dIjK92tyFXwMcJ6Y7uK02XxCht+Cl0+YvQBAl7dn1bWphn0mcnGDZDaDRyt/NM
 trM9rh6FWyrQTN58R78S+XZwa/cLsd0uST5EPjNTh2SVwffRLSGUuS7wQpG4sb9ZXVwF
 qQZ1GhuhGK4ciELbtxaCxqNwQSL0RWk/Ijape68908vKgfCK4D4ydyA/WTkJHOLPH8zv
 qbPHKYuPn+Tr+UMagiB9JwVaF0pTSZCE0auhhdlXCLS90mniyvl3A8DBZyjj4lpEhw7y
 WESw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791928003; x=1792532803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AqZD4Ft9JyhRwT2DBarljuLbS5RYQ2WwnZPQWaQ6rj4=;
 b=hsXF6X/fZ9n6M2LE9cpjRsJKfb2poTfMlIrBvu+qdWlR+uOzEyONmVFdfm5vhczE2/
 FwWhrvHb69Pm5pQ0xlSHa9ycvPSc00wuCmsEWu4umpi+KEBZNz+JSqfqifo/Eg1lnoUC
 ZeoB7WP49apP+Ksh+bBGcEj4WIhlBRGdDOe2LvMjH68hHL387ze6KVw2bkIR9SGqSE3P
 4YKtM1GkrkpDwAfjmyDYpGeObpwQJBFJ47bOa3kQP99BetX8mHVchyfsAG0rMNiciF8k
 +F/30hSgwWwIIHMbemj01PH+4o30UFwfJx2roCWE2pl7++teE9dyETOj9f1Oxs9aiWGS
 nWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928003; x=1792532803;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AqZD4Ft9JyhRwT2DBarljuLbS5RYQ2WwnZPQWaQ6rj4=;
 b=AeNt3Ju+Fmv2lA6C/WGBbuwiWuLuLWBORWiG5sYi3o6gerh8CB2yGn2k4Rk0/gsPnt
 KpHP4Zr1oadRS8PfyaDF0Wgi0NVTrxHhbDbTITZiu83YJiAjXrk3P1K2hd8QajyZxJWE
 sgyvoblP2ojqtUkFD6ZFsfJxQffjwuJ1J9d5tt0d5Rp8DVtR3dCSDYDMLyu48n/O5h46
 j9fyMK/Ggl+VY6rd9YaSGtryb/613b+MdRsaxy2tzKTFQWOq4ixNMJ+8AZ0Mo4xfsh6y
 gr4VNiPwXn+IH35Xi5506jMQMUMJV+p4n5MxxWFbb8hm10rkRA9jlhDZcWVLgs764x1H
 xxbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI0cZRW+EUSEoQQG86mfg+VdOW/2M8UbEYn/HI2mQJp0PQotSh/vuNnChvoDA81Z3AE728APG/yig=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLoRRHLzigVbf15tOqSE4/tWkW40VP9NIiqaZ0kUR87xIMvmss6
 3eI+pCgYEGD1Idysx7i2ZfvOIPpHDDfAHUhmJfx/uvGbfByNVLtM4OgfEYwLXeziQ19EJue90jf
 ql616UHZ4wIaDzZfXy/vf2uTzEsTObJk=
X-Gm-Gg: AYBFou0JNXMtLrozuX6/Z4EWpEKKXaOtRVJXhy72RsAv+WRHjc1Nk/VuID1tDHShgtq
 A0gK3NFNMHCPFnAOejFMo9Xlnn8OinJ+9dZZXXDxcxKTiUXDRbiEA0AteqI/UlSBqlK9GwpzbUm
 Zglud3M+POVWZnpa3J5XUBfI2L8zFP6b2vTHby5gJ5JbHHZIci6D1SEWuU0vOvJJ32Dti5uK48R
 uDg/ePT17B6bpQqw+Yji2HZfdRqt4eylYF5fIqm+hrknYQF5aXpIiasN3VRF89HzfTpArfCgoQO
 tJC/JYIKh7KdOcoboUhCNCoj5K0jsPQfq7CMX/xcdEeEYy9vu5XWog==
X-Received: by 2002:a17:907:3d51:b0:c2d:be57:f742 with SMTP id
 a640c23a62f3a-c31a71252famr1282278766b.32.1791928002700; Tue, 13 Oct 2026
 14:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-1-7188e7ea7a15@fairphone.com>
 <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
In-Reply-To: <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
From: Jasper K <jja2000@gmail.com>
Date: Tue, 13 Oct 2026 23:46:32 +0200
X-Gm-Features: AclHuK-NqYEpvDtDXhi9IVbRYKes3SwwvzbOhM7NId12OJB7ksYzqp34C_yrVg0
Message-ID: <CAErD6092tBte1je=9t0_NUwrU8uqHen_ffYMYXFBqMCJkTZRHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
To: Doug Anderson <dianders@chromium.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org
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

Hi

Op di 13 okt 2026 om 22:35 schreef Doug Anderson <dianders@chromium.org>:
>
> Hi,
>
> On Mon, Oct 12, 2026 at 11:11=E2=80=AFAM Luca Weiss <luca.weiss@fairphone=
.com> wrote:
> >
> > From: Jasper Korten <jja2000@gmail.com>
> >
> > Add an entry for the B140HAN04.0 eDP panel. It is found on the Samsung
> > Galaxy Book2 Go.
> >
> > $ edid-decode /sys/class/drm/card0-eDP-1/edid
> >
> > 00 ff ff ff ff ff ff 00 06 af a9 65 00 00 00 00
> > 28 20 01 04 a5 1f 11 78 02 9b 85 92 56 59 90 29
> > 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
> > 3e 00 35 ae 10 00 00 18 00 00 00 0f 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
> > 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> > 00 42 31 34 30 48 41 4e 30 34 2e 30 20 0a 00 ed
> >
> > Signed-off-by: Jasper Korten <jja2000@gmail.com>
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 2b455369ed70..73cdc2d37ab7 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1986,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B11=
6XAN06.3"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B14=
0HAK02.7"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B14=
0HAN06.4"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x65a9, &delay_200_500_e50, "B14=
0HAN04.0"),
>
> I'd assume you don't have a datasheet here and that the timings are a
> bit of a guess. It's nice if you put that in the commit message, but I
> won't block it. Ideally you could reply here and let me know if you
> referred to a datasheet or just made a guess about the timings so if
> the question ever comes up later we can find the conversation based on
> the Link: tag...

The guess was based on the other entry of a panel with the exact same
name, but another ID (0x403d).
The link for when that got added can be found here:
https://patchwork.freedesktop.org/patch/msgid/20231107204611.3082200-4-hsin=
yi@chromium.org

There's some panel documentation around on panellook, but I'm not sure
if that matches the HW rev that's in these laptops,
nor if they actually contain the data I'd need for this panel entry.

This setup ended up working out, so that's why I left it like that.

Kindest Regards,

Jasper Korten

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Pushed to drm-misc-next:
>
> [1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
>       commit: 9125232bc2a5020710db1eadd21973757f740648
