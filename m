Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277C9EF4EA4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F3F10E1E0;
	Mon,  6 Apr 2026 07:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iBj4qyg0";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9953810E012
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 07:39:53 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so16370375e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775461192; x=1776065992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PV5yIQv/6bTdgVUZVXXsO9kP+vu/b8exNKt22mhgJ3E=;
 b=iBj4qyg07vXTHX6LnUBu7VH2KjWaab6qKNqqNKKjKsXWeisvneNyBKFdGi7Qp2x4RJ
 ys/KRxH/+yQRCHfwrviwwP+jNLVlm9IjlVxOpYF6OISz/jcwMBreBuilsiFUiIja3zv+
 nXX0LAQEP4VFGl+yb+fLyIJBhHVK6hryASSt63d0b6uC6qCIchh8bII53WQB2rAXSyJJ
 QXHoxRCqUKyx4D51Xc29j934a2YUnlJ6slt/rwAHUyeza2TKmNgbKyFmbUe9Z8zVhteQ
 H42LdJaCA4kPP50qo6O1FH0iiVJat/weDDBqqRnMWvhyrXhJU+OVsySs46nNwCqpnbcf
 jk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775461192; x=1776065992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV5yIQv/6bTdgVUZVXXsO9kP+vu/b8exNKt22mhgJ3E=;
 b=F/E9f2811t+uLzVvg9wmikyOb571a+i1LB3dlhe7FVW0z4HESdVtFEBbJgZBbGNziJ
 3VS09nQLtbb6aW4M3T0OY13G+TaEYttubKLKm8sOjG7hP4Aocv3HHPozzKPTZwO+bq39
 MgHjhpqzIZV54r9TUIpXD60diRhNotZyk+DpZxDn3zap41pnL/jRtDcbzw8Q3WqMy5YR
 QAIyvkpNWDrkk4MYdbxL4lU15i82yDsQ84ed4mjCpYrTvrpbwLRtHdmttkdDuhKwIYYY
 SvdiUgmoCiF+k9wO4LZS+TmXdnQPD8ze/9eD3IQuDEAe5ai7xAE+7IT0PthkDdsWoaKr
 x4eA==
X-Gm-Message-State: AOJu0YwYgb+aibN0PRl469VekpaEBgz53DvS7oTttH0mWTJYKhyagio8
 5FcY3T0CNmQhxSSoqIKWRQBW7sByuvufSdZoipVUZ5ZCn6kPGc/q0n2+
X-Gm-Gg: AeBDiesona9qOA/JTrAVSEr95As9SVuY/MsyNZTQO2vl/jX/a0T8e6FYpq1kf//T3Wd
 7yQdJEHkb7Ao4ac8RPxAM77vw4SRvwjxCv7+1NEXqXPILtW1I5GSC4V1oMXK2noxXcWH5aZaCnC
 /nwWcSgj5+YFGiTIzvoH8/Wjha+Sh/DzbzFeAvSJimdRSqELMXtwLmpNt0/yXnustGbeln9H6WV
 lI/l02+aNY4xm+Lq/5VvH7KnGElk2XkDgWIU2pNaHjBWm3FcDhl2rB+nC4drOHgUHie72ep6tec
 yjjScRVY6Cw8h6OJU6bcwiTfHynCLsjIbDllr7R1jA+obLiq336/oxYKmCf8fVjicrlo+UkFVUN
 TS3UwiV85stFQI3qMzaoIqivKZ24RSnG5uD3HhCez9AlajVY7iS9/jvmSYG2VHzdkvRUO7wVp1y
 2qCPUJnz0VohpW
X-Received: by 2002:a05:600c:3f0a:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488996a206dmr185178835e9.1.1775461191593; 
 Mon, 06 Apr 2026 00:39:51 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83e906sm527201325e9.8.2026.04.06.00.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 00:39:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3 RESEND] drm: bridge: add support for Triple 10-BIT
Date: Mon,  6 Apr 2026 10:39:26 +0300
Message-ID: <20260406073930.24662-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
P1801-T.

Link to v3: https://lore.kernel.org/lkml/20250824092728.105643-1-clamor95@gmail.com/

---
Changes on switching from v3 to v4:
- rebased on top of v7.0

Changes on switching from v2 to v3:
- place mstar,tsumu88adt3-lf-1 alphabetically
- fix typos

Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
---

David Heidelberg (1):
  dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS
    Transmitter

Maxim Schwalm (1):
  drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Svyatoslav Ryhel (1):
  dt-bindigs: display: extend the simple bridge with MStar
    TSUMU88ADT3-LF-1 bridge

 .../devicetree/bindings/display/bridge/lvds-codec.yaml       | 1 +
 .../devicetree/bindings/display/bridge/simple-bridge.yaml    | 1 +
 drivers/gpu/drm/bridge/simple-bridge.c                       | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.51.0

