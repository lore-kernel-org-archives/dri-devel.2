Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64501ED7B95
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD81710E570;
	Tue, 14 Apr 2026 09:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fINXBuae";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Twmj1A91";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A08C10E570
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:56:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6Yj5F280867
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RLuqThd/6lPqEfYAxapAuHQDSrKifQv+h9EGQmRz6Ho=; b=fINXBuaeo4mpid8+
 3BEEhZKngQhbZtJ4j6jFm+Y9za7UY4yTTIHiDG5J5+2AA3AcWwkUI15Oypv0jkj+
 ZX7yYnuUBT9sYCJY4h1N/S3EIrRRTM/hDraGd04y8kJoC7epbbshIwRSvVNcCcOd
 5V07kyB3cEnkp0Sj4WYN1E+rUumAyPYduw+Y7Lhpl21uAdTwquf39Wu+f79t/IRu
 /czo33J2MZO9kVwApxm8NleZXnFxKTRQZaBfpdnNEhSFIqSA9UZ36wR+uU+QyzqV
 IGJSeCaF4dF+c/2GhCQo2Q5ptQMFXCo0o0k8hA+/oWGibJc98GB/xSyFJxpOhNgv
 ldpcCg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vj5rf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:56:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c1e1a6cfbso3878658b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776160613; x=1776765413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLuqThd/6lPqEfYAxapAuHQDSrKifQv+h9EGQmRz6Ho=;
 b=Twmj1A91FgKFT7eSRIW83W3k6sn8oEjsZVs/yDSWxleLLoyc34JFdZhs/oU3h1Cfrb
 JTM57D59gpfRKokG5hIaxtPWWodIN6ONFjDuCybhWsb8ZT5RHznKBkDePtvgJaZkCvvx
 i/x13xQPhecP577Kcb3N2hB7hi4WkZsWgO4b6zdeOzySaPAg/HQpXj+CCvhH0QjC8DOu
 dWyb2FOfmQXZzJGo9GQ1ltuHQQy+tA3dKkiogmaQu5kFPNV5cU+xFek+OAgOAk4TJ+Bn
 gqa/4HlOFt1caXm3Kb6a8c0H/OtuDtaRgL7YE6qmQUeTwvs2Ek60QX3GEIpyaU50TcW7
 0b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776160613; x=1776765413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLuqThd/6lPqEfYAxapAuHQDSrKifQv+h9EGQmRz6Ho=;
 b=E37RL3A76udMP3iSA+spsiaPGJz8ug01z6wYe2oobzQnc8veTWztBeAjmUDEEta8ZW
 4l0MZSRwgFRh19choHLK/CecS6aFeamZwV9FjhKi4FgkGGLTqR3nQUGQT9RpqgSAdXFT
 C7cT/DWxxngDn1A3Q6ebcscWr2x8ewG4kCSlPRFNtukf6EfiUrSnzpDlC4+VZIPUmuwh
 NwRAOvCdUvwC5eyApgiayPR8PGSAC2wUBigtgrK/xgm7ielh4VSy94O8hK9G9H4g6zTq
 a4nfJxttCUHIBoRWdCXaMEVI5o7ObGxbK1xSDGPE1352p41CZxNm9ciXtnNCc0dNGqd5
 JT+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hVPnuPQZ4uUlnJhnFQeTGzOL02H2Yudyaj0/V96wWU/e/CpOnpA0K8vXN5FvzGRG4M5OuaqFhwQo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8hfJVVdNZ3MHAAgYrYIgRIucVAUFzsvTZHQMNDghjg3nHRixl
 fGyROZIw5RcyzBrL4aoprx/s9PrfbA3aM/2XLJvv+lSEft3hqwfzIBoKRZ2FValscBCG6K+UT1/
 IV+R9ZAy7Fd9hhB0TGtDmb4M2MrKrPX/7qHkMwP5BtSBERsmbKpbCdOByai0+9zU559g0/ZI=
