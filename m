Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122FCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B1F10F871;
	Wed,  3 Jun 2026 05:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8j4zNtb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKn75NX6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A4210F871
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 05:46:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6535Wg031568329
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 05:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=; b=l8j4zNtbaNo9Nw2A
 dI861FKta50sP94zsAFz9s/HbxVQJGYtbZTU2VKRrawcVwcmjArJCbq0vLiB7uko
 TqsWqSXPjhAYWSPF5mi1LZCU65HiO7bA10vMCnENN5ctlYxx742kBHkKvrWgFODQ
 X5Xw8JTjr/cBAoH7UvLA1+rBgO2rLZEQFrVs/NTqTgbLtYeXyEGSwvdywLjO90QK
 rUZBHOjPcSqFNwUow8/nseSuP41yZlhym007DBINCXH8wwdLwLK+IlmzKZFXcDYy
 LvqTBWpN4jSXiXqGARQS11F5LpoA+bicR5UPgRXZ7kF47zWEJkUo0G+erkD7mDGJ
 QqVu7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsjadbt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:46:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d97415004so6770579a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780465605; x=1781070405;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=;
 b=dKn75NX6MVOzC6d/BQfdfc49vSQh6uue0emgjwnBixveUj0cobZB9KPal6i+sCQ4GW
 SJ2ff3sJqqCbeeTuHG0Dz69saMEELEVb72SvNZYJNPP9S21ter5E+UhDtnfAnnUqbkoX
 SsXPzTNK5e1o6cpa4jnbJSdmbioXtmPLVNPguiA0OywbtsRdVHS+22nj3eOt8/eZdzXl
 SOOmAP43RjTDcZtjBel9mWffI2wOb71j+kfkt1BPLdDxN9PxxfFS/NPkH5SLVevaru5Z
 OewznH1d22m3R95zfec/4rsJBaPW5G78bKGV+iJ4IjKzu1a6vL95MT3CDtCjTS5mnDvG
 YuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780465605; x=1781070405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=;
 b=GHMoDJkyjvOz8UmMFZiD1Fd56XohdtI6SqiSnLIRaPU4sqAT8diYNq7amcDRMKk+1r
 3FM9+sdqBv1ilahNADba6xum1jfw3kTA6SYGEj/FooHINSOzJ4gjNmyh2jUzHDzCmobO
 oD64xuuhRDiP2ZKQU+m+25wXFRG+ci0YaHrqSn07cWRARW3lxKCsPeIb3aQbCXxCyfq9
 7hlxhXAAEGJ7fQrERlOxaV/LL62xAwFH3YqcAYl+OuMq2CPoRrxiMX6QeBTH5TaShAg6
 YF2r8HIUGc3ON8rPrv/9GVXLrN7NuoMcHlbsR1Vw/3FRz7NKQzucyEhEHdrj1UdIz59p
 kfOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9clz5BRK5zlW2BhZcnN8rITpP5mApVQWGmkwAeMnxDOOkfJIVHhC32RNGz+R6I143YRvrD1zXP2zU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzepV0s1juKdqkcvMMdTCvzoJy70jKWwtQY5ssuSnxjvclAjVD/
 lsz6Xkrigf9NYpLPxmNcZYsBIvXIXpxVGmZLnffCO1dQq4toSSOYdP9diduHbSeCAOno3x/UtqW
 bmq9y+nDaDF04/z4QcPTZudetGuv0k9S7ioDbd5JHXAQm++ykiz/zvcvp7/sM9tGgQ1faDP4=
X-Gm-Gg: Acq92OHIeNNAjv2vshnCrG11QH6KxRTBfo3ilPVrriejU/6LKp6OyDrGkx6I2cZJql6
 eBiWGtMWQ6/HAkH2VCdmvfDcO4xvuwlpZlt4/fkU/UXKqrlOIrdc8cc77eFgI3Cqtx7LIvCjenL
 VMMQrGHFUd2qX+Uk6OkkPx7muADl6UIN9WrLOEL3MzJwoRRy5DpvlE7BQS0gHJQyt3buMnvrK1J
 HL+FuhcC8WtgyLDZj82V66jx6M6F6AJk1AQ+rb2T1OoPFWjlheO4OBYMSn7IMToiKYgJpjAuZk/
 FlDugMI6VFd5ZOve3bwq+bTgcRma0g7Lfp1xhayvMjnSbELBNy2fMUh0yk2dn0CIULEgasBwsVL
 324x7Ln/cgR3hTe87njPrhqTUpcOnfrWwhmGC1C4EFg+Zb2xZJHnKVXvwApaE
