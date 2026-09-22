Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF5C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD4710E004;
	Tue, 22 Sep 2026 20:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gq1bXgXF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJ3EJQuT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D527610E004
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:36:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7x6o767723
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+hpos+oDMvB//kGlWtIFvFC8
 JGuO25mX9RiSy0nVVWI=; b=gq1bXgXF3s8Ra4n02W3SuuXBHDj7XCY1aL1sxa9c
 u2ix9mNTUjoYemXIUH9MUJBag6g96s+TaF3H4UV4X0Wwh4Jp4C+bT1bvRGIefFf/
 evLcj9iy5K80G4tgUlTNm0+6PM8pnK+UlIK/rQHU6HORQq1dobQdsAQc0sOs2yVP
 l6barOdQ00KSB1x/v5eVSy6TCD2xX5HcAR6wERBje5qrpc8jf9qzQK1pZrDDPGLL
 RPaiXl66re5XrVB2T0JhfiWpX/Geoo/8x+tGZHhuAEDzeSmfJIODDBAb9vTknyUK
 jnvkqMl1sq27dq08hW6w+a7KwE/1SdLH0GWY6i24Cmp4Cw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqkgg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:36:12 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c82fe2ba8aso354138e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790109372; x=1790714172;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
 b=fJ3EJQuTn/ESbDoO7KuKHTpBrdM5QaHMg64kHxgr3uZej5QRD8CmZXAodtIADQ9JPC
 ifg2BiXxA9eHUdBk4e3yQAuBb685Jgfr7Pca2gi/fDk4uKPdi6oG611HINhwaflB3u+5
 Z9ypQk7VsnizFT7/MlpuHzv7oXUqPfKMu/pPrbSu2O9hmcTKJevIgVsfPtIKkSorUWgY
 PglYdub7jEFZn3WXvVALZyrbea+341wg2RD2r0uXgrFZRchY1I/AvpYYByUvj3IkJlEN
 Y7abuYCfgf6R1DGSHrdiDL2zkMF0FoVY+PafISy/6Z3uQj5scLxU7bN05N/MKObyvwF2
 5Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790109372; x=1790714172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
 b=XegqGlJAtBh9TiN7Q+2uLt5rwHKjdz2ao49FGP8umsRSn9nqE9J8W+pPCzHmP//tU6
 g7OMgpi/tfRmF1iMCo52V16n8W2zGx3uRz+2LOKsuxGP0GAY0m85PBbj4m4oH9/fg1X3
 RqdFeYEqVrMZAz9Sv+oiFO5ElJPAYFAOnsKlq4NcugNNKUyr9I8XdKh4gJqTweAwzgga
 4MCAixdWPwYiWfLBC9Q6PjUn7yeNnNCW8E+ahfdONsq5j1WH+0AcqvgnJTOp6s9dIkWF
 z47nqWopfj4B7z68vFjzZjQM7kl8irvGI0ty9H5tB6KQXQbZ4akS1kKmFeVuJ0GJoiJt
 97TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByHfOmMIzxMM0kqmMAR+Wv5wnUiIu6GHeDCxgVFDKCS3rXpRhGQwn0P+P55nwaTpkc8QahtyUi8IfU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfa3qhXePZvegQv0TE7uPa/lQ0RBOvFeeTWD1iQLBNtm0/KIfs
 3BogrTB10pPbf61KAw3qsM2FCpA2FemR266GQfRUZXr0C2D3OJABFsTbMP/afzDI0aq8eiP8PPU
 BXYyjRd7qoqspb1up+b4jkDrBTPcUvlcPC06kTAcVXLVM/AgRUNxN0OHyH8a/Nk4uQOTd/a8=
X-Gm-Gg: AYBFou0pMYbv3NUmhUqu2T+jqtU6KQeXG+BA5Pzs6QwaAZ0wZb/y7gei6SeawBcKuB/
 xmYhQRWtfsOZJmSlydeyT7cLJTKzuCKr/VjHAAJFAk9JiHYh6TzEZSS8X9vRHALsxotLofx3Bek
 7vBUPzbPrbBQK8KkMvVsvPCrHzix072wTiIjJFAzjDTH0xBuUwOzlblcITB4oXok7N4bUdYHa5s
 OPQVWUXi3xYChQWMjzUjRi6RHMYilfKztRaKKiGlnjyE6JG7/6HxfkGGDCszEkIfzVPPRdWlnAi
 JL1X7Gw5ho9XN4qlA6/FmDOCVhhUIP7lYakXqmuhMHiiGpYweFR4eP2aUkkHt9n6Xhad9MXOtJS
 9RS2SDASiS4cA8A==
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id
 71dfb90a1353d-5c9f1597c52mr1337356e0c.2.1790109371766; 
 Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id
 71dfb90a1353d-5c9f1597c52mr1337277e0c.2.1790109371230; 
 Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c267sm965996f8f.16.2026.09.22.13.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 13:36:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 23:36:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v3 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
Message-ID: <c2jt5rpbmys2fguk6ui7e4lwzp55vio3vf73akeiega2wqb5pf@ewp6wsvtxm3n>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX3BIXCPV+5Ex+
 CrWAU0w4txYXBStAUl+vf2xm0HxoAzAJ+K6XQ1Aw5DE++JqJoSc/PzVcJQYTGSE3B7/DGD3Q9SS
 gblmlTRccKuV30Bm/rVzrlH2PKuSxtaBWW+ArZWzjc2xSZPmUMcBIohlHuiPp4uSPD1p2pLYdqf
 dZAOJwx8u6UQvNnGkrb1s1adhtrrY52PzcDHQMYTRmLlvdwl9gxnit3nAyNqL8LszUJ6+bu+Ren
 iSpRu9aBcTS52rxzNCpIMhCN0dPdXJ2NUPDtqXB0GWO8W2EFAO63R9WCmrGiQ1Ih+NK9VsKyHHs
 xRwQQrD93BEpo1APPwdUT3XFD4Vf0M/J1CZh2a4xRtzHTx/PBp6/ImeoaGtDXm2w2VxGjOUtMgi
 hnPJ8mszU/GjVGTvBzae33csIKSOizKxxk79yC5h6EqGbszgO0UEKXuTqov3AmQwqpA+DhJ07ZW
 R/pmmill6Cqb3mvKF3A==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2e6bc cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Oh2cFVv5AAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=n1RHFZ1giDiXVFLDIJ0A:9
 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=7KeoIwV6GZqOttXkcoxL:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: LL0677kgfG9FUjS06T_NYqnuooEWRN_a
X-Proofpoint-GUID: LL0677kgfG9FUjS06T_NYqnuooEWRN_a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX6sYxV/wsmCd/
 Iwwo6VC0FU7tIlldcK75S3kWosC6aSauNysjnYrS3QZ+/84WM3Tu4DIll3PLAdF/VtUvnDbS8SK
 RQO+TZQRT/6Y0jgj3tTX1bTGwQ1ivHc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295
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

On 26-09-21 21:18:53, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
> 
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
> 
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver, with
> some parts added from existing other GCC drivers.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
