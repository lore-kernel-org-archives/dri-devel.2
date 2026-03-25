Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F099103A999
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730B210E6AE;
	Wed, 25 Mar 2026 02:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fdZtuiIe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EQHW7ObZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E99310E6AE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCxaZ2340457
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1ecNg33BXnd8FIwwFk/kNazy
 X5nLnep0wIUCVx2Mpkw=; b=fdZtuiIe2gYZknKDrne/4AOcYC415j6Vu+pDG2hJ
 tB/Gbk7Ym3nArt1oYdydIRUQnNtLp4XuNwtLMlJ/YXVxYeNCyAJCoONcAtGnVHfG
 167WiffsENSwrWdo3/bN08u0cKVBZ/9gzAbogwsfxynu/BfaapxTZJW7pF175Tqp
 +Fudukrr5Om/P3IKAvv33skDxumwGP/2zZM5cAXJhE6mmnJSNX0a/hR5WGxu+4t3
 bY2lHhlp43Zqqgr9OCRGA3HRu7eh/9T6hO11Gq6E46Fb57bdBR7XCGP/bhXBEsTu
 +5B58LSmwapjUo8RNRmwcNfIWNbTgWh9mGj4xudp+xaq7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw431f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b0601ff3d9so34416655ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405891; cv=none;
 d=google.com; s=arc-20240605;
 b=Y2E9ZB/4AV6IlSKo48jXsnvcI77LBIiJtyPsnpkwBfotS0uTPvUUYqDIdsEyeheZ0+
 mc32sUPi/GlH71qcfaqnpeV7ZhpD+URzafQSEbEZXiQXpijacUkcmUgKwByrQflKtp1X
 YyogN9YPCsOiOg58s/ThiJkYuNpDO+cc6srg1EWPxpNaZfnnWQOWof4meRU2xbtdglSr
 +W7A+xxV4z3GmOxc2QeuAge4P7Zsqq4FLyWci9mfPsmCRgNBY+bxQ4vUFJ4skTPINtrq
 foLWbvfO5aw/gjYzJ+PSEmOekDR56eq8469EVY1pOXkex18Jq7YAyMTXF55sQhj36h0Z
 VFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1ecNg33BXnd8FIwwFk/kNazyX5nLnep0wIUCVx2Mpkw=;
 fh=N6RnbNb50Jl2CC1ajC7sHIXqSXOzSMxWHUTdiLljU9A=;
 b=O4EcnD1AE/1Iu6HkWqJwdBk/3CJeG2Qr1x3KZBBJhnq6czGT9ax+1pPzjx4HiMt54k
 GewYvLz6Sf3akJbS2gcMylmZkOynRHuFJEtyv504oDHogIANATXUeSyNn1aDcgIYBWHB
 HE1BhWRKPp1GN57TnPdUS/TwAOEninTrQiTRWhrQ5JtaAR5stIT8jLWECUzJCvdX97Eu
 FkTyVAFLaXxIz2Axt75TTr1jVmv+FwSpFpLnTpDb5Wtc/dQ6c3X8O9XGvjWbe5CHcqD/
 wuKYmhd1d3QAoGEpz70o/ObhZqPM7Ny2UI3Q63CNc8GLbWeW5XsK9RKIwZFdcYx0q44X
 PLPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405891; x=1775010691;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ecNg33BXnd8FIwwFk/kNazyX5nLnep0wIUCVx2Mpkw=;
 b=EQHW7ObZB2lC1fJiOWdTtkIHNpuDOsoSh/np2qZu8akbvKImzP+vYL84zB7cRUkRgG
 0bxgt04HHbSbvMfwylTJT+HmVAWrp2XGvJX2MCge9fCDHOJqtSVCKKSS5b0QhgrdbsV+
 B14ybNm+6POEcXTi7IH84oP6IvqWP3YSigh7qpvJDSxYLXlL6e5QTh6rTBmLy72uAvOD
 Or51u9XftWkZl6ELZlokvRZtdScbrNlZ7G4e6qJCBT2+Ooi69RtX8EwjRG/5dRssZlU/
 pXupvwOTcKImjDe6p9le+LYetsGCy1Sg+UI1yKlP+LpeLx1kss8qCYpuMvWilXc/Vbf9
 SJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405891; x=1775010691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ecNg33BXnd8FIwwFk/kNazyX5nLnep0wIUCVx2Mpkw=;
 b=I69lTSYfql6s9NETlOtv8lPjeyL0i7kil4DW7MYqxmOANFnWnxFwpyMzzvVVdrXvEI
 CY2SB9uznGDKmGeUJZVKMV09czZQq5RAMwzD6TloeEOWahytt0MIitYPwY6XJuEC/T6s
 B4Mt0yFhSbPY89s13b9EUfxaHtEGhJWbvBp7U3zFedWolnAntbEUfiCfZQ8Ns7RoVp2j
 NQkycbF3xJUMNmSZvbWq6ZbOKItVSht68Lzzs+73VnAYUO0raz+kZb9JUKHFW5CalWMy
 EuY0EK7RVKu5JaNGx/GGfw9dBOwHmZmpF6BaKVyWRAI1XWcflh21Nk5NQ3ZfH8tH1Zfe
 yQuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYWM77sTM8SY0LYOZ/Yxrgl43wOPDEOwB5ISA/xhjQd0yY7eRjge3BTSEVbV57Go/wzKn5tTvsndI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzv8+1P6ZGJ89JvzkxHjoQ2ZOVhgO4BeQMAQRgntltfuLwEvWu9
 lYpWnR1tbXN4otZjOSsp+UVTzgc0xE+8uS56sXwfjCXuXo36Azp8weOo7+mr6X9l2uJV9bgAKyL
 egIU5wfJu6VbGFugNfwWdWAZ+V1KNC07fdkIhcV17PYSWddDdiu+SXdaOzF6QPm0qS3R8UnV326
 4/dUSu0hbmR49MzXCYn+Y2d6o/Rs6TQ4jpA3IyJL+PZiV/kw==
