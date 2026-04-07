Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10159FB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE6010E313;
	Tue,  7 Apr 2026 02:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLcqfOVm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOdPQkZC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0366C10E313
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:33:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQE8I1584466
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 89gbJ4/Y+ioC9vThJOmb87Wer206nh06egfFrTvEDCY=; b=iLcqfOVmi8BwWlPX
 brlIBgMjYBJPxI4zh74O1bmM3TPrhSv2SIM2g0H0b2OnotGZ66R/sixcCnaDOZd2
 KXx5PtUHMzFojsqr30jfOF4O73weUia4mZbD2AJj9svp5HzJ5qiwhsaG7qxVSrr3
 cecxGPzWQzUt58nAtLObTo1CcwH6n0nQKfE1TorkvUJmu137ZnBOha4kT29tDTTx
 mcuiXL70AotzszhAFtimswpBKorTtDZ609EPfcXWQEzMCoNSW5X1NMNp8cG5djDP
 iY70VjgPabilOI8hise+odrZFXiLUbYAS1UkQREGBAivudtwtDh1Qnlgvy22I9e5
 8g3yAg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9rns2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:33:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c4664f75fso2906028b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775529227; x=1776134027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89gbJ4/Y+ioC9vThJOmb87Wer206nh06egfFrTvEDCY=;
 b=XOdPQkZC+PgNCg/AWgU+WBzP5Ind1wPPudNQ05hSSpLohVM46eqi8gj6lSxUv2VpGx
 FXoKDA76BIGCD+JyGdchKRCCx4UVcOZotbzuzVS+kQm2Tmo84gmAFFSfMz97G5d3sPbH
 721pHHmlHo9DgT5/cY+rLfiJwRFNTuVe76UwJF2zLcGEaBmTntqmOKKsxQg/lINxvNI9
 rj2IpPWfdbh7TNAlUJkfQRtiCHHS3XlVSszwhQDyhL3YSAml5wwoVSrZnvEjPKAkeWDF
 GFJ9vaYyw8qjvwYlHXYjVTs/47tsoP63f5qN0JLRHRwa2f6EzPHkwtbbKnW2ub3mlIEL
 eCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775529227; x=1776134027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=89gbJ4/Y+ioC9vThJOmb87Wer206nh06egfFrTvEDCY=;
 b=nGIrk40ghyT3T1jNRixAOV3en3yxrUngmGxTkEM7qrpyMw6eFIzKAVEHuw9aljTQAs
 Es7RWSAkG7M8DHoF6OhY5lae1WEXKh4B66b1lTt3qbeMJeaC7Mz/6sogopMS61SYTHrf
 oZn4QsU2JfzGuSFpOHCMII+R9jDBZ0cBd7mU2tia6QZKIu9NSzRlzdPBRzpvD0Z3zFU4
 PKB/js7uRG1FfVAvX8aF/Eojf7ShCLIyH/NV+P6hu+nyd7TTchBe9eWlEyHeaNubiDDY
 KBgb+VHezEPMs1dsj4QmOJuSri1QY3+GDRKf4o8Jt8XNO47BDFScl3vSke8ehV/7rAIO
 zzSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/sD+6X2TO/nfJ7XNM8XcgL4mmlRTM/jXQMgAu9UAOSlqNJ+G5lFLRxcRtzggHns0zLh+EbWZgUqo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFLIODQgPqDFDTq2kKkd7LPUq74TTxgzOYnsdnDM9QqXm05TVC
 0OoKWtjcEhHC+7bvqcfBpbmSyBU7wbXNT7dqNHiTkviKtttsvgNwjOlMNlkmp58Wbrp8h86V7kg
 HU4EPlmJfH0Sr+qIJcZTZCnVnCO56cry1SGsVh+TKmLqbMmVN/j4ygH3eqJwJQUPy3SwYxK0=
X-Gm-Gg: AeBDievVlLRpBDVsk2Bboy+shnY9Zsb8mQSR3eORv6DyF530SvTnpxiefS3zT4Wccrr
 gmTqYBjpIeUOi40UFlQ1QwW0JEturjDn3zbK3J8+hUaGzeihU07Ao0EXrS2ZP3K8Eoiz5r0xENa
 Crn7lj3ZB6vakUtuzBT/6OOpTdpjE9KqVsga8YMG4Ae22IQadnXHLF9Fe2COLbwIeuNPG2ac10/
 FqZrNlZVNsodLJYJrrnLDRpE5J7q2UzVskDkPDISan1eysIaOh3Orwp6cUwn5PQvrpD3UhFxQH/
 h1Eu7ocA3eZLf0SvdzdSK89mryV2+NvUTgJ8wt2fPaHbIYcOHD1az1dn1IBNV2XNkcRwB/Cg+sU
 Fk+d2PNIJYb6IM+LACCcmZqKgEPOjuIMONpE6lqbeVITJcvuYNsUoqqQRLMslimQGr0FUakb10J
 ZRs4LFj8pAv1G8nxAIOg==
