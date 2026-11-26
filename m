Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82F606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eur+LAM4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ODAg76tC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABD01124B7;
	Thu, 26 Nov 2026 14:53:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C679E1124BB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:53:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEVE0v3143471
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XQNAN6Vy4siPlthRoQH9jet8l2I4+/EnJVydI4yjk1s=; b=eur+LAM4pFbOfhIo
 2uB6AtdRkfgb4csfaXkpGOzp1a1TwKFNiM39Swed5FkWWMFuonAI4JqPsHNhALHo
 wWiOWniIQnfsCzkKggHON/1+EEl5ZX/55r/uE8BnosJhV9e8ZNsY2sxGGwMrk3O9
 aWBnM0Iu28wXw/mHvi8d/on3ezXuOpVXLwY4W5bhXQYhjAgt8peG48y3RO3BEv+r
 h21oEV6PXs9YFK21TR1sm2rp/s4LHVaNLJYTN7jMOvpoOdg8wPO1zQN6Gh2zasMY
 8ppY8rWEchIoDbvZ2hfbRKRtNXYGSWZnaJzxtlf3w4v3I4BIJGGK43QjjKIUe9JY
 ES6nFg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvv0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:53:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-386a65fca25so6212915eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795704807; x=1796309607;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XQNAN6Vy4siPlthRoQH9jet8l2I4+/EnJVydI4yjk1s=;
 b=ODAg76tCzvXw90881aFr6mENqwo27qi9xax5zjQWFGyT71giLcTOGX9TP4bhhTI9Ic
 cuRe/FMH1BxOA1pjwtUtu1CXNOHIeT77nuGRJ6wtpqsvQkWtiANcnTKkfVwjATAtyV62
 LWEFJA2J75AhZ/EhoXH8uX8F7P9r1w0yWTp3LfhRBZpbUvuCsGZkW34UEHDeIF2CXzMP
 Ea8yHLqXJfmG0PK3QXMDFPN6DbUWqZUi5IYy4WfXldkxsweEGk4G1WwQe+pAz2GnZ7ZY
 XJi1cYrLckFaIaQFNu+8gM3GO9mxaP+3A4ql3AabwfvA/pbfJal4M4oFb0TXsso/kd+l
 8+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704807; x=1796309607;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQNAN6Vy4siPlthRoQH9jet8l2I4+/EnJVydI4yjk1s=;
 b=jQ8RnWAEluji05H8i6Wpo2u++ANxB3Tuqu5GWwy1x7CBxt1naUWmRXWWI3RX4OBC/z
 byTjrBHCom2HDVTjUcxQR0Oqcrs5Xi514BBQFStIXLBXP31IqNVkkt9LvK81lHZuRWHP
 /AV7V0f9y9u91qALKxStrjgFKf5ZH3zKko3z/HzMR1f969NvZVCbBssgAxtz95Kjavun
 4ZNyTXJAiB2tIajrbqIkcSDu9GGoMzvQayO2BH3lrgBdPUjIxk5TrbTqpsTmE0UoTHKz
 F9zujeCYj1jHeJyRD38K/qb3QHHoLyxU+8Meq6BcthvwPDHNhizYjhz9LS5M3mvmmZVd
 PqlQ==
X-Forwarded-Encrypted: i=1;
 AL+hErExJpg5MUu7cie11344YLBlm97PJ89cnpxXAQYvxDE3gS9Urwdl35MsglgRFNY1nYNS2CHwMaojl8s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/q3S3aWjJoBxumx0HtOjcAFA8QoVx0s1l1uZiAt3hRl7+ow7Cn
 XWm7FHxN0seXIRUuuUzS3T6SVf1dMMfVrfiik6+panT5PHximskDhDLLeDCdH55bztp3fCUwfk0
 b7TdwRgZP2UnbkG0fn9utu55kN6yum2hEkyeuHTlFt5PEElsuTCSeaLwp9TUQ4CJlCaVJVig=
