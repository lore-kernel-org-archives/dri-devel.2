Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6562DC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C4B10EC34;
	Wed, 26 Aug 2026 07:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CT23V0d4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TquXvN56";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2551310EC39
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q7Mxv41261254
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hAtoFR5M91EfZJjcnXRp50nEQGEixoE/vi+YmUD955k=; b=CT23V0d4SCSFpGR+
 kGpNmv9UfXO2UmWsgiXcybzdTSAkCRZBoNV2LO7H0CGwooE6VDCWLqaPTnuD9VOH
 41vQqWDdn+KPJ1BdN2fr4FbXBr8ir41dboDktPT9e9YVO9CwWZeIGqzjWukvgSM7
 0iV/PR5qzhS1Ku4LSJ+zFKfe9TMEpI3xWDEGb66+yRYan77y/AFEri+d2/nkN6fx
 p3TWkmL1OCfej3o2utt/n/dkj1sMy7zfK7Zc5yfpE2Bn4+Ng3k1+yrz5CK+JDD14
 1+j/t2RrIZ6csNNJE0+CaUy2whkXR/pB3q9ZLPaFy8BLFxFag9Zl+n+1lTGA20Rg
 5/58Lg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1r37t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso1132940a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730517; x=1788335317;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hAtoFR5M91EfZJjcnXRp50nEQGEixoE/vi+YmUD955k=;
 b=TquXvN56tu/tsYEDFURRvgHU3SVK5W5S8m0LNMu67qZaWu/1UVcm+VKQTrLbAcNlnB
 G9oUxG5gmlXPcHiL6cvxuiAZ26tMeHNhEKK/wwdtSqhrI/uVXkr9lEGqdOZ/n3NFcCmB
 +DcDrsOKekCsAEvVc2SVh5HIoupkS8wkgsvYyO6DHgi+RWKiif/JQ+oXNYUY54XEkoh5
 8TU5JFDErS8ujZPRPaZ6rJog3FlgImO5pzluxfDfSqHLOMjsTvv/Wf2WRzRG1xRHA0Pb
 oE2isMGpeJ4xs7/PF+MHDbwvZUHF53NY0qRyHXLegw6Zg6luG21dhcxOCE3McwbkYkvT
 w1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730517; x=1788335317;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hAtoFR5M91EfZJjcnXRp50nEQGEixoE/vi+YmUD955k=;
 b=jUZLGQ3Hl1AOMkjWNfrWQn9ue/ByqZWeOAXAnCV5DoY7+2i9ygKzZy2CPY12qmJqcz
 gvithOcI5XuuuASqP2pCRojmjlqItKDR9+IuDDmZEvm6vMMOZAb+MC7PAaq48wNrRS44
 HgT63UAF9rIwwampOWS3gvFDyoLyZEppvwMrKCKFoNdtw1JWHXV3qtZJwRPd18gKeUw0
 fFfVVpBXKF1n2tKiAOu824yuq7FDZRbzqIfXReMkcZfE2vf3IOlLOzBOobAJkN2M9+Kx
 db5DSXjORKdBnUdLLN6S1An/2OwnYpaLCNz0PP9Sj/zGC/6f3QVT2qWoRPo3ECH3h4lN
 zL0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/DIt2PnG6BiWnm8sAlyKOdP/jGnGT64TVQvlwkEOk4SItlNGbFY+KjE30E4W1e+20EyaPhvrtrzw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mM7QVkAODscuIj8btxqHjK9TtYgoHc8W1HRE/pAEXhQuu6H02X
 WCsvo7Q5lzWg6ojxjztKDvi5VERWK5lw2SSmozTVxjVkFGt7lvcrpx9IAc9Paewgcv2XAki7/b2
 ljqq5FfAIilGc0IjRCR6owb35ZvAPB3Pq5GxG4jvC/7HQ161PSIYALUhoX9of23dVgzSWxoo=
X-Gm-Gg: AR+sD11d5OfAJS93irf+cin1Q88OyjueC4Q7vhungjaSqZjsrmcEkhkoAZJGMpK71ZT
 JsbKU79t9cJQfaYqCTEBL3l4Hz6eXXwUlGGcv0mwkQkBCXYrfxvBurl1X3Th7v2TIMKC4L7iIPV
 L7ejF7qbVMcvYeqHSy4AQElIfo8QnW9FBJqGEd3OOVGgSsJFinhBRlBmw+YWJyJbZY5iucKHSOc
 6LPSmchG4NiugUa1IZbTupOh6O2DURnqIRXxFr6f1U5Wj1F0EqTuo7fyDbdpWgNgbJ9e4gPq5cn
 oX9b3F5chcjPkND8j5+jmihP1JwNdn0xI3Txbjh1bC050zDuhgUVUwWXpULZpkt3kvEwTsXoFWt
 LwcKgOwNQEK/q89vnQKQj7pRDtCuZNrpHGlrTuv12TRpdSvVqCzEl4XdKPemOOvJz+Z1EXKKZ
X-Received: by 2002:a17:90b:164b:b0:396:4729:43fa with SMTP id
 98e67ed59e1d1-3966ce035d6mr10084692a91.0.1787730516761; 
 Wed, 26 Aug 2026 00:48:36 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:396:4729:43fa with SMTP id
 98e67ed59e1d1-3966ce035d6mr10084613a91.0.1787730516257; 
 Wed, 26 Aug 2026 00:48:36 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:35 -0700 (PDT)
