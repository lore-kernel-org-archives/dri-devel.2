Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147ACD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133D510F862;
	Wed,  3 Jun 2026 05:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFwvN/NT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AX5hRhqB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A8E10F862
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 05:39:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6535WhXA1568389
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 05:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oCMutz/MyDhFR2IPTdBR86gHzqmBqi9zc2xD34Nwwhs=; b=gFwvN/NT7sPgzj62
 CKGfx2dursqnvLzRufm2muLcqMueBJEB+BZxAbEt4edrnlERAoS6j0X4Ajqx+gaK
 CWje20/aKu6STz3GfeF6hjFnaNSqgsiDWLE4aL5QL+Zs3Nyr95e9wbpn/yte9H7r
 2A10xTZZRoPxz31s3zTCJURFa7fXLTWBwXHRSOTSoL9vLH4qSM8ZmKa3Ey9x5vtV
 87PG/GyLawCCKaQ0fBcHilkCoaFpapxASjXZH5D0QgtCf+z2Zlgmhi+yscU6KBwU
 GYq4ko++njlorEOxyUzmrBALO/wONWxVhQNTN2kGxiD3Nyw+qxUR+z3VHr3TF351
 eCOhHg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsjadayx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:39:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d99333358so3130045a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780465181; x=1781069981;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCMutz/MyDhFR2IPTdBR86gHzqmBqi9zc2xD34Nwwhs=;
 b=AX5hRhqBQGhJ5nZ00CBDJLa4zI6iB/gV9/cx0JxlnrwdGDGcOH+q+uOeLANlUxYfOW
 y7CITBVVzLwVLeBk30t2/d26j1SQ1O46XIV2Xhekhh+3XN4OsgHZTr9XVuCw6A5wGvMe
 NBsgA8MRxEfvleRwDw6YTdbvTwvn/Xs8n5AzIafvhq5VPglFIqbqX+0M9xr1+mzQmbll
 JR375wLl/o3Wl/F/c6PTlN87G3QHTUXm9H/FyDQDbj3XC8l2Q3V3+stBMq/Xeni2ySb7
 MYm3afDTdWm7oBXRoG2+nMWn5s7nquufl2OHi6zls/89vhUd9tuvZM9TKRYvt5Rnwpjm
 jQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780465181; x=1781069981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCMutz/MyDhFR2IPTdBR86gHzqmBqi9zc2xD34Nwwhs=;
 b=hWyyGIfRkqPYxuBbxNNnI2MqiB9eydsL9Ls3KLde3DfLy5qKbcjTH2WCZ2s/xvU+Qd
 bRiamcpihbt34imz8q8DWKnitHzvg3Cjv8CVSWrrmCZzjfxxmZITfUxVTh0OCpNPyi6t
 9P9yMRN45guMzfwT+s9SOOPFjyPU3A0R30Qk+B2F2VuRZjjASmq7xsY3ev1NpDsk+akB
 fic/2NJlAhPYbiDk/NCsK90AWzbueHi3ipw+eN4fYS23UXsRWlbHCZsSRaUHuTfS62h1
 Mqy70rjPc3foOotvw1dcsvjnWNbdehWUSEuu/g2/M2wVW9G+JS825Nbzkuk5mCYZ6m2n
 ibyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g8N1zyH+F6ZHRi22RLBVKKv5oEDy5z2j+iAj/wu+fk3ngraj1h6oUNc8fqLkraR1F2SH1L/jqy+U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsCykC/yV+7EcNQHHr6Xsh90bWnZTbtD42EjjjlQFrAPTuOTfr
 A7d3acaxdq4Nar3+GXKo55B5O5GyrEG2CoMFRXY4Ac1Up++qdEjSbkGu/gB1gnK4jLqFrzIZ8xq
 InS8KyLSJraFvZ6fcCFaCdM4jEbc0wFCqLwx6ENnfaqjJR7p91mph1yatUmVmvwccfCtWh5o=
X-Gm-Gg: Acq92OFFrWddFhKVJfzaKGfahvlPgl2N96iwg23cvSpIz+QI+iLXNA0JvL9jgMS5yk9
 keG6JErsprMyEdUG/Btx9yCO91IKkNlyw//0h0y4tMEPTTI+dHPd2y79wjtvlpXID4iWgYk8C9a
 Lp6cH4hKjlMEr6p/TIw8/So+3hC7NJyCbDqQ/a9OGpDLHt3A8tPtyD35ddhcG1v9snw0zDYE064
 uSt2WaLTReb/xC7AazfBhXQCY7jhonDinYRLCRvfjlyojHjKVjKRntr+raEsZNrpIGiDv47JRfw
 xnaNAsjdAsVWPxTVMP/Hw54QaEw0VCBbcWay7dGvt9dchtNT3LeCBLB6w7QhHpFsbtWGXrr17A2
 bNp+kW2gueEsao84bi2falOnt6JJeG9cJBelcfamY2jrOA42IjYN/YcXxcut6
