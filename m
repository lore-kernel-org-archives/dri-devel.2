Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78824CA6002
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68BF10E775;
	Thu,  8 Oct 2026 06:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C60Yibao";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+xJx0J1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0F210E775
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:11:46 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BiES313965
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 86RBZ7v3wJ4xaR5/4wdQH3fkTa46s0FM7vfKFSF6MSU=; b=C60Yibao8onkV6FM
 w2Vqcu1Ki0Yr6cfzts0IeIUvieAvOvsXjV4alKG8EFG2PXC+l+CYbcDTQTMliPWq
 c9ecXeXC6vhJKzKBY0rzPCtES5jeYjuG4JzBbu8sp6M13BbBS0zsPLx7y2Kd5MIW
 WaZbZbUnAbNIjEuBShDWvoO+csLWikYp5zCRjHkj33hSjw+3MIK+bmAqjr71Ijk4
 XY988HPKjnP0FwnXLvCrTEq1PFA80pq7IabbK4RQAgCv3u9DGx87eOBZVaZUkMVV
 2PIx1kfdbcWnlPqwx6d5NItHcn3xDzlFl2/cEXbmFWc3NYvt+yldy37mnnGDjfpK
 3dYMwA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe31buv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:11:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a82c7e8fcfso3574765a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439906; x=1792044706;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=86RBZ7v3wJ4xaR5/4wdQH3fkTa46s0FM7vfKFSF6MSU=;
 b=e+xJx0J12EO3ziXzFNdXn53mSs0mi6bRfocr0YBo4JAoThyZYLHgPcgre9kbxINcQp
 pqEuMv7KFkcng6rBfsubVr85eA2CQU4362HmjAXkz2YI0s0CoScXEKEw1Rgi4EoqRif/
 vVj3xvD5Qesfu7KyNEnuX67aINUPRoKwqKWB9rREWou8pvDT48/4iaUPVwIYtIndERea
 FiYXg3ahVQHaNfr5TZXyvebNS0YZd6WhCi4SyDU0LPX/tUHP7LWiPoaoV/lTkjNhxIVW
 0AcT2J60xQA58TancAWeBRKVMG6vX9ecGe9Ln+2aPpKe1EXaAtckFNe6xmI5r3mWrpdL
 +qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439906; x=1792044706;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=86RBZ7v3wJ4xaR5/4wdQH3fkTa46s0FM7vfKFSF6MSU=;
 b=H42ExGZFGMOFDUHSsQ0N0AeIBPKV1ScAl3eMthL0ucIhwoWlxZqvcG28b6pVo6urxF
 QZIr98o8B68nGAz1AV7BpXVYo9o5rKCrT96pFyUZ3KoiYRDOlFnfyUJejEJJSv3FFZNx
 nzWuNkDXfnQnFOstiXbMeomSS/IZjpid5HamaFdj6lNlOMZKtgO8DiTLIuFhHxbcKh9Q
 Xgm++QX9Jq/P4qOBQa8pek2A1ObIelfoFWIgClQqoJhpWKQXX7ZPaMaHKRqVoVgf3cjX
 OzJn1eq2TLRYxkxsid82GbQGZRdR9F0j0dhfisBXj379lkR9jlJj17q53UecMhbxQFGx
 9zSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZcw0S+aAbwqITdt0gxpXMDoxs1QGuCQgUhBHrysqlupqofIA8qa8bKyIBfkug5OnZwaOcgbFmqes=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLhz6jRXIMFmPR8+lvcDwaZkTVZkosBHwnZsw9yDRzVH9GprtfU
 GltS8Qn/AZP30rKJPLLPQ+t0d/6fIgifoJVA6ApN2LCpwHCJWkLtd9w5+EbjnTtP42A/0WYpnFh
 LKly8Ml53PvUhOuEoudTSxt0OcA795QXw8P/1cIvLuDpVvgaHcDU+WHRPtVIA1+dku8ztWw8=
X-Gm-Gg: AYBFou0luqPvduQzg4eG3pAUKWQtmzRJPBeXkyMfBrmP84LQBqOJgC+eOwQ1O06gd+6
 EsolI2KD/fmDOGQDDarNfJH2ECZbCKoSELx5JUVKUE3UaSh7+fmZoZp1eF4Pkef+HRxRp1PePse
 ZM1tvtALpJqYaAjRDSUHjX5l8B11p4OL+oNOlswQt9rRb3iIrhao1f8sAfYeQgWk9G5oyaapiRq
 RAPdSOQaLADNOpaQGEzyK4CpboLwhVJlRayHtCy94FbjNQoI0mL2pNVwB08+LDFSLdgK6/PSCB0
 meurM7sItEnLZWKwaDrdPN9syk+B4o6mqVJXizlWl1uwVWUSg7J+DOb7IlB0fxDXz30Ii6RytRA
 KaCRBNIFHJwJ5hRsGkfF55i6rUhwwBwE=
X-Received: by 2002:a17:90a:a89:b0:3a8:cb54:e135 with SMTP id
 98e67ed59e1d1-3a8cb54e725mr1571772a91.19.1791439905568; 
 Wed, 07 Oct 2026 23:11:45 -0700 (PDT)
