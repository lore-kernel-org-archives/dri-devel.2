Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570E10F2842
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FF210E275;
	Fri, 27 Mar 2026 15:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qNVxcQga";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6167010E275
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:28:07 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a12c19affeso3675933e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774625285; x=1775230085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tAuB14KY8sm1zyzklVI5F/AGlzK5GVbWoscRV5zS/Eo=;
 b=qNVxcQgaAfW30es5647tXECRWWxyc3OQiD16WIYa/Th1XMaky3+Cj6fctnwROK7h06
 II0mbWUp2HZ2AcQn+t5OKP22zx54eqtMr2cMZzl7xZDYI5IJVN+qyU2868EV+tOg6sh8
 7sbuIA0z+iL8Y/WNMgQ7cq2bRQrJDKIup6xQ7j9Bew1umUgLKsUbNdzKCZIvyUaWtwW1
 n1I0gnJSNOD+R9b/9TrtKsGBPAF+WkoGQ7nE+iQW5AGcY0SauyvV9ZJ1xHQGz3hqrpaH
 ICe/YBkkd4G/GcMI4+r6gN5QsU7QmKAmPx9XYj4FJSJ5t5lx12NacrVm1VaBtcC0Kr4u
 G/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625285; x=1775230085;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAuB14KY8sm1zyzklVI5F/AGlzK5GVbWoscRV5zS/Eo=;
 b=XJ1f/ZlGIMSw+juLzQCIvs1xVEtVFkpAny6YJqzIlRApH4XrKQLcqkOPFnNsHV8vR5
 gRDk/fbTOyTGOIkj6m3bBRWK4C6MkEgk5Qj/P5HpIxot8iYAsqcG9zrmTfr/XJRtRleL
 lPW2HJCTniqOWwuKHt9k16ksc4iLHQVxAd+kyf+65oVccbgfJp4uUoYCpMV2ejlNVgm7
 ee4Une5QMnkntdvBBUtVN+64wFymo/BSsa8BtgsoMgFRfgoy+zySg02shVwQjB/3EU/U
 y764x5x/BfVTV4OBiAtp9PUtyObpBpLpC1RjdpuN/3tEDKFHtHYIPUYFI1BWnIS05axD
 X/9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMwzKqyWGrGutMFGd576ATXJmNx+pclg1LBY9XxkKMzL4FYHGLCXsdzNxHW/p73VSW/+/VnSB8I7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXqMRMOF9esNTQHlulC/Yy/JaFn5FKsmGAJr9YdOeOqYYuxniM
 xXjPznsaqx/eUr2htKSRT7AUC8b0poDLIovePyhECE34RHO3Jq2HXRoM
X-Gm-Gg: ATEYQzzp9xa2B5Ed7cc89a/AjJnbJH0sokbHQLp3IFEyvVu9h+Sk8x4pgp8ffmlJeP2
 lruC9T3GHVstDraKE2szCTwAMyXBpAQ2n+nUYFPdCcEltwtbyN0nc5JmPgYHEMlo5WTWbGwDgoH
 WD9E21hyEGuPwzhHHhua6HkpxE2Fx4SvFKK+hXr6QZBJcTpJPmi3fh7QI0Bnlm5W0Qvvo3okix3
 Vk/fdWj4TfFMp0dzjxDlOfQcklfanUQVD0/TA0E5pK+BRthRNPd36IN5JVIpD6F5gbW4OLquAWT
 F4aZVEEQHt6u6Pgw3tBZYNDR1uG/OvlWKbWqpWM1dNaykL4cDXZjwMt+VvNCfvaXz+bDm3+mN46
 HRe3jzZvMiJFlu8yWBVfXTqppiPXyffs2E7l2TTxCoPcZHDCMYcdWU1ny+Fl6VxsklIrDqgX1rn
 zhx4XFcdYzCn3QP6y4bGcPPwCbfHINGnTU
X-Received: by 2002:ac2:4bc1:0:b0:5a1:355d:674e with SMTP id
 2adb3069b0e04-5a2a505c5b6mr2257466e87.9.1774625285215; 
 Fri, 27 Mar 2026 08:28:05 -0700 (PDT)
Received: from ehlo.thunderbird.net ([178.137.189.225])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2a0699011sm1439422e87.77.2026.03.27.08.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 08:28:04 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:28:04 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
User-Agent: K-9 Mail for Android
In-Reply-To: <acafk7munaGrCTK3@orome>
References: <20260223065500.13357-1-clamor95@gmail.com>
 <20260223065500.13357-3-clamor95@gmail.com> <acafk7munaGrCTK3@orome>
Message-ID: <546AC4C1-CCC2-4C69-B563-B29BC1D865B5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



27 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2026=E2=80=AF=D1=80=2E 17:18=
:42 GMT+02:00, Thierry Reding <thierry=2Ereding@kernel=2Eorg> =D0=BF=D0=B8=
=D1=88=D0=B5:
>On Mon, Feb 23, 2026 at 08:55:00AM +0200, Svyatoslav Ryhel wrote:
>> All ASUS Transformers have micro-HDMI connector directly available=2E A=
fter
>> Tegra HDMI got bridge/connector support, we should use connector framew=
ork
>> for proper HW description=2E
>>=20
>> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo=2Ecom> # ASUS TF T30
>> Tested-by: Robert Eckelmann <longnoserob@gmail=2Ecom> # ASUS TF101 T20
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF201 T30
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  =2E=2E=2E/boot/dts/nvidia/tegra30-asus-tf600t=2Edts   | 21 +++++++++++=
++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>
>Two things about you commit messages that I have to fixup every time:
>
>  1=2E caps after the subject prefix

Prefix ends with ':' which does not imply using of capital letter as '=2E'=
 '!' or '?' do=2E Linux documentation does not regulate this=2E

Even more, examples use lower case

[PATCH 001/123] subsystem: summary phrase

>  2=2E wrap commit message at 72 characters
>

The body of the explanation, line wrapped at 75 columns, which will be cop=
ied to the permanent changelog to describe this patch=2E

The commit message is wrapped by 75 characters, as linux documentation req=
uests=2E

>Both patches applied, thanks=2E
>
>Thierry
