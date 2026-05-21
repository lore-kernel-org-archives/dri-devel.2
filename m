Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ADCCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C39E10F371;
	Thu, 21 May 2026 14:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="X4Cm0eRa";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780A410F36A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:53:53 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3665b67ed66so4023754a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779375233; cv=none;
 d=google.com; s=arc-20240605;
 b=B0S6v2MrEZmXtVL3ZVJel5px80p6IfbPwF4BEx0ISUHst2L3E08zdtYR7cWabml9PA
 oFRzFWeBbHA+b323yloDghiK10rXw0xolIPhq4Gkfa+mEbS/W/l2c9tx3SaSlMtY9cMj
 e7YMzMRJtr7TdxPxayCEyNe89QB7ZP8yUvsGM08bZ7uHZMzw7CCfbnvOieuFjztRkqsY
 bcEXnTi5kd3yr790QcRj+1XlGxfqJd4sPBQfM4cp4/lKaYsRKb0CW9xfg6gcIBmziQNd
 u3wUOVnxbBQU+6a/ESRLb/6TjmCkZ38GXGlS6RNjTM9XRJRnSZ8s2f/vhx3VQeAN/gxM
 LTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 fh=UEm3sUYIbl7bLQyNDCt0rwlAyV+Lj0spo5O5iINylwE=;
 b=bpz2kzIZKBi0/8tUySpqJQr37qtoqUn5j2Jr8z9/eiuexkZv4RMQ6qoQ/O9WMNTC5T
 b6jBI2L1lEuLd2/f2Ca5yT+odnp6pgkoePA2j97tsJb8uPIzOMl1MFLIvRMNsDd6jf1Y
 z9M6QLYgcBOyCtjFv4xfbKtY2gItYBJDwYyHeK1dnDZhpirp6JF+LXBJ4wmUervshiCS
 VvV0HLBRTq6hpICm6Yg7JRP/5vZA4D4p3mpdv/lj6el0KxhfuhFHq1mgsEXoyt4jebZY
 g76wzaef3jD7wVUhLGyviv3qFQBZEp+1tywGtjeKksPUkW1qn862wqhVblGBW2Mfjluk
 3mFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779375233; x=1779980033;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 b=X4Cm0eRalOhD7aPfWdgBAVBQsTDZXCODGprWlAk7HpUnnY+QmW9ikUAQrBoFUV066h
 PDq+nDNKvUEK2MsIIG6juPz1PheewyhtGHPFuPAPBtp2mrTxzoJghs+yb/ppOeUeoZea
 hoO6TCqDTrAq0SopDvvkHIDjNYLqX7sCHKPLZvyHx1qYa4pGVD4MupVlPKM+IVFcW5Sa
 A5qso4bpIuub5uH4u1gwjA3BzgPAxnmrVcCSjEs1Z2bIlIHfGiu9gkCs3B2WsL7cLyyv
 BPcsGzUNRznfDwlBxAoewe/5/5HxNBKViHyx5FnJziIrSFAIAgz48nptWdoERrpqnJYU
 6gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375233; x=1779980033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 b=aysb+1/g3UJK/Eu0H0ZBrtO4vaQcMGbSrqM8+dqq75/BSC36cXS/TguWEU9+5fBPKp
 HafhpLfMO3a/WYqFfI+q5pA/tMhsIlSfeoNQC4en1UOFJALp7Gi6sRalBtUVcl8kMXa2
 HDMoWepk2qH+32Dw+1Qy45xsr4qfBNfoRf5hDGr8W+AoQKnf8tfvW1Z/tUXfjQIPmQWb
 3wD4cAQ1dDfpDdhQUUucIipp29eTWMFcGgZy4wgKJl9UoBYjw9BLDXaTxfr7qiyAWNhj
 QeodH6cYO+5XUqVKK6DQq9JLkyaTooZc0JzBLGZ2ggnkQEGGd3jGn0TAIQ+u0aQaicCp
 SkwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cXlWZjMoWlenD9mXYB+8qP5VgJJNZpduE4LALRUN1gZBS3LrXzDYu+u0B+WEVp3fWXX8lNbgbprk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW8D4JssG7NKLEVH4H2G70KSjfJnmEMMbsobgOslbUSJ29TaoH
 DhTIt9+tQaJdpgcmc8rXYVV4aL0XLnvbDGjjve420C+WLNlsQLky1VdGmJJqd50YilJYqkl1WbZ
 aNob8FfnqE2jT8tKkzJqJF5Zwab4gWRTqKUHDeyiuYQ==
X-Gm-Gg: Acq92OHM2a3hWrz9UxYZ3OnpTp9MyWBVLi9aQLbwbX/AlCWWF0o4uejVTB2TGgDwRvv
 Qs6wCP8Pa5Y01FJnV9El5KzLuCGRBcELunZ8BWnCau3N3K2o0nDv5x8dMH88XhMNG835s4+jnb3
 crr1YCYcb6NXgZqjcWq/aXYtqiCUwwlzUe2XM3r6mVeuxVDiz21ofV+eNmBSeLET3vyeOflBM8I
 8pBgW3nUhS0LDYYkmQjrWjgvdLA/3jC2dj//3VzzDM+nwkcB2aUUrYxf3wYb22J9TdEdaw0fDp+
 sMBYeTSM73Ih9tvR0YNbZwl94KLSyk8U6tdY7Gk=
X-Received: by 2002:a17:90b:2d50:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36a451816e0mr3680773a91.12.1779375232901; Thu, 21 May 2026
 07:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:53:41 +0100
X-Gm-Features: AVHnY4KPQYYiaRNDiAsU-wmS8JuOZnjSnShN4CXgg2DHzWx0LVSgQ_nHQROoprA
Message-ID: <CAPj87rOFnB+csoswOOSBR2-=abtCDbsKq2uJ_PgYKPWh-G8m9w@mail.gmail.com>
Subject: Re: [PATCH v14 00/28] Add new general DRM property "color format"
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

Hi there,

On Thu, 23 Apr 2026 at 20:04, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> We have an implementation in Weston at
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1825 that
> adds support for this property. This patch series has been tested
> against that MR on i915 (HDMI, DP), amdgpu (HDMI, DP) and on rockchip
> (HDMI).

This MR is R-b me.

> General notes on the approach taken by me: instead of silently switching
> to a different format than was explicitly requested, or even worse,
> outputting something to the sink the sink doesn't support, bubble up an
> error to userspace instead. "color format" is a "I want this" type
> property, not a "force this" type property, i.e. the kernel will respect
> the limits imposed by the hardware.

Yes! If userspace wants a fallback chain, it should encode it itself
through a series of test commits, rather than adding the sequential
logic to the kernel. Doing that might work for one axis, but pretty
quickly disintegrates when there are multiple parameters to perhaps
fall back on.

I had minor comments on 03 and 20, but they're Rb me with the obvious
fixes. 11, 12, and 19 are Acked-by me, as I don't quite know the
hardware specifics well enough to say. The rest are Reviewed-by me.

I suggest you merge the common code and VOP2/DW-QP implementations via
drm-misc, leaving Intel and AMD to merge through their own trees
whenever they're ready. We'll merge the Weston implementation when it
lands in DRM.

Thanks to you and all prior cooks for all the work, and to Maxime and
Dmitry for the help and review as well.

Cheers,
Daniel
