Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3IE4qwQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nstwn5mL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AE710E139;
	Fri, 30 Oct 2026 12:36:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18D71127CA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:36:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG14a2071543
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=; b=e3
 IE4qwQOFgqK0bbRwjOQxAeUpHNDVsU5XPnIuBzxao7roUq7aP0qACrqYYEVkp5zG
 5oBydsI7dWtfmDdsNKVJ/XGKezJ11vkTTn39WTOWlRHhWm7XQ8U9O2seE4HDrPBc
 DEv6nU5H26xRc2yeFh2BfA7Mcv8yOzRNBRQR5yYqnWo0kZHGUQ/+JkU7xqUL+5m4
 Aj9VCtCaFuyFrHEZbPmTrPz5nJsZ/plqhFvb+pccGa5pJYSRrMwK3UMt7cH1a3ZK
 zSnTShpr58u6PKFXAWaz8ZZf4tJUfxIYGD44MirKKJCFnHtvV2H8k5ZzNQZjtU04
 YYA6jaOZIxkcMdNblQsQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p32u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:36:04 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-46509ab0149so595025fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793363764; cv=none;
 d=google.com; s=arc-20260327;
 b=fnibarmsCiWQcKGLHSfZ2swdiEjLcIojG0XgqRfK3h71T3E9RN4JdlG0JSkuP4lkCO
 I6VjGUUF5hF34PwZ5cmauxdZnL6E4WIQvcHY7kOMXv+hK4cxm70xOaUm8oaKlWejZ1cK
 kBKHQC/g0+L8/rzwhcQtTzM6OuvzvrC+GfQIze52+rzUaLGoIgJXkoqyn6lKsPtU8i1x
 zUsBxppQP8GuYZi908Begz1roK1nIdmQRFmNadIrzX3Uf5M8BGqoqq6HlYyOrhOZ1uxY
 AEQYWrA/pJCBFv4VbSweU4yJgkaPpOlTU3tZA/QTapDzOWCwqwLBJShKR6h/KI9t+c3Z
 bcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
 fh=UJ3tU66Fh4Wp0CKCsaBAO9fLAVsGABF9Yi0/+p84/AY=;
 b=arXEaoLDhLOCXFrLczH7ik7Xhy+bleNO3yd+WypJizXXcZFsouGSXpqyXQTma/flTx
 uAT2c7FX0wOKA7BqiOMoIvVDRHzriEOOKpCViCm/lyA98F3MaN0a/Q9BLNkkWsw2Ye8I
 ag9bffx1U9eZtD4+8fwGgLglNPffrXnkFh/I+Sskwl5NkusPBA7y5aLd0M2m28urIsEn
 vrnNiV5cP2IAHKMVymXVPj/S11w0dz+XW8bX0s8w8m9cY9LvmqTo+GteSR3B0pchNsr6
 RsNbnbxLNf0521FZvx9uTqXWuRr8UFpJxeZMGJXcbCZTx2vvdYDzDzYDV9Ycgi6WT9Nn
 dQpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793363764; x=1793968564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
 b=Nstwn5mLmFxydzcowIq6Za9pZ4lKf1XH42W+xlJ8ygeY/C37iwTGx8LBmHwK1cRbDg
 jQyzZBcVxtGdEIaBRWx2UB77rxZOKefPMOMUQNRP5+EhchDfTRjAo4+1ZBWsUXnypBZ4
 U5LenAljFlbRohe4FUx5Ls8q/RMFX9mCtYOAtbl1caqF90QsbfTH1HQkQTLIDpVdCzBT
 D8Fym8lvvqqLf3UegPwL0q7RUFloeNFBqyD8d4oWLazh6J2By2D0iyiIPelR0qz88qyd
 tGAxa4CgwYm0ustQ0PcfozUSZJbpbZQ1u48IaNvcK3KbAWF55ppsy/BtnSJpiyppF6OI
 tsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363764; x=1793968564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
 b=GEIbmI/8BokmI1vauY4H5UEczywWy1DZylURkp/7ihgttPGAywogE1RxqwlLtjxovH
 3PlNtiO2qJOnV6pnAANq/KDn3J3ipBUW4u24rQeoxKO62MZ8u21T7AZ+pagwxIBcqfRq
 q0/S1R2avxO2tm9sPKTtrvUnG0/CDavQk+0I5dg4NuxiTwh2NST5lm8EN7hRoIN2dRle
 hfaoc07L11yFmCckcqHwIKcLUCjmRAH5mMyWw1vmd3y8PlkP6UXrj9g9wJW7HLFWeWL2
 bUGM5QDBCDqJvXprxtIzYVRvu8q6gDrQZdluyO0ffcNBrnbq6aSVnz/1ggbZtLXFLtS3
 PTiA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZeRlrAbktNd73yU8h5Y1//z8hbLnuEck7aft2TE/gnLClpioIaxBrAp1qFMZbeR3JgOm8zf6skMk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOdC8h/j5ge5G37FH5eXpZE752eTb3/Z1MKfqEzq0/XVC0y2N0
 hEwHTFdW9kc1lsDOPeHYm+5377GtxDM7SK8i9R3lNRnHeqa7Y2JwX/O5IJ93z2WnmeVJIhfEsD7
 U9gYTcPMyaYVxCc8GtA0/soL9s4BIMr7RJDjuVc4PTRyBtjDWlPiPmfp3A9XnS+j9el+xIQkNIa
 XKw2iaXhiI75JSstrTLY3fQhcyFCyXZP37J0nn+9YrGTn1Xw==
