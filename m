Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D62lie1t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A2B112540;
	Fri, 13 Nov 2026 11:16:56 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C1710E4BC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:16:50 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b6f42095bcso1571921a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:16:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794568609; cv=none;
 d=google.com; s=arc-20260327;
 b=G4ORw1J7mo/IUGEUL0a1ALVhIRJ0KCYyypwMlfCcB2hpF9ie1IikMRmo1A+cN+Rfzv
 ScN1tj5pIhAlAZtqBHfV0VZC5oQ9hx86JiC4ue3Xps+0oD5W8OUA4EwenwgVBOClUpAW
 D3EPDf6N91PrkOC8lRrQ2vOMjlnlGkf1mcs2Arfg5j8BXm610GbPKMsUjQ+wneFVW8iM
 ghTpLeyLDphf0l7bNHrBbZOcRL+7xZBg3E99pJ0R1fssGKiQxnQO+jCcsHMXh1Z+04It
 EbN3RN0wKjFLg0ZMhVFNYi9R1dBrEHb5aZAfOWZ+YrKLLxo8KSDjJr5wXqeekxAIHo5Z
 I4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x+dL/pUR4F4FQVytUdUQ75lGkzx/qCuTpi3tX44aRZ4=;
 fh=f4KGYPz6fRMe3vPb7VyaC2s7+zzlNJoF8bZeRJXR+Y8=;
 b=DqimJ6GCiFv8v/+ZGeWr5xiVrLKocBMLrqblYtnY8Gq3/F19mD5UxDKPRlubZJfWAz
 aMaJKYeEGxdJq+0nklbR84OVrggczYaKqQJ7xdmxkVnTi0FErWm4U0RRuvIownWgcjxO
 hGnt9GyNxsm4g8ZHPEWdFM2fqom/bRaLI65cX5Gr0UdGpYbL1FfpmxmX4n6ELrCMfT1+
 uO6cQuUTJ3ldASfP4LTuZswswhzKZ7BYQbov40YCa8k3ftNIgwQHl1vF316tZWYHSoZb
 gaFd/qy4DlcxvqYQOUAO9g/OqHvk31zO6yuvn/tjdDnV28wE3ah5+csGpXZ9z/BJgWda
 4Lcw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794568609; x=1795173409; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x+dL/pUR4F4FQVytUdUQ75lGkzx/qCuTpi3tX44aRZ4=;
 b=D62lie1tc0TyI2+8hRpVNLso9kh2tqIhNi1qkMFp/kIqq/0sL1YIeEU0V+OU1ZYyj1
 0BaEcjQzhZJIDXKI2yzS1pdKcBoCAqqjDwVnB/jd1mnUe1e2eOXsm7ktFh721PjACyqp
 LWQ4oBYYIwQoy2ynEpf3pP3LNCkjhmtuAOSrxWO7z2/RCz6DST4Ik6sWG/MRmgKempSK
 w6qH3kSXKZqLAnXubBHG/TBkmDk5ORHL/KN0/qNBm2pvWlrLhNX9cWG200rTNJ38oVQ8
 A02VXrnBgBf/20zpyNAVdNWCLFU5CIynQLp2ItFGT5Uq67ZUkmarlEdzVOashvUX2wOQ
 oNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794568609; x=1795173409;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x+dL/pUR4F4FQVytUdUQ75lGkzx/qCuTpi3tX44aRZ4=;
 b=s/ETEt8lNdKC1zHYJrGfOXbMSXmF9kyCcc9BY8I4rGS/4KhOV3ZoPElnljnMMvLt89
 mNyd/uO96fUiGO9Ng5H+ld/YwMnuQyen0O7t0P7yGZvekTrRoHDacoEJdnMM4d6xcPsh
 gpsQYt6M86SN8SaPBB8K39gHD8+JlotgI1j/nQb+J/Yuzao/fcLxo20m37RZY9QBJIZM
 Tc/xjzV52ORLFVmJcCxZyWlKHBKAK6z0AfJzpI1AASjwNYfYCze9PtP3UxHMyKir5PbL
 NWisH1Oyqpyp+uHeBcVe31XpGdTFq4jVe4nVDkVadYC/g8iAjYz4StBhnphidsJIIKiy
 Bu9w==
X-Forwarded-Encrypted: i=1;
 AL+hErHNSWiu5X9b3gy92Yff5Ey+uJusoKZ27oOxiN7xDzuxupwID3LtHpyNlngiqe33DnhcTw0VAEq+kpY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dzlB9DoQnnDKLDwE2CePQucQL7HL9cR8TOqWokJ6Un0dYwkQS
 fOEPOwHchz0wCf4IOY/ap41JptbVPdNm/q222nMMMMmd3A0BoyP1pqG4uQe4A1uWKnkv4lSknlj
 hXA/hxnRidgCdExy6iFfMYYVGeuLomLk=
X-Gm-Gg: AYBFou2A6o7IQc6kLZ0xgV9Z45hntz3SptOmBNkwG5JI3s3zUBaJ3zUsUyQTTo/e8rQ
 /cgnQgqoXPXMp+hR+dsQgaqyVotzBqgMdFCFdH+0+Mj9HhRTaXdztPa1bNCsfcQJGQsqRD+mVIx
 kTzcbfo3wwurpc3trA+KsUzrkN9N7gDZg0lNC2CqAMH9Sp3h6TUXE6fQDJS8L3hmSLCsL/VRVZS
 nvlxKVQKGkx16VCn1POmD9+aJSsGtyaMO43+5odCMQIxo9AkdVwVbIyWm9bXcSmtpBbSqkJhzn0
 Nk8Pg7eW5qN6l5x8nX4hZxuKpOQRIDM6ag57dTrdRte3CjM9GcMcE/meuVpusnhhEeDxCG+vyL1
 zo8CL8qPrMqGBnIWZIlac/Mv8Pnl4Hj3yJc6TIJwdlQdLTuTFk7IVO3XIGkP9scnlR/Y3328=
X-Received: by 2002:a05:6402:42cb:b0:6b7:8591:4824 with SMTP id
 4fb4d7f45d1cf-6b7c0d02591mr1780882a12.37.1794568608969; Fri, 13 Nov 2026
 03:16:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
In-Reply-To: <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Fri, 13 Nov 2026 08:16:36 -0300
X-Gm-Features: AclHuK-sgiJfOe_aa1gMorIQEzhhJIDpc2gzRfdf_b5jPlP4iRad4Uop4eDvftg
Message-ID: <CAFGNeahrgeXe870i50nq8DRsqqEyUEwaVCoz_-iEUias4E31=g@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <jttelaak04@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000767d220660269033"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000767d220660269033
Content-Type: text/plain; charset="UTF-8"

I would put something like this: Poulsbo driver in the drm GMA500, and
generic SGX535 drivers in powervr_sgx

>

--000000000000767d220660269033
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I would put something like this: Poulsbo driver in the dr=
m GMA500, and generic SGX535 drivers in powervr_sgx<div class=3D"gmail_quot=
e gmail_quote_container" dir=3D"auto"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div d=
ir=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
</blockquote></div></div>
</blockquote></div></div>

--000000000000767d220660269033--
