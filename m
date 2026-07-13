Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB724C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223C010E50A;
	Mon, 13 Jul 2026 00:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAWPE8h6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HmqdS1qT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2894E10E506
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:01:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNU1kX3767896
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HAb8Upwmrk7LAt8tz3SMF0TU
 5cLVuPTANU39n3y2qgA=; b=AAWPE8h6GhRnojFn4dLLX+rkHCJ9lmKeqZ9QtcZv
 DSJYE0aa8/y9INRQt+wDBAguCCUbTr50Cg9klM+NoDG/xP1F3nrqWyExx17bKByZ
 DwC4++0JMjV6+nd2DftwZrMTHAiATBVrHCf400WnEBVcUxiu2MqA2vci8ciBCDYV
 4RcySD1bL5o0an8LTdcyKOayM3qgqB3RHT+1aRzFKXthSMWudjYi+qEzx+zx9ACw
 Sa7UWsqIdtre6/q+5pfAiRbBNqRQMrmIEo4bkqGW/v8Yx146MVz8S24r3TEheCZe
 C6i14gFgNz3xSzOBo7YG6VqX4j3VTGyV4bqH9LzuR0/WTQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf483mkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:01:24 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-738e5b5ef68so1303830137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900883; x=1784505683;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HAb8Upwmrk7LAt8tz3SMF0TU5cLVuPTANU39n3y2qgA=;
 b=HmqdS1qTtPKNxovxRyKVGTY6YiI4mkfbXDhclhPROUoGPX0BS2t0Bn9hoI/zBPXu/f
 cvtWBDa87+VzKavFdMtEhzjZFCzO9wIXPM/K0W/kJi566YcdA5oiDaDy/ywJsjJwczBA
 edbP58DcXI1u2aAjqKFEJ8zt+35dIs9PN9DTUm05T9ImgRwJ2q8dJ9Yxo4pGUfYY9XtE
 In21mOPFaoA8aEqb1X8zyH7ypFPdEvNr1MCt0QMc+aJthMxxUFRz6Cyz2ZQWxLi1mQWL
 tWjtvWjcAZoNy4B/cn5CJR1Yy3t17j7orwbXIQ6aaI9KMAIPfJmSIhily4KFw1Mnq5Jj
 xHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900883; x=1784505683;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HAb8Upwmrk7LAt8tz3SMF0TU5cLVuPTANU39n3y2qgA=;
 b=IC1aKmavc3bFnb3RHkl01O5V+R7l7S1CkKQMGtvQqCv/V+HtcI+lGqHkdMGp5Cnxg6
 f8iR0IMlyy0DTJRbrL4FCBp0K/2PksvfsJNQaFgbt3s6Y1dUGoq2C7STBL7n7jH28n27
 ut/edsfUgdXyHiedsRCYzqhggSumRZrotTgH2T7jWBIlW0ygbrMwWdQZDeauy2CMdl31
 4GYA1YqG8Ttg9+jlgok91JnuY3GFRwoCetmBQRkH+OxdujpIlT/jEmbu/u46rxMNlPB7
 S1KwA0qcDNiICxWogS2vUBa7pLdQ697K8E2FOpzMBkB2Pw1O1YDbHcQZInH2JuwRQZGZ
 Dl8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvhoXWi3A2tqsTfbVTbif1MwtEFSbXO7C0XQKx6TiZmCTN7jRBUT97aN3fQ0nRBTciKbE9okPIhtg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1x5F73LlcObChbeEnKYVdjfxFobKTWZkdyjkUwNAo+BEcOPVw
 5q32xWvtwi6jDxLjQ7OhebGVnVEaHxfBYFsSb7TA9wT8MRfxgSyC2WgClIZaDg85FStsf6Ln2WZ
 QPO2dJt6ziF764Sb5AlxwAPYcf+7zKSd7V7QUCP4Qm0JF3Thv4n/SiLcFqxhuYCUH/wyfZwI=
