Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20BFCD3442
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116C810E513;
	Wed,  6 May 2026 07:47:27 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F371A10E182
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:25:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so1873931b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778019952; cv=none;
 d=google.com; s=arc-20240605;
 b=DrREx3IugoJqPyEKgBY/F1QPSHpS3f+gaM5klnfSm4V36L6kgoeNdxK9917oAtXd6b
 VoKiRlmwI9mBJ8u4cyrJsUJZZUxHojAeXO6EGy7B26cy7NUNsk4jg9yTNGunUsaSOtoC
 IrpYE3R8/epCCujIAAxI9z6jWRGDpqtCRtGroPnUCAVIl6+yT60zqHz2gLV8RflB2I2d
 ff5cgQ64RTzl3x0sZonRi8iMZattU/FGzZeyFdinLqA0wnx+30Co5S8jSu8g1lyPYLoZ
 rYYapd5H1G1dpOZ4yr9E0v3HIQhYF7y0mrNvVHrgN98c2Sfce9isClcaEXp/zS5h9Gzu
 ZiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Z2JpVZpwEkkxXIyrqDzbrggAQUpIpo/aeYhdL9hdyqI=;
 fh=ZF/aOkM3ZPrRmKRhZS97b208lQGMQbai0J0D8KR1bUI=;
 b=SLF97SlXS8oSbdD+G94sw/vO4AJSG3bH/AhGOlat3LJvw5ObCr0ObVtdp83mypPhdr
 iXtlvR31Pdn18jp+Sb5ubmAXW2UsMs8QVn3H1FW7NHiBBP2Nung0E6tV8uvekEjJaKRQ
 gFsm6B++9PAXfi0di7HlTX7fkLdNeH/GSoOyVg2qZTz61qUC4/CsRgP+9c7/ydsZeaoy
 ZHwTEQuamJ9mH9DCaNas15kvbHoOjBD4bU3ZITlLzgF/Cb/Z4ejRBa7NSCE2Ye7d4sfy
 jEEj33CN8eOiceJxj6a0Hq/AkbOnUMleVK1G5aGX+cHYdVmFePDf/Xp+X4XxYJTQjaA0
 xuMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778019952; x=1778624752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2JpVZpwEkkxXIyrqDzbrggAQUpIpo/aeYhdL9hdyqI=;
 b=A/zF1OhPdzbbsz4QUd14ltRLqIQutLDvXvxImRwND3ZtLYsh65ebr/1x6VNgkYcUDg
 5WKsLac0HS+h2YqdnoGs8UTyLk9MWBqhSu6sAxKk0wlot88cJ7Q9YfzzOezaKXxYROpu
 neFnXFb+mmU6iY+1y6zVxR6slhsFngjxYxjzweQfLr9apZYcskZzt/TxsxqAvZYaR+vn
 5ZKxc/KxuEgfuMKzsfZiDQAHNJleNE442bAc1HmM8usdx1EzMLXFHpA88h5yGpuh07EB
 MI8PHXAx2uGCZk3ZbQ/EZZANS9C1YHYCb/0G3WxRjn2LwfU5BS9KnoOuhXVINkS2aFW2
 Ydng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lMJ6xUxtNo8WKI8zW5+Cb6xZbhmWMSVgbN/yzFalo7hgCP0skncCLPTZk1bJtbP4UBF1sGuX+idc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxrKQ7xsH9HgTH4tnd3nh1kSJgCcgimqLq7WEHb7d+PI7f4LMH
 gqrRKU+tY9CoihquuaU2K6UwrnqJAgB0zTfoB84ZYPftnZpFtXNi1TS/8oAB6aDfApbZYoeztBe
 mmreRRuqgJyceI7gXcpVr0K2OOO2m9mU=
X-Gm-Gg: AeBDievK/QL7ldY14dGHXmN7yncpA6d3GrSEhKo514Q1p3eROTUVpP9CY0PuLB76cX5
 KOOrqQ6/G4Cxm3hrt37cMyPkNxTCMNPMHfP/zNjdkLJkHDBuHCr81gSOTCc2zvLCOglz71j/bZG
 JYmzLYV1M7lixuMaFLwcRR+rJ0HS3w/CnSllf6UfF40R+qZ5ZsDRAtGQeeFu1ayT1JXzcfWZuLk
 aQJrFZavnUEdQRhfgJ3uXg13PLv/1oJfttYh96NQc91W0JJFPNJq2Wmrn73h8h/pt/oaCpxseBW
 vAZXo7+p8T2UvMVEnbJz6ZOMNZ+KYlNPKE6MQM5p5fht5P3v9IYqrawEo60hRA==
X-Received: by 2002:a05:6a00:3c81:b0:821:7d7e:41cd with SMTP id
 d2e1a72fcca58-83a5bad9ef1mr633954b3a.10.1778019952505; Tue, 05 May 2026
 15:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042631.1916555-1-domibel@debian.org>
 <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
In-Reply-To: <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
From: Dominique Belhachemi <domibel@debian.org>
Date: Tue, 5 May 2026 18:25:41 -0400
X-Gm-Features: AVHnY4Lo6UtcN4hSCb14mibdOGotokNdtYYLa4ze8bpapQKXeqjIKujnqT58ymA
Message-ID: <CAAvaLCyZfdo+h+gYjEd6=kDug0A77rqH2e4U7JzpUEEGo_mvDA@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 May 2026 07:47:21 +0000
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

On Tue, May 5, 2026 at 5:03=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac.=
cn> wrote:
>
> =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominique Belh=
achemi=E5=86=99=E9=81=93=EF=BC=9A
> > Wire up the standard non-coherent path matching the ingenic DRM
> > driver.
> >
> > Tested on StarFive JH7110 (VisionFive 2 v1.3B).
>
> Interesting, I am curious about other patches added to test this.
>
Hi,

I tested this on Debian unstable with a slightly patched 7.0.3 kernel [1].
The test branch contains your verisilicon series, Michal's JH7110
display series [2],
and a JH7110 ccache change [3], which was also required to communicate
with the BXE-4-32 firmware [4].

This change here is only used to remove the ugly framebuffer stripes
on the console and in the desktop environment.

[1] https://github.com/domibel/linux/tree/jh7110_dc8200_hdmi_v7.0.3
[2] https://lore.kernel.org/lkml/20251108-jh7110-clean-send-v1-0-06bf43bb76=
b1@samsung.com/
[3] https://lore.kernel.org/lkml/20260430035259.3402954-1-domibel@debian.or=
g/
[4] https://github.com/domibel/linux/tree/powervr_on_jh7110_visionfive2_v7.=
0.3

Dominique
