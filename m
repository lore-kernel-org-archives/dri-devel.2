Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6AFCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2526B10E449;
	Mon, 12 Oct 2026 12:15:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86FD10E449
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:14:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxsh03363785
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SpuOW3irnSF9gZWodyKphbnc
 flg4AOxCzIxt+F492qw=; b=FGhE4hUfGbH3tvVr29hEAg+OCyVPFAtVfQ28XeKb
 7xXoc13xxUMz62CLDsV6f+bkpzFbxvupMbXrwQ6iJWlFj4d4b4SrcJtkN4mqq3x0
 ccDQsZtVPOKWWPzRDJUeJFETkoMgOn3fZCa0qvJl5IdJpJjhKmP3KH3Mai0cm8G+
 Gh2JgHYhHGR8+zE+otGY3QaAgjCmsLZhU7NCqxyzrk6YdWlL6wrzVrC8M9xu5SPP
 ZIgyoZljw1Epkyxlwt8m9trhLSFVNkbeZUjLpHSY09bflv/MWdpUS/rS2oWyv1BO
 RZURVL5MqaZIwxP1a4Y6kqVPAlQ/eLwjk/+ATmJtC54hVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr8n1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:14:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso363561185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807298; x=1792412098;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SpuOW3irnSF9gZWodyKphbncflg4AOxCzIxt+F492qw=;
 b=XSFXi43fVtj8hdmDqjxYYpsS9AgVhmGz6oGWwqk7Aerctzqx1pKj9YT4I9JAj60bmw
 LGcix9ej0zZ+C24nS+ty2lKXtSRCgKroxdSWXowEbE39x5D8WbIYchRCNWNcYys1q925
 NOaPayeMdKkyNSeB0dLqylHUzWdfHqGA/0EJQpdXJOU1lfezNrUxWZkvEBH89olBcwvq
 namnSbTD/5W5FeQekABI5H1QP94f6ccodUTR8WMMsgBFov50pd24KaC1sTjGxphAHOgY
 1Og8SFTKbhxHl4SIQ94YHs5IFO14n/maVaKl5BR8vF3tELLXGPQJJsrQm/Bo0JKWd/Am
 O+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807298; x=1792412098;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SpuOW3irnSF9gZWodyKphbncflg4AOxCzIxt+F492qw=;
 b=dHi8sUsKbFD8IeyQCJD7ET9GRyzSQNiwk3l7c7vEg2nv/3tYyyed0JaF4yehP0lWHP
 8YWRvPZIFUKcmc/mqqW0+yC8+8NMeOjEtsSFrRLfKhdUpgiTYhPneFhLGQzCOydGUs7f
 /v6YLofOeOJYpKVJynBnUu1ZF45Zym51mEntr8X1IYjXL6PT1LGwpDiDMX2pyKrKwD1+
 jpluznAXlSQGQPLP/FGWJoIPoKWf17n2AB9ZhGq+3x+yVLpziSCOFIHHvNIsIO1Ib+pd
 FC9t49r9G9fsAqgiM3QO/sM5tSkdW0Y6RL4hHYWXjXgJTe5ueRGAHPw8X1k4kqTQWI38
 kcUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlf7cDRqKfdkpplQ8oYwSKgmSjvtS/yze6NI5VSvpMEg2o4AWoRyF4zuCPr3j/FAOK7w7pgbmE5GM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYq3BTckPXV1ZGgTWohMBdgPEiLbOKMKnwUZaXxwwQvlo04pni
 sWbArNIvsvauLyQXCqOyQztRckaQUVAPY3Xfz15LvYwhgwtnjCPYHdcqSZQrghpZKkS2iBLs/Kh
 X5MMHTScwkI0mJryDHBllyhS7puETzH0yqZW4Lf5Ja1MubiOli7wut7DfdzofxlOWDnzmVAc=
