Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999FC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308D310E4FE;
	Fri, 14 Aug 2026 04:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHlU0hUT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sl0Hm754";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F7A10E4FE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 04:45:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QWOE4043014
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 04:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kmj37gDYLFmtuqipO2FnJ3qf
 8t2h85UqZ/NaV5wPTQA=; b=eHlU0hUTunVcOxqua6c0vcWDLZCDyEOwTthoz17G
 sgmjCukTdje+2BK1FdA2Lf2Jd6Xepb4o4765r1KeUA3trlidQL0XmgKcO11xkeCq
 U7pPFKn7cFoQfV2AomSTlD7IK7CT7DbIIrZ3KyDzw9a7nroADUCMZfvHb8bWbqPR
 EMhYzSaamt6PoSi1MTz7DDvqxDSAdIKW5C3Gml+zu1YeGoB1CtO3KtBHfhy5n6DR
 2pA8Eyi3B7p2E5yv91hGEyxlwEuXu5DFN9spdZOn/ghByrbpSJej1kZgWzOOHnb+
 JgZw2RnvCpXCgZDp2pv0rYTRaLm+sRFfA1PKz9FXNDK5bw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1m42hmyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 04:45:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38de4c60f0eso129228a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786682740; x=1787287540;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kmj37gDYLFmtuqipO2FnJ3qf8t2h85UqZ/NaV5wPTQA=;
 b=Sl0Hm754EcH8nPOD8yDq9PZFhKDLitLbYSW9zbrHrmJlJvtKDg9y2BXMOc3H6QZzSy
 uBFqaBLjgh1lm5BegaXETRcrsE+QOexA6kUtlqpHJdCBqqAfMa4kUhlvHLYd+zG0p7iB
 28BmA+ZnpM0FwfAtKuTSlTK89H9q2wVMnNuXaMrypByLfzj6qc6GAEECZwEI7UrdjNEX
 xpVCjOmtL/IFEda7YTPhKtBuY2hk6vfuI4MkSn/l6uC9Etw4JSL1XR5/SMCy8PzIdL0v
 vpAz23MLAtyjq0se0sxvx96J37tiJEiv6l5R5MLKLUyHcAnua/Qfp7F2W5y0J5OhvQTT
 3nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786682740; x=1787287540;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kmj37gDYLFmtuqipO2FnJ3qf8t2h85UqZ/NaV5wPTQA=;
 b=Qa9mFyTRIJUs6vuDUVt6pG0x6Zfpu/qD4K875eEgMjXiKw4/qcY/VSdKw1ddpqyvWC
 +/d7yNoNRYtfXoyf687/nHxYYZlhs1NufITkd9tUpVk5UGMp1x7qAGAVmaCEUSUg0jsq
 UeYmbKjIdkxGohtCZVqvqGVLEMiXLxgkMzJQhGyUDU3826xuR0fapmQs4phe1iflmHCK
 Kf1/4aBO1dMgUvidMjru3oecJVDWbUW/8TmuHbmXwvnsu+EQds5otriP8hpfnTbeCopV
 CG88J5KO6go+oJcpucGmQu5LBPHoFuGNC+6iYUhRcibvLQ4+SaY28L7t2zXGgt3IU6HC
 /INw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEKhc/tGvgCcWiJivgg81A/M4ylGuHmT7jKxnLeUhBDZydDTaRV9jF7EjXWTdNkfGha3cJ3Uf6aI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaaI0OB0ONAUd2tEGRon8UCtG3vw+HfKfrqlwUfpgby0xms3xy
 9CFwj1Hp/eNsiYd8rQHr9ItCg7S8mLkYwlIpJBz7g2uDlVCJHlAVd5e5JxUQwqD6uTnM+lLLd8t
 bhKH8uE4kOsydZevP6GIB/lOqnFVbKKKz634xIJ4sjQufx2Cm/iFAGBzuS4V9sZpbvgMFFRg=
