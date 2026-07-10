Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32814C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302F510E192;
	Fri, 10 Jul 2026 11:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCTgJ131";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i1OnzRWl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4B210E192
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:11:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAmp2g569600
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=; b=VCTgJ131iEPM4MAE
 8AYlc6FUY8uYOy4BZ+QjxJUMPxwOJP1fAdceJXbGSle3LxdPLs/ci66EsO43j6Aa
 aCV35X4L1GQDnSm7oi2OXuH2GTtAB8jKnxUTqGN99GkNSqHGFM8BsOCG4XOOiG+R
 K6P28wi4JcS9YD5PpAJvsQNwH9pOd+mbfQXlUGRMwiZ+YRyKyDMRmw6q2tyBKrg5
 zcuhJAAZdqDAkWin8FUYJDLXkAYcL/t/TWBIIzqwQ9YloyN3IjqfdZdvcQWSUsJ7
 wUsiP0u0b/+jxA+UfqEZAI3Hst6y/HtalCKmlTL1+NFiI8dWKz6RLaOIlWWkSug4
 /z5aJQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f8br4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:11:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38001e788d6so1529168a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783681910; x=1784286710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=;
 b=i1OnzRWlnmFCbB/iNhPHbjjDZT/1g6lU9OndnTK52LUAyNF5OUZ2YQKM6U5f7RUB3z
 hRlPiBA8ULvPCmg+HcJU+V+HEd+gk4GIE0LDabenjA/DbAjfPFK47aEtAuVYp1gNQuyZ
 oUHUE/x1YxgBPEILU3DhYHBL00BsX0tuFFSGlC6facn/aqaAwB14F/B8EOR6spctNfPV
 fKeKpPyFNC8+giz2yRg0t2FNs6eyPdeLqo5HkdJeS2r5TPorzL50Gz01XwSm0LPDywUa
 lXt8/fU0utWjfmo99S8kbTUCuqY04D/QGVa7XIZgXrHoxyZ1oTZOuALL6etEqyOFVDhl
 8YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681910; x=1784286710;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=;
 b=qkirtJo9SF3+gLgQMAOKlsKs2lXxqt6cggZc2VG+AZ6M3UlqZCH6jyLqhOQm/6fRUq
 3JNZoQAXFWbgdXu9fp8xZ4Ibo9ccoxw6/vVfdfVyOzsoy8/wWFylzR2WyS6uhVMQNAfY
 F/BA6mR8MwBLtdFETyBSROf52Mz9ko3FimnX71vprYSljfBc9fOJ1e/tyaAgy92dx4lo
 2UAOog+RlEfmh47I/G9Raa1Y2G6K3cMBrfEK3bACA/pCgcaZd+yzotsixMRcJvdFtaOH
 nvXhFEzJHKhlSpK3X3nOXp4C8C5iGT89fWeEJFpVeMGZFfPKGfhxrVqJ9IsO5qnP+mGT
 9xLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq81gX8u3uwikhrPoPIp/E1cQiZKuswR+yfl3Ab1hzoqey+pHnXwcz2CvHp1U9bIXqVLtGGLMcxFSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx0B15CPabPoj1ct2iigBL/cUUqXv8HQOvf0YKX4pY/XDClVvd
 SaIwLoDC5thv4EdyTlkzFuqofE54KL2j0g5cNSNkRWPi3ykEFMp9aZUXNwVP3q/b98USaIiB8lv
 bQbRY6tF9ChkW1PK64W4dzA/eaPYOlYg234XitTDH3nYFDzWyp2QC9zCFoqrngcBXkhCJLX4=
X-Gm-Gg: AfdE7cmaUPa0E2tAbFct62awZcDRZYP8NWEfl/4hlJqbLU2NCwSgpHAN7rEWMZktZWh
 LWF5Oq1BZ0PE4oqlmaWgJwscKLz86xG5mpIlPwrxmPczMxP5XolGbw0uiJuDV3QOmnTMF7WbyOA
 sQ1lP6jS8o6NRhm2BO0SHjYrt/kvg5zfo+uNCwGFAl0dXTuWvmTch27bD4S204bSuPV7cFARp0T
 oBHnX7eduhxYcWfvZVdv+dVDR/bsS7FOXiLNoW0nkbCM6n5M6IiePv3DCL2homH+RksE9vEN13i
 CeIRfs0yr4ItdbIto4E07QUxUgzGSQfpLQvb+74ZrJAmawSGdaXwcWUPNkobn6QERlTP9SLFkOv
 vt95UooEI1wzqnzdncem/Pz4dPKdWE5sd4rV1aARn95V+Knn3Gg==
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id
 98e67ed59e1d1-38942b786e0mr10762379a91.43.1783681910299; 
 Fri, 10 Jul 2026 04:11:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id
 98e67ed59e1d1-38942b786e0mr10762344a91.43.1783681909714; 
 Fri, 10 Jul 2026 04:11:49 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516ad7asm2610062a91.3.2026.07.10.04.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 04:11:49 -0700 (PDT)
