Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9E9CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF84110F28F;
	Thu, 21 May 2026 08:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GRm4uhJC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V8410uii";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF6210F28F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:53:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L2Sw2t3815917
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 elzPaWmOKLsXoiTCtcan47fSW0zgacEY+5u9ATsGPN0=; b=GRm4uhJC+C0BghoO
 xgoXnCW0+nOegy3A5BJsr/Uo7QveiulOO+hu1TjUf2sym106+1XaKJnpQxNOhjfK
 TRstywF8S4JJkXLrbHpTyebeyftvFsSRd+yAIKMwQHzoXPzq+93wcDr2nESMoSng
 E5Yl3c4WI1xxKEquiCcr1K5P6Q7FQv4BusnTQrBK/4bNicVa+cKt/L6sCy3fuABh
 69KvScARtw5RiCUDd5oxvBdgBsjuB/hm+g+6rn5ERoojPec+3zMRdRIARc6kdD8q
 q/loxq1+N3OCTQyBOE7mfePMn1sPqy9XDqhhFYlRtHDCV5ck1CtzjENsN63bRW3O
 KdwDwg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa1bu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:53:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-910552aaff2so102430885a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353595; x=1779958395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elzPaWmOKLsXoiTCtcan47fSW0zgacEY+5u9ATsGPN0=;
 b=V8410uii7kIvHPsf8neeAEkk2TBXCi+V0Un13FmMNBpQwGcgT0YgQxo15+qo8DWMiH
 305d4/nBLbt1oSMl5AGbZ7nQWfIIfSrl0Z/41zI8BIXPgZ04xLO51UQsgWAJxkYXz2U5
 0PeWp/MtE/Ry1g2N/ZG7kBIUZmDAFZjsSZwmF4q+A3BJ/lnBODGDShyZ9GUwiVzJfbEE
 aDpb08QMgxQT5WTr7E66gQsA5D1q6JeT57DciMVyyqvNUg5muvb4obeihIyQquvRmTJa
 3PSfqV5/EmI22kys/fvMVHlg5JeFlrJgGA5Iyl0Z08QqZriyk6IcIUtFidBkZKA5SDov
 X1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353595; x=1779958395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=elzPaWmOKLsXoiTCtcan47fSW0zgacEY+5u9ATsGPN0=;
 b=DCQLnIbYKiYWJsdewGQFqW1/EYs/ZZ+r/qa+ty03OriGzijoMnCjvxQnR2d5nUMt41
 77cDz4u0GXBJjyz304Kq9byKqFek1pop9PyLmjT6PCPmg1RBaivcygDqqHe8aFxblbVn
 Se3Z70zXQYX4YtDyfzXNhtzn/c6rGKj9NbOk6rBEvdX7d3QJPNMh++OK/YOD/oHMWNa+
 N4l4gsP/j4HvTH21P5aH0vPv3gZU6Ff39hwmHGPsziuoKCeaNgfoNWQnE+ndMZN175Lp
 xmjalVc9nSmEbX7mXF24rH2NrrkCOWahs1JUa7n0MkWORwNmT5pxBlunqXRRTPZmYkvx
 MSKw==
X-Gm-Message-State: AOJu0YzFniUTW68s6e5hqqcPehT5Xz8fvgH3uVIH+FCCdwLbT6R9RXkc
 Z0h2Z4yRVb7w3wk+lQjMfqHchzjIJI6tAo5rRYGYVb2ptMk1/7k6MuJ5JDHKsw5Mb0gYmJOINPD
 6Q0uP1LhRwkyzoWtGpbCLQbO4p7v9jhNZ+b3SZC3OKzHdihdG3yGBb1mSTUQ3TFFD/exUOpc=
