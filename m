Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53692CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 10:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F3210E1F1;
	Mon, 25 May 2026 10:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfgNmMml";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQIOVGdm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495FF10E1A3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 10:08:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P81rFs1844577
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 10:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IhQx+fQN8NMYGyoe+FxB1LZO
 zEN9L+wVzrVejV2yZ4g=; b=OfgNmMml1DZ/CmCKWR0hegPNSABNWmLY2PsdIEQ/
 yJB1nBPr4xxP5Q2xNGPGwfT32zWPQJHTVwhFD67V40iISKNaN9Djid5qEJPQz88W
 qlgLUEQ1NUBSozgBkH9/oTwxrxogy+DM4EKr1J/ajGGOAZXP5g3lliR0Aja/Ck82
 IaGKMexr0dxmyZ5o2ISRDRA2YHAez6iYvHIDVWxgs3AQ7+Op5i3qEeePpY8D9WAh
 XjndcPKoJXfFFL9FXXlaKdnqr5l34L0yvt6OTdTga3AbacGavwWHYgLDGCaFBDl5
 BO57a7xSHYkr0GCeTx0/x01DDAzl9Z3DfcDRtQHWK/DpcQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w5nc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 10:08:58 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6618ab427ccso10982327137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779703738; x=1780308538;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IhQx+fQN8NMYGyoe+FxB1LZOzEN9L+wVzrVejV2yZ4g=;
 b=XQIOVGdmToOTF0c81Tm4DFtocxbtBIn6cLQ05FN6FfIc9Ap/+nO6o4p6XGq8ZQzA8o
 a3jM2Y7TNTnEUjbmUWKbm98relbfbsHYdWVl3ro0WfAl98yxTNbKKeT/Zfuc1pgeaO0/
 8tdn3hZRW9Etpnr6VCfhTVUU2q5k1e53+9oqgxc2+lkySZWyFU8nh85YtrvcC26PXcR/
 1aMY7uNORoaew423ZSYLCUZL2D+EM4PwkgFutDauKBiua8yMXho8hNHayyTubs35B5pt
 5ur+FH+lv8NrGOdVjEFmuizT0Lba/ryxwGrtU5pIK4Wr4mQl+mK2HI7ClaN9zXnV3h5f
 fN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703738; x=1780308538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhQx+fQN8NMYGyoe+FxB1LZOzEN9L+wVzrVejV2yZ4g=;
 b=bmwgHa4aAGZ15q2nt/q8W4XQIoJj459NZbMFKke0iZ0zQjshRIZ/k5FPTmoN7iyh/t
 4rvC10KrcKQHhPC0FnFimXnKFIzt0hPYQyO1pglEoBmyUWR1xKMiVxkSyiS6j0IirwlA
 eealVMAWYy5tJHVjym3tRdNZhsWXC0VVKhrYTbRYQpyE3OBoDXnajvENwRG6kfTj0uzi
 nm5SVqq5O7hQND23LwjDEKDkc9JyzL0yzTa1HU1ZMJeY+Gq3OXvY5WWOh6E0loSTIyEL
 c2xT/8ZFaUOwqKmbnHjRrEQY4sQQEayXGusOUadGNF9QQ7kSUkmWSwCsMSHIQt32NCs7
 o5/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j8t22QUw+39xYvTV/KCRxm+cnHJe5CLCVEr5XWElbov8TESLXcBNU/mlSF5jw0qEkMXVJ76HYYLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwowNj6Gl7csvpXbVd2WHXcKczFCdxKzTy+RttXz4ZOdQjCSoHq
 rcQ62z1OZJo6TXEkDtbqcxp4kozC6FRg4VwHL2YXZg3+vi7ocfPOZlk3pXfq5C9h+j8a2B7daHY
 2ZYbyTeGRz2I2deFxR4wBxYK1ocOuc0bQY5JjgXlLzU1+BAztaX0zqA2NiZcYlOIDfehYTdk=
