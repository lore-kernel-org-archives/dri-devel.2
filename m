Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799F0CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FF210E6A3;
	Fri,  2 Oct 2026 20:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NobJkXZb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQNfS4qM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A641610E6A3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 20:23:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692K9jlS2749761
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 20:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Sm7PSIXxWP70Y3Fubw9NhYaR
 bZ+kjeuTwYGtZMCtngw=; b=NobJkXZbmh4q8GtQLRTh3Ob5w/0ZVHYbVHCOUuo+
 IxgiFNc2Zn14imaLap/T/Kfr3aHPV4URxrwTr36aW6ZHTFi7qrQQL9IhC74glB2y
 Yrr7Xh7xgDPvvwPuo8sXN//YaEYC+CdR7oCbZRVbK5sp+9OsTk4mogc3nG4UoiuU
 tQ7iibJUtFiFHtxweOgA/CHnrjtaA52hwGSfqxne5aCeHQFI4t9xRMJ5MECIdE8y
 GbXuGde9le59IkH5C4swkXTrnvnKZMM6mVyF7AyW8GWrR4TAX+N3UhhRz+GD2HZj
 aeIEtUsO3PhDi35gZXCf7adaKVvH/BtdDSe1tR5pKj2CMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh43nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 20:23:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cbacbb996so314554385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790972638; x=1791577438;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sm7PSIXxWP70Y3Fubw9NhYaRbZ+kjeuTwYGtZMCtngw=;
 b=VQNfS4qM4jXeb9zyURU3o7JMlvtEE/JssP59EF4o0DNMYI73ZQlfDgukqGRbGsI/Je
 qNlvoOh3vry3jNjSggLaWGWeCCIPg08RwZM0hhRQcRIvWI5VTRfb+wp/uybE/bMuWZcy
 cJXrNKuREKljPXIpNqEzyxeKkdK/YVn3Vu33OMjLqAsIHzVRMLm5//0U0v+UopT6B3Dr
 jwXuP5phWICJGLHSRlO30ljADB325e/tr604Qz3bDVoAOyCS2OodhJilucGysbbs6tZG
 9UKVLGDBh7enBLFPlYsfcIcH76JDFBdJRto7gmdk6gE4yVaLcRLVgGRBBD7qcUZOJsfF
 s+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972638; x=1791577438;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sm7PSIXxWP70Y3Fubw9NhYaRbZ+kjeuTwYGtZMCtngw=;
 b=br1h+t6BfRCNvM6s311TzPxVajLDxNQo640OhBTbyiz0U3jA2Pdfg5lDxcCuIkvj+o
 ulHNZsMNeRRL2+y7+jxMYSsIiBLiYCA5nNfkPNTAu9LEBXJ2oashHW9qG4vSqiKGDcc+
 EyLtxwqOiAsQKQ7byItisbHqY2ue9rxpmpZ9gywDQ3dzbE4GABTzQR0XkGq6jkxvb2Up
 DJsKqo4fBTV8zCu3iA50+wZP7T2kx9UMkxRc3ZJwGqoQb8ZN+nutkm/OjgyNeUQtZtef
 2t5yAy+uB64oBde1i3gDyrluN8U6QjQq4xyFxpbNta2JkqYN1g3dMT+lL37MFO8xB4HO
 ml3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN8HOYMeCcmj/ipLn8M9vuR70OUOM6Pb02LlqQ6Zu+gjoL/DV673M6a5A+ctHyQG92K8ovTa7yIfU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6SzcQSdyolkHBwTL+ssc/R1ihgpLPOe12yp7vdiFmP7cnpH2Q
 hP6OIm84ZYQK7M9HUZJI4i1bE7PFaruUb7j+iaEjxDyvPMlyM0axHczNPjyou/+symBwSShCr0q
 PvaTt8Os1sQ2qm4ULooKmw9Mgf3EhdX4cxpOHECiK3hDoPcbCVjqnmkoRtQ7/RbCfiba6o8k=