X-Received: by 2002:a05:6a00:4fc9:b0:841:dcbf:e82b with SMTP id
 d2e1a72fcca58-84284e19ebamr2089919b3a.12.1780465181468; 
 Tue, 02 Jun 2026 22:39:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc9:b0:841:dcbf:e82b with SMTP id
 d2e1a72fcca58-84284e19ebamr2089869b3a.12.1780465180927; 
 Tue, 02 Jun 2026 22:39:40 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842829188b9sm1687035b3a.59.2026.06.02.22.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 22:39:40 -0700 (PDT)
Message-ID: <37ae68ba-6639-4bd2-9483-5aa0156fd772@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:09:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] accel/qda: Create compute context bank devices on
 QDA compute bus
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-6-b2d984c297f8@oss.qualcomm.com>
 <f527lflctqyqjrotd2qerlx4oikg6st6u2seqsjw6u5krkqrab@uhw33gnkp5c7>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f527lflctqyqjrotd2qerlx4oikg6st6u2seqsjw6u5krkqrab@uhw33gnkp5c7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MSBTYWx0ZWRfX39ttNrqnVlt8
 6NE671d+EqSe6iRV/kPVvdUOepKiJ5yClcKUcy+S0Hk4qtQfI9UgX9NZLGXtH2MtLFxmmxp8wCZ
 KjP+o5vVqugcJfq+JxPA1W+36vzXTTWqomZHJ6nousb+bjPW3cwwwZRcLz0PcC9shGOAfHq+fSp
 J6sY9EkJsfG5i9OTkjO6zAyoak4Q+SbvuLp2JZTwEP2CWurtmsGqKT2kX9X9IzU5+EYNEeK2KVi
 1wB4BdTvVkwxdah60WjaBlIKarHU7TVg7TJOg9hYpAirEpQMdOfD2A9/aCr+4YHLDAZbm+f8fKg
 iS6vtOsui8xcM8xs+xE1U996uNhZzfAs3xYGvWXqRoN0V9G66lEtEF81zPcGjxRNsp9wkmHgK32
 cfOutghez6Pq9jrBaS/GepQQrTd3nWoPBxrvHFwneXGzkgyo8URUK4L+QN1AgG9y666PJ+wvT9G
 prCsdkMlR59NiMeV+8w==
X-Authority-Analysis: v=2.4 cv=Ld4MLDfi c=1 sm=1 tr=0 ts=6a1fbe1e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qYmJ1cgbGSsHLxxvYMEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: BrIRRAlS34CCKB5ExwLILNbBNisjWrhs
X-Proofpoint-ORIG-GUID: BrIRRAlS34CCKB5ExwLILNbBNisjWrhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030051
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

