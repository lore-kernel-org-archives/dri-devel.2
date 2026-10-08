Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70706CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D9110FC48;
	Thu,  8 Oct 2026 06:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+Y8weLU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxCBlLLt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D7F10FC48
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:12:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BqDG928943
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YPGiFq54jDa1xyPtt96t6RMiyZYDpPryks68gXkQPlQ=; b=d+Y8weLU28GSBE3q
 hyzTdHjUqu0MoG9oE7BMMVpixr0jym6chlbVLyh95W9Eji88xVsqFZJNef/DoUw7
 Obx3sfnhxloT9BDE4BWjzaggfa5zK6RhZvt5Fn5e03n1QSqVN+5L/Q09mf5s3A2m
 6m8E29+WzGV6cSLDo2zKcwsUMkQZEEKMXzGXewuQ9g3z2VwazZOJDakO5hU+J6ue
 jn353z90aVVqQKwpnSbMPgAsfI19ORNDVGef9D7QiAn2jhihcVk8Kg0GWS195L6C
 IB5lYTVH3G+1aSlcItsbmf31Dq5zIu6O2XgAXelbEGz3Fzhq7dOX5uBwezXMiGQQ
 y7YsxA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2sdab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:12:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4e36d5a77so4996593a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439959; x=1792044759;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YPGiFq54jDa1xyPtt96t6RMiyZYDpPryks68gXkQPlQ=;
 b=UxCBlLLtRJwsa2dHhFP/iwyi8k5hx50wa1q+RSs+G4iF6fP8YQa51RLKvMM9tGfMFt
 djZ1xasnNvAOET7DHLwIDHdBnDygHdk5bedOwNKwwRXPgk1/hgYFZwWWNQTtNqSjzDlH
 Pa7JPaBYYcGoqWh/6cs+IDKPB2h37jKt276gNBcUJkmTLXT1zWd+lNGLTUMAuIsjpzlD
 dR9umhkS9akoIyu6WVtVURaLgdDPkDylV2GFqYybLYfLQU1ZCpgypf3EGBm0trreuT9X
 2X294qJfkFJYxMOkF0UgaRnI6QstQaEJ09yRPSVHoiFc5zwig59wk3jC+tCAStyxLQxu
 geAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439959; x=1792044759;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPGiFq54jDa1xyPtt96t6RMiyZYDpPryks68gXkQPlQ=;
 b=EzbDhZR2ZmcQh+R3jSOTNHLSTxoibBRoA+QJ3+Yh7Ocqn0AIr8UqtlWSvT5HeDnyDD
 RpDPcv8MaF9FiRpW1JxgLnLwIY0AWG6F5P7NLlML/tQSYssF+RE0RamdsG+Xxg+KVrZF
 n3e6gw36dCBCdBA2Ye8jZKywMQ2MXts2zRL3nmj/gBNNoKB7LnHVmsTxX2o4Fn3M/jni
 gQaDtagPG2Xawwa9Q/f3AX3leHN0nJMfoIbZs5I3z21fv1AX6HWzZdWdOxndLrxKvyNZ
 3ze0dnJ3cYua+GQnXb2x5PRpcr6DKToTkxbhB5OQJAbDlfO79t1+r3NZ+Jh+K1RX+zdr
 MnVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXxVL2mViHyh5CwalDpkIWMHl3z7kiqtUTXUOjpaRrNMR7AMXMswuVc8ouvHXs1U59ls3v+Of0PKM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/fvNJbGvBPp5qzFDE2iFyGUiEPcz1P3jUZxwCTragiEMadPev
 JVW9rtAmi1VwZyacMCdAdC0lHSXBtbc4b4EOPPnMa/fJEFLCvwYl3Xi83wrh2FEOS05KlZSmCKS
 wbE/RZA2YijU/GgeVRgdEtufFRhwAWykA28k+/tGqBNQXFOJ+aAga3FPj22sf+E4jWA6VGrM=
X-Gm-Gg: AYBFou3oau3aPSs9++caTnNmhUBMcLSV22/nOj956D0GYOiVeBTb7AFC3IFhzb5yNtk
 fFuXy39J+FwWokscxxQpdlZbBDggWjDcx6/qXupA8U3Z4VNdouJudPepOoFSQN0ZFRUaUqoXyQ8
 d7sEt0VgF4wPJu9uefWo/lgumz3PnACtpyDlXJjaEHJOHTRAKue8l1RaslVL8PeklxwTrM+fWWe
 JYh5THJw4lAGkKhssoUO+lSh8j4ID2gjEXG5p7+G7AfA+LDTKc+gN4wvjhNyQTBzrBmh1Ti7BPz
 4Mfi08dFWU/djQ6LF9d9ZQspY9Q8dzwmY+1vR9meYKHFOTGAU7EIDUETGZ99X8kqACqwkAaMCo3
 25YUe8P3CBZVT0E8T6roShrVCq1iYvJtg
X-Received: by 2002:a17:90b:1811:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3a8a1bbf16dmr4086862a91.45.1791439958830; 
 Wed, 07 Oct 2026 23:12:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3a8a1bbf16dmr4086833a91.45.1791439958315; 
 Wed, 07 Oct 2026 23:12:38 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1a23c82sm2882655a91.1.2026.10.07.23.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:12:38 -0700 (PDT)
Message-ID: <d57835a1-9a56-465c-946a-ff261d2df0e1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:42:33 +0530
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX/biBKYsQCIhY
 qdPjF/gtsMzAu433gugcyPKfSkoSW3thvD4di6rrFBq31MqJRvgbhH53LVMgRfwSMe9VYxmglnb
 JmNA4U2hFuxQqk/dyKRpJgHs65Oq4Ic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX9JwKYM3glMYL
 IyCNuqfxjOdS2jxMiFwMc4OKY5Spamm0ud64XlFskfGlbykFALDYJVjGXm7m0M/vohSoHt4vR5b
 86YmN8ftb5A1QRz+rkK/BWdC+xNzOOJorhNLP9mMawcw6xHX0VCLRm85GMGGq57TMf0Ju1ntaze
 5ETDzx1b8owWo2fZJ6A8bSiikZLJ2nzAsgb2oAJfbVMZd6Gpnle4PTIY4Yq9fz+zNdaKkx5KBum
 /4hjoloQ65lF0YTCDQzKCc2MDwF7Z46y7HZRI4BjVYZl/QoYTv7PYYE+vytIfQ7a+JR2jlrAqoj
 j/ERmg0sDVZpz7L8vwKbaT1sxnkS0iXNfJtkYwK+nrFBivhQ1q3StVpjQ8NvMsluBon0RNTv9Rs
 lyk20YmvcNdf+7bCz4H2T8S39NNr9+q01JqM5FxVxdDLhEGXAmGdcyMntBontH/DGzTBsLGPkQZ
 f8VUmLwWp8JHo2Oxcwg==
X-Proofpoint-ORIG-GUID: AQhdeUa6LwNxdSg24ID-ZDPD9r0wXXx6
X-Proofpoint-GUID: AQhdeUa6LwNxdSg24ID-ZDPD9r0wXXx6
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac73457 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0IlxrgZsFcjQ__LXY9EA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
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
The sysfs attribute is read-only because its purpose is to export the 
training data captured by the driver to userspace. Userspace reads and 
persists it as a serial number specific firmware file. During next boot, 
the Sahara driver loads that file through the firmware framework and 
transfers it back to the device. The data is therefore not written back 
through sysfs, making the attribute writable is unnecessary and would 
allow arbitrary data injection.
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
