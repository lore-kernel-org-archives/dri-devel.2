Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AD7CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E7A10F7D4;
	Mon,  8 Jun 2026 17:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PKgV88Bn";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC9410F7D4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:29:07 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5ab02fb64b0so2382541e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780939747; x=1781544547;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUnEQeB3M2YVb9xR80dNnrafhjR0z9+ysfmjeZHTDT0=;
 b=PKgV88Bn2yHwuqbzYlhBaG8xGAIwcpeBjrVOTbUx1C1TXPMHFLUvP6GFQMTTgDUJjw
 buacaOuk+/xq0yuj4cB+FkJnPXrSuNAxa60HXZ8L6fALash/xqUCtzciSGEjBRW43QsS
 pXTj9BGPvmHZ1cilSBNhwAayoZKDa/IMtnDbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780939747; x=1781544547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUnEQeB3M2YVb9xR80dNnrafhjR0z9+ysfmjeZHTDT0=;
 b=iizsFv07IKAxAb0hk9RQ7l+GxTUBzA6F9Tw3DXftnhVcgDfvZHzZ59JlBCwmnoqtS7
 MNGkJTUqOcCayuJcgdKmkdUR5Qrl3RsmUmMcv+nOe91VGLYcm6NUc84aeK2IHl0xsK7r
 YelCNmwM/xvoYl357IRsS6lUZeTHLI9L36zjgBH1sPArFQeXiE508XPZsYqF/dNFJ0uz
 ccfZY4VFg+1NWirfrKL0mBdZ1EZ/LRTWwi9TLIrstCPCFmHdglCes2QEPo3DMy59dIvz
 2NvFqnX2OVdQ9Z2gU4cgGdyXibHPFFWziF/wU3/filDhj9gP56n1EmyMvzNkaJpFlqBc
 qGvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ95FdseGkvgc5xz7FgXjXwUKC2tUOMSaVt7+Gv4DCFTtOmjOnfFG6xn/36G52I1Cu/RGUhKqK0GnHk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIlJc5EWoboVC+/ZvJuS3ocJboIaWpV4UzbbTPFWMhaXH1PQvh
 jojEPPU5YeWJdKhW42J39xju7QC/pjSytDBuqttmpjObjMtjlOVyjL5weIeyuecBXHt9n3Y5kxb
 uNoU=
X-Gm-Gg: Acq92OH6TX6o9KQl5Ec9uMKIr+HJRWfKftChOYVMQJ8g+zLayRc2RXGoUw6HGLbNTev
 cIF9PHgC+d6wRbl0aiK2SX7/KYUecUwFwrkkLiF/hK30GSFzAii8i+a1D03CSeqYIWa1pjT7Ea2
 2phIYAs8MfalBGAlZnELmggxgYIuLFDCSl+XChgk4XHvieY0kDKK4euLr1G46KMjj+o8htutbAR
 ut1u58zqeBXumthzUBEVcummWamITyifxhqGRQNui57CAr2z/fiUGz823nS826xIcsySlyk3ent
 JvFGaA70tQIFGOlY2oK13UTnjHe60WRDP4HERRI9W89Ztg/5Jy8D8szBf+vnmKxdbmKCPk05HWy
 XgiuyWtlsZXsMuhVpnBNqmwWTwKNzZNFQd9fKyKIaBAxNBiAjZBfsd8fjrzYhPtHE8jiV2uMfEr
 GWZMMueowxSZ3lzqKRtK8GGJ5kxpkhbkT6j9aWXHv43MZJjavZu21CyG59Qab5//eQ5VESE0KV
X-Received: by 2002:a05:6122:6e0f:b0:5ab:26f:4a42 with SMTP id
 71dfb90a1353d-5ac4d5208c3mr8786930e0c.0.1780939746572; 
 Mon, 08 Jun 2026 10:29:06 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d64139fcsm14937112e0c.4.2026.06.08.10.29.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:29:05 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-6c25b040555so4240637137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:29:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8/5wVG02dgHXhB13V2fI47k/CZww94QD6x/21+HvOQJo84oPrippIjCqgnxOGGDscFsEhHuUuTxUk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:c47:b0:639:4bb7:c916 with SMTP id
 ada2fe7eead31-6feecfb6b46mr8553228137.3.1780939744156; Mon, 08 Jun 2026
 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
 <20260608080310.15126-3-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260608080310.15126-3-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jun 2026 10:28:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBZWyqNpACnrRBXLXjK8ekEg8STGwF5himGwf9tTjLwQ@mail.gmail.com>
