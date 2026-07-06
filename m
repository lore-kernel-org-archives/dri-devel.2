Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B8BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3E910EAA5;
	Mon,  6 Jul 2026 19:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST78Cn0C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DE4QI7Fb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F9710EAA1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:56:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FFBAR900863
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 19:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=; b=ST78Cn0CaHEAkBgQ
 hRRjEv4Z/xXKv2pMOPJkqYAqsxxiYT8or41dWgrQWnOH9cJiSAgKRORgiMr+lok9
 5tyUYKpaSbfYS4wJTiwDGn9JsKqgBBt8PD6L37SJO1XXQ6gva5mwocEWJqFYDvc0
 ujpTfltzo75l9CEPP7rBpbZQAj/QCeetpwFJ8pdaN1+N3cKJfH8YVq+W8vKza5WL
 Bha+6cda/Q0xM9PkaiwdIU6hXe+Afqo151kx0J3vFMLm9fp+o2IlYBtKOAzYFcG7
 0cWdN2uBMOoZUjYHvGBZtdePiaG3jV1Y7aC1gOPh+jPcdnnYhpcyK3T8k4iNmKGq
 IYfdeQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7ka8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 19:56:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2473228a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783367775; x=1783972575;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=;
 b=DE4QI7Fbrfu8spOAvJU6JDxovQQGBdcGhZglnqwLcuye5MtIo7BCtigk1KOKlQqp3Q
 Ur/o07XkcLS9QxVxb+UAtsHkHUCS19OUsGBYAu+CiQRxTcP4emRyy+h+JbioVihUJCy/
 5ZOoECy6eI8v+hxolVbqBe9oXfjsEui4aETfeqZZ0ra8LtE/y9pbip0HLA5F8x5aWXqK
 hYvaj35rHRYTYzYMikB7VgtUlVfNcttapTf6qAm61eNBn7kpvzydx1C8VkpvE+fzEt0r
 cXpD5JXLomLED5BWZhN9LEA+oSPkWvNvti1h4t99tKoh+be+OUNYbK92aKoFBdBuXMdu
 /cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783367775; x=1783972575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=;
 b=e+XdssRBYcH0FdfTQM2kiSgzHVzrXeql189GOYa85S3bNlWTP4pd7Ey5efAgxrQSUL
 YkM8XLGWf5va0wlVjq0YiQ1MZCBofmDo8ohrhCtcztaO+hRm9ZNGCdsnkLAbFDHZ5RaX
 dN4D1gq0LTVipeVB+VJFzCXu1Ci0HXoA8tT+1YFpHdZLDSBVKvaNuQZQgrKDiL/m1zWW
 GABwdiUv4e8y5nDDs5g7MewJy4LeVhjjdSAycN7g6nrMpzbDXa5rkYbt8KOnr9yxN1Ro
 2I6s/9LdpoZCDgAGwc8ripyWZGlzsgdC73jkKKLu6AaIvQLXx+RHnni0bzK1ybUt/avt
 /BnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqlm5KMqdKSgJebllj1t6kHgrT12Pu9eAs6XKhHHo3QeXjMxullnIgXCnfZ0OWbjSVgMXHvLDO8eBk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpJlAw1undniPMq3f3ZxELyAbE5ubiO1H82Z7S9al1lmj3QkTS
 o+otMmPrZuaD0MtwF5cYI23mIeOkaeLvdSRBO96yvJPR4CMMivDWgxpQczrilmavblZ7bb0yMUL
 cX0VIpC/MfrY7YuhFWiG2FY7RWhQKoobRM2/4UR9zD+lDZ60bL4LiAso6cYae16DAB2GZhM4=
X-Gm-Gg: AfdE7clvbe8KSgJYWodr2h0tqnBc3/17IJcLWzP8oYVFFSKYsqEDXlTViUV8+0aYKdt
 hHDNiWiQAy35YDjGXpTTjeQlVLcz3kc/5MGMoi64twpNuhA75eIIJF34c5luQqO/pQTHJgLdCky
 6qhNVZLMFDsrlpQzz19eIx+GwCSG11xFGLVk34xo6OE5pS4pLbOdWEXoX/4FvFWZlsku2H2RQ5K
 r8Q7V96QAYk3u883OScqZK/lT8qfcoDOT2Fa+zSniHr2arwUNt5BIwS8bLLkL2R5S2S/ST9sdZG
 xSTznmCPllyjZsiYafOV7scc7xwDaOswkKKHvfzTbguI2V3ofGJuzayvtg8F4MJdIGjnddA4E4/
 MxsIeCkYT2+PFSKKUuiNgFaaPzFQNOhRDfbI=
