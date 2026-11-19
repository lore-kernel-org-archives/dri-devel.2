Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E+P1sIxB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502C910E55F;
	Thu, 19 Nov 2026 08:19:54 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D186310E55F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:19:47 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so16759805e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795076386; x=1795681186;
 darn=lists.freedesktop.org; 
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p+dKc+IASGuU74BQrkjO8c1LFAuMGojRAMZOBhZUcyk=;
 b=E+P1sIxBA5Q3l46a6EGUdEOAr1F/IES6FWyBKgF/Dlc0RZzpwYq/fryTgOrieNRV1x
 Zo1II/3hkl4Wph0A5/1YqYT3fhfcAkbtiEt07LdD5+37XTjeRMJAgSZpSPaTCbV1AOwS
 RxScWhlIXyghNEtJzKB9bY0cR9GifTKPpl3keoJbtYYqV/dyS47RFY4eWYB1FSu0sD/x
 B6MUqkCDpA7rXLlmwNFgQAHoK/GgLZGg8WAi4KI9PW53Q+UMe0Ud9COy7G8X4vWYYk2/
 xACEE3hvO+LriKlI/EDYpGmSHKv7vrWIMLjGLAf6e0KLjp0A8Sg+sC0926DP3EIwTVW6
 MrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076386; x=1795681186;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p+dKc+IASGuU74BQrkjO8c1LFAuMGojRAMZOBhZUcyk=;
 b=FbahD0zlqqUduAxHu/HYOQQ4GWcb0DWAJxf/IAvrK0T2spcGbNXJsPsYt+Vl3INCRT
 zrbm7PcKnDRBpsVUkv+YzB8XMNPK8nS5X6DXjs1NH+ceosWY2YmKnIo70SiL5R6FZZF5
 Kmrfqq9qlFNcvzw3NtH1pKr4NH8BhAj0m5x0jhISZeAmB/rSsmrHySTURwfnhB9ZUEJT
 owll+prv99SNtHkwUg5uv2vss8uj/QbFWy1CDwHmFo6S4HyCg6tSZMmFC/1FKaJbSCsY
 uuHWaDfVsjmT9zMw4UANqjNQmTmyF4E+O+3OX65plG7GTFM5ZY2h0bfuGjPCHjBXX/K7
 i+cw==
X-Forwarded-Encrypted: i=1;
 AL+hErH7NLAaEcGLzFiL4O9kjC+7iVniiU2Nes38MfEkPOHaZb13nLJgiBBGhr6GmjRZpXT47rcl39gRThE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cRvda0NW9BUp4yn2dzm+/ET5g8EXWTyp8xKcpChbMyByI9Iip
 Y6xFHC2nlgn/deXAJW2XoOe8jlQcKJ2HA+7mFLZ1RdLB3b8WbsRU0wtmosLL5rpuQfo=
X-Gm-Gg: AYBFou2LR7/7bmAtFU/eVXRA8GI/GUBmNSOY3KN1kFRgiScK9VfDewHTUFu/miTDxhs
 Mh2WlzRblSIr6nBLihP/5dGSRWNl+KR3g/mhiMskyUFR5bp+ApvJBjldrBbnvVDNHRxZW6fEd84
 0WcA6CFrHcKfPQvWJ90s29ZFgMHuf/tOTTZShHzpJ4vUrUVCMP9He9XtGg36IKc53cRR+1y1z/G
 C1ZG23vnbO+CxeZGMXRdezd5KaGwmjD3FLcO3J9t8CpHwvmu2FpqAHH/imPmVhf13xKgK9DlMXr
 kc97evYYd0EzmNJiaMhL9ZTxYodjGmJvjAYZ2Yz+3QktCMJznAuYm+MAFNZ2BseHAfLwAdznhXD
 N9X9to/nhh/d+4jlwQGOeT/9WSBA806vN1edukozgiM+nrc0MGMuQdGVbXJ4pWSYs94nqxr7JXZ
 sbkeVc1OO3LDJcU0lDKJUBwmwd2WYcpcQdl53bMudgpGFwGL5DxedlCTG0dQJML2msa0J9pNv+R
 kVNh60Sz32ppxhAXIyHsH4rx4dnrJ7gJC1Hi57KQ8SEm0kzornklxo2OJUfjb9U/5aPEhSPT4Tf
 h7q18iML3s9dYtds762ztkN9dn4jZhZO1UDK+HmEAKHaoEwV
X-Received: by 2002:a05:600c:8b63:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4bb7da27088mr96761205e9.28.1795076386236; 
 Thu, 19 Nov 2026 00:19:46 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e5656asm17330585e9.3.2026.11.19.00.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:19:45 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Gregory Williams <gregory.williams@amd.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Oded Gabbay
 <ogabbay@kernel.org>, kishore Manne <nava.kishore.manne@amd.com>, Izhar
 Ameer Shaikh <izhar.ameer.shaikh@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
 Ronak Jain <ronak.jain@amd.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/15] accel: Add AMD Versal AI Engine driver (with
 Versal Gen 2 firmware support)
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
Date: Thu, 19 Nov 2026 09:19:45 +0100
Message-ID: <1jcxs12py6.fsf@starbuckisacylon.baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On mer. 18 nov. 2026 at 15:31, Gregory Williams <gregory.williams@amd.com> wrote:

> This series adds a driver for the AMD AI Engine (AIE) found on Versal
> devices, together with the firmware changes the driver depends on. AI Engine
> is a tile array based accelerator used for applications such as beamforming and
> machine learning inference. Tiles are organised in columns, and groups of
> columns form partitions that an application requests, initialises and releases.
>
> Several registers in the AI Engine array (column and shim resets, memory
> zeroisation, tile clock gating, NoC and interrupt routing) are privileged
> and can only be written by the trusted firmware. The driver therefore
> packs operations into a DMA buffer and hands it to the platform firmware,
> which executes them in order.
>
> Firmware patches included
> -------------------------
> Patches 1-10 are not part of the AI Engine driver itself, but the driver
> cannot work without them, so they are included here to keep the series
> self-contained and reviewable in one place:
>
>   - 1-5:  zynqmp firmware driver refactoring and a va_start()/va_end()
>           fix (patch 2 carries Fixes: tags), preparing for the extended
>           SMCCC call format.
>   - 6-7:  Versal Gen 2 compatible string and firmware support, where all
>           EEMI APIs use the extended SMCCC payload.
>   - 8-9:  Versal Gen 2 clock binding and clk driver match entry.
>   - 10:   firmware IOCTL support for the Versal Gen 2 AIE run time
>           operations, used by the driver.
>
> I am happy to split out or reorder the firmware and clock patches if the
> maintainers prefer to take them through their own trees, and would
> appreciate guidance on how the series should be merged.

For the clock, it would defenitely be prefered if you could split out
clock part, especially if you later need an immutable branch.

`b4` makes it very easy to handle series deps, please consider using the
related tags

https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies

>
> AI Engine driver
> ----------------
>   - 11:   devicetree binding for the AI Engine.
>   - 12:   driver core: device probe, partition request and release.
>   - 13:   pm ops: building and sending firmware operation packets.
>   - 14:   enabling and disabling tile clocks.
>   - 15:   partition initialize and teardown (reset operations).
>
> Previous submission
> -------------------
> This driver was posted for review a little over a year ago:
>
>   https://lore.kernel.org/dri-devel/20250702155630.1737227-1-gregory.williams@amd.com/
>
> Since then the scope of what is proposed for upstream has changed, this series
> is considerably different from that posting, in particular targeting only Versal
> Gen 2 support. All comments received on the earlier posting have been addressed
> or in this version.
>
> Abhyuday Godhasara (1):
>   drivers: firmware: xilinx: Add IOCTL support for the AIE run time
>     operations
>
> Gregory Williams (5):
>   dt-bindings: soc: xilinx: Add Versal AI Engine DT binding
>   accel/amd-ai-engine: Add AMD AI Engine device driver
>   accel/amd-ai-engine: Add pm ops for firmware calls
>   accel/amd-ai-engine: Add support to enable/disable tile clocks
>   accel/amd-ai-engine: Add reset operations
>
> Naman Trivedi (1):
>   dt-bindings: clock: versal: add Versal Gen 2 compatible string
>
> Senthil Nathan Thangaraj (8):
>   firmware: xilinx: Separate TF-A checking
>   firmware: xilinx: Call va_start after pm feature check
>   firmware: xilinx: Add comments about number of arguments
>   firmware: xilinx: Use match data for ZynqMP/Versal
>   firmware: xilinx: Rename zynqmp_pm_invoke_fw_fn()
>   dt-bindings: firmware: xilinx: Add Versal Gen 2 compatible string
>   firmware: xilinx: Add support for Versal Gen 2
>   clk: zynqmp: Add Versal Gen 2 compatible string
>
>  .../bindings/clock/xlnx,versal-clk.yaml       |   5 +-
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |   3 +
>  .../bindings/soc/xilinx/xlnx,ai-engine.yaml   |  61 +++
>  MAINTAINERS                                   |   9 +
>  drivers/accel/Kconfig                         |   1 +
>  drivers/accel/Makefile                        |   3 +-
>  drivers/accel/amd-ai-engine/Kconfig           |  15 +
>  drivers/accel/amd-ai-engine/Makefile          |  14 +
>  .../accel/amd-ai-engine/ai-engine-aiemlv2.c   | 441 ++++++++++++++++
>  drivers/accel/amd-ai-engine/ai-engine-clock.c | 154 ++++++
>  drivers/accel/amd-ai-engine/ai-engine-dev.c   | 255 ++++++++++
>  .../accel/amd-ai-engine/ai-engine-internal.h  | 377 ++++++++++++++
>  drivers/accel/amd-ai-engine/ai-engine-part.c  | 140 ++++++
>  drivers/accel/amd-ai-engine/ai-engine-pm.c    | 472 ++++++++++++++++++
>  drivers/accel/amd-ai-engine/ai-engine-res.c   | 184 +++++++
>  drivers/accel/amd-ai-engine/ai-engine-reset.c |  69 +++
>  drivers/clk/zynqmp/clkc.c                     |   1 +
>  drivers/firmware/xilinx/zynqmp.c              | 340 +++++++++++--
>  include/linux/amd-ai-engine.h                 | 115 +++++
>  include/linux/firmware/xlnx-zynqmp.h          |  65 ++-
>  20 files changed, 2679 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
>  create mode 100644 drivers/accel/amd-ai-engine/Kconfig
>  create mode 100644 drivers/accel/amd-ai-engine/Makefile
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-clock.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-dev.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-internal.h
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-part.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-pm.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-res.c
>  create mode 100644 drivers/accel/amd-ai-engine/ai-engine-reset.c
>  create mode 100644 include/linux/amd-ai-engine.h
>
> -- 
> 2.34.1
>

-- 
Jerome
