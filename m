Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1219606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsS0fMdx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A0C10E60E;
	Sat, 21 Nov 2026 10:26:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FF710E60E
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04826611B2;
 Sat, 21 Nov 2026 10:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49771F000CF;
 Sat, 21 Nov 2026 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256759;
 bh=MSk/uVkQyfUVhAgt2eCEE3LaDy/K+jEkqGBhIcy+lD8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BsS0fMdxleqFnsJwCTuV2102PxgMUABBW/PoBag/xS1dCc9qRqKeiEwMMM27QJC35
 fhqO0urH6WPxMpgo8mcsAi71SXrWZomy726Qy4r39DfWvhZCoqvFfHUk8F4wqXC9RN
 nPHmEwypNKXSpJ/f0GN1xrP3CE82MrlmNTQvLtJXkuj7XijFZSPn0m3ZaCK+6lgorp
 ieA//znJ7F1UW1SuHgZO3NHGeo3UxsApZ2dDasrm3iZ1R1jORq4cNOTB43reuxGASK
 PMMCsO52sgeVTpIgzRTGHnMupkSYA9BTYEcmmeg2WwBkDO9th9+OK1MujuVhWHqBiM
 7JDEdAvorECPw==
Date: Sat, 21 Nov 2026 11:25:56 +0100
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
Subject: Re: [PATCH v5 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Message-ID: <20261121-glorious-apricot-bird-4dfd91@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-11-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-11-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:49PM +0100, Abdur Rofik wrote:
> Describe the QCA6390 power sequencer with properly voltaged supplies
> and enable Bluetooth HCI on GENI UART6.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 

Not a separate commit.

Best regards,
Krzysztof

