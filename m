Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC25606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dqn0kUaS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G9PsU/y+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAC71124E9;
	Thu, 26 Nov 2026 15:29:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4132D10E9C6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:29:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEVYmn3298802
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4Avc+sTpAvITn8tvFDLpyq/WRXcoXa74D7F5mNDMS3I=; b=dqn0kUaSSTo3y8pd
 o2AKQM9P8Ie52h+H8EoQescJqbHOWMLGQikInVhQLOoOhNa4+3N7ncCsaZOlZg4k
 7wUA3nrc6FVrxvf+i1m8+66lStpPC8CRFKR1JZBcml/F3VUS56A7f/11zwPSRWAY
 RQitCzMu37BgfoWn0/lWbdxKdRJkQP74qrYyJvsXzgqbzpB5O5ocoRagzbrDKyaf
 v4DY+DJ6lYWkajnB6GkDd0BDHNHLWGgDGZQHmYoYTiM5uPQZZ7XXdOpJLfPuHAmx
 71nibQIrw60kqn/AFbtGqfGTUUsGFcd8LWo1eOM7dOWGftcM0+3Xe1tc6ds7oVrr
 cJYcxg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak02u9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:29:14 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5edfa7703ffso325157e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795706954; x=1796311754;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Avc+sTpAvITn8tvFDLpyq/WRXcoXa74D7F5mNDMS3I=;
 b=G9PsU/y+kM2zawNOTORhnSYWcMjhypo8rbBhfqD0JqHBUbD8SVsXCC+wpYTAbNZFYn
 2ZFqyg/mRWda60h3vZUaIRwqZ+KXGE6qhWghf70bdA24tJ7aKJP7YZTUKGw3WF3JUMBJ
 7BKWivmIzFssIH88kk/WClfdUVeDHYFpeoYuIogH1EV4U5dY/niT/C0ywODtFsUNyxHQ
 gV/VovJwSn3SrLLggI3zBn1kIDdrSJcaubs3eaGRrpYsc8BsKHjVj58Un9dntrTWo+pU
 rkUXdV98JRT4xkhuZjzc8HtbdHISyg3uM9rmzjYyhg3i1z4GWD6xtGxel4D5GTST+6GJ
 BVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706954; x=1796311754;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Avc+sTpAvITn8tvFDLpyq/WRXcoXa74D7F5mNDMS3I=;
 b=gWBktwYAoEZg7VB2e6agE1GFufhpvJTMz/MqkN3+NweGqmNmCxbmEvfJM9GaEsH0gF
 AEVwBRVu0HlmfjigwQN+v4D8cLV2+ZG/Tt3bQnRVC4xzUQIq+wrhoZ0BECfr0qs8NVXC
 Gvdgaoa+Obf5K/IzvRn5axCETQH8wIW2nXMk1w8asgfFm243Ks41GxVUL3SjpUQKTmRi
 7kcdIHvRG8kvTygHHtGOy6t12RfTF3PU3MINkeuE0Y37nUtamRANxp8OoC8xkAp7FxMl
 jreuRLi+hCizfTCko4zs0QK5jbEjLIq+bDX0XV0jaeUzNBKorzrcKzt8ULi/ecrupBXr
 E4iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEZ/jvLjQ7OBzVj+ePNPv3VSzI4f0e5b3eX3nngK4lVntpO1wMabcQ6eReF9l5lHgjSkQV7bHVeTT8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Qej/PXkeviGmLl+G0FeuwA2GT7ZFCdVvuPkrKhoOaMZwjDyFA
 b4TXKK+pL/3z9BB2uAVpOAQobJvmcDf27Ys/Y10c7zuWYaEB0Gs6r8DPP3TX89ILm8c13ygWYlj
 P/gQ9jXNgKQtORto2Pqz53miA1Rh40ez5O0jga6kB/NE4tAput/1LGp2ylziJjzxiAlNkAP4=
