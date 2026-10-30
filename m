Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hjE8gb/B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j/p/yjzj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC9C10E0B9;
	Fri, 30 Oct 2026 14:23:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD7810E1E4
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:23:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UDnZSe3469080
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Yjr0RvvmXOhOI5x8DKMkHT1XyeXVZPh6p80n/QvfSz0=; b=hj
 E8gb/Buf1te2qD5qTJO1a2YL6QQfCZsKF4VOQYoPrfzziWccpC7DCMd7N9os00c3
 wcoVX8ULmhHOyswUm8tJgAx2MkIrIGhyCUsrEuFJC2A6icUPauFGzEUywLZzWnUI
 woNEmnj/Ugm8Iz/Uj2Z/VYP/Z9T3aWfbeGYOKPRYsBAeyF1Qo2PUX0DIW10IkYO/
 jC8MXE8OXgdpgoL701MqonhfcOA11m6u1ZeyA5P90Rnf/AMMsjLk2Qdh/V+uhKU9
 eovfZcTeBmKSLbTwCRhYCZS8FsXcRJdxZvyRbgxIuLyvmWycI4D+pLQvIcNXRth6
 vAEcYLnadSvAED05VNNg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkdwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:23:04 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-458326d2d9aso898481fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793370183; cv=none;
 d=google.com; s=arc-20260327;
 b=DVOaMdpeiJL701D/NC8bwMqSBV47wdRkzB8WBtqAm0z+zpCl81JfMAfgiJ2g85/kjn
 eFZt5EwmwET5xubUbiRuqltweR81q1yAocmCUJdvPDj4jXW4gUP0+/4ggtYaeCxnUmJ1
 nxRZK7UN6JvSbPIHlr4RTPzc9+GUsEuWi9qY2eqbnMkMQ2vryF6v8o+LRYZvhaekA3zc
 Ne7IJxKZyzvB/8FiwYFRIHcPt+XWCFRk77sZPFxdjX1o2QzxwZH5rFOrZEn/qebLGueD
 UjVi0kI1nO66YycVSZ3IgGERRkhNBJ7M9VOLF7L9GaKpPcBv+ZVNFDHvDCgib3fxV2jT
 95Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Yjr0RvvmXOhOI5x8DKMkHT1XyeXVZPh6p80n/QvfSz0=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=IMmlrBgkWGAIoN1HhVxJ6S6+wlyJ33dkQTbMIDcqI8y5Bau1IsjjpSsTvHtl3mZ06D
 S+ciGA20SDm1lV/jjfcb05RpkoS5EjAGmfVK9SiBP9y224PhdiltRWpWjDEuYDf/Uyy6
 65U81/m5M0hxWpihaDgFizKZieYJscSrlFzhYHPyV32qPP2EGgmKta67fRIKnVWUqTgc
 E7bulOmTRamAQVOa0iZH7M5qg5ZIaK4YJ2pgs/hRItyYxcWuNNEzJQ2T0fpe5h0ndQOE
 pBdWmZ9dmO+srrDkh/2CGTBG46eevbyk7U1VDeHXkiMWKHhByoosZZv9BBmfQ94q6qzk
 +prg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793370183; x=1793974983;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yjr0RvvmXOhOI5x8DKMkHT1XyeXVZPh6p80n/QvfSz0=;
 b=j/p/yjzjNB4icPodZPZBs8oPioiGsV44OytSno+gShNxRpcD3GvJIa3XekSHLKXPrP
 YAdyW+NzmkKlz5ljqvWCws6e2ZdwKrHGzfDDkgkxopdzLgZH2QykOvYvXhf3tNXR4cf1
 OZl6I8dK5J1UW1ZuMH0zonUk756ufizcvsQIxOEJHwTuguuBC9qAIjC35etD+C3d5iD2
 mlgAOPMwJB8WyzHnK95GJAkRnyrfdhreo1JxYx726um4JN7sylVwad8/5ZM1zByA5Jue
 EB4+dCMEv+oDkfM3oOSfbcyU2nPGhlqE/pglt6pY4irLJZBZG05TAklnN7vkTauwL4I4
 W8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370183; x=1793974983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yjr0RvvmXOhOI5x8DKMkHT1XyeXVZPh6p80n/QvfSz0=;
 b=ISzdJ/SEbMDiqNfVozaint48dc3vG9yR2xep1pV6mYgYjvOuyNz427gyjfwWppSEbV
 zYj7zr3tZywOMRO+4gpbRKb+vYtLha6dAIxUIrXQ97vcMiHDxlVIkhQhH3CLaGMfhGph
 36+hv9gaEJnRmRLSRt9MtTHc//HajAbfXhdfsMJgAjZZ4OHzLxXiymTEGcXCE7vfisRs
 /pgecTL5sS8GwleY32vJ7OXuUcAK0nxlm7JnXMGtv4Q0lvRrw5a/LrcbWoACyfg+RPPn
 2MGZg7YP5x0b5PuB5+wTEA9+hfq6Fsx1im8Va2C/K2fA4tufX3tL6Y8aRpdXoK/oSLRL
 275w==
