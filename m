Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D47C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56C10E421;
	Fri, 17 Jul 2026 03:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKdI19VI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eahHPxWv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A957710E421
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:28:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H33sgt607357
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oGQyhCyTFOfzEilNh6DtlVyB434KQJA8Hb/vNH9xhho=; b=nKdI19VI0Xg+gH6K
 UaaLkdRdr0hYfoRKujO+x/4z6W8hJIy1tzOMitetK8PrTxidOfU3ufli8mgWHkHB
 J3sxzmo7OH5LsyP4SZWOu2hIw4uC8lYlZ0BLRzK6/ltIFrMutUJ8dQEbrU+q5l8f
 k/XcBlJtTQsM7mpZb0IvTLbV36sZIbklyWkR11UXAI9Ig1zG425AwhHG3ZPtWFUY
 3aIazBfoJC5g+5rKz/FsKPa9HT9AHhQLgMQVr4DWUIv0EXdORvIq/Qd4dWCsN0Ql
 uGuF2AQPqLxMiPxDPuGhkkZzx64PBNcow0ELolGpDpTWWgF443BMnYycR51hIIA4
 roIzhA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10cepc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:28:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc101287aso8512633a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784258932; x=1784863732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oGQyhCyTFOfzEilNh6DtlVyB434KQJA8Hb/vNH9xhho=;
 b=eahHPxWvYhl+PvSUKsL0TryNoiH1U+j0N0WbvpqDD5RaCzlKRRVzwzPZ9CP1mjXO80
 VOhRkcl+AkgE8105PxgIRO29ImDCOZYul0hXsoYjL6HhG4JWDdO5woTHG51WaIlBb6AJ
 na6ZwFhG//5IemvSIiN5T8g/TUQ5GMpwFz4Aj9YrlqBsyd5cBWJ8M/nBEL2l3BCYEXII
 OHk1gramox8lu3zpOxFypHuGwDq21FjDdwsb1xbKkp/MIEsve9k6Lf8jfTAgNbw7XyqS
 Av8LD0lpTxXTjXP+wTA5ZK+XFQZgbOEZbrSGI8uuId8+yXGp8LkWZT8LOXeD8cyf6a3H
 jVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784258932; x=1784863732;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGQyhCyTFOfzEilNh6DtlVyB434KQJA8Hb/vNH9xhho=;
 b=JtuLkYOTiu4GfGhM7qgjOxaz8KiW4kPE9JPj5ErQ5uMoF364j8+xizil5QQbqWHrfJ
 B/+V2HyWx5gHXLubnJfnJXNdM15R2YDDMj38M8aQOemKSELovg5v7DKUspC9KYo6E1rL
 ipmJhsN64vNJ4Sex8Lf64fv8FmQKLCHvQHQEcIdE8ctjegN+93Dvb6w3T/FrBpyF4hHE
 V1bWoYO++25Zo0Kg8HyWhsBPKl43EvOj24Cy2c7teCa9ko3N1aCWY6+vTSOXP8nGApzt
 +h3b9nJoZPTKV81/ePq6cmqjWpe0BuObx6PKJoenmPkCgI4AzgeU6h9G9pP6soVYgOlR
 7jLA==
X-Gm-Message-State: AOJu0YySm9dvYXLmedM+JrpuPEMu95+edVo2+l9fjJXde+sR1wDMO6D7
 Dy1VH/P1Tqd45KfjlZS32HqJTczGoix0UhsWOaZ84RjHX9PMe0qtHK5DkVcWwHynheSsUOmoGbs
 Rh6xwz46DH2ibVi8pdwXf25bZVYcd9uyx9i5BRnhaVEl4/lSPDTMMHB7JKeky3mNSfPE3ATE=
X-Gm-Gg: AfdE7cklvHHgldlP6TYdZGICNwuCjnbvTHrT0TBHE/B77zug8Na2w7r7j9xcARlUDER
 d/a2sDZvMfFdDYL2DyiDP30JWpFyQpU14XRRrgcxBVfc3ctxYcTSHv04qdfA4kTHaQKNMdWO0gz
 nhHu31005AamSWuAneN1rBQpsCHMARUQy4FzL8I2DDv6Kklxfl/LxJsfTnOe5hCJuOrALBZZu4y
 y6ttPIDjSkeWBRB5rxHZnOY2YHh3cqVNC8t4btcVrsfRNBxs3UQVze+qO43QTsW5X++KBBpcUQC
 isRObBZF1cO7ChtBnaQBgjqQle4jjt+suGU4Qxw1RhwON2sUhL6CabWMP8+J9hQn6AkThoWZ2lt
 CcMtoyMAWmj7MbJIRFx3RkJrN6P6YNnge2sHP/I3xb+IBrat8C3vhF0e+84p3BKc6l26PM+q2
X-Received: by 2002:a17:90b:35cc:b0:381:720d:240 with SMTP id
 98e67ed59e1d1-38e4b446fb9mr806530a91.14.1784258932422; 
 Thu, 16 Jul 2026 20:28:52 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:381:720d:240 with SMTP id
 98e67ed59e1d1-38e4b446fb9mr806516a91.14.1784258931889; 
 Thu, 16 Jul 2026 20:28:51 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e4b22bf63sm281893a91.15.2026.07.16.20.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 20:28:51 -0700 (PDT)
