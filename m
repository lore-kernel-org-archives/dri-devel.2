Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB36F1061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040DA10E6FD;
	Mon, 30 Mar 2026 20:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0YVxLlI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8XF8Uar";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E3810E468
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:51:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UEgMir3721896
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sfLWO/i4ybjt5OEVNLgyO1zG5HeDMlwhQfu+dIrpgQs=; b=H0YVxLlIZhalDLI7
 +PVzCeglPvO08oei1dttOUwMVHZ/xsbwosto09vS5VFZTGsb0n7u7nYBvh3uWbWn
 cyGCGxLuHaPaq8L9a7koNh0bRvI+s2fwscx36UfXqVGQ8v6626ktcv8VIJAqWa68
 JMlN6f/zNxeHZuUCb+bUTNAlVXZnyIdM/nl2gEEQY9Dh5cTZV7MISMAs8M6yVovP
 AiXbJzJnkuQj9WPi+mI8nm6ZHWB5HPanAKmGTGEHdb6qVpT0iNqm2d3smB62fNpg
 zb5wzlJhosFaeBPYJcK6mzV/3RjSTd64D+065sDtZZux0uveqPmKZjw0icLp38WQ
 O51nhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmthde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:51:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2497cc190so15785415ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774903895; x=1775508695;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfLWO/i4ybjt5OEVNLgyO1zG5HeDMlwhQfu+dIrpgQs=;
 b=E8XF8UarzVRRevboIBNnHT30dLiALyq/8s33vx3+pDM+AItlPtrZBSwmhLdKgGtnPx
 oFsUNqO8H4ePmD37Y6EJEaGyR7ZQkivQ3k6gFFcFEJLf95noZBiC4/9jn/fERXAvFgoG
 e87k8YWUmfgQlTTkQr6SN0gHTxXBlMFn/QD1jWC0awY9CxGzwYfsqYmlpHTJue3ZVacc
 nkfWWw2Wetc/0PCQ6dZ/UV5n20kjf3OGDxsTmEPccLKKFS207DNuA0A5OdK54aBZUl7k
 /RPvid1mjGrOLpF/FQ0ZrqmI968bkxSwBoECTqkO0xorwxe+zRbeSbR/29Rr6tv55eXt
 IoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903895; x=1775508695;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sfLWO/i4ybjt5OEVNLgyO1zG5HeDMlwhQfu+dIrpgQs=;
 b=imQLKj3MgOwK595vMUT+pCpfN8/DFXmY/0gUDDFHxa6iP5oZllUSMop4W8bmuv5WYC
 JEK/n4+pn1uGCtOSJjMHaEdDCNvrknMFPxIXSGxzKUr/rl34EYFasDN+dzS83ybMy3jW
 E3KfXqcU8JEUypetpBBxlomusP/c9LOMsZqdVrbOM1qUoCvYN5aGEFMTv0vyVcS/ofJG
 h1kXtwtw9hEyeZFzW30Cj/MnSq7DYzf+m4AOmp6i/brfOtHUEltddu4Y2AS3UVFqUEnD
 XhSjzOeI4da9HuQ5a0ENHQc8SujlPmjJSzLhP8ibJfehI3sjvdvr+22dJEQdE4nSQKxD
 FT2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeJUqY2SYkoFwpxS8PP0SybgKX8YswyI74rRGttU08yLYh6bcAjFQZb4hms6CL5td3cl+j3Xiq898=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSGJWr1pQB7n+RBaDKMIevVvTg+PbHMDODoDzVLK39mFMOxJ+v
 AVCErfLAjYSH6lQREpTMpOJgSyRE9BrFE0AgoLyGT5OcAxZWgAguZibP4b84qrxKj2vRLVHl42G
 15KwS3eXT85g73tYTAeTvlrz6k7lj0hWJPjUaxeWePR+GJR0xrU6QDXXglT1iIYAFu8EJFOY=
