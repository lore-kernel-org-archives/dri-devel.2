Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2152C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0727710F64C;
	Fri,  3 Jul 2026 06:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U9Nv5EcC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeMcjZi6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BBD10F64C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:28:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rfxg2994870
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 06:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r9DM8Go2RjnzqwoByfIyzL3ou20U9NAg7EwEKzgleYs=; b=U9Nv5EcChCcpZbE1
 lg+uK36ii2OVRC65b8XbcHe3hj7aN/Qh8/SR+ojhdmY/E0AjQuP+B9jgrYKg0MSN
 J2wOfwdjOIBZ5yDhhOdlpNqdiE+bM+cRD8H+3zqYIbcmjCdzVICKMb4nQpqVb/Ig
 dQdJnk4tDeRAj8ZmUySBJefO8tjJ6RRDiQdRJRDaDXBDTUYl1ixVGPdfT5ROIG4m
 j2Q2yQButRpPXMehYwVdmPrlPn7wd++hBBrKxDgKVpEBW/pD6TJ2/LmVFsD+d+C+
 nyqT1M126wgHKsJJDjcoBWh+e/c2Ycu5Y294erft1YpnnMck9pgAEN4F3kTljWMq
 ZUbfcg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n0y3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 06:28:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c804e38c65so4776985ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783060112; x=1783664912;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9DM8Go2RjnzqwoByfIyzL3ou20U9NAg7EwEKzgleYs=;
 b=HeMcjZi69xUffswlWY6kgI4FEFJ99eW9gst58K+HLOs96GglKQwaLEojbCkrqOHyOF
 PXHbyT4gJ0n6qokojZZuTGIjtZhKp7tRaUxysyTvLJmhNbiBW8TpAyZHga+Kh2Tm5/9H
 FOaHCiBhL+4+7R1we65RNHRFwvEwGn34LSWkFeRvYC6aVZ8tuIMEFWNLZu5VQPxa2J/f
 NfcRPFAvh04SvmDnBA554qxjykibu2ULSrBcujjIwZKx3D1V7VadRJ5T4GCSedwvfCno
 9OEslYLLW4Qy9vmaZKuUEsJoFlboRlpdadgeziXf2bTQ1Gj1CyNG0ihRSRSlnjAC/4n5
 HIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783060112; x=1783664912;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9DM8Go2RjnzqwoByfIyzL3ou20U9NAg7EwEKzgleYs=;
 b=ANpK4VWIwhdsj2jppN3S3tBICv5F9RdMLg3nJKbbQBGY36O9mpy5XHKAGBmu2S5AKO
 HLSqcX8VRAjFcRsqh3WW2xzYj+S0r0ddO8aj35nljTZp7n2LftkOGhdLzNTU71KNUMsG
 Y1sqIGBrMan3HfNTAl8OQiSdjS0T/KXylka+uSbfpAIRGgRsgPtnvLaqClOIZp3G0OTc
 1+ms/zWmbQS03rSneTwchv3m0cCqhDh7k47boFK56AbFQVBQFFEw9Yv8+s1Rs8Xa7uTU
 6fJEdJTHgO7siwgMdcHAtylte1jTF7MhZ8NWBNo5by6ruz9MlBOyU9R0WbROj7DnBmW3
 1hwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpVaqoIjel411k/xsjOadm30JOQwkxUHKsrDubvsO5Eno20pXHe4kNs/1v8uQBBi4fFT/QrZDi05g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY9uYgaXSjYiRY4f7LM3/vHO46DNjSfF9cPmgcvDtFq2jnd6Ez
 9BOrSKdkRmPkA96+LuERx1UBry0c3AvHnb9mc+3zt+eXpInRybpQvWmCYEHQXIlFbQrl7a2kaGp
 ESX7VqkH+NAfnNOiFy/Y8CxYjpcIc2zg950j2ELW/t3eCjnokwjlJPEJhptMChPwnqUh0pNI=
X-Gm-Gg: AfdE7cknsK/WrkqZAmSusDrA6cmxJZIx1LxX5HKiIWlE+2dyNzOkm6ayQEDuC6zoko7
 7l9kaWVOcEXwkaP7fz6M+nbu7K2YTb3uqaPV2A4Dt+7oVm16d3WCjU+ZSFgeui3k3B/H5pzvUIT
 /tANQF9cJinueF5L+TJtVkkGAUZHNGnBMfB6t1Z1mcALr/zN4clcAtxlcVd3NTwhnkRbL4Nd/ya
 rLWzxtkkwknVW95VzOReScXfH06Jc1gskJOAT3tj9O5Lqgq2s8fK6n+qeqhgzOAhwHIlBKUiJ3L
 afbKk5sDVqKmuXz0UPnz2ofu3v6AIGiQZ4M7EZKhmyqljjt1hf7ZTPTgzp4wSKj+TKeuH3xupAH
 J2u4ACA/8XxsMi5Grvf0W3krGw3x01IlRMKSV4lqDY/4Xp/ort6Wbo+YuHybePRQn4Z11ZTQNGR
 4JNPsNog==
X-Received: by 2002:a17:902:d2ce:b0:2ca:ce91:f027 with SMTP id
 d9443c01a7336-2cace91f1eamr28805945ad.36.1783060112158; 
 Thu, 02 Jul 2026 23:28:32 -0700 (PDT)
