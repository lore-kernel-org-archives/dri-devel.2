Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836DFF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 12:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CCE10E1B7;
	Sun, 26 Apr 2026 12:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBdSkHvT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDFiB1kQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0159C10E1B7
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:24:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PKsKWX3865953
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xbAF95i14HhsfSGXuY/tMJx2
 G1OOoMWvPHHUcpNBgbM=; b=UBdSkHvT9cBi2Jo8+qaSxIm3tFuFv4IjHRt4Defp
 J1pcgUKQsRlyAI6J6Y71om7S8eqnhHQVTuFCkx7ptJ7QA27qU7S/VyQUp9UcWtnT
 Y2IgVf4CRsOsO2xc391JW3oeaeZ3NhFzKUZ3gYWSh8cI67CjqLoauKwTlSZzSf18
 2m0BOY5JtPHm6EupG3ecLOWTCkKtN3KB0P/tBimb3QzkU11Zsc3ALX+aPIo4cRcx
 nGQvgRP5s1+nh7TQd8F/p5FV+C+eWZm32aB7u1/uuve1j2Awgs0FBtC1Oh7DGAME
 Tr11On8xNfWYgPnHwc7pgX7y17VyheojbE6BvrM+zyD9QA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxaukf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:24:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so201007651cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777206270; x=1777811070;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xbAF95i14HhsfSGXuY/tMJx2G1OOoMWvPHHUcpNBgbM=;
 b=dDFiB1kQbjkJxCZmMgym9zrrJ20zla6qdnkPstr4XMCD44qGy89VrfvlJv/9WiSmDB
 1g66ee0StYDrG+deNYq0XnMCE6F6eWvnly2lj5xkaFGhmxQhJNHNKTkcbphQBBqIVWaO
 zTB55pYGewfIvLbcu1NmUZ3anKh5LhtKec9Ihu2sMlEBqwLb06XFEwPiz0gmJJur09Az
 2nanTisB791r8zdpEPTWv/Z6HGuj3uPuVmi9YQNFhAwN+w3795AcSwcdB1hXUDJ1gMyr
 tuOyud+2xUkaV6QxsqihBmm56kLfAJsO3WFt9UX6fYO0WNJpPic2B7+o6q60lUQqLDOE
 zv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777206270; x=1777811070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbAF95i14HhsfSGXuY/tMJx2G1OOoMWvPHHUcpNBgbM=;
 b=MBT4pYWzmCtSvCrd9MkSY7k9ukNE/QYG5qU/hQmSmoAS80iyUoUjeLmdG485l+4Jmy
 iqqwNzTFLZqzJ6pBXRbT+edsEsGWDLrmlfHFlcJ6GlMGwSwDd34EGDd6P2p6A60P2YrY
 5T/SMv3kZW+oZrW3eGtbTssUccjafqL2ToEhurddDbK9AuYTbfFcx0zV6RBPoYVWng90
 arK/zvL0d2xC+v7daNtdZfYLb0p/o6m7PmDQK46kt2V1PQahXmIFn3oMrKbedJ4ZWxqY
 pHKWDiirabOltLwi2UOLQxgTg8ph0uAw6G+dujPeoQlretKJnIHR5Fk1FR9faAXKrc86
 HqNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ834jCF851GlfcIBkUAurVumOWr9RtbVhVRdhS60QBCJPLn5PpRyEEq+rhHF6V9f/iv09q6Chd6CVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVlKS/dn3OlLfcycjZRz1K/aDGZp8IIhW11qmGjNQ7XKRWeJiZ
 WM3HnZ6Jp0vWnyfCbp2oUzmTtaQqtPPiovnJY4Jre1INVxbRdQ0l9AnjZsy/IK8DhLobuofzxY2
 w4Ya9F6wqFAp5jfh4fboGr0je7s+TLu73s2TaQbgL0U7sDAbsadMIyoseYFYvUrFiNJCUfS8=
