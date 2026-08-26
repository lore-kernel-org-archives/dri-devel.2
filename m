Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27027C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6245A10EC45;
	Wed, 26 Aug 2026 07:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HXGj+kzO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gj4bnKVL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCBF10EC44
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6Ru8x122883
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 voO0QQTgVbHKHOvzivClVeHFhl/PfTaZ+unD1L+XyPs=; b=HXGj+kzOH6ACsxAa
 lHm/tqBMZ1PPht/BCiVnYgde10I9xzM1OSyaB++SRn62UwIPAwVafcaGjAPhw3cL
 xwH3zbGyAE+lDy8co1hnXUK4Sd74FIp+S1RAe+cp4Hp2ulMszP4CDqeqSgsx6kC/
 njI5D3ZwWcuYRKByiCPASGabmEZdD2W/jxPhpFlEnpORrCPh0oSz6QfFqncKOhPL
 EmD01Cx/fxoKSuX2ZbnFdI6EOy2EUxXtGcA1Fs03swrOTWCJbdOJ5a9C7v07htKP
 UKHB9VcN5HsR+9vwpTgPF9AHUM9MkVvuzqpZUoPRH9N09Nmrq1b9gxP5C4P2d45q
 +KMxVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mtjpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso16428815ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730534; x=1788335334;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=voO0QQTgVbHKHOvzivClVeHFhl/PfTaZ+unD1L+XyPs=;
 b=Gj4bnKVLxDuNH1nEcDKX5LV1xRUqohlDbolEaCCSby5Muz6SCCvxOAtbrPSp8Enefs
 63nZEp1BxoGX4lVaL0Dx0rGFQWWGRkvT8eASXbRfbcOJHgQX4NAJqf/J8mHQNh8dk/3J
 L7mEm0S86vAMlNm1l6Bu3QERKUlDxWj3bg4jUv9vBbaH6HueIXO04uy0Ncf7zhNWi+SQ
 XyGmOy2zZoaLoR2hkHVUjsvaw8UTxaObijsvxsK9YlzUFSf31Y5PbKwkKQPMZktajPKC
 +9SwxiuBzPHQnWGiygFHNvwj53e7KogOeoNLyKoF6+lqfa4mGY4tOhzSF65fwdPEwK4B
 p9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730534; x=1788335334;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=voO0QQTgVbHKHOvzivClVeHFhl/PfTaZ+unD1L+XyPs=;
 b=ZBfpVoetghR896gMYWX7uf+zcfUgdGSslzRV+yQkdaj5v15CkpSnamfkY159Cq6HEL
 4ODlxtS0KfYXRrxnktzdXlX9++mXcbVuL2fTpnt8iHYzq41fcrqAz6Iqljq8Q4vDDyc+
 Kplrt9djglW16/R2O4tKpQJQomzBdpNnfp5N18sKX0HX/OPHFq8u3RAvzCfSMjNGNyrY
 vyyJyI68QOl5CotWD7sbbm8c2y7NN+r6xPNmMCZc2Bzun323zx3FRhB2YneLizO0qMpJ
 4EUTpB9vvs/zwz1DxgHDAE03cXJSxMGeVy7J+uL4VR/kzeKQANmk8ZSUVmOgMqwN7J2X
 FilQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXwdh4LQK8rqTkpDUrOTT18bSP/w4hQ4+FFgXdhw2hAFoTlNcEqw9Yh0gaLkKdZ6WUTVCb10eF9DA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLmbksNZWppEis1/vhqY8cMTzwhB8gDqkFfj8cbtioGe47H6SP
 xhf2zlch2s5yUQZC/Z3fZiRGTfDO7Niha5NfrsHTKwC9eRvdyng65X1eanK/3vpbY5agyNopVeq
 Sd5Sb7U3JJjLDJtE1gTMphcsWTwh0cGbwCKtDuZHjiBmAxhNQgvhGEMLJyvKTzwUb6zs0cCw=
