Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3377CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE6210E2E1;
	Mon,  6 Jul 2026 06:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XE7VxoPL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtYfgmla";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA4810E2E1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:13:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641ZSk3585603
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 06:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bKz4CaC/c7J7lYoZ1j+G1HE7pYhCs1U+Xzm8efUob24=; b=XE7VxoPLvtu0rC7r
 U8nG3KeyQXspD98WHqNbF2tmUpbK1Q/9PhrSBGHckuRhrneTfrNmw2mY+epRfAVl
 lOMOFp1a77mhkcWENkSvgaIZXGoggLzj4MGZuTj9j3FRBc6qzjjEBGiwpLGpAPhF
 NVChyui42K0hCO90aqSMN2R8CZZuT73bF++eJ+UsYuINf21Q+4XcBBT3e2bC2Dw5
 Ne0mXYQS0T2K4XUIQUPmDaIG9pW8UHIOaq6vQxZB4PzDchYnz5Qm7m6OH8Xg59vD
 sfUW9zxZQXKjox4lSjgFakSqBFS5HKEmoJZxFQWd7+ZBtv4G18d8pp2suaqHvMOi
 uHH0eA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8umntx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:13:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so4397196a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783318385; x=1783923185;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKz4CaC/c7J7lYoZ1j+G1HE7pYhCs1U+Xzm8efUob24=;
 b=HtYfgmlaD10FSd+3pC2S9HRcSJFHhgLMiFhatXcgQqieOWa01smpcKkgkDXsS28AqM
 nXh/2NqPod1B/DBts2wx+XLPcq+iZqq3V+1I7v+M467+dEhsMUyzlRHGNNq39qAUdjuu
 anXc3SKTHDGwgEByAyKS+nDAh1BDI+iBRi8pxgD/fqoU1S8FILGtDz8GgZMsgqpjMkmz
 2PTlLYM+A8g2gL8lZrGlOqR6gWb81+5azqv33p2Ad3vzb8W3qiTDnuyewx0CEQ4oYX6F
 i+lFoAJu00KYf6+Q3nB59lshxiA5bfa4Ze8Ft2g14mVcHoIIjmgLk3tPJ4gUu7UVkfs3
 hHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783318385; x=1783923185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKz4CaC/c7J7lYoZ1j+G1HE7pYhCs1U+Xzm8efUob24=;
 b=H9QbXW995qEi61S3J7G7YdhzQULIzuS678dkcxCNy1y6nnANvaV4RUiRK30/V6S/zp
 7RGNvXSTVGItici2QvXNzrw4RlZc5zQre4n1vR9BkqIJ2SpXTVk1k/7O5+HA2+L3muat
 Yd4/ARneZNNSOcFQ1zb3yLDZTIRY6KNqpTGOiCv0QwBAB2CfuUCLxQxy5YoGxXQVh2IH
 aVGBm2CLzvVDPQoM/4O8iZ9b03MiLqQIvg/dYjfjQT4eVueCdcPyJlUa2I6nexs9WCDf
 LYtLqGtz9tjg7HjZPK80T+uZ/TcKDiNs9oBtfn38sjbyBelMo6I87HSGdtfHVSlUtgzw
 2azQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOywWUrGNvXeVS/tBNzLLBbwbdfBB2j8vuuGepwoGw9HMyNLsXQJbafnzLLcMJy3w1twsm1hHXNZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUrPywYaf9yILGBqZvBdL+mErM/cFr2AbJMZF0gfr5u24pbh7T
 QnrQpqTAlhP3uV6QXVPxhr59EyO0fSNmBhPLoRMvJvs0KM9susMoUakm4CTC04N4ZLnhY2LIBJk
 X/UfSBTPPHsLYun6+l3YfbNnjtb0+XPsSxRup7Jfysu0/egViIBozzHT7DIILAlUI8yNvRPY=
