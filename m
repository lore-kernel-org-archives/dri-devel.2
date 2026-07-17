Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA0FC44512
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 02:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A156410E405;
	Fri, 17 Jul 2026 02:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUGmOFV8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UX31H04h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C45510E405
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:42:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GNIlXa3897151
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E5PcsKP8MMsqwKd5TU75FBn8OJDje6C+VZryog6VtDQ=; b=OUGmOFV8X/X65iEl
 xTxqo+/DSYttxR3DbBG+nenY+wtH4Cyl6eHyQLMA538PBZ6FMmA5DY4GlJBWgSn/
 kDRMv8U4rPdIcYhiDEQ5N0G4fDgnpkazvDQZz5w/OCwDooTh/fiJAuiXMRCze3OC
 rRhAI639HxNlvX2/PUwgEVh4zRy6a9jyOLAVsnd2omDDyYeXJDon4TpX27fzJoN0
 Dllxv0mJELSmocm/KmWNtDDoTo8UCuChGFRwnz5IaxMmdPlZEJ6HvvRf+cOL3td0
 db8setEFfeBmKEM0TYrO+fg2b11Zrzvv/8ofSUxThUTf4X+vlkPCGDBNpfOKgk3E
 c2kOPg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9jb4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so98570275ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784256119; x=1784860919;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E5PcsKP8MMsqwKd5TU75FBn8OJDje6C+VZryog6VtDQ=;
 b=UX31H04h/IjzOj7ur9li8xagCMjLqGEo50OQxJqHxFRl/3YCwCadSSKZEnjCfIw24K
 PEv7+n4EphbhHg5srOX3kMFiR9oGJXv+g5CxbOoCPmJ+z3RqZN/Q6P019Cn2kYkrkhIk
 Oewl7q7N7vjerUkocBjUXotx+7Ll0tJDYbQlcmTCa1QqixYbuapO1NFY59I+9+Uxo2F/
 XC6c4tRRjB8QP2ZQneiDdrr3Xp/4CchtEiegm7Q1reCuv2if3HEtNDcyvDGeoFqamkCI
 vNtxmMeZhjGdP+xIojiOkmXqacwzRTh3wliFWUhCy8BTNePDl/frHowHi+Xga6/2RJS+
 pp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784256119; x=1784860919;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E5PcsKP8MMsqwKd5TU75FBn8OJDje6C+VZryog6VtDQ=;
 b=fSHX6BsJx0tSMjk13Vx+DnARfTs2KtcqjGfLfHrz/doB4+ZyQaN2di4im7rNXDLXaO
 o1D7dzVaJp3o2N2eBzLikLUmvzy3Y5KIk3XXEBpt7DO/2uP3B4mXqrOQBsHnIJBWxCLj
 wsWoFWXy2nfErAe1jgn6o/9/sS4CAvCGWUso0CN7egTMzU7HY3OhGAfX22NY5qI4fPBQ
 zK5DJxwMfktE/UmYnLt8JptHZZQ9O4BnunpidFKYpACvoaty2RNNW/ag51vuLYGdhvFm
 pI4yR53vJeNAQehFLxG3D/H4Uya5piKf6j1t3yr06aP6mY2wZYHpVAblTc9LBBR/oysx
 UMMg==
X-Gm-Message-State: AOJu0YwxZfdbiKZ58mKLI9czHMQvFwSraM+VTc/ugxMiglkBduM0HyQx
 MCWbvQ1o3e8ROhwOEGcTlb2X6AiAZ8b+IdbRx2jRmiLyYollKcE4pDAGmzPZ6eV2VJR/G1PC1tu
 CafN1hFPJcPQqzY4hwTepPzId3Zknmno6laPd7Y2MXeZLbkTeSsnw39WGIKtP7D4pn4DMEo0=
X-Gm-Gg: AfdE7cnb23fvolRT3GjSuabac2nGFMbnuZ8QmiqWNK2XjTzHYA5hwj5XFnEAKGYFGAX
 3w3VUUO4uPq3cOaTYybYRErKTBE5G6PAP1sVYBMZgDiDDCcZBz/0HQQMs8mN4IgHgyZXjPdk5mA
 42jnT9yUSgfgNcsDEOoJYJ+XpcRaC7Jpffth2okv2pmNo/zh7o7XeWLhivhdSGLZ0SDwr9n8q3v
 HVC7YqVqVxaqPXGGPnNygRcxShtfPwkr968Q4blrZ84KNPasm0qm7gIJdi910M/VnCNH1+vMSGO
 JxoAQMSTArpASPITHCuAw3NZGoUOTdKvH878D56bJ7+ItksxyZnHpIEV+oYMGhD0jaStJ5vYCde
 LM820p0NYvqhqyySwe0dGZ5j+dap8l1rGXUSdxr/mcKVAWoVvhUDCZkFi1OKoFBWc5LaKXMRh
