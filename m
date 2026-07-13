Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFF3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DAD10E55A;
	Mon, 13 Jul 2026 07:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UwQx2fsQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QDA3lwuX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E8F10E55A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:26:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6NwFm674467
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XhrdjE8+DdQexYgxMjUrXviF+vvjNB/D7Kmvlckb+5k=; b=UwQx2fsQGXdXQFOc
 /VdZH38tEgCj+u46WkNuQLxexnPhJhGVaFfKb1R/IF5/kxN9rEgdM5buIrd22dAg
 2lCchT7IRWSZ1Hq8kLubu6xb5FdrfiSrJH/CKuCPpxveySIdqp/DkW7KwgUFDhhD
 DqoCtfnBA7AyAbOnO50zOycIRXnckUo1dT+KLMV6DZ7BXhtdjnZXOSX7EPNcpEzr
 /0hAYszojz2Ve5vqeYYKL7KUl6wXc7EcqcFOA/FIgC2Rg3/mfzaDPH1rdLmosRCj
 k6aaVnnm1f7kbwloPaasoELdOZs5BlHbbWWWyqxny2SPKAPoNGqZOuPWBOQavdni
 o+XNtQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgmyw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:25:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7f385887bso70162985ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783927558; x=1784532358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XhrdjE8+DdQexYgxMjUrXviF+vvjNB/D7Kmvlckb+5k=;
 b=QDA3lwuXcpyhngjO86YcquZ+2VrKvUDgK2x9IdLo0OSxEp4JIG1oM8c0wfzp0Y1+nS
 7246P61ahUShM5BwLojRELoQS4rfWOiW4VNMGLGOiTOSS2xjhR/9yc8GuBJnQQM/gSNC
 RAUjQbWpc3f7ui7QWf4Fy7SoUWKSwq5rl+7w3fGzTut4HGc+3PvX3T01gRSX8a/gZOrn
 3JsfmGZZ+D4jrdoe5GvSYxPI7S45g1yqVaDw6gW20I/TWhpocjLweUZKTboZ9udF1Rb7
 m5ZAyeP7MGMbjklIn8WRCLEOWjqrNmM2fUbE3G+V8QKZPJbvRButZCssNleUrTuwxy9Z
 BUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927558; x=1784532358;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XhrdjE8+DdQexYgxMjUrXviF+vvjNB/D7Kmvlckb+5k=;
 b=rRaocPpMlkynclsgEWmbVHbIXaGVxN1Ee5a/h8yZxQg19wHmxcVkIvykLBxCXgn6PK
 mtlpO46024297+X6gv+7eXZM42VYoo0lugYx90WUgJvvHw4oLDGH+MPVje2f/iNW38rj
 KWJaA8cugReYDeEL/adtt6Q/MY90Me8j6KS6ey7ShRmrMbOQUQPqx9DmKsZ59Cf/1CIz
 tiNkP/uM1O06arKWqATKr2bDNm5QZO0KLsZCDBGZWw1qAyUQnf7Bu3FVwSA3SWdj7i/c
 tT3C+tYk/CLsfIS7KEV+lMzRmcCaMM8UmFak1E/NUULaNTPTA5heiY3WVeKD43Jp/Ii2
 Z0AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rporxjwwcpkq3odnEohPQhBChc1zkMv3bdvf07Hk5a4TDYuo8eI1P+WnlnHhaapSUIjcDK1r9oKzz4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy07FuL4144lzWBILxW1Y7tTdIKHRR8JkorKz9geFVAgGHMqzBp
 Wwle+ZMvVtudQCaGUvsyFtzCzIZmLRtSYA87ui3awcTBcL/UiskKWYMv5T6CIKoQOSTdjOuZahG
 D43JERivJ0+9y+KZ907as49iOkJTjIjryxzgEoA6xEcpDj8GMmMftAa7MDxgVPnT4R0iaDmI=
X-Gm-Gg: AfdE7clFgTHyP++k+jR0RipGbvCdoHNe8PeUWpNdN3X3KI0zhJBIORf0jtzsA3e1Tkt
 63yzioOJtvAfpABRXmKH6zRcL2zA4dBtOiqI1ancJTA3rQ7Z8zRhQIh24nGFBWapHSrNr5vQTTS
 miOGnlxGHbld0xb57S6v+n85Ff+obgbwa21E6GNj2qq1S5FnDLWnIf3xLPeBdpsLkQfMfBbvn6n
 vj5z6uoFC3v2WkksvjmWkCnQ+icKIWNLIxpTZcUP1E4KDKdYKJjrLF6kC3hMirxEO+OWONibdZs
 nfxD2mXASewhxG3dUisbi3/DLgGshHkW++J/A12UlvFhVof0JzhmTPND03c4EW6puyd0EufIoAo
 OuxwIJnpzzr2OZf2I7UUSehIobioEPVrjZLGryR5FsXY=
