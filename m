Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338DAC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8ADC10ED3C;
	Wed,  5 Aug 2026 07:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ISz4aaTC";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDEE10ECA8
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:02:34 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-ca5b707b78aso61323a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 22:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785906154; cv=none;
 d=google.com; s=arc-20260327;
 b=piRa7MFz8jDJDMT52eQumscFCuYZnyjHkaBTlEIuD20THTMWRGzDVC6WQsnmb4MKXd
 9ftsUKF5X8dFpxkLmEnWiWM6ddCCmzGn33YViFOeZSdWqQpsiirRsdUlD4QYrzsSV3vn
 iNhGHAco+rVQU+eiuOeuYuocHS9oXYcDxseNK22qj13WHwPuL7pQyUF5hlzCaPURbNSM
 O4g+vUuL65ehl2ntBkroEXXq8g49KOvZMVdACS9TR4D7CGm0/29VLFXbkkcLyV3YmzdY
 VV521CH6WB534ODsbnqbT/DujSzqLP51617bg/RVGp2G5OxRjIZOoTFaf+MFh/8lQ1q7
 Z/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IfMuWOWMqjMkwepOgGFeNztuOZSjc/0X5JOkM+uzAG8=;
 fh=k/F8ZUs98yyuuLuY20tjB9kfzzspqzCTzcERBC1xEhg=;
 b=DoPxj27+XkeHF/s+eJqttMeLCRxVXaQX/wRbZLV1sXFq/CvdGHpx+5ueKykp8W58ex
 Ff0//k3XrbXZZjjUe26vmjCgfHcsDvFF69wUn6VVFc8th4YNqYjxTcmsPEuuyh6xSkv4
 9d+ZqRBQ9DajSJWUlubrxqwCY2kd7LX3WbX7R/+GSwAsIxMA8/PmPv4Jqru5WZRkXu0y
 XHMYnMycoea78bXtTDfTGl1UVFjM38fqzntLRdSJ2qkdfSPLWPVir69CbLWcugMD3rjg
 lOoHZ/fOfVu2qItA4WDsDwj1vT8Tp4UjhoUzDPqPe/mzCDcXITz8+9ndoVIWJIYJGsdP
 sl+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785906154; x=1786510954; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IfMuWOWMqjMkwepOgGFeNztuOZSjc/0X5JOkM+uzAG8=;
 b=ISz4aaTChyak2CNJZEVpIrUJoi9h/PVqDo3MiLbG1EU208deZs+3tgxIXVkSloQl8N
 AHd0+k0qIfv1oFD8Z0Fl4ZtekEA4Pj2XMPW2bmChmsL6Hq+k464J87n7XY83MS8AtQuH
 bJVXmDtvZIm4PMumMtnw7OrAXGKBgKtqUY9Xk83/pUhyHF+Lw492sk3xuD5oDXRO5Kem
 RuHpM1wpuprzgarOmifAqhAZYr7v6ZVmkjQs0ZH1UY0GY7cr17uIolb8tP7+f0O6YwVe
 9Y2HFnVEfax7VM3+MKu8MqAcOclKJhKWOhxL2//dIN/uLqLKM/qmlgRWepyASjIUcB5Q
 DOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785906154; x=1786510954;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IfMuWOWMqjMkwepOgGFeNztuOZSjc/0X5JOkM+uzAG8=;
 b=mVTUNVAHJUu/ugmNyaV/j9Icbrl4trZqsLND26jLLGHd/NgjQihZ6uX0+35cfJbiQ4
 JQa9MGNPbJ4yQUiN1s/YU7ez5mW3kV/Odruj2/h2y/b0eCQd/KZYnZOuec2mYU/Yuu0E
 yZ4kSVzk1YOZSp5pUPGW3SDx4S40O0fpYMt1Womln723CuP0sKrpygaS3tCmwd8CFJkz
 jKZwmp/naJxSLRbH8Gz/fC6HeQdsP68HGdkac5AVYEKtRBe7sZ2epLKC0+E0cee4UqQq
 az6V9Suy/wQi6CHnMfx+y+z4Z+t34Ek/YpGd+ImmJv79+VsTPgsIghTDa9Ucsv1GjaOH
 APoA==
X-Gm-Message-State: AOJu0YyfJfC70eHgVW3vPDCP3mZTimD41Qk6kgJQLowoAQr1oaMex7/K
 PiW2ltVVyLdacdrvEiTk3c1y38VAckGKA4sM2W5kC8cxB+PPVZfri4jXgr0TD+yKCBszsK2xztv
 xcvuUUuYOWlTTZZiO1LE6p8j0cF1XfRTzBQ==
X-Gm-Gg: AR+sD11nYErjrRtN+kfbllqZ8qmJR9XZTblkAtahEFv+nFJ3fFUjN1od4Jn/3XQC4WV
 l4pfTEBU9/Aql/0/HD5CuOmj4PvSIPUkAj2mPnUd5JgGpcGM5ngoTHYWMYBFjIccZkGfYKze3TZ
 9c2wszP+ZavaIsmlez9yE5fXF8urCwHiP/syIHOiVosCTvspOUDatAzCmRM0cidlEUL988SIKAO
 N1g3hDnbtzOf3vPNpJFrARUW10929F784bsxRho208dCWxeXGb8oraEk8fz6pf57t52dGATQtqQ
 wjefThPH0Dqwat8NVdhZCa623R7U8nP1FYH3A1zj4AQuJJtXs55NKQ67lMQXa5OE5wZSGBzbqdc
 ApcDdaGTr805l7LDE2gyzFsKgnWdxgmqEJbBLLHbVo+7c4g==