On 20-05-2026 19:53, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:56AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the CB (compute context bank) device management layer for the
>> QDA driver. Each DSP domain node in the device tree may contain child
>> nodes with compatible "qcom,fastrpc-compute-cb", each representing one
>> IOMMU context bank. The driver enumerates those child nodes during
>> RPMsg probe and creates a corresponding device on the qda-compute-cb
>> bus for each one.
>>
>> The CB devices are created via create_qda_cb_device(), which registers
>> them on the qda-compute-cb bus so that the IOMMU subsystem assigns each
>> device its own IOMMU domain, enabling per-session address space
>> isolation for DSP buffer mapping.
>>
>> The new qda_cb.c file provides two functions:
>>
>>   qda_create_cb_device()
>>     Reads the "reg" property from the DT child node to obtain the
>>     stream ID, constructs a unique device name of the form
>>     "qda-cb-<dsp>-<sid>", and registers the device on the compute bus.
>>     A qda_cb_dev entry is allocated and appended to qdev->cb_devs so
>>     that the list can be walked during teardown.
>>
>>   qda_destroy_cb_device()
>>     Removes the device from its IOMMU group before calling
>>     device_unregister(), ensuring the IOMMU domain is released cleanly.
>>
>> CB devices are populated before the DRM device is registered and
>> destroyed before it is unplugged, so no DRM operation can race with
>> CB teardown. On probe failure after population, qda_cb_unpopulate()
>> is called to clean up any CBs that were successfully created before
>> the error.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile    |  1 +
>>  drivers/accel/qda/qda_cb.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_cb.h    | 32 ++++++++++++++
>>  drivers/accel/qda/qda_drv.c   |  1 +
>>  drivers/accel/qda/qda_drv.h   |  3 ++
>>  drivers/accel/qda/qda_rpmsg.c | 12 +++++-
>>  6 files changed, 147 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 424176f652a5..143c9e4e789e 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -6,6 +6,7 @@
>>  obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  
>>  qda-y := \
>> +	qda_cb.o \
>>  	qda_drv.o \
>>  	qda_rpmsg.o
>>  
>> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
>> new file mode 100644
>> index 000000000000..77caf8438c67
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_cb.c
>> @@ -0,0 +1,99 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/dma-mapping.h>
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>> +#include <linux/iommu.h>
>> +#include <linux/qda_compute_bus.h>
>> +#include <linux/slab.h>
>> +#include <drm/drm_print.h>
>> +#include "qda_drv.h"
>> +#include "qda_cb.h"
>> +
>> +int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>> +{
>> +	struct device *cb_dev;
>> +	u32 sid = 0;
>> +	char name[64];
>> +	struct qda_cb_dev *entry;
>> +
>> +	drm_dbg_driver(&qdev->drm_dev, "Creating CB device for node: %s\n", cb_node->name);
>> +
>> +	of_property_read_u32(cb_node, "reg", &sid);
>> +
>> +	snprintf(name, sizeof(name), "qda-cb-%s-%u", qdev->dsp_name, sid);
>> +
>> +	cb_dev = create_qda_cb_device(qdev->dev, name, DMA_BIT_MASK(32), cb_node);
> 
> Wrong prefix. Pass the name format and the params to this function. Use
> kasprintf in it.
ack>
>> +	if (IS_ERR(cb_dev)) {
>> +		drm_err(&qdev->drm_dev, "Failed to create CB device for SID %u: %ld\n",
>> +			sid, PTR_ERR(cb_dev));
>> +		return PTR_ERR(cb_dev);
>> +	}
>> +
>> +	entry = kzalloc_obj(*entry);
>> +	if (!entry) {
>> +		device_unregister(cb_dev);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	entry->dev = cb_dev;
>> +	list_add_tail(&entry->node, &qdev->cb_devs);
>> +
>> +	drm_dbg_driver(&qdev->drm_dev, "Successfully created CB device for SID %u\n", sid);
>> +	return 0;
>> +}
>> +
>> +void qda_cb_unpopulate(struct qda_dev *qdev)
>> +{
>> +	struct qda_cb_dev *entry, *tmp;
>> +
>> +	list_for_each_entry_safe(entry, tmp, &qdev->cb_devs, node) {
>> +		list_del(&entry->node);
>> +		qda_destroy_cb_device(entry->dev);
>> +		kfree(entry);
>> +	}
>> +}
>> +
>> +int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>> +{
>> +	struct device_node *child;
>> +	int count = 0, success = 0;
>> +
>> +	for_each_child_of_node(parent_node, child) {
>> +		if (of_device_is_compatible(child, "qcom,fastrpc-compute-cb")) {
>> +			count++;
>> +			if (qda_create_cb_device(qdev, child) == 0) {
>> +				success++;
>> +				dev_dbg(qdev->dev, "Created CB device for node: %s\n",
>> +					child->name);
> 
> Stop counting successes.
> 
>> +			} else {
>> +				dev_err(qdev->dev, "Failed to create CB device for: %s\n",
>> +					child->name);
> 
> Unwind, return error.
> 
ack>> +			}
>> +		}
>> +	}
>> +	if (count == 0)
>> +		return 0;
>> +	return success > 0 ? 0 : -ENODEV;
>> +}
>> +
>> +void qda_destroy_cb_device(struct device *cb_dev)
>> +{
>> +	struct iommu_group *group;
>> +
>> +	if (!cb_dev) {
> 
> How can it be?
I'll remove this.>
>> +		pr_debug("qda: NULL CB device passed to destroy\n");
>> +		return;
>> +	}
>> +
>> +	dev_dbg(cb_dev, "Destroying CB device %s\n", dev_name(cb_dev));
>> +
>> +	group = iommu_group_get(cb_dev);
>> +	if (group) {
>> +		dev_dbg(cb_dev, "Removing %s from IOMMU group\n", dev_name(cb_dev));
> 
> Be uniform. It's either drm_dbg_foo() or dev_dbg() all over the place.
> Don't mix them.
ack>
>> +		iommu_group_remove_device(cb_dev);
>> +		iommu_group_put(group);
>> +	}
>> +
>> +	device_unregister(cb_dev);
>> +}
>> @@ -59,9 +61,17 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	}
>>  	qdev->dsp_name = label;
>>  
>> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>> +	if (ret) {
>> +		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>  	ret = qda_register_device(qdev);
>> -	if (ret)
>> +	if (ret) {
>> +		qda_cb_unpopulate(qdev);
>>  		return ret;
> 
> Unwinding registration?
did I miss something here? The intention to free up the CB devices in
case the device registration fails.>
>> +	}
>>  
>>  	drm_info(&qdev->drm_dev, "QDA RPMsg probe complete for %s\n", qdev->dsp_name);
>>  	return 0;
>>
>> -- 
>> 2.34.1
>>
>>
> 

