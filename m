Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B25C4450A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 02:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CB610E3F1;
	Fri, 17 Jul 2026 02:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnaJ6nlR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aaod3XdW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380AD10E3F1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GNIZ6E010484
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N7rCpjkWjlTwa6LsILuSxuuEsyS7uwwCqw43dM9nNM4=; b=dnaJ6nlRIKpYPq5N
 ivwszUVgsaPCbrvwIP+PMBAioomdOiDsanBXB1et8cyxI8ZosPTt/d4DuZnl2ifw
 pUU+3gGz3OSQAaz8MkzCb0hIYY3K3xXaXX09H6IL51RxqoRzn+cNKeQ1COltbXPH
 dm85nvHXKXriVnTP1Z9SU92JS8AByvNp3sRbe3NUdeS2+KFECqNp5GjVIqzopHFb
 TaKT5G+lDRy+8QTbevs2VdYXHWE2gQM+a6x5afdq8q55mJ6w2OIp4+ShhfmnzCPT
 TJ+YbPEkxRu0IKZapxpr87Mh8OMaK+qCJqWCri5duv0XMveKZyZgzVfR5oTrmS/I
 ev5Gaw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex47st-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so14210966a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784256064; x=1784860864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N7rCpjkWjlTwa6LsILuSxuuEsyS7uwwCqw43dM9nNM4=;
 b=Aaod3XdWvWrEXECO90RUMAsFdzzBb4BX10ckoIzrMWpUW47uj6VsDv2mhqNB9vl7CR
 oOcQy2yP5e50mwKZ37p8B16BT0mEFI3jHj/iXjmrh57fIhu9hnJCsh2okcTG/K+KUhrI
 GInQJq14mPCrDwuXzoEd9s/jnzLi+rWBm3y8D9ufSsRV6SRZmbgP0RB/dshZgNyI8EeB
 grBBlnjzPboeHpW9l4M07AGwk8FMICvSYnwyhNeiGEEddgrK7S3W30YgVErnBwlgz/9+
 v3fUe0NT/kRoxG2S8bORpeRCjKys6nJCoedxnsmAhpUtMPsYL7tn68lb71CBTPE0Prwn
 yKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784256064; x=1784860864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N7rCpjkWjlTwa6LsILuSxuuEsyS7uwwCqw43dM9nNM4=;
 b=dpGWmOHI40HRV+VuR0EA83SIGT1m1G3/aocQcCUKPSwMc4lvSJAekPXXlXl0RbMCnJ
 SePN+KXbruedPA+Y/T3gSQjH5kg2fWamS84AL/IGXqp8p+DgPc6pTUUHdNzECI6LVS3i
 /tQsTy/3rZOng9G/tAirqDsO8GfrnCCBVlcNWDT9vJauYuL8zSfn947nCFRWUMmO2xuL
 Tj3ZotVP3nIM7BdbaBZJkF4q0MgppmckTNqIPtT2TCY7mHSPMKB0n+uZ8veqcNBNObJp
 8/qMc7OyQl9lmVXuK0mIeiVAb9YgfyDA8rPJu9hfSjDN068385OkuRZLaMpW4PLiwKIy
 ztNw==
X-Gm-Message-State: AOJu0Yxqzc1a1kgIMzjU4wtvLAjVVm0NpkmYiKcMJSBUzun6tGvqI1UR
 hMSDVd+G1nZqGr+FgQnG3UaJ8Iu97MoSg91yXpNiWNW81DSU70N3Na/Be/f1Qt58S+RISmRy1wi
 M8h5cbMQ+Q6kc83Ci14RUenr6CU2gYSUylJPxf2BSUN+MkVIGfWugkuMjW0wBt3c9lDHpv2XLiA
 BqOjs=
X-Gm-Gg: AfdE7cmlySjVadZDLcborjt6t02zkEwGPvbQeNIGkkEL7SWVIUlikHz0OLly8RXexWE
 Wmm1S8g/fPq3TCjyb0ikSHK4ZU8G+TjQWsy4c1JW3pbWV5+rz/gpja8vwjhWZnqlVbjOGvGStcw
 LOvED8JxY6kak8oIgJwY49nlu+gxYtrQZH8O5p2qvoXrXJ8XHQWgON4S5pB1EW5pu7iYjwV5Cm8
 VwdXAedDi6dsCWc4A1IMivN9HsvW0UnOlZkiKLu1bUwXeO4EvA2P9pXKtYPhd1I4qtTs/RF2re7
 sxApPXW6uTkRwt0OFCo9Geg8eQE328TwvSCiAJEuFxyEU6XAubm8mbloC3s3G/hM2+1dH3AoHgp
 Fs5PO4LcdUTSezjXkFvJEhdgWgNWfZLZK6r1MIzJcHdXSDpax120oL8XzB41g5YXuNRZmdESE
