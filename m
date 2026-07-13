Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DE1C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7DDD10E57D;
	Mon, 13 Jul 2026 07:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFRZG0FB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c2PyCbig";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250BE10E57D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:30:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Nvaa568097
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Em8mVgyGdEfRfVq1ukW+9EQ7G6falQSSjNEsV/umQPg=; b=oFRZG0FBTXeGJMO7
 f5LvKnJ3r5wpsshA11v9obYuL3jKH64/1p+uVpjQ89vRdVurxK1TSUVGzT/0IKuH
 BoZjyVWB5FV1OXcTREh0siUr2XPrPTg9STj2dYweUWCtsivda+Z/lhJ3pno/+E4K
 +YyVQK1UkoF7yhpr8TQYwBgENLnJOdvUMaNh++9PhlguQ6o+wTG5myzklqYXbS6l
 upsNOmHwYJJaJQigTKTRI4yLU/7KHJ0MzmLjjEpzdOxpZ9nvT0spUZxRfeLu73CM
 qVYVITCw5AmSJLIt2y07or3Hk5tWmpz0jnasNBVTpAZ0zXmkQzmJj9bzdWg68lLC
 Q+DKKQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe914yjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:30:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so1641596a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783927834; x=1784532634;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Em8mVgyGdEfRfVq1ukW+9EQ7G6falQSSjNEsV/umQPg=;
 b=c2PyCbigS0eTW4RpitYA6Ke+wh+UgfODNok9+BG9FvRZlCUZnEL7twMiFsuQsP7dfX
 tX7fmdrhMnJy/b41eXaCkhqLHRRbinbrhJZVryrqNnU7g6wK6BTQjGi7ZGQ5+mDLhBqf
 LX82Xg5YDK1wv/ntRv0L4usJ0y3s3lapPugHvf0B0jpu9XaAONv7z8gzpgQygUbneUpK
 zmwk0edi9BFQ7RwBUpkZiK2AeZr1kEEqm+vpRK/Pp035ber8BkAe9RlY9h+eufOPK17J
 EDwdKIfKFzKiBAK8yKKJkw4zdDW+/LjtNe0OL38SZraMBavRdrQ1OKH9a48HPSDjJBBq
 bKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927834; x=1784532634;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Em8mVgyGdEfRfVq1ukW+9EQ7G6falQSSjNEsV/umQPg=;
 b=AwJG0BKfaRdeAQO6oLlEYdsxK4xY9KHW1mgyNeWn0HosPLdUAL4QuU4FGR5hh+0opT
 VIR2Syg/j+B/h7abvS5k1FR/MJoNk+0YeFEJeCtrDudyKMsrT/R9yvQVUQKyp0XN2Fdh
 vITJJS/nFFv7x+B1XN68OuFSlUxsKcXDsAT1laXHUQXK1pVba8ks78B/86naZ+ISvZ0C
 sfcUzil8Y6TrVY7HfeeyaONeeETRgy22dAAlwt7Uc5Oh/wsmN6qmPQaS8NCgJRYz8DG4
 Hxvnd4S+zL6ZaR8nDwNKpEc5fIMuEJUqqjKqjof0Yc5t7Io3M2yx/BWHlZ9FSfcSpVIL
 c2cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroP4txbB5XaCC1Gd5Az3F0+mkZeW09yEQpHCcbZoOdFcfw6AYzHsqBZkRMjLvXake15PXXKwikWgs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDHSc36UMi7RwavoPhUGqUNnOOv7jpfO/q2KTbVzbTbtrBIack
 U+BrMe87MKmSLIfKANn8aPUbMOKDbJKbv/LjAC9XQRThzhnky7zBpl5/iOIrNguLyHtC/1KBPty
 px8bQBB9muRjVTwWHsNTqtqm7+T+GVnlTBNAoBSotConhIzeSasvKTbjJw7WeTOs15OLPK9o=
X-Gm-Gg: AfdE7ckLM432c6YJoNbowOCyhpWU7+3NNY0MeCkPpHOuQNjqneREkFOiD+4mmAqaQuh
 jUy9bBUTGVVM9KJtB7hzRTJdaetmvbRbliRcNDCjfMU5gekXVkjqGB6FkTpE08KoApiYfp9YZQM
 GwyK1foalxYVhyNsIxmlSTg3+9N6flwuOhe2Ib0Hw0iHGyitewY2SNVr7xGJ4HvFKvaypFpnCKO
 iOUmJppmWQJdTCPde/VuohGB4Tc3lrxskVDj+MzurFMLBgAeCgDGrBbp30rSy+a+s5V6ZgmDzLD
 bj9tzyXsiH76fG/6lWSKPfrFA9Rn9ke30K542RN6z9hckkr/m8DFrzYgGf81CFylOWm6ELKH24z
 oyWdEhziEzbRFv6zZTVHpBf8+iC7BKcPqWAkJmACtwtY=
X-Received: by 2002:a17:90b:1fc6:b0:382:5c31:1f8a with SMTP id
 98e67ed59e1d1-38dc7769973mr7950645a91.27.1783927833993; 
 Mon, 13 Jul 2026 00:30:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc6:b0:382:5c31:1f8a with SMTP id
 98e67ed59e1d1-38dc7769973mr7950579a91.27.1783927832681; 
 Mon, 13 Jul 2026 00:30:32 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a56417527sm6208769a91.16.2026.07.13.00.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:30:32 -0700 (PDT)