X-Gm-Gg: AfdE7cmNGzWX2sNZykYlDbkC/SVElyim/xhqzrg6Eix8imu7O2ip+Rem7tmReZHOR4C
 pe4gWAZ/xq9Vl/NHtwuyspD+egMNpyCP2PCbSmovmoO9bERyGWubAT7W4IN4SatdzjDlP+763nx
 ZyvninMyo7T6nbg5OSd9DfaJRm0vJx+JZMxmi6ZmmQ/MQq7Hvfg3vgsll8XcQ7TbGfP6UhFmYpm
 xFKXT4315Kq6HtrfbNb+HsGtfMx1pf3fZvhXCe9YStOYnigl8/utq/ns6Qe19r1QiaZ1+p47pns
 51Q0aPtJKZCVpc3rdsjea1FFgS6aYc/6WJvbt+st4LmRtQK86jMFTrry1pUKgzBJFGADYMMP4Dd
 sg5KQoZnhuQ8OvDMIp6vSnZpVrTWWgK3InfVTW3QOdK6zg7ucYBRn84Pc8Sxm0jKpd0gUUl+c27
 QH4u1q8tWPUaCylYRbkndigkD7
X-Received: by 2002:a05:6122:35ca:b0:5bf:d2c7:c481 with SMTP id
 71dfb90a1353d-5bfd2c7c633mr2128264e0c.7.1783900883356; 
 Sun, 12 Jul 2026 17:01:23 -0700 (PDT)
X-Received: by 2002:a05:6122:35ca:b0:5bf:d2c7:c481 with SMTP id
 71dfb90a1353d-5bfd2c7c633mr2128231e0c.7.1783900882802; 
 Sun, 12 Jul 2026 17:01:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b1c943sm22431121fa.18.2026.07.12.17.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 17:01:21 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:01:17 +0300
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
Subject: Re: [PATCH RESEND v5 20/25] drm/msm/dpu: expose dpu_encoder ops for
 DP MST reuse
Message-ID: <uja44sqcdoegy4lm6hmd2eoqmpdtai4bdbndlgtgw7w4k6lah2@hw4etqvmcj3v>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-20-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-20-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI2MCBTYWx0ZWRfXzAgwQKh8uQan
 LEOyH5KaIzMORw/IA6Nd5uiJdfxFXzMS125KlryFU07SphSeatY4P6J0q5oxi6X5Hq2OyO8F6yy
 RiFtoZAjBTLDu204U/FDKvYf6MwxDeE=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a542ad4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=zSW4VIRgNx-_4IL8-IQA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI2MCBTYWx0ZWRfXzJ4xRuW1OQQk
 b6lg4JQv1PenEEw9PO9G5fTHYa3A4G0xRGGn8AZ2z1br0la+zj0ieo4mfLu80kZsNNWQPPJC9Sh
 fyAe7mcgU/h5AvmzHhO4PumO+fS20AllSAAnmz9NdlRD+eCnGAnL03EOOwohrRToT8aBrSluIbx
 Qa66zC9vggrgSRYKgwi9BpgVNKMM1fxjmZTb54tdaef15T022ahcVfZoYc8cubbSkajvtl48xfb
 cyOeTlFsHvlRrvpUATydaKk0Oyyo4vPTxH77HRnCblLnQCWFb8d/gbZE0Y2oaY6hG/veSE5DaeE
 xIpXbix6/zL/LexC3AR3hFQnfG1l9HGwwuOOkrbtUry3c/64OYRKRe6nTwRCDl0lgmRbaj5sZAJ
 lDiuhcTi3sKrA+DfV2oYix/10/xUXt0cQtKElR3BIcJIskvuE5EEgBBJgUCCbWNyrVLFYHNWBn3
 6g+Kd+3UaqkaJ95Y5Nw==
X-Proofpoint-GUID: zGjH6Myy_1BTJtSPsKDwqXq34nDJwbog
X-Proofpoint-ORIG-GUID: zGjH6Myy_1BTJtSPsKDwqXq34nDJwbog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120260
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

On Mon, Jun 29, 2026 at 10:14:41PM +0800, Yongxing Mou wrote:
> Export dpu_encoder_atomic_mode_set, dpu_encoder_phys_enable and
> dpu_encoder_phys_disable so MST encoder helper funcs can reuse them.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 ++++++++++----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 778e231d4967..1c74ff6f0dbd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1149,9 +1149,9 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
>  	}
>  }
>  
> -static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
> -					     struct drm_crtc_state *crtc_state,
> -					     struct drm_connector_state *conn_state)
> +void dpu_encoder_atomic_mode_set(struct drm_encoder *drm_enc,
> +				 struct drm_crtc_state *crtc_state,
> +				 struct drm_connector_state *conn_state)

The commit message says nothing about renaming the functions. Why are
they being renamed?

>  {
>  	struct dpu_encoder_virt *dpu_enc;
>  	struct msm_drm_private *priv;

-- 
With best wishes
Dmitry
