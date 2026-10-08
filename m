Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1ECA6002
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D16510E779;
	Thu,  8 Oct 2026 06:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fqnbnf5D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WhT8WjsL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C8D10E779
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:12:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BlhN1752696
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s0KchWkDklqgs7rB211yiwG6I+6COkYJkCvle0beTDA=; b=Fqnbnf5DNqxV1Qjr
 xFJ00qsGb+AHPKJk2tXgx+blgdntm/qaHerXv9ZoOjfh9Bzr/dhUOAPt4fROgDYm
 BC1KgEWfNEbYYx2UTlpOGutf/+W1GjoA73ESXBPdO6hklKsEDo98TEFidH9mISFw
 mql3VFK5F+HiuPIlgW21Dn7zh/CtwRXByM0i6uX8tks76YPQ7Ke1I1kj1zTKUsx2
 tJ0daANecaMunovsfAfFGuKAStk4BAGqYxQJ9L5KZ2/HOYZxiZvQZ2fQHYns8y8l
 cGNxOrbtOS5WliWA+5bjdssRnDEdWu+MfdaFhKHj6nL5IgoB6yNlLjc4JfAod8PH
 q2YHQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2sh6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:12:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a8736ec262so2761361a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439926; x=1792044726;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s0KchWkDklqgs7rB211yiwG6I+6COkYJkCvle0beTDA=;
 b=WhT8WjsLs7uZjrrs09O5eKZZMzzi/v7gIwIcvrMrLxvQQFbwvP44eFhQNqQL0KnEXO
 QZbvvUsfcSw1o+K2kqmfvARKi1eN7xZhQcX1YEQA2u6BaXlXHys1K64vgcMFDhFHZKC6
 6UAnqEiVeFvpddawDIPCsaFY7i5HWUOVQEf5FdtPiMIs4p3BI4kiE5uO7dIwzvfrgE7u
 W6fzHTvmPmBfS1tSCcT66wLbgmpIEX5q7epvnaQvZqrvUIeu1zC2EpogPl4zf6TKOH6n
 hzC4ci6dyaJobpsMmolV27e8oofQmvjV5Z8lbFghCHarHl3CqKUqfx2ETuftBQhjf81K
 lbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439926; x=1792044726;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s0KchWkDklqgs7rB211yiwG6I+6COkYJkCvle0beTDA=;
 b=qrE25Ji3W9zufpFQtTphBzDScMz6l245vWIg4lV/YVvRo6EUt4pwMalLUW2Ij7F8pJ
 3W2ev6LptubqnsMkD+FPwZNanKtIryxik6lUVv6k4ePxeCbIs/CgfxubAoqA00CN89Kk
 9Z9pXIPC71DaEkMMYESvjuekJnXBM/SdyWxADn/x+7lDFm1oJEMKMbNLw6DDk8aIZzdc
 E6IQ/bx2bqH8P2gyrGk5WhNhQ1lN0KhxccfHdLSIh2DFLF+8i6c8+nMz6XD1PwTd7cDr
 NBupxELnMHPFkEjpilgWIwvddxEBCJeso0WjN0qe6f7IMRaWLobo/zYoZ14POhsmAYqx
 YcGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDonhwC5ZV3tSYgztt0k6UoxrHklZe9GaprsB43wytRiIsUIjbJdaUrxa3dRkzuYISDmdGedwHaNA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMvvsTBeQHQQfLBboRLQNLL+wVh7gW4DB33F4fqtRcOJI9W28u
 n0QxBIPKq2cYY+daa8KX92FB5wqOKhe91FAS5jDIRyIHpictf2FG8DHPxXQfAnrE6WLVtomTt/5
 Gr+4pCsX4nAkMZV0VKM+wDh9AfR0FOPgTYaWnywhyyxPGcJGNj1CzQTpuLlZphfBJNeUedbqymk
 ooIT8=
