Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53737606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyvWj+ot;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dxTZMGI9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F3E1129F8;
	Fri, 23 Oct 2026 08:13:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3381129F8
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:12:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F9Ze2067825
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=; b=eyvWj+otLQ0BXr1c
 5P4DKyOze42qntnvS0GIzRTMcrX2YMQcsvWL4X9TisOmvnlnSgnL/jGkiGrhZGB/
 JM4nCAMccp3ipJsz0sPhTehZi1lstygdrYT0d9g0Z5B/gi+EmIN6ynR9rYIdJQvj
 lKgAuES/X0d+AeS1N4UDPko66iKbUghw1jHtZ9EFSdNSfBsFk2A4Qo+qMDgWuklb
 ltwcxdfe1hf8V0ImNLcu44VH2Iffni5PZ8YCf3QzPrGJ5Hn6PLtYNkOw5RzzeWTi
 M8sZTKvIQXiE6IGIzWyymKcwpKKR0gTp0gZEfqk21r0KQt2qKZ5WNx0DtmkMiZLH
 +ZMINw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw35xk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:12:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a01ea9e318so972303b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743176; x=1793347976;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=;
 b=dxTZMGI9ylbuc5p/w/CcTn/sqgtsTCcmiu001TIzjWTZjmC0PysRNPZQJgUnsO0PP8
 M6lm5wOble1yGxXOAY5MJIu/ZrQS7YOB98b/rjDP5J2d8VfQyNMh5XCp/s+PPiEdt63w
 Doh1ldSeTJDyft71LOiqiFbHDVrFfkbJCB6c4ZiPosDEve8M4TO2OoNOr97+PPlc5Pvt
 ggf6No0YNmV7IpxjUia4Lt62T6l23AlJqiYdgfjOVYaO3bQnmKlYajFmuqPI6eIrCarH
 c2SGevYzKhj8+O7y96kBda7R11EmSrgoR/unE/KE0BLHHFzyVKR7HeEfTH0dRb00V82s
 CH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743176; x=1793347976;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=;
 b=cW8UDffHp2PJmSh2kCrMqLvT75PXLeMzY0SWLdYYHtsP8sRBXya5aV71qNMNy19/9+
 FjELEWkQQij3UwuTGsevLOMzIzVRjoVPdeYIb9maNLSLuQxLZCuLTkONl1UvYzhFe8dP
 MWLLgN5fShT9pw5Ak3hbqu2R+ribdmmj+uLWWeH6dOP6KGtUo99jjJCRAVvGe1Rk0Azm
 0PnGkporNsvBt1HJUo8h9z6DZnnHWIUEY2wkoOB5Y3S8GUOG+jzAtCCCb5FXuOzTInxZ
 739pAK7akGOmreYid/ATprQguqUdRdVgsnDtcN9CwGEWILQTptWmQrwwpxAo/CLFFaVT
 QdRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp5YSnBzgfCrSabuU2uCdVKHl5+68XLxiTeq2818/WFtEEiGZDG8KnlwtaV27n5kzvbEMAXytNKxU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMYcGLNUt5kmrNoxkOMJcdNGC8TD/q1Fux6FwqhPUUbTkwFy/L
 iVnxxvkOC7Y8Aaz8JsZ3D8uvTg4Sqsso4XJruF59od8LNqzOiw2vSVQEp0BYaqPq3Fh193HQTqx
 yZB33Qcporkc/NcMJxXidnyaNTQ/eQa42bFGGs5BULNzvFL4B4AObIhp0dDRCmGqxro9YNq4=
X-Gm-Gg: AYBFou1FHrIyuVVj+03rbOntyr6DZkunrDdLXkxfqK38mykdr0T0uaUvPx8RaD7owCG
 SYIZdyT8LdM8+aSmpvsNn/ee8rWLCXdb6ITUpf2YYkjeebi1Sa7jn/R0d9xu4DOmZvEqFREEuvZ
 dUjRlowdmr9xIZQJrpt9NkLzpZd2TyITNut0y7mbab4aRFokyrg/SiVx5jTFYprc/GY/8vrlCaN
 JCEeh0OvnVHh4BRt3Jgk8KC3LXO37R6+v26Vc/nefdgXP73n+utCLVxE5suXoM8x6rwFGAlZlaC
 mEigkMaTfFug4DFqSHu3fflYbFbJm7reqkFHW8M29hA8B08jMz7tXG/Ta3gpls0jHXfZhpaWdM8
 i+447a754AKNfzYPnSVtlJOSGU6jZjJbpog==
X-Received: by 2002:a05:6a00:2d91:b0:8a0:21b2:7c7d with SMTP id
 d2e1a72fcca58-8a2c472056fmr1403999b3a.0.1792743175973; 
 Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d91:b0:8a0:21b2:7c7d with SMTP id
 d2e1a72fcca58-8a2c472056fmr1403965b3a.0.1792743175484; 
 Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c797b685sm455376b3a.1.2026.10.23.01.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:42:43 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
Content-Language: en-US
In-Reply-To: <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lvfiBbCeWnnCgo9mnkfe3yFL3isyu0AG
X-Proofpoint-ORIG-GUID: lvfiBbCeWnnCgo9mnkfe3yFL3isyu0AG
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1708 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=eWRtYoRFSfl0Epy3KhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX3XoDpGLgIOoY
 U+019IuJjLFn4So0zQICCtOY12cZ6mvx7vtn37bQSHcokCVLsE4BKMo7XrSF+YUiPC0cvqnYmc0
 lqIt1JA8uI2uBFDXeLi9C3IqYGz684M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX6OaApuQj5TEq
 f4awqbeRE4v10muxDlvT9cCGxi3bhW6wziPR16aq8FFRN1/mI/jJx14sxTfFjPC2TI4y7sUEmzc
 gMLqLBbzmXT54RmacbsFen2+26OuMfnupO2erxPmxpyudWSJEdS6RME0d8vf523x6mzllCMTEqT
 MXlqLQby7ssRCgJdZb+FG3LowLC+ZObwiEhH6kkLe75Ef+ynV/fu0/5NtcTfBRHMhLr5vZlqiLR
 x7+zSdOCGdHx//3VGlPZD4JWVAINEHKuzOQ9Qo/cHaL9n0ohrYIQHk/N0YEQuQaYFfED4i8wif1
 9YrHptPItvjJu0D7BPyMP6OVRHGJjpmGGirH4Ooe7C5wllP9kChBZ35VUC65W6tR4WNkZfBecE8
 339Fll8DtN0nqQILQaoQ/x/ZsGzjGgYpOLoUNHO5/Kg74ejKb+B9DByEHDMPEccTDt158UcgHo+
 tIbdzNHipUNDA11LnKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> On 15/10/2026 09:38, Jayant Shekhar wrote:
>> The DCP firmware exposes display resources through capabilities rather than
>> through host-visible display registers. The MSM DRM backend therefore needs
>> to build its KMS objects from the firmware capabilities and device-tree
>> display graph.
>>
>> Complete DCP KMS registration, including power and IOMMU integration,
>> capability handling, display-graph parsing, and creation of DRM planes,
>> CRTCs, encoders, bridges, and connectors.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
>
> Your tag is the last one.

Sure, but I notice there are checkpatch errors, should we keep this or 
remove?

   ● env: :3: WARNING: Non-standard signature: Assisted-by:
   ● env: :3: ERROR: Unrecognized email address: 'LLM'

> Best regards,
> Krzysztof