X-Gm-Gg: AYBFou3Vy/4qihb4MytRdYPemx8wJUn4cO1O2GeZFZPtLtIc/dZhnPtIA8AuKe4yz4G
 fFkaDAGLalLyuGJfXogfsnmehjOfFP+2g3rGmIhu7PZ4V6jvbhH/WOxjSVE1K2ox2JBTzlZhRMB
 DQBH+JQGez7AtpYVnnRUa9g3guDTSQ8cOvMGPrQzcIQlbdG01ES+ukQqfnks3yN9FMyPdLl3ZPe
 PNbAAfWD6VzcHVa+jspqhS+DjoRCWEU4HH0pav99hNR+ynXHByAelqy6xLT547H/7iLW8NrHP/F
 7FNDCBZo8LpylY/1P/R5m8GPBDPw2tWngfXeHzVf80dYMttYqgswY3H2M7sBPjpDLQ+G95hlTC3
 VONlTTwwZXOJOMEDjWr9Mix+BFgI08R4nVzXfvOTGsBeG9abMc/jlCFWGYyjdm+LIFzcuz2KFUa
 81iar2R9O+tpqU
X-Received: by 2002:a05:620a:17ab:b0:93c:c73c:91f9 with SMTP id
 af79cd13be357-93cf1700af7mr654368685a.31.1790972637420; 
 Fri, 02 Oct 2026 13:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:93c:c73c:91f9 with SMTP id
 af79cd13be357-93cf1700af7mr654361885a.31.1790972636696; 
 Fri, 02 Oct 2026 13:23:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9636c571bsm8836931fa.0.2026.10.02.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:23:55 -0700 (PDT)
Date: Fri, 2 Oct 2026 23:23:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <65hkupywjw2czck22qod5egpssbymvgy7wf6i6c2oyelexek53@fs36x66abtn5>
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4MSBTYWx0ZWRfX6bhT6aCKguZI
 QX8ejcyTlLO8wlbBzRPh6aaBk56c68KROD9X7eT2XKWdCIwTsWzodyZ+7PKHmwZALCVMWUHmjDr
 ldxAx3IWFEY7kFvGbex3g6VXdIQE2nE=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6ac012de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=cxr7Rb4uYlb9bN0-pOsA:9 a=aow2KpemsbaojCVP:21
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=cvBusfyB2V15izCimMoJ:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4MSBTYWx0ZWRfX2bFIvdL/5iSj
 yhne8iYsV9TwEpB5M/9smAkoTcqfquxgVTV57IkwO9+hmwHhN8SijJG6kAkRRZIE4F/BQ9oZfca
 ZHPZvhEkLom3RiwxewLk13IlxSpRAR8h5EHX+WRX6JCjOAN4XJEN90T6naml1KnJ35nM7Yd8x70
 BMSAO2OD7zzl4bIIgAYBFbq4d8p0hmtCDpApxmq50rQV0s7N4Hds4gIG40a2MiVKJkrH9aXKKqH
 QRnuffw7XG+rU/THfndZ59xmIHmE1KhJuRn5NVp92cdyUNSwPr6KFrqyWM97yBfBVdf84mKD0vc
 2/knuvWtLq2AHW3fYMtme0tdjt83oTsruM/2xOCRLpfM9zZZcE8Euszbh8kQuzc3HdL4vl7IrRY
 794jnDTMU/yRb9Svn8qkUWA9SNLiVJpeeAxJb2BvmpOH3lVeQjQfqtHFQScm0B8t1w9iWlNNNay
 UJeQ6EeCuqnROp26cGg==
X-Proofpoint-GUID: t8dSYw4YJLUSQ4fgST-vqtTWzmmY5AiR
X-Proofpoint-ORIG-GUID: t8dSYw4YJLUSQ4fgST-vqtTWzmmY5AiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020081
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2026 at 05:33:26PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width constrain
> or scenarios that surpass the maximum MDP clock rate, additional
> pipes are necessary to enable parallel data processing within
> the width constraints and MDP clock rate.
> 
> Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> high-resolution cases where dual interfaces are enabled for virtual
> plane case. More use cases can be incorporated later if quad-pipe
> capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Patchwork: https://patchwork.freedesktop.org/patch/675418/
> Link: https://lore.kernel.org/r/20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

FWIW the following patch seems to be required to make it work on DPU
4.0.

https://patch.msgid.link/20261002-encoder-flush-old-ctl-v1-1-2a2f29e9b930@oss.qualcomm.com