Message-ID: <f0a5b6a5-bfac-43ea-86bb-aa8c565d9e02@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 13/25] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
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
 <20260629-msm-dp-mst-v5-13-2ed6aee1867a@oss.qualcomm.com>
 <mys3u23vp6oi46djrj7lgp2bpmdlzaa6trmcmcprk7ws26ffx2@jzxkindvhuu7>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <mys3u23vp6oi46djrj7lgp2bpmdlzaa6trmcmcprk7ws26ffx2@jzxkindvhuu7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nh_xG3MNLakeql-51RWIxFS3A2cICE2-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX6wgow41rm4CB
 JIMZQJTk7yQxUP61etjRQCswifyJQIQQx/lJw7TqPEVRUEOlWrLwuvFs45SF+4dMsRd55QcmQU2
 tW/6V8pp12pOluB9Sull2yak846ZzAXs1B0V3X2dnIaXbByN8zK6qcLXT7eSzowTw+pKGWGGPTe
 EhJVpD/q6OomZeR3MEcEiUNvh+h7YcywPdKnkubf5l0CIKdxgw79lQrM4Qbz576SCo3sqxpjzrz
 aoHvk6Oh4gSPjDnCoO2ErZeMvr4alJu2KDojCaer22yoIKkdHlXmqJOXzo+DXENISkMf0/onoyg
 FSI1Sz5ctRGVBs6O7/AKblnreGJ8V2qtjoV1FC7FAdwxGcoI25MT/pQzsf5RcCGnYm7ZgmP/yeT
 FbtbWCWL81boba31mviDYnMZ9fQMM0lO6lZlC0ReXAHXW1VfKs1BdTJlWxEto39l294UEVk/qgo
 8etKBz+Asn2iqwI6HNg==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8e9a55 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=B0EM0j4ZEun6JshmIZsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nh_xG3MNLakeql-51RWIxFS3A2cICE2-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX9Z8A+1HXL5bM
 yo0LxwXopLKMqMjOcP5qE97onJZ5M5Ms2QC5BcB+Z1O0Ji8yEV9jx8012s/zMQ+oyLMRHCo9SJl
 zhZtwzt/oyqxqqDWQVHob8ZT7gOcvf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
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



On 7/13/2026 2:51 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:34PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> For DP MST, the link clock and power domain resources stay on until
>> both streams have been disabled OR we receive hotplug. Introduce an
>> active_stream_cnt to track the number of active streams and necessary
>> state handling. Replace the power_on variable with active_stream_cnt
>> as power_on boolean works only for a single stream.
> 
> Last two phrases are redundat. Drop the "Introduce..." one.
> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++++-----------
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>>   3 files changed, 19 insertions(+), 13 deletions(-)
>>
>> @@ -670,14 +670,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>>   	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>> -	if (msm_dp_display->power_on) {
>> -		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
>> -		return 0;
>> -	}
>>   
>>   	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
>> -	if (!rc)
>> -		msm_dp_display->power_on = true;
>> +
>> +	msm_dp_display->active_stream_cnt++;
> 
> Current power_on prevents from calling msm_dp_ctrl_on_stream() several
> times. How is it prevented after the change?
> 
I think we don't need to prevent it. It call drom .atomic_enable() and 
it should not call twice in SST case.
>>   
>>   	return rc;
>>   }
>> @@ -726,14 +722,14 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>>   {
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>> -	if (!msm_dp_display->power_on)
>> +	if (!msm_dp_display->active_stream_cnt)
>>   		return 0;
>>   
>>   	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>>   
>>   	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>>   
>> -	msm_dp_display->power_on = false;
>> +	msm_dp_display->active_stream_cnt--;
>>   
>>   	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>>   	return 0;
>> @@ -850,10 +846,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   	 * if we are reading registers we need the link clocks to be on
>>   	 * however till DP cable is connected this will not happen as we
>>   	 * do not know the resolution to power up with. Hence check the
>> -	 * power_on status before dumping DP registers to avoid crash due
>> +	 * active_stream_cnt status before dumping DP registers to avoid crash due
>>   	 * to unclocked access
>>   	 */
>> -	if (!dp->power_on)
>> +	if (!dp->active_stream_cnt)
>>   		return;
>>   
>>   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
>> @@ -1535,6 +1531,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	if (!msm_dp_display->active_stream_cnt) {
>> +		drm_dbg_dp(dp->drm_dev, "no active streams\n");
>> +		return;
>> +	}
> 
> If you get here, there was at least one active stream, wasn't it?
> 
Emm yes..
>> +
>>   	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
>>   	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>>   	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
>> @@ -1555,6 +1556,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	if (msm_dp_display->active_stream_cnt) {
>> +		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
>> +		return;
> 
> Why?
> 
Here, unprepare is only called when the last active stream is also being 
disabled.
> General comment. You are not just replacing power_on with
> active_stream_cnt. You are also introducing sequence changes, but it is
> not covered in the cover letter. It's not clear, why those changes are
> legitimage or why they are required.
> 
Got it. Will modify the commit message.. thanks~
>> +	}
>> +
>>   	/* dongle is still connected but sinks are disconnected */
>>   	if (dp->link->sink_count == 0)
>>   		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 55ffa22bb233..75dc40261723 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -18,7 +18,7 @@ struct msm_dp {
>>   	struct drm_bridge *next_bridge;
>>   	struct drm_bridge *bridge;
>>   	bool audio_enabled;
>> -	bool power_on;
>> +	u32 active_stream_cnt;
>>   	bool mst_active;
>>   	unsigned int connector_type;
>>   	bool is_edp;
>>
>> -- 
>> 2.43.0
>>
> 