X-Gm-Gg: AYBFou2AhR9UZhEiRy+tIb9MerFoj1g9odUqIQSk0QFHZv2wGbzvripPMM9E1DL6F8p
 K27tOuOXhLV/vBGp4/zureAQMshrXr/WDS6aiLUb7+znzCincsb3Ys5xWqm3ARVeSr1ZNRMjSkT
 M0JDij3pLXaj6NGIrJSYptUD+F/DYo2M4jW+vQ06mDX/b+F9FTdI16vSJ7cpQm7FW4WS3M6Ydww
 dAmYNeRE9wpKT/n3vKnTcWf81kHOaOOcHj9XU89oJhC/sFvAHAYyn5kjn7mLPmS06ZWvl3RsGIe
 on8KAAggCLHl33XWZD+JLR1dw+EYSCGb1HGM9CDqx3y/VSkjtCFaHZ7r8OT5m2gCoYfKLtICpZx
 Gk5HikZ0LOEcieKquqdD12ofqH4B5UAm6
X-Received: by 2002:a17:90b:3ec9:b0:3a9:8482:420 with SMTP id
 98e67ed59e1d1-3a984821aadmr1865879a91.40.1791439926340; 
 Wed, 07 Oct 2026 23:12:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec9:b0:3a9:8482:420 with SMTP id
 98e67ed59e1d1-3a984821aadmr1865857a91.40.1791439925817; 
 Wed, 07 Oct 2026 23:12:05 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aafbb29c12sm803186a91.2.2026.10.07.23.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:12:05 -0700 (PDT)
Message-ID: <4e3cbe78-7a32-42e8-90be-db5158907cad@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:41:59 +0530
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
 <rwjiriaurj2ajowddjjerrr5wsu4ios6lpm6adglvlzsrxf4x3@tw2wbobghgca>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <rwjiriaurj2ajowddjjerrr5wsu4ios6lpm6adglvlzsrxf4x3@tw2wbobghgca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac73437 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pIBEpd9KSKheSvzPkZgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: fWoeQLO217QAbHRtUmbx6Nn6tIbNNi45
X-Proofpoint-ORIG-GUID: fWoeQLO217QAbHRtUmbx6Nn6tIbNNi45
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX0GglzMTO9Yub
 sUhjgq6UNMmQ2P5sIVrp7IH8Us9RJpzJIR5UGrOdRwORi7WyQ49YOEseeU6B7bsly7OQDbNSAml
 laKM5v48ZYX8zeICHDo6gt0aIjB5NEM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX3dbsJqoudKuI
 dvqT8+CKE99xEIPSa5R0CjsLH434+5phgKXBkrDIQ1BNhD1iXI6mbZMYRMxdUiNME+kq1APMM5c
 GMPY5vRTyI+27Ie1TI+kP6knxWPJAsi4ebIcIWugFNpp1Sje52bZaXJY/EXRaRFN+eOJ5W8ssaP
 KXJuyUKJD4lsyoDG/soOnds5JL1WNV9hFucq6UZ4HisbEC2Q7KLm/qOZRz3c1Cfwy6ZqRcKWi1U
 /ZxwxxljDtU7dNA7NVerDvv1fNsNjaKVMsXw5TgoDs9eXkrNyG1JllNvGVQ6pbFzTNvBVVRbRNx
 SiGra7t5/4LOeTgyYkB1WoiJ8QF1kEz0q6JhMsju+b2iLP5ciU4Z2uZMI463A/FgjGVkw/FRQM2
 MePCcnSA4YvYrITap3/CyNOah2gMhH3BCVPtDWUFPTCP26PnYOxbPHEX+jObwo7Z4f1APkMVMqn
 +GTSqZ4JwAcjGrKlPlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
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


On 7/22/2026 5:52 PM, Manivannan Sadhasivam wrote:
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
> I think I asked this question before, but didn't follow up. This attribute
> should be tied to the SAHARA channel, not the controller. There is no reason for
> it to be available when the channel is gone.
>
> - Mani

Sure. Let me clarify. In this flow, the sahara channel is used during 
boot and is torn down after the image transfer sequence completes. If 
the sysfs attribute is tied to the Sahara channel, its removal can occur 
before userspace has an opportunity to read and save the training data. 
This is why the attribute is intentionally tied to the MHI controller 
device. The controller remains available after the Sahara channel is 
removed, allowing userspace to read: 
/sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data. This attribute 
remains empty until valid training data is captured and is removed only 
when the controller device itself is released. Thus, its controller 
lifetime is required to preserve the captured data across sahara channel 
teardown.

