Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE536F364BD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AFC10E86B;
	Thu,  9 Apr 2026 21:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kz7dc2Aq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dL1ZXLXp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B641910E86B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:14:14 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639IcYxa3352614
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 71bx/GMNtE6R0JOiEcxGItTozs6PCdIMyyDmKsMoGNI=; b=Kz7dc2AqlffxzAgh
 cdh/3LtvfpwHCe7rSWC0Wldi7NbRmijlA9Sf9GouOVHCKU9yBzRS3ISBi9wJpGgQ
 qnfNmlkyPHDfsKbfBAda4+AKrx+4I5vj/AsMOHcItxVdA99VajhrZ7N4VOsLUGaB
 zjfrFaLt6B8Q0SzCj03gDfr/GQ8vcibfyXUFpavDPh+EDjrmMWSLZJALXEmhxW/o
 CtImuz5AnVs45OKk8Uw+CaKSMOb0Jahf4F1I9+BkrqtiuLpsq3gUDyW1cEEr+O+G
 NkW8aOABPN6XpOvK2f8NdSHhx/NmzAvZSUwi27/s1zfsVvw83aZcSDZJEsO3ih1W
 Qj9J6g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec1qsxcy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:14:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1279caef718so11917455c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775769253; x=1776374053;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71bx/GMNtE6R0JOiEcxGItTozs6PCdIMyyDmKsMoGNI=;
 b=dL1ZXLXp2MoUFgx5yoeJGWS6n1UxabelsNp4WPBmazAfbH/E9HqFUoAUuMHERmim3a
 zC9cgZ6KhUYvejsZk40fGFqqsyEjnzAKKH1mgW1AwBreYj0+OdGAppd1H2BOVL50ksl9
 sCYGsEa2wVs9oYDRSNJctpxia34rYt+xM6Vyi/3EBXdJivgfZWEBj9YeCPQMEfEH/Lgz
 GRuyeYgMLztfDTB6ukdvbNJRX653YJmaSDuRkHT8gLMWm5ozWJMLC2xr/c+4RWIsASut
 OKbu9yM2jRzgpMTX6svej3nR25XIlzxahtXntRKDXo5IJiN7cs7WBbR1bpFUkdELpRqR
 JRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775769253; x=1776374053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71bx/GMNtE6R0JOiEcxGItTozs6PCdIMyyDmKsMoGNI=;
 b=Jk4EKX0dfRTqtThZtEurQHso6PYrxQA7qPAamKxO3WTfnM9IDsa+sQ5QggRlzAJSlx
 CJrdj4LzSuOSVxgvi23wTA9N8FMrNBIjEqzIqStcAYVaV5jr69b/dP10xscelc2Fjt7Z
 tDa57mVrsAjZXLLsSMP0bVB7M7mocN/1pKbucHj0N2/nvT/vXEfzokk+EZpNX1dqVRCf
 JtkWEXqvXH38x/k1i0OXeiOfyWvOSW4Ohy+qxviz7Vz43DxlzgJ09BnnEqi1QQLKOs7e
 +dzPw8B2R5K/dAMN+zHRcKdovxHWs1vi6sbb9yL7d5cetqlZ75YI2IG8nq2bt7328PXO
 f5GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qmIeUNElA4OCYSUc/1s5Z9gjHHI4IhzgPy4T5kBD6I7NQY5Y/UdVf9L6c+6Uh4NqSmO4N9H2AMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKzqvFpDuvh2kgPm9tUtAZjBCmR505G0tENKY+kgDgiP0wa5Wp
 ib26Q3urlJYFLnw9Db93y1hQNhIBbiFL3Jyh5et8vhleRQ3be0bTyu2oiaY3VPm/uCw09dlatze
 Ra3sJ87PjPR1lkLYil6/qjJJ6uJwybLoh92fOrXINaHu3Kk+LPufaQgCGmZnn+4Eb18uuhWY=