Message-ID: <cfef008f-6b25-4630-8571-573be8156233@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:28:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/15] drm/msm/dp: pass panel to display enable/disable
 helpers
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-15-ea04113e8233@oss.qualcomm.com>
 <20260609101330.8E11D1F00893@smtp.kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260609101330.8E11D1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0sb-_XZCSXbSAN9YTOlk8ZICvaNZSmcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAzMCBTYWx0ZWRfX7Q8YbbxIDu6d
 0a3Z9ynNV+J2FtE+50Z8UQF+uIL0FQZudmihJlN0Z5gG9blNZq4FaeK0oVDWoFD3OmWYgaz/dYw
 EW2sc+v0+HIVxexGWOoNcGrVcYnug1UUzddAiugAiJhzE5vOWEjfPhGQ9pcxqSq7iurfJAyHxHG
 TnBR4jlHctR9DiXqCcSarKRA4W39o3wuDFS/rg4v5C5ELno3HoV46nUxUK4gNk2lj6biivJqD8D
 7hz+zEFixfDKlriryXtjA3ydfyws4m8MWZ/l4L379HSk6+IR5z/RyqLiEnDqkZtkTyRT4i47Y9f
 o5O5OEq+6bMBVSdr7FcH6QHn1ZQ9DjUT0XqWPpboYHLJ0iNaZqvxfQL7/CC8/fE2S/fBGFl3H+k
 NQp3CAPqSK2w9UeW+Ot1MrGJefYhwOIwbQiscy3MfoDCiLis5ijDwwrz/rXqHdO3f5VF2JZcSwP
 Fb84WOpJXDrnWMCvI8A==
X-Proofpoint-GUID: 0sb-_XZCSXbSAN9YTOlk8ZICvaNZSmcs
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a59a175 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TcVGpIbawYuZJHNPIbUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAzMCBTYWx0ZWRfX5KtVwqk8K7+5
 zkAoEMZkLHbVKQqxME92xyPSf9quFl12LllJ3NAWdvYmO2ZqLN0AnYuVl3bwi6s+Oow4+aK9vSG
 xP9mDZNwcOBnOISV0UsOLlTYhJpT/LU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170030
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



On 6/9/2026 6:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Incomplete refactoring in `msm_dp_display_disable` leaving `dp->panel` usage.
> 
> Pre-existing issues:
> - [High] Missing early return in `msm_dp_display_atomic_enable` on display enable failure.
> - [High] Sleeping functions called from atomic context in `atomic_post_disable`.
> --
> 
> commit a04f2001a63e30ecc08234abf0151576d165e356
> Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: pass panel to display enable/disable helpers
> 
> This patch passes struct msm_dp_panel to the display enable/disable helpers.
> This aims to make them easier to reuse for MST stream handling.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 03320071fc077..888ecf34f1602 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> [ ... ]
>> @@ -707,20 +708,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>>   	msm_dp_display->audio_enabled = false;
>>   }
>>   
>> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>> +				  struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>>   	if (!msm_dp_display->power_on)
>>   		return 0;
>>   
>> -	msm_dp_panel_disable_vsc_sdp(dp->panel);
>> +	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>>   
>>   	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
>>   
>>   	/* dongle is still connected but sinks are disconnected */
>>   	if (dp->link->sink_count == 0)
>> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> +		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
>>   
>>   	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> 
> [Severity: Medium]
> Will this disable VSC SDP on the wrong panel when reused for MST streams?
> It looks like msm_dp_ctrl_off_link() still operates on the primary dp->panel
> instead of the newly passed msm_dp_panel parameter.
> 
>>   
> [ ... ]
>> @@ -1437,14 +1439,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	rc = msm_dp_display_enable(dp);
>> +	rc = msm_dp_display_enable(dp, dp->panel);
>>   	if (rc)
>>   		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>>   
>>   	rc = msm_dp_display_post_enable(msm_dp_display);
> 
> [Severity: High]
> This is a pre-existing issue, but does execution proceed to post-enable even if
> msm_dp_display_enable() fails?
> 
> If msm_dp_display_enable() fails, the error is logged, but there is no early
> return. This allows msm_dp_display_post_enable() to proceed and configure
> hardware features like PSR when clocks and power might not be properly
> initialized, which could lead to hardware timeouts or unclocked access faults.
> 
>>   	if (rc) {
>>   		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
>> -		msm_dp_display_disable(dp);
>> +		msm_dp_display_disable(dp, dp->panel);
>>   	}
>>   
>>   	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>> @@ -1479,7 +1481,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>>   
>>   	msm_dp_display_audio_notify_disable(msm_dp_display);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this call sequence
> sleep while in an atomic context?
> 
> msm_dp_display_atomic_post_disable() is an atomic commit callback, yet it calls
> msm_dp_display_audio_notify_disable(), which can sleep:
> 
These callbacks are DRM atomic modeset callbacks rather than
non-sleepable atomic contexts.
> msm_dp_display_audio_notify_disable() {
>      ...
>      if (!wait_for_completion_timeout(&dp->audio_comp, HZ * 5))
>      ...
> }
> 
>>   
>> -	msm_dp_display_disable(msm_dp_display);
>> +	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
> 
> [Severity: High]
> This is also a pre-existing issue, but does msm_dp_display_disable()
> similarly sleep in this atomic context?
> 
> It calls msm_dp_link_psm_config(), which acquires a mutex:
> 
> msm_dp_link_psm_config() {
>      ...
>      mutex_lock(&link->psm_mutex);
>      ...
> }
> 
> Calling sleeping functions in atomic contexts is forbidden by DRM/KMS
> guidelines and could lead to kernel warnings, deadlocks, or system instability.
> 
Same as above.
>>   
>>   	msm_dp_display_unprepare(msm_dp_display);
>>   }
> 

