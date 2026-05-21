Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF80CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED8B10E450;
	Thu, 21 May 2026 06:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGbvrLaL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWL3qNEl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B123610E450
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:40:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L1BXRK748568
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=; b=pGbvrLaL78us87ZC
 qoWvxsv7V2INxu/+LYewLf/Dj9+tEUXahR+lOB1X0Jn6fABWHOWTXz9IjuiptX63
 LDHkSGIRTxjXwrGYwGXEnQeETck4YSzpAKVmctSzjxA3Q5MHR1sSW2h8P3AO3uIB
 olClDTEjvs2c6UwO6AWstv3MzUE/DaqWAMcx/rbLwes0tAHjMYdL9Ju1yvFsH4td
 FamEMvDSnYWQQAPHrWkbljA26w1wV12BpCN7fks9DapiFsrMUxOlofal82eKGD9O
 y/eg1qOLPXIDCixysfptgpB//Pt+S6sQhrBHY1FLK4Go4EQ8hqIV9bfHbMLRiMF+
 EAoVPQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6k30s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:40:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b4678c6171so60661065ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779345659; x=1779950459;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
 b=fWL3qNElKT5lW8CkJjxINeFiRQnMepbwQUDsZ95lYRbLuNADdiZn1My53sWOx8XWpx
 6QEaEbcqEU/fAGBgoBLJi/2FqKssDN2JmZKdHj42kLpeFJGnRkI5SicQUhWJ788DfhI4
 oU8o95kanAFCqeU5OVIxeigoXZ//wjSUujI/y/4vrNPtQQd+mZgnSsj6vXCGagJYIxB4
 sfiZABRHMuC+IJ0114trsMuSlvTktSKaeCwVU7qk7jzzW3drSuSVUIKi2nQbWXhnF/Z6
 cgE1yXU7zJhJ7/N32KPUJScAbee3QKtBlYuauhFZg3kB6OsSNKRU7Nh4ibPzOYeIgFlT
 xJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779345659; x=1779950459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
 b=iAfwAaxjE/sxfZ4whEwXRmUCuphJ/eNxmRfs2kL+ofz4Z9Dag/Z/9FsrBk9QUfyhKk
 gzR8jypVy+h4NYvK7lFqLuN0ACggD7CH9DkQhN3h7/NPDB5k8Rp7itmR29PahIIN/xsU
 SgqqB7VrgGVQnEaurn+rmLfpqenTVl/HBKTNWUt0IuHvsCyix5swL7/SfS0Ep7zw9OAo
 bJA+P/yyCsIBftsEU9DoU57W+AZpwoOLUnH8nQn2adZ5riJds+E3mDVG3xYPCk/2rjZ2
 zKSHUDK8THjcrlwebRoDq5bHTpS4yhBczLaCLRXlAwC0j88hUJ5i5Z8myasFSkBhtPsP
 UjRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vSIxOJ5JJdqabVWQpR2XT3vr/XUfx/4vofDzADNzzwS6TXw21Qhzm672Fo7CkubQMPistU+X9AvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxvay1JTpi0mIFeuax6oFiVgQ1oEu9n6tWp1g5yXvcgOP7hqwYS
 dsraAPOKEfKwjfwBKGPq4TPHBWVu5JE1WsFj9Uh/XX9hP5MS+EadqBQxUyiHkQJHDE8lj+h2GR6
 s5sZ0PRndwZi9s8FMbA6zK4bXaox78CFBnW1yzzKVXg9TvQsrQiBwsWy3FfSqZl9fXv+lEn8=
