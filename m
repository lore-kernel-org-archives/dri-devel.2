Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21273C44512
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 02:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA8210E3FD;
	Fri, 17 Jul 2026 02:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRYI2ZIg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8Id+si4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092EA10E3FD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GNIxhu4051009
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jiHqrvT+mM6D6jdKW6Gxav0qmC++bQtkMzZTkAbIWzQ=; b=PRYI2ZIg/BCe0QKH
 bV3QYjRAbVe90C9Nu5MQgruDZwtwavnBfHaKNBvV3HbXUD8Kivek/lKmQI2+fa5y
 BIrsaaU0y/gIMci3CqWpzI3CbrqUrB3mO0ZZ3Ccr7TfIY8st8M/ahKL+xPJKzv/4
 n4rAW8d0/GTKLy2Dncazo5RR49U0iJ2vTCeyyxFTNEUhoF+LIH5jzBAgOihCboE3
 +ZlbawMoPTeCJxnhJHNlFvyGT/l9iGn81xZ1E8Lb3OP1knJHhYgRe5nZtzINUQwA
 0JNQQvm8Rb9FoM9KS4zEb7IkRc0CR2MhEvDresY6A2o2nNyxRHr8RKmXE7Q4JrG/
 1/1xeA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1wea8h4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso9638074a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784256102; x=1784860902;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jiHqrvT+mM6D6jdKW6Gxav0qmC++bQtkMzZTkAbIWzQ=;
 b=c8Id+si4rSjLl5Ge700Uecamv/FA179aD0ZLMrehzu6h+IbM0n3m95Rjtx8o/lughB
 SMsmxqwPwZKY2KCmZ1bhAZhZQK3gSKakM86AINyDjuWaytqCKqAfhXsmKAW55imRnwfG
 /LYlH23Yf+JfGaW5PwNiOhaf/hjPk9PX+iVXyNauRVbMwoQLyrpH4S9i2jO4tEJ6J7g2
 k0ty2DQoVFIlAiv0JKoNHJYMdusC3jfDv05xA/0GhyBdbpFeYlaSEFWQGKWtwO31HN1K
 J/XAyBIzQ46lz1Yl2+sT/NUETEwvKZrxc+JGxrSiLBRis5X0vHhT20+XsZUQRcVi97o6
 pn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784256102; x=1784860902;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiHqrvT+mM6D6jdKW6Gxav0qmC++bQtkMzZTkAbIWzQ=;
 b=XvdodpA4xgYB+xkJCcG98w5X7YKx38PHrae7hwd9aTWTYMm0AqUbxWLXmnfBSZj2pl
 y6FgCLKI8uXEMb8yYfoSjePzxnqQ6x3Pl9XXGewsioOYtoRuKxYU6Frqolb6PsNvDvwo
 4IRLuJxuXncvsGldPyMA5mncrx9vnCn8ZGdCvVLIFcbX8xqrp/PpDwerev3Xr3ANNiQq
 zMQwL68k5AA85c7uuTAo4Xcf0mAnF1gMp3dt8ok/0DQWYVevOaEr3xyDwoU4X79YlBHJ
 LQXHfM4GYhQ/PwiBKZsEsR0Y0Lz/mWMEbLbCe8zbe+gvJd5Qzds8do79TdmEXDzHtjCa
 zESw==
X-Gm-Message-State: AOJu0YwFWAZVJJCP35C1v7tUxNJy71TU3OBv2YJdm1th7ZXEJ5EUkw/Z
 U8eH68OS26OQ1xU1KElhCIsZVJhTFNLkI6+x/gFjxc+bg5USGGv3oAerpsEARumhqbPwHbwM7vg
 T7lwqqWGso2wEsYHL0VQJJtxm0/esqNPpDt8Wafijpxo+O2eF1fvtpnCM3Z9w4+Pjh5d0DU8=
X-Gm-Gg: AfdE7cnlNLGwOVWtc/7IyueQagxeyg7kulDopWRkrlNb2YamjPjAaNNG3XOxdN/+bdW
 cIKqIXatH90oJMGYnOVOuJMMo7TK7z61cXoBqVA+Z0yp59yE4KxNTKjCFPjsbGezlcc0anBTsMo
 0FwIhcq+yNcTx1PzThbdqItatEYDeUzCkjOZh/PeNLZA6gSkqagBCZ8+iIOSjvGUCBgPtxALjqF
 sgeG44+rMk7Q4vRlaToyWZfCQ8vWqPV5pjfULVyzwktEZQlwgZAVE4Ch9s2RguZG8uRqzW7rWw5
 u9Q6P9W+kEffxMDiZG6bsnQPLwa2kwIE/CS7M34KTM0wjKU1tE6/E/cnQQ3f0+YhsBAM3dtX/IN
 3pcPidO9CeFYqh53HrjG5M8Ai0UfEf83j6rYcfJJ1cwkwRuZDtVYu6nlbWUGgqmGkXgVUMJHk
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:2843 with SMTP id
 adf61e73a8af0-3c3ad97155fmr668974637.50.1784256101620; 
 Thu, 16 Jul 2026 19:41:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:2843 with SMTP id
 adf61e73a8af0-3c3ad97155fmr668962637.50.1784256101157; 
 Thu, 16 Jul 2026 19:41:41 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb519aeb69csm151310a12.20.2026.07.16.19.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 19:41:40 -0700 (PDT)
