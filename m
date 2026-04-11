Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF312F3ED59
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C2C10E229;
	Sat, 11 Apr 2026 18:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6FWnChg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9N0HdWo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9AAF10E276
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:04:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43Qft621305
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IXF+ZYDY+njOzNrPh688DcH3
 uDbEYAIr/6wHxBHBDFM=; b=j6FWnChg5jqghWxdFlNpxybU/IEWqN/8+0gGsf2j
 /sBgRv4RKs2bzW1WKkcBxlkVCWmh6NoBK2gmwJ2SCwgD/o18+bPUV3939/7xgw4C
 zMUYZ63THeFzyGSyUs2hz7Fs2ZVW7ngxvJEAcx6S3SqKJaoH00J48oe+RsQoXNHJ
 UANVY32qvsWButxUuUXXYFSBpA7XZS8lRtkBp3fGG57d8AHWeC62Oi4mawgDLHtJ
 ewcbbhQgfeLM/VQIfa6oryyf9Zu998DuJS9fu8pCZgvwnz0v59GRUXo0TA4W4AoW
 myKS9cKRduptQJWZgJjEGGIZAuYd8n2YNkwFYZXarumCwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfs68c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:04:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d831e8083so29928691cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775930662; x=1776535462;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IXF+ZYDY+njOzNrPh688DcH3uDbEYAIr/6wHxBHBDFM=;
 b=J9N0HdWojkL98ky/H69jE8MAs9Q6o3Icew6YqdfD0DZtMqq4YnGuh5w/6TPQFQuLHO
 1QTS0KSz4sAOd63a1jBcqoDy2g6OjMjci/QyHCGV+JeSUzkJrxKhXKgIvKnr61V2D9W9
 OpIdyfGmkmKkjd6mLUWQ+CpdKUjZUnxVJ2766/f9r4AO2o0GF2XfUYNeNKwhj8ksPsfs
 krDqcc/EmUFc0F7Eh3tU2B21MuQYBf8xefYkZeBOo48Z6hihRewM3rhF7pqiNx1/WyMK
 1QwkA/vYITUm3O6E/cCCGw2tTY8F1HHdMgXnTd8CjshotLNjiK8fIVJqF3UHFT0Czujj
 S6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775930662; x=1776535462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXF+ZYDY+njOzNrPh688DcH3uDbEYAIr/6wHxBHBDFM=;
 b=VpVwOZQ8Wa6Iex7m12zdz8ey4BFrRp6UJdaWq1MU5DDcS9nMAqLzE9fNalWq+LUDTP
 y9UIg0x1Y61preSPTvqNb0whrQvTWjiBmPkSqJUTIbDpJj6uxxsAiNTaB+pw/IrrKBCJ
 N7wrEG9ILBEcw/tUvCkMcq1i4tFcVOZftkzTYuRSLVvajD+TSDLF/39y3n+5f1rX8o6r
 uQrSHGzGmLQVrm7Z6lAkhlIYs1eis7O38D/5DfvO74+vv67l0Ldy0CF0wTeuqy09OdI1
 dp+0fComxLmDJYf7ZFlcaik2cXw9H+Zxf+QNCXpmT8xXKRz9tyZweVNMuzIXGLapC+c5
 MttA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs6kPO9ojZ3JWSGK6d/QC+BYphQx4EsVbWGinOqXeWSRZQK4gEqlRRDjLNDzlYci/D4l7khebuL8Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU0auIQ5sinLdFfPjdvscGM7YFMvnh+DD//LW8swXhAxpA7XlU
 R/+Zr8KMrXlTK37ADN/22meqBBAxZ1r0dQH/dDAqSM7WdvKvljhGGXhTVNhmDHkKD8gEimemh3N
 vDvhBQGnEWmZjKd8UGABKMbYdhk060ztQRRNu+ow/a2EMFgGKCvTIQiT9I4HMvhf4h2ngqFM=
