Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B847ED7B95
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F403210E573;
	Tue, 14 Apr 2026 09:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzFcidfB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NFsWdm+t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BC210E573
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:49:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6kMun281295
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U9lFHIlpJYOdo8F//iQ+Ufb6uo+NdvS2bpAUFa2NvQQ=; b=RzFcidfB3e58xwDA
 TrUaa7TKX096YFPR8jB2yXpbZdweC568akr6saJOdjhVrHQCgLkO2DXK1nGah6tP
 dgmweSdm6JlqLt/jKMc/QWMO4hfe6JfcIar0gc51O2bdklgJ5MLOC2sM49iDeN+6
 tiqKnF+0ejRCbcXMrxxDcjZCzaIefALJJM7l+5BHVyyHPmj+oCWkaMw/3JaUCS9M
 lysUpWuPQ5i9MLl5ZUkc7RIQ/jBCOx9if6xakQnYKr/Lk0OZ4xfoBUQG9kJhUwnW
 c5aQdCDMybfd85RBMsl6pPerpmSwKC5M3x3nFhpPT0g8v8cXiU3PkBI/agutfp1+
 aj6ZYw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vj4xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:49:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bd4feb9fso2924324a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776160146; x=1776764946;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9lFHIlpJYOdo8F//iQ+Ufb6uo+NdvS2bpAUFa2NvQQ=;
 b=NFsWdm+tT9GJ+CWNAWcVgMeP5BoaMFdbe8t1h0UaYViu6s6yPPRVtnF6MJzpKVCF55
 UMi0x60Uwi+IOqJFCLg9DTrJ629CEAjB/BZ/xgU4inHqU+su9EC7zL28OysqvXv8OnjP
 QjUY1Om6xfs/6NGMjLtKupvl1eDVt98ZOz2avrV4iQzXcKSabQk79HZiXYiFKhmZs1zd
 Z5pESX/l5G87RFYrpjwWsptbNDNwbbETpgbgRE2PtS3pPu8YLDYJPUR2vJWtp7gKEOVW
 dpiX8nGKkmoo5LKetkvdshY+/x3C5bupMU3CYCwmZK/wjQaFaWPM2gvfl0sRYhlwv5SV
 DXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776160146; x=1776764946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9lFHIlpJYOdo8F//iQ+Ufb6uo+NdvS2bpAUFa2NvQQ=;
 b=PgwEM7U29BC3pGkDy7+OxHjXle5asegeiW1wUFfys7KuVJrLdRuVcCdIYcTdPmzGQQ
 3ouoeNO3Gyf/ATrI78ZtZKF0QA3c3jg7Ab2BUPD8QcpLXRJ6RoZ0fzcuzd0g4JwtLFIV
 TxfUJ6jPZAtjmmCSbBoWvcQlfVNlQY8GRoLMHKVWg7ShfVvOyL6yz7OnyRvXlpPHJD07
 5gAnufEqDktbGmqqdNwoa8kKGcP7SFZOiV1qU9VOgayM/JagCu1MajAyx6Wa2GbumJka
 mXPj+iHgLZGf9qtBh3kz4phDlyomfdpXTJ4ExM+mGu/bHscysnuIsk4WV0yHV9GsjPna
 KoyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w5jUyLlQMcoJqXvimh2Pn1k2xxtXEk0Xxm7ANSNkscv9PWnP8eOJ6pA90JUq2wb8MFS6zZMzRQ/w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3MumNuFA8hy+lN0L+j3cmdR5vJ36NXjfgLzIPzbYQ4wlCVrEt
 xFX/8m1NLzNp9HC0J2iNvvQtEWkOsARCUffvUnJn0wrnly4J9Y2MXxUrwzQMVJgg/pz2oSPEsXD
 7Wc+MAO44rsLsZz2hXM8g38XBE8ocHoTN1KMYJqh7YUmB+G+UHKzUQqSyU0ZlPwF+gUPVui8=
