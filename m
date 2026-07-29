Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1464CC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F44410ECAA;
	Wed, 29 Jul 2026 15:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7xEEHtj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eoJ+ytXR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF6D10ECAA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:33:48 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3SB52108644
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ajMms+zzZs+uBR5tOwHZNPSy
 MNLyGmo/TMRwS6asBT8=; b=L7xEEHtjD1i38yrf6/u7zQbJ2t12vUPoUyI+nUD6
 ae/s5RMzWNzGK/Nu7UMp4siroDNpWvty9UlKquAo5likeh7ZvPzZAZiSWs3CVe+1
 JngEKgVsq1pIiJC22CrYztdDpsShfG/8KKBWnZDmbodNThQ7re9aYDwNYT/gfPkW
 ZEE5NyGiiyWei9rER889z+bANm1/H5VEBXrZUFWA0v9Nj4oHgJcsDy3KVSHFkD9w
 fMO1O6Vw3G6pKpIGJkQoXl6FqU7urXrOibEaK/RsBhK7aQKKnXLETCFsGbgtlRA8
 vfz2fj2CzT6LYbKf2XhiKwpQPACIw0LHJxx3yyIKksp0Rw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkds8bmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:33:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so16252141cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785339226; x=1785944026;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ajMms+zzZs+uBR5tOwHZNPSyMNLyGmo/TMRwS6asBT8=;
 b=eoJ+ytXRMpJUIhp1g3IuHH6ZCLZaSOk4QWhB90g6dgAJU17H20xnx8JdBN3OoAe5dU
 hxy0noNDp1mrdy49fnn0GdjVUzH18H3E15d7ulucfXtAaDBAvtfFVDuSJgK0Kyplqydu
 0/HcdiqowYDTGNWEbfUCUu2JBtUxd5H+3Fx9x5jmnjFGvgob/ZgYBe2akir8vflVQHdQ
 wnD7YwsLqISsD5q7OkW/YcJjR1NHUlPBRxH4w0aGYEpReXW0oYL5/mU7zzR/0Zyr2hgv
 xKrzDg9UnZQaV9KMMSWDrm//R6Jy3OjTvB7TQ5mObucjuUL1wwp7ob/W74ahx6teFsPY
 0wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339226; x=1785944026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ajMms+zzZs+uBR5tOwHZNPSyMNLyGmo/TMRwS6asBT8=;
 b=JGamgFSFDZUq79ZNmoIKxl6NkS0RGwh/mVfu/YZ4MCnU7SR6jA+qtliVFmP24ggESY
 nUXwQ+RkrS7VTuHr4rY6/QSSXBxa+gWGloknou3/pAcYThZDFfG2Xu+kO1MUvcNmbeVe
 lB5o91ucg4TGjwiRsEOGxYpv8WNkaL9F3j10+0x7brKjULp3TqrdyTfztl0mG/xkdf2n
 1Py1xrNJOanzJIH5HBq2QMIVi0cstpyxDpyRfhGvlIGDngH+1/EIFH+JTyM4Nx/q7CHz
 yonV23yhJmyYbCHYkZ6Hg/wvzP+Myf5Mo2GSm/W+UNgXqryb6ZUZPFl9JMzeh4p5P/fw
 B0xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqolCECLxWaaWx84a9Daf07F52Ktf8FzBuo4haBJpkFYB0D/R5C6spu8wSqovaAdtKnA7vwt4JS/dM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzf/lnzBLpSl1RD4JPZDEfQfvEmg8JUruR4ilWgs0rnbJHPPQGC
 8MEYjhYMfEO2uxduxaVGWyrUAwz5FEJ9+c2egrxOWh9GZEbi0uqrjZi6QQR7J9hnfLXv+9kjDhr
 2Eeg+bABeAnH5zGBS1MU69lwznT8ZnYGNhxgqistDfk5QG9BJOTr2oQ+oDAeGFpVcSM5LmAE=
X-Gm-Gg: AR+sD10XNvnz+OWfIvS/8MMJeGVgc4n7cPU5rVMz+IUn8bx/lSK63cDpdH3wUs0GCo8
 1dz08cluC2T8H2l/i8fdoeV8+KySxvpKUYkhr96EYXig6dwGRlrqi3dsF8iylEXtfLNVAaBVoMl
 9FY17nEFHU2HhJ8koZRaGefenTQeLE1gkApIu+RQ4lBy9MyFP5zBzBzxIMBZbnb5poDZxbq0wKo
 eSjdF7wZs2h57hO98+WlSxl1TXwWz5DdfVPs1vRtf3WaVc9Jlo2vCgmoLCKhDtz9+SIrlwcxBCO
 veMS2C9+VLvZuC6d2EtGNqX12V9ulPmG8xMIhGuW0MhXyY/GY1/FsgYh2Ba1nbsBqOo7tRlUdiC
 bexOYk01BmqbtczM=
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id
 d75a77b69052e-529d70fc0aemr69903261cf.23.1785339226303; 
 Wed, 29 Jul 2026 08:33:46 -0700 (PDT)
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id
 d75a77b69052e-529d70fc0aemr69902581cf.23.1785339225661; 
 Wed, 29 Jul 2026 08:33:45 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4615f5fsm156186365e9.9.2026.07.29.08.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:33:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:33:42 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
Message-ID: <q6f5b7xejzawn263ipbi7hsqin4c6jqsk6n7h77libdcvaq725@n3jzmra4wgdi>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX6qeuKZWffN92
 yULkurnEzz+SFx5CKBoYLfh3DAnz5NJ7XK/0wqx5cQi+m0xG9jBoxpEhoRajCrPQ13cxxOuZsNc
 L8zKWiggPMk5HbR9RGGNHpmqpYtwQlw=
X-Proofpoint-ORIG-GUID: kcHGckiDW_eAIbSb-bxKG__Cz6jd2_c1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX1rXDuf3U87XS
 q2T07W6tq5iaVNyn1QldnQyCMg07BgtLjAc0n2MGu0K6W9q+5ZUTzfkcHxNpzG/MrR8B9bER+KW
 cVdopfYNNfnxQWdV3od7Z+oE4EawSbk1ZJgdqD0doHhDxH/uJQkhd56vQzTuDN0gKGRdlTvH5+L
 qIk1tXX1f+TyYtciC+Rx37IuTnIYdoOuaawgHen79jBz7FuyRSn21hUzJd0szl1ik7BElU+c/8n
 +cLZRkd+MPNQO1uOqEiwc4LJXKiBshb+4sjSpDXOXsbXZx55Hu1m7RTjzz8L3Mk3E/Dg3QsYSn9
 NhTqnhwWIPi7BJ5oT2vpJheu0mZHFlTGvbG230k9TODmhkWBTBphBOJ5+9okvdPTGVMSr241z1E
 zmmHTg5VNLhH+wtzkCDckd8kaWdwgeb0mB0OW2QwKFfzQsknN7P6yOXeRs2e6N2z5vW3HgacP01
 6a2/apDUF9NzV/2keDg==
X-Authority-Analysis: v=2.4 cv=VJTtWdPX c=1 sm=1 tr=0 ts=6a6a1d5b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2dTW7TWR5CdT-0lf7KkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: kcHGckiDW_eAIbSb-bxKG__Cz6jd2_c1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290125
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

On 26-07-18 02:11:34, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
> shader firmware path.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
