Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7PtfVAo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VrN9A03b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC8A10ED55;
	Mon, 26 Oct 2026 09:49:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B020810ED55
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:49:02 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4auvf2727072
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=; b=o7PtfVAoxAtxieXR
 qRcE9ZdSLenSgiIBM0TRYc2MvEukOTH9Z9A7NiC15tPKoUryXat4v3SuvZObO1MA
 9AQ7gR/UwJkyZmGX/5PatiGk2jL2lYjWri/GDgm7FqSiNVI6DVp+FKNkz4Uab9m7
 Is9ISRdBmQyMwCVHrtF6ctgXt2LW0rq0h5F/yvNJrZ5ZUfW/Elg9cNW7uIhIouPP
 s/A03M6SO660JMWH9rGl6TXjODBfe6B+62xJD3B+UfC3FVfoXXOETml8lfRZufM9
 z3n6CVU2wGlwQvfyoij8mzLrZyIm0ObEH82IcdH1Ugzox2nc3N1K3IcW2RTvt1QH
 FxKY4Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6nwds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:49:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c4d46037eso8441866d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008141; x=1793612941;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=;
 b=VrN9A03bSF3G8dGkhdcYxCY1oxFnsZiLvCcPOgdtQAnIVyjSltpHVtBtZd0LVIWthU
 u4NwbnkSmAWeWx09YkB9/DnoDlGlNj8X7zKdOpEmz0hwRvqh3+POHetE6nJ+9CuJKCH1
 1d1IqZG+fCFOJHCzgm3CfSrnFa/U/mrBx9oIcPTh5KmnfFc6Rq0Xl2EpJUBmzxaGiYQq
 p3vajCrHAk/bnU4oUrFbhoNZ+PcqBnIdjhxTKPgGMFZGvza0a95opkWQAlrcnqXT5D2J
 a9vmuOK/7PwE1LOP43ZeOAj+9LdGFIqZEkj7v0sgIVR5s5CbLKonDiRD03Tk70mtkglm
 r4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008141; x=1793612941;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=;
 b=rrTAYx68/J2U4XVMWcLwivwvoSFHXjbmWKrohoaTLXQ0N3CIG1wwQedsDl4m/F4Xow
 zi6k4Yk20kxrHXwsARjHzKSRNeKspK/BabworApSGC82A6vU6RLN+0Ybe7IRILKLdkul
 y591MnuQ9BJ1mqKVEei7wTUX6SYlC2gEQeeuXhGTaYn8+Pcx8Au2Cb68WdOkWkyxdRtP
 G4hb1sGIklk8xBnznt7+tVuhBkGOrSWjPV5uyEPZp7+pnwBiyT7ZNxTMwqP7wIGx38LF
 6HPWsIpCDZ9YM1QZGe4ecOFr9Adv9kqnWqWd6u5zXR6VgVzzgETnb0DDuH8ZnDLg3rRq
 yqBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDE6QW/UaacsGZC8c3lapyKxvfT/8Qm2X5iJ4FhF7uvXnI2/LrFwbuhKmuBhQXLxaONQ3i5qxXc2U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJbzVXWCBvFhjskvBP4TIlDUvRKWJjUrftGuZlmAG3S8xoAT87q
 ZwAWOA/zkOY1kjmyB7TfTXwl/YgMhytqPtFMleCa+RPBqHEhXESHaBs5CNZPq/Afa6mSrvadf4E
 Z5z0bUCn8s5f19/7EBDNobaEbWEvTUtSm672rxn60hmzxclO06QOJclgpk1ePgzLsCk0uDUs=
X-Gm-Gg: AYBFou0Dxk5JNWe/RcDjkZsd+pHXMyR/yuKMZ55ie8Is1LDy+BLNHOM+5dDG/su9gAZ
 qxwryDPomfmza36fnGVasQngRCz84mrj5N8AYiLzLq/1cSoBpYtBJIDs7pBtOP/MPedGTkuNave
 XiKsLGkTQkN5kdVRjddOfPaorx0+qztllFNADnXXosvq2UUd4oscfPI5n4oGXpknF6VXrNX0bEV
 s2IvvV8xl81mE5EXVSrlg8MkdmGWF8iNF8PIpWyJa+gcjZdsL/YI293NzgLb34AOaz61mQ5qXfe
 m928MpQ1ijxlSztcPs8u3p4CR1PZkUG7sjfQk8n2g2SFI9jPryIG5wRzbBHb/8TI2wJd5Yg35AY
 slRybRv1XLsnFnYMwHIfRaw==
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr891899585a.3.1793008141112; 
 Mon, 26 Oct 2026 02:49:01 -0700 (PDT)
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr891896285a.3.1793008140702; 
 Mon, 26 Oct 2026 02:49:00 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4459924bdsm3349750a12.37.2026.10.26.02.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:48:59 -0700 (PDT)
Message-ID: <4fa0a55e-4446-43e5-aec4-beb6108b9686@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:48:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/msm/devfreq: Record idle_time at GPU idle onset
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DILZswVM_wxAVetQ2ySUi7tkC0T1ifRK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXzZ/8LhhzF+3c
 +pOlXOTM7kOQ/001dAA5qokaxHVKfAP0+Ed4lhYu5dxGM2E/YvHhvzLoEextQO66DxVidYZTb/P
 l2f8hr5HxpxMLZwwJg3onM5j8VW9E3U=
X-Proofpoint-GUID: DILZswVM_wxAVetQ2ySUi7tkC0T1ifRK
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adf220d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXw4LIsACrBp/t
 y4CMuyp/vNTbi6oKmD+T94AD64CNh14+4s37SQV9HRPsqhBeW6h4oR9Ps+qQEM0H/n6QtOHheQ4
 v8wJOyK3cAbzitcFAFhIVcWN5L8kQUu680ev9iinzrTRypXeWBkSv7OgUllIns8BhcCd1vlJgRz
 zY2comkKjlEAp/owgciTn6ebxdayGWeRvDjgXp5UVw8oT0RlfFDzb8k73zmmvItuQ3pv20FrwbV
 LL6NtJ4QQ+Hhjj31RE7ut6tHtO7W15zY9cM65oBHCTDw4PlVzU3l/zbWbCrKljpdUCH7Cp+3liN
 Qsz4fGzBVMQWEiD+k6O5tOwXxwriPos3fDYZW6yBk4pLQ+hP8tApqj1Rd9mFxCBJTg8qYpSukxk
 i8L0r5dKLiKHALK/D/YTB9cfiWhzcBXietlopVgc3n4fUexYQAetuvIY8kSYkkLrLMZQ1WsBhaA
 xiKCwjQPzyeU23Y6jNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260038
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Setting df->idle_time in msm_devfreq_idle_work() means a cancelled
> idle_work leaves a stale timestamp, causing idle_time to accumulate
> across idle cycles and potentially trigger a spurious devfreq boost.
> 
> Move the assignment to msm_devfreq_idle() so the timestamp always
> reflects the actual GPU idle onset.
> 
> Fixes: 658f4c829688 ("drm/msm/devfreq: Add 1ms delay before clamping freq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
