Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DCC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D74510E9DF;
	Tue, 18 Aug 2026 04:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRWMczQ0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iKbjoa3W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD7510E9DF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:34:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I2529k3602875
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FvN5/OloD/Fmp8QtjbtPM01MGFAJJiFT/3YnVeIo5HU=; b=SRWMczQ06B4oXnPk
 3tIwlt8AqhcLxC4JWIvUMGLjGBxqhhiijO+Lg411rn+H6K/nkCGpgHXiOymYv5tb
 yAyS3KQGPm7oMfQUzERKA7yd/k+a6PjDTCcG5ElhmJSEMQPJa2b405h/VcIvBGwg
 ZtVci6+vG+u3gTA8cAqiSWMi7fMFdXz09tW19DfPCP3K4IHYIhrAsUhP+wd1szht
 +KTJjfEWRfUc4P6WwoMW/UoL3y5f8HBKKGoTzQSOTHa5WQUUhH3DTpU5EAgtWHPT
 xAefdlwZEAaSDdsCngJB9aZtLyIhi6EtQQf+K5FOqEg3xz3KO6A3FIX1cqahB0XV
 R5JCAg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2ghn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:34:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so67884405ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787027647; x=1787632447;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FvN5/OloD/Fmp8QtjbtPM01MGFAJJiFT/3YnVeIo5HU=;
 b=iKbjoa3WmRQ+/HUrQDhIXOcHfVHr3WcKe8d9nulJL8yzUYVZUMyh+XB5z1VuD9ls1O
 QB/f06osect2spxyVhF3h2IV1oS77M86E8ELL13hMU1/OMT4M8quc7jwN0hVeJ4b92Zm
 PKJkFwHFWLNyCt3+N8XG0+Sl9r30dEFcVj3OH4J2eRtMpdBfkln4+77uH8gcP2JbsWSS
 vDUXO8ppMOogNS71li5Je1GXUB1khtn+HlKllE24Z/Izi70epQ9SS1y4LuzPzt4Kqfo1
 VImaymv9iQXMhBCsb/Mv8dmbiPTQFWI5j1eFP3ekpa0AFcRXyooQbsUe/MO0uvcJIf3L
 kxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787027647; x=1787632447;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FvN5/OloD/Fmp8QtjbtPM01MGFAJJiFT/3YnVeIo5HU=;
 b=F2yVqeRjSKPkKIY9hgEoSyuft8WkeI8b6sGXMRWPJbHh2PcGVyv2xSb/mNrhMfB6hA
 7AT1RP6+k2cEF+jrSIxuVzGct6HaTgKPq+4W5AXiZeOskdpZ42HmR9nDztM3zoeRxyKA
 zG9X7SwD03IK4DL9W6DnK4Rxxb4x4yAwISYr72SpSaJCB0VmuFj0kibSSXGLxoyFSi5D
 PW4k2XenbffblcoZJ5Sib95tIowHyQwcH6A0RNLJuWNmdXHhmVMWcYDvoGgEWQ3KZz/w
 OABCbwrEFjrMrOORvjqIs2B2rq1WfNLEHKKmERChCHKNKL0NxhMiPuEjlG0PvkP1PgyV
 CR3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBfVuHc4TgfiFaU/MiT5zPfmyo+uDFc+TUsIBD3C+iakbAkrmHb9LgqfrR9Nb1YMOFdHjuRdX4Rf8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVyOWzS0KwIRv5a9mnRaSA/Y0aKJXAs5x/vgqTkb2frokAjYtE
 3MmonMg7EWL9RWUFS+P+FGgzAQn5H+OHoknGqk9hFH7aEnI28W5FUq8EmKEylu8PkkRRicFa/NU
 V0BugiddCTevFqrtd788rn7bXYjTmHIoOeYJgWQ0FAn4u/ktKhirFFXzdghbp1Zg3lMztZhI=
X-Gm-Gg: AR+sD12gS9KCOxmXzm3t8jogIyDdsTmMUzroCA/moqGCmI+M3kmSncYnmg1DTIxSlyP
 FVaxr6tZirux9jDB6TZv8KHwNRIuT1xUKW9feDTjIG7p17KbNtNIvUX5lPLDeSoVNMRqOuKYAtO
 M3TNSp+ObXfnep46P4CUollLWx38lZmy9nSEcrnOSJOkwpK4aMHKLVha04v1t30WZ1wNhYvQHmG
 smINqOJh6wkFLQ8keSVvMbnj4FBstuRhXv3WwCdqEE7AMDoX6iJ+BgnBlYkBxoRxjL744/5Tm+F
 kZColLIODyiXZbatSFDE/S+KUAoEq+XLWpZo40VeCc7UJbw0+Q0TetgEhjmBVODTFz88JAVHQz1
 Y/9naOUN7D2T+Uce67yNVCFzRdtGTtA==
