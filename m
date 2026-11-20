Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54076606C89D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TkpgDZoU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9883E10E910;
	Fri, 20 Nov 2026 15:55:00 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C54F10E2F4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:54:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so1443378f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190092; x=1795794892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+aCHgVYgy4GxhOiFEAFYeoXQcQ3nMSgt2tm+XSQojA=;
 b=TkpgDZoU+eflF34VpaJGC+2tsK3YtAow5cbCJrCPCpI3hX5xCgOKMjq3IWMCivl2JE
 3mFqxUaLS8sFxMsqFD23C5spw+Kkv9sLcmEXU0JR50uI2R5j0U3+6ei7CVOhWyac2HH/
 tQnsTgMMS7nz4tQ+d7A+0e909xveIxkIUpqh226IQ9y26ea2kBJmGq69Fu3pJLMBcY3C
 /hrmamk18MNj50uX0AeAhI9bODBQa45RHGxQBttW/0lHEd9q4OZJ5QQOWXslTIDyyNS0
 JQcR92ORaTM/eAMdVJ4O6sJp/WIWHJaeW3cIPQe+5WBdQsvvna+fjseCqCbQ1j/syURP
 +eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190092; x=1795794892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+aCHgVYgy4GxhOiFEAFYeoXQcQ3nMSgt2tm+XSQojA=;
 b=Jl1cRrBm6CBWU9FENqoADmgZqApX0QalgeTk1Aq1u/mrjQ3Hs1eAMV/pTwXslucAfs
 2sX3VMbBpxUDiNy7JO9Ij4nYMl/ZBvr0Kp0wcFXxzQtxYfIsdGZW3fVHfuF/uiDxb6Hs
 cFvjSlK25DqqtcBsuJLb/70yLjYgmXOqM3/nmHjHdAdKT+gzJoYcQLqLpFvW3bF5Ll2o
 hsHMqsTbzah3ZPQPxvr6EsmU8HFEvK/jDzMK4FO4vr9td0TWor2xxY1yxu9NK4yNQZkD
 EYbybvlurgfG0lhtQqnahgq5FEQ06RrKzslWAjGFIb2klO7luDaLpWecpA3imSQhL/jN
 ETAA==
X-Forwarded-Encrypted: i=1;
 AL+hErHK4AtB64WbGpBvZcPl6HQ+RTGB6DNy2HH+MAdQUuytpWSMVnoyAfQR6+gOuSDNwOe16Mu5MOxdeoc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9usvup0ymUOUoIjJ3DwS+I9Vmws0Ukp8sepOcy3oABe60m3onX
 CGy9xcpU9MDAOtkPBWMEKD46QwxCJER3okRFyK9p/tB0ttz+O0prGhSi
X-Gm-Gg: AYBFou3SRmzXnY4mXpWo+ofhNmDN23+RIOGNq580DmCRYQv00wM1MXwnCyku+O/qQnt
 9CnR6ojU0vEeBQRFOLqIyl4q3Lz1icGrxD2bKT78b7Nf0Ow2mq9YGbCW/8K0kr739s3+w8WbZYB
 QyBcADBGtu5nanRMLmW2vPR/9SnRNdYPw4W8TCXnWPgjNGMm9OcQcyrvxTKZcrnu8+cqTksOesv
 brU1dalvFdhqwj8d8wUInq02zn3hlfqMRnwBAw1CHHJbiuza9ou1G2xB6fd2jcwgEr8QcIsQpb0
 xfbgOQehgvd9kgwk/E/PNH1lT+qo5wu1s4UO/DfiM4MN06Yx3ZnnMIk2c42rFn48jUZK3tv11H1
 +i2HBP+3tSqxJQKDWEkvgv+OfSXFhfTk4Jv4P/lFDp3cmavC3Mq4cbtrIODfn/W9MN61IMUStz4
 lq4S0WP1q39sxHIlEs9Jmg4N42e3WTLhnmNtvvMaIFC6IHGUY6QeyxXAxrB77SxDkDrY7H2N4en
 7BtXXuGR5mTZPYz9txcCwbXrC85iofLs03RoFBLwrH75km/C3TVoOuoTdCKmW5mLoB3V4WP0JX5
 xYKx4pKf+WTn8Al+jn/GfmVd857q2msRYQAHjd191SqjG1CZbO5laQgirNQF4k+PUjG94YJUofL
 HTCOXdshq3Uhx9h+q6wD9
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb887fc396mr78640565e9.3.1795190092017; 
 Fri, 20 Nov 2026 07:54:52 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:51 -0800 (PST)
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
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 00/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
Date: Fri, 20 Nov 2026 16:54:39 +0100
Message-Id: <20261120155450.7719-1-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
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
- GPIO keys (Volume Down, Assistant) and PON keys (Power, Volume Up)
- Simple framebuffer (continuous splash handed off from bootloader)
- Adreno 650 GPU with GMU and zap shader
- LG SW43103 1080x2460 DSI command mode AMOLED panel with DSC
- Silicon Works SW42902 I2C touchscreen controller
- PM8150B USB Type-C controller in sink mode with USB-PD and
  orientation switch
