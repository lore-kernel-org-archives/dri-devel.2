Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6760AFB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1C210E30E;
	Tue,  7 Apr 2026 02:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPVFLrL2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2q/uHZT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8D110E1E6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:32:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LRaEl2009139
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZDIJ06XkWqipUKqinNpKfVikyAkuaR1akNIDkorxtNI=; b=FPVFLrL2YSRQga4u
 ItYbNup8NUnlLLEwxwYR06GC58vTp3fKFj7siOeeyns80euFnFYUvLJHYexv69Ol
 Aj3g5c4uh6i2ugOQjtFWIe7ZA9t/v+s4i1CEOfMhBI3CwgFjA5z/qBQ1R/XCDam1
 s4AGCotnnX64q9NmNj8wfzc4vqEQBBImZGdpK8kUC0K9Eqx7Uk/7xPeovkaUuaKG
 /LwfyQtEzYen1LV3IsCoFnrl2PJyTalDNhgrkocj7y0qBhZbMbq5OwSu5bvusRuV
 LIWNavMFMfVfyppMvfsWuND9K9EkLZLGEOCw2ENkDXse+s2MIkDaExdfvjm22Cgk
 PQt9cQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrrndc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:32:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24308165dso118214265ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775529150; x=1776133950;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDIJ06XkWqipUKqinNpKfVikyAkuaR1akNIDkorxtNI=;
 b=J2q/uHZTwldFzSn17ZlauUyYAcKX6mRI5hXFCCYNPKlY8IKcWS0xXuVcVETkJwltAm
 zAD5ngMmFUH02AIv3TWK0eeyZJjxDyG2GwPFvlKkRW1l9S7ZK0uWd4tE7QVj7xPaadlS
 wuyqai52PraPQ7UlSLS3MkDHo7NnHxZmW58+C569JzUGxamhJtUq2C8VBVqCJFTnbeHE
 RRGMawVmS08SEnEcpKSCDTQ8EeJNUloA9De2qthGmqwH1l5gKz+q1ftUNaMcd4KrfzOM
 9+1XdQHHcnLPAR39qeX1U0NxgMLujNIxiDFdOIjsQGqbXFcUyfU6Ld7vF2fdmGFk9MQ+
 CbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775529150; x=1776133950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDIJ06XkWqipUKqinNpKfVikyAkuaR1akNIDkorxtNI=;
 b=oXs0SjZ/U73HTWCfDKrMI/e/hqmXHISqMYhU50/x6Zf5bYVw5EHlYz2+0v0iQAFZhz
 aA9GvzQ+BXVcU50/F+gFpdypMPQujB4W8zxPMSMOG6xdC34IhvoJWd64rQrpKl8X5PLf
 wqdlfhHN7+q8xuVYKvllgSQzajdVoci3RYXM8en4PiJq7eVg7M4ck+pHdcfqask8+7z9
 cYwAq/hCpTRjS/mvwroX0nRdkrYqkZaljX0FALTMylIVGwEUk04ggJNqN/SYCWxqW7Ia
 D27hFL5sc8yv92KIcsKA+0cfFztBSVnSnLmCidwK9CMuBiOuEpIrLiqSALDzDwlVDqu4
 lgpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuTvCaMLhFOjgq3HgijlKBhF0eNuyl6tY65ozFbQsAIVGAurGUDhfADDjCr7+o+bfdbJROeEqRjHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa8euVMmUEu2YhyqSpBIiKIy/mLyDG1SKT6XIH6tsd8uBpUx8J
 JhVP7V8GwE+JFYoVWQBBh4P3kSuaIqPwLs6zNj69fDNYDI3SIH4z6VmpTxFpRsUMjAYw0ANrk7g
 IF0ffiNk2AcnMLmfgS0hiXTo9MBfn+g+d7wzQYZsnrYnu2XSW75ZOhB1eb//TY3f72aJWGnc=
