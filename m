Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E402FC5AC67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF71F10F1E8;
	Thu, 13 Aug 2026 08:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="fbpn74pA";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5D910F1E8
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:35:51 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so1630963b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 01:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786610150; cv=none;
 d=google.com; s=arc-20260327;
 b=I6TfNraovcXyZ5rmW3Sl2E9PTqBAcMW+01MBQ3z4CL7a08ecjeox9CRC65IlaX9DDK
 rLXY7EKXcIyIjFSFT3Bj15ZT7LTwdMj3x16Gg3fG7FQJ5JqbyHC7WjhnhKhEUzXZ6LYl
 T9lRzhzS8L5aMRngJdqLrkXGLFVU8uxfcgP3OAJtxpHouHN9i6jeA+nL+RTViMfHNUc0
 qU3Md9/Ti1zt2kLDXkCNel+s45Ar9zxoNcUE5D1RiOH+7NPJEHmevBOXaWKtFBFE3qcu
 MPA+k4v+V5MBXgRCepR/GnteUd7WHH6a+Fy0Kwf8xvu99WMWPyMRKA2sxYni5sCk2aUZ
 yg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 fh=O9w4uPpRVWeOZn+/tpxEk7fgt3NL8r+yfN/g1oab6d8=;
 b=paDPRR4a7som01v4P6/lbJPo7eUhBPY+8tpa/zh362ysnfICf5YkTGt9zvA6tgdG6J
 Zh4n3D32s4vUsalL4D+dHoJWKbYLqF+3nZBMeMey+ABR7Pq1xk+Q3Xs/JUKXgOg6Ozl+
 dVnJU27HpCpMKkTOYcYyWEuysZ8rSjIRgRGUTYi/XWjKTdAEean9t+3rmpC4uafG58Kf
 G+o/7H7y5W42yctOjoCmLPVqefjc3tsviq+dwVdOuFFwHt9Tz2XL5bAts6quJEfP94Ch
 Ul+grSBR+VaSLFwmqCqlwie6W5xqPfX1n6LC6T0xGylMeFReuYnzh/0BfwvJdRBVI9gO
 Pebw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786610150; x=1787214950;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 b=fbpn74pASFPbuFUE45mpBG8eYUWgtzcQ06rywB8KZsQmpnN9D8B82d9+CV8aA5b9yL
 KPppyJnxmbd2FCHwcIdmokipJMUPI4nsCMwGxOa0j/+ZoRnnfO0sgM04HPuod+PlJ9nd
 v/c7uNQeb0iLBEEys4q0kP7goIv5LdiElVIxIEDKJAB7zO81kpCJ7dpQXpXNAKRdPoVm
 vBYUBrEulCEJ37gOa2EAhQUDesmt1mr6ni5i3BikNV49JVH2G8UWy2gzcHpwJzr+AqJE
 6Tdun0uTJaly6wl2UbuisqAgHaqg7E8pztEMmmqaZJ+dTpwYmJkT1zh8pYwkaYrQ/MQ7
 J4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786610150; x=1787214950;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 b=fx4wL/EQbAlYlKcKLSVy2V6vvHac99PWVuQMZsR/QM6QjBAvoyvnGGp8d4pKW3KLng
 mtlF2Aef+gbWOM00smFddheqS1DpAmLb81z2yurJouRwUugRk9fqO0SInj0pxNZsSOHE
 6gjk6Fh1ViafLPdvXHvHG4PrzGE4pjMl9OxFsVk7YS9wfxfnNJ84ZgRtHaXiU7y1LvpG
 Eo291GskijA8cdUbxXW/HI8k4YhzYP4QDldg8aJSkAaoSG5m7VVFL/902oxeAR8F5YNn
 ahJ52Sq03w0dwGCv14N6f7GfvEGc5tQmia2ml90oSCWpyDYNgiuV46rftxz5eNZ72xqa
 WV7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeSi7eVqY8fDvVXLxm0smT6c+942aNgmPS3Mr9nJlrBCH+DWV+oXX6sxQQdOOZfw/JG+0qN8qX8W0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznZx/dsAfGsacojz7wJYyWTSKzJMQeDG+m2VK+b7+h6bE9vgzj
 G3TJCt9c1w8C1MQM2brOD7Q1KNUvrf+ARbGqnoUMKTqmPJtZdtRSBVnkcIcS9ugK471rY9ws90i
 Kep05EH9Ao/M+T0AifAF1LqK4MG8LCRz5040JAW7jAg==
