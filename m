Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130AACD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B8E10F37E;
	Thu, 28 May 2026 15:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLBnNZCK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5ebYZFP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2F010F37E
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:25:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vgCd2794043
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ErmR1hLpUWMYC5McaPLOKuCL
 O2aW0JnKMVzTCEWLslY=; b=VLBnNZCK7s3NpUylF/G3q3yvonuDHJWtgJsIostA
 cem2KNgKrVjsGLsJ/h6s0PZ9uLE2k12/pXlid2NqPgzjfoyZENRxr2p4j+y2oLUZ
 SrQiZNjIlIUkZH+xb9f441sIH+3oQWLd6qHozeE+gjV+xFxXB/v9M79guHNjsxP0
 RtPigBKL1T4RA9Uk1Nba7NKcsd0kvwTwxqktictReR6fRGgXWi9rIVpTHUcyIlNI
 GRrQ7r7qsGDS5m6rE38ig9LaG33ht3bu1BfliVMWHIXEjpPfk1VFswcAfH9F/3b4
 2i73Scv3NXVdHVCjlK2RGq7LWQ/fFbTnenk2NXr5/cEKPw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y1ubuv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:25:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51494d74d4bso87501891cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779981946; x=1780586746;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ErmR1hLpUWMYC5McaPLOKuCLO2aW0JnKMVzTCEWLslY=;
 b=E5ebYZFPfXsTTPeax4Qvcqy6c4Ud/oGRt0rZhh+jPw/t9v9TZDJOUeXoseFZYjfDpT
 PGPCpidpDWzc5/pav1ATU2Y2fIsc3u8al5fYhZhaAA+wj7b6zRkAQPIK6ZUgTUoXpXqA
 PoXrrnoAl7w1Z/0pF0IpdjhIu4cT0CZoTiQd274Yv1OyMYxbcxVo2F/tSw8478MUqJRA
 wfIe7qo81uzaOGzQlXvaF3BSSLjX8oqP0RtOa5aRjoYMsUpqwl8j6u6X6I4vENp5wyqu
 j91WPeR4+kwdri787cxtN7Be6Rs1Vb1XDn8NFCf7tfHu/R+GtX46CVrtnzaKZ3g0g/aH
 grYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981946; x=1780586746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErmR1hLpUWMYC5McaPLOKuCLO2aW0JnKMVzTCEWLslY=;
 b=dtXDZc+zDXYQV5G9k4LDAKe6PZVTonPp+IDRJsT5t7lcMOE7w8dVwn0UoYVLPPOO66
 cOoS6r1Vc667+uwX7AxrLNVuB18xQU7Kjhiu/K6bAhteGv7eLbRKVznewKvFAX8BUnPW
 p3HKBLUCfhFinOJ8VTgOIx0PSZaBmnz3kPoDKwLXq2N7dbeM8pY+/yd2tzGXYv+faip5
 2fbzF/0avXQ9g4bxZwjJK4EB4KhlSQfTJFb+P0qHA7G/FbIdObK9uudLEicQsJ0Ue5KE
 fi3Nz3scsxYM5QYxPoSXymY8yp4t9lkl8jqhX+3KmcdnprW5S+oxwg/PpTtaQhoey4sN
 G5OQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lLKFNAcR2DbT7Kd2/8eSHQVe3DYBTuburYvI0AcoBKnfPh3g6oidHT46HPC+X7WwlOuwC7KVkRZ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzr4fiXGtANELr6yxlBszMgVXGat8dNqy5xzQoD7brE6lpt2rqs
 uDy/e18VIuMf9hUFeq/p5zTlIwbbcAtjXAhDGOEWaBGY+1vR7DfG+I3axPQiFX+yXXQ1VBlOs4o
 r9v/oooQbA/A8E7vl1FZYCOR5pnsbSvbRXD8e8bM4Q61z/xLOkmPzXAwOXzvhMncNs2rR8Cg=
