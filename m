Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3057CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505F610E4DE;
	Thu, 21 May 2026 12:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LK7jjMjD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SxAkNspd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC5E10E4D5
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:29:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9AL1Y3555969
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M8Xi5z+FCk7PL+V8zhBB5Imo+U7JiUrOw4e7dC2VIrQ=; b=LK7jjMjDcqfftAVi
 DdyZ5JwoTkvnNvM7R0IexhiLZ/Y0u+SzE91W9Ms7IW5kDEJkv9AsIGYbX3Fg/ejA
 q10YVl3MsGKC/s2+UceInp35b3xQ1bMm8BtPgyD56YYkeIPu4HlkBFCd7yLbpR7W
 Ssucl+UqyR3X9lhNtddLz+hiJ0FFapFB2Dt+XunmPzUXGNlkPOOd8Cna7sXZLCqB
 VJACbNCSAaB5qP1KkSuKI7YPH9/OAXLTYwFVR6UMN7DcrQPWDb2F8h9feBDISxkg
 UWXEgDAJ1JqaIOo82s9e6hWJH3BUZjYsuCVDOK+6dhSP9b4xVvt8kQAL+nuqrGDP
 vyf1Ow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6mftw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:29:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso9125454b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779366552; x=1779971352;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8Xi5z+FCk7PL+V8zhBB5Imo+U7JiUrOw4e7dC2VIrQ=;
 b=SxAkNspdyfEqEkp36Ydty640N8alSLoN0KwJiWga/afpUj2hne83AV3nQ4mztC1i6K
 qzQPzOS2xZI4yC+9aszHD8mksgJ+/XaKWwcXUCKjhZYJCoU5oPYx21OJZdUoxLcel1v1
 YaOxcUkXo6yQ72oT4yh3vyD1w5CUIBh8HrwTuV9rS63NOdbA7IRk3EyBMZxPGN0HDlyD
 Ih0lnvBg8zBi2hs9Gh/EmYyr7qAsmIuvh5q147KAMZBD5b9Ujb/5DOJJYqwvPh/P8URw
 8wIrLlGhs152SUCz2tyYcmyxcozK8MhZKLt8t5FWCLGl7ZrRlNJJ6fRzNvYNIJY/2JDS
 MjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366552; x=1779971352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8Xi5z+FCk7PL+V8zhBB5Imo+U7JiUrOw4e7dC2VIrQ=;
 b=hJT7Sp+8eEHrfIzSD6Y3rR0iv+8kB7tjKxYqlippMUvKZseBVpiTpV2VI9JyRO0h3I
 QdB7vIWDGQS17e20mMXTAhENHCTsd6kTWBdWKPSz8gllRy6ZBYR4NwS2wwOF4We57cn/
 izf8UJ3Ky9RSunB+2qIhNTk56uLI7yealogDtN8lQ8IYpraGgrri/pk9ng44LOQ4ZfiH
 giQbN6pkcwqcyeQsDzRIdUKXVXFeESBT2K6k2XodCEFT0q2+TnsVD74qlh1Dkmb0Xd1E
 k7odc08vXEHNBnB/Dndj76t1NVhnGJllxgbxs51gHGt9ZSuX9dMOKfGb3e83kbKgAT8m
 KhZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bKqTNvvPKyzxf+A+WUK0egy35ZTm/jDSUR7MZGNrZpISEeVpPgzxQhTZwC6b2IipaE6a34oISUSU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywjwTKfKqk0P1nJZ4s9iaUXyEvPTuDC4/OylnacVzhW0ZQQjNC
 CdtJiYCmZ+ECO9x6ILSKwBm+3Psk+0Lx7BrNDU7chWNy4ehSnBd1Eg6DrMsN84TJdqrdGYjy4zq
 jY5EuegLkaZ/ZtXxQrztS0ow7sRLxNGWKaBV/acYFP4HsrtHddOPpUTYyhzUOXwugtS7L9Lc=
X-Gm-Gg: Acq92OGGqhXn7l9WrzLTVEMANrgc4XSqdxNqUKAZaTQVjeUUFE0KFRwGtxrFYzUIBnh
 wVCu3KgfmR21CiNrrhZEbemyUkMLvjabrgonxeiE1kyJJi/R3zrhcKIb43ZN2zUwk0glsEkGW8l
 aEtdQxy4CVPaQIAZMm3i1R5Ji8He54YOSlOTLymWZGLNrwkDGBq7QHXJusMLHsEfHm8SaBMsCq8
 AScAgiVsZvXWrw2hRaxTun770DwSMpIdh+MlGBLiSiL1QUJ4+1EGSDqQc/6cEHYFaRTHNd8YB3D
 fD7124krdYa6ODX1EU/xtDVph5H+04IlEnY15Nw5NgouHbqBVDiKyxMrUGnN1AGRtFeHXkXUKdp
 iJvHhSgQ0Ut9QWwgPvjqu3RF5rPtkXoUq7Ok5nFLXkO7HWEaUXbHOuoRPZrA5IcYvrAgeVB5J6C
 VD6JvVr+6tCYcFqO1AdVEW3tY288WM