X-Gm-Gg: AeBDievgVa4Y9TwwzHj145DuMvsMSnfB7MffaTqMxQ59BZ/Tf7IsHNZkn3QPYIsdCL3
 FGANRoVrQVZ1BNFxUpY109oFJygte+N9YUVElbiXkUI+R7n1ZN7ul+lyhz44NNkvgi43mzmu2Ad
 ifOhLN7yX2KGQTbdw2v3q8F69SNe7NOnlfyY0lM4ZSqa3Ar1EX1GH2fCX+X5H3+qkGMOijo4Ip6
 8sDzwUxnYgCh+kD90cSzUZPJSYmC3d0Vfdn4hzmMeCcxRxvnJ52omqDzZLaqnZAU/1WV63OwndD
 eyNUm2jDDeQsMsyfuZ3JzuLpVIkSmkfQzCq7XBw0C40AN//E8aTxROJEVyAb0DVb9EQ4FtGu2A0
 KMjuTG3JgfY4nUsazbL2ACQjjXuv2wb1uVZT33NqbHnDT0J12pRqY/qzDU+2x8ZezhCdajh/E67
 U=
X-Received: by 2002:a05:7022:419f:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12c34ef6d62mr423010c88.30.1775769252621; 
 Thu, 09 Apr 2026 14:14:12 -0700 (PDT)
X-Received: by 2002:a05:7022:419f:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12c34ef6d62mr422975c88.30.1775769251987; 
 Thu, 09 Apr 2026 14:14:11 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c698esm1454478eec.6.2026.04.09.14.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:14:11 -0700 (PDT)
