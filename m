Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE2606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=feOWIR+T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D8710FD12;
	Thu, 19 Nov 2026 07:49:05 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B028010E192
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:52:50 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c50cc7540b7so214347266b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795035169; x=1795639969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
 b=feOWIR+T0sLSQURQPRLDwHWHfoL25HlfFJdWlQGhJZ5vt2+OhrE/kupASvZ5I6GobL
 1P82wiO1DV1940nK9ThnZSEB2KEWH5CGHWJRARPmyhnDXIKgplVTTMrRVKlwHxYvYCFx
 MxmpaBgL3lNYQq142wla7EA63WCHFEzfRQf/95/USuFBe6VxHfgcPpJM1LuV+YSld8L1
 M5Gfoe2+6ixMSe+p4rL5wj65Vx/WT8eDd5hB1Idgtt+6VbzZOY2uxS6/sVo9hcYZPD/G
 S+LQfzHj/EqME7claD4b06N02pEXFsXKlcnNjJM7u8E+grgtz/XPHuaCAMmKFXz3HM1X
 SZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035169; x=1795639969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
 b=G+3jnXNAquet7MOYIeajlFHIw+lCezDimk8DGP/WwTDCU1vg3q/5RI/ZwtwdoN7qgi
 Qq6neXDvAOs56XIG4938HrXFW7u+S4GJ0AtxNMnJtxQKwJD0taJjxD8b5rrPl/WiYcVJ
 BVaKL+K7KUiGG2StgYaXQ0QxVW8i/Ul4mTqSz5Q9kuTXTr06tEGkSzH4WunQuPBugphf
 1tx9SY2NE1yfEQhvqL6jCGQYWECTJNkddzQ+z9qgoXRJjLpJf5c7G/coA0Pw99HKnDlW
 GRjzQd5DLBQnXtOgEjyJXRI2n+kKwzDB6bLTwPxea5M43yoBff+QCDsbs/ypJ3613GTW
 S/Rg==
X-Forwarded-Encrypted: i=1;
 AL+hErHoUFbag3ufYXbbNmy7OC8FlNLuzXOPyqORD0dz8JMJb3xeW5T9bieuDaEiEYRll/RkM2JVwTOrUjw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8zuEEYFSw5TuEOrpsX/6N05GrUDSK0aSb6T/UwdUJhScXOLGy2
 hqY5qWCAyNj1S1kQAo1gXohSyp4LX0i77gwhui3ihOx4m8Vw0a6yXbI+
X-Gm-Gg: AYBFou3RhcaEBER0xjNHEfiw5u15p5kI1GO4k60ndbjGMhOvU5xgI664lcRlqI2grso
 Utv9wFczvGwgmArQjFfI8plvPEo51X+tuY8WKIHK564+Xg/KZg5wJ4pAqsLYPuSNxiUHoTqRG+R
 w0xnLDRSnQErRAsepgpFWgBC2OcKTPCENnMLQGpFjPaUgiBBw1rwbnZcXewWeguOrneMDmBxfF0
 o+sJtnU/LGmdH5oSX5q0QXbHx7/MV8WDYOxprYj7bobfOWdSxSOPtq8jU6UlCZ39n43PRBJf0HU
 u2BQxK6sZ2BiT6nqNikiWWOKYNgJTHGSM6TgKcw0d0V4yMkRcFlwcOw+MDW1NyhNj1OD+Eb06FI
 0Y1SQD7DmFML7H1VKzb0vOi21WDD7EALTxiGVBDsqQsRFtYwx6N2TgfdeUcPMQ+S8iE7iNbnzi5
 92HCXAoz1Cn1q3F1yUVboDmguPm5mTx1gWmvhmaxxwSl5vC0ZnZhrpmDnt0m1dDaUi9d25JGDVF
 mnELukXvYmqVMvdA9WEvI2+IekTTJsyPD29g/BKuXtXL/LmOdoiMj4S+kP55mftQsrif4XnRJ/r
 SH2qPPHrechasetnheNlpRdpH3hQrDYcsEOas0mipwcQ6YPgqpI1utQI84hJsUWH6pNd1okTRSG
 PpCz14lM=
X-Received: by 2002:a17:907:1ca6:b0:c50:ac4e:3770 with SMTP id
 a640c23a62f3a-c510e516a2dmr391250066b.34.1795035168876; 
 Wed, 18 Nov 2026 12:52:48 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:52:48 -0800 (PST)
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
Subject: [PATCH v2 0/4] i2c: omap: add support for DMA
Date: Wed, 18 Nov 2026 21:52:03 +0100
Message-ID: <20261118205213.88778-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
Also, I noticed some unused arguments in the receive/transmit_data()
functions, so I added a small cleanup patch.

Kind regards,
Antoni Pokusinski
---
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

Antoni Pokusinski (4):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: remove unused is_rdr and is_xdr function arguments
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 363 ++++++++++++++++--
 3 files changed, 350 insertions(+), 29 deletions(-)

-- 
2.56.1

