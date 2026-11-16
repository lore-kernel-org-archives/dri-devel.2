Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96A606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfPaonkH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4C810EF35;
	Mon, 16 Nov 2026 10:39:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3E310EF32;
 Mon, 16 Nov 2026 10:39:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBAEC60D4C;
 Mon, 16 Nov 2026 10:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A2B1F000C4;
 Mon, 16 Nov 2026 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825570;
 bh=TMelqXmuFWpq266Nr/pmiKLHwnbkJ+vOhcI3eV5hwDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jfPaonkHOoYzcERjBg2syjUH1ZjbOZW510AZoG3aEu9g6XfzbK7P33m9ATRC31esW
 Xdy9/p9SL1vp5YScPnoZkhd8sVwgcnULVsMki3bbR4zQefs8PpiDZuz0ZqhCOt6RWp
 ENGj+45YyD6EKciWwBHU0oBFk9rPTStNk4HVH9AirjxPTr0eor9hBctsI1seXZ2+Zu
 4/mfcU4KVWiVz273BitBNYXa7+D314Sy8pztPLGBhohMUyVcesjgCXt9TlGh1Wzrwk
 Dn8KStfHUrWAEq6iE0wEG8R/m9M+PT2AOFE6fVlIk7R74aliyfOqErZCgZ0efGghdr
 fWDFAvIqvWOTw==
Date: Mon, 16 Nov 2026 11:39:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
Message-ID: <20261116-flexible-uppish-uakari-3f1b07@quoll>
References: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
 <20261113-msm_gdsc2-v6-1-17adbce47220@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-msm_gdsc2-v6-1-17adbce47220@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 04:28:51PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
> MDSS hardware and most of the DPU, while INT2 GDSC supplies the
> VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
> remain inaccessible.
> 
> Describe CORE and INT2 as power domains of the DPU device, matching
> the hardware partitioning. INT2 only supplies DPU-local source pipes,
> while CORE also remains attached to the parent MDSS device because it
> supplies shared MDSS hardware. DPU performance-state votes on CORE are
> propagated through the genpd hierarchy to its parent MMCX domain.
> 
> Keep the widest valid constraints in dpu-common.yaml, including the
> power-domain-names definition, and narrow them in the platform-specific
> bindings. Require two domains and their names for Kaanapali, while
> retaining the existing single-domain constraint for all other DPU
> platforms.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

