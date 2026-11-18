Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5900606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g7iAH68K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB3D10FCCF;
	Wed, 18 Nov 2026 13:47:15 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6302510FB79
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:18 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so589138f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003636; x=1795608436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9seoRhnpl2G4Qf4rk1mvdRgkYkYbj2TKHC5BtWjc5BE=;
 b=g7iAH68KuNMMNQDOOAYpEpB9XBNayhiXJzh/iKtXGj4um1sL13+1Upgpx6ev2jdX3E
 l/6G3m2ghKeAHtJ5m7bUEEUb/IE43ryx08lXi/INiX8Apy3yF2ewUIpkTxf4MGs3EZqK
 /uY5ey6QRRv7K8gkiMKufMdqJffOjYc5fifLVNs2J78JL4jKeoV16KpWrcTRvP28+HGc
 POERcyq5/LynhKrnVsJxLNUXWqnD2fCxy5zoagdpXYK+VckSoAuUuF6w8fwhlianPhB4
 w+SLy6/B8sKpXgna9Tb8cJU7eBHQlXqdWiupQDCpVIo1zNlCcSqJutQPaH5cn8mCzG3z
 wXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003636; x=1795608436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9seoRhnpl2G4Qf4rk1mvdRgkYkYbj2TKHC5BtWjc5BE=;
 b=VyKUD084in2OcFa5IlBIcJVIw/Xnmx6XR2DRItrQon4565gTFLjD+x140DoJ44+pi0
 CGxjc5L6RzRojwDqgkPcOeg1dC93rrTkcCqeSQygaBrko+M15cgumFy10UNlBwnjEBha
 73WfajYQIk/ahUBwZ+RjEUmyfh6+3kOP79yNHI+Ip6nZMfPV2jVpTlFewmYQyEnBots6
 Dmh9NwutPn8dGFv43QGCUZsyop6e56ZbJ0yOAPLzgArkpoepqO2nXMVMm+aIdut2oYrI
 0QuTEBE0KZABQFPoBdzAI9u0gn9eeaqXL4MCYHQSK7gY8WtrRx3f33c4QfpzwdLKO9cE
 MtXg==
X-Forwarded-Encrypted: i=1;
 AL+hErGzAqt4/tc+Mw9/nMyZbqQ2KnyYTKnvLV/H+D8h+zFCkzQCIQOAmHwSSh4Rhsfj2u/3x0ZOxOZvAx0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/JAEj1S5lELURxjXNIVy+Rx3cVSG5CYWiQsaxwmAcBTtVhCWXL
 YNWAICgDUi3DYRsUpLz9yfUMt+9y66M2t/gaFcOyAZXLS17SOKn+fJzZ
X-Gm-Gg: AZFdTZdRa76WbVebJf4kI/LxvexHndkBKR7T+G8nHYhoCWOiAm2OUtiEB3Ujj8krvBE
 ANgj0hd7slmVgwUOPDeIxv1+GmRqedyp+wMgBTHmAhboYCgGTAYIYuq29iLiYLYswJqVf2rEAeT
 R3TrQg8lOmprlhgKnUm6cz5Fpckt9tNNvvdDK1XYSv/N2iXkzGv05c9zKIHn/nDcoJMk3bNOKR2
 u32c/4Zvm8aVz7ELesS4sjdwQHiyugf4vP/SiuNhN+XLnmIX0mm+FiYsAlZnJvs8XWtrStuStE4
 iemeQqWsciv0suWIcXVyAddoQYQ17jBm3CLqS77iTevauJ0KkfjRanSj8I9P0UVyTxRYZRPfYCi
 BH0xQZR68IQ4wbeNX1rdAx154SFGQDkNssAm86Qn1ujyzHdeUDv+MLnyQVtjolelz+ESNCMIsuq
 yZFi9Kjhj80MYuZJNd6on8h83J35CY9yftdZ3fJMT9dlikHTMaBJoOzv4gLb+zpWEVOnvt7VsiS
 Sqq4j8ajxSBS+JLldxpN+bkx2hI6QRsAL6H0P8moHalGlIeW/B+4WcbM12fdBBSfVhwuBE3pyRk
 s/a90Y8aYwy1s15DrPRwvLmK4IhYyTQFRe3iBP5C6wL1BzEIYmFEwRkBEUpujFUvnKu2flRv3+6
 aiNJYhvlqMR8vrfUdv+Gu
X-Received: by 2002:a05:6000:1ace:b0:490:88e5:92d6 with SMTP id
 ffacd0b85a97d-4a63ce07af1mr5436523f8f.49.1795003636236; 
 Wed, 18 Nov 2026 04:07:16 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:15 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 00/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
Date: Wed, 18 Nov 2026 13:07:04 +0100
Message-Id: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial mainline device tree and driver support for the
Qualcomm SM8250-based LG V60 ThinQ 5G (timelm / LM-V600) smartphone.