X-Gm-Gg: AZFdTZcJZLvb2+IqSc2DXrnX+1vd3qdgo9wqxyVsBK/ITB0Ss8R1C+MlBVtBavLydCS
 Gg3/Y/BX12798qnXzFvaDxAjZGa1FPMjFrPgbK5aCiF/kb7dVi5XMrtPdHuf5GVM1aQcOK9S1DG
 VecApoZa2u+OAhJMDE/hhRKuyP+pLSv88PYt7wCyF8RvLfMeoVACCHrDc5gKKkjyCo9zafLCzRW
 Hzvqi7KPwpmFVqWrxsdpsbwI2m9FQ38BkluOZckmRpZ2E7OUH2/ViqGLt/6ygrF/nt9DD2cuUqw
 RSvPfE1LuN63xUdO6wejpCEKmb8QkyLHOoyQM7pqBVj/+nSyOk82igc0V8y1uNftG7lKMEX7pol
 ye/a/K0bPvLPlRUzQMRD1isoCTWj+r69IavfrcBMcnyqANQpy5cPQtE1/Bn2T1F61ewIYngtKYg
 ==
X-Received: by 2002:a05:7022:906:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b556904c50mr27737687c88.29.1795704807290; 
 Thu, 26 Nov 2026 06:53:27 -0800 (PST)
X-Received: by 2002:a05:7022:906:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b556904c50mr27737651c88.29.1795704806659; 
 Thu, 26 Nov 2026 06:53:26 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm82132907c88.9.2026.11.26.06.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:53:26 -0800 (PST)
Message-ID: <70651641-b264-43cc-a745-178ef2b02680@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 20:23:18 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
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
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
 <20261118-nord-gpu1-v2-1-8d6d9908b7c5@oss.qualcomm.com>
 <a005f8a1-76a2-46ce-b328-2063bc307758@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <a005f8a1-76a2-46ce-b328-2063bc307758@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UJtxnshhtsXiW9y7xXEaEGhZ8dSkmVW3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OCBTYWx0ZWRfXxFFJRPFPY3PX
 dKJpIbq6/MH0r7omWTsNAHCYxxEEJrJdq9ujySbpqk9dU+544CHq0QQ7kpJcKQYTCZ5kbDQDwqs
 Uhwujc64A2KvS1aBwtXu7x0aPEZBPmY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OCBTYWx0ZWRfX6dg0l+ZAD8SR
 dSp/Ig+uvOquRdWqkpCWja/io96V1qrrVrp2CSz+R+Yuz1cofD1YH1ykareTHeuhWrdCkrnyJF+
 8X8OFY9a4Iqovsj7wbwQe7y661t40UVFlTakSZ5vGYn2Dww7eNHzHvKVdAe7/waSR6YM9vpQE+O
 GxRlqcP/lA+yp0UpTzcdhQ2uLXRR3tGGJAdB8AqZ/tquF+9SACm2HYupCUy6GKaWwJlr28w8C55
 cFSJlJfYSkrAF5+XKoxKieIFOaoTCHk4v5JR1OQ0+nRMqRxAtoPgbqriyTVXmhFmawWoIPjbELb
 7oHRVnz0rnTPdrhmtteNpTHbH9ySj3IedMt6k45zxgkCC6FUJ3Y8U6gUdju69K+NnfAZML/Gkzu
 2zhRJ6suKU7RAmYEgUWdrR6Qgd/1JzoBET8Qc0E/loeORUHRVGY+neOEAmEEdArJFeOcculplpA
 Z22imRlUYwEC9boHfDA==
X-Proofpoint-ORIG-GUID: UJtxnshhtsXiW9y7xXEaEGhZ8dSkmVW3
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b0847e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=GMqeiC-AThkal4myrkQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260058
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/26/2026 8:17 PM, Konrad Dybcio wrote:
> On 11/18/26 12:00 AM, Akhil P Oommen wrote:
>> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
>>
>> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
>> the A7xx Gen3 family. It is derived from A750 and shares the same
>> IP-level configuration: protected registers, pwrup/IFPC register lists,
>> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
>> record size. The differences visible to the KMD are the chip id
>> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
>> firmware.
> 
> [...]
> 
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -651,6 +651,9 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>  	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
>>  		return;
>>  
>> +	if (adreno_is_a753(adreno_gpu))
>> +		state = false;
> 
> Is that intended?

yes. It is mentioned in the commit text.

-Akhil.

> 
> Konrad

