Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD60CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CC210EF9D;
	Wed, 20 May 2026 08:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNeZXWX7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLmUazW6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9046010EF9F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6ebfS2143802
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tj56qRj45Q6wqrEcPX6AbsU+eMkJuuBDYfmrRyMaOao=; b=DNeZXWX7x0Rk52O2
 pRXcDPKBfRoUfRpF/VzEBbXLT1cf24oA6sGBtXUlZLnH7N6zgHUCiJ8lk7/xkdLt
 QMQrL3Vm635K+p0XCgxHOB1wBoRDnbxoq4Nl113tpi286CS49+FLKuEqljH3aPXH
 mlxrk+YrUOElqnrxj/44tIimmitx7p0gZ9fQrJXvjOH9trd4fpsBp+sqcQVEIabj
 xR2LIWIzlyu7QK62ennytxiDElUMmhAsrwUru3Sbgoc8w7IKq7AvT+nAQmKWTKV+
 JSl+c4ZyHCSE5imoe3pYI55HeH+2cGm0ou+oHl5dyrg3RmSiYs2NLjQ5J0RKrC1U
 viqFLQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3tkws2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c82c935e048so3438188a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779267260; x=1779872060;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tj56qRj45Q6wqrEcPX6AbsU+eMkJuuBDYfmrRyMaOao=;
 b=VLmUazW6N9rTqCrQidZ/QZjRb3+7CGDNkmMCdmcuHgfCxauioD5rclZ0DMvlfycih2
 t2W09lPOKtc0ZT4l9M/pSBdxlywmHeImUigX/4ioxMqgdv31w1HP/bqnO88QK3+Dzdvv
 +rByUpymhdm7CczWsclwvrHGjcPYaTFRHsw2CK0hRRAsu8GP9ucWMuaqWbOE/ZHBxSgT
 ZjBfqRp1MfmF6DN/RT8hwdHePqeEflJcvslOI2ajYuCertAPAl28/6GsRMvvX8/6sZaK
 KMiUwOUFg+kWFHa7BitzDN+4ypPyWsreubk16pzhKNCS8ASdmltBpNwnNOSPL20fu5mu
 3ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267260; x=1779872060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tj56qRj45Q6wqrEcPX6AbsU+eMkJuuBDYfmrRyMaOao=;
 b=YLQAb+sL6wIIF+aZpYDsKlCV6hpYTZGNb+5yT/9+1vfIea4fZo0xHfBE2cYxeeRzDV
 weoAQCskioyeH2+6nDf3DvbUjF2vL0U1i5kOp/m708Z/DSv0QiLXDO2Vu8c2J0u/6vCP
 Gb6M+kifmjkA3zOvDFPEB/6jrQHcHF3Wa4CkJ0hcl3qDU0Nt5WmFUkSgYlsLzQTkplK7
 3j+AcA8UHSJxT7vROd3arRjwkKrdmsdPPaADzi+RUJTrAYG1IX+nq4BlVWBqxkDvn9dv
 CLQ7PaSXaIsYgHwn2gk1XtP1AVR7YaqZ006vdyOqyKaYzPo1LHQzHSD5aF6bomalJjdq
 6lQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/4V55JDx7ZQ61hBDbCt2rocdNT4ngtsjY9blP8Cs6vJqFTQcZSg29PIfZEm2a/D+YYoCToft+O+E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkWdi7zjavs0zXzROb0CgUxanYlirETvSSXU53NuIgMoMTWZI2
 69mGy3g2PKLXCRvuPlo0XfcAUJTPIh1WX+OK0hVy6thqw+aeMfyPH0zQCu1mwhFpabNHOlHHKWd
 ss3CoZgEbiaQ6EA4uPC1r3etc3LqKp/ZViZln/5VIjMdNqcsAPoFzD11GQyKCZuIvYGcdwdA=
X-Gm-Gg: Acq92OHJZgcICL9HaSCU0F7cRPDWjmBcnnBkY/KwrIvZ4ncg7A5XjS4kyzY1p/hjXzk
 q2nFNAFXO6zWgXCAkdOqph5/B+2b2RICqQEG6qmC7mHRc0HvwIPy/gn6WuSeiAVzPhQbSnf+Ux7
 HuKWrLdB3c2Rgi3RcgedghDy2O8cPcvEp/QlQ43r7Y1vdf6UlGVGQd73gDeAGWUU6gi9BPiimH5
 g9yTEcxn+gUikF6I0NHIj28tYGSNoBMqSZdh05VB6lBvui6mteSXNY5/PyO+ZKlbMOggWo+LA+c
 4Vkefg2cmjpIWS2Jpjh6u/dG38+Zf46Ep/jeQG0buE7q6mrY28frxIp+fXvvh1Udrq9cPd1DwPk
 p0bs8Obqc4R/XVyOl+/VG1G5rPPIBnw0egHbf5BH1c1Tu2kBqqpTWtZf5SilcU46cklZ0vFBLei
 mm3372AWpLtnMn/0DDMw==
