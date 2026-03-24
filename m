Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D073F54AD6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 23:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04EB10E626;
	Tue, 24 Mar 2026 23:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZrLhuNk";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AC110E19A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 23:59:49 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-899fb2b94c1so55076436d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774396788; cv=none;
 d=google.com; s=arc-20240605;
 b=BtiuObkVbrX5NS7CIOmVPHAT0tyWuAzt498EN2xu0SJuDuIvz99pfeRXSudM5gEcke
 SrAbK1tiA40YEHCc/iAeNLvP6Ape8TeZiIJx4Yf2s5Op2U3dpCLURu5WgyhcII512QSB
 5AUWCIeiLf1O8Ea9dPkmq9CJdU12pQoQGBstae7lOrJbHT4rZy64tz9TFGiLEGQxC2ua
 528s8dwh2wKenTawExQ8BdpLgZouihxRJDxvkrIo3bbLuusc5hD7g2L0e6SZOThTA3RV
 bTvHdew1OUfhq+IGmI0gmlpVSVlCxDpNAe0YrYhJDk/WeDGcBQL1Lr9ILZjVCEneJefR
 RiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uiewSMRs+XwlKBP4+JT5tYJ1so3OLkN3F3J3k0h+W+I=;
 fh=p0Y6zIcLv72qpQ3RiYrp1Q12u4cWACw4gIUFl13A9EY=;
 b=jBpFO0gMzNbt3xz4keI+skMTuu7/Ees2UZSlmQx0k43OfgAMDwfDp4uyL5PTpHAZ8n
 qkwpYVwl0CJAau9knyDOcxqnfDZYLAmZLWZmXwD6QB2f7QQbJzRTb0NDzmPFC8+9AR4T
 Qnh40TZYMCJkq5ji8d4vRBJGIl0TOlBjLmyBPUVANpYEh05J8pqhubmBF8tTktXAY+l2
 BtV0dvQLIsZMf1zncqrPsk55o5ji9HlTOIIies0aLVFdR5krC0FB8tmS3TyeWh+QqijK
 EONVfQ3iTj0+Y8hOyve2pkGQfdMxaCabuDLIvZmtMWnyUFGOF7ZoJB9y47iSsoZ6aXrt
 kdrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774396788; x=1775001588; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uiewSMRs+XwlKBP4+JT5tYJ1so3OLkN3F3J3k0h+W+I=;
 b=ZZrLhuNkJGtfNxCUQmxZZRlZcR6EN8HuzBUIN5ro5IJbezkY3D8mGTr8It8x+OSlXB
 z8oYk676rr3Eh8gbCg9WjA2TPZer8M6QIyDBIuaMCgRWmf86aH88fooB1zPKnBGJ8A3+
 HVscgdfQxl1KFllkyEpgrZ1OhhvD/wTcIrq0sJvhYTlioNEhtERBCTE9qdcYpfEcJ9+C
 o7SW/fkm0LzrFHTYFoz4NW8RkTgv+Btp8bswDHew9XnvqnDxdszqR3T8QrIAy4n1RySM
 CKGw4+2KtrhbwaUHKUy9KWiy4SNC+26Uc2vZNjbmDo9AeD0vizYSAAlJjkCtSLWMHnYD
 Qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774396788; x=1775001588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiewSMRs+XwlKBP4+JT5tYJ1so3OLkN3F3J3k0h+W+I=;
 b=rzc8f+/ztkjLZvvDxgmfBNpn5JsW++5YrhR540EY23ve2hviH1bQMVJEGphyWp3ex7
 CvGnZdCODVsxmGrB6Q0TV1Z54fxPi0qi8mAF0hIv+G0+WscyhvSrBd3BWX1JHFwtP7XW
 wm4b8jopuf0ca9Qt7796xXjDEKjCabQOEIWFCKi0uL3VgNsmrLcgEQ69BBkTqYE2OX/A
 sluYUsaflhixD2je/C5PoEyN8vVXeG3/l10Gr8+oV9gvgFwZdUG1yBKG2Su/1D/gsZdO
 ciYvQLrjLzpg0lEnzd+fJeSh0oXQyMrDtczGa+MmMeAp/NSUa3eX3vvpkWuKi5GJROGQ
 AaZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq7ouaqwZLvxY3zUimL2+WkP4aQLIdJOFcwpJcigTw0/Vx3BX8DzqdMQDd6ms4KjvmRxXXDkLVXD0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw63bk4PNPFShMOkPwc/TEdwwLxVIG76DTtq9w8JuFUDFelCG5F
 Ij+hO9L0QD5IAcGW7rETG+nqQB3Q77Xe1Nb4Pmmjs9SWR1a9PvQmPQGNV+SqJcVh4Z4cYxjhXR+
 z4N5mp7HWx169pDz+maM83LugHJOuWEg=
