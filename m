Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32983ED7B93
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9281110E2A2;
	Tue, 14 Apr 2026 09:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nw4JxSAB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkQ7U3Vc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D5810E5BE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:51:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6teD93681505
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HWChOupg+vdURK7dSsm/hBK2/Y/ha3fMXKiVhsxo7RE=; b=nw4JxSAB+NuLLXc3
 o9eOyVq2tF3RtFloo2HVbRw2HcgLJ7YYbUOgP1fFfY2tzfnlla1SaGqtutP+3KIE
 HqildVx+6zdcomNkiRfQZjBBvj5J8yU1sQAsKAxs5/JcIgPXKUGFM8NGsxVtoa0g
 TdWN9t4JA66fXchKPdVeigBAhjhFC0QVcOzuFtp8B1B9ckBZNsVLHcZDMg3LQsM9
 z4BZ2Pa3hzHGQ/Yuvn/1HG7XR56hBUbksxTQ4kT8vtwye+SYxGyc4yb5AbJGXK6m
 OpXqqfItSmFn47wq3XmBY1E8SxhcK3U+CPdBKE90mv4xb6PHFdIBD1DSwcoPOAEt
 mVyRsQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d25u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:51:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c7a84a43eso6501108b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776160317; x=1776765117;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HWChOupg+vdURK7dSsm/hBK2/Y/ha3fMXKiVhsxo7RE=;
 b=HkQ7U3VcPJ+U5xJT8p3bRqYgG6SrbielMY8DuGVZjIGS8xf8Rxhk/PExwlsRGffsEw
 9h5x2CHgkKFAXG8rhBO7sS7tH+lkiIwNyog7Xl4IayRtqoi6uMm7BL7WxwR65N5H+fFL
 LvDVPO0D1ivyOUGvh1wDKtI71teGPlGSSkbq4h1HsHop5aX3lENX/thHvXdcSCJEtKNF
 EtWkVYxVKnFs4bAnmLDXnQeTWp9sSlZKMxyRSGR4X260ZOJgzz0lEjyj3UoqisUSORiy
 Y3wC/EF5V9zJ7aPnwgcYKLv2xq/+/iuEpOaFz+AXpdu4wh2Gny4XrXbZDoKcE0beKV7H
 jIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776160317; x=1776765117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWChOupg+vdURK7dSsm/hBK2/Y/ha3fMXKiVhsxo7RE=;
 b=EKQnwctUrzarEY38wP2OFMwmCPbBz+Oe2tHoR8k0eQPCxl0c3yR6NW8hWPjgZZI/LM
 UvYyZi8ifPgTqULPrJB8eXi4+zosY8d5MdiHRBwWjNhZLM1fTPMU4KvSGKGjQ83xUrm7
 KENtAwHk/MO9g/E/0poC9qQShO4lJbl8Bzba0A+4w7+fu5VrujXAtZog2BteHfzrfNcc
 9hifZsy8kRXAAKBkcY9I15vEhRxPmPAt3+xW/rZqoTlvKgIQfMPOQQlQ9uH+l21zqRD7
 MayDBHXKSQr2czgsCLx1fuOOdeUomfCaSn+WUUa2ZNuVR5py2Rz6OXD+XQxithzTrMP+
 k9Zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sKd8XM66w4OcaxX6+E4Au1xhUUrV50cMaPc7GedGnVbf5JU8GmHD1CW24BUPMXxFWwpn+GpmGfAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQYLQjQUmNZYBbuTyXvHiKSw12vSkusuaeRMl+6HjAgjK/u2SS
 mM/ek6BpvTWrejuiBMyfdbpzmLUEgoPYwGKl/b6WG1THGQrxMx3ag1lvOHkkgEatKEXpFzsu356
 Z0icBO7v5cmcl2CzWJjfe8sZ0KOA+ioJwp3jbP9m8rNVg++F87YuLBIJt33ErUzISEkh22SM=
X-Gm-Gg: AeBDieso7z8Y1lHExK0ykGNf13vgb9yrtAPgxmizL45/QPSuxnG5U4L7SZlZrnIEJf8
 1HiyAUDiVrCMB53O0DO3I7oET9m/5OdVSpwBPVlpBoXJZ80ptMZjVwX8qPWArldEWOam2lMVyE6
 Wp/usam3pBycdYOvfVGLONgyZFchE6+Q4yEFN/Uifa5WhxB5rr6Mqzm3ODttsp1DzTt9o32WAY7
 AARZ+Vzz3qD7KbFsi4Ja27CV3liR/J+2NQCr+JxSlXETaSU0a4erIqy2RAmRpxu4kymDLX7mL2m
 OF+X2ZV0KPqXh0VDs02SWnx2lcqC1YgG1UjImxlVKn4yGBmgkGVid3kXZIcS1gvcBsWYcH2M07+
 cfzyMfcvez/qN2GjeJYAw0E9TKOUMKJu+nXSHZ6EYLC9hZj0BYhER9idCqMRKezIzNqiLK6Nl8W
 BO7n/C3HwvEYUxHdpo
