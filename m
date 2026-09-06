Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B12FC79F8C
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4730A10E0BD;
	Sun,  6 Sep 2026 17:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lx+qzOnI";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6E410E0BD
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 17:29:10 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so30443685ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 10:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788715750; cv=none;
 d=google.com; s=arc-20260327;
 b=B/hXQhqmOC6iHTO5J/oc4WetJMPGHb+4yKBK/7TrQxsewdaRkZjTyaDvoayUD3opPz
 eq3FVm1ufAHNFMcgS6zboSv73Ow2WMVFISTlWCdCsfN7qevYNnTocALs2JI1HSACb9Yz
 //hnZgSUFUSZrFotJ3FjYj2PcdOtVpATbrkVOXNQ7Acm6lpJ1vKfx81h3rKDBsX7y06b
 uF4+ueNg+e0OkvwS3Hl2thPxBdrjd0K3ceu5Kn1gh0YFMFCl4EkwLmuIXG84w+BfA072
 1PnAPCpKuH8g7S/4IkW4t7tVE1YFcJBWPSOutfV9ZEKsbQyxPXe5UCthjwWPy7Lyz8kG
 ViYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
 fh=WewYDEOdKQGQJuk3bT+nof5dD/KwkoVb+mmQx4vsS/s=;
 b=bfzIOwkiPtag6iXpgb+ahAyttM9v+7ZfTlNb+tWjMjHKmq3iF0JO1ZhXz3K4mj0wXL
 XA5Qu4QO9ioQZM09mTw/kdV/gBTh9Yqp7qz0RNDoIkcvsiLsDA03fzEoP1DkWHX8Pf4C
 ELBEF+XIeSINlsz7Iu/N6uv8jVmTWG3PEDM6d7lkScCWikTBZO1k4BlgckOJzGpZyl9h
 SrawC6QDsyD3h0uAZa9ONecqnm6hL2rtG8pmn3yav1FF0hY65HNX/Yspa1NRrTeOUCgr
 4ZUjL4XCkaBo5oAVQg8lE+quSSQ1YzPv2YsU+9aUZ5e1K9dGg+LBtucKvPW3c5L6S0XC
 Mzig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788715750; x=1789320550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
 b=Lx+qzOnIbuorH/SsyIm2iRhtojyPuTVMRUipFCopI2n7p+gSk9WBhLuS3wrBdq10Mg
 LY8AL/esdt8tNqRb6A3XbutfM5I6YXaD7ebSqh6SKafnS3ndgblx9NCLOoR3cMn7vi04
 79rUM/lGGT9uWqR+Qx4fQQzWRLzVhxRQkivpzc36PH+dgOlRnb9jj6bhSA4PYxF3Igoz
 pWx3Cr365tOSr5qAsfEaoamR2Yyyj2fqejeVK3lPwAHHByxQX+OIV7JgiULIsORlHjfv
 Zw7KqvLBNHtSbBkzWAP3sPWdO64WzdMmH/jk1suU6K29HVnmBXuMRBxVFnDLhoAgqDfP
 KmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788715750; x=1789320550;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
 b=jWyk84CfPX0rvlhxCE4j+HtG8wJceogZOs7qHug1UkYCDe9lgcLgUXWCZmaRWzl8gh
 Jt2k4OnBF857x1RD7NLi0Al3U3tdraS+PTh8DRKd/w7iMu18wN0n/JLvllQVzB3kLzfi
 L99SwB7igqFTs5cyrb3FHeFvJjo8lH1RH1ENRR8pIivlz1kyBgYp9QeXk4yO1DLzCnPf
 /2FylUXb00pD88kc0LXrnffAsYK0x2fXvTcQCiinrAVNwHMnuU+c2cxAK69DsfFUaaDN
 WpMkI9g7WdEIg7cL80w/ZcnM0jimnYRLixygHMog0yQdS3uvZ2dllWSGWBLotaaatBYA
 xXGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKGWsI+4Ati+krNUnFlsO3x5Ky62DxJswANd5z8sGhqqfuYbFL6MlIMLB2+4XlRC5rAOPQkcDpQ5w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nK+xD0QOCsWHWZNNsxzQUaUSxLl1DqXSP61YQi4D+DdUP/gbV5
 Ytn2VTwXOGCqTgKMfhZgSy8Td6W5jbH03ANgrB17RISAZY/YwgT1MrHvuShv57LmPV6qC+s5XiO
 PrFJRtDVJGPMLEcAeVsRVZXWNV2Yp9Ww=
X-Gm-Gg: AYBFou0S2Whce1w8twNaqLoCXNr6rb1c4+CBEQAozub1FRGfRZcSw+UCCCcBryDPgQp
 RQOUw2QVpNh+oVVowWrA/VeJ6rzNj7EUj59e3RRCUCnZWvVCOQmRf/ivDNUk8XEEuZgH03X9D31
 kv66iSDb3Q53NsJ3XPS9MS58SN+s9akTGauVZtv0grUWw884j0QZj5MGwh+1qGn/qcG2pfDBwWy
 GojNt1cUtKFh7mrrLk0mgAy/tlJoqXc3sSIPrul48G3xLoxUvZsBSjuY6TrWZ+AOGC0M4Gs+EkU
 uZv+6pBKJcoKsUgBLcS7oPczxUCWukEEeiTR0L4BONUacmt+HUuDa52h1czERT41/16syVd1l7L
 lcg==
X-Received: by 2002:a17:902:8a8d:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2db122edd50mr199148445ad.5.1788715750074; Sun, 06 Sep 2026
 10:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 6 Sep 2026 20:28:58 +0300
X-Gm-Features: AcwNN1XWisbz2ascChHcLatRKYQPwdXAhH_U7ChBKnQiXROAqpt9L2vnmsacgR4
Message-ID: <CAPVz0n2fRs=q-1dAEt2k1FJpQVK9+PMSY0BSMB7Rs3F2xDyFvw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings,
 improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello Lee! Is there any unresolved blockers for picking this patch set?

> --
> Lee Jones
