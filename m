Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624DBCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F37B10E3E9;
	Mon, 25 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRGkHE9j";
	dkim-atps=neutral
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927CE10E34A
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 21:33:21 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so22700235e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 14:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779658400; cv=none;
 d=google.com; s=arc-20240605;
 b=RpfOH3s8CWjixn4VjWxGmo5XRyXYBw0d4wG6WVyD7HpLPWKeMzzcBtzteKFb0WJSZb
 jm1b68e/35XfWcgasBflvD+Jpxbb7rcZSg+YI6I0FtahFN+yLPxE6mOIkoHnIlOGuGfv
 CR+6tJi/j8Pj+uj2C+CZ5GfOARepWvHdSuZZ1u0M6X98rGQMGGynY8yAFVuCCl0IFOlu
 aaGEpqyDooglQ0897jaS2Jbn7luEW4Lz4bL74wgecJhHJVfY9ki3dXEzfDoOiqdSrDRB
 ZicxiPPYz6uCdzvU6CiScVYa0gQlOocygS4KPNnyLNmqh0NjaupYp7H9Rxr2+W+g3Mia
 kc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=RfBHHtWh1E5iPfg08hDGPxdg+iSUq3Vo7ZICvTuwHxk=;
 fh=rDltgjhaWmGCx9BMA1PIrNR2540oPvM8yw2Pjefp/ZY=;
 b=MTQ3CDF4tjKjZj0VDfZNWjeOayKx3uw0UZJ5DMzmnLSb/c8ZpRoCL2kjGbXZIoaza8
 X8PHGr/Vv6+2yAGcDLfF3YdNWLWuMux06vLsGGjeAIQFq0iXOYSCsn+piuS40UYL8Vns
 IoFwHnoVYoPyPpQuIrBk5H47B5s/pUUUP26s7gT0By/noO/FNlSjFKONFd61SxNefP/8
 GJq/G7867bArYTeL7pup+t38zD0hgr4fZySWLigeolCeMZRX0U2hPjeADgvyYyVaW+8S
 +wQjMdw7jirX4fMcZaJyZX4JgnFrvfR2s5mx5xglT8XJ6Q0FQsKtTLEHmPGUJLqfEfT2
 SrtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779658400; x=1780263200; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RfBHHtWh1E5iPfg08hDGPxdg+iSUq3Vo7ZICvTuwHxk=;
 b=FRGkHE9jAhuLY7lflKPlQcu98V+coRIiYtVFdgNep5JC9N/ZznUw6FrVr00qPB9klt
 9VxoNF1Y2m0bhaqs0yk3LuQkI01ChzmYiOkiiOsavveRredKXc+RoMAozcYyNkD8KVLs
 chvgxwM0HKqd1qhS8d9xIdZxUbHh1T0sq/9fFlZCv3b6OB4SjH48h5Fbx/KsfrbVsDTg
 T4ouxZ3SYp/hz+X/gaKTKE0ajn5Fse36U/aBkeSGU20SqQMwb8Rtp72mD19TA7Jp7RA/
 3V26W+Wja3fItUJG4UB7LJKT8JnM3jsV1BE9i//1m9AfopopnqMlqu1FHfjSrVnNHNjz
 RdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779658400; x=1780263200;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RfBHHtWh1E5iPfg08hDGPxdg+iSUq3Vo7ZICvTuwHxk=;
 b=OQRD01+XAUE7H74tGDVenVtE7MIxthJSSBmhS4VChOBqA2WxE1fV+6pOHwSfZMrt2h
 8U8iWgS35Olm+7ls9ADHxYinN8lMLHbC7gv7/KzsDSDJsAr5lyUszQZR/mk1QEWuN5LK
 h+/9MRQOZIN3PVja99fAAovHtQowzMvLRxUtG/4SN1LKh/bF4D6951SVd0LKIRzYPvEh
 oTX43cpRNbkktLSx5fm4djN3Pr6oXfwLq7SR9vyYHmo7nbWXIJPbZhWA2fLiQJIxT0jx
 0U9Xm3Q3QWVigbw5Pz8SRCo2EhsugdXJzZlYxu+DLv4DL6Z82Uiy6mCGrqw4suXxrw2F
 gziw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E5Fv3H6POYHKhgqw6lYIiC0ZDVDXK5fiHltr+OPwjwXCPoK+JfCnpPa1u5ptzBgE8h5u/PqoocZ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrFxc6+A/D4aJdoEGMBXO54XUIjGPRsqPtvZY/kNDOHw4nzOWX
 9FiHHnQZ+xniOEDwmG7vfh2X6j8pfXOst4zsv3X0yTreiYE+rCjCtMXHPQYZfWY07Q6u1rQ72k2
 JG2youTv+yXEJPGF8gADGfq+apCWUwZk=
