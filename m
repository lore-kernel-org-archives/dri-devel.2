Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73961C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AF910E4A9;
	Tue, 18 Aug 2026 05:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeBhHxQZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SunHNU+T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A8110E49F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:10:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I45lqa4187015
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=; b=KeBhHxQZWxpTR36D
 Psjvj/wq85jpkNoelRCr7GA7IQCCNbmQzbbatB7HF/+kMmEmIX47iSfKo78TrcSi
 zRz5ZSG449nqvSpSoNWzt68dQQgrrECiYvvocNwe0bQUC3g/OuRn/tEfNoxb24oC
 O9wbXTcyPL56yRHFNej8KVXdeaEMBbZEEIPNDfRrpfJcoG68OgijLhbpI6ejiKy9
 0/VB2vb/qCwEl8lPPqalgpvM78u5K5Sp+CNMHTxsKImtrqVSh44YqH9H+pABffO5
 hr6Tf/yxspMv8oPqYzuJdIWNp2SdtEDSQsiwbvkCPxvoGVfB+nOTF1tlZ9n7YP78
 D4B/iQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p083y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:10:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e1da97175so5312866b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787029836; x=1787634636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=;
 b=SunHNU+Tf0yQV/ElhXXGrBkiIB2la35PulOYNrMwrBPzXAA03hChWJv2YqacFw3MoQ
 B7f/Da9BwsYLdkZKl4YqWR2WlxBghBKlzdOs06H1QoGtExC1E+lyKUSJr75e7ep+8cs8
 UICo71K9imo/qwjrsYEEijvC/uwbiTGcA6nbGufR5+ba6WoX/PHDGE50oZwlgGzTsFg9
 TfZvfXP+2myjrLAVotuIiio1w+VCfOVsB39PUVqD7zQEdnttMjboo3rgntL/dzIeVJzj
 h93MQZmV0P9kkXOwKLIPLyt6oHQvw3D2XiFB/nfvNxfmoUKZ8UItGIJ2nHQWptbSLv+/
 jAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029836; x=1787634636;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=;
 b=V5HoFCzxf/kWfXctNmKEXRUaT86MPNvPhBwBuPU2tzP5DS34C9cC5LK8G9PYRQUAF+
 9R+Cu0hmaF1rRoP5SvvpUTz8NY5KuXPv6ZfN8w2NyXpQhlwFNc+5EMjN6T8xKl78wX1Y
 549IBW23TCRm2RWlYp4LD7rcQiUm1fPtKTwEXvLVzCl1IlrupnCSDwI9O/6wd1nOh8je
 XsWk6qDsBqTRVRTjzed/3kfv3YgHP4wCjS8Y6ECiLUe1tDuF5QgGTTJMHV2oKcofQ6dM
 7ArJal+dCi7thWBeLrIfqfPHqdnKCVe+hS1J6yPeV5RVnuxsA6swd6j06YFtEIC62Vh/
 uo8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOdb5rArFPiAkz1Vyj5I7O7Uj7X7kaJVKICnDL+T/Lk+JkkP41dE2VUiz/AdjC19s0F+hU1GOByek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3vQ94XQcLqkI5mRUL3palNxeUdBPC+QRtKkvOVt143Xs6yQAX
 Z2HWHrb9wS2dnb1SHsbFsk1kgNJYm+bqXiS7fyrzmp8BdPyyOt/Nk+i+8B1L78vTR+XvAXpRJIP
 wsX2DoxVktBjgO9Xop2FEHpltICE7hSRLMIeKGC9cqrkLTLyezBvG/u5G5MraVOTmt9+VGJA=
X-Gm-Gg: AR+sD1230/mHcmnCjT1XacqcOEgAoKIfV7PDNMOI0cDGA3/yla2A4C99mZ8Nln7bbN/
 McBCy3UawAUiQ7Wmgtw9jClv4ymDMGQLLYcD7KtTpv1NAcBxlah1O3Z/Vly+WQ+23ABia1z0T+H
 vxcivKLuF1CiwZjDXVFK2Mc+asQbxuc4QwSlQiUTEW5ln9OnX+djKVX6c27SGtHrgg4gyrBGfgd
 touITBYBQo9Ul+FFR6FU8igwYv4nkLRkp05KSaCFbimZ4bqtchaJ5JlN3zCsQ2MrJZOCZI7NIqS
 JxkzHbi++y9566C7A0l3Gd4UY2YyMWGvXpqZlIVaovjkwZE+4mY9L7mhBRYtyu4KgRWFxfce6sg
 QT6iEfCILJOq4SREg2YUj5UgBcmgpPw==
