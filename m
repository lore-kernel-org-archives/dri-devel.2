Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73CEC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B19710E918;
	Tue, 25 Aug 2026 06:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiTHo5y1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0J4Z1F9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E68810E916
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2R5qc405050
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B5BlCQjUficUb6+P36Gle/9S6qFrgRnf0A65vTV0iuY=; b=UiTHo5y1lbB64WL3
 fwQywIod+yVa8ZONG/lsCSFeejYySG7KXE42GbAdytNjpDntGQkflG3hYOgbK8SO
 ox7SsD8lVZ5c2gTGIHv/MhNpp2gS3Ek40cMDbvRJg4a+L45ar/o7bE1LV8CITj7d
 XNx+ZMZu5JIbVtyLmXmwxRUTVQQkYuHi1ytNK/jESbjTPLlrJxmJm+nCcw956VD0
 JqtZWzeGjgfQh3OA68rgPutMxyfAhjBJqxNxnPbTSkSeSNOaxJkidPpUjNTXOKPy
 6W4OsWxb71XMQEgmusSfetcvPv0LF9jYLqrnj3K3HYWgmetl6dEbQ99SKA8r+M80
 OCFNMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8y5jh87y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so66326885ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787639353; x=1788244153;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B5BlCQjUficUb6+P36Gle/9S6qFrgRnf0A65vTV0iuY=;
 b=P0J4Z1F9Xg+2lAkTypVq51hjcUG2BJ6oZKnEJVOYuvEnkanteTLvkUjDoRvMPH41ib
 ZF/nQRn9CZZ3SxPs99LTqssJvUTkkdAxf7GGJzxqSk1ay4JhxFXr7WLfJdIagtcJi4ow
 wtw4F/rx1/683wM8YYP7ohR/KgpKPJzWH8UiUhYpBfXu6+z1P4/HhrRj0CJs2/GiQALe
 21gOo03y76z3FY0LF3x01HzzCrBFGrg3VTsgYTtVN/sidgBQboil/67oszRBitDP4OyZ
 j35QYpUH0stdj9UqupYfDVcmWAGZYwxoqKHd9iuhd85CBHpeeD4YFs/qQ94igVLxHbwH
 Eu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639353; x=1788244153;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5BlCQjUficUb6+P36Gle/9S6qFrgRnf0A65vTV0iuY=;
 b=kV5LJDSLcfEDRPrItZSF28bQC6sHk+codHZiwkzd7myLR2mUR98f4r5mezl9mQGAEB
 yT7jE5WrZIjmV+oByMqkDPmn5ow4lp9vdXevRFCzsrz0yR3mbITeA5nGn7LfEgAYLFeA
 SO9vdfzOyyayK02VS5eg0dSTGhVlG8lICIIV8MOg2WseBwsY8bNyDdU+VzevF8UmOyNj
 P4X1iNljIp06N5cSqbt79c7FUdIRqttFOO94frScl9CES4wc+Qrxs4gjUiqcOx0Qw+5A
 rbOnMYGhu4uiQ/3oSBzJH9rCseMgkLu7IoVxAd9kdYl9YPdGFwTZh5GrwWfdfLz4siFr
 5CvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFLnzDA1OG72qVAXBtR9yTD3EWV8anWUax/1ibRk80rMr5goSZxCluVD9unyxdrTCa8Yw7h1R8dFU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lmNo9bSuSG1urq7l/eT401tJBYBixnBGJKrQ6nDY7Ozr4FCGqA
 0Qvh3ZVWwQ3JxsXiDLTYJLYTWXI2teBzPH/Fe9RHx+DmCRf3Ty3WJ5TM19x3VagwFDyzoZNpx1m
 sNPZLF7X9Tbg4UUsm8+Y2koDC4Iu2s0c6IAziPNMRiotaCWsO8miu3Qqw/QtVcwDGctfgN8g=
X-Gm-Gg: AR+sD120og0xMyUr8nmgzplrO//6Y1aT8c4E9QotRRfOsPrRzOviFqsylbgQhJGAKBd
 3OTd8Lbstr/64HUi7aWNdm9AKA5CaZMh9C4dn2+na2mARQhBeKRZlqtRr0cwGczp07WIFYq1OYv
 a6PxG96nMG27CnFRUISq7yLB1zdhcEH2xuihvSK3MXziGIa4mvhVzyE3UgsMQA4QNQ9JbdlwVb4
 JTLzeMS+ItGu2napV0qcFwsw3kRjKUH6DFD1gEKBcyGZMu9pIP+IIgDhOVrOgHPIxArXeSNmtrA
 Ddi5dT0Xpr7RWNro6bIoPn6qH/PftaeGMjyTsCbBdvEAJQ3r+wAyrHMMO4Pu0cobp2U85yYDz63
 DkQ5T3gjbeEUz3ksWISXx54fUqS97+DJdILF3IoMMDRnRY+39TdrBKXzbbZ2xOwiUl0fChKK+
