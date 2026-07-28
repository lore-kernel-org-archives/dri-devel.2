Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947DC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3418D10E5C5;
	Tue, 28 Jul 2026 16:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohjcwOzd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAVScbdW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C26610E5C0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:40:48 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcf3Z2996439
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6XIAYpvOZNxgfjo9PcaotLY0G9PU+jDGlLgxgEzrF9U=; b=ohjcwOzdL6AkZGFs
 gzft2ifcLHgXwDO5sF/vklzZAuWYqB+Lnz05gIhX+C0AefvCzbMX7fJu1YxN5ig3
 DKbRkbHZeoiiv1DZS4ABaQWgoFGTC2u4gID8O5MsvgudL40l5YdYxphTocJaNijx
 v6x1SWh8DhNwKXXgDHzwn2VRV28D5hX0k6ugKXFwgcVDgrMW1O9dcniQCixiVZrF
 RURGZm6X4D2MqEdHEinQ6guhPrGk7kp3Jw4eAaLz8hlV7m40HA+EFXFuJXrteLqI
 TqcpIM45cQMp2o6Yw8Sr09I9MTpPH/IWTfpSMSxZdhp7McA9C64ZTElRXrDXgL6y
 OgtcPA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjjn9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:40:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51ca37ce4c3so41661cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785256847; x=1785861647;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6XIAYpvOZNxgfjo9PcaotLY0G9PU+jDGlLgxgEzrF9U=;
 b=IAVScbdW0WnrAGuTqBy7/HSyr0AnokV00eMsm85sgVqMW0zZGBLTKbX+wC6LIZY3n8
 UjE91A7Ug6tJr6ookIDkGMbKr0EbX1V9R9kuWggUIYVlnbfRBISwg87k8M4vuA7T0hkg
 TtshoR5+aWbO7nuEZgzKKvU1E04U297fo+5B4lpbX1t5ZkS31w4DZER28w6wjqWjTZFt
 hQjBMf983Q5LNJWswx0gbTwOkL1aBRdLhEtjIQVbmyUHP63ifFzgmEjvhVtezAu6SgCI
 1jOU1miYn8Rx6M7aNsE0xB6YUPWHGP+BCKKIMhHZTX2+95CTxKksizL0e6LDFicFZDNM
 rQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256847; x=1785861647;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6XIAYpvOZNxgfjo9PcaotLY0G9PU+jDGlLgxgEzrF9U=;
 b=layTZzyxGOMuRxafMLiAeLPD+TE7eu5WIiHKMepUbL7zzqsU9DNKk4eusFTDVF7X60
 iPqA3wrivWvsjoBa6tL2DyFAIcYQHaaczIfHdFWwBGN9sUuswSob1YxMBnFEY1iG9BCs
 qUTANC7LmhGVOwmgyv3cHjShafNetI3V2+ndWQAVuwqsBjrGcj1T5/sY2ING2BjAGPxN
 kSCeMg5KWhNVtmCwOJ/0c1sPVXOcEEejsv0w4+VJH0QRk3LqFgYf/7uDu5/z13sUl+ub
 GRsey8R0ACpl0X2wLwFMnIIP1ufXDRDr/jyTJehkDOd5ypk8gkVzHgnUrgRQ4Cs2cTe5
 metA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM6kY/S/Y8IBqcq4Z3csVLNxP5ev9lkaTlug/ovWUo245SQjFGyVVGQDlksqRGpF+3zTBmHupoM+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxicbyF+Po4kPPzPCby1jvZ0oLrwjhUuAIhUOYi/xaa5oludH17
 06VvJX4ITS9XFF9S3/367z5M9Fizfm/uyPcr/l2BsOzl13Z7Oj9Rfm454QiRb0EOoQxVph3zBaQ
 ZsZDVKdJ465ZMOmDyCTvNSh7wPBCJ/X+VZDbsw8ypN4jC6KccXrryucjJcXL5ED9i0SoNOkw=
