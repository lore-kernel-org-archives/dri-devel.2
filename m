Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3863606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c40YX/h+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B2310E3DB;
	Sat, 21 Nov 2026 10:25:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4823310E3DB
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B76EF61230;
 Sat, 21 Nov 2026 10:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F651F000C0;
 Sat, 21 Nov 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256743;
 bh=mNDeg6YvrsPOdQUVy67PCCRbJ3kSBV3g3A++Aptm3nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c40YX/h+QhmxT+ESd/lYr6t8a3wmgjO1B3Xs1PwVa2Hto18FliHI+37+AhOaCezWh
 /4urgXF5XKeOgtSiinX+02kGcEIJZLz9dxBORg4STpJBLpLZnUHKq8JSiyoGTIJTeH
 GgDcjWnYCAbTBGrwoVYu3X4td8GIBSDatDvsXpmZ8+BDttJq/LC2RX7n3WCUQYkeqJ
 6niQ+VwzZfaM/X74RHECES8SVCxj8IW5U/qAmsksrJJQgyyb0kTKNimMaPQ80mndod
 c6mgLaVbyLWsaZtNZzHFf4+T1zOjY9cizGrLW8Vvg2yZeWdSIZQC7W51od5XNYtbBk
 cGHlDq/zRUcMw==
Date: Sat, 21 Nov 2026 11:25:39 +0100
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
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB
 Type-C
Message-ID: <20261121-vegan-okapi-of-karma-9b4ce1@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-10-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-10-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:48PM +0100, Abdur Rofik wrote:
> Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
> 9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
> QMP PHY orientation switching.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Don't split logical patches into multiple chunks.

Best regards,
Krzysztof

