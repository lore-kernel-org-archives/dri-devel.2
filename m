Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FE606A883
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSbkD8Ef
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A4F10EA51;
	Wed, 11 Nov 2026 17:27:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8369B88EFF;
 Wed, 11 Nov 2026 17:27:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AC0545732;
 Wed, 11 Nov 2026 17:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D56F1F00A05;
 Wed, 11 Nov 2026 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794418068;
 bh=UKDVE9TLs7/zbZ30VM6Th9gaEU7UkVx8isyzwkCr8x4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kSbkD8EfoKGJqcP7C+w4qDgcT6TDVLfY0vH9Uor/GjV8Qnj8Xkwk0ymMBqgw2JoLt
 1/2kaWfH4Nr1IRboHJp0/ASIU2F2IggYskrRsiaYrXta15f5em2qKOyfyEfDl/JXd/
 GiSu1Ar6MmmlTQFqpUpE0eExmoIAJssb0S4vmieoy1WXVNxgxhAHv4DkRQkcBJ43UP
 5YmyoElS4yRWXVrDW9ggdA837qYYdR5LL9WEWcprrQ8EmM4gbGW4wrEx+Ac/rzpD4r
 2ZpHFIkIMbL9RD2jajF8Bvm1CwF6+UyFiygukfyFWg7LokVgp9UOnLRysUKMxxKz72
 2hsDczFzlZ7kQ==
Date: Wed, 11 Nov 2026 11:27:46 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 freedreno@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sa8775p-mdss: Remove
 bouncing Mahadevan
Message-ID: <179441806600.72167.8413609787157851282.robh@kernel.org>
References: <20261110130255.134252-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110130255.134252-2-krzysztof.kozlowski@oss.qualcomm.com>
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


On Tue, 10 Nov 2026 14:02:56 +0100, Krzysztof Kozlowski wrote:
> Emails to Mahadevan bounce permanently (error 550), so change the
> maintainer to DRM MSM maintainers (Dmitry Baryshkov and Rob Clark).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml     | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

