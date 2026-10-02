Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D3CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA5810E4A3;
	Fri,  2 Oct 2026 14:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VNVH09gw";
	dkim-atps=neutral
Received: from mail-ej2-f30.google.com (mail-ej2-f30.google.com
 [74.125.228.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D0C10E4A3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:21:51 +0000 (UTC)
Received: by mail-ej2-f30.google.com with SMTP id
 a640c23a62f3a-c2a4fbc5586so13042166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790950910; x=1791555710; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hi8AlywePpuCp/I6l8npdCyUnuCu9uLP5sJkPsGRVk8=;
 b=VNVH09gwcHX7xg+q1zxdJG/2aIKPdn8w0chH4r+NrOrjviRANNMrjuXsjBYaUfgyjU
 pS3YTN9fLASrz4agz0tkFxDWrDtXyGXcs4R9h1zqkLBRuBrhhxICdqU3m7DC4I4AZOkk
 mbDXrM6djt5s1/ThrowR4wBYy1+JpLnl8iWYU9y6hK8724QwBUKhAU54IUTaO0ks7+Ml
 UdEQpXTh0r7Wqk8sivigGS3uFX8af9i+IXsns1DIroUAtOxeogQjCvOiiO1gm8+SGJJi
 t/oZw2VmYhRj0GLMajqsDQ1nx27N3h28DDWs+vfELPyQIBaYN1x61HXaeHn6Z2Gz/diG
 TvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790950910; x=1791555710;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hi8AlywePpuCp/I6l8npdCyUnuCu9uLP5sJkPsGRVk8=;
 b=lrsLPC7lBgfFdBu1J/AKVuh34CVbJJZRRg/t5G1rkx3rPHYL5KAeNHDdYsrzzVx8sY
 tVOdpGG4fIp8di14U/rwc0bf9ydYZjZoWpwbt0lVk76vN59qv/h00i3deqopotUlzSCS
 LIbqLVhPLRiNhlhyBDUHiiaS9bU43i9nGrMuGyvXJtgXmNL85IVrerScrlEBAerQuCuQ
 0SJ4FyC8GeI9iVIWMELMUr6Bxc8fTvPdex37mPxvJ4zzvgw2YkOQiGCEv1KoF0EzDTj8
 X0ljhJyfAwRHYQV3AImM1mcor3yKFbhe16K/A6S8B/UHzbZq+2h4ur8LCTxYJwR8BaTt
 uwRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw41jZZMy+Kj83uQpMVl6LJLIuNLjpXW8gRQbvy9hN4tluwFKZll0IudfXQxaHEbxiXPpPu4JYh3ms=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kmZCw6ZhfSZ31SShN+bP0JGjWISHWjDkVyCNgznulfCDIfL2Ky
 +89QHZBwg7X0me2WFLABs8egtDHumbYxPyDV6PN+/Apng6SNu8UJAtkv8+SajUQsRx0=
X-Gm-Gg: AYBFou1XA5vEmOmtMRtfc+D01wA0Q9d2GMtkdv5TjvAb/bkS5vpSsu/SAyjRH8rss7W
 5vzVdsqwd2qeDyYtBTdbo1gRUzPJmhooaN1+PQgdA61L3+SjVGFfAMx136FDaKEGRZ17bdutHHf
 HYdMNaXp+GmC+Ux8ZCaTizEZRWOpLaPxv7Ps2jpJgdAtk6X4q8yYPZxETiIA34n6bblQqT6A7FZ
 PxuqZoxasYyxTlE3vgxM+DK1h4GwyqhtD02Hj2gsRL6maOqbJjeGk4tfnjAowK/c+o7H8SegD/4
 iwWQuow+xCA/FXnCbxQoZsf853hk458l+CueDKJBUKU736cT02IOd8A/1F31/m0K7ipPl+t9DTW
 nn0QcTvvtfBTXJJTtlUlE/n8HHAtK/UDTzMoBQE2cO619i8yanBdFBViR+WmkEDILptNDtjF9JD
 zlaVXyrdDTFAbSkZdxqMxF4cRUhh3nnyNvIDlmwSyjfgNFdGUYv19a5EYPv7EG5v/lAofF2y3hT
 5B9Nn8M6cQeXSqHBR7suOMknI7ggThT4QRcvdqeRSfJjwZV21yx
X-Received: by 2002:a17:907:2d10:b0:c2d:cdc6:827e with SMTP id
 a640c23a62f3a-c2e4af677d3mr241217366b.41.1790950909638; 
 Fri, 02 Oct 2026 07:21:49 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cf684e3sm89307166b.51.2026.10.02.07.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:21:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/4] Add Novatek NT37705 panel driver for Fairphone (Gen. 6)
Date: Fri, 02 Oct 2026 16:21:44 +0200
Message-Id: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr0K6tmba2kpZeQ/jAoZBahSwxUZju
 LsVTTTG5U/eezN3Fsg7CqzI7sxTdMH1XRpqkTFsy25P3NVpMwnSgAbBm8HwoezoyFWtNFpr69y
 uWOIHT427zq3t7rXDpToQjs/Am/B0vqQj4wtjVRmIY386ubHI4nqpuEfFnnbrwtj72/xYFDP85
 4coOHACixVoowXipimdH9q+o2XKzqUoP7YV+bctk22M1bgCyK2EX3uapge/DQfqIgEAAA==
X-Change-ID: 20260501-fp6-panel-3d35c999d894
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790950908; l=1468;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=NrQQe+ffbbsZUbQfuVMBkJLb7Eu4aQxcLMmswA46ZKM=;
 b=+KnsUStWqf+ki9Bj4Hq0RXT697KNdlbH52n35vhI+yqQTDUqeanE4a/XtKcxAs0t19T8OBgMJ
 NKhSTvVvfClBOP34uXjdxonv9HZans0NcThfNKohGCcG8y5/R8RTysN
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add bindings and a panel driver for the NT37705, and then enable display
on the Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- dt-bindings: don't use 'contains' (Sashiko)
- driver: Use devm_drm_panel_add & devm_mipi_dsi_attach
- driver: Replace linux/mod_devicetable.h with linux/device-id/of.h
  (Uwe)
- Link to v2: https://patch.msgid.link/20260918-fp6-panel-v2-0-6695c4008920@fairphone.com

Changes in v2:
- Fix kconfig dependencies of panel driver
- Pick up tags
- Link to v1: https://patch.msgid.link/20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com

---
Luca Weiss (4):
      dt-bindings: display: panel: Add Novatek NT37705
      drm/panel: Add driver for Novatek NT37705 panel
      arm64: defconfig: Enable Novatek NT37705 panel
      arm64: dts: qcom: milos-fairphone-fp6: Enable display

 .../bindings/display/panel/novatek,nt37705.yaml    |  71 ++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  64 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37705.c      | 396 +++++++++++++++++++++
 6 files changed, 545 insertions(+)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260501-fp6-panel-3d35c999d894

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

