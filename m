Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EADCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D474D10E20C;
	Thu, 25 Jun 2026 13:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="LzXqc08l";
	dkim-atps=neutral
Received: from out28-114.mail.aliyun.com (out28-114.mail.aliyun.com
 [115.124.28.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C287B10E20C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782393303; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=VNTyeZXje64jTeQZA5UeZ/40zYq7tvnkh/fzW1IzNFY=;
 b=LzXqc08ljVSAf3kHvcbKIGbSv0p3iJGBAl6oJFdkxfnTeyeTFpbINxuFt/I4TaT+neySz/gwmaUs7hbiXzQr7nwvB2UDH7G5OuxbAKmb+aKYNKSY3TijNUv6QAmZ9PsnvIui/XFU4eZGKyMBAY7MmQrU5ZqtpTJH9OEGD8p3XMJqnn2IJ5GpXY1og9Tuih0H9Xow3l0QQArsSGgQ+rEWEZLubzRNFOmuVuM5azyTkiaQzwIF+tyA5iv/75qx0MxeTD/uxUhjHwhIZ7q+mKeLj/rukgfxpkhGAEntQvliitmWOnT69yBKrCXTfPeqxOdsrtLH/yW/bYHtfR2uMwR+bQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08090395|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.0455441-0.0127734-0.941683;
 FP=13497706032206022546|2|1|2|0|-1|-1|-1;
 HT=maildocker-contentspam011083013073; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i5Q15Rc_1782393301; 
Received: from mail-oa1-f50.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i5Q15Rc_1782393301 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 21:15:02 +0800
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-43cce8288c7so1181105fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:15:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/OfRD3Ud7fFf7kWEW/ib2vxNICVc7sjMmtba8XXBJOIehNNx9DAguP7t2LgBsyDu40x/WNwWVER9g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5vuywBn2zandTILrqzz/+fne+LH08djwQOnDyGbhviqdJU5qP
 TnVZ5pmvnoQcH0mc09quDEHfY1Og1KarIfD+FO724/u2RjSp/tlOXjLvdZAJ5KhWhh2YIul6oaH
 AcAXSL1GQJGwK3aD2jkqqELAbWuJvZRM=
X-Received: by 2002:a05:6808:158f:b0:490:70b:9d72 with SMTP id
 5614622812f47-4921a7194acmr2259727b6e.23.1782393300834; Thu, 25 Jun 2026
 06:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
In-Reply-To: <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 21:14:49 +0800
X-Gmail-Original-Message-ID: <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
X-Gm-Features: AVVi8CeoPzxJojSa5QCnyjr0i4TPsX9EaOpdR9VoBhnzNDHkkK9oqaU5wohJDQ4
Message-ID: <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > +
> > +static void lt9611c_reset(struct lt9611c *lt9611c)
> > +{
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
>
> This is just plain wrong. Why do you assert, then de-assert and then
> finally assert AGAIN the reset leaving the device in powerdown stage?
>
I am using software to emulate the hardware RESET button on our EVB.
When the hardware RESET button is pressed while our chip is running,
the signal level changes from HIGH to LOW and then back to HIGH.

Of course, we can also use the following:
static void lt9611c_reset(struct lt9611c *lt9611c)
{
    gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
    msleep(50);
    gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
    msleep(20);
}


> > +     msleep(400);
> > +
> > +     dev_dbg(lt9611c->dev, "lt9611c reset");
>
> Drop such debug statements. This is some downstream, semi-useless code.
> You are not supposed to add debug to every call.
>
it will be fixed in next version.
>
> Best regards,
> Krzysztof