X-Gm-Gg: AeBDieviSQ7wUnbZbS/ko9Zs1FFufUzAwN54SDVWpw8yOf6HIyuYodO7Rr/7leVpLd6
 fUAKBBlQRXK4NpmggY7ckcMez6OlPU45r7KwKoNXy0GRwlTDDWBKKUzAJ80DsGhA+SEpAg6oANg
 3r35gBpaMq4C5qNVy0trBt9IjoEAqLMWgiBtu+2b0u9a+GX5O4rf2DByQaXkvKhEcHLPt83IPjU
 f1xmsyb1oFDRJvn/Z48OXkmK9h4dnzDZ9kk3nw91U3eTwZKErALl2Dux0TmxyaNn3+3dLK/R0cL
 hd1JKK95eKsyg/MXPMrEmEcqrFrw/XACHD+z1trIviwT97k5e3r59mxAo1+k37vGDK+0JHn7cvi
 WhZukoNEylC7Rr0lY0MmR6SNM55i2TvkSeZ78yE5lanLAk6G9TQL+CKC53i/bqDFPj+gP4zANdS
 Bzq+MqbuB8ZZ16Jlr4Pg==
X-Received: by 2002:a17:902:ebc4:b0:2b2:4697:78fa with SMTP id
 d9443c01a7336-2b28188a80cmr152058735ad.44.1775529149566; 
 Mon, 06 Apr 2026 19:32:29 -0700 (PDT)
X-Received: by 2002:a17:902:ebc4:b0:2b2:4697:78fa with SMTP id
 d9443c01a7336-2b28188a80cmr152058465ad.44.1775529149029; 
 Mon, 06 Apr 2026 19:32:29 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a3a1asm152554985ad.62.2026.04.06.19.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 19:32:28 -0700 (PDT)
Message-ID: <10464c59-31cf-44e5-9d7d-68b04ec2529c@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/38] drm/msm/dpu: use msm_dp_get_mst_intf_id() to get
 the intf id
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-36-01faacfcdedd@oss.qualcomm.com>
 <exfflgjky4zgqa7tnudfteeosncr6nsuwqadxnfftxtjay6hke@fxru2weupuwt>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <exfflgjky4zgqa7tnudfteeosncr6nsuwqadxnfftxtjay6hke@fxru2weupuwt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMiBTYWx0ZWRfX4bqeU/xEZ150
 JL8MQ+uXjwVlztg32ezlA+003vVbuDPJ0vSFjyy2rNXJjDRbcuwoLScABR4kFPd/9c+227HZUyt
 NPSg0yk+I4iBBlfAAsQ8b4bOU79jotFynqaIkRnDusvuL8fr3okyThEpKslIuVWh/EDYo4t6Sqj
 fVKKu6bEHKtPqBj/s2FVbePgVJBQmgQNPGKa82Tvk2MAg7ZM+dT9MhJ8HnKRn0BNssVT5hxN57/
 qSIN2Jsgt3cIdbwi81qpqR7AJttFGPs6auL0zqnRgnoLV99tEtSpt6dTSeMentHNiN6u81ihC02
 pwX37+c4MBcuK8viVOcrw/iFl+nNDPe5DbDas1lyE3KREDLnTYSz81FIj0GbMPBT4Wtp0tl2FBV
 ikDwn5xmNoQ39AYRwXwDQatxxPR4odmdg4l75STedAsR+inaDMy5fR0o3mKSxycNyf0/P+wDAJR
 dyvGw/rIctjIzd9ll/A==
X-Proofpoint-GUID: 8gYEHoIRJNA5NRW7nVkLM5OyObTBDkqf
X-Proofpoint-ORIG-GUID: 8gYEHoIRJNA5NRW7nVkLM5OyObTBDkqf
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d46cbf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vb8O4NVuiNdqttNDiRcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070022
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



