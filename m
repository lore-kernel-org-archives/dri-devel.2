Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89CC61CE3
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA5D10E900;
	Tue, 25 Aug 2026 06:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCrh+/Qa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zn/lwd32";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9189910E8F4
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:50:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2lJjX1220782
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oNl++Du6VHiN6HOj1SJl6WWq3CHouNZ3mdv2us/L06Y=; b=QCrh+/QaYsIen1IX
 Ylu5f0lZcPYjGYc9jc3pLFpnsV5uYfU/Ol1HyKXxxHvDo3CrjAXmHitvfVyH1Ey0
 xSuWiHjwE6+ykf02DLkaWp3yuRm0zujPrd7DEvTN8rNPehtMbuhqrjygy26U4K1N
 LsvLXnHYLlWiCXxH/dVAg5fvSXD2FFLrnCid1sqBMgAeclQTzo/GXAcEmW/sUSSE
 6xeYhMGKjtQnPdVrZaLf66M3JBa8QTb7uktUazVoUe5D9PeqwKlco3oEADdFg6Q4
 aLyAyHR4/7mV7a2j0qov37hFqvUFpvWdJpeaHH+E+iRKJ8ISSrZ+GTJ+m4eJyC9L
 PtGiIg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqrr0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:50:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so60531405ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787640641; x=1788245441;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oNl++Du6VHiN6HOj1SJl6WWq3CHouNZ3mdv2us/L06Y=;
 b=Zn/lwd32p3Z9/kqfVXYhT4LGX5xQLLueytta6KISZecI1iDyFlpFsdFLyfgCbFJ5li
 tnb8jxlPcQaA+Zoj5Kno+9rxD8KjgM6e+tClhjanlue/4DR4NLbTxlXB8RdRSrIS5o99
 ZQc7pScDOqVNYgyJ4GKXqEr+khn0sR37OOxSWAFzP6ThJ/AgOX4FmPQtH446tHDjLVb8
 WzK3C5ag6aMWxgiZ6Fn9WlCW7GALW9pPyJDVbyLAM/YdJ8RQsl931MOz3pJUhYVjoYPf
 ib2eonApvmn/Pmsoeh8Cz63r1bAsh+OHdc3zILZ4UHJvTL8vwEmRbdLANSUfYJWz+o7g
 giBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787640641; x=1788245441;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNl++Du6VHiN6HOj1SJl6WWq3CHouNZ3mdv2us/L06Y=;
 b=YGu4FkPdLk2AvSxW3CnPRIHLjX7wWUlIovLcsxEYO2Soh4187qQWjOoGAkTtPwUKbp
 9Smc4yB6QUTvkFo0lGJ4Z7ubMidVYEAM/jNrlM/8YV4aPUpXLMJtAfJQ1L4a/f2hrxWk
 0qlOjyWxkqDYlvGX0YEyG2bhfZooVDO1vVromdN+bkvzyCt9iPdU0FLFlRhcgaq4MNHe
 CtzmYvF95H7DYEDzPaktevnZIXpn03Myla5ckzfi4pCJGrOwBDffqytUBCm7oGdiLRgn
 B95N6TlnRJljI515ZbZjo+eidQ0e3KYzt4f0nJVdyGwZD89Q63Tn+nLez84meSOdp8IQ
 BL3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcqSCytA8FGxB1ONBq4IWvYKdQtgS3jBeoi6y0Q9EdydsyWbrTMA8gFW5cGs3bzibYsbjZ+fgzlSA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lifFZBllW88nNTqow3lxDrOjebnPTHAWzzKdo4bDVHF6JpXoaR
 Tb8oedku5A+uPRrdCL9IT6rNaJ/+YppIuw08q+6mgBpWXXfyDDpvEmqJXc/6Q056sTzi3cgNX+M
 WvnAl8J/sYFX9sGQQKmCV0/lnd34lmnXbm23gfSX+VhuBk5nUa86+/RF1Pxoh9a6WYgh4XdQ=
X-Gm-Gg: AR+sD11wZuo2Z0/y952yeYXRQL4vm1YfDwXi8qaD0vfiaU51K05FvIdeQ4cBXtBYNuT
 jL13RZMAaN1Ig+YmoaFkes5MrnhQCz6W5zvZN7X0INBdky4LgtvvSrTBKHBCHOEzGtIQLwut0+7
 WS5fubog8zDNZUYj2NuB8rwElJHIccuJkVLYlQ+cRH78ezVA3fO497LerDtQQ0DTt+Ky3ebXYud
 yn5O0y5+IyFHXXZWecgEL0wzKDYZ8bI36YJrRTCc9a4YTCjbo9wErVCq2K/r+Tqxsehr9082WXz
 H1jBt5YHdG3QK6/L4fPyt9SVNMJ4WzSGntR0OyOK+akkSnQkUfmMrBONeB1+7ymDX5Z4oxKQdsq
 BojcyAxJCTmC7zW9HrEIw3yCk74w/wLZD8mDEl3qVbZ3cc0suK1zCRJYmeebe3Dipauk37Odn
