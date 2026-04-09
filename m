Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9C7F364BD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B1D10E05C;
	Thu,  9 Apr 2026 21:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtPv8XsW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFip24s3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407C810E05C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:23:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Jj3K21972534
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSBXIIWfdwTwS8iiRQJHGI9PtTjv4IHRrGHbuBKd26c=; b=YtPv8XsWvAXUmXXL
 MzZUJC1E2rUDkiHda/ejZd/xqhij9t4SVRA/RZFldHUmjuRbcADFOZU3EYVSM3Ea
 YNpEso/Vx5MS8dZs9BvnmJFFS2Hbdb+tYhOdfsoep0HemYTzrS+R95Q4mX4o0O1W
 UxAVzZQFnELbMJK+VH6dBdqr9KgAb+2fl1E9IbJdSRniDBcskieWxwu6k9SorjeX
 gH1ZSyNCl+BCruBku+xwCTf+KrlSzKArZSzl5C/uK0bzXTeiU91J+Eea4M+3IeLy
 D31iKLibqQU6oyIQR+k3489iyfeeD8hJ+7U/uDLbwFZsRpFE3WmDOHQhusikn1/l
 doN+ng==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decms1quw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:23:15 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so279222c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775769795; x=1776374595;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSBXIIWfdwTwS8iiRQJHGI9PtTjv4IHRrGHbuBKd26c=;
 b=iFip24s3g3h7l5w316p+8SZs3YDIGGxBy95XfvwOOZfkse3K++9xrGVsUoZpUhsQ60
 fug4z3NLFrMtQq8SYI38c51+oLEve7YLfRO5HFIGELElZD/OjJr/MiNYscWj1Mhm1S4f
 s4PkiplzmXh2OWiuAGeUzssPgsre1iN1mDAwQRzAy1am3oNpyx6MdL+4tUAab0u33m4u
 DwI71tIZBf+ZL8uiXkSXRuGQCjPllEoITBz9BdZ3OM/P3RW1lxKnLy7dWWS7yRLeWDa5
 uZYcZnyXwzcbVRyLqAQWtIq4ZZYQjYj5CkUPo8qlZLCp/pewPMBP02zzM4j04yQEaI4D
 uweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775769795; x=1776374595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSBXIIWfdwTwS8iiRQJHGI9PtTjv4IHRrGHbuBKd26c=;
 b=cS6klGd/KXmt2ZBZnMjtBZyUQ87+7ue6/mkpYsiJC/r8swcHw955A141Khz34Gh/dF
 x2Fc05UUsXB5KirUlixs0vL5mGctoOk5031vr4derg1zEeTu1riuF77Bit6W41ocrn4/
 v1Jw4sKEx8Dv4mnva9IRxJeGM4MO7b4G+lBEVb/2hKC4zUJpajXualY/YLAPAfh7gu9E
 jPoOJReh6+x9zzxvWlj02+o7xh6OEdR3937sVVmExKv+48JxpDEs3RPUQtPNy1Rsr2oH
 w5/ETfYfbMWNkB2AvdThTaWwxZx+FIQO1ai7mTy+bIn34wavq2JXeBW/2uaA+Ggs08Ej
 Cn9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYz1Obc0jQyYbwe6BVGSepHSEhdRwJcqSsLl8ExJwPaDjnmQbne08d1S9C413Q9a14Hoz+e/58Q7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9TF6vP70ph7S3PagvsgT/j0Cb7teCMGUwXwyNV/zhZSVmdxI5
 E1Lf6xQPFbPTLqUTNyy2NIDWPiAIR9Cu4jOJ4LmhW3xq1JuxZptl7oOrqCHmrbzV5I7EqjEg7gH
 /fkasjOObJN/Sj6PfDR36ftOsuFJeGCDanz/y2C8YdLV09cATBUvE+y80TfOYX4tkPsfRzFc=
X-Gm-Gg: AeBDievcmtPUTZRpqASZQMgaSb/Q11a90XOy4oGFSj7KdYZNf/liIdA7S5UZEgqUtno
 fjs1//PN+9RwWX2jZuyR7jIHkERvTTX5L76pC08TarX8wBd82pAdnxlsW90xxrQTAtw0WZJ+87g
 Xu6gI3EA0f65JU0MIAUVPvtHDG8Ngu5kCtzj8LugoiarmZBssdfZjp/4gspJ2QYXGOtMSOp3qHu
 CouStxh73UiPH9/rDqHzRGAuj5L5LdmpOJjJJMfXPO9V2uKWnrqJgAXzwuaCSel7yV2t+YiSRrd
 KVT1rhMmJpOpD/Dv1Q/pmbTc1NQRpGS5wd62S0ijCN5KP9V3OfKlO6I8ADagyC6kpRF06EK5aPR
 SHJ2pKA+YUVkXKEDVzFDL4yYwnHYhbPl6LLNf4DQTzgd69BGZI6fmsXnexz1ksZ4r99KCE27RJ1
 M=
X-Received: by 2002:a05:7022:60aa:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c34e4531dmr485660c88.1.1775769794915; 
 Thu, 09 Apr 2026 14:23:14 -0700 (PDT)
