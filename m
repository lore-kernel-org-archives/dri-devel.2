Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48397606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GaHdL+TA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4F2112959;
	Fri, 27 Nov 2026 09:56:19 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994F3112945
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:59 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so67671835e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795773358; x=1796378158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4DMcsVBCyuxSJxnBHMXvc5HVYKbb1XH0m0g8E3RsK/8=;
 b=GaHdL+TAnLDoDw+BHGmYc/wAG6i+01pajrf9/B6I2c5dDeF0yiHZsEolExpFysVi0d
 QQ4QhUtzK99c1KFQYeMNEmp358N4LQB3vSxRN8VSA/HNPEi9O8HwvUY9CnKuKnlJ47oQ
 DXtvZN00e7DM/+2c3yc00DNfInKxWQGo7KO+Bz3xycdoYD0m886c5RA4KcbJbDQkRZaI
 N2ObOY4XeDiGE407uIne7QHJRfeCG1UCjPK2P+U4OeP4H6WMntTlScuQPsBRUqEgiD6H
 RpI3VhPVrBOD/M+HDTRoOpvcXXFH8FGlbMtZztUtg8C5QIzFFDvS7XCaKET2RCPHaLI3
 jyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773358; x=1796378158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4DMcsVBCyuxSJxnBHMXvc5HVYKbb1XH0m0g8E3RsK/8=;
 b=CLJTyqCa4CFa9Q+r8MK3QlYF3oDY3NOOmqj8iVnFXQUZZnAwm/yNVdx88ipMQNv93g
 9rxXLU6xb3aKdFQi1zhE5LvcOvcE5mNT8VbQDYOa26xwyazwo16WM80wWt5vpfTfuDNv
 Nc3GghwcUloV3geUCByt6Ncs85TlVQw1jDpXndRwpJbgW1J3+xJJMzBh13jxORPMjyOg
 6c+xGZkPUD4BQit2eZLwHhsc7iZMsAZb/N/nkbTvGBd1Cm97+3euxzEXpligOYXBKQmU
 uiaDtH/Hh7YvBSuHlF86khbMuq5LB54upZURlcvWRF8JilPTDivFGZzX3q2JeWlG+aYV
 tJRg==
X-Forwarded-Encrypted: i=1;
 AL+hErEg15gpGfOikGa5lbw1rO9yWZ0pgugTASUS6g0CAwqHx+/YxRaW0FqeBjXKDt92con+Fl+MKIQJiH4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8rrt0mu3408ThXlxDA9EK9D1PnvshPFOmMhRBVGSBrZ/pIsbi0
 oCWb74KBS/6UK06KLrq2xmotYVcPjQjIOKIt0mLSfnH5CQmkdZLH5Ebr
X-Gm-Gg: AZFdTZdaScc6IIwoN5gzZ6e8x2AKC7aRHnO2BguBECyDiStYS2BuoaNLdpTz60zP9dV
 HN1VYBvDVxuiteIvyPNfHuPcYuQsAxL3gFGnU5eUr/3glMEsHoMVI2pw/XELs0vXPi6/6ruTsC0
 kkioys3+5mfgQhCz7y/ACfbQoSLQPj4DKVkuR/VBMaONXR9yCrOD4dzjuFhtmUv/tFwMnbnwgrg
 1IVRUSduCMekXraej6hVcePdUToOaoMwH4rA7gmnB1QI1VL26CnIeaosRrGgqSOJXGXTvFN7RFU
 Mf2sycv0chszRu+Nn7BldN53F9vQcxv6ECzZf5Wn6unTLAM4lcvt2q28ZsurqPwtK/uVFSu3BsV
 b5VDCsb44jnMSkrGbmnndVzHfvofRHf5NnKwmfBLSchJxvQOnDEtXTqg5rnzzZU9hFUIPxGboyw
 wC08pHPHdodzvjKLchegO5SJp/Z0i6z5/rj3Rx11kI/zXlmIZ+KHJ68mgKHiKM9kGdU6jt6v24M
 mFZp0RDNzGc/rkjYaO/ktlHH5uE0i1e7clKa/NWcfo9VHZDb+fZr7xfSYUVdD1a3OvxNttSkNGw
 Y70cZd+CKcPMDQSnPEwxk5jMUtzUGxsfBgtqVw2c91UVcdaIfDQmgUSweMnNfvphtWol4v5XKb5
 vq701VSdOxHqbeAGfezTWliGwC+CXHC2gw6C878ZnKOif0Q==
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id
 5b1f17b1804b1-4bb8880ad4amr455477665e9.7.1795773357686; 
 Fri, 27 Nov 2026 01:55:57 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a1e8bsm560192195e9.9.2026.11.27.01.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:55:57 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Liu Ying <victor.liu@nxp.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi: let the glue compute the
 hcomponent lbcc
Date: Fri, 27 Nov 2026 10:55:56 +0100
Message-ID: <20261127095556.1794628-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101143031.880389-1-romain.tisserand@gmail.com>
References: <20261101143031.880389-1-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this one, sent four weeks ago. It still applies as is on
today's drm-misc-next.

It fixes the garbled picture of non-burst DSI panels behind the Rockchip
glue (GPD XD here), and v2 follows the reviews of v1 (Chaoyi, Sashiko).
Is the get_hcomponent_lbcc() callback in dw_mipi_dsi_plat_data the shape
you want, or should I rework it?

Icenowy, Cc'ing you as you are working on dw-mipi-dsi for TH1520; the
two series touch different parts of the file.

Thanks,
Romain