X-Gm-Gg: AR+sD12Xrc25qqnlmlSIq4Xst+Ha9bFIztC97Vg+F30k09k5S4pVWNSEU7SAJAo/Umf
 3UPeqGRvYKu7LmnkJBQuJPvmQirOjQ/SCqbNlgIGfzO8jUHlRtRGuBlUm32mE8twtZZZeSm/Rnc
 ISk8DrWb+9EulE2DADAfqDnQmsdcBtDjAMI8S392W+RGOQSdKXPvpECrOyUV56ZLkKnsLv2Nl9T
 mRpgPEt0v0Sh7ZlLKRbB5vNIa1qVoJlciLClHDEvhhNlKtysz/zv3vUO2O/3nR48O1nD4Pidim0
 uGJ0ZTuuoVdSw57CFW90fJLZsBpquNCWtA2mkwRByaSE6W8Qx2y6LJDUVAUqtDAA2qh+gFjbraQ
 ZQ045mkAUzTGvgaP8Vf2j7zr65LEVfiyuX0pi+M2sZiO+cVm1zC2opLXynYr5xr5NWWMWJfI/
X-Received: by 2002:a17:90b:1fd0:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-3966d3ed042mr11270561a91.6.1787730533910; 
 Wed, 26 Aug 2026 00:48:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1fd0:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-3966d3ed042mr11270482a91.6.1787730533411; 
 Wed, 26 Aug 2026 00:48:53 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:53 -0700 (PDT)
Message-ID: <d8a7407a-9c8b-4435-8d99-a46588d52e9a@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 21/25] drm/msm/dpu: use msm_dp_get_mst_intf_id()
 to get the intf id
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
 <20260629-msm-dp-mst-v5-21-2ed6aee1867a@oss.qualcomm.com>
 <pnhfi37ijlxuboqritlsg2o6wew44pe7niyhyvxc3dbrdvgazc@dfpldilmrp7r>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <pnhfi37ijlxuboqritlsg2o6wew44pe7niyhyvxc3dbrdvgazc@dfpldilmrp7r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX/Ult3u596Lx+
 Nx30Te8+LvmKTeXaTiI4MvdcUUUrR+qRxi28PnM/WmwB8SlJsRxSN0so3p0TXfbXzMZ9THhUFWW
 2QzpI8K1ewhwlrv90Jdpe/Zn86eGoP0=
X-Proofpoint-ORIG-GUID: j_8Y3RlNX_jMILaTrPhW3iGMd38zkIYY
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e9a66 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_xYO84BrWpCsddiSF-IA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX+gUutLSeUE4P
 sL8q2MwFtUTycYNxLBEGr3VCam3jGvDRMlPpiMAGNiU1aIphb/m8QarqkpkQm1OSpcHhZBEr6ID
 4bL727zqb0vRnectYWJRWRzeEptaKqsv6b4/81OHOjclETsCC0AZCwzhq1aitzJqP4cGEcnFXsX
 +K01D2LmMJ+9SWEAmk2cfKXlSpmIlP+wKOW3sTM7wvcnumzlTDopyTPOxFt644PjYywn4OKMyj2
 DB82cD5i31NRwb02XhqGMukYkwR1Esg1f09cJ9vGzz+Sv4tqsmAdvDEXUb2pIueHAMF4d78Z49X
 ++cVH2nI/F3Aoq2sTUh6/jSTAVY0D8vyUrHjJdJsO3//AQ8n2vOKE+iYAcUj0FXxdM2g5iLWQ3Z
 fmheaVTpsDG8iNfmB4ZbbPLYCLOtP/DobWSn2MJr88trbiBPRxIBDl/5AMCSAnGnEAPpN4TDLA+
 jxeI65JCso6FJ+SSp3Q==
X-Proofpoint-GUID: j_8Y3RlNX_jMILaTrPhW3iGMd38zkIYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260063
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