X-Received: by 2002:a17:903:360c:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2d3b0d5e37amr333048995ad.15.1787027647084; 
 Mon, 17 Aug 2026 21:34:07 -0700 (PDT)
X-Received: by 2002:a17:903:360c:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2d3b0d5e37amr333047625ad.15.1787027646465; 
 Mon, 17 Aug 2026 21:34:06 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb4ea3a4sm12288325ad.24.2026.08.17.21.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 21:34:05 -0700 (PDT)
Message-ID: <c4820424-eff0-4c28-ba77-5b595ed09a4e@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:03:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] accel/qda: Add memory manager for CB devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-7-69a02e9090d4@oss.qualcomm.com>
 <wt2pdo3m3nlhvyofuvbsqnvggywx75ucs65vjt3dzrxkrpgztz@xwwlhq2iuiun>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <wt2pdo3m3nlhvyofuvbsqnvggywx75ucs65vjt3dzrxkrpgztz@xwwlhq2iuiun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX7hiFrlyRDyi0
 mHAmzHubKZySOEKcDaEuFaMkFwz8BwU1hpUZLTcsTMlDncIU6+53SP8sfhUd/jdGQ69mpf6XdSf
 uGaAZzGOQ7R4ngNGM8gqP9eckkG0GpWj8/Gob757r3ghb3lHGNEM4xRXNB6WsINJVLGhyketxYH
 nVZoWthZHScIT0p3wfbERFSPKzveU2MDXBmgeJxR/DI6YADGoHP0hr6GD8qHmiZwiZH0oS5N+/L
 NSEb43apV62SwG3MEFcXl9KmTCZkd/yaBe1W1htQaZRSiw/0UgMoETNWwAAwwSRbAWlYUK+JNCY
 7u4pViR9PZmeKluwlcZ0v4Ge6xCiZqArF6uryf9vC/Oabo2qrEWQGrfOCU76Pkt3SnBiVDEgYmy
 ZBYazqutkJCmiTePiz6/skj7KfWV9S2I24plrgFUhUeh8b3/e7wXImxMwX3m2G1BGeoLdqzCmYK
 QziYrzijH1TPyLyaUhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX+z8UNXoyVPk5
 xjhLcj0/5ApmXwV8uDwbb6Y3D+RdC0XwhzkBRBRfTcI4csEPs4xhIzPVpJ+eJ5sJu2Q2evk90Mw
 w/h/Y3auZ8LKsoYIRUiUi7/kxmyVX9U=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a83e0c0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=F8gUvEXnVjwIBCcNVQsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: BwGk8gG49RmJE2o2zwm7Xj2KONdnrwil
X-Proofpoint-GUID: BwGk8gG49RmJE2o2zwm7Xj2KONdnrwil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180031
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

