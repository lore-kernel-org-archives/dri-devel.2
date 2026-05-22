Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C93CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3B710F54B;
	Fri, 22 May 2026 11:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4wwpGjL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="afK5+4ru";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A754910E155
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M92KOv3005120
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2tPpYvChL3EWA1u+ZY08kAo16G7ygyNesByzCgdPUwc=; b=Y4wwpGjL4+3LkpmO
 y9/qwytBOw+X4WEXAnI3uN9NlAyn/MMEhV3enwEG1xASAouyaJkxH5so1Ze1kJLI
 8xd6cpm7bXyD1nkTgMmG4FwqrgjHxLjVTByr1vaPrPo+0uqH+xM9pY9tIqtALiW9
 AigD5k/xAP6j6Slt48+EustPvbvUguXkr5H5TpcxK2dYG/qjwA8SFBkOxGk5ERuQ
 BUU0fTd+/naSRs8HTbVApM2Y/wCLQRHPc9YR+94cnUHeCndX6RAzIB7qAH+ZMLXm
 c40ff65YuW8d9GRZfYPvi3G2yB0Bjr+Y6GSq7hzZTz3SMeAVVTVumYfgnDlkoitz
 XT+UMA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt9rft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb39de5c54so172922185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449620; x=1780054420;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tPpYvChL3EWA1u+ZY08kAo16G7ygyNesByzCgdPUwc=;
 b=afK5+4ruBwJU5phGKFFgiAiQWbrIhRuWED09XObDZZWjJtSnscv1moafLScbJWDGUj
 dN5Ac6mDwi1KDUQRftOqVpcaIuxxKUyyMdh4H9LXzFYGeFMX8snSZY0Y2YC345d5iwy0
 cyAVHej2fkmBMF9KZtD7w4M2EhyfYchUtQKEbDVZAoK2X+8Dh7AsyeCBWwE1FXuZgGKM
 OZAf1rrY+DpK/0ZoeJW3JkBSwWtB8VAN9Ot9HxVosZyHaRz/6LEh87QCXp3HxtqxN5uQ
 zGR0P+2BuFHTEibOa6UqnOma/uo1GT2ZDPcWBK2QHhGEKUnLfj3N0/cD4Rf1p6zWwRMP
 R7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449620; x=1780054420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2tPpYvChL3EWA1u+ZY08kAo16G7ygyNesByzCgdPUwc=;
 b=EOfTu7Wn98nzREg037ZYxnKL5uUaGdRIorwZF9sqFI+V85VSLaZY0gR7zuybKGTkPx
 dooqSBzn4PmDf2NGAJcuEVu9lD6jSUuQSZ9cPloYmgahvESeeUSnyUsSYMe9YpWtSvzo
 eWVMTiRLh2UkGLr7eSQo571Of3pSpt2ygDwKV+Fub78Ab+C75OnmTGrjwgG3k9oW0d41
 0QmKkj94CMDUeCQOakTWO4ygL2wtz24tkbWEQdV6aK42jw0mcUQE6VhDzR60DDP85pyf
 jEkPEjJZn+QWRJZrgfHh4ZZ5exiodmdjxtRoCFrh/Z5KaLgsQKtfWpi07Ns2zWS5quPA
 XzYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FpaaHNIWsqJCFC3qh6wL086xQZzZTM/OkPHPx5NDomDkRHlS64PYvj2WAvzQx4yH2wn1mqZ3i2r8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIKeS+9smTfQYrzI1zTqK3nTHtfrpVHOLSBv3/woQQC0ZbKD4b
 CxJB0XnklvNPtv711tuoJciZubzNQCbjIvLo94BGeYDR22ALfxaNcvE3V/GvdI1rd+8B0AR3x+C
 BQTg0xh2TkzBE48cmXLPTu4608kfCqhth4NoPw2yF8NZdbeM++BkJlmKuno/8f+qj8s57Mc8=
X-Gm-Gg: Acq92OGn8bCMmMLUGf+kJIHPGUoCerYv4H2v7TUUYPwFX27s8YZ3yg9WAqWYZpwtZUu
 81rSKdqFPv/mapf9VwsgSfhB0pTmPtzeieHc1dN40h2vh5JPxaIbq6F5VB9tUu5D4xH6y8nB9Y3
 pk9Irf+cvuKuBqyzu0wt9uJU8axQwu+vDbzzoZuUebdIz45mgfrD6SZQRPKmqDjtFcRNk/XVgHP
 gOOEtlrXuKcTQG5Ojf5siZd7D5HvQ7q3yVatH/QSCOim7dIfr398FUUCyYQ9fqWpRP+pC6onVUm
 TUS9NpNNt20yiatbLUj0U5Y6697FVfftaSTDAnAJGG1KXuUP8cWnVm3tMYFSgkCnb4TGTLt3GyW
 SsBLIJfxv3DL5m0K4MdRyMD/A3Nym3lXZTCYnpsnE6HgPIA==
X-Received: by 2002:a05:620a:690f:b0:8f3:5b1d:ed86 with SMTP id
 af79cd13be357-914b4a59f89mr315524185a.8.1779449620211; 
 Fri, 22 May 2026 04:33:40 -0700 (PDT)
X-Received: by 2002:a05:620a:690f:b0:8f3:5b1d:ed86 with SMTP id
 af79cd13be357-914b4a59f89mr315521285a.8.1779449619725; 
 Fri, 22 May 2026 04:33:39 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9b6d334sm580222a12.2.2026.05.22.04.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:33:38 -0700 (PDT)
Message-ID: <32e8eb9b-b365-4123-841a-823e41c50235@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a103f15 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=UhmnXqIqSmzi-CRdO7cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX7OV4ADKgYHjB
 /QPOtj7VHeg3eFfnbTL6aMfNt/cF5lwVKD127kFLE4+YmqOcjQ9WT33l3E/1VsP2V7TBdvb9gGx
 yXgwWsW3H9AdP/FZFiPNdyAzbQVL1sM854W4dRUzlfn9PNwVVLD045h8R3UdO+m53P/74qblqOX
 Q6lY7u7XluJO2Y4bduOVfkT5wJLWSJUQLDynsZgIFvkMM/Fj6mQn1vwvEUqKobbmCivWV+cdpco
 z0uMrYiwzVP4+2f1FwEm77gSzIyj28qixCwNvNzsNtN5jm0Ot3ZbhPnGqtobqmGwuqOsH7JykD/
 OerXpQUyev7C/w6Y7cIvgUibdYdz9t8U4Tsgw+UviKqx/DI6cmCIl540Cwr1M1s5okt1RPmLRHt
 zlHfu5Z9QSew3pHkz3bc7gjbHeadfSy0nS80vNGrJtvmuftP61ZajHai002w6bgVzWv3PWhps5F
 UAM2noa+RRn4q5ZxKdA==
X-Proofpoint-GUID: cDoeFjTX5xuBdn9b-kMAwPvHB4txqKyh
X-Proofpoint-ORIG-GUID: cDoeFjTX5xuBdn9b-kMAwPvHB4txqKyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Currently, the DP link training is being done during HPD. Move
> link training to atomic_enable() in accordance with the atomic_enable()
> documentation.
> 
> Link disabling is already done in atomic_post_disable() (as part of the
> dp_ctrl_off_link_stream() helper).
> 
> Finally, call the plug/unplug handlers directly in hpd_notify() instead
> of queueing them in the event thread so that they aren't preempted by
> other events.

This part of the commit message seems to still not apply

Konrad