X-Gm-Gg: AZFdTZdQNajDeeP6xhVxMmZGVmTJ2FPJkmL94Bbipxt86yHqkhgdgILCNDWgmqmu+xJ
 zZSFgP1X+kG81NxcbtOKE0m/zZT5anKl83ez/2o0B+IOdHaBrkjh2iQvqZR/+VO6iWBmate29Yv
 dvWdH57f76rOunAw29AHPcXfpTzaQEySBGRug2xCfAFC1nIxxXKpB4kBNG0z8LmxCne6cCsqHu8
 R3oChlMKpaziqyyBC759wvJ5cn+oRaSnAaF7y1ua3QwVRlXVc2m1DVJo34jwszMsBj2xiP6vvFf
 07xmInl4DALavX8CoJOFCiua1o+BeKD5CD+Wfp5fVxUjSXe0mW30aCWuXPVaEt0B6SFoFZMIGtx
 KriLLcWGRvD7y9pSzSOC36VW6JfFumEcV3RGVC02omrWSd9GWNgZtvq84l9GEWL8bvcllYHE=
X-Received: by 2002:a05:6122:2b1:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5ee8ad0ec78mr13671366e0c.0.1795706953469; 
 Thu, 26 Nov 2026 07:29:13 -0800 (PST)
X-Received: by 2002:a05:6122:2b1:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5ee8ad0ec78mr13671332e0c.0.1795706953035; 
 Thu, 26 Nov 2026 07:29:13 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b01e242sm739907166b.82.2026.11.26.07.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:29:12 -0800 (PST)
Message-ID: <6962c4ef-ad14-4984-9df4-4624c4bb50ae@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:29:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
 <70651641-b264-43cc-a745-178ef2b02680@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <70651641-b264-43cc-a745-178ef2b02680@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b08504a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ljcxbz6TTgZqL_1UImsA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: phToxiXIoRWJb51vKsa243inC-Xw8HQw
X-Proofpoint-GUID: phToxiXIoRWJb51vKsa243inC-Xw8HQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MCBTYWx0ZWRfX6v04y8cM8Iin
 hItjB0Gr5Vx8VQq0NN93Dbqu+DuF4Ir4fs9aRT6J33nrWqC1RlItSKFViwkRONO5HtaMTeqa3gv
 Hk4te7sI27/f3rPRCI0NekHVzrQ45ev1AiGkT9Eh0++VybrMF/wKd6aMZeL976Ekme3xqcS2Rwg
 K2jqrnWO27ZcLA7tK+GXVlICs/w2DpocYF09BRFOtPpydTv/ImebGSbrFUf9RUlixIUY4uQBxsN
 4e/nnfULP8BPzllghbhd+u+EL/6pyfWBnFtBYwxBaA1TCAzDJkq0LVbv2r+HtjwVqh8r9v/cO2J
 VtQf8+gCJ9sT70qDGp/kM3GZDm+h0ZssyXGW6X8CNqvV3yD+YRuwk1a1AUUwDR9yRnWgGG1idt/
 b8eNnox71d5Wh6iRIq9+DIO1lrfLvpl3IxsYuqMgSluAxzyuiRLuAoxp20qr6lcpZo6BrUSmGhB
 NLs6boqlrm+3FPRH4+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MCBTYWx0ZWRfX14aOsQqpN9OQ
 iwkyUZ3Vis4g83kCxorGXtGUR7dkfLszkIQcKhMmRBATIGvHt92cTSVyP34tYyyRAb/I7RCYdcE
 3N8uTRW0MrN0mRRgXzZ0D/zk7NP9pzE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260060
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

On 11/26/26 3:53 PM, Akhil P Oommen wrote:
> 
> 
> On 11/26/2026 8:17 PM, Konrad Dybcio wrote:
>> On 11/18/26 12:00 AM, Akhil P Oommen wrote:
>>> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
>>>
>>> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
>>> the A7xx Gen3 family. It is derived from A750 and shares the same
>>> IP-level configuration: protected registers, pwrup/IFPC register lists,
>>> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
>>> record size. The differences visible to the KMD are the chip id
>>> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
>>> firmware.
>>
>> [...]
>>
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> @@ -651,6 +651,9 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>>  	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
>>>  		return;
>>>  
>>> +	if (adreno_is_a753(adreno_gpu))
>>> +		state = false;
>>
>> Is that intended?
> 
> yes. It is mentioned in the commit text.

Right, it says 'it's not working at the moment' - are we going to
have a moment where it works?

Konrad
