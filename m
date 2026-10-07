Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649EACA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D5910E59E;
	Wed,  7 Oct 2026 13:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CaKcQa/0";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7DA10E3C4
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:02:06 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6afb0d2a586so3444093a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791378125; x=1791982925;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R+rvRY3MxyDDJlHyGuP46Q73CKubNnzJd6vSmt+6L74=;
 b=CaKcQa/0qVk7ryp+pXTEFSNoFUclj9jL6143sxfFXGOjkNhe/7Y9BLKXpA5AcDRLwQ
 evb1SKIYoD04DS93I+njRfPSEle+nMdMb+MSxpcwqgLt77dqqlVtMXK7m3/Zeuvp5AKE
 BZ1lWsx/UptJt13khPaElNo92o6HGQC//HpV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378125; x=1791982925;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+rvRY3MxyDDJlHyGuP46Q73CKubNnzJd6vSmt+6L74=;
 b=LXUMlAEQubJOGbpOKpPqMub6++4FdHhMDS4FRQqy2EiQwEPtO95Jm/ocWEmhoxFarM
 ZnvQMmgallSAVyhwoR4Bpd1YC1uhujVVkX0BgWthK+rtNjV5WEyUXkI/ppafo3bw1eOy
 Fu0sv31uHyoJEmvJbcleBZXgJXycGSlgvnrTx1YweyXc/ON8+sGE8McbX++8cLzfZr5M
 nB5Xj5lHvV5rC1VJ7DWWGtWuOEwXUc55EU6andv4xMR+/cEXl6uaZaGH7GIbA7s2Hyb6
 uSnoLXIYniOuuswErI8Wk8hROyJ0uq9seakHlnGfdEc/oGKUgPyndfTR9ncQLRIQDV6z
 nzfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7YRzGmkEeqX/dw1IiaaE2Xp3xMtvMrRH6p34qlugPe7/NkrduTbq8xwYGk2z5HToi1hjIIYuH8aM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlIJowYKWzcVS2Kc+9Lv6nsKdpLnH/9gMxx72ePWprMbVGX14/
 6HKyRKIGo9QiWk3hfwbrUCrcuaftlJIoIITyVlO9uGwaoW3CmLHpZduLlCQkiWeEG4CYhBP5q7J
 9PaG/yfBv
X-Gm-Gg: AYBFou3blJLldriuzufgvDsXkzJXFD7U2LSz4auPoR3IPlkNcADvTtsPWM8hTX/8SFb
 pQU8Vz8CQolPG7tkoOs/c69BJZ8LrppgmxOEFS1My1jaSvwVuZ+khglASXdYznLJLCejlU1W3dN
 cV4zuRi9VrBprHyZ8957osaxCemwJKsxecHw70+CXkNjaH2QVh+2FYGZUmR9+SFZCeVwyw3rXf8
 v5NQySLZCXAAy6P+rge+9sMqLDHK3I1iWhm1ws5Hcpz60cmwENKi0pYn3ZFb4M3bjmII+9S6tHe
 Gk7ptw2bLMYg5/8EDZ72rRhukQs1lYndiwpq5gpnXMQA0IFHBwISpxoh3TIciE94M4mfkyfvvqy
 OoubYgMsMCAMG1zx2Ri4w4B5QpU25oiG+d8wb+ruNYBhpQR12itLJv2bY1Y1Fi6uVuVhAkrZ5I6
 Q34Go+ku7cRApqcjV97aiN/3LoMLVEON66dDfA6ADuFQ3rnM/C3jzM6Yujeycetd8zn/zhl/+9S
 bAPO8N0zxE29pfkgAgaf6dfVq/FqbWcu09pOA==
X-Received: by 2002:a05:6402:2744:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6aff374f70dmr2489642a12.6.1791378124554; 
 Wed, 07 Oct 2026 06:02:04 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b009c6cf06sm27897a12.4.2026.10.07.06.02.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 06:02:03 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c2a832c6554so269521066b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:02:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzvZhsOeHjz/Ps1FnwWs0wdwKJ+66Bb2+cte1D6JfAQalEBKHhzu1h3mFChN2NdSUQpriHQ9Hu+nT4=@lists.freedesktop.org
X-Received: by 2002:a05:6512:b83:b0:5bc:a9f9:b649 with SMTP id
 2adb3069b0e04-5bcd06e8b11mr798936e87.31.1791377665307; Wed, 07 Oct 2026
 05:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-4-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-4-406fc042162a@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Oct 2026 05:54:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vh-GRYtuGM+By9BfpO4X7skp9QOYeHRj7Rzc_tgQ0KEA@mail.gmail.com>
X-Gm-Features: AclHuK-ILqIUiSWOn4shaOpkE4nC07lDEACeQZtcv49rxdfgv5oCmNXTTOAhHtk
Message-ID: <CAD=FV=Vh-GRYtuGM+By9BfpO4X7skp9QOYeHRj7Rzc_tgQ0KEA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop
 8th Ed.)
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Oct 6, 2026 at 2:50=E2=80=AFAM Gopikrishna Garmidi
<gopikrishna.garmidi@oss.qualcomm.com> wrote:
>
> The internal eDP panel of the Microsoft Surface Laptop 13.8" 8th Edition
> is not in edp_panels[], so panel-edp falls back to conservative timings.
>
> EDID, read over the panel's DP AUX DDC bus:
>
>   00 ff ff ff ff ff ff 00 4d 10 72 15 a1 31 05 54
>   31 23 01 04 b5 1d 13 78 03 7d 77 ad 50 46 ad 26
>   0f 50 53 00 00 00 01 01 01 01 01 01 01 01 01 01
>   01 01 01 01 01 01 60 b6 00 a0 90 00 2b 60 30 20
>   3a 00 23 c2 10 00 00 18 60 b6 00 a0 90 00 56 66
>   30 20 3a 00 23 c2 10 00 00 18 00 00 00 fd 00 18
>   78 be be 2f 01 00 00 00 00 00 00 00 00 00 00 fc
>   00 4c 51 31 33 38 50 31 4a 58 36 31 0a 20 01 4e
>
>   02 03 0f 00 e3 05 80 00 e6 06 05 01 73 6a 0b 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa
>
>   Manufacturer: SHP
>   Model: 0x1572
>   Made in: week 49 of 2025
>   Display Product Name: 'LQ138P1JX61'
>   DTD 1: 2304x1536 120.000329 Hz 3:2 (291 mm x 194 mm)
>   DTD 2: 2304x1536  60.000164 Hz 3:2 (291 mm x 194 mm)
>
> No datasheet is available, so use delay_200_500_e200: it keeps the
> 200 ms enable delay of the conservative fallback, but uses the 500 ms
> unprepare delay of the real panels in the table. This matches the entry
> for the closely related Sharp LQ120P1JX51 (SHP 0x15a7).
>
> Assisted-by: LLM
> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[4/5] drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)
      commit: 7cf88d0a3f5324eb44c2ae9840568adb2374ec10