X-Received: by 2002:a05:6a00:188b:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-84fddfe099cmr29499674b3a.13.1787029836095; 
 Mon, 17 Aug 2026 22:10:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:188b:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-84fddfe099cmr29499576b3a.13.1787029835654; 
 Mon, 17 Aug 2026 22:10:35 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6ff2232sm1015652b3a.52.2026.08.17.22.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:10:35 -0700 (PDT)
Message-ID: <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:40:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
 <20260817134416.GA1415075@ziepe.ca>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260817134416.GA1415075@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O-lx--F9yj6_TNfvXc12jt_TPrFdd697
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX7qzwUVa5Kvsz
 iSijXsS1Nxahv9AAkH6YkDF4GVn7h/nOk40nV6ENq1hJ2L5vgkVCZN6ZMFpbwjht8zlgZbebqN7
 fGZ1Bu423H4jAuUbmqz+kuWsHvHZVLI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX7eVCrhzh37b8
 AeImh3ysei4OCLgb5NIYPduWzqZp/R/PhsnbM4GiejvNZZk5Q4Qh9m38+Gn5Ch9A94eElIkjqIF
 YBntlEobQUPoJI914e/+uc0bhqsVrB1EYZbw3Dh6iIISwIfZzehFqrAr7a48LF1LKc5U3atvHEC
 azgC+jp0GeTtcbq7+dYfs9a+o3dF4Dm52JmVH2020wok+IYYRD/JgdfY+zZuAfafvGu0Jwqfmt3
 Z7NSHUNH3D2S1qsVjoJtjKEbpkQEATUe9cIa0UBCEfSbTQoYj/x413R3uuD2R6oAOj8p2zeq/VL
 OWAuXkr24vZMQT+teo1FjRS/v/HQBXdt88jYFfLld3JutrkmFNiB63O1sDimm41ebxnRYcVxwBg
 LLUGtrpPHEJafeTMOvCj5I6FOwwXnS3wUMkTwUC7ScuS1fSNVghja4C/ad8Ozp81WxAjgnuu3S3
 F+/8oOTBf7eDbC4mgLg==
X-Proofpoint-ORIG-GUID: O-lx--F9yj6_TNfvXc12jt_TPrFdd697
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a83e94d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=UlZBYPnkdO8YS_jrOJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180036
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

On 17-08-2026 19:14, Jason Gunthorpe wrote:
> On Mon, Aug 17, 2026 at 10:17:40AM +0530, Ekansh Gupta wrote:
>> Register the QDA compute context bank bus (qda-compute-cb) with the
>> IOMMU subsystem by adding it to the iommu_buses[] array.
>>
>> The QDA driver creates synthetic devices on this bus to represent
>> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
>> so that the DSP memory manager can enforce per-session address space
>> isolation. Without this registration, the IOMMU subsystem does not
>> probe CB devices for IOMMU groups and of_dma_configure() in the bus
>> dma_configure callback has no IOMMU domain to attach to.
> 
> I didn't notice a clear explanation of the proposed DT schema for this
The context banks are described in DT as child nodes of the fastrpc
RPMsg endpoint with compatible "qcom,fastrpc-compute-cb" and a `reg`
property for the stream ID, this is the existing binding in
Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml. QDA reuses
this schema unchanged.
> 
> But it looks awfully similar to the other driver that was creating a
> kernel synthetic bus for actual real HW, that wasn't well liked.
> 
> What is this for? Why can't you have a normal DT binding for the
> iommu with normal devices?
The CB child nodes are not separate addressable hardware — they are SMMU
stream-ID assignments described as sub-resources of the parent DSP
interface. Using platform devices for them was explicitly rejected by
Greg KH [1] and subsequently using a generic shared bus in drivers/base/
was also rejected [2]. Greg's conclusion was that each driver needing
this pattern should have its own custom bus type.

That is exactly what QDA does: the qda-compute-cb bus is a per-driver
bus type with a dma_configure callback, following the same pattern as
the existing host1x_context_device_bus_type that has been in the
iommu_buses[] array since 2021. The bus creates devices synchronously in
probe, calls of_dma_configure() via its bus callback so the IOMMU
subsystem probes them normally, and tears them down on remove.

[1] https://lore.kernel.org/all/2025062434-reviving-grumble-1e53@gregkh/
[2] https://lore.kernel.org/all/2026042442-luxurious-antonym-f20c@gregkh/

//Ekansh>
> Jason

