Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED141F3ED5D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BA910E168;
	Sat, 11 Apr 2026 18:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlxj8q2o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXyM6eXv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527A610E168
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:12:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4e1bm3874719
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=d7aVOYHYRJajgd06oCHvRT4L
 JqIV7wS2v0f0jmElxR0=; b=hlxj8q2ocrspTGXO+M56HXcazzvniFOznVEBxlGp
 +8YtLpeD/R3+ab36rJ9A/zvHuo+eMy0z6D3DCza0m/osNMmgMB0h8Pvo9C5TtAcZ
 TZWy2X5zNIrWRx3mcZKlPoG1uD8fBMgdr2Xb2Qeh/ksRGsd0FbpRAwfeBcXxv2m3
 yIOndessMtyOPqY7t6sAk4jtwacKSFUyyFLzXSpwhzB7Llg2fWaZ0UDQ+Argdox0
 NrIXMS10eZVPEG7tKUPnsHv5LgioV9LpctXqlzs6VR/BiS4VCqNsm00YOT/IjdZc
 TY96ecacIvp+NxpMJOyIBHKiQM+cOU1RI0Z30iEO9IKeFg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhs4ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:12:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d68dbb77bso21904011cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775931166; x=1776535966;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7aVOYHYRJajgd06oCHvRT4LJqIV7wS2v0f0jmElxR0=;
 b=dXyM6eXvMQxDh4JZgfmn5jNwHV+IfKm3zq0tDVHfBLLNp0PUbdSPrRSBS3DfDHkJk/
 pOJ2N2zQI+pQ/KGquhUPZ3+s/Lf9FwMgQ/zLOw5bpDudxQ62gR5Vemsri7+xDhIINTfB
 IbJJ+w11wF19LS/gQgSs0+PV6yUFVncwQnVh9t2pcNdZE7cWfPWGkyxVfTZCeXNmWvV7
 DyjGENjV3u6ENHzcco2/DJRY8Gug50nrlHuqTG2moxsu/85TelvJJ2jLHokBbzD3ViMy
 NcegXhTb81lnkgAc0NWjxZM5xdoAHOS4Z0Pocn2XxutHK6NoyvpihSuf6+m6ITaP0ZB4
 ajZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775931166; x=1776535966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7aVOYHYRJajgd06oCHvRT4LJqIV7wS2v0f0jmElxR0=;
 b=rCem3bFH077Q7TqNX6h1j9QGNbD4cmYRB98eaWr6GUpbDofNWyX46qxHhnhpYtTtI5
 G6pVCxsixSY719kWuwrSBkZYb/WKHX5AybKi5QkIvqIiaCuIQQcRP0qrbgCEoD+Idbxt
 /9cizX/WXM1YUDAKsF5QYvLpQ8CmU1iCHmnDI9C7oobvXmucrMh+dFY1hNEs4Y7eBcbS
 RZK3tmmAwABw+QPbsDZYv80VhAya3fE/VoUj1kDqw+er/sZUUAKinZ3GpsKKI1MNDtBi
 2VbJz9Km2HDdBenSVLJ+c8T9/lMwdoTMBLaDWo10HOQfigKVDGag3pvRRAtWxEBS7XFz
 IPCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk2AfkLDjMvjlLWR/EGEOhJWi6OwiSiHQdC9E6So4GD6QQm7jwUdfW5CjeX5uaneqyDl5/FcqRsek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhDE8kwuK9Uzi8qMLCPBLsq1HS5CTQJjiP1pIB510r2ANKiIGS
 zrXndZxMBau66cHwSFWUFnqakpZS8+y/segfbsmlXUTEOERk8FHEF5um9IjQPVQTYFlM8wdnokW
 qPsGyzz6GuTEPohk6OU3SLxfh0a3Yw+Ulh4HevlUOEed6ZFVKc2JHRIOoIR2nxlC99XWfezw=
