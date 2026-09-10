Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B113C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7723F10F49F;
	Thu, 10 Sep 2026 12:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8xdOdWV";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF9D10F491
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:04:32 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49c5a927a1fso3235385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789041870; x=1789646670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csxrJaNJi4tIfZjrD+uNlOFumjNYljFKlQuyLO7kEBc=;
 b=f8xdOdWVZgS7Q5bXJKCa4wvAY7Owvwr/BPiS2XaBXCffoIVFhXMjxOd+oZ7xdBcNm0
 28lmT18NhmxBPIhj5i3g/pgc1IhLRQtwrVc+d2+lKbA6+OonYBmF5pikam+asq/9iYQ6
 qWa1EMiheNM6Q4ZWZir8MSgbtQkZaWb67d9X7A+Xrqv/8N7apjUJ3Hyqlccd09QxRJTS
 9cteYcxF4QasMRPwZQ3jmauldYGKnvklBdFpP7GztmlVzqJ1Vmtu8fQqlPrZee1yUbad
 gUv7x0HJILARb7NtUzdRfTdpidFKWu/dHXyvLZC1bADP0DKzrb9Tn8Df47DZSeQDaO3H
 IBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041870; x=1789646670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=csxrJaNJi4tIfZjrD+uNlOFumjNYljFKlQuyLO7kEBc=;
 b=hZq+mSVcx2nUQ0ExeT4AryHtM8rneZGRlvor1/iHTVyrruDff8VOpJs5j+K3+0qGF1
 0wO7K3LzgbAfdjMT25GQQZ1VWQh39SuY15ku8Dt51vXcgvnnNYYxTxEgHnrV3Qs8b0j4
 hBmAL6mlgE1o6M0Q6FL6aUhOIGghCdD60tOrobi69FhP9h46oB1qMHNf7MMHvpBPA1yC
 JKuYCAmxJxaTDuodTsLesVgCbrBI34WS6cw/MuRIO7IIZQQuYmEvCwbYzyfB5m7jH/ri
 gnxRG/Txe8rI3d35qUhNgDmEk6HrKmGtFDA3iJgXQmFP0LxlkISx+64bQD6/2nYmwL1k
 aTKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwjdarXjjSDI//24pKkhh5wLEZfOp/xJ5zIQOy/YdNzfS5kKDImsY/IwUS1DcyZnL0KP2d2ayTqQk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6PYdA/P2McTJK6VwJV9TZ4Ecm6l0YdQ5AMmQXbdaUMPRCfC8A
 Ojgk5XlYIShBSU6xqPLb/pl1v80WPDf2ecms6EBR8g5m2tE8Y+MYXWRY
X-Gm-Gg: AYBFou1s4/A67IVgnzgd5JvX5ZeEfPCPLKPAaETOLJ4MHAJoNoBtrB+5UgqlGAaoxK6
 6rntl+0LlWZTdMnywpLWdAkiYv7aRCffRmXEocOvijdh3vyZGyNuIZS5vQVtvyKYUY/oo3432W4
 eQPyT9RIgTyBp9syUFPmiyfsWoGEeLXNGRwzQ8qIM8N4RSdVi1hwDo9MeP9DLgEAbl2qGjvj1mq
 Lr+Rz7YURdMpfw+anOaEjpnfgX/ajfAWXvE+BOBV9JABWkNgkRk8JlcuRDlJllnMUMHFrX7hRgF
 6Gvv1ru94jTNA165CQ2Yek+EGxSCX21YD7ZCL5EEsz1ohLypiD53pX0IziePQvm0TrDR4H4wNLG
 MbPiz4bjRhHTGCS/dvQ7/619PgUQzTZN+Wotl8dx0teO5HlBnLdqnX2b/F44GXJsNRoEnAEBabL
 MGc2RiRWY0i/8qRZU1pl00RlhThj13e2YFKoTtApUkqKdyR9Q9ud4QUJWH2bbA1KlVrIvfqpob4
 LetW2CesNoSgYnl2YRF9kM0dtpwtJlgKh93PWPu5nncphtmiFYwlei/gwqIXjPZbE9zb3BlspIY
 07XN
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49d010c3969mr308061045e9.0.1789041870300; 
 Thu, 10 Sep 2026 05:04:30 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9146001C92980EE71198AB.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:4600:1c92:980e:e711:98ab])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48591eb3d3bsm34529530f8f.0.2026.09.10.05.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:04:29 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Maxime Ripard <mripard@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
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
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
Date: Thu, 10 Sep 2026 14:04:06 +0200
Message-ID: <20260910120409.63850-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <388fd1ef-a8c9-4419-8bf2-10af7063e734@rock-chips.com>
References: <388fd1ef-a8c9-4419-8bf2-10af7063e734@rock-chips.com>
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

On 9/10/26 10:16, Chaoyi Chen wrote:
> Maybe we should consider adding a new "DRM_BRIDGE_OP_DP" :)

Works for me - it keeps the HDMI-only wording of max_bpc and makes the
check explicit. So that Maxime and Cristian have something concrete to
object to, this is all I would give the flag:

 - DRM_BRIDGE_OP_DP: the bridge drives a DisplayPort connector and
   fills in max_bpc. Nothing else is read from it for now.
 - drm_bridge_connector_init() treats it like DRM_BRIDGE_OP_HDMI:
   at most one such bridge in the chain (-EBUSY), max_bpc must be set
   (-EINVAL), and the connector gets "max bpc" with range 6..max_bpc.
 - dw-dp sets the flag and max_bpc = 10.

The connector itself stays a plain drmm_connector_init() one - no DP
counterpart of drmm_connector_hdmi_init() - so bridges without the flag
see no change at all.

> Perhaps @Cristian and @Maxime have better ideas?

That is point 3, and I will wait for it before writing v3: whether the
create-state block gets duplicated into the non-HDMI path or factored
out of drmm_connector_hdmi_init(), and whether keeping the restore value
in struct drm_bridge_connector is acceptable once 71/74 lands.

Thanks,
Igor