X-Received: by 2002:a17:902:ef06:b0:2cc:777f:d67d with SMTP id
 d9443c01a7336-2ce9ee16c76mr80260245ad.30.1783927558179; 
 Mon, 13 Jul 2026 00:25:58 -0700 (PDT)
X-Received: by 2002:a17:902:ef06:b0:2cc:777f:d67d with SMTP id
 d9443c01a7336-2ce9ee16c76mr80259955ad.30.1783927557662; 
 Mon, 13 Jul 2026 00:25:57 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d5bdf5sm94513175ad.73.2026.07.13.00.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:25:57 -0700 (PDT)
Message-ID: <a05e7dcc-7d8b-4db0-bd51-754184afb7c1@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:55:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
 <n45ii7ekxeefuxw2ydwzsx7lqlfczbgg6obrzmzpytl2fin7j5@vbhmrptcjvcb>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <n45ii7ekxeefuxw2ydwzsx7lqlfczbgg6obrzmzpytl2fin7j5@vbhmrptcjvcb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NSBTYWx0ZWRfX1AEkGzh/ESpO
 zxLyufsOTuy/sjDyC0CVRHcahwpFWFcbRrIXehO85xvHacAqw/teSbQUrF0bhOZMD3lv8vk5o8e
 PeK9xuicT3ScVP85caCDLODfUgDyvgI=
X-Proofpoint-ORIG-GUID: uH8lIFXVQyyF6C2SaW8pvZfcL5cjcTJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NSBTYWx0ZWRfXy3PNowrk0TVg
 Fy1q4WGb+k9KsWkfY+4sBo+XW1M/hqkou048WJC5pOzGwuDTTO9Laklo6zSh7zMz07oEQ0Ys819
 AD0HOvLeT7pWi3xwj3xvJL/+y++R1kVnQQy9AOqAJlicpn5QCUq9rAN2xbGM6hEuL0YP0k9A9Ec
 tVigE6xt1JNlvPB/lxxzHDlUzNoVhquA90JFreBSb+Kh2FXJ6bHBLrswzfeUrKhFkvqvHb8+7Vu
 xb6brBVqQlsIiSxjU+WVGTeM6jTL8OQ+QTqfX9Xa8y9SV0ZniMX12L4GO8VrfpcOONKsv9HUvbT
 chnjT9wX1zDnz2vYeu+YZkSuU9jkWb/ChNmht/x46iAWqwqW2TzW5Ns19zsljyRSGwh+js3PZYY
 TBd9TkkloqyZsDejmB+6jvj8xkD1PzOZxZ+6uhdvCpsCEEVmyquwLCwpKVP6Z9TnhYpMxGn0SsA
 JwnfUHOicSfUsRdlhfA==
X-Proofpoint-GUID: uH8lIFXVQyyF6C2SaW8pvZfcL5cjcTJ5
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a549307 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_CfiQXmXAg0GS1E_7KUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130075
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


