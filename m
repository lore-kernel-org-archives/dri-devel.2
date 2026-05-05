Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86681FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157F510EAC8;
	Tue,  5 May 2026 12:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQCBZUPW";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B944210EAC4
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:51:21 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so1237033f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985480; x=1778590280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYjSXtv2b2p1dWmem9U9G4n20yFMMRsWm/tKYwxj1Zk=;
 b=vQCBZUPWLnXm4ZZx1a6/3Naybcd9kDqhLsVLAZZSATPmfQlk0kLdr5Yde3oq80o18j
 qNXUIWr+Ts8nGyB3uThJTAEA8wTJOOFsWKtTyAEZL+HlLKAqWdxUqREBan9MGyr3zRen
 QQWdyKO2278KJaMxywRNbmxpcxeEIOaNRLUYvw50dAVAbHLRNujQp51/j7oAR2y3SR7n
 iYJ+lbSeyea/ncdVBLRGZxe9REyrY0pz4DtN2CsoK0SqIy2+30Kawtpe30xQzmQMZhsG
 Jh1t91pl5+nG+LQcRiWH77A0B3XP3clW2uCwFGDdDKxLcXZvVEqiSuoUCDMt43a3cgeO
 JXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985480; x=1778590280;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYjSXtv2b2p1dWmem9U9G4n20yFMMRsWm/tKYwxj1Zk=;
 b=GHlZTsy85E4RqzZ4/2iSZAKTqg0LuJMQA46zJqqIVGJVigFgH0EE3jdbaA+uugZqDP
 KC77pywwjTX6oPT+l66Vuv5c7bp9fLbKgB3tvOLBbPDtwqvHeo13R2yCo06WOHGDqYi2
 sdHxu2RDtV3zYfNRoZUj2cWYbC5Xfnp3mtcvluhtk9KV07r2PpW+IWE7XUQFRV7S45+S
 WS74rQiTWMkSZd07P3DhfPqXY1ezHvbfozHBkB7xlA2UV8AGOYEC7xuQQ/BAkJSNWoWM
 0p3sigVDwiwoqHJr0cZ0K6fa/o18Dq1fdJEkfiWYVDNAGxpAMKU3fp4Njad8bYVzzsgZ
 Byfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e07PV3aPTHzDb4XK4kbXKR0/pwCHNgbVzl+etxA50KiLyy75dHKT+XQF/nJ/ktg83TGDCg3cDDDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRrg07i3r1YbGYMxsMeG+zTbMyhaLPR9dDB4ttQmyNw8V8XijL
 y5QK9BfA6V86ermV0cv0gugCk4sALBfvKrIq5dmYfG06lVvCPW45N8yQBZ9CrzNPNfs=
X-Gm-Gg: AeBDies+fYTt2YCzu9CzqBazNtrkQYlE3uNzIJ65B8MK64YbFgP6qV5UK9wudKiwSm3
 qlFP0XrPVBaoiaY2ZC9x1oi5ljNVik8lcvyZqAN7JdK4kbOZ7+IPPaOpEo7awubugQqU2Db+YH3
 9SN1uEL3gG0nI5K8/UbSr2/D67j5NJA1ZmbqGUcTi6UGj4nHAg1PCNqbb8YWtEtX8jjogyov26r
 wwgrsLyV1inz+F714dz7FRtC9Ge72mtQ+tvTkk4MAKmqPqB0MKu/SZ93mj81D0kFSzcxQ0Kvxtl
 J8dcOiVADnWTnIHuOdxJk6+lc+QmEJu7iZgn9l+KI165JCeyTt+yJ5Zi/XaglFwYfdGFgCNkPw7
 /9kDCI8YG0bXwWhxpYBbY1OVbvGglF9/WUrAZZiN8jvpY92fMeIX801kFZkUoOVepAEXPhfpoK9
 vW8hMtkqO30H7KBA/QsnI3zwXbzJOfatRQ4sk+dxzQGffTJZB+i85sL0qcwTJKALYFAQ==
X-Received: by 2002:a5d:5f50:0:b0:449:31ca:5e53 with SMTP id
 ffacd0b85a97d-44fdc4fc60amr6655328f8f.8.1777985479921; 
 Tue, 05 May 2026 05:51:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:51:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after
 sending disable cmds
Message-Id: <177798547910.553197.2210349130446801175.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Sun, 26 Apr 2026 00:57:51 +0800, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2d4e80271f784aa0c7b17676e9762c7e8156be1c

-- 
Neil

