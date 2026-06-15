Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51454CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F2810E2C4;
	Mon, 15 Jun 2026 08:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rR3dIO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V55g548a";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6834710E2B6
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:45:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IxBo3344539
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V7p1TqGbxKOzqKvuGX8oUhCBkSlMWPS5HXB/aBjrvlQ=; b=L3rR3dIOdeyvn4/F
 6QQU8XUmCp2kYAKNzSw2T6jK/FyUmfHH6xKUStHQi0vIqdPRTGi8yIVQUplNuzT6
 ouM1tZh6OHHcbNM0SI99oIL7cq+kjhAbCG5w8RddS6nAj+BDb+e2hLUik19JM0SM
 iDPmKbEsItYz8rWe2kR/cbQbTy3EjRsTHwlxGAWJVNO5L0hFcp3YRESZWrVmtkf5
 naooRkIya17UHgpkXbZKJZMneywFugiatbAnh4TvU65QYMxrW0xYgBz4wwdWjOZ/
 /qD5LjjUALSyAbz5Wu6+iZbau1GiAajIHRV81L7S7eQlKzgCbJmM/jOlNzKuyTsg
 9RCKeg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9feg17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:45:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85edbb10dfso1705188a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513120; x=1782117920;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V7p1TqGbxKOzqKvuGX8oUhCBkSlMWPS5HXB/aBjrvlQ=;
 b=V55g548aB/80r4qbrQgoflo2oLJCxVQ256mCzYdUDVYi1TUeZhXINYiusisTEnck9M
 Pxy2w58xH1KlcNJYdZhRc922pEhEQ9pr6Blyv9965wizDNJ5B6HJlSiOJJlUJQ+APCG1
 6Vo9ehJRI6WMKQHbmaenUCP+u2tAmplLa8RoVTgkRzl8uLz7bHfVpHipM+QqvO3AsXq4
 Cj0plasvf9gpjWQULMU5TSIKA0JbVPC1yd8p1DYYD6czyYw9ib1qIMVjHlMCsPmhq49i
 L7gxI9ijgMHczHfsusH4piWfQC88r0Q3HU9zYNM6bjqnPv6YVEgR4qlGQ962EFB850WG
 sLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513120; x=1782117920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7p1TqGbxKOzqKvuGX8oUhCBkSlMWPS5HXB/aBjrvlQ=;
 b=Sbe9xRXOZn9T5Br4pvPIdvAGxJESjyhTvNhSLN3BFwdB6RZ09mqyG5AVGFoZZ6W9eY
 fq6cCs1EFyps+c3dKoetjBrf/E3J/tyP+fLfu0Lfzb6Jx2SBWmqChpb6JYiEvxvyGYYE
 1y+q/h9J2I4ysAClh77X9PIlx41KW/U994F4eUIxo8KM97pfNnHPmFefsoOVF10Gp4qs
 /AOud1os5rHwzs9ZWXmaVkneLWCxk9ZxYISjTUBpAmHwzuqHdWcsTR2mHqXe6qAuz9em
 esMa8Z1wE9e1874Uf1EIioLkd0mcRmGORzzO+YmIGcwURr1mIqJphKCT4JWJ0dv5YfOE
 DvlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QJIGRiKbTvfABlZxVmTSwDxlnxCY+EMM77A/it7Q8CrCspNoqohjWtfWy+ZIg4TIzKWGQ37VY+l0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZxfHF/tLbuYuJNGCrSBb2KNOFMt9FTmxkAN+PAVo1FjdrNH44
 hRDE+5Ws6X6ytl31Op4YWpc6I9lGeiqT6bJzqLCv81nd9+822wrL5x6a7EckD+d51MvY34zKuF8
 qaM6X8rvW+jHzbCNz63c0HwgIuv0LTCLMODVetmUHV8ax5HagONHcwUCsNGkJ+j+vCR5nM3E=
