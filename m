Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88869C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E2310E13C;
	Wed,  1 Jul 2026 10:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xjv5oH18";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="go8k+iOg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246B010E0EB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:36:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8htM683245
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O8G6SEKueMAy0GKvF0ivRFmIBQ9+gkPfS66+uUscIR4=; b=Xjv5oH186eURa32i
 pv60++cqYka6A4+MLPNPZRWttiWo+5Uw2mVC44ibCjKYpdE0dW8g70mIx8/qk8gl
 G5zuZ49wxkH2HZmrNyKCN3vwBb8lFzGDz5jBklbIOFRrb7S6FJ+qAwkSvxiAiqc4
 QqUpem95ahLLmmqKjQHeYDkK9NkTi6IhynEpP1U5H4IySL6+zee/d2xxxT26ub1I
 LxhvIFr39vOOk171cF4ljxL8981ABXnArN2jjqza5A6ApZl4dYJ5kNCtJDsRsQ3/
 uomUn8l+wyrN13QziaD+IjncZ0ruKigT/S1KPDRXFxYcmn9Ri4AWG0NZ1GlBAqY/
 oyChAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqks11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:36:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-847a2509456so600197b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902193; x=1783506993;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O8G6SEKueMAy0GKvF0ivRFmIBQ9+gkPfS66+uUscIR4=;
 b=go8k+iOg3Ukjc4yqwhd3iC2Ig5R7rGa+klF8uccgbtDglyuHvGYgSHkbmuWGffLdOu
 hJmitL/L+0awNGdk6mQnOSi3zptAuUfTfhqwSBnihB0uJh3cK/0Md+hgznus2A8R3/xn
 aL/ZVwKVLYkzpVF+IVIhkU046O2b6d9GEixg0YB48wORDZeH35qPtSz3+grbo161UanA
 I/9zQDWvEchCCNM6ftXES+2hlDTmxLC+7sQGm5EhJ1aH6dH15vN2Dl/5pgByNNnDN1Qi
 9Gv3O+6O0nEF9njwuexmsqUhztqWT/+IUNQGf2ReEPqD7qmsW88pzECie36CjT9iCkvf
 Rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902193; x=1783506993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8G6SEKueMAy0GKvF0ivRFmIBQ9+gkPfS66+uUscIR4=;
 b=V7AU1RhisyvLu3jTxVu+KrrgdlkcQLJcHarsYkEAYiUl+VYSGYSMoL3fzG4PL8V14g
 vb+NhiwWp1VnzLEO4sxW6LE+O77IMTMa9WdgXAjOLkzRbod9oYkMpD6YkZrcJj3JHP5y
 vDLbqF+nVwiF7AMkYA38tkRQXk/FiDPe/vsZ/OgisTgthotICBp4Yo4dcEE7yKuNflDi
 oKd9Uit6VhhfmHWx7XTqW9nDBVcO00WDpJta1Nar9AEc8/c8/KSrrcO2n1lsyhiqILL7
 VsNeicxtC0tzM3GoszQeH7oy0648nC9u1O/imxkOWPfA4ymacnYIiHkK99bm1Z9lSHA5
 YuBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5stNcja/PNaHtWQ9XP9jV06VIeYRsHdrFdlT1mNaDqNxo56qP20RTtvTcUWJRxi4G+GKWXnOv2nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA681KT+eYuSQYGJ67o+yPO3xB2dXCcuHteaQCmN2MQZnf5+jn
 5/n4Z4sYq/ys4Z19VYtIryHx1iwK/e1rN3OiKIcJSbUhmnf1OY/bmVCaOLkJidd6vck+l7AllEr
 s+qm+i2jvLgReS4frRkhBMcJLbpJ6CA3SJwb6j+SzUYZmCjgEt0gzPHhmNAjGYI+XfYQNzKE=
X-Gm-Gg: AfdE7ck8ehaCsAlIXlwWqEDOBK1/wcwToqo11Imw1z4nJ3R6sRDYGI+8mYOTFjDuGkr
 aMEiL7wXFX9tR4wtRLfoAKOPDw6xVYNB1fFY/FY2ypMnw9Bu1FZvrpVsGg2LsaCCOaP/OUbnR41
 SabweCC2g331zFBSf6Ji00wMP7rt1jXgPV63FViribmoY1aTmLrYWEK81crZKGyY+9LMD2LWO48
 jwVJdLcnhtzGEjUcuMihDrd4hJmCNZL21P2EmkyyTJUxDqiqf/URnqbLUk8R5O/DlSsxtcmz/sO
 lZ36tQixbXcm9qJy4uko7RFSq5n0AFcJ3wQ76I7KEK3ZEu/zWsxhyD+NgwNuM/WXXrLXbhqOYjZ
 eNGKjkGWfRc17cxMcyybed8JStDyoeVID2a/4HurcmnE=
