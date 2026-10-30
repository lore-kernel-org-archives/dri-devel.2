Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06557606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MH7riAKZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T4XFR15U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6684711268C;
	Fri, 30 Oct 2026 08:36:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED9611268C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F09T2721626
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=; b=MH7riAKZSiGO2jEj
 XWVxCXJWjvOyDK46m8K/q/ILwUqX9k6gFaLTogXB/2J8GB79vCfCdnesV59nhls9
 L9MrX8TwCcYGAWDMrRXRsrgUfOwHKeWZmyRLd1Aj6JLLzVKD6r2FEMnQdiOpiCu7
 vYTQRXh5WHeDpg0AYvMZM0PVeyb/YKAE2EFzohUHHmLqpGZpYW+xj2WNsZElYPLG
 h/fthvX3S0HPUPOpNSdJJwT3Yyz+ULZaz61AHXj+u6HBZjnDm1ZdhhYCHQ55QoZv
 QB3BjlYVJQo5Q6nAmiL2N9lDmngunpWR+Gl1zbaccZ2A2qdYXzyoZVSMfLX7NSC7
 ge7BHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj184-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e629c7b16so9567285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793349358; x=1793954158;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=;
 b=T4XFR15U/najpSNA7WqL6qTjvoQzN62u3XaUfbVcW6jxkuYuXEsRaZSPq/ee6EB9Mt
 yj/3LC0eSbj/foC7SYBrIc+AhcecOUz1W6COxWFQm70oqFittLfj33clyZax6P9GMJaf
 3R//GC3ZAlB+GCiSJ3VLgLxAZiPL3xtYyZADwX+swjIzt8Rk52MUP0eJuL4iclX7OyeU
 nIrGJR/VhUZn/kGX0HaCq10OCDUwy94YtlauCjt4wdztnAdMiJfaShW+K3h3xqJKPBti
 /6r/SM69uT9odyQ3jfkQHUQWvRFE6iEvlm/oN2IcYlu+77B9TuePAXe2MoLqFSHinRP2
 aQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349358; x=1793954158;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=;
 b=de5YeJ0vrrnqu5rf2Wn9LAjeGVXT7jB+5DAqf7hGR5Fxrxx7zdQoM8WXp+VXR388gX
 unO4PAvWKUw/825QAaE5+6Y3Zcx+O3nkD8d0a1IWX63h6m5Z48DwdTJlnGRIjqeAyHmQ
 FEHrMXsKqa3PdVIXNWjARHSFEFIr0lhw9HM8R+G4yeXfQW6+EaT1SSmxT6h+cJdclYPO
 fyzI/SYl+Fa6TtRM3X2pYBN008ANX7m1R9ihPMkMvwNVaRXInZjop4151WaCoQk42rJo
 BlpUd8ugBaXz8C8lJ0IsWRUMQjRzyCpAMiGleSDI0vTmyp4tXYgP6uU05yja0A1X1S+q
 TfJQ==
X-Gm-Message-State: AFq9FYJnrk1oen9U16uflQltNL1CKxNlGeeCrXyt9MHegqXo4WWY/LHc
 KxtZP1tAnsFESaENCAExev36tuppzeLrxr3kkO5i/BpwygKH3XL1/qRNOQ+/SKQJUNrLUEJ7HdB
 XBUiwII5OX9TbE5gZpQAUOhMSlyyem5GcHkKVHxsJiKh/eIV36pVVUzFK9BbsZf7M4CW3Ywk=
X-Gm-Gg: AYBFou1KN3hZzsKY47Re0At4ehcJvx1b1jQd9f8hQCBKbMS0yoMxsy5cWA9PVs9xjEe
 rphRT7hLmJYryFrltw0bJZfM9Uilj0Ks6s8XRLSEsaFdur6onetaVrGrkXed7QRHaiAixb0/YLL
 6URnN0fWkL9imguW1GdapicZdy+n5LPz/A95EKHeI9vrHdqvIzmQB78EpzJg+AB/iab9+79Z8Cm
 f6AWCPLgHa2iPs1iZlsZza5rUC5Gr2JdMem58h3Xw4Deo25B0RdvtfaN2Xe0gBQ5VpDh1JrgfJq
 0oI15WoueKgxdIE7OZQGHnDJDsmvnx12x882UgWwPKKrFgXvptsoBiwl8LTgXPme/n+l05x3Dd7
 RV8LuNTRWs4IadsEath3SKLxwptBlMjnl9aPN1L0v5654bmJEq6f+8xZVtZ6mwsBCZfSxG0w=
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr261458085a.5.1793349358229; 
 Fri, 30 Oct 2026 01:35:58 -0700 (PDT)
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr261455385a.5.1793349357748; 
 Fri, 30 Oct 2026 01:35:57 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe0f504sm39083766b.36.2026.10.30.01.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:35:56 -0700 (PDT)
Message-ID: <dc2c51b8-41cc-4abd-b52f-ef2072593d1e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:35:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
To: Rob Clark <robin.clark@oss.qualcomm.com>, iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _zjtZFkCXtauqHtEyvImSx1RCXcDIwbs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX7ox8id5pyTzw
 Yp73Cb7bYA2TYzVdTvG7KZtKN5i/uDy7M+yVEgfiWlMYEKwwZfOAgfDkCYvpaRtWCe3hu4Lq3Pp
 MyDnr7oWCZeZsW2lHmq6mEAnYu3Ze0k=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae456ee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nPYanoZRiyYWTCGofB4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: _zjtZFkCXtauqHtEyvImSx1RCXcDIwbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX+6WuYyje+6h1
 Um+EVR9xTFrk2Exe8RnaZmjR8hiu0kIbzYKW6SdpK9qEM7605nej89+U8BoNXi7hpeBg31yh1oC
 Q88ct/cCGiftgrfaaOZ6XHF8jjDRqYYfqHJfktiFbZCW/ShGWuPkBABT0h9gY52ZTdBxRmii9PW
 v2Iz+MZjlTpwPfJN/fYZmqtLM+FirLi70C6eFskQ0eiQ8QWcrJt8cRnolFenI/NSJZba2q7RapE
 0NJeoYTcgxntpl4EwOkqfKRTNO3Ua24cHJjnoxGl3ObpPn08cdEAq8DFY4oLBmJDUiSjfb7rC8U
 17ANL4U3v0EudSuE6Q7Ox5PhP9dnHqpL3gF7qqb76f/w1k/LFtGyNqVi/f/iisLvZcnbtPLx8it
 yhEpZUVH9jLhj3gesEy/hBt+U7Uca7/OeDxSQqOgQs5SDRsPZsDz3MzEZIUTp4aQr6yXj9lCiGO
 gberL2yh0/TLxZQX3Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:23 PM, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