Message-ID: <e775ae90-86d2-4901-8057-264953d25c02@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:41:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
 <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
 <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a50d377 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=52HooUGS_mQjH2t11kEA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ob1jA9bT0sOPxQ4y4CFogOALyH_Vpbpn
X-Proofpoint-GUID: ob1jA9bT0sOPxQ4y4CFogOALyH_Vpbpn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwOSBTYWx0ZWRfX76/4n94lZIy8
 B/FYCYr3Yr+L5iXZQwO80/zDRuKw3Esi7otyD/IThaxwUEDPHGv3L7hE0Z8tXyAHT3UNLEKUQVk
 VdT5dGtb0dIau4HmK6iN4eXHGh+QQqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwOSBTYWx0ZWRfX7ddams3SaCV/
 GiioSEZesBKqhQizfWpChbF2Vkxfwz2/rfg0JKodWsar/SrdgMo6oeabW+Z4KOQWtwFktRLR/QB
 /42kMufDj/pAeyCUM6YRnP1c2j8T3EpiPRzD3EsrnlCWnN9gb1Ua1W1TX9TE5i1u38OllooeJ5F
 KNZo5UBwLKVtQwxHppz0uLtF8BGZYeI8hY6TGOJ37PXDIHuuvtq9fZb5wrcyZViD9WEWPcGgSUc
 EzmWqTnxZ5rTycpKl0eGl7SExxMPzlE11C4YLN/zC4NYIKWN6e/Jg0Yk3hHhK9Q1bm6tIQ7skzX
 KUqCSpDmdnE5iDSCHvYe6sq6rfTSB13H5LUFjFEiYHk2rCLX9jd+q1j35DAbrcqRBAf7CybYO6v
 Kj9hPb3xl2orXVjOJnI33Cqj4nJawlJlgHX8qUAQHpNfSxVau51O1z7eTmNeT19tSRQIO0+/Ntr
 kOU/JZXLRhGObrR7mbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100109
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



On 7/10/2026 2:57 PM, Konrad Dybcio wrote:
> On 7/9/26 8:28 AM, Aniket RANDIVE wrote:
>> Thanks Konrad for the review.
>>
>> Sorry, I missed your comments on the v2 patch and ended up posting v3. I'm happy to post a v4 incorporating your feedback once the discussion concludes.
>>
>> On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
>>> On 7/5/26 3:57 PM, Aniket Randive wrote:
>>>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>>>> regardless of message length or bus frequency, causing unnecessary
>>>> delays on error paths.
>>>>
>>>> Compute the timeout dynamically from message length and bus frequency
>>>> with a 10x safety margin over the theoretical wire time and a 300ms
>>>> floor. For GPI multi-descriptor transfers, use the maximum message
>>>> length across all queued messages as the per-completion timeout.
>>>
>>> What's the reason for a 0.3 s floor?
>>
>> The floor accounts for I2C clock stretching. The spec allows slaves to hold SCL low indefinitely during internal processing. A dynamically computed xfer time alone gives no time for that.
>> 300ms value covers worst-case stretching while still detecting real hangs 3x faster than the old 1s static timeout.
> 
> Please put that in the commit message and possibly in the code as a comment

Sure. I will update the commit message accordingly and add a 
corresponding comment in the driver as well.
Thanks,
Aniket

> 
>>
>> Thanks,
>> Aniket
>>
>>>
>>> Why a 10x safety margin specifically?
>>>
>>> [...]
>>
>> The multiplier covers the gap between theoretical xfer time and actual completion time (DMA descriptor setup, interrupt latency, and scheduling jitter on a loaded system)
>> Without it, short transfers would have almost no extra time before a spurious timeout.
> 
> Likewise
> 
> (Should there be a constant safety margin added to account for all
> that? Keep in mind this driver will run on a turbofast Glymur and on
> a notsofast Agatti so any numbers that depend on the processor's
> speed must be reasonable for both)
> 
> Konrad

The 10x multiplier was chosen as a conservative guard band to account 
for the gap between theoretical transfer time and actual completion 
time, including DMA setup, interrupt handling, and scheduling delays. 
Although the value is not derived from a formal worst-case latency 
analysis, it provides sufficient tolerance to accommodate runtime 
variability and helps avoid spurious timeouts across a wide range of 
platforms and system load conditions.

Thanks,
Aniket