X-Gm-Gg: Acq92OFDa5Ab8Luzfcz4dT2Ocg2RQdPNc+PXNSbrIyHR3HmBUr80Kaf1gs6HBjCgITD
 EgK0kvYFWQzU1q4zv63/d1XcxgfI5vcNQYltZhes6TzrOxFMVKcxGASfK/8/UcgSna6xfnmtRS6
 UuGr6BrY+wLuL8VXJ5PLHbqn84rh7bIwWJ2tPf92VUXrRv09m9oDTJZ8ox9d6BZnF0UDIZn/RSy
 foQp/z1x4Xxp0fPe6DfnE8B4ta7QmoOuWGtGeDwhsD4DDZC/++D+K8FHsa7ZYWryFDCLBMzhJSK
 Mj7k4FXXNepkK+NDj7Ds6h1Gk2JFu90WGd80vJVkkTsbBJ4gflXz
X-Received: by 2002:a05:600c:19cb:b0:490:507c:bdb1 with SMTP id
 5b1f17b1804b1-490507cbed4mr133267705e9.15.1779658399829; Sun, 24 May 2026
 14:33:19 -0700 (PDT)
MIME-Version: 1.0
From: Misty Robinson <11111577m@gmail.com>
Date: Sun, 24 May 2026 17:33:09 -0400
X-Gm-Features: AVHnY4LYUQ0Tyb2yqL4DCU3LkzUo1pVpr98xcI4oG9pyvGMAS9XPi4QkbHlPExg
Message-ID: <CAFufjN0cNAx9=xfNOTVZzm9wi8TjWGCRd0Bu_7P_QQUHj_BYNw@mail.gmail.com>
Subject: Re: [PATCH v5 05/19] drm/mode-config: Document drm_private_obj
 exclusion from drm_mode_config_reset()
To: mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, alex.hung@amd.com, 
 andrzej.hajda@intel.com, contact@emersion.fr, corbet@lwn.net, 
 daniels@collabora.com, dave.stevenson@raspberrypi.com, 
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, jani.nikula@linux.intel.com, 
 jernej.skrabec@gmail.com, jonas@kwiboo.se, joonas.lahtinen@linux.intel.com, 
 jyri.sarha@iki.fi, kernel-list@raspberrypi.com, 
 laurent.pinchart+renesas@ideasonboard.com, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 maarten.lankhorst@linux.intel.com, mcanal@igalia.com, mwen@igalia.com, 
 neil.armstrong@linaro.org, rfoss@kernel.org, rodrigo.vivi@intel.com, 
 samuel@sholland.org, sebastian.wick@redhat.com, simona@ffwll.ch, 
 skhan@linuxfoundation.org, tomi.valkeinen@ideasonboard.com, 
 tursulin@ursulin.net, tzimmermann@suse.de, wens@kernel.org
Content-Type: multipart/alternative; boundary="000000000000be51920652970205"
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

--000000000000be51920652970205
Content-Type: text/plain; charset="UTF-8"



--000000000000be51920652970205
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000be51920652970205--