Message-ID: <e997f350-df80-4ab0-bb94-462ac5ed2232@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH v7 08/15] drm/msm/dp: break up dp_display_enable into two
 parts
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-8-ea04113e8233@oss.qualcomm.com>
 <20260609095951.B0A1E1F00893@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260609095951.B0A1E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX+EjMpJPx83nv
 UV5X/iRr0kdNhOOeJLFXUk5esrV77bJc6NjCqn0KZpRGHx/tmkyblPVlIQVUR9wgBIeZ85aXPUo
 s1sXNtBkotgGMn9nh4LOuvkDaa9muQyPT9fBtyyahJQvXr9cB1GN4BPd2k4cEAcnIomXsq/PNX9
 oWa8FTxGkQLQ5kmU+bbsiamBXxpbv2GW+wLTqJPYpDmODhx7NANbDI7EP1dS5xPi6m3EANTNCfx
 +dECQ54mPsr8cKNgiJx2sxY4WwUlbZWcgZ/K4SLd1fgmiuGh79GktJsIVBXNiHyVhshnU6Q25L/
 yM9P+vxWoDwrqBnYoeLP6ULSR2ZGoi3bwLqLOfsixTkbr9Ws6z9qZqz7situSFd4A7kgImHOsPV
 OOGLDT7nLmRsDuGSsjz52ArjDwyVykxvMN4Q3vOOLfJZDBq6fJigPvlGl/a7Ao2mgUM0IJwO7jC
 m6K5J6tEbNMQ7g7O18A==
X-Authority-Analysis: v=2.4 cv=JJ8LdcKb c=1 sm=1 tr=0 ts=6a599666 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Y219pdqfsrRzYske1R4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX/9XXawT73jmn
 yqyPRwgJOD7DjnMRKM9IpmE+p5OUvgVTnMBK67AO7eOyrwlImLfnlo9K7TtaN7bZ0KgEAprTXPo
 FSw27Uzm+hLB1pI0h7IzR2swltpzaL4=
X-Proofpoint-ORIG-GUID: i0gzA2QihyHESns7Dfh4JsHQJ-MMLa6l
X-Proofpoint-GUID: i0gzA2QihyHESns7Dfh4JsHQJ-MMLa6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170023
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



On 6/9/2026 5:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Missing error return when sink_count == 0 leads to unclocked hardware accesses and kernel panic.
> - [High] Missing early return when link training fails causes stream enablement on a broken link.
> --
> 
> commit b8a02a483af0ac409e7c1790ebfbe296067ea49d
> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> drm/msm/dp: break up dp_display_enable into two parts
> 
> This commit splits dp_display_enable() into two parts: prepare and
> enable APIs. This allows inserting MST payload functions between enabling
> stream clocks and programming the registers.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 155beefdfdef2..2cf4c984c7ca7 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> [ ... ]
>> @@ -617,7 +617,40 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>>   	return 0;
>>   }
>>   
>> -static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_link_train)
>> +static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>> +{
>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>> +	int rc = 0;
>> +	bool force_link_train = false;
>> +
>> +	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>> +
>> +	if (msm_dp_display->is_edp)
>> +		msm_dp_hpd_plug_handle(dp);
>> +
>> +	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
>> +	if (rc) {
>> +		DRM_ERROR("failed to pm_runtime_resume\n");
>> +		return rc;
>> +	}
>> +
>> +	if (dp->link->sink_count == 0)
>> +		return rc;
> 
> [Severity: Critical]
> Does this unintentionally allow the enable sequence to continue when the
> sink_count is 0?
> 
> Since pm_runtime_resume_and_get() succeeded, rc is 0 here. Returning 0
> causes the caller, msm_dp_bridge_atomic_enable(), to continue directly into
> msm_dp_display_enable() because the prepare step appears successful:
> 
> msm_dp_bridge_atomic_enable() {
>      ...
>      rc = msm_dp_display_prepare_link(dp);
>      if (rc) {
>          DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
>          return;
>      }
> 
>      rc = msm_dp_display_enable(dp);
>      ...
> }
> 
> Because msm_dp_ctrl_on_link() was skipped, the DP link clocks are not
> enabled. Will the subsequent call to msm_dp_ctrl_on_stream() within
> msm_dp_display_enable() then perform an unclocked hardware access when
> writing to REG_DP_STATE_CTRL, potentially triggering a bus stall and kernel
> panic?
> 
>> +
>> +	if (!msm_dp_display->power_on) {
>> +		msm_dp_display_host_phy_init(dp);
>> +		force_link_train = true;
>> +	}
>> +
>> +	rc = msm_dp_ctrl_on_link(dp->ctrl);
>> +	if (rc)
>> +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> +	// TODO: schedule drm_connector_set_link_status_property()
>> +
>> +	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
>> +}
> 
> [Severity: High]
> If msm_dp_ctrl_on_link() fails, does this mask the failure and force the
> pipeline to stream video over a broken link?
> 
> In the original code, an error from msm_dp_ctrl_on_link() would explicitly
> return and abort the atomic enable sequence. Here, the error is logged, but
> execution falls through to msm_dp_ctrl_prepare_stream_on(), which often
> returns 0.
> 
> If it returns 0, the caller receives a success status and proceeds to
> configure and start the video stream on an uninitialized link.
> 
Will fix it next patch.