X-Received: by 2002:a05:6a00:2d10:b0:829:9f46:280d with SMTP id
 d2e1a72fcca58-82d0da345b2mr13849281b3a.1.1775529226743; 
 Mon, 06 Apr 2026 19:33:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d10:b0:829:9f46:280d with SMTP id
 d2e1a72fcca58-82d0da345b2mr13849234b3a.1.1775529225895; 
 Mon, 06 Apr 2026 19:33:45 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b589b8sm15404155b3a.24.2026.04.06.19.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 19:33:45 -0700 (PDT)
Message-ID: <c976f5cf-c61a-42ba-97f9-3d36e2baed26@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:33:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/38] drm/msm/dp: initialize dp_mst module for each DP
 MST controller
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
 <20250825-msm-dp-mst-v3-35-01faacfcdedd@oss.qualcomm.com>
 <yztpuhehjydmtefynpa7gt2keysdjpsdmrke6nkjsv7jnhkvkq@cve5yzs7v2sx>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <yztpuhehjydmtefynpa7gt2keysdjpsdmrke6nkjsv7jnhkvkq@cve5yzs7v2sx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d46d0b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fATO5yK3SkeBLP2YPJcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMiBTYWx0ZWRfX3PbYo+mSM4rk
 psh4N+oj4bNvoIV18ijlF+VFkMAitn4SySuz+6fPIc5qvQiyX/vvbCvMmve4PtFuMwHhvTOev50
 49U/gmaBMnM3F/VgBzJVXFYYOfegQoh9dH94KIxSotWqZNwbCaJqfQ2uJCbFNAZbc0sugRJXjbj
 zDU3DRMsLaP5xCXOJ1J3+p/b0LZ/RAZK6I075UVrE6DUjn8D7u6g0UIgHNl6nuQFY+5NJXuoAD5
 BkBA7vqM22GG8wL3+831BT5DD8bNvGtsmX2dc+hGLAyWWuiWI0ss4GmjTlx3DlDFCYuFI2rP9Yg
 sbsG61QAeYmg4d2sssi4MWuJ95wmISnBj0pacF6TbrcRzfwzBXzYZh05meCnRr0OrwTnAskjATc
 id8pqJWMbmbyOZZN2Z+pksNjtCZmK7eyqhEkKXemxGP9Cm28CPPZqtoHcD930H3x3HeswcjiRj5
 Sc6gj0ZlpZmbPq1VNuw==
X-Proofpoint-GUID: lxgyDtWcjkgF_YcSuauVqJOWOw5rs3Xg
X-Proofpoint-ORIG-GUID: lxgyDtWcjkgF_YcSuauVqJOWOw5rs3Xg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070022
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



On 8/27/2025 5:27 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:21PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> For each MST capable DP controller, initialize a dp_mst module to
>> manage its DP MST operations. The DP MST module for each controller
>> is the central entity to manage its topology related operations as
>> well as interfacing with the rest of the DP driver.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 6 ++++++
>>   drivers/gpu/drm/msm/dp/dp_display.c     | 9 +++++++++
>>   drivers/gpu/drm/msm/msm_drv.h           | 6 ++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 0b9d9207f4f69e0d0725ff265c624828b5816a8b..4036d3445946930e635401109ac4720ed2282c2f 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -681,6 +681,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
>>   
>>   		if (stream_cnt > 1) {
>> +			rc = msm_dp_mst_register(priv->kms->dp[i]);
>> +			if (rc) {
>> +				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
>> +				return rc;
>> +			}
>> +
>>   			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>>   				info.stream_id = stream_id;
>>   				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 909c84a5c97f56138d0d62c5d856d2fd18d36b8c..897ef653b3cea08904bb3595e8ac10fd7fcf811f 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1586,6 +1586,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>>   	return 0;
>>   }
>>   
>> +inline int msm_dp_mst_register(struct msm_dp *msm_dp_display)
> 
> Why is it inline? Also please move this to a corresponding patch (the
> one which adds msm_dp_mst_init).
> 
Got it..will rework patch to make them look more reasonable.
>> +{
>> +	struct msm_dp_display_private *dp;
>> +
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +
>> +	return msm_dp_mst_init(msm_dp_display, dp->max_stream, dp->aux);
>> +}
>> +
>>   void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display)
>>   {
>>   	int rc = 0;
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index 3e64ec7b7dbe1d1107e85def9aa80277131f40bf..c46c88cf06598df996a17c23631570fda078b371 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -365,6 +365,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>>   
>>   int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
>>   int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
>> +int msm_dp_mst_register(struct msm_dp *dp_display);
>>   
>>   #else
>>   static inline int __init msm_dp_register(void)
>> @@ -392,6 +393,11 @@ static inline int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct d
>>   	return -EINVAL;
>>   }
>>   
>> +static inline int msm_dp_mst_register(struct msm_dp *dp_display)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>>   static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>>   {
>>   }
>>
>> -- 
>> 2.34.1
>>
> 

