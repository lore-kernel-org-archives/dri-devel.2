Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9F7C982CC
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6217810E0BA;
	Thu, 17 Sep 2026 02:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="luBSYXqB";
	dkim-atps=neutral
Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com
 [74.125.227.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBEB10E0BA
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:56:52 +0000 (UTC)
Received: by mail-pj2-f19.google.com with SMTP id
 d9443c01a7336-2db18fe433fso2972065ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789613812; x=1790218612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mep4zkN4WAtJ2xw4HnArFK/4M5cNXhyijbcrj72ZXVk=;
 b=luBSYXqBSMAzpzrD6jUxbPzgv1bBU0MGFVRDGBjPAtfW1cg85sclpvsa5PaYkTak2a
 ZRU7mZBiD6//2QZoy0kFjHhn0+kX98+IUXYR1ZvNRhJc1iThOgH+3Q0uhVMnedq4EBe4
 UZDJPR+8YZiX9CjG+NsZZQ0z6Po82nlKN2Fk2NX7SlUkmJj+II0Mw/LjImZdVyOaJShN
 ABdiC6a8CiERZ6Xi3qo4K+uAiTc4SDoWOQjsnd38VzMHvpT+Q9pMy0FHZsb4hlis5b2f
 AqlKH1065aWNY3LW8I0Mi+9WWsoq8261Nr9CKKT5J9GfRXV4iuFiDS6gXk3uxYufgR3S
 0dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789613812; x=1790218612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mep4zkN4WAtJ2xw4HnArFK/4M5cNXhyijbcrj72ZXVk=;
 b=B0bFUSmPwW2PrxGWo4CC13QS8vmqzOnyoO7Yc/+ZZmSQ1zTb1PDXVP7vdE82JlHTjT
 C4w941SnT1T6KWs/K8BSQvEH6x1fxq2EmUjALZhr2oWH4zfUQlyg9xaoyfw95UUtGB5F
 yvyNduurs7/XUBkGUyARmZlCy2+VFkk2duaJKg4R5mlfvGK12POwnb/YO4t8R3s9eKFP
 M+8g37q9RgGxwTMmoEUGb8ImQrfrLKHjGDGnvw7ACQh+7rwTXMQaEWC2Co4t3iZYWhNS
 xpxRy7t2nmaxwH0iPDGmIoJZfGcPNO1EVvqzHKl/7lrYpezSF4LqrTsfhXX79LL5R94o
 tBgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw54bjSv1u0p0ShNejrvipvemuo5MS16xoPGE2E90wg018xgxlfmsapmNc55ovxn741YBO3LZOvYQQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nuRC5d2L4DKNgkRmV0sDRsWmjhUYMz4mG4uHOSeVZkuwkKuRNP
 1/1nn3xCsKwhd5CblSPkshEpQOnGKB5XbELJy7EraVMi6gbZtp2bqK2C
X-Gm-Gg: AYBFou1v1fbk1qATsqP1k3rAsdFy+eZyv22NJN9VKpAkn+nOHFxYuQEJdldgCQD9SW/
 noOgBsYzbEcDUnqrm9DrgIblbBbi9m3rPjIjG00JWjS+pA74edaa73nGYZzRSBuEsUNl1URblvT
 SDAwhs+eMKP4eVIzLaHOVlnJzhTYX5dsAMHOROndg/ObUJZ2CLExAEFmqGNUmIyTfU0HDRcmE2e
 j9lWaEc4QFpDIcH3unLZd1P43wDYYmCb+JQMHzT/7bMevRFWuSte8VjprC9+ZJ9UOAJ0+K0EZ/Q
 KW0tm+QH7EwoumDCFyw6XUqa7CpwoYImWwcOtJgUVMJ2MCbaqsfo66KVl0JVJ8gUfHvCfZ5mbLn
 0NRPR9scOvE9ukEw63Hf7aegCJdzYEmuVzEaJe2LeRBZzCn20yErLe3Zh40B1uI/bcudJ5caPl/
 J3R+NGe3ze8TcUhGxeXvhJJuBC23e/9+/7ZU6n9b6MImgI1c1ij2RwPP3iwU2R4WR0QFVavE3ZR
 /TiXOx3jMkvAZvuuODpD/2JhzVWLUQz1XoxjE6/3TDRHvOq6erBT6iQ4yKPP/NA+oFICnPLgZbq
 sk6ZO3N0LQc=
X-Received: by 2002:a17:903:3848:b0:2dd:76b1:34f0 with SMTP id
 d9443c01a7336-2dd8e5244a5mr107821025ad.11.1789613811428; 
 Wed, 16 Sep 2026 19:56:51 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower..
 (125-227-154-99.hinet-ip.hinet.net. [125.227.154.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89eb896bsm19014945ad.43.2026.09.16.19.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 19:56:51 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: LiangCheng Wang <zaq14760@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Thu, 17 Sep 2026 10:56:44 +0800
Message-Id: <20260917025644.1262504-1-zaq14760@gmail.com>
In-Reply-To: <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Thomas,

> There's also the ssd130x driver under solomon/ how does it related to
> the ssd16xx? Is that similar as well?

They share the vendor, but not much else as far as I can tell - Javier
will know ssd130x far better than I do.

It is an OLED driver over regmap, while ssd16xx is e-paper over raw SPI
with a BUSY handshake, RAM address windows and waveform LUTs.  The
register maps do not overlap, so I doubt there is much the two could
share.

Its shape does look like a good model though - one driver covering three
sub-families through a variant table.  And if you would prefer ssd16xx to
sit in drivers/gpu/drm/solomon/ next to it, that is fine by me.

> If the ssd16xx does not make progress, we could also try to merge your
> code as ssd16xx and Devarsh would then add support for additional ICs on
> top.

Thank you - I would be glad to help that way if it comes to it.

Devarsh, it is your series though, so please say if you would rather carry
it yourself; I would only pick it up with your agreement.

I should also be honest about what I could offer: only what the SSD1677
and the PIXPAPER 4.26m need, arranged so that further controllers can be
added on top.  This panel is the only SSD16xx hardware I have, so I could
not implement or test the others.  If that is too small a starting point,
I quite understand.

Regards,
LiangCheng