X-Gm-Gg: AYBFou1vR7nBwOIZOOajtS0nHjfXOvur7Qz6ymjYodgPXbDljKX1GvWmC4Wgj6OEM9M
 gNA6/X1UsQPZlpBr7BuZgnFW9QZaimqSoH4DSbyGBqaDVZCWGXSJTNlrSpXov68OasFjUBTUO0S
 BV2nY+AnJmxZEQNbR38M6Txh01KH3RKCpYeGwGmudVFqm1MWich+Eu90pHHvei39XJCkzoYdqAD
 VuP+xROFI7wTjBwl4U83WljS6OxHjf/IvuHnFTeRmH663oWlqe2096jcs8uPddTsttun3IgbpWt
 BVvzDGBaPeLQPi1m6quKw0AGoIY7SxGd+yfDh8B3336P17y1Es0whOsbLfFWHmG35BhsjNxmk0Q
 op2JRERdSwns/1tKmW2zvryn1oDTGr164wTNZ+X88pB3EL157rQ+clWDnRv2k+LZuIdvyTnnP12
 vO5N7SHsSWAw3u
X-Received: by 2002:a05:620a:470b:b0:93e:c12c:43fd with SMTP id
 af79cd13be357-93ec12c4a90mr1419179385a.74.1791807298140; 
 Mon, 12 Oct 2026 05:14:58 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:93e:c12c:43fd with SMTP id
 af79cd13be357-93ec12c4a90mr1419174485a.74.1791807297651; 
 Mon, 12 Oct 2026 05:14:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddcd3fcbsm2817950e87.0.2026.10.12.05.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:14:54 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:14:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] drm/msm/dpu: check mode against PINGPONG or DSC
 max width
Message-ID: <2mut637ssnnyf7spywezdkx5fpoc4virkr3zuqzj3klwd3ijfr@xk46zya3hgak>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX+/WD1FHSd+VI
 uAdb4AfqyoMwpG8Yb5vnlvKYXr++WW1QDyOqg/oUbfKhIDp4X3L772H5DrPLMOEwjR2ZGwSVCAf
 AT8EEj7LxlzpZEXlKLOOjQoTsuNOKdGBoj+1XFK4DLAqHCkzWTmTEgL4v+5342EIpC0Q5QcM7zg
 dM0mXxMusiqHuNCgPfwNEoWM6iTzdTMjrFjE5Mt3ZW+FDoJ4OE71gwbQ5/UT8Z+M7tMyRbxe+q3
 1mk85SgevZZUnIf/DCvLZ0U0P/OADOPFz2dB83da912HmI05HAq5B8bpjR08h3sFk6WB48HbVOJ
 VJB0W6C3GxhBcjsAsB4SGX1c8UzJAFOuAdMCbEExvS6h0GsY5t5f9a3B77qAcT5pb1vYRBmmvsB
 CIU2IP2DuPWKz1aTp22lqkO5adFan+RXmTnVkNHAl/YSjst2nGGrzUMmaT4VMXdLMzb3JOjLZS2
 1Hpoz3GZpT6WF+0qBAA==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6acccf43 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8 a=Wa-MJAjFNFIhp57g3PAA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXyJTQ7ai6elQf
 U6zJgT7GOdxJcr8k8ZlpAvwbItbi7tnvkUl9pWD63pwNYoXI2qLD6fJzDy+MKq5FpeLehI2ZfB7
 8hL1zmuUJchDFGCoBqj5LmzzFSUvwmc=
X-Proofpoint-ORIG-GUID: 3lmO4-4yzcCiq4gelymUIPtgq2usWze7
X-Proofpoint-GUID: 3lmO4-4yzcCiq4gelymUIPtgq2usWze7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048
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

