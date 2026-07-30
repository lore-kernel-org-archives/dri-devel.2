Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50A2C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE94C10EF24;
	Thu, 30 Jul 2026 14:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIz+yc2X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKdRm/zA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA5C10E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:00:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDFcJ1372963
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=; b=UIz+yc2X1jEWPTdy
 WwXtE1QE92TeVS/mdHfvjN1HOxbYI5AssW4CqRojNV+GVWWcAnYIrTEMecbvK6Jb
 fFgdCdLu2kyJ8aZU6AhZEUrfqR8Vvqmw681XXVd+zR9YEu94Z6wQAK0YHJMYjgv/
 N6HPqlAfX4h+YoiRD/J2AyvnohJFzMYurtcWM8zIxCiU3pKWE13PGOgVFc2G9Tsi
 BqWBp5xJrtCIOXCg7DmAbGDCvp/CKVFAoNscQJ/NMblywndCwTwCu4FS0JYp9seL
 Za9QOZ0URQML8NPSoTxKKXLyV9uP1UnnUkfHrekEnNGCXGZOPjbnMg5E9i89VKdW
 TCqwiw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr70bg9fk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:59:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1e777a15so3611041cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785419994; x=1786024794;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=;
 b=LKdRm/zAdej3ASX4fiMrYtaP8lnx7PB0iWQLKtn9hJc9lqFy9lzQrFwVRmV3eZc1JU
 NzxPGlIINa6nYp+SrY0EuiOM2xIra8PkpI4Rh51juiFJ2AIVTUX1jpwY6fq5RTfLRP0w
 xIsTvK+u4rglMyOmDJBQth0sprpxYqJZ2/JM4/a8E/+h36ut7L8GoWZAWVQbNMUt3nka
 QQssL7fK53Fjt1R18391OUbh1iSRFA8PohDyMHEqVYDfdnRvUWDMi1nl0tfVKoZOU33v
 TjIbHhSpVvR/U41zuzAPGuhl/9IrkD/Q5ybuoe5rHZU1WFQTSk+yMAonw1VbxwlZmKmh
 Ft0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419994; x=1786024794;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=;
 b=N4cMjGodhBXc9PPtmGtgZCepAzFVj36S/1tMXAa/tx3Uxi5us1jlAtlVarE4KMbH6g
 03LwbAYhIOUWa/nwha3EN521rsNlvAx9R4OiW2c3eQjVpwmi8j3IUXdhFy55afFAppys
 MKKC7XTNnc6zIxVjjsmSiT05xi5gNZZPsAGubdpJwkUQnOeKVZzovuGdNGOA+drGaOU9
 b1wg6+U12mWRTY7dhNooygglCvTcIiydYWmwHrJQ03IfCj7Yxmf8g7XLa9L1mqZBkAjm
 BitlR1SL+dXzbqqPFtZwYH2PDNwv1weYAvMQo8J8J6BTQzPrmjcljGVfSQuBd7KxrTKN
 iG1A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rofq5nM6N8mqP91g+t7sQKkp17EKHB/AXoQxWeQ53xpNld4BjBpfVYV3lU1LF8wWWtxoMl1Frv2+xE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLjzQyZVcU8rWrf8tVaJ8Urw1s3HKnuhUBa+7kC//Q1dy147+O
 fomFzxFCEDvIk6c9LCg9XIIxG8AxPdDDOox1nvV0cBmayTKcalLCWTLGBQFpPYToV1o6Kvnc6j2
 qX34v/aSNiKyfsm7K3SiQAXbPs3NzCJYtpCPKfruuNaveR8aikC5imQsRFI+FgN+HmgtrBttSg3
 DpRdg=
