Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78ECA6002
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960A610E76C;
	Thu,  8 Oct 2026 06:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbldskUL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqdxOSLM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2261A10E76C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:11:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984Bp6X1433995
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bT/V/nt6qbgKzgYIifLz9HPk01hR9BcAcWPYqg8Rbkg=; b=AbldskULusxGjnFU
 W4wFl6s7oVQesNJvkIlbP+jRW/UerLNVssx4obMOROqmJggK6jMmGMoSSZtX1PPG
 +DGZSR8M+4LICz0c2RJFYEi51Bt7+JjsUOLmdtRjFM2xq+CLBig8QH6vq0QNd4/Y
 7XxQEorS7OJJCuvkfWk4Gx22XPlyKftuUx5cnDV/pkAxz8V48JVCiLPYvNgkiziD
 WYXJd4PFCVg482TAF8a24hCXwxNdkEvHhVzqpbJkLn8+6LbftKNV9ab+1rAGOP/2
 DRr++iRQZ6clagujx6bJMXBa1hwwyI14YYwWJ598is73xO09YNANYozKe3/Lzjzz
 yRIY9A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3hgdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:11:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so3921741a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439888; x=1792044688;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bT/V/nt6qbgKzgYIifLz9HPk01hR9BcAcWPYqg8Rbkg=;
 b=PqdxOSLMOkYQUvovjufgpAwFH3dUlRSSjKCY/vay6wsOltwIJJUAblOyYNinJoH8Wk
 9i31tWDjQQR30yAJTRDaZsO3jVdwE9+GIfeJLC0kmPaWqMOlEYkc/NoDY2muJEwYC1gj
 hpSif91f5mzI3Fo9sAPumcR76Vq/8+6qNTjxFy1eO6LlcA24G4RNIwY5BubhCBDf5bzL
 gHuKUCW8AfC/WRX3YvyFf4+h/zHZMrGNp+aIa1q240s7HypZbTE6ywQS/pzoekX7lKCj
 6nV4Mr2ez3ibQZYRXRceY74B4o5LWvIYoYtBgRoWXjBYFaLOXO14U8Qf1dkrrpKTNR0e
 OGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439888; x=1792044688;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bT/V/nt6qbgKzgYIifLz9HPk01hR9BcAcWPYqg8Rbkg=;
 b=wnzsZsCRKRWixjKKPKmynyN69sbtQj9/FILZipYZC9bXN0Q7u16+/pUcqeonvBD4PS
 G0zZ+j/2RuhKWY8WeNFuIYS0jVoNmcivLtOANgAd8/Ij6izyfD1rALjA9gpfqGBu2GkG
 QqFbUM7RJxW49t7Dj1dqqJdX7B6JYxCs2xrg0p55bWzPkn+JrUKQWCdMwgu48aCyTNht
 24dNZ67vy+pmA+4+bNt9yrBy9L/IyqF7Bm4pi+c7Yf4qImErCTdPGqSjyGJradXiKIQA
 41KilGg2dSYFTLVzw7aAc84iAIHiEKApDg3prWsD3M3sA6rW5Ru/5nCd5+t+sfSyNIue
 EWcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgokcoZ06IzYhoKADPz5yjNQKDDhTcOMURjLB5fAhgiokazwQBJDIeJGjEZPEe+V90Xx+sXar4lJE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYvxcYBX3yKwI9dgGJh8J15N7CamADCQ6fkG8b2Yr4r8Zpiaf4
 Z71PGWWH8cgRS46N0uZNW0Rhpwcw9tT8xu2XnqeG6+lNg+YDfD8O7V6mzJY2+9B4bYKjn5s3aUN
 BaGBBZD3N3K9mOcfQRxWSNkF+XjpJjYodT8HR1qTZKHBZDoIFxOgdlznCgZX9qIcvcyteakc=
X-Gm-Gg: AYBFou2iyV3n5O8FTZlDEDGAReb32OOmwAeygzs4kjfryWdZg8kVRj+tXK6YXz0rkYj
 +C3t98v+EJS11+tPI0Al+mpizngbphnGqC+/NGtIQ1QNBEAVh/dPucB2bF7t9q/+Y7CizXazYBr
 Ahila04xQPbw2mKY4VHWxMqYLNPQ1sJyHCcQF9v+8Qwg3XKRZe2Hek3A/EeAxslqPq1Io7qjQgh
 Cbg3sjvcnIeIU7X1tqsL+RLA6ayPZOYlbpc5QntdS3BpdnTS9DxzegC+h03Ppx5RckP7m7tqU39
 XTu3dtT/dfMrb1Z8P2wploix2JV7D5DUisDo6uPbD4i7omajjL7gRMsfqkiggW0SVGkH8H3/emL
 aSUVL0KnK3vwRc7qq8bmOXpJX2J6b7pM=
X-Received: by 2002:a17:90b:134b:b0:3a7:933a:3195 with SMTP id
 98e67ed59e1d1-3a8a072a7d1mr4161141a91.7.1791439887919; 
 Wed, 07 Oct 2026 23:11:27 -0700 (PDT)
X-Received: by 2002:a17:90b:134b:b0:3a7:933a:3195 with SMTP id
 98e67ed59e1d1-3a8a072a7d1mr4161120a91.7.1791439887434; 
 Wed, 07 Oct 2026 23:11:27 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1a79582sm3405917a91.5.2026.10.07.23.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:11:27 -0700 (PDT)