Message-ID: <fb34c262-5c91-4beb-a792-f00da203d1b6@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:00:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
 <n35ouuyvy25ocbfaedksryoz5d53cylk2pcsxz7f25us444gh7@7ybkifq3fbae>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <n35ouuyvy25ocbfaedksryoz5d53cylk2pcsxz7f25us444gh7@7ybkifq3fbae>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a54941b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=0IlxrgZsFcjQ__LXY9EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX9J6pcw9KZ9U4
 XVUddlv7PauqHlNNggMsk4D3EV1VzD+jiiv2lf197Ceo9lQFj0NTmf5n5BVsqDooweuzFLu2ztw
 ZiZzvujch+WJst7GnP05PRX2rCVOMLI=
X-Proofpoint-GUID: qIWeaNpHyTIAxu5krleMSEMC1PLBa8aI
X-Proofpoint-ORIG-GUID: qIWeaNpHyTIAxu5krleMSEMC1PLBa8aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX0qgcHPB9lM1t
 JAIFq1b610f+MUERb4fAgXroI0+7hJbWr0fD99uzlOhQvY+4IkHPc1FuzOabWMv/i+Dmm6MgiwN
 +/elYFJuEgRapWrDiIcf9eDDZZ/MH36B31VJ85OA3L6fpcHO9mfo7qtFs/kFli7fjl4Oat0UPIH
 Gmus9OIt8ssIT6/o8cE8OSASdXWr1ejgRw/tMXoZURakucmZnqH2W8+sod/RAP+p8wz5u8qAdcP
 KwivwWuA2p22qUiAUJhYJwaPYAXnYkrwZKqVAdfEOT/4sdGziRdOUfBxn00iJEJgcmQPauW7uu5
 xcEPxxU7JC9No/q9goOO9bua1AwMd58Iw6csh1xoKfmJ4w2l/ArpRzOMSE+o1nwNDCLqPkJJDSI
 qLEHWqDm9O3Sg3t2HqH8IWkGQQOnb4w8GRnv11vJ8FIWdmINzonipKtuvKLYJThnkKrEAmxTkE6
 bDZTk7uUKr58eJGY0jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
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


On 7/9/2026 12:27 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 04:07:41PM +0530, Kishore Batta wrote:
>> DDR training data captured during Sahara command mode needs to be
>> accessible to userspace so it can be persisted and reused on subsequent
>> boots. Currently, the training data is stored internally in the driver
>> but has no external visibility once the Sahara channel is torn down.
>>
>> Expose the captured DDR training data via a read-only binary sysfs
>> attribute on the MHI controller device:
>>
>> /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data
>>
>> The sysfs read callback serves data directly from controller scoped storage
>> and protects access with the controller training data lock. The attribute
>> lifetime is tied to the controller device via devres, allowing the data to
>> remain readable after Sahara channel teardown and ensuring automatic
>> cleanup when controller device is removed.
>>
> If this training data is RO, then what is the use of exposing it to userspace?
>
> - Mani

The userspace component will read this from sysfs and save it to a file 
named mdmddr_0x<serial_no>.mbn.

On the device's next boot, Sahara will read the training data file and 
send it to the device. The DDR driver on the device validates the 
training data and restores it without running DDR training again.

>> Userspace flow:
>> 1. For each controller device, userspace reads the ddr_training_data sysfs
>>     attribute.
>> 2. If the read returns non-zero data, userspace persists it using a
>>     serial specific filename (for example, mdmddr_0x<serial_no>.mbn).
>> 3. On subsequent boots, the Sahara driver attempts to load this serial
>>     specific DDR training image before falling back to the default
>>     training image, restoring DDR calibration data and avoiding retraining.
>>
>> Add ABI documentation for the DDR training data sysfs attribute exposed by
>> Sahara MHI driver.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 +++++++
>>   drivers/bus/mhi/host/clients/sahara/sahara.c       | 62 ++++++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
>> @@ -0,0 +1,19 @@
>> +What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
>> +
>> +Date:                   March 2026
>> +
>> +Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
>> +
>> +Description:            Contains the DDR training data for the Qualcomm device
>> +                        connected. MHI driver populates different controller
>> +                        nodes for each device. The DDR training data is exposed
>> +                        to userspace to read and save the training data file to
>> +                        the filesystem. In the subsequent boot up of the device,
>> +                        the training data is restored from host to device
>> +                        optimizing the boot up time of the device.
>> +
>> +Usage:                  Example for reading DDR training data:
>> +                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
>> +
>> +Permissions:            The file permissions are set to 0444 allowing read
>> +                        access.
>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> index 07bc743aa061dd2fa85638067d494562152474e3..72ac751c302a98448b5756c9feb438647bd0ce4b 100644
>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> @@ -273,6 +273,66 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
>>   	return ct;
>>   }
>>   
>> +static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
>> +				      const struct bin_attribute *attr, char *buf,
>> +				      loff_t offset, size_t count)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct sahara_cntrl_training_data *ct;
>> +	size_t available;
>> +
>> +	ct = sahara_cntrl_training_get(dev);
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
>> +static BIN_ATTR_RO(ddr_training_data, 0);
>> +
>> +static void sahara_sysfs_devres_release(struct device *dev, void *res)
>> +{
>> +	device_remove_bin_file(dev, &bin_attr_ddr_training_data);
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
>> +	ret = device_create_bin_file(dev, &bin_attr_ddr_training_data);
>> +	if (ret) {
>> +		dev_warn(&mhi_dev->dev,
>> +			 "Failed to create DDR training sysfs node (%d)\n", ret);
>> +		return;
>> +	}
>> +
>> +	cookie = devres_alloc(sahara_sysfs_devres_release, 1, GFP_KERNEL);
>> +	if (!cookie) {
>> +		device_remove_bin_file(dev, &bin_attr_ddr_training_data);
>> +		return;
>> +	}
>> +
>> +	devres_add(dev, cookie);
>> +}
>> +
>>   static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   {
>>   	char *fw_path;
>> @@ -1131,6 +1191,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
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