X-Received: by 2002:a17:90b:4f81:b0:368:65d1:893 with SMTP id
 98e67ed59e1d1-3692344690amr23209195a91.5.1779267259573; 
 Wed, 20 May 2026 01:54:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:368:65d1:893 with SMTP id
 98e67ed59e1d1-3692344690amr23209169a91.5.1779267259085; 
 Wed, 20 May 2026 01:54:19 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369514aecaesm17276282a91.17.2026.05.20.01.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 01:54:18 -0700 (PDT)
Message-ID: <aae363fc-c3d4-4c00-9ede-1508bea6ebc6@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:54:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
 <4z23aj2mzpgvaoqodncmi47uhydgtrzagh4j7uog565qm2t4in@mrkummd4vp6q>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4z23aj2mzpgvaoqodncmi47uhydgtrzagh4j7uog565qm2t4in@mrkummd4vp6q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=feCdDUQF c=1 sm=1 tr=0 ts=6a0d76bc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8Wk7F6lNGgSB0avDr_YA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RAlQykbquEYZ2wEEKLY2UeixnPTXLkIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NCBTYWx0ZWRfXzjgMFgtJ/Kqv
 z4bb/QFl4yY+aUlxwxeLcl8dwqNJwg9lyQ0rkybe5bUHwq3IG/DWelBZp/+mIeDxod9mHpA8rig
 7LXl2HTgftnsme1zloo7U5yeQ75RR1MgCPaPiwd6bdSUoTLIaMKXDnMd5+ZsPmWfNuMuWsKBxBU
 YSmCGq/6CxfEc2BTSrJv28u8+9oNWp1dCoG2CImcSBAH6OwkUaFD6wWMQemUif+LP0nMA3vwYGB
 73KshqNp2y8mzsbWNmI/X9shmfLZsfnZctH+UxhAA5xZWex/tJa55bxeeMHHM5fKboXIAKXxM7b
 O/njOAoTrSRGx/SG9buQHQ7j3Ln3GZW1TZiQgugMZrBtf9OMBYIB1XzEdp+PCsDYd3M4vqRITPD
 BzhT4Gop1WlHsOsmE5Ard90yMXYllXwGv5qQZab5Ia5uSSa/rlrSbbwm/Z2R1HOrjSOqy2wuTg2
 +oEWsNaDZ7d8ckTfGsg==
X-Proofpoint-GUID: RAlQykbquEYZ2wEEKLY2UeixnPTXLkIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200084
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



On 4/12/2026 2:04 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> With MST, each DP controller can handle multiple streams.
>> There shall be one dp_panel for each stream but the dp_display
>> object shall be shared among them. To represent this abstraction,
>> create a stream_id for each DP panel which shall be set by the
>> MST stream. For SST, default this to stream 0.
>>
>> Use the stream ID to control the pixel clock of that respective
>> stream by extending the clock handles and state tracking of the
>> DP pixel clock to an array of max supported streams. The maximum
>> streams currently is 4.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>>   drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>>   5 files changed, 71 insertions(+), 25 deletions(-)
>> @@ -2735,9 +2740,17 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	if (rc)
>>   		return rc;
>>   
>> -	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
>> -	if (IS_ERR(ctrl->pixel_clk))
>> -		return PTR_ERR(ctrl->pixel_clk);
>> +	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
>> +		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>> +
>> +		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
>> +			return PTR_ERR(ctrl->pixel_clk[i]);
>> +
>> +		if (IS_ERR(ctrl->pixel_clk[i])) {
>> +			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
>> +			break;
>> +		}
> 
> Almost missed it. If it is -EPROBE_DEFER, we must return an error. In
> fact, I'd rather check for -ENOENT (or is it -ENODEV?) and pass all
> other errors to the caller.
> 
Thanks, will fix next version. i add logs change check this, if no this 
stream clk in dts, will return  -ENOENT..
>> +	}
>>   
>>   	return 0;
>>   }
> 

