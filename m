Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8937CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4710EFB5;
	Wed, 13 May 2026 17:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RnrEFmAG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXqfGXD/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C07710EFAF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFdeQN1242787
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rPuHL/f5LzXJ7O7qOo274Obs
 +ipAHrmu1VPjHVQ/kck=; b=RnrEFmAGoLK6MSSxH/hyxpSV94i49m/hTXnpMIbi
 D7cl9PdO2cHptax5x49zf/eDaswen8dPC1Z9MKvwXnNfg0Se79gL6OSFmSE/31HB
 SFGfiYRWoYg/1GpBol6ieYd0ontVTPIMbEeIsikKfwZQ8ZH+1zPScFZ+0gh87H8d
 xfjxPH2dZIc7qXrQ4WxqmmxtwF5W0ZfctuaohLAw5NA1oLPbyFiQj13uctdBVqwn
 aUSahxZQbQPR8ONqSWRf5yLcqLQ57B9RcaRdZRp4K4FeG9SfEy8KVbtMrueuuaAr
 FGQHPyeAyThzLhvmkv2qOZfFtvOz4Gn7p8RBqSV3MvvzEA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4trh7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so50103311cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778694847; x=1779299647;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rPuHL/f5LzXJ7O7qOo274Obs+ipAHrmu1VPjHVQ/kck=;
 b=gXqfGXD/EiBRbzZ/k4C3iry15lY96RS78Taj9peqWJikrcVdLV0SvTNdGwBnz+qlHM
 z7HlAhoLcTUWaxTxqWmOgXDQuCu8uB93lQaviWpNXzKWTZNeKL/LTYd3oqVQ8KZArMVA
 rSG/2K3c8PK+pkaQp6yknXPHkOCictRzKCWRo8Qh5MI5pvuziRRmCI88t16+H3N5QgPl
 kyqHT12fM4K1tPza26Cd24aPA5JDHr0gftF9y4WeHVwvsdDhyrNW8xSk99Y4Y0bul0hu
 a/9ON2MmB8f8bbhWcsgPvf4AttiSOb2vC0TpMGoF3d6Wgyl00ckhFna9fj6KQE7q+sEC
 LAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694847; x=1779299647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPuHL/f5LzXJ7O7qOo274Obs+ipAHrmu1VPjHVQ/kck=;
 b=J1YzTwkYAuN9j/2j3jkYcw7HIzG8JCg+k4oetNrT3ya0wBFbelXLSKctNxZKAKLJaw
 B8a/Q8trZK2GVa5gFVZTOUWDk8iYbaM0PMnsZSGKRASq/okjjCV3G34qzs7L/BW2FWfr
 tN3nghrxKPvBRLQp//4fUGPTdVl1BH8rxXxo6YeYoUUPcD8hioevYlILSCqKGHsZtUKR
 +ik5dmpVoDfirfRDTy7MvR4IIzz+W3GHRAOjKe5O9jH/lU0jtS++biDBuMXV15YpXhaL
 UjVIwfpblzCbQ0957SyRnMbkOE1zWxkTTOwAqB8hmiAV06fVfHRXhUgqiaw/nNoTpoqk
 l/+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xvqNq74eibeRcoGJzqU8OmRzUwVOl9SjP01/UW8jaS04r1tMV0nBe18jTuqoXfWQ4axqKZ2C8AVQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+bQ0yLUn5KGEeViqXWr61lxWFPj2a0NJrcQqiTaK4LjoUzivx
 UhUWMZ7AhhU4n0Ny3XxR5ShQpIf6kh0DfwyxHoUHQFyt+opkdlZzto9uRDgXShke78QUvYqKUFv
 8lMx4ql0IDblmWiI1T5Uuy3xUShL0F1IpkocJGjLnSm+ebrIy5KyZuqG78StcoB6u+GAPSFY=
X-Gm-Gg: Acq92OFb2WipxrdTlOpsNbJxbuoPKEy9BiEJcaIikgySXXZ+n4xdOskluXFCr3+yYCs
 hN6mTO8uZY0zL+aBsk23Eo93d3m8wF5WNiMahejE9p3yaDDatzY0aFsIoGsJLzT1ED3VkRV4AJn
 FuW2CG1+9BuWJ6DcwMsCcKP9CT8lvb0esVYUxFi8IyNbGfCMR2ElwQi38VLhQ76UJNNhR18ABW2
 2u8cMkN2p9uFuWAuzRPnmHpZ8IQFbDYlW3reOK+H9FPqrQrzKtNZ6GL8FMFtmz+xd7j/mrKjRJo
 GL/qarHsul2XM4khH34A3NYGoCaR1YydEzkfZ9HzDRRAAmbOaNR6p/ljmj2PfyKC44ztWtN3EUo
 EnNTq4zIW8qHiO67c0eoe6NqzArkkOIqVP6HXeJs7FsBpaiAxQbBq1sFsUsnI1O8Y+2n8NPY7aK
 TlrlXeRpw8WYB6hpUZwemVItl/X27yqQrE3+k=
X-Received: by 2002:a05:622a:98b:b0:50d:a3a3:e612 with SMTP id
 d75a77b69052e-5162f4a88fcmr58559401cf.18.1778694846811; 
 Wed, 13 May 2026 10:54:06 -0700 (PDT)
X-Received: by 2002:a05:622a:98b:b0:50d:a3a3:e612 with SMTP id
 d75a77b69052e-5162f4a88fcmr58558691cf.18.1778694846256; 
 Wed, 13 May 2026 10:54:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956606fsm4199375e87.60.2026.05.13.10.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:54:05 -0700 (PDT)
Date: Wed, 13 May 2026 20:54:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
Message-ID: <c3qa7bctzt4v7lblcnagdkxl7q2ku6iutwz3c7yplh7zvrrxb7@iyhn3wd43mrj>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04babf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=z9YPW0OalzF3dbzmYPEA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfXzo7hp1OltgxE
 32pci2jVLtpSSAseOi9CpyBSK7fV8S8kGFIf0YXIgnqr9OeoqQIs80LnBxhG7mWsefloASQEjyE
 mVTy2LuB2pWzvrMWtgtfAifYZLf6J4AalH2lnHe6pqArg7jrmn6WBfAl1ALygImqzcXxKao68cJ
 ORJlH0NVJ7XczaxzUb4LMavOAFVc05e6ExBx/qyYbRJ3q6pFogbaBLR3MZ7VdOJOeAQeBWm+msz
 rE9NGbZKJHWZOiFMQdIXlXsl/N2C4PXhBqsmHBcBTTM/5K21z4VqdKgVW8C+/iSO9Jkzvlxgq/3
 iVnWaZdOFCcj6hkcFIwZu912Y/sg4zExD+wlFWgK35TY8mNNH70HP6Rwl6+LxJxXnCsdkbJwVeM
 grRYyWZ0u+swC9AiaXuFAydIlTxQYdvb58xnkte+xswgokHWh8rO+UAqiUwfnttXR//fWPEfkus
 3KCpeKcam5RhsQt8E1g==
X-Proofpoint-ORIG-GUID: axIHIr_D2RshhBHzGSLgGxNa-CckdPrV
X-Proofpoint-GUID: axIHIr_D2RshhBHzGSLgGxNa-CckdPrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

On Tue, May 12, 2026 at 03:53:21AM +0530, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali MTP device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
