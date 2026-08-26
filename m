Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A3AC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6AF10E214;
	Wed, 26 Aug 2026 08:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TS5xN8Cg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dL6vDOT1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B90710E214
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:41:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6Rq1e3210752
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 toc2DNcq80nDKIdm/5fVrSwC6pi5hJO7nJ40m2OU9a0=; b=TS5xN8Cgz5VazS8I
 UqGUSrJLw4Q4NkwLLPJvu954fBWjkLuh4cxC276u8VfxIjAMK1cvD6fInU5I6UB3
 tH6sxLa8wPdNKtduMwpeoRwRjmFCLng1OeBgtrx18VTkJ8GgDzglJ1/vWiJyJ3t/
 RjtAgJ2iMgbUcTYz7EE4K2td7Wu0ov50AhCcWOsygLW8XHZJ4S2nC2EDLQk+nAN5
 6gzlb376vALkqRX7qEg1+sVyV9xU1y5b8eDhxVWLtQfrhHClCeNvYuOba1B7VsH3
 Vunr7FrHZZc9mUdPlmEdkNlAxyGvOfIEaK9JuAY8t+ageikntEUTmRKlHLjAo8AU
 bxbIqQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgrb0df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:41:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-853402198efso378503b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787733713; x=1788338513;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=toc2DNcq80nDKIdm/5fVrSwC6pi5hJO7nJ40m2OU9a0=;
 b=dL6vDOT1B7g8b5x4rU/LGPyc7AsknHCct4v5xkRgMMHJgw4ZJSYTYHsuxh4UJqU69Y
 3Ix+jHKX69ZVsjzqd+8CNa8qgyL1P/45KKT3HqEeT2pcPOz2hllbj8QF9yRPOhlSoXad
 iwy1I+Ip0tKigAJYPoGw5u1maLAz+eDePyTmnRmyUPllCKmqIj+hj2jVNDIxC+y9RIO2
 OhdPMbRB7fP7RBrWsaeGonKzthNZit31UE4fnhow0BqhjAGfRbSRkvwqqgYQdI/tLdph
 PiuxY9gO28l+DvHvbnoVUupn7AvAvIIQLVy1770mJcC16MTBqbF7yhbscGnTc3Ow/XL/
 O5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787733713; x=1788338513;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toc2DNcq80nDKIdm/5fVrSwC6pi5hJO7nJ40m2OU9a0=;
 b=ibop7mqyceZJbXfAaOJzhfWKmT5xXMbXnCoymcKsklnTgcmtaJxXGb7CfSR1ZMApRO
 QEgxH2RXSQdWCt8KgVifqC6PlZpz4LBwLjhwWwWOYHsmoDhyFn5rw8r22guHCdVq29W1
 u62K4GvoSYIxHtmIBJj/ZpO4G9/Zh30rsQpxHi+yndnOKyrsBKVZugUd7/67V/fwLo2O
 lsljVP0wooDBGMVdhphCp1A0MW9woK6hHpq+pibO409wah+Ke6FHuJkJo3788/ScQ4JL
 K1XOMX5Ccj8E+OYJ7c4aIxD8vPsYyL0BoYmYyzH4HqU1tTjq/Wg/5677ypL/a7f4uKhq
 E1kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqS63bJgcIS+h3vZQcflqTJJQ0TNCEw55rZO5f3M2Cv1Y66zIMo+oja/khsXqfQ5EwQlnhQhHkMA6A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNqK86DPR9QEtb8Jao1n3xYXOMLcvzeJB8LgkmsR9KspDFwiX9
 EbQ7e8afUHkz+Y/pvJWq3Bip71+SE5LWqbHeTO3HnHHu71WrKYv3rpxwBxc6tbelVSGaTykhqEw
 0OLKni1FJ+v++qkouDNIx6dUcngK1yjpvZMjHKTBmOfqwDF359WItd1B6ITr8TnvV/52ciRA=
X-Gm-Gg: AR+sD122o68HOvqgdJTpt7dt+RZphtC9tVLejTo4a833hLEPeRxzeO8D199So/yxb8C
 snk9ZLf4h1EnWJ0HsXJE7hdnic0XOIt96cxj59hYZCxU7J72UufmQ6sCZh8ja71mP1fdebKON+7
 yA6Z5qUJrBcr1A7BJz++FEdAcwDRqOKqg5h0N6YKk0iQc6CnpwbxV7RNjWYO4974niwvfnujloz
 wl1c6qRiw7qQJM4iSPG5/Bjbs6CgY2bFfd7p0yC9QyuKuqla6f1OL/cEl+sSHeF2ESDyVU33HrO
 4owwsFTGD00e/HtJziHKOjNmgr2v4PvkHNCmnSAnaVboaHzCqnZJhHYU4L5h4PPpK0oCBulXZP+
 XA3AxkJAj1eXjD/4IJkdNcUwI5ldQQerQKHnRVaXre6SscSE757UKWTzO5Ik4rlfHd86/jSw=