X-Received: by 2002:a17:903:4687:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d6dca619a1mr88911895ad.1.1787639352656; 
 Mon, 24 Aug 2026 23:29:12 -0700 (PDT)
X-Received: by 2002:a17:903:4687:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d6dca619a1mr88910725ad.1.1787639352192; 
 Mon, 24 Aug 2026 23:29:12 -0700 (PDT)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768b9e3dsm24218565ad.65.2026.08.24.23.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:29:11 -0700 (PDT)
Message-ID: <73722056-4f15-4043-9005-c033dc8986f8@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:29:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 25/25] drm/msm/dp: add HPD callback for dp MST
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
 <20260629-msm-dp-mst-v5-25-2ed6aee1867a@oss.qualcomm.com>
 <remaj6npgiv2hakdeevj5mp76c46xupoa64dqbp7x37wlzgrca@66ooracpci4x>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <remaj6npgiv2hakdeevj5mp76c46xupoa64dqbp7x37wlzgrca@66ooracpci4x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O5QJeh9W c=1 sm=1 tr=0 ts=6a8d3639 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6gsoYQu_toBURm7Jz6AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfX3BJ2xa2cqXqg
 JSio3zIv+EKMGG8+/jKGNjmYK08omgMmg4r/h5kXyuWzvc2mCbnVlh1LBzH3ezrQipqCHgg1hok
 chbVyef1Zov6vhVBKwEkNQats7Mr79vPOvnsahsLCj074zVQ2cP2d2NIX+HJDQoLKdE+cdKBrbR
 /Hvjy25MtYL+cgA5SH8iUYqrXsIBxidwAfe1ZDGauQNE8mdrWvKnnndmFLzMQY9I/6i3iouU8CA
 9N9UeoSZF1QGynXHWf33PJSbuogr7yEYvbCLjvlRJsv450/EtVJ3NSqzPjEjUqPN8BvY9a0ahdO
 3wwLC8aAY2fbT6AWgHkpPyxpsZOlLNjWmryuWGllm0I2hWUXY1QOlOGUnOdQpAtPX9ONAshqPIm
 VOAOGW//uyv3vld39eBs68+zgfEqDWgxfmXZ2LzLprHCUEhxA7kwkyuzqh+5rYN/nLPV4KI4w6c
 WhBD7uq7TrMz8K6zrfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfXxUN7aPDC30yk
 R2+uhnK2H2GuOlh5mZ1AGGmAboY+8kyFkvhFuqXUzRYn0OxxJdQDyPQgGBm4/Hy6lt3A0qB3cjD
 HzHOPCzrx6xGrnjXZL5RdUldVjwfpso=
X-Proofpoint-GUID: qQ8duH0M2CadNxxUnMS7zP3V6g_YjtXH
X-Proofpoint-ORIG-GUID: qQ8duH0M2CadNxxUnMS7zP3V6g_YjtXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250053
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



On 7/13/2026 8:54 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:46PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add HPD callback for the MST module which shall be invoked from the
>> dp_display's HPD handler to perform MST specific operations in case
>> of HPD. In MST case, route the HPD messages to MST module.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++----
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 46 +++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>>   3 files changed, 65 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 6eac390af2e0..49a7bc5e031e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -455,6 +455,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>>   			dp->msm_dp_display.connector_type,
>>   			dp->link->sink_count);
>>   
>> +	if (dp->plugged && dp->msm_dp_display.mst_active)
>> +		return 0;
> 
> Why?
> 
We need to filter out unnecessary plug events. A single physical HPD 
event may result in multiple hpd_notify() calls. The first call comes 
from the actual IRQ, while subsequent hotplug processing may trigger 
connector re-detection, which in turn causes additional hpd_notify() calls.
>> +
>>   	guard(mutex)(&dp->plugged_lock);
>>   
>>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>> @@ -550,12 +553,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
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
>> +		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> 
> This should be routed through the HPD / notifications API so that there
> is always a single path for handling the IRQ_HPD interrupts.
> 
Got it. The reason for having two paths in the native DP case today is 
that the current DRM IRQ API may result in unnecessary hotplug 
notifications.

Once the API adaptation is completed, both native DP and Type-C DP are 
expected to use the same IRQ handling path.
>> +		return 0;
>> +	}
>> +
>>   	/* check for any test request issued by sink */
>>   	rc = msm_dp_link_process_request(dp->link);
>>   	if (!rc) {
>> @@ -1111,9 +1120,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>   				      connector_status_connected);
>>   
>>   	/* Send HPD as connected and distinguish it in the notifier */
>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>> -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>> -				      connector_status_connected);
>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>> +		if (dp->msm_dp_display.mst_active)
> 
> Locking? What if MST is being enabled or disabled on the other core?
> 
In the future, we plan to switch this over to the DRM IRQ API. At that 
point, SST and MST will no longer be handled through separate paths, so 
this issue should naturally disappear.
>> +			msm_dp_irq_hpd_handle(dp);
>> +		else
>> +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>> +					      connector_status_connected);
>> +	}
>>   
>>   	ret = IRQ_HANDLED;
>>   
> 

