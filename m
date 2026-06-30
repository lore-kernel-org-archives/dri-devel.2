Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBA1C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACC510E1D5;
	Tue, 30 Jun 2026 11:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCuqERbN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xie1n+/S";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DF010E1E0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:30:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mrlh1542070
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jxuf7nHCMmQB8RVfIW4EjJ6Gc6YS8vbqMU2TjN+Z8FA=; b=FCuqERbNxnT4KjtB
 MhUUyYQlAUeUCim8gETqZ/WBhgJsxN3zYuWqdktUu8aNWighfDNfckvnxphx7P6I
 luuMfpCqcJ5Kg6DZfW8F+V2f+YLI2ew1Vja/b7ESPBYF28jCX2LG5Qg1K7oCkPHE
 P5loEpmpUTDoTXFmXtMlmsLWx7j8jhD4x67m1Tb/Bq61IesRRhMO386pNfv7+q7g
 c7prZqpNaJXiMsyPOZLPmloUxHwupsEqa47vUDoRDuz70uKrSZubkBtXJGFW37ZY
 Yhe6WE8mbl9ScB1bxShQbI8uubHr4oh51Dlbq31Hxudl5k1vLg0GwVHhMDPmdh7J
 U0zBvQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4j6fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:30:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8479cc04d8fso1671685b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782819020; x=1783423820;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jxuf7nHCMmQB8RVfIW4EjJ6Gc6YS8vbqMU2TjN+Z8FA=;
 b=Xie1n+/SiidjdsydmFbyn8n0YoYZMCth9cQyS0VCh5gr+JBmXpmiP62xLKaJuF0Kdv
 NJN+ruebnVqOehJ6NujkPNG9XV3iIUpjAuwYHQ6SxwC2I8I7sbWyTFqVE5R7H7qcE4P6
 W9lAbRzx95p/SjMpCC4WFJvlbiPe94v2qafbTkGr8vps6jOUj2ZwVLARVWs3hvmJRYIy
 0gkIJjYI4JOnLTYNII4yyCGEAidQp8OxCVxwlB5i0hEt62EtHf7pMpOezEgMb2Z94u6U
 68O577Kr7SZG0KNmJUCmlZnm2FedvCuO5kPF9C6gt07c4fW+3DraAPLKiwKI2hXtGuOu
 nhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782819020; x=1783423820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jxuf7nHCMmQB8RVfIW4EjJ6Gc6YS8vbqMU2TjN+Z8FA=;
 b=jcNwTaSfYc5ruqN3Ou+e7v5sLbVdReC7ku7sEgcf/62iR29//3jC32dT2clSJ9Y+3I
 fX8cFaCjuy1DL3PT1X2VkrwxafSFTA7az03Um7PApqI0Y6Kd8wbYw2z4KApXh4dx3UJV
 JhHdTUfVTHacrS1rSaoKqWt/M77ESzp9Z1n0Av9Yz5r3dwg9wQeD/ZZaQ3D8zXlqWmLS
 nEPKqWyrNE8vntNGC6szIXWXVMo9F4K1YeIddG3zNFFcbeCZyvF9UFE9DZPwKY/CAe29
 HkJ2fHFgWNsihRCp4vey/mSqnSyXRk/DKPYFGx0lgdr0M5R0m6PspPme0FNUyRy6tzvF
 QHRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92t19gZQY85uK1bKvzMrGd3FH2lq8HrMh45mVhUre/Xzw5JrAYRvm3jGz1FFU3BEHYBmYpgN8I/Bk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKrvOBcL28Z1qgQnKwVqAp+aofplQQBWDcE//Wr58RWH30YBS4
 hzK5yH39sDiOwiilMxZK6+5qfiQ74siYU1E/xCPFYjmMLEnekXXaSeH/ZWMpxsRWMNpyE64Qb6r
 o+d/PKnyN25DgNPc70aAayfHUhPcSvTYbIg/X1ppfyl6XWIEOUtdHrwySzsYGS3jARkqHqXA=
X-Gm-Gg: AfdE7ck8hGSLypk+Z3nwUVauopUIphaV8FrLNNphUB41hz5nC94LxpTmnXgNYzWl4+y
 Tjm8Bpe04tncPgFAscEtjAGw/AI6gNCgX54X1oYkWNE6qq6jBxg69coO+EBjovcYcBEOdzHjNYz
 pQSyBME6kJk4KQ6RXRknSWDA7+9HWxY8FIP2jfokktCNayuqQm633vzwwKjKMLd05ZMXj7hFNBG
 4Q4h7jHiYaYoVL+NMl2mXanfh6kVzkOVZ5vp89sznBLZOQTVzndoMhw6Psu+hFDvT9QCdLHC7M7
 2SNAnY3nwp7+HNkrbh73r9ZIUZ58B5MlgqB7FrSgyetSLyGeSEd42gdWDgJ2JEt+RMoE3U7/jSc
 RYXvfTj0Z3IPEEtgBqr5iur4GmYKFWF6rMPQBlV9cvX+GS9mud6BdMGCc2PUVCmXeaAz4jBn1oO
 01u4oR