On 8/27/2025 7:42 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:22PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
>> controller as the intf_id is unique for each MST stream of each
>> DP controller.
> 
> I think we have one sensible exception: SC8180X, where we have several
> DP controllers and one shared DP interface, but let's forget about it
> for now...
> 
Sure.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 51 +++++++++++++++++++++++++----
>>   1 file changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 05e5f3463e30c9a6bd5b740580720ae2bf6b3246..2eb5397d15732b224372c68d0b2b7167da9f2896 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -1429,17 +1429,52 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>>   
>>   static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
>>   		struct dpu_rm *dpu_rm,
>> -		enum dpu_intf_type type, u32 controller_id)
>> +		enum dpu_intf_type type, int enc_type, u32 id)
>>   {
>> -	int i = 0;
>> +	int i = 0, cnt = 0;
>> +	int controller_id = id >> 16;
>> +	int stream_id = id & 0x0F;
>>   
>>   	if (type == INTF_WB)
>>   		return NULL;
>>   
>> -	for (i = 0; i < catalog->intf_count; i++) {
>> -		if (catalog->intf[i].type == type
>> -		    && catalog->intf[i].controller_id == controller_id) {
>> -			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>> +	if (enc_type == DRM_MODE_ENCODER_DPMST) {
>> +		/* The intf order in dpu_intf_cfg matches the mapping in the DP HPG.
>> +		 * example:
>> +		 * DPU_8_4_0 - DP Controller intf to stream Mapping
>> +		 *
>> +		 * +-------------+----------+----------+----------+----------+
>> +		 * | stream_id   |    0     |    1     |    2     |    3     |
>> +		 * +-------------+----------+----------+----------+----------+
>> +		 * | DP0         | INTF_0   | INTF_3   | INTF_6   | INTF_7   |
>> +		 * | DP1         | INTF_4   | INTF_8   |          |          |
>> +		 * +-------------+----------+----------+----------+----------+
>> +		 *
>> +		 * DPU_9_2_0 - DP Controller intf to stream Mapping
>> +		 *
>> +		 * +-------------+----------+----------+
>> +		 * | Controller  |    0     |    1     |
>> +		 * +-------------+----------+----------+
>> +		 * | DP0         | INTF_0   | INTF_3   |
>> +		 * | DP1         | INTF_4   | INTF_8   |
>> +		 * | DP2         | INTF_6   | INTF_7   |
>> +		 * +-------------+----------+----------+
>> +		 */
>> +		DPU_DEBUG("controller_id %d for stream_id = %d\n", controller_id, stream_id);
>> +		for (i = 0; i < catalog->intf_count; i++) {
>> +			if (catalog->intf[i].type == INTF_DP
>> +			&& controller_id == catalog->intf[i].controller_id) {
> 
> && should be on the previous line
> 
>> +				if (cnt == stream_id)
> 
> if (cnt++ == stream_id) return;
> 
>> +					return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>> +				cnt++;
>> +			}
>> +		}
> 
> return NULL, drop else{}
> 
Hi,Got it.. Does this code looks fine?
......
	for (i = 0; i < catalog->intf_count; i++) {
		if (catalog->intf[i].type == disp_info->intf_type &&
		    controller_id == catalog->intf[i].controller_id)
			if (cnt++ == stream_id)
				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
	}
...
>> +	} else {
>> +		for (i = 0; i < catalog->intf_count; i++) {
>> +			if (catalog->intf[i].type == type
>> +			&& catalog->intf[i].controller_id == controller_id) {
>> +				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>> +			}
>>   		}
>>   	}
>>   
>> @@ -2670,7 +2705,9 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>>   
>>   		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
>>   							   disp_info->intf_type,
>> -							   controller_id);
>> +							   dpu_enc->base.encoder_type,
>> +							   controller_id << 16
>> +							   | disp_info->stream_id);
> 
> No need to, just pass whole disp_info pointer.
> 
Got it. Thanks.
>>   
>>   		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
>>   			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);
>>
>> -- 
>> 2.34.1
>>
> 