X-Gm-Gg: AeBDiesh1uoAb5NKHhrzW9HI83Yuzv6L8optDby2l6N5gnJqPGPciMm3qgsWxtgN/Lw
 ImR5FQgIfM6CGaSuRisrgMYuVyt0Mc5Bj8xm+m/5vDNF+lACtMgsEaNIzpzcgcs1KRNx7uDPpxp
 wxOXjLy8/Ff/bXEaBqd4LvqSTAkqm8iIXkXG4h6F6KcPCkWAYUSFf/Q8Y6zoFTCAXg02zrWYQYm
 z3LNmzshno9K1jYNxBKOTuV0jzkV5jLeOB5ZaQJyyNNUj+1lzcYX+SxjRqPgbXo8i56BJygu7hW
 t/HZn9tetPdbtlywcwnCWNGirZPAXSlgzXLzzxLqx+K4LRD2yQXs2ovCAo402GRFggjEnmjXjpW
 Ria4jruL1Z3lPudfJWv9Qh6/om9dp93bkTUXn1oq3QV2YEzqC1uWtTECKV41FUg/KwKjD1txYJz
 xaet4YVKwRmNcv7+oNck/27XCXNuWr8AgUF9Q=
X-Received: by 2002:ac8:590a:0:b0:50d:9073:f8e with SMTP id
 d75a77b69052e-50dd5b3f2f9mr125410281cf.26.1775931165548; 
 Sat, 11 Apr 2026 11:12:45 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:50d:9073:f8e with SMTP id
 d75a77b69052e-50dd5b3f2f9mr125409851cf.26.1775931165020; 
 Sat, 11 Apr 2026 11:12:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefbb10sm1549362e87.67.2026.04.11.11.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 11:12:43 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:12:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 16/39] drm/msm/dp: use stream_id to change offsets in
 dp_catalog
Message-ID: <exhugtt2cf2zjvbing6p5q4ubyiealzj5ijcdrmmp2s45liz5q@7ccvl4euerkq>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-16-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-16-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE2MSBTYWx0ZWRfX6uTtXoN2JJyU
 9yYrhO0NAkIhzbvT2QxE9d47NdhVDrTVAdsMZCfwimG1tSiiCxNE3kCow3NvyERCrC2f9OqD75c
 SrWN2QHPSJdjGxfTyoU3tt7p1qC/NITVF6ytzlCr9y3eQO5HHTQprbFsCHY3DJMc+xDIoC2Trhr
 W9n56nG7+GOgCKZuoLpmPS7Fuqhbediwq2ldk0PesG+4eUdzpB6mDbAIjcleS+bgRtXDWaNg0+O
 NB8CnTNogirF2g/aX55EiZ9Qc86Lo8/w2QsmYB/7hl9jYToLefyFs1zn8OyIaRdVNBYmHhtVWRs
 c7SHTHUicG6Ojs9lGDZYP2Fds/K4jqdxa08mFapV9G8JQHpkvehzlEIKK34LYku8l+k9J4EtCB7
 lJZPphehM0Vd+8GQ0fiIJaiimi62OKxiqzPPd2cnIOr/xK93CvwtkuDeCVdtdtctjgkeoJ/yGCv
 Vp3sGTvghHTpgaDIP0w==
X-Proofpoint-ORIG-GUID: aa28CAu2QYvyBR_fXy9etY2hH-Tnrq9c
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69da8f1e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=szrjfyC7KoKo6QiwLCEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aa28CAu2QYvyBR_fXy9etY2hH-Tnrq9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110161
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

On Fri, Apr 10, 2026 at 05:33:51PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Use the dp_panel's stream_id to adjust the offsets for stream 1 which will
> be used for MST in the dp_catalog.

Please start by describing the problem.

> Stream 1 share the same link clk with
> stream 0 with different reg offset. Also add additional register defines
> for stream 1.
> 
> Streams 2 and 3 are not covered here, as they use separate link clocks and
> require separate handling.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
>  drivers/gpu/drm/msm/dp/dp_reg.h   | 11 ++++++
>  3 files changed, 81 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 1e80d6fc7bda..a52bcd9ea2a3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -393,6 +393,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>  					    struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 config = 0, tbd;
> +	u32 reg_offset = 0;
>  
>  	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>  
> @@ -409,7 +410,8 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>  
>  	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>  
> -	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
> +		reg_offset = REG_DP1_CONFIGURATION_CTRL - REG_DP_CONFIGURATION_CTRL;

Where is the actual write?

>  }
>  
>  static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> @@ -460,12 +462,16 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>  					   struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 colorimetry_cfg, test_bits_depth, misc_val;
> +	u32 reg_offset = 0;
>  
>  	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
>  							  msm_dp_panel->msm_dp_mode.bpp);
>  	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
>  
> -	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
> +		reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
> +
> +	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0 + reg_offset);

This quickly becomes unreadable. I'd rather have something like:

reg_addr = (stream == DP_STREAM_1) ? REG_DP1_MISC1_MISC0 : REG_DP_MISC1_MISC0;
misc_val = msm_dp_read_link(ctrl, reg_addr);


