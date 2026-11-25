Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06598606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ug2KI/Hc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9AF10E383;
	Wed, 25 Nov 2026 18:48:25 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC0D10E383
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:48:18 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c51a02ad3acso173548766b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795632497; x=1796237297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
 b=Ug2KI/HcobYTQRXI+AS65g9wKFlqjqj+qFu9dFMMotmN4A6grpm67WozadmdcEQ3fj
 FfnEGgDpSdJsLiwJHijrLgf9b1idmDPiCuKqAJ/tE0jqolQEdAJOmWbFAgD0trcHdKmw
 2RAykSjGGkPa9t7RI9BIi8GyNPaKegiyfcoiuxwpEv1WKMuhQVgopMEPAaA98ipB/TCa
 CGY2sT5eoJU4/QoiZi2if0zcfO74x2rCuUUFeohjCAXGZvWfzvXWcWXdHwNMsIJrktY4
 RMS4lUQ7myv5D5h4Uj4Ozlm0p8F6CW7Z8wl/DGi18pzFtGzx5QZ8BKAm7GHzhzOcFjT7
 TY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632497; x=1796237297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
 b=jV1IeYzwK91jQQMYxAjLM7eQVxjaQZZ4b54Q+LMTbk8j8+/oE9li+N0UxWvYjhSxre
 japNLeXotL+Mq1N7MmI/pqwISrREh54St3XkPRQ11ESI99WmGIS+pZfwNq+61z+3EB6q
 ail0rBRhac2s+OGsd121Z6NzsXitosx35OdJfdTG1YkQaAKvVDrxeWjYdaEjWDphHZ1T
 uZ8zcd5tdBwSg/OQZWf35bKZTi619wSZM5o0XJ/eX/40GpDMXuLP3NgwlaVtnAEiWajK
 kWS1vSwIkdXfCihXYioldyJYxin0DeboX6ptXHHEV6apqVoegf6BzdtrBGux/vQF2/CK
 3abw==
X-Forwarded-Encrypted: i=1;
 AL+hErFnbWUkOxdvMOIiQIKomyzE7qnxB/hT8Yr8yB37qbnTwF/cJuOk4vAOPUXwRi4MBt13SqR2wSS10iU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+0vVOm3jOd96G3osZMpoTmR/2EIBiWAIztroaWnhX/nWfXWsQd
 at1km1X8tJi5Q8ELiydKhHetSL4jX8ZCpdfgTKCobqMUcHKQbZ6w3jj3
X-Gm-Gg: AZFdTZeFUQy24PipkGlFY2A19FrK+wBz5lFdSXIFY3RwMh4rAsHOpdaDIk4cNQ2pruc
 x87cS9CnR6/J030U1/07v6iicqymNVHtkzV/BthLXptlTtZF9kW3VgIwGzwMQwlhm4jABlWGCuR
 RqdCQ1V19wtID5U9Nc3kB0lRE3Cz0JRj7kfNq6ju8BpovlP2blGJX6iL3ypVPFuQPjeg2/xMvfe
 OlV7Lx160d64am3JqbhIvIadS+RuCD4tKWcar+YS6o+4xb7cEySYVY/DIqhTDYrVoC45L4XKNuu
 As519GoS5NqSlZu61nNBNzfPfY+WhbeRL9vyZifxtZRd05Et2ZqgrbHyGJQpmRtZwxE7ERJykP1
 V5XqbPDO5JCp75tbPenWkx/+vAVEDVBY+AispnkxK7CR0LD06cdo/Sb++ra4jlapzJeyAZGE3+Q
 vli2Cz9NuiKlkqhfG0taPlZmfIEa7tROCtHmgniwJjmQdipkJVyA/uIie55R1W6+LaHxS/Dlp36
 3dM8QkiDy7nxSJjddX6aByKVnFRzUYZsGcgtg9R5421jr6zaLu7cIPs3fZuJmZ0O9alNq+Veuh0
 1io6iwma4AIMNfGwRY495YiMmkltNnjDG4hPCn1N20zGdBzb51RrX2aSDXA=
X-Received: by 2002:a17:907:20e4:b0:c40:9b75:84af with SMTP id
 a640c23a62f3a-c513a5ec7cbmr1173636366b.8.1795632496938; 
 Wed, 25 Nov 2026 10:48:16 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:48:16 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/3] i2c: omap: add support for DMA
Date: Wed, 25 Nov 2026 19:47:45 +0100
Message-ID: <20261125184750.57866-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski
---
Changes since v3:
Some minor changes to fix the issues reported by sashiko:
* resize_fifo: changed type of the `size` argument from u8 to u16
* xfer_msg: fixed style of the REVISIT comment
* xfer_msg: implemented fallback to PIO if DMA transfer setup fails
* xfer_msg: disable the DMA request as the first step of the cleanup
            (instead of the last step)
* probe: introduced intermediate `dma` variable
* probe: all DMA init errors except EPROBE_DEFER are now treated the
         same way: dev_warn() + fallback to PIO

Changes since v2:
* dropped patch "i2c: omap: remove unused is_rdr and is_xdr function arguments"
* added `omap_i2c_disable/enable_pio_irqs()` helper functions
* probe: added `if (omap->dma)` before the DMA free
* xfer_data: signal DMA completion in the case of NACK interrupt
* complete_cmd: signal DMA completion in the case of bus error (e.g. AL)
* xfer_msg: removed incorrect checks `if (!omap->cmd_err)`
* xfer_msg: added handling of DMA/IRQ cleanup in the `b_hw && stop` path

Changes since v1:
* new patch "i2c: omap: remove unused is_rdr and is_xdr ..."
* probe: added `goto err_dma_free` instead of `return`
         in the case of failed `i2c_add_numbered_adapter()`
* changes in XRDY/RRDY, XDR/RDR interrupts management:
  - init: do not enable the above-mentioned intrerupts
  - xfer_msg: enable the interrupts before any non-DMA transfer
  - xfer_msg: disable the interrupts after any non-DMA transfer
* xfer_msg: added checks on `omap->cmd_err` to catch
            NACK or AL error occured during DMA transfers
* general: moved scheme-related macros to the top of the file


Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 377 ++++++++++++++++--
 3 files changed, 370 insertions(+), 23 deletions(-)

-- 
2.56.1

