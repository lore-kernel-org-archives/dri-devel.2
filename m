Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ff21BiKV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D2F10F54A;
	Thu, 12 Nov 2026 11:12:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739A411202C;
 Thu, 12 Nov 2026 11:12:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E78F60267;
 Thu, 12 Nov 2026 11:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246431F00A05;
 Thu, 12 Nov 2026 11:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794481930;
 bh=5gcFLFOOc3M6G3iV05BDCjmeiT0hNCjXENI5/wHr0cU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ff21BiKVa91jTFoi8ychwjJauN3eF1PoeEn0UuAJrEVa7+GYQ3+tcfu8iu3BtDMvt
 /9uPNcS8CjNz8QJNJm0UTpmwT8ZJy17HqtSr2HmKNNyZ9PRyw1gIDCIKI4bVQPzO3w
 gQjAqEHWYVD2z8aTjbWXP0HxPDfnBvJenuL35Cg3rk23uIawkFcCvbjvGBlA1cuzr2
 A4/RpL/qeoUhVgd7No1MSsYYu074n6aG81Z1z0eQIIs66dfloZGBCKML0zxPOjRzpG
 dO+L8fWKA0YiBtCgdo5KGyjmW/l0v68+rDVM9KJc65mcsMkMHoRg97ml9efRU+Hnyx
 rhnySk6BzoNCw==
Date: Thu, 12 Nov 2026 12:12:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: display/msm: dp-controller: Add SM7250
Message-ID: <20261112-zealous-sparkling-parrot-0e4d3c@quoll>
References: <20261112-dpu-sm7250-v2-0-8e925a3a8a7d@brar.si>
 <20261112-dpu-sm7250-v2-3-8e925a3a8a7d@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-dpu-sm7250-v2-3-8e925a3a8a7d@brar.si>
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

On Thu, Nov 12, 2026 at 10:06:31AM +0530, Ishu Brar wrote:
> The SM7250 has a single DisplayPort controller, the same as the one on
> SM8250, so add its compatible with the qcom,sm8350-dp fallback.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

