Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A0C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E6310E1F3;
	Thu, 20 Aug 2026 13:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmoEhjUd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4A3v0Li";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3B010E1F3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:17:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA2i522932668
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=; b=gmoEhjUdDJpy3Un7
 /05JKM/eYIVdcr6EnZripaPAzrd+h18Y3/X4BYTI1o9xfVe3V9Tl9rUy2CfpyEVZ
 yrTcp/V7k5Oy31pSO4x8XRACgLa7ATmqePbt+0E12TuFjTX+1JyH/nXayvJfsYYN
 CEdwN4sv13gS3VDObVLzPhxRCSeyzH8FvRDuOD1Oc3/R5czay27AoE/19XJY+xz/
 CVLEl/bbEVrodJd/I7qw87+Ut4tMpKsAMHeMdp7WD4TqUHgocIMV6yWiRsW/2/Gx
 s0yBt/SS1Gg8oli0M66XIDC/mVKLNPqUeZPEDvIUd1gR64Elbgf0U9J6io6uPf4z
 Xmpdog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0gp8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:17:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so36944945ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787231838; x=1787836638;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=;
 b=Y4A3v0LiaAb4HeBtp5tVaTUKmFtByg8kvAD3xX9nMoiS8cEhN5RBMNS3M7LLQN1Mo2
 LufB5Cslf8UsWAjnNqiXQ1Y4AJql/eTlWBxFzI/rGmKBTxdOXhA73HXYM1To63lDSwyn
 EvFap/pD0FIp9Qw/+MqhbOIhkr0wMyAwbA+XLSkjWtVU+QFgSKbFKDmzhW/zRs6ahid1
 io6bN2z17aAT8oZGwq0Fr2EeS+1E1IUallIDZNwq6O63xiEWePfoyvGCLr2WAANW1k7O
 ro9G0YvQNk9vKT5EdkdpA8b0PTX4/+4vKslfU4YHrLvtZitGJNPdmk0hlaGBtwHrLmV7
 th0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231838; x=1787836638;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=;
 b=QMCv3OR1PjNnIsT3iry0gUeCX7DV/ebouo2/HZCNMn8zSgVOC51PH11LP8D8dSJdTi
 juaA75jfB7pKhHrYMCAx/F3MLwQNt29GCNF9yiHL6mQ+6nGXbZBtGDRkisHu5EQFJJSD
 GF4lTXZTZF46NtPc94gBvurWeXfH1NAFzQZIIU5dGs0jxHvdBrH/uMz+oQHSK4+GMGtX
 Bs4hGLDHwegH0xx5vmbQNRufN3f3bpPBVR5jKXDgTwlseXhCW9dEvKrvPXaBXp5wSXbv
 n+YyQ1VkAnsD2f9a3frghvXALgWg/U2hwvHn7Cgq7LF93YwShR9JBUFPNObvG+t1iEtW
 zUfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCUoOmHMp8Istzvrm6rEnk3PivmcFlhkJA3lLwHDE3aYNGws0fYvFbMdos2PNG8/GiQnEjeVIYTUU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDxYKrRWMVyAQ8FaKpLQy2DLEzq59da+f+WX7KU/7AiEgfwwsq
 N4C4ygHh5ZJbp8KkAxoYCNitE7swi90KHaPoUv+eBcN94fLeQp/mHT8d0erJ19LIVNvcgNytFv1
 +KRVYQwdLUnzSZWpdlleOFeVj+vpDm1Fn6V1/0Pw2EG00e7X761sQ4Iyrx7udKoR1uTEK+ogCVS
 X+yv0=
X-Gm-Gg: AR+sD131aCzUePgTJoCN4UBWfir4n/EBsFgQfdYMkN/Hq3/UlaiIMDo5zJ+PcOTog84
 MHGE0XHYCRLYL1uRqQCFt7VXew5gHGMORvd6zGwoobpl8rjhQCdkyfFSVCf42XT7X+zsoFOZYAI
 DAZAlP4Xb4Kmq+DB8niZiJ6H4W+qNZQofaVh42PRKPl7d6Ejl6Gty962PRgJs741flxkKAoKFsO
 jafIqptIHT6hdqloau4bBnp2R9G2I3Fj4loO4MKylH2uy9uWJkCxpEOhGUT74KrR0haZAI8WIP9
 erdahVSqk4GRs3bOzO8vyGupU5tx0JfejFqeICiowQqSJvneIDU5B2ZNNwl/+52xiSNYGI44P6i
 qK/JeNoc8uJig8xhhas2v5zmVGkFmvA==
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3958110cfc4mr24511151a91.9.1787231837577; 
 Thu, 20 Aug 2026 06:17:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3958110cfc4mr24511026a91.9.1787231837065; 
 Thu, 20 Aug 2026 06:17:17 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae143edsm32627819c88.10.2026.08.20.06.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 06:17:16 -0700 (PDT)
