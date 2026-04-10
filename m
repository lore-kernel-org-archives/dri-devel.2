Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5693E99068
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A67D10E1BC;
	Fri, 10 Apr 2026 10:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWzGM3WQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1O+0RfI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9352F10E1BC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:16:47 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AA61mA017381
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=; b=LWzGM3WQFiAU6RJR
 tY+utxEjkSbrUkh+oCfMPUEip3mr5IU5MUs9rvy+Q0Sweo8DjNPzls4lw5jA0vMe
 AV/mfjWUPxuvkuSKqCu1n4NV9f2wWLcABtvwqc8uGeqbmxht7jsb2V3M5QQglWHD
 oiKk8oTKd5hNQLNzL02ZNHytIfs5TF3uzjTGpp3anltCrvaGhbXDH59ofMADu/0D
 wykL2rzD/2ucsx4sGjEsIE69Bv1nDK20oaNRsJ1Tw/nhapoBSmwLkSnhnV7E7IDd
 6ZgwC7caIvvorbU8qrlp/rkjfdh6VFkCsoaHZuvHrsUMOFfe3UN83C+KG2Y+bu9l
 CWw8yQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5j01qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:16:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso2242135a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775816205; x=1776421005;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=;
 b=d1O+0RfIO8/UVJOqMdMZINwWit+GwS29XjS62xwvBBHxfhPVB9Ng5o7sHUmjQwesNd
 0335nIyYcVYmyxx6IRn8G0sjcwjIZfKVwUJeKEEjHxQex1FUHibAiVtrLUDcu+26Db+/
 tdvhbS58adOpjhXiKooIq0YkRpuT4AIyLT/Z8yuble31wQE4/i7cLXz3fOmGJxwp46Jf
 y1e+PQ0HfnFw5h0s1pCi4Xof6XROir/mFHvcENRtEru5fuaV92DqXtTsGrxGTJPKtkDB
 zAQ8fBNdLVGxjUexq0Aj4ic5CMt6ydFZmakZ88qbp2TjgPery9Q3eK2jSkZtiEletdNC
 3q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775816205; x=1776421005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=;
 b=nAOHb77/5wVb9/YwT9/HmtwkC/jSNNNgGDG6QlXRl4nHF/XMA91jl6fyp6j+znddvD
 GQUG8fj18iAKxXroxqOE+HpFliXYPJknssGVSxqIB87+03JRhWyVt+5+fTIdN1RqwisC
 HcnxSbABqiSEMMgGPJTkNKJJngir8KEhZnhTw2xSsBLNg4PEvbGA1lfOzp9W/9NkCDZW
 DgNJJDU9K8sMPgQhdxhzAzu5Laswk38RR5a6tJ/fSDmBZcE6GvO1aekm9Mgd3eRFWM+Z
 Cc/7voQ9BuBEpTnP8F5tMI7PKpWXRSSiRYOmmijKhLMNmWdc4y9KeZWSnU+lQoQXLYlb
 FJUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWspNkWZZ/ciX5i0xdpPbeot/Uqldl5zT9JEi2F7v4cX1l2TolqAEBsz7MQQKJUrxRGRVf7yLL9thg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg+qUJASjBgkgSXZ2DKaXNzLzEy+GKxGsxR9Qqj0WcJ4xGEEK4
 uSuBg+vMLJGhNXOW8YNutNgnNMSIRiPlAzbdAL0HLpDf4Vu1L2j6PB3g7WaIPahr6uTpHFPd/cg
 rfAocxnp3F+QlazOCqJdwNGHwueTCpY0WB47c6Jj8t05yjHg2eUx2678o6CyyuApMwddfJi4=
X-Gm-Gg: AeBDietMkj38Qh9WU74zYgSKIG/+ktljA5IebXh0wZCeNftz/T5tgr+U3gnme/4Je3m
 PMhwRt82JW8NpcCUqt9Rj8bVwEpnY2OBCwDmgcgskAiGQa1e0bY2sZqniib/qzT0ehwffJonq61
 JqlW04c1rTt8VdkL7DhiPnqexqj1NThqwn9OtDcXgAZJ+ofnHq1CWsSFxnGCnn+r8E67lJ5/EfR
 Fa7fD+4rT2V8Ubq3VAofsG6UJ5IoxxpYdiF/555vHnyGcP2PTCxD7ijgAG3iAF6bVryjbe9skQI
 cHOR8w2JT63DzgWCELcGLfH1QHcuyt6GAKJf/WtR7uw9SHiKk28tmUhSRduBBKHFWsapqgr/84g
 gfjpN1u63N/a9aEjEoJ70vxnV8U336WrjhMh4ONwZz1CQg/lonm6EdrY=
X-Received: by 2002:a17:90b:4fc9:b0:35d:a38a:a117 with SMTP id
 98e67ed59e1d1-35e42815bccmr2699516a91.15.1775816205345; 
 Fri, 10 Apr 2026 03:16:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc9:b0:35d:a38a:a117 with SMTP id
 98e67ed59e1d1-35e42815bccmr2699460a91.15.1775816204836; 
 Fri, 10 Apr 2026 03:16:44 -0700 (PDT)
