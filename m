Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23E606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=OKUu4Ltc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC54310F1D2;
	Mon, 26 Oct 2026 23:15:27 +0000 (UTC)
Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBAB10F1D1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:15:20 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=5+C9eGmNHsPXaGlsuMgVqJCe2uE/aRlsxhqFVlOWH7I=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793056518; v=1; x=1793661318;
 b=OKUu4LtckR0cWT/Bn31ZSz+TBGR1tq3ZHdKApaCXsW+kXDiThS+o186lcjo41LgYLS+lNNx6
 jL05rxBYPJwyDN0iOTfgeR+FBIbjurGt0h8nji04a61710e8L1ol05A9QkoMkfW1lr5ob0tnxBD
 SP2ZSyAFR0xHvHgdPo1Ja0VoIfTCAYXrnDKR4nn30Lftc1U+Q8LmeIIRmABzGj90Q0DSH8ItG4R
 Ph73dtdYXnU15eJCjbrXYgc5U81+5VzuGOQDhYATlo0UGKMymxeZzPM6zsMcR8uNsij+pXtBDbi
 K4/bRyNnMYqSdT7t52F0eCzRxG1k3ShlWRLtTb8ltbntQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 05c349e6dd1b2b4b;
 Mon, 26 Oct 2026 23:15:15 +0000
X-Mizu-Trace-ID: 05c349e6dd1b2b4b
X-Migadu-Flow: FLOW_OUT
Message-ID: <cb719558-3f7e-4332-beff-b81fa31cb73d@packett.cool>
Date: Mon, 26 Oct 2026 20:15:10 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drm/msm: force mode_changed on color_mgmt_changed, 
 not just ctm
To: Xi Zhang <xz.ca.cn@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
 <20261026-msm-dpu-res-clean-v2-5-3d864435186e@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261026-msm-dpu-res-clean-v2-5-3d864435186e@gmail.com>
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
> dpu_crtc_atomic_check calls dpu_crtc_assign_resources when
> color_mgmt_changed is set, which is unsafe outside of full modeset.
>
> Set allow_modeset and mode_changed when color_mgmt_changed is set,
> not just when ctm is changed.
>
> Also would fix
> commit 42f62cd79578 ("drm/msm/dpu: try reserving the DSPP-less LM first")
> which was reverted.
>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/work_items/102
>
> Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
> ---
>   drivers/gpu/drm/msm/msm_atomic.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index a8babf1dbe0d..6f0f30b0728a 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -195,8 +195,7 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   	 */
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
>   				      new_crtc_state, i) {
> -		if ((old_crtc_state->ctm && !new_crtc_state->ctm) ||
> -		    (!old_crtc_state->ctm && new_crtc_state->ctm)) {
> +		if (new_crtc_state->color_mgmt_changed) {
>   			new_crtc_state->mode_changed = true;
>   			state->allow_modeset = true;
>   		}

This is also handled by patch 9 "drm/msm/dpu: only reassign resources 
when the encoder is reprogrammed" of the smmu fault series:

https://lore.kernel.org/all/20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com/


Thanks,
~val

