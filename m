Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11962CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 22:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6614E10E57B;
	Tue, 29 Sep 2026 22:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/trdO7R";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8795910E760
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 22:21:38 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-9105d241693so40108436d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790720497; cv=none;
 d=google.com; s=arc-20260327;
 b=CrSsXQu9BOkjLkXTI3cG3/7GiO0UiZPAHF5ER/Ahdf+IkshS1UBMZ7FQIqGKgZGhlt
 c1nyEHagNa5wKpYZ2wLr8R2swq7iTrs6jSZWTl+wO3dzVVbRUb6yXrV4/TsdZZ0iaytM
 ffixzPIzz+qLqRk8enfNg/lptmuCGpbIsW6fcc++rvjeAgJEwpi00JN5ql7zg1DnKzsb
 OFoLKMsNGK4L/uLxEKbamfproOz6UllW9Udl+zjKeGhnnsFAe7dqRojVwB6HVuWrb0Tp
 AhK3LmhK21KBTzl7BASZY8SEXzUwJuXiClgz/DeObrxBy/GUxj+17Zc32xNXfLkSylhp
 45cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
 fh=qVa51EYGmk/7BjKtDbBLFg1Pn7q+IkznTskKIijPyEE=;
 b=scit6APH1QgbysLI1rVYb79mKDBeXBYcJ18fvzEfZLHc7CCZBh9XeFCRnWmybn9mDA
 VEiMRd+4failcyrPJz6KbYRasgRplUr47PtXVX9r6mc77YIBKnS/CnLrgRw35HuVVesX
 Xzgu783uuKcOXrwRc4ufqjbvrzyt0YN+Zz5+X+bq8Px3Hqds3MJZclogyRpcj29LHjM+
 CBLCKKC56D9WNiS7d3/L9kklQ96XAUmZy6K7E7AOFIaXwmWDGNX+TBNNr8oRvZ+dR9m+
 zFnVnkRIEWShG+pUpWAhJRbRVOf3LwlGKFngcJ7Sk1TgJeKrPmCLucywwpsA6R6yZniC
 6DPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790720497; x=1791325297; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
 b=d/trdO7RlVn6TSN4vqXu2MA9LOmhVu3uKPzcDyb9ylALuVyrmEmjaSewkgCsZYp7nk
 a2j9+vtJSWti7OictQ4fUeVC/WZiMPcm0e62kkG5yNfO9i1vjFdHU+1Qzz2V7l6lh+7d
 uNhLe1QxpqjfAu+QZAIxRaG3M5EXbhEupsR6IGrnxE/s6inypE4Nt7xZuGvjo5EtDApF
 Xs5Cu9hHKH2ebh4qdDJNY5k7NFd04cSR05pXfCLgHJhU9nGcetJ3/svoSRlB9yIJCc05
 EFK3zIV9aePXz62hSeil8SUkp+C/2WLmGZQ5EVRlT6D1hm/G40m5OCsC4dvEEoIOSNj+
 1h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720497; x=1791325297;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
 b=FrOHoWO6yqFi42XgKCYtgZP/+J0lJdPXDpJ7lMO7o1m8DATh420+w7MExgvMl26gTV
 gP4VfQaJlkY6aNoyKtdcAiY/yQkeepg//Gwp3O2OIMfInkJONZMCRxSt9TSfGwxzV6ib
 au+HZlCPOoF9vtgjwXZ86bVTE9A2+wnvKXpkbngDkw4FQyCk+hzzBakqEXwX2fm2FMuY
 cLUOAm8PG0OfL7JerlSxy9qZ8dS+vdlTbutjel1j5ykIOPhl8eoOfRMgdeoQ/DXb9RwT
 HR5CiqIzcoZzGrWWsjSXhxsz0oynefQsyLFdAda09NiBmMZ9eqeBaHqDjPBSBQU6rW6h
 4evA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsntJ7U8rePxeMGnMYAu+Hs0LE1Cn/HypS/5KX6ckJ4K33BXjaBGTG+pSpMmUfw07Rwk1zT2gXCEM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJLm8FBZYfZVZYkGUtgnlvhp1avgm2chI44tBr2yyhNUFJFNPh+
 RiuHUKW1Gp1FLW0P1NJ26WfqBY82/MmcGKUwIAOfDSQzMkDNgCO8qd5gOIIvm6l65mJur/0uGXL
 KjH/i3gt6xkTpLflMtkgrpgO52lgj3r8=
X-Gm-Gg: AYBFou1Q9U4Qh5M4DRw4HrgvxBVoxWDlTcQ5T6hlEqghQOaR3CYovta0cehljvMmolz
 vHG+ROzF6KL9d5j/ljXE/0Y5PgARPni2ckdBt6QkmT9qFk+h6yhY8pSGCw8ke4LwW99JFQIdazE
 anG8PCBGBfHcc1STgpyAU1lvpQWsFHFbhjDrpLuA645XGhM4claJBZ0NscSGJgOBztUYq+uzCuF
 Ge7duZb2Fltm7OgseRbeArD12TO5hpoZybzjDevTb0YdDdUVSox6WQLahTktecDeI1g6SbiMl7o
 nPQRw/1zn9lkZeSMIPND3AAA8Zgcsxuo0DOCeYZaxJrNRGgaS+sxt8k=
X-Received: by 2002:a05:6214:3202:b0:914:4bd3:d984 with SMTP id
 6a1803df08f44-91799b4bd9fmr11450236d6.34.1790720497177; Tue, 29 Sep 2026
 15:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
In-Reply-To: <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Tue, 29 Sep 2026 18:21:25 -0400
X-Gm-Features: AclHuK-WotblnMwdXvS53G0qNfl2c2x7OSON_0NQQ-TSXMtSHUSKVbt3lVkA9wE
Message-ID: <CAFZQkGyvxO7Dty4XXJ89FfTTeD5YfirX=16tMW2Mzds7A2_bpQ@mail.gmail.com>
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
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

On Tue, 29 Sept 2026, 15:18 Vidith Madhu, <vmadhu@nvidia.com> wrote:
> My understanding is that flicker may also happen if the refresh rate
> fluctuates significantly within the sinks' range, although I don't know
> how common this is in practice. I would imagine these frame range limits
> would also be useful there to "dampen" the fluctuation.
Judging by our user complaints, it seems to be very common, and I've
been waiting for this API to do exactly that in KWin.

> In any case, if we expect userspace to use the frame range limits for the
> purpose of flicker avoidance, it may make sense to expose a read-only
> connector property for whether the display is susceptible to such
> flickering. For example, NVIDIA G-SYNC monitors are resilient to this and
> it would hinder the user experience to unnecessarily impose such a limit.
Sounds good to me. I think such flicker compensation would need to be
configurable by the end user, but having good defaults (and being able
to simplify display configuration if the driver gives good guarantees)
would be great.

- Xaver
