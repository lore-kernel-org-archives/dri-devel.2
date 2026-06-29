Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E202C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8844610E780;
	Mon, 29 Jun 2026 08:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5v1Oid/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BaZ6N9nc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B79810E780
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:47:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6s3mF2103885
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=; b=S5v1Oid/YK8zkt6J
 2ItjNKJhX4moBJ+xFFnUfRz7spo1b7QPzxRTMwHqM6TOXp7IZl9+etshzKHNQ2rz
 i8xUonlPASvKY+E0gX+DsEkgdmdjL8iV4rAzMh/hFyB88f+QRqDRE/LLHLRQlLi9
 IpQcxAeTgjRc+k5mu42tticXPsqjKzVTtE8BYoA6yky3gI5xFv+Cqj6pu1r+A+gk
 rAnUY3QSJEYk4vDJnN8Jarv0mR/jFbeb4re3zvxWlJQ7g2jMik0hamPAGO168iyi
 ypMG0IKeeleScoOwHOtgelvOflQSlXJE5WE+2ubIBIOFSEzNDKahIp5iVb9gTuvB
 maH2kA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cnf0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:47:00 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-969471b1265so22371241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782722820; x=1783327620;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=;
 b=BaZ6N9ncNIOnyQ09I+u4rr1Pq155WTK+zPbGwYDbouUISJ6J2Q9UCs/7HiM7mytbYV
 ToK9gypc3NnK7C/MFD1gdwqA/6tskzaGa+jsuuLZloNwouGrYd2moMKR/50vMBfvLjNT
 SHQhvEBXes+7NOFxJCczMg9gj16PLw25I+BWNgi1g1dAwZhNL0T8n3hs162HqhUTxqOM
 Nr82EJThTddWtiOevBbv2lRuks4TE/6H0rzi6TyZNqRCFw1+2U/dRsVidnkJTMhwI/a+
 n5fPVB1UVu9PxoZw4rAL2jsWtSSgsiawwxGsLfumZ4Hu50YJBGz0HK6RGCkTWSmPTtl8
 Hm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722820; x=1783327620;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=;
 b=O29xY32HXTd0FXUsnEDRc4BQr4RTjPZpZWimLKLG6DezBvFeiWD0FqPh6ODF9ICLP0
 hb4HWu5jMBh5yYrPBwA7CcuJVW24iay3cTYKoSEY+nWs/Kh1oW9t5eXunwhGaoqAC0Ku
 jtoAQZ11xpBBofcLYkBQWzSjNiwKjO5H+1jKNqJ2eoND97ImrXS9FRH7wjtGw2VYa72H
 kD8yv2r1JVd7h+YYxKEG7/hfXhpfY6rfMSAj5v5bA5fv9nuor2OkYHDqojMBvIbnvIMe
 Z9b1f7/ohY8qZ0HOVcBrYuEmDrQhFBNkplenmi9MwqrBqXu5JlRz1jW1weRrSL/0PC/9
 Kz3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIJkqrZn1RSyj17tEf1nU5kRfMJCxRYMFb6UT53D7zktjkwqKbTBGFO34+MtJ4D/ai3VHc88lTNzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk1TDf/AYw8rmcebk6VVBmgJi/MAA7K/XG/qljFhJd5irguM/V
 OGEc7tQaC+EtqtH/+pd0LRN2GkCYA+dpV69+q6XmnftasyBSzEqqT5UFEWoNuzskGkaxy8DmXiY
 y2a3MuP9pjifAmKsRupV0lQhPcLpjyGnsWI2VINdIzbCZEYN1EWoSPOL/O14DXN56jo8a/QQ=
X-Gm-Gg: AfdE7cknZQgP4SbvBW4Y1W/PbjLzBvRHZxb9drN6TjwgaPR6fE+BY7UExvJuhUYwBcf
 LnsFS2ijqYH01VxGJTJsxE17fcmOxc7onz9424u4g9LJpdegXlTLRnUOVGq+VhvT3ekNSFtpmEa
 Nfo+4NsydlvhCs+gyQ1ENjMFQ8qorn0pNTjnTfNOL6fpKsycJWhPxdzFLyFYtQFA7xDoRTz12Ud
 QngzKDY6u5mpMB+NJVFQoOYpldbL67HrOt9rfVkHM/Ns7GfMy40sr3esiXZ7OPnXPIJ4isvjcFP
 AMrGjI6JO6jyxyEzEK9Hpi2wNsFQXBgOvCDMuzZr2BIID1jAbILHHHuKuBRjuslxnLp6qaYRCox
 IS2ZoNvmvrNTHKP6K357LsTrJWrS9hQvyz3w=
X-Received: by 2002:a05:6102:6c5:b0:738:4343:fba9 with SMTP id
 ada2fe7eead31-73843441853mr493672137.6.1782722819888; 
 Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
X-Received: by 2002:a05:6102:6c5:b0:738:4343:fba9 with SMTP id
 ada2fe7eead31-73843441853mr493642137.6.1782722819368; 
 Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-698481d0359sm3009277a12.30.2026.06.29.01.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:46:57 -0700 (PDT)
Message-ID: <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a423104 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CtAqrJV6yErwifH23rQA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfX2/9JDva4NCcX
 vD/iFA2iN9nlQny7wKw5xF4YAhxrhRxbLfs1Bk2+j0IcAKwp48wkGkm5DjRknbGWq6hwXh19WAV
 4mGtC9bNWdGKeaceeGXmXxRiZ9yD8YU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfXz6rFqaoXIZ0r
 2B+Vz9/Yun7x5QbUgAG+LuU9IUoZb6OMj4sygcjsJIRVuzvQVJ5urvCBPiGrMrntWtYWRoshJHN
 k+yzYnSm8gFWiDCdiUlywUpAdiHEw5dKpPnh5VBGlK5PaAHIB3TSi0MftTAt4xZlaYim5ZsY8J1
 Nn3wo0k/SG5Zz4sQXHIjDeY5v6omAaW7gP5vjIgKhk9cWkfpiSutY+O+ZMTufZ2IQVNubtNt0RJ
 vBIVs+HsEaD2VDOb1UrvZ8m5m1Qn16qUcTgAB+69omOSXG3wOQmVJCI9sL865sGKkHaoNZljDbt
 Y7tR8KhdosTLF72lgjXA/mAbBbRhOsIoADVhMSrXjqgE4UybGpMehVk23fvN3xCBzz5K8GkxAfa
 kbQF8JNxj9/DhJSsUocvLC0byxrSBPmwycFlx6GHXNvWNZeCtK+Q/0dfEUSSyQNwAt+zJw2/RXX
 yr1p77aH+AVJBlfzYsA==
X-Proofpoint-GUID: j1hNp34t19-AT9e1U5Z3eK0rzpcA9QAx
X-Proofpoint-ORIG-GUID: j1hNp34t19-AT9e1U5Z3eK0rzpcA9QAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290069
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

On 6/28/26 8:23 PM, Akhil P Oommen wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Drop the sign-offs that don't apply (presumably applied as part
of shuffling around the handlers of the patch in the in-flight
tree OR missing c-d-b)

> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
