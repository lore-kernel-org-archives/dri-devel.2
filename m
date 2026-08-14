Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E264C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB1910E126;
	Fri, 14 Aug 2026 17:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i7M6Kfj1";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5364910E126
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:22:33 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4a45b3f0becso787074b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786728152; x=1787332952;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tj7E+ruRn21DOx8hBxzrIfOaFa15mTHfWsZCBBG1Pso=;
 b=i7M6Kfj1MUjUBxGAH5vbDkXPZX9Qr5w+RkAcwMeb/I4+bXzxDeDliTXaBApi/o2zWp
 qi7UCHzBoRVpMLCF/WN27z+08VNUQBidFUSFK4sV9WAhi9aOyF4CMyTwSngZKzd3KL/Z
 Zzr6qs5HQAKIFkxNtkI4x8KZJW4KIGuOg/rkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728152; x=1787332952;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tj7E+ruRn21DOx8hBxzrIfOaFa15mTHfWsZCBBG1Pso=;
 b=WbCknZyaTLECFU0aX0cX/pdzJsriPRawLGs0wCgcdPh+evxDTu6pAgCXidMVSddf2A
 Q9uMHelhOZBPVv0WvAQ2oXCGwE7m9u7lMtK66ciJli4ELseU0m3Fg9EqMz5c3FNpJvt0
 7ptxnOAUZCkhHFqlC2TfTrInSQj2VhEK6PQN30szsg3+HOntodDLuBdA+piI+UyUREKZ
 aHxLuUxGSFN/rBrBqLbixi8r7JxH2iy9YQ+OUh8cg4GmotXI49EiIZAr3ZFoRPeb2UZg
 gm+0l8SkdaTIljUva58gul3JYYdR1MbjkD26xf0m6//4INNFqNjCVi23Q7Wydv8CxXjw
 HENw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9jwzRNmuKwwjn7EZSlJ+SjBHPuT61C+YwqZQ7ipCNdUxUmN8x3dcOacCXS9NGiooixKz1JAK1wtk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywup6in28NxTaXgXzaUD4Y7lFoaC89GuhrcF/Re0gryiiZcAaaO
 Lm96pfXwn0j421N5n8RRrVO0t8bN3pD5EtH0UJqtJHb/kcB8/jSquWM4dEDseXBtvFu/MfiOihx
 dmt0=
X-Gm-Gg: AR+sD1110cRGZOcDpfTFzssMLBgywzWk177WyzXhFr4j1hRkd/Mr/cGrNjzA2Fx6Tmn
 MxOB446sD/dWn9Gd92iMRerCtcGkQoCUmT8+Wv2UER+lLJNM6ao52jsDCKaaaZpYQnXLIfrmPlb
 bxfwmeKIGw2yD506I7ciFL3bjuApjPwaW7W2R4MYwnnAKtCOyuIH/Ph2zWCSTJEDDZKmngc/5VK
 QBlPT0vwJJoTks7eiFDZrloqP9nfG8gG0CzF7TJv/hN9MG3u5RduaCLAahfAl3BEgjRZNxjzxh1
 wMabpVpwG1eafPpvGrSJbRFqav8NOUvE/oh82ps9Lo/Q1ZHH3x16lYQIOfYBu5OoMLspBTU43mY
 WuAiYWfU2hmF1E5DqZwxHLqT+aDn55t8tqPtczbv13Ek9HRa98dUTn14c83W3yP6kGFqHoGQFze
 NDhvoR1i+lymG7xN1Imutua/hiL5EYKM9GDaDy6+bKBEgqLPfS5BiwZ+T7af1xWogyViXII+Snz
 EjMCKJt3MA196KmPA3P2+K0Fj2QDFU=
X-Received: by 2002:a05:6808:4f10:b0:4b1:b9f1:e893 with SMTP id
 5614622812f47-4b2412f1004mr6705457b6e.3.1786728152301; 
 Fri, 14 Aug 2026 10:22:32 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com.
 [209.85.167.180]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b24db6bcb0sm1242577b6e.13.2026.08.14.10.22.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 10:22:31 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-4a45b3f0becso787054b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7KBlw0osajAHM50k5gi3Gt8kB3pPGZZ9dP6Htq413UD5mBVhoazeSPi/SUC5V4sFKbu97oI3CH94=@lists.freedesktop.org
X-Received: by 2002:a05:6122:1829:b0:5c2:b001:db5b with SMTP id
 71dfb90a1353d-5c591d18a3cmr1347396e0c.6.1786727693732; Fri, 14 Aug 2026
 10:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260814120304.887993-1-y-d@ti.com>
 <20260814120304.887993-3-y-d@ti.com>
In-Reply-To: <20260814120304.887993-3-y-d@ti.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Aug 2026 10:14:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XVoWvfD33Y16UOMZsz_fsOpnxeGK0izEKc-iCbR++J2g@mail.gmail.com>
X-Gm-Features: AcwNN1Xbr4jyJmLc9m7TmngqM9GEVDTkwaaD5i4mwFGDheHWmnM85sejBoE2ID0
Message-ID: <CAD=FV=XVoWvfD33Y16UOMZsz_fsOpnxeGK0izEKc-iCbR++J2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link directly on
 cable replug
To: Yashas D <y-d@ti.com>
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
 u-kumar1@ti.com, devarsht@ti.com, s-jain1@ti.com, d-mittal@ti.com, 
 b-padhi@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 14, 2026 at 5:04=E2=80=AFAM Yashas D <y-d@ti.com> wrote:
>
> When a cable is replugged while the upstream display pipeline is still
> active (e.g. a compositor holds the CRTC), the bridge can retrain the
> DP link and re-enable the video stream directly from the HPD interrupt
> work handler without requiring a full DRM atomic commit. This allows
> applications to recover display output after a cable replug.
>
> Signed-off-by: Yashas D <y-d@ti.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 215 +++++++++++++++++++++-----
>  1 file changed, 179 insertions(+), 36 deletions(-)

There's a lot of code here and Sashiko has a bunch of feedback [1].
I'm not personally very familiar with the HPD flows. I'll probably
skip reviewing this until Sashiko is reasonably happy or until you
explain why Sashiko is confused.

FWIW, just from the patch description, I'd also question if this is
really a good idea. If we get an unplug / replug, we could get an
entirely new display plugged in. This is really something that's OK
without needing to handle things?


[1] https://lore.kernel.org/all/20260814121431.72C701F000E9@smtp.kernel.org=
/
