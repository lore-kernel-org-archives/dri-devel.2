Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED6C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE2010EC48;
	Wed, 26 Aug 2026 07:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WpXfvZgt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQoUArm5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BF610EC47
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:19 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RqMU3210700
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6DCmBsvDeuI8ABH6xP2YOY9HZossfW23sCzfnm22eqE=; b=WpXfvZgtvPv32iNy
 or8PX7JwoUsUHI2qkxa0vBHZbtCqriiINVxk6ttQ5HEGTvPv3kPeB55hgFucoheu
 P6k/66bSkxasHh5MiMWg/nS8PIeqDst4hC2QL2Wtc0TvfAK5wy+P1paFKzJgrMlV
 4jC+oLmtGFDkCEVfYtznyyNHJN6fMu4x9y2alZzle80HFK6xZoxFvtuCGhWXdp9w
 iw8dp2Nj4cieL07X3109rxTs5/p8u+rhzNlF4Q+/WOKKm8h+vRw4PrRkl2FAA3Lc
 LKqK9Q/FCHGqrXCa3qHW4KvfIV1n1CN675+RhRZis5RuUjt6H/WlNKXjc+r7JjSE
 +/hxgw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgras61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84eee2147ffso972679b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730558; x=1788335358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DCmBsvDeuI8ABH6xP2YOY9HZossfW23sCzfnm22eqE=;
 b=ZQoUArm5P542ag3xDaUn/+B4q3NaVVJvSNVRjgTbn4HxWFUkf4x8WzqCmUvzJ5XMt1
 GYQHEmBPOnoyZ63nmdD8rvpyxwzRUcBasc4cQNUZLNCGaNo8Gf9cpVBbTRMnzKvcafuE
 ChK9WyiL38Fk1tTheAdJHTlCA/+3sKqkvgpjTvcQFKxM8I139mjCw1C+Bfusf4yiNz3z
 FU2WHgv4iXnj4Dl7qz3bzlKev8mZdQW4dOdtx/h9Lo4gzqskCljnHtO1vVbDJSPBA8fW
 mxHPfy3LKOxJFnwTmGGJ14fhzBftBnWTqM8S5ghwXLypmsEy2yqxTptyzpLy3ZHjeamW
 aAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730558; x=1788335358;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DCmBsvDeuI8ABH6xP2YOY9HZossfW23sCzfnm22eqE=;
 b=Cj6J73IWXzmrm6g5undZfqvYmieumuyIB8r9lcAH3xrPXiyHwJHCFpC7VwvzxOi8ob
 V18laoUDry6fEduiBovunaZwPtqkMgg2/2QVBG/fR50ClV3X/1eTq5XqYiJsIBWoU2N1
 Qm/ZqZT/D4lbhpbt47nTrgM5rvabgOi29+3opLD9o7r/A33dtXwq0madt4Szfxxer8Xz
 MdCio251gFpn8L76AgG0bCvpk3SWcgP3o+S9Cb9G4WleheJ/NnmRPtZyVjmynqYc8qdj
 qfbi7Y7lyyk2CiSH2gOa2uOsmwDX/9uFTWmsO+EfRKRm9+hPC8KhHU36Mg+qAtIafOcn
 XjZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPm0ITZ32K7Kbn3PZfotnELUitOqLwgXV6RMhU+tq8RlfxyYenjZ67ckUuaCgY9cOEYqvcTDtTtJk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltMYe7IFNhKKZUX66kvPzVrtHqDLkVc4ERfav+IwVB6sR7Df84
 KtLxZEYOh8CXG4tz+no7RrcNGlsVCqfwPINPdD+SS/+LxIpEfdCD6UDitZTReuRndbEvAbMdoNx
 G30woROP2f6KzVXU/dD2fZLWapUv05nzXh0l9eegZFtZGF7EZipBbb+GJZaW7aMgU9LDf8co=
