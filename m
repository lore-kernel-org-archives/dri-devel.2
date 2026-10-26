Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=j2wqjV78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F39210F1D0;
	Mon, 26 Oct 2026 23:04:47 +0000 (UTC)
Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F269C10F1D1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:04:41 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=VpHtdEItOfBeyzi/S7o4HPEf4C+PK1AXEFD68qJcQMU=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793055880; v=1; x=1793660680;
 b=j2wqjV788SXMn3EMI1d9VoRkEPsswMQKmBNfnmU/GJMrMXFgLZ/ZWwwm6uaASqpulhEZJIaq
 W5SKHmfjg2vlkFg2HEeyKAvHbzz9ycD4QhnAPKOc9mA9wFioC3jqDCsVExYnUZKxCuLMN5mszAA
 wQNCjQEM0Hs7Jgn7F72vxCrImcdCx7ZbimtALvIe39UNqObL/fh5NI9pf1QfzumNitt+B6y779Q
 Mfyt8NIOPVdBgBVMjD0gCx60TibYS00Pji2p9pXiBNU/+46/v1dJd0PfMHt1VnNMPr10dh0qPKb
 nbcXtvgPLiME4i/fm+J5db9nOBhdRhOyebosEtFfAPIRQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ca2d3fc45a918743;
 Mon, 26 Oct 2026 23:04:40 +0000
X-Mizu-Trace-ID: ca2d3fc45a918743
X-Migadu-Flow: FLOW_OUT
Message-ID: <498e2fa8-b707-4a06-9fe7-9e62253786c5@packett.cool>
Date: Mon, 26 Oct 2026 20:04:34 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/msm/dpu: reset unassigned resource slots to
 NULL on topology update
To: Xi Zhang <xz.ca.cn@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
 <20261026-msm-dpu-res-clean-v2-1-3d864435186e@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261026-msm-dpu-res-clean-v2-1-3d864435186e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 10/26/26 5:25 PM, Xi Zhang wrote:
> While this is not currently the case, it may be possible that topology
> for cwb and dsc resource requirements change between mode set in the
> future.
>
> e.g. when dsc support is added to DisplayPort, dsc may be optionally
> enabled and disabled between different modes due to
> bandwidth requirements.
>
> Set unassigned resource slots to NULL on topology update to avoid
> issues in the future. It's good practice to do so anyway.
>
> Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0a6be69a3e83..8d2b4d2726f2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1205,9 +1205,13 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   						       ARRAY_SIZE(hw_pp));
>   	}
>   
> -	for (i = 0; i < num_cwb; i++) {
> -		dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
> -		cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
> +	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_cwb); i++) {
> +		if (i < num_cwb) {
> +			dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
> +			cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
> +		} else {
> +			dpu_enc->hw_cwb[i] = NULL;
> +		}
> [..]

I've mentioned in a reply to v1 that this was indeed affected by the DSC 
changes in radxa's WIP, but missed the more relevant one:

This is already handled by the "drm/msm: fix SMMU fault dumps" series:

https://lore.kernel.org/all/20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com/

Namely patches 5-8 ("drm/msm/dpu: clear the ... blocks ...")

Thanks,
~val

