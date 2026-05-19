Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12151CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9E210EAC8;
	Tue, 19 May 2026 07:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RERe0nhL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2+zKcns";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9345810E36F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:27:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J4etsb1251904
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 utMyKzcFS3nlxzF6C6V7bnijzPGvaVgfCyXA1B5b1iU=; b=RERe0nhLWi4CRDxh
 g2MAN7OG8I3bFpm7BKfHKN1bSo6r4WioWuKjw0hYomEzET0+WMKnkwd31Bz9YjtF
 nG5y2E43D2CHO9V6tmMnsqd2ktDcKFxSMqU62jtP0AlY75pHAWmYpe+679LMWxnh
 CzWvJALzJTnNclcaQtQNXbXz8sQkvTE745L3WuCTNxEijECJAdD9OsRIQpNvAiLK
 wmQNqAov4VBQwMQoD2+JCwpOyryLYTo+H6NrVIgC0uyQfQLUv4eafXaQnTH1j+/y
 KMm6ic4P32jVbW2HNJWpDpGlvQzj0WrI+fMWsDVQfSZhOWmP6bTuQzhXYxFOzHDh
 RcRHlQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82c0kypj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:27:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4678c6171so34685265ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779175626; x=1779780426;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utMyKzcFS3nlxzF6C6V7bnijzPGvaVgfCyXA1B5b1iU=;
 b=Y2+zKcnsn4/GeDYmuQpnLdprSTZOK/XKey381vO9+hDFhVDD/cvsTNYbbkij2pnboA
 ZlC+9jDBA3NqvmyhvMkb33K0aOCAMS6tp4YmOIXEku9pdLn/HIDlZ/A4w5WvLaOE9NsT
 Ha3YTlKtonyGDxBMO50MyAkCYX13UueQkvPzJtyImNjREgex3BhvpPqN+PuSz6Fl1xJQ
 MwUsHNKKFLDMUR+L1/Gu1Vt5/Ef6MUj23AHrvRNhFbJ3Ph/wIUkHb8Yw89/dkJpI7ZVU
 hZVj5+t2MidYDIyoTuH2Mz06EurOwCwu55tZILh6uPRF2tlfy2f4BOBCqI8esMYCrrnS
 FIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175626; x=1779780426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utMyKzcFS3nlxzF6C6V7bnijzPGvaVgfCyXA1B5b1iU=;
 b=fQRbB21iHbVZnp5TG6PW6F8lSoOjysk/NbMfmjV2TwX71WepU2G4zKf7YY+bc9LNIY
 nOkQYwx0DVoM9Kr7mwUXCrWbvJmnhMtvjLeWOAQ1YWGG0wElGYzQTZjf2kSBGYAOuAek
 LEFZGLEmJPbJfett0Mi79c/4BbXAdfmJaS8pwCsPu5iEHFC/bg9rHZ5fAg5zI5LpwIwP
 C82p9InhP5/CtoKG1Xj+nLaWN7Iat+1vtRHwMv1/FzORd3oTh0pDNE1w35aBj0QVSTcs
 frISdrD/QSk+MHroGg9y9lM2dC+1SYDMz3Wk8FgUOTMe1rLpyiGVOaG91xetwiUkB5PK
 BOFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yJdnLq1sG3COHzE99kfJytMtAKC1ATmGMJK5XjL4apGvU0EE+TjS+RUIjrVZRaM83rgOpO6+0djU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeWoYVGBQESE/iT3MTReSc4p3A/Ui4Zm0ZVnb+auIcrQOzAgpg
 cTeRTjoEH9/aX0ulcuNLZExQUBSRD/EZiWdPBpFMWp48UE//8/3EB5fQOTWst7jbGm800AyLJrS
 2gXYJy4Q11QygMuGy2Sa4MuraBR81CykCMQpbIzulbHC0eC5yQZmwoPXg+6nT5ZhmdYK3VKM=
