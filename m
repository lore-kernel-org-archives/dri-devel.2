Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F9CCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89C10E339;
	Mon, 15 Jun 2026 10:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHHdewTV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STf8qDEg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD2D10E338
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:05:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F9Td3v4161070
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t4X6WGiq4FPEq0dd0u+pxDxc4ERsQrYiJnopRFePXIs=; b=aHHdewTVMpBZivXU
 fn/VX6pRmultlnOvxG63Ju6yQO1ca285YR1TNQSMLzRdAkdhWLTmR+R/lljr3D19
 5qr6ByBCKfsyGikQO/1tXJy6FgMpyL5hBlEZEaSVztLPq03Z8q+QR9mCxfjMYfFr
 uz66vpwbbTV4QI2fegMlxW7+k1RAVHHvj1VHDBdi7J9JWSRQ/OpxZ7kHMqpo3JZC
 +wOfOA2OinRMXP+ubmfA5v/Myn7oMYABH65KcH9HAwcYWnQbFVuZdTR77sct1+T9
 nQy2lsl/pQf6Ib5AaEY/i51RRW8br3+PwBvt6GmRRa2HKQ1gagKpBhfwpHW5X0Y4
 3r9vAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf04f7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:05:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf160f7191so20766435ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781517913; x=1782122713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t4X6WGiq4FPEq0dd0u+pxDxc4ERsQrYiJnopRFePXIs=;
 b=STf8qDEgtWSFoE7tmoxsZFMOHEG/zbsyyLQoWT14K3pxK3wdcOpufIrb9CXOt5Kegw
 CvSVHzZ0YthwdDWXT5TxT+reml4k7eneeJW3m2CxHz59zK0+FrtNPh5Bt0heRcvDiMjt
 vAdr5XGP+HpIROBXHMCs2EL3w3ibOWJypk9izeRcXOoZmRNWLadkvrLAnkAGxFkeUVbx
 VEmYag5PFIgTJZUACX5MDKzIscITq1ihCx8AVphNLVmkTASDhydfm55C1a/oeRArJZ+G
 YUyiYpwwvQ/fBNfXdnj2H4Qrqu2y/POiGxw9Sq8WqWlzN39DCAAoyBJ/iL5oTaIPNycy
 Fncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781517913; x=1782122713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4X6WGiq4FPEq0dd0u+pxDxc4ERsQrYiJnopRFePXIs=;
 b=mKU4jz+ToFOQjIHOcRe+2XLR2KGCUBeC/m2JF4DARCnu/tZyKjQA2/1z0/4ak+eKx1
 /oRrKz7fRkeFHp81IZEwDlH64Yxqe6GyJ1xNb1oY0bTIe/od0/nt2RrfMVVaTk08iSLC
 pPHMq77l5HCdpGprQ4yOweOoaGAO+PDOZZlf4mXmhOEAvCUxeYo3zgiOaKRf04u5Mg8E
 tNgwPFVA55kxwyi1/mxrrKyjKCt/izEq+Ms06z5zWCaQogb6+Hl+CKNfLoNUnNsID6sC
 mATGGtRKaP1qgJBFMOzhjnP/jEP9lgSr4KKMYReyGqacIkitxr0QYsXQls7eADrckFjG
 Os6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fU3/zPO33BWtwsBCNrNQUzWadBI0ILiEdIlLxz92YT5sQgmETBjh34mvVU0YGxrOLmPIxqCGOC5c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1SmxUtn35JO4kC5qFJWBkS72kiDjIhfH4gwRgQkHCgLgdN+wH
 NvJ8IbIIEI/6k8Ar0fsRK8/3qRqiG07uFZM+X6h0lwByRo8geqUAxlh0S4FbGABjMZ7WU+iDCFr
 ZWba9ec5pOxyIq/H85xv5Mn8e0+Hmx4gUEKiU9VXBtAwpv7HzYRssFCWvk+udgDpxV6iXpVg=