Message-ID: <65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 15:14:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] bus: mhi: Add QDU100 variant and image_id firmware
 fallback
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-5-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-5-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5NSBTYWx0ZWRfX4t9BfJT1U9Jl
 aKQOuw6OPIWNW5ie+AvtCUrH8ZUa32+cWPk6YUWfraVjlNhsLQH4PJwrGF1OSX5l0Sp8NWfbfc+
 JHf+svqXr1+QBpWaEDYdAW5KRPcXCQPspNh0nz54CDawMRLSB8Pc980BAaGY+ydADIYDXkMtUj2
 FCAJkEA0Q2lrADzU4yQcdih2JRPeKdDCYKNHm+bdzzAf8C9TQ+XoLocYyyNzWF84etnoKcE1I/5
 +R0tM1OrnhuZQ1HDdfPr4mCd3UbIiV8jXc1qgU1xkf3bg5Hcq+K+p30f8TQ/r800ChHNenABp5J
 z9KFdxl6lxtd1H22IRFhLvoXdlvBRY9uSMetMfggKOm+ao4ez3KKUd+iaH2bgrpnUbe35SZjnps
 vIVhAFyUXtU2GKJyNQowDLzmuQ797ci3Er0K+5kijDQf4o09UQbZwrNVhaOlrEIlkoNPpmQBbvP
 akLsNbw1T3vbr4IQeeQ==
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d816a5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-PYeUNOmlN0cYKBwraoA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: AH-sqZ1qejWCZKtj74U2m7QXZgM6s7p2
X-Proofpoint-ORIG-GUID: AH-sqZ1qejWCZKtj74U2m7QXZgM6s7p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090195
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

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> The Sahara driver currently selects a firmware image table based on the
> attached device, but it does not recognize QDU100 devices that expose the
> protocol on the SAHARA MHI channel. As a result, the host cannot associate
> QDU100 devices with the correct firmware namespace during image transfer.
> 
> Extend the probe-time variant selection to match the SAHARA MHI channel
> and associate it with the QDU100 firmware folder. Add an image_id based
> firmware lookup fallback for cases where an image does not have an explicit
> table entry. This allows required images to be provisioned by the platform
> without requiring device specific client drivers or additional registration
> mechanisms.
> 
> This change only affects devices matched on the SAHARA channel and does not
> change behavior for existing AIC100 and AIC200 devices.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/sahara/sahara.c | 77 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> index 8f1c0d72066c0cf80c09d78bfc51df2e482133b9..4ea14c57774f51a778289d7409372a6ab21fea60 100644
> --- a/drivers/bus/mhi/sahara/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -234,6 +234,36 @@ static const char * const aic200_image_table[] = {
>   	[78] = "qcom/aic200/pvs.bin",
>   };
>   
> +static const char * const qdu100_image_table[] = {
> +	[5] = "qcom/qdu100/uefi.elf",
> +	[8] = "qcom/qdu100/qdsp6sw.mbn",
> +	[16] = "qcom/qdu100/efs1.bin",
> +	[17] = "qcom/qdu100/efs2.bin",
> +	[20] = "qcom/qdu100/efs3.bin",
> +	[23] = "qcom/qdu100/aop.mbn",
> +	[25] = "qcom/qdu100/tz.mbn",
> +	[29] = "qcom/qdu100/zeros_1sector.bin",
> +	[33] = "qcom/qdu100/hypvm.mbn",
> +	[34] = "qcom/qdu100/mdmddr.mbn",
> +	[36] = "qcom/qdu100/multi_image_qti.mbn",
> +	[37] = "qcom/qdu100/multi_image.mbn",
> +	[38] = "qcom/qdu100/xbl_config.elf",
> +	[39] = "qcom/qdu100/abl_userdebug.elf",
> +	[40] = "qcom/qdu100/zeros_1sector.bin",
> +	[41] = "qcom/qdu100/devcfg.mbn",
> +	[42] = "qcom/qdu100/zeros_1sector.bin",
> +	[45] = "qcom/qdu100/tools_l.elf",
> +	[46] = "qcom/qdu100/Quantum.elf",
> +	[47] = "qcom/qdu100/quest.elf",
> +	[48] = "qcom/qdu100/xbl_ramdump.elf",
> +	[49] = "qcom/qdu100/shrm.elf",
> +	[50] = "qcom/qdu100/cpucp.elf",
> +	[51] = "qcom/qdu100/aop_devcfg.mbn",
> +	[52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
> +	[53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
> +	[54] = "qcom/qdu100/qupv3fw.elf",
> +};
> +
>   static const struct sahara_variant sahara_variants[] = {
>   	{
>   		.match = "AIC100",
> @@ -250,6 +280,14 @@ static const struct sahara_variant sahara_variants[] = {
>   		.table_size = ARRAY_SIZE(aic200_image_table),
>   		.fw_folder = "aic200",
>   		.non_streaming = false,
> +	},
> +	{
> +		.match = "SAHARA",
> +		.match_is_chan = true,

Theres a half dozen non-QDU100 devices in pci_generic.c which expose 
"SAHARA" channels. Considering those as valid usecases, I don't see this 
mechanism working. Everything non-AIC is now going to be treated as QDU100.

> +		.image_table = qdu100_image_table,
> +		.table_size = ARRAY_SIZE(qdu100_image_table),
> +		.fw_folder = "qdu100",
> +		.non_streaming = false,
>   	}
>   };
>   
> @@ -278,8 +316,21 @@ static const struct sahara_variant *sahara_select_variant(struct mhi_device *mhi
>   	return NULL;
>   }
>   
> +static int sahara_request_fw(struct sahara_context *context, const char *path)
> +{
> +	int ret;
> +
> +	ret = firmware_request_nowarn(&context->firmware, path,
> +				      &context->mhi_dev->dev);
> +	if (ret)
> +		dev_dbg(&context->mhi_dev->dev,
> +			"Request for file %s failed %d\n", path, ret);
> +	return ret;
> +}

This is a pointless change. Drop it.

> +
>   static int sahara_find_image(struct sahara_context *context, u32 image_id)
>   {
> +	char *fw_path;
>   	int ret;
>   
>   	if (image_id == context->active_image_id)
> @@ -292,8 +343,26 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>   	}
>   
>   	if (image_id >= context->table_size || !context->image_table[image_id]) {
> -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
> -		return -EINVAL;
> +		if (!context->fw_folder) {
> +			dev_err(&context->mhi_dev->dev,
> +				"Request for unknown image: %u (no fw folder)\n", image_id);
> +			return -EINVAL;
> +		}
> +
> +		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/image_%u.elf",
> +				    context->fw_folder, image_id);
> +		if (!fw_path)
> +			return -ENOMEM;
> +
> +		ret = sahara_request_fw(context, fw_path);
> +		kfree(fw_path);
> +		if (ret) {
> +			dev_err(&context->mhi_dev->dev,
> +				"request for unknown image: %d\n", image_id);
> +			return -EINVAL;
> +		}
> +		context->active_image_id = image_id;
> +		return 0;

I don't see a usecase for this fw path search functionality, and I think 
it breaks the documented firmware loading guidelines.

>   	}
>   
>   	/*
> @@ -301,9 +370,7 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>   	 * Only the device knows. Suppress error messages that could suggest an
>   	 * a problem when we were actually able to continue.
>   	 */
> -	ret = firmware_request_nowarn(&context->firmware,
> -				      context->image_table[image_id],
> -				      &context->mhi_dev->dev);
> +	ret = sahara_request_fw(context, context->image_table[image_id]);
>   	if (ret) {
>   		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
>   			image_id, context->image_table[image_id], ret);
> 