X-Gm-Gg: AfdE7cnjloBDc8qOcUKKSYQO9Nag2D9SH94e+pDZ81dtErVHpSVorcepTE0amWfJf8Y
 TT3TsKOH5oXGFukKUJFegj1FIQWXGJU+gcd2hVWXJsPLoKThQ6b2kjRqbpnN6LN6+2H6HZRc2VR
 cRvorV4JqWyHI9yCB3EvEbpGEcKg3v2SC4FFJRo71lIHMYCj3VkJ6TDz8H1ngAshbCuy2hLX/lE
 0w1GrqT/odswo2lkClVzeiM9NCyQ0bFrv1hjueNsekqtfa8OeJFIXD+pGcSwDPBnc2ywSxFl6Vx
 UG/vOPE8Be2ioyBYSevodK/wbjWdsswn9HfhLNguzkWjcn8WYzrVLA3ryGFVA4BPpPY+pRTEjdv
 poMQOpYcfEqlb+leOmnFMA4NEcCdqIo1BellAEeTU8Q==
X-Received: by 2002:a17:90b:3805:b0:37e:9e9:6ffc with SMTP id
 98e67ed59e1d1-3829f6e3e0emr8352820a91.25.1783318385117; 
 Sun, 05 Jul 2026 23:13:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3805:b0:37e:9e9:6ffc with SMTP id
 98e67ed59e1d1-3829f6e3e0emr8352798a91.25.1783318384627; 
 Sun, 05 Jul 2026 23:13:04 -0700 (PDT)
Received: from [10.204.78.23] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38127d147a8sm4313752a91.17.2026.07.05.23.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 23:13:04 -0700 (PDT)
Message-ID: <113f7536-92cf-422c-84ef-cb55a037aa81@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:42:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: create duplicate sessions after all CB
 probing
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
References: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
 <6a7e3394-9dc7-4371-9935-47f3be8a59f4@kernel.org>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <6a7e3394-9dc7-4371-9935-47f3be8a59f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CghhR0cIGee0gCt4vnoBCIKnl60yOb4-
X-Proofpoint-GUID: CghhR0cIGee0gCt4vnoBCIKnl60yOb4-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2MCBTYWx0ZWRfXyh6UYeXTGvG7
 iFNi63W2JP2n3ZeM/ugsSJUjAbMd56Y95L6V7iDe+0go8o2hXZp+mRKPKxWn6Rd9LupUVjgij0B
 lDSzx4BrXismFrfWeCyC+FAjroWOoW4=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4b4772 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jvgINQJEQb2Mk2KRUnwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2MCBTYWx0ZWRfXxlhPoHNH7E00
 4Zh8q06OS6uqnibVgx0HK54ycP3b4uV0dXpVrzxdRWOoB9uACmKEi1Zl0xSkx42lfk5jSQn9XWo
 msJ1CCbaqOoOdJAIiwlVB7TJAZl39A3ottkG+OfuEV4j4c5KabfaJZb2mwCYxsYjd0MRyEeIAjX
 zHit7svWS1K2+VRgCENC8KjJV1pddYdi8HbySi175jEOLFyrudlZuGuXyUmbXO48wjh2UJVcRWb
 RZAbLIak807tOTSYminBnwS9lPIGwukWQT2CXG06Pbop6ABEPOxn7NdBHZrLNAr1WeGyKPoDix8
 XFdMADJpM5uIJXhe8cTYrcds4vX5camnBj09C18VSUJ+jZPYbx8QBw+5KeK/BkS3Mf2OyGf29Re
 iBLrgjDIEZ3Y286kIrx3rzueHRd23g8lLQhRmTvRWTycM4/vo2Y5NdHBLBKb/oqcqEoIWpo22vO
 SlmT5njb0mGLx7hgd/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060060
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



