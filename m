Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01B3C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3B010E734;
	Mon,  7 Sep 2026 09:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TiRieHp+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OIRH7VX6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E4310E43C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:35:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6878RnsY3872938
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 09:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2pZyG6eb3zzujfssjYHEawTXK0BmQECZw2QbjnCLMKU=; b=TiRieHp+jPF1S6xj
 CDMgOXvXZPDeKtwQlipQYwn/fEOv9Bn/BJnNYwwxUVVnGl73a5OryTSAWtbkKWi0
 0890Y02gV0+o5hVvTafjSO8IGASKpkKwdzE5DDAgFWtJAE/Go3N1NOjUHN21yWi4
 z/P0vghXqYaS2oX1fGZFkhuFyhCgDdIF0NYlWXussx7Srt35/V85V+W80EayA+GP
 0uQzk3TgD3dGEWqFWfqM6PK5idOdTOU0tmAdB7O2IhbNjoZ97Erx22RRUmaw/86A
 xCj86KYq8zI82jrDmc/63YxV+GcXMbD/w+WuY7oB+QRZnVXxJrbOBiyerASPiKHh
 i94gyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg0arv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 09:35:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so8004135a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788773753; x=1789378553;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2pZyG6eb3zzujfssjYHEawTXK0BmQECZw2QbjnCLMKU=;
 b=OIRH7VX6rSAfysg89pg4lle7hGHzvhBxsxHhXo+ZHwJB9yWtkkU4Q1dvbkEDtq7+Ly
 CkbXDAJjS0rOgYeaEd3CkPDMOFFsSgIUj3cKrekR1Dwiwd2udwnaf610f0EGpLT0Jt/q
 POE0bIW9X5nUTM6/SlrOVJ8Q/hC/4rUPuepI/oJ+EYxS2np5ehWylPXj3tMPLkxquV6q
 L8erB9rTDdeA6rgE4HlmiLH8karyO4HcEHlg5FB7Cc9OUC5qZdfXboiyAmlbNTfLlyWo
 /WMwfRvlHKqEtlt+7Tqf4UPB/NybNlZEZn9T1VeeWFWM/WPEjLgBMjkz2WXmqGTuDqxc
 f8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788773753; x=1789378553;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2pZyG6eb3zzujfssjYHEawTXK0BmQECZw2QbjnCLMKU=;
 b=H2fph+kNKLi4tV8xEdtkj0JYplLBXTinfArnp3KxK5UkEmaxzkW5lKycYrFvL57N4f
 nwoOFDi17sHNMIELDe2DsXaJkLotjPcPzhLbIACptWhianHo/ZrGFDRSniRmykFFnExJ
 S2TD2J331GOdreOfHlyAQTtgmxsY1qCTntGQdiRVzmYhyEJ0q8AtuTdxdFq/clIKAf+2
 lG2DkaUsdnY8VhcVXOYF19jGU1rBxQBS6w/LN9spRbd1UBCu/D6j5IlBy82uO6u1FtXy
 lFV9DZSCuyGlQMzNBZ6O3uBf/ZXpRjKOaU0PeEqpA1O/CuDGrBHw0noQzYPqnWsqWVCp
 mGDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGb2DggA+RCoolsStq3bEE8+++Vb/5MIgFHSUqWvpuZKRRV0/3OJyY7co6Jr4fNUhBGsGLHPro6ic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ksc7HemmgEXxEQvpCrKc3VeZolNUKE1gA8xsjzUdZHclFgi2lD
 GtDn1tgxJXdewhDKRgvQV+U2m4X4UCCOW7+IIX3iJXFlBaNF+HJqGs8C5erYsfGk8CjrAGLnTJ7
 kS4VPxTBA76vzqeawYFzG3ItUFMDdYzca6fHtNoZUPhKQkI6nkEpWfFdOBa3dWyw51ZrCMqI=
