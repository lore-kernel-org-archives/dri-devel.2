Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201B5CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D7B10EFB2;
	Thu,  7 May 2026 10:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tIrBg62Y";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFA010E236
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 00:56:49 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7de7dc85b74so284978a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778115407; cv=none;
 d=google.com; s=arc-20240605;
 b=gFo0KTcuWPAoX6BTD6Cm85CEpnIVI7ycF1el16coDwBfiJ3arFAbhC4LwNZNzksk8O
 DaW0r3i+Nxml5lCHRRk1IMNTPFa3nyT6XtK+dSh87P0l1ibZG6mo5LFZ3B5eSJW1vJvU
 H2hsD7mTjSqtSNecU3z9Y7GixjwKY8DrfOs73HnaAFFU6cen3hlmbxaUZ9hYw5FcYDc9
 YGEQ8LEHF8ju7K/4aInMksw6+fVSu6zwaQoHHGSIiiqJqFZztYO45f5G6HTq4uIWjbYI
 yjg1pxRBkxIi8bFV+1ZaaWZDIIPlz7kT7X97hXXYaBSMS/igZPK2aPgPX+Tk0PS5XUtP
 vdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g1sA1lyRofYcGEHdA6gOvVQU5sDRhK4CKp/w5qZjsk0=;
 fh=llzBN+AmaKIwN39AlM+njvybEXov3KdRthJrHynyA2k=;
 b=RhI9M5Ph3x1XBf+JkOXIgGTOcYXkjTfvy6PftzN0KpFfQahvJXG29ALXD6Ztu6JrWY
 fgY5n1GBcuxTkQY8BCGvbV1dJYF2qmcMT1x+kLI7OaaYk+aE1eKbBRzlmAsq94bBdMs/
 g0BWzoBbItEbYc8ZTDIg9pMyITRpkJv76z5NCUdR7GwjjPFKHOp3bS3hbytZZBVTaDaV
 9bvEmHcCfA4XSShzsuy7kz6dZx4jFIs9qxuJ/IZseHoGIrQUqlDOMc66clhCEuhlBLrj
 C7fRalKCnlvv3vDJ4Yv/CX9RdIAO55KL7rFGN7U3Y1pnweo2JK7lcIR7CEauwL2JKMHm
 XMYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778115407; x=1778720207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1sA1lyRofYcGEHdA6gOvVQU5sDRhK4CKp/w5qZjsk0=;
 b=tIrBg62YHb0bueo6TYj6bzUBEq8h7e7ewyrsNd8dl88E/DwDbODOG4jsGJqljrxxXf
 YZbugAwDVk0YLU9v8TLVfBApU0ZxNlRBCJkEsli+2bjhr/qOCOLEcystBue1+uI6SZAs
 xa8StR2EJbq1lLJOpHBR/3TI/U3qWWb53SrPgTh6xjG60DnjPwigX7GEgriPlBKVnMab
 XqKlRms7iYioqCHmO0dK3NTSkYZwMhb56OWTL1ut9a/UKtxt6Dt5YzBsalncN2qqpftu
 3Cm6Ci6Yy/Wx6+rAmvKWqgtIm4O8cOlQ3zfXOWnCALtzcM6OwYxyaAYQDa7oUcSjYuPM
 tKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778115407; x=1778720207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g1sA1lyRofYcGEHdA6gOvVQU5sDRhK4CKp/w5qZjsk0=;
 b=TT80QX0Mok/+Xy1hyeBFylVuRONssgwdIwnJaikXDX9Lwe++qJdS6fmkBVupIQxqis
 KnuclYdEwXD5UDkbpZzoaZ2zmi3RK1plFxO6u2UFBbVir55hr5qrw0kvvsZVYTdhNnx6
 qTDaJ9UfJjTZtTvp02bR62tkmYdWC2mEqMpMc6EkRIlJjfkN3cPHmvNzmzGt/Ols703o
 yZ1vGDk3cNlkHTks66694BUP+DUQ3ngt81ssSXln1jLBqBnol6uhqhLp3lWoJIn5JTcV
 bUBR4uQHCLPYW4La8st4EapCiIRUUl5yhiGusq3oNxkqcL36EeHnTqBenfHQCzA7WPyQ
 NPtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ny9G/AutzSlQwBVx6aNYZG0gfNeZ64fUcvKKR65xfk5mEC1lgFNO14rScj6ICteaKiI6y40c+Qgo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWmTFT/NY4+OYolzUGVNFtU0qq5gdrt6AEP5aEIh9nWl7pgwLn
 aVf5s05T3ExJZNcErqn5YSjl0bzMVBtbKl18NqTqKzCGcZVCluFTFqWPUIZ2p6IedxxRoOzVNUM
 qmOcLEsxeXK9uW+n/nyJkG9xP9b1vn00=
