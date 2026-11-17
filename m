Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYlSZSDX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJ4J1MFK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E3A10F99D;
	Tue, 17 Nov 2026 22:25:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19A010F99D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:25:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKfbuD1700550
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3VeSk617D+v4O2b7XH5K6xESWUQk69Ood8RmJux2MOY=; b=EYlSZSDXRmqrVoLt
 k/6Mv9GEXrCaVkLfZRE/AyzmzTsrHfaaa73bsqfIDRPTpBEGXPSj+UcLkPl5eO2t
 RuMEb/RjNGoL0GCBLLgmgSRH1mui0KY3nvAXU9nCyxZsDev9Rf0eJZhUwJfSy8k1
 LLZX121uR7DHfXcV4cinik9qNaf8gVJYuvWPWuybCvThfC+/+nw0uFg+UWquTSlu
 KonF1sy1yOh4ITORka+Vml8JS5U9w+45qwRtypsMlcsJrOaDCAEYNOLYMUBtGlsN
 NRRXBEyNWh8m9llvQWXg6qy+giUFUoH6CYnGuoBt9ZTJENvB93Gk626yNuCRv6jk
 S9E6Kg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd3vc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:25:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-378722fd4a3so450110eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794954316; x=1795559116;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VeSk617D+v4O2b7XH5K6xESWUQk69Ood8RmJux2MOY=;
 b=cJ4J1MFKroyylkINJjP6d7a99nbq7GHqQLYxTgUDkqUeqCXKoEDNy7Dr0jrrvkSBIt
 Cpomd9EpPuhHokpom53ua6jqKuT5BmCD7y982xJx+6m5UOx+uddKqyxnbjNisAaVTUYV
 22+kmWFTx1gqUiSbAzWV0iTGxiq5EWHch3uOI5pZl0Q1mn8IzlyL8mrbAc6bg+fj6/3g
 pVJwa9ceIDAnora1kh+vZfqj8xnwoBbhUbRpSxVWy/nOaedpnd9+pEHCBjPSiusfV1i+
 1SdC33GYvejVvbJl/v4WmoogSbPIMx/AK85Mo3MjLcJ3dmf3Pu0OUbYxcCRqw0qOBeOc
 CJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794954316; x=1795559116;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VeSk617D+v4O2b7XH5K6xESWUQk69Ood8RmJux2MOY=;
 b=HfzQgQZmlnIFnGK66SEwLMCTM4BLOvOhYbXDlX1y+p5qxHLnZY9aTfheKeQCYb24OX
 bKXQHNHTFVS2BYRzQ2u5ny3Cc8uW9yG1gdQTglL480/37HaWZIlgO57goTOA3AUOZbLu
 5+D6v0/kUKwhHfMOjkPRPFDOoTCpAEzqTXGVtGBuv14pap/UsOKSQ9ZNkB13uFLbk7DJ
 NF15V4ev8Vicpb1MebXnRhHoapkuTq4ocIcIloCBaaanTf58KeYMhDQJilbfPWbgDZ/1
 E/sImBP3uGjjwlGlvIgn8JAweoVBmnoF6AwJRZ62DYzdX/scqaszXueqt/dxbpmOpkJT
 OSdw==
X-Forwarded-Encrypted: i=1;
 AL+hErFTaw8n78clfvNfangKy3V3OBoeH4luhTuF8Z3QfRTKqEfgnNuQJTzHbBTFWyJpRViWZGFmsWY1L7M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kIGFxwFpEa7LY1k/vK8tfyqA3+3bYPRVGExo7gMmxEzAwwtm7
 lzYjKy3WW+gmWLNyTpP7w2LI7koTr6c6SO6n5jAgXLN6cIYrZVogJdzZJDNQVCHfmlURGJkVr5p
 4JXV08dknpDBIECUBzdOBiIkCmEY7P+SPYDSQHkyGnuelM4vv6ccC/kqM90HHwWwU0Gm/LHs=
