Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C7ECD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEC010E9D5;
	Wed, 27 May 2026 20:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tBdhlAEl";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D42110E9D5
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:30:53 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so8030463a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779913853; x=1780518653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2OhCxIlJi2QiiC8j/rvp1ZcuO4vzfhN+zs+219JbuA=;
 b=tBdhlAElDurOkjMJ5VI/cKjVGgObL9BtWEk0DznVRU9nF1OzdNnzq2QLHuy1i4/zG1
 zfTqBTfi0xrZRgchowi/IqSHk9KjmatSTAY794CPhgbgF2qJrtyHZ9H4p3sshTOdXx/X
 tAnYGluOHob4VQFzONgnVX2Miw5TYOzzNgaSbflSlHeq/z5GYZP2fqcH9Uj3VfPdL6Vf
 FvHLiXq262YbC7hleohIvBSK5vRNMJIYAFmNDBZ4NL+Q/sYIaH+hI/q3bcEzGdgyBR3a
 ed+A0eRxSVf0rGqLmDe2J5zFqWG+08X9wc9ytqTw3hZGeiJ0UMztlGhFEnXXpKGJGwpl
 LWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779913853; x=1780518653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2OhCxIlJi2QiiC8j/rvp1ZcuO4vzfhN+zs+219JbuA=;
 b=JMbHGbo+phZexB6pqAc20+1x3UrIG1p6dYzTz8e5qN89OQu4z2/hjFcbiTALp6NjsF
 94iLSHErbfLxVT/8k9TBoPJm2rsRST/fpsCHndlQE0Q3C07Aeg+IKPfSZfHky3tVVICl
 8qZhKJ57ywAwBZHwSRMX9kzxwDCnSWM6L4wTf/kEFqpqfKz5Efs3jHTbuDlq9YEwBIan
 5ouM8VYPjK0xypan9ZRwfLsAZ+X0xHdX22DYwKphui60dntewYykM6omFvVwyGg7Q7wM
 jxPH7JCTA1JjOQC3xeBs7n7u9IfvOkOBeQhdjcVLyctF8ctRRPMQDQR1v68MKXMFuqct
 v2eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LnAQl67Zkd1gp+AENlvWrHFvf4MMHS/F9l8wsQlpQKRdJB66n0KdShVVQ1F62X5zPWVIOnPiJ548=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0TJ3t/XRXnYP5iHOQExZ4Pkc9cme/OuaFPoAuGQgkDOgBhgml
 kEl+mGpqEapeo7Rcxr+qHV8Q2BM2IVtAzylXjuPXIQITJnlN8FanxUAy
X-Gm-Gg: Acq92OF/CaauIEurPwPmkcWWEKq7+qgH01UiV3qbg1RwjNoRMwwuWM5+mQfM9NCP5WU
 goJUReV2XokG9b2qZIx+z4oPgx2NSqDlg+E9porZRXkZ6tqfUeoUJ8xNqExLFNDy4VCWG/5/KK+
 ZxLHeVt0agFlGPCXA2LanIRvjBF7mlEtOneSQ8J2gQm4z0d6fxlGvreNpbIVYsgkoi+eNe2Hq36
 NmFlUg78iV/N+MHi8pAzOQL3ofcaMvNmw1vEjS/pDWxK5noZF1uNLJigd2+y+ue/7bJASlCD7lc
 OCuhtuRP2PnEfPnwubkg8NXomsGBgwPM7yYu6VeRcUjb66ORQF35eiCylSBBw7XLjnzdY5ffIvR
 nnOtemws5c7tca/wcDR70+q1fEMtlmk9l3wdIq+Mod0HXxfp3cox3bPIxm38gyHk/QFLIbJnIJv
 SLiGapTK8wfPAaSrnt8Q/WPpAZhxkslWmDwhz0315UV/vJ+yA=
X-Received: by 2002:a17:90b:134f:b0:366:3ac:f725 with SMTP id
 98e67ed59e1d1-36a6788d912mr24792193a91.25.1779913852550; 
 Wed, 27 May 2026 13:30:52 -0700 (PDT)
Received: from [172.18.227.108] ([219.88.198.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c98b95sm16549405a91.16.2026.05.27.13.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 13:30:52 -0700 (PDT)
Message-ID: <4b911ed0-64b1-48aa-a00f-e2ade66afa1c@gmail.com>
Date: Thu, 28 May 2026 08:30:42 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] soc: qcom: rpmh-rsc: Skip TCS init when RSC is
 managed by firmware
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-2-graham.oconnor@gmail.com>
 <934e6039-4639-49bd-8cf9-a1674f86b8c8@oss.qualcomm.com>
Content-Language: en-GB, en-US
From: Gekko <graham.oconnor@gmail.com>
In-Reply-To: <934e6039-4639-49bd-8cf9-a1674f86b8c8@oss.qualcomm.com>
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

Hi Konrad,

This one is confusing.

I started the bring-up on this board on gentoo-sources 6.18.18 but the 
board would not boot. After an almost subliminal flash of tux the board 
would lock every time.I found the solution from PostmarketOS who 
obviously faced the same issue which formed the genesis of this patch. 
With this patch applied the board booted fine so I've applied it ever since.

However, as a result of your response here I tried booting my current 
kernel (gentoo-sources 7.0.10) without the patch and to my surprise it 
booted just fine. This leaves a few options, including:
1) the kernel source has changed
2) this is a firmware issue and a firmware update fixed it
3) It's a timing issue.

To eliminate 2 I would have to test 6.18.18 with the current firmware, 
then regress the firmware and test again. The do the same with 7.0.10. I 
can't honestly recall whether the firmware upgrade was before or after 
this issue first appeared.

If it's a timing issue it's a bit more concerning. If the kernel is 
taking slightly longer to initialise before calling 
rpmh_probe_tcs_config() then it may just be missing the solver 
activation, everything appears to work and nobody is any the wiser. If 
the existing solver code doesn't deal with early firmware TCS 
initialisation then it could, under some circumstances, lead to the 
security reset that I was seeing. This patch specifically tests for that 
case.

Based on the AI review feedback I've also modified the patch to not 
simply return early but to just skip the sensitive parts of the code to 
allow any other setup to complete normally.

My current objective evidence is that the board boots without this patch 
and it's quite possible this patch is unnecessary if the above is incorrect.

Graham


On 26/05/2026 00:40, Konrad Dybcio wrote:
> On 5/22/26 8:06 AM, Graham O'Connor wrote:
>> On QCS6490-based platforms booting via UEFI, the RSC hardware solver
>> is already active when the kernel takes over from the firmware. Calling
>> rpmh_probe_tcs_config() in this state reinitializes the controller
>> while the firmware is actively managing it, causing a security
>> violation and system reset.
> 
> I don't think this has been an issue so far on other platforms..
> 
> Do you have some more details?
> 
> Konrad