X-Gm-Gg: Acq92OFI2DcciZSwWEvVLt6fICeKH49o7vl8SyDkAfo/9EtmR53bUyvoKIrPwlrQYZR
 M9dUvl7Y92hH537WPu8N8zX9X4iGO544jnrDZuO3/EH9ZpRs0DYG2a51DwOBRVRUdEXvPmfRStn
 p0j75Z2EnwxhfOH/BbX5sMS9Cw7NMgtXGiPAVIuRrrDPprejdoXh5taHyiQfX0Ubz6hTteb0qwX
 um9F6i7hVKn41yhoYQ81cyrPNjJXs4CbwPD3DCZ9UIGcjQJXBCbY7mC6gOVI2AvUD/Ye5s7WDb9
 qlm2YQ5J0Ik8kpfyV7MHxIqXIYWKFZejigl4WVzDjquw3Mo00d/XJZuz3lkagawJtDAl4MkSUB0
 2hKnHbJIxBD/MKpyAm780jUPkOTRK8gTMzaxwc7af4knYtsgYFGQB54UsnkXTSHVSLQEBltkbFx
 4HmEOW3LNpk6+sJs2gCg==
X-Received: by 2002:a05:6a21:458b:b0:38e:92f6:9ab1 with SMTP id
 adf61e73a8af0-3b78588b46fmr11370746637.22.1781513119953; 
 Mon, 15 Jun 2026 01:45:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:458b:b0:38e:92f6:9ab1 with SMTP id
 adf61e73a8af0-3b78588b46fmr11370715637.22.1781513119450; 
 Mon, 15 Jun 2026 01:45:19 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86651aef27sm8248972a12.30.2026.06.15.01.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:45:19 -0700 (PDT)
Message-ID: <9219adc5-e394-4d70-a580-f85bf860e566@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:45:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/39] drm/msm/dp: replace power_on with
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
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-27-b20518dea8de@oss.qualcomm.com>
 <ezm6cz4lfzrh2a7ohwdc73qbn7gblqjhwtwcp72ds7u6cmizrx@qvh7vu6kis2k>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ezm6cz4lfzrh2a7ohwdc73qbn7gblqjhwtwcp72ds7u6cmizrx@qvh7vu6kis2k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MSBTYWx0ZWRfX92dFq8WzTPOc
 B95Aem6i3TvrPj/X2LwoUUg12dJc20GZTua4bpUofEFHMMUF3Eh9Rv+eo8L/r5cxQJX0419l//K
 fCL6zDgxPm7wMXLXZ5nsSAm9ge7uBhehI29W0U+h0URn2jIMKTOuYq0G6SiyWvq8o9lRYc4/TCx
 pzDKmiiBc69yCzdXyQ3Q13ylLadqnkj/GMDxdSbuLPTJ0M+ueQ2cg+7NHoiM+Ihd3NL5hsOTZm+
 BInqiHQ+P3Xq7CwHt2BSgkozpBcqpfkPj3f1XN4KC0hdxSUzbWUuQt2e9ddl1+G2MgCYM8wbqr8
 zuFxlQiOKktuaGVPNwBxXLlQoKgDFU0VEw+YBzfo7Ye4R722vN344XLq4xz5GCVsvDcXQzIGw/U
 rMk2i6PKsQm4twu1cZs4k8XkOWzd9XR3N9m43Px33eOJKDbgI7LJBh0XHbZqWUrk4DnyJF3woM1
 K9JEjc2vUiTxcPfq8Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MSBTYWx0ZWRfX+zzYOz+O81aj
 pK8lkhqOSS+V3zDnNA4nLnqBwrqv+bstS2bfXZzLk+c2ybFmLHycBMOh0R/VPjLC+uqUzb28zuS
 KXzA2x5YU+m11B1QQCdFOsstTHi4nrA=
X-Proofpoint-GUID: cBqdA2_JSC2IK-UL3puMoPQLeX0BKZaD
X-Proofpoint-ORIG-GUID: cBqdA2_JSC2IK-UL3puMoPQLeX0BKZaD
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=6a2fbba0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1XwNoAEaEPKn6H4yol4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150091
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



