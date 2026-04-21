Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A651CF327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989C810EB93;
	Tue, 21 Apr 2026 07:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ECoZH4lu";
	dkim-atps=neutral
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9944510E17D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:49:16 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-4232323a7daso1758165fac.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776750555; cv=none;
 d=google.com; s=arc-20240605;
 b=Ob/NgMLPqKzc3JU+cjPrHFDJjBPcw7Mm5Fw2hmXAXWGtdwwsXalr+QDHoCq84e3IrG
 jn5g6SlH3I+JXz4WeZPC+TdvFP2NdCaWDPV05qwR7EPK4Go7VSOFGZFGFaDsqU2FXyTj
 ZcqY55gf9qTjfNZnKupHYSgXdg44DdRbR0q1bW/bdMBmEs6LQR9tdMyFqN6fkH1/ZDNl
 QrwbiCopOD5Zo88umUIvL7a5HDcyIruar8IjW26V/+ixtz5h2lfPh+Uq2NbBgBmiRyY5
 nxteltlQu4UuwPnmZSmD0FApZzyGjiEifIdhGjQZh6xA66s15Rvaek5ippTggyPMlsoQ
 xdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SRWv1DAnKxjPg4EeC1yHSfGfzIInINqcAO0DlQUlQZc=;
 fh=LCeRIjTs+FdrlJExMh9FkHC5pVzRmV0lbkoS9r5Gw0g=;
 b=ZCmp9jweS2ar1aGoqqCP7tCcLCXdO9GEHfCfGuR5JghsiwVQ4i56EbzJ+n4wASSCNE
 RnpwOiSCWb5xfcyOx51kZYGv3gHNmVvARZkQdTg1BYTmG6ZME5SlkJd65KqAAuVWUtcP
 7Gyj8Q+MUBHg9nurw0FcbtDNDoSmPEMhiEt7gQcsV4OxVlNmjiS8sWnfs3GwBZEr2OJQ
 y9Fc2vEjMRzzegF3mtupY7uAbCCTpdgv3IOfSn8M3WaFdnCy9p4hV3H6Fhi6meDICyQF
 piUXiyrJy4yDbBYOMB5eRT0LfCiCOj0LDBA5Ij8JLdsRgYOkm7KhGtbaICcI87qkFgQn
 cBQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776750555; x=1777355355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRWv1DAnKxjPg4EeC1yHSfGfzIInINqcAO0DlQUlQZc=;
 b=ECoZH4luH2wUlcILwsgchWjtV3nMHaPc2j6V2sJlGGKNbVqwEwfhGx8kb4YooB1j0a
 YDKa/ypvVJew9n/YGVOLuktA8p1ZDB7GgFgC/Nu0eIwCFZqfQbu7YC3KLynHEzwqbPTN
 4CHPlo25u2h4gQ+OhCzRUQzYCFanZ6gWbi0gBv75IfcnSt9aUa+aWnQ07hweUeGVL8a9
 EbLxTvW/vNF6NaK8vYuObA1tkvQVmxR1ts0GzTxEfdRsWRRWM4kbpxJBOnrroWu1AGeM
 /ZgJWtAmCBgdY0JvnIV6ziVfEYLR66JcCuPBvfKmYPAet1149W0LMrozpx89T6KK0m7q
 x6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776750555; x=1777355355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRWv1DAnKxjPg4EeC1yHSfGfzIInINqcAO0DlQUlQZc=;
 b=ghEcNAlB1jOaj87DHAcxXb/F/GlcSaMdRUC/BhZybPmXSXeLppts9BygDUCIBBwrRQ
 KOpz5fcxvHKdYe5omFXVWlxUujmpxfy/+6sHuCUfRwZurkptSyduQJXToSo9r6jtJlvQ
 gp1pQ/hgIKnOWriKe0mP/N7bBOsmZB5Uos+iqWQs2RVjWJvQMtEuXDEIp0WVNPT3tpj4
 IQNc9S1jfGjpMFwA54P8TJvonu6CCYbtBiTo6rt1pI6vxpmwxMhIn5K08UpFlOUS0siB
 taphbT41ElodexGjoB9aFfIVOWpwslXhCt9xt7vlASCELxSnInpO6bpPXz68DaT3zJcl
 xZhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ99j0oyB0+K2ASTvnvSgKtA1ts4U6ehY0/86dHf4EntT1ocNH/IbjanAmakY8e7lHWvuf8zGtv+A/I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyskkAkAfjWaBdQfOAcaIXNQquxpdJiCPEt7MuASUPe87oxNdM4
 d4eV6li7hgF5l7UtHLLDHiebZ84p1nwYXXQxyXSB2uRqrLBny60qmS27CR3rR+DN49XjTg98oWp
 2pkUcqmkQCQBvqvxv3hR+U1s3SdkomMA=
