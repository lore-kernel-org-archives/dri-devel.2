Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071C1CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF5510F33E;
	Thu, 21 May 2026 14:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="fpPt8P12";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E8F10F364
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:41:01 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2bcd730e090so48105665ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374461; cv=none;
 d=google.com; s=arc-20240605;
 b=TxkB73ppbFXi/B/5YKNLWSrpZtrt1obbmmF0L2yfqoxVFinvmJILUPeaaubjgzDRQZ
 K3uERyg7ouMMVamJmsGmBTIxaVJJ1/8p1Ipgrx2e//RrPpqX8zp1jDT57D8G9P3i7LsQ
 kV5D1cMIf+5+GK0HSd45g29Hiqpb2z0b5f6u1B5Ka8x31DMrKvky1+LTPUcGMdNvpti0
 DTtufL3zt55HsqRxeiAfpwQ3y59WuG7vNmLNOp9UirnAHRH8Nuavf0sQ1TbLmJ/dMLWy
 W/QLJ89rLmwBUv3tr+/vfzN+KeROGG19MwItOnAS81o4HiN2VEx9p3ec8G/XLDCHepGL
 U7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 fh=gM5z1FcMduVZGCY0ZQkB4lo3CwX2z/qQsbgFBzWswbs=;
 b=jsa46Bmknz8Cch1wuEJmOUM45Vc0pDqUcVZkQiq0pA2YmcYhlMSpTlgqX87Ep7mYpC
 JruodHrtIs3TQTohn3kMw+cGqZgQ5W6r8F7ImY/JRyJYeg8NewmXumfSDdFU7mGQuFvA
 jfKC3q0szylnIhQ2FNBY0JkDX9bnV4bYAB+6uNDA5y3Bb+dbVaIH82i1tPlsh2Oxqrs3
 pWAV5bxn0KiXK6Gl3woaX+Z+iEmrPs5jd4AoN+bCL+FY8uWXi8Z1+dD5/Fco3fsxhvIW
 Wl9WfjaMA40JnWnTrZ+lsRDMm/PczNSFD7RrQ3bgds0a1O8NUv5AkIt5kT+dn4ZppF6p
 xIMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779374461; x=1779979261;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 b=fpPt8P12fUNdMUXb8E4v259pENQikVsG8rYsQX6klE1idNU7TA3Wk5GZPOs2b7o7zm
 Xnrpaw0VzDMnV4nBB5dDvF/L41ZV8nclP0R6AE4yfyZPy7LhGft291pLTtSy0bVi8Gd0
 9RWc8Oa7nDq25dIPb8aapdWb9Rdvz2fElhEiGiAh+oTQKyChnTHv+Nrk5ZE80VT9WvPl
 J0IoNIjOB/JFLhjSv0rCuarR1wv0Wk1BfmdY+2gGNRcCrHFTiJGyYhbDyIDw8WP0Ocg8
 BlGJxSS79Cc7MXZ7k0NMtOUM13msZFeKwV9q/NCKE2igzXuQNa2shRDjz95xSWZfCE31
 X1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374461; x=1779979261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 b=bcMvDWxlAAwVDeRUUgz1mBo9bh4auGEpUx5Qvl67OW/4+Smd7gQdPSgFWu7h2ZnN1i
 Gha2IRGBpSKm+V+JciVZupOazVE6JS0tQHUPCYcdzaGt2UtQFAKCUD+IQAT6/KnrDsn7
 RDYUczboCmjICgwv8arOu8C3kzkk/I8si3kHcSXJWFXL90hYykF7j+P6u/oPbk5AxWai
 jtqfFF81yhLRXAXFq9FUw7X0hkbgLbWeqTRfGOTYtF7ckdPp95JGsgPuXF7I4slxRvyA
 /St0ck0qQOH0lrAJPBRKJ3+sGsE1/Wei+1ki+q2oqg/9I98Rie49HXZ71R+m0QnbQ2LG
 hqQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+53XnokYGT681fIaMfbnGcrXAp+ADqLsWgjnki8r1/N3GS3xbKEIv58/pxybjGadEgc6TALNyLN5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKsyscle/QW/adOaX5hZycIwHd/WkLMv1E5M4yA3FEfFxJO+Ep
 1fD2VKLbTjyWv6Lw20PpqzJMTpApCC0cjv3NywLFtiGURHtSGclY4208tboKq3Wpj+uPRrVYaqR
 Vh6HqfN2h0vZfPdeCA3DK9U7GaTDa6T+M/pAaSKZLMA==
X-Gm-Gg: Acq92OETysSek6fu6TUsJZ3tLHoK6f7BPz8nVxJCVvH5Z4dQRSp2UmTEU17vN2aB+oj
 nLdstW3FjTcbJtaAB1a/V95ZjWHzgyQXMjxRhk/iOiuH4uOj1YH+qXz+fb065nongOrDvc5j6Jo
 YNfGVWNaE+JI2PIlQHBlCvpaFENS4ioXIbyf8iHF0l68hysNzFYfv8LDz3k75hh/93W3h4n+3Wv
 cDPLuvrosn5GxuoQaCJE/kZvgqCsqTiwKdZuAlsX+s5LqONPPlAt2rQQerYs1tv8Kss4GrrT6Qz
 ArmfIeY+1blidryEyplOgWEOLTDXXMMI4tXYwzwc9fwpIxSpMA==
X-Received: by 2002:a17:903:1b10:b0:2bc:e62a:979b with SMTP id
 d9443c01a7336-2bea33d166emr36661465ad.30.1779374460988; Thu, 21 May 2026
 07:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-20-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-20-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:40:49 +0100
X-Gm-Features: AVHnY4LM5MR-pydhp54-iciGhQnPfxKOlxWC92SZdhfzMOyTtShVga8wCcjC3D0
Message-ID: <CAPj87rOBvjw4v+PER+6+FMuDRajXNnPSKAke8a=tVgiSRg8QTg@mail.gmail.com>
Subject: Re: [PATCH v14 20/28] drm/rockchip: dw_hdmi_qp: Implement "color
 format" DRM property
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
 wayland-devel@lists.freedesktop.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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

Hi,

On Thu, 23 Apr 2026 at 20:06, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> +       bridge = drm_bridge_chain_get_first_bridge(encoder);
> +       if (!bridge)
> +               return 0;
> +
> +       bstate = drm_atomic_get_bridge_state(conn_state->state, bridge);
> +       if (!bstate)
> +               return 0;

IS_ERR() + PTR_ERR()

Cheers,
Daniel
