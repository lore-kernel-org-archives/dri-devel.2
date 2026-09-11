Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76730C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FB910E041;
	Fri, 11 Sep 2026 08:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZ9hKgyi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZM/q14wt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ADB10E028
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:55:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kh9u2801878
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2IbXZHi371lo7FXX0zW3IyQ0mtUslzhc6wCLyKQtbjM=; b=XZ9hKgyi+VqKDRWt
 Sg79lJotgtVbJzymLntOnFnfzynIR8cLozJoYcxA/gCQ4FJJ0bIkAwrITno1PjuU
 LGCGxpRoFO/BkTm3UaI/8nqBSkGAvKG7vjmSKclfHlmkZ3iGnxdqJqmDmM1dpizM
 P+z561EgSNXDaS8XtJWoAoxJSBy2STweaO55K3pCIHCD53EC+z2m8MWQL+EtPZRm
 eegor3/SUMQk9vO0JGpaaPISO2LC0d3zImu6cu9oqDzpmjb5Sv+uq3DY2ecd7cRn
 IcLONC5WNKYXI0pmz62ezikhtyTwePRJvrDS4h0/U1ShqQlVwUNzGCBocy93Agyt
 xX4gHQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm729hr6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:55:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90e8d3a2d3fso1120076d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789116916; x=1789721716;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2IbXZHi371lo7FXX0zW3IyQ0mtUslzhc6wCLyKQtbjM=;
 b=ZM/q14wtH2LM3ZskZ1Qsc9iMAHd57Fg9qTlbilNoSympEzVFd4bEgCm2VzEnXhtbA4
 bXH2gdBN/Q/uvnDGlAOlNdr4+0fn9SFOR/Y7qHb8/ioEOrUMVtLieYlMaT5Lo9jjVwP6
 X/AkovOVxOs/x3YBsKE7ZNWlkSvhS1NdN6FFy4Woj9UTk88Fsjm6X+CRBDfbcPYX/Zky
 dfFwTUf+J5StObQNsBHqor+xrGfBSelGL0Tg0HsNsYOfmrLmkrbExu1LsFMsZN0drV6o
 YDGWpotThbCWhJD+V6FAAQgKaskZIXntaKa0mGrF8aDODv1dy5qIJC8NqSv8kRhpiv/Z
 lyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789116916; x=1789721716;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IbXZHi371lo7FXX0zW3IyQ0mtUslzhc6wCLyKQtbjM=;
 b=fDUMQB5uFm9E3f/8svQSW4kBpoX6iOWkipKjR2Mlrzxm9l/nWGkn3zv50TFGRFdVqb
 HVMYbPN2zXtH3PfiOrm5pHfBEbDoMCJeTD1ojTE8/IvghJrXXX1RFsxKWtfj/GUsG+Rc
 XWnCml93YdFvGvXO7R5YxHCl4fkGdZHWYT94Am+hC/ZPykfD4Jj+puMazwLmzPmvv12u
 Q6g5Z8N41n6xD2jtTT+14ovh2/6AumogSmX3o3C50zxwe4bfNVq2jpb5Z9xYUnGUyKUH
 NomqGqLwdqMs0g4v3GfRm2nXF1x2nC/AWbSJ7zUs3aUH3P1Wsm4ixnatn+ZL9i0uIP57
 +viQ==
X-Gm-Message-State: AFuF++mCWlvrjaU2nGn4qRXnFNgqUsglsSTUEOAQYJfFqBPQaBHiXTcj
 n7iby+h4QGNAWhwulxFYlPALFginRa31H2xqz6ch1OGQp+gpKtsfsgWh9vlGXzowHTOZL5RHv+0
 T571jTPTvY4yhVY7Dabe0J6sMrW6cPwGNO7xRLjGbAl6lPOV53pbDxxygozdPa1FamExMus8=
