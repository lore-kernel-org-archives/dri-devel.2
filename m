Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F0606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0SkaBPo;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VXRN2Q94
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861A310F495;
	Tue, 27 Oct 2026 13:13:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E62410F495
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:13:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAdsNP1921592
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7WvmV6i+t04NVkQBEVgPIfAREv8DxyMHYZ9gaoAPyvQ=; b=g0SkaBPoD2DSomoW
 C/Pw36ZqeeBH3PkKVjeb01huIbylnMejQecjdd/n465bfDGvQoTOWnhfvBXi68rS
 7ttyexsHI5SS0rtOdZ/IYu1OJHAzOqYV/sVcdE6mVfkIQcxn0L94yuMv5b+M+OKM
 3KXhN5rJ4uF6ty69PN5AtnB8CoCCwQX1nTqG7xrStx8virnkdZcIxybKj40k/ZOl
 TuIcPXFX3Cq6FBwhLcRvCxX6p4orTbFEa+4zEJ498NuGt7DF8Gm6V+olhU3vGBGw
 wweFAol6BJ+DtDGa7tf0eEhmAXe5XyiLZRE0SyeQdn1HHVyEeyxoKiUDp6XkgISo
 m4k/Jw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq690rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:13:06 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4574f1cac98so5413749fac.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793106786; x=1793711586;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7WvmV6i+t04NVkQBEVgPIfAREv8DxyMHYZ9gaoAPyvQ=;
 b=VXRN2Q94nT2oNfTunj9//XGHvv9GSBkIlJNJw1YVlMlXDINUYt1/zMzLvWrAo9vFMv
 j9QrlqOALq2xXy7g5gwq7kvQSDWS6xFF26K8HslRq2kBKGVzNBjFhSvNA92ssxs8VrpY
 bInNLel7WEvFOf8K/MJZHb+qgoG081zKXIboWR29x0g/rRg0dpZ27BDdul8S3SMdGQ9w
 LVhI7QxT3lIIuZ5su6D2/SLezADjGc+n10p14rdV+pBFdOW8/m38Gw+vIaDMowLwY8XM
 ghkah2xwqdSN1gKmLfBf3b+R0zQbPrtOC/RndGo2vJUgGlHKXcw/iNtj66UfWMUC5GpH
 6fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106786; x=1793711586;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7WvmV6i+t04NVkQBEVgPIfAREv8DxyMHYZ9gaoAPyvQ=;
 b=sWRtIywQPggiRHNN97z3+wPoZPPiZYwTkHyo5i/4srRo4KREDZz64blP99R2awzCYM
 S/pK2beEnf53h5hprkhyd9No082b+RokFl8360Eys9A0uiY5QVQ4Eil3Dn1pmS1Jlbv8
 skU6ZUFAMI09RSBYMetPazJS6T48WwfkmBvvViL4xW9ojwAwgaTkanuVj67HcGnK0DxC
 gR2lwWPNid1V4zkF4F2Kkd6bOjPHPKhq/u4gZcX+sAFIcQ/zI15v92vlPjPS/jPzXKzc
 w/mrfzHNpmjHX6FoqP+Xr/uVmthih8GS5NfpmbzLJdADfcmVaPTg8r+VpevMvmnXOMDB
 09Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWbyafa9+JENSqb98vbYaOUnWIZlVTVZH2Vkq6lnkAdNavVloOxK8MPGHXGz0lIzLUl/cdb4U6BBA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIlMyB67XUSsrm4UUs7/oj42doScqPlAeLHrd/v82ou9aCq+BO9
 2wGDc9SZYEVJOZ+auM3XT9UBCpV+U/xo+2SBH1DIK326NP0cQt3cn6j/pZeQbs2YNzthmaXy6Hk
 a2WDIZ8VFqLqkSSton2xeCOdlj94gysmsoFHH4C5WT95fWsdnb3wKV7CNy941nRrFu/PsOaI=
