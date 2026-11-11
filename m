Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C282606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E6ZtrJWS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z5ojkO7b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC23710F73A;
	Wed, 11 Nov 2026 07:14:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2BC10E999
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:14:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KVqG2021334
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=; b=E6ZtrJWS36NJglrd
 wrr1bpaV9Jd9mV9zd7xBCZYYEwwSNptUySacWLWhEtOics1GqNNZGOztM2ZpUOIK
 lsJ79vl+7z2qX3fM4jggXDLB9fin1eITfHQZ64UTV7ypRU9OKeO+7RVI76duUfm1
 uYBjm5xXKfiH8hn55EK8aO+XONk6UCcCKHIdeVmicDZysX1GbQ1kYILRRrb2PPIR
 33CqW2bWiaWFITu6A8Ve3eYH9i9aSTg6Zupi21eeaTG3lhCKhKdiHBsMTCpzic5Q
 oqRxqFCPKU3V5DRzDhPN0GfEeu5SR7eequFTx3qGGHRZ/N0IcQMMZdvFYhm3I2cI
 iWIFpg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pvbq18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:14:06 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so4706117c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794381246; x=1794986046;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=;
 b=Z5ojkO7buc3Snr14gk3MkKsLC1ZdcTsnNAcFLtbqLLtd88htvkaX9ScvKCZfdgB1G1
 PBgPGOb6zwVLnxie7Dz+Rh2f3UeaN20aejPu9UhGZOcn3nzQRXPlpOpFe0g3gV6n3CAl
 y98IpUAtK/G39VfMdlLFj33j8V6aGO/BVsYvdCjM43s0m6ZP8/TBJocLUSCoMt3jQ1C1
 YMFVue7ZxAf/cxC9h8HbRsmizbOA4CiqWyEVgiFW5q73LfNqnQhHVXp/xNgVq+ZJw0LO
 QTEPKHTL7ENu5WeOmKi8N15ZMlWQ1ZxaEtvxJAu4rq1qc2bhHyJiXMpYBmdchWyEZkdP
 a8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794381246; x=1794986046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=;
 b=kxDS15P9bsMn2M2qmOCaD5eMlVyF75j5XZw0AVB8+dXqps/lHzuuvWstW5WNTs4OSj
 q48/lnX6nVcHBnKx3saV1HoomS6TzQVB50dWNF4HrpCSY+ixU8XfURJa3etJH3GGibZJ
 2tmKJJRR0fUeIdGbj6vO8SiZGbvK07VzAV3c60fk8Ck52a1RkY/vRsWMa9DAOsc3Euy0
 Rx/V1fk0zByavBEhnL9sRfdx8vr86yjGajnDX6L8PSlrbu3Hz+NnJHYqPooXI4EIKTiS
 5HfOerSDblSUZh7unLQF/gY+Iw8+deYWXNusEEH4Chv0hNeVtLvNAuJp2zDP93bLYJDs
 3j6A==
X-Forwarded-Encrypted: i=1;
 AL+hErHeO0bzBnh/Ux/hA58KrrnpHlKK+abFiISysAY7j69Ikr4n94EA2qg+L1KiZG+4W0Wgpshp5aDyhcQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Eww2W2aU95cF6M1enQgeLnpdIrb73VC7EqBBUTS7d2wxAvEmd
 w6jrCm749HjIDd5alyBPLpdjn2LWzZmS4fgFeexioLRVl1EcUt6L/UgkPFfWPiL/lBBcdw/VYAm
 LDjRGwGIewfZYQSTwH5ad5LT3haXwjY9Q+WTZCRh3Uan8XvnqkAx/7r4ZlRUwhgFSGaO3U0Q=