X-Gm-Gg: AeBDiesI4V9UQ7sWY09qelGcQ9lK70Okv+2Fn2k8VBqUc+dNNksKuS4j8LiFXsY4AYp
 4ZXq/b4LOewqNzwuxGgYOP+BP9Wg18NiLQ0RI7t2bNkuQpRVfe4PSUZZBkJMLUcR5xVHPTPnXt0
 lrmH9JhfHXQaFitRbhAAqxpbY+o2aXZ5IqbrCOxbxgVhFTOgsfb+cTl4H5LeoBy8zt4HXW5E0Ij
 P4hpDsB4PFuyngXnbtc6Oja6Ln6CS8aV4IeRYCMSxHVA3KGixBNNCeb9dCl2+HTfTMQatpXDz/e
 0ZERZ6xBw0ONJ9lzdEv9Lj73/oZVsebg1k0MXDuPPhtbqoF5J8DDh55kmAZWG9Zdx4s+3ybZT8p
 RoQijDnkeuwJBsj/egtm/ia/+CACmAmx1fz7oGSTzIGJF1/vtxqzLrQ==
X-Received: by 2002:a05:6a20:7347:b0:399:12d:41f with SMTP id
 adf61e73a8af0-39fe3c92b30mr18024898637.7.1776160145697; 
 Tue, 14 Apr 2026 02:49:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:7347:b0:399:12d:41f with SMTP id
 adf61e73a8af0-39fe3c92b30mr18024854637.7.1776160145166; 
 Tue, 14 Apr 2026 02:49:05 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc7e7sm12108505a12.10.2026.04.14.02.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:49:04 -0700 (PDT)
Message-ID: <75e54438-f19f-4542-a271-14e7a68c9635@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] bus: mhi: Centralize firmware image table
 selection at probe time
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-4-47ad79308762@oss.qualcomm.com>
 <2sykuv6r643v3i6ymdoevzohoxdmgrrodvgpbaystskz7fwgun@fd3p7gcso252>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <2sykuv6r643v3i6ymdoevzohoxdmgrrodvgpbaystskz7fwgun@fd3p7gcso252>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UBNKbtv1Q8ikDyLzEfndAccXvbN_CdqY
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69de0d92 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fsfV3h0Z8HPD5dlk9hgA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: UBNKbtv1Q8ikDyLzEfndAccXvbN_CdqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX5ok5N7pmfwFU
 XSSQJ32Mu0knNhdqkyKBLzDHqOMQOLb/NnhF8zUOn7Ji/8hr+Enw/Du8WjKLe+7NcNUOohkVP9S
 wlH43MpGb/YsUWyCJwpa1MQ+291v+Wrir+3Jez9hHnjf0dIA0Q1D0VJcQdE60vpPLk4jpwUGZMR
 KtdMYsLRuKv4yxP180nf0fXnZ0t/olz8p+VMRWuIjAWoacaOSZFscPvZvz0QW3fMzYDFKM2TQEi
 4riol1dCkE07WNQ3C2hNgFQ9ueXV5VL32plH8F7Mw2uiEVQyTg5L2I8O6WALWAQDeOb+HZvleJ+
 y1GdUmePXg5cfPh76cR0hCwB12cmlqD1kPAPwoEjfJncG3wokPID4TGCJgnPAsIDEhNp1HCKrgk
 BQEiXnc8gXDqrOzPFbGFEfUd62K+n+w+03TT76izXQSqo1JGJTAlIfrAncDUvoFUehaA4GMudl6
 qfP7xNiE3FeFipKaV3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091
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