X-Gm-Gg: AR+sD105e2etyll9zeQ0uet7WBPTCEqqf79vTtbt0MQvlBVztVOFz56XXwKNDiGzsYB
 YpyiFKMUQ+RlHxpB/kGHdEJapnsKI9yLSXlQ6gVyGkb+cljusViPQiI+qeWsKwKEpCbgi+K8mwG
 S3K/hhsIHcK53VtLvFq9FEM7SgkeiblqmgKpn6pgSpESY9qfyjMcQj4raC2DiArcoxf04+jlbKL
 3wkPtIo/kp9+VypOO3nNTo4nQUuLElVFO3ShGQCQ+tjhAAZtH1mzVh5vPJBOj6waJsElurbCp6v
 534hiqmSz6iGzpkNxupAPvvWe+Bp22n1eqKK07ZeRx0Sc/kALRMcp/A5EHjzeg5jKhxncoOpGSE
 1zZeLfxteRdofGjVuPGifIMxWcwKSsyMbjz4QekzrAcVZpNa3IK446SZVjVmwN3UrKjxjcFvV
X-Received: by 2002:a05:6a00:4216:b0:851:b03a:fcb with SMTP id
 d2e1a72fcca58-85374bbae36mr9760662b3a.14.1787730558308; 
 Wed, 26 Aug 2026 00:49:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:4216:b0:851:b03a:fcb with SMTP id
 d2e1a72fcca58-85374bbae36mr9760557b3a.14.1787730557806; 
 Wed, 26 Aug 2026 00:49:17 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cd8a41esm588474b3a.29.2026.08.26.00.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:49:17 -0700 (PDT)
Message-ID: <06462446-9a80-4c41-a882-59f19f6a5ccc@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 23/25] drm/msm/dp: add dp_mst_drm to manage DP
 MST encoder operations
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
 <20260629-msm-dp-mst-v5-23-2ed6aee1867a@oss.qualcomm.com>
 <z3eqtcsn43bjlnyqarrclyuukg54wzl2pmtd4sosr6ske4scqq@vrdyrare46hr>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <z3eqtcsn43bjlnyqarrclyuukg54wzl2pmtd4sosr6ske4scqq@vrdyrare46hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HoHXOgHUm72X-7m-Hw68JLCivqt8l32_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX1qJMf2Bo1yaN
 VZwr7Yowfu5rzotevCsjfAjJCh1PPp3H7xIzN79j9DLzz2czL60DaF+zPizBJeC4mTmL2YWFtaO
 loPVOiTxd/vTP7neYepmDd0pSLTW5qqFl3MOxl9yAbXZUlsjlnhW8vG+3ybLEtQERXRjfDfl9Q2
 yebsE55J5srGqZoA6xBovP7HTqzphPVzjyjv9ZwD+yiWO1tRQS0A8KzV35TPwNI/BjIi8Snebi/
 xFd91fPUoFXORxYs9V9L3EeZRG9awCRKdVZXZRWyOZqOt1J1P/qQUmf8wfy7GbYvAyM7JaG/6ZR
 NBeguuTxmhknQpM/BYQcDDX4kdRxzbllgAyFm8WmCR3JnJ4yPvBAsC3VbZLzHjgrRarKBb8RaGA
 vqIE8PE9djHk7i3eSTgMDnMqRpFF24N7YlP0qTKqVYYbsLcWJ8UJpJ5QZcrIyjGzqQc6NvE5QQd
 ucKhaSDbGnJSp1JAjRg==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8e9a7f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QDH60ZEL_tEWVS7y0fAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HoHXOgHUm72X-7m-Hw68JLCivqt8l32_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX8utQfz8PXI6Z
 v1r9QERz9auZc8d5pXv04b5mmLTLUwKU22swQO8Y7QqBnJY1dHhF1INy7g3AIUNj0Ub7Njgl1Ig
 ZhNoOHaLPcPw3W379fbtnD8LAlskQZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
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



