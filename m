Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7764F60A3807
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A8TBUZHc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF49E112C3E;
	Fri, 20 Nov 2026 18:59:54 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17212112C3E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:59:48 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so506207666b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795201186; x=1795805986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
 b=A8TBUZHcmDT83P7qEdFvHTs9ShAws5jKY/5yc7QuGw8KhHK5bEcVSudhyGqkrdGMtc
 N65qoEdOEs79PYb97dG5dn0OLSfDrBqJ1Pej2gFH+UiffGIKVunBh38ykfUObrcM0GJo
 tgIarKLOdW1Iu2M5VQE1R0DgZw6l5yTBglcd2hqZq01gQU7Ob1g4AjgGnwxHVrFhHi3H
 AWJIvGHCYxdhsK98/Hn427MJxoIo9qaDhETVupJ6HNWwTud9Tu0xDS+moX3JyqKNMjZY
 MaMkTl6yarobhmNNudV/rjY1I/LJVoMk65zMXbNa9tBJD9jS4jDHLrB/n2voe/i+69tS
 W2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795201186; x=1795805986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
 b=dp97o4xw0Q5VHjkCRxj4D9mAQvJFW/mpVke2UaWSjZ3uZb1r+H+2xO8W/zScHtenWN
 8rKyOHD/llVak99swnnpGNKtCuru082DBLHJGYDPOVAj4UwtQgU+xwJbMa6/WDyoiL/H
 m51kgHFZ4KboCvfPz6qf+RO2fFe/taNB3UjFMdTQ2ajd6OyGgTs3bn7WYAUJamn7hAQT
 CcPV3afiKLVsNMxrcPkclETrf9KApoWwHPghmquX/XNU+yFg4beINooqkHhhRbq1bGgx
 Gx1bDZBvAi+B90ds9mIYGPHJ9aBlpIj/B5hc8NEf64OAnJKBDl17qSHnMdfDEhpHJvI5
 dsvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHu86qmT+En3ouzmOCtkYLELKO0BTSJ6FPHg11cmZhwflfd5wOlITDEZdI4kAqU5tiviqVkhYNg0FI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8DXHG7ndaU/xDfmvGhBbx3NostpyKzpB8I/T8+CATq1vu90qSz
 hmpCaOZahRv7DhtKlcYJpe56PY/O4Vuwd7sW/ZDODaY2EH3CDB8LNlCm
X-Gm-Gg: AYBFou04//Vkp7HHHs8QFGCx1VTUZa9NbIg8APWs1UMHkIZPC6TzM3q/v6MeFBmxx/0
 a8IhL3DiTKIN3CMtoqZMmpQE57B3dn8dyuXNEZdA8qpJNahsPm545CPOmtwwW+VGP/GrDNsU+mc
 XGjeEjoNnOO1u5dGrSR/p3r7TeZ7xhKdoe2++8GhzJ5ZZtxEQbkFauDSW7X0KO54ijqw1HmCqiv
 asiGrn72VdvvrgOoofHQz879QWqBtoGl1a9oWiVeyVFpfs1ceuWrBS8PxM6Zz+KsdKfebNrQxPE
 J044L8QMo9gM5R87daIRzWQTOZFGLKUlbMJG4Xn0lKrT6P6R8Rp0zmx6QuCWwEN/PiMg5uqqSOX
 yFHmf0s1Kcm8FYK/PP1pp4g5HYv/4Vxh5KwYOHrPULuXAJmjSMr+Jkoj71QF6tciZLHMQQkpqV0
 YkGtJ4prUHXceoC2ri8ILDw8AaccnldbMLn58gSQRsJio+OMedYpafnxVKeK/G1IGHYY0sd/vz0
 xKNYF48ujlAw/cYl2UW9K2qGJo+mofpdRaSOMqyVQUi3DeOuMtEBZ9+EoyKckd3wiXmln0hhNeq
 P0LppSt+2cLbAjlxynLgO2L6HejlYud/Dl4DcVqzMRKlCl0dtztxzMNKCxoB0QE=
X-Received: by 2002:a17:907:2d23:b0:c40:2439:4d9a with SMTP id
 a640c23a62f3a-c51319c24fcmr565365066b.28.1795201186217; 
 Fri, 20 Nov 2026 10:59:46 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:59:45 -0800 (PST)
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
Subject: [PATCH v3 0/3] i2c: omap: add support for DMA
Date: Fri, 20 Nov 2026 19:59:10 +0100
Message-ID: <20261120185915.150228-1-apokusinski01@gmail.com>
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
 drivers/i2c/busses/i2c-omap.c                 | 373 +++++++++++++++++-
 3 files changed, 368 insertions(+), 21 deletions(-)

-- 
2.56.1

