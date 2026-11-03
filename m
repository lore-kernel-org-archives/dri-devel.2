Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26100606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=d5FF3TuT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF2A10E75F;
	Tue,  3 Nov 2026 01:39:55 +0000 (UTC)
Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE2A10E75C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:39:48 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=mNEuaRcpsX0bT1HmxTiLkgvZnDYXGr7bXi1UzYrBtz4=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793669987; v=1; x=1794274787;
 b=d5FF3TuT2Zu9DYOkBbs09Xg5jsT5KyE8npDhSUb5pudzo3Fh5x/9w+YpjGyvLB7oHb5TvC3F
 lDCknDOSNW0RfbYNLKpVH6EFfJbYlz/ApX5yaLSL/AdSW5rQ6CmPVKvTgh6MHzUHpo6qSLT0ui3
 NCioOThCNeJlwfBSdoIX25uzM293+pSV8BgyKvu1L7HvJug5Rm//4AcvtaAXUb/qMXJfzYQh7ek
 9FLSSLz4fODeBkn4YuevTHpbvQqcQCitlVsW00D/6OWAaOGk27r2/Pl8C+Ekpqmc3Xo2a973Zr0
 lygNrxNrnlZeo+kKa/5zRGreundbZeK4rbDf3vvifDy2g==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 59de2e7479788338;
 Tue, 03 Nov 2026 01:39:47 +0000
X-Mizu-Trace-ID: 59de2e7479788338
X-Migadu-Flow: FLOW_OUT
Message-ID: <07d29a8c-1caf-4041-8c01-845a51d11a68@packett.cool>
Date: Mon, 2 Nov 2026 22:39:40 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Import a680 hwcg sequence from kgsl
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261103011358.65398-1-val@packett.cool>
 <20261103011358.65398-5-val@packett.cool>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261103011358.65398-5-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:13 PM, Val Packett wrote:

> The initialization sequence for a680 differs from a640 in a few places.
> Match downstream by using this a680 specific one.
>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 56 ++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 6c154792cb07..48197a54984c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -9,6 +9,7 @@
>   #include "adreno_gpu.h"
>   #include "a6xx_gpu.h"
>   #include "a6xx.xml.h"
> +#include "a6xx_gmu.xml.h"
>   [..]

(As sashiko confirms it's not a good idea to try to write the gmu regs 
from here, shouldn't've gotten lazy and assumed it would work anyway..)

I can make the gmu driver write these on init, but would like to know if 
they even do anything interesting, and whether the entire hwcg sequence 
is worth it…