On Thu, Oct 08, 2026 at 10:53:49PM +0530, Mahadevan P wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> LM block doesn't have a hardware buffer (unlike PINGPONG and DSC
> encoders). As such, don't use ephemeral max_mixer_width and
> MAX_HDISPLAY_SPLIT to validate requested modes. Instead use PP and DSC
> buffer widths.
> 
> While on the DPU 8.x+ supports a max linewidth of 8960 for PINGPONG_0,
> there is some additional logic that needs to be added to the resource
> manager to specifically try and reserve PINGPONG_0 for modes that are
> greater than 5k.
> 
> The layer-mixer count for a merge-capable, non-DSC mode is chosen by
> dpu_crtc_num_lm_for_mode(); feed the PINGPONG/DSC derived width to it as
> the split threshold in place of the removed MAX_HDISPLAY_SPLIT, so the
> pixel-rate floor added earlier keeps high-refresh modes that now fit
> within a single PINGPONG buffer split across two mixers.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
> [DB: reworked to drop catalog changes, updated commit message]
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> [MP: rebased on msm-next; fed PINGPONG/DSC width into
>  dpu_crtc_num_lm_for_mode() instead of open-coding the width test]
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       | 54 +++++++++++++++++++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  7 ++++
>  2 files changed, 51 insertions(+), 10 deletions(-)
> 
> @@ -765,13 +781,14 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
>  	struct drm_display_mode *adj_mode = &state->adjusted_mode;
>  	u32 crtc_split_width = adj_mode->hdisplay / cstate->num_mixers;
>  	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
> +	int max_pingpong_width = msm_display_get_max_pingpong_width(dpu_kms);
>  	int i;
>  
>  	/* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
>  	 * before even checking the width after the split
>  	 */
>  	if (!dpu_kms->catalog->caps->has_3d_merge &&
> -	    adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> +	    adj_mode->hdisplay > max_pingpong_width)
>  		return -E2BIG;

I guess Sashiko is correct here, we need to check DSC width.

>  
>  	for (i = 0; i < cstate->num_mixers; i++) {
> @@ -783,7 +800,7 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
>  
>  		trace_dpu_crtc_setup_lm_bounds(DRMID(crtc), i, r);
>  
> -		if (drm_rect_width(r) > dpu_kms->catalog->caps->max_mixer_width)
> +		if (drm_rect_width(r) > max_pingpong_width)
>  			return -E2BIG;
>  	}
>  
> @@ -1374,17 +1391,17 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
>  }
>  
>  #define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
> -#define MAX_HDISPLAY_SPLIT 1080
>  
>  static u32 dpu_crtc_num_lm_for_mode(struct dpu_kms *dpu_kms,
> -				    const struct drm_display_mode *mode)
> +				    const struct drm_display_mode *mode,
> +				    u32 max_hdisplay_split)
>  {
>  	u64 mode_clk;
>  
>  	if (!dpu_kms->catalog->caps->has_3d_merge)
>  		return 1;
>  
> -	if (mode->hdisplay > MAX_HDISPLAY_SPLIT)
> +	if (mode->hdisplay > max_hdisplay_split)
>  		return 2;
>  
>  	mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
> @@ -1403,6 +1420,7 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>  	struct msm_display_topology topology = {0};
>  	struct drm_encoder *drm_enc;
> +	u32 max_hdisplay_split;
>  
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
>  		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
> @@ -1410,6 +1428,19 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  
>  	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
>  
> +	max_hdisplay_split = msm_display_get_max_pingpong_width(dpu_kms);
> +
> +	if (topology.num_dsc > 0) {
> +		u32 max_dsc_encoder_width;
> +
> +		if (dpu_kms->catalog->mdss_ver->core_major_ver < 6)
> +			max_dsc_encoder_width = DPU_1_x_MAX_DSC_ENCODER_WIDTH;
> +		else
> +			max_dsc_encoder_width = DPU_8_x_MAX_DSC_ENCODER_WIDTH;
> +
> +		max_hdisplay_split = min(max_hdisplay_split, max_dsc_encoder_width);

Should this be min() rather than max()?

> +	}
> +
>  	/*
>  	 * Datapath topology selection
>  	 *

-- 
With best wishes
Dmitry
