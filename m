Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DFACD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351B210E0BC;
	Tue,  9 Jun 2026 06:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8fvimJg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZHhQO+if";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3561B10E0BC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:27:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6593wZvk1060931
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 06:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ha0OMzIFz4oGavhsmpfWitFRwWVvRwRyXxaIfNOHbno=; b=H8fvimJgMTpQT8ea
 rbbJFLJLyFBqeUW4EEjuuZ3+6yezDPLNfeP9U+yXgsbX+PhYPG7w6Yse9FMEhnFx
 xh8wAe5aHtXCabf+s3Rckud9y8cRVn6xuhpbPq68DTegXRsp00HGN/SE3eiQUaKB
 SQk1JXDBhfJ7TwoD2ib/TS2vn3J5S5WUA+5ISJHwRmcCv7knLwxLy1pAYPXWXy7y
 bpSA0YBRKw0xFM1/47V5uEWTdv92L9hGdEGaoDgVYhf59q7vzSfi0+cDapaMwfHH
 CmxCwWHK4ygWKtVbJmB1CB/7HCWhpamGrPjPRp+jeag3Wco8NiQdbBqkIcxLqp9P
 r2M1Lg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun44s7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 06:27:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d98b74447so4033049a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780986464; x=1781591264;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ha0OMzIFz4oGavhsmpfWitFRwWVvRwRyXxaIfNOHbno=;
 b=ZHhQO+ifSuotv11q11el7rn4x/xnHv6i2/+yOrj5BkXP66SkKOWyZNYpFxkvDhaaef
 UH3ArT3Mz8n0GW3tJHjsNQHtd3m65IPsndBzl/EhhRVGysyqNeftENRrj00w8bUVoG6q
 fA4R9EUt139DtbYJc+xxfuzP5mD8FjIA+1tJshiHl4/NhlipsCNEDellpkzyNkhdK3Td
 QXDfDe4+DG9hk9tlM2+vq+v3sSg/yuYvNWiVM13LBGZ4FKB7v1mW+FfARJCc5vNGnEYB
 sMWG41K1GvvWuCajP86BNWroZZzD7wc6X9m4sA13bmSbKL1K6SfB9DrS1V5xqu3GEI03
 DJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780986464; x=1781591264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ha0OMzIFz4oGavhsmpfWitFRwWVvRwRyXxaIfNOHbno=;
 b=Ym/7q2HEl/HZxuVnPYt1ekE190tL8/M1p1LmB3T4CH2TfdU6rGqgglqe0u0BBp/F0W
 zxFBm4mN2gTfJMwkm2/0G2nSQlq9rAUuDY/9Bqya2fY3PzEZ+HpHTAl8+136rLqcq9O/
 C/W5DzT7GZyKb0lvOiOThVWWMaE3Nd1zflf8US+nuILDBD52osCx7exVXj3U0ImMaOz2
 wsm1vWu55YElqa/4L5yn1liXL0XJVBCuCJY/Rw14wJ1aUSWA4mhUzNJmjrjXN7fnp5H/
 d9PtGmXyxGLApqidlW/2UgV95ewNOo9CnepU2qyxSJ1eaqCe1FiG46Znh5+TCEfN9ped
 TgUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y0IVpIWD/UBis+GaF9jkfBakSD2Vk3Yx3JthlAthEbv8pcViaOn4C+33gInen7pKzB6Rvw7piXlU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsH9KnyUGD1nqXU03lev0B+/g5/b21Q0yPg2sl3xUBoj24CPAt
 GDHcTJ4N7Nn9F5Dmzjf3cdGmqRaNPIWsTHiu6JEL9LSXDj2C+zHPrJQOQaehJRqO/9/oJjQSCzK
 yxdQWkQSjCrVrvKBFxF21D4tjVJKCV9scYYIJ6O6IKAeWQTJ5rOCFcLmqkCM6RSxwP1V+D3Q=
