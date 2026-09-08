Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5933C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B307810E6E1;
	Tue,  8 Sep 2026 08:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mm9l/doq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrdG5MEC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F5310E52B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:40:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Lrdb2154211
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 liMTX+5W1ZhScG/VtPCEXcVGP5PSRJI5VVuw8P97m6A=; b=mm9l/doqRsf8Bc5n
 wAGT9LOAROOQh1pUSyZ1rIGXOuVoDdTqBSZuFjBsS0L1XeH+89x4BxdgpZaKrbx3
 iVR3ajG/3eXLVOoAcN+kESDPCW7w8kEdY5Hsfh3oda6OOKtjDoQQPYKxaWLb4cy+
 nL5VIcrzm6PCUdQnGi2dnfeKovg1d985Z84C3YcAqKUvcbAj4aI35y0aCWqhLC7r
 +gRBgwXk/xZMNDRGywoyR0YMA+ifM5tSprEg+fB4BpaGYzYWXSc47cSNi4F9VDDI
 N1yt4KVYT+uPRUhdNxoxhDGvNLqpIqZWKL3aVZEvgw3KYz4T/qUc4hcOidwt8Ete
 n+gapQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwjh70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:39:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so801473085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788856798; x=1789461598;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=liMTX+5W1ZhScG/VtPCEXcVGP5PSRJI5VVuw8P97m6A=;
 b=ZrdG5MEC8ueqKkgtBibVRe9ECi5l0i+0pzicKrkN7iD5Uqf0KDBS9lqRDaF/voOGnR
 9QnmletCFNT4xTspQHFEfoTUxn1X1PbMoLgacVI7M+podfdJRodYpfjsTmlBzIXdWntA
 4r7a0YUOh77TXcV2tpjMqy41LYXPmoRZwvlzRFW5BwLQodgP15GQnHzZzXsk9W6Yp81n
 tXsygWQZCmnmvP42Rhlq/3hGLlopkKtJ/8f1zhc/0oFz3JAu/Hxr1xPI7q0Zu4p7PHlq
 x3HuRxoYC55xYpFUPNYY7zpPVLwn5Rmf4PdkOz+1aaNGr1Eb0PY4sl205uuKkz1xOK+L
 CMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856798; x=1789461598;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=liMTX+5W1ZhScG/VtPCEXcVGP5PSRJI5VVuw8P97m6A=;
 b=Ec94A0u1KsSZqlOENFFuZ98uE9llpBYdaw7+YQm+LGzHaP9LMYTovOLzuHPBVeYcHj
 x5ORZIOj2UjrkyTLBtV3+nHbSBhls5rGS9R+JDsYZSfpqFcvTucejlu0wNwf6YwMK910
 T/t9+wZHH3EVARLMv9UiG2dad1VO2OmxJsMuMvSMsIiW+JeN+Mqo5ORDjANe9q7L7zCH
 CiL3On6VxUYbm7qGf1H9EkMI8te/at0+p9jg0kqSK2uPi0cywbPIyt4WWLY4h+EA3wyA
 0/8RCymOR/PLwm735OlkhqddXIsMLGNjsjr5WUFSYiFS9XWW8kZcV74HdK15Pqr7GVtf
 4woQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU/unaaPKv1alMWDDB8V9UgzhjXeKeBY2EwBUiXzvHI5gIcIrKG2JBePSxMSCgoHgZrLcHP33nglg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5fvwWTqHgXmHjNNBNj9d8uPuF24qjqyPSZLEpxWgEPH1ksV4p
 KW4mK61LJkR0k7cLsgr51d8Y2RYiNMkgG9uaT9Pga/MvVegLt7df2uz/F0Ao1g3c/jvUvee6Va8
 NDcDiqG/A+9VWw+dqYZBLwFBWafNY4uoRSg4oj4lyKt5Zu7tFphmdkpZt1aOpUsro4A0NTYc=