X-Gm-Gg: AYBFou0zRUW//yCick3CCpzmzuJRWCm2p5uxjb92PWpqAY3Xx5NMahaxxxikCFzlAza
 +h115xRpwJhF8GWzUSXXICmU7Nu6ot8V89WdpZLrs2M2B3UDImeOm6m1Igi2A2nF8J9ifzRwd7e
 RA2yHM2qc6nFc5JJoywxWb+aiNYc3ykkMvkGXwSgKor4VFd0lliS/AwEfzeW06iYyzaHyFTSnHM
 mpICEEfy7LB2vFQ2iVAXClMn/MWe2YqcEx9gQP8iNmMYpgPVZSroV+NdTBwn+Qq2iFuvhKZX/T3
 /4fPUIOyAvGAI/8laQ48MY94/A3uRHGiVzW/y0g7+S4HWcsPQWbgZF/ta/VZpaOgWuflePFNigp
 q5WSA5k5NBrJutbk17tmleffIJ27pWpo=
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39b261074camr32015989a91.6.1788773753048; 
 Mon, 07 Sep 2026 02:35:53 -0700 (PDT)
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39b261074camr32015923a91.6.1788773752605; 
 Mon, 07 Sep 2026 02:35:52 -0700 (PDT)
Received: from [10.206.103.40] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm41656313eec.15.2026.09.07.02.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 02:35:51 -0700 (PDT)
Message-ID: <8b45dfc1-5350-4a63-9213-a1160478683d@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:05:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when link
 training succeeds
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
 <2b1e73f4-a476-4dc8-83f2-42be1008c1fc@oss.qualcomm.com>
Content-Language: en-US
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
In-Reply-To: <2b1e73f4-a476-4dc8-83f2-42be1008c1fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNCBTYWx0ZWRfXxOIo9xWuyXr2
 W1ZmSDrH2O+tYUBSOufGU40ktKr1H1OQDokOzNv9FTqFl9LS3YKXrRTlTRXKUbpHpkkmzoHdMTF
 AvBl31qh2HdeYo7zD21xtU9hFZ1PLqc5lHRWp5yHXAyGd7Kvn/HjTOkvvC+cadtD4qUW76DXpJC
 b2NBgO2vtMdPqe7bdDjyguozkN/cPdDjpA9T/Z1RzeqLmO25UNZnt5LlQv3z6FXRlKLwRZVjhRQ
 QPztYkGYHfSu/G38xSA4Bu89sIkHWhVMVMgzUnbVH0Y1NJT82bGbqq+SbVned5Sg8HYv0o11Z4j
 AxS3RmWNqUCAACArH45oBy+veO9DjJc5uvmEUfwqWh9K3mNKhcvmt0ob3dRfaau2U8+bZw5JgUP
 g+GdLl1yqymwITxHFUN83DuegsmI78/LR3fifh0RANNAsRHMpQYH/bv7doqibKUpnmR59JOJnuB
 KFH70mqijoLI0J8/Rww==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9e857a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=gUzaiutwswMiDYJum_AA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 1ACOsxnM-OmfeziRrzKMVOAdlgj1fy7O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNCBTYWx0ZWRfX3G/GBb3L5U7G
 bPRAeOioqet7L4UETHbV281V+84ZD4MFKysOG2VkwZlB8bB2abr2mTKx4pvZHXCJpW8+dhXqFgp
 91f2ewqHGCf1dtfSn7t5jE/4AsSZVK4=
X-Proofpoint-GUID: 1ACOsxnM-OmfeziRrzKMVOAdlgj1fy7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070104
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


On 24-08-2026 18:47, Konrad Dybcio wrote:
> On 8/24/26 1:28 PM, Saurabh Anand wrote:
>> msm_dp_display_prepare_link() sets force_link_train = true before calling
>> msm_dp_ctrl_on_link(). On success the flag was never cleared, so
>> msm_dp_ctrl_prepare_stream_on() would unconditionally trigger a second
>> link retrain even though the link was already trained.
>>
>> Clear force_link_train on the success path so that
>> msm_dp_ctrl_prepare_stream_on() only retrains when the channel EQ check
>> fails, as intended.
>>
>> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index bc646d172abe..40e19d506a45 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -649,6 +649,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>>   		return rc;
>>   	}
>>   
>> +	force_link_train = false;
>> +
>>   	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
> This makes the argument of this function useless

Yes, agreed. I will update it in the next version.

>
> Konrad
