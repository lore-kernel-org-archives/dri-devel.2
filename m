Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9190C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC6A10E440;
	Thu, 10 Sep 2026 16:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFih7TpY";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D342810E440
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:41:04 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so34017a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789058464; cv=none;
 d=google.com; s=arc-20260327;
 b=RY2TwV1OkEeehzK+7Dt6jFIamr+2TI2Wi/QjI1f08UGyibOyTSlSsD/W45nBvz7PhW
 Iyxiir0gqkHUbkRPpemABQKG4xXkhK/viPDJ1KlKMtZMv6kzNGkzZQdwnRMYbDIGBvpU
 rI5aTT11efulrLtB8vv5MCC7d7OHqJwLqkxo2lITZVAlqfCjkZBFtph8kxHdkgVhZWOd
 VhO/nU7kzLueHv4v/bfvvQf2XnUTnBCMeKKYn+Xg7bDWgK9oCnr/Q+Mib0gzF26imoQN
 NJ0XlcX52JmAFyiT2iyBDx2cBo6cIl1XF+PdtMdSWSK6VD/odwfTYmlsNxtbTnLK+Go+
 NmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
 fh=G9oQwkU6V5tWCsSBg5KEABVJ8zT8ueYq/Cgn1mETfcw=;
 b=tDT4tyfoTHd3Xxmd6V9MbbG2nKJBSjpJjd66eKwJdIbU4F5ro2ThZLhvddXLNhXI3e
 zEnB0LcrrhSjIoM79DiaoPkeetYxlEI5+TtMasnOM6Lont1faAx+Uaz04ZEJg3fBqwFm
 JTzJ+UXtPKgm3J0IWMaIWzdmp+ez+HDK5rAt7//l8/AyF2Wog89adcX8EBtNjthpJFaW
 5qN7cSqVdAD/XhcSluu38vLoMTSNBAbZkbAxggiEe//TQ+1BrMcJNwGg93ONW9jaA+wF
 rHRhf6GI1135uRuGKo0Lgjl4VelJMKcG0VIbhgwaZHqPstu3Gj3lPLhBEpEmARuEMYAe
 0TVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789058464; x=1789663264; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
 b=IFih7TpYKHlHqSOJ2Kfiy+ci4LV1KobFYcG5RG1wAQL+Vx7OIw5B5Z/4U6+vELNKDK
 FWq5i684yo6bSaoPcbb5+c2sj6qqwfNuQA9ADGC6K75JbTS5MoV+uYi28Twh213kS+Ss
 mgHCTpD8t5hpsb2hfmgUTWVfvzagHIawf0GG9Xi7lVTSpZBmiXwSIdq+pxE/54KuruOm
 VODHxqp1z0DKyXhZ6s7HBKTERYJff4LyLtO9Uz0FAL+QM/hfS9qYcyFXHkgwSh8wgxAO
 uMogjRYKnGe7TGlLOUkwFJ1n0tR9YAnOgJYaH9hcC6hxB81r6VUCEjyDbDBFVFU9OxFx
 lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789058464; x=1789663264;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
 b=dROPEiGVvcO5f1YHBkf2/4sy3PMStO4kqzhcncWYzSo5G0EBAFaxhErvBGNcPE73qA
 H505WcGuJQDUOtXUI3D6UcwIDWPQIad6O31+DLiTiQcCbeknP3b9yf0nAyS6uN6TPfHO
 q1SVna+Z+NzHE/ZDKFn3johanueKz9CJAXA+WYi0Zl182/tE4ghMEK90RZkbdNH6rkT2
 SWPjcSsyNFxRZqd24YRvcX2E5edTxHn3TwNctYeRMOvlDLvP6MjZ14YvMRHxl2ZH+yqV
 FmzjCCF4RbEf3O7gp9Er7ZLfVKyjkgs0qnqKQe2Kj1r0EUSYwAU3wK8i7Tc44aOenH+B
 gTSg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfo6VfNlSlzy1jJr/ItcGY2pm9V4At9chyO7pk7Jnk3jwLzlC3bhOdb6xJV8b9f2fXUIm7FPDMYkg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPYmpQB1Rm92nqs2HIcR3xRmYrBui6aslctbxHcTX3MGwSknA2
 SRJ3qfNTmAj8nKZ9DZ5P001/IQTEubtscWQ8AEd37yfqg30yuyZFfj7S9VHASwbeX+vuMlYSisU
 BS5Z1fBD2uxJPP+MAY3KxieDhgselp+po+m7hKAk=
X-Gm-Gg: AYBFou0Lz0Rn3qjrEOmUwTkKthrauiCh48B1ZPXH4Kzfp9H9jeXOEiUf7ROrkgO+A8a
 Ufnb8K0OcQ+izGPpEyD5lmC8X6gj1EkqgLwdcNAZdPMFrvMveFyPw4Lnl72nZcwgIXhUwKNsG+b
 zwGrEq0rF2ddN0xYWaSGJ1fY/tZCuHs8C6ylACMU+0GBzYulK4t/8jX2uzLfiTINLzBO2dNaYoF
 hbnkAtwmCRlKSPRULHnyMoyIVnmEpSlWZkgB4WNG2vlKzKrV92EzqgvE4tTmyf9Wje8ToQX+GEa
 JkITyROjw8B/WcaBj22zrpCH/hpo3yJuEwhLugFG3A5SIdBfO5ekN5wTHu+P4Xv1UAODfvnRtSu
 FbTxuM2qdzOWy
X-Received: by 2002:a05:6a20:4388:b0:3da:1e2f:3be9 with SMTP id
 adf61e73a8af0-3da3a0b0070mr69030286637.22.1789058464290; Thu, 10 Sep 2026
 09:41:04 -0700 (PDT)
MIME-Version: 1.0
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 10 Sep 2026 19:40:52 +0300
X-Gm-Features: AcwNN1W4_hjYZnmcEHRG7pGvN7c5hDgMskFtPJT5Q7EoYoaMGm933k45arNi9hc
Message-ID: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: arnd@kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Helge Deller <deller@gmx.de>,
 devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jonathan Cameron <jic23@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev,
 michael.hennerich@analog.com, 
 patches@opensource.cirrus.com, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 support.opensource@diasemi.com
Content-Type: multipart/alternative; boundary="0000000000003f1e49065b23a2bc"
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

--0000000000003f1e49065b23a2bc
Content-Type: text/plain; charset="UTF-8"

Hello Arnd! May you please spare AAT2870 from being removed? I have a
device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed yet,
but in process as well) and atm I am working on converting this driver to
use OF. Thank you!


P. S. If you are planning to remove more old drivers, please CC me in since
I may be interested in some additional driver upgrades for devices I own.

--0000000000003f1e49065b23a2bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20

   =20
 =20
  <div>
    <p>Hello=C2=A0<span style=3D"color:rgb(0,0,51);font-size:13px;white-spa=
ce:pre-wrap;background-color:transparent">Arnd! May you please spare AAT287=
0 from being removed? I have a device which uses aat2870 (LG Optimus 2X P99=
0 Tegra 2, not upstreamed yet, but in process as well) and atm I am working=
 on converting this driver to use OF. Thank you!</span></p><p><br></p><p>P.=
 S. If you are planning to remove more old drivers, please CC me in since I=
 may be interested in some additional driver upgrades for devices I own.</p=
>
  </div>

</div>

--0000000000003f1e49065b23a2bc--