X-Gm-Gg: ATEYQzw7sTAUBwpHr+0ak6SXFtaE8Gqx53LCyCNkj+u5jQlFp4/lSQ1AwxGGIXKh3ei
 CcM4I++4oVHgzvQQEYthoXSP2Yy2Nspur9KEWA3Zl7FqPSdpLQOxPNotsTKTJnxCuXcm8XymJY7
 RP07819bORBWfqnqUfcH58B3RhCbhEpiHqilZtUcWIh9fDBOquddPYGSk1byEpTXX2OMRgWjMts
 k4Uf9k=
X-Received: by 2002:a17:902:e54f:b0:2b0:67fa:dbf8 with SMTP id
 d9443c01a7336-2b0b0abfc7cmr19727615ad.41.1774405890214; 
 Tue, 24 Mar 2026 19:31:30 -0700 (PDT)
X-Received: by 2002:a17:902:e54f:b0:2b0:67fa:dbf8 with SMTP id
 d9443c01a7336-2b0b0abfc7cmr19727355ad.41.1774405889714; Tue, 24 Mar 2026
 19:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-lt8713sx-bridge-driver-v5-0-6cc2a855aafa@oss.qualcomm.com>
 <177345419701.98253.11507693763985665579.b4-ty@oss.qualcomm.com>
 <CAPM=9tzAQaZbzpVw521cwBc2btWC4AK488edwuDE5D+Z6d6QYw@mail.gmail.com>
In-Reply-To: <CAPM=9tzAQaZbzpVw521cwBc2btWC4AK488edwuDE5D+Z6d6QYw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 04:31:18 +0200
X-Gm-Features: AaiRm50iUBDZT09wWWUTotuSx7Merw6EUyoVPC0MmHa3YQK_6ldwzXMeBMyZoso
Message-ID: <CAO9ioeXf_BAXOS6unjZDZ0G-dC4ktLAzBgFn7-tF+XE_oAxiNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add lontium lt8713sx bridge driver
To: Dave Airlie <airlied@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony <syyang@lontium.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, prahlad.valluru@oss.qualcomm.com,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Simon Zhu <xmzhu@lontium.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNyBTYWx0ZWRfX9SchflKVQ1se
 h22QHZzPVSSyd8/nfOGYoBWchTxMQHny3lrmmAI6PkznwEVkBRuLwP2d5QBApt0Sgtqx1VJU58u
 xdE03OoDR+sbJjbifJ7A+ahwxv4szi9oU6JqZlt3ZRxCrY9OzXAnheRgVxBytfJ0lpmjdAGe9qm
 7JTCWiovzIs5r28N2hyfucG1BrwxyP6qVSty1oLDl2agwUNz5ZmTl0AHN6aw16weoJRPqxeASZu
 vY+gnKtmBahkB27MQTm/csLbJYJ/jiW2aJPcyrVV8Oa9y6PgJZDmUj65Zu/Z6gWtygC7GHYZRQs
 LK5gSdUXi0kYSe8WFg5j0x9NMtZUaRj54nO2H030LoXbZM64p7WAXnvs2oLX1xJqYvkxd0CfrjA
 /bZ53N7ZPnspSp+fV5RGs4H0wWr4kZhNNWbC8gqah9sFn1USVTSln9/PWW0MWKuaHNbSVcHidTw
 oye/oOuDPkDGf8tQ2lg==
X-Proofpoint-GUID: BdN1DwD9vIrkQ4s3E4mVIjvNY7xk-pNZ
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c34903 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=EhbOz9AlyGEJ4U7p6VAA:9
 a=QEXdDO2ut3YA:10 a=GOxxtejO2lsA:10 a=QYH75iMubAgA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: BdN1DwD9vIrkQ4s3E4mVIjvNY7xk-pNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250017
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

On Wed, 25 Mar 2026 at 01:59, Dave Airlie <airlied@gmail.com> wrote:
>
> Can we apply the two follow-up fixes to this from Arnd, this is broken
> now in drm-next.

Done, sorry for the inconvenience.

-- 
With best wishes
Dmitry
