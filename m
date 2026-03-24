Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ADBF54AAC
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1006A10E54F;
	Tue, 24 Mar 2026 13:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PzzQ/VjJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EdECc/2z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A6A10E13D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:04:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCqlmt127807
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ih9VTv83QqyTp0YZh+OZkzFBW3xGR+7UkInLLJl+QN0=; b=PzzQ/VjJI+CsrFld
 sCQVJ2z0SrwnyWtz63sC1Gq0UQR3aIxbQsS16N5N95Ib2FQyvf6togKuGckPxVHN
 PPBGvN0WhYsJDUuTCKk8tnmdhDycrwN0FFnAYW0BvcsHzcGP1KcT1+qJg3Q5+KDM
 eWwAZBC9N5og5MZbp/1L9tR7qnwPsEHGsTwaPXCeSFutdoNLReIm9oLYaUuWnR0T
 W5N4VlJlynGkV5w2gaNgg3btE2UvX/l51wYKM+Ht9+iOBVco5ok+QJMTQ45XodOf
 oZgXPEHUfwXc2U5PCv17f0WPSmokIVySI4XPDZEDtVv1xN+2UIvkDk6fC62kMxDG
 6n6iwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m017f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:04:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad5fec175so27700035ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774357472; x=1774962272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ih9VTv83QqyTp0YZh+OZkzFBW3xGR+7UkInLLJl+QN0=;
 b=EdECc/2zjwsevgjbkrZKqgcC7CKNaeQEzzt1DxfGjHSN0/H9RrcFZs4i7bg3TA4BIo
 F6pn0OQSv15Vro3XXGDqkZDnG4FUpNz4tblYHlgH2Oy2ElVP161F4UA1XuEj+s2gUeij
 1sNGr2qxraASgG7ust6wFK3Oxr/MbiT1eWBXqYO6lZ7kA2pMnvHdRmGodr0TnBTTefSm
 3l8cNJCATT9hu2Mcum4voAEFz3UOxK4U/J/ZylimR+vrvhGnLGp+hCUiVVva5F5Ui47g
 5QlDWIH5aC3cgVWspa7hKb+90loHurT9i2cB9JsK5kn0EYUGiLSSwb5bxCQjlzhkocsX
 5fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357472; x=1774962272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ih9VTv83QqyTp0YZh+OZkzFBW3xGR+7UkInLLJl+QN0=;
 b=m3PcjGXZ0qQ10VcfnKKYNScgNAcwxBTcvrHsPlu0xE5cq+JgC6as8RWBw80Q+SB4ub
 wvOGVUFSheA4pb+8y6p6CGLG8xaW+8O8gTjQxlsRQd0HKuHa2iAqQ560E2eQkG1ADYto
 BDSttDhwpUxtpgR/A1mA8aPya7N9/YA35az0fNYTxJ1F8123VTrS8Z8aRTQsMxKQzUpP
 foDLZBZMWJZlaFsB71mU6FMPMBkLUsg/7lvg/SMXff+97ub7JXlmwubhBcfxNpBz3lj/
 mvwCtn3IuIXrgPSv9JlCQU8UDuuKipke3s9Jj/hmxg6H2emRjuMvOF1y4kY8sjfp86DP
 +PJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO8gX3M7XSjKx8p9+k7QrCDB0bCaVX7K7OmwJVyCO3ctoD2LAgKCiks3/ENVAhGNQVGMQFkwJqeKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynSND0VmSVYlIDLI0sijH4ADb1tGrE7KQJiWw4syA2HFU69UvE
 9UmbsdCyHpuN9pZgcenb9heNIdGjvOaDJzqUI6BliRquSjnK7xYU+HaSFU3CnsWMylXH7ugRzvs
 gg7uB2K/fZCPzfMupeb37ABY7EfMHnLSqPYY/1ovq6YDVgtCXzI1KgtSFfvwHC39vGfhX390=
X-Gm-Gg: ATEYQzwUOz8ewEvF57X2fDaJkjgn5efhRba/r0Zqghh595H12THOOs2CbSS1fmS+Keu
 g14cvU+vU2lz53mOTPCVnel/YzzjTd4xvWuP7Z8cXrieqFNAIljJ51mlBa8ed83uYxyN2ASr6/G
 QKIP9hTMXVpdH5rnQk2ehH/JwgJ9yLFn7otz3T2FsIgB2qSOmsnoGZc+Lx5hRnuUEOx8ldkkQrU
 Idyo6b2qOBUgG1HQpkrMan61fAA4vZl+gv9Qlx4CkszoOqCoRj5YS+VngUR8AyesE30MjVK7ls1
 ZmfZ3iccemwnjS2jVCzNLnE3JvrMJVOZrFuVoX+KkDhKT0uE9WLn+xkBgB5r6l4XGrXfkSLs358
 raElA872TOtaGCMnF4ai4fHzvMq8X1rM1NyvfEfevKgWHVLCcX2RcnRQhHsWsuzH9bIs3Q4DekW
 xaiMDD44klId57Ws/VVg==
X-Received: by 2002:a17:903:2284:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b082797411mr162229235ad.24.1774357472018; 
 Tue, 24 Mar 2026 06:04:32 -0700 (PDT)
X-Received: by 2002:a17:903:2284:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b082797411mr162228805ad.24.1774357471373; 
 Tue, 24 Mar 2026 06:04:31 -0700 (PDT)
