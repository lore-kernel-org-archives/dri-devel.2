Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D4AFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA7010EEE3;
	Wed, 29 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r/9lJjSj";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A89110EA89
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:08:47 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d4be94eeacso11492864a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777363727; cv=none;
 d=google.com; s=arc-20240605;
 b=fh28MsM6a1uKGJzDBLkRuT6/VizqR2K8Jf3mbPpBpBgEBNfcpNogZHS+rnUF6y62ZU
 aS+tvwCYWMMIZFYKI7sjgig5ccsJEzgf9xiQX1oZ00MPB7oQUtyBoMX9ndw7QaNjkx9V
 48qqsazwHSSWU4881+Yq6hCxcGZcLsDFp7BhrbsikhEt1QaURckITBXLuip8n48afK9i
 OsbBAFXesC4iGitCGJDUcf0/Le1Q84e2fqZ1t4g909UbQBGBnhaNWiTXTCBdIMM0/uY1
 1/I+yTY7r2wNfGWZR4SbFnDPS8K/hOuauYdenUuu28Y0w9o87j59ZWVZhmCBPdf+2w7Q
 zurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7UEwv92PoD+4ILJO8JX/q3C3X7YrwX0Cm3GLepTk4j4=;
 fh=AddFVCU6PtUZHnXVRgy4AWjuADBwkXzM0IE5JVQd/WE=;
 b=GSYaEDVBkHojwGThUsuEqKemgfAszVafgECW4R/RHNTSYSEj7s1x/76g7xCGNdeb3H
 qKGm3xrqkkze3eZJ4EdWEy1TGzVRPocOjaghB3YkzHGsFZAwmP8qmdgtO3KacbnSjgal
 FgcTUuRjqwhirASMtEkfCsl5HokZUeJ2I/IIeRKNVm4w5v9HDqwaXTCbwKBO9fDZewSe
 EBOQsiCyihN+KJWMixvPZcnjdhGLkBYufLE6+WZRpCu0MCnCK/nC+6u7/0WSG3aNYEwB
 ONBJ9Tznuakz1jG2R099yym4vh5AMtk+aFAsiBR2rR5c/I5Umo3gQpg1G4hfEi7CXhOK
 dGnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777363727; x=1777968527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UEwv92PoD+4ILJO8JX/q3C3X7YrwX0Cm3GLepTk4j4=;
 b=r/9lJjSjGk4HYNoKtK6iq5MkKzTTL1AnCJhCSi9Z9KPMJJGjrG0s/jer3BUiJ7XIs8
 KT0yzrvOJ6nHa4mWqzxUaf74wKHClnE6AJ9nGCVM5msspybGajb+VWVJfJkMqXYfeuiZ
 qXqzNSM896nxQduQNyt1QKcjJu2XryvXr9Iqp1fRqTjE+OWud06s+A+fZktCDGnnLB+C
 2CrPI8z1eYL++VV1CHgh1G6XXbfnaUNATt4Nx83j41uoX8aIoi3k7ROv0XX2JuQIR6sU
 JYb9eoHjGEX2Mz9O++hicdEnSb7vq6l+O37sZGGhRDqixABbgaE2Bwsb2f/V6UK49Dnr
 rlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777363727; x=1777968527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7UEwv92PoD+4ILJO8JX/q3C3X7YrwX0Cm3GLepTk4j4=;
 b=YAqnzBm9VN/8jnLjamqQZRqys70/uEOhQywTs03h8b4uCYbsJt38jvGuXOB3IF7R0q
 7bWKseFTMqobj/xFm25+1lZBYZFHYczaT6OjOrVc5i9n7+8o2B0bU7lUYkMf6mXRavct
 vVjV6kSq9CgRvyRvNaukGJbctCakWHKo4F2NF2ecIqsRVXDuAUb684VACZIg863x+w3I
 ET3uM2tPgJjEER8kgSE4j1bdJt4I9DJTUB/8fTe4BTDciT7aEC85xOtfRTVa9xpYWKlS
 D2Yi87fhWtDg7WgQIziMkqn9PW8j2QvSH7GgmUxwsOVQm0xVB6v8A/KULalNIaG3kdtI
 vw+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/hf3xw4Oi9S25x3o3LN4dtnV+HAvhBwLsOg02Ie6kspUVcllCRI5luzF37f9SfRLzNcEPHpxaF1o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGJypZe9GzJqzMnB6tatd8hCYpkvppw/OIBPmwTdXc+67/StnM
 DUda+iHq0estu1QTt0MuqOV6lBsKO73uWre7Bh+ixde2Hqz36F2mibFskK2Q8DL5vqY1mlL2nu4
 QajxZen1GNnGjwn1SFZcMNQyTh392qSc=
X-Gm-Gg: AeBDietfz661AbULoomAkimRf1EDbDNdidHuKtxH+HdQeaxqh7Ar/btxY3l5X3AnVjI
 gEKEU4lgAHzCvFWF9tA21yOzvnpDlYLrFjFPw/LNtTa24cSTqug25KcDEwszJkAoi75wZaIqVkE
 0klfycnuhWfq0k/HfPYqwQTc1kcJ9FOjJm1/6/JldHJMEAMMTbJ8rXYmdJNLSf3Xi9MOViKiA+h
 oZjwtKDv9gxmkFp4vdmMvNfJ6Z1rit3C0KrPKIPI+qlOxWZcdUlhvQPr8l1c0zEw+8VsjQqxNuT
 wyq2K648diS4MKXwmg==
X-Received: by 2002:a05:6820:f004:b0:694:9c29:c288 with SMTP id
 006d021491bc7-6965cb787d4mr980070eaf.40.1777363726695; Tue, 28 Apr 2026
 01:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260428063224.3316655-1-syyang@lontium.com>
 <fe73b59e-bbe2-4452-8bea-1fe1ea09d4ee@kernel.org>
In-Reply-To: <fe73b59e-bbe2-4452-8bea-1fe1ea09d4ee@kernel.org>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 28 Apr 2026 16:08:33 +0800
X-Gm-Features: AVHnY4IZADbXY3ILR908Azef-6srzy9Im9HPPnfOtJszFXPeyNaoufpsUDkQ-Hw
Message-ID: <CAFQXuNaQdo-qE3sQs_pjbm4tLKqEGJYZxkuwWokVp5VpbxC__w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Lontiun LT7911EXC eDP to MIPI DSI bridge
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On 28/04/2026 08:32, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > and output signal/dual port mipi. This series introduces:
> >
> > - A device tree binding YAML file describing the hardware
> > - A new DRM bridge driver implementing the basic functionality
> >
> > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> > ---
> > Change in v1:
> > - dt-binding:
>
> So explain me how does it work:
>
> b4 diff '<20260428063224.3316655-1-syyang@lontium.com>'
> Looking up
> https://lore.kernel.org/all/20260428063224.3316655-1-syyang@lontium.com/
> Grabbing thread from
> lore.kernel.org/all/20260428063224.3316655-1-syyang@lontium.com/t.mbox.gz
> ---
> Analyzing 5 messages in the thread
> Could not find lower series to compare against.
>
In fact, this is v2. I made a mistake.
Link to v1: https://lore.kernel.org/lkml/20260420023354.1192642-1-syyang@lo=
ntium.com/
> Best regards,
> Krzysztof