X-Received: by 2002:a17:902:d2ce:b0:2ca:ce91:f027 with SMTP id
 d9443c01a7336-2cace91f1eamr28805545ad.36.1783060111658; 
 Thu, 02 Jul 2026 23:28:31 -0700 (PDT)
Received: from [10.133.33.167] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad6f260c7sm4483705ad.12.2026.07.02.23.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 23:28:31 -0700 (PDT)
Message-ID: <630c7fe6-bcc6-475e-9738-2d90d63eb050@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:28:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, amahesh@qti.qualcomm.com
References: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
 <b907b6bd-ea6e-46fa-9546-b8b62e12bded@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 quic_lxu5@quicinc.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <b907b6bd-ea6e-46fa-9546-b8b62e12bded@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX/njGnd8yl4oy
 uM0rGoPLfvl2vpJ0kVSXpndKCZIHs1q7GuQ6L8grV29n8hFeorIFq+DxvF1qwZnXVQbzkgbIWIt
 qvAij7m8kXkLi+Q0Ti5Oe5/Gh9CG8bI=
X-Proofpoint-ORIG-GUID: rIccbE8MJ7_CCfaFrEKN7O5fyDJwZkOk
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a475691 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_y4YfpV96PzIBbQw7ZEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: rIccbE8MJ7_CCfaFrEKN7O5fyDJwZkOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX4m60Xz4zFvq0
 aH40taGy5wvQbhjNSnWoDuGE/jq9t6VamG3MzJiDpbrJ8j5kFaXFhgz+dbEt1bS6QxnhKJjwzSm
 NTp7gEfQTieEn88mT/XqbORYhmKzT7878EQ+2xbuKIpyjfYNPa2idcm+bRjSPniNBOuSY70wa6t
 y8WgyKIB6O6smKZadnjbPBzhOa3qH14B7xNhALP0Vb8vWh0W972VBC8XHRZvtC1cvQgl+5IOU3E
 1lzZ0F7TYyYEK2XfWoG9auVKPar2xMlymUMEyYTD0pGIv7ddANw1a941jWOlF5VZbogsJGENzlp
 AtEeUxRuQkItcFhzFupk56zBVxBA5GK/UhwI+QDS3SuuVQMlMxZihHiN0YEHqc7oNnsHsZYfGel
 4kQ6BzOHiP75TCU6BiD1SnS6w50T7LdgzJsj68FtT0lkx1PH9J2zS4ew0SKF9ZScYCT0hxX0csj
 /nMNLf+JyPLDZBlXt5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058
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


On 7/3/2026 1:16 PM, Ekansh Gupta wrote:
> On 25-06-2026 13:38, Jianping Li wrote:
>> fastrpc_create_maps() performs map lookup only for buffer
>> arguments (i < ctx->nbufs) via fastrpc_map_create(). For
>> arguments beyond this range, no lookup is performed, which
>> can result in duplicate DMA mappings for the same file
>> descriptor.
>>
>> Additionally, if the same file descriptor is passed multiple
>> times within a single invocation, performing lookups with
>> reference counting would increment the reference multiple
>> times, while fastrpc_put_args() would release it only once,
>> leading to an imbalanced reference count.
>>
>> Fix this by allowing fastrpc_map_create() to control whether
>> the lookup should take a reference. For arguments beyond
>> ctx->nbufs, the lookup is performed without taking a
>> reference, ensuring that existing mappings are reused
>> without introducing duplicate DMA mappings or reference
>> count imbalance.
>>
>> Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index a9b2ae44c06f..2622a1360a65 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -924,9 +924,9 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>>   }
>>   
>>   static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
>> +			      u64 len, u32 attr, struct fastrpc_map **ppmap, bool take_ref)
>>   {
>> -	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
>> +	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
>>   		return 0;
>>   
>>   	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
>> @@ -999,23 +999,23 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>>   	int i, err;
>>   
>>   	for (i = 0; i < ctx->nscalars; ++i) {
>> +		bool take_ref = true;
> bool take_ref = i < ctx->nbufs, also add a comment stating why reference
> should be skipped for DMA handles.>

Thanks for the review.

That's a good point. I'll initialize the variable as:

     bool take_ref = i < ctx->nbufs;

and add a comment explaining that DMA handle arguments can reuse an
existing mapping and should not take an additional reference, otherwise
multiple references may be acquired for the same fd while only a single
release is performed during cleanup.

>>   		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
>>   		    ctx->args[i].length == 0)
>>   			continue;
>>   
>> -		if (i < ctx->nbufs)
>> -			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
>> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
>> -		else
>> -			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
>> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
>> +		if (i >= ctx->nbufs)
>> +			take_ref = false;
>> +
>> +		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
>> +			 ctx->args[i].attr, &ctx->maps[i], take_ref);
>>   		if (err) {
>>   			dev_err(dev, "Error Creating map %d\n", err);
>>   			return -EINVAL;
>>   		}
>> -
>>   	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1508,7 +1508,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>>   	fl->pd = USER_PD;
>>   
>>   	if (init.filelen && init.filefd) {
>> -		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
>> +		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true);
>>   		if (err)
>>   			goto err;
>>   	}
>> @@ -2100,7 +2100,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>>   		return -EFAULT;
>>   
>>   	/* create SMMU mapping */
>> -	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
>> +	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true);
>>   	if (err) {
>>   		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
>>   		return err;