X-Gm-Gg: Acq92OGwHGiLnlZROkB0vB+2zzmXFEWydVc30RqChFjlUtr69muYGp/H7uGt5V/2RZx
 Nu8V7VKk4JLAeHaQPTQn1WFjOK7HUBKEouzO4FRBjdynbb6GRhNEEY4ufolNQybUrKAVKRW+gAy
 E75r/yICIW/EBulO5O2PPBCKJX2kglP8/DQkpjzaqLlkMkUOoki/7xzVphFrxxQ7k/j1Tdoicpq
 1TyuggRSwkrV7vEgdNHjUwFl9bYC0s+OuwH0BhiDBTfpabyd78bU0xDKnCxiCaIb0q3jAFMv4zG
 vrccjdCykpYVdCMOM/7c8GTRMk3Hj5X9orPu6+4R0VemhE0I7LnA40EualPjTAdAzUm7vUBTBUD
 0rN0IOVaVFq7OuoQXcBPXBo5s2NqxKgIuMDBGfeWHSJ25uOqfxJ+pWwey2H0ELU1wCT2wDZ4E5+
 Pg6tg=
X-Received: by 2002:a05:620a:2909:b0:911:e556:c7c5 with SMTP id
 af79cd13be357-914a2d1a4famr157593285a.8.1779353595220; 
 Thu, 21 May 2026 01:53:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:911:e556:c7c5 with SMTP id
 af79cd13be357-914a2d1a4famr157589685a.8.1779353594684; 
 Thu, 21 May 2026 01:53:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6882442b03fsm572015a12.12.2026.05.21.01.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:53:13 -0700 (PDT)
Message-ID: <990a0d6b-ef5c-4d7b-ab63-e75c37825397@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] arm64: dts: qcom: sc8280xp-arcata: Fix top USB-C DP
 alt mode
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-5-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-5-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX79+nCSWcK1Ow
 i975k0f16bqT+aHhrPUpQh7G/YIKf4c8IoH8KalsIFtMeU5YoSZ34SXIpIdRrkIAhfLyxN/07f9
 okRolAaSrJGTWhsfitHDm3QeYELsUjTvbQuSFzdbNIuHxl1xYjadgKp7rHb3FwJtFNfqFpA+tmo
 2JIkoLG/mpKodeqvjkR4TdYZU8ugKrMUCRG1keLKwFIaaE2PrTV8xknbOa9pRAt2oL7/C1OKlso
 IddSPLhUGqGJG77Q6iP4jQlbpBo8afIYqCD1qoEwBVVpmd0lRQGH00xxiJ4WkwtbR4NTzlhNSXr
 471906okoBXWd4LsUqQPfbSZJ7LPEps7wdmB95dD5181ImjMJC/pSkkiFbLWYuSDWNL3DBCDZvp
 SqGuOmF4OULmzaTdF8OTdd1Z+3nDOOUfJ0y5KbSbeg+NJ1eyUCpLHg5w4waYM+ysokyK4W++SB/
 YoI4TkMyDP3vG3uNffA==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec7fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=gxl3bz0cAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3tLAdUXkJK0rNdSNFTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-ORIG-GUID: Go5chcxR7KDgqzjmQiqcPJ0Ve0N8Hd5Z
X-Proofpoint-GUID: Go5chcxR7KDgqzjmQiqcPJ0Ve0N8Hd5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210086
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> The top USB-C port (usb0) didn't switch to DP alt mode, as reusing the
> same GPIO 101 as on the SC8280XP CRD or Lenovo ThinkPad X13s was not
> working on the Surface Pro 9 5G.
> 
> Investigation [1] by Jens on the Windows Dev Kit (WDK2023), the other
> sc8280xp-based "blackrock" model from Microsoft, found a reference
> to GPIO 100 in the DSDT in addition to 101. Switching to GPIO 100
> fixed the issue on blackrock, as it does on arcata to enable
> external screen when using the left-side top USB-C port.
> 
> [1] https://lore.kernel.org/all/20250609-blackrock-usb0-mux-v1-1-7903c3b071e4@oldschoolsolutions.biz/
> 
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Fixes: f6231a2eefd4 ("arm64: dts: qcom: sc8280xp: Add Microsoft Surface Pro 9 5G")

Fixes should go before your sign-off

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