X-Gm-Gg: AYBFou0bLxHkvucbzAzraQ0p7fc2wsyr0rCbZT9CttpXA3IpCpyajJoEJ53/GttH7ri
 qTthVSBxJbS05etyiwAIrc4pmhw85xoGfD9DUYdpb2Zi/TBSQQL/r8uc6bTlZaDW0NHtev/YcWj
 MiIYD7QMRgdAIs8F9NBcglbcRdUNAouPtJKbxWm/zjRhd6ZV9OKwt6d2ZSyUvnWT0n7wwoCTgEc
 K2jH0BOnq6QIIxk2Sq9Q/Lvnrnc8IzVYxAgMB0z2o5JC93C3Fi7/MdNoAOeoYJp6VgQmUHkzx4y
 UnjTJusTDEap7x7e4NALuxp/2L5efoWd7V5Y+oZOnfcr3CVeFt25X8HzAreCXI11FImQTGcwuO5
 iAQlc/R6NXn3S5epnkHZwJQ==
X-Received: by 2002:ad4:5aaf:0:b0:907:8b2c:ef0 with SMTP id
 6a1803df08f44-9121211e4dbmr33150986d6.4.1789116915964; 
 Fri, 11 Sep 2026 01:55:15 -0700 (PDT)
X-Received: by 2002:ad4:5aaf:0:b0:907:8b2c:ef0 with SMTP id
 6a1803df08f44-9121211e4dbmr33150686d6.4.1789116915562; 
 Fri, 11 Sep 2026 01:55:15 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296608aee3sm56924666b.37.2026.09.11.01.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 01:55:14 -0700 (PDT)
Message-ID: <477ff72a-fe0b-4c23-8448-a0ec87c7e039@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 10:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add driver for Novatek NT35596S panel
To: David Heidelberg <david@ixit.cz>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Molly Sophia <mollysophia379@gmail.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfXxPsW5oSsUstr
 tzQq/9KSrqLzPyPRKRhAm+fFmaZ9g09YSPyb4a9OiHPsDZ5g5OtE4YYQCuGikePaAnuYO0vXgql
 3fcT3DVmY0LMETr6WJdYsujwmjVNizc=
X-Proofpoint-GUID: KgtTJl95j5EJm9vgcN8MoUqhkzaQ-hQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX4ycOYVcKzB1g
 xh0zmvFUXHUgh4u95t3XP1WuCUL9uwZhFN+E1uvjaDJtj4UZhj8hawwDaWn5M3pnjJqixLnk2Ed
 Z53VBKnWNw2bwd+ijYLyO23q5cYsMrvbHbyFWaDpf6/NgTCPurTGdXeZeaRjmaWzYPD/lKYyqVs
 rbNIfoepfNcSZTtjyCuWetdxj9EYuPGvftefia9l5QsjFCOVyo87v9PgS6EwyOTjzNZByEXzcYU
 /BoS/xFDHdQ/+KafK6VuN+/GKR3+/AFjJp74Qn+oMy8XyId0Pq7nY+LrN/K+0I4fvPYhWbkiVRZ
 xM3SNfDEtqeELxMYotoE5omrP0JDEP55XcNHJOXiFxWxn5O87ppZEGt7HWl3s9Pzfg3UUxzcB1q
 wXNcOwLiUx7oCzjhgLQgaeM0uInc0hYHUMi+YDZ9JeDTNRYvKl0l/sH5YsJQdZDvPnBrDWy5D6P
 EadqC5zxvb3YDACDlcw==
X-Proofpoint-ORIG-GUID: KgtTJl95j5EJm9vgcN8MoUqhkzaQ-hQn
X-Authority-Analysis: v=2.4 cv=AfwkjHXG c=1 sm=1 tr=0 ts=6aa3c1f5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=XtAJtvJZskthm95za0cA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110123
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

On 9/13/25 9:19 PM, David Heidelberg wrote:
> These patches add support for Novatek NT35596S based JDI FHD panels.
> This panel is already used by mainlined Xiaomi Mi Mix 2S mobile phone.

Hello, are you going to be following up on this?

I noticed we've had the jdi,fhd-nt35596s compatible in the QC tree
for 3 years, without bindings and even without a driver..

It's producing DT warnings, so if this is not restarted, I'd like
to drop that node soon to quiesce them, with of course proper
reintroduction being more than welcome.

Konrad
