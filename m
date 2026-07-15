Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82F6C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1830A10F02A;
	Wed, 15 Jul 2026 12:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.b="V4xEtnpS";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6B710F024
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:16:14 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8efb708b1a0so46127796d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1784117773; x=1784722573; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XYn30NuQBlpDBaqikH9GRFE2pdu5APUaoZom7kBIJ94=;
 b=V4xEtnpSA1XQ/LocZ3CcsdMfTygzE89Flj3XVlRsSy5CDRBDwm5louIfoXkqAquR3B
 zWzW9PqGPuKVdYrpXs3UvLwJbG8ukBIBVrKsdJYEnpm9R6+qBCQ81i4UMZj5ZJPJgI7Y
 ugZRjUe7e6Y2bSCm+rRVGgP4B3SmYITFGK9yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784117773; x=1784722573;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYn30NuQBlpDBaqikH9GRFE2pdu5APUaoZom7kBIJ94=;
 b=lRtF5B0Cv0i5yb1vAegEgclbehAkA8nIpYdaUbyXmkNE+ZV5a9nW1Zt5yrW6wt6EVS
 QY81C1U+2DlzJm2wckEmPUv+shX0dovZ0X+wUNLdN9NkYnHz/Cui7Myq1k+vatEZvN9Z
 jKjMjVTii401psQTJewEu/RVOzN3SdAdjPM75OUJe5FML5l8MVOEj3sO+dzbA3s/j5ul
 5DyKi/SsX4xnvWbXCU0pG9ClLB/yeX6JaTFTAlTjWZBOXIQxijKe07Bwn9mSYu5Z0ygN
 kNQsRU2ueBFoPERBWwdT2WnfAGprPx2Tp4p9br0fvQnX2lt3DGwcT3GIiTtRq9ijAFMU
 XLpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxpYxn8B3vfk7hCZYuTENxvul3sqm+cPuB/sfQIocq4rbI2VAvEVUV1sXLuCDpVjQ+2pbWV2iS9Jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2XU14YB98t/4F6ZGa2hxAOJ00aHaz77yVPaav969q+UnkQD9i
 pdSy5fdG2emtfPq7ghZzEaPoHi3VMRqUPuYgB2FZ40M+OORXRUi4pLl9oeU6Pq77NQ==
X-Gm-Gg: AfdE7ck3X/9I31qN0UoR6Dq6+BqW3Bfx79FMXwsmDwMDN/fB0NkEFEfmOTDqLdfQuSy
 4UU6C6bly0rueukDn9phjR5OZ1VOqPIho0x17mCzXbrR39Tz4OwzDaOc/Ae042pDoJEjDLLsAZc
 bkOR3lu9A9rgYNN1Xln5BI9E1qS/Nvnj1wjvLje5VoNdcxOQ5oFKr2rMyhE9qgsSIgAXrPqmjy+
 WNGk+YQBHfAwTxPmKkXs5zIsAQ5AxsV48j2a9ur6E+8Gpf5HqvqZKi0B1o/XeRUhQVIBJ6wJW08
 yxbXZR7xy3Y5qsRsoqLnnC8nuNC0Z8kIDEwoXszgCNgKs2U6x4RC0unbqEd4gKjhfx3JWIKkiuY
 7sc3tXysOMC5IeXKGgHgXl7+D7RxQzum4H2anI1+jWOn9V9O2CaPZv6ODRrl94gulc0Wt3I85ZQ
 BbeyYj0PyvMnOKdxLdj7mC
X-Received: by 2002:a05:6214:500e:b0:8ef:5b18:65ec with SMTP id
 6a1803df08f44-9074c70b5cemr66890686d6.15.1784117772692; 
 Wed, 15 Jul 2026 05:16:12 -0700 (PDT)
Received: from [10.211.55.5] ([73.62.185.64])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1fd2bsm193918296d6.27.2026.07.15.05.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 05:16:11 -0700 (PDT)
Message-ID: <358b1215-df7a-427f-89cc-55a6f2cf357c@ieee.org>
Date: Wed, 15 Jul 2026 07:16:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/14] net: ipa: Switch to generic PAS TZ APIs
To: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jenswi@kernel.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Alex Elder <elder@riscstar.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-12-sumit.garg@kernel.org> <alJp8jMzcw9EPZoy@baldur>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <alJp8jMzcw9EPZoy@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/11/26 11:06 AM, Bjorn Andersson wrote:
> On Thu, Jul 02, 2026 at 05:28:27PM +0530, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
>> service allows to support multiple TZ implementation backends like QTEE
>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
>> backend service.
>>
> 
> Please find an immutable branch with the dependencies for this patch at:
>    https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org
> 
> Alternatively, if you think there will be no conflicting patches in the
> time leading up to next merge window provide an Ack and I can pick this
> through the qcom tree.

I don't see any reason there would be any conflicts (certainly
no difficult conflicts) with this commit, so I think you can
safely take it with the others through the Qualcomm tree.

So if my ack is what you're looking for:

Acked-by: Alex Elder <elder@riscstar.com>

Thank you Sumit and Bjorn.

> 
> Thanks,
> Bjorn
> 
>> Reviewed-by: Alex Elder <elder@riscstar.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>   drivers/net/ipa/Kconfig    |  2 +-
>>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
>> index 01d219d3760c..a9aff1b7977d 100644
>> --- a/drivers/net/ipa/Kconfig
>> +++ b/drivers/net/ipa/Kconfig
>> @@ -6,7 +6,7 @@ config QCOM_IPA
>>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>>   	select QCOM_MDT_LOADER
>> -	select QCOM_SCM
>> +	select QCOM_PAS
>>   	select QCOM_QMI_HELPERS
>>   	help
>>   	  Choose Y or M here to include support for the Qualcomm
>> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
>> index 788dd99af2a4..3cd9e44680e9 100644
>> --- a/drivers/net/ipa/ipa_main.c
>> +++ b/drivers/net/ipa/ipa_main.c
>> @@ -14,7 +14,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/types.h>
>>   
>> -#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   
>>   #include "ipa.h"
>> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>>   	}
>>   
>>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
>> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
>> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
>> +	} else {
>> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
>> +		if (ret)
>> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
>> +	}
>>   
>>   	memunmap(virt);
>>   out_release_firmware:
>> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>>   		return IPA_LOADER_INVALID;
>>   out_self:
>>   	/* We need Trust Zone to load firmware; make sure it's available */
>> -	if (qcom_scm_is_available())
>> +	if (qcom_pas_is_available())
>>   		return IPA_LOADER_SELF;
>>   
>>   	return IPA_LOADER_DEFER;
>> -- 
>> 2.53.0
>>

