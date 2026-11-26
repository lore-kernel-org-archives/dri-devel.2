Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E645606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pT35UGj2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145E61120E6;
	Thu, 26 Nov 2026 08:09:06 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C01510E008
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:59:02 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1b589050416so999154c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795672741; x=1796277541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ENOEvWpXS/hO0xFIEmj5YuEGPhTN4rxHq1cUYnvsQg=;
 b=pT35UGj2QgEKj7GO+2riuhx3s9gd1Y19emSe7SBYMsFWytgCljbYjlfwEv0tl/iRzi
 GNBstIHi8vS0wd7cFgUn5I4sMDRJQIGNa19f3EqoONAgceHiPphkWD8fN2BgH3CO3jrB
 AyeMTnGegbIRY5VYjf/dP7P3G0kSq9loawAhjodFOuLh8xdVQgCSzgOH6LCo2RqBO/1M
 PFKRhxBB/c6geGrDdyoCB0/wICsNtsLRSxrPsqDtGR/1TmUyfinjSkqIBi7Kuw3fnw5Z
 1DD7QjUL17e3Nw06VbhmqlThDOaFJlDST1NdpUp0RtD0FnwckBaUbDSf17JyldWl7MzZ
 wIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795672741; x=1796277541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ENOEvWpXS/hO0xFIEmj5YuEGPhTN4rxHq1cUYnvsQg=;
 b=ENT7RhsyMpEQY/xLgZIWCB6yDVn6mmEyJnsEdh9WKrBiiUfYNLozNWck8Mi6CaTN89
 d+5MWjxhqHZAOnwwnPW/o6/4qu1gU4k6e/VzByjpfhh/Fe0C8KEg/WKi39zDZj3JA9pf
 qQ7flWTrwNmL/hgva5QhPyRnHgjsyZSbl43/PV8pRI4xkdN6gHMqzwt7yGqa0FH8dd3z
 jgp/17d+TFoJop9gwIYPawwrOq9z5lpNmocvDquj6BvMi2MuW1VI3hx/rsXkin35D1pl
 Wvm+5h1oNtLAoK6qu48mHVkP5vIsprBnVSCeTdEzQXNqTViz/a16I8YSQT8K+vS3aAUm
 5iZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFy41Ro9PJEl7Uccti8S0LP3DhqhIr/1f38rMb/Lt0UurZWObltKLS65Q5s7DH0Ouwv9b4eLpHubJQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cig8xViWCuLRsvt8mw5Z9Ce+WKRAGFvVuGHuhGLE8nRYec2TX
 1EzlthcX/9TEa+jccotqTEl3ewJ2unB1JcOzH1Gw9P0ao8smPR72YvI=
X-Gm-Gg: AZFdTZfqPPEXfoO3BuFgiCu931y4OPJ8496Z2MP9PhSIzlrUsKVXGryeMyfWOIURvlb
 FY1Rvo8KxNhuE8JVKsDNVySLf/Llor6vEwl2pqhGKkdNdlEYsJ3wvlDohGjHQYPnhPX14JPh/k3
 GHienEoOOgOjR31K9enX99VAg7jPn+GH6W9kA1fwjKk+bhWKqQ9mgYnGI0qPFPI/rzbkbiB1CoW
 pCX5fXwMzPZWa5C/wILgMEel4y0JYIQOZAgjZrHKQIHgUvUgoo0An5+e2nZQeU8ASQRqxClqWpe
 wAVB4MUKrxeXDh3dInmGpQ9PjEcbN4utt2JCfU4EDbUcbJ4cenP7DHU2zJCv2VfAbENMIy7xObi
 jwmv79LPzpJdogCVRED5aFMlt2XLNxvWrLFKaZm8oMtYyMop1aNtB4/m/md8uGW9AN4aU0Y3KDJ
 EQZ5r/+qQNbqq+43J7/l7khJ+qHkdS63yEI7KbNDrZBJwacHYhayvrmAV71HFa04X1evvmcwBXC
 KWXx8BSoBRk2ItnYY5JGP+4VZhXTv7zF+Eg6qOxvPKXkeH4nprAryflpSYTs42yOsjRLYCLQS5y
 rsA8DRWwxn5+9AHEtJ8cLZLEEA6BOmFLXAA4B5ccPkDT6tQuvhJvo4QLD+VrmoT96hk=
X-Received: by 2002:a05:701b:2816:b0:1b5:3b83:5374 with SMTP id
 a92af1059eb24-1b5568cfbd9mr18022188c88.19.1795672741112; 
 Wed, 25 Nov 2026 21:59:01 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm45249439c88.2.2026.11.25.21.58.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 21:59:00 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: Yige Jiang <yigejiang86@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/exynos: hdmi: put bridge reference on probe failure
Date: Thu, 26 Nov 2026 13:58:53 +0800
Message-ID: <rc-b1-20261110-vc-19-b220c856ecbb@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hdmi_resources_init() ends with hdmi_bridge_init(), which takes a
reference on the next bridge with of_drm_find_and_get_bridge(). That
reference is only dropped in hdmi_remove(). When hdmi_probe() fails
after hdmi_resources_init(), including the -EPROBE_DEFER returns for
the DDC adapter, the PHY and the syscon lookups, the reference is
leaked, once per failed probe attempt.

The sashiko AI review bot pointed this out on dri-devel on 2026-07-16,
in its review of an unrelated exynos_hdmi patch.

Drop the reference at the end of the probe error path and route the two
early returns after hdmi_resources_init() through it. drm_bridge_put()
ignores NULL, which covers boards without a bridge on port 1.

Fixes: 2db0d298f22d ("drm/exynos: hdmi: convert to of_drm_find_and_get_bridge()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260716132919.A3EA81F000E9@smtp.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_DRM_EXYNOS=m, CONFIG_DRM_EXYNOS_HDMI=y, CONFIG_DRM_EXYNOS_MIXER=y, CONFIG_COMPILE_TEST=y; baseline and patched exynos_hdmi.o, no new warnings.
No hardware or runtime test was performed.
The path needs a bridge on HDMI port 1 and a later probe failure or deferral, e.g. a DDC adapter or PHY that is not ready yet.

 drivers/gpu/drm/exynos/exynos_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index d67a493c8fe4..cf570be8fdc3 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1997,12 +1997,12 @@ static int hdmi_probe(struct platform_device *pdev)
 	hdata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdata->regs)) {
 		ret = PTR_ERR(hdata->regs);
-		return ret;
+		goto err_bridge;
 	}
 
 	ret = hdmi_get_ddc_adapter(hdata);
 	if (ret)
-		return ret;
+		goto err_bridge;
 
 	ret = hdmi_get_phy_io(hdata);
 	if (ret)
@@ -2079,6 +2079,8 @@ static int hdmi_probe(struct platform_device *pdev)
 		iounmap(hdata->regs_hdmiphy);
 err_ddc:
 	i2c_put_adapter(hdata->ddc_adpt);
+err_bridge:
+	drm_bridge_put(hdata->bridge);
 
 	return ret;
 }

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
