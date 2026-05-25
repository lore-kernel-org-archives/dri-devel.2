Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90791CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004BE10E368;
	Mon, 25 May 2026 13:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYeSHzfp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5WR0P2s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB00C10E369
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PD25dt691624
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iJf8SHZ8adk67Gfl+mwlKWiNU1Nx1Ly7j7+/7kZEWZo=; b=dYeSHzfpjdetWSDB
 BE3WGbNmn1PknpNnJljB5RP+KkYU7f8ngYBw+TX+rDpWUZu8WNkNmEaZzB4hYrCk
 iFai4Eb+FTPTw8DLd4tbFSWgGRrMOd4pxw96+kKKJWG8AQeT+NnjwdMxTFYxrt5E
 ky+SnooPN7jQvGvETIgC65xD79EMrJn08kRt8tugsFmCLdRyN0Uuqv59OFODwK2C
 MCcd+zVtf4JkcsLd185PHAGaLn76Z06qId6QFdwQAVakDixzbsDWMEWzqy3+fneI
 I4umIjNvlPuDX9XKZtR9OmRL/1X60HUzPxC95cQTfD69rIzjlVKdIcpN9vARANLo
 LekPrw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2g3uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:44 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e6027a5761so1018054a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779715963; x=1780320763;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJf8SHZ8adk67Gfl+mwlKWiNU1Nx1Ly7j7+/7kZEWZo=;
 b=O5WR0P2smL+kCOY3x0lSfVPAM41TujsBk/TYazjXIfoDiX3qv86y8LTSzeBO7OKYIw
 FKpd6xkxvrm/dHjk4l30ELirkU6/6IFAeoQvWIGFNx8CuccLuNTnvA9RaMT2gdzoOebA
 KF9umroiVffCRT5nP6lVzBlExFCC9JB/kAbeCb9Z4fZjSjW19G9K+5snvAzVIin46bM7
 vrmfF3OaMh+MN5r/HZmJGLdAAppteIP47juWeSdFZf6Iolse6tyVzK9nGjspF8j2rdgs
 0kWWff1bANeO+3zQJtT953rVpMg7OI4YJumq461ASEia/u4UyITvykreMFoLnU1G7so3
 /mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715963; x=1780320763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJf8SHZ8adk67Gfl+mwlKWiNU1Nx1Ly7j7+/7kZEWZo=;
 b=bt3p0/AI/YgruizAT5RfzVRpcJBTNOyfg1jnGOc9oSnE8cXyOj/BIjS4cMF2FbLHPN
 PO7i05sfkk/vTGA/7szcWup8xIIv7SB48g0mkiQ+nvyGSpr/HcZxAZr4cfjZFcSjlz38
 v3Tey0g6EMICh5ZBxPBLtbEhZpKFhg+1UGkleFsorkg5ya+c1hhrvHZSl2sb4QvTybR6
 eWwO9aYko289LMaf9eg0+CHMUGfd0ZibfZo2ncCZd5Qhob0AioHECVX2wuS1XM3AhNcg
 hzHe+52s/Z+UCi4WSGAP7iuaeJqQ4YPZQf5gDcAt1mlDlF2O5Z2EDJsmHdUDSK8+h+sq
 lNqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CzzdeId9hW2WM5mD36MLMBNN+4VrKfv77BaN/KRt8tq6Vyy+Ow4XnPwCcPsNsr7XXOyBZSAEg9GY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8Qh/8byI4gcdtrWZJKBUzlLc21jTdUdWHOQNXtMp3q+R1T+iz
 iLWfnRs47d164waIPUFuXKrxfAjKBctUqy0SMGrl3aXLLmAEmxGFaHqsISX9Yg7ev1swtPXrHzu
 fUDX2dvYBsJO2YJKiGu9gItaNMnO1by9n9Bc56k0UBVzvfZZsYNXfRGmCfKrdRaPcEBzTM/c=