X-Received: by 2002:a05:6a20:5499:b0:3bf:9e25:1a18 with SMTP id
 adf61e73a8af0-3c08ef55ba0mr2517892637.52.1783367774875; 
 Mon, 06 Jul 2026 12:56:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:5499:b0:3bf:9e25:1a18 with SMTP id
 adf61e73a8af0-3c08ef55ba0mr2517836637.52.1783367774370; 
 Mon, 06 Jul 2026 12:56:14 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b816a42sm90197173eec.9.2026.07.06.12.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 12:56:13 -0700 (PDT)
Message-ID: <3dea2be9-7c72-4c5a-865c-139837d294c1@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 01:26:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Add Adreno 722 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
 <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMSBTYWx0ZWRfX2ZeR4TxaGTFC
 15wt7QwiINMmmX2PTsABgMNLMfgp0MvXpioeHes5qsUHCTZDD8+qs+d7LZ4imMZcKciReGOr1wd
 MmH26CNUBqNOVV2CaMPUUvVCEMITBEbzH0F+LusFlC/5f7R3Hb47/zObrhro2Bkd8+/HEdJH0vV
 d+xwCRvRYEE1gsiVP4zLsx7sTn84/Z8iVcoRj7NUDu/DnmPCyE3q5TCd13KZdXaOltyTVGLYOHo
 HHDHE1Ah2a83KaAqztYmxHD6mtqbtrBsKy65NVkt64K0MnXeUfDIFywVVegChReA3+k4vx/ACsk
 OaticPWPioFxYykxcs1EmyWpO1pabZHz7tC+dJLs+Jm6otCsBqWxjOq77S8Mn7PDoj+fH2WxpW6
 6jjkvCFtEwIg4Wn0aVCXH8i0o3MWJ6QSj2A+ceY9BCH87Bde5P25AHSa6IkeQdie4I01RoaJ9Bv
 wvcTPaIcBEYCyIDL75A==
X-Proofpoint-ORIG-GUID: _h35TubsIYBVRfkTulFh_rk93nLbUgJU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMSBTYWx0ZWRfX5O3XnNOoIlqm
 BjUrwcXps/N1/qyVDxPC49CNE+tqVVESzUzRvAfuRjdWYo1XfKfp22GoPhBOXCXdC38ckAvTw0G
 Px0gPcvXFO7mydVctlyw8DmZUmAEmd4=
X-Proofpoint-GUID: _h35TubsIYBVRfkTulFh_rk93nLbUgJU
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c085f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Gg-SMJLLMV3ST4U2SEgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060201
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

On 7/6/2026 2:29 PM, Konrad Dybcio wrote:
> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>
>> Add support for Adreno A722, a member of the GEN1 A7xx family. It is
>> derived from A730 and shares the same IP-level configurations: HWCG
>> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
>> Major differences include lower cache/core counts, 1MB GMEM, no
>> Concurrent Binning & LPAC support. Some of the peripheral blocks like
>> RSCC are from A740 that resulted in updates to RSC layout.
>>
>> Add a new entry to the catalog to describe the usual configuration and
>> few additional fixup mainly due to missing CB/LPAC features and updated
>> RSC layout.
>>
>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -710,7 +710,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 2, 0);
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_ADDR + 2, 0);
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 4,
>> -		       adreno_is_a740_family(adreno_gpu) ? 0x80000021 : 0x80000000);
>> +		       (adreno_is_a740_family(adreno_gpu) ||
>> +			adreno_is_a722(adreno_gpu)) ? 0x80000021 : 0x80000000);
> 
> This is a discrepancy vs kgsl (did you look at gen7_14 instead of
> gen7_17? did you test this on device?)

Both 7_17 and 7_14 are same GPU IP. Yes, this was tested on Eliza MTP.	

> 
> [...]
> 
>>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
>> -	if (adreno_is_a740_family(adreno_gpu))
>> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu))
>>  		seqmem0_drv0_reg = REG_A7XX_RSCC_SEQ_MEM_0_DRV0_A740;
> 
> Likewise
> 
> [...]
> 
>>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
>> -	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
>> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu) ||
>> +	    adreno_is_a8xx(adreno_gpu))
>>  		seqmem_off = 4;
> 
> Likewise
> 
>>  
>>  	/* Make sure there are no outstanding RPMh votes */
>> @@ -1100,7 +1104,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>  		val, (val & 1), 100, 1000);
>>  
>> -	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
>> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a722(adreno_gpu) &&
>> +	    !adreno_is_a8xx(adreno_gpu))
>>  		return;
> 
> Likewise
> 
> You also need to if-out concurrent binning for this SKU

You mean the PM4 pkts? If yes, fw will skip them as NOP.

-Akhil.
> 
> Konrad

