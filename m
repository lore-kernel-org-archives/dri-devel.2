Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98550606A325
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnU3Y4Xs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BB410E050;
	Sat, 21 Nov 2026 10:21:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5630010E25E
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:20:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C39A4040D;
 Sat, 21 Nov 2026 10:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F91F000E6;
 Sat, 21 Nov 2026 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256457;
 bh=PBpuaU4ZDQrnpSnbxJPolIK00ZR9E921mIZ9nlUSwCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RnU3Y4XsE0fMQzt9mlKiq7UR/qJeV3o5+mKuONYtx7rgqkHLRgaOyxFg22FZPCt21
 Hx2TRMWTSfjSPalRtTfH3Y1/AWR+v8vX2xCyReNwfKx0kkNGMwW+2T6+9utriTBY0Z
 fHUyOpmNKuSkQEGLErZNSn/NzLv+6axlv/UWchCSL7SCrH3YjjBgIlYKKHG87ZF0Xn
 YEQnZIoNMz1rRh9d5eBcPYhOCUMJI8DkBSuENsDZmSiWhpblTZV3YSc5GGw9NDzyaT
 //Oz6Y0VsoMFdiLA7OqEd+3EMBwQ24l0j5JTN6xMXVulJjuYHUlZtrSn23xvlv/VrB
 0illTsdzUizVg==
Date: Sat, 21 Nov 2026 11:20:53 +0100
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
Subject: Re: [PATCH v5 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G
 (timelm)
Message-ID: <20261121-crafty-mysterious-degu-50a9dc@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-2-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-2-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:40PM +0100, Abdur Rofik wrote:
> Document the compatible for the LG V60 ThinQ 5G (timelm), based on
> the Qualcomm SM8250 platform.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

