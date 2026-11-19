Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470C606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ7B4MPs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C9B10E8C8;
	Thu, 19 Nov 2026 22:13:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474C010E327;
 Thu, 19 Nov 2026 22:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F63D62872;
 Thu, 19 Nov 2026 22:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975A01F000D3;
 Thu, 19 Nov 2026 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795126412;
 bh=lOSd5J4FCYgX98Se5iiOkvY37YVWiB+QhTNatsC3gsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WJ7B4MPsIts0ax4y4MgrqQg9BS9ZXVquYhA2B6DQWXw4T8Cxcpnoi6Sw86Zh1nNo3
 ATd+jKwpGh32JtYrV6IkCwV8DhDJ0nDLbrbJz6ZGKawnjZVdyRp+RmSujCba15K6RS
 xKVQ02U+sTue8TZWkVVjVyZUePAsCag5V2o3z2U3Sj91YIWVXtKSiBf3xrkPtv4GII
 8y78ruxFi5/8zY993oJtwr2uCer5cu7O6wttZ9MYdCrHJEvh0aRPkZGt6ykcaAGM49
 +2XhANmBzOJ3gTihCUrg14zY1JScWAy+AFpPm53whHoKVArcterfTHCEysAJFBi3u+
 Y7QKQ5CS902/g==
Date: Thu, 19 Nov 2026 16:13:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Demeter Barna <me@fromdisposition.org>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 David Airlie <airlied@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Simona Vetter <simona@ffwll.ch>, Srinivas Kandagatla <srini@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: qfprom: Add SM8350 compatible
Message-ID: <179512640965.935436.17254466813902279332.robh@kernel.org>
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
 <20261105-b4-sm8350-gpu-v1-2-a7175cdd6512@fromdisposition.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-b4-sm8350-gpu-v1-2-a7175cdd6512@fromdisposition.org>
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


On Thu, 05 Nov 2026 13:30:01 +0000, Demeter Barna wrote:
> Document the SM8350 QFPROM. It needs its own compatible because some of
> its regions cannot be read, and the driver has to know which.
> 
> Signed-off-by: Demeter Barna <me@fromdisposition.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