X-Gm-Message-State: AFq9FYLImS25obCMo5kjQ067SDiWYLzhvLAlfR00vZa5fw8He5iI5Osd
 7BjttKaoy8i9aFFhf4Qfu50e67qMXI3d2snvaxYjZVxsSD0tafow2z2hZeRPac8++NUD07kwFOq
 CtQrKuaNAlXYPsk+0xRXXlIwzOEZZ8l6bRY/TEYBUgVO42PAHvO9QWAdgnis8z328IxvlCCTsWQ
 YPL0WRHvh5QbpvV0zh5+OeyWSBrMPKWxtR30v74zLBSoVhQw==
X-Gm-Gg: AYBFou2rjd0XC8bl1eHWhnYlifs1ZHkkg9Q7ov/LKQzDbD/YZEBzTduN1Dsv3eELAaW
 5L/dFx5FMVKpGbggl3tJFUgtbK5iFG3zhIQCmr0IU/sBre0JgTYiwUOpgcxdjXap98TNw/R0YMH
 nwJghip8/fhJrgPAfKvoDusDkcN4ck6bFbKQ3b0l4y5QU6iQ/kgWzkvbFK3Q==
X-Received: by 2002:a05:6870:702b:b0:4a8:1837:bc27 with SMTP id
 586e51a60fabf-4a9072faaaemr1677706fac.3.1793370183380; 
 Fri, 30 Oct 2026 07:23:03 -0700 (PDT)
X-Received: by 2002:a05:6870:702b:b0:4a8:1837:bc27 with SMTP id
 586e51a60fabf-4a9072faaaemr1677666fac.3.1793370182955; Fri, 30 Oct 2026
 07:23:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-8-robin.clark@oss.qualcomm.com>
 <0103e15d-42e0-4e8c-9f6e-ebd0b56bf3cf@oss.qualcomm.com>
In-Reply-To: <0103e15d-42e0-4e8c-9f6e-ebd0b56bf3cf@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 07:22:52 -0700
X-Gm-Features: AclHuK_L_2HBiXq59BCEL1wHfkKwJn-aIJQ8gMMWTwWyz_La_kw_FYR72xePUcE
Message-ID: <CACSVV01QNDTkri8WB4nwEHjOZA24x70LfKsqJa4sp9NmJp9_5A@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] drm/msm/a8xx: Stop getting GMEM_PROTECT from
 nonctx list
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PRf9FwFC4vh7t8WbhLoMBDRVS69yGoMj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NyBTYWx0ZWRfXw2NWbM3WnvOM
 epXPTbnWM0M1v2zrX5bSIINDhgFDSE0zWUW/tPpHKC1OVjY7ptwIBx3gTUsES2ECa0bwbe2Rvau
 RvTdF4XKmeKX4AJ8923aByO4lhTh7n0=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4a848 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=WwG0zxbtD6kTrJi3JyUA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: PRf9FwFC4vh7t8WbhLoMBDRVS69yGoMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NyBTYWx0ZWRfX/Wa9VxWniaTu
 3lSLjyKmuuDeaRdX4oS6XIRPTi0pjlPE2suhuD25swgQ7vHfg8yKpwTjT11NvAVogulhZE87hK3
 7hjS9Z2QwjHbk3GxD/trYIJnZ0lwDKw02G1L+L98NP5mkJMAeuMoACwKrn+rt5o7AH+6EK8rH9+
 NE+MeFBJl44hnvtWDjUroUi9zH3MmkZgrmZnGpuKqHjIbieD9cjPoaSVxXH8KTM0/hXCQZrLPR2
 xhFOAJJ8Ls5JOfdfirTUr42J6hEAm2pUbWnylWNGotXqy5i9PRcU4fKr6gzY7HfqPuQ3BDQbtJh
 Xk3sd15zOuq1slM9j/aKttUIg8aop/CACCyCaS+Ul96+Z4PK9Yjrg2cVOZXwiaTz71L1pnv6oJD
 /h3M/pnAILOndzd0t3Y9jrFhbidV6pC45k1T5Nin8P2sfljTQS9Pn45WBAeW1U4ugeE2ANb/F4L
 +DYy8OvYW9+swYjCjnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300057
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

On Fri, Oct 30, 2026 at 6:43=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/29/26 9:16 PM, Rob Clark wrote:
> > We can just simplify things and calculate the value, instead of manuall=
y
> > adding it to the nonctx list.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> Should we drop the entry from nonctxt tables then?

Yeah, since I punted on using generated nonctx list for now, I'll drop them

BR,
-R
