Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6090CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C09C10EC14;
	Tue,  7 Jul 2026 10:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpA58R8J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRU0Bap6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E462010EC14
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 10:12:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DmCt3138670
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 10:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=; b=VpA58R8JiSlVbUdY
 S6MHesUXfkwIBo3HzMez6adaN2gWzDQNMFVx+ZUl6tnES3W6Tj7pt6rjlanvjnT2
 o/GnGIDyN1LLdP8ZAQjUn5H9g+jqKQbT/8WiEiA5LlB8OHGlELSDOY7sXwVeBuxM
 4EIFlwi4NOfosfmkcncRQYCNxqXSP+S3tGmodsagdfWod+a+tOVUPuh34/QB30AE
 Svx22pQiSPcvtll2QpJgf6rGYIdQGtYXyJ1ve+H4FGtlD5ZTHp/zXAGmt8JO4v3a
 sa++8xf7Ka1c5Cwq8TOl+nzZsUl2njze64TKgSiVxSwg5mWPewNTIrc0pgltRBFb
 Q3pCtw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t159eaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 10:12:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1e777a15so7618821cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783419169; x=1784023969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=;
 b=SRU0Bap6PwaX7z5bWvzAOOIPjcNA6d09aNlE8uL6Ubp0luDgOdDkMu+Sklk1rh0o5M
 ig3iz21S0GYK61AscAVBFrGuwczarABnnVgxzUHCEAMMd5X6cT0Dj7RC/KVteLRrlf3z
 +uWVGrZBcn4q2CV72ChDVjvae3vdxXNmZwlJj2ZxKuZOWWJiEIoztReA5G5mqofk7ICx
 AniN0JCTXTi7OOdLvBq/JVpIU+1YWPTS7gvVNygU1z5EtpXv6V/4fykaLAKWFDux+Z8i
 SKRs1CrOKclXbdwQ+gS6A4R0j7mJZ4ZtfiteZXKK96jpErIQamZRSyeCQD2i2HB0bioY
 czkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783419169; x=1784023969;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=;
 b=lTDxBqkgTPc+hGBUST+j3oBLG4o4bdeL/kjVWQPTFoKY65WYtJHiDLKr5rdwBSKk20
 iq02uFpNKVBt66ibrcM7Za81E51xhL82lUCV4kEEuR1pCCk387QqKPktjVx2QEFlwasd
 rWW5y54GXy+31jiuccWDPWJuUywSVI2KCrVHc5QyHsEom6P6S6QDP4fioCgnJx0udpMK
 KJQ3Mpl9TEDipy3zKnOKe9T/JO0U9OocMgL/xTfc1Ht60VIqjFRJfkK8Z6limDFoM+fz
 9DHJUj75Bwt2CNFWP5H8LG1VTMvn8taeTWLfLMTiMabxvxGtWDbLd8rCdlxJif/8r72W
 uuRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ8FkeoRJwvd5lwpYRvAm1s0WkDCK9y+IZ+3p0+Zz4uydSxiqy0EZMoksnEbzdDfx0TKN2QJmp5lI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1e6X5rIWYC1BB6hXH8zJvzmVGLZgkuxdOMvFp3lmAskHNPS2h
 hup1WsTOHTnfTgCNRO9L3B3Rvc6HRrf73iByi2mh84pUPqRp/yyNu19ki6vgjQCxrKH0/RL7m2b
 IQvb17PRrxWdMBbP1xTfsE1tv/Vk37+Frri5zosdRvP/ik7tD5vQYb+uuY6UprTZMEPsWfRs=
X-Gm-Gg: AfdE7clF9bH+MuCiQlElKtj+mooNtokybo+vWR0w0xybhYCkYHxzfuVnJbyrCi+XLnE
 E+HGR8+p2i/th4kkwHoP7Y7lUvl3vaP+epfAs8FCr/iOwdRAZ4aLB+7cx8Dya8lbkdL/C6/1p+2
 Zyf/jzxV8R1HQpd/g1uRRoAP6HsXeDg1RyH58Q8SrypSPhOJhoSesldlN5Sc6zY2qqcSbG2/hFK
 6IS+M5crwLGKFXzm4AC6jvNc1dClN5QIOwKrh6+ZI8uH468gVAgWkSKP0GMfhqYMfCIryUnGLwu
 6lXvHcphXEYjxt0v8bX0DixXgCh8SEFJvBbF4pxqqLOR55RH/NlfgnOM53idV3jPAnrrJJR+j6m
 OSSAfDek7fd85FpzajDHBwU/CE0MXl+ZMIo8=
X-Received: by 2002:ac8:5a0f:0:b0:517:57c1:bbdc with SMTP id
 d75a77b69052e-51c79ed34b8mr20269621cf.6.1783419168921; 
 Tue, 07 Jul 2026 03:12:48 -0700 (PDT)
X-Received: by 2002:ac8:5a0f:0:b0:517:57c1:bbdc with SMTP id
 d75a77b69052e-51c79ed34b8mr20269231cf.6.1783419168432; 
 Tue, 07 Jul 2026 03:12:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada057bfsm98437966b.43.2026.07.07.03.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 03:12:47 -0700 (PDT)
Message-ID: <36f4507c-2524-4a9a-b38a-7d061d13cd4d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 12:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
 <20260707-kaana-gpu-dt-v3-4-8dac9a60dd5c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-4-8dac9a60dd5c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TWYnBnjMvf4xASJ1B_oMqH4NOB0upAuU
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cd121 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=z65YV3W3F_EkYOo9s_QA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TWYnBnjMvf4xASJ1B_oMqH4NOB0upAuU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX4beGwPSXa1S9
 E5yTcV1gC3OXhM/M24ai8d0bo8ivhS1H3XIzNsSEOTC6K+KcuxXn4z39b9eOszOm1sF4LwZQCaV
 uIxnvY5en7ahTvJtFq2MChA881lozj0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX83U3loTqbqGi
 M01E9uTaZQQs0ASnTdX+rmCKBNbZ+Wj07vfE4f6DedGkQyNdCWzXTO2TETo7256ouHRc6Mxbbpw
 aeAZF5IVF1xNnO3qf60x/gkNcxZxdbnSAJBlBC4ryUpO+W99UydV++mFjGxA8NMmt/pt7xp2G8m
 tWJ6EukgQHgC4XoBhsB7vhfCADnyu4YRcAcZYfKE57PC1ffh3CZtNfRRGA899nqVytBTUw0YbDz
 rjHthQnAA8C1yUV3v3S3hdPL56iuXgHTDLqRPudkN+Q8mu/5RwziY66Vkv8Dt2iZ8l65tXagQi2
 Zc8WN1RTci6AiW1XBQiF1AgPfJhDNgCrAzuuMy7jPV+0kZy3r3R1tsTnbOrCFoKwJLcTJXvkc07
 b1cq3xsRd/LOrZ6G4Y0U1t7R1lA34R+xjO39xLqedyvYxEd5sUGw4Euww5TCXH7ReG+V5Td31QY
 Dz4nr6JTImhR2XnSKig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070099
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

On 7/6/26 11:40 PM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
