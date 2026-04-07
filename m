Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C466FB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D43110E1E6;
	Tue,  7 Apr 2026 02:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7VnEzaS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FqiX3if5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5137F10E1E6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:35:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQAjn1405853
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pKWZGWsm+uinU5enYlneg7o88Oa9y0lewOd8+OxYdEo=; b=a7VnEzaSz691Ni60
 jHHQs8DzeX3CnTDVWSMcEOhnPdsUc/yi2a3iUwS2TK3anYUaCPHVbRLUU7O0sJ2r
 eyo2Xk8ivIgtl09y/ife7H2Ny/61ta0uZahK8bNEphAYEdXVY5/wyUQaXGLcRqGF
 F7bo5MwoROvwPTnDX0siGeS3wR3t661Z4Pjipvcb6PRL4zLYq4u26xcAscEwB7xO
 s3bjYGlkl8XG6hzz0dIkBTwK2VgzwfPXXBOVhL7C0dtjiy0J8v5iHB5RCc15HLyC
 bpRYHsdcERjKu3NHbCFegRXnaJb0ulTF28l3d1DxJfUGGCsG2zpvws45f/5eqlou
 UXU9sQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrarpb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:35:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2489af602so44633185ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775529355; x=1776134155;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pKWZGWsm+uinU5enYlneg7o88Oa9y0lewOd8+OxYdEo=;
 b=FqiX3if5c7Vqtf7e2zaXeZZiwsnLajgoWAYOPEE5Gnl6aeaFCW6yAml95bsgckRw+k
 dcCY5IjZe+v/0x5cfvhZ9Ql79uyqadGKrVyAd0yWIxcaTtmboa1Nd3KT5ZB7oe4ZBWTq
 ts9X3in0rsQm7KptiTl+rDSG4apMTwcU8C3EFNxE+eCaHvkhD+ymZ4Jf54d/JlO4Bdyz
 WnAfSDG/d1ti6x8FHe1KzmFfJra5PAFuoQmnQrfTOCkZm5xJce2i4OEqOgXEUI7C2N3o
 J9VssRmNxND7wke/rQN+hs+xRkRTiUDvGnqPlNAWNy2eqvvrMZsegaFqYD6qXNE5Hu9K
 1iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775529355; x=1776134155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKWZGWsm+uinU5enYlneg7o88Oa9y0lewOd8+OxYdEo=;
 b=JUyL6qM2Vvpg3KDE9pt8B2EK8dRzSUA9DBy7Azv5L1gPQ56iwtPPIyJbIJODBP8aSz
 LVIaAVeVujWBIELs9rl/wfbxWhByKRovAkEP8S2L0I+7ujgvRFt/YRGHEDea7reQrJIX
 ZruBn08bgpwDOnrSe4ONHDlcEcXw0g+tLMuB1+UTpthB7wDvxekdQHUoM8yCl/OyaTRb
 7BRFelYVOkaZ6cwQlwGKwRGE3KR/WChS/UaAZ/CHgkiDWH91gkTCSTWOgKqN5MJ8sTv3
 +qcK3vtW+akSoGKuwwj5cxRLo4hDFdZr9IJat5rHQP1jm8FwQ2Af9kgqR4qafKp8Tn+B
 XrQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf7Aen7CCJTBOwsXEHpSvbIuU0IbJ944PB6HScz8w+d8+7JwDHowg7IggtQ/CD4QpmDndqYNT278k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNN7VHMJjo6LI8RzNSDvl48/rG3GIPncJOOvYnk9Q3G+fz5QJ5
 /igu993GHWrkTKR82WzjEtjXZwVD4Ex2TPV6mDTTMdg4igON6SdUSphAm+ipCN/9rzODXKXoomV
 kSO3qONF9iLXeG6LV9iNkVOX0U2WBwb6N1OWL/FioLrI8c5aKsvSbfvrv4kNCCu0Q17n01tE=
X-Gm-Gg: AeBDievShUvpQJUxcL5r4yU5YaTFNX4dMgUHP8HdltTKdYTiBKRzI34PBiLZppiKr/x
 JL9lnMw0AEHHKICcRTp4mjrJvqxoJaZLu8WU2YnDNirWCaWXNirJQcRyLMHd8UX3xNdxU6ucmUJ
 BLVrZVwR1HHxE1fSERJ/rsimlfzBPJ1F5nLdSJQKvhE+TulOziZ5K4J1ENfUlxBROVaDX7EWBUm
 nESX08xM3y6F9yBH0cYmroIKZB9riAq4JA3PA5+5ynZHZm2NROBSwLCtMT+M1McCbl/N4kx+tOc
 PctQvadR/NxT5kTQJQGwhlDF+LiOcGQMxbYmXmdJAdEcelYlQYE3H/A6gqrJj3O/UGQi9eLPDRW
 TCaZTGNhe+nlAZEZjVEVEBXn2b/oNZTxAyT4PBUIlayBKbQD75mRW6i2pMrXX4e7iIgALx44fMb
 VIZetWGyGb1kdqVyO49w==
X-Received: by 2002:a17:903:388b:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2b28205a9d8mr144906065ad.13.1775529355065; 
 Mon, 06 Apr 2026 19:35:55 -0700 (PDT)