X-Received: by 2002:a17:903:26cc:b0:2d6:f9e2:af7f with SMTP id
 d9443c01a7336-2d6f9e2b022mr3980675ad.1.1787640641274; 
 Mon, 24 Aug 2026 23:50:41 -0700 (PDT)
X-Received: by 2002:a17:903:26cc:b0:2d6:f9e2:af7f with SMTP id
 d9443c01a7336-2d6f9e2b022mr3979575ad.1.1787640640848; 
 Mon, 24 Aug 2026 23:50:40 -0700 (PDT)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d67cbde1fasm23573815ad.56.2026.08.24.23.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:50:40 -0700 (PDT)
Message-ID: <c423ed30-1168-40b3-8b00-6b2f0339b466@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:50:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 11/25] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
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
 <20260629-msm-dp-mst-v5-11-2ed6aee1867a@oss.qualcomm.com>
 <4las62mpvcuud6m6yo2mz6hiijv73zt27hnha4tlaejubt25x5@gxralblac3m4>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4las62mpvcuud6m6yo2mz6hiijv73zt27hnha4tlaejubt25x5@gxralblac3m4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kZhb12X06P4wdpYXYBsvY_4kP_eRV3fh
X-Proofpoint-ORIG-GUID: kZhb12X06P4wdpYXYBsvY_4kP_eRV3fh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1NiBTYWx0ZWRfX+K4meFV5wnTU
 fk6Z6AoiDKHcvnRV1/djVoQrOsV0y98eA0zCQhZLGSyIbtLubGCQd6CfMCBq1l+K5Y00lp2A6v/
 aZRcXMtsmvpn6EeciVnkw4DXqzEp9Dm1Hj3iMdKm76vW1dzb+UPDZLYRxkBZxNa+1zR97Bj6xMF
 nmojjTt7eU33eIvS2mllNMHIQbvS5fagRI9vPmDwQuVPczOVZord/zSDQiZ99vkNPqee5MVZYoQ
 uak3gBZCBhwpPBTib9hd1mx2sS+NBTFbvi0q34dU86dflWfv5CWWwPBuHhS8RsS1kM5G9bII2Vw
 1DOUZKKo4wSGv9oCLWCiHM/fEwy/mupclb/PR8G/nbCblu+P0fZAn1n14v/sBwtE0VwvDqVEph0
 m4OOH5zdzTEkhWLabwbgAyHDEPj5zwx3r74VvTDeqPVHchchhkwn3PHZPRbjX2yDgZ1alB8ieU2
 KeXzgXV8O5Jm34F7phw==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d3b46 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3ssPzueCi6W0KKmKcc8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1NiBTYWx0ZWRfXxx1oCl9cLOgN
 NyVaZf7j94XvEzc3IjeYX5NJ8y2koWxOzuQSYym7JtUN+WZz91pKc0YUXkUHT7IjkNbLUMiKQ6c
 Kl+SEsUR3Nk6gC5AmSDl6JJk3xedumM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250056
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



On 7/13/2026 2:20 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:32PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> msm_dp_display_disable() currently mixes stream-level shutdown
>> (disable VSC SDP, off pixel clk, clear power_on) with link-level
>> teardown (PSM config when sink_count==0, off_link, PHY re-init or
>> host PHY exit).
>>
>> For DP MST the same link is shared across multiple streams, so
>> disabling one stream must not tear down the link. Move the
>> link-level steps into msm_dp_display_unprepare() so that
>> display_disable() handles only the per-stream sequence, mirroring
>> the split already present on the prepare path
>> (display_prepare_link vs display_set_mode / display_enable).
>>
>> SST behaviour is unchanged: atomic_post_disable() still calls
>> display_disable() followed by display_unprepare() in the same
>> order, and the cached dp->panel used inside unprepare is the same
>> panel that was previously passed in.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 1af56c84b82e..1680a67284a7 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -731,18 +731,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>>   
>>   	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>>   
>> -	/* dongle is still connected but sinks are disconnected */
>> -	if (dp->link->sink_count == 0)
>> -		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
>> -
>> -	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
>> -
>> -	if (dp->link->sink_count == 0)
>> -		/* re-init the PHY so that we can listen to Dongle disconnect */
>> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
>> -	else
>> -		msm_dp_display_host_phy_exit(dp);
>> -
>>   	msm_dp_display->power_on = false;
> 
> The list is no longer powred on at this point. So, this is wrong.
> 
Got it, here should also move to msm_dp_display_unprepare().
>>   
>>   	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>> @@ -1533,6 +1521,18 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>>   {
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>> +	/* dongle is still connected but sinks are disconnected */
>> +	if (dp->link->sink_count == 0)
>> +		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> +
>> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
>> +
>> +	if (dp->link->sink_count == 0)
>> +		/* re-init the PHY so that we can listen to Dongle disconnect */
>> +		msm_dp_ctrl_reinit_phy(dp->ctrl);
>> +	else
>> +		msm_dp_display_host_phy_exit(dp);
>> +
>>   	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>>   
>>   	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>>
>> -- 
>> 2.43.0
>>
> 

