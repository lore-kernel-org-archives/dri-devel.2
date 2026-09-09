Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5639AC79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A230010E1EA;
	Wed,  9 Sep 2026 17:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pYgHYVYY";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE8410E1EA
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:36:10 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ddd5d0aso1222175e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975368; x=1789580168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5xZwe6BB14FgiUoJeEDcecfAKoT6SnPT8CWcokGDbQ=;
 b=pYgHYVYY2dfe/B1aGHFWYO3Lih0hLkN4BYmv1xPWKQvKAv3cujppK9ztTQEOttMDD4
 Ivoau9NRtrydbOdJ5/OqgTCGeQo1WR7V6jLNCfdH8N3TNGEMC3RZWxLx8IdO8xiuLT0W
 wBVA59uO/dYIVmoqLRdu92JoQfK3YomWS4uJcqX7ZQb5d2BXV1i/JH5dmwNkDT7WaTet
 6tVQvO/6EwoTEp+ifxxIVLKhVDvZkPkm1EUCtrBS5TkP/VEWwdwrzs1gBEgBFTr7qb0r
 t0AnRU3cMTxRFQ0WYs9zEUZw+ZQF0tI4SInF2ikec5qbpLUBkreljBPy45TU7Jq0X5Np
 YKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975368; x=1789580168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5xZwe6BB14FgiUoJeEDcecfAKoT6SnPT8CWcokGDbQ=;
 b=lmj9xkK+f/ttUpjcech9kmjGPNsfwa6DvWO8u/2HQO/8oI5Dan3U6oXsFfDVdi8eoY
 AjTY0l20OHuKa1FVE+Og6s1vWho/0Jd7oZUM1pKXW7aRxPqpc5vT/r0h9M7Y96HrNhMC
 H89IQ16wc094QAZoANjjMjbZLqQdI3+EmrW5IG1mcNSnqdv/6fNlN45qMu+eEgrREcmQ
 LQ9wwOA7RFwX+7SCdKW9AdKrC3Xt9TzBZju2hjRaNQuR61kJjc/d7vrJFjvEFeJZgkSO
 cjiNzBFu0f+KlNiwnHHIGTTn919veSpjObFL6DNlcXARSI4cnssQ+zLlDoDgwyEegtWz
 NY1g==
X-Gm-Message-State: AFuF++lfC1yffqRmDuIbC48Pe6t/0cOUpkOIATG7st3YbsMM6mUjE/tP
 LcDO4414zESYRFZa7gfh9Mwd1iC9IpFFII1MbFGg/Yfa3ljfRZl4VY7EMw3Wo52F
X-Gm-Gg: AYBFou3zQalPgafwHe62SXAoEHsS2ki9bqDGANacLrGrEuB1RvH834zp9kJ0XAKbd9h
 +HvmgT22NEmc8XvCvEwu07IG7vjhTBwDhoQCUfCnSp/uf3c6cxRn4PgSlrI/re5Jrur8TKOHEou
 PJ/jnsERqgppH7CBz5mqgdOCHmi65x8xvl4sgaVowuzRigiv+ofJEKDr91yeKg4HhOhgTRp9DfX
 VP4kRpg401a2dHgz5O2UzqiWm5pOIscv6YXkpV8CxF773sAV0RNVqeRQGlF6PccoB4mugZZnBbb
 xC/X1bBFYcrvac6BlJqPZ7lQv11yNa1ZW4xa3CuvCRjWyQXB/CPOegPFpBvblc821KQYiO3IITX
 8Odsnf+0cZOSgvaBgQZzgqZPDBmq0pdUUFAKK7U2xnAaM6Hkfg3HsijFdDTOgIAylxCf5JcaNHs
 zasNzFFW5YEtEbkq413iKlZGYvQV9H0xI2HNixWPBOUTJW1k2Tt1p3+g9DnM8RFzlRbxm+BcdKg
 dW9xPZXuHlnj/gMXbR1K1iSVs/bG1rlHfcWy9LHN7Sez0i06sp2ZZU/E5HG1DrqMRBPdo+TXg+E
 HA==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-49d01dcc32cmr256409415e9.1.1788975368210; 
 Wed, 09 Sep 2026 10:36:08 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900B0110705BF092680.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:b011:705:bf09:2680])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c06f04sm6876575e9.13.2026.09.09.10.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:36:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH v2 0/3] drm/dp: shared HDR metadata SDP helper,
 and max bpc for dw-dp
Date: Wed,  9 Sep 2026 19:35:37 +0200
Message-ID: <20260909173542.14030-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909163206.36409-1-royalnet026@gmail.com>
References: <20260909163206.36409-1-royalnet026@gmail.com>
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

The three patches of this series never reached the lists. The mistake
is mine: when sending, only the cover letter carried the recipients,
so the patches went to nobody but my own inbox. I noticed while
checking the archive after the fact.

Resent below as replies to this cover, byte-identical to what should
have arrived with it. Sorry for the noise.

Igor