I'm not 100% happy about this patch, I can foresee having issues with
the different DSC topologies, but I guess it might be easier to try
figuring them out (maybe together with rewiring / rewriting the resource
allocator). We need to find a way to try different combinations and roll
back to the smaller configuration if the other output needs more
resources.

I'll test this version, and if it passes, I will maybe try landing it...

> 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> And 4 DSC are preferred for power optimal in this case due to width
> limitation of SSPP and MDP clock rate constrain. This patch set
> extends number of pipes to 4 and revise related mixer blending logic
> to support quad pipe. All these changes depends on the virtual plane
> feature to split a super wide drm plane horizontally into 2 or more sub
> clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> whole drm plane.
> 
> The first pipe pair co-work with the first mixer pair to cover the left
> half of screen and 2nd pair of pipes and mixers are for the right half
> of screen. If a plane is only for the right half of screen, only one
> or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
> assinged for invalid pipe.
> 
> For those panel that does not require quad-pipe, only 1 or 2 pipes in
> the 1st pipe pair will be used. There is no concept of right half of
> screen.
> 
> For legacy non virtual plane mode, the first 1 or 2 pipes are used for
> the single SSPP and its multi-rect mode.
> 
> This patch set drop the merged heading 8 patches of v16, only the last
> 2 are revised and split into 4 patches here.
> 
>     Changes in v21:
>     - Add active-CTL constrain to quad-pipe case.
>     - adjust high clock rate constrain to quad-pipe case so that 4K@30Hz
>       still use 2 LMs.
>     - Link to v20: https://lore.kernel.org/all/20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org/
> 
>     Changes in v20:
>     - Rebase to latest msm-next to add single DSC case into topology revison.
>     - Link to v19: https://lore.kernel.org/r/20260312-msm-next-quad-pipe-split-v19-0-4ffa2b06c996@linaro.org
> 
>     Changes in v19:
>     - Refine the plane resource assignment to avoid unnecessary argument
>       and operation for non-virtual plane case.
>     - Fix wording in comments.
>     - Link to v18: https://lore.kernel.org/r/20260213-msm-next-quad-pipe-split-v18-0-5815158d3635@linaro.org
> 
>     Changes in v18:
>     - Revise the deferring of SSPP handling and comments to distinguish
>       assignment of non-virtual plane case and allocation of virtual plane case.
>     - Always assume 1 stage in non-virtual plane case when splitting and
>       mapping plane to pipes.
>     - Revise topology decision making and comments to fix possible
>       regression.
>     - Link to v17: https://lore.kernel.org/r/20260121-msm-next-quad-pipe-split-v17-0-6eb6d8675ca2@linaro.org
>     
>     Changes in v17:
>     - Fix iommu warning on Hamoa.
>     - Extract plane splitting into a dedicated function.
>     - Defer plan splitting and SSPP allocation until CRTC check
>       so that topology information is available.
>     - Add virtual plane condition to quad-pipe topology so that
>       legacy devices are not impacted.
>     - Drop the merged 8 patches of v16, only the last 2 is revised
>       and sent here.
>     - Link to v16: https://lore.kernel.org/linux-arm-msm/20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org
> 
>     Changes in v16:
>     - Rebase to latest branch msm-next-lumag.
>     - Fix IGT test failures.
>     - Drop patches that have been merged.
>     - Link to v15: https://lore.kernel.org/r/20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org
> 
>     Changes in v15:
>     - Polish logic in sspp check and assignment.
>     - Link to v14: https://lore.kernel.org/r/20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org
> 
>     Changes in v14:
>     - Add patch to fix null pointer bug SSPP sharing, which is missed in
>       the last version.
>     - Polish single pipe check with removing loop.
>     - Polish logic of SSPP sharing test in dpu_plane_virtual_assign_resources()
>     - Polish argument of dpu_plane_virtual_assign_resources().
>     - Link to v13: https://lore.kernel.org/r/20250728-v6-16-rc2-quad-pipe-upstream-v13-0-954e4917fe4f@linaro.org
> 
>     Changes in v13:
>     - Modify the SSPP assignment patch for sharing SSPP among planes in
>       quad-pipe case.
>     - Link to v12: https://lore.kernel.org/r/20250707-v6-16-rc2-quad-pipe-upstream-v12-0-67e3721e7d83@linaro.org
> 
>     Changes in v12:
>     - Polish single pipe case detection in a plane. Add stage index check when
>       sharing SSPP with multi-rect mode in 2 planes.
>     - Abstract SSPP assignment in a stage into a function.
>     - Rebase to latest msm/msm-next.
>     - Link to v11: https://lore.kernel.org/r/20250603-v6-15-quad-pipe-upstream-v11-0-c3af7190613d@linaro.org
> 
>     Changes in v11:
>     - Change function name from dpu_plane_check_single_pipe to
>       dpu_plane_get_single_pipe.
>     - Abstract SSPP assignment in stage into a function.
>     - Link to v10: https://lore.kernel.org/r/20250526-v6-15-quad-pipe-upstream-v10-0-5fed4f8897c4@linaro.org
> 
>     Changes in v10:
>     - Drop changes in drm helper side, because num_lm == 0 does not lead to
>       any issue in the first call to dpu_plane_atomic_check_nosspp() with
>       latest repo. It is initialized properly right after the call in
>       drm_atomic_helper_check_planes(), thus the later plane splitting works
>       as expected.
>     - Rebase to latest msm-next branch.
>     - Fix PIPES_PER_STAGE to PIPES_PER_PLANE where handling all pipes, instead
>       of stages.
>     - Link to v9: https://lore.kernel.org/r/20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org
> 
>     Changes in v9:
>     - Rebase to latest mainline and drop 3 patches as mainline already cover
>       the logic.
>       "Do not fix number of DSC"
>       "configure DSC per number in use"
>       "switch RM to use crtc_id rather than enc_id for allocation"
>     - Add a patch to check crtc before checking plane in drm framework.
>     - Add a patch to use dedicated WB number in an encoder to avoid regression.
>     - Revise the condition to decide quad-pipe topology.
>     - Link to v8: https://lore.kernel.org/r/20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org
> 
>     Changes in v8:
>     - Fix looping pipes of a plane in _dpu_plane_color_fill()
>     - Improve pipe assignment with deleting pipes loop in stage.
>     - Define PIPES_PER_PLANE properly when it appears fisrt.
>     - rename lms_in_pair to lms_in_stage to avoid confusion.
>     - Add review tags.
>     - Link to v7: https://lore.kernel.org/r/20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org
> 
>     Changes in v7:
>     - Improve pipe assignment to avoid point to invalid memory.
>     - Define STAGES_PER_PLANE as 2 only when quad-pipe is introduced.
>     - Polish LM number when blending pipes with min() and pull up to caller func.
>     - Add review tags.
>     - Link to v6: https://lore.kernel.org/r/20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org
> 
>     Changes in v6:
>     - Replace LM number with PP number to calculate PP number per encoder.
>     - Rebase to Linux v6.14-rc2.
>     - Add review tags.
>     - Link to v5: https://lore.kernel.org/r/20250118-sm8650-v6-13-hmd-deckard-mdss-quad-upstream-33-v5-0-9701a16340da@linaro.org
> 
>     Changes in v5:
>     - Iterate SSPP flushing within the required mixer pair, instead of all
>       active mixers or specific mixer.
>     - Limit qaud-pipe usage case to SoC with 4 or more DSC engines and 2
>       interfaces case.
>     - Remove valid flag and use width for pipe validation.
>     - Polish commit messages and code comments.
>     - Link to v4: https://lore.kernel.org/r/20250116-sm8650-v6-13-hmd-deckard-mdss-quad-upstream-33-v4-0-74749c6eba33@linaro.org
> 
>     Changes in v4:
>     - Restrict SSPP flushing to the required mixer, instead of all active mixers.
>     - Polish commit messages and code comments.
>     - Rebase to latest msm/drm-next branch.
>     - Move pipe checking patch to the top of patch set.
>     - Link to v3: https://lore.kernel.org/dri-devel/20241219-sm8650-v6-13-hmd-deckard-mdss-quad-upstream-32-v3-0-92c7c0a228e3@linaro.org
> 
>     Changes in v3:
>     - Split change in trace into a separate patch.
>     - Rebase to latest msm-next branch.
>     - Reorder patch sequence to make sure valid flag is set in earlier patch
>     - Rectify rewrite patch to move logic change into other patch
>     - Polish commit messages and code comments.
>     - Link to v2: https://lore.kernel.org/dri-devel/20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org
> 
> Changes in v2:
>     - Revise the patch sequence with changing to 2 pipes topology first. Then
>       prepare for quad-pipe setup, then enable quad-pipe at last.
>     - Split DSI patches into other patch set.
>     - Link to v1: https://lore.kernel.org/all/20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 55 ++++++++++++++++--------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 29 ++++---------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
>  6 files changed, 52 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index bd0e720b484fd..d586825015906 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
>  		struct dpu_crtc_state *crtc_state)
>  {
>  	struct dpu_crtc_mixer *m;
> -	u32 crcs[CRTC_DUAL_MIXERS];
> +	u32 crcs[CRTC_QUAD_MIXERS];
>  
>  	int rc = 0;
>  	int i;
> @@ -1384,6 +1384,9 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>  	struct msm_display_topology topology = {0};
>  	struct drm_encoder *drm_enc;
> +	struct msm_drm_private *priv = crtc->dev->dev_private;
> +	struct dpu_kms *kms = to_dpu_kms(priv->kms);
> +	u32 num_rt_intf;
>  
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
>  		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
> @@ -1396,32 +1399,48 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	 *
>  	 * Dual display
>  	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
> +	 * 4 LM, 2 INTF ( Split display using 2 interfaces and stream merge
> +			  to support high resolution interfaces if virtual
> +			  plane is enabled)
> +	 * If DSC is enabled, use 2:2:2 for 2 LMs case, and 4:4:2 for 4 LMs
> +	 * case.
>  	 *
>  	 * Single display
>  	 * 1 LM, 1 INTF
>  	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
>  	 *
> -	 * If DSC is enabled, use 2 LMs for 2:2:1 topology
> +	 * If DSC is enabled, use 2 LMs for 2:2:1 topology for single display
> +	 * to support legacy devices that use this topology. Use 1:1:1 topology
> +	 * if there is only one DSC engine in SoC.
>  	 *
>  	 * Add dspps to the reservation requirements if ctm or gamma_lut are requested
> -	 *
> -	 * Only hardcode num_lm to 2 for cases where num_intf == 2 and CWB is not
> -	 * enabled. This is because in cases where CWB is enabled, num_intf will
> -	 * count both the WB and real-time phys encoders.
> -	 *
> -	 * For non-DSC CWB usecases, have the num_lm be decided by the
> -	 * (mode->hdisplay > MAX_HDISPLAY_SPLIT) check.
>  	 */
>  
> -	if (topology.num_intf == 2 && !topology.cwb_enabled)
> -		topology.num_lm = 2;
> -	else if (topology.num_dsc == 2)
> -		topology.num_lm = 2;
> -	else if (dpu_kms->catalog->caps->has_3d_merge &&
> -		 topology.num_dsc == 0)
> -		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> -	else
> -		topology.num_lm = 1;
> +	num_rt_intf = topology.num_intf;
> +	if (topology.cwb_enabled)
> +		num_rt_intf--;
> +
> +	if ((mode->hdisplay > (dpu_kms->catalog->caps->max_mixer_width * num_rt_intf)) ||
> +	    ((u64)mode->hdisplay * mode->vtotal * drm_mode_vrefresh(mode) >
> +	     kms->perf.max_core_clk_rate))
> +		topology.num_lm = num_rt_intf * 2;
> +	else {
> +		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ?
> +				  2 : num_rt_intf;
> +	}
> +
> +	if (!dpu_use_virtual_planes ||
> +	    dpu_kms->catalog->mdss_ver->core_major_ver < 5)
> +		topology.num_lm = min(2, topology.num_lm);
> +
> +	if (!dpu_kms->catalog->caps->has_3d_merge)
> +		topology.num_lm = min(num_rt_intf, topology.num_lm);
> +
> +	if (topology.num_dsc) {
> +		if (num_rt_intf == 1)
> +			topology.num_lm = min(2, dpu_kms->catalog->dsc_count);
> +		topology.num_dsc = topology.num_lm;
> +	}
>  
>  	if (crtc_state->ctm || crtc_state->gamma_lut)
>  		topology.num_dspp = topology.num_lm;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> index 6eaba5696e8e6..455073c7025b0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> @@ -210,7 +210,7 @@ struct dpu_crtc_state {
>  
>  	bool bw_control;
>  	bool bw_split_vote;
> -	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
> +	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
>  
>  	uint64_t input_fence_timeout_ns;
>  
> @@ -218,10 +218,10 @@ struct dpu_crtc_state {
>  
>  	/* HW Resources reserved for the crtc */
>  	u32 num_mixers;
> -	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
> +	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
>  
>  	u32 num_ctls;
> -	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
> +	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
>  
>  	enum dpu_crtc_crc_source crc_source;
>  	int crc_frame_skip_count;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index eba1d52211f68..058a7c8727f7c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -55,7 +55,7 @@
>  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
>  	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
>  
> -#define MAX_CHANNELS_PER_ENC 2
> +#define MAX_CHANNELS_PER_ENC 4
>  #define MAX_CWB_PER_ENC 2
>  
>  #define IDLE_SHORT_TIMEOUT	1
> @@ -661,7 +661,6 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>  	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>  	struct msm_drm_private *priv = dpu_enc->base.dev->dev_private;
>  	struct msm_display_info *disp_info = &dpu_enc->disp_info;
> -	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
>  	struct drm_connector *connector;
>  	struct drm_connector_state *conn_state;
>  	struct drm_framebuffer *fb;
> @@ -675,22 +674,12 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>  
>  	dsc = dpu_encoder_get_dsc_config(drm_enc);
>  
> -	/* We only support 2 DSC mode (with 2 LM and 1 INTF) */
> -	if (dsc) {
> -		/*
> -		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
> -		 * when Display Stream Compression (DSC) is enabled,
> -		 * and when enough DSC blocks are available.
> -		 * This is power-optimal and can drive up to (including) 4k
> -		 * screens.
> -		 */
> -		WARN(topology->num_intf > 2,
> -		     "DSC topology cannot support more than 2 interfaces\n");
> -		if (topology->num_intf >= 2 || dpu_kms->catalog->dsc_count >= 2)
> -			topology->num_dsc = 2;
> -		else
> -			topology->num_dsc = 1;
> -	}
> +	/*
> +	 * Set DSC number as 1 to mark the enabled status, will be adjusted
> +	 * in dpu_crtc_get_topology()
> +	 */
> +	if (dsc)
> +		topology->num_dsc = 1;
>  
>  	connector = drm_atomic_get_new_connector_for_encoder(state, drm_enc);
>  	if (!connector)
> @@ -2180,8 +2169,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
>  {
>  	int i, num_lm;
>  	struct dpu_global_state *global_state;
> -	struct dpu_hw_blk *hw_lm[2];
> -	struct dpu_hw_mixer *hw_mixer[2];
> +	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
> +	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
>  	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
>  
>  	/* reset all mixers for this encoder */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 61b22d9494546..09395d7910ac8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -302,7 +302,7 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
>  
>  	/* Use merge_3d unless DSC MERGE topology is used */
>  	if (phys_enc->split_role == ENC_ROLE_SOLO &&
> -	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
> +	    (dpu_cstate->num_mixers != 1) &&
>  	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
>  		return BLEND_3D_H_ROW_INT;
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index ba04ac24d5a9e..b1ac84c0b52db 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -24,7 +24,7 @@
>  #define DPU_MAX_IMG_WIDTH 0x3fff
>  #define DPU_MAX_IMG_HEIGHT 0x3fff
>  
> -#define CRTC_DUAL_MIXERS	2
> +#define CRTC_QUAD_MIXERS	4
>  
>  #define MAX_XIN_COUNT 16
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 0e65bf5ddc4a6..fd1f3e7982062 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,7 +34,7 @@
>  #define DPU_MAX_PLANES			4
>  #endif
>  
> -#define STAGES_PER_PLANE		1
> +#define STAGES_PER_PLANE		2
>  #define PIPES_PER_STAGE			2
>  #define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
>  #ifndef DPU_MAX_DE_CURVES
> 
> ---
> base-commit: a913d08e5ea9a491b806e64a24410f6722ddc9b3
> change-id: 20260121-msm-next-quad-pipe-split-ab95b6e3ffd3
> 
> Best regards,
> -- 
> Jun Nie <jun.nie@linaro.org>
> 

-- 
With best wishes
Dmitry