X-Gm-Gg: Acq92OFXSlEV+XgXWiBD6FZExi/8xV91+MKj/0qIy3kGivju6mNq1D6NHOkYjUh7jWd
 nKRq5F7wr+b6+4WszQbLFnE67j/XM1pCdmqvVO4DPAYTmr62Z5WDZYMN8bmDlQbCC9dFWFHJnXN
 /2B/CLfOK55ihB3UHWghJ7xwcFEwWas+jWvbni0U7IM+yAWAwBdYSB03JKtSistkPaCNyevrU5G
 I3LQQC4+GDAvK91S1F1gjJSUCsMS2XWMMCwpV4Q7vutGQdJ81x23aPiRkE+vJAw9368UGTk+psR
 253JuOAEkBEz2U+2IUGnt18j3T5EFhjeZWW/gSa6ovMIGLgxvR8N5WH2t+Fqt1xkdJZAlaVCp2E
 t0CtSVVnUVqp9yuW7/3MZlpHfhwBYuPlgJbW+Faz7Rn/fuf5lv7/l7I8+cNV29PQQX8BRrtD5vt
 hapoy68p9AOVAmzvLwo/oKWf0dCE/+o+Q7o2ioVSCINBC4Qg==
X-Received: by 2002:a05:6102:610a:20b0:608:d017:471c with SMTP id
 ada2fe7eead31-673c1842bf7mr1390555137.6.1779703737798; 
 Mon, 25 May 2026 03:08:57 -0700 (PDT)
X-Received: by 2002:a05:6102:610a:20b0:608:d017:471c with SMTP id
 ada2fe7eead31-673c1842bf7mr1390545137.6.1779703737408; 
 Mon, 25 May 2026 03:08:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf945fsm2557294e87.75.2026.05.25.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:08:56 -0700 (PDT)
Date: Mon, 25 May 2026 13:08:54 +0300
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
Message-ID: <moeb7zqqhengrd2nrqyuqydyq4pk4imd2uylmr4tf2ypn65h34@z33iifvtf7al>
References: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
 <meuxtcs3quchupl6gf4vtjiosmoig7zs2tc2vr2xthetem5hll@l4op77zr2srj>
 <a7b4c0ea-0e02-4ede-8d51-a4c038d55a5a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b4c0ea-0e02-4ede-8d51-a4c038d55a5a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a141fba cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=N0EbhCz5inPs_2rfm9cA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMyBTYWx0ZWRfX8lG8zBI7OL68
 spEbPLPcuDRgNfJA6xZVKM30A4mB68RXQUWFSwy4bLvwqdmHzO+PqxBrleuXWfJalfdpqYUzPwu
 0UZmk+x5VgdMdvEa0fWbLsmPTYN1sv8RwNIORPQDvrTZlyRLJaBftMTzq6zobRp8LFTmkFZYI/o
 DCS6C/Pc/lakljdzF7xDuwEracF1xrJEAOmiBS2b+LZjRYqGiygola7OeVUd72eL25YhJKqzO8n
 eqqMZAE/xPykqY8n0pDmZiV50QYOFNmCVOAv21rpzeLuWAgRWVULgQTNkznJVl6T4sOOPu14dTE
 rIHJyq+T8rwUm9Nl4YICZWEsAcyqHGUGhliZ/fp45CbkHheCYjw2+RV17Nv08cKFEhtiujwf1Xe
 QDKuSWV90P5m18Cr5muPqp5jktUn/D9UHyJzAFsnS6fMPwUmsUk9ggFbt5CVndgw13djS5LjtIo
 iilAt+TeiJ6ikCUnMpA==
X-Proofpoint-ORIG-GUID: Alo0eQVfdWxTtMUZT60SfR3E3QtA_qcr
X-Proofpoint-GUID: Alo0eQVfdWxTtMUZT60SfR3E3QtA_qcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250103
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

On Mon, May 25, 2026 at 05:37:23PM +0800, Yijie Yang wrote:
> 
> 
> On 5/25/2026 4:37 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 02:21:17PM +0800, Yijie Yang wrote:
> > > Document compatible string for the FastRPC interface on the Qualcomm Maili
> > > SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
> > > fallback to Kaanapali.
> > 
> > Can I assume that it has the same bus width as Kaanapali?
> 
> Yes, the DMA width for CDSP and ADSP is the same. If you were referring to
> something other than the DMA width, please let me know.

Thanks for the confirmation.

> 
> > 
> > > 
> > > Assisted-by: Claude:claude-opus-4-6
> > 
> > Claude assisting to write a one-liner patch? It's becoming ridiculous.
> 
> This patch was generated alongside a set of Maili-related patches and was
> not created specifically on its own.

Okay...

> 
> > 
> > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > ---
> > >   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 

-- 
With best wishes
Dmitry
