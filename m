Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B5CC5DF8C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 02:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C10210E071;
	Mon, 24 Aug 2026 02:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="oFtjZcHm";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0529810E071
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 02:18:35 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so2252027a34.3
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 19:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787537915; cv=none;
 d=google.com; s=arc-20260327;
 b=Ep+skPQu0cnOPfFj3Yhja+XYvS8nXqOWh6PtCa6VhXBnFAK8iB+8g8kV0dA3x0I5xW
 LaK2lAIaXWKaBpNIDUQCBwJOxNZiVuFK30aOAUR/tO21U1M6yRK2o3MCj42W6NPkDx21
 Dp5tvjWWAs5Li8dk1sWy5m3U47syVTioF2fNE2hvUSGKWJ8KGrfNJIRAq5miByRuekgt
 Qt71Ij4XZHJpMTd5UlkSX4gkj/eu4XrWE3pVkuljvIUBBOpHlcIAw3SxHPSa+BZOaT9/
 VOhgerCk/jeQ6Oocba31TDz1xKjbAqMDu6BBbHa8FL8vGhBdEda2CmmSg0eALaulB8ow
 hfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ti7uDrEa0LEcGW1nlIJmRJ1t8Z8G6Rv27AouiCCX9Ms=;
 fh=LJKnP1qIWbhuHSsYRNXihlLCkX/1S6q0LfN3r5GoZ0M=;
 b=ZM+rTT2Yk6OZhcdZ7cAig/bG7OeN20hP2io6/ztg//ntSYhFA1jRdaGlI/EUI4Reb1
 sL6LCCUitxNhnlK+T4JS6wgRFQVF1iJN1aZeqtwTzaOMNxoMAwrPmRs8/XdR7Bikt/7s
 zaZbh2H2bpiWhkfpWEgUOCmZ0CYwAp4pSKQcdPW7yscfbSXN/6iHLYbKNXZDOIbv3f86
 hMLuonOLG+UQW3ABE1/hsnVgxI7394M3ii3uZzjVH7NyebINNwLKUobuyGI9Ui60CgZ3
 YBsyxZkNj11QiP/rnCeepWjdgsA4Hqr+1+EXNTNhhRQT1FiZodOz+kqYgmHiogpncZ4r
 XGHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787537915; x=1788142715;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ti7uDrEa0LEcGW1nlIJmRJ1t8Z8G6Rv27AouiCCX9Ms=;
 b=oFtjZcHmxYTJxDgjrMq2sege/pIEpjJnQpwUF+phAoKNoDtN124auz3HjwiACnOmtm
 YR+UPOvygH5xxA2ECTGU07M/Bo0AfgLdJV42QhhbkkgMKy/KPR4DZymG3KpqlWrASJYM
 DQazYuDvE7YoJXI2QaQ0e400+vdorePlwQJjGNR+il5+SHETx1mwF1KmNlv/Inm3i9mC
 GiBnjoIVtOPXhkFTlYbbBY5aUhw/AuB+0ke6mO7GcvJAITmRnSXH4xLntQJrtPxRHvMz
 tIA2Rptpb+we1seXKNL2jJNDeWowWivyHIZrD2fTcOP2ocmw21zDsxhjmVnD7KlyXVfJ
 Gayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787537915; x=1788142715;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ti7uDrEa0LEcGW1nlIJmRJ1t8Z8G6Rv27AouiCCX9Ms=;
 b=YaK1Qw4Clzj9bobKYJohcz0chxdflBAjTUNKfc9ZRIgxImKtrFoMk6JxHzlz2OiaZa
 yjT7y3lD+cmOBFqLL4giJZp02k4Px93Fmv3+P19yofVBSrV3HvqzOUllSZAuwUJmfZTY
 dLNIbl5HOvMUXwh7eqX48I5hVQfTv02s5We2kUcE0jLntAKnt5iJMBSQBX+P/kQtQnkb
 l67jPsKQqxr49UT0DsTNRpwn9u7CA5EblC6HBzJWxOvOWuWhMF2DMew2EYZFDuQFIRgX
 kZKhStd0vzZjmYSKWvs+vrtyYi25DdZeQqJCo0vUG2dnEiKRQqQ2EPv9iOJ5hRw1ZYwZ
 DOEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZMxwgHa7gS67YjFOmjjexYf0qdcDcny1J3AM29uwjHyM84RVRkW/aYoVHnGb5GMwbbUEkIddZN24=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mKDrMjt7ujd+p+6VPLQMKE9OZU+WGRJMWxtIKkMmUszB33S20m
 NdhjjAErzxmPsI/XTvZNiBiLyKKIbk5pjIMK3LM7WXKhw7T18h92Wz8u8MMuRfEJATuDuwE7bQ6
 0fmrNL/mMnJjxXk0VeyvgJQz3kZ5O2riVv2WUDLHjCuHX7mOoCGKGtvixvA==
