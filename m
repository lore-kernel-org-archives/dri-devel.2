Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B746CD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7FE10E299;
	Sun, 17 May 2026 18:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULyN4gfd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnKpzWwN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C842D10E2A0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:25:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GLGAkT1200503
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CJ/DYyyYxpPY+jYmMita7FBJ
 M3UjJXpu/BoZnJFwMm4=; b=ULyN4gfdwQT/eHimmWBPyIxAJ4vRX2BhSEUMlUlU
 +uvDD0WorsyOileAHG6/9e9pTlExjSuJufl/KPGPSMVHab4upFBPYJgFH39Btpny
 FBy+ZP8F53EqCyjd+NNI6D7qhgem9fy6oQMUYf2NrFysTY8P61s3D0+iAgcetvdF
 wvgmS51IM9wWhCmgaI91vPTWzaBdYrt1TFH1je+CieORsbQIagYqQHugC9dQghSl
 Mh8XD8EO5Mq/tqfymmyJbGSNt9CpONQ7OIJR5nsn2TNZJpxEpLe+PWq3lgFEqF+2
 PW8RnD/FZgi2pRRbCY5aiP7Ye77woo+04dPx+Z89am6mCg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g3b92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:25:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5156c85538cso50832231cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779042305; x=1779647105;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJ/DYyyYxpPY+jYmMita7FBJM3UjJXpu/BoZnJFwMm4=;
 b=gnKpzWwNJA6L8eldphfiK3leAu20buudOY86IlEbvOzsr/LlkuuNaGvsmABZZPcV/H
 Q1aDPKYoGzxfQkv4peFxjblKKqDbIN1RAcY1uGOa+x7b1N3sLkYQoezQmgGGhuLIhKCm
 udi6p5qvyWo7KuZAwOZkZVGQGD1g9EHOjfo9teSyN0cJ4A869sg5JTx2GaPs82U60v2t
 VFyErgHJwV/RAallwbD7gmMr6tK+1kBpyCUPqVvHLkzvvElavHPab7A0j44H7NhNs1kv
 VUqk/lA3ArWipu+UKMshx4ZmL+jfHts5AuVAHCpIa+ucQifO2a8Oha1OTllRUE3pxsmH
 YasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779042305; x=1779647105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJ/DYyyYxpPY+jYmMita7FBJM3UjJXpu/BoZnJFwMm4=;
 b=Uw9D8l5sZSKDCTZY6RkMA52i3AJeCfsX1jFuvRLQuVriSTwSHScCWIj9Aj+ut7UaEE
 t1hlQTY0TcrkLp9bv+FQmPBGp7csXKSNJr4zQtyWyWc28V/u1XDevF8uKtgFeUBDItuS
 V8H0toLb7v8vFXiSD+kcmcCwEQDCGX4iHRuJIvGlP5GHPOnTTUwNDm0YTKiNCF8zXg9r
 W/VvVDehFMTaqQtUiru06il1SWtnDidmKJT26h/bKfVwz7UdlVzVziDgfH6utszzjhEw
 MaazM2yoIU94HXMG3GqPf0txpo1xcfMqqT/YkicxbPAoeD7Q55g2wR9/toL9xApZq6Rt
 hvHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2d5zBAlNewm4jLD9lwagOac6H3FK1kkdY+qyaghXlTaMSyS0JZizc0KA75JwzEPQZyL7Do61MCwY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZb0RZcMbWn7oJ3t9RcoOtHvg7BDeTfjdtzKKm3exKI3XBrx7B
 ru0g2Lqinry4v4exuDMKylrB7A/1J8lm1KSE6JZt6dUAl3REVj++vHHBZtUSKhCJDJIW1ozLeIu
 oxCW1fdRZ0Qgayv4omUbSkt7ANUs/ZRT6+Cm/dkRrAFXomZziwbsr7FPuh7uAcpIzcfXwBDA=
