Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F35AC43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D744F10F6B3;
	Fri, 26 Jun 2026 17:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSLVdDV7";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4467710F6CB
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 17:06:01 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so13851575e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782493559; x=1783098359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
 b=gSLVdDV7Krk6A3fOfLybhSkET31M3YUdRBNgMH+8zA5haIXPQ3RaS0sPJnM4be4K01
 FhKapUjO9sZ44rCI2K4C3qTnqIo6/M30Mc5ys+SCZmy3zrEDDqMOaVbhiM3XlChzkeny
 aReC9V1E+GKQg3gFS++gToqB6NkW6+0DCS3zoGPyLkUr6peIvFBwuS/oVawDBE7EPOpo
 g/PlO6t/ibKvr1jME9US96WlVTMRqyND3uGKhpQZUasC5WJ4iQPeoLOod8DObHugqCRp
 VpYwv6Fucra5v3qG9o4eCHAdIxxpXaicvd8hm70/bvvIafxCynq5tVTVuzDq94pqK5zn
 yIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782493559; x=1783098359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
 b=tNc/oXy1oMZWOS9DNfHry/6U2EBqzsATKqO6ELrsvRYm0zzwbV51UUpzG9aVKNdVIy
 q7Qxrwqz2Wt+BCFMsaQtgnm1Ms6a0nEYkaSK8S+X8dvEc3N2An9l+cEVkghEzA5u2KtL
 EwAA9DxJyRtSRZlCEXiK+sW1G0eDR7/rMzm/hXP/erbpldbS+gDsQm7i551NGOFyyIQo
 7Z7Dtkzf3vorctX6jyEg2Z4jEutjGIqy+3WGCnXL1jPZmS3oSZ1asYwvFLr8YJR0O/Fe
 PbT4GynLV/fSVxmB7YfriqbBP8XLiI+xIijaKc6Q2l0snVjHHtGOsqg4vVKxpKwJ9ybN
 4lUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JhaxkI700CT9s1/H3ZZLZfL01kLwfbwC0ZF3bgZClJIwhRrUzB325pRuaIZOlzNOmTILLOP6soW0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8Fe7+n88AFIfx67rzoaS6D9BeHfei1h0mfOWrcwf/xPLMZRvk
 eaq34vOpeirVvDpDMz6kBW7/Kf/Xw87KN/dNwDKTL4A7VAe5QUJUsxmS
X-Gm-Gg: AfdE7cnEG6+coFnuSWOUCy5FOdbPWydU5gYRMVhF63xnDuY0Fn2XG2RRWzYAz0h2VPa
 fLM8jlrErmI2WvQEcb4NLKxxW18wydatvj1UjwvhAU3BXV9zyos25mYi7xyOn2X/e5bvZw34rjU
 FBP+ez6CrnU40XiyZHowOfL/IhHjiHG3EbqFbglBCUSRdTWt6EHalX4KTQoz/U0k4uQnnQCVD9P
 +4o3tscEkqYEfVnswKcSWQSHUIXgI5NqIOQiT21CaX4yE826XOhqH3YPLa36tfWl5J66uyTLDKf
 zhhbq5dOEp7dY1uUNlTQ5NUYlM6C+5ozENNBUN0rvSVoicjyTgdf8Np3KYrx/EvHIC7Iz4/CmOg
 CaGIeh23xjS/ZKcS+RIQY9nyX2SZPsAt+fVqSm2oqtJJ+ggGwvpSMVjIpuaBn7IF32k6mIKMES/
 m2+cF987IMEP1Y367d30qP0gWFSC2I6QW9BN9CLDOGOEddR67s6iIZwRSEmnxhoQepHl2gfBNf5
 EYFOiFi
X-Received: by 2002:a05:600d:864a:20b0:492:5bf9:d149 with SMTP id
 5b1f17b1804b1-4925bf9d18amr186215685e9.5.1782493559068; 
 Fri, 26 Jun 2026 10:05:59 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fe25429d5sm1694876f8f.7.2026.06.26.10.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 10:05:57 -0700 (PDT)
Message-ID: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
Date: Fri, 26 Jun 2026 18:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Sumit,

On 6/26/26 14:34, Sumit Garg wrote:

>  config QCOM_SCM
> +	tristate "Qualcomm PAS SCM interface driver"
> +	select QCOM_PAS
>  	select QCOM_TZMEM
> -	tristate
I think QCOM_SCM is missing a 'select IRQ_DOMAIN'. Right now I get a
build error without it:

drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
  drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
of function ‘irq_create_fwspec_mapping’; did you mean
‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
   2512 |         return irq_create_fwspec_mapping(&fwspec);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
        |                irq_create_of_mapping

- Julian Braha