X-Gm-Gg: Acq92OFK63UG1hDvb8iYDXCLzhgBTfcUCHfxqTHzdseWek6nUiP7VVzXo4PZL+E9Gj4
 IQWD10ybfvKO/6K7bb6X/iR1LgO9rrFT7N3Zir2gwoLuin3uCe8tqZUO4O1aPHWcw3wFQhf6FUd
 rjYf9OdpCVy4Ldzo+l+8o5mgI+Q1glhno9b6D7MSD/T+/Q6a9UBs2r7Cp4RuHe4mX9FWr0j92la
 HaqVtw6NmsjO8vWOuKwtorvxm2Uev7ijnxbcROuWspnlYK40Dx1kwfhKcNgQnpX9mpwtVaebWQM
 D5D8sCu+b/3c9ZwmrjNJ2s1rw0TcSqSbRhm+Nil+MsUXu2ZgY+p4kTURgw8I1jMC7eBfNyrrb7/
 15Tg5sW0ZDwr4CZAt5gFTROL3l2N8cZv1lvl8fedv2G32WZ2yVmYS02c9ipX/76aBRaE2ZWiipb
 QrG/WRQNysBq9/r0A2Sw==
X-Received: by 2002:a17:903:2f04:b0:2c0:bcb3:86f with SMTP id
 d9443c01a7336-2c6641488d3mr116824465ad.6.1781517913007; 
 Mon, 15 Jun 2026 03:05:13 -0700 (PDT)
X-Received: by 2002:a17:903:2f04:b0:2c0:bcb3:86f with SMTP id
 d9443c01a7336-2c6641488d3mr116823835ad.6.1781517912493; 
 Mon, 15 Jun 2026 03:05:12 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fbb50bfsm96866885ad.33.2026.06.15.03.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:05:12 -0700 (PDT)
Message-ID: <42c2bbab-dd86-4ba8-94f6-a6f377425be9@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 18:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/39] drm/msm/dp: add HPD callback for dp MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
 <ml35zldwr6f7euzmw6noy7j5mufyhfhmwoigkwq5ykyyl3amgb@5eo63mfnd4tg>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ml35zldwr6f7euzmw6noy7j5mufyhfhmwoigkwq5ykyyl3amgb@5eo63mfnd4tg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a2fce5a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=99inU4qtSHyG9fJ7QXwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: geOjFIBzAjKaOtmCrdDNu7-ZrZgGOmYH
X-Proofpoint-ORIG-GUID: geOjFIBzAjKaOtmCrdDNu7-ZrZgGOmYH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEwNiBTYWx0ZWRfX+FF2rtrxk1Ig
 tg2c89a6OoY0umPNv2HpgBvqbIuRdym+ZTO+w7WwGkFMfy9BzLcyDE/pj8DKlJegtHttn+m/Fg1
 sOb9JgCwPAeJulFanwunknEXnM+VkfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEwNiBTYWx0ZWRfX6ebhN1aO84hg
 aASFKQzgQoqgpWpClqakB19mBvvFzXUi5a5hoIdlmHuFhjhbFZ2iaOPz/ELH2+9DzJa3Uh2T6dR
 p5NUJZLtbVgjEbRaC2PteBx3dbjQfre8flhOOMzdr3iS3JtBZOUZXT/JMOnbs9fwhvLAPGTGe+7
 Nd4tQ2jV7jYXhNgXFlhOWbO+mPoPKT5d0YJaH2VCE8wNleoGtBUbt7r74HaKjej+RpTYOg2YZuR
 ymbdEMlCTZkWgT4E+4UsjuBmPJ2AiYbApa1mXhxTND7V3S+mSHSB1FEABnhlqt6ekXJKBUdk1C4
 CB11Ff/jlqpIU4FVDC72aZnYCA9d2uZkHCpO1WEtBmTh1cywlqjVQ/QOVmMvLEQjv/1NbXNl/bL
 5PTr+r/CMGY+oZyhONLxVVxlIlGsxIwR0/zcuLe+pMLuyHFZ/AvFGDktRvyDK0niPf0Nd6jneac
 +QgfIRRrqSOgGK6azLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150106
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



