Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FB3C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C21210F342;
	Thu, 10 Sep 2026 07:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pZcE0QJ/";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2422F10F342
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:52:03 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b0dd3e1d0so2366315e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789026721; x=1789631521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSvkvCa4QalyG2BNxJcMEEX0DpoCO16400N3JfxMgjQ=;
 b=pZcE0QJ/Bfd32reE+IVYJ0CkME3JCB/JSb8N6SS0ZNMqsC8/WJQSMFFzj0GOCWex/J
 Bsdge9YyICVEdtfj3xmR3OetQxHpbcglg4nWUfC9ksHr9wfs0ED0GHbCpLIKTFvIaA94
 MitcYxDS3ZG67tuz+MHPpefjLSXv/JgOKdpXeaElMJLLWhK7pHnGD0UYA5JmLb78GbbM
 1YT9v4aRu98zPYEBp9Ucf/a+AUdYkPN9sYyqkdhEOSJ8mg/pkNAvfuboawIKnhbZ+tj9
 rzMmZfobTWBv2DblpghFW/yU+4ceQCu5a2VZ9GPj4nQPc1ygDkg2kV1TlXPkrHcEgbXP
 LyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789026721; x=1789631521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSvkvCa4QalyG2BNxJcMEEX0DpoCO16400N3JfxMgjQ=;
 b=q9lPoEz+VaOCPKa7juA4UEWwiCLtQ15w3DTl9MZ8OZjCt1jc0PqZdYBSZHQGdPQ1yB
 RS2iQRbmcKlHf/AgM3lClJKu51DlPkHBRMqhYy+JrdCiKQGItwdVHl0ts4yXZu5Bi7rp
 JioQr7ki+RYuuUKZdwNC48wYoOLkQQG5uVJlz5wQBMaGSnqlLLVffmFlqBqFePuymwOI
 9/sPJDoQoPQdU2U1I9YC657MQ2TzZjjp4GY4c9nNb18odwOilRlqWpKNLB152ET3xjj2
 u5b7J94rIdPl9h86iAURnjCjrOUFpPenhX4gF2UZPG8fPzriuQAwzbugtlG6uJCyM3d7
 Snvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTubNtW3CAcnSxsXha8VDti40XVayTlcLZ58yJK3isW+jpTDwJcUhkiY/b0ADVwnBO6tMdaftcBbI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFPfbSGG+SVx3xUXH9af9XBsb7fjuh7lEEgCIEGTnmXq7QIVC2
 S/VkFP9jD1aCeuDQWLLo88cnxScT71exLJ0eeoDduDCYp//Yik0N5Rxk
X-Gm-Gg: AYBFou1bqa0oNeL/Xb2OUc2NOhmUtONvaB9sve+ZuHuxf1Tw5J+PzUDAfiuOG4zRrQE
 uTvo2N9hb9uBeowVoKHihm1kb/AwxBTGN4WMfln3wug8eFU+MTMfNXjLR9Un+/6aojG84s258bt
 nGOg4uMBm5bJ2A3lnuTlDyNk0pZimSjV6P5zLfRh//NsvN8bU7LMYu+gVwDq8A4z0/PyZvzIlyD
 rId+vBzqwpzsxU36IEuwCg0nnBX1s4Hdi+/L2LlOmMs2YHFlhn+S6+V0weUc00aDWmNGGr9vaXg
 LlNZKBAwOj0m4j7EK0NmbGXtAfLcNBFzxNvx3KK/GtvICm0ztPNcJcQTW/aTOt0CyyfNrKpV3MN
 OymKBgh4ENzBF6xEXkfwOZ4vgB+IWjzuJuJ7K9ykJCb7s+cha0S8C3CGWa6rdLwvn6VgJVuZhrl
 eIyLGUr4pPNUa5Bwu99LidlM8aC9RvijBlm9JR4gql4jLSHpup6e2Jm7cuwZgeDSIE/WSTTmndB
 cKeZleORgLK9yncbUx1bBfy3j34hQkw0qQ0SJ8kpT77MXu3Gnv9iHNFlHxIHfdlDv0YwUM26RRL
 GyTy
X-Received: by 2002:a05:600c:530d:b0:49c:e363:c66e with SMTP id
 5b1f17b1804b1-49d01dce86fmr291744635e9.1.1789026720937; 
 Thu, 10 Sep 2026 00:52:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9146001C92980EE71198AB.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:4600:1c92:980e:e711:98ab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm251593715e9.4.2026.09.10.00.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:52:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
Date: Thu, 10 Sep 2026 09:51:40 +0200
Message-ID: <20260910075141.48803-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9e77b5c5-f1d9-484b-ae02-846fae1b3642@rock-chips.com>
References: <9e77b5c5-f1d9-484b-ae02-846fae1b3642@rock-chips.com>
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

Hi Chaoyi,

On 9/10/26 09:16, Chaoyi Chen wrote:
> I don't think this is the correct way to go.
>
> I believe max_bpc should be handled in drm_bridge_connector_init().
> Take a look at its implementation. HDMI already does max_bpc there,
> so DP should probably do something similar.

Agreed - that is the question I left open in my reply to the bot. v3
moves it into drm_bridge_connector_init() and drops this glue patch.

Three points I would rather ask than guess, since it is shared code:

1. How the bridge advertises it. drm_bridge.max_bpc is documented as
   "only relevant if DRM_BRIDGE_OP_HDMI is set" and the helper only
   reads it inside the OP_HDMI block. I intend to honour it on the
   non-HDMI path too, relax that doc sentence, and have dw-dp set
   bridge->max_bpc = 10. If you prefer to keep the field HDMI-only,
   a separate field is easy - I just did not want to add one unasked.

2. The range. HDMI attaches 8..max_bpc. dw-dp's format table goes down
   to 6 bpc RGB and i915 attaches 6..N on its DP connectors, so I intend
   6..max_bpc when connector_type is DisplayPort, 8..max_bpc otherwise -
   the same gate Dmitry used for the DP subconnector property in his
   msm series [1]. Nothing is attached unless a bridge declared
   max_bpc, so existing non-HDMI bridge connectors are unchanged.

3. Where the default lives. 2/3 restores max_requested_bpc from
   connector->max_bpc after drm_mode_config_reset(), but Cristian's
   v11 71/74 removes that field [2] (HDMI keeps it in hdmi.funcs). I
   intend to keep the value in struct drm_bridge_connector and restore
   it from there in drm_bridge_connector_create_state(), which folds
   2/3 into the same patch. 1/3 is unaffected.

The state still has to exist before the property is attached, so the
non-HDMI path gets the same create-state block drmm_connector_hdmi_init()
has. If you would rather see that block factored into a helper for both
callers, say so and I will do that instead.

[1] https://lore.kernel.org/all/20260722-drm-msm-display-interface-v1-24-368c10fe62fd@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260901-dw-hdmi-qp-scramb-v11-71-bc12954a0688@collabora.com/

Thanks,
Igor