X-Received: by 2002:a05:6a00:4655:b0:82c:d7c9:5479 with SMTP id
 d2e1a72fcca58-8414adfcf5emr2926535b3a.32.1779366551774; 
 Thu, 21 May 2026 05:29:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4655:b0:82c:d7c9:5479 with SMTP id
 d2e1a72fcca58-8414adfcf5emr2926480b3a.32.1779366551232; 
 Thu, 21 May 2026 05:29:11 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84154e1d0a8sm1279516b3a.42.2026.05.21.05.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 05:29:10 -0700 (PDT)
Message-ID: <6a5144f5-8734-40ae-b170-eae107089a3e@oss.qualcomm.com>
Date: Thu, 21 May 2026 20:29:05 +0800
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
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
 <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
 <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
 <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
 <d4c5d26c-47f1-4e42-9852-d407982cb4f6@oss.qualcomm.com>
 <djigwx5k7j2rkaoq7g6paor6l6i25srvq7chjqqnjlbs3shcco@x5drauwxzngp>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <djigwx5k7j2rkaoq7g6paor6l6i25srvq7chjqqnjlbs3shcco@x5drauwxzngp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0efa98 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=L-3u8DrejJcmkFE2JFAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xOUsZhPw7hv-gWqpc65-Q24MStH2aUAO
X-Proofpoint-GUID: xOUsZhPw7hv-gWqpc65-Q24MStH2aUAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNSBTYWx0ZWRfX0PW57PJaYWMI
 1G9C3tYOYzj9ZnvZPTdKJaBSy1O+waukNUGmTOg0mkxP48XWZDYC5GcLdEwvoEbGVH/ZIH7JLbe
 OhZ0BdbEJ5AAK6ao2CEbqqMArDCoCe6CyqZFVkDUJf6eL5lfUNEoBx6OSGC4QVfcA0BoS2clcLn
 OVBdrSmWORrTR06tQAc8D8qK0qhHNU0+n1mqV3+WKNfYp06t0MLOcgp3aHfi4t6pWTmmd+i9et2
 kGx0/zMoA6b3xZ6KJ9FsWixHpJa/YR9QybFQl2tAJT16dAwJh3Wx2fzZhv1or6zPZkgLTInrGyO
 33kWRE10Tb2DMffsR3jgtlNk0qL03VL7TW3XbmOUy3rpErtiZEaJKpr1YUMHyjuwz+r1UXds56j
 rE7GkxjRrvPIEtvmsYO96p7Dm7pF9Sl/ldHp55h9t8FC4DFSxUZfOJ/HGRrWz/9tX/k+IOUABAH
 A3vN4cAMp0jfvzdFoUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210125
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