Hardware features supported in this stage:
- Base board devicetree (sm8250-lg-timelm.dts)
- PM8150, PM8150B, PM8150L, and PM8009 PMICs and regulators
- UFS 3.0 storage and MicroSD card slot
- GPIO keys (Volume Down, Google Assistant) and PON keys (Power, Volume Up)
- Simple framebuffer (continuous splash handed off from bootloader)
- Adreno 650 GPU with GMU and zap shader
- LG SW43103 1080x2460 DSI command mode AMOLED panel with DSC
- Silicon Works SW42902 I2C touchscreen controller
- PM8150B USB Type-C controller in sink mode with USB-PD and
  orientation switch
- QCA6390 Bluetooth HCI controller on UART6

Changes in v2:
- General / DCO & Identity:
  - Replaced account handle "rofikkerneldev" with real name
    "Abdur Rofik <rofikcoga@gmail.com>" across all commit authors,
    Signed-off-by trailers, MAINTAINERS entries, and copyright headers
    per Documentation/process/submitting-patches.rst.
  - Replaced un-documented "lge" vendor prefix with documented "lg"
    prefix across devicetree bindings, compatible strings, and dts files.
- Devicetree bindings:
  - Added lg,timelm compatible in arm/qcom.yaml.
  - Added lg,sw43103 panel binding with enable-gpios and
    vddi/vpnl supplies.
  - Added lg,sw42902 touchscreen binding with vcl-supply and
    vdd-supply.
- Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Renamed file to sm8250-lg-timelm.dts matching vendor prefix.
  - Reserved memory: folded cont_splash_mem and log regions into base dts;
    sorted all nodes by ascending unit-address.
  - Ramoops: adjusted size allocations (record-size 0x40000, pmsg-size
    0x1c0000) ensuring 256KB is available for dmesg panic dumps.
  - Regulators: dropped unused LDO4 from PM8009 regulators-2 node,
    resolving the invalid 1.05V constraint failure.
  - USB QMP PHY: corrected swapped supplies (vdda-phy to 0.9V l18a_0p9,
    vdda-pll to 1.2V l9a_1p2).
  - GPU: enabled &gmu alongside &gpu to ensure MSM DRM component
    binding succeeds without -ENODEV in a6xx_gmu_init().
  - SDHC: added complete pinctrl states (sdc2_default_state,
    sdc2_sleep_state, sdc2_card_det_n) to &sdhc_2.
  - UFS: added regulator-allow-set-load and regulator-allowed-modes for
    dynamic load scaling.
  - Panel: added enable-gpios to panel@0 node; sorted display nodes
    alphabetically.
  - Touchscreen: used fixed regulators reg_ts_vcl and reg_ts_vdd for
    power supplies instead of raw GPIO toggles.
  - USB Type-C: replaced PDO_BATT with PDO_VAR(5000, 9000, 3000) to
    ensure valid 9V/3A PD sink requests without clamping to 600mA;
    added OF graph ports connecting DWC3 HS and SuperSpeed QMP PHY
    orientation switch.
  - Bluetooth: corrected QCA6390 PMU voltages by setting smps6 (0.95V)
    and smps8 (1.35V) constraints.
  - Cleaned up unused dt-bindings headers and enforced strict
    alphabetical ordering of all referenced label nodes.
- Panel driver (drivers/gpu/drm/panel/panel-lg-sw43103.c):
  - Removed redundant manual unprepare call in sw43103_remove().
  - Guarded sw43103_backlight_update_status() against execution when
    unprepared, avoiding unsynchronized DSI DCS writes.
  - Removed hardcoded full brightness writes in sw43103_enable().
  - Expanded Kconfig help paragraph to 4 lines.
- Touchscreen driver (drivers/input/touchscreen/sw42902.c):
  - Converted GPIO power controls to standard regulator bulk supplies
    (vcl and vdd).
  - Added suspended flag guarding resume and I2C operations to prevent
    IRQ disable imbalance on resume error.
  - Pre-scanned for palm touch reports before queueing MT slots.
  - Used named initializer in struct i2c_device_id table.
  - Followed input subsystem error naming conventions.
- MAINTAINERS:
  - Added entries for LG V60 ThinQ 5G, LG SW43103 panel driver, and
    Silicon Works SW42902 touchscreen driver in strict alphabetical
    order.

Abdur Rofik (10):
  dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
  arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
  dt-bindings: display: panel: add LG SW43103
  drm/panel: add LG SW43103 panel driver
  dt-bindings: input: touchscreen: add Silicon Works SW42902
  Input: touchscreen: add Silicon Works SW42902 support
  arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
  arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
  arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
  arm64: dts: qcom: sm8250-lg-timelm: add QCA6390 Bluetooth

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,sw43103.yaml    |  69 ++
 .../input/touchscreen/lg,sw42902.yaml         |  73 ++
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 840 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 587 ++++++++++++
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 355 ++++++++
 12 files changed, 1973 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5