Received: from [10.217.218.160] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e42e4517fsm984703a91.4.2026.04.10.03.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 03:16:44 -0700 (PDT)
Message-ID: <587ea315-9cc2-4ac8-919d-fe34b076f63f@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 15:46:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260403084135.1300931-1-aniket.randive@oss.qualcomm.com>
 <818da0cf-06e8-4a26-955b-67a3d5392e91@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <818da0cf-06e8-4a26-955b-67a3d5392e91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uqDZcENvyf6ZPKRmBvYTzkHdasmrdAiU
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=69d8ce0e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=v7GTtkQuv75T_6NhELgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: uqDZcENvyf6ZPKRmBvYTzkHdasmrdAiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX5Pa/kTGKwqt5
 N0EC695G2j7zg9tbTt/H3yZq+eH/e3W7Ydcf930ZSNs3Wt6UfBLZXhCImqP+dOAR22OwT3PkYe/
 xi+kxcs7iRIjv5qffG+VRNfxqheBBNXdL/1i9XhSxEZzkIhvaDRuZpwSd/HaZcNBAu+cQM6NPfd
 F7BvjY8KZOsDuOtePX6QHHWM/zNm/DLG3NExiJHbE+1nBU230F6KydCh4sCXar2qQCEpyGbXGS2
 iCYi5y5DzXxGNI4F5Qgf730cBiIRg1RiekwbzmV1wWXZrDT/LRokiePAI3XWxb2yTwvL/nUZ2d2
 G7hl31loojMMwZ7U45+az0p9cfFDqa+JFcPVVjRrrcbOJi3SSi9sNBXy3vTEQ+570u5ULlPciya
 OlC5jp5VSaA2IhQKSeJAWgLP+DpYSUlev43xXZJ09G39jD5FcnzceRNJku7Yf0TnCZybRmhPrs5
 R4iH8x/UbH4944Z7f1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100095
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



On 4/6/2026 10:08 AM, Mukesh Savaliya wrote:
> 
> 
> On 4/3/2026 2:11 PM, Aniket Randive wrote:
>> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
>> descriptor (TRE) on the TX channel when handling a single read message.
>> This results in an unintended write phase being issued on the I2C bus,
>> even though a read transaction does not require any TX data.
>>
>> For a single-byte read, the correct hardware sequence consists of the
>> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
>> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
>> mapping on the TX channel, and may lead to incorrect bus behavior.
>>
>> Update the transfer logic to avoid programming a TX DMA TRE for single
>> read messages in GPI mode.
>>
>> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>> Changes in v3:
>>    - Added comment in the driver for better readability and changed the
>>      position of 'skip_dma' label to allow dma engine configuration.
>>
>> Changes in v2:
>>    - Updated the commit message.
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index a4acb78fafb6..78b92db7c7fd 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, 
>> struct i2c_msg msgs[],
>>   {
>>       struct gpi_i2c_config *peripheral;
>>       unsigned int flags;
>> -    void *dma_buf;
>> -    dma_addr_t addr;
>> +    void *dma_buf = NULL;
>> +    dma_addr_t addr = 0;
>>       enum dma_data_direction map_dirn;
>>       enum dma_transfer_direction dma_dirn;
>>       struct dma_async_tx_descriptor *desc;
>> @@ -639,6 +639,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>       gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
>>       msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
>> +    /* Skip TX DMA map for I2C_WRITE operation to avoid unintended 
>> write cycle */
> Seems you are missing writing important point - For read message ?
> Important is to clarity what's the condition we are handling, Skipping 
> something is anyway clear from goto skip_dma.

Sure, will add more description in comment for better understanding.
-Aniket

>> +    if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
>> +        peripheral->multi_msg = true;
>> +        goto skip_dma;
>> +    }
>> +
>>       dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
>>       if (!dma_buf) {
>>           ret = -ENOMEM;
>> @@ -658,6 +664,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, 
>> struct i2c_msg msgs[],
>>           goto out;
>>       }
>> +skip_dma:
> Better name - skip_tx_dma_map ?

Sure. I will change it.
-Aniket

>>       if (gi2c->is_tx_multi_desc_xfer) {
>>           flags = DMA_CTRL_ACK;
>> @@ -740,9 +747,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>       return 0;
>>   err_config:
>> -    dma_unmap_single(gi2c->se.dev->parent, addr,
>> -             msgs[msg_idx].len, map_dirn);
>> -    i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>> +    /* Avoid DMA unmap as the write operation skipped DMA mapping */
>> +    if (dma_buf) {
>> +        dma_unmap_single(gi2c->se.dev->parent, addr,
>> +                 msgs[msg_idx].len, map_dirn);
>> +        i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>> +    }
>>   out:
>>       gi2c->err = ret;
> 

