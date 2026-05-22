Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB78CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942C010F56B;
	Fri, 22 May 2026 11:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTOwpQUF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/JsGxVy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C0210F56B
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:40:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8WwqY3532229
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PJrMUhAsFW3Hba+YJzivVZsaFeu6ubFMMTZwlHTTbPI=; b=RTOwpQUFvLJtWgln
 wYnrgQrGbrCE9RWF88iqdN1OHIKdP8KZIZN7zyTIgTPDOIygBdReHSPpUX+CV0zs
 Tel7Z9VEGAlAxx0Ay/eRwmkFd6VAppMHPJNBb2GAdgjNn/fQYjUXd6QoQdE89KgF
 MY60xrXoC7Q8mDG4w7Po2w2WpXPrVeSaOsDYIQHKlpC44FnGBZ4AfALNNlT0rP9f
 OEsrE1ncQ87aG/UO+aD0AXRP5/6/mtuYHPwB57eQYpgl77bJDvoN+9j2KaDGsI2F
 5wlOkH24BnuFCv8DxJiTcnl0Zn0rAixxusv7MzIihYA5l7goriAP6eDltHICF+6H
 p61s7g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gvud4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:40:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516cee1f042so3385651cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779450044; x=1780054844;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PJrMUhAsFW3Hba+YJzivVZsaFeu6ubFMMTZwlHTTbPI=;
 b=X/JsGxVyu4TjDVGAZftnchiFT/JPxazGftVDb6EAGx6iR3nDrf3xFaHTqPBXhTusqr
 XxZRo07PavWmIE07X8uWjTwvIMxiHoDvjcC4vfe9QYyRYLF/xXmcxecQDh7lyWBHPAmS
 UBXl/3SJ8twwsAjvbwUTIB6m1nTv3xo+2TEv8w7qNCCoTp1ZgAwZlNgiaIlyuQQpKfrT
 OzOadqf5cXZQx0re/LtR8XFhJEDv2T3lJu6AX1ph9nuJ2Qd4gPUXwe4eYaH/KCdIjeky
 2yq4rngnxT5DDyR/kfAvJLF5ix+yWPI+K36v+BgO+z8DcvvggCPrezyqP/6KZY58Epxt
 9ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779450044; x=1780054844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJrMUhAsFW3Hba+YJzivVZsaFeu6ubFMMTZwlHTTbPI=;
 b=ERSIEY5WpHiNMaTmWTsuuX+C5dU6+GY3+e68F7ogt4rrd69X/IwJ7iX1AkzY4Dxq3f
 8QUxY35Y4+kq1ci0gzOjLyCJwBHGTLE7pGdRt80bU1tOsLJxhkTSwjKc/bi/JiQOk2pg
 hzoPoicQP8TZDNK2xiI5mnLfY2ppA7MLy7zSm5sR/ZkMz1iufvT3w6T4OB/SKVipBsg8
 UGPiX4iZTgxIvaGi1JZZoBc2cMKD/AoAlRlw53/aU12RnVUgROl6BYy4AQKhfZlOV8sh
 US+HsL94by6e00DxcIfnXpcZsj9Y/AvvUBmlrDmL8lUhDlkiWt7KBhaSYL5isj+9Zr8h
 63vQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YjsebSkANwFD9uzhJceJ53isCjUaEkiww17yFmVp1ajci/y4vaRAd77bSWkiyz4rh4nOwCc3E1xk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4ZyhMm20RCOCGxOLPLY2Y9wyr9aAGo7mqAERogODRAdH+jzTw
 DvjavJjfP2KUoL9w8+QfI/aKIDECbirWPRAJ91g4W4Mug14fiK/WrBDE9wsgrm47UYngqElQ7Fz
 PZtTDtyEhOnGI29XpJ7rPrHvvihXnK/6nVYp0x5lRWf38pB9+SXabIsBX7Q6/v2OvSHP1z5I5ZQ
 ragbg=
