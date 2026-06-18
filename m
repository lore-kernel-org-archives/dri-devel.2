Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B653CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 02:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA26410E77B;
	Thu, 18 Jun 2026 02:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BK+PS6Zo";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABA810E77B
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 02:33:46 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8423f236418so157810b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781750026; x=1782354826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIlS5jhtZMjuo8gglp6tVBsS03VnKU3kEreZFvvVOkg=;
 b=BK+PS6ZoRsN8ua/Iz2KoY7MR4IC/iddMf1cWUlwXjev5X/pQAJKD8TMdYpCvU8LdVx
 U4RylPTHI+B+oC3u3bX46UWVeMHdXwTyF/VZfQtEy96zaD1YRNFIOnYx6/Y3eQnN4AkU
 qAw9GLRJ/Pls++joMAJewxAEqvhHHVqDoepfG2fEHyvN9DITs+80j17PV60CNfxxWSfL
 YW05vR7ibKyLIbKoUDvxgVOiO70lt4Jzn7R0vMutJzTKDxoFMOQKfoAl1LeC9KLBT9F5
 d+7en1zexGvi7yddnrnPvQ3REw4HEMVdFREURNTvv6uJuHUtHW2WzU66tQm1adh6GVBc
 TciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781750026; x=1782354826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iIlS5jhtZMjuo8gglp6tVBsS03VnKU3kEreZFvvVOkg=;
 b=MqF8wrKdFeXX08A9riumOHtenwXmFilSTGipN8KVHi5DOK9xn3Bm+WRrwXSGDtiJNw
 A3QQkt0pRTh54E7HlXSxyLf6EGNel0uiMMG0p/GDqDmTW80PkqJFY/5ZmHnfJeSHbyTy
 qfboO/ut8vgav+I+ltBRV7mKNigsuhxT58R9xR41lthhEP4Xfvw0kyX/APakV8BSLE8q
 8GOoQ744LhoKOMi/eSxam9+cr2VBHAW+pbUVOXU89lKBgVG6PLYMr8H8JISXZvJJAHzM
 bN0sUBxKzkfcm8nANfPYKcf8mxhLs29UyUZ1NY6OXHrFLQna4XzAo25Pm6uNkW0JAl6l
 P+AQ==
X-Gm-Message-State: AOJu0YxIj/c2F4AVH7ee131513N8/+LwXv6E4hGFg4W+N5i0xGkw4IUk
 vGCx8afuGx0Q4xks3RxEdNgDzWsdTEwmZe6dGZFa6tZ4oVi5YkNIl/jb
X-Gm-Gg: Acq92OH3zY6Xr6+azK9ZdLPxQxA311yQROl29woV3wYexStqsG8esHHsqP1+vpm8+6l
 SaGpYNYPbSi2HnOnp0TRQBrEG8JKg0tOppKkMG3V87XfjOxS0OP1+1/84Hshdj9pwbK1vHPy58P
 nDcUMkRySUoOIXRoJZu5Sjs8O6wjPINM9x0S7kqRKz7mP4rXdF0CPpjoQ66AEr2xsi9xh2GsW7F
 qFhKNJAx1uoVHWYWoIsJv8Ym4WgJUd7UrtuyejURJ9fj9RFGB4xMMnNWRC5qqOfMA3Dlx2TKSBz
 mVCQDK7swuX+7bccYysGxcenqsyMkLmkGDYFNZSCo7htniuG6MJ5le94u3ur3SS09GhOdgvlTEC
 wwWhVjEISfL/rn0Wu4rkdKHN2s9VCvfoDIEsGyGzNiGAHmxDH0CQa8Ig1Iure4fS3kD0gRbBeqq
 L5tZYaBQRA+qFni+Qjl4YgkRwyK28PH4uB0LG9riaREbdY3FFqd7upfavq4KwxgfT1vyBvAFsOX
 LuoZLyZsYZFJdKEBrZlE5ll
X-Received: by 2002:a05:6a00:2d96:b0:837:80a:5abe with SMTP id
 d2e1a72fcca58-84524595b14mr6044974b3a.37.1781750025763; 
 Wed, 17 Jun 2026 19:33:45 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845353d096dsm1722242b3a.59.2026.06.17.19.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 19:33:44 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Thu, 18 Jun 2026 10:33:38 +0800
Message-Id: <20260618023338.26630-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9fb7915b-dc46-45af-bba1-a3d3a59b5e49@suse.de>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <9fb7915b-dc46-45af-bba1-a3d3a59b5e49@suse.de>
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

Hi Thomas,

Thanks for the review, and no worries about the timing.

Before I spin a v4 for these comments, I'd like to confirm the overall
direction, since it affects whether this should remain a standalone driver
at all.

In parallel, Devarsh Thakkar is adding a generic Solomon SSD16xx e-paper
driver (panel-ssd16xx.c, currently v1 in review). The PIXPAPER 4.26 uses an
SSD1677, which is part of that family; Devarsh has said he will add SSD1677
support in the next revision (v2) of his series, after which this panel
could be supported there as a panel entry rather than as a separate driver.
That work isn't posted yet, but I had agreed that consolidating under
panel-ssd16xx.c is the better long-term direction.

I'd appreciate your guidance on how to proceed -- whether it is better to
keep iterating on this standalone driver, or to hold it and add the
PIXPAPER 4.26 panel to panel-ssd16xx.c once that driver supports SSD1677.
I'm happy to go whichever way you prefer.

Regards,
LiangCheng