X-Received: by 2002:a05:7022:60aa:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c34e4531dmr485631c88.1.1775769794383; 
 Thu, 09 Apr 2026 14:23:14 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c346fb26dsm907975c88.14.2026.04.09.14.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:23:14 -0700 (PDT)
Message-ID: <2865b4a9-9044-4593-b32d-39b581298edd@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 15:23:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] bus: mhi: Load DDR training data using per-device
 serial number
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-6-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-6-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WJIRWGG2XuFMC8cvxwpYafpLdZ0mUwyN
X-Proofpoint-GUID: WJIRWGG2XuFMC8cvxwpYafpLdZ0mUwyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5NyBTYWx0ZWRfX9aoz9V43Bxf8
 3ALIvWJ/eKVXmKO4B3Pnd6/KCTSbnVwmTp0U0iyqVzcn9+Tp84STwkTJUDvXovZcmQdUWCq/HIg
 8bpUbrxlHCI0a5VwSo0P9SNVDd+OF23+kP5ZWkyV7DckB1Mt/TNY6Zsts70CPdO2gzK7+FawMBT
 Zv1Dvca3ibuAdkIJy406q9IDHd1O67NwWwXbWNFknKKd6fwJhHpd+jKogzR6cHPQaU3Q17l0Nlq
 6OmYxxZstyA06Pl8UD24Io/b5zhVExX+bJlxnYf8EY5rfd///+ofMg38W07B7yztZbu4Ke1hCRh
 Qy7xfz7ICg7uUcdIYEJr7N8/SncyMpY9l42COqMvl1Rz5SDa0zS9Dd8uubxuChVCep1hXqMaj4G
 IJdx0kcO2RFGIQsYKUqOsi4DGceuKqjKbJuftUvnMGgxitkSBZJPKNrqJfauFhEmcLEeWcRgPZ6
 Cbc8DA/saDS3WBewYBQ==
X-Authority-Analysis: v=2.4 cv=N/sZ0W9B c=1 sm=1 tr=0 ts=69d818c3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4fJIAEbhtct7chBbnB8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090197
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
> Devices may provide device-specific DDR training data that can be reused
> across boot to avoid retraining and reduce boot time. The Sahara driver
> currently always falls back to the default DDR training image, even when
> per-device training data is available.
> 
> Extend the firmware loading logic to first attempt loading a per-device
> DDR training image using the device serial number. If the serial-specific
> image is not present, fallback to the existing default image, preserving
> current behavior.
> 
> This change enables DDR training data reuse when available while keeping
> the existing training flow unchanged for devices without saved data.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/sahara/sahara.c | 47 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> index 4ea14c57774f51a778289d7409372a6ab21fea60..0a0f578aaa47ab2c4ca0765666b392fb9936ddd5 100644
> --- a/drivers/bus/mhi/sahara/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -61,6 +61,8 @@
>   #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>   #define SAHARA_MEM_READ64_LENGTH	0x18
>   
> +#define SAHARA_DDR_TRAINING_IMG_ID	34
> +
>   struct sahara_packet {
>   	__le32 cmd;
>   	__le32 length;
> @@ -365,16 +367,41 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>   		return 0;
>   	}
>   
> -	/*
> -	 * This image might be optional. The device may continue without it.
> -	 * Only the device knows. Suppress error messages that could suggest an
> -	 * a problem when we were actually able to continue.
> -	 */
> -	ret = sahara_request_fw(context, context->image_table[image_id]);
> -	if (ret) {
> -		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
> -			image_id, context->image_table[image_id], ret);
> -		return ret;
> +	/* DDR training special case: Try per-serial number file first */
> +	if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
> +		u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
> +
> +		fw_path = kasprintf(GFP_KERNEL,
> +				    "qcom/%s/mdmddr_0x%x.mbn",
> +				    context->fw_folder, serial_num);
> +		if (!fw_path)
> +			return -ENOMEM;
> +
> +		ret = sahara_request_fw(context, fw_path);
> +		kfree(fw_path);
> +
> +		if (ret) {
> +			ret = sahara_request_fw(context, context->image_table[image_id]);
> +			if (ret) {
> +				dev_dbg(&context->mhi_dev->dev,
> +					"request for image id %d / file %s failed %d\n",
> +					image_id, context->image_table[image_id], ret);
> +			}
> +			return ret;
> +		}

This is entirely redundant with the else in the next line. I don't 
understand why id 34 could be reserved for training data, but also be a 
valid image if the training data was not found.

Just have the if that looks for the training data, and an if that if 
there is no found image, do a normal lookup.

> +	} else {
> +		/*
> +		 * This image might be optional. The device may continue without it.
> +		 * Only the device knows. Suppress error messages that could suggest an
> +		 * a problem when we were actually able to continue.
> +		 */
> +		ret = sahara_request_fw(context, context->image_table[image_id]);
> +		if (ret) {
> +			dev_dbg(&context->mhi_dev->dev,
> +				"request for image id %d / file %s failed %d\n",
> +				image_id, context->image_table[image_id], ret);
> +			return ret;
> +		}
>   	}
>   
>   	context->active_image_id = image_id;
> 

