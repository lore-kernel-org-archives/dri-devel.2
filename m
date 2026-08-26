Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142CBC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551F010EC42;
	Wed, 26 Aug 2026 07:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqgu7SYY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DngRa1Y9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AC510EC30
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RcWO105926
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M01LbEstjQwAvWYYJO2xKIyxBlaOYO4NSSppT6rzH2g=; b=jqgu7SYY4b79aTgV
 CjpYVhdntB6IbqmTWJ0gqrIqtfUrXDEMX6jkrlLRiFaMHSl2LLKlfmXgkD4Rp28j
 0EHiHyX5w74IpENCa9Qff0kleoYYcz7P2EBk7m8XsFirm0gUoTI91ToKnZ16PG4s
 06dWJmR48wYD2sQFay2DshBKJ7G0jSuZ5/yNynwAkwBH671muvKKkKb9e9my3qTw
 5kVoVv4y/DcW9oyJUEtc7awdIBRMX5gA8VM86uL4HXf7BGREkQjYrBxbRl2OtzLW
 X9yZT5SLG7OYCgOIv2hUS0spWIucuXRtInb4Z0AxLHufdVktI1mxKfHYwbN/vMoG
 Y1MA+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k10hg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso16427285ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730530; x=1788335330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M01LbEstjQwAvWYYJO2xKIyxBlaOYO4NSSppT6rzH2g=;
 b=DngRa1Y9o6ax4L1gX89XFWB5jb7BS9d50L/3kcwX07m9fC8OiBtMzLbyQZYBKziE7f
 xfpnR+YvErY5Rkdh+sW4Vy0Hja01tNRwNOk+0GChjx4FEu3Bl9bw467STsxWn650kB63
 vO3nmGl85puabtzNZLj2ImZIFoFuERxPRszhBZe1ONCXtaZyiVTvgfPgu7V6XwJeIq/p
 Ev/YVmVtpt+iMoNmRnWp7qMXcg1+kIWJJXG0WD/ogfL1lcPGwVBiDhE9vG/vDYNzdyEs
 1ekQccEkyveqjD99suEABhIw+EUE4DvqwgJCav5T91U9sEshkWAyzuJ1ENwfhtIqbJz8
 cxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730530; x=1788335330;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M01LbEstjQwAvWYYJO2xKIyxBlaOYO4NSSppT6rzH2g=;
 b=iUSdajUjtQS5045GND6gUMcke7IEEfaJSEZInd3IMbN27R7OTwd2qgOUf01ntaRJw0
 uO+6RStDMOFKVdo8ZvGOck6TxsYTutcJTCI4PCTECv9vFESP1fXrKN/Aq2R6e5emUSVz
 s/3+1zoMWSK7hWk662gIbHSqzn/6xzMxNHEENZnBTfWR0sn7leT46fRzJffa9dIgsqAT
 T18DCwQ/iohuy3AP31EZm0OEBeQsTe+ja56TozyLU5ilnmHcJaDmP+p95Fda12H30a7u
 ZODbwzGH7qFc/QTgEvAy/vQfFWlgFIMYpl31E/7mQwmXV7Z6SvKDFMOKG6ZNQKxANXN4
 3ESw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqhZ4PopUJss1hZdUY69pZKIlqMSv/hR0xADDWx+imrb7gsLUru/xT3qlOaxAAUufSLnt4RxgS1lg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKcUtlzO5ghWp+em2i9DfjVk4J2cEzC8/Mvi6I50qxmYLfJ6F+
 gFskery5MBf2iD3ffNnc8lvl2K7WV9DwpEDtv9LYhwqLgVooZWcRd6hlMN9L9Y2JVQp7ik0zoOj
 7Fz7diP92jZpTN7i87iOAyIu2HJUpEDC/DiEb+VdqnMB5z3Zn8bMAiJeoQPN5YLm8Dl7/6sQ=
