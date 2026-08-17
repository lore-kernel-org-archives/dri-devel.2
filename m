Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB58C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B3910E6B0;
	Mon, 17 Aug 2026 08:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZR9HJbvs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0qFVZNB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A469310E6BE
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H7F8671636839
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdLyylUE5b6H5mJfPKhLhaC/fcZHtchZG+7kuZxWmc8=; b=ZR9HJbvsksB9XvRq
 sULsFfHCIYHSf//AXumseNMzuTQqbikY5wNz6yzatHNjcUOy3BRxNau0ieE+mGJi
 lLHC9ybmLvaWQfSuou4l67Tm6vi2uOMveMp+8ri6PeSsdejVej6QmgVHYMZkdzUz
 jyQVARS6hbm3gNmba0iSUa+VRsHSzDVJppn1ebxSU/BTmAfX4+QWW6f5qXqQ21B7
 VvSofF0vBBXwSQG2GHg22qmtxVL1dhseRqTvTUrNLZrgGXuBio668Dl/1tRgVFSf
 kuiNYfBLgVfzwQq+jEgTIVYMxYbUihu57vnqpl+OQkzkFl6uHJwF2ZgAik1P6qZi
 ftb6hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wreg5qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so29533481cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786953743; x=1787558543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rdLyylUE5b6H5mJfPKhLhaC/fcZHtchZG+7kuZxWmc8=;
 b=V0qFVZNBJ3oNVM7IS8fvcYoik97o+GERoKDpKjgh26rfpIEachpkL9CvJuJBD5d7kE
 zmZWy3u9SZfErjGfhv1WwxADEW+XBZhKEGXNJq435h+uo7Otr0p+4NIhROGqXh5L9nb9
 Ye8NvEH3ksNuug6Tz7pRYDkDfQ3ZMQ7YISt5/ZVECgOTYVLlxY2OWNxi0Bt0LqyaaHT2
 km5R+2vbnRDuJ9U8pB0NJnDeezfQu6lVgPpUJIGT550JlhwiljR7fjdGeVf77znGhuux
 u9BG1o2vY+UjI7yrN3ROEriW9ufiEREKh8XYzEVc/u4zdzsKMu6fJ6a2sGlzy1xve3gm
 994A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953743; x=1787558543;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdLyylUE5b6H5mJfPKhLhaC/fcZHtchZG+7kuZxWmc8=;
 b=VUcRSw7rVZYvphZsgsQS63ClD6su/nIpc9irSoPo048XWjy1k2Gl/qFzZT765ZhEsA
 pES8fW/gwSVKvdL0Z8Byb77XT14klbng1nSkt6cJFk+zJSf5STMv9rRIf/tv3LxLk+lA
 6IvuB2IOBRWe0uCySx1OJ4gFKhc+zIou/CYoNvGYZXBqUQz2i6WE8KOU1DZdTF1Jgl5I
 /rPHVPjMCNVmyrO3p103wMGjwILDn/ECn/R1pDwk0DUG02Rrt9d1xOAfd2e6+6RMYKIj
 HXTz+O1e6rfJcAf0HeTGNGpdrELGDwlxNRgE4/i8zuSIhadfAAjPiPFgCcxhv0dCLvxG
 rPsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpZh1oQmC7kurYqT1nheYq/QzYunRU3GRS6YIM24eUQUtHWCYxHzmVuZWhR0nCEg2K949How0G/Eo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2symOhcLI+7P+bVNfcowOTQrOU9a2aTYW6k1mez1ApEkGZdkr
 TDULDCk+3puKfjHxhRFCOUrJCdQEbWZ+QWtGApoQeH0TKQ6u1JfBAvjVB2ABufkcNo4ehCjlV+D
 56mxrC2o+6pnxR3dp4xFw2gE6rvBWTICfbWRMo7ak7Tpk6uRS68vYHMYvoefvxBvUfE2dbfI=