- QCA6390 Bluetooth HCI controller on UART6

Changes in v5:
- Touchscreen binding & DTS:
  - Replace separate interrupt-parent and interrupts properties with
    interrupts-extended in the lg,sw42902 binding example and the
    touchscreen@48 DTS node.

Changes in v4:
- Base Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Drop vendor brand prefix "Google" from the assistant key description
    per review feedback: rename google-assist-state to assist-state,
    google_assist_state to assist_state, and update label to "Assistant".

Changes in v3:
- Base Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Model PM8150L SMPS6 as top-level fixed regulator smpc6-regulator
    (0.88V) rather than in regulators-1, because PM8150L SMPS6 is an ARC
    level resource (ebi.lvl) and querying it via VRM causes
    rpmh_regulator_probe() to fail with -ENODEV.
  - Drop conflicting memory-region reference from framebuffer@9c000000 to
    prevent simple-framebuffer/simpledrm driver warning and mapping size
    mismatch with reserved memory.
  - Add board-specific firmware paths for CDSP
    (qcom/sm8250/LG/timelm/cdsp.mbn) and GPU ZAP shader
    (qcom/sm8250/LG/timelm/a650_zap.mbn).
  - Drop duplicate sdc2_sleep_state pin configuration from &tlmm (already
    defined in sm8250.dtsi) and redundant &pon { status = "okay"; }.
  - Adjust ramoops pmsg-size to 0x100000 (1MB, power-of-two) to prevent
    kernel round-down.
  - Drop unused <dt-bindings/phy/phy.h> header.
- Touchscreen driver (drivers/input/touchscreen/sw42902.c):
  - Fix potential unbalanced regulator disable in error and unbind paths
    by registering devm_add_action_or_reset() after sw42902_power_on()
    succeeds.
  - Guard sw42902_power_off() when suspended to avoid calling
    regulator_bulk_disable() while supplies are already turned off.

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
  - Ramoops: adjusted size allocations ensuring panic dump space is kept.
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
  - Cleaned up unused dt-bindings headers and enforced strict alphabetical
    ordering of all referenced label nodes.
- Panel driver (drivers/gpu/drm/panel/panel-lg-sw43103.c):
  - Removed redundant manual unprepare call in sw43103_remove().
  - Guarded sw43103_backlight_update_status() against execution when
    unprepared, avoiding unsynchronized DSI DCS writes.
  - Removed hardcoded full brightness writes in sw43103_enable().
  - Expanded Kconfig help paragraph to 4 lines.
- Touchscreen driver (drivers/input/touchscreen/sw42902.c):
  - Converted GPIO power controls to standard regulator bulk supplies
    (vcl and vdd).
  - Pre-scanned for palm touch reports before queueing MT slots.
  - Used named initializer in struct i2c_device_id table.
  - Followed input subsystem error naming conventions.
- MAINTAINERS:
  - Added entries for LG V60 ThinQ 5G, LG SW43103 panel driver, and
    Silicon Works SW42902 touchscreen driver in strict alphabetical
    order.

---

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
 .../input/touchscreen/lg,sw42902.yaml         |  72 ++
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 814 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 587 +++++++++++++
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 360 ++++++++
 12 files changed, 1951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5