X-Gm-Gg: AeBDietB2bU2Hl1QzxSrZhOVFkDwtPQbkXJa8A3OVX5ORsD17hlREa/V7Zd/4fuytuu
 XFCe3syZmvlPFNtiPuzlKtVmDKUR22yzDwER/9N2j3cXW6JfJ68+GwiofByXzuprYzuWeZbUkR2
 DqGqLV6RlCl/eMPKJyGeWDU5PAqqcIvqm5qapgvW0vxRvfSK/LkCxqxrLatvgeg3mrIt1co5vTI
 lWk3Fzd30F8Bufl3fBU1Ey5Fsn7XnTGBJhI6lA3MebAXsNnc86zLoACVZMfOo+UYs8GQfn3LMwC
 goMsEvIJ6EhhhANYW27kgH31Ff+z98n6DzmV6McVKLN0vodJbSrU/iLP2Sn3N7tPC7iY3G58Akz
 +KmLeEjUohEoCQLuxqYoCFLwUZ3O/R4HHbp77JxjHqAmDdF3Z/yJiQA==
X-Received: by 2002:a05:6a00:ad8d:b0:82f:316:3208 with SMTP id
 d2e1a72fcca58-82f0c35628bmr16502556b3a.29.1776160612650; 
 Tue, 14 Apr 2026 02:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad8d:b0:82f:316:3208 with SMTP id
 d2e1a72fcca58-82f0c35628bmr16502526b3a.29.1776160612161; 
 Tue, 14 Apr 2026 02:56:52 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c30ee4bsm15060311b3a.2.2026.04.14.02.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:56:51 -0700 (PDT)
Message-ID: <8f620562-2e1e-4d61-a823-767fbe51828a@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:26:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] bus: mhi: Expose DDR training data via controller
 sysfs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-8-47ad79308762@oss.qualcomm.com>
 <tbwahssgudfeacfj3wcg32yw5fkqorswees4gv4geypjmmdcyu@tv6qkuhyw23l>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <tbwahssgudfeacfj3wcg32yw5fkqorswees4gv4geypjmmdcyu@tv6qkuhyw23l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zsJX7ZkhBcYmrmpW9OJqs76BqFmeUyTe
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69de0f65 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7NWoxAv4aW94f8snxxYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: zsJX7ZkhBcYmrmpW9OJqs76BqFmeUyTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MiBTYWx0ZWRfX9SlRzCFn9MVl
 zDM2RI4ib+wNWWfm42GnVVvprRUUnDDF+ehebmbTL6O2oYQ0xusiqvHGDuJVjU19zwvu3F7uZsX
 sm0IYxOnUWD7C5IFbs9eKAdJRbNwN76b9ToNRMioCon7VgauPZcE1QMv2G5prLjF3hzW7za9VW7
 ynSc/xURZzpZIJR1VVUSUFLJx5aPicx6qbKpwc5NxuR+Y5odayS7qgQn6XrcWWUG4WWz8gTYGzi
 uNcRmN5/BgzBi82kfZKRlii4zGBCsuxXcBBk9suW6XfolUyq5aVK4FmPUg3QmOScd5jZ7J8caiY
 5u53RcVXfNnAJkn/yVLYHCZKt0m0Wadu6YjHXNc7GzmCxMRZXQTo+jfUUtrQ9rsm1hg1kRxAD0B
 CjFah9WQbGJpdlwluZD5lpC0beb5V2b0fdFqgYwtOxQ2HVk/HsR46QgIRy9nm8Qt+G1ctrbZ2E9
 DRyGgrfXu4P0le6NSIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140092
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