On 4/12/2026 6:00 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:34:12PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add HPD callback for the MST module which shall be invoked from the
>> dp_display's HPD handler to perform MST specific operations in case
>> of HPD. In MST case, route the HPD messages to MST module.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>>   3 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 919767945ba5..ca89e20b7563 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -454,6 +454,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>>   			dp->msm_dp_display.connector_type,
>>   			dp->link->sink_count);
>>   
>> +	if (dp->plugged)
>> +		return 0;
>> +
>>   	mutex_lock(&dp->plugged_lock);
>>   
>>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>> @@ -556,12 +559,19 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
>>   {
>>   	u32 sink_request;
>>   	int rc = 0;
>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>>   	/* irq_hpd can happen at either connected or disconnected state */
>>   	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
>>   			dp->msm_dp_display.connector_type,
>>   			dp->link->sink_count);
>>   
>> +	if (msm_dp_display->mst_active) {
>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> 
> Will this work for USB-C?
> 
Hmm not work for USB-C. We can remove this check here, as the IRQ thread 
can handle the disconnect case itself.
>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>> +		return 0;
>> +	}
>> +
>>   	/* check for any test request issued by sink */
>>   	rc = msm_dp_link_process_request(dp->link);
>>   	if (!rc) {
>> @@ -1125,9 +1135,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>   				      connector_status_connected);
>>   
>>   	/* Send HPD as connected and distinguish it in the notifier */
>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>> -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>> -				      connector_status_connected);
>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>> +		if (dp->msm_dp_display.mst_active)
>> +			msm_dp_irq_hpd_handle(dp);
> 
> No, don't touch this code. HPD notifications might be coming from the
> other entities. This IRQ thread can only send the HPD notification.
> There rest should be handled in the notifier.
> 
Ok. From my understanding, after this series 
(https://patchwork.freedesktop.org/series/164954/#rev5) is rebased, we 
should use drm_aux_hpd_bridge_notify_extra() here to notify the IRQ?
>> +		else
>> +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>> +					      connector_status_connected);
>> +	}
>>   
>>   	ret = IRQ_HANDLED;
>>   
>> @@ -1793,7 +1807,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>   			msm_dp_hpd_plug_handle(dp);
>>   		}
>>   	} else {
>> -		msm_dp_hpd_unplug_handle(dp);
>> +		if (hpd_link_status == ISR_DISCONNECTED)
> 
> Why?
> 
Let me explain this in more detail here.
Currently, MST hotplug and IRQ events are handled through the SST bridge.
This guards against spurious unplug handling caused by 
msm_dp_bridge_hpd_notify() being invoked from non-HPD contexts where 
status == connector_status_disconnected does not actually mean the cable 
is gone.

In addition to the real HPD IRQ path, drm_bridge_connector_detect() also 
calls drm_bridge_connector_hpd_notify() to broadcast the detect result 
to all bridges in the chain. So a single physical plug-in produces 
multiple msm_dp_bridge_hpd_notify() calls — one from the real IRQ, then 
several more from various probe/poll paths. Stack traces from a single 
insertion on QCS8300:

   1. msm_dp_display_irq_thread → real HPD plug, status=connected
   2. fbdev probe triggered by (1) → drm_bridge_connector_detect → 
status=disconnected (link not ready yet)
   3. output_poll_execute worker → same path → status=disconnected
   4. drm_dp_mst_link_probe_work → same path → status=disconnected
   5. output_poll_execute again → status=disconnected

Here not work for USB-C case yet, I’d like to switch to using 
drm_dp_read_sink_count to detect whether the sink is actually 
disconnected or no sink devices.

>> +			msm_dp_hpd_unplug_handle(dp);
>>   	}
>>   
>>   	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> index bb3898b1f6b1..71d3f63973e6 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> @@ -490,6 +490,40 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>>   	return rc;
>>   }
>>   
>> +/* DP MST HPD IRQ callback */
> 
> Useless comment.
> 
Got it.
>> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
>> +{
>> +	int rc;
>> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>> +	u8 ack[8] = {};
>> +	u8 esi[4];
>> +	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
>> +	bool handled;
>> +
>> +	rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
>> +	if (rc < 0) {
>> +		DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
>> +		return;
>> +	}
>> +
>> +	drm_dbg_dp(dp_display->drm_dev, "MST irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
>> +		   esi[1], esi[2], esi[3]);
>> +
>> +	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
>> +
>> +	/* ack the request */
>> +	if (handled) {
>> +		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
>> +		if (rc < 0) {
>> +			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
>> +			return;
>> +		}
>> +
>> +		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
>> +	}
>> +	drm_dbg_dp(dp_display->drm_dev, "MST display hpd_irq handled:%d rc:%d\n", handled, rc);
>> +}
>> +
>>   /* DP MST Connector OPs */
>>   static int
>>   msm_dp_mst_connector_detect(struct drm_connector *connector,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> index 5d411529f681..08e145399cfc 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> @@ -9,5 +9,6 @@
>>   
>>   int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>>   int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
>> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
>>   
>>   #endif /* _DP_MST_DRM_H_ */
>>
>> -- 
>> 2.43.0
>>
> 