>  
>  	/* clear bpp bits */
>  	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
> @@ -475,7 +481,7 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>  	misc_val |= DP_MISC0_SYNCHRONOUS_CLK;
>  
>  	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
> -	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
> +	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0 + reg_offset, misc_val);
>  }
>  
>  static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
> @@ -2446,6 +2452,7 @@ static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl)
>  }
>  
>  static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
> +			       struct msm_dp_panel *msm_dp_panel,
>  			       u32 rate, u32 stream_rate_khz,
>  			       bool is_ycbcr_420)
>  {
> @@ -2455,6 +2462,12 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>  	u32 const link_rate_hbr2 = 540000;
>  	u32 const link_rate_hbr3 = 810000;
>  	unsigned long den, num;
> +	u32 mvid_reg_off = 0, nvid_reg_off = 0;
> +
> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
> +		mvid_reg_off = REG_DP1_SOFTWARE_MVID - REG_DP_SOFTWARE_MVID;
> +		nvid_reg_off = REG_DP1_SOFTWARE_NVID - REG_DP_SOFTWARE_NVID;
> +	}
>  
>  	switch (rate) {
>  	case link_rate_hbr3:
> @@ -2509,8 +2522,8 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>  		nvid *= 3;
>  
>  	drm_dbg_dp(ctrl->drm_dev, "mvid=0x%x, nvid=0x%x\n", mvid, nvid);
> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID, mvid);
> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
> +	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID + mvid_reg_off, mvid);
> +	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID + nvid_reg_off, nvid);
>  }
>  
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
> @@ -2585,6 +2598,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
>  
>  	msm_dp_ctrl_config_msa(ctrl,
> +		msm_dp_panel,
>  		ctrl->link->link_params.rate,
>  		pixel_rate_orig,
>  		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index c17b87353d1a..6c88cc7e3037 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -447,27 +447,35 @@ static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct
>  	u32 header[2];
>  	u32 val;
>  	int i;
> +	u32 offset = 0;
> +
> +	if (panel->msm_dp_panel.stream_id == DP_STREAM_1)
> +		offset = MMSS_DP1_GENERIC0_0 - MMSS_DP_GENERIC0_0;
>  
>  	msm_dp_utils_pack_sdp_header(&vsc_sdp->sdp_header, header);
>  
> -	msm_dp_write_link(panel, MMSS_DP_GENERIC0_0, header[0]);
> -	msm_dp_write_link(panel, MMSS_DP_GENERIC0_1, header[1]);
> +	msm_dp_write_link(panel, MMSS_DP_GENERIC0_0 + offset, header[0]);
> +	msm_dp_write_link(panel, MMSS_DP_GENERIC0_1 + offset, header[1]);
>  
>  	for (i = 0; i < sizeof(vsc_sdp->db); i += 4) {
>  		val = ((vsc_sdp->db[i]) | (vsc_sdp->db[i + 1] << 8) | (vsc_sdp->db[i + 2] << 16) |
>  		       (vsc_sdp->db[i + 3] << 24));
> -		msm_dp_write_link(panel, MMSS_DP_GENERIC0_2 + i, val);
> +		msm_dp_write_link(panel, MMSS_DP_GENERIC0_2 + i + offset, val);
>  	}
>  }
>  
>  static void msm_dp_panel_update_sdp(struct msm_dp_panel_private *panel)
>  {
>  	u32 hw_revision = panel->msm_dp_panel.hw_revision;
> +	u32 offset = 0;
> +
> +	if (panel->msm_dp_panel.stream_id == DP_STREAM_1)
> +		offset = MMSS_DP1_SDP_CFG3 - MMSS_DP_SDP_CFG3;
>  
>  	if (hw_revision >= DP_HW_VERSION_1_0 &&
>  	    hw_revision < DP_HW_VERSION_1_2) {
> -		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, UPDATE_SDP);
> -		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, 0x0);
> +		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3 + offset, UPDATE_SDP);
> +		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3 + offset, 0x0);
>  	}
>  }
>  
> @@ -476,16 +484,25 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
>  	struct msm_dp_panel_private *panel =
>  		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>  	u32 cfg, cfg2, misc;
> +	u32 misc_reg_offset = 0;
> +	u32 sdp_cfg_offset = 0;
> +	u32 sdp_cfg2_offset = 0;
> +
> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
> +		misc_reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
> +		sdp_cfg_offset = MMSS_DP1_SDP_CFG - MMSS_DP_SDP_CFG;
> +		sdp_cfg2_offset = MMSS_DP1_SDP_CFG2 - MMSS_DP_SDP_CFG2;
> +	}
>  
> -	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
> -	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
> -	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
> +	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset);
> +	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset);
> +	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset);
>  
>  	cfg |= GEN0_SDP_EN;
> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset, cfg);
>  
>  	cfg2 |= GENERIC0_SDPSIZE_VALID;
> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset, cfg2);
>  
>  	msm_dp_panel_send_vsc_sdp(panel, vsc_sdp);
>  
> @@ -495,7 +512,7 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
>  	drm_dbg_dp(panel->drm_dev, "vsc sdp enable=1\n");
>  
>  	pr_debug("misc settings = 0x%x\n", misc);
> -	msm_dp_write_link(panel, REG_DP_MISC1_MISC0, misc);
> +	msm_dp_write_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset, misc);
>  
>  	msm_dp_panel_update_sdp(panel);
>  }
> @@ -505,16 +522,25 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
>  	struct msm_dp_panel_private *panel =
>  		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>  	u32 cfg, cfg2, misc;
> +	u32 misc_reg_offset = 0;
> +	u32 sdp_cfg_offset = 0;
> +	u32 sdp_cfg2_offset = 0;
> +
> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
> +		misc_reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
> +		sdp_cfg_offset = MMSS_DP1_SDP_CFG - MMSS_DP_SDP_CFG;
> +		sdp_cfg2_offset = MMSS_DP1_SDP_CFG2 - MMSS_DP_SDP_CFG2;
> +	}
>  
> -	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
> -	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
> -	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
> +	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset);
> +	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset);
> +	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset);
>  
>  	cfg &= ~GEN0_SDP_EN;
> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset, cfg);
>  
>  	cfg2 &= ~GENERIC0_SDPSIZE_VALID;
> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset, cfg2);
>  
>  	/* switch back to MSA */
>  	misc &= ~DP_MISC1_VSC_SDP;
> @@ -522,7 +548,7 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
>  	drm_dbg_dp(panel->drm_dev, "vsc sdp enable=0\n");
>  
>  	pr_debug("misc settings = 0x%x\n", misc);
> -	msm_dp_write_link(panel, REG_DP_MISC1_MISC0, misc);
> +	msm_dp_write_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset, misc);
>  
>  	msm_dp_panel_update_sdp(panel);
>  }
> @@ -580,6 +606,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>  	u32 msm_dp_active;
>  	u32 total;
>  	u32 reg;
> +	u32 offset = 0;
>  
>  	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>  	drm_mode = &panel->msm_dp_panel.msm_dp_mode.drm_mode;
> @@ -594,6 +621,9 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>  		drm_mode->vsync_start - drm_mode->vdisplay,
>  		drm_mode->vsync_end - drm_mode->vsync_start);
>  
> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
> +		offset = REG_DP1_TOTAL_HOR_VER - REG_DP_TOTAL_HOR_VER;
> +
>  	total_hor = drm_mode->htotal;
>  
>  	total_ver = drm_mode->vtotal;
> @@ -624,10 +654,10 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>  
>  	msm_dp_active = data;
>  
> -	msm_dp_write_link(panel, REG_DP_TOTAL_HOR_VER, total);
> -	msm_dp_write_link(panel, REG_DP_START_HOR_VER_FROM_SYNC, sync_start);
> -	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
> -	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER, msm_dp_active);
> +	msm_dp_write_link(panel, REG_DP_TOTAL_HOR_VER + offset, total);
> +	msm_dp_write_link(panel, REG_DP_START_HOR_VER_FROM_SYNC  + offset, sync_start);
> +	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY + offset, width_blanking);
> +	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER  + offset, msm_dp_active);
>  
>  	reg = msm_dp_read_pn(panel, MMSS_DP_INTF_CONFIG);
>  	if (wide_bus_en)
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 3689642b7fc0..295c1161e6b7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -332,6 +332,17 @@
>  #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
>  #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
>  
> +/* DP MST registers */

Which register spaces are they from? 

> +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
> +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
> +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
> +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
> +#define REG_DP1_MISC1_MISC0			(0x0000042C)
> +#define MMSS_DP1_GENERIC0_0			(0x00000490)
> +#define MMSS_DP1_SDP_CFG			(0x000004E0)
> +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
> +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
> +
>  #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
>  
>  #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
