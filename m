Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BdQUFQsL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A9110FCCE;
	Wed, 21 Oct 2026 08:53:01 +0000 (UTC)
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3092910ED68
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:10:05 +0000 (UTC)
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-3a476ee8669so900171a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792501805; x=1793106605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rli4VgxJjcOffz1T4VqacG0mFNteJvCejK8yAgJ1Be4=;
 b=BdQUFQsLi9LqtF0Qi4Vm3pgi0M8Ujt1LBg1y2kpprj7xrBQYm2ZykI3jnQkXV3IeBM
 ykz1B17YGWRajx3rTX0Rf79R29+1q9b8xaLmlHqoL4oWd2Ot4PxJ0ShLdbm+2Vg2NvJH
 NqXUqyirqFcxGjbeBuJEvG1xfQlkn4I2LtsfM+EO+dBrC9GsmP6zcsnkhFXw9Mt2O1ME
 iHRetdp8d/E74ra1heZD7lP4i0rbW/1ndFsQgf8EFXIIZ6FKQewW/GDPZEOzm83JykdA
 mGIjft9E29KDwvHzagEigA0JXGN0ZrzuTfdYZeqTop9/aML39EmHduT4U34OXSmYEUwt
 O56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501805; x=1793106605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rli4VgxJjcOffz1T4VqacG0mFNteJvCejK8yAgJ1Be4=;
 b=lCQ9THZl9nAMjYSOo4H32gVQavYMUHDaJ2ha+RGW8NwY0TvlPy+AbONE1WB9E0KwvC
 RnzWh8l4ns2X2CSc9Y4HoZj9YcwgLNXoSRyXTkVxq9UkPGij3khpJHVOk6moY5MCiIYB
 3VNIQGkEikR1eA45NsOemdpF3FQFpOnSTabtzk26xMKxTEkanbH4zfOE5IB+xQmJiRCE
 APzEl5exINzqIT8Ot9CZzr+YFNqVq1Sdz7t3T7DyrzS8tJ9tM12cvYk6eU0y5m5e81CW
 BBB0nUQS9IHgmzDBIOZH1mM/fDFC/AFpabf8ygDBRw7moChY6cfiJoL6I9iorna+2JmN
 VDsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHqQ3KaxsThU9R5fHFRGeehOxjJs5MBXGpXjHEgES5L+waRUCprDrcyF+Yak+CDsfaCmZsr7rwN3k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2F4SsHmU00P4YE6c3pEVMVBaqhHiXqu23A+UMDBWqc9IB+1i1
 9ryyUXVIoyD1K02L76iFwgqjF9pldjLhEkbZnkE0Y9GnYh25CMAnFnKr
X-Gm-Gg: AYBFou2qNYfv6ROzvN7TeYqE4CkuLJR7o9gc6lxnKoLtxvXbtV4NawIV59kAg/1su3i
 y1Vb2wEr0jVRRErbADMCOVrAuiw2lu9TcnGD7T8oMfTSI2fLp0ZAe/r0H28guWy1+g7a+3htglx
 YhWWZevruFbefXW4i/umO7yHX/9kIDHQkqDpztE1H/y9B/Abv2cGIpPcjCAmmUbS00/GhJXLgAb
 FgoyNpVKVSGJYi5SGTO9NuCiqcikku+rdbxTI6cCjkbkLkA9cgrmkhsZW4+O1oQyoSaTzZKbO03
 Z3cEnjvawp32YTR+nCdi7iA6rWCIs8TKbrn8yx3n6LKXJbyVaTPZGWjYU9G5ZmCZm/GbjcYs/F8
 J2ylOdn4ZhnIYkpLxpe537Qh33xgc2dxzM2HVc6HnRc0m6ftVqpR4PJGsRb805srILDuWxsg6aw
 wd1HM+ovayxHf88EbE7Nzw2BOKTrabTl9Fw2N3EhIeBQ5ahW/cieUpkR4=
X-Received: by 2002:a17:90a:d010:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3acef134b64mr9027170a91.20.1792501804482; 
 Tue, 20 Oct 2026 06:10:04 -0700 (PDT)
Received: from Linux-PC ([2a09:bac1:1980:20::1d3:a8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd3cc73c7sm10131496a91.4.2026.10.20.06.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:10:03 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH v3 0/3] drm/panel: Add Smartisan TD4362 panel support
Date: Tue, 20 Oct 2026 21:09:31 +0800
Message-ID: <20261020130934.2289011-1-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017083531.766557-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lu Chen <tianshi12127@gmail.com>

This series adds support for the Smartisan TD4362, a 1080x2242
command mode DSI panel found in the Smartisan R1 (trident)
smartphone.

The initialization and power sequences were converted from the
downstream device tree with linux-mdss-dsi-panel-driver-generator,
and the driver was tested on a Smartisan R1 (trident).

Patch 1 adds the "smartisan" vendor prefix, patch 2 documents the
panel binding, and patch 3 adds the DRM panel driver itself.

Changes in v2:
- rename lab-supply/ibb-supply to vsp-supply/vsn-supply (per review)

Changes in v3:
- drop <linux/mod_devicetable.h>, drm_mipi_dsi.h already provides
  of_device_id (per Uwe)
- carry review tags from Krzysztof and Conor

Lu Chen (3):
  dt-bindings: vendor-prefixes: add smartisan
  dt-bindings: display: panel: add Smartisan TD4362
  drm/panel: add driver for Smartisan TD4362

 .../display/panel/smartisan,td4362.yaml       |  75 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-smartisan-td4362.c    | 262 ++++++++++++++++++
 5 files changed, 353 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-smartisan-td4362.c

-- 
2.56.0