X-Gm-Gg: AeBDiesHwuas5/hdV/5h5jVD2MfuGTkx1j/CvlPpB+2LweV3fCthojMPotdwJZstwlf
 Mn6g5vuDdBNPCekS0YMFp9lMqOhneSufhuW/ZWxaWZVfm82aBEy0SGOKw6OxqX75lC9jmn223k2
 qPoQ4KQrNlGIiSMosC6mYlljK34BjAsX8sgoe8W5F08blUTTxBukGw7zVaK/sNDny7OYTSONfwu
 NuMMH61INOIqaF8XoPNnMWLHrXxueZzT1qiDa2clB3ageV6P0ATLIBWl0RAXwHW//9eSMjUPDNT
 U4pyObdsq7ybX5eA
X-Received: by 2002:a05:6820:8118:b0:688:e3b:3b8d with SMTP id
 006d021491bc7-69462e1648bmr9079448eaf.7.1776750555537; Mon, 20 Apr 2026
 22:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <b2a5ef92-f312-4e0a-9772-4d430b80a46e@oss.qualcomm.com>
In-Reply-To: <b2a5ef92-f312-4e0a-9772-4d430b80a46e@oss.qualcomm.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 13:49:02 +0800
X-Gm-Features: AQROBzB9rYJlnnqh9os9JxgZAo3i8KtXGQWjM6H5x1xWxow6F4ShLEOhK5X1Slg
Message-ID: <CAFQXuNYFwRLbm8yLFNzAcwO24NuBWEKnaAQP=O5BhCuCb+eWuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device
 tree
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de, xmzhu@lontium.com, 
 rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Jingyi Wang <jingyi.wang@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=88=
21=E6=97=A5=E5=91=A8=E4=BA=8C 13:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 4/20/2026 2:16 PM, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HD=
MI
> > chip:
> >
> > -dt-bindings: bridge: This patch adds new content to the lontium,lt9611=
.yaml
> >   binding file.
> > -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD) c=
hip.
> >
> > Signed-off-by: Sunyun Yang<syyang@lontium.com>
>
> "This patch" should be avoided in the commit msg, begin with "add" will b=
e enough.
>
it will be fixed  in the next version.
> Thanks,
> Jingyi
>
> > ---
> > Changes in v3:
> > -dt-binding:
> >   1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
> > -drm/bridge:
> >   1. Drop the licence text, only use SPDX header
> >   2. Sort the headers
> >   3. Use library functions for crc8
> >   4. Drop i2c_read_byte and i2c_write_byte
> >   5. Lowercase all hex values
> >   6. Use paged writes as implemented for LT9611C(EX/UXD)
> >   7. Drop dev_info, use dev_dbg
> >   8. Modify lt9611c_get_edid_block, don't store EDID in the long-term s=
tructures
> >   9. Use HDMI audio helpers.
> >   10.Remove unnecessary flags,Implement proper cleanup path, unwinding =
resources
> >      one by one.
> >   11.Replace devm_kzalloc with devm_drm_bridge_alloc.
> >   12.Remove extra kthread.
> > -Link to v1: https://lore.kernel.org/lkml/20250903123825.1721443-1-syya=
ng@lontium.com/
> >
> > Changes in v2:
> >   1. Forget modify code, operation error, Please disregard this submit.
> >
> > Changes in v1:
> > -dt-binding:
> >   1. Submit the first version of the code.
> > -drm/bridge:
> >   1. Submit the first version of the code.
> >
> > ---
> > Sunyun Yang (2):
> >    dt-bindings: bridge: This patch adds new content to the
> >      lontium,lt9611.yaml binding file
> >    drm/bridge: This patch add new DRM bridge driver for LT9611C chip
> >
> >   .../display/bridge/lontium,lt9611.yaml        |    8 +-
> >   drivers/gpu/drm/bridge/Kconfig                |   18 +
> >   drivers/gpu/drm/bridge/Makefile               |    1 +
> >   drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1365 ++++++++++++++++=
+
> >   4 files changed, 1390 insertions(+), 2 deletions(-)
> >   create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> >
>