On 7/13/2026 8:40 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:44PM +0800, Yongxing Mou wrote:
>> drm/msm/dp: introduce dp_mst_drm for MST stream management
> 
> duplicate subject?
> 
>>
>> Add a dp_mst_drm layer to manage DP MST streams with a clear ownership
>> model between encoder, panel and connector.
>>
>> Each MST stream is represented by a dedicated drm_encoder. At modeset
>> initialization time, one (encoder, dp_panel) pair is created per
>> stream_id and remains fixed for the lifetime of the driver. The
>> dp_panel thus carries a stable stream context, including stream_id
>> and pixel mapping.
>>
>> MST connectors are created and destroyed dynamically on hotplug and
>> are attached to a dp_panel through atomic routing. During an atomic
>> commit, connectors are associated with encoders via
>> atomic_best_encoder(), forming a temporary binding for the duration
>> of the commit.
> 
> This doesnt't seem to be true any longer.
> 
Got it. will modify commit message next version.
>>
>> Encoder helper callbacks drive the MST stream lifecycle, including
>> timeslot allocation, link enable/disable and payload programming.
>>
>> A per-MST-instance lock serializes operations on shared link state
>> across multiple streams.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   6 +
>>   drivers/gpu/drm/msm/dp/dp_display.c     |   9 ++
>>   drivers/gpu/drm/msm/dp/dp_display.h     |   2 +
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 245 ++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/msm_drv.h           |   7 +
>>   5 files changed, 269 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index b32ecd5b0777..ac5dc844fead 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -696,6 +696,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   					DPU_ERROR("encoder init failed for dp mst display\n");
>>   					return PTR_ERR(encoder);
>>   				}
>> +
>> +				rc = msm_dp_mst_attach_encoder(priv->kms->dp[i], encoder);
>> +				if (rc) {
>> +					DPU_ERROR("dp_mst attach_encoder failed, rc = %d\n", rc);
>> +					return rc;
>> +				}
> 
> Reoder, this should be a part of the patch, adding the encoder.
> 
Got it.
>>   			}
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index fc9c1e3e57ab..6eac390af2e0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -601,6 +601,15 @@ struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
>>   	return dp_panel;
>>   }
>>   
>> +void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
>> +				  struct msm_dp_link_info *dst)
>> +{
>> +	struct msm_dp_display_private *dp =
>> +		container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +
>> +	memcpy(dst, &dp->panel->link_info, sizeof(*dst));
>> +}
>> +
>>   static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
>>   {
>>   	msm_dp_audio_put(dp->audio);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index a185819ec57e..fb6bdd372b52 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -63,4 +63,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
>>   
>>   struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
>>   					      enum msm_dp_stream_id stream_id);
>> +void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
>> +				  struct msm_dp_link_info *dst);
>>   #endif /* _DP_DISPLAY_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> index 78b8dffe111b..6a77fdef85e9 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> @@ -4,18 +4,259 @@
>>    */
>>   
>>   #include <drm/drm_edid.h>
>> +#include <drm/drm_fixed.h>
>> +#include <drm/drm_atomic_helper.h>
>>   #include <drm/display/drm_dp_mst_helper.h>
>>   
>>   #include "dp_mst_drm.h"
>>   #include "dp_panel.h"
>> +#include "dpu_encoder.h"
>> +
>> +#define to_dp_mst_connector(x) \
>> +		container_of((x), struct msm_dp_mst_connector, connector)
>> +
>> +struct msm_dp_mst_encoder {
>> +	struct drm_encoder *enc;
>> +	int stream_id;
>> +	struct msm_dp_panel *dp_panel;
>> +};
>> +
>> +struct msm_dp_mst_connector {
>> +	struct drm_connector connector;
>> +	struct drm_dp_mst_port *mst_port;
>> +	struct msm_dp_mst *dp_mst;
>> +};
>> +
> 
> Extra empty line.
> 
>>   
>>   struct msm_dp_mst {
>>   	struct drm_dp_mst_topology_mgr mst_mgr;
>> +	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
>>   	struct msm_dp *msm_dp;
>>   	struct drm_dp_aux *dp_aux;
>>   	u32 max_streams;
>> +	struct mutex mst_lock;
>> +	struct msm_dp_link_info link_info;
>>   };
>>   
>> +static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
>> +							  struct drm_encoder *enc)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < mst->max_streams; i++) {
>> +		if (mst->mst_encoders[i].enc == enc)
>> +			return mst->mst_encoders[i].dp_panel;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
>> +					struct msm_dp_panel *panel,
>> +					struct drm_dp_mst_atomic_payload *payload)
>> +{
>> +	if (payload->vc_start_slot < 0)
>> +		msm_dp_display_set_stream_info(mst->msm_dp, panel, 1, 0, 0);
>> +	else
>> +		msm_dp_display_set_stream_info(mst->msm_dp, panel,
>> +					       payload->vc_start_slot,
>> +					       payload->time_slots, payload->pbn);
> 
> Can you pass payload as is? Then you don't need a wrapping function.
> 
Yes, we can directly use this.
>> +
>> +	drm_dbg_kms(mst->msm_dp->drm_dev,
>> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
>> +		    panel->stream_id, payload->vc_start_slot,
>> +		    payload->time_slots, payload->pbn);
>> +}
>> +
>> +static void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
>> +				     struct drm_atomic_commit *state)
>> +{
>> +	struct drm_connector *connector =
>> +		drm_atomic_get_new_connector_for_encoder(state, encoder);
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct msm_dp *dp_display = mst->msm_dp;
>> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
>> +	struct drm_dp_mst_port *port = mst_conn->mst_port;
>> +	struct drm_dp_mst_topology_state *mst_state =
>> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
>> +	struct drm_dp_mst_atomic_payload *payload =
>> +		drm_atomic_get_mst_payload_state(mst_state, port);
>> +	int rc;
>> +
>> +	panel->connector = connector;
> 
> The connector should be _get before assigning.
> 
Got it.
>> +
>> +	guard(mutex)(&mst->mst_lock);
>> +
>> +	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
>> +	if (rc) {
>> +		drm_err(dp_display->drm_dev,
>> +			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = msm_dp_display_prepare_link(dp_display);
>> +	if (rc) {
>> +		drm_err(dp_display->drm_dev,
>> +			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
>> +		msm_dp_display_unprepare(dp_display);
>> +		goto out;
>> +	}
>> +
>> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
>> +
>> +	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
>> +	if (rc) {
>> +		drm_err(dp_display->drm_dev,
>> +			"[MST] payload allocation failure for conn:%d\n", connector->base.id);
>> +		msm_dp_display_unprepare(dp_display);
>> +		goto out;
>> +	}
>> +
>> +	msm_dp_mst_update_timeslots(mst, panel, payload);
>> +
>> +	msm_dp_display_enable_helper(dp_display, panel);
>> +
>> +	drm_dp_check_act_status(&mst->mst_mgr);
>> +
>> +	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
>> +
>> +out:
>> +	drm_connector_get(connector);
>> +}
>> +
>> +static void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
>> +				      struct drm_atomic_commit *state)
>> +{
>> +	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
>> +	struct drm_dp_mst_topology_state *old_mst_state =
>> +		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
>> +	struct drm_dp_mst_topology_state *new_mst_state =
>> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
>> +	struct drm_dp_mst_atomic_payload *old_payload =
>> +		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
>> +	struct drm_dp_mst_atomic_payload *new_payload =
>> +		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
>> +
>> +	guard(mutex)(&mst->mst_lock);
>> +
>> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
>> +
>> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
>> +
>> +	msm_dp_mst_update_timeslots(mst, panel, new_payload);
>> +
>> +	msm_dp_display_disable_helper(mst->msm_dp, panel);
>> +
>> +	drm_dp_check_act_status(&mst->mst_mgr);
>> +}
>> +
>> +static void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
>> +					   struct drm_atomic_commit *state)
>> +{
>> +	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
>> +
>> +	guard(mutex)(&mst->mst_lock);
>> +
>> +	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
>> +
>> +	if (!mst->msm_dp->mst_active)
>> +		msm_dp_display_unprepare(mst->msm_dp);
>> +
>> +	panel->connector = NULL;
>> +
>> +	drm_connector_put(connector);
>> +}
>> +
>> +static int msm_dp_mst_enc_atomic_check(struct drm_encoder *enc,
>> +				       struct drm_crtc_state *crtc_state,
>> +				       struct drm_connector_state *conn_state)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct drm_dp_mst_topology_state *mst_state;
>> +	int bpp, pbn, slots;
>> +
>> +	if (!conn_state->crtc)
>> +		return 0;
>> +
>> +	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
>> +		return 0;
>> +
>> +	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
>> +	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
>> +
>> +	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
>> +	if (IS_ERR(mst_state))
>> +		return PTR_ERR(mst_state);
>> +
>> +	if (!dfixed_trunc(mst_state->pbn_div)) {
>> +		mst_state->pbn_div =
>> +			drm_dp_get_vc_payload_bw(mst->link_info.rate,
>> +						 mst->link_info.num_lanes);
>> +	}
>> +
>> +	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
>> +					      mst_conn->mst_port, pbn);
>> +	if (slots < 0)
>> +		return slots;
>> +
>> +	return 0;
>> +}
>> +
>> +static void msm_dp_mst_enc_atomic_enable(struct drm_encoder *enc,
>> +					 struct drm_atomic_commit *state)
>> +{
>> +	msm_dp_mst_stream_enable(enc, state);
>> +	dpu_encoder_phys_enable(enc, state);
> 
> Looking at this, no, squashing the bridge and the encoder was not a good
> idea, excuse me. The encoder is an internal implement of the DPU layer
> and we should leave it there as is. DPU can use DP functions, but not
> other way around.
> 
We could also invoke it from dpu_encoder.c, similar to how the MST 
encoder helper functions are handled:
static const struct drm_encoder_helper_funcs 
dpu_mst_encoder_helper_funcs = {
	.atomic_check    = dpu_encoder_mst_atomic_check,
	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
	.atomic_enable   = dpu_encoder_mst_atomic_enable,
	.atomic_disable  = dpu_encoder_mst_atomic_disable,
};
......
	if (drm_enc_mode == DRM_MODE_ENCODER_DPMST)
		drm_encoder_helper_add(&dpu_enc->base, &dpu_mst_encoder_helper_funcs);
..。。。。。
This looks much better.
>> +}
>> +
>> +static void msm_dp_mst_enc_atomic_disable(struct drm_encoder *enc,
>> +					  struct drm_atomic_commit *state)
>> +{
>> +	msm_dp_mst_stream_disable(enc, state);
>> +	dpu_encoder_phys_disable(enc, state);
>> +	msm_dp_mst_stream_post_disable(enc, state);
>> +}
>> +
>> +static const struct drm_encoder_helper_funcs msm_dp_mst_encoder_helper_funcs = {
>> +	.atomic_check    = msm_dp_mst_enc_atomic_check,
>> +	.atomic_mode_set = dpu_encoder_atomic_mode_set,
>> +	.atomic_enable   = msm_dp_mst_enc_atomic_enable,
>> +	.atomic_disable  = msm_dp_mst_enc_atomic_disable,
>> +};
>> +
>> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
>> +{
>> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>> +	struct msm_dp_panel *dp_panel;
>> +	int i;
>> +
>> +	for (i = 0; i < mst->max_streams; i++) {
>> +		if (!mst->mst_encoders[i].enc)
>> +			break;
>> +	}
>> +
>> +	dp_panel = msm_dp_display_get_panel(dp_display, i);
>> +	if (!dp_panel) {
>> +		drm_err(dp_display->drm_dev,
>> +			"[MST] failed to allocate panel for stream %d\n", i);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	mst->mst_encoders[i].enc = encoder;
>> +	mst->mst_encoders[i].stream_id = i;
>> +	mst->mst_encoders[i].dp_panel = dp_panel;
>> +	drm_encoder_helper_add(encoder, &msm_dp_mst_encoder_helper_funcs);
>> +
>> +	return 0;
>> +}
>> +
>>   int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>>   {
>>   	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>> @@ -27,6 +268,9 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>>   			"[MST] failed to set topology mgr state to %d rc:%d\n", state, rc);
>>   	}
>>   
>> +	if (state)
> 
> Why?
> 
At the moment, link_info is maintained in the SST panel. After link 
training is completed, we need to propagate a copy of it to the MST context.
>> +		msm_dp_display_set_link_info(dp_display, &mst->link_info);
>> +
>>   	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
>>   	return rc;
>>   }
>> @@ -55,6 +299,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
>>   		return ret;
>>   	}
>>   
>> +	mutex_init(&mst->mst_lock);
>>   	dp_display->msm_dp_mst = mst;
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index f71200a790f3..854dd08eede2 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -358,6 +358,8 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>>   bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>>   int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
>>   int msm_dp_mst_register(struct msm_dp *dp_display);
>> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder);
>> +
>>   #else
>>   static inline int __init msm_dp_register(void)
>>   {
>> @@ -384,6 +386,11 @@ static inline int msm_dp_mst_register(struct msm_dp *dp_display)
>>   	return -EINVAL;
>>   }
>>   
>> +static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>>   static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>>   {
>>   }
>>
>> -- 
>> 2.43.0
>>
> 