X-Gm-Gg: AZFdTZe3RjZcUP+yAKOTgs2jNfU3f+nOMK4Dh1V5651h4P3uFUXihcDxWiodn1WB3WN
 hEdxez8uZGD/aFR48+hoC4Ost9S+8QderR+f0vFQ5g1gzAt//MZX1P+r45uv/7g+p8CP6BKGi37
 +zXfBQFgKUnaxaF+JaB37Mat6B32y/dD9ir9rYI8oaCrHHAXMfOcUT9ISWQS6NYSOVF5DAuI0/v
 hGoUEz8yAEfjoUHMNXMftRc5IzcncD/fQw4HKiyykGxLQn+q4odomtXSZUkZbRm9f6JXA2y5Hlw
 vDewTzSwBsrcyCWJzK4zfmtArCWV3FYV5gNdU8WQMAjfJYnBw1Yo23fojMS/v65NcwVQADXwqux
 DMwXSlAh0kj1NPAUsXVUU0i8HcFFBvtRMih5ogq+MklwsWk0PSYUM/yR7rDJeFvCIsLoJekphxA
 ==
X-Received: by 2002:a05:693c:415c:10b0:36a:1008:5815 with SMTP id
 5a478bee46e88-3827dd05a3emr857617eec.5.1794954316345; 
 Tue, 17 Nov 2026 14:25:16 -0800 (PST)
X-Received: by 2002:a05:693c:415c:10b0:36a:1008:5815 with SMTP id
 5a478bee46e88-3827dd05a3emr857578eec.5.1794954315791; 
 Tue, 17 Nov 2026 14:25:15 -0800 (PST)
Received: from [192.168.1.12] ([106.222.233.152])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a79c96b2sm1041210eec.24.2026.11.17.14.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:25:15 -0800 (PST)
Message-ID: <dbf1487f-24ec-4f52-b8a6-0c63097d7b1e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 03:55:07 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-1-a06a6c57bde7@oss.qualcomm.com>
 <0fe6b4f6-e510-4fcc-b1a8-785438fac3e4@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <0fe6b4f6-e510-4fcc-b1a8-785438fac3e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afcd44d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Q9FbUFTPKQUszr4Og8UIjA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ud8-AEEbLN8OrmE_FLQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OSBTYWx0ZWRfX8H2wxf3q8Qwz
 wyDxvIYiwXNRLuWOkjSvDAQQngyhy0blIpsRLQcnKSi0/QlxvDE2dbB2NJwVZfJ2clTq+cJS41o
 as5tf5Dc9nCzABTh0hu9kuga+tKXhmA=
X-Proofpoint-GUID: Y7anlSmDn4sZRIWZ_1wSAXE_TK01BHLj
X-Proofpoint-ORIG-GUID: Y7anlSmDn4sZRIWZ_1wSAXE_TK01BHLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OSBTYWx0ZWRfXwY2lCk/vrHku
 GQYENk1LB0CvjfIigli5KVBjcakcGxw8cmKC6Go3SLMAN5Jx2BlX8e01AqjLY9J8VcqMP/0uaww
 47tK6/SKV5me68RajFYcW3HkJjbLlqbpkEGW3FGYQqvfpFOQoBLoTfkfca27fIBcblBjiGl9vyQ
 I1+UArbFNfPeqUvwf1P98YSpIxhCoFM2i6JkJQjGoAu2T6wqpmIGCBlC9z/U2duwZs24RHaGIfR
 GrjzYp+mUEVIRwPxCNrkzj+i/LWGb1vRxhM47ni9+jQ3/SAxAOBP62/cek6iiqWSehYhDRj0uyB
 LWz+GLkCijMc/x+IsHuh7NTnP/sStLXLSXyo13LnMvgK54wFlVzEmNtxWZD87vhH8dxoR/17Wt8
 +tKUTAfAZEQ9WPcfnsUwZUo5aON9RUKVnoA9kLSZ5b+gi/c7DwfSDQlVTlT3qyCOqfaCHep8eYB
 RAu+zl4pcp3Hn+rcBXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170089
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/12/2026 5:51 PM, Konrad Dybcio wrote:
> On 10/8/26 11:06 PM, Akhil P Oommen wrote:
>> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
>>
>> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
>> the A7xx Gen3 family. It is derived from A750 and shares the same
>> IP-level configuration: protected registers, pwrup/IFPC register lists,
>> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
>> record size. The differences visible to the KMD are the chip id
>> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
>> firmware.
>>
>> The Nord primary GPU is the same as A750 but has a different chip id,
>> so it needs its own catalog entry. Add a new catalog entry for this
>> GPU and an adreno_is_a753() helper. HW clock gating is not working at
>> the moment, so it is kept disabled for now.
> 
> Do we know the reason? It seems that no other platform has this issue

For some reason, this is causing random GPU hangs. It is still under debug.

-Akhil

> 
> Konrad