X-Gm-Gg: Acq92OHCFEJbcuZpfiWpsKgi9RXQUQzk1YMfcu9xJNSzKvJfssIAkftshvCSJASOnCG
 3dRqEwNWohAn92j8mlVU5Ux8xFYYVUUCvU3xotbuVt2UaP2UhJdxG1H4k3pqaMceKYDHi71DsqD
 zdnHuCd9o0HQg2Z1InS9noJay2bj3wkS2vvAkWIdcglEDOtw2TbVRHn9qKMrdLBuD2ag7VdTUz7
 Rf1juKo9r4qgofwviIBVowEiV/JhvzzwijHP41lhC4++Io/5hXI0YzXXKeKsE8ByrNFIfZjUbtq
 lf1nunBu7xJWv/sG+pdi5NXu+T1DtWgBLQRXdCY7EUbhT9PWdU2xwk/D52u/kQQs3WH7ywUhAC/
 XXzn82AfOK6T7kfHeR16ZJP/2sNkuUCZpvIa30+QMlSgNuQ==
X-Received: by 2002:ac8:5acf:0:b0:509:2b5a:808 with SMTP id
 d75a77b69052e-516d4433f1emr30597251cf.2.1779450040129; 
 Fri, 22 May 2026 04:40:40 -0700 (PDT)
X-Received: by 2002:ac8:5acf:0:b0:509:2b5a:808 with SMTP id
 d75a77b69052e-516d4433f1emr30596801cf.2.1779450039590; 
 Fri, 22 May 2026 04:40:39 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc5ece294sm44994866b.35.2026.05.22.04.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:40:38 -0700 (PDT)
Message-ID: <e8b8834c-3bb2-40fa-9508-53381839d417@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] drm/msm/dp: Add sink_count to debug logs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-8-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-8-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a1040bd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Vx9tJy4mw0iOory6Zd8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: TdPdPyRfnSYjZZrxeYIG0Qs82Ux86PNw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNiBTYWx0ZWRfX7GR7q6GDbOdI
 4PUwZdLsT+y1vH0QQLGUjeOq1BkKcY7MsJsAa5Ru2ejADfHVHbCOGEO2vJ2/E++qpH+DdxQiOe+
 G++cYApklhnTPCJh2NNGZdy+oyozvKYynrEkG22ohS1ZcPRPTEXETeNirpkLFw+DO6RBjLfzYwS
 x46/zrWvaYm0GmNcJlR2H+l8B5cAFNBGqMDFjmLD6RxlEuibG4XHhP5AzGoC/hRgUkYTixxuPOS
 zDtdQ2+DJbgn+VaYZGnceQmdUpah2jV2m5X8PGpWH+SpVsUswMklhq9pLJ8NpGImRLCOokqNCss
 hKEY2QRI5Gqbzo23+sUCTco8I2qm05eLCTD5hG0vm326QGIqX9u78lEBurhgBp6Feq42v9zU1ZQ
 rR77YSue/ktjyzTBYnrt25jOJ6rxd6B5+AGavyG3lyACArKpHsEYtXAdgN6icwNMvZQEMG8TbAY
 32AOUiHsxr4r15GYSHQ==
X-Proofpoint-GUID: TdPdPyRfnSYjZZrxeYIG0Qs82Ux86PNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220116
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Add sink count to the debug logs for [un]plug and HPD IRQ handling.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> [DB: dropped link_ready handling]
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d61a8ddd30a8..b4deeea0ec59 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -388,8 +388,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>  	int ret;
>  	struct platform_device *pdev = dp->msm_dp_display.pdev;
>  
> -	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
> -			dp->msm_dp_display.connector_type);
> +	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",

dp->link->sink_count is an u8 (perhaps over-eagerly? 'int' seems to
be fine for "amount of things") and the struct gets padded anyway as
of right now

Konrad
