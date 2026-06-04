Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA2BCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D603111A31D;
	Thu,  4 Jun 2026 21:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JFWDPK4O";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CFF11A31E
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 21:23:46 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-59c627b53a0so365816e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780608226; x=1781213026;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ywNOCiZbOBaXvTwi0yahMBNcZD2OXLAw/3rJV8izSk=;
 b=JFWDPK4OhAObh7+xYXYJ1CyeE4noqF4WsPUI6bTBRD5+MWhUHzeNNPZrClGqVI7Eff
 lr0JgopzPa7zP+phTsgPqRCPUfnMan2FFSKbFhgpEiJxGdMTBBr2sJqUJS/Zr7b4cRFB
 hmD+Yjft28xVbxvPYuOLS7E7A7RTuzvLyHmtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780608226; x=1781213026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ywNOCiZbOBaXvTwi0yahMBNcZD2OXLAw/3rJV8izSk=;
 b=TlUhQC2vAuNmiduKMT+IuS72TFp+tXrTjNQ9fpSqWhL7ub3GAoF325AzcXKBOPUoH0
 aRaztrg4bMd1G7NWpkzWUtfMO2zusw8hOf4xKM1ZQbVnHLZ9aqY3S+rx81OKJJ6Q6Awe
 Y6tg2UwbtZHu2HIfCFd5SJPNf4v/ej/M73LQPU4XffNSTnCgcnt6gO2tSl1peMlLu2B0
 uNTWwbjMjmcEuanFWue95FxVdhxri0u+/044+OL2iQjGhLriO9ojX03NPKiNSuXKLqyg
 egenLFPjYpxmj7aMYcR7v1FPW+r6RZqIw2CZKHEqxsKUgxXFS6+WuTdC38Bp7r09xsWF
 tB/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3yb9PUQPl5sNTZuW+86DMBrI40VqgYB9XSnf8pqD7FW+Vd6q/M2CjQHhtvNEgZfF/h7F1Zi8JBxU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy28PAzuy3T8ZSUiTLXBMY/MYq8l4WvaN/Gxm7iWCjxzR+uIl2O
 hHO6EFgoCLZoB5eZi2XH6P45PoNBoibnPcWuPtMfL3PUxGmVgN2f1u5Hi0v2mkH+Gkeqs3UALDz
 Wdfw=
X-Gm-Gg: Acq92OGlaAYrUQm85bfBlnyK3y5gmEeo+uBAo/e0kEgEKij8zH+dYQsgubOInWnhG1m
 4M4Flvy/AMO6FJwKuXUdYwao0orSpckzwrzBMric8rIlMQeGgWkasUnO3BefVOFVmFtRLFaDXoW
 DQqqTqDGUHe/qDHIPM+KPj1aN8mW8w4oh0qw/5bvu0EBQnUprHXAacRkgQamelUHowiF7xRjfuM
 3CN+fJFizD4vtasobFpbITO1/07e5sY+3guyGZjYLchygc2xdFeQ5776Sj49Ym784DYDNZtiTNf
 0de94wBPpVh49DsECdidJ15No9RODXJpN8AU09hGwL3V4wEaPSXyhd2w07E3peLNGmsWHaXf/q0
 fz6gMr+0RDzP1XekxY8ygOkpMj/KN+Ur7KZc8kGhJUNPUxSWRCdxGPZeiaBZnOkwreNVRgFwSY8
 F7FAchXjqKLso/ZkH79cbXvjFKftFO6o7HbQIZ5cGZ/m7uoUKerbHnf9rZqPgfIshZA0e13Qjt
X-Received: by 2002:a05:6123:161:b0:56f:61d8:86d7 with SMTP id
 71dfb90a1353d-5ac4f94d0famr455174e0c.7.1780608225384; 
 Thu, 04 Jun 2026 14:23:45 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6413cc1sm6059457e0c.3.2026.06.04.14.23.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 14:23:38 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-6c4a2458683so504151137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 14:23:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/l30986WZbsuOzFXJJ6+PVTofXoRbmSwAU0eDrRTfrU3AsHxBmCGL5RAfBE7hvzzLfNhBDEqDanDM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5e87:b0:6a2:cf9a:a5f3 with SMTP id
 ada2fe7eead31-6fef26ce86amr349440137.0.1780608217159; Thu, 04 Jun 2026
 14:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
In-Reply-To: <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 4 Jun 2026 14:23:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
X-Gm-Features: AVVi8Cc4MG7c0lW6-0qjcdQ-D0zLqfcs-TS6nz5hMf5r8Kr4Mvblgg-anJYVP1A
Message-ID: <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: samsung,
 atna33xc20: Add ATNA40HQ08-0
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