Message-ID: <d39fe14b-1fd6-476e-9e5e-f4030c60b66c@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:47:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
To: Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzk@kernel.org>
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
 <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
 <20260818130724.GA5482@ziepe.ca>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260818130724.GA5482@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VOWyP_lQq6eGKQ0AZMZoshsJJ8_wR6DY
X-Proofpoint-ORIG-GUID: VOWyP_lQq6eGKQ0AZMZoshsJJ8_wR6DY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfX++6MNy8jUtHd
 ke6nYEpfG6UrZfit8/gEefW6chs0COMqbyRH3qivu+5UMrqwxLURJqeYToxun+2LWZ4cn2m9/S9
 jeHaAJqh2dA6ZLdnmS7m6p92ZZiULymCRn4X8CcMWS6HPBODMD/uXvHTdULRHbujVciF8APP2kl
 Rcc4UhGf1kRws4JY7rA5NTCFjW1xz5FkyRghZC/WI2UProxX8qzo8AIRqQfGEp+G4aLLniCtbeQ
 w4lqxjfYfzdSuJICmTukqqz+/Q4oIzbm0AphRuN+vthKEziVZ6l5vVCjyJN/MQMzyq9qeuQ7Ndv
 P/Hb6OqwGZ5muLiBTDu3yjQdYI5c3dfzO4mUUwE61nOAnT6Mwe6G9lmYvb1dzCbqUMm6rP8Qt7Q
 nE+sgUBIkd2p2zjJg1oDi0yKbxvp7Ix+PrXCTJJ+J6a0YwsuaIveb4xhO4CclUNR/NyP8poyo0Y
 g4b2oHImb+Er0BlOnFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfX/BzPBff1uLrz
 s9hLD8IwYo/LzwoWmTMYAj9O2JEljziYLadKQSpsa26Qf90pK5L1GeSIjX3msuerQwg0L0IJ0Hy
 Hc6+ONvmwvabdV/YZEOMzTP3xkbfVa8=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a86fe5e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=gAPlAFmufI-heuDFQeYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200099
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

On 18-08-2026 18:37, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 10:40:25AM +0530, Ekansh Gupta wrote:
> 
>> The CB child nodes are not separate addressable hardware — they are SMMU
>> stream-ID assignments described as sub-resources of the parent DSP
>> interface. 
> 
> So this is exactly the same thing.
> 
> Read my remarks here:
> https://lore.kernel.org/linux-iommu/20260618151745.GD231643@ziepe.ca/
> 
> The DT modeling for devices that have multiple stream-IDs is to list
> them all in iommus list.
> 
> If you don't like that DT modeling then you need to start out by
> explaining why not very clearly.
> 
> There is undeniably a Linux gap where it forces all streams in the
> iommus property to share a translation. This is a *linux* problem in
> the iommu subsystem and DMA API. In an ideal world it should not be
> fixed by hacking up new busses or mangling the DT.
> 
> But of the easy options I think hacking in new busses is the worst
> option and has already been basically NAK'd for the hamoa project so
> please don't use it here for a diferent qualcomm IP.
> 
> Given several qualcomm chips now have this same issue I strongly
> suggest qualcomm consider trying to fix the root cause and provide
> some way for a Linux driver to progmatically "unbundle" the multiple
> streams.
> 
> It would be much easier if the HW properly supported actual sub
> streams as we do already have a programming model for PASID. Maybe
> some kind of driver thing to reconstruct the iommus so that each entry
> is exposed as a PASID in the API instead of an alias or something like
> that would be an easy direction.
> 
> Jason
Hi Jason,

Thank you for the detailed analysis and the pointers to the VPU
discussion. I understand your concern about proliferating custom buses
for this class of problem.

I'm exploring an alternative approach that avoids the custom bus
entirely and will try to address this in the next revision.

//Ekansh
