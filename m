Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E28606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D/0F0tJD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHM1dGcG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEBF10E0E9;
	Fri, 30 Oct 2026 14:14:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD24112828
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:14:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UDnVnc3431724
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Jaru/sr4U9yir9nA9QRFkdDdW1X3YADwZa6Fl4aEpI=; b=D/0F0tJDf2Lllyzr
 dInXChbQXJBWuhLcixxOCSO7eYhukDPdCMVAkxA8qtVOsxa3CKmWdxLAvJsGHCgp
 nDBP7gZmDpzxLPSGFaKxPbCSUM9UA/WV40YDEFB/R591WypnMfwNlVlBIf7p5rTc
 CxAppIgwIDRAFjscogg7hw4I+KmIxEBI6ZpwMfnLWei7MuluFd2JmMIsoyHHhFbq
 eFiQ8FOtlS9carTAf0rLsDlThzE4gDIdaiOGJErLoxS36tuFLMVkdsZ6X9UxhQlb
 qRwvohziZCCTVJywMnEb1ZYmb7ng1uVN5n0+TbdcUHPUYynerYirq+IzgmToxfKY
 GIn3+A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkfcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:14:31 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eaad898904so30824e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793369670; x=1793974470;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3Jaru/sr4U9yir9nA9QRFkdDdW1X3YADwZa6Fl4aEpI=;
 b=LHM1dGcGclyKH045FXeG2nCg7/UYUJkMgcfSPscb8QNCEMKYvHZElYuDh3TJCJwy38
 fq0wrpwrWlMSpPkkHk0M+d/MHcaqCWYqA4/PbKHcJ7mVM5S0rKZAKl60aGzy4g9vnuVO
 Sf/1m5Hr4N7XF0sorXqIAIJTRVp2aiB3W8b9lKt957br5WPgFodVEA8AsouGX4vJ4AAJ
 BWAvRUhM33dskporIvg2f2YaqYVKUtlDeNVOtfsZqXEfhUj4/ud+0wXCcuXyyvP4Z5kL
 1FFFnGjBEeIw1TsM/6DElqwsnQGXjXoXua0MMHrK2BOYFkhO9u/MovUOyNdHLxJkGSn/
 GrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369670; x=1793974470;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Jaru/sr4U9yir9nA9QRFkdDdW1X3YADwZa6Fl4aEpI=;
 b=03bq2Cs2jE13tnL8g0mzOAC+iRTHVvfU1DwMMtq1q5dB1kLT2SHmoNqssYtVBsxO9y
 UFB4q5Vs7+heFvxZDm0V4b7guNWgqbzfj4wvjOwC2gRbL0/Kd/lRaiSiciZjl+HBck/i
 ZJdW5MEAX/D/JbWu8pcpkYyxLaS3VOT/DRy1nzyqb5DAM6H2tT7IWLVVTytvo6vSSjdP
 tR1m0KdpixFuKs62gB+KIylsxHJAIdGJFrDZQgvKFa12GbITJfosY6ibEqab6Mys63RZ
 BNVjhi/XkWc4vEOx+6w/3x03slNxwUyTjKByJi/Yy/rqHobv6iaQB5aV3HFCZaSjz42b
 C7Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlR+0uaneLJyPrsBGszm+rwMWbM3NqamQqB6Ay8KG4FLMhUaH0UvTCpmA9smqToXpbhfUakLCkOYQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJwzo3olJnagTWcG40cdtb6+2S48Uu6qonJoIwCoT3RYMHgUiDn
 2Ry61oh1P12yK3fVIhvyUr66+xS9iPyG2iapRy5Jr5DfzNfUlivcaKvVjo6VGsC7oNyGvfHaIr/
 kOAsa26rk55P3RwPII8tmhcuWzgW6vDtINAUswdQ8W6wg2ZcB7+EmuWOHSY1mFtovm/Iijvs=
X-Gm-Gg: AYBFou1w9U/5jD4ebfIBNDAh3De9We8hlbmNmtG1w3sNuRRll/GpjqhM4XQA/p66wWS
 6LB7J64Pj+hj42kbSfx7cuERkgrkQru5XsycruLMMrA7RZHuNLFPzFmvEga3n9Q0nAd4zLOODcz
 YgNhIUt5c/bZPkiA88I2c7kL22zvoTOvZHE+2/1T+opIFeRMj+iooAq+BIwoFE0utr6HmAuhKiy
 tSPah8X1m4IwgEx7o9a/DNdbVWUPXJcV89qErPFHmzu3pdNR71LnoytelkBnZfyYtUS0sLrXMQ3
 NeSEq5pa3RvN+2Uy8BQJjehlyuAn2rmWR6t+7/p4cMZbOd1CVpflsXQK1alUzHRux6xdaCJCaBb
 eFuLcXGroj/44iAZS84MaHwN7vEsQZdI14MigNcs6k10X/9dwojDBtKLYBJ0sPA/fbnvEY7Xa
X-Received: by 2002:a05:6122:4a47:10b0:5ea:cc1d:173e with SMTP id
 71dfb90a1353d-5ec6851cd15mr1215910e0c.1.1793369670426; 
 Fri, 30 Oct 2026 07:14:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4a47:10b0:5ea:cc1d:173e with SMTP id
 71dfb90a1353d-5ec6851cd15mr1215878e0c.1.1793369669938; 
 Fri, 30 Oct 2026 07:14:29 -0700 (PDT)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc18ed0sm70345466b.2.2026.10.30.07.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:14:28 -0700 (PDT)
Message-ID: <eb461324-2ae1-4e62-bced-e662a69b19ff@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:14:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-15-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029201730.151754-15-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4E0LqMGcJZRR6KhUoSoc47AjMCthwChB
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4a647 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6Pdd9y4b2srEKQt70McA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXxp7zEZxnPS2Z
 GYfaQC9LyS0THnGZCAm6AJfyxD6ym76KW4uhCj+xC3D8OBTI1ZgcBDDTdd96XXdAnhtKx2FWsZC
 wOu5W8cX0SyzOJiJAXcg3Gk5KGWpZbK6O+MfI/xzdMkYGKVELCRsVmvs9h4STJ6H2osgCVG3Ot7
 tax1/h56ZA7FDm2cZDCbLBEbVCno+Y+XDcTw4DEYQSkwaQlCWf8z5SR85HDpJXL35uIDFwdbwN/
 TvFhwIqVX8wWlUIyjxWJF27JC5gmS8D+ToAAkHiKqIJPsdmg8azZEH3W2CxspbLhhaPEa3HpnXE
 fXmX2+8FjZT3jrtOe42MX/roE0T+qhCRzSbBughRzjmeobds00/sqTacbQBpkekBnG8dG+ChbfA
 C3obMj9984HDG1zruw7zGhiN10yqYDMo6SpIpNxSy8ibo+EhFKeIrztBSyUE02YztUFa9fAdWxn
 VBa7VfNppPq29m9tITQ==
X-Proofpoint-ORIG-GUID: 4E0LqMGcJZRR6KhUoSoc47AjMCthwChB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX51rWs/W0QbIC
 EdRt+5RdQy8hl+PugyDeZsLz6L2p3rlnjeTAHqaBAzek9lFOWiuet9MMZU9CnDkSbwi+MiH9oAm
 Cp1ujTEgRuVrM2m5x3Ml7szaTZt+wGs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300056
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

On 10/29/26 9:16 PM, Rob Clark wrote:
> If there are not enough global CP_PROTECT_GLOBAL regs, we can use
> CP_PROTECT_PIPE regs for the extra spans.  We just need to configure
> them the same on all pipes.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