X-Gm-Gg: AR+sD134lLAdiQAHJ/Oir/o4Nw2Hh6plXa87KfI6+bJNTUKHjwL3z6KSJssxZtInLP+
 kx8oY5cbMg5kKye0aNNcWIQnmuNUiJFkapFoavfMwI+K1/zv3K47NjQkq/s3HqWuiHZwmOoViLm
 MGj5ijL4UvUZozdfO6BimgnPeEZu6C/enRhotGYJu8BxNB7Xvl0mMvbxKT7BcvneNLAtPiQRyUO
 hB5n0fR/mifUqD8x7USs7aaEHiIhBkS76rIr5ePKSX5VPjdaLcUWByofElAFYsxq5SiGjG+v8lG
 pH9oNf7D+7rZ4CwGZ3Dun4+bEvGvJMiQBGFp5AYXH6vYnw==
X-Received: by 2002:a05:6820:4c04:b0:6b1:272f:db97 with SMTP id
 006d021491bc7-6b1593781ddmr23997585eaf.18.1787537914987; Sun, 23 Aug 2026
 19:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260820012554.4038893-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <CAD=FV=XSbzZP3j15dNioUeibSw7ArnLUUsuLqtfMm8MzTDpZTg@mail.gmail.com>
In-Reply-To: <CAD=FV=XSbzZP3j15dNioUeibSw7ArnLUUsuLqtfMm8MzTDpZTg@mail.gmail.com>
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Date: Mon, 24 Aug 2026 10:18:24 +0800
X-Gm-Features: AcwNN1WGbzQuXL0vJrXozGJtpnOyCcxtFhEM85LMUbag0_ngCo0XH_CUtEKw7MA
Message-ID: <CAKDRTei-79M31gT7wDK6qNn9ap06-agxCBRkfMOi2G5WaDJOOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp
 panel
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

Hi Doug

On Sat, Aug 22, 2026 at 6:00=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Aug 19, 2026 at 6:31=E2=80=AFPM Haikun Zhou
> <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> >
> > MNE007QS3-F raw edid:
> > 00 ff ff ff ff ff ff 00 0e 77 87 14 00 00 00 00
> > 0f 24 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
> > 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 35 30 80 a0 70 b0 24 40 30 20
> > 66 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4b
> > 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> > 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> > 00 4d 4e 45 30 30 37 51 53 33 2d 46 0a 20 01 41
> >
> > 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> > 80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
> > 5c 00 42 12 78 22 00 14 8c 5a 02 85 7f 07 9f 00
> > 2f 80 1f 00 af 04 23 00 05 00 05 00 2b 00 0c 27
> > 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> > b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
> > 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> > 01 01 53 53 ff 00 00 00 00 00 00 00 00 00 7e 90
> >
> > TM140VDXP15 raw edid:
> > 00 ff ff ff ff ff ff 00 51 a1 37 21 00 00 00 00
> > 0b 24 01 04 a5 1e 13 78 03 2b a5 97 5b 57 8c 28
> > 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 24 31 80 a0 70 b0 3c 40 30 20
> > a6 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> > 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> > 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> > 00 54 4d 31 34 30 56 44 58 50 31 35 0a 20 01 dd
> >
> > 70 20 79 02 00 21 01 1d c2 0b 58 07 80 07 b0 04
> > 80 71 69 5b 79 d5 8c 87 82 20 02 45 54 b0 5c b0
> > 5c 00 42 12 78 22 00 14 3f 66 02 85 7f 07 9f 00
> > 2f 80 1f 00 af 04 3b 00 05 00 05 00 2b 00 0c 27
> > 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> > b0 5c b0 5c 81 00 17 72 1a 00 00 03 01 28 3c 00
> > 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 90
> >
> > Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 5784ba0618bd1..03e24f2a8a104 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -2236,6 +2236,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "=
MNE007QB3-1"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100,=
 "MNE007QB3-1"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1486, &delay_200_500_e50_d100,=
 "MNE001BS6-2"),
> > +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1487, &delay_200_500_e50, "MNE=
007QS3-F"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, =
"MNF601BS1-3"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, =
"MNF307QS3-2"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x153f, &delay_200_500_e200_d50,=
 "MNF601BS4-1"),
> > @@ -2288,6 +2289,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >
> >         EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, =
"TM140VDXP01-04"),
> >         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100,=
 "TL140VDMS03-01"),
> > +       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2137, &delay_200_500_e50, "TM1=
40VDXP15"),
> >         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100=
, "TM156VDXP25"),
>
> Looks OK and I've pushed the change with my reviewed-by tag:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> [1/1] drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp panel
>       commit: ae3592a2b58a9acc6e6211440f0f638b79b96e9b
>
> It did seem a little strange that there was no "disable" timing for
> either panel even though "nearby" panels did. Are you sure it's not
> needed? If so, please submit a followon patch. Thanks!
>
> -Doug

The hardware meets the vendor specifications after testing. Thank you.