X-Gm-Gg: AR+sD10WhYVKYiI0NGz3nPgUeczySATiC22o2S5kXYYA5g1ne0qCbwysImQmkSWslDq
 sxXs5JOcNmvwmq06baXYcHI2tVRJ0u2JJCEFUkHnhio5R0qPhlnfyEVbML7eFW06zTgQJ2HAqjX
 MFJDsZTk8/SicqTB5ODnpvcxT/tI481py7LSI785FD+gIK6jSZkfiuxKpzPYDZN6pF8moeJMqwL
 51vSehhU3G8zIM4iBB9OowkjxbgsFFms9NVkFCeVeGjb8LVKgXDaxoXu3PF8NBY1WyOtC539QEU
 127/dVTguMadcxDNPr40rRwqF1Joh1ycFUMkIziq5V9P
X-Received: by 2002:a05:6a00:1da5:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-84fc744db5emr4187647b3a.5.1786610150481; Thu, 13 Aug 2026
 01:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 09:35:39 +0100
X-Gm-Features: AUfX_mwpP6c1PRTeqjm78CTc7zKe8fxHsiMH1wJibE82I0ix7CJ_6B0W5ARoaVE
Message-ID: <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
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

Hi there,

On Wed, 12 Aug 2026 at 01:43, Zuo, Jerry <Jerry.Zuo@amd.com> wrote:
> Below two scenarios belong to static/modeset ALLM

Thanks a lot for these clarifications.

> #3. Gaming-VRR
> > Is it mandatory for the source to set ALLM when the sink advertises ALL=
M
> > support, and game-VRR is active?
> Mandatory to set ALLM =3D=3D 1
> From spec 7.6.6, P240
> It is spec mandatory, and we follow it.
>
> #4. QMS-VRR
> > Is it allowable for the source to set ALLM when the sink advertises ALL=
M
> > support, and non-game-VRR is active?
> It is QMS-VRR, mandatory to set ALLM =3D=3D 0
> From spec 10.11, P456, 240
> It is spec mandatory when enabling QMS-VRR, but it is not yet implemented=
 in current change.

This is the interesting part.

> > > Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> > > doesn't mean we're playing a game. We might be using it to play back
> > > judder free video (where we'd like ALLM off to preserve the sink's
> > > image enhancement), or we might be at the desktop.
> > >
> > > I'd imagine some users would still want their sink to use all the
> > > image enhancements they saw in the showroom even when playing a game,
> > > so I'm not sure any kind of "auto" decision making in the kernel make=
s
> > > sense at all, even based on content type. It's a very subjective trad=
e-off.
> > >
> > > To me, this seems like something a compositor would want control of
> > > with a simple boolean property.
>
> ALLM_Mode is a protocol-level HF-VSIF bit; like VRR_EN, the driver derive=
s
> it from existing compositor-set KMS state rather than exposing a new bit.

VRR_ENABLED is a completely separate bit though.

> The Gaming-VRR case #3 is not policy at all. 7.6.6 mandates ALLM_Mode=3D1
> when VRR_EN=3D1 and the sink advertise ALLM, so it must live in the drive=
r.
>
> The only discretionary piece is content_type =3D Game =E2=87=92 ALLM (#1,=
 #2),
> which CTA-861's latency-minimization recommendation for Game IT content
> makes a reasonable default (Appendix G lists it as allowable).
> To avoid per-driver divergence, that default could live in a DRM helper,
> with room to add an explicit override property later if a concrete need a=
rises.
> It can be planned in the future.

I really think the burden of proof for implicit semantics in KMS
should be the other way around: do we unavoidably need this, or is
there (currently) no other option at all?

I don't think ALLM falls into this basket at all. It's nice to have
for gaming (and mandatory for gaming VRR mode), but there are plenty
of different scenarios where having it on or off is a legitimate
choice. For instance, should desktops imply ALLM because they aren't
going to smooth your text into oblivion, or should they not because
you're probably not going to read text on a 49" display? Should all
games imply ALLM because you need the response time, or are you maybe
playing Myst on your TV?

I understand the attraction behind 'we can just stuff this in the
kernel and it will dtrt', but hey, that's what people thought about
Broadcast RGB at the time. Or colour model/subsampling selection on
the wire. Or or or ...

Cheers,
Daniel