On 7/13/2026 8:09 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:42PM +0800, Yongxing Mou wrote:
>> Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
>> controller as the intf_id is unique for each MST stream of each DP
>> controller.
>>
>> For DSI/eDP/DP SST, the stream_id is always 0, so existing behavior
>> remains unchanged.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 +++++++++++---------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  4 ++++
>>   3 files changed, 17 insertions(+), 9 deletions(-)
> 
> This really should have been a part (or done before) the patch adding
> DPMST encoders.
> 
Will splite this patch.
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 1c74ff6f0dbd..3adfaeaab71d 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -1438,18 +1438,21 @@ void dpu_encoder_phys_disable(struct drm_encoder *drm_enc,
>>   
>>   static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
>>   		struct dpu_rm *dpu_rm,
>> -		enum dpu_intf_type type, u32 controller_id)
>> +		struct msm_display_info *disp_info, u32 controller_id)
> 
> As you are now passing whole msm_display_info, controller_id is
> available as disp_info->h_tile_instance[i]. Pass index to this function
> instead of passing controller_id.
> 
> Ideally, split this patch into two: one changing the function to get
> disp_info, another one adding stream_id to the struct.
> 
>>   {
>> -	int i = 0;
>> +	int i = 0, cnt = 0;
>> +	int stream_id = disp_info->stream_id;
>>   
>> -	if (type == INTF_WB)
>> +	if (disp_info->intf_type == INTF_WB)
>>   		return NULL;
>>   
>> +	DPU_DEBUG("intf_type 0x%x controller_id %d stream_id %d\n",
>> +		  disp_info->intf_type, controller_id, stream_id);
>>   	for (i = 0; i < catalog->intf_count; i++) {
>> -		if (catalog->intf[i].type == type
>> -		    && catalog->intf[i].controller_id == controller_id) {
>> -			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>> -		}
>> +		if (catalog->intf[i].type == disp_info->intf_type &&
>> +		    controller_id == catalog->intf[i].controller_id)
> 
> Why did you change the order of the args?
> 
Hmm I'll restore the original argument order in the next revision.
>> +			if (cnt++ == stream_id)
> 
> Squash into the condition.
> 
Got it.
>> +				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>>   	}
>>   
>>   	return NULL;
>> @@ -2675,8 +2678,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>>   				i, controller_id, phys_params.split_role);
>>   
>>   		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
>> -							   disp_info->intf_type,
>> -							   controller_id);
>> +							   disp_info, controller_id);
>>   
>>   		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
>>   			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> index 25ade3dbbeda..861d69afbd76 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> @@ -28,6 +28,7 @@
>>    * @h_tile_instance:    Controller instance used per tile. Number of elements is
>>    *                      based on num_of_h_tiles
>>    * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
>> + * @stream_id		stream id for which the interface needs to be acquired
>>    * @vsync_source:	Source of the TE signal for DSI CMD devices
>>    */
>>   struct msm_display_info {
>> @@ -35,6 +36,7 @@ struct msm_display_info {
>>   	uint32_t num_of_h_tiles;
>>   	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>>   	bool is_cmd_mode;
>> +	int stream_id;
>>   	enum dpu_vsync_source vsync_source;
>>   };
>>   
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 91d33b432427..b32ecd5b0777 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -614,6 +614,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>>   			info.h_tile_instance[info.num_of_h_tiles++] = other;
>>   
>>   		info.is_cmd_mode = msm_dsi_is_cmd_mode(priv->kms->dsi[i]);
>> +		info.stream_id = 0;
> 
> It is memset to 0. Drop this (here and below).
> 
Got it.
>>   
>>   		rc = dpu_kms_dsi_set_te_source(&info, priv->kms->dsi[i]);
>>   		if (rc) {
>> @@ -689,6 +690,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   			}
>>   
>>   			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>> +				info.stream_id = stream_id;
>>   				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
>>   				if (IS_ERR(encoder)) {
>>   					DPU_ERROR("encoder init failed for dp mst display\n");
>> @@ -716,6 +718,7 @@ static int _dpu_kms_initialize_hdmi(struct drm_device *dev,
>>   	info.num_of_h_tiles = 1;
>>   	info.h_tile_instance[0] = 0;
>>   	info.intf_type = INTF_HDMI;
>> +	info.stream_id = 0;
>>   
>>   	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_TMDS, &info);
>>   	if (IS_ERR(encoder)) {
>> @@ -748,6 +751,7 @@ static int _dpu_kms_initialize_writeback(struct drm_device *dev,
>>   	/* use only WB idx 2 instance for DPU */
>>   	info.h_tile_instance[0] = wb_idx;
>>   	info.intf_type = INTF_WB;
>> +	info.stream_id = 0;
>>   
>>   	maxlinewidth = dpu_rm_get_wb(&dpu_kms->rm, info.h_tile_instance[0])->caps->maxlinewidth;
>>   
>>
>> -- 
>> 2.43.0
>>
> 