On 7/2/2026 1:51 AM, Srinivas Kandagatla wrote:
> 
> 
> On 6/9/26 11:33 AM, Vinayak Katoch wrote:
>> For ADSP, only a limited number of FastRPC context banks (CBs) are
>> available. Each CB supports a single session, which means only a few
>> processes can run on ADSP simultaneously. If all sessions are consumed
>> by fastrpc daemons, no session remains available when a user application
>> starts, causing the application to fail.
>>
>> To address this limitation, a Device Tree change was used till now:
>>   qcom,nsessions = <5>;
>>
> You should mark this property as deprecated in dt bindings.
> Which should discourage people to use this property.
Ack, will update in v2.
> >
>> However, feedback from the upstream community indicated that this change
>> should not be made in the Device Tree. Instead, it was recommended to
>> handle this as a driver-level change.
> 
> Changing it in driver will make it applicable for all the SoCs.
You are correct, that is the expected behaviour.
> 
>>
>> Instead of duplicating sessions inline during fastrpc_cb_probe() using
>> the qcom,nsessions DT property, defer duplication until after
>> of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
>> all compute-CB child nodes have been probed and the session array is
>> fully populated.
>>
>> For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
>> last probed session once of_platform_populate() succeeds. This keeps
>> the per-CB probe path simple and ensures duplicates are always derived
>> from a stable, fully-initialised session state.
>>
>> The qcom,nsessions DT property is no longer consumed by the driver; the
>> binding and DT sources are left unchanged.
>>
>> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 1080f9acf70a..46afbae9c234 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -30,6 +30,7 @@
>>  #define CDSP_DOMAIN_ID (3)
>>  #define GDSP_DOMAIN_ID (4)
>>  #define FASTRPC_MAX_SESSIONS	14
>> +#define FASTRPC_DUP_SESSIONS	4
>>  #define FASTRPC_MAX_VMIDS	16
>>  #define FASTRPC_ALIGN		128
>>  #define FASTRPC_MAX_FDLIST	16
>> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	struct fastrpc_channel_ctx *cctx;
>>  	struct fastrpc_session_ctx *sess;
>>  	struct device *dev = &pdev->dev;
>> -	int i, sessions = 0;
>>  	unsigned long flags;
>>  	int rc;
>>  	u32 dma_bits;
>> @@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	if (!cctx)
>>  		return -EINVAL;
>>  
>> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
>> -
>>  	spin_lock_irqsave(&cctx->lock, flags);
>>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>>  		dev_err(&pdev->dev, "too many sessions\n");
>> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>>  
>> -	if (sessions > 0) {
>> -		struct fastrpc_session_ctx *dup_sess;
>> -
>> -		for (i = 1; i < sessions; i++) {
>> -			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
>> -				break;
>> -			dup_sess = &cctx->session[cctx->sesscount++];
>> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
>> -		}
>> -	}
>>  	spin_unlock_irqrestore(&cctx->lock, flags);
>>  	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>>  	if (rc) {
>> @@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	if (err)
>>  		goto err_deregister_fdev;
>>  
>> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
>> +		struct fastrpc_session_ctx *last_sess;
>> +		struct fastrpc_session_ctx *dup_sess;
>> +		unsigned long flags;
>> +		int i;
>> +
>> +		spin_lock_irqsave(&data->lock, flags);
>> +		last_sess = &data->session[data->sesscount - 1];
> 
> Why only for last session?
The number of ADSP CBs is small (3–4), and earlier sessions are consumed
by fastrpc daemons. The last CB is the one available for user
applications, and the previous qcom,nsessions approach also targeted the
last CB implicitly. Open to a better approach if you have one in mind.
> 
> This is now un conditionally done for ADSP which changes the whole
> behaviour.
Until now this duplication was only needed for ADSP since it has fewer
CBs compared to CDSP. CDSP has enough CBs that this is not a concern
there. The unconditional behaviour for ADSP is intentional as the CB
shortage is a hardware constraint common to all ADSP-capable SoCs.>
>> +		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
>> +			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
>> +				break;
>> +			dup_sess = &data->session[data->sesscount++];
>> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
>> +		}
>> +		spin_unlock_irqrestore(&data->lock, flags);
>> +	}
>> +
>>  	return 0;
>>  
>>  err_deregister_fdev:
>>
>> ---
>> base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
>> change-id: 20260609-dup-sessions-ea2acaac1994
>>
>> Best regards,
> 