X-Gm-Gg: AR+sD10rEi2Kr+KAniPDHOUNmbMeprwPk/Tcfm68ofrGLCSdXOOwTqx7tu34WYHZCJv
 OqnwNF0Roozu7ZY2P4f87BXnOLppBVzTXFVHGTX1qDv93XwEdIRHBHEIidGpS4jpJVbBpu8fo8C
 x+MAw4Gp+W9wX+UomeHNtHOYHtQIYdC6uUHzR4RDC1AUa/w2FIMyURUiGtye+Ga0z0UJ6e+01/Z
 VdNDwYruolf0OmJJqBVVMce9fLgz6vffkqLmFbMqAr3PHLOHmMM3iesH90b+T+TaKH7eN8snNau
 EIct+K4Bl0MtIc/05jNTN9JlfI1S99pSh4GJREGn3uwW9TEUeDDobk0CF4iP73EByGheU/hWKCw
 KnbNIc/h8CJRfAlFlGjx4Y+o6+uouoCajB7YPMtch8rkIU2VZX9EOP+EQ9w5vczU54u0XRfte
X-Received: by 2002:a17:90b:2791:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-3966cffb1c7mr11428790a91.0.1787730529702; 
 Wed, 26 Aug 2026 00:48:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2791:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-3966cffb1c7mr11428726a91.0.1787730529320; 
 Wed, 26 Aug 2026 00:48:49 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:48 -0700 (PDT)
Message-ID: <2fa275ee-85a3-4037-bad1-14b45dcb22e7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 20/25] drm/msm/dpu: expose dpu_encoder ops for
 DP MST reuse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-20-2ed6aee1867a@oss.qualcomm.com>
 <uja44sqcdoegy4lm6hmd2eoqmpdtai4bdbndlgtgw7w4k6lah2@hw4etqvmcj3v>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <uja44sqcdoegy4lm6hmd2eoqmpdtai4bdbndlgtgw7w4k6lah2@hw4etqvmcj3v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8e9a62 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=D-WeIjmAtmHmNwuUf4UA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX3gGNx5zzj3pL
 sg4kB42IDH+/WnElN3uDkJu2Dhsj7Nbj80F/ho19kg7knDUbV1vp/NdTt/jHaHIjHHS7QIXV0Bg
 MAN5WjdmCYuzRM2bsVGmhWjT48wr2NQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX/wXqI2roPyLn
 ClJw3X62vzy7+6gGpXc542beWyQGq68I8Az6bHf0VeSUyvGA9L/lPgl0QMIEvnRBIC18fwTeP6x
 B/6/VFEJW/dyOtu95jYPRMjgtmzPWi56n1jc0CiFE0t1PM9WAG3F0Y1tcrfjTsyWRljCIootMY7
 aEG84o46XinckZGOxTxBL4Ao9jhMQQPkWrLwyGz7UiWEoxWYxa4YdVWNlQpVDtCSogZN7Z2PGBk
 icNQDRoWrVl2DfkZqRIG9oWcrw9qXZ8PEPQEtyBwegw0AL0vKLKb6Hf0rZVb4LjGa13xMY1A6b5
 NbJdKG8pgBERpN+TdJFj1i23BEdckRhHzfuAMnr15Y2TPKk572o7zs0AC+I2Q5mraxxF6XBNXKF
 0OPvflh0vUiWv3NtqfQ7FeFPX46BLZ68gwTHAJ7xF9wlssA9aXaitfCoHZfHYhefygTKeL6wwbZ
 BEdzEsWB/WwlIqvMKZQ==
X-Proofpoint-ORIG-GUID: qb5lnXvuQQ8sgOLOVcyZsEFyfjVLbDFp
X-Proofpoint-GUID: qb5lnXvuQQ8sgOLOVcyZsEFyfjVLbDFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260063
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



On 7/13/2026 8:01 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:41PM +0800, Yongxing Mou wrote:
>> Export dpu_encoder_atomic_mode_set, dpu_encoder_phys_enable and
>> dpu_encoder_phys_disable so MST encoder helper funcs can reuse them.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 ++++++++++----------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>>   2 files changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 778e231d4967..1c74ff6f0dbd 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -1149,9 +1149,9 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
>>   	}
>>   }
>>   
>> -static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>> -					     struct drm_crtc_state *crtc_state,
>> -					     struct drm_connector_state *conn_state)
>> +void dpu_encoder_atomic_mode_set(struct drm_encoder *drm_enc,
>> +				 struct drm_crtc_state *crtc_state,
>> +				 struct drm_connector_state *conn_state)
> 
> The commit message says nothing about renaming the functions. Why are
> they being renamed?
> 
Got it.
>>   {
>>   	struct dpu_encoder_virt *dpu_enc;
>>   	struct msm_drm_private *priv;
> 