X-Gm-Gg: Acq92OEFwsdHw8CqoKjuCEb5mT08XmuD+qqnrlb83u9DA4gTbigpcSI7HcC3gZBlX8k
 GcS01EF2M+4TmDwiw3pckQ7LNl6qrQ9gr4vgRExnCnSjbBE2sonA529qjR6Pom6sbnJPj12kech
 HhWuienOxvGjULO8aKD9kgOue37UCpOdF6N7F/0iPjeiCmJ6QaUTScCPxY6REfjR5HYcWY37m2H
 9ie0KW/Zcsb7g7EE2MmU9eIckeux8qDSItSG05i4un5OTaPQIJAdQ26nk+LSIAyYBKTjbF3W0Ml
 A7ABxngKVj+H5MoL7PW0vRnqaCW34leMtCtLPItoiofoTNeL/bVRpx4+bbYBibykKqqbH/vy3JP
 4rrOBDybdgweaFEIAwhKpEOzVNmwdoF0IiSvvJoamBufs+SZYFV39OF0EAp51ngpDnLOP11sgjj
 v/VKV++TVswdUhxfe7b/1u+Nwsrnby
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id
 d9443c01a7336-2c1e79e29ebmr223714415ad.3.1780986463951; 
 Mon, 08 Jun 2026 23:27:43 -0700 (PDT)
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id
 d9443c01a7336-2c1e79e29ebmr223714065ad.3.1780986463390; 
 Mon, 08 Jun 2026 23:27:43 -0700 (PDT)
Received: from [10.133.33.232] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609e627sm205631375ad.52.2026.06.08.23.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 23:27:42 -0700 (PDT)
Message-ID: <21e5e1ee-c083-43a2-9f66-cdd07b529111@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] drm/msm/dp: move the pixel clock control to its
 own API
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
 <20260602-dp_mstclean-v6-7-2c17ff40a9b2@oss.qualcomm.com>
 <d494a62a-2d4b-4406-99f8-cf8775ea4706@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <d494a62a-2d4b-4406-99f8-cf8775ea4706@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA1OCBTYWx0ZWRfX2Z8NprbWqt8q
 y6pN0q5M7KcRePJMlsJ2bj6fZr92d/rRKbSGpdqxS0HXd9+C/mXeW+gXdxodusNMcZe3DlHg7IJ
 Bzsj1y5VqMtC0B1RC9hTddS1/5WSuJfZ12vp8As/yYaDqnnWIJSQV0q9Yaj3JQ6soW/A2XOpSjB
 3aTblF4wDIMdLqGxrFsp1CUeEVNxGXTsG2SnZbpmVAIx8naUFfr4hLXsQ/OgPVDOmYg1X+CkVEK
 ErH0G+tNpSYXqgK+FDPad7ul7KDUbhG/Ipi5JH/Dc3Il0eCTdnV83xgqidbsrhxq3nqsZTco8y3
 1fQ7EfFgX32bXUNdtvfv8QtwPEpJncccbKW1lUnMufYG6HrFF9pmoSlbZMTN6iAQ3PEApryfLwD
 NeaVLy43ThEHPmYdvP1lpKFJGEClG5jYfEwxXYkho1YPC42klNCyRuASzEySnRA8JmOzZpkLYiT
 THSU2tSsSkXIzvZuzRQ==
X-Proofpoint-ORIG-GUID: NxEORNw-nQQzqkcLvgvTLWXjEqdEstCB
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a27b260 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iRcVBvsBG4cgb8Ug3_IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NxEORNw-nQQzqkcLvgvTLWXjEqdEstCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090058
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



On 6/8/2026 3:43 PM, Konrad Dybcio wrote:
> On 6/2/26 11:11 AM, Yongxing Mou wrote:
>> Enable/Disable of DP pixel clock happens in multiple code paths
>> leading to code duplication. Move it into individual helpers so that
>> the helpers can be called wherever necessary.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 81 +++++++++++++++++++++-------------------
>>   1 file changed, 42 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 1c2eccec6ec6..ac0a2c387f03 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -2171,6 +2171,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>>   	return success;
>>   }
>>   
>> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
>> +{
>> +	int ret;
>> +
>> +	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
>> +	if (ret) {
>> +		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (ctrl->stream_clks_on) {
>> +		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> 
> if (WARN_ON_ONCE(ctrl->stream_clks_on))
> 	return 0;
> 
> ?
> 
> Konrad
Got it. Will update it next patch.
