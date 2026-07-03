Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 23:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5010F9BF;
	Fri,  3 Jul 2026 23:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pziJtIyb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/oWnea+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDAA10E58B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 23:11:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPbmo1029436
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 23:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=; b=pziJtIybqcXIcHGY
 16uqYBUx5N/NQcu3RbmzMBy7qXMjMyRWnQnW0e+YAIzOO+/jIi2ZjOFdlZsUHK55
 MJtpBpnIaIsWphbHLScDa2McSQ6HH0IH4yK5eIn+0pTfNAZd4ibOGkecXIRnGMr8
 2ijq2jLz+kq9hb4PUwWsTAwX1Lh65nMREjjMqqNd3O7PyRCVk+5HOL/nmZiESBN4
 OtUEEqNhKVY18F+dgeSzsJ4+S3mywjbF43heo7nJVt5DD1hzNbqK6QlsAY/kSpr8
 E1gWIEN95XAGB50G4MF8OpxOcHhttAAvTJhhkdpPeDwOF58JURaMm7BEjwd21/GI
 kq9Tvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qckx51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 23:11:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e53b8a302so92368085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783120314; x=1783725114;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=;
 b=P/oWnea+Q6fPOMpWkIfqxGXqZLcmL3L+Mf+torheoDgUUw2OIcYH6EgLbYqGvTJilM
 Vi5+e8OQtGG0RTeOGpMjS2rXTocGTfpvOHl56JSlhJschF0I0KMk2DJrwxXyisrWbXjq
 WXeNcORcn2e50C5ONJG9+ta/TImv7H8SruVfARCc7ptkPw0Ed0QDamTdVG2wmB2L0ZJC
 HJ1eRwddOL0RrpWkbM5OET+pP17CxjgA1vRwI+dWT/d/VEAtijXIj+6sTFQMdB+28Ezh
 zin4SFZXuSFbiAHNc7eXWy3+sAf8Wc2KjpZeWwck2fo/nj4ygLEDGs7IHiuzYOO8avTL
 IKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783120314; x=1783725114;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=;
 b=JKgvdfHM+yGmM7Ydga2ob9k5DMDoegdb85brsCtg9DQzr9qwT1LuOwB3t7rvvv5jGS
 ekt9w+XZNlcUsp/idrjTToElM/ge1YMY/Ixq3L1SrBDLaf6fvhOHd932LT3qnb1YQfBk
 DQcSBj26tnklN7r1CVOLOurm41TziRw3tuWCsVG0RQ0+l4ZD62eKjNF1T2ioLRGj7sGl
 WRVx7GJrHlKOTZ15i2Cwp415iI8PxYxntaSxnOGYnOBbDl+9bEaY2nDEpuA3cgTu7xcC
 s9HQkW9pKzn7aKmzWaDYhQMduTAAe3P/EAa1y+rK3HkfbR1YmKZD3xTfxAi4fYOBl1x7
 JRDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8niWaZ01dlhIWJeoqSDYexFY7rc97Eafq/WH5smm64gIMwQLprygIXSkTIj3N0/hfvjtxyGIeXsiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypzD2eUCcbP5pDMaXv9g3hePok/g01R/0xbsAPF/oaBg+ngcjm
 j48y3cBwhY2alv6zPAmkZxxnovf2MEKpQr+sGP8qw3xxPz1jLmk6AtwzdC/jFrXQJhOsQCrVd5Q
 HifasmZi0WbdES7aaprR9v/AMXj90X0cWCOPxIgndmbNp432L0uyP8OwB87AeGXLmQynQdqc=
X-Gm-Gg: AfdE7cnkrj4Vfztj/140VIXA0UlA/5fbyDGbTWIhQJyFEU5JnDw0XYL8FG8mQGt8s13
 GEkOKXLETxqaTqFpo0jX3IU3yTahBmCBKwEwtz7MoZcCn5SPfmvIdIjir06nUaOLOWSqmftZFOo
 6M7jMHMAoksRL8AAvMl9z13E95kU7C0C59byclspnqVZtW7w9QYqPSD07pqrkv9WQaxuP7P7Tuz
 GDpsbT5cW4PM6WvD96pBMlg4wqsHARURK7fJ81MDkFtNnUDXSsckTBa3jUkZ0Do/ztu/XkVy8BO
 cpwo/PJR7pOL9rGqamRlrMHo1fonwWH6VqDPDDAKX+RQvA3pvCLkNPBWmTLkaaCJCWXtpGH1wjZ
 A2Nt1/bjHtXLFTJ9xfFEBsCxLmKLQl5QvGJXHSeysRbft3DKtg2Hl2rNcW3KjMjH/Rhg8PW9HlX
 t5z3mtbApxZDiGNe1SrhquxBeO
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id
 af79cd13be357-92e9a481185mr196238985a.48.1783120314141; 
 Fri, 03 Jul 2026 16:11:54 -0700 (PDT)
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id
 af79cd13be357-92e9a481185mr196236085a.48.1783120313712; 
 Fri, 03 Jul 2026 16:11:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bfdf2sm835345e87.58.2026.07.03.16.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 16:11:50 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:11:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
X-Proofpoint-GUID: 3_NUazTDwka-_exFI7UpsvsBFSHi4I-U
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a4841ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fEDeFOH8jy0W6kBJ9PsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3_NUazTDwka-_exFI7UpsvsBFSHi4I-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfXwjf8vE80a/15
 Vc031ISrVE+cs9RLOHGBHqTWhLT0JZVCNOC+VtDdHzIe2dWN0gmDaexjyk+zOYTNCQHPzUQ1rTG
 +regm4y/rc9ao3uUrSAlCSzC4RPSZ2gOV+EU6itofrcdBWrQojFZq1f8Z+J4x8B5FzdwVBWNpYS
 EozACo/8RIK71/2CdkKY9jSWNK7WyWpkLVansXjUAMN3QFiuBt5wT4A9O6gXPsT6fKGfLB353bF
 fy7lV2GrNjf6XmmWssuzuzucU6MTbzj50T096T7Rv9NO1Si6/2u8ZPefUz0JiqPfnXEesWCCBfK
 BQ99uk4nrZCs9+fLRhN/2IYXLSwzcYWmmqAGr52GsOZsl7BsHZKoY3zqZ7NPk+wVAePcmHMq7Hk
 npa1nqjY1TG4B4W8p1T2I3TLhK4F8rV0o4gFuNoQxDEmBbdnbOu8nkTh3a/oja1/ZRuVdqfFMz0
 T4gKG1KoxZTW6TZjzQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfX4qefbmt4aGqM
 Lqeiq/2MtLpLpUSpfN0QKyskVsXhAb2SnQbob1r/Wr6tDqOg10b05FwzB6uLHa0OqA9cZlcPHGx
 opPYxMSGJ3VZENOTTvw09NVCTRQHHdc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030233
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

On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 115°C.

Nit: 72 chars. It looks really strange to see two paragraphs with
different line wrapping.

> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 34261221664b..eeeaa369d3a7 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -2510,6 +2510,7 @@ cpuss0-critical {
>  		};
>  
>  		gpuss-thermal {
> +			polling-delay-passive = <10>;

Why?

>  			thermal-sensors = <&tsens0 6>;
>  
>  			trips {

-- 
With best wishes
Dmitry