On 4/13/2026 4:56 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 19, 2026 at 12:01:44PM +0530, Kishore Batta wrote:
>> The Sahara driver currently selects firmware image tables using
>> scattered, device specific conditionals in the probe path, making the
>> logic harder to  follow and extend.
>>
>> Refactor firmware image table selection into a single, explicit probe-time
>> mechanism by introducing a variant table that captures device matching,
>> firmware image tables, firmware folder names, and streaming behavior in
>> one place.
>>
>> This centralizes device specific decisions, simplifies the probe logic,
>> and avoids ad-hoc conditionals while preserving the existing behavior for
>> all supported AIC devices.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 66 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
>> index e3499977e7c6b53bc624a8eb00d0636f2ea63307..8f1c0d72066c0cf80c09d78bfc51df2e482133b9 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -180,6 +180,16 @@ struct sahara_context {
>>   	u32				read_data_length;
>>   	bool				is_mem_dump_mode;
>>   	bool				non_streaming;
>> +	const char			*fw_folder;
>> +};
>> +
>> +struct sahara_variant {
>> +	const char *match;
>> +	bool match_is_chan;
> This name makes no sense.
>
> - Mani
I will drop this in the next version.
>> +	const char * const *image_table;
>> +	size_t table_size;
>> +	const char *fw_folder;
>> +	bool non_streaming;
>>   };
>>   
>>   static const char * const aic100_image_table[] = {
>> @@ -224,11 +234,50 @@ static const char * const aic200_image_table[] = {
>>   	[78] = "qcom/aic200/pvs.bin",
>>   };
>>   
>> +static const struct sahara_variant sahara_variants[] = {
>> +	{
>> +		.match = "AIC100",
>> +		.match_is_chan = false,
>> +		.image_table = aic100_image_table,
>> +		.table_size = ARRAY_SIZE(aic100_image_table),
>> +		.fw_folder = "aic100",
>> +		.non_streaming = true,
>> +	},
>> +	{
>> +		.match = "AIC200",
>> +		.match_is_chan = false,
>> +		.image_table = aic200_image_table,
>> +		.table_size = ARRAY_SIZE(aic200_image_table),
>> +		.fw_folder = "aic200",
>> +		.non_streaming = false,
>> +	}
>> +};
>> +
>>   static bool is_streaming(struct sahara_context *context)
>>   {
>>   	return !context->non_streaming;
>>   }
>>   
>> +static const struct sahara_variant *sahara_select_variant(struct mhi_device *mhi_dev,
>> +							  const struct mhi_device_id *id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(sahara_variants); i++) {
>> +		const struct sahara_variant *v = &sahara_variants[i];
>> +
>> +		if (v->match_is_chan) {
>> +			if (id && id->chan && !strcmp(id->chan, v->match))
>> +				return v;
>> +		} else {
>> +			if (mhi_dev->mhi_cntrl && mhi_dev->mhi_cntrl->name &&
>> +			    !strcmp(mhi_dev->mhi_cntrl->name, v->match))
>> +				return v;
>> +		}
>> +	}
>> +	return NULL;
>> +}
>> +
>>   static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   {
>>   	int ret;
>> @@ -797,6 +846,7 @@ static void sahara_read_data_processing(struct work_struct *work)
>>   
>>   static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
>>   {
>> +	const struct sahara_variant *variant;
>>   	struct sahara_context *context;
>>   	int ret;
>>   	int i;
>> @@ -809,14 +859,14 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
>>   	if (!context->rx)
>>   		return -ENOMEM;
>>   
>> -	if (!strcmp(mhi_dev->mhi_cntrl->name, "AIC200")) {
>> -		context->image_table = aic200_image_table;
>> -		context->table_size = ARRAY_SIZE(aic200_image_table);
>> -	} else {
>> -		context->image_table = aic100_image_table;
>> -		context->table_size = ARRAY_SIZE(aic100_image_table);
>> -		context->non_streaming = true;
>> -	}
>> +	variant = sahara_select_variant(mhi_dev, id);
>> +	if (!variant)
>> +		return -ENODEV;
>> +
>> +	context->image_table = variant->image_table;
>> +	context->table_size = variant->table_size;
>> +	context->non_streaming = variant->non_streaming;
>> +	context->fw_folder = variant->fw_folder;
>>   
>>   	/*
>>   	 * There are two firmware implementations for READ_DATA handling.
>>
>> -- 
>> 2.34.1
>>
