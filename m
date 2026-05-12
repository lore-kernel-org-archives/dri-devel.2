Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABC2CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A3E10E25D;
	Tue, 12 May 2026 16:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I5krqQYC";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2771510E25D
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:20:16 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-67da63ae541so10098889a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778602811; x=1779207611;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeyK+aHCsO8ZbrN+kA60XGbqitOYckkdGu1NcLbLw2g=;
 b=I5krqQYChIiT0OiEQZKSvcVxD/3UuxQ1x3rjyxazN8ithS5t6/r93vKPsM5dzRNMqB
 QqvIGowhH3HD4er3zYKMnylQDLJ4fCqeTrm1llIVFYYxmJD3dkSurVdHkAOiQSh+0cH8
 +DN3HXl6bFsxTwD4EV42SicPmWGsN0jSY8Ewk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778602811; x=1779207611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IeyK+aHCsO8ZbrN+kA60XGbqitOYckkdGu1NcLbLw2g=;
 b=qYwYBSPRUJmH9FaGqiRhStETES+meCQlmjhZJLa+fou/WgQkWRAu9O4yzmGGgL2Ia+
 skPm07Fl1+PPiY3gxQn5pzYjHOTn2XBc2mFHWpJrXTIwGg6CiR1RJ1fjAXw6E8eP9tsG
 7gK3tyQBykTyjQBuZUGU0yIYAs9aFIVFFcw3AWS54W6GR1+XSIVK7CMRGT8kVSOdLvsJ
 InKPued2/7KKfmyA85f3QN9xs1+LNope/+PnljxrsJMut8V/Geo27TPQf8SgxMk5Axh2
 1IbgJQOwtaeWnyY986rMvuiFxZMW05aZ0i6+ReS0m43jnM5RCa2QrKEWEgDMjV3TXG96
 P0wA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wjz/YXyPI0dEXhARbXl8mKspK+9TRRpeCOVG2KrykQNRNGUrVOIM/IkeEYxfPGoVf7LlD3BTSjQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ2p9escIwltc/wvtZNcX3inDgmr8aoiph9fykvVcVvmpnEHvw
 P7hyk4EAiu6iiiVckonf0QSS4yrb8dyoKYzUS+Hth2NJKxikBcL6CLj7jvozu7I4f2SYFiLjD8M
 xzOBdxw==
X-Gm-Gg: Acq92OFC3TnBB12gOpRkD9+iO3+r1/8mCf5oFQjapr+MZwbqvJAb0I9gnQqW1569YBE
 AaBbDWl3c8UmWWDySzGOnddKKF2hd8sSMnfETp0ZRyg4NBo62BQ9ELHf6l4mmtePV3xi90eLNLg
 VNqwESOb0sm0docCPDdKvEjp9fQ4MSnByGy5QXJfl2ZOFSxNmdrD79TJZNdlx85fH84jnWiMTWI
 G5h3A8gJU7PKVSSuIWA76ODo5ltVjsBMjaT99e90QZbPMguy19XFu9PfSa+N+xWVKbgi6C8PKLH
 XXgt5zFSZEWV92TElm3gti5W2bhNw/ieE7l4VkCljoSTVUB/bsqDnGT0H4B4B2/ZMjc+w2DkX/f
 Kb/k/ebiT32Jxszivcl5mg6OUkgy4BlJXEWokrItpyEIh2VeThSS0BF/vobs7CDXfX1CFqd/dJ4
 6xKFLDIIUbwPatfLVWzV8+mcXPOV3EVD2BHFP9Kyyr9gnsejFamDpVLeWACPneuQ==
X-Received: by 2002:a05:6402:5025:b0:679:65da:33f2 with SMTP id
 4fb4d7f45d1cf-67f716df32emr7692716a12.21.1778602811128; 
 Tue, 12 May 2026 09:20:11 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b3b904sm5079765a12.1.2026.05.12.09.20.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:20:10 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso52778765e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:20:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8m8a2brPNkFrXlsiX8XURNBlGNw00diITzp2pGD3QLPDXz5yIdNoLKXIPHH+PsCwBjJ40FAmA891c=@lists.freedesktop.org
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48e706edd0dmr242481795e9.28.1778602808331; Tue, 12 May 2026
 09:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512045454.1505733-1-wenst@chromium.org>
In-Reply-To: <20260512045454.1505733-1-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 May 2026 09:19:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0g3ETLPLa_vZZTjrCv-o=TSKxfGtX-yWcnTjccVNtJw@mail.gmail.com>
X-Gm-Features: AVHnY4Iq6L4YijqMWVnEP2WiCSNNa7CCgHyGtdG7-uDM7ZZymTpWwAQ2vi5pT48
Message-ID: <CAD=FV=W0g3ETLPLa_vZZTjrCv-o=TSKxfGtX-yWcnTjccVNtJw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add AUO B133HAN06.6 and BOE
 NV133FHM-N4F V8.0
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
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

On Mon, May 11, 2026 at 9:55=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> These two panels are found in MT8195 Dojo, a.k.a. the HP Chromebook
> x360 13b-ca0xxx laptop.
>
> Only the BOE entry was tested on an actual device. The AUO entry is
> solely based on the provided datasheet.
>
> raw EDIDs:
>
> AUO B133HAN06.6 (from the datasheet)
>
> 00 ff ff ff ff ff ff 00 06 af 8f cb 00 00 00 00
> 2f 1d 01 04 95 1d 11 78 03 93 05 92 58 59 90 29
> 1d 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
> 3e 00 25 a5 10 00 00 18 b8 24 80 b8 70 38 24 40
> 10 10 3e 00 25 a5 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 14 0e 1d 7d 20 20 20 00 77
>
> BOE NV133FHM-N4F V8.0 (from an actual panel)
>
> 00 ff ff ff ff ff ff 00 09 e5 25 0a 00 00 00 00
> 2c 1f 01 04 95 1d 11 78 03 28 65 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 a4 39 80 c8 70 38 50 40 30 20
> 36 00 26 a5 10 00 00 1a 6d 26 80 c8 70 38 50 40
> 30 20 36 00 26 a5 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0f 0f 1f 7d 00 00 00 00 d2
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Added raw EDIDs to commit message
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

I'd previously seen the AUO 0xcb8f panel as one missing and the EDID I
gathered matches your datasheet.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F V8.0
      commit: 5dd1ff95c623b8118ccaae3242119b8552f7b98f