X-Gm-Gg: Acq92OHiTRA6YjpJea3Jq9oLBU6zWF/TDhbLscOy6STc6ArSdXaGtQyQPQm2Ujq9bhJ
 OSJO886Av+vsG0USh2DSTwtOOKv5TTtIf01AVg6POdHAatbztI3mm9VfRzizQLq1/j3OR0u7v6a
 A9WIDdM2P429j3D0bhPVNNSEWm2Os24h9nFfMNWUEYwpgtWvzX0LOdlAH/FPKPw5oLcuKkBsqbG
 47N3jz7tecN1zY0tgbkS8DXW/+7SZFrI7li885spGrQgQdX4bh2AoCe3X1jVYYCMLv7DzLGOsCP
 f6QZw/2u1E5X3itK4Xc+8g8kzU7oC4JOExJSIEnc98EJxx+zM497++d6YJemu4h9x8sOZLhEUCN
 Ya3YYomQZdYXKuJLFCQhAWzjd275mzjfA/gkLV5xL/YQkcK0Rf914SC923Cz3Lr2m5RGN396nVB
 WX/pOTszPD/yM8hBTjW6cUt+9XyMjJ9oV0r9wE90mLbWKXrg==
X-Received: by 2002:a05:622a:1f06:b0:516:dc75:1aca with SMTP id
 d75a77b69052e-5172311597fmr22312071cf.26.1779981946570; 
 Thu, 28 May 2026 08:25:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1f06:b0:516:dc75:1aca with SMTP id
 d75a77b69052e-5172311597fmr22311591cf.26.1779981946116; 
 Thu, 28 May 2026 08:25:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa463312a5sm1960878e87.67.2026.05.28.08.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:25:45 -0700 (PDT)
Date: Thu, 28 May 2026 18:25:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v5 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <mar2smjimo3uoucxctofmjd25vsfun66m3l6i4prnyvo3z7dzg@7e565usiluvq>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-10-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-dp_mstclean-v5-10-a9221c1f1f3b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DsNmPm/+ c=1 sm=1 tr=0 ts=6a185e7b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=7VmRHP_rljhwBiH_WasA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IVvhgQeC0eECQaOh-3M1b-lsDUJKLtJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1NSBTYWx0ZWRfX9UzAZ+9nxWON
 cTb+Y/j8tHukB0om7c7oUWSur5xj5kaSB9UfRcr6+quz278FFKLTGLQ322Mj/rkTTxybEci+qRp
 6pUJVgkSzPrKeoS0o3msPl9CIKt9UDFjd3AvqjSAf48aqz5mKY8UbdCz6ndLBMgipb24AxrSAEC
 sFCnF3xpUydoZrHuteSenOaq4VpEjCU8MVBpuOl22+LiIf7WwMbeL8YicdxVJV2JY1E4MiI/Hct
 oMzwjGaCE6Wl4zhuDMnOeYMm0+G1pUYz/dAq3X4+v+LV0Ar5/V43i18DQbjzoXgz3pgyJuXfHXe
 fbjRicLNF3MdV7lnTEC5h6l2HawIDeklJHhaTgIivX7Ply4jAVeIlxkpDxeQzRKW5Km3CbEwiPk
 j2ugb9t5f22r3laPOBA07Irof8HI62kWZMD0KoYdGZ4hlHI7m6MejD+ydghgKwE0B9S/DyQj6u1
 AoOnMsGVjKbkCWZrZZA==
X-Proofpoint-GUID: IVvhgQeC0eECQaOh-3M1b-lsDUJKLtJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280155
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

On Thu, May 28, 2026 at 06:40:31PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, multiple sinks share a single DP controller, so a cached
> panel in msm_dp_ctrl_private can no longer represent the per-stream
> sink. Drop the cache and pass panel explicitly to all stream-related
> dp_ctrl APIs.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 208 ++++++++++++++++++++----------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  28 +++--
>  drivers/gpu/drm/msm/dp/dp_display.c |  24 ++---
>  3 files changed, 146 insertions(+), 114 deletions(-)
> 
> @@ -389,7 +389,7 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>  }
>  
>  static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> -					    struct msm_dp_panel *msm_dp_panel)
> +					    struct msm_dp_panel *panel)

Please don't mix sensible changes with the renames / cleanups.

>  {
>  	u32 config = 0, tbd;
>  

-- 
With best wishes
Dmitry
