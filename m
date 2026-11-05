Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B2606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8A7ZifM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFEB112C59;
	Fri,  6 Nov 2026 09:18:59 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5733C10E295
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:12:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so22519645e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793909544; x=1794514344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oj4+ZYy6IPmEk7n48ZoOfVMyHB9K5zKwdNLmj5eS60A=;
 b=w8A7ZifMPmzulpgYXiDymJf/hvziDTDNaneH1QWQO8dyDwhqyS70Ff/KAGr78aRmmH
 xO9OKG2x28eRRYruFT3LW2FT1OUaP24iFoKZxgUnLTFeQLNXb2rWJDcsK8+604pyPEQr
 TZvCqnR4M31ocg3kKNgcRnZo55uMqbJHcRYVvI0DQ7iB8Wn5OZXJyZAWIPfUVCd/CPpQ
 lys+BOssZ37J7CJl8494V+yHkjRlaP4WxKeHaEFPvAuv6wHWSDjqImm/mp111grLYgpI
 vwHiFGnrhBbN6nWA4Bw8LfjIkgexlpKweF7plJv2GOoM0cOrTMxEId/5sLmpJtGsltwU
 A+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909544; x=1794514344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oj4+ZYy6IPmEk7n48ZoOfVMyHB9K5zKwdNLmj5eS60A=;
 b=KsCAMwHVucI0FPyEry95QV472RYe6wehz1jwSyeUGDF/VQZGhOaz3LPTwokY0YVt2q
 pGiz21LcdiNBY4MiT6nSBgxMlIgNwgy1c83jb4ifoSsWEYTGIEKnSM3eXH3kn/5Bm9TD
 wukIED8YJ5b4agdau5YuKyT2c3Ue4hIM99+W6wLR+GmGNhVUAbrpDV+NfPQPwFsUQYdh
 gNqcDJ/18N8R6/0eaNU72x/n6AStzr6XdFkhtbuDY7H2r/gQdg97kyfOpVnxVvpQKyQx
 dc4wfcGxBI8JDUlmGNhTZ2/8CFnND7tOSe9/gnzPieHTxb75qSOymEnUhQNQGRLgZ4Aq
 l8kA==
X-Gm-Message-State: APuU4Z9gX4sQXuDqzkSXzWItJpxGURRvHE47IDgiQtasm283HqrScKM5
 bksE6CvG4MBNUm4yozDOXayBNTxg6NK1+ZMlbAn09FGwCYhktxwwiK0LuxOmVA==
X-Gm-Gg: AYBFou3hiSzjcM8wocW2xEbj6+MXrx5sgwfUR1QtqJT18nEj7XdPRDfD21kX3JGm78J
 Zt/BwbN2IqA0ZcjQ+/bMGxAfb1wvb6H7wMk9lOI6FkRj6v8jUaEz6DaeO3suZUAmewgEEs/ojUg
 rzhylD+C9uvCo0Lee2qPRpNBn1723JP6hmXeNKp5W4vo1eHr0pma+4zbtw98xYOwvP5etQ6b45u
 qdXpjTnBw3bTJwNS24pXjSYHQuNnhitvE1HCF723FM11No95tFYmmQY1csoJdPRbuZJ1mcDLs1P
 pJTbJSyhk7/05DthAfiskGrFWp4pKrzisupf+d2nWJX+CTIKyoEzKDtpkHeqZmijFYmrsORnVGT
 bvc7YSxwD9/QYy9Q9AiyLdIbm9RdoZaXSaKQ6/vRq+/BPBqCFnMQAYjDKTD48KLWWWoaBSnTi+j
 EncIPPb7Qn0wF5lYX2Zc+vNIvxDYz5166n6+qjgwhvyGgvXAU6wM3GN4jFgjBgWp0bugUrwawlX
 2UOhh1NM2JrP8ig9EBtuUrBAAoPUBBj5anzXqJIg1taGUJbuRMlVOZcW8DBJK4/5NRRlqUeV16D
 UNKjErN+kYqahQ1efw+aGwmS4eBlJEorQbp59bxMdL28AFjwK7XLfII=
X-Received: by 2002:a05:6000:2dc9:b0:48c:7f18:c85e with SMTP id
 ffacd0b85a97d-492778d2076mr1325704f8f.45.1793909543495; 
 Thu, 05 Nov 2026 12:12:23 -0800 (PST)
Received: from localhost ([82.77.126.113]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac1caesm11108369f8f.17.2026.11.05.12.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:12:22 -0800 (PST)
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Daniel Matyas <matyasdaniel006@gmail.com>, linux-staging@lists.linux.dev,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nam Cao <namcao@linutronix.de>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
Date: Thu,  5 Nov 2026 22:11:53 +0200
Message-ID: <20261105201154.37294-2-matyasdaniel006@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

I'm looking at the fbtft TODO (convert drivers to DRM) and want to check
whether fb_ili9341 can be dropped. Findings against v7.4-rc1:

1. fb_ili9341's init sequence is the MI0283QT-9A one. Comparing register
   writes with drivers/gpu/drm/tiny/mi0283qt.c, the values are identical,
   including the default gamma tables. Differences I found:
   - mi0283qt writes EN3GAM (0xF2) = 0x08; the fbtft write is commented out.
   - mi0283qt always sets MADCTL BGR; fbtft makes it configurable (bgr=).
   - fbtft rotate=270 also sets ML; mi0283qt does not.
   - Rotation maps as DRM rotation = fbtft rotate - 90 (mod 360).
   - fbtft also offers runtime gamma adjustment.

2. fb_ili9341 registers the compatible "ilitek,ili9341", which is also the
   fallback in the dt-schema binding, so it can match nodes that the DRM
   drivers claim via their specific compatibles.

3. In-tree users: no defconfig enables FB_TFT. canaan_kd233 (62363a8e2f56, Feb 2021)
   has a status = "disabled" panel node compatible with "canaan,kd233-tft",
   "ilitek,ili9341". It predates the first DRM driver accepting ilitek,ili9341
   (5a04227326b0, Jul 2021), and none of the DRM drivers match canaan,kd233-tft.
   fbtft requests "dc" and "reset" GPIOs, which fits that node. I haven't tried
   binding it. I suppose that, if the board is used, then it is built against the
   fbtft driver.

4. fb_ili9341 has had only style/mechanical changes in recent years.

Questions:
 a) Is removing fb_ili9341 acceptable, pointing users of other ILI9341
    modules to panel-mipi-dbi? The KD233 node would then have no driver.
 b) Or should KD233 panel support go into a DRM driver first? I don't have
    its init sequence or physical size, or the board...
 c) Is removal of all of fbtft already planned?
 d) Several other fbtft drivers have drm counterparts. Should I inspect those
 to see if removal is needed?

I have not tested on hardware.

Thanks,
Daniel M