X-Received: by 2002:a17:903:1b03:b0:2ce:d957:59c6 with SMTP id
 d9443c01a7336-2cf349bbf7fmr6773595ad.30.1784256118682; 
 Thu, 16 Jul 2026 19:41:58 -0700 (PDT)
X-Received: by 2002:a17:903:1b03:b0:2ce:d957:59c6 with SMTP id
 d9443c01a7336-2cf349bbf7fmr6773425ad.30.1784256118176; 
 Thu, 16 Jul 2026 19:41:58 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347166e6sm2267625ad.59.2026.07.16.19.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 19:41:57 -0700 (PDT)
Message-ID: <09e28aef-cee6-48b7-bd8f-74cb7c4c0eb4@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH v7 12/15] drm/msm/dp: simplify link and clock disable
 sequence
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-12-ea04113e8233@oss.qualcomm.com>
 <20260609100223.4726E1F00893@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260609100223.4726E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a599677 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7szLq90EWCkCOodppdgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX5V8JGEzwMw2a
 gJTm4ToQuUxDO9dFK79KmrRJ9aJW9hFa9OcFPC+0w3gX7Bcrxm4uGSrCQ/g7skOuiZGGCjU+9Cp
 r6sZvgGtO5vQtSZLm7YSS/YHmwq9PiKkxgveJrdUyJ+Oijiw0YxB3X7yZ6zO9JK//Ko0Fp51A0S
 4jgTE2iQ0WmD1j6oA4R/Ta7Dgd/H+/UWBp6hq1ozC4ZcVUEkuSv1sCkb985Je6h1pNCkM/fMRaE
 rEar8sWHpdzcFl8UZhwarbXJeMjtI0QI+YheQqpxSWhih/0kSJWIh2U7oRvRr/u/QnXIkqGK4aF
 lu2notDEwNN757TYgY2A3/jMyQ8lmvT9HxJZcCjG3OyfzoPd7bVjrk28vM6o7ze9Wbm3C3c399M
 75XtJiJ1D+7GM9XCPyFPnUfgZNFOgSm/R9W71k/9FQcLJNoe9I5D1iSr6f/UVOOk3NAKEZcytci
 a1V7K51wymsOPx/UFAA==
X-Proofpoint-GUID: yQjRjqX0E5GRFocTuzR36LH0N8L5NgD7
X-Proofpoint-ORIG-GUID: yQjRjqX0E5GRFocTuzR36LH0N8L5NgD7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX8XxyuzZ/A6Nt
 NVHCAEYJpJG+iMTBE0BsSqghXPXKGEhEiIGSLw34kpKGp3UvdYJQlHJgaQJTBHzN1sf3LMk1PaI
 HGdhcs41kJj+8tnLR7SC6WxHtTDufX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170023
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



On 6/9/2026 6:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch introduces a Time-of-Check to Time-of-Use (TOCTOU) race by splitting a single `sink_count` evaluation into two unprotected checks, risking an inconsistent hardware disable sequence.
> --
> 
> commit 4b86b22d6f1aa41eba1cece8a907cf0b3a12b55c
> Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: simplify link and clock disable sequence
> 
> This patch refactors the disable sequence by pulling common steps out
> of the sink_count condition block to simplify the flow.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> [ ... ]
>> @@ -716,27 +716,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>>   
>>   	msm_dp_panel_disable_vsc_sdp(dp->panel);
>>   
>> -	/* dongle is still connected but sinks are disconnected */
>> -	if (dp->link->sink_count == 0) {
> [ ... ]
>> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
>>   
>> -		/* set dongle to D3 (power off) mode */
>> +	/* dongle is still connected but sinks are disconnected */
>> +	if (dp->link->sink_count == 0)
>>   		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
>> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
>> +
>> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
>> +
>> +	if (dp->link->sink_count == 0)
> 
> [Severity: High]
> Could this double-evaluation of dp->link->sink_count introduce a race
> condition?
> 
> The original code checked dp->link->sink_count == 0 exactly once. By
> checking it twice, if an asynchronously processed HPD IRQ event modifies
> the sink_count between the two checks, could the driver execute a
> mismatched hardware disable sequence?
> 
> For instance, if sink_count changes from 0 to 1 after the first check,
> the driver would perform msm_dp_link_psm_config(), but then take the
> else branch and call msm_dp_display_host_phy_exit() below. This would
> leave the PHY completely powered down, potentially breaking the ability
> to detect future dongle disconnects.
> 
> Would it be safer to read sink_count once into a local variable and
> evaluate the local variable for both conditions?
> 
No. Here is safe. No one will update it when link off.
>> +		/* re-init the PHY so that we can listen to Dongle disconnect */
>>   		msm_dp_ctrl_reinit_phy(dp->ctrl);
>> -	} else {
>> -		/*
>> -		 * unplugged interrupt
>> -		 * dongle unplugged out of DUT
>> -		 */
>> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
>> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
>> +	else
>>   		msm_dp_display_host_phy_exit(dp);
>> -	}
>>   
>>   	msm_dp_display->power_on = false;
> 