On 7/9/2026 11:49 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 04:07:38PM +0530, Kishore Batta wrote:
>> The Sahara driver currently selects a firmware image table based on the
>> attached device, but it does not recognize QDU100 devices that expose the
>> protocol on the SAHARA MHI channel. As a result, the host cannot associate
>> QDU100 devices with the correct firmware namespace during image transfer.
>>
>> Extend the probe time variant selection to match the SAHARA MHI channel and
>> associate it with the QDU100 firmware folder. Add a firmware lookup
>> fallback for cases where an image does not have an explicit entry in the
>> device's firmware table. This allows required images to be provisioned by
>> the platform.
>>
>> This change only affects devices matched on the SAHARA MHI channel and
>> does not change behavior for existing AIC100 and AIC200 devices.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/host/clients/sahara/sahara.c | 27 +++++++++++++++--
>>   drivers/bus/mhi/host/pci_generic.c           | 45 ++++++++++++++++++++++++++++
>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> index e339c67e236af271645ca81cc517efd9eead87e4..9adbd84859073d8024ba2a5fcfa33897439d6759 100644
>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> @@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *context)
>>   
>>   static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   {
>> +	char *fw_path;
>>   	int ret;
>>   
>>   	if (image_id == context->active_image_id)
>> @@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   	}
>>   
>>   	if (image_id >= context->table_size || !context->image_table[image_id]) {
>> -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
>> -		return -EINVAL;
>> +		if (!context->fw_folder) {
>> +			dev_err(&context->mhi_dev->dev,
>> +				"Request for unknown image: %u (no fw folder)\n", image_id);
>> +			return -EINVAL;
>> +		}
>> +
>> +		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/%u",
>> +				    context->fw_folder, image_id);
>> +		if (!fw_path)
>> +			return -ENOMEM;
>> +
>> +		ret = firmware_request_nowarn(&context->firmware,
>> +					      fw_path,
>> +					      &context->mhi_dev->dev);
>> +		kfree(fw_path);
>> +		if (ret) {
>> +			dev_err(&context->mhi_dev->dev,
>> +				"request for unknown image: %d\n", image_id);
>> +			return -EINVAL;
>> +		}
>> +		context->active_image_id = image_id;
>> +		return 0;
>>   	}
>>   
>>   	/*
>> @@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
>>   
>>   static const struct mhi_device_id sahara_mhi_match_table[] = {
>>   	{ .chan = "QAIC_SAHARA", },
>> +	{ .chan = "SAHARA"},
>>   	{},
>>   };
>> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
>>   
> This change should belong to a separate patch.

There was a review comment from Jeff(v4, patch 3) to move to this change 
to the patch which adds QDU100 support so that it doesn't break bisect. 
Please let me know if i need to move it to a separate patch altogether ?

>
>>   static struct mhi_driver sahara_mhi_driver = {
>>   	.id_table = sahara_mhi_match_table,
>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>> index 391ab146f501c6ce1c81f6138f7c491a49c2f264..82e41632afc555a53dec3d8395558ae039b33bbd 100644
>> --- a/drivers/bus/mhi/host/pci_generic.c
>> +++ b/drivers/bus/mhi/host/pci_generic.c
>> @@ -300,6 +300,43 @@ static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
>>   	.reset_on_remove = true,
>>   };
>>   
>> +static const char * const qdu100_image_table[] = {
>> +	[5] = "qcom/qdu100/uefi.elf",
>> +	[8] = "qcom/qdu100/qdsp6sw.mbn",
>> +	[16] = "qcom/qdu100/efs1.bin",
>> +	[17] = "qcom/qdu100/efs2.bin",
>> +	[20] = "qcom/qdu100/efs3.bin",
>> +	[23] = "qcom/qdu100/aop.mbn",
>> +	[25] = "qcom/qdu100/tz.mbn",
>> +	[29] = "qcom/qdu100/zeros_1sector.bin",
>> +	[33] = "qcom/qdu100/hypvm.mbn",
>> +	[34] = "qcom/qdu100/mdmddr.mbn",
>> +	[36] = "qcom/qdu100/multi_image_qti.mbn",
>> +	[37] = "qcom/qdu100/multi_image.mbn",
>> +	[38] = "qcom/qdu100/xbl_config.elf",
>> +	[39] = "qcom/qdu100/abl_userdebug.elf",
>> +	[40] = "qcom/qdu100/zeros_1sector.bin",
>> +	[41] = "qcom/qdu100/devcfg.mbn",
>> +	[42] = "qcom/qdu100/zeros_1sector.bin",
>> +	[45] = "qcom/qdu100/tools_l.elf",
>> +	[46] = "qcom/qdu100/Quantum.elf",
>> +	[47] = "qcom/qdu100/quest.elf",
>> +	[48] = "qcom/qdu100/xbl_ramdump.elf",
>> +	[49] = "qcom/qdu100/shrm.elf",
>> +	[50] = "qcom/qdu100/cpucp.elf",
>> +	[51] = "qcom/qdu100/aop_devcfg.mbn",
>> +	[52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
>> +	[53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
>> +	[54] = "qcom/qdu100/qupv3fw.elf",
>> +};
>> +
>> +static const struct mhi_sahara_fw_table qdu100_sahara_fw = {
>> +	.image_table = qdu100_image_table,
>> +	.table_size = ARRAY_SIZE(qdu100_image_table),
>> +	.fw_folder = "qdu100",
>> +	.non_streaming = false,
>> +};
>> +
>>   static const struct mhi_channel_config mhi_qcom_sa8775p_channels[] = {
>>   	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 2048, 1),
>>   	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 2048, 2),
>> @@ -1399,6 +1436,14 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	pci_set_drvdata(pdev, mhi_pdev);
>>   
>> +	/*
>> +	 * Provide Sahara firmware mapping. Sahara consumes it via
>> +	 * mhi_dev->mhi_cntrl->sahara_fw at probe time.
>> +	 */
>> +	if (info == &mhi_qcom_qdu100_info ||
>> +	    (info->name && !strcmp(info->name, "qcom-qdu100")))
>> +		mhi_cntrl->sahara_fw = &qdu100_sahara_fw;
>> +
> Why are you adding QAIC MHI controller config in pci_generic driver? This driver
> only handles Modem devices.
>
> - Mani
>