X-Received: by 2002:a05:6a00:9508:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-82f50cded65mr3749896b3a.13.1776160317458; 
 Tue, 14 Apr 2026 02:51:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:9508:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-82f50cded65mr3749879b3a.13.1776160317029; 
 Tue, 14 Apr 2026 02:51:57 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c343b16sm13872900b3a.23.2026.04.14.02.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:51:56 -0700 (PDT)
Message-ID: <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 17:51:51 +0800
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
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MiBTYWx0ZWRfXzvL89b+7x4FK
 0KdzdgeRyCjWEYb1fDc7fqgCODAcVJ3hZ7NIV8dZRiTG0eenm9U9m7rdKKlg7Gcrx1AKVdDSWV+
 Vpf77Vw5eO7m+/ncRexUTGUgRpsCHOnKLvr226EU3D10PK+EIhJaewELps3d3WVQ5B28Xx/Wuyx
 P5RHlucUTSeX+QeOMMxtpVCvPXPJ72HmJ7VWgOny1VQX138YfVtdZaxW2wuaHdjPKxJnJjz857N
 Lj9qn2vz9YUjD5L9boGUGFE8nXnZH0FTPrfEjQj3Vuqk5PVReiQBdM6hi61aFmAQ0BI/01R6nol
 9hDDQFQLQc3HjFJhW3eACj41PlTWwRkzBB4GnCxsXvjLOHOm2sgGkFgnRTn7sTrYmcRAPLp+iEG
 i8v+u7fnAQj4nCSIm86uXI970NKFIQfwFocJlGmhRWbiIEeRvqTDsnL4YqjHaZjAfE+Gg8d7Nwf
 yEvLA8c7GuDAwifZU5Q==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de0e3e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rS42QUC6qLDb_W9ZlKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4gAVjhZ4QJ0_lVX7oQdfHBujxfB4NvaE
X-Proofpoint-ORIG-GUID: 4gAVjhZ4QJ0_lVX7oQdfHBujxfB4NvaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140092
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



On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
> On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
>>
>>
>> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Add HPD callback for the MST module which shall be invoked from the
>>>> dp_display's HPD handler to perform MST specific operations in case
>>>> of HPD. In MST case, route the HPD messages to MST module.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
>>>>    drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>>>>    3 files changed, 48 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>>>    static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>>>>    {
>>>> -	int rc = 0;
>>>> -	u32 sink_request;
>>>>    	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>>>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>>> +	u32 sink_request;
>>>> +	int rc = 0;
>>>> +
>>>> +	if (msm_dp_display->mst_active) {
>>>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>>>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>>>> +		return 0;
>>>> +	}
>>>>    	/* check for any test request issued by sink */
>>>>    	rc = msm_dp_link_process_request(dp->link);
>>>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>>>    	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
>>>>    		msm_dp_display_send_hpd_notification(dp, false);
>>>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>>>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>>>    		msm_dp_display_send_hpd_notification(dp, true);
>>>> +		msm_dp_irq_hpd_handle(dp, 0);
>>>
>>> Why is it a part of this patch?? It has nothing to do with MST.
>>>
>> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
>> I tried an alternative approach by calling the MST IRQ handler from
>> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
>> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
>> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
>> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
>> However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
>> MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
> 
> When are the link status bits updated? Please remember, we need to
> support all three cases:
> 
> - Native DP, native DP HPD pin handling
> - Native DP, DP HPD pin not handled by the controller
> - DP AltMode, DP HPD pin not used at all
> 
> In the second and the third cases we will not be getting the IRQs.
> Instead one of the next bridges (connector, EC, AltMode, etc.) will send
> the HPD event, which lands in the .hpd_notify() callback.
> 
I added some logs and did some testing. I think 
msm_dp_aux_is_link_connected() only shows the current HPD state. Since 
IRQ HPD Pulse Count is very short, by the time we read 
REG_DP_DP_HPD_INT_STATUS in the IRQ flow, the HPD state machine has 
usually already finished pulse classification and returned to Connected.

Because of that, the condition hpd_link_status == 
ISR_IRQ_HPD_PULSE_COUNT will usually not be hit.

do you have any suggestion that in how to distinguish between an IRQ 
event and a plug event in .hpd_notify() better? We probably don’t want 
to introduce another state machine.