X-Gm-Gg: Acq92OEEnKYkDIx6NRLsV1iYr4xnKUlPecjukfGZmK0U55h9JGy6igkJ3TxL40Hd88B
 Oe0QFszw9dZNQkkVwmqnKM9LfNqYNArrzWZ7M/5l53U7p/ugP9PU4wMaMgPw//Kq+tpguVqqfSi
 8nLM0lTt5slM7LuOHB50nCYcKOUSkV1xZ05B+6QVQMmg+Nq2jIMbT8wueNtHZzWT+nlOTxiS3/W
 qTCmctHtNuGt+cAHGNsx/h2gAlLFPcq6KUTQGvfvekkpN4bHIU+AndtuZpLSK8P3HgL4HKNLURb
 3bNFyIfVr8A5bSdHhGS+WWbCkIpso+OENwRFsviEx8ic8lASnWurphu80ko11vxRQuH6WN7mF+z
 JEP48A+sxxd4v/RWSMX9TBKa1ocjVYKWnwuhayOFKwMXdRBwZN+qg0S8eFWHvQTPL2qSIGM9W6f
 0rUg1bT3OtRvfVm68TKyYcrxDbrmF7EO61o/U=
X-Received: by 2002:a05:622a:4c85:b0:50d:66b6:1564 with SMTP id
 d75a77b69052e-51659fe9204mr166199371cf.14.1779042305187; 
 Sun, 17 May 2026 11:25:05 -0700 (PDT)
X-Received: by 2002:a05:622a:4c85:b0:50d:66b6:1564 with SMTP id
 d75a77b69052e-51659fe9204mr166199091cf.14.1779042304753; 
 Sun, 17 May 2026 11:25:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c797sm2819287e87.8.2026.05.17.11.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 11:25:02 -0700 (PDT)
Date: Sun, 17 May 2026 21:24:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
Message-ID: <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5OCBTYWx0ZWRfX/6X2F276qOZb
 2NUn37GDK1N+BGhAiKINYD8IaVN4g4eLobEYJIcWkxhaio9aJZqQOIwzf2jOgqCBFj2XWWaK/k4
 ZTimmF/tp4x/gsC3+ixrHvX29d8kjf47MJ0jUmVMnfNUSYD3TyHoH6vc6coNCSKhadU6cOm++fG
 /7MOjVfHli351YH1deQvS/2ZVPxN/GJ4rZRZXtp5OhOtCqNOhfZ5e67MPSxhpW+nhS6lnWFUzLJ
 VmqgyhdpPZo4KXeXRjxsvDP+Z+Q4CUkoz0y2v8+OTSjhxwbB6Cao6z3BHFdiq0vLLJIUYOh1u0V
 7zxCm61u29x02nAkIvv7fVCsqh3GI6NbxVMgRzvkhTq+GtpJ4Bht6HdfEwoqiMMeQmxeBhT6NHJ
 9JvUifxkHMALugvWEqFN2g5ozGx4JrL+2DyDalCN0YG/mo8PAKkXAJf+tmqqW/+v2PzVnu5TUkO
 U4DRMUjHzfwVqPHZbIw==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a0a0802 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=lCdzeb2fhCkI5a50WhkA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: cAYTrUDxgnzADdbkrYWDPU23tvXFHKMi
X-Proofpoint-ORIG-GUID: cAYTrUDxgnzADdbkrYWDPU23tvXFHKMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170198
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

On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
> > Adreno 810 is present in the Milos SoC and is the first GPU to be released in
> > the A8x family.
> > 
> > This series is marked as RFC because it depends on a few other in review
> > series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
> > support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
> > 
> > Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
> > review and has been applied.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
> > [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
> > [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
> > [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
> > 
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> 
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> For the rest of the patches that doesn't have my R-b tag in this series.

Unfortunately patchwork doesn't capture tags from the responses to the
cover letter. I'd kindly ask to spam the list with individual r-b's.


-- 
With best wishes
Dmitry