X-Gm-Gg: AR+sD11ECtT44q+ttd7+8Oicajn6AwloSF/iF2PMmA1dVANTcwWnmwr4CFLiWx2yH8P
 u/la9by7HALhzmKoOj6LEE5g/9nT1QKPf7oAK77TWlYqeKNQC9MJf1vpGLl7h5KVjMr8GcSQ2pP
 ZUF+5yJL4BTlYHwKwmI/ebLIZ+GKnxN16bQNaDnWFfiFwoVjzWdm3RScspp8o1cnsvSIOSbiE2j
 heCk+orOWxn7c1FzuU9lStbjpdd1MGWRx4ylp8FogI6KGu0Vd6QmCk0QhbHsmXeFwY77jHBaGrq
 e5N2Z6XPQ/gK/rCDOIssm6JqR3/NjnAWVgKwEbRswESu4KvqVniAvUvmGUeVMec60oUhDlKnE88
 Jx7a+wn+sLn97CyjVEBHJ8t15
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id
 d75a77b69052e-529d6fe33e2mr18917481cf.5.1785256846481; 
 Tue, 28 Jul 2026 09:40:46 -0700 (PDT)
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id
 d75a77b69052e-529d6fe33e2mr18917181cf.5.1785256846019; 
 Tue, 28 Jul 2026 09:40:46 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83d27f47sm8254366b.26.2026.07.28.09.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:40:45 -0700 (PDT)
Message-ID: <28a1cf31-1edf-4980-90c4-a3bd89b638f5@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Vara Reddy <quic_varar@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 Guenter Roeck <groeck@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tanmay Shah <tanmay@codeaurora.org>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-1-e7783b859a70@oss.qualcomm.com>
 <twedkppa74qxgbphy4xqhreb4a4s524jfjuzaqydtizeutpjql@tht3pklgptp7>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <twedkppa74qxgbphy4xqhreb4a4s524jfjuzaqydtizeutpjql@tht3pklgptp7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qZRKPGVCNUn0AORRN_FfppQn3XOF73mA
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a68db8f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9gYuhPn4vmGLrIwqE-QA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0NyBTYWx0ZWRfX7qir/w+X0q/C
 MszNWgWVyJuFKROJeAq51DDNZb1qf5PkbY8TEjoiATyrEHKVU5omZMKgk47lOGcu4TeMpgUzSQz
 co6aGdl+Vn/sPZ2kx4bKMpiq3fs2B/s=
X-Proofpoint-ORIG-GUID: qZRKPGVCNUn0AORRN_FfppQn3XOF73mA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0NyBTYWx0ZWRfX5Abh0rWWEN2c
 baFDvw6aKH2kSFvOUNAST/qsp2YHSii6pwoknHCtjjgHsbRxYlj3Vc+j4Rx79WPrnEi+wOz1/9d
 KVbXKn+aTaw8G8NTspwZ0ujgjb1mHMU4Z7It1w87Cv/TtQeK8VXiOOj67Zhz6A7nf/WGnjxxfI+
 /ZfvSJK0NS5iRe+e0YUkeyU27+ETgdAemWTP0l7PfhDPmHsT139fUL9+V6c1JvrQ7wdCOFBF1B2
 ifoefipF0nb+QOnFS/RQfs///1YqJ0XviTQezC8+OdBqt1ylI0mbi2ndNvdmpBu5SNDSP71B0an
 HvbpH5KC63Im24l7CcyPqui1YYz+wNwY35mgd3LH7F17zMtb19TXuwyKeLyYKFDtBfT8Qln8+hD
 zIf/Wc2qXdDK0eE82I3DEzFsYYoyrvEUNDASHGlZbMaYWQ9OqLFmbUBnvRFcBO97GVEUC9cAs1p
 exs5jySIHrPUHELVLrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280147
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

On 7/28/26 3:57 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 28, 2026 at 03:20:45PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> dev_pm_opp_set_rate(0) removes the vote specified in required-opps but
>> does not actually park the clock, making it run without the necessary
>> power backing. Prevent that from happening when
>> _dpu_core_perf_get_core_clk_rate() returns 0.
>>
>> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> index 2ff255d7795e..fea173e37464 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> @@ -394,6 +394,10 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
>>  
>>  		trace_dpu_core_perf_update_clk(kms->dev, !crtc->enabled, clk_rate);
>>  
>> +		/* If we're going offline, PM callbacks will disable the clocks instead */
>> +		if (!clk_rate)
>> +			return 0;
> 
> Is 0 here an actual case? If it is coming from the core_perf, then the
> next line will handle it.

Yes it is (upon suspend) and it will not be handled because it's a min()
and not a max() below

Konrad

> 
>> +
>>  		clk_rate = min(clk_rate, kms->perf.max_core_clk_rate);
>>  		ret = dev_pm_opp_set_rate(&kms->pdev->dev, clk_rate);
>>  		if (ret) {
>>
>> -- 
>> 2.55.0
>>
> 