X-Gm-Gg: Acq92OGiWiAWdHZQWwqmyaI5tFIT177D5TOmOAqY2dEKRBlkymYim7/HMi3e7brcNN6
 os0IBeorFy4PRXVZWPRmVy3k5M7fLx5pMpUwIHn9BRxJ+IiHf3jhyGAkJvLwIpDJjrWO0aVsiXk
 90GuLr85HenawZZdHLgNN6t7y8g5d5suf1ybzXZpThsG1zQsbZq0Ei3SIMStKkOJnP+45YT14oV
 aBLNZHP8lDfuJnS8uocGyHABBnHsbDsdD6Wbq+06xWVi6no4YEyMU2fCvBTAfXI6wZ9K8/VWnck
 7TknBjsumb/i8KXe+K8ahPljBrabNR1GSnuY7MbdO9HRtYnzRhkJb5JtS/3S2oH1w6/YILaMXri
 3mrfQFuNeW86qfsmb8D3Efpd6gSr9QLKUTL3/SkNKsTduDk8D6J3wyi25
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id
 d9443c01a7336-2bea3367915mr15247315ad.30.1779345658551; 
 Wed, 20 May 2026 23:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id
 d9443c01a7336-2bea3367915mr15246705ad.30.1779345657978; 
 Wed, 20 May 2026 23:40:57 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe8698sm234673925ad.40.2026.05.20.23.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:40:57 -0700 (PDT)
Message-ID: <07cdbd20-f0c5-4be5-878a-ef23dc633767@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:10:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, pgujjula@qti.qualcomm.com
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ea8fb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WXTWxIQM56r_4Oy2wpoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 1oXsBbYnEwNmApIwmdHx6d67MzxP8nom
X-Proofpoint-GUID: 1oXsBbYnEwNmApIwmdHx6d67MzxP8nom
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MSBTYWx0ZWRfX6w6ZTHA6YCgx
 pH23Xtjrey94bztSzjBrh25BIik7G1wxcmXSMKmjh+F18kxGJL99NvckKf2NIFleUbgne81otLS
 n3pTpey2LxMhDnEXz+VkF6uhRRNA4EhQKk5n/JCe9oHAtLu8gk5enBqS0lHpfu9GxlH6letDpU4
 xe++Dub3t2tDE2+NsvDvqTJFVc8bKKD2lqDbXTVGtec0ol7FiaVby8KCFITEGJD5vj4Dw289J3e
 CTENrIkKL6QZ1CpqsATT4hXxILJql9Fs2lEJX09GM9H1vxVLmHcb0ROYLMSjy7aaGXJQhqHUnJg
 YM0lmWj0hixrdJ7amBnL3kF8MLu65Xlw5aFugo9RlGf3LwDxs3mGrunmD3uD1N1mwlT3qRh3OY2
 NPUZIwjrrpG09Agov5hOY+I8ZMXzlR2I0JnCxJlMcQO/mq7Hy8bTqmLnt6gpwstOAihe7l6jEfH
 a/DsM+DSfXPoJsrTQ7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210061
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


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..b3c5281aea91 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/of_address.h>
>   #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>   		return -ENOMEM;
>   	}
>   
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>   	if (ret)  {
>   		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>   		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>   						     cp_config->cp_nonpixel_size);
>   		if (ret) {
>   			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   			return ret;
>   		}
>   	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>   
>   int iris_fw_unload(struct iris_core *core)
>   {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   }
>   
>   int iris_set_hw_state(struct iris_core *core, bool resume)
>   {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, 0);
>   }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index 63ee8c78dc6d..7997b8aa427a 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>   	select OF_DYNAMIC if ARCH_QCOM
>   	select QCOM_MDT_LOADER
>   	select QCOM_SCM
> +	select QCOM_PAS
>   	select VIDEOBUF2_DMA_CONTIG
>   	select V4L2_MEM2MEM_DEV
>   	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3a38ff985822 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/sizes.h>
>   #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>   	int ret;
>   
>   	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, 0);
>   		if (resume && ret == -EINVAL)
>   			ret = 0;
>   		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>   		return -EPROBE_DEFER;
>   
>   	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>   	core->fw.mem_phys = mem_phys;
>   
>   	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>   	else
>   		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>   
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>   						     res->cp_nonpixel_start,
>   						     res->cp_nonpixel_size);
>   		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>   			dev_err(dev, "set virtual address ranges fail (%d)\n",
>   				ret);
>   			return ret;


API "qcom_scm_mem_protect_video_var() would also need this migration, 
any reason not to consider that ?

Could you please check, if any such usage of legacy *scm* APIs, like the 
one i pointed above, can be enforced to err out at compile time ?

Regards,
Vikash
