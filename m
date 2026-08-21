Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6719FC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D53B10E359;
	Fri, 21 Aug 2026 22:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YhEpnaGi";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F9C10E359
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:00:38 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-97c4f5858c3so480160241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787349637; x=1787954437;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L/WPKDMNqV5Ps5p4Smoel0/e0IhCvb1OShEWiBW4re8=;
 b=YhEpnaGiarWyuPlUpXJCbkiVP6GDh8x8eUjrCT+zIGSs4Kg6qyX56XUECp8wti9eDn
 fzyiM0LI1yKawRuQ1lRNt6v7FUaTGywSxeIbnArN1ZtD0F2+u7VqN+l0by0PF+K5bhQa
 rl8VOzN7A1+nQGAn3xEGYnd4eFJi8AYJ+ERjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349637; x=1787954437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/WPKDMNqV5Ps5p4Smoel0/e0IhCvb1OShEWiBW4re8=;
 b=YwsrSx90lSGY7FOiSApXxh79/glcvVGs1IGeRyxJlW7R9fKXFEfq5qzxR+41ce/pNu
 17rUR8gMAE1EEVJYHo9jmEBd+NLqlYdH3JQbZFlUhLS3WwHTV9cXk3OUlFED0agnLjuh
 Tnm3u+aGDqtNIsMzZpKnWjMURnhIm111T1SLOoEMiatGmYnFODdxFk3D0gk1zQcfupTw
 sAnfhSxc7mRvNNZR9cFDqO5Y6R//U35LTgFjjspUEmEOrb6m8tyB8FG5C94ohrfB8M8Y
 BtwkD5lbqxX35XMpMuGseM7XrSVNmYaKZa4bA7MRSys6B4qQju/r4WBvqp/Bcu0ff/gP
 YSQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcakIn1I/TNu9JPDK6kVLf06NxQ0cFepiNbT4c8QnZDXua0XRPDbsboBTv95WNRGk+wVZvNhA5Vyo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+MWXmh/MnwDuD2B70bexruVWvPf3b0tMpYFCh1RMDCOO3jolr
 s9SVrutqtGcVlMbW6MCNxN+ogv57Uey5Gl5k8G8y1ms03ig9cPXGnLSh/JJeAAGZV2rKvnkD2xY
 eb1U=
X-Gm-Gg: AR+sD10nL/BhnLLjsOv94X2arM3SBniadW63D1oLAZB4Hw3FfSYpczi7kkbcwNQHUXe
 HRIivBkSH+QR1qBnJDMSnZ68N72qdc1C2RHnQV+f4AjvqC2ZunyZnS46+aBIhUNrYGF4aLF2yTO
 qjicDS4Z40aEmASU11GFSdsd5T9K7WVwBAJy0q5llsCaJInDh56+59g6KiIlxrW+9wgVrRsaCdA
 Cb2ofbKppnWA7JOoKEOJHY9KdC4drytrXyt1RrSm6l2l2CKqHMhmQ6+ZLwcyLFY21x0W1dKmw9P
 xuBUx+rafxhE6IZT8NB6/thg+YbPeqJTOiYp9+olhn1+m3qeAb1DTVO1CBkzAO8P/hIcIPUpNk+
 ko+bfZMiNXYSfcqtRHVIbQBEtNlIPuD6g3fDgXNXxo3k8TFdruZLOfEH7dh5wxICRWlZ3cBJ1jm
 zvjJi3TXyCnznSNBaZAUJArgKSWQXMQNuBzjAxzrMQXijViQ93p4DTMPk0707U7KVq9gtwPGh9N
 VMusYq49gW89rlQy9bUu7qI2C0=
X-Received: by 2002:a05:6102:508c:b0:777:5bc1:1148 with SMTP id
 ada2fe7eead31-77bd04b5616mr614527137.2.1787349636856; 
 Fri, 21 Aug 2026 15:00:36 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97c834d0321sm99662241.6.2026.08.21.15.00.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 15:00:35 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-74ace427b29so522716137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:00:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpQnVT2ZoMFsicFu6vM3ohIW79RRj6ioVP3vAce152D26azX1/fxAugj2Cpz64X/LeHyd5JQQVsCrM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:578e:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-77bcdb370e3mr640643137.0.1787349633985; Fri, 21 Aug 2026
 15:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260820012554.4038893-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260820012554.4038893-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Aug 2026 15:00:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSbzZP3j15dNioUeibSw7ArnLUUsuLqtfMm8MzTDpZTg@mail.gmail.com>
X-Gm-Features: AcwNN1WPCMDE9irRKPa5rGKxGnoOdQt4TkDLraQQs83D2xMexFBXn6tWmJotXGw
Message-ID: <CAD=FV=XSbzZP3j15dNioUeibSw7ArnLUUsuLqtfMm8MzTDpZTg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp
 panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
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

Hi,

On Wed, Aug 19, 2026 at 6:31=E2=80=AFPM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> MNE007QS3-F raw edid:
> 00 ff ff ff ff ff ff 00 0e 77 87 14 00 00 00 00
> 0f 24 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 35 30 80 a0 70 b0 24 40 30 20
> 66 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4b
> 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 4d 4e 45 30 30 37 51 53 33 2d 46 0a 20 01 41
>
> 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> 80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
> 5c 00 42 12 78 22 00 14 8c 5a 02 85 7f 07 9f 00
> 2f 80 1f 00 af 04 23 00 05 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
> 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 01 01 53 53 ff 00 00 00 00 00 00 00 00 00 7e 90
>
> TM140VDXP15 raw edid:
> 00 ff ff ff ff ff ff 00 51 a1 37 21 00 00 00 00
> 0b 24 01 04 a5 1e 13 78 03 2b a5 97 5b 57 8c 28
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 24 31 80 a0 70 b0 3c 40 30 20
> a6 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 54 4d 31 34 30 56 44 58 50 31 35 0a 20 01 dd
>
> 70 20 79 02 00 21 01 1d c2 0b 58 07 80 07 b0 04
> 80 71 69 5b 79 d5 8c 87 82 20 02 45 54 b0 5c b0
> 5c 00 42 12 78 22 00 14 3f 66 02 85 7f 07 9f 00
> 2f 80 1f 00 af 04 3b 00 05 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> b0 5c b0 5c 81 00 17 72 1a 00 00 03 01 28 3c 00
> 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 90
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 5784ba0618bd1..03e24f2a8a104 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2236,6 +2236,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MN=
E007QB3-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "=
MNE007QB3-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1486, &delay_200_500_e50_d100, "=
MNE001BS6-2"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1487, &delay_200_500_e50, "MNE00=
7QS3-F"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "M=
NF601BS1-3"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "M=
NF307QS3-2"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x153f, &delay_200_500_e200_d50, "=
MNF601BS4-1"),
> @@ -2288,6 +2289,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "T=
M140VDXP01-04"),
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "=
TL140VDMS03-01"),
> +       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2137, &delay_200_500_e50, "TM140=
VDXP15"),
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100, =
"TM156VDXP25"),

Looks OK and I've pushed the change with my reviewed-by tag:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1/1] drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp panel
      commit: ae3592a2b58a9acc6e6211440f0f638b79b96e9b

It did seem a little strange that there was no "disable" timing for
either panel even though "nearby" panels did. Are you sure it's not
needed? If so, please submit a followon patch. Thanks!

-Doug
