Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892C606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4lNHNVy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18F510E117;
	Sat, 21 Nov 2026 10:24:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493F810E117
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:24:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05CEA40654;
 Sat, 21 Nov 2026 10:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D6C1F000C4;
 Sat, 21 Nov 2026 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256660;
 bh=dvU2agkWKdY+B0Mb/5zsIWJZhSUgLNKBkVFfFC4SWtk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q4lNHNVylWtL4GS8mdKI4dUBh+SgDAHv3vIw8RxSOVFSTZicaxYc0EkLQ8ITIZz7g
 pm309MI9qE4h+EYJQjuHAiGTXsPJ++/1WmTq1KLY5Kyafh9ToisQAwYGMBWCe0dUI9
 Y2uvpmut30rON3LFBhGEsXlsTTiG2ev6ooC5KLOfdK+sqYn+54FWWCU10kE+tDlxLE
 +Nr38O/avTk6iljaF1HOdW3gm4DU9qT0Gum5Ajr378hJ/94pj7Ldkd/8fkSbZRtWu6
 umCVA8LqfWUI11AAAp0L3wHGcDd1172Om/Ohyn+nAWVbRzzdDZs4KVasm/b+66Xlw7
 rgtbrkMGg4bWg==
Date: Sat, 21 Nov 2026 11:24:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
Message-ID: <20261121-first-fine-python-68fef4@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-3-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-3-rofikcoga@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 04:54:41PM +0100, Abdur Rofik wrote:
> Add initial device tree and MAINTAINERS entry for the LG V60 ThinQ 5G
> (timelm), an SM8250-based smartphone released in 2020.
> 
> The initial description enables:
> - Memory reservations for bootloader and firmware log regions
> - Simple framebuffer continuous splash reservation
> - Volume Down and Assistant keys via PM8150 GPIOs
> - Volume Up key via PM8150 RESIN
> - RPMh power supplies across PM8150, PM8150L, and PM8009
> - Storage via UFS 3.0 and SD card via SDHC2 with pinctrl states
> - Graphics via Adreno 650 GPU with GMU and ZAP shader firmware
> - High-Speed USB and SuperSpeed QMP PHY
> - Console output on GENI UART12
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  MAINTAINERS                                   |   6 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 592 ++++++++++++++++++

You need to slow down. 10 patches patchset sent twice that day and
before every day.

>  3 files changed, 599 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ccbcdc0799b9f..80c1bfb66f8cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15211,6 +15211,12 @@ F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
>  F:	Documentation/admin-guide/laptops/lg-laptop.rst
>  F:	drivers/platform/x86/lg-laptop.c
>  
> +LG V60 THINQ 5G (TIMELM) SUPPORT
> +M:	Abdur Rofik <rofikcoga@gmail.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	arch/arm64/boot/dts/qcom/sm8250-lg-timelm*

That's the first time one adds entry for individual boards for Qualcomm.
That is fine for me, but in this case - three days ago you never heard
about DCO and did not even read the docs before submitting patches, so
honestly - too early.

Best regards,
Krzysztof