X-Gm-Gg: AYBFou2ujyBrDzP5sHuQZKLaeqLakMYSegQeclIjh37Hq9YSk5jsvj+qEQa4+8sDtdR
 FOoj34o0KnOruZpp0Cip+LzDm3UhgkwoGAv7qNlWEPqPToq4CjTZohUFOkb/aagu02u7iQFl0eL
 VCtfW4qCRpD/yoLfbcmfIf2kDA/P5QyJ2gLgQgybopTX7BGNyCT5MlubKV1Q==
X-Received: by 2002:a05:6870:a104:b0:475:e066:7714 with SMTP id
 586e51a60fabf-4a9076f5d71mr1257360fac.27.1793363764190; 
 Fri, 30 Oct 2026 05:36:04 -0700 (PDT)
X-Received: by 2002:a05:6870:a104:b0:475:e066:7714 with SMTP id
 586e51a60fabf-4a9076f5d71mr1257338fac.27.1793363763749; Fri, 30 Oct 2026
 05:36:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
 <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
In-Reply-To: <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 05:35:52 -0700
X-Gm-Features: AclHuK_Kxv6J1o1Nk4jiUTeYgcQUlfsMkvo2Oyu2LlP58eHKHYlhfwHqpLn5bVY
Message-ID: <CACSVV00wrjhBHtKE6iJ=yvdPVaZ0RreJm27JQ9KaKy50-FSA1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX7lq5PUGpQ/+z
 uyv2kWvZQy95hsrGmTUxYftUih03EQuw8fiw4TG27DTBJfzkGJe0V71umY1FFF/y+/zo6qIawy9
 bZSxA+VP4HvnISr82cbKyE6h3/2XNwRChuLG9vYQxwydvUwf9n+g07U/pM2sppC/6rhtAEvAM1a
 sE1AK6D/Orfi6MDiGE2TynEFBe/xPvl5VFCKM2krjAeCjKg0WcT+KGM1/ntzjwAWc5XeGUpIe4k
 TDseaUJj7wwY0nSQ1bhS+dRtQXYg/i7xiF7rNRAwr20Mq29ZtjDS+Gxi+biczRjPBrVcwD21UZX
 FSs/K6nBys13K8u5aI9ZxjIwjGZ/GEvxllQd8VJJyxxVMqzTx0CY6gQfrp5aTj82PCrxXffyfMu
 Pv6h9UvwKdJK63OwEiSTUTc6enerYKVHpeZxsKpuAMMGiDbLCeL/DVAp/W8qQRqkU3YXUhVC1pa
 1C08L2QmBN+EOTISYbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX3f2cnJXC94YY
 Vx03lHpk2219Krlkqe2OmE9laAM+FIS06LMzAcqvToNKDCgpdDvoRcUWPJZivpODKJLG5afCSrT
 e1rkiB0EB4YwJ1vG2aVJSFPsa9sw6Rc=
X-Proofpoint-ORIG-GUID: v7kpX_wP_8sbvrL6itmh0C59ri5fTFQP
X-Proofpoint-GUID: v7kpX_wP_8sbvrL6itmh0C59ri5fTFQP
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae48f34 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=RaxNTMYahNmlKwi_CG8A:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300050
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 1:35=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/29/26 10:23 PM, Rob Clark wrote:
> > Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices t=
o
> > select direct mapping") for arm-smmu-qcom, match GPU and display compat
> > strings to pick identity domain time.
> >
> > The drm/msm driver attaches it's own domain, which it manages directly,
> > so we don't want an iommu managed domain interfering.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> fwiw I'm not sure we have any devices with this driver and mdp4
> but anyway

probably true of arm-smmu-qcom as well ;-)

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
