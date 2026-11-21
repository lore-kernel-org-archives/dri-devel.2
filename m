Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E832606A331
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb94tnCW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4649610E296;
	Sat, 21 Nov 2026 10:25:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9062010E296
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:25:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64A0761388;
 Sat, 21 Nov 2026 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DA11F000C0;
 Sat, 21 Nov 2026 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256729;
 bh=zcYwiYMgwHPQSKRl9NzBw2LKspoM6b+H+dLztCd23Cg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Mb94tnCWX/iYDn9bt0VqQnsMIk2qoUIRC14x9VjZlMkPCi/+ubRWhQ9kq/WIXwV6h
 YMlLbsqBU467I2LaNg3KvLo8R0fSLbaKmjo9aaC7vaMFsomO7P8f1I2yB6ROoNsOaa
 924v6loVFKQBJP0psU7EfhB24rlH9Ab5uDdFV/w7AH8ZxfMutfLEyzvC9YBp0flGJH
 cLkqYiKyKo8DDomEwCcbvLTg5qcobNTuIVo1OLMGjILjmyAfB0cWVQX2LafKqV/O/4
 b3hstB0e1qvpmyEdF2EakNa8jAvm/eKJJE+s0FIK/merQPOwZ8J7XV2DQ7ZH1jiSw7
 hJwq6mSHlUIAg==
Date: Sat, 21 Nov 2026 11:25:25 +0100
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
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902
 touchscreen
Message-ID: <20261121-skilled-boisterous-antelope-0ca5ef@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-9-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-9-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:47PM +0100, Abdur Rofik wrote:
> Describe the SW42902 touchscreen on GENI I2C13 with its interrupt,
> reset, regulator supplies, pinctrl, and native 1080x2460 touch area.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)

Don't split logical patches into multiple chunks.

Best regards,
Krzysztof

