Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCF7C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFD710EBB3;
	Tue,  7 Jul 2026 07:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcckQYcR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gp3LWWo3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F4B10EBB3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:57:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66748qxn2675422
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 07:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=; b=fcckQYcR8YaWsCne
 8OMkkL6BP/ynJXTTEAsp4qAeFWCCSjtyss+7TFUrogT8Wim7hJYNpi6snApgBjUS
 TKjFsDx7XkHgKeZK9JiMftH9grco5VxkAWTNiTqHxZWEj/V/oxN0dfTwapDvVIWT
 6bePbgvZVPdMCveLWJJfaMIlrvyLikhUIiTSt/fsGYitYyYoUna2vUuaPvez1i0n
 /3jqUl9vCs2hdmUit562G2/k6yzexF1+ZLjJnm5PTbhUMXmejpIIW1bSTc/kxYf1
 EkBuvtu5Sku3r6Y8ZoITOOI0bomB3zl1EUtfCs/cVdSxe+O2z4PmKrN46N5ra0a+
 idONjw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj79aka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 07:57:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19a2da0eso3507681cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783411028; x=1784015828;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=;
 b=Gp3LWWo3w0hXeQVPdVw2xpc+b12IRPRE759zcWL+woy9z08vkbZmyV7IKZIuymPUBY
 7WfQuC3WIYdoJVeOA0W2FTYgz1jvq44w51g322vfVoSeXmuwks1Uk9a/QXzdO5KLVt6c
 7kSl7sYtdSpFk1TAqwY/N3ZktZe5bF8haIAk9ujCbXPx1AhYPsg2X1bUJJCha1/8uxrS
 X1yT5NTXICPwayyn0mI0f2NEpIaTokpx9W6RpOr1KPWYpRi59r4G5Eed5tOjoCsGsrM7
 IbsgNQjNUkaOyLtNzKysBbM3op64BP6M6dqoBskUSHOZL+emCKTxcIjgz/8hmpjNMDmY
 wRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783411028; x=1784015828;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=;
 b=hUIZzm4fwoCUaH6PFLeYqEdzAU4eY98GhTvaYSga31LflAv34RlpRyxG8+ikQz97lU
 62rfatitg3rFE/YWQCA7DFxOTJ0YU732TqebB+ZoRq7MtGqrll/MLcczlHb6LsX9tbeM
 Fa24FQJPWT5eozeKpKqdlxZRZfADGR+OepUsBe65wgUkCSRZiaAmXlQNznDzpbkINGFw
 v+WZnJsPnk35cUh6tKSZ3w6jbcIX5/b/rx3qgd+T9/FqS/GInDTE8sAOY2K5PGCX5FVX
 z7G401+OCK77Al6WV6M2HEPAzMSkwMq7h9uA3MqgOy8BpW50KOmqaKPHS5qVbCAZSZrj
 hYbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0BOeTWcmCeRqMsz2o24ibn7VKHQwjuYsrUpauB17yod3hnobS50/pE3WjRNtzgw7/wjpYruaingA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgDl8JfmpXfet5C8gHUL1AAI5DC8OYt+1aQ0GlChvSAUZGgYkw
 uyZ6z+Qrn4wZantK+6UV95NjGZIxjOKSFWXAvK+s/UrCsnTxSxS55WtUK+XJz0wi7sj0l7N6i76
 b507GMdFFD2vcx7boTCoSzi9fljFS7T5Ut9QyoEw3KERM5wELiiOU2KfhIGFlcvUTrH1e2e8=
X-Gm-Gg: AfdE7cnEE/dVOClMSruwC/c5CHQuCnYwUCHksGGhUaRm842rjxaV2u94id/3Gqv1BIf
 Vgn8z5itTniiW8k3doSwsJO/hCrEJT8FZ1xiJMKX8iORhL7jp5sw3epm/UcfsudPCRokMcpGUto
 K/Yv3D8ge5vdz24pA7thtcqH06VSwCq2hB0B7XXDe+qALG8TOTQFOve2cedRaBFog4jCeTDmxKi
 60XicRY+n7J12aQmteT7xhQGrgh4GRNRmHSHsWeLXNKZaleBEQPWrC8gKgO/hjW63JJkT5sXihY
 ul5rZki4PIPuq+QTSWLRC0kSk4xc+CyrYUmQXJzn/97elKaPGs7ceWt50Jnp2vicfjV+KrgpM6z
 LNFTZa094We/8RFrjaIdKC60Qc2LvAcE0PiM=
