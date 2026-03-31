Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D97FF60E7
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B3710E7E6;
	Tue, 31 Mar 2026 08:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lAYcu7qa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FlOQ1StL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877DF10E561
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:23:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V84BeJ430979
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oQq1wkGEX+ClBiMhfWlR5FzeIGm8ijkGs4W5JaGUg6U=; b=lAYcu7qakxGiVyjL
 8XBGCUUob2SLtzam9C8y87L6fbi0YUk/d65e9+s9Hof6kl2P35yIucHWo1RbioJ6
 zECkpC+nkcVn95joURvyTW3qpdfZfYOUEwNdeV5RxoMqVVvyHTE8DAMGx2zz2w6u
 HDJMDg7BQwIAaUZW6s5QWDTrNXYFljHszAlmbb7P/DT6o1oTFJm+9AegtAHKPzyb
 C8QoYZ+fnXJe2fG9dxD1W0GC3/HISWr9/XSX3cVKXiIs6bwlwKDmgGX2f0JpSrQ3
 Lk7A9cJORrn9hlAKVD3TD3ponHuqmgHgYRDs6YC4qVB1PcOhOF4LvQwUbwOHr1vm
 fEfGow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d84bfhead-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:23:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50943e69b08so19644911cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774945401; x=1775550201;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oQq1wkGEX+ClBiMhfWlR5FzeIGm8ijkGs4W5JaGUg6U=;
 b=FlOQ1StLCcZk+KueV/AO/l0H6r+fuigIh003gTVtqiqaoss6H417ZOIcgzybPW/qIw
 gxqwyd6X58EGPvKOrzAjayM3bXe3TKyzo53cYlOkQXdczqdpco+bV9mwWOPnd/Fnjl/e
 kopxxhpRJWQW6B31YaQ2bX32cVengWL7A+MrIBYWNdBYW/WDC5NcINGPlU8niWBgw8mg
 5tT2PqmohuiTDfa4/Jb/8k9rleE/beqB6VXsQzNnxfCetMCkJuC+aglilx/obikIlcwE
 OWDLIAlNN9CghttcVPGGkaqNmMLxo38wED3Ghzo8V6W2/H4ck3FJX6Ue0FyziK+L2JEc
 8eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774945401; x=1775550201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQq1wkGEX+ClBiMhfWlR5FzeIGm8ijkGs4W5JaGUg6U=;
 b=oB2S6yxhtN7stvqwe1FwQMlXprRk8UA7a0aSgBa413YTOYBKVn7KB1BA3VxqjfUxIA
 rE4Q2tyaQVfi1kHH/s/CLVUshV+5QUddKf97aVfluDgDHEwNkwto2/77G1R8QMl+sW/l
 xhxQ7HwHjuy3k4gY6ha50zskInF9eAfJ73eiHRKVgWgROPmZb1mu2SQDOmiFEucYS0DD
 Bi8Oqb50ix7H3JNU2kzWozP+SRK2s/DDIQQpC6PdwI7eCDVGJo7d/0VOX9jJj6nwZOa+
 umyAqndunguTswXlRUt/0S/4mVQ3cu0yQ615yPyBzsfdeIknvcyEg25bWbkJ4wSDn2kd
 JnkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmFaK6hw7Gk6/NnIZqkurtgKOXTSJRIArZiHqxWX/ALcTW6y2sN6GkfO/TEiOi5H6aJOb75tveIh8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeKBp3Se3AKhhIst9CZb5FieqcrahPfmDcKjtjztvTjM12KjFo
 i6mNx7Cvsa3gWkwQqXzm8a4CYfrxCP6cwTEU97UK2lrgztBR7QVNkPf46FD3UI6Hsi7KbT2cPB9
 pfMTSS93LYQmOsAq+IX/bAvtWGOUQbLlJtxFNX2e8ZoWo4kRWgGAm8jmWDOVKD/DBPAxg4rA=