X-Received: by 2002:a17:90b:3a90:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-36e33bb9354mr1974885a91.18.1780465604801; 
 Tue, 02 Jun 2026 22:46:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3a90:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-36e33bb9354mr1974830a91.18.1780465604223; 
 Tue, 02 Jun 2026 22:46:44 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649ca4dsm10999325ad.76.2026.06.02.22.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 22:46:43 -0700 (PDT)
Message-ID: <f146f972-6508-4147-86f1-2b88c80e1c89@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:16:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
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
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
 <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MyBTYWx0ZWRfXzjydpJixWmZ+
 e3INzJKBIuqoG58kHQ+oekPGwB67upMdiw5tH+8Q8Rvm6VTJmeCaBP+kB7FjIrUVGuKifJHtReB
 dr7q4rzu9VjijyYHVv7xK5yDG0YktM9mEtclNCtmDVPoGYpWSccedgQji8By3JD39adff2NM6vq
 VkRWPRCUGUiGD0anUh7NA7lpgJR23/FQpWtphiSW6AoZfwbMVggFAf0eti6lDx5JHlD+9u/qW4P
 4VObaowUMA2QLfCIu3KfvWfeTir/Q8+uo71pnwX+G04ooL5gJ3kIll06iEBh9L07ecAkP+VWMuK
 V+kdk2a4WrT+B2snLaLcCC3gbmalqP+zEqvKBELC/tEL5hPyl8TKWPXIzbPBS3oxBEbIqcPdf3x
 9+5wExeVz7a1zczaKEmBb7mYxcaLTT8RDOWXcxnDOfqYcfgG+Ruv4PgAiidFKqgoSR4HNbIfv8M
 y1PBGicDH+6zvOknceQ==
X-Authority-Analysis: v=2.4 cv=Ld4MLDfi c=1 sm=1 tr=0 ts=6a1fbfc5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LzV4jstc-Az_XmsxRYMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: dDvTFAFClFjC-1W0MGpamW5WmbJB4OB5
X-Proofpoint-ORIG-GUID: dDvTFAFClFjC-1W0MGpamW5WmbJB4OB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030053
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

On 20-05-2026 19:57, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the QDA memory manager (qda_memory_manager) to track and
>> manage the IOMMU devices that back each compute context bank (CB).
>>
>> Each CB device registered on the qda-compute-cb bus is assigned a
>> unique ID via an XArray and wrapped in a qda_iommu_device descriptor
>> that records the device pointer and its stream ID. This registry
>> allows the driver to look up the correct IOMMU domain for a given
>> session when mapping DSP buffers.
>>
>> The memory manager is initialised in qda_init_device() before CB
>> devices are populated and torn down in qda_deinit_device() after they
>> are destroyed, ensuring no dangling references remain in the XArray.
>>
>> qda_cb.c is extended with qda_cb_setup_device(), which is called
>> immediately after a CB device is registered on the bus. It allocates
>> a qda_iommu_device, registers it with the memory manager, and stores
>> it as the CB device's driver data so that qda_destroy_cb_device() can
>> retrieve and unregister it during teardown.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>>  drivers/accel/qda/qda_drv.h            |   5 ++
>>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>>  7 files changed, 254 insertions(+)
>>
>> @@ -61,14 +62,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	}
>>  	qdev->dsp_name = label;
>>  
>> +	ret = qda_init_device(qdev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>>  	if (ret) {
>>  		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
>> +		qda_deinit_device(qdev);
>>  		return ret;
>>  	}
>>  
>>  	ret = qda_register_device(qdev);
>>  	if (ret) {
>> +		qda_deinit_device(qdev);
>>  		qda_cb_unpopulate(qdev);
> 
> No, this is not how you unwind in the error case in the kernel. Follow
> the established patterns.
Okay, I see your point and the same you highlighted on previous patch.
I'll update this.>
>>  		return ret;
>>  	}
>>
>> -- 
>> 2.34.1
>>
>>
> 