X-Gm-Gg: ATEYQzzHWyp5QeFL7Z1jFVZTUX5LIca1UEZmcTwHWJDDk/oNBxV7jZc9DmmI3cal8+y
 LO8X5lJnKBR3w9GH4qsRGrKYHu/JRjhxuCrT62qxxe7e9Jwg+UImGdCMv70o7wV81QfvJ59IX5d
 mc9uWSJ5SBj1dgcZQeyO+5T/LMU7ciLyJAuBesjCDNeGeHqFQyt+Iof19Nzw9Gg8q1u8fnSPVYn
 mMwpj3xuBGq0jX3hL+/h1Uf39WlsqW3M38kxXzA+G9RnYCZwDU6Z2eOei/DNADyxmukdxYcfek6
 J+OUzR7CDtfSaZ9UTe5WtuVWV5AX/7EdwxUDeHCI9D3J4/rodYgGDhvHDr8PkocLJes=
X-Received: by 2002:a05:6214:c6d:b0:896:cc24:138e with SMTP id
 6a1803df08f44-89cc4b65e6cmr27219036d6.54.1774396788182; Tue, 24 Mar 2026
 16:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-lt8713sx-bridge-driver-v5-0-6cc2a855aafa@oss.qualcomm.com>
 <177345419701.98253.11507693763985665579.b4-ty@oss.qualcomm.com>
In-Reply-To: <177345419701.98253.11507693763985665579.b4-ty@oss.qualcomm.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 25 Mar 2026 09:59:36 +1000
X-Gm-Features: AQROBzBAhdkkbQbtMmKagJBqy5qFRmo63QEe7wc-WMhxWlbYF3hp2JIC-NPKySc
Message-ID: <CAPM=9tzAQaZbzpVw521cwBc2btWC4AK488edwuDE5D+Z6d6QYw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add lontium lt8713sx bridge driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Tony <syyang@lontium.com>, 
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 prahlad.valluru@oss.qualcomm.com, Prahlad Valluru <vvalluru@qti.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Simon Zhu <xmzhu@lontium.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
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

Can we apply the two follow-up fixes to this from Arnd, this is broken
now in drm-next.

Dave.

On Sat, 14 Mar 2026 at 12:10, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, 03 Mar 2026 22:13:34 +0530, Vishnu Saini wrote:
> > The lt8713sx is a Type-C/DP1.4 to Type-C/DP1.4/HDMI2.0 converter,
> > with three configurable DP1.4/HDMI2.0/DP++ output interfaces and
> > audio output interface.
> >
> > This series provides bridge driver and dt bindings for lt8713sx.
> > The driver is required for firmware upgrade and enabling the bridge chip.
> >
> > [...]
>
> Applied to drm-misc-next, thanks!
>
> [1/2] dt-bindings: bridge: lt8713sx: Add bindings
>       commit: 130daea1cb6217fb9b9ad51453e0a06e8111b3b2
> [2/2] drm/bridge: add support for lontium lt8713sx bridge driver
>       commit: 4037c6adc1f99843b9076e7ced85db0f233e9eeb
>
> Best regards,
> --
> With best wishes
> Dmitry
>
>