X-Received: by 2002:a05:6a00:22c7:b0:842:5a8d:303a with SMTP id
 d2e1a72fcca58-847adea9b55mr270147b3a.37.1782819019935; 
 Tue, 30 Jun 2026 04:30:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c7:b0:842:5a8d:303a with SMTP id
 d2e1a72fcca58-847adea9b55mr270094b3a.37.1782819019374; 
 Tue, 30 Jun 2026 04:30:19 -0700 (PDT)
Received: from [10.133.33.5] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a039f2c4sm1796908b3a.54.2026.06.30.04.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 04:30:18 -0700 (PDT)
Message-ID: <12f549f8-6365-47ed-9334-7cfdf201cc5a@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 19:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: Skip push_idle in atomic_disable if display
 is not powered on
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260511-edp_suspend-v1-1-128555968d7c@oss.qualcomm.com>
 <mnpara7zwt6ahqkb44mxjtengjodutek35dzax72xuf5i4puzd@tvxhgefvpdqk>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <mnpara7zwt6ahqkb44mxjtengjodutek35dzax72xuf5i4puzd@tvxhgefvpdqk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gOZI0LXj3MjuI9Bmnec65v0aWExYohul
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfX37inkvdR17Zb
 bJH39Efp16lliGe2L/Qa26n74IFq0zFIMu5GW8u2xdvIsaOzan6s1BdAl+BCK3EzClBT1EHenYr
 PvOC8dHYsJetto7w4TJCKwuz4KQfIT4=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43a8cc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Fa2nlc_RI4ObidiIHNgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: gOZI0LXj3MjuI9Bmnec65v0aWExYohul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfXwiJfVcR6FSki
 Kl9cP3Xo0KieqxfYGfo29vBwMTVQ04f7apXlSjAL3pSQ4OGA/R34Ncq//V46xnMxvgMVuxG+qvJ
 9KT2OmV1CXxHTSogYRGLunD8YMF9pe8ZIZp74+lDbch6HITLhgH+EKPFrnSSt259PwKlLW1LZzs
 ozd1b2M9dxUmTkAaDXOj7HT7MMk/A6VswyiPhCT66RW8qYP7Zhv3wGbSAAF7zPDfbNomj4K8a4U
 qdTLFK4HEYF/xIsdCoBKIpPXwQcit6b1lF7IGHBHmq2HXVqJrmHeJ5o3N69z5N1/JHkqa0sXLOA
 RP9mOEEp7SzNnYhnFgcAHsbZ9x2+jIhbwR/nMDA6bNKrKhxizLLmuEIisbeeKqGjugdWITn/eeV
 SsrKWod4jwBtqm47aJKjeK8pf7FbBAgxwP07LuSM/ZGbICur9nkkFktSi+jnkXoSdxGNgff1bG3
 /Tk5Ie1RrmFf8KBVfNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300105
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



On 5/13/2026 9:28 PM, Dmitry Baryshkov wrote:
> On Mon, May 11, 2026 at 04:36:03PM +0800, Yongxing Mou wrote:
>> On eDP interfaces with no panel connected, panel-simple-dp-aux fails to
>> read DPCD over AUX during probe, leaving hpd_state at ST_DISCONNECTED.
>> msm_dp_bridge_atomic_enable() exits early as a result, so
> 
> Why is atomic_enable() called for disconnected bridge?
> 
Sorry, I wasn't very clear. What I meant is that the hpd_state is 
ST_DISCONNECTED when no eDP panel is connected. However, the eDP 
connector is always reported as connected because it does not implement 
a .detect() callback and assumes that the panel is always present.
>> msm_dp_display_enable() is never called and power_on remains false with
>> link clocks never enabled.
>>
>> During system suspend, drm_atomic_helper_suspend() still invokes
>> atomic_disable() for all registered bridges. The resulting write to
>> REG_DP_STATE_CTRL against an unpowered controller triggers a NoC slave
>> error, causing a fatal crash.
>>
>> Guard push_idle with a power_on check to skip the register access when the
>> display was never enabled.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> Fixes?
> 
Got it.
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 1b3cbf4016ef..51b60eb9c2df 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1660,6 +1660,13 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>>   
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	/*
>> +	 * push_idle accesses link registers which require link clocks to be on.
>> +	 * Skip if the display was never powered on (e.g. eDP with no panel).
>> +	 */
>> +	if (!dp->power_on)
>> +		return;
>> +
>>   	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>>   }
>>   
>>
>> ---
>> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
>> change-id: 20260511-edp_suspend-0e45d0110633
>>
>> Best regards,
>> -- 
>> Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>
> 

