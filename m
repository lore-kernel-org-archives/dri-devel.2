Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6490C531FC
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC14510E078;
	Sat, 25 Jul 2026 01:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QfOssLO1";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2465A10E078
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 01:03:26 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso11580295ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784941405; x=1785546205;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XIjmTusWB12bxyGcigZiT96smwtyfL390XuUtvO+14w=;
 b=QfOssLO1yTK2Y0s5BOKDgGrxSpgB3Ef+ttqNc6d2S4uO2SRURn6HFkSC5G8D/+t+9o
 YGzXJHBH0XDUt6vdNaLDH918E60whVEStLJ6Vl7S4MX0SJMJtJ6Ti7VuCZcX90gt4bhH
 86fPLv0YKlZLpxUZPsVeesPMSk8FQGIEmjkTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784941405; x=1785546205;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XIjmTusWB12bxyGcigZiT96smwtyfL390XuUtvO+14w=;
 b=ocMMT5hw5dUhGSWapy2B1kSlcxl1daR8RMoNWvRSwVfJN/h4smgn4qubMR2jcRHk6T
 MOY2IuS6epUep1bJp38idReRKaEgK0W7QiwR+NE91eiWvouzVVlOy+rI/zg8QCzSoZ6C
 RusaXeDRMy0JrXEUWj4WP4Y74d9qk1NqKZY071QC8e3PXT5JYud1y4ewVE/KsI2HWMmB
 JLo1pmf/lofyIi5tmO+DGeuTaL2TM0WG9lgT+DQDCUZ7lnF9OGHgzntS5fPJdvrpVDHS
 ZAgGVP3ePhsbO47BN9qQ/kgoziD812yyuw8I7DJCd9IKP2xqBFsC/7ewX6ZzCFr0g1vP
 hEog==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpv4rWZqvMrBKDMZ3S5yzfMS0lJDXzju4qCo82z3d64y1YbGFKPik1AI32bgVcfcJ07zQI1dryhVeY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynn+N48xG8V2Px6xPZU5fF6L3hU3KVYFMB2G4z/Zl98xoi6WlA
 5Ni/I+j3vlnw7ovEUdLQKH/Q1/WA+gO8+DKecWrI5ghyAz5xA706SzsJ1bV4hvqPVo7ba0N0Gba
 2QBc=
X-Gm-Gg: AR+sD13FtjLC6GFmon+uD8Z0Tm8z60QxiAjq4Bp/UUiwV1fQq9DlaWP9c1xtaRuc6VO
 mybZbVUnBjCxNYu2tfXBfFnKoECyFJHTdDencoP6ttDaOxfToLSSMNZlrk9Q3vQSLC/LiUTB3CA
 LknBs2tmO0CxOKeDTlgfCeL3BxUuCfSyo9KkKCZelIlqj49PZMZoU0uvvRkxIPAkCK+IAniTjgT
 94/q/Mgk0LGWmALQ8TacHlBS03xju0E000JIT/ltu9gNOYpMl3RIvILq8Qk9LlMFrm5TQieq61o
 zT4FS3a8B5nqeKEsXR+nG8GLIsGej46oULAo8r6jH/jpYVtVv+vkFQRFOyHsjT+bkf0cL+Crvzh
 FCts9iLirL85NtIezoMMFAskp4k3mdvV46KM0Y5uylPn0I+zYJock77ISSvz7YmNhpNQCr7CZ4K
 4poAaDCWTdVYsbz/Kyn0UlkcgQKRekin1YbVSXu7h5
X-Received: by 2002:a17:902:d581:b0:2cc:f5aa:9513 with SMTP id
 d9443c01a7336-2cfde7903a1mr5845745ad.10.1784941405600; 
 Fri, 24 Jul 2026 18:03:25 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com.
 [209.85.216.45]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde59b885sm2363445ad.15.2026.07.24.18.03.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 18:03:25 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1091968a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rrl4xQA0jrzxJfrBs22lBN6VSIx2hh3E7x8Ec1r6o17w/X+V2C3AlUCjNKp5WKEslVqk6NFEzR83iM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f48:b0:740:2d5f:e37b with SMTP id
 ada2fe7eead31-75040edb533mr763712137.29.1784940919042; Fri, 24 Jul 2026
 17:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 17:55:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vo-VQDmRVDhpFbBQ1A4NxqETiBMbgwHZdUTHL3cmJa9A@mail.gmail.com>
X-Gm-Features: AUfX_mzNm0opznBrZoHzgDpOdeSJ0d5GIrQEB0Lk6NT0NzBqTtHZTJ8Wbf8vw_s
Message-ID: <CAD=FV=Vo-VQDmRVDhpFbBQ1A4NxqETiBMbgwHZdUTHL3cmJa9A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ps8640: propagate AUX transfer register
 errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Wed, Jul 22, 2026 at 7:38=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> ps8640_aux_transfer_msg() programs the AUX address registers, starts the
> AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX status
> register. Several of those regmap operations have return values, but the
> function only checks a stale ret after the status read.
>
> Propagate failures from the address write, transfer start, completion
> poll, and status read. This avoids returning a transfer length when the
> bridge register transaction or AUX completion wait failed.
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX chan=
nel")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1: https://lore.kernel.org/all/20260623060635.16064-1-peng=
peng@iscas.ac.cn/
> - include the AUX address and length in the address-write diagnostic
> - describe poll failures without assuming that every error is a timeout
> - add the Fixes tag suggested by Doug
> - rebase onto the current drm-misc-next tree
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Assuming nothing else comes up, I'll plan to apply to drm-misc-fixes next w=
eek.

-Doug
