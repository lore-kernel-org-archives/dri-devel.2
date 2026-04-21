Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A83F327B3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C7210E80F;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U60WQUB6";
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097BD10E03D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:40:03 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-66ee7b9af94so1329755eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 20:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776742803; cv=none;
 d=google.com; s=arc-20240605;
 b=L+0zG4kii1k9K2RL3RY//hY6Il219gYes8qItLIQhz8IA/gW3Mp0Uj87fZfOnDrdqh
 p0VNIaB4dg9Hn02KvmXTTcyupiuwI7h4LfwzYg++zpNiogqrt/r6WDYVnGa66xY2JMHX
 5k+zxe8FOXW2kI3IPqzOMAJT8wEMWWzuQXUm5ixGMJX+boWarRm9tcGICIJcwnY0/tXe
 2fZQFrtsgS9xI8o50Sb9JI7eJl+KOit/HUmdGmss1mZWY8WXvWjNqwW/1do8EzTgLA3o
 zIVV3SjUF0/Gz2bNYldjMkzoJ/oJdL8vO5vbdADnj8mvxYxUq3INMpz6fkTb0D5v8C/9
 pRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WfEmyIjuh8sO3J0gUNj620iHLRP40PwnMO2vrwbQQrM=;
 fh=8cZjKBMgbEb86qguMxNuHmy/3AuJA0HJpLoUx5UlQaY=;
 b=PzB3a81KYk3DE6NfH46L1Klx5uPH7KhLYnOiKHKAahqoxzBUP5benxDyS3mnb9ybbh
 eatLre9j2jTK8IeEqTBv9+kas43PjODW0OlGt3Jv/RaAmPTo5Ycq7l+fu7PL1FCZ8f7h
 F4q0QWuDMzU+fCj/T4YoxeX1+apsYTEzuKRNRVt7Q/hV0yari7Mubrj6BNVi6sawqoMw
 ZGo4D8/KM68/g/6qMnR++C8DbI5W8bZFPKIdXQ66MubQrNzVAkTVspMjs/J+BzraEztN
 3IHcE3/8uKzjbKJWIR5rOCFCwO+DYXMDEsvuAjrSPdOHz1zcae3tLUUcqzILJ5+PMpiZ
 U+rA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776742803; x=1777347603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfEmyIjuh8sO3J0gUNj620iHLRP40PwnMO2vrwbQQrM=;
 b=U60WQUB6Kz1we++W3FgSvwvXjVDOZRFzZjPkpT14GVSXs8awaOsubJCGYk3+EJ3C5Y
 t4TBPKsaAyJUcvTWxuu26fE1nps5022oBfl4WBbYLeb6RA1xcsLjYPMZyWHdeAN39Xs3
 JrNNbexTbJHzQi9T8Unc8mg21AuSXwvD0c/pSZq/zr/+Q0dmnbD+aW0fNpdAx5s+5AF6
 73qjdavNIrPuRUPTXMrU8KzUMHCo/IBQQCPzCuTnvNLq51FM7SJDd+zC2sRge02K7jy4
 +ERgmLlwWK7sTFO5lh1s4R215X+7WDCD+XBPVOKif9wzqSXisvf3v4W+eULNUBFUO8Z9
 /kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776742803; x=1777347603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WfEmyIjuh8sO3J0gUNj620iHLRP40PwnMO2vrwbQQrM=;
 b=TPbwbERDsEo7CP6iyB/f0ddX/xrcPgqZqX7vfYKP+AkDrI4fYCOMFIMhArRaQRLEUX
 YotUViDxuaWCVmhJsNp+UB+A0Y7hlV12FUDDDyMmdJvGXyf/O+jI7+kcj/RenakBIR7T
 L0WdS2S+dzmxSsZwXkbZrOcw2TpOPi/tTnM6lqMUgA1DWZTmFsdlqzD2sKvXcIUzAxXn
 1KwXZmuqhxN07a9ajkd9/MdeGJH5qvJVKujniwYngdWmQtd48s5p7FWKP40mkcd92s1r
 LJGTjM1wW2AqsCHJFc9AJ9v9p5dlqy39xShzELrESkrv1wtoePQTve/JpUpoM2H+sOyu
 3rGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95Y/pCi9AJJ54rV6W/XYgmV9EZCd2VOk7WgK3n11q62ePnS/iBKhqDPsIASWmvs7ynHAtdxeZitkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg2mJTv0cBH/YX33apgEZG07Xdov2Fyt7nYbCWO90/v0yaR4u9
 x0TP2krWVlc5HTCJjr2m8G7+q11USDs03Yv0Ub+sC03WSaXIvfRJZZ1zfNYKqrUDjPXJZkg8kkL
 sr/stUo/3TUAqbYG06tHOFT5hVmLJ664=