X-Received: by 2002:a05:6a00:178c:b0:848:6c9c:4074 with SMTP id
 d2e1a72fcca58-85371cb5696mr8913347b3a.1.1787733712922; 
 Wed, 26 Aug 2026 01:41:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:178c:b0:848:6c9c:4074 with SMTP id
 d2e1a72fcca58-85371cb5696mr8913268b3a.1.1787733712430; 
 Wed, 26 Aug 2026 01:41:52 -0700 (PDT)
Received: from [10.249.29.124] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535afb2caesm642714b3a.26.2026.08.26.01.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:41:52 -0700 (PDT)
Message-ID: <f78bf297-e676-48f9-b2e8-565a8758ac6e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 16:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, amahesh@qti.qualcomm.com,
 arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
 <dcf8d925-cf9e-47d8-ad79-0b5e641529ee@oss.qualcomm.com>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <dcf8d925-cf9e-47d8-ad79-0b5e641529ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KggWKntNenKdGTXgrEE26Cdv7dNC1MXx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfXxWf9PX955y2O
 QiRC0lYt5Lk0tFzWfd7LjpPmpB4bYFTnpwNC/gI/bFSKbHZFVXIdfdqc0BnPyVH7mIxIbENyWh2
 804Qeb9xTfN38RHMXEdKty6G0y97djJ+6cUnJsWGVpwi1CHTAIuGuKuKlmnnFPCSJNGkdaJBCZL
 uSEBuTai3wKvC24ozitDimTDMyU6ijaPyy1wa2DmmTBvcg8QglGv1JsVaD7DtRdOXvEUTiXAvPW
 oDiHiQmuCD3q2QCD6NWqxpW5OCwnVJ1BbgJFLnOgmiCdnde79U8g3MZ1vWThd62XNMPZdYYiSLB
 EtZDckhU5qy8jJnK3d+QHZ9WL83l35OnvN5CeTElHRor1DnCCVd2r0yUjbQKz/xL6HYaKid+FPA
 1GOLT1amyRnimUn7o0byF1mHFnc/ZxvAC4qAkYBeVT648eR275xJERi87lOA+o1L81ld1Xre1QP
 vyi8RBe5xCNyiYUVEeQ==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8ea6d1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=4MCOB7C_Cw_4N5Uyge0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: KggWKntNenKdGTXgrEE26Cdv7dNC1MXx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfXyLM0IB3V0Aw7
 cKtzv4MY5DIxCTShmibyivbPhKf7/1hzAvblgaN10NRJZ5FsgfQHQOYbuI2XjM25diOCZz6LFUT
 7lQMPEixvVWuteup4NQJ/p1ZO7Z4dg8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260071
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


On 8/25/2026 2:47 PM, Ekansh Gupta wrote:
> On 14-05-2026 11:58, Jianping Li wrote:
>> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
>> to retrieve DSP attributes during boot, resulting in repeated
>> "Error: dsp information is incorrect" messages printed on the
>> console.
>>
>> These messages are observed continuously during boot when metadata
>> flashing is enabled as part of RC releases, causing unnecessary
>> log noise.
>>
>> Similarly, the absence of reserved DMA memory is a valid
>> configuration and does not represent an error condition.
>>
>> Since these scenarios are expected and do not indicate a failure,
>> downgrade the log level from dev_err/dev_info to dev_dbg to avoid
>> flooding the console.
>>
>> No functional change intended.
> misc: fastrpc: >

ACK.

>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 1080f9acf70a..05ec14c07fd0 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1802,7 +1802,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>>   		kfree(dsp_attributes);
>>   		return -EOPNOTSUPP;
>>   	} else if (err) {
>> -		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
>> +		dev_dbg(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
>>   		kfree(dsp_attributes);
>>   		return err;
>>   	}
>> @@ -2361,7 +2361,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   	}
>>   
>>   	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
>> -		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
>> +		dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
>>   
>>   	vmcount = of_property_read_variable_u32_array(rdev->of_node,
>>   				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
> Can you also move this log[1] to debug level/rate-limit? This can cause
> dmesg flooding in case all the session are already getting used by
> processes. Some discussion around the same happened here[2].
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n1786
> [2] https://github.com/qualcomm/fastrpc/issues/383

Thanks for the pointer.

Agreed, that log can flood dmesg when the session pool is exhausted.
However, unlike the two messages in this patch, "No session available"
reflects a real failure — fastrpc_device_open() returns -EBUSY to
userspace on that path. Lowering it all the way to dev_dbg would hide a
genuine session-exhaustion condition from the default log, making such
issues harder to diagnose in the field.

So I'd prefer dev_err_ratelimited() here: it caps the flooding while
still surfacing the error. I'll fold this into the same series in v2.

Thanks,
Jianping

>