Message-ID: <add116b0-07b6-4723-baaa-ed4d813cb961@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:41:22 +0530
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
 <a05e7dcc-7d8b-4db0-bd51-754184afb7c1@oss.qualcomm.com>
 <wbez5pvslz2opnjd2mih7b4noce2oghbdi3ncxyrpg7u7vocas@zj4zzxh53myv>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <wbez5pvslz2opnjd2mih7b4noce2oghbdi3ncxyrpg7u7vocas@zj4zzxh53myv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX1ZerxpkTtexC
 TQQKfhnOW5RGzd67prEeTfGzSP/jje4Hv/ePwjHqs0gv0kTguWp4LbxMs7r8PWYZksNY+dVdRmw
 Ou5W3HNmNjMAYxpZqetjhvgtjYyeTxA=
X-Proofpoint-ORIG-GUID: IKeCHEJUdgaZtYSSatAjHUVIzvnWHk6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX/1dEemWsHlmc
 e9F+la1yaHrwFEln7gTWF2ijsoxXSCDk+YI1yZpMYD9ItiDhrC9hnEMhS9xpmDyll+Ky+gq9ro1
 1cmmATisiMpqvENb5HSALf50ewwNfMuavJalHRrZW5RvyvLzbq9Y/KSqJFRzn374xYlx0WXdJ4F
 Z3HDH8PegKhB3BRaMHxZiDL59iz7zPU4YjBiJoRtJ7wBoZl8ST5JipBVcxhBAT/LrKYUd9WsqQL
 3gP+BkeuEZWWN8I2cAcp/qjDd/8E7+CHGzdtUP4nm5y29FbB1+ELkjzMUhdIbz0jJfDUHLp3n+y
 zyB/7SfMWWe2KEi8SIL19aLdbLtWKMBSPFnRrBvc+QjcYyMQPFqiJ+xSCHVX2hcAYIk4R22qOMp
 MGJYmxIMbccrBOk68jwEXa5vl3UX0SSNUjWun5OaWQvUc0dNFNSiwtmwpBoXchUNoIRPu+5n12l
 5tXQ1JF2gVryOuX//CQ==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac73410 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vwFko8lV0G9a4cWME2oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: IKeCHEJUdgaZtYSSatAjHUVIzvnWHk6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
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


On 7/13/2026 10:41 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 13, 2026 at 12:55:52PM +0530, Kishore Batta wrote:
>> On 7/9/2026 11:49 AM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 01, 2026 at 04:07:38PM +0530, Kishore Batta wrote:
>>>> The Sahara driver currently selects a firmware image table based on the
>>>> attached device, but it does not recognize QDU100 devices that expose the
>>>> protocol on the SAHARA MHI channel. As a result, the host cannot associate
>>>> QDU100 devices with the correct firmware namespace during image transfer.
>>>>
>>>> Extend the probe time variant selection to match the SAHARA MHI channel and
>>>> associate it with the QDU100 firmware folder. Add a firmware lookup
>>>> fallback for cases where an image does not have an explicit entry in the
>>>> device's firmware table. This allows required images to be provisioned by
>>>> the platform.
>>>>
>>>> This change only affects devices matched on the SAHARA MHI channel and
>>>> does not change behavior for existing AIC100 and AIC200 devices.
>>>>
>>>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bus/mhi/host/clients/sahara/sahara.c | 27 +++++++++++++++--
>>>>    drivers/bus/mhi/host/pci_generic.c           | 45 ++++++++++++++++++++++++++++
>>>>    2 files changed, 70 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> index e339c67e236af271645ca81cc517efd9eead87e4..9adbd84859073d8024ba2a5fcfa33897439d6759 100644
>>>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> @@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *context)
>>>>    static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>>>    {
>>>> +	char *fw_path;
>>>>    	int ret;
>>>>    	if (image_id == context->active_image_id)
>>>> @@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>>>    	}
>>>>    	if (image_id >= context->table_size || !context->image_table[image_id]) {
>>>> -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
>>>> -		return -EINVAL;
>>>> +		if (!context->fw_folder) {
>>>> +			dev_err(&context->mhi_dev->dev,
>>>> +				"Request for unknown image: %u (no fw folder)\n", image_id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/%u",
>>>> +				    context->fw_folder, image_id);
>>>> +		if (!fw_path)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		ret = firmware_request_nowarn(&context->firmware,
>>>> +					      fw_path,
>>>> +					      &context->mhi_dev->dev);
>>>> +		kfree(fw_path);
>>>> +		if (ret) {
>>>> +			dev_err(&context->mhi_dev->dev,
>>>> +				"request for unknown image: %d\n", image_id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		context->active_image_id = image_id;
>>>> +		return 0;
>>>>    	}
>>>>    	/*
>>>> @@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
>>>>    static const struct mhi_device_id sahara_mhi_match_table[] = {
>>>>    	{ .chan = "QAIC_SAHARA", },
>>>> +	{ .chan = "SAHARA"},
>>>>    	{},
>>>>    };
>>>> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
>>> This change should belong to a separate patch.
>> There was a review comment from Jeff(v4, patch 3) to move to this change to
>> the patch which adds QDU100 support so that it doesn't break bisect. Please
>> let me know if i need to move it to a separate patch altogether ?
>>
> Since it is a new device support for Sahara, bisect is not really a problem. But
> I do see a value in keeping everything in a single patch.
>
> - Mani
Sure. I am keeping this change in the same patch.