X-Gm-Gg: AeBDiese3vt5dqoVZa/1oQnzFGhxLJn8hQPHQVxevGA+lmVbXnM9zL8TQlChT5ftbaO
 ZIR2XJ5GHfpObw8LB6LFfkXLsRWEKaaMY+i6QJJztOYrhKsvBbeQpbojCyLQ+f55bScThEwE9sO
 6n5YGQCTZo0d71IFiAL8jUWGsmZRhQObz8fiCrX779efwpsh4OEYsQoRbJ0hSYpANBVl1a8Zwch
 ik5v6GKxVfyb9g6SVw5Qty4Tlu9KDD6Xgp8r/ickhoYtMSVftTo1MPIwCtD8P+SdaEoCEOb2R85
 7I9p4p/pIT8FoYxa1+NeNHsfj3+p3DAU8ChIxsd2lg6lLYbBzIUGmFrNBeO8xkYGFsi9DIltOIl
 6i05VbUBoGfQIskNk/2zxLFxiOXAP8EYweSH8G4pbhCgrfadsWx9oofFnajAZX558jiYYaqplAr
 Bsoc6Z6c+tuxyYB9ye2Ft+W7MZPUQsLtXQyWI=
X-Received: by 2002:a05:622a:834f:b0:50d:aa99:7bbf with SMTP id
 d75a77b69052e-50dd5c0be6bmr97373331cf.43.1775930662274; 
 Sat, 11 Apr 2026 11:04:22 -0700 (PDT)
X-Received: by 2002:a05:622a:834f:b0:50d:aa99:7bbf with SMTP id
 d75a77b69052e-50dd5c0be6bmr97373051cf.43.1775930661871; 
 Sat, 11 Apr 2026 11:04:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee11f6sm1535434e87.44.2026.04.11.11.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 11:04:20 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:04:19 +0300
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
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
Message-ID: <4z23aj2mzpgvaoqodncmi47uhydgtrzagh4j7uog565qm2t4in@mrkummd4vp6q>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-GUID: _yoX3rIOOUWRKET80Gea3Mr0bpLxF3z1
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da8d26 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=F6drfhpXLueasqm-KwwA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _yoX3rIOOUWRKET80Gea3Mr0bpLxF3z1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE2MCBTYWx0ZWRfX9FR741uATvm1
 mKdPzlxZHPTAZC2k9+2K0ZnZrdrtfRuB57VAXKq+Uj1G2gxOvBPU8Ojx5qY8hCHBP57pu7a4HRs
 wzhxjdLMeMfdH4N+tW6f0MeThEqXK7yTL7KWM375SxIV4LEzKWgjxLXZXQJ39h6JlvtviCDxnVP
 16L3omj+BbqkFh910yJplgsoFzsgy/XCY1IX/k/e9btN5BEr7jnaUcDNZrhLmQhmy0KFk7pXPLm
 90NO4HKPa005Z7nTIFPg1gL+DDrdOG/8LB03SkLWYh1sbvLv5OpNf4+kPwfKnhZ5iS6PAbxTEGv
 EmrOfF5eP0YUvjEWNvi5RL6rsvOz7gCP1QRY/LM8VlWL0dRqzgp2ITdW/t3wH/DJJuWOIEjnkeC
 on76qMc3sP1CvqE1EdYbxtzl+Xe3vr0j2bdIWZxrQlzjMnsBaYMP7L/nl/20buxA7CfGy79SdGu
 KsLw2+2khO6VyqI7ECg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110160
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

On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams.
> There shall be one dp_panel for each stream but the dp_display
> object shall be shared among them. To represent this abstraction,
> create a stream_id for each DP panel which shall be set by the
> MST stream. For SST, default this to stream 0.
> 
> Use the stream ID to control the pixel clock of that respective
> stream by extending the clock handles and state tracking of the
> DP pixel clock to an array of max supported streams. The maximum
> streams currently is 4.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
> @@ -2735,9 +2740,17 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  	if (rc)
>  		return rc;
>  
> -	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
> -	if (IS_ERR(ctrl->pixel_clk))
> -		return PTR_ERR(ctrl->pixel_clk);
> +	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
> +		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
> +
> +		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
> +			return PTR_ERR(ctrl->pixel_clk[i]);
> +
> +		if (IS_ERR(ctrl->pixel_clk[i])) {
> +			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
> +			break;
> +		}

Almost missed it. If it is -EPROBE_DEFER, we must return an error. In
fact, I'd rather check for -ENOENT (or is it -ENODEV?) and pass all
other errors to the caller.

> +	}
>  
>  	return 0;
>  }

-- 
With best wishes
Dmitry