X-Gm-Gg: AR+sD11qDScCX1eYDLEcmB1jaXi6O4BdS14l89xtQU3K364HUr8YlVAPQlrYgaHbEbN
 IoaU3HTysDEqLGPUblqN/LooDCR29RF7v5tBsJqBzVG3Nnc7Mo+f9TY4REu4caOpXgE3e8V3mFF
 FcO2UOuzDzocEgBPGyorsFF9QKDWG5bw0Pkn00e2Mozppb/cTwdw7njGI3nJ0FoseKsdtnS0jBg
 9v1ytpWWkDQWXbRuPdikOpdESwoB/1/ScGk5PbriHxMvE4HJAI5/bia33CCEjn+TRHGCPQmpYp+
 o6BFtTVkiTdmEo3dCYkImb4UvmxwkarKcl05dbRenQ8UTnJ8bgKaGnYzjqc2lFLX4mCmV0/syUT
 E7H3oLDUrmQk8NgekcHOejR9A2F+p55GNtzWR5HzqdRSCKLu7FIwuoSTRQbHeq38ZRba/qscthg
 UW5bycYM6oxhchRSsjaxZE
X-Received: by 2002:a17:90b:448c:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3933b4f801dmr2340478a91.0.1786682740384; 
 Thu, 13 Aug 2026 21:45:40 -0700 (PDT)
X-Received: by 2002:a17:90b:448c:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3933b4f801dmr2340438a91.0.1786682739812; 
 Thu, 13 Aug 2026 21:45:39 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3933b79af0esm474831a91.4.2026.08.13.21.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:45:39 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:15:31 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple: Add
 boe,dv215fhm-r01 compatible
Message-ID: <an6dazZ1WU6vL7Dz@hu-vishsain-blr.qualcomm.com>
References: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
 <20260810-b4-lvds-panel-doc-v2-2-f2c2fe309989@oss.qualcomm.com>
 <20260813-eager-international-limpet-743d6a@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-eager-international-limpet-743d6a@quoll>
X-Authority-Analysis: v=2.4 cv=I+dVgtgg c=1 sm=1 tr=0 ts=6a7e9d75 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=cDQfHJCeRM-fe6_fTbIA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: pRTPRZKhSwZuvrxyxuSEfZZeNFAVBID5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNCBTYWx0ZWRfXzShcHT22zdZ1
 pISYg1VjMTb5m9tvucLFYcqXWgdSR2SZz3YM7xfCp7cvIh0tSrhVqDXI07n91ykQy2cqfAuF+lM
 T7scDeNKu+QaEBEMieygOgEQVBKTAa2236OQe72KvfHP1o8GJDizut2sogeUN1ZCYT+HHp0QW85
 1pb6INBrcdOyEuF3LngW+HhXlgyuzPzFWq6yJLPrCgYtKRepMn68gW8BGz6EhEUyhpUjOxgiN9U
 08YXl2nzWV5lc+euWqIyKxMowqrpL5MxItPB36dN20elkT6rVh1gmuFz4NhSmGqTWvlL1rIIzVQ
 d8Ax0unveeJdQHaSN6jCPeeQZHJ3vfNMzfVVLWsjW89IpZ3zmIUIOWfZmhKbT/XFILmSr3Wb86O
 gicHtviVwmfiTVma+4tSNY5GvmzjusruLO37DJ+guou329dTOID1X4dFNoFINZH7tE3YODGUZ6W
 wSyTqCqqT8tMp5kuauQ==
X-Proofpoint-GUID: pRTPRZKhSwZuvrxyxuSEfZZeNFAVBID5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNCBTYWx0ZWRfX7mLRq3RiZxMP
 uLfNChry360IBFZOTZocxu2Mtd6pwycOYo8z54fWbNda5+ZgSTKeJ31d/mplqECPjP3L3G7CMxK
 xvjx57DNYv5aJGeJYoX+bQ6gMRwsZF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140034
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

On Thu, Aug 13, 2026 at 10:23:23AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 10, 2026 at 08:27:30PM +0530, Vishnu Saini wrote:
> > Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> > compatible string to the panel-simple-lvds-dual-ports binding.
> > 
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Please organize the patch documenting the compatible (DT bindings)
> before the patch using that compatible.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Thanks, Krzysztof. I'll reorder the series in the next revision. 
> Best regards,
> Krzysztof
> 
