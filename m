Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36954C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 09:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9051C10E1BC;
	Sun, 12 Jul 2026 09:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgQxYWWd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YSsBPwKx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8D210E1BC
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 09:37:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66C7T58Q2059956
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 09:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oE/19i9toA96SneFhi3ZDhc+
 txpytRBTsnN+E2BtECQ=; b=ZgQxYWWdXQej79t/PWYU5EcGWePsmavZwZYbK1vb
 zpiH8MZz65yTkuCOr/gcFX2nNBvcaWWCGspiS5RxKhwOEyDCd7iwii+qZc83g1Go
 t09F/qrsvh3iHfcRdjO2F/A3pqNTa1LTDAjQeL7OrUgyXUjtZb8EAwNfXx5i4/AI
 QfuRvP+aawc9AnkUrIl8E35mNOnOsWM8QtSUrfxIYJsEB/UdJHMq5ZMuR58vN2r7
 YW7RtfhgBWrvr/qgGp/Z6eNZbO1NDdqLQ1RaHEsC6bBWr+ooHPzqY54rFxgYaQ2k
 Dc2bbJbaKfpYOnm5FIbhTf24RW3EI4O49QnZmKY03sdnPQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeafag6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 09:37:12 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bfd8a074e0so321642e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783849032; x=1784453832;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oE/19i9toA96SneFhi3ZDhc+txpytRBTsnN+E2BtECQ=;
 b=YSsBPwKxJ94XvWoVHYslpURjVVDhj4Ee72W2xdvg2PWY8vOIEZJvogXPJ/Taja110t
 2BoPMWDlB7e4n6vCwXwu7++6e5CsG/qz3r0OebRDFUqKuFEIRdIOaFZ6k1LGbWrlKlfC
 zPMOMLD56C/N++3LVHfYsCpu/+tB8uy217QBzMZrRa/upN3NzkBrfwSPO/eIU7UntpYJ
 jEYVDCVdT7VaCdiO7x9n4wGMAeCXIc2IJbNFrEJ55IkUEjw29Og3VohF15pxbe7OVhRN
 g6nRtqJfeZ9mtvGX2P1e0Qfa0J3IF9UgMSj/RjE5E+ewREmmVroPvCDZUFGFzTllMSPC
 FmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783849032; x=1784453832;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oE/19i9toA96SneFhi3ZDhc+txpytRBTsnN+E2BtECQ=;
 b=EEHt/SpHVgMWcdgy2MoCMKYEgPqNHXLE8DicJBNsqVPHpiY+hZ1DzPalzzgokKOLtt
 5Z1HH4ufsI6A2XM7cYEtokKRm0wt/17PXw0HpalNcsEDmrwntaaXOS8ml3TutqXxf0wq
 dnoyh8EEkmQr9FfY35WT9BNmprm5BN+HDEzY1+WtgMkahyiimLjUWDCFrDbEG5g3keUP
 KJirPagGvDceWDFurY8Hrz7w0a8Iw9lO2JK/Vya3WRiwLVZggS/KW3b3smkldPqCvoIn
 hcxWGm0nPahbGojkj0TFpAA9UXOEe+xnhn5wsI7d2r8v6F4zdVLtCAAsUfj+jqF6SJnN
 VL5w==
X-Gm-Message-State: AOJu0YxZvaoUdZG+wmQRDgQUFc7+SY0X9hz9/GkpNfeettcpjPAG38zj
 ZksYhlJ4S45l2lp7o4N6Dry1xAccGl0PsE+cMGX66vp78h9HRhfWoEN/5V2k40pcodP9FBtKHTT
 9AStJsQZZN/uFnV+sFMrsit40TYge8D0SWl6OdYXIQSRF3oPsr12BG5PvNouQ5pKVU4L715M=