X-Gm-Gg: AeBDievsxXAa7xibFVAVjnyICfpEAJcC1VGM0lk30rrHDn6wZi1k6Rna0f8aJpm9v5r
 ce/TWyxEgJheCSzKGnVvCRAMVZcxU9QOZ2w5zPi4Voas/HnG58fSa/gUl5v4Els71HChVkv/8ct
 X1DtqmIenuoQlC7bmjhTOAVKauIApqSOsQ/wgPU9DSDByEORA9P5oq0b1B/dy7FH5wjYhsUt3CX
 GEyWk8mt5nZhkdA8W4PZ9r22Ow8+Ddweoldog5Z5CrDU7+vjuK5kmWWXoY+TS6U0EQRPxY1jif0
 K3zC5/32iUT163vjpT5prAjv9Z3p3a4xisVfKNSs7uNxgn21fqagsRK+SU83d+H/tY6t7VEJn46
 tfTMC2dlmbg5qC9YJcRSXtC9uqrpnyia0aBZC77pAKn0BBHW4+7IPlYZJPhDtOUF0LxapVR5rHa
 yvXYDHYT9tiO81HemDRGwWZsklAMartuhOecLK9W49BIPy8A==
X-Received: by 2002:a05:622a:5a05:b0:50d:72e4:6df9 with SMTP id
 d75a77b69052e-50e36c7395emr549145261cf.50.1777206270015; 
 Sun, 26 Apr 2026 05:24:30 -0700 (PDT)
X-Received: by 2002:a05:622a:5a05:b0:50d:72e4:6df9 with SMTP id
 d75a77b69052e-50e36c7395emr549144771cf.50.1777206269618; 
 Sun, 26 Apr 2026 05:24:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7a3fsm7396347e87.59.2026.04.26.05.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 05:24:28 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:24:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 12/13] media: iris: Add platform data for glymur
Message-ID: <x5kuf3n4z4jn6qxkqshzzwofitz2wsh5ayjlpz24cm5weo4nqg@smtwh755sc3z>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-12-0296bccb9f4e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-12-0296bccb9f4e@oss.qualcomm.com>
X-Proofpoint-GUID: y-Y6S2BVE8pdoh78TcCs7oej8H-_Fs78
X-Proofpoint-ORIG-GUID: y-Y6S2BVE8pdoh78TcCs7oej8H-_Fs78
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ee03fe cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=54w5cVOzKzMHq45Zt3UA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDEzNCBTYWx0ZWRfX8zLdQaqdJ+Oo
 5KSaZZxezwVFIjNP6TTBQO/XUWuos1I5aJ9WUKkmv2JPjARUn2pB8UISvVSAPrdmdXNLP6slY8T
 2sQMcThdiDAA89P7M3eaYGQo6oD1MCD/n/Vlg78SaUq4gTZxiC6XllnbS0biN7CMEamlYCrytTa
 xCYVeD6c1M+uOUFQhfRz2lp3eda1qP6VPyVnyCRpW1cUeOZuUIgFGN8yPsl2Gx+DRIU6wBsLnW9
 MniNHMxRPaCQA7u2q/5tx/U7kZqmlLukR9pkMH1rbcqNlhsc9vFykWWx+I/lUhgVgtWKxnbzGLP
 EpOeBI9BWHclNflanS5UgQkp7V21ECdJOXvvt05hPF5zb/maAq8xpFbHtXZRsp2vTCnxH4EdL95
 /sHxbA9GK4IB3ljrCVrVKUGAfU4tAF2p4XiQmHFTZjfbLYPbtKFu/LzxnrYGNXIYJUcE/Iw5WV6
 +tzmx6DLBwH75MO265g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604260134
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

On Thu, Apr 23, 2026 at 06:59:41PM +0530, Vishnu Reddy wrote:
> Add glymur platform data by reusing most of the SM8550 definitions.
> Move configuration that differs in a per-SoC platform specific data.

As a continuation to the previous patch. Compare your commit message to:

On the Glymur platform Iris core shares most of the properties with the
Iris core on the SM8550 platform. The major differences come from Glymur
using two cores, wile SM8550 had only one codec core inside Iris.  Add
glymur-specific platform data, reusing SM8550 definitions where it makes
sense.

Even for such small change it is much easier to first describe why you
are going to perform your changes in a certain way.

> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

-- 
With best wishes
Dmitry