X-Received: by 2002:a17:903:388b:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2b28205a9d8mr144905685ad.13.1775529354518; 
 Mon, 06 Apr 2026 19:35:54 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27497af19sm149001615ad.50.2026.04.06.19.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 19:35:54 -0700 (PDT)
Message-ID: <a69c3d6c-da4e-4ee1-984f-cb827c298c0b@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 34/38] drm/msm: initialize DRM MST encoders for DP
 controllers
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
 <20250825-msm-dp-mst-v3-34-01faacfcdedd@oss.qualcomm.com>
 <npxu4ybwj2dztn3dbvmkxiwqw27wyr57g7ps72ndst7cful6n7@vuk2rizlz356>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <npxu4ybwj2dztn3dbvmkxiwqw27wyr57g7ps72ndst7cful6n7@vuk2rizlz356>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7HRgjNOr_FBdkrastDhEKmiDe_m80dae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMyBTYWx0ZWRfX9pudWiMNMI9e
 nVm9TaG4Bx2aDEqRRCvBi5drAzRuRDTysx3y80epMhf9OYTNxTXG7t8pzEiX5bCDvrCKjxuPioT
 lVJnJcM+jmTDREMxFUeYJH1E5tWlZhEOq0JdQTfyxSdPz7E85UMiS8pOxc47fT5xV/+RJXTLaw0
 zlRsxYBiO2MZ1irbfO04jltm3tIRclRSv8piyCP/5jJDurxhq4SzDmkHRr52uo5qPpnT4qAoQbO
 jDM9eInu+KUWl5MkFSx29P+VkFDvfQOOhDtXVFhjvjqOvsm8CyewK7/y1k9UpF+kxbfjtxjALg9
 t9Yn74SZqLM4wTFxledwWrSsiA3FBnhzjTVs3nI9NKxEPgfua7aYOEbuotbUQz+O7sFHrdXzagJ
 0z+vFM+3MgxPcYGUskdqJNg5SPtymcgKOF+C50IV/k/xZMaKY6HTvE1FSIrIK2vuFTDyp4PJ2el
 S+cN7pB9mmOyJSRzjLA==
X-Proofpoint-GUID: 7HRgjNOr_FBdkrastDhEKmiDe_m80dae
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d46d8b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Bl6qu2857310sCFhzq4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070023
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



On 8/27/2025 2:55 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:20PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Initialize a DPMST encoder for each  MST capable DP controller
>> and the number of encoders it supports depends on the number
>> of streams it supports.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 23 ++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  2 --
>>   drivers/gpu/drm/msm/msm_drv.h               | 13 +++++++++++++
>>   4 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> index ca1ca2e51d7ead0eb34b27f3168e6bb06a71a11a..2eb4c39b111c1d8622e09e78ffafef017e28bbf6 100644
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
>> index 12dcb32b472497f9e59619db4e810abfbf610c7c..0b9d9207f4f69e0d0725ff265c624828b5816a8b 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -653,7 +653,8 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   	struct msm_display_info info;
>>   	bool yuv_supported;
>>   	int rc;
>> -	int i;
>> +	int i, stream_id;
>> +	int stream_cnt;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
>>   		if (!priv->kms->dp[i])
>> @@ -676,6 +677,26 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
>>   			return rc;
>>   		}
>> +
>> +		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
>> +
>> +		if (stream_cnt > 1) {
>> +			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>> +				info.stream_id = stream_id;
>> +				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
>> +				if (IS_ERR(encoder)) {
>> +					DPU_ERROR("encoder init failed for dp mst display\n");
>> +					return PTR_ERR(encoder);
>> +				}
>> +
>> +				rc = msm_dp_mst_drm_bridge_init(priv->kms->dp[i], encoder);
> 
> This is an implementation detail. We should be asking to init MST, which
> might or might not be a bridge.
> 
Got it. How about renaming it to msm_dp_mst_attach_encoder?
>> +				if (rc) {
>> +					DPU_ERROR("dp mst bridge %d init failed, %d\n",
> 
> DP, MST, no 'bridge'.
> 
Got it. Thanks.
>> +						  stream_id, rc);
>> +					continue;
>> +				}
>> +			}
>> +		}
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> index 8fe6cbbe741da4abb232256b3a15ba6b16ca4f3e..d73e3f908439094532e88945ed4d41ed092051c9 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> @@ -82,8 +82,6 @@ struct msm_dp_mst_connector {
>>   	struct msm_dp_panel *dp_panel;
>>   };
>>   
> 
>> -int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
>> -
> 
> Squash this and the next chunks to the corresponding patches.
> 
Will rework it.
>>   int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>>   
>>   void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index 985db9febd98e35dfed51d39dac1a522abe5a351..3e64ec7b7dbe1d1107e85def9aa80277131f40bf 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -363,6 +363,9 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>>   			       const struct drm_display_mode *mode);
>>   bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
>> +int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
>> +
>>   #else
>>   static inline int __init msm_dp_register(void)
>>   {
>> @@ -379,6 +382,16 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
>>   	return -EINVAL;
>>   }
>>   
>> +static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static inline int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
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

