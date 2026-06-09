Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D8ECD98C8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE5A10E611;
	Tue,  9 Jun 2026 20:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="Io6GWpt6";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DE510E618
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 20:12:02 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso6042225a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 13:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781035921; cv=none;
 d=google.com; s=arc-20240605;
 b=VYuiNlkSIFNhjhCphnmteKCKpTOBczNIqkpSNG8kglWnA0pGwsr+WP241IkcdBLrgS
 LOWVbp34TlrlvEciuM2LIpRpR8U8DpMPsjMhP5k82a3RiKiVgKGF2ZXozEI3xU4sUwDK
 oYSvK13v6NauCmKaYAVXhf2ythq/IcBLi2UBNnbngCMcH4ASWIj1v0l2DaoemHHntz5g
 2XW2jT6zR3Tg7iS/fNwYOeVmRaPYsbyNUmi8aI+ZqAVWoJm0wyK/FbEN9wvhsxrVwoi9
 lnHbv9RNOIop58aT8wFtoZ7AckmsJpmkDP4r820b93SG470gXqp5eVC/lm8ZpslAaoci
 ulRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 fh=ZTNvg43btqolYNDDlDgdSDgd4kAzCEOoJ7bssKiiwhg=;
 b=G3QRDA1C5khJ29XEyC7xyq8w2u2cA9sKfyOAhxDsOYVjw15E8+/Wwa9PAl4+a0/uab
 L98gnvbr1+YV07wKAP/yBF9LbbNv46O6o+F+Ds9o8eq05A+DiIOCo3oTD5ke+/IToLon
 SeGj8wB8bzmnsJXcLLWPIS/vCOs1fu18ftcRvFnmOBvflw3Y1c63N7wjTcW3bYTH62Ze
 vw8xOVreZWcLdFHle116Srp7tJzK+Fx6mjAFbKdwmZsM0Ej1hX0WTQWLSakBULhMI0b/
 4c9NrjkT0ddS9xI8TBya+qqsYC76219SSzhJESKWWpuSxHMbDpnNcYU+GCZlVawvdgSm
 3VBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1781035921; x=1781640721;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 b=Io6GWpt62/Gv/hyGboRumqyDPBqmK48RMS/LWQjoe3l1/+gg0mPwtFR9RZrYo5zrMF
 dTHM7QPQvj2OCdN8wF9jDgVSd8skMH9J50XOyWbjVJkdybrgmS7t4Gb9KClxygrdkO1F
 Fb0hfjjjguTi1bdiMnBUARPpimPf238PplHHiGjzC0MH+Vbvt0kYoWtU9c+/AfFIaO4C
 AzAeG6aM7LnU1/ndPe5pSjvVEX8Fho9hHIZQICq+eeUlcDEZUqry93r+N3BmnmQ+kYNp
 7W6Gjxl61cghxZi1rL0VU9OTjhofVrRSzstptUIzNhPBVPw+nIp7jwFMET7tbMzcwbw9
 EGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781035921; x=1781640721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 b=L2Rl6FPN8pTf0EyE2LTbLmoY2luB43irSV/Sw8X+36kjp3y9JtRc4eFXPHHCe1skzc
 4DzvoYbK4YJeT2b4dPw5bjPAHoxXlIzRJkBH85Ztc97o/pb2lRu7tn4wiLRZyG5HYWt0
 vc2sNM3gD1uASuNdWVnDqQQ5SYfVc/iIdK2X7JZlVEDWU7F+Kf/PYUATQZdbBZLDsaTI
 t1gezzuNlMm6GrdZoLMGkKBEu5xhwcOUyXwQJ1n3puO60L9iC+mZ3T/Z5eUSupAHtMZJ
 B/wgNvJzcPMBkMP88pn80bdGsvlAlIHXRNAkttQVszXfQ8xNVd7xQS/aVB7kN9jQpSV9
 4TFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kOZtLP3gKJ+HALr5n2+j/S+NuFtBbMV5WXwj36m1mtjg2nRvJpwC4o/DILH/FGONwh9lrMtnvYYs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsSWGQC+Wp1ze4/33WUANu4nhAXSu8Y0Z9sZxiFMrkA3uI6U7O
 M151P2cNZji7ZKIZBwiv9KcoWmn0ZWaywOVWGesXkNHgCjiiXxghIEdTrPe1ueqrqnRg6Zuq5ra
 aYCke7jMPHVx2lE6MEFpMtdV03XCGz62JJOU/qHvsQg==
X-Gm-Gg: Acq92OEUveO9lnuPBLb4l2cX+HJ0ylETEjXgR3LKKOINELB9DypHWtcgZkYnJlgF3ck
 0Llume+Dw8PRbn8zgn1AJqxWAhgRd+OYwbj8XqxPaOc/Yvtml2pPKYU6VdjNLv2PyWBNAZzzXw6
 EH9bjYqb7JsHblxD4vGtgU1DR+f3k683vPX8cH5ORNKCi6+WsZWMe5619fWRU7caxKXhYDUt6hy
 8B7H4vyowcYDISbcTRndFOKM1SFw1mhZEPcZ5HBET2qYNK2kWntngxaM/zHlwZOlm2H/5airQaO
 iG6lVqFmdqkTX9C+Jw==
X-Received: by 2002:a17:90b:3bcb:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-370f1525ed1mr21923499a91.24.1781035921449; Tue, 09 Jun 2026
 13:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
In-Reply-To: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 9 Jun 2026 21:11:46 +0100
X-Gm-Features: AVVi8Cf7R-IrVdYhsGfa6ARvQUl6VjYbn-pxlLXZ6UvxdCSIBKSlKWHfn1zLb40
Message-ID: <CAPj87rNhTViuff5qWeoGkPgyRvP0uOAcUGpcJJPTkPR2b8fJcw@mail.gmail.com>
Subject: Re: [PATCH v17 00/28] Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org, Werner Sembach <wse@tuxedocomputers.com>, 
 Andri Yngvason <andri@yngvason.is>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Nicolas,

On Tue, 9 Jun 2026 at 13:44, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> this is a follow-up to
> https://lore.kernel.org/all/20250911130739.4936-1-marius.vlad@collabora.com/
> which in of itself is a follow-up to
> https://lore.kernel.org/dri-devel/20240115160554.720247-1-andri@yngvason.is/ where
> a new DRM connector property has been added allowing users to
> force a particular color format.
>
> That in turn was actually also a follow-up from Werner Sembach's posted at
> https://lore.kernel.org/dri-devel/20210630151018.330354-1-wse@tuxedocomputers.com/
>
> As the number of cooks have reached critical mass, I'm hoping I'll be
> the last person to touch this particular series.

Thanks for seeing this through!

I've pushed this now, minus the Intel patches which they can merge
through their own tree. The AMD tree required a pretty trivial
conflict resolution which seems to work OK here.

Cheers,
Daniel