X-Gm-Gg: AYBFou3nETi13gav4uPlnFgvVeCMDHufh6YONJs7sQa0s6lZ+s97jmLDKTehgV/p0dT
 QqQGkN/+9A94A5LlxNJxtCAbW/YqKCwXOCMqI3eGwB/eEihkBpbR5Rc4a7mi5e5UFExrvYlbOz6
 SHUi6eJp7d2ufmprvFy6eg9W0bfWx4ktHDn0C2CN6/jn+TQTRGMM6CAq3E+MQ7P5Y8+so/0up0o
 NnMfI/LCcJh8YXP1phDYhan/btaLHbAhVBHmhcoNY2eXWeAcU24//RWpd0uvGP6V3ijnPD1ryXU
 XGXWg3cBHaIgb8p8fsZfPHZDLO73NWWwMUmGQYzjntgcwqRL7Me4Pm3bfVbDfuchglcIO9lJQOG
 axNglGnepxBy+3LHE2GWQYPBRFPxr
X-Received: by 2002:a05:620a:2617:b0:939:7683:33d5 with SMTP id
 af79cd13be357-9398037b951mr3141905885a.19.1788856798434; 
 Tue, 08 Sep 2026 01:39:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2617:b0:939:7683:33d5 with SMTP id
 af79cd13be357-9398037b951mr3141903985a.19.1788856797991; 
 Tue, 08 Sep 2026 01:39:57 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm377307385e9.0.2026.09.08.01.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:39:57 -0700 (PDT)
Message-ID: <6380c418-afb1-46a3-837c-582175d51cf5@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/msm: Properly handle msm_ioremap() without name
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-5-dcf8956878ca@oss.qualcomm.com>
 <51fceedb-2dbb-483c-8eee-9409ca61b1cc@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <51fceedb-2dbb-483c-8eee-9409ca61b1cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fc9df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JWgyNuB4YE4UXSG_TMQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX84DrOzlaCYeA
 hAlk/8EAFdcQF+rRR3L9Wycyv7TTpiwoi0AlhXgsOxcU3kWO5Y5FWIwFAjnImZNjlIJveNHXxwD
 yVZJUtzj8lLQUPEoWmv+oQkHCQf8sPvHfH/i8hD8lzMrX4rIF0Mp7CcVRgtHXndq/zHkPuB5sfL
 PA96gqw+f/6DqY9xi2C9DlVQJuW/W9Rutl2m/8C8LbXXrx7V0wXb+32a25u0MguF2vPh6mhSOM5
 HgbDWXhFSDEdZGrakwPlzHwxX3LhPrGSv8BsuaHZ9hBTkBhK8q4RWngoY/HuooGc96Z9iyOCXT4
 vRUvI3RqMaPx9JGTbtTYpclLnf47gk8wWivpmyAIGDwEh8OIX/XlmHsvnBqRDt5XWTZYj3GDRXW
 ZanNq4UuVU/T39AwBijrmx2iNV2xm/GrnIaMwoma9cHSaHCpWn0izwHiLW4Pl5+lGikKyRz7wVV
 0kjrikyBmmIRXT6onMQ==
X-Proofpoint-ORIG-GUID: -R8kxHVaGiRd9DbSlhlxMOOJCE1_e8BS
X-Proofpoint-GUID: -R8kxHVaGiRd9DbSlhlxMOOJCE1_e8BS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX5bZb2JvFdmh3
 Eo08TWPRj7+9JokcOIhlqjMtZWlCp4+9MEXBblQ8bhUFlVqC3Bn1KYT/p/9AF0018GyBVhnF+cj
 xAXCQuKT/oM+OuYZXJVPFqbgcSG4fgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080090
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

On 08/09/2026 09:59, Konrad Dybcio wrote:
> On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
>> msm_ioremap() accepts being called without name of the region to map and
>> in such case maps by index 0.  However error paths still use the name in
>> error message.
>>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
>> index a6efe1eac271..0a4ac0fc5fb5 100644
>> --- a/drivers/gpu/drm/msm/msm_io_utils.c
>> +++ b/drivers/gpu/drm/msm/msm_io_utils.c
>> @@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
>>  
>>  	if (!res) {
>>  		if (!quiet)
>> -			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
>> +			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
>> +				      (name ? name : "#0"));
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> @@ -86,7 +87,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
>>  	ptr = devm_ioremap(&pdev->dev, res->start, size);
>>  	if (!ptr) {
>>  		if (!quiet)
>> -			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
>> +			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n",
>> +				      (name ?: "#0"));
>>  		return ERR_PTR(-ENOMEM);
> 
> It's odd to see one being ?: and one being open-coded..

Oh crap :/

Best regards,
Krzysztof