X-Gm-Gg: Acq92OGbxS05WWOUyNbNkJu7qM63lDoHJ6PtEQtpSjnGVMF1Tfede89BVrltotdIozJ
 mzqFOv1fC2xD+Hf+7336yiY5yKC+6IiWxexzYkcTjAjkPSBt6o87iAY9RSSQfdo187i2nS3m1vs
 HK00Vr4V78M0JMtchjMjEc/LMFUe0rjMj1R3jsA6lTeVwE6XQhI+dPdWV24dzVRYwE0buBL1Pxz
 5R20EtRrHHskAr80RSBUreGfaxZcTi7Y4BlyURYmfrHRSGx92+yT/MZSdCGov+C2U2AFHFiSLCe
 5j5b9IfnyMVe7T55FGWO918hSlJIMbQe62w+02ZBBejRjK8MiUyyp9CP7J7qK93HEWsP5KnQXKv
 UIOQ0zcIWaq8/7ssiuB0NDWMcKbbSKNfMfNzMjhZr0QFNK7SOpeN1Ycoda+LOjXRA1OKbsjFw7A
 S+enquQ6K0T/fASD0W2g==
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id
 d9443c01a7336-2bda3c56ef9mr137131305ad.14.1779175626143; 
 Tue, 19 May 2026 00:27:06 -0700 (PDT)
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id
 d9443c01a7336-2bda3c56ef9mr137131115ad.14.1779175625661; 
 Tue, 19 May 2026 00:27:05 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm168210415ad.32.2026.05.19.00.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:27:05 -0700 (PDT)
Message-ID: <b02965b1-3805-4ac0-8772-aa832f192756@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:27:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/39] drm/msm/dp: remove cached drm_edid from panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
 <7cnjdge435t55s5vf66fkjfmkz7jvcbbax2uuismyc74mv4eia@toe2vu2folqa>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <7cnjdge435t55s5vf66fkjfmkz7jvcbbax2uuismyc74mv4eia@toe2vu2folqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3MiBTYWx0ZWRfX1vBMAQRqxUzU
 4iFR/7LTxkQHu8l8Fz7c6ZDIdq+OLQreBg0oXP0zJbJv+njx/VIhIUeNoTO/UTs3gfrbwe0zTa7
 kbkGuVd0hH4aGGkfrAclhO9OO32Dw4ngIs+qZP4uOiMA2w/GZ95P+m5ZM+3S8oj9McIkzwESFRk
 FOloAowQibb0cks7iE+qNqR0o/8eR80aBictgomK19kZEXXGvTrR24pEIfoRgvbcXnK48POOAs9
 Z09YuD+LLdk//pP7+HWM3IR/GNnbUKNw85VZ6rM8l43FR5nTepJ1p7bvOJ+3nwLBrgFMPLwiJgX
 yzlizp4OJ6FmDPEm+e/AE84695m7fR9M5KY9Esxw46d+1JjM9eNgvPeHVTd18QKVAslTwsPUGIr
 3TIC5aPuaCVTLZ96h0+6S0JDMb6FX7nvFY6+mQ5q5R7ml61KA8kwedMwPjxF0u8mKIVWog/q0lT
 bccYdSav1SBJAhWmMFw==
X-Authority-Analysis: v=2.4 cv=A5Jc+aWG c=1 sm=1 tr=0 ts=6a0c10ca cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kvofMlIKq05Gu29qcYUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 862B62ohkI9VrnZKM60TEsG_wlliQzzn
X-Proofpoint-ORIG-GUID: 862B62ohkI9VrnZKM60TEsG_wlliQzzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190072
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



On 4/10/2026 9:52 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:36PM +0800, Yongxing Mou wrote:
>> The cached drm_edid seems unnecessary here. Use the drm_edid pointer
>> directly in the plug stage instead of caching it. Remove the cached
>> drm_edid and the corresponding oneliner to simplify the code.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++-------
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
>>   drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
>>   3 files changed, 26 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 5c6a24ec140d..e28cc1bbb5b1 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -268,6 +268,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	const struct drm_display_info *info = &connector->display_info;
>>   	int rc = 0;
>>   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>> +	const struct drm_edid *drm_edid;
>>   
>>   	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
>>   	if (rc)
>> @@ -275,10 +276,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   
>>   	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>>   
>> -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
>> +	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
>>   	if (rc)
>>   		goto end;
>>   
>> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> 
> Where is it free?
> 
Ohh, i miss it, will update next version
>> +	drm_edid_connector_update(connector, drm_edid);
>> +
>> +	if (!drm_edid) {
>> +		DRM_ERROR("panel edid read failed\n");
>> +		/* check edid read fail is due to unplug */
>> +		if (!msm_dp_aux_is_link_connected(dp->aux))
> 
> Does this work for USB-C AltMode usecase?
> 
For USB-C DP, i think it always TRUE, here should already existed before 
this patch..
>> +			return -ETIMEDOUT;
>> +	}
>> +
>>   	msm_dp_link_process_request(dp->link);
>>   
>>   	if (!dp->msm_dp_display.is_edp)
> 