X-Gm-Gg: AfdE7ckuMOLWaY2Pr3hjyZW94W4bD8jRgspI4MfdU4+d6hemI4dn55HexbRbavlH7zo
 /qzf2zgwybAopLcZE2pMxFLlBQO59jPARwGNqr8fzVnM43c/fsDo5OFViKHQWspIoqsBwkLbJrW
 hhZTW3YTMuW42wBbf+wt4dblcetTlz9qEu8B5hLn2leDoOohHolVMxRzhu3hJPsjKH6xZT+x9+n
 boi/Ka0YqiWO+V8JkbwnCRkqEUwuNnDWsgsVH+M4h4ADvRTajuqB8d22pvmeIhx2l+GkJXDTF8K
 sPui9wfzfYdOVDEikQzZi64eywI5AwmtYOdskj0fqlCXLFgbYPWrbk2TD0UA0mteHtTgYjNCjyE
 kZgw7ubCNtYQ6M6pSdSpn5kAEAANs3LnPO3RVuA2sGchKAeD1PK4VmOGITsqY+x0P1RIygmBIE5
 TlQ65SFmexRHj2pkrgMyEOKpQR
X-Received: by 2002:a05:6122:169e:b0:5bd:a247:49e2 with SMTP id
 71dfb90a1353d-5bfbf04ffa4mr3254314e0c.1.1783849031896; 
 Sun, 12 Jul 2026 02:37:11 -0700 (PDT)
X-Received: by 2002:a05:6122:169e:b0:5bd:a247:49e2 with SMTP id
 71dfb90a1353d-5bfbf04ffa4mr3254297e0c.1.1783849031479; 
 Sun, 12 Jul 2026 02:37:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b83a93sm21643201fa.24.2026.07.12.02.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 02:37:09 -0700 (PDT)
Date: Sun, 12 Jul 2026 12:37:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>, 
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dpu: fix parameter name in
 dpu_core_perf_adjusted_mode_clk kernel-doc
Message-ID: <u5ozkmhq3ll4pfhvxl63ezf5dtgz25lvrwmpk6u7ofccnjicw7@skim2jft2cyp>
References: <20260530201342.10538-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530201342.10538-1-rosenp@gmail.com>
X-Proofpoint-ORIG-GUID: ewGX1tND9OXOl-Tkmvi-mpbffsx7UAgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDA5OSBTYWx0ZWRfX/W6+iQR3GYnI
 jr4Dgg4domJ/6XfPbMlykN1XQ7ihk4ZX+ZfZPr93dA9vseuew+eaImFU1NUOFpEycrpA6KA85RZ
 4lYsG6VROtA40F5Aptdwx6D+K6PltX70prs91K9Nx9V5Nt0Saxa7mnn2Lb1HRehDjuruMQMnlQj
 4ZeqpzMxEXaG7+79oEdx/BbQUuPDXs7hGorGrl4GL+t3fNrAAmWdtDMHhNWVVrSr77b5cLnOSCK
 rE1L0liOuNfFLESrcRsmmLQJqga2Y6PzKHSyJ9ripvldcdUbkHeEPVQI4BX3F+iiuF8/l55goQV
 Wc5JY6TmQSIsv5hqsebD+vvnV1esRklFY2/3w9ZTV5IjEY28bhitGvFf5NyMuvp7RXVgtI4z/wQ
 7nqx+vLTO49G1KRFxlNEjMvom4i5upnaxlQDXRQDcD4IQlYVya6aTnsGxYpf9pperf78ANFq3ey
 rZxNVw3Yt55seP8HR2g==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a536048 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=zdcK4JMYJf_hBWaldjIA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: ewGX1tND9OXOl-Tkmvi-mpbffsx7UAgQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDA5OSBTYWx0ZWRfX5fQyzENfLplZ
 o8tcc3mhyYwAeWGCJ+YP0GIS5M9I5RPfeXffDl4khZ9OzdgSn0nvVPRZvOPLXo2pyJDwooWnKHK
 p1wOjx3Rr2AsY0mFNNyW/8pKgSHBzMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120099
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

On Sat, May 30, 2026 at 01:13:42PM -0700, Rosen Penev wrote:
> The kernel-doc referred to @crtc_clk_rate but the actual parameter is @mode_clk_rate.
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 13cc658065c5..2ff255d7795e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -34,7 +34,7 @@ enum dpu_perf_mode {
>  /**
>   * dpu_core_perf_adjusted_mode_clk - Adjust given mode clock rate according to
>   *   the perf clock factor.
> - * @crtc_clk_rate - Unadjusted mode clock rate
> + * @mode_clk_rate: unadjusted mode clock rate
>   * @perf_cfg: performance configuration
>   */
>  u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
> --
> 2.54.0
> 

-- 
With best wishes
Dmitry