X-Gm-Features: AVVi8Ce1JMr1himb5bywHonvBScOYSNWWOOeNXyrGOsKtXKmpDTtzZT0qHblM4o
Message-ID: <CAD=FV=WBZWyqNpACnrRBXLXjK8ekEg8STGwF5himGwf9tTjLwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel-edp: Add BOE NV116WH2-M30, BOE
 NT116WHM-N21, BOE NV116FH1-M31, BOE NV116FH1-M30
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

On Mon, Jun 8, 2026 at 1:03=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> BOE NV116WH2-M30
> 00 ff ff ff ff ff ff 00 09 e5 6e 38 00 00 00 00
> 0a 24 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
> 36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 80
>
> BOE NT116WHM-N21
> 00 ff ff ff ff ff ff 00 09 e5 79 38 00 00 00 00
> 08 24 01 04 95 1a 0e 78 03 3a d5 95 5c 58 94 29
> 24 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 38 1d 56 c8 50 00 1c 30 30 20
> 36 00 00 90 10 00 00 1a 7b 13 56 c8 50 00 1c 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 7a
>
> BOE NV116FH1-M31
> 00 ff ff ff ff ff ff 00 09 e5 8b 38 01 ff 00 00
> 0c 24 01 04 a5 1a 0e 78 03 50 d5 9c 55 52 8f 27
> 15 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9a 36 80 a0 70 38 28 40 30 20
> 35 00 00 90 10 00 00 1a 67 24 80 a0 70 38 28 40
> 30 20 35 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 36 ff 0a 3c 96 0f 0b 1a 96 00 00 00 01 cd
>
> 70 20 79 02 00 20 00 0c 9a 0e 00 8b 38 00 00 00
> 00 0c 1a 00 21 01 1d 03 0a a2 05 80 07 38 04 88
> c2 39 55 1e 15 8f 7a 32 15 02 35 54 b0 5c b0 5c
> 00 36 12 78 22 00 14 ff 21 02 85 7f 07 9f 00 2f
> 00 1f 00 37 04 27 00 02 00 04 00 81 00 15 74 1a
> 00 00 03 00 28 3c 00 00 53 5a 53 5a 3c 00 00 00
> 00 00 00 2b 00 06 27 00 28 3b 00 00 2e 00 06 80
> 4b b0 5c b0 5c 00 00 00 00 00 00 00 00 00 89 90
>
> BOE NV116FH1-M30
> 00 ff ff ff ff ff ff 00 09 e5 8c 38 01 ff 00 00
> 0c 24 01 04 a5 1a 0e 78 03 50 d5 9c 55 52 8f 27
> 15 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9a 36 80 a0 70 38 28 40 30 20
> 35 00 00 90 10 00 00 1a 67 24 80 a0 70 38 28 40
> 30 20 35 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 36 ff 0a 3c 96 0f 0b 1a 96 00 00 00 01 cc
>
> 70 20 79 02 00 20 00 0c 9a 0e 00 8c 38 00 00 00
> 00 0c 1a 00 21 01 1d 03 0a a2 05 80 07 38 04 88
> c2 39 55 1e 15 8f 7a 32 15 02 35 54 b0 5c b0 5c
> 00 36 12 78 22 00 14 ff 21 02 85 7f 07 9f 00 2f
> 00 1f 00 37 04 27 00 02 00 04 00 81 00 15 74 1a
> 00 00 03 00 28 3c 00 00 53 5a 53 5a 3c 00 00 00
> 00 00 00 2b 00 06 27 00 28 3b 00 00 2e 00 06 80
> 4b b0 5c b0 5c 00 00 00 00 00 00 00 00 00 88 90
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[2/2] drm/panel-edp: Add BOE NV116WH2-M30, BOE NT116WHM-N21, BOE
NV116FH1-M31, BOE NV116FH1-M30
      commit: d4ae726fc08024b359e9cacf2507f1c256b9d71c
