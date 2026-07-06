Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE76C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B95010E81D;
	Mon,  6 Jul 2026 08:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bq1jokot";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9mVm1g/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FFD10E815
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:40:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641cls3470523
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=; b=Bq1jokotQ2I1ybSW
 pG8Vbjp5cmexg06ZgOo7HnUcdoz++VQPK9jPrlOoDYzoLaJSiP00gdk3RZV0dGdl
 HcnOpMe8UkqIBbOu3ID5mXiOSHkWrGbn/o4RaCjxI7TUE3YgSMVyeOJwObJIZWFS
 L6e5Dw8FpN9uUp9oYfh03/1X7e1Pt8FYvReYZBaqUJaha7/g0J1nEXVeTp/lerEH
 7XARdYrlxEjVDcYf3Fy6sF1V4rU6mnKUJk05/6VmOOVk7oPy1wh80CgeekGFEm9o
 MGKW5oA9Usfw+0K616ZdPkKF8aVVNyBILDw3nWtqR7P0oqKYiMrsCQD7d8G0vY2b
 yeRsBg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txen76e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:40:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe75b7dbso9106091cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783327251; x=1783932051;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=;
 b=M9mVm1g/a2opMcPCikq571DF2237sEcGYHsoLRjqIvIyUdJiWCiPitYsLzNuN3pXB7
 Txn4DTFZnwujJbeetwO7548yugugRIZeoNTGyye3ojl5ni+Bz71PJ6Olx82iBUpn+sO5
 QmKGMatWOsoI8pve1HRyUaMfd9e4zoASmTfl6PygWCiKdXOWvs279CHnjGTsRrjIeBX7
 j9J5g10DVPbj28ZVwcaSOF6Cdd2SBTFGil/Nwzg/mm5KYu2qaGeB3VFi6f2ZFqD7cllY
 rOeALjVxMwT4PE/y7zYHhjDBHupIgc3nkvDhykQcohRkNm6O/UlBSCcCIM6AAL3509xL
 s4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783327251; x=1783932051;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=;
 b=LLUNSEXJER4pvIoVyIZdDhSjmdh3Uz61ljK4yi/s53aq55sn4SZIH2hABS2Ok5eHlA
 MHE6LPzwxa63Hq02Cbk2lUZ/GKAjCAM0WOGkLfJ8ugDtxIT4zZs+pm9ias7Aaq2WizBR
 aYtraSkpGOgu965n9+zVfb0bKukPlPF9kpCIs6+bsDX6tcD5Bi2h1XsOSk8ZTOIT7CR7
 hGp2+TBJO6/PUZ79aNWe3Ik2av0RKomRLwlCuGNBhl0eJczFet5Ts75LYhSVtm4cOUsU
 YnIj/5J6TecoSnczuWhdnwV06cWpJ8Wf4ZSd1FaXwRLtXVztT3PSNkuINUA0TXYfaPmH
 Kdtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RojAZEkKFMKXl11xQx0fuAtEPg48V9ICQAyUd23L5u53pyiXCHefvuJjE1CssMIavDsI5VB+Lrx5B4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWZW++c5jQJHoX9RE6hV9sgnEH1G0bNRBX6NbvEEaMJRDMZZJA
 t8df2ao/IRh/Ozw3lFVDA94bTGfpKnRidQKCi/u71RLIjwGdKh/RjNLfs0ppSx9fdZIz6s04KKN
 5+DJe/jhxykj8lxBO1ompxFD1PpoXAJlZ0Xp9MYD3SSzfQbSDiWWlupynUNHMXVNdbR9SCN8=