X-Gm-Gg: ATEYQzzZcTSnnMEoWfaeyaCICTmq01edTJ4dnMPNKTwtMHXi1Bn7mKkrn/O4q/FdaHO
 H192DuaUMQ82KTz6J8aDGLbsU60Zcl4N7n6UQklnks3RLVl2PT5kiLXh2eB7rkRt2Ov36bNkK60
 SNBl10nc27JK1PObsxqXyKyr5iF0fGH7n315gkcG+AvW68gGDvqrW9NoyTHIA3jiMcLFHm7jBp2
 IUzNJQiswP2qpBOG0ZRxw/9yJGGgi/7seBV8e1q8p9r4KlkRT11TmZTLq0/Xtt9UvnP7MlmJeHR
 aChebXECSmbO4SqRRMUlyGxtKXBkAf/axOHl9nmbp/6VWodgNeXyg7GpHbIY9ez9NzPXqR2Zr/l
 wKmP2U5KB6P7BXQI1zQ2XRGUJsz6oLRaPBLg4SP1h3+qu97dmLCkREKp2rX38bg8O/foZqc8Z7c
 NLlmE=
X-Received: by 2002:a05:622a:30b:b0:509:15aa:cf03 with SMTP id
 d75a77b69052e-50ba3970575mr159030391cf.4.1774945400998; 
 Tue, 31 Mar 2026 01:23:20 -0700 (PDT)
X-Received: by 2002:a05:622a:30b:b0:509:15aa:cf03 with SMTP id
 d75a77b69052e-50ba3970575mr159030271cf.4.1774945400588; 
 Tue, 31 Mar 2026 01:23:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66bf3e16f80sm1743697a12.25.2026.03.31.01.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 01:23:19 -0700 (PDT)
Message-ID: <a5608e05-ce8e-42bd-8178-d197e6105b58@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] drm/msm/a8xx: Fix the ticks used in submit traces
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-2-2b53c38d2101@oss.qualcomm.com>
 <438fd5f0-8a03-4d86-bc5a-6fd32c7a6480@oss.qualcomm.com>
 <d1122bb6-da47-4089-96d8-9a3e7673fa0e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d1122bb6-da47-4089-96d8-9a3e7673fa0e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=69cb8479 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=S_9RJizizuE5VhlQKy8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OSBTYWx0ZWRfX346FztftI6hk
 hjW1D/g3rIH/S1yR0crh+vmkYOHGXCh7v4Mhtih8497m8c5+2OMXJ9n4Dv6LUnA+63tKF7H8NbJ
 LUONmNQ3Ri+UyexXwHUGhSsb5TLzgH6/TgBIw6v01GgEc7WnvaScLcqG+ILTTQDTG2r4eL2xHcI
 vgUZOhw42Gw918HPGxlrSsaED4lCaH2plPCNzbUQY8LIAs9WC79+/YUg/1che8s3WsIxpdJCTey
 xGhgtRPN/YPC6Uog32HRJx4Eukl41UzfkD9ErdncaN3OCSHeEfbNTMwiZRSPxUBu+Eyd1n9ep3f
 ARLUgbQKVSCAapaTe+/Xafab9tndvvuywRaWYP5Ll0th+xTOj+CCAXdy33sWSFbVbvONpqa6f0e
 /H/p+cBrbZd50msY9dKpbMYeZ2Wb4Fd85MUoqKyDdMprlEp6lRmJyzzNgmygKsoi6xkRzy2QNhd
 dI6Wvt8Z//lt1tIEDqw==
X-Proofpoint-GUID: Utt5mzK79WItcT5hGbsRiHUi81SUfloa
X-Proofpoint-ORIG-GUID: Utt5mzK79WItcT5hGbsRiHUi81SUfloa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310079
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

On 3/30/26 10:58 PM, Akhil P Oommen wrote:
> On 3/27/2026 5:07 PM, Konrad Dybcio wrote:
>> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>>> GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
>>> register offsets are used in the submit traces instead of A8x offsets.
>>> To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
>>> everywhere.
>>>
>>> While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
>>> counter.
>>
>> Which I assume does not need the GMU to be in any particular state, just
>> have its clocks enabled?
> 
> On A750+, there is a cx timer calibration during gmu resume to match the
> GPU AO counters with the CPU counter. That should be complete before we
> read this.

Worth a comment!

Konrad
