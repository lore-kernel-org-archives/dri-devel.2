Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E09C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE82610E28E;
	Thu, 10 Sep 2026 17:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lqlWRBm6";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D5B10E28E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:20:44 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2949ed8cc3so4165166b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789060843; x=1789665643;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+3KF/o8Cps0NWVPCbvYTG6UtivJb4eqDQrioajlO1zk=;
 b=lqlWRBm6MXGEOzuBIkFkyHuuVqCBgnYAjXukBcvqAVMdg8qGkE5KAgUXW0yh1xfaeG
 M6xwLEJsILMBnOKRrqzXbHQbR182v7ndh6N6MSin4aS10cFrln4xTOQb1SZkJf8YxOql
 dC2fIgTy4Mfrm9/6/OYaYnifk/AVaMyYux4dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789060843; x=1789665643;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+3KF/o8Cps0NWVPCbvYTG6UtivJb4eqDQrioajlO1zk=;
 b=kxwMJdIKEpAKhozmMsSLtZmJz6XrCkl0KYjYtlh816+7KhYqtpkDWCE9wdiuo3ld+o
 mLekhuW2AOS/Kmuav/5lGk660DCDk0PgXFYD33K76aEfFUE2EFTHWhdpek0kReHW8E3q
 Ga0K4zbiWMF6VOgUr391c562tBHgvKMkCqy2m2croBwrOb4w6Zr1OA5iavFQBVybv6Kt
 tLSYLHzW2yBHv/0aNoyPhVLtvuzQiC/gfOyv7fpdXkPjXU4lwrmtW6/5J+FkcbsN9TgB
 fdu2LmAKANiy+oNE+ONRCiC59i1Y/cEgUAoY2R6hjbA5We5+TFoT/so0MS9pc4y6oQLj
 oTrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1xBwN5GKryecAeVvzpjq1ikiLhOEG2a6iyjBjkIEx+CzAAinkYCIDFykRA8Wh2yAIVz1PmuZN/Sk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1nNISzraTIyqJtyesfKg2S5jaGk5FNS+cttMB8zdoKAvWGhSg
 K4lZsBH3E46p+kK81JTXk9wo6qR4hkb3E4qBmiiTyfli29DMXG/+oGTmqakCLIPSk72WOX+Kzj9
 XThdawQ==
X-Gm-Gg: AYBFou0MMXPkbkOlr2zyCPic1m12+4ji8UJ5uskzZcf+aRO+1P4XTycjVSfG0bCQEQ7
 45Op3Nl1Whd9JHhslzHZL3TQWRzOb/08hkb2E3Btncx/gT6liJFdPmDzvGys+iMlxypKihi37qP
 H3SQJNfYGXIyL0YTC9KLn+q6j2b22gIv6pkyxYqsLpvIoLRprXyMFrtWIz9kNVBLe4bWjS0WCGo
 4z1bWQKw39u2WK9qeDE4wg7YAxjqzw6vsufr2ncpZKZSW1ARZyiPTZUkqTykSmLkMocrXrNkOy4
 fuVXqva3H7+BcCJNNKZnDCrP1dNlRPX89+kqypd52wKgL0RDW2OlO3c4wz4mRGgDuUTv1zX7fci
 WTKT4U9SW/H0q9MA/MeK/LZ8S4rM4TRlhizPTGC29WSAAMmBA0rjCXyV3hX5UTHreDPupCozBgq
 YO+wsCogJYr7+zhEGHGIEy4klkbpgdRmKctpn3RzmSKQ97+H7vhNrbqVaVWMzvYtteP4hgbXWBJ
 IZTRkW/a83UFvVU/eXJxRwJQKGxLb3eJ9rPmA==
X-Received: by 2002:a17:907:9720:b0:c29:3c6a:8357 with SMTP id
 a640c23a62f3a-c293c6a90e2mr449613066b.28.1789060842833; 
 Thu, 10 Sep 2026 10:20:42 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1f6sm773355266b.50.2026.09.10.10.20.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 10:20:41 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so4636612f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 10:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwIt/F5bd+1sZXldhYBm2sQFOsSF870h1E8IO62os0z7Rq3/JARibjs7bMLdsIGRbr44QKvuwTrgc0=@lists.freedesktop.org
X-Received: by 2002:a05:6000:60e:b0:485:8c16:a355 with SMTP id
 ffacd0b85a97d-4858c16a6c2mr40688071f8f.45.1789060840463; Thu, 10 Sep 2026
 10:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260910030432.1009658-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260910030432.1009658-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Sep 2026 10:20:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuHN-=YrEDEACaqrPJs=Me=kqn+M5Mz3RZK+QjBGHerw@mail.gmail.com>
X-Gm-Features: AcwNN1VzxdMZBV1mUzENH0DDwgg2DPid6UF7SN5vBnHmAA4ZLngkE3Xtq2q9P58
Message-ID: <CAD=FV=WuHN-=YrEDEACaqrPJs=Me=kqn+M5Mz3RZK+QjBGHerw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add BOE NV140FHM-T0A
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

Hi,

On Wed, Sep 9, 2026 at 8:04=E2=80=AFPM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDID:
>
> BOE NV140FHM-T0A
> 00 ff ff ff ff ff ff 00 09 e5 ea 38 00 00 00 00
> 1c 24 01 04 95 1f 11 78 03 28 65 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 c0 39 80 18 71 38 28 40 30 20
> 35 00 35 ae 10 00 00 1a 80 26 80 18 71 38 28 40
> 30 20 35 00 35 ae 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0c 10 21 7d 00 00 00 01 38
>
> 70 20 79 02 00 25 01 09 7f 41 02 7f 41 02 28 3c
> 80 81 00 10 6f 1a 00 00 03 01 28 3c 00 00 4a 5a
> 4a 5a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c8 90
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NV140FHM-T0A
      commit: 45c7da8b15f6716f43143214eeb350d97623a608