X-Gm-Gg: AR+sD12oRYn4CAewv2iCLOIjIXlUxuyRWshoPVxcNzGT5mqhO/Lwbn4gynhy88CKrrZ
 w19MurpItS36mJTXUVchPq0xkloTHp0mPxI2KafTcJbXl1p1dQq9xpjG0yXaWuhwUYb/EK+T43d
 +WigCIFexWq8ZY8wh48xRb7ieQ14kSmUveqdM5zwS/4hcOuNoxIJij0lIjN0o2AsgMQCskmIy2A
 SukGenAPa0U++A4JlhQoAO4MRKa3WxTSOg1a50wjb6tV4l7TO3/c2XRW4SewKHZfw5I6CVsUqzV
 /z1LP8wyKYqdZkl1pKY0qh2i5kBLpbi24YCLu9u2dR20ImPiE1cHrZz308Av8mDQFL4NRBUX1l7
 by+MIMEoCNwWuTmwiW+eSzZwv+sodWuubksOe0h5ImQAQZfrm30c/+o1tq7P7E3YdPg==
X-Received: by 2002:a05:622a:614:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52d855839d9mr232646131cf.40.1786953743085; 
 Mon, 17 Aug 2026 01:02:23 -0700 (PDT)
X-Received: by 2002:a05:622a:614:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52d855839d9mr232645661cf.40.1786953742432; 
 Mon, 17 Aug 2026 01:02:22 -0700 (PDT)
Received: from [10.111.162.109] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db610b491sm8343721cf.8.2026.08.17.01.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:02:21 -0700 (PDT)
Message-ID: <2351cc75-ccf8-4ff0-a558-c29ccd2b86b9@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/msm/dp: report IRQ_HPD as an IRQ-only notification
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-4-646a10256233@oss.qualcomm.com>
 <zmnftag6s6mxvnoqdzouhpdcbwscm6sfzrqkzgwrcptgbr53cx@jetw2gtov7qp>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <zmnftag6s6mxvnoqdzouhpdcbwscm6sfzrqkzgwrcptgbr53cx@jetw2gtov7qp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a82c00f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=tg9PfV-btg9rSNVD8o8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: HEFvQhw-Qr1lkT6OcXlZeBdlPYjrWweD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX6nLoFTPRcFiR
 7wypJcg5B4/0YX1rOluVbbUIYDo+Pv68zg8NqEpUnMTVRIpnvfOuEqDj0jkgRCAYdrWrtPlMLnF
 KflvsTd+UARVqMr0g5B5Kn5MOSuVskitG4EvTQ116+zs2R5ejViopVNpcrd2jKssxRZW/u+xj6e
 nLmLULKDDjqKAXkgk8x0+RCnX60gWNRZ+YxSx2gt7WyzOQBpyKgaOc5zEoLBHYaqAIT4im0P8Y6
 H6O/JM8aG62M6+3b4lRSza4QsIJLFfrmtFXB2glrGiHR0EvAATWJWaUREd6JJW0ks/pVVUdGbn9
 ZHzsKHBryFgWNJD4/UfJy1ontzMQQLW9omtMFm7gONUJQ5oRDCawM44z5sGpjzqxoVtQaH3G4ZZ
 3e2vBqh79n6mQxPsw/I5klW3UA6F7555ycSPyO5J1p4E4jvYa9oenqAUXJ5M30mXq0dV2WUNEB9
 ZqbN2V/GAuS43qT/cGA==
X-Proofpoint-GUID: HEFvQhw-Qr1lkT6OcXlZeBdlPYjrWweD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX4IZpXVUYqomK
 FMDwuIXslf4UVk4g0ha2I1l9c/6XGwPxt6CZZHvNiwSl3mZt80cQomufwRXNbk4NdcnqZ22r2c7
 YDk2tUODoPP8p7hLMHc95dZRfYrS6yM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 7/12/2026 6:55 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:48:06PM +0800, Yongxing Mou wrote:
>> MST reuses the SST connector bridge to propagate HPD IRQ events through
>> the bridge chain.
>>
>> For IRQ_HPD notifications there is no connector state transition to
>> report. Use connector_status_unknown together with
>> DRM_CONNECTOR_DP_IRQ_HPD so that the bridge connector framework treats
>> them as IRQ-only notifications and forwards them without modifying
>> connector state.
>>
>> The DP driver handles IRQ_HPD events based on
>> DRM_CONNECTOR_DP_IRQ_HPD rather than connector status transitions.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c   | 22 +++++++++-------------
>>   drivers/soc/qcom/pmic_glink_altmode.c | 14 +++++++++-----
> 
> And which tree (and why) would be able to merge this patch?
> 
Emm , I will split the patch and reorganize it.
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index bc93b566fbca..4ee391cc7165 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1119,14 +1119,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>   		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>>   				      connector_status_connected);
>>   
>> -	/* Send HPD as connected and distinguish it in the notifier */
>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>> -		if (dp->msm_dp_display.mst_active)
>> -			msm_dp_irq_hpd_handle(dp);
>> -		else
>> -			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>> -					      connector_status_connected);
>> -	}
>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>> +		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
>> +					    connector_status_unknown,
> 
> It's _not_ unknown.
> 
Same as my reply to 2/5 -- the status is indeed not unknown here, and
using connector_status_unknown as a sentinel in v1 is not appropriate.
I will fix this in v2 along the direction discussed on 2/5.
>> +					    DRM_CONNECTOR_DP_IRQ_HPD);
> 
> This should be fixed in the MST patchset. You should not be doing any
> actual handling in the ISR routing.
> 
>>   
>>   	ret = IRQ_HANDLED;
>>   
>> @@ -1781,11 +1777,11 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>   	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, status=%d\n",
>>   		   msm_dp_display->connector_type, hpd_link_status, status);
>>   
>> -	if (status == connector_status_connected) {
>> -		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
>> -		    extra_status == DRM_CONNECTOR_DP_IRQ_HPD) {
>> -			msm_dp_irq_hpd_handle(dp);
>> -		} else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
>> +	if (extra_status == DRM_CONNECTOR_DP_IRQ_HPD ||
>> +	    hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) {
>> +		msm_dp_irq_hpd_handle(dp);
> 
> ANd here you missed the case when IRQ_HPD is being reported together
> with the first HPD event.
> 
Yes, will fix it next patchset.
>> +	} else if (status == connector_status_connected) {
>> +		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
>>   			msm_dp_hpd_unplug_handle(dp);
>>   			msm_dp_hpd_plug_handle(dp);
>>   		} else {
>> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
>> index 946eb20b8f83..28ab8cbb5ef9 100644
>> --- a/drivers/soc/qcom/pmic_glink_altmode.c
>> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
>> @@ -373,11 +373,15 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
>>   		else
>>   			conn_status = connector_status_disconnected;
>>   
>> -		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
>> -						conn_status,
>> -						alt_port->hpd_irq ?
>> -						DRM_CONNECTOR_DP_IRQ_HPD :
>> -						DRM_CONNECTOR_NO_EXTRA_STATUS);
>> +		if (alt_port->hpd_irq) {
>> +			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
>> +							connector_status_unknown,
> 
> And this is completely wrong. The AltMode driver (btw, you also missed
> the normal altmode driver for DP) doesn't know if it should handle the
> events in some way. It should report the HPD and IRQ_HPD as is.
> 
Will fix it next patchset .
>> +							DRM_CONNECTOR_DP_IRQ_HPD);
>> +		} else {
>> +			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
>> +							conn_status,
>> +							DRM_CONNECTOR_NO_EXTRA_STATUS);
>> +		}
>>   	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
>>   		if (alt_port->svid == USB_TYPEC_TBT_SID)
>>   			pmic_glink_altmode_enable_tbt(altmode, alt_port);
>>
>> -- 
>> 2.43.0
>>
> 