X-Received: by 2002:a05:6a20:6f02:b0:3c3:bbe6:95db with SMTP id
 adf61e73a8af0-3cb85e2babemr3736704637.1.1785906153753; Tue, 04 Aug 2026
 22:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACa-pC0Adw8u5NXCAhZUfrEyO0-kosqJZa8FeFjD7nvGNX1qaQ@mail.gmail.com>
In-Reply-To: <CACa-pC0Adw8u5NXCAhZUfrEyO0-kosqJZa8FeFjD7nvGNX1qaQ@mail.gmail.com>
From: Min Ma <mamin506@gmail.com>
Date: Tue, 4 Aug 2026 22:02:22 -0700
X-Gm-Features: AUfX_mxeltQGfrFXUkq1ah3VR0LUcqRSpPzMXeWSpwrFaLNee0RAx-JePttWnPk
Message-ID: <CADqY2u7ast+7SbjR_y2CqrNZF7uj4+D64+d81m7yaKjvWQW13A@mail.gmail.com>
Subject: Re: Interest in the amdxdna debugfs TODO item
To: Parth Kamani <parthvipulkamani@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000e58f66065845ad0c"
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

--000000000000e58f66065845ad0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Parth,

Thanks for reaching out.

Yes, adding debugfs support is still an open and wanted item for the
amdxdna driver. Your plan to keep the patches small and test them against
mainline is exactly the right approach.
You might also want to check the amdxdna repo in github. :)

I'm no longer working at AMD. It will be good that contact Lizhi. So that
you can align with AMD.

Thank you,
Min Ma


On Sun, Aug 2, 2026 at 1:37=E2=80=AFPM Parth Kamani <parthvipulkamani@gmail=
.com>
wrote:

> Hi Min,
>
> I was looking through drivers/accel/amdxdna/TODO and noticed that one
> item still appears to be open: *add debugfs support*.
>
> From the TODO, it seems the direction is already defined, so the work
> looks more like implementation than design. My plan would be to keep the
> patch small enough to review in one sitting, run checkpatch --strict,
> test it against current mainline, and submit it via git send-email.
>
> Before I start writing code, though, I wanted to check with you first
> rather than spend your review time on something based on a wrong
> assumption. Is this item still wanted, and has anyone already claimed it?
>
> I'm currently in my final year of B.Tech in Computer Engineering at K J
> Somaiya College of Engineering, Mumbai (graduating mid-2027), and I have =
a
> meaningful amount of time to contribute before graduation. I'd much rathe=
r
> spend that time contributing to a live upstream codebase than working onl=
y
> on coursework. If this isn't a good first task, I'd really appreciate a
> suggestion for something more suitable, and I'll happily work on that
> instead.
>
> Thank you for your time, and I look forward to hearing from you.
>
> Best regards,
>
> Parth Kamani
> Final-year B.Tech Computer Engineering
> K J Somaiya College of Engineering, Mumbai
> Email: parthvipulkamani@gmail.com
> Phone: +91 9820081318
> Timezone: IST (UTC+5:30)
>

--000000000000e58f66065845ad0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Parth,<br><br>Thanks for reaching out.<br><br>Yes, addi=
ng debugfs support is still an open and wanted item for the amdxdna driver.=
 Your plan to keep the patches small and test them against mainline is exac=
tly the right approach.<br>You might also want to check the amdxdna=C2=A0re=
po in github. :)<br><br>I&#39;m no longer working at AMD. It will be good t=
hat contact Lizhi. So that you can align=C2=A0with AMD.<br><br><div><div di=
r=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div=
 dir=3D"ltr">Thank you,<div>Min Ma</div></div></div></div><br></div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Sun, Aug 2, 2026 at 1:37=E2=80=AFPM Parth Kamani &lt;<a href=3D=
"mailto:parthvipulkamani@gmail.com">parthvipulkamani@gmail.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><p>Hi Min,</p><p>I was looking through <code>drivers/accel/amdxdna/TODO=
</code> and noticed that one item still appears to be open: <strong>add deb=
ugfs support</strong>.</p><p>From the TODO, it seems the direction is alrea=
dy defined, so the work looks more like implementation than design. My plan=
 would be to keep the patch small enough to review in one sitting, run <cod=
e>checkpatch --strict</code>, test it against current mainline, and submit =
it via <code>git send-email</code>.</p><p>Before I start writing code, thou=
gh, I wanted to check with you first rather than spend your review time on =
something based on a wrong assumption. Is this item still wanted, and has a=
nyone already claimed it?</p><p>I&#39;m currently in my final year of B.Tec=
h in Computer Engineering at K J Somaiya College of Engineering, Mumbai (gr=
aduating mid-2027), and I have a meaningful amount of time to contribute be=
fore graduation. I&#39;d much rather spend that time contributing to a live=
 upstream codebase than working only on coursework. If this isn&#39;t a goo=
d first task, I&#39;d really appreciate a suggestion for something more sui=
table, and I&#39;ll happily work on that instead.</p><p>Thank you for your =
time, and I look forward to hearing from you.</p><p>Best regards,</p><p>Par=
th Kamani<br>Final-year B.Tech Computer Engineering<br>K J Somaiya College =
of Engineering, Mumbai<br>Email: <a href=3D"mailto:parthvipulkamani@gmail.c=
om" target=3D"_blank">parthvipulkamani@gmail.com</a><br>Phone: +91 98200813=
18<br>Timezone: IST (UTC+5:30)</p></div>
</blockquote></div>

--000000000000e58f66065845ad0c--