X-Gm-Gg: Acq92OHecS/CQDk1Rx1uvA/uF15yndNLERvATli8D3xbdIkhcKDx/abeC1d7K3UKFSr
 L6wcVRqBjQpw5n9YkvTW3gPYf3umRftv4xTOiMxlj0h87RvLXEB5is9WDuZBbs5MSCJak5aT6aF
 e/QaCXqlwDV4ah5tP/TwPjDefrfimrnJ4RSwpIdauG8sQVPOu5jdin0SuG1hwIdP6KNwMA+svEp
 S5su7/xKh5Yrra7CTDm63kcuXwJspH39HFyj9YuPp/zVPrOK+S/sN2BCpNd+T3ms/bxXvIZB19A
 WezZr9xjEOkWrrgyklrxZR0R3pANuLVJsK1Ak0rDRpWWwq9yY0MXoXGQo9B77b9eBSbhQZZJNlX
 pQ07foEs/A4KydGE/dScj2RhyeaJx/MrJNxkrXqWodamUkYfAtE3YBTni
X-Received: by 2002:a4a:ec4c:0:b0:695:94b4:d4bf with SMTP id
 006d021491bc7-69d7e83053emr4656109eaf.0.1779715963334; 
 Mon, 25 May 2026 06:32:43 -0700 (PDT)
X-Received: by 2002:a4a:ec4c:0:b0:695:94b4:d4bf with SMTP id
 006d021491bc7-69d7e83053emr4656085eaf.0.1779715962851; 
 Mon, 25 May 2026 06:32:42 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc5eced0asm401848066b.39.2026.05.25.06.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:32:42 -0700 (PDT)
Message-ID: <00ee4b34-7f71-4448-806b-65bd62ebe574@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-3-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-3-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X41qgP1ys-a-LIrrejNaxvNwUT-ZxLl6
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a144f7c cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=e2WOG6c8x0SVvsxun3UA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: X41qgP1ys-a-LIrrejNaxvNwUT-ZxLl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX4CRHtWKQMPyO
 wppjmJRK3f6PQn4Oap4y7s5jTuUoR2QbClXgN+dt6B2OneO4iKhIE5zxWLcT3PwPZXzKtWifsZX
 qHXgrrUA9SxMWsPpMSzz/rYFO54h/ux57clOm9wEXCwCy7LMrIKJzSWLguAd9b8p1V7hkdx4pXa
 P/JLYUxCkc63B6jaYJAd9W3J+bUDdBkahyt4HyUlB3rU3eRYW3mJIPTNOGDlyeWkyNzSSwGx0Zd
 gC8I+n94rEtNusqb8UTLHBVeyg74ADwQdEmfXBNEOgSsPhPNPhnZOp/JQUgxKTeqWAyCSIomwto
 KBqHe7N0dpSmpf3hL67voUVkpj5BvoepWM+8bhAOo4QtZUgYu2mEWohGDHHmr9B/1TSdptmJj8c
 pJ87U9s1mjOgprV4ZL2mUq7OQFeTwf4Tqa1nbEEPjhNb0aMeHr2T9K8w8Ifk0co+HCTJDnLma/H
 o/OD7YkVi0H2HjcLLBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250138
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

On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Instead of relying on the link_ready flag to specify if DP is connected,
> read the DPCD bits and get the sink count to accurately detect if DP is
> connected.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 63 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 20 ------------
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
>  3 files changed, 65 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1dd168acbbc3..97c4752005c0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1152,6 +1152,69 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
>  	return 0;
>  }
>  
> +/**
> + * msm_dp_bridge_detect - callback to determine if connector is connected
> + *
> + * @bridge: Pointer to drm bridge structure
> + * @connector: Pointer to drm connector structure
> + *
> + * Returns: where there is a display connected to the DPTX (returning

		whether?

Otherwise, if keeping msm_dp_aux_enable_xfers(true) is intentional
in bailout cases:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