X-Received: by 2002:a17:90a:a89:b0:3a8:cb54:e135 with SMTP id
 98e67ed59e1d1-3a8cb54e725mr1571754a91.19.1791439905042; 
 Wed, 07 Oct 2026 23:11:45 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89d416348sm4247427a91.0.2026.10.07.23.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:11:44 -0700 (PDT)
Message-ID: <4ab383a0-5fd3-4cda-a0b4-8d9bd5d015ed@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:41:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] bus: mhi: Load DDR training data using device
 serial number
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
 <ysumvduurfx5jq7r2eaa4ik24eqk5at24frvjl3zyif4wc4ojj@2bhq4vzuqlnw>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <ysumvduurfx5jq7r2eaa4ik24eqk5at24frvjl3zyif4wc4ojj@2bhq4vzuqlnw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX8KqCaj6w5qH4
 cManScj8nQURchVXhtG2fCLwPmbnPAw8OX04O2tINxZHb+zhGxf3e3cXKpmwqiDvZr33pBpOOYk
 wm1SX63oxQg8WGA0EU6BSXL+hulUcFxSuxsazHPKZVoCii8LdWrsPpZ0RrvnDSKB++VlIBFyTb2
 YLdNL2dTcFoVADOhBOOYsxDQrIF4b4mfOiMSvhVt4n68zdko7DXc67mXm5Fy4DxANmfEGdJc2zl
 EzGSEv383aadXymiDaA83hb/PaAxGfm739NSQmuy2iQmsgrO2txQ9aXblIVukGLRaHjydfPw0R+
 vOuVKA9w+yu7cTw+vtFnldP66SDi6qKSBhLTeuABSVyrjFqg/CYoCDAYlhVb7uRstbhVDOGlBQ6
 pBJX/vqRp6OHVk084GYv9M1A1QL3kGYP5fDB0+pYpRa8aahuObFY3tJ7yzvHTitaUkP1rQRzbhx
 o00b7x4jzxHzT0PDCLQ==
X-Proofpoint-ORIG-GUID: VxAXeOvyCq_6ZXZ7_okrcYDH760wyrpb
X-Proofpoint-GUID: VxAXeOvyCq_6ZXZ7_okrcYDH760wyrpb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX5QJpFdxw4fyn
 QEDjKWmkoY7PWUXaEHLp3cD/2DB7syZ9lHcfq4swoTiNTZq9vn4NyMEdKQnC33DFPxcr5faXuX1
 37Y8XPkpLccG9jboM5KDiinVR6UghjI=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac73422 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=BmEjwzUHSYKQsWGf9k0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080024
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


On 7/9/2026 11:51 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 04:07:39PM +0530, Kishore Batta wrote:
>> Devices may provide device specific DDR training data that can be reused
>> across boot to avoid retraining and reduce boot time. The Sahara driver
>> currently always falls back to the default DDR training image, even when
>> serial specific training data is available.
>>
>> Extend the firmware loading logic for the DDR training image to first
>> attempt loading a per-device image dervied from the device serial number.
>> If the serial-specific image is not present, fall back to the existing
>> default image, preserving current behavior.
>>
>> This allows reuse of previously generated DDR training data when available,
>> while keeping the existing training flow unchanged for devices without
>> saved data or for all other firmware images.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/host/clients/sahara/sahara.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> index 9adbd84859073d8024ba2a5fcfa33897439d6759..b5ca6353540dc3815db6539e7424afdb749fd3f6 100644
>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> @@ -59,6 +59,7 @@
>>   #define SAHARA_RESET_LENGTH		0x8
>>   #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>>   #define SAHARA_MEM_READ64_LENGTH	0x18
>> +#define SAHARA_DDR_TRAINING_IMG_ID	34
>>   
>>   struct sahara_packet {
>>   	__le32 cmd;
>> @@ -226,6 +227,27 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   		return 0;
>>   	}
>>   
>> +	/* DDR training special case: Try per-serial number file first */
>> +	if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
>> +		u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
>> +
>> +		fw_path = kasprintf(GFP_KERNEL,
>> +				    "qcom/%s/mdmddr_0x%x.mbn",
>> +				    context->fw_folder, serial_num);
>> +		if (!fw_path)
>> +			return -ENOMEM;
>> +
>> +		ret = firmware_request_nowarn(&context->firmware,
>> +					      fw_path,
>> +					      &context->mhi_dev->dev);
>> +		kfree(fw_path);
>> +
>> +		if (!ret) {
>> +			context->active_image_id = image_id;
>> +			return 0;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * This image might be optional. The device may continue without it.
>>   	 * Only the device knows. Suppress error messages that could suggest an
>> @@ -235,7 +257,8 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   				      context->image_table[image_id],
>>   				      &context->mhi_dev->dev);
>>   	if (ret) {
>> -		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
>> +		dev_dbg(&context->mhi_dev->dev,
>> +			"request for image id %d / file %s failed %d\n",
> Spurious change.
>
> - Mani
ACK. Will remove in next version.