X-Received: by 2002:a05:622a:9c3:10b0:51b:f40b:2fa2 with SMTP id
 d75a77b69052e-51c4bd5a87bmr80136051cf.1.1783411027784; 
 Tue, 07 Jul 2026 00:57:07 -0700 (PDT)
X-Received: by 2002:a05:622a:9c3:10b0:51b:f40b:2fa2 with SMTP id
 d75a77b69052e-51c4bd5a87bmr80135851cf.1.1783411027315; 
 Tue, 07 Jul 2026 00:57:07 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad82311fsm75880366b.8.2026.07.07.00.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 00:57:06 -0700 (PDT)
Message-ID: <c9fc2770-d436-407e-998b-b7ca49ee344b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
 <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
 <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DDgsQk8Jmezl7J_0tfuDmpKRfV5mCY4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NSBTYWx0ZWRfX16Jeyan/D/yD
 6fcjzBWIwrzc5vH7P6elpA2yccSkLzU2v6f8otzAuUNreQT4hBPflOKZ+Hy3njUiDXBW60rjrgB
 HQMxMwWeG0rn6ycjAUzFZi7GM+Yu20ppeH6vOaWcElRPknmZfz3OGIl3ezC3L/9MCRTPZmuMD7u
 NjvDxzghTPed9ssNzD35qKjzGk3vmkd74psojE7iHetxigrUhq7HXWVXWonsHS+lHt0IkHWa/cG
 INbjkVD1rLYEXH7hfE+jYVPoXLg4v2woZVCehk0HW77oGuPhNglmflUXIMYUmjIyBBp4iQ7Eu0g
 3ZP9QGYLKiPfTWLCJRSK9cFvGQf5prmsXIIY9KJHPl49PRNa0aqJpdXVq7Bzp8HDMxMyKmuxRBJ
 wOG0h7hfrCdwkbwRpisrwoDgSKbD+HCw+dEb98xyXwbSlE6qHNXPn0Z3SfPoDoq2f92GNNgt+Q7
 sXzExq0K4+OUVc3jcXQ==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cb154 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w5vk1yBYWc5d-UbTd4AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NSBTYWx0ZWRfX1Sn1Bqy4sLuH
 w56oag0Ic+9Na7ZPUOl9g2eLT84KrRrC+TRN4Di3olVPWuCk3ycREi3QNZiLpktCBJm7nKuLvmW
 LT1GFtr1cX12tmlaoJxhAhyH4wEfnok=
X-Proofpoint-GUID: DDgsQk8Jmezl7J_0tfuDmpKRfV5mCY4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070075
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

On 7/6/26 10:06 PM, Akhil P Oommen wrote:
> On 7/6/2026 3:07 PM, Konrad Dybcio wrote:
>> On 7/5/26 10:00 AM, Akhil P Oommen wrote:
>>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>>> A8x family. It is based on the new slice architecture with 3 slices,
>>> higher GMEM/caches etc.
>>>
>>> There is some re-arrangement in the reglist to properly cover maximum
>>> register region. Other than this, the DT description is mostly similar
>>> to the existing chipsets except the OPP tables.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +			qcom,gmu = <&gmu>;
>>> +			#cooling-cells = <2>;
>>> +
>>> +			nvmem-cells = <&gpu_speed_bin>;
>>> +			nvmem-cell-names = "speed_bin";
>>
>> This looks good to me, but I thought that on a8x, we're supposed to use
>> the freq limiting register in CX_MISC - is either of them preferred?
>> Or are they just hardwired to the same thing by chance
> 
> I believe the other register would work, but I don't have a fused hw to
> test. OTOH, this is what is commercialized.

This is the answer then

Konrad
