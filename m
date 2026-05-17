Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F169CCD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C88B10E23F;
	Sun, 17 May 2026 10:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JIgin0Pi";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB0C10E1D9
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:11:17 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2f3c623322bso5009582eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 03:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012676; cv=none;
 d=google.com; s=arc-20240605;
 b=YiQYGGbCzm0p8dOTtGCFTrHxpU4UqvhW7II5U17CD1t24wRSiUC0bGqV73Yb4mjp8Q
 9RmLD5W9gjCtxZwY3gEfYMl8Vk8lq35bM39YFQb2VWbQl3SCSxkNJYbTC1N25OqYS76d
 N2cip5lc21ymfpSkGTW27WmazGlSrkKQ1/kkMkrLKnTk53Ftpj8tGu6LipzYkf9KKaBA
 cWkfcXtQgilo91s0b/9WXRE/g280YTfUv4IFPUg45PXqZwuIl+VO7QIG09ktRxL7xyMV
 nb6zx6rxqKaeQdi7s6woctIw9a+It7AGtq93E7xAsbqLCyvOTmsqv7hJHcU9QoXZ/4lv
 GCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
 fh=Ch3Cums7gExaDDjO/Mo01w+/qVsxWxrdsVi1EXOot58=;
 b=Mtt1VOFDAx7cK0i4mAEeK6fxq5+PgGWPao8sYuBxl4TfwbIKmiAW3V0dz7SBo2LAGc
 Ci0YIUkzUrcfQBLDo2WukI4DphICwKX75aHGIn96CJs/AmiMqbki6E48xItNS3ckSOIL
 oxQG2hTCcoc0d4keoaEejR1lDfAP8oKD38qw9TNBI8mx9AEu0FO+kleXFaxfsfff5SQY
 ZcS7zte8ZVaJtx8ebYmH9j6BfLXeqf2a0vsP8iI/jBsY51Y9U47K2+LVK/r0hsZGhYK1
 8C7OHGmLzGmSwuwVAb5ZIvqwKXAqrh9tjUTao2ZCoFCu/eF6YPdYFIPsLQQaoJS025hM
 OM0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779012676; x=1779617476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
 b=JIgin0Pigdz+lkm49WGjDHv1Ac27nv6YjINYrtmIc7+xZHxuOPP5I1jfcZ201fD6RU
 2DkZ5mWSDmWPX77Kd0jbiOzF182dpTanEoDbluBdc6j7GUG38QhGHf3u3/qaL0ujZr+b
 TZPJl1hRObbKQftSNPkneGM86VR9iUPS85Q0/r7tCj4TpuZhf/G6uvHRL5uwcF4O1Zif
 Ykod0D3gCyOYOMpHEl8Jg95vP/fsGb3OlDlOjhRtHJq/4649wbRalm/BLQ8EuGO5aBEk
 gXFvI/wYgW6+/2CK9LDlF0qmgUGgMx70hL6noTQqal8od2y3fCa1e7MZyvbIHNfvQLmb
 1Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779012676; x=1779617476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
 b=KAom0pSaeDdLHkquX9J5bGS2PDWq6ZB7G8gxxSO+afaWokLD6ydGCQj36f0ugwIv/Y
 QnZmiziRuzbQPIhRQRNTHY5Z9BUTmTklbJ3RpCTKIkvMcsSYUIvAxXJVhlvy1/OBy/Hu
 50DDiWjeEjeevcMQkypJv4J3ilWBoHfvxGxa82ZrRVyZr27jF9Ne328tBgfHKfGCfyw3
 udTUdmaShpR85ujHoKbCPaT/BsM8mgDkm8Vl3aeSuqd5aE1yB2kHjCQf02PbyOyWO1G8
 EN7i255u7ZEzsY/UT7EL/34uE72uOVZ/nlFK01Lwcp1L8GWg2PFzYMD5I5cL4WMX6dd1
 0O5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MjiqEmdTWx3e+oAne1XeD0Ykxf3Xp4N9VZknPja8w2C9+7WDW/9UXqyjweyPaO2ymhtJXrtJl0fI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDgzvw90BENbu2barCeAq7Ceih/gHt6/Ndm+3rjKwLlyuP9LF5
 cSX9jn40QlPSSpM/WGaJE8Q29RKGOg/1A69iyleX79dh7drJpNm9ohZyGkqiILluw/4Z4AtxKpJ
 0vxuZgHQZljdVnd6HplpqYhTZamfg5kc=
X-Gm-Gg: Acq92OFtyZG6FN0n/CZdywYod/rF6Dt395T++Hxt9CuyQWf2P39OpF+06JqdWb2QnEA
 9xQA9rgSAIDYNPM5iFZWnTyPNXogHGzKaqzEsjTMBR0F44fGLf3rz5mBKiz67TzJHP2gntsgnA4
 zWRqnzsH1gk6vLTRG36VnefkmKwe/BySIyOesJ0fEufMxtI+nvTFOlqVduzSSEnrtLUJoxld+m7
 Rci0J4Sxu8xvyw+AlBnGcCX3d9+AfyYrEVXPDFr5C+oO3qELMvR3CKJnfSrX/gcP0KSj7eS51Sb
 aLjywTr8
X-Received: by 2002:a05:7301:3d12:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-3039818a65bmr4929254eec.2.1779012676435; Sun, 17 May 2026
 03:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <20260517074306.30937-3-clamor95@gmail.com>
 <agl0Z_EGzX8X4No4@ashevche-desk.local>
In-Reply-To: <agl0Z_EGzX8X4No4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:11:05 +0300
X-Gm-Features: AVHnY4L0_43-8RfJ6hM5f4ALu2Syvstfg64dnmlFGgfmiwaNMhHznD8dW2kFuMQ
Message-ID: <CAPVz0n2D7q5kEECPr+bo=W=5OU=w4eni-FccdMEUMupkzHhvLw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
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

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
5 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:02AM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> This is a mixture of at least (!) three patches:

Maybe you can make a list of how to split it then. I have tried to
make it complete and remain readable. I am open to your suggestions.

> - devm conversion

This will be dropped.

> - the change of some constants

If you mean LM3533_ALS_RESISTOR_MIN and LM3533_ALS_RESISTOR_MAX they
are used explicitly in r_select value. Previously it was passed via
pdata as register value and now it is obtained from the device tree as
resistance in Ohms and register value is actually calculated.
Naturally ALS_RESISTOR boundaries changed.

> - the rest
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