X-Gm-Gg: AYBFou2gRsJl76pA+rham1bop7Ng25fvC7Y8p49ArgIud9nSUiGOM6qJp0GxA+xSSDj
 yd4U4RlegE8foHtutp7vUUcTIZmWI/Vc/j2/3Vc6HQ4evj8o1oScVyqzgdJvgNFADXlkvC3oBfb
 7RfESifSmFcoSuF8oNgkJM0bBKe4C71ojyroA+bvIDM7WOdKMK6E194bEhEmHCBIFEE5vyEKy4v
 k8V1Hs5Vih7xrLAUGX0wZOeTPrYlSHA30XXPrdURA0Ntq9DXcWVvj9AJrPUuMk7f1tIVHlBuHwq
 KUVzHz+YND7ry6jXU6eSnExpwdBDW40bPETbKkl6nq5t119ypFC6b2oPkxKXv/ORiy8xoflEdeD
 PLPfbnUUI9Ixj8FJY6DEZReFPkKdvon9X6DI3hdYp5+WIsvuZglifDnvnjBoLa55jv2ZqLfcie0
 FbO/lrxxk=
X-Received: by 2002:a05:7022:170a:b0:190:da74:2c89 with SMTP id
 a92af1059eb24-1b3c0324aafmr1387050c88.21.1794381245630; 
 Tue, 10 Nov 2026 23:14:05 -0800 (PST)
X-Received: by 2002:a05:7022:170a:b0:190:da74:2c89 with SMTP id
 a92af1059eb24-1b3c0324aafmr1387024c88.21.1794381244935; 
 Tue, 10 Nov 2026 23:14:04 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890c0esm13146024c88.1.2026.11.10.23.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 23:14:04 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <512f4c94-15a0-4ea2-aa70-b0015fcb4079@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:43:53 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <20261027-camouflaged-orca-of-debate-316694@quoll>
Content-Language: en-US
In-Reply-To: <20261027-camouflaged-orca-of-debate-316694@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af415be cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=iiY4aUXpewVHb1WYKVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: LTqe2iGvNxZ7_Lp0Muii4I-hF8zADpXj
X-Proofpoint-GUID: LTqe2iGvNxZ7_Lp0Muii4I-hF8zADpXj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfXzrbStGN5MF5m
 BxY8aLK4rUcNL/2zrw936AHI3Z/zhHzG9npKwpJwA6cfwJ/ts9s3mFb4txGPqjDj+JFp/BYBDsH
 3/NgIT9775JmUFZUrb2tEKqBsWJuIpc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX6f4en8Y5qVQv
 s0qx7V21uyFpg6zDmVmlntxdX2HBW4cRr+d4wyn1l88h5se+BH1EZEWakPoy05B+lUyQ0V0EWiy
 OCSZH+X1m15eEBR2kLbh5z7UrmBgFqWPHSLt3oNIHVOMGUhDDsBqE+4/tzYey1Vx3jXVPGD3P7z
 HFvYyy3MGEPwhz5rTGVrXfMpVIp4cTVneWoazzMEIK1V25yPnKmHK7wyx7ZGLMciG3dxQBrfUcG
 T2ZIK75MpgfU0CdA+U0+THx9biWhf6/cTO39P6Tc/f2bbkhcKfHQ8vY1PPxF+IgkKbwXwXSdBsU
 KzQ4WuNNYZXUcq3VCGHxDJ61TcLc8JVrC5wHVUal6OFxmqxKpfecIM+BOPYizk/Gihwi4T4teGE
 EvvStpmjmPORgvg/OUEx+oSkrX8BA+3RIWHUbrVE0voi/HtlM8ODj4UArbljiq4VG32xVk8MkOe
 tzjLQk0TnoUJ+CztQzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110028
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 27-10-2026 14:06, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
> What is a DCP platform?
>

Will address this in v3.


>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the Qualcomm transport
>> wrapper, display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>> subsystem. Document the IPCC power-notify resources, transport and
>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>> after the IPCC power-notify sequence has completed.
> It's still DT for real hardware, so I wonder why no SoC specific
> compatibles were used.


Thanks. The same DCP transport wrapper works on Hawi and Maili, so the 
current driver uses the generic qcom,dcp-virtio compatible.

If a future SoC requires different wrapper handling or has a different 
layout, we can add a SoC-

specific compatible and match data then. The child’s virtio,device34 
compatible identifies the VirtIO function.


> Best regards,
> Krzysztof
