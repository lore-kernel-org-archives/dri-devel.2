Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3792CD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F8510E03B;
	Mon, 25 May 2026 08:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKYYpZlL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XU8XukEA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC82210E03B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:37:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6gPg91223139
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Fwx9ZLlt3548Y6WCHHCbQYxT
 TMoRGEnYiWYKbuoAZjU=; b=bKYYpZlLnVrZLl0MX9CRuSQ42aQNJyT1VlAR9H8m
 at0pQpZPZ3KoGk3SC33MKSZF+hjpvT2OSPsrS4gdKAPKGtMKctd3yZucc6V/SDkq
 g2sYkRqs5eEZoGRxNwcUwdfZ7D4lJakdkdeoALSABk5w7hAoIQ5hzY1/yrGGAQWz
 u/vXx4mcERtKPyU8Kt8bVA4u5lZXGKklWTElrpxeMvd+VuDvmxuL1pGqdU6FCmjq
 AVP2hH5+LwK3uXm08cpt7TxDdvJFVr7gH8aPNDtdBW0FQxk5bv01sbbjeDzamofd
 lyxdF6QwekNIZZ4PKHnbw/iiazFi29/MzFUB6EcXxLwQpA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txntqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:37:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95fd70270f7so14193898241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779698226; x=1780303026;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fwx9ZLlt3548Y6WCHHCbQYxTTMoRGEnYiWYKbuoAZjU=;
 b=XU8XukEAuD88Kia+yQLSD7COfhdrCCCFxpR3ssctrU38bRz7fBXQRnO/rMy6LCSJh/
 CjCHtg4VLidqzusCQt2vPBP0unnvF1Rkwd+Z2Zp+aLttCrAanBoRFhxjlkpNLRX2RT13
 j8n3rRQukzy+APTjNb/2zFlcMf6IuEneJWfFb4aNoUxrCKkY6w4S5OM0P6fHGm+cucWp
 1rlk/YgVo8MVBeptab3CAN3aIsLs6m9DUSE/3GlwS4g2+x/vPA0daob1k5SU2KECtV5c
 pGsA22NOojqOQ/9869TXfedKsL3KvdiCdLPbpJKwYIyMNmBDSLLijQd9pst1Cq0sP257
 uROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779698226; x=1780303026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fwx9ZLlt3548Y6WCHHCbQYxTTMoRGEnYiWYKbuoAZjU=;
 b=NZL+SoRvUJNhbprWEJPr0pbYKujARvIkV6HBlgEAfcxfYpcAlVvUIJ3Yme3YtGtlIq
 z49d9Q49AG6/FFDu3E7lUVa/I4jjZfX12bb21hQPLK2EHsDV0Uur4uqUOu/A2LQPY1H9
 HjAuII1o2W7irlbUO+qf+oMhkuFHA0EYH3t4olSDqzT4PG7vLR9PHEZJxzK7O2uJEllg
 LDt5nxZNzclg+fsXSU6q8qyQ4kpLEB/gCCFdLD1OThRddALkdKaKPWPFB1RKQ84BA7S0
 0+hU08Zzcbi5zU7ieejpgV9TjM3QlXk9MjBm4h6o63Ns2P1ww5otjpg7kMv4YEHHxq03
 wRMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4Jzr8Y2qvRcOtp7gMYPHmo2M9jQy+DTVF3w70AQDdOA3uocQkVkfFEngI8EzM/dB2oBpGgmFOfno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8OGlGUADp8qUlessWeagpnxkzoQHJdumFe2bd4ZjxWED1tXay
 tNBR9jG54ZrP3qP/JKc+PvafiijUb3djXgSsE4ilGiwBTjMifwXo2pAO9eB8hoHphjO9SaJ1KVo
 jIR97ltSjeXNRK1m/s9zg4dPOaTYwORqeAtJmGqq3+ueZ5iXRKY0aGDRNQZVtbrh8yTmlgIo=
