Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6A2CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB94310E47C;
	Mon, 12 Oct 2026 12:22:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DB510F071
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxvZr800778
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hECoQTtFgcbzntzMlESUYXkqjFtu05/x0Nrt7fkTe8E=; b=IbZ1q9nuM/uTauEk
 r7fMu0btngo/AKavyz3ACWH8s6lpHplhRlzRmqOqbXf6ddkoQHCLLOIucyLxUCU6
 6NZT54czZXKtaifAD2QlmPFmzTDbzPnqIRIe0UB2xxWtQLDvfNAAMsMwYKRZTajK
 Qks7gRYtYZatVUYwxuMqlDj2IwLM3keaGyjH+xPyzzJTBmBCQNNG8gvGpjZjtOI4
 +VVsPFNEOcjxUS013SeWd20jLwmGzGv0QENLRTBIymZzRo2Qg4bLRpmlKKqV0/Nm
 4invtMb+Hyb4tkJ/18xKxhTMRdCpJg35qnDnLj5ZMyoZw4VGfmb8r7BKJHQhUyRe
 CzRimg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcrmhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9179ef12a03so7588176d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807715; x=1792412515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hECoQTtFgcbzntzMlESUYXkqjFtu05/x0Nrt7fkTe8E=;
 b=YFC8ftKk8wVTGyJ+PvRCx307p9e/+wCZmQUl3OdWxoVIf63zW1LastW1040qXpOtEH
 EM6M6LyBpQUfosEY63GOR/wx9pDHiC2HyB3O1lABzdQtrmXSKrUdwKmDu7LPa9QUQ+n2
 ho0nmF3yTiI0H9Mr49ng6kOYMbsDlMEmUUTGLqfNADFwMqtfCt6gJNl/rkd3Bq71SE/h
 HNMMAsw63I4ln58mGOU/LYsS8pqrnrRjgJPGC9jq1Me7UNBRUsB9OmAwbUAAdUO1DSwk
 zTp8O+bZ0hbQRjtgMxxEsXfOxyjl32ecL+wTaF9FYU9HwIdqAl3qqxBnyixmF+4YNH7H
 cCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807715; x=1792412515;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hECoQTtFgcbzntzMlESUYXkqjFtu05/x0Nrt7fkTe8E=;
 b=j296nV7yRFsBneEtjVRH21ue2Wpbyy+IeT3rMlkoBnwchnwySE+pwljmLpf41FinMl
 zAeGciwum+dY7vuqXWoIyL+rjvOvRqAnBIFQ9YCFQgcPCsyq8RN/agdp53/Zh0whPUDT
 du4yCU+XMCdPAGyOOedc6xXNOHz2Xz9oCjl3UXmQykm1riVOZiFLs/m2qp2fCV23+HZG
 iiIiATdjdT7cw+2EoO7xSQ+PzAI66q4e8X1PxQFk1AAf3kjvpW3kkjid2ZZwIc5xT+9o
 WayKLH3zCzj3z+SWc4GcYplld0QQOia1EHUwH+/bMJO2aKw+HOHeSRHYQld4m/iqqqld
 WcVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1a/MtcXsNbO5kMfQ0ZOJ88kBhVvAva+ZN0DcphwLvz12G4NmJnhadAkWLjSsMrqCycEdk4N9m59g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLHQDYxck+N4AhkokvpszqWaNMoDU+OUwE8g/3ovlH1VvABeGv
 Ri3OUdFiB5mJStjLufzqt9tO07eATYTfqqYeWmLV3b1Zfus6C7nghNrwjNa+a5He+FI2rb2lkqK
 tcN/5+43ZzrIsSQGjBYjObVkmBVZwx7ns3SJ53kUXxPufixURTg2orIPky+xwbJ5QGhgCRrU=
X-Gm-Gg: AYBFou3HYVWbKtxkNIItcyRcsL1VF/w2h932Y12A37Vk/ZN7H4AgPOoP7dC15bgQGTY
 Er+kKCLA4LK4lp1VKr3VzFpOrrNN4j2z7td4sgUMLxvedbPeTrVag5TBJAhPD/E6XwqcgCf6mEF
 PUVrvOsR12+A66fEPz7Ipc34V8PY/N8pCOXEvFg1djAVP3OzsWMlj+Hg2pF2PkOowdjWRCwOQl7
 rL3nme4LY/Hfne8rgiLMq/a2CRROKbxjwbUeweXewtOQYGgl9B1NsegfM+mBIQgCE6X0gLVcgMG
 FMsygt8weVjhzcfUF6ubaYGt+7jSaySYy2+Uq50CKvssh278Q3XAa1fNFje5jD2cmzEi/nnXKKi
 EaRmvQvzV+GSyUaobZht5Mw==
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93ebd27cc8fmr1762719685a.6.1791807715535; 
 Mon, 12 Oct 2026 05:21:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93ebd27cc8fmr1762712285a.6.1791807714903; 
 Mon, 12 Oct 2026 05:21:54 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9aa8511sm457033166b.59.2026.10.12.05.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 05:21:54 -0700 (PDT)
Message-ID: <0fe6b4f6-e510-4fcc-b1a8-785438fac3e4@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-1-a06a6c57bde7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-1-a06a6c57bde7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2zK1E0QK26J9P1FCVO3oknCWaVSBBb3y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX9ZAq/zbQCx2t
 wr0TAxBpEHZ1lDAZdHUisy7NVeF2V8SpCjzjvynnN/m+2U+ASckEOKN8om6r3al0gD3HGDtFZ8z
 zCE0JQuF8YniZRoH8CKdGEkSgS1+rHM=
X-Proofpoint-ORIG-GUID: 2zK1E0QK26J9P1FCVO3oknCWaVSBBb3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX8pXFXm1KpyZ1
 GV7pPan7we02Ni0eSgo2JFX2lz4YArbEtg45Q8iSAIB5WYnqSLYxvnsUplovU+ULH1Ge1rzLqSv
 /8hjt8hsXNyayGiunIQSip2o6VrqoRRKdvmUoswYGG9+tWvOzqtavVWFWSDT4SyyZV+VrHlMldG
 Rt1qqR6HcVXlUpBItQd6QDNKYLAKpmseM5ETIo1ZbtJdkWWux/OkTOitTrr0UR1nTnUCF1NcqFb
 SiiaU8N65WPLedav5efNprdJ726JzKZXI3zcAD+YEGIAW6WvxgLTnOdHcEn2yD0dKytCCgalDyE
 yWm0jSRE42ABUcN9KqKJzC6hicOqw/EUMFIqig2K6NbqI7UD+2bS1BJT223dNL5aCgyEsT8XZCn
 lecUWfzFfCK1FnHgQf+Meji4mRTBvA5/mgf1ggRvGJUNf8q8ftQOyOTJanrcZG6wAx/Jn5Dl04p
 8L7yKbq/Ih6kCBzv3Qw==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6accd0e4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pu-9y4Hw9t6J8xIMaM0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On 10/8/26 11:06 PM, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
> the A7xx Gen3 family. It is derived from A750 and shares the same
> IP-level configuration: protected registers, pwrup/IFPC register lists,
> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
> record size. The differences visible to the KMD are the chip id
> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
> firmware.
> 
> The Nord primary GPU is the same as A750 but has a different chip id,
> so it needs its own catalog entry. Add a new catalog entry for this
> GPU and an adreno_is_a753() helper. HW clock gating is not working at
> the moment, so it is kept disabled for now.

Do we know the reason? It seems that no other platform has this issue

Konrad
