Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E788C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8A10E211;
	Thu, 10 Sep 2026 16:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IJ+jT0II";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA1A10E211
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:26:21 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b93204449so12285e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789057580; x=1789662380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0smL/d6QKu04fRHQtGBAAZuzGVVYkDUilTOApT5q0GE=;
 b=IJ+jT0IIm5MG4z3fXPHqdEmGJDOEu1FI+liI/76TMCnjNbk58WPiLGrrEtk6U57EYY
 JVFLtBLKzB3MbCCzO30TqHVpcvhkgalfx/hqT3DIh6SyitQQUlmuW9jOdi58Da3WSOcN
 +oyi8tvohRxlLp1rVUfrrxBzl+nZXUPxyG6MvwbSB4bqy1URHuoWgZs4LOc+jxtBzRtH
 Z0fcIRqEcioQiaL0UopmEz6Q//gbom8exyDKjq7G7Adh5WovXH6V7Y5yWx23Y4EGp1st
 jNxv/1s2qriUNzr+Dl81DcxjnWHlVryvR9R4f5F1KcR/IXTeHxKeW/bxaYQBRvBZ1OhC
 tXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789057580; x=1789662380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0smL/d6QKu04fRHQtGBAAZuzGVVYkDUilTOApT5q0GE=;
 b=X9dKRL8h6xVRGxHOEStUNU+mYbQzfg2xN//cRboFxZzOZhc4j7dUTqTlSv0CvR9dtQ
 KjoS+5Ih4bT0AtzwSqdORWayeAqwqolMViKjW9+/sXD6IQIXrsZagebn00v+1CaK3d1D
 z0QPQWhioWXLAKn6w0f9aJMVxo6VPGIq3HGK3twuGL4WBqyJvrgbzVteAXZFea7ke/sV
 fhnTqj8nX+12acGcrZHifnKVGiJLd7L5gsFRBtkVcLA2iws1uWG/YFlnjLJRrqqASJst
 PxyTdv4p5ym2+UnoLuBKkoD9yoYZd39sYCjODxPAQyM/hVchYMtCM9k7Htrmjv3zOg+I
 PqIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiEjTQEwJ1ISciBev8AkphmCvej3TZmuS/LvDwVfTDYKtXhBgMYkkfeF4QkBhxouPcc56KGQA3oQg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkd2bfasntfSfN0LpzwgvhAYe9tk7ESLJlOVGGQOoWmSS2A8I9
 qSopd6XyP3KRl82XMPmmZeMi2lvtvX+7ER7BNUSSXAWmn9jhbLyiC5zJ
X-Gm-Gg: AYBFou3NU6mKxGK0uY9cCQinAsnSi6OS5HDooJtuXwItgGzwNFyJetQpt4/1euRFRyo
 VEVLo8klJmbT/QFiPIa35lZ+PQs4WPzkKVPkhN8rQYjWp3vN2fq4jR8oIbcMNV5EfhbOmhn64fO
 XDUyOpHOdCAo7N7tbMmoan/j7nlEbEYcNyAZdVkza+2dxRD8MgYbCyB1+OG4NaltGCSJUJH7slQ
 1CsnOYLQljXuhRqFKF8BqRj7KAUKggUS1Q8BUWakdE0vDT44aZezZWIR6WffxZ+8VlstOMHh6N/
 1J+Abg5ajNs/q20r7wVALxM8iLfz5feJQbXt7lVaTarpo4dX2GI1LjFIE8i+Xo3OKDKIxopawoK
 uuNW/sp2gmBAbSVMeuUF/so5TEydGVZx1XLJ69aEDpEu08q7NTotg8QcgJkdxCK7e0Mjv5B3JRE
 Bcxb+kSUZMxmYG9RCTL8IxPyI7sn4QxdVFvxjPTEXubivwluVq6eHLM9euxIFR28TOBdMm24RtY
 k0SRp5XuTVGiHGxPtT8E8uDCcG2fOgrBW1idczEycZv2awejddH4+xytFt2uoRQciwqyylv1Pv1
 bJgR
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49d010c3969mr322629105e9.0.1789057579609; 
 Thu, 10 Sep 2026 09:26:19 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B91460038D48F9767ABDC4A.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:4600:38d4:8f97:67ab:dc4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm7275965e9.0.2026.09.10.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 09:26:19 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] drm/connector: Cache out-of-band hotplug events
Date: Thu, 10 Sep 2026 18:25:52 +0200
Message-ID: <20260910162553.6262-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
References: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
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

Hi Sebastian,

On 8/21/26 16:55, Sebastian Reichel wrote:
> When the USB-C state machine finished negotiating DP AltMode before the
> DRM device has been probed, the out-of-band hotplug events fired to
> early and are lost. Without replugging the display or reloading the
> USB-C driver, the DRM driver assumes nothing is plugged.

This is the boot race I reported in [1], and the patch fixes it here.

Orange Pi 5 Plus (RK3588), a Samsung monitor on USB-C DisplayPort Alt
Mode behind fusb302, on drm-misc-next plus the dw-dp and Rockchip USBDP
PHY series.  The same tree also carries my pending vop2 AXI clock patch
and the pending dw-hdmi-qp audio guard; without those two the board
does not survive the boot for reasons unrelated to this patch.

Without the patch (one boot on that tree, two more on my daily kernel)
the DP connector reads "disconnected" from the moment dw-dp binds until
a boot-time service of mine unbinds and rebinds fusb302 some 45-70 s
later; only then does the link come up.

With the patch the display comes up on its own: the same service,
running 40 s after dw-dp bound, finds the connector already "connected"
and does nothing.  No warnings over the session.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus, USB-C DP Alt Mode

[1] https://lore.kernel.org/all/20260811211534.8618-1-royalnet026@gmail.com/

Thanks,
Igor