On 4/12/2026 8:11 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:34:02PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> For DP MST, the link clock and power domain resources stay on until
>> both streams have been disabled OR we receive hotplug. Introduce an
>> active_stream_cnt to track the number of active streams and necessary
>> state handling. Replace the power_on variable with active_stream_cnt
>> as power_on boolean works only for a single stream.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 38 +++++++++++++++++++------------------
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>>   3 files changed, 22 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
>> index 41018e82efa1..035e230201fd 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
>> @@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
>>   	 * such cases check for connection status and bail out if not
>>   	 * connected.
>>   	 */
>> -	if (!msm_dp_display->power_on) {
>> +	if (!msm_dp_display->active_stream_cnt) {
>>   		rc = -EINVAL;
>>   		goto end;
>>   	}
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 33d8539afee7..e6ecbb3a688e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -657,15 +657,15 @@ int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
>>   	if (dp->link->sink_count == 0)
>>   		return rc;
>>   
>> -	if (!msm_dp_display->power_on) {
>> +	if (!msm_dp_display->active_stream_cnt) {
> 
> Okay, I'm now being lost between the names. When is prepare being
> called? Is it still part of the atomic_enable()? Or atomic_pre_enable()?
>
I’ve renamed the function to msm_dp_display_prepare_link, which looks 
better. We’re still in atomic_enable().
>>   		msm_dp_display_host_phy_init(dp);
>>   		force_link_train = true;
>> -	}
>>   
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>> -	if (rc)
>> -		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> -	// TODO: schedule drm_connector_set_link_status_property()
>> +		rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>> +		if (rc)
>> +			DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> +		// TODO: schedule drm_connector_set_link_status_property()
>> +	}
> 
> Again, this more than the scope of the commit message.
> 
Got it..I will update the commit message to explain why this change is 
needed. Under MST, preparing the link only needs to be done once by the 
first stream.
>>   
>>   	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
>>   }
>> @@ -674,18 +674,12 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>>   				 struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	int rc = 0;
>> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>>   	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>> -	if (msm_dp_display->power_on) {
>> -		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
>> -		return 0;
>> -	}
>>   
>>   	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
>> -	if (!rc)
>> -		msm_dp_display->power_on = true;
>>   
>> +	dp->msm_dp_display.active_stream_cnt++;
>>   	return rc;
>>   }
>>   
>> @@ -731,16 +725,14 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>>   static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>>   				  struct msm_dp_panel *msm_dp_panel)
>>   {
>> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>> -
>> -	if (!msm_dp_display->power_on)
>> +	if (!dp->msm_dp_display.active_stream_cnt)
>>   		return 0;
>>   
>>   	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>>   
>>   	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>>   
>> -	msm_dp_display->power_on = false;
>> +	dp->msm_dp_display.active_stream_cnt--;
>>   
>>   	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>>   	return 0;
>> @@ -876,7 +868,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   	 * power_on status before dumping DP registers to avoid crash due
>>   	 * to unclocked access
>>   	 */
>> -	if (!dp->power_on)
>> +	if (!dp->active_stream_cnt)
>>   		return;
>>   
>>   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
>> @@ -1559,6 +1551,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	if (!msm_dp_display->active_stream_cnt) {
>> +		drm_dbg_dp(dp->drm_dev, "no active streams\n");
>> +		return;
>> +	}
>> +
>>   	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
>>   	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>>   	msm_dp_ctrl_mst_send_act(dp->ctrl);
>> @@ -1579,6 +1576,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	if (msm_dp_display->active_stream_cnt) {
>> +		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
>> +		return;
>> +	}
>> +
>>   	/* dongle is still connected but sinks are disconnected */
>>   	if (dp->link->sink_count == 0)
>>   		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 0ede5505be58..2548f67cd441 100644
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

