Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C802606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ighClSv2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDF910FCB9;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D188910E5C4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so30978575e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919189; x=1795523989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yf/7M/nDCTW8ZFPsGSaUmFFI3kKEtiDdHsd3kIU7HVk=;
 b=ighClSv2euIbB1P2LDsf7Mu3kMs+1JrEtAFBnKwHfnVX4cvnmmqvqtQqNyiUmpZvSE
 tBbv3POuKfsDl9j+Ag/KqJOeC1XHpsj/CCdzil7CDFcfa2D3NF6CrFhpCsLp4T76XSyW
 aUZK28h8jOv2ED20+yW5rFMujr/P1ihNVsJXq7mwR65ym10uonXDcezTQG9Bx0y5PBez
 WaBBQhgAp2FrIj81l9Qq6A5sp0+fk2j1NMnb5lDEJFc0OzYy6wDtqaIEEb9/jGEjvEq9
 Od+NuaospErqcrKEkeuPx2311b+6lWkt6V1LAmMaD5RB3pf/kOyr984GOxXVg2BrRDZ2
 anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919189; x=1795523989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yf/7M/nDCTW8ZFPsGSaUmFFI3kKEtiDdHsd3kIU7HVk=;
 b=oGM4e0xpZTix0d3xvDqwAfbtd+aA3Y8h5Uh8G8oAJhkGS2AkTC5l89mfh/xJN5oMxx
 /zRDgwhWvyd2TG0e+MUBYMqboAqeOsVHdla/Ag8jUl+un6b8svKhBlO3EBQhoX+ZbzoR
 8sVWmyd2DpxvZsiqLjhfbrvoJhS3e/KN3J0OnqSS5kNXcbr5+TIwGdra7NhHSNnFlmEt
 7s8a7SLIwDnxJ3fV5vAkJbGjyyqvzg+hHde9qdF5mZ5l1hrxJORHQRpTtoNCJ6alYfIP
 O7tGGXtuXm00xmYImqKuk04bLl1cwu92/Krn8PppJcshqFtIzQiCOpBU+UGwBfX1G5i1
 FPpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH7kjWcj1uZ6hvLmqMoIB/cV4EC+IxJTVtOhmIwi31CPToVyzPD9tWvhwwQOHLsz26jwjuzWnjQdiU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Q7grQbDft80ZPDIaAzSFowqqMLgYTY3em6zfBhwuKaRrxyA+1
 Dz61b6D+N/LNqBCwCytx8o/ljGYUXhAqIKSsD//TLt6C6CPLWcA7RJcV
X-Gm-Gg: AYBFou2iQhoNO15zTYZg3TMp6x6h1V82OHsraTC7A88l46+pIQPjW5TrH0Pgy4Ft1BX
 fMT37Zk1/FEy6irHkENVlwO2dObrFa4KKJpMdx+T/eMBJRE8k7UPTTXekmbA5GDY+2Bi0CpU6wv
 rYgksUDJpGhoR53XS6ECuHn40fnoYEg1VDnNmZ+CCPhThW4F9aPZ2VIo7uO/eZt6psPhOubad6s
 dtYaQ/tFU6VxviNliW1SJviKXKUx59fjQs677ZQbO5Sbd5j98gCgzeWuDPoEy5oShda9D9yci3w
 gfV2edWhpkUm/wzZY56gNoGgetx+oU0cemGsMU3J/iGKwNc8lbH8dWLaAAP/5ltn2tt2s71uqf/
 ZSc0Amo/G7t5bVa38PRXDfmIc6CTGjxWQrnsdHPpdeBAUQlL8jTttzEq6NiczX/X6k+d7Yuzgwi
 rvcvFjqxICKaQvcC0Q1718bqq+H3NCqR3xbLjjBX8A4zFDkIJeglbRVXwEQehwQqvNGRSbLAqyb
 xHliq0lBwQN1r5P7zZqLviBgegs0dUEux9hOn4XnPgyl+BdTfIX07niA81JGuMwv8hjMORysx3Q
 nR2zqPtmU6uQ9Vsryl6DiwgUfG6CdSr9N0Tid1+SGiSzFpHM5dvrcz9y/KIq/fSHWnqkDw==
X-Received: by 2002:a05:600c:1c0e:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb6f452d4fmr166096475e9.22.1794919188928; 
 Tue, 17 Nov 2026 04:39:48 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:47 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 00/11] arm64: qcom: Add initial support for LG V60 ThinQ 5G
 (timelm)
Date: Tue, 17 Nov 2026 13:39:35 +0100
Message-Id: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:07 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial mainline support for the LG V60 ThinQ 5G (timelm),
an SM8250-based flagship smartphone released in 2020.

The series enables:
- DT binding and SoC board description for LG V60 ThinQ 5G (timelm)
- Memory reservations for bootloader and firmware log regions
- DRM panel driver and binding for the 1080x2460 SW43103 AMOLED display
- Touchscreen driver and binding for the Silicon Works SW42902 controller
- USB Type-C TCPM sink mode on PM8150B
- Bluetooth HCI on GENI UART6 with QCA6390 power sequencing
- Storage (UFS), SD card, volume keys, and thermal management
- Entries in MAINTAINERS for timelm platform, panel, and touchscreen

All patches pass checkpatch.pl --strict with 0 errors and 0 warnings,
and the device tree builds cleanly against Linux 7.4-rc3.

The series is also available on GitHub:
https://github.com/rofikkerneldev/linux_timelm/tree/timelm-v74-stage1

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

rofikkerneldev (11):
  dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
  arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
  arm64: dts: qcom: sm8250-lge-timelm: add reserved memory regions
  dt-bindings: display: panel: add LG SW43103
  drm/panel: add LG SW43103 panel driver
  dt-bindings: input: touchscreen: add Silicon Works SW42902
  Input: touchscreen: add Silicon Works SW42902 support
  arm64: dts: qcom: sm8250-lge-timelm: enable SW43103 panel
  arm64: dts: qcom: sm8250-lge-timelm: add SW42902 touchscreen
  arm64: dts: qcom: sm8250-lge-timelm: enable USB Type-C
  arm64: dts: qcom: sm8250-lge-timelm: add QCA6390 Bluetooth

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,sw43103.yaml    |  70 ++
 .../input/touchscreen/lg,sw42902.yaml         |  74 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 744 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 594 ++++++++++++++
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 315 ++++++++
 13 files changed, 1846 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5