On 17-08-2026 12:22, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:42AM +0530, Ekansh Gupta wrote:
>> Introduce the QDA memory manager (qda_memory_manager) to track the
>> IOMMU devices that back each compute context bank (CB).
>>
>> Each CB device registered on the qda-compute-cb bus is wrapped in a
>> qda_iommu_device descriptor recording the device pointer and its stream
>> ID, and stored in the memory manager's registry. Later patches use this
>> registry to resolve the IOMMU device a session should allocate from.
>>
>> The registry is a plain array sized to the number of
>> "qcom,fastrpc-compute-cb" nodes present in the device tree: the RPMsg
>> probe counts those nodes and passes the count to qda_init_device(),
>> which allocates the array in qda_memory_manager_init(). The memory
>> manager is created before CB devices are populated and destroyed after
>> they are torn down, so no dangling descriptors remain.
>>
>> qda_cb_setup_device() is called immediately after a CB device is
>> registered on the bus: it allocates the descriptor, registers it with
>> the memory manager, and stores it as the CB device's driver data so
>> that qda_destroy_cb_device() can unregister and free it during teardown.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Replace the XArray with a plain array sized to the device tree's CB
>>   node count instead of a fixed 16-entry table (Dmitry Baryshkov)
>> - Fold the init_memory_manager()/cleanup_memory_manager() wrappers into
>>   qda_init_device()/qda_deinit_device() (Dmitry Baryshkov)
>> - Drop the pr_debug() calls (Dmitry Baryshkov)
>> - Use goto labels to unwind probe failures instead of open-coding the
>>   cleanup at each error site (Dmitry Baryshkov)
>> ---
>>  drivers/accel/qda/Makefile             |  1 +
>>  drivers/accel/qda/qda_cb.c             | 39 ++++++++++++++
>>  drivers/accel/qda/qda_drv.c            | 26 +++++++++
>>  drivers/accel/qda/qda_drv.h            |  5 ++
>>  drivers/accel/qda/qda_memory_manager.c | 98 ++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_memory_manager.h | 55 +++++++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c          | 23 +++++++-
>>  7 files changed, 246 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 143c9e4e789e..701fad5ffb50 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_cb.o \
>>  	qda_drv.o \
>> +	qda_memory_manager.o \
>>  	qda_rpmsg.o
>>  
>>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
>> index 9c5ef32f351e..cd32d6df6318 100644
>> --- a/drivers/accel/qda/qda_cb.c
>> +++ b/drivers/accel/qda/qda_cb.c
>> @@ -8,13 +8,40 @@
>>  #include <linux/slab.h>
>>  #include <drm/drm_print.h>
>>  #include "qda_drv.h"
>> +#include "qda_memory_manager.h"
>>  #include "qda_cb.h"
>>  
>> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
>> +{
>> +	struct qda_iommu_device *iommu_dev;
>> +	int ret;
>> +
>> +	iommu_dev = kzalloc_obj(*iommu_dev);
>> +	if (!iommu_dev)
>> +		return -ENOMEM;
>> +
>> +	iommu_dev->dev = cb_dev;
>> +	iommu_dev->qdev = qdev;
>> +	iommu_dev->sid = sid;
>> +
>> +	ret = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
>> +	if (ret) {
>> +		drm_err(&qdev->drm_dev, "Failed to register IOMMU device: %d\n", ret);
>> +		kfree(iommu_dev);
>> +		return ret;
>> +	}
>> +
>> +	dev_set_drvdata(cb_dev, iommu_dev);
>> +
>> +	return 0;
>> +}
>> +
>>  int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>>  {
>>  	struct qda_cb_dev *entry;
>>  	struct device *cb_dev;
>>  	u32 sid = 0;
>> +	int ret;
>>  
>>  	if (of_property_read_u32(cb_node, "reg", &sid))
>>  		drm_info(&qdev->drm_dev, "No stream ID in DT node %pOFn, using 0\n", cb_node);
>> @@ -27,6 +54,12 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>>  		return PTR_ERR(cb_dev);
>>  	}
>>  
>> +	ret = qda_cb_setup_device(qdev, cb_dev, sid);
>> +	if (ret) {
>> +		device_unregister(cb_dev);
>> +		return ret;
>> +	}
>> +
>>  	entry = kzalloc_obj(*entry);
>>  	if (!entry) {
>>  		qda_destroy_cb_device(cb_dev);
>> @@ -74,8 +107,14 @@ int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>>  
>>  void qda_destroy_cb_device(struct device *cb_dev)
>>  {
>> +	struct qda_iommu_device *iommu_dev;
>>  	struct iommu_group *group;
>>  
>> +	iommu_dev = dev_get_drvdata(cb_dev);
>> +	if (iommu_dev && iommu_dev->qdev->iommu_mgr)
> 
> Can either of them be NULL?
it's only called from qda_cb_unpopulate() so it can't be NULL. I'll
remove all the unnecessary non-NULL check like it was done for GEM.>
>> +		qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr,
>> +						     iommu_dev);
>> +
>>  	group = iommu_group_get(cb_dev);
>>  	if (group) {
>>  		iommu_group_remove_device(cb_dev);
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 09b6d5ac390b..fdc909facd95 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -56,6 +56,32 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>>  	return qdev;
>>  }
>>  
>> +void qda_deinit_device(struct qda_dev *qdev)
>> +{
>> +	if (qdev->iommu_mgr) {
> 
> Why?
> 
>> +		qda_memory_manager_exit(qdev->iommu_mgr);
>> +		kfree(qdev->iommu_mgr);
>> +		qdev->iommu_mgr = NULL;
> 
> What for? If it's a teardown path, qdev will be destroyed soon.
ack, will remove it.>
>> +	}
>> +}
>> +
>> +int qda_init_device(struct qda_dev *qdev, int num_cbs)
>> +{
>> +	int ret;
>> +
>> +	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);
> 
> devm_kzalloc_obj()?
I'll check on how this impacts the exit path. Will implement with this
if it make the logic cleaner, thanks for the suggestion.>
>> +	if (!qdev->iommu_mgr)
>> +		return -ENOMEM;
>> +	ret = qda_memory_manager_init(qdev->iommu_mgr, num_cbs);
>> +	if (ret) {
>> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
>> +		kfree(qdev->iommu_mgr);
>> +		qdev->iommu_mgr = NULL;
> 
> And what is going to read this NULL?
won't be used, will remove this.>
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  int qda_register_device(struct qda_dev *qdev)
>>  {
>>  	int ret;
>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>> index 3bd41b9593fa..690a833d732b 100644
>> --- a/drivers/accel/qda/qda_drv.h
>> +++ b/drivers/accel/qda/qda_drv.h
>> @@ -13,6 +13,7 @@
>>  #include <drm/drm_device.h>
>>  #include <drm/drm_drv.h>
>>  #include <drm/drm_file.h>
>> +#include "qda_memory_manager.h"
>>  
>>  /* Driver identification */
>>  #define QDA_DRIVER_NAME "qda"
>> @@ -40,6 +41,8 @@ struct qda_dev {
>>  	struct device *dev;
>>  	/** @cb_devs: Compute context-bank (CB) child devices */
>>  	struct list_head cb_devs;
>> +	/** @iommu_mgr: IOMMU/memory manager instance */
>> +	struct qda_memory_manager *iommu_mgr;
>>  	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>>  	const char *dsp_name;
>>  };
>> @@ -59,6 +62,8 @@ static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
>>  struct qda_dev *qda_alloc_device(struct device *dev);
>>  
>>  /* Core device lifecycle */
>> +int qda_init_device(struct qda_dev *qdev, int num_cbs);
>> +void qda_deinit_device(struct qda_dev *qdev);
>>  int qda_register_device(struct qda_dev *qdev);
>>  
>>  #endif /* __QDA_DRV_H__ */
>> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
>> new file mode 100644
>> index 000000000000..b1a80ee77c35
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_memory_manager.c
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +
>> +#include <linux/slab.h>
>> +#include "qda_drv.h"
>> +#include "qda_memory_manager.h"
>> +
>> +static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < mem_mgr->num_devices; i++) {
>> +		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
>> +
>> +		if (!iommu_dev)
>> +			continue;
>> +
>> +		mem_mgr->devices[i] = NULL;
>> +		kfree(iommu_dev);
>> +	}
>> +	mem_mgr->num_devices = 0;
> 
> What for?
not needed. I'll remove this.>
>> +}
>> +
>> +/**
>> + * qda_memory_manager_register_device() - Register an IOMMU device
>> + * @mem_mgr: Pointer to memory manager
>> + * @iommu_dev: Pointer to IOMMU device to register
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>> +				       struct qda_iommu_device *iommu_dev)
>> +{
>> +	if (mem_mgr->num_devices >= mem_mgr->max_devices)
>> +		return -ENOSPC;
>> +
>> +	iommu_dev->id = mem_mgr->num_devices;
>> +	mem_mgr->devices[mem_mgr->num_devices++] = iommu_dev;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qda_memory_manager_unregister_device() - Unregister an IOMMU device
>> + * @mem_mgr: Pointer to memory manager
>> + * @iommu_dev: Pointer to IOMMU device to unregister
>> + *
>> + * Removes the device from the registry and frees it.
>> + */
>> +void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
>> +					  struct qda_iommu_device *iommu_dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < mem_mgr->num_devices; i++) {
>> +		if (mem_mgr->devices[i] == iommu_dev) {
>> +			mem_mgr->devices[i] = NULL;
>> +			break;
>> +		}
>> +	}
>> +
>> +	kfree(iommu_dev);
>> +}
>> +
>> +/**
>> + * qda_memory_manager_init() - Initialize the memory manager
>> + * @mem_mgr: Pointer to memory manager structure to initialize
>> + * @max_devices: Number of IOMMU context bank devices to make room for
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices)
>> +{
>> +	if (max_devices <= 0)
>> +		return -EINVAL;
>> +
>> +	mem_mgr->devices = kcalloc(max_devices, sizeof(*mem_mgr->devices), GFP_KERNEL);
>> +	if (!mem_mgr->devices)
>> +		return -ENOMEM;
>> +
>> +	mem_mgr->num_devices = 0;
>> +	mem_mgr->max_devices = max_devices;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qda_memory_manager_exit() - Clean up the memory manager
>> + * @mem_mgr: Pointer to memory manager structure to clean up
>> + */
>> +void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr)
>> +{
>> +	cleanup_all_memory_devices(mem_mgr);
>> +
>> +	kfree(mem_mgr->devices);
>> +	mem_mgr->devices = NULL;
>> +	mem_mgr->max_devices = 0;
>> +}
>> diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
>> new file mode 100644
>> index 000000000000..7e38c8a18284
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_memory_manager.h
>> @@ -0,0 +1,55 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_MEMORY_MANAGER_H__
>> +#define __QDA_MEMORY_MANAGER_H__
>> +
>> +#include <linux/device.h>
>> +
>> +/* Forward declarations */
>> +struct qda_dev;
>> +
>> +/**
>> + * struct qda_iommu_device - IOMMU device instance for memory management
>> + *
>> + * Represents a single IOMMU-enabled device managed by the memory manager.
>> + * Each device can be assigned to a specific process session.
>> + */
>> +struct qda_iommu_device {
>> +	/** @dev: Pointer to the underlying device */
>> +	struct device *dev;
>> +	/** @qdev: Back-pointer to the parent QDA device */
>> +	struct qda_dev *qdev;
>> +	/** @id: Unique identifier assigned by the memory manager */
>> +	u32 id;
> 
> What kind of identifier? What is going to use it? I don't see any
> readers in this patch, please don't add useless data.
I'll move this to the patch where it's actually used.>
>> +	/** @sid: Stream ID for IOMMU transactions */
>> +	u32 sid;
> 
> Do you need to store it?
will move it to later patch where it's actually used.>
>> +};
>> +
>> +/**
>> + * struct qda_memory_manager - Central memory management coordinator
>> + *
>> + * Coordinates memory management across multiple IOMMU devices. Maintains
>> + * a registry of devices in an array sized to the number of context banks
>> + * described in the device tree.
>> + */
>> +struct qda_memory_manager {
>> +	/** @devices: Array storing registered IOMMU devices */
>> +	struct qda_iommu_device **devices;
>> +	/** @num_devices: Number of registered IOMMU devices */
>> +	int num_devices;
> 
> What for? Is devices array to be looped up to num_devices or
> max_devices?
num_devices is to trace device registry with manager, it grows on
register operation. I'll improve the comment.
> 
>> +	/** @max_devices: Capacity of the @devices array */
>> +	int max_devices;
>> +};
>> +
>> +int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices);
>> +void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr);
>> +
>> +int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>> +				       struct qda_iommu_device *iommu_dev);
>> +void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
>> +					  struct qda_iommu_device *iommu_dev);
>> +
>> +#endif /* __QDA_MEMORY_MANAGER_H__ */
>> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
>> index 723b3e61bf0a..64bf503106d9 100644
>> --- a/drivers/accel/qda/qda_rpmsg.c
>> +++ b/drivers/accel/qda/qda_rpmsg.c
>> @@ -42,11 +42,25 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>>  	drm_dev_unplug(&qdev->drm_dev);
>>  	qdev->rpdev = NULL;
>>  	qda_cb_unpopulate(qdev);
>> +	qda_deinit_device(qdev);
>> +}
>> +
>> +static int qda_count_cb_nodes(struct device_node *parent_node)
>> +{
>> +	struct device_node *child;
>> +	int count = 0;
>> +
>> +	for_each_child_of_node(parent_node, child)
>> +		if (of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
>> +			count++;
>> +
>> +	return count;
>>  }
>>  
>>  static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  {
>>  	struct qda_dev *qdev;
>> +	int num_cbs;
>>  	int ret;
>>  
>>  	qdev = qda_rpmsg_alloc_and_init_qdev(rpdev);
>> @@ -59,10 +73,15 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  		return ret;
>>  	}
>>  
>> -	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>> +	num_cbs = qda_count_cb_nodes(rpdev->dev.of_node);
>> +	ret = qda_init_device(qdev, num_cbs);
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>> +	if (ret)
>> +		goto err_deinit;
>> +
>>  	ret = qda_register_device(qdev);
>>  	if (ret)
>>  		goto err_unpopulate;
>> @@ -71,6 +90,8 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  
>>  err_unpopulate:
>>  	qda_cb_unpopulate(qdev);
>> +err_deinit:
>> +	qda_deinit_device(qdev);
>>  	return ret;
>>  }
>>  
>>
>> -- 
>> 2.34.1
>>
> 

