Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6414AFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A51C10EC87;
	Tue, 28 Apr 2026 16:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.b="dw0cg1cF";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7949110EC53
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:54:05 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-69498319ee7so11699eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1777395244; x=1778000044; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
 b=dw0cg1cFYqeOK74F67KFGsMMh1TSvHdRCEKO6hM6xYnfs2Zea7g+/p92fiimFu85q2
 7TYPlIlSIjfgROaSrYq+45sXeyek6Lmnbr2u0QpB+ueTPz5GH0EmIvZ90xUAjrFfH3jc
 x+wo4uGUQ1Z1BxNi+Agwq92KflsRSnwXbBylU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395244; x=1778000044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
 b=a6DbghTjkytkaE6PD2xHmlMvA4QKP+RG/bv2FyPiV8IKR4oD9I6vfF18489j5YrJJ8
 SV7tY74wnSmBP0DlCtxxnBgbL47qVnuvhX2RmDMuWdQOE4vfaGnDjT4/G+SYhzsu1WFw
 CTrTv0vfXQK6suIguQZrYdqh0NiJxa3oAmmW5rNIMG4ifsxwgVFcYuCSzjdZwsJr3Y2L
 fMHk/3lmq/b7manbGPoQLuQSKHnyFptzGNj21MsXTRst6BbtQLgkl94JJ5JKkv9ccJHY
 puFgiEz3wmMX/Zdg5wzld1OqOqxNCRBUELY5E9R0TB4SMdhRotgFhTOBy6LBdyyP6ies
 8ssQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GnwCIuqqnwBFRvb/RwOUGCxil0frWI6krme/JpyJ3oE/sDjBKCFSHh57GEZyPKV9lPyCCd7lJNhM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOa1on5tJ31OUkUfKPFzb6waUwGNmZhf3SMEKTtSv+PVEcoXoH
 jaS70kNQvhJVa+NdlKG5nEXCmyzYBTIFrpvSNME8Hm02g8DjVf97soB7j5jsKoBFnw==
X-Gm-Gg: AeBDietWhbpUA7dkWBUkrzxgVKicGiiDNQWcBpd8Ynq1trBy9SHjOa17ejyaayoPYl9
 N6QTBq9Wu76mk5fzzKx57x/7t3IYS6j3d9eZLjCyL0mdBtGBHqkVPzJskghCDFZuT/pEKZp6/rg
 vSiA2xa7wGHvrDnPmsRi/K375NETGIb3snE1AjBA+kKqWqS+/Af22GhYg0pV3MRATCf+qtZ5kdR
 hdt2eee/cnPfLKWeoU4Nx+BAWc+oIKz2fljGDp87fHGoKxO819mwjihi1K8ydXOOFjd/pB1ldxg
 RaqvMmLUt4CjTOtDqmCZInO/a/bTvSTHImkWA38okpyjgR1PQ7IuSqaVrYX8ZI5kZNSpv262mih
 OC4MhUWM+K9xBEMSS9EDSCPn1kxuufHywej8KITb1W59WsLy9ZmhDR3OVXVS3JRTpksBHydgpjz
 IJEZIQ/7Mr9LQzuUQX+YUrttR1mJ29xoeO9wkGXCz/KUCKM19QlCwlSCVrhG6/6IiGhLczXc6Oi
 GwW7bw=
X-Received: by 2002:a05:6820:4b05:b0:696:13e9:6863 with SMTP id
 006d021491bc7-6965c5ee294mr1871158eaf.2.1777395244239; 
 Tue, 28 Apr 2026 09:54:04 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net.
 [75.72.117.212]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-433effdc79bsm2240677fac.18.2026.04.28.09.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:54:03 -0700 (PDT)
Message-ID: <aa2b2823-05b2-49a6-bdd3-622523497a0d@ieee.org>
Date: Tue, 28 Apr 2026 11:54:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] net: ipa: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260427095603.1157963-13-sumit.garg@kernel.org>
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

On 4/27/26 4:56 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/Kconfig    |  2 +-
>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>   	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>   	select QCOM_QMI_HELPERS
>   	help
>   	  Choose Y or M here to include support for the Qualcomm
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..3cd9e44680e9 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -14,7 +14,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   
>   #include "ipa.h"
> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	} else {
> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
>   
>   	memunmap(virt);
>   out_release_firmware:
> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>   		return IPA_LOADER_INVALID;
>   out_self:
>   	/* We need Trust Zone to load firmware; make sure it's available */
> -	if (qcom_scm_is_available())
> +	if (qcom_pas_is_available())
>   		return IPA_LOADER_SELF;
>   
>   	return IPA_LOADER_DEFER;

