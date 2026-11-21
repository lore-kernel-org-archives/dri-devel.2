Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645D606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBz7WbYY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA63710E1F9;
	Sat, 21 Nov 2026 10:25:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDE110E1F9
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 605E645654;
 Sat, 21 Nov 2026 10:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909A51F000C4;
 Sat, 21 Nov 2026 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256710;
 bh=FS0SGY45488KZrZ0atpu54dpxNlj/6wagsa2k03gJzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hBz7WbYYrXorJK9xAFL6eIh9ORLC89FZ2RPxREuoxuc1sLOgkxrwxEmX2vcMO8Tdw
 8raUF4itO4NSXzGm7nNsI6d8gaqXSi0K/0o2ak1bWJ17UR7TXWYUKJUQVGY9nR3WyB
 MYq3c3m/+W8/AFGUFk0sy+EdcMIuAI7UwGqGOVWP0BkBgefRFWoLMggMuh85L87C7E
 jmh0BoFMn2lPWbcZ8EI4aBOFq7UD/i/DcLgXGN8D4CpWYslU99+0h3SzjZUDDBqD1F
 qZ3HwE8ONVRDd2qSVXATjiBNPkPRxLbScjsEI7cI7GF2cRJLEsX92+GaoEwb5dCy9J
 ju+GmBRSv5+yQ==
Date: Sat, 21 Nov 2026 11:25:07 +0100
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
Subject: Re: [PATCH v5 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable
 SW43103 panel
Message-ID: <20261121-furious-turquoise-zebra-28c6ed@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-8-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-8-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:46PM +0100, Abdur Rofik wrote:
> Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
> rails, enable and reset GPIOs, and four-lane DSI link.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++

Why is this separate? When you have your new board DTS ready, and you do
have, posting a new board is one commit.

Best regards,
Krzysztof