X-Received: by 2002:a05:6a00:32c7:b0:847:8250:2b2a with SMTP id
 d2e1a72fcca58-84c294dc10bmr573280b3a.60.1784256063923; 
 Thu, 16 Jul 2026 19:41:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:32c7:b0:847:8250:2b2a with SMTP id
 d2e1a72fcca58-84c294dc10bmr573261b3a.60.1784256063428; 
 Thu, 16 Jul 2026 19:41:03 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb519ae8690sm150093a12.16.2026.07.16.19.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 19:41:03 -0700 (PDT)
Message-ID: <996db256-91fa-4ace-bc1e-b43e45bbc9a2@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH v7 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-4-ea04113e8233@oss.qualcomm.com>
 <20260609100433.E45DF1F00893@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260609100433.E45DF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a599640 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1nfiX9nEXZiYykqwV9AA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 1jZm4-TxxwnWpQf2beHlK89tmzO2epux
X-Proofpoint-GUID: 1jZm4-TxxwnWpQf2beHlK89tmzO2epux
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX6N3l5Q15P2Qb
 Fa+6Kol+/R+Nfi72U7F3zqGio+HOdxQLpYkrq3VfwWTopTz8mC6u5EmqaWBLvUm+EsQOimGO50e
 q99YlwSouspEOiH16pirlc1O7dON7cc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX+fJfc5Qa4uPd
 bvLgW0MQ+wn3vx8fK1IcIoxpG+aiK3NOBAj1hnJpMTnm+7eiwYD9o7aDynM6gry047qS4G/h1Ub
 bMyVX6ULmCNNx+IReJn8O/U6QqjZUJSrJvi0UdXCqVIMRY3btDw37T2ZD+W7jRNqrfZTsrHwqdx
 FagdvslY3UMEF1zN6ykLN/7h1NtrCMMly1r3NNu2emIe6yxN9wI/CFUmOd0P2S8b9RsymzhjlbE
 oobVQGqpb50br1owovpGGteAZqQTWTPso0RRugIxDTbFWABLpLvDPMT1deyhCZBM3FFS9IGMDdr
 SzOQwAXOrZoU2D9jgXgzQEI1gXSG0gfI7WRVLqIG2uNOaBfV7NuJfgbbrk7dtpPPq/QAHXLoza2
 x/YHni6jsRQBz1zOS/uvybnr9XfpcwjRJsdbi89jrrE8pI639XmBgULgTIi0jUXVLERfoHuX4Fm
 ogEOBImKEYico32BGBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
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



On 6/9/2026 6:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Splitting `msm_dp_ctrl_config_ctrl()` causes stream configuration state to be permanently lost during dynamic link maintenance, leading to display corruption.
> --
> 
> commit 83fda55d30fe1cd098ad8cc76e151a0398a09b6a
> Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
>      
> The DP_CONFIGURATION_CTRL register contains both link-level and
> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> all of them together. Separate the configuration into link parts and
> stream parts to support MST.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 86ef8c89ad443..ed2ba47881fd0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> [ ... ]
>> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
>> +{
>> +	u32 config = 0;
> [ ... ]
>> -	if (ctrl->panel->psr_cap.version)
>> -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>> -
>> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
>> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
>>   
>>   	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>>   }
> [ ... ]
>> @@ -1628,7 +1644,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>>   	u8 assr;
>>   	struct msm_dp_link_info link_info = {0};
>>   
>> -	msm_dp_ctrl_config_ctrl(ctrl);
>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
> 
> [Severity: High]
> Does splitting this configuration cause the stream state to be permanently lost
> during dynamic link maintenance?
> 
> Before this patch, msm_dp_ctrl_config_ctrl() programmed both link and stream
> parameters. Now, msm_dp_ctrl_config_ctrl_link() initializes config = 0 and
> overwrites REG_DP_CONFIGURATION_CTRL, which erases any existing stream
> configuration.
> 
> While normal initialization restores stream parameters by calling
> msm_dp_ctrl_configure_source_params() after link training, dynamic link
> maintenance paths (like msm_dp_ctrl_link_maintenance() calling
> msm_dp_ctrl_setup_main_link()) perform link training and then transition
> directly to DP_STATE_CTRL_SEND_VIDEO without re-applying the stream
> parameters:
> 
> msm_dp_ctrl_link_maintenance()
>      ...
>      ret = msm_dp_ctrl_setup_main_link(ctrl, &training_step);
>      ...
>      msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
> 
> Since msm_dp_ctrl_setup_main_link() eventually triggers
> msm_dp_ctrl_link_train() which calls msm_dp_ctrl_config_ctrl_link(), will this
> result in the DP stream coming back up with critical parameters cleared (e.g.,
> 0 BPC, no VSC, incorrect color format), breaking the display output?
> 
Will fix it.