On 4/13/2026 5:28 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 19, 2026 at 12:01:48PM +0530, Kishore Batta wrote:
>> DDR training data captured during Sahara command mode needs to be
>> accessible to userspace so it can be persisted and reused on subsequent
>> boots. Currently, the training data is stored internally in the driver
>> but has no external visibility once the sahara channel is torn down.
>>
> Maybe share some steps on how the userspace is expected to use this calibration
> data.
Sure. will update the commit message with the required details in the 
next version.
>> Expose the captured DDR training data via a read-only binary sysfs
>> attribute on the MHI controller device. The sysfs file is created under
>> the controller node, allowing userspace to read the training data even
>> after the sahara channel device has been removed.
>>
> So once the calibration data is read, how it can be used further?
The userspace will store the calibration data in 
"mdmddr_0x<serial_no>.mbn format. In the next boot, Sahara driver loads 
the real DDR calibration data and training data will be restored. No 
repeated DDR training is performed at target end.
>
>> The sysfs attribute reads directly from controller-scoped storage and
>> relies on device managed resources for cleanup when the controller
>> device is destroyed. No explicit sysfs removal is required, avoiding
>> lifetime dependencies on the Sahara channel device.
>>
> Missing ABI documentation.
>
> - Mani
Currently i have added in a separate patch(9/9). I will squash it with 
this patch in the next version.
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 69 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
>> index c88f1220199ac4373d3552167870c19a0d5f23b9..b7208738df10fc3c3895acd46873412818dc1730 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -415,6 +415,73 @@ static struct sahara_ctrl_trng_data *sahara_ctrl_trng_get(struct device *dev)
>>   	return ct;
>>   }
>>   
>> +static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
>> +				      const struct bin_attribute *attr, char *buf,
>> +				      loff_t offset, size_t count)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct sahara_ctrl_trng_data *ct;
>> +	size_t available;
>> +
>> +	ct = sahara_ctrl_trng_get(dev);
>> +	if (!ct)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&ct->lock);
>> +
>> +	/* No data yet or offset past end */
>> +	if (!ct->data || offset >= ct->size) {
>> +		mutex_unlock(&ct->lock);
>> +		return 0;
>> +	}
>> +
>> +	available = ct->size - offset;
>> +	count = min(count, available);
>> +	memcpy(buf, (u8 *)ct->data + offset, count);
>> +
>> +	mutex_unlock(&ct->lock);
>> +
>> +	return count;
>> +}
>> +
>> +static const struct bin_attribute ddr_training_data_attr = {
>> +	.attr = {
>> +		.name = "ddr_training_data",
>> +		.mode = 0444,
>> +	},
>> +	.read = ddr_training_data_read,
>> +};
>> +
>> +static void sahara_sysfs_devres_release(struct device *dev, void *res)
>> +{
>> +	device_remove_bin_file(dev, &ddr_training_data_attr);
>> +}
>> +
>> +static void sahara_sysfs_create(struct mhi_device *mhi_dev)
>> +{
>> +	struct device *dev = &mhi_dev->mhi_cntrl->mhi_dev->dev;
>> +	void *cookie;
>> +	int ret;
>> +
>> +	if (devres_find(dev, sahara_sysfs_devres_release, NULL, NULL))
>> +		return;
>> +
>> +	ret = device_create_bin_file(dev, &ddr_training_data_attr);
>> +	if (ret) {
>> +		dev_warn(&mhi_dev->dev,
>> +			 "Failed to create DDR training sysfs node (%d)\n", ret);
>> +		return;
>> +	}
>> +
>> +	cookie = devres_alloc(sahara_sysfs_devres_release, 1, GFP_KERNEL);
>> +	if (!cookie) {
>> +		device_remove_bin_file(dev, &ddr_training_data_attr);
>> +		return;
>> +	}
>> +
>> +	devres_add(dev, cookie);
>> +}
>> +
>>   static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   {
>>   	char *fw_path;
>> @@ -1272,6 +1339,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
>>   		return ret;
>>   	}
>>   
>> +	sahara_sysfs_create(mhi_dev);
>> +
>>   	return 0;
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>