X-Gm-Gg: AYBFou0Jb1Ixm285s6I3f9WqDXzJJtqtP5Y3YlbreOUDRkkHHnnHqTlBw2/zXhqYU/A
 HFQiqU4OD2kNsv9dGRqVkAchcU4q9zqyAZfTSq2ZO97SYUi4pFidaIzaLh+NswzKjZ1Zg/6QX9o
 sdGddKGUxeA77oZ+Gy92xPbP3jSIPV5N4CFbnQYbkVoCyK1UhC5dIGilrJmmyBvgL9UwQB87bLw
 v7ll4KLvWj4wJZl3kGyB8ODXpb2wY8btaE3WN2Ei467RBSduCiCbcCQmQsPYWK5DK+/bSj1iYi2
 gjfgRUObrldVzbbrtA07SLIMO/p8co89/7RouiCnJNdQYx4JIJHqnue+j4JsgmxbALPR4y+C/R7
 JCrb6OGgVbkem4JtwI8yMQIFt9meqXmeoKKaoNV2rYKqfVFLgDDpWwfGoJdcZbRncTBSVQkBEuZ
 87LjSa
X-Received: by 2002:a05:6871:2114:b0:4a7:c737:5a11 with SMTP id
 586e51a60fabf-4a83f40c1e9mr5690944fac.20.1793106786061; 
 Tue, 27 Oct 2026 06:13:06 -0700 (PDT)
X-Received: by 2002:a05:6871:2114:b0:4a7:c737:5a11 with SMTP id
 586e51a60fabf-4a83f40c1e9mr5690892fac.20.1793106785324; 
 Tue, 27 Oct 2026 06:13:05 -0700 (PDT)
Received: from [10.219.57.214] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b74c0a7fsm11511fac.2.2026.10.27.06.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 06:13:01 -0700 (PDT)
Message-ID: <1276435d-7102-42f7-ad92-84c61aed6d2c@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:42:06 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: misc: qcom, fastrpc: add iommu-ranges
 support for context bank
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-1-5dca3aa2c2d3@oss.qualcomm.com>
 <20261009-space-crane-of-prosperity-bba4d7@quoll>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <20261009-space-crane-of-prosperity-bba4d7@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0a362 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eYkptJB4znfycLMIrrkA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: yaHDkVMUdr1OebjzzP-lyUlGpjEDnkH-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX6hxWasx1HvTd
 xjTCUFNHcpkyESyvge1WTYknW2tvw6kF921NTOfbzPFYntgWGN7sf5eNpzu0zBJW1lIqdu5bauB
 2VFuM/cdxQOsG97rJ1tjkmDuPtLQWZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX5gDKhBK71lQK
 QSIUGHiXGEcftCSxDWELtzkT7tAK7l8itjTqAFITIEBccaVZYztFnrh+aZWaDz8bwxSRCPiJAMk
 fdnYugB21KqqVEf21DgEBx+zY76MxWFqSLpqFqRjuxSKTRA8xFRMeA7+u1+kizZB8AFamT0sRgJ
 /ZnvSItIxa/1o/ZQOVdbznuQGQO0PPpHFjTNHYwdQUvJMVAF4BHqs+qEViayZjdrvUclNtolzlE
 DS4I/exi+MmihTYDVHM44Nu8xzVg+489SQ1D61nWhoyhJ4YeJkYhtrg93H8g0u4cnSU7TP07EGK
 ZojNFCwiVxPao5Xx7meADIKWYAxofBy+SGkw1ONXaM/Ez0DbifR5YH//8lJvjU95Ic1IOApS1+t
 bYZBuo8kU6j7FUsasdYrK98paj9/pAR7kg6SfXsbASmZPgKHlPF05ZzapOkLfsckqE3j4UwyrOU
 9NTE+IUFcYFBN+6p4Vw==
X-Proofpoint-ORIG-GUID: yaHDkVMUdr1OebjzzP-lyUlGpjEDnkH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270052
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/9/2026 3:26 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 07, 2026 at 05:07:48PM +0530, Vinayak Katoch wrote:
>> The driver uses the presence of iommu-ranges on a context bank node to
>> identify it as dedicated for extended IOVA mapping. iommu-ranges lists
>> the IOVA ranges the IOMMU allocator may use for that device; any range
>> not listed is left unused.
>>
>> Add iommu-ranges to the compute-cb subnode properties so the DT
>> validator accepts it on context bank nodes.
> 
> Example looks incomplete now. Please add a new example showing complete
> picture of this device with all new properties.
> 

Sure, will update.

>>
>> Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
>> allow platforms that require 64-bit values in iommu-ranges to pass
>> binding validation.
> 
> Which platforms are these?
> 

Kaanapali onwards, I'll update it in the commit message.

>>
>> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
> 
> Looks like this needs some dependencies.

Yes, it depends on v5 [1]. That series still has open comments, so I'll
wait until it is aligned and list it as a dependency in the next version.

[1]
https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

> 
> Best regards,
> Krzysztof