X-Gm-Gg: AeBDieuIBqa9QNvjHRe2eW+vVRuTjVOlDophraQKdF39aGJ9B3nZRJ0D2Nf0I2PsaxN
 PnpKvFhDopALTPKb4dem44VQ3+v/cKnMqQ+V6ZY8GZuWg1ov6g/PXOFCiwxULhxDuvKheeH0M6e
 6TZ7d2O9fPcde+HBXWLlaYhFjZXZv2dFN3LG+ee9EQgTam1i7ZJVdCoBEGgTYRyuJotCMqdBqCi
 wr4Tu3I0iFGAGGnAGOFUmjJ4gACONDFmfdeaOHuOVsNkr0Msg6QQX4Pxu62fEzoro9FPrBXYsTN
 VrRUSsssi05+a5HN
X-Received: by 2002:a4a:ee11:0:b0:694:6e61:8ddc with SMTP id
 006d021491bc7-6946e619009mr6913077eaf.17.1776742802908; Mon, 20 Apr 2026
 20:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-2-syyang@lontium.com>
 <192f1948-bb9a-4831-a1cd-5ef500cfb413@kernel.org>
 <20260420-sophisticated-scorpion-from-camelot-b9f326@quoll>
 <6f3a890f-3bc3-450e-b3a1-20fa7e84fb8a@kernel.org>
In-Reply-To: <6f3a890f-3bc3-450e-b3a1-20fa7e84fb8a@kernel.org>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 11:39:49 +0800
X-Gm-Features: AQROBzAxO75Rw73HtESCLZIOSvSLMdp5lPhXnj6EDHdWNc5UBUQV17pvBB6hrXo
Message-ID: <CAFQXuNbNGNYiSpcNbVyf530s2LEFnNwaXoqZU_V42Dsin4txFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: bridge: This patch adds new content
 to the lontium,lt9611.yaml binding file
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de, xmzhu@lontium.com, 
 xbpeng@lontium.com, rlyu@lontium.com
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 22:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20/04/2026 16:15, Krzysztof Kozlowski wrote:
> > On Mon, Apr 20, 2026 at 01:33:46PM +0200, Krzysztof Kozlowski wrote:
> >>> -audio
> >>>  1.sample rates of 32~192 KHz and sample sizes
> >>>    of 16~24 bits
> >>>  2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
> >>>    at up to 192KHz frame rate
> >>>
> >>> -Miscellaneous
> >>>  1.CSC:RGB<->YUV444<->YUV422
> >>
> >> Commit msg is not a datasheet introduction chapter. What does this all
> >> mean for compatibility? What is the benefit of listing all this?
> >>
> >> You did not even explain the differences between C, UX and EXD, so all
> >> above is pointless. Explain the differences and why devices are not
> >> compatible.
> >>

First of all, I'm sorry for the trouble I've caused you.

Secondly, when adding a new chip, my intention in writing this was to
let reviewers understand the chip's capabilities.

Then, the C, EX, and UXD are a series of chips within the same product
family, with differences in hardware features:

       - LT9611UXD: Supports 2-port MIPI DSI =E2=86=92 HDMI 1.4/2.0
       - LT9611C: Supports 1-port MIPI DSI =E2=86=92 HDMI 1.4
       - LT9611EX: Supports 2-port MIPI DSI =E2=86=92 HDMI 1.4

Finally, it will be fixed in the next version.

> >
> > Also, you have checkpatch errors.
> >
it will be fixed in the next version.

>
> ... and finally (apologies for making it in three emails, checkpatch
> warnings come from different toolset): your subject is pretty breaking
> every standard rule.
>
> It's redundant, not informative in various ways. It misses proper
> prefix, it misses even basic description WHAT. Everything can be a "new
> content".
>
it will be fixed in the next version.

> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submi=
tting-patches.rst#L94
>
> Drop second/last, redundant "bindings". The "dt-bindings" prefix is
> already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18
>
> And obviously "file" is pointless. Can you add content NOT to a file?
> Like add it to a directory?
>

it will be fixed in the next version. thks

>
> Best regards,
> Krzysztof
