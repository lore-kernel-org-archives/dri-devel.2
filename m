Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE4BCC6B14
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA8210F59F;
	Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73B310E656
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:00:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so14931265e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791828000; x=1792432800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7efvOtPkVQs2r0jJvys2pZpGeATiCwhTrDVdy86Rwg8=;
 b=etzi95whD99aeO2aHfCJWRzEbIXCdDakZ335IOd6sSmvkRqLdzSmsSnLjWS121uFzc
 pZE/LpZEx4VUK3IFxHf5rxppXAODprGNp7loRikA9vULwD1gVGLDbr6AbrUAfMlW52yi
 yprA1a0v2CXvC1mYCt8pYIa6TdsIkqBS00xSDAmUccejUe4lF3NBTs+x1eb9l4GCmk5s
 SaALbjKobk4RDypXhqd8S0VmONHexpKqAZBl3Su5uverXVx/Anr6QHPnJ1YzkInOBtUl
 0wutI4JzxYEBh5UQHsq+qfbiMeOM3Sb0pUNMBAi21Ix+Y7s3E08VapsiwKeK2B5cHbQE
 ZZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828000; x=1792432800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7efvOtPkVQs2r0jJvys2pZpGeATiCwhTrDVdy86Rwg8=;
 b=Jyr5Pp8dwxrmcT0N15i1NohXd6aKShV3VxBPeK8eW6dHAaaJS7SNu9F0hJT5gbCpAW
 69K3eNQaucPBd4RGFvG/M6/3Iar4U2XMYxLL/KJsb5YSPU/hvk1KiuFjRZmQ9syZcnxd
 rqdwDQGFRjAViE5i/tsiI9diTb8omzC4u9AVEYDIAgoZrsiZdQwPquyhAzCEfasbhxhF
 TXFSncyH/0XDaOzoIyY6jJ2ql014yA+q6iucSF347uYFHAmoaH7n2DPADAgpUcvMcDqQ
 Z2lHvg3PfK8xgjONpN9ZRNKxrL9+V4y5nkgspy/me+ncNI9iE0hQ4U1AsWfBQbZC41uo
 JwVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByXIQj5YeCt+oA1fAsJ2Bs0UoIDHe//vZuB3GOAHQkq2dJmdw8mYdC+8cuP31SZ17E9R7kOKEdmQQE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICv25QcSzIsyP/RrQxPAwAgwe+w65cMs6ImkXDnH80rwEJkfx7
 qiZz5tZ4aHZnkyMgoPMy1ik2IlJKsznNQeRWL8BqOzTv1mA+qINncqV8
X-Gm-Gg: AYBFou3sIzEN0QZugsxFESTjPeIOXkc0g8MVy2Yuj7ZabgGGA2NcrM+fmyuDCiUmRb8
 F+YaVUn19IrdALfqeR3/nzw127xNlzt8gpYZ1wm0I9VExQIe4chdozjFjo1VgOpweAhq4WooyCS
 Yw2YrJgDv8WlVJsE7Z36ajzzot4dOcvKLHtluemDigN5cvW7meZ8oPdbv9lOuLll3bqcYjNJWDh
 0VSyGJy2mjuDJ8sg5QrqNzBeWtKETY/xepATG3RfloRzb/8eMwi0qamoDZgJRxIWPB0NNgt385S
 BBH8GHE2yfGh+oW1sRqUDuIqTnSfDGwHItpAnvrcckBMx89Q5p763r09dgN+GB4d8nain1ON+Ob
 i+WrXW58PDcPiIZjBVGhRDZVI68TXTlgsT0L6xMTtPJtoERukCqARz2USpr6U2OZswfaZ1M9kfz
 2AITNycgc0F1KNEesGb+7tk8NVJ2lZpmiK8TeqaW8sIlT8RZ0xoKM6Wvbjt1XN9IZjHHGqpVDSb
 Tgt27xAGOTCzXxt
X-Received: by 2002:a05:600c:83c9:b0:4a1:70f0:ac2 with SMTP id
 5b1f17b1804b1-4a18e4ce9cfmr193832545e9.24.1791827999830; 
 Mon, 12 Oct 2026 10:59:59 -0700 (PDT)
Received: from hp-z640.fritz.box ([109.76.80.100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm561705395e9.9.2026.10.12.10.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:59:59 -0700 (PDT)
From: OOHehir <oo.hehir@gmail.com>
X-Google-Original-From: OOHehir <electronicconsult1@gmail.com>
To: m.wilczynski@samsung.com
Cc: Laurent.pinchart@ideasonboard.com, alex@ghiti.fr, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, aou@eecs.berkeley.edu, bmasney+clk@redhat.com,
 chaoyi.chen@rock-chips.com, conor+dt@kernel.org, db@domibel.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gandalf@winds.org, hal.feng@starfivetech.com, heiko@sntech.de,
 hello@big-grey.co.uk, jbrunet+clk@baylibre.com, jernej.skrabec@gmail.com,
 jonas@kwiboo.se, jpeisach@ubuntu.com, kernel@esmil.dk, krzk+dt@kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com,
 mani@kernel.org, maud_spierings@murena.io, mripard@kernel.org,
 mturquette@baylibre.com, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 palmer@dabbelt.com, pjw@kernel.org, rfoss@kernel.org, robh@kernel.org,
 sboyd@kernel.org, tzimmermann@suse.de, u.kleine-koenig@baylibre.com,
 vkoul@kernel.org, zhengxingda@iscas.ac.cn
Subject: Re: [PATCH v5 00/21] drm: starfive: jh7110: Enable display subsystem
Date: Mon, 12 Oct 2026 18:59:41 +0100
Message-ID: <20261012175941.258219-1-electronicconsult1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

Tested on a VisionFive 2 v1.3B with patches 1-17 & 19-21 of v5 on
Linux 7.2.8, plus the clk patch that was 14/20 in v4. Patch 18 was not
applied: it conflicts on 7.2 & there is no Rockchip hardware here. The
same kernel also carries the out-of-tree PowerVR BXE-4-32 enablement &
the SiFive XPbmtUC errata patches, so the GPU could render to the
display.

- The dc8200, the HDMI controller & PHY & the vout clock controller
  all probe, with nothing left in deferred probe; HDMI-A-1 reports
  connected.
- kmscube (GLES via zink on the PowerVR Vulkan driver) runs at the
  monitor's preferred mode: 1683 frames in 28.1 s, 59.93 fps with
  vsync, picture confirmed on the monitor, no GPU firmware resets.

Only that one mode was tested; the modetest sweep in the cover letter
was not repeated.

One error at boot:

  i2c i2c-7: of_i2c: modalias failure on /soc/display-subsystem@29400000/hdmi@29590000/controller/ports
  i2c i2c-7: Failed to create I2C device for /soc/display-subsystem@29400000/hdmi@29590000/controller/ports

inno_hdmi_i2c_adapter() sets adap->dev.of_node to the controller's
node, so the I2C core registers the controller's children as I2C
clients, & on the JH7110 that node has a 'ports' child. The display
still comes up. Should the adapter get no of_node, or a dedicated
child node?

For patches 1-17 & 19-21:

Tested-by: OOHehir <oo.hehir@gmail.com>