X-Received: by 2002:a05:6a00:1a88:b0:847:8625:f7bb with SMTP id
 d2e1a72fcca58-847c09f1bd2mr873349b3a.60.1782902192720; 
 Wed, 01 Jul 2026 03:36:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a88:b0:847:8625:f7bb with SMTP id
 d2e1a72fcca58-847c09f1bd2mr873321b3a.60.1782902192198; 
 Wed, 01 Jul 2026 03:36:32 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8479fffa4f0sm3803736b3a.19.2026.07.01.03.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 03:36:31 -0700 (PDT)
Message-ID: <6a40311b-8f3d-4bcc-a3d7-98022ad119eb@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 16:06:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
 <20260416-sahara_protocol_new_v2-v5-7-6aebf005e4ba@oss.qualcomm.com>
 <x732txb6wf2giiv22xw66sqrnkjluaua5kbsmjugv4rbvpjqrw@ro2wbv2olzbd>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <x732txb6wf2giiv22xw66sqrnkjluaua5kbsmjugv4rbvpjqrw@ro2wbv2olzbd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TFdNmPUw32poDhqfmZA09F2qXYk-XRbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfXztDaIipfTm5l
 qSdXvrywe15c8NAbIy1Yxd6EsFVzP504r4HnB85Ih2+Wz4HK9SdZdsP7k7dzitgx034lLYO4/0K
 O3HuB0p8gRPjqqhopF0bV5MmToXFx6CTcsWyaZarPAyMnYgOxqOjfs0gQeDv7ScSRM0/YUndAfA
 FiCNbrsc2qGRDO7dhkfj1qSNSc7PTnzCvOa5l0Nmw3LCHzqj2naCf/N7YaTBTsCZaL0eSf4GJNs
 vXEdPxiRozhZrsw3Qa9sYhoOwAOlgJ2RGCcolp9MSB+Htyh5bco69SRd3Pz+OiedCjCQ88IPM+6
 Je3UkMFbkKiHDGpT8Z7RcVyNRmn+NiFholAq5BU4xf8AvF+HGFzmBVo6Cctx8gU7HgDMrXnfcOp
 h7WLm+VordJIeNbqhcVCpr6JsOYQ1xh+QIqKBcVykIe6CL6Y9XwjnQ51ciMR88eRHfbFA1x5RkV
 6/r/1vY2kpsdjyJHjOw==
X-Proofpoint-GUID: TFdNmPUw32poDhqfmZA09F2qXYk-XRbW
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44edb1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=n9NIK8s-xoBB9Vmc4qAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfX/73m7B8FH2bl
 P1PMOyqO00JuFBns9HKOfndJYJNytvPU7YYPETIO/5TW7M4FY9dNIImvwkaJ8Q0rzOmvE64m9f8
 W0Y4W04/orWjRYAtcpCJ9eTrrN4GyMc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010110
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


On 5/12/2026 7:49 PM, Manivannan Sadhasivam wrote:
> On Thu, Apr 16, 2026 at 07:39:48PM +0530, Kishore Batta wrote:
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
>>   .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 ++++++
>>   drivers/bus/mhi/host/clients/sahara/sahara.c       | 69 ++++++++++++++++++++++
>>   2 files changed, 88 insertions(+)
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
>> index 07bc743aa061dd2fa85638067d494562152474e3..fef5dc1d8884133397d204f23361584fd1d9b075 100644
>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> @@ -273,6 +273,73 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
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
>> +
>> +static const struct bin_attribute ddr_training_data_attr = {
>> +	.attr = {
>> +		.name = "ddr_training_data",
>> +		.mode = 0444,
>> +	},
>> +	.read = ddr_training_data_read,
>> +};
> You can simplify the attribute creation with BIN_ATTR_RO().
ACK. Will use BIN_ATTR_RO() in v6 patch series.
>
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
> So you are expecting this helper to be called mutiple times without teardown?
>
> - Mani
Yes. This helper can be invoked multiple times for the same controller 
device without a full teardown. In this case, Sahara probe can be 
re-entered across events like subsystem restart/warm resets, while 
underlying controller device(mhi_cntrl->mhi_dev->dev) persists and is 
not re-created. Since this sysfs node is associated with the controller 
device (not a single probe instance), it should only be created once per 
controller lifetime. The devres_find() check is used to make the helper 
idempotent and avoid duplicate sysfs creation when probe path is 
re-entered. The sysfs lifetime is intentionally tied to the controller 
device, so it is only removed when the device itself is released.