X-Gm-Gg: AfdE7cnuYe+WKLwSNqR3q/aTE9g08opXFcL0EeyliD3/1XkKryOOT04EKw3M5SQ/8QY
 ZtwRlNNQgHCiEmzpk2ui5kL+cjPMl/quHUGcoBrSRhd1nGtRej+t1c1otWQPdln1blxz03ZkPuW
 jsQIBhT4uu0FXw8UiKvr5mF/hFunCV2NFB3DiYY9uXy5Pnn3zrE8jCEuBhIWLsbU7ayoxJG275L
 HyPQG+jzmtPnxsIYCX5NPMrLl75/hosdQCrHFvJVNdvrxWLkZ8my3MEfMk+ik29xjLaL8PewQGU
 OC/WO9lkikcY12fqLynla20DikOLtLMCp76I4X+4mgUE8gfbKjtl/4lljaabw3lLJ+WJI3M3iKY
 HSBEtdAfcLbq3NabWQtiY1TiT1A0WbYw7DRE=
X-Received: by 2002:ac8:5910:0:b0:51a:8c9c:7f58 with SMTP id
 d75a77b69052e-51c4bf4718fmr84324641cf.11.1783327249009; 
 Mon, 06 Jul 2026 01:40:49 -0700 (PDT)
X-Received: by 2002:ac8:5910:0:b0:51a:8c9c:7f58 with SMTP id
 d75a77b69052e-51c4bf4718fmr84324361cf.11.1783327248523; 
 Mon, 06 Jul 2026 01:40:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c4b52sm690724266b.47.2026.07.06.01.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:40:47 -0700 (PDT)
Message-ID: <0ae3a788-2061-4bee-835f-d08ecb2a1d39@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/13] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX9IDH4R+m1I7c
 Y72690u0XSpkvnsp/Ki40g+zZTaXEe2Semr1ha/zmUWLR035gr9qydClwNsox1WA5mMveVKpfQ4
 0BU8yDFBkCxpEO1iPat0TUvryz3HD5Y=
X-Proofpoint-GUID: V8nDSJl0zVf732oQ7n2wjN964dEAZhs9
X-Proofpoint-ORIG-GUID: V8nDSJl0zVf732oQ7n2wjN964dEAZhs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX2AB1lOh9P2dh
 0/+kSHK539yNJJJpqt9p+zQvnn7GrGg74nUqeNMrrnf1JxQV7ZdEmGSXBMPiJ1BMEEwWAAh7STE
 YUvkHeGgf39/GZqc+ucCQfEtYqZAwcZXlxs02R8mJF0dqbM578aKr8LBWdnIgWnCl1MdC7vne45
 Q16T6le5grKqJw7bwGPqA9c8vcQVqQn7x7e6egFO93lNgxABzS83DZKkCpyeE7Qyw+047jj0WCQ
 7wJ8dVu53FmsrfPFdAEdEousPiLQUH5gqOGB2IdanlcvUNgg5Aufuky5gSxHrHrB8McL7s4nz2P
 TdSQyyKnHsbjB31Ah7Rt4QXsDQyzmYL1jYvZoYMafDr24l7LkMasp+P7z90Xw5DwjoMuDFn+AUT
 fZs/Ecma2RNndy67nc0MB3zpF4EdZxncLds6NUevqflKK9vC7kNZD3r6IXlWrOz4mIuTL9Wsdu3
 CuTCDUEtueDhXIxnSgw==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6a14 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=cDqsbA2g2SHu6s1Cd_QA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060086
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

On 7/5/26 9:13 PM, Anna Maniscalco wrote:
> Previously both SID 0 and 1 where associated with the same domain.
> 
> When LPAC is not used this is needed so firmware can acces memory when
> initializing using the same page table as GFX.
> 
> To use LPAC however we need to move SID 1 to a different device.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 1604bc8cff37..44e5f9d4b335 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4133,6 +4133,13 @@ tcsr: clock-controller@1fc0000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		lpac: lpac@3d00000 {
> +			compatible = "qcom,lpac";
> +			reg = <0x0 0x03d00000 0x0 0x61000>;
> +
> +			iommus = <&adreno_smmu 1 0x0>;
> +		};

I think this could work better as a subnode of the GPU (or perhaps
if there's no "actual" separate address space, maybe just iommu-maps?

for something also making use of the latter, see patches 1-5 of:

https://lore.kernel.org/all/20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com/

Konrad