Received: from [10.133.33.127] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0835298acsm151917955ad.22.2026.03.24.06.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 06:04:30 -0700 (PDT)
Message-ID: <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 21:04:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] drm/msm/dp: add HPD callback for dp MST
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
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c28be0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=wlarEYM4F4ymYTEdJbgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZlGRJ0vRQf3wlJjMoEAVvyNzkk5ROfbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwMyBTYWx0ZWRfX3nMJmI0/L/iY
 b1ptVcbPl3gV8k2HGdyf6WIZjrdSHjLstfsKgSi+IACE378AQdU3kOHERrsbzGv60KOHAXCbGAt
 0Dmeuh4BAAGpFymzuXID/jP9nIPXPj62i3QOK3/uoYhZVFA0rtDdX3dqMIhfl82xVgbPptff1wt
 TsWSm4H2q0hu6ODi0hx/Su94+WpBeAsL8yA9xaeWmH6lnBTomaTU7K0cDHtSg51TFD9+wz85Uup
 ITBPgUiFvCjnPh3mhGm+qvQlWbXqVXL2JAere0zro6oy7ArNViGRxaHELrei0X1K0j8eP22sJws
 ZhhTLNDZZ2Iq8JNCXmlZxC8YDRV/G9uqnOvYD5bZSzmXRuCbgrbi58/tYWy9ojqIameBlqsYwf+
 0CKwnG0GgtZMg99As4FhNyv6zD9TaZncrWx5ejiPKjBXovW90vdOEbeIOMSmyw9YnvxU91CzczO
 uPAN3xv9hFqv2IiX0bQ==
X-Proofpoint-GUID: ZlGRJ0vRQf3wlJjMoEAVvyNzkk5ROfbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240103
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



On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add HPD callback for the MST module which shall be invoked from the
>> dp_display's HPD handler to perform MST specific operations in case
>> of HPD. In MST case, route the HPD messages to MST module.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>>   3 files changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>   
>>   static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>>   {
>> -	int rc = 0;
>> -	u32 sink_request;
>>   	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>> +	u32 sink_request;
>> +	int rc = 0;
>> +
>> +	if (msm_dp_display->mst_active) {
>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>> +		return 0;
>> +	}
>>   
>>   	/* check for any test request issued by sink */
>>   	rc = msm_dp_link_process_request(dp->link);
>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>   	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
>>   		msm_dp_display_send_hpd_notification(dp, false);
>>   
>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>   		msm_dp_display_send_hpd_notification(dp, true);
>> +		msm_dp_irq_hpd_handle(dp, 0);
> 
> Why is it a part of this patch?? It has nothing to do with MST.
> 
Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
I tried an alternative approach by calling the MST IRQ handler from 
msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status == 
DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in 
msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, 
we could handle both SST and MST interrupt paths in 
msm_dp_irq_hpd_handle(). However, hpd_link_status only reports 
ISR_CONNECTED. So I had to move the MST IRQ handling into the IRQ 
thread. Do you have any suggestions on this?
>> +	}
>>   
>>   	ret = IRQ_HANDLED;
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> index b4f640134af544c77ab262d2cbe0b67e1e2e1b3a..331d08854049d9c74d49aa231f3507539986099e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> @@ -567,6 +567,40 @@ static struct msm_dp_mst_bridge_state *msm_dp_mst_br_priv_state(struct drm_atomi
>>   	return to_msm_dp_mst_bridge_state_priv(obj_state);
>>   }
>>   
>> +/* DP MST HPD IRQ callback */
>> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
>> +{
>> +	int rc;
>> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>> +	u8 ack[8] = {};
>> +	u8 esi[4];
>> +	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
>> +	bool handled;
>> +
>> +	rc = drm_dp_dpcd_read(mst->dp_aux, DP_SINK_COUNT_ESI,
>> +			      esi, 4);
>> +	if (rc != 4) {
>> +		DRM_ERROR("dpcd sink status read failed, rlen=%d\n", rc);
> 
> It's DPCD, not dpcd.
> 
Will fix it.
>> +		return;
>> +	}
>> +
>> +	drm_dbg_dp(dp_display->drm_dev, "mst irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
>> +		   esi[1], esi[2], esi[3]);
>> +
>> +	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
>> +
>> +	/* ack the request */
>> +	if (handled) {
>> +		rc = drm_dp_dpcd_writeb(mst->dp_aux, esi_res, ack[1]);
>> +
>> +		if (rc != 1)
> 
> No empty space, drm_dp_dpcd_write_byte().
> 
Got it.
>> +			DRM_ERROR("dpcd esi_res failed. rc=%d\n", rc);
>> +
>> +		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
>> +	}
>> +	drm_dbg_dp(dp_display->drm_dev, "mst display hpd_irq handled:%d rc:%d\n", handled, rc);
>> +}
>> +
>>   /* DP MST Connector OPs */
>>   static int
>>   msm_dp_mst_connector_detect(struct drm_connector *connector,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> index 1484fabd92ad0075eac5369aac8ca462acbd3eda..5e1b4db8aea4506b0e1cc1cc68980dd617d3f72a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> @@ -86,4 +86,6 @@ int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
>>   
>>   int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>>   
>> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
>> +
>>   #endif /* _DP_MST_DRM_H_ */
>>
>> -- 
>> 2.34.1
>>
> 