X-Gm-Gg: Acq92OEzFaTDfZWVoj9AtNSV5uSiLsTnOIrALvdNKoXZSTIqLC20f6U0l9aa0PcXi0p
 3jNVjbFWMjJF/8y6ZDyDJWLz9eU8ASNhJ7I/xcbG5K+CISfsdBBLlEzMJuaTeNWwlCHrOAJaE7d
 CrnyZH16fFpfMFOtXORw47el1YYuvJyA0yRV1sJlmuWFQyArmRyFj/5mHV2T0aPk6/Gh7HzmkYg
 0e8ObHC6Ma5FG4THOSomF1z4BkoYgudPJUKDMNT3iFmOoUAYWdI/DDd5JUg9mo2DiLo2DWJf/N/
 SkcQY0JGBfJXEInblzPvCK3+uROfXFNt5T9aXa331NwEeATbf8muG2G3gjhtoLW1Z07RMIivfvU
 qDIcOeutdcHBB2ms7+7J28Km4zu61EOOxu6xpzP5b8PIht6juMZutZIEyJzd8InHgHtzfnBiGZi
 DL+QFs1o+0XJcRG/qCnuCVWwAl+ur3PbxLhUc=
X-Received: by 2002:a05:6102:510b:b0:62f:3e1d:a55a with SMTP id
 ada2fe7eead31-67c798f21fdmr6526905137.2.1779698226415; 
 Mon, 25 May 2026 01:37:06 -0700 (PDT)
X-Received: by 2002:a05:6102:510b:b0:62f:3e1d:a55a with SMTP id
 ada2fe7eead31-67c798f21fdmr6526899137.2.1779698226077; 
 Mon, 25 May 2026 01:37:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf9957sm2497662e87.81.2026.05.25.01.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:37:05 -0700 (PDT)
Date: Mon, 25 May 2026 11:37:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
Message-ID: <meuxtcs3quchupl6gf4vtjiosmoig7zs2tc2vr2xthetem5hll@l4op77zr2srj>
References: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NyBTYWx0ZWRfX6P3MZFtyFDWR
 pxiGhHb1IGFkgUruA7RFuj3jX2GzWxwTvbgxFB8zwUcREHpxAz2XWBFtZve8vlFxJxOhiCtX57u
 pEtyd+E7eO0iKiJNmQMb+19exwDakPAlakHoo85zllhHZa+KHn/LmHmW32LysyZlWKYCx1y3PXR
 pNVCQsq0cLRFZhlbhFfUnNnom1HrZp92ObAVyn8cKFBkWMu9ogpsUZdtlyrkatJ0tHNHnSMecFq
 sEWwl2/G2XG2KaNKdRH4jz9aeLwMY/ZriyJI+TRcgmBaB7cwa5eQK5AT8o5b6L80vUC0kUiJAw0
 SXNValaxFI6dgERVbxBFQY3AUMMDzw2unha/pQX1KC6BEe7zpZmhusm8SmwIHOjTu1k2UpI9t1R
 E78R4DqRNxdWtYKlBSyf7LRap+PTMb1+rNfx5TdBYF80+7b1JY8t8Dn8+i6epZcXGflbhPva+Yg
 Ns3nU68VkLS/Fpc9NwQ==
X-Proofpoint-GUID: 6ZtQjbU0guRWAfiZKy3L5iGXIEUTk8f-
X-Proofpoint-ORIG-GUID: 6ZtQjbU0guRWAfiZKy3L5iGXIEUTk8f-
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a140a33 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=XtIZyzpYV7b62ySdhoYA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250087
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

On Mon, May 25, 2026 at 02:21:17PM +0800, Yijie Yang wrote:
> Document compatible string for the FastRPC interface on the Qualcomm Maili
> SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
> fallback to Kaanapali.

Can I assume that it has the same bus width as Kaanapali?

> 
> Assisted-by: Claude:claude-opus-4-6

Claude assisting to write a one-liner patch? It's becoming ridiculous.

> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 2876fdd7c6e6..afe52296bf1d 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - enum:
>                - qcom,glymur-fastrpc
>                - qcom,hawi-fastrpc
> +              - qcom,maili-fastrpc
>            - const: qcom,kaanapali-fastrpc
>  
>    label:
> 
> ---
> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
> change-id: 20260512-fastrpc-9f3b691f8e2d
> 
> Best regards,
> --  
> Yijie Yang <yijie.yang@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