On 5/19/2026 12:36 AM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 03:12:17PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/19/2026 8:29 AM, Dmitry Baryshkov wrote:
>>> On Wed, Apr 15, 2026 at 06:32:29PM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
>>>>> On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
>>>>>>
>>>>>>
>>>>>> On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
>>>>>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>>>>
>>>>>>>>>> Add HPD callback for the MST module which shall be invoked from the
>>>>>>>>>> dp_display's HPD handler to perform MST specific operations in case
>>>>>>>>>> of HPD. In MST case, route the HPD messages to MST module.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
>>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>>>>>>>>>>       3 files changed, 48 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>>>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
>>>>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>>>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>>>>>>>>>       static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>>>>>>>>>>       {
>>>>>>>>>> -	int rc = 0;
>>>>>>>>>> -	u32 sink_request;
>>>>>>>>>>       	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>>>>>>>>>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>>>>>>>>> +	u32 sink_request;
>>>>>>>>>> +	int rc = 0;
>>>>>>>>>> +
>>>>>>>>>> +	if (msm_dp_display->mst_active) {
>>>>>>>>>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>>>>>>>>>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>>>>>>>>>> +		return 0;
>>>>>>>>>> +	}
>>>>>>>>>>       	/* check for any test request issued by sink */
>>>>>>>>>>       	rc = msm_dp_link_process_request(dp->link);
>>>>>>>>>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>>>>>>>>>       	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
>>>>>>>>>>       		msm_dp_display_send_hpd_notification(dp, false);
>>>>>>>>>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>>>>>>>>>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>>>>>>>>>       		msm_dp_display_send_hpd_notification(dp, true);
>>>>>>>>>> +		msm_dp_irq_hpd_handle(dp, 0);
>>>>>>>>>
>>>>>>>>> Why is it a part of this patch?? It has nothing to do with MST.
>>>>>>>>>
>>>>>>>> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
>>>>>>>> I tried an alternative approach by calling the MST IRQ handler from
>>>>>>>> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
>>>>>>>> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
>>>>>>>> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
>>>>>>>> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
>>>>>>>> However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
>>>>>>>> MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
>>>>>>>
>>>>>>> When are the link status bits updated? Please remember, we need to
>>>>>>> support all three cases:
>>>>>>>
>>>>>>> - Native DP, native DP HPD pin handling
>>>>>>> - Native DP, DP HPD pin not handled by the controller
>>>>>>> - DP AltMode, DP HPD pin not used at all
>>>>>>>
>>>>>>> In the second and the third cases we will not be getting the IRQs.
>>>>>>> Instead one of the next bridges (connector, EC, AltMode, etc.) will send
>>>>>>> the HPD event, which lands in the .hpd_notify() callback.
>>>>>>>
>>>>>> I added some logs and did some testing. I think
>>>>>> msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
>>>>>> HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
>>>>>> in the IRQ flow, the HPD state machine has usually already finished pulse
>>>>>> classification and returned to Connected.
>>>>>
>>>>> But the IRQ should be sticky and it should be readable from the status
>>>>> bits.
>>>>>
>>>> Yes... I’m not sure how this is handled on other platforms, but on LeMans
>>>> can not get IRQ status from msm_dp_aux_is_link_connected().
>>>
>>> Can we clarify that somehow? Maybe with the hardware team if it is
>>> uncear from the HPG?
>>>
>>>>> Note, in the USB-C AltMode case the HPD machine is not used at all.
>>>>>
>>>>>>
>>>>>> Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
>>>>>> will usually not be hit.
>>>>>>
>>>>>> do you have any suggestion that in how to distinguish between an IRQ event
>>>>>> and a plug event in .hpd_notify() better? We probably don’t want to
>>>>>> introduce another state machine.
>>>>>
>>>>> Then, I assume, currently there is no way to actually distinguish those.
>>>>> The easiest way to handle the replug would be to store the current
>>>>> "connected" status and verify if we are receiving "connected" while
>>>>> being connected or if it is a disconnected -> connected change.
>>>>>
>>>> Emm.. Currently, regardless of whether it is the native DP HPD (on LeMans)
>>>> or DP over Type‑C Alt Mode(test on Hamoa), a single plug event always
>>>> results in two or more identical .hpd_notify() callbacks.
>>>
>>> Could you please check, why? On Hamoa it might be because of the LTTPRs.
>>>
>>>> In other words, after the transition from disconnected → connected is
>>>> completed, there is still one more .hpd_notify() with connected → connected.
>>>> So it still can store "connected" to distinguish between an IRQ event and a
>>>> plug event from .hpd_notify()?
>>>
>>> I've sent a series, which explicitly tracks the IRQ events. Hope that
>>> helps.
>>>
>> Very thanks for sending the HPD IRQ series
>> https://patchwork.freedesktop.org/series/151522/. it very helpful for TYPE-C
>> MST.
>>
>> I’ve been testing it locally based on HPD refator series, and TYPE-C basic
>> plug case works on my side (although with some local modify, maybe now it is
>> workaround). At least the IRQ is being delivered correctly now and the
>> simplest case works. It still need to do some additional testing.
>>
>> There is a small question:
>> When do you plan to merge the HPD refactor series?
> 
> Would you or your colleagues review it? Or at least T-B it?
> 
  I’ve given the T-B. Could Konrad help review this series?
>> and could you please
>> rebase the irq series patch to HPD refactor series ?
> 
> Once it is merged.
> 
>> so that i can keep MST
>> depend on those 2 series.
>>> Thoug storing of the "connected" state should help us to identify the
>>> long HPD pulse (wich should be treated as unplug & replug).
>>>
>>>> This is my current understanding. If this is incorrect, please feel free to
>>>> correct me. Thanks.
>>>> As an additional note, msm_dp_hpd_plug_handle runs through its full flow
>>>> twice for a single plug event. Also, the behavior I described above does not
>>>> include any MST-specific filtering codes.
>>>>> For a longer term (and granted that HDMI also has a notion of HPD pulse
>>>>> events) we might want to extend the DRM HPD API to pass through the "IRQ
>>>>> pulse" events as is (instead of converting those to
>>>>> connected-whilec-connected events).
>>>>>
>>>>> Let me sketch a draft for that.
>>>>>
>>>>
>>>
>>
> 

