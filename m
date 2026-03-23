Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7CDF46137
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9EE10E041;
	Mon, 23 Mar 2026 15:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="baBiRDK5";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAD710E041
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:00:07 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so757471a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774278003; x=1774882803;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egPIzPWyFZ0H1bAOoG2ieYC+ndnIov1MmZP1sPDcz1I=;
 b=baBiRDK5tt2ZL7zrpB9MHMIWoFzvoMBIRoIcxYDX9IGAypgHf91f4IA8ZNXQOa8d0y
 WFGVETYxPKULLDOPzDUIvcZI0wX8/AzvWA38jchWM9Ov8BMyTSJRdm4VNKECwvnSg8Lw
 aISi1EFkZsOLmxgAX48JDNp3TbeiO+FqUs6RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278003; x=1774882803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=egPIzPWyFZ0H1bAOoG2ieYC+ndnIov1MmZP1sPDcz1I=;
 b=PdhBxTJw3yBuQOTAqxRZJx/r/JwA+sxV4wQX5ha4OP2CLJl44XqgMQUwxV7hNbXDUk
 COq1kCB/URZTNUXj/RGr+65i7FDsqLWjaRMK4s+bAasLxgS9AaPdb1Lo2AX48288inv8
 c1h64N3B0ZvJ5VA8UPkx87GYdi19T67YxTt8bxkF5hP4849zYn/8b3YmO1uEXON1bMW2
 Mwsd6DuHS/H5Z8oYwDChwyqGuVHU7jKTPViGTOVIgpbKd1lJnADg9R764MI3BFbhjav0
 Hf4hLeyM6WJHsTa1Mg5nicNfwggNWoqGu3C42YI6ud4bOEz+3WPL0nd0laCiAJ3dFYBA
 oRtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt22WUhNKcabskVLQlrA049kB9+eEWd1FKmNwtdPOnhFUT9M7Zs5+cUnocvSeKnAYsaGx/DDmHGak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7LEjjzrYNS+jppA/7FTsNxVA2XW0059lIq2gHdF8634aNL3kc
 Qjf6bZLDpqamPAiidz+adYNLeZXM7VFozmZFZWQBLkALBk6ipilEYNfzN0WaujEmZy+ZrCxwGam
 O8zy6Zw==
X-Gm-Gg: ATEYQzxQq9G6gwZgBEjcdGppeFc1c2n/T/3wXcx0Mmc3mHUAbSueltkkhCYIBWKxkSS
 0UPIhcBT300XqiscukkfHE2kRnEBmNGVQ1wUiApVokepDg9De2lKDJ/8N3yds1xPTiwQcC6x5rm
 oK/gMt2bB9q+P6ll5youU7upnqAO7j/88IPA7VZpkz1+vSOrXves6mPmqQA1DukFbquKMW6z66p
 weTicVDVSB1ameDZSt81xFK4qKEofljjN3/C1p5pU705+bQIQ2lIlndqd9ymhIPFOtok6583C9y
 ci7FLozxudrYh/HfafcvBhnFGDlJ8R0G2HGZKoKjmYcz1agIMQJhw5IcUd4ShBynnuS3utw3Bsd
 Q99qkVTnklkYoCVey0hq8LfUGI2/VlVJucrPJjef7NZLte0qHZoCXce3CTr/W1ZGvWxGmtxjIVw
 RzQ3s6kgm9n71WUihSfwqbvvNCBoII1GBpJqTvElZuPv9nxxqTVMSCz1kg0NcUlgH6YcnUphtE
X-Received: by 2002:a05:6402:1ed3:b0:66a:16ed:46bc with SMTP id
 4fb4d7f45d1cf-66a16ed48ddmr1172527a12.15.1774278002588; 
 Mon, 23 Mar 2026 08:00:02 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-669331c7450sm2647281a12.6.2026.03.23.08.00.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 08:00:02 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so25391515e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+vX6sfVIipx0xp2FFoZB2ftYmXQ7nDVWcioFRatqXoMWet8OwIUB85SqE0TqtxBOLTvVjA88c0rU=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1da1:b0:485:557d:9fe with SMTP id
 5b1f17b1804b1-486fedc9c01mr174598265e9.12.1774277999781; Mon, 23 Mar 2026
 07:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com>
In-Reply-To: <20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Mar 2026 07:59:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4x3HbT7NV7qL8j1sR9T-RZasgocE2K4O_X6YSQ-HHtQ@mail.gmail.com>
X-Gm-Features: AQROBzDHHKfMN9DEoWAjPEf75yc54RObeksOHRDurgU_-f_sa7ptq13LcEo7-Gs
Message-ID: <CAD=FV=V4x3HbT7NV7qL8j1sR9T-RZasgocE2K4O_X6YSQ-HHtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: sharp-ls043t1le01: make use of
 prepare_prev_first
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Mar 22, 2026 at 6:21=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> The DSI link must be powered up to let panel driver to talk to the panel
> during prepare() callback execution. Set the prepare_prev_first flag to
> guarantee this.
>
> Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI h=
osts at modeset")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
