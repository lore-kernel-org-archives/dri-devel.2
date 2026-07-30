Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8984C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035B510E099;
	Thu, 30 Jul 2026 01:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dCEAn+hR";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7A910E099
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:39:01 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-92e5c92c389so97093085a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785375540; x=1785980340;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cAIY8Yh5oMiGhOYeiua/PSFT1RRT4CI2Nf3XBfJofEk=;
 b=dCEAn+hRBXP11+Uy/GJSiSrSZvDeuNOBMGO6tXSf+AfOI0xqLJfPXTJAh6NUQX70um
 zWgqSvKfdrusJeocm0qDCmwHPYEQc0ucvyWbVel6NPTE/au6B4FhqvsO28NLztODt01W
 b2pngpatWhboHpFPKLhnwypTM93AyBhPNx+n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785375540; x=1785980340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cAIY8Yh5oMiGhOYeiua/PSFT1RRT4CI2Nf3XBfJofEk=;
 b=FjxRFxV3diWVWDDBB9mbnO/zqK9nahhN9KIrbq3n3ID+51Df2zilQQSBnVSK74yR0h
 ie4E+hxSBY6cs10gbZHcYEpysVFpIXFPOR3pOe6YYXWSPurnwl90uROnWUn1GstKS0Eh
 a/FtP2K/l5drygJCg7HongkHga12XFIXn67N7/1vTw0gzkku/pLG60Un5bTY7z4LRZH5
 /3bhlw5gFKreeRr+VO5zKZsSnVMB08Taw+bntO4TCUx/DDP+YrK2Xmi0KBPEjkvXsCsT
 hf2qgDNbuy0/6egu+vTIcBTpTLdC31giVRsFLx3sKwGif8ZUEajYxIh5/oqxjE7reT/S
 mPSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnuAYyGy69KV3MjjmxBwMlm6DUZS5JlNsuWIaNqDonDbBzjPPYvS2oLzLY7gUacgc8OK/bwwKu5nM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtuI1y/zyiZYY/mlNuh1HmjBUKCcqiWB5WARjY6xeFO+xM8nwV
 Vv0XdsW13lif/OucTOtxUJQUJgpWXWsPFnvsXmCPcRF8ZG9khRjnwsRIxXgaVcLiMEOvIO6OMUF
 Lbxk=
X-Gm-Gg: AR+sD125o6t05S0Upyl1dGcATbcrViQgIEg/QQcgGAE1TfaMTfLspe5G1mu1/O5D3q/
 HslcaGR/LikQUm8n+a/ZnnFsZbpiPWa5b6OoWwvRBVNs5Jw2DBTqnjpwbK9T2350kMnIhaIwHwx
 101uLtWNmohpjY9gHyK+g/3k7ZCOZnCzzetir5Vyl/zm/fT5Wc457K2DS7cKtDpwazaWQ5WWSk/
 /VlXY0Z+IYhERVGvDS8YNiKK+rIGzk43yO/znXbGYXHhSOGEFQBMk8zMydXfLhTt3JIyKijea+/
 JfXtFkbmPIkh58LDFOru4pNHT+pwouCKsZmaIG6QMba7dFT2dDqTKwomcyQEuf/pcOF1kTgw/ti
 VMy7g7Ot0BElr+JMyxK7sJYn8v0KwJh/1O/UZ746Rvyj6Gr83jHHwQf+dt8hmVkJhzDHMY4Y1Rh
 YQ8AVmq00MRayGTFX4QRIyO22Es8dArGZ1kwJTyjRp0zsI4BXqdBaC5SlZ9n0bWNumE/8yF//zQ
 p0oREvlN1Q2plxoUpmOWgw/d7k=
X-Received: by 2002:a05:620a:6015:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93485fe7b4emr71601785a.33.1785375540094; 
 Wed, 29 Jul 2026 18:39:00 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com.
 [209.85.219.45]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e733e41bsm300712185a.39.2026.07.29.18.38.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 18:38:59 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8ff5d1b0f91so11281186d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:38:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3LhNnek6nWoq7Y95kEF5MJPRbmIkj6E8Os92SCoV+OpRw8oCHD2TAyJmRXrH/srkOYndPnFhQOVE=@lists.freedesktop.org
X-Received: by 2002:a05:6214:5012:b0:8dc:ad48:70a7 with SMTP id
 6a1803df08f44-9083470bd3dmr4918436d6.26.1785375536299; Wed, 29 Jul 2026
 18:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260728035931.10342-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260728035931.10342-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 18:38:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+nQ5GsbuahKiBK69ZTpZHNvckM0-H6sL0v1zfROBQCQ@mail.gmail.com>
X-Gm-Features: AUfX_mxrUm9UyxJtuGWvqXIQq37cxVLvL-J1JNEtLZtuuEJ4CkZXhZ-NQE-9RN4
Message-ID: <CAD=FV=X+nQ5GsbuahKiBK69ZTpZHNvckM0-H6sL0v1zfROBQCQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)
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

On Mon, Jul 27, 2026 at 8:59=E2=80=AFPM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDID:
> 00 ff ff ff ff ff ff 00 0d ae 6c 11 00 00 00 00
> 02 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
> 30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 47 ff 08 3c 7d 0d 0a 15 7d 00 00 00 00 05
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
> Change from v1 to v2
> * Modify the signed-off
> * Correct the subject line
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)
      commit: 35b6cf07851a2b430b0eefbcb7b5a856f9030264