On Thu, Jun 4, 2026 at 1:07=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> Some variants of the Qualcomm Snapdragon X2 Elite-based Lenovo Yoga
> Slim 7x Gen11 laptop ship with a Samsung ATNA40HQ08-0 2880x1800 120 Hz
> OLED panel which seems to be compatible with the other ATNAxxx panels,
> document it.
>
> Note that I stripped the -0 suffix from the compatible, as it seems to
> be of little importance and some sources omit it.
>
> EDID:
> 0000000 ff00 ffff ffff 00ff 834c 422f 002f 0000
> 0000010 2300 0401 1eb5 7813 6603 ae85 3851 24b9
> 0000020 500a 0054 0000 0101 0101 0101 0101 0101
> 0000030 0101 0101 0101 0000 0000 0000 0000 0000
> 0000040 0000 0000 0000 0000 0000 fd00 1e00 e678
> 0000050 47e6 0a01 2020 2020 2020 0000 fe00 5300
> 0000060 4344 2020 2020 2020 2020 2020 0000 fc00
> 0000070 4100 4e54 3441 4830 3051 2d38 2030 c402
> 0000080 2070 0279 2000 1800 1200 2ffb 0042 0000
> 0000090 0000 0c23 5441 414e 3034 5148 3830 302d
> 00000a0 0021 ca1d 5e0b 4007 080b 0007 7ae5 8551
> 00000b0 b9a3 024a 020a 5445 5fd0 644c 4400 7823
> 00000c0 0026 0609 0000 0000 5000 0000 0022 0014
> 00000d0 0ad4 3f85 c70b 0700 1f00 0700 7707 4f00
> 00000e0 0f00 2e00 0600 4500 5fd0 644c 002b 270c
> 00000f0 1e00 0077 2700 1e00 003b 0000 0000 9085
> 0000100 2070 0079 2200 1400 d400 050a 0b3f 00c7
> 0000110 0007 001f 0707 07f7 07cf 000f 0081 731f
> 0000120 001a 0300 1e5b 0078 8fa0 6a02 7802 0000
> 0000130 0000 e38d 8005 e600 0506 8f01 016a 0000
> 0000140 0000 0000 0000 0000 0000 0000 0000 0000
> 0000150 0000 0000 0000 0000 0000 0000 0000 0000
> 0000160 0000 0000 0000 0000 0000 0000 0000 0000
> 0000170 0000 0000 0000 0000 0000 0000 0000 900f

I'm not a fan of the EDID being presented in 16-bit words. :-/
Changing it to this when applying:

00 ff ff ff ff ff ff 00 4c 83 2f 42 2f 00 00 00
00 23 01 04 b5 1e 13 78 03 66 85 ae 51 38 b9 24
0a 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 fd 00 1e 78 e6
e6 47 01 0a 20 20 20 20 20 20 00 00 00 fe 00 53
44 43 20 20 20 20 20 20 20 20 20 20 00 00 00 fc
00 41 54 4e 41 34 30 48 51 30 38 2d 30 20 02 c4
70 20 79 02 00 20 00 18 00 12 fb 2f 42 00 00 00
00 00 23 0c 41 54 4e 41 34 30 48 51 30 38 2d 30
21 00 1d ca 0b 5e 07 40 0b 08 07 00 e5 7a 51 85
a3 b9 4a 02 0a 02 45 54 d0 5f 4c 64 00 44 23 78
26 00 09 06 00 00 00 00 00 50 00 00 22 00 14 00
d4 0a 85 3f 0b c7 00 07 00 1f 00 07 07 77 00 4f
00 0f 00 2e 00 06 00 45 d0 5f 4c 64 2b 00 0c 27
00 1e 77 00 00 27 00 1e 3b 00 00 00 00 00 85 90
70 20 79 00 00 22 00 14 00 d4 0a 05 3f 0b c7 00
07 00 1f 00 07 07 f7 07 cf 07 0f 00 81 00 1f 73
1a 00 00 03 5b 1e 78 00 a0 8f 02 6a 02 78 00 00
00 00 8d e3 05 80 00 e6 06 05 01 8f 6a 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 90


> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml =
| 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna=
33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna3=
3xc20.yaml
> index 1bbe0da3997c3b06eccd18fe8980b58a6c05d963..27536eeaed8594c047dd0fa1c=
f425912be189508 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> @@ -25,6 +25,8 @@ properties:
>                - samsung,atna40ct06
>                # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
>                - samsung,atna40cu11
> +              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> +              - samsung,atna40hq08

Sure. I'll repeat the same comment I made the last time someone landed
a change to this file [1] in the hopes that maybe someone will post a
patch one day:

<repeat>
Given how many of these we're up to now, I'm starting to wonder if we
should come up with a generic compatible like we did with "edp-panel"
and then we can stop having to merge CLs like this. All of these
Samsung OLED eDP panels have the same power up sequence and once we do
that then we can read them via EDID or via DP AUX bus to identify
which specific panel we have and if they need additional tweaking,
just like we do with "edp-panel". Do DT folks have any opinion about
that? Coming up with a name would be a pain since I wouldn't want to
assert that all future Samsung OLED eDP panels will have the same
powerup sequence. Maybe "samsung,amoled-edp-panel-v1" even though that
sounds terrible and there's no known need for a "-v2"?
</repeat>

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/4] dt-bindings: display: panel: samsung,atna33xc20: Add ATNA40HQ08-0
      commit: 6f7565f2fc85e9dc0d9d7594bdfc2b03c4e11205


[1] http://lore.kernel.org/r/CAD=3DFV=3DXvHu_NnahFOcfLV4XQm_mQkO5cG3YP+acRg=
C9AE2m6Jw@mail.gmail.com
