Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0500C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3625010E40A;
	Mon,  6 Jul 2026 21:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9xRteVh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GxQ4DEPT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EF610E40A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:31:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxjP1478039
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fzDGxXLJjspm8ID6JkaqhKtT
 kAtG0hD6KCQrkPkv4FQ=; b=g9xRteVhP5gefYbx3ff3+GVHkD5/NtiD8aFuBMmo
 LEvcsBjk7gLxGiEeBkNwuOxiiOUkedrQgK/jNGCTT8Qx/jKdOvE7Xb3acU3YafMq
 bJWF4WqKDd9ZtgDi9VlLEp/JtlO0xxZskJUD61UsCA/LzCawqqyrJbadehamQfhO
 ACULbQGHjRHrqnuIUhZjcPAn6C3bZZwwXQCINsSe7FIGkS92zjGhusCelovk8Yxm
 fGKCjq7+om8sGd39x9soMcEnV8RwKpjCysdN/UAlBLVv99omvKFvpQ6DkdoW8d43
 +nMvnk6KMg++WBqdAd0X+NpH4jWzhYoHiEJoJEmv/z0B4w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbe9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:31:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-96966afe3d1so3821382241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783373495; x=1783978295;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fzDGxXLJjspm8ID6JkaqhKtTkAtG0hD6KCQrkPkv4FQ=;
 b=GxQ4DEPTW3aBvUwohQWOgJLSj8jOtCOf26B0xeqvqA2/fF4SK5xUWunVZmgpNt3ixV
 galqWWypardZdyy8xqPdSd1A6o8CjWgKqCXM2cxQqcPKKIsAxCnY1Gd5xobInzGf5nWE
 cCY51+RLIbfMXu5sUpW98lusfqXIv/I241bdBp376nwduOjzCYOODmnWp3h4cXUoiEPM
 K/wOR+7U2hDRVLfvVdlLqU2FSOGYJTyYnhmRrT6tx7IDibr4DUMrwb6rcjNZNXLLVK6B
 93VjZE3hEXZgkV2Q53R+9ULsmliPzKn0yLS4TvlilLbm3hUIy6k1JILjDT0BudWW4WfZ
 kknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783373495; x=1783978295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzDGxXLJjspm8ID6JkaqhKtTkAtG0hD6KCQrkPkv4FQ=;
 b=LPxpkxQ14PKHX7LeT9KI+YIAd1HxrghilOmD7AlkjtXZEnAJhcRVcRc5a15A9jsv0R
 jjwAF66ZDaLNy1acNdRT6m33X2z+KFHDRDzqJuApC4PP7td1hy9zj0rSnyTpQOaV68Dc
 KyR68dd9Su619F6BVF8C5BuhOiyGxFIWvQDUCLHCOMKjCkQee2brIH9gp2WB/sIrejg4
 NvG9/w8xT+te/WBosmzT4L9Ogt9SXWnkkqBUDDppb2iXdAe9LsJThYolEvZM18/DFxa8
 6VqzzDpZUaMIwL6ZWaWVjrfR3enLMe4jiliLiD+Gvolsnw2CF3hCqhTk1+i9K7ElAFqV
 +esw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeP0+UoKqGDcMHZ48cd2N/IIXeqsAQHrifp7DGphW9RkSptFhzA33uYryOo+Sf0Wk6Gz+lyzhYX0U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxErbR2Z2BIvgRDiQzqZ3gdc8rVS6/8p6+XcDTEnV3SoR/HYx5y
 AdxaMFWxvJ5u4JH4ohnOPf2I70v3kd/KArevHfF5YYFbQEU8MZVuvWp4No7l8sUjSh7yzK9m11f
 lTRrJoX8K8ZuYTbb3okTtlwb4CNP5/OfRogy8RLbl/gyMI9/Mnplzj7EAn2W0867eZ5cktds=
X-Gm-Gg: AfdE7cnAspaNn/La3YWVPvHJ9ZgfwBn5vpg7HWprF37/k1YiBnYWbYr2FPk7c67MuGX
 bPX+uNNtge9yHVbqF8A6XkJ8uyMxtowuvhq6S5aQnpnBxZaUsdoE4Pkb8Mm5YRuKq5AqELWX84U
 OT91loCunNrroW4b8th6y7z5qKplbuPlHdxt7bE2WdoZvBK+Fy3cG3dSVnomiWHb7WXkccSsNgI
 dahjr9u6Gm4d9+tYzwRFAwqm2D3BrxeetMqHx1fwSFRtkfa3dJhrHXx37Av1tnmImk3yYJChY74
 s0BwaRUuaqv6cK3ljITFbMqy1glvGFTqfEAUFJHeWpct2rZhTNXyy9VuOuUDGg8pL0/Wd3bypWa
 E5NN4sLDcMp32MuufezZJAOtqM82OqHW2/UIfAFb0NsqSYIJsBa9jOt77XvIH8TblcbWLC6qz7A
 wcbBfQfrkPQW5cTPVrmC/pIzFG
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-744b7d6e301mr1166762137.14.1783373495247; 
 Mon, 06 Jul 2026 14:31:35 -0700 (PDT)
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-744b7d6e301mr1166733137.14.1783373494851; 
 Mon, 06 Jul 2026 14:31:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bb868sm3149884e87.47.2026.07.06.14.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:31:32 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:31:29 +0300
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
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
Message-ID: <w3cid5vezrofchq7nagu5pzasicagrzj432j3l4rt3ebc3slqw@gvtvxbkkplet>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XBZ436JIy-JZHz6vYNUNGjYoXelHxDBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfXyHjeAZi0+DdG
 y2qJDKSSAr8hiaMYHdQwxF7qA35rTAHDZ5hmy/ICDvhVG5dBKCcZDMqoRr67gvogd/gmvoc9c6Z
 ZodynnmQUXYGHMDnemVZt1EJAqf2laUHjkJWz0JejehfxYq2GJTFf8FC4Z4DpB9E4DxRW75o2GJ
 bHo4dwNRqZV2qWD0vfAksPGi0F1i4jAJ5Y5loZGkWjvF4yPGTBWhwZEMNutKZXzrH56wf1gqV2k
 TD8HPQoYI+rkcToctIWNooUVQbCwTS+eVNn+OZp+dZtGsomjT9fPBc1YfaHSMgHIWQ7OTKsdliF
 6fbCr6vcA22+W2ldyvOkOAGzR/9MaKCQXgPmnJiI9MMHcrYspNSoQhvQgC1qmxz+VyM8QeQXbYi
 d28i03rKj3lFpZhS/bfEGvMjnKWkHmnSTOLbLGmqYjOoDyA0PRqBVmei9QrKq7VLP8zVug71Adf
 WkO983crWwPyD1NZqtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX28PW7Vof+qp9
 n0fLiVwVxq7cxD36k2NH6gw1nE/4PTVd5XSzYubvpxMR/Rv3lAvb/nlBJTsvmrqqtMRE96pGK2q
 nM4/JgZWj0VjoNnJqGOOXd+HhjztJHs=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c1eb7 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: XBZ436JIy-JZHz6vYNUNGjYoXelHxDBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060217
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

On Sun, Jul 05, 2026 at 01:30:08PM +0530, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the QFPROM node and GPU related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