X-Gm-Gg: ATEYQzylz4awm6gHf3CMm188GTU9ls8h/hRl6mO8KnV55UL8F2NN/ka0zj8HZepxDca
 AZnPXO3Hyb5Fkf9SqljjrBWQeKtd1Au3dYYSSTebENPW+mYyzTDMpJoDJDgFfSrEqihF/wrugHI
 xCX4wiexuxhup/Jrv5VDqaDnv7+H6EQ471UoVBYn/A1paiLi7wDjwq/H/jNhw848X4hk1n0ricE
 Jef4fahqcqgPJd35iPF5E3BVy8Nws08hf3KHxSzaD4UMPCuW/QBx9jxQ+t9nCfuEX+xhkfgoIQl
 DBHpe948gFo7rQJCHBdbyYZCJTgmx4UC8DEc4Lg7zxnuFYM3iccDJYZPCL5s9+rlV3TrdI/QrYd
 GjWdxOhW5srCITCJ54TqvzO9D3QElLVaC4C8DBIUq7RQ6
X-Received: by 2002:a17:903:1a2e:b0:2b2:3eec:c75b with SMTP id
 d9443c01a7336-2b25ee90436mr7881005ad.2.1774903895447; 
 Mon, 30 Mar 2026 13:51:35 -0700 (PDT)
X-Received: by 2002:a17:903:1a2e:b0:2b2:3eec:c75b with SMTP id
 d9443c01a7336-2b25ee90436mr7880855ad.2.1774903894992; 
 Mon, 30 Mar 2026 13:51:34 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24265a954sm92575545ad.18.2026.03.30.13.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:51:34 -0700 (PDT)
Message-ID: <6037882e-3716-47f9-9303-b448ab8fed79@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:21:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] drm/msm/a6xx: Switch to preemption safe AO
 counter
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-3-2b53c38d2101@oss.qualcomm.com>
 <2ddea137-bff2-4576-94ed-4f3a48aed386@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2ddea137-bff2-4576-94ed-4f3a48aed386@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KyOS1vIo-8NdD48SsmtOifXawfIzmuGD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NiBTYWx0ZWRfX2gzid9tmxcqY
 JoHYZSlIcHRDVWmQ+a2/vkLrEAhW5rJmRlX+4i4i/omWr+EU+XpgPxuOjgaiBZClMkJH0ZAghu/
 iwEvsmviRP5cIxyEPrjVoQEwpqkZfJlr2Dz9UHzmGbhWM2SR0tQREjokPGxjG6ZtxwshyV6Y2bo
 xZPwX6qlDkCC6dSsot9sN+YvRMj/Y5I6O61pB3ade5pJYPogCOjwav15CzvKdg9hzVlC1FRxqlI
 +4v3aoxUbXh8NnPXmEVqYHFVwmd1SjNNXmawGg5CaJGwClIG6N7HogdFSM83nwLIkHpNXhbSqHZ
 pc/QLCpMufZd168RHamI1YEDWYTcKncOZQwc/FEqVzv68kW3h6mDuJWpsEpja7ZDFGFsGfKEGpH
 463BCJxZREYgr00UNhz3v8QmjI8VXuhp4F0Pv5UH7ppDnvKP8BcdIuwFTHsT0r8iuE2SPqff9fo
 GZmAx/dJ5E3X3SikQIw==
X-Proofpoint-ORIG-GUID: KyOS1vIo-8NdD48SsmtOifXawfIzmuGD
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69cae258 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Y7Gn0S8KdB2wQIMvTzwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300176
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

On 3/27/2026 5:02 PM, Konrad Dybcio wrote:
> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
>> provide accurate data about the 'submit' when preemption is enabled.
>> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
>>
>> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> (this is not a blocking comment)
> 
> would the _COUNTER counter be useful to keep for any other purpose?

That is actually a good question. I was fixated on the fdinfo aspect
that I missed that this is used in the submit_retire trace too. In the
trace, I think it is preferable to use the _COUNTER (or keep both) so
that we can visualize the order in which GPU processed the submits.

Rob, what do you think? If required we can drop this patch from this
series. Or I can send a fix up as this affect only the ftrace.

-Akhil.

> 
> Konrad