X-Gm-Gg: AeBDieuv2i27DVgEgc58MYEOaRdXfSyZV4MELUNdK9wozJ87oBAgnrXTyt/Dn6K7hDB
 aVQTBEMH+9iMDXrnNZf5A0ZZhihaLD8oEv6bnnIArq/sZVsB6VXy2UPGv7AezSs7NC5EOBtsN21
 zgT3l73cMwIIp0rZH8F4QJVvjTeQJF3ihI4yRwplBNIZeLvo+0NFRpTlnoo8E1Yrg9qOMZCYYEz
 dxepKmumACJaeWAUcNLTbrxWU0/ifTC1lhJl//3PXBk0tECZ4cD5/otwOnc54X8MiJNEPjMQGdM
 RtSc4/wLfH7XzGSYkyjqUnDgC4j0
X-Received: by 2002:a05:6820:178a:b0:696:982b:1c24 with SMTP id
 006d021491bc7-69998d56a5cmr3110249eaf.57.1778115406810; Wed, 06 May 2026
 17:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260506104934.82275-1-syyang@lontium.com>
 <CAO9ioeVBF2O9sRT+KzMETvYuV5Jw0okj6MiM1sxVdc5j8Pdk3w@mail.gmail.com>
 <CAFQXuNbA-wW-ZyqZKjRagA+qpPMP7AAtaX67Y4=AHOx23s2SEg@mail.gmail.com>
 <CAFQXuNbWQQN0U+s0K2XV7hy6ow3x7RAB8Q=nxOvsWENDAE=2VQ@mail.gmail.com>
 <uprzduq4ct2dpkwvlbwxw43b77yzubjwkzvjhadlkoajmbbybe@3cygq6vamfy4>
In-Reply-To: <uprzduq4ct2dpkwvlbwxw43b77yzubjwkzvjhadlkoajmbbybe@3cygq6vamfy4>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 7 May 2026 08:56:35 +0800
X-Gm-Features: AVHnY4IpqoVhLCpOMAkka2K3RzMKu25-S4RZJ-aEYGB73dj_vPbjIK_Tkr419W8
Message-ID: <CAFQXuNZpBnA=kCCKEhXtN4wDOdU48D94PpbYrR_cEu+YUt8aBw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-firmware: Add firmware for Lontium LT9611C
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, linux-firmware@kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
5=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 04:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 06, 2026 at 08:01:46PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > =E6=9D=A8=E5=AD=99=E8=BF=90 <yangsunyun1993@gmail.com> =E4=BA=8E2026=E5=
=B9=B45=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=89 19:55=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B45=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=89 19:46=E5=86=99=E9=81=93=EF=BC=
=9A
> > > >
> > > > On Wed, 6 May 2026 at 13:49, <syyang@lontium.com> wrote:
> > > > >
> > > > > From: Sunyun Yang <syyang@lontium.com>
> > > > >
> > > > > This is the firmware for the Lontium LT9611C,
> > > > > which implements the function of converting MIPI DSI to HDMI.
> > > > >
> > > > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > > > ---
> > > > > Change in v2:
> > > > > - WHENCE
> > > > >  1. Modify lt9611c_fw.bin to Lontium/lt9611c_fw.bin in the WHENCE=
 file.
> > > > > - Link to v1: https://lore.kernel.org/all/20260506100242.79276-1-=
syyang@lontium.com/
> > > >
> > > > Why? The rest of the Lontium firmware is in the root directory. The
> > > > driver also (IIRC) expects the firmware in the root firmware
> > > > directory.
> > > >
> > >
> > > Our intention is to place all Lontium firmware in the Lontium/
> > > directory for the following reasons:
> > >
> > > 1. To distinguish them from other companies' firmware files=EF=BC=8Cs=
uch as
> > > rockchip, qcom.
> > >
> > > 2. To keep the root directory cleaner and more organized.
> > >
> > 3. Clear organizational structure
> > 4. Avoid root directory bloat
> > 5. Improve readability
> >
> > That's what I think.
>
> It's all fine... If it was consistent with the driver that is being sent
> to dri-devel@. I'm fine either way (and yes, having Lontium subdir makes
> sense as this is the 3rd one already). But then at least drop a note to
> the dri-devel mailing list that you'll send the next iteration of the
> driver.
>
thanks Dmitry, your reply is very useful to me.

In the next version of the driver (v5), I will use  #define FW_FILE
"Lontium/lt9611c_fw.bin".

> --
> With best wishes
> Dmitry