X-Gm-Gg: AR+sD13nQHcne2QSB28FbuufwIxTPtVZCFK5guScoMIEb78svHE4zGV9qkBWAgi8Bli
 tRtVRzX4N0iaoVG4kMhnrajW7mD/j0AubrJ4DskvrhWb9Doz/6BVCYV/v3qyF8XKFGUheu9/WBn
 YcEFDtgX3UAxcuPn3BIUoqjUs9Bt2wSx+mROo0lsEeMTFb0Ea3JepuXKNQIgs6WECcSRBSMJ69r
 T3671WSCV5IGSZguyGGRPfv31fEd7HDItk1BtcjyEmPNjB2PoIrQ0nKUqU5wdOTgTuacoYd3wJB
 JduqkYvfphbjoq6wRGRCjk/nSN3w44Ev3X2BYlPWLekVKw9DH962XR4wsUL+OdGKJULCmFvgBDy
 C9jkpWWQA1IaU3P791tCkEQB9
X-Received: by 2002:a05:622a:a990:10b0:50f:b9a6:82ae with SMTP id
 d75a77b69052e-52b42b4deb6mr3958231cf.2.1785419994080; 
 Thu, 30 Jul 2026 06:59:54 -0700 (PDT)
X-Received: by 2002:a05:622a:a990:10b0:50f:b9a6:82ae with SMTP id
 d75a77b69052e-52b42b4deb6mr3957631cf.2.1785419993517; 
 Thu, 30 Jul 2026 06:59:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8576a3dsm71944066b.14.2026.07.30.06.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:59:52 -0700 (PDT)
Message-ID: <9d43109a-6c4a-4339-bf8f-de3aae6e25a6@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
 <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
 <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfXyplhC6fdHN9e
 AvrbgUmRUiQTxKgLH9IkI6hCEegDMCFzc1Zdtrm14KaNlP3ve9kZfMYyjvJ8rqDZKsPG5V+Adp4
 73rZXhb3wbj2PnRyaFxkUfTYgo4SnqJjF+nGnWLxP6uGuGUvFStogByyM0CDwSIoft2unt/2G4L
 ADIMaDUfL2lGeQqNmadCyKeFat2ppP4dfeuUHqcVqsBjMCB10ljD4WOuHKxQlGzwNVsHJhvkSf6
 w5+WHXq9p05li+aMGHyYQ4sfUa1ySCaosE75AWxRaUvXGiyVwyCCPNnvvUwNzmrwNWYHbVnsdEh
 vhNhVrbCwapmXnSjIradptR/OE7VgWN2lArxIT0IwiK3bnjSmnfXw0jhCfAeyFhvhlTM9KEYqOj
 ieOgPAl8nLqQKbUPTxoMZUODcehc8bvV3bzskMt3g0j+VRsEcdgyx3PMb3bjV6oREkOLEfnuVY3
 AIR75F/5SyjWJhjl7xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfXwxso1/wwfUv9
 Kh2wpXYaA+bwMWkkyQ94UarZyVpu9I/9NT73+GW3uiwvVE/9WomdZ7ssz4Ilo+3xxMwmdTugxnk
 ZMdhV8wOXrrv1Bk+Wx10Hfe/rffRCOc=
X-Proofpoint-GUID: iHqioG4yssBwL8imw8MsRseYPvlO9QL1
X-Proofpoint-ORIG-GUID: iHqioG4yssBwL8imw8MsRseYPvlO9QL1
X-Authority-Analysis: v=2.4 cv=P58KQCAu c=1 sm=1 tr=0 ts=6a6b58df cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FAOltU6waKXSbT9yybQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300106
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

On 7/30/26 3:58 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 30, 2026 at 03:42:58PM +0200, Konrad Dybcio wrote:
>> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
>>> On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
>>> dma_iommu_mapping for every IOMMU-backed device and attaches its domain
>>> to the device's IOMMU group. That domain is neither the group's default
>>> nor its blocking domain, so when msm_iommu_new() later attaches the
>>> domain the driver manages itself, __iommu_attach_group() refuses it:
>>
>> [...]
>>
>>> +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
>>> +#include <asm/dma-iommu.h>
>>> +#else
>>> +#define arm_iommu_detach_device(...)	({ })
>>> +#define arm_iommu_release_mapping(...)	({ })
>>> +#define to_dma_iommu_mapping(dev)	NULL
>>> +#endif
>>
>> I see this is prior art, but should we support this config being off?
> 
> Yes. For example, on arm64.

Right

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
