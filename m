Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EA9CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288DB10EC51;
	Mon, 12 Oct 2026 13:23:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF35010E57D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:23:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxsSJ1404376
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iENrqNPzMG3pGs3C6u5aujr8
 2Gs7PvX4x7xUK/FQCmQ=; b=pvW195SnD3mOBU6n9GQiqKAZgqtcmA86QyBfTH7P
 rYLfQl1H/7bPQUvzWzSs5NN0mHnfqx0+idE84u3xDq5ub7/3D89oNRGZWzS2HSF7
 k1k1lf0EDuTgS7iX/1VOR0zPpXEmJ2uysDs0fn3+QPjtpeQ2RHaHYxfTSwhgEHAr
 5hZwLikPh+R2I0gi1JNNgO35cwJ286jn9mHeQ6oVq2GTrN5FaOAkGjUa4uMuDs3r
 v4CUJStCmYj2wd2t5u8hrG4Tclv0OQNwqtc+Zq78E56DCGdK1A5XNlhuYGVAtXpd
 Z1GwvysWt5M8RZn1YYlTn3xQqyTmtEc6gQTmSYu79Ym0Fw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ks8vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:23:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a0c25def6so2261292eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811425; x=1792416225;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iENrqNPzMG3pGs3C6u5aujr82Gs7PvX4x7xUK/FQCmQ=;
 b=LnmnUxs0UiZfXwzftk97wstQG8L2dGTlno9uvJ9dQJilo65sOh9xRwYuq/raacWRAF
 P+hBKIWqgD+POCPI2D4PXS99BEFARJcB9Rc1uIj/kRNalmSIJKQXOwmQVOmw6NMKOiXj
 z87VtwAiCUXrRZicKG6AtwzdlAjkoUcqQ2cvCjeajNIdfCGnjn/6eNdXexlgF9nLNKp5
 4SMi3SEdKSjSzGMBBgtmYjX9dMOufOtIAdK+3Vnqw0jpbeecCUJlKGt/SSvm5ypbFegp
 mB9TyZ6Otq0oOOfzFnT+dAaK0aZS70neJmVyoj/7XNU4XpqmgDs1amlpoxzYaAau72J7
 TC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811425; x=1792416225;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iENrqNPzMG3pGs3C6u5aujr82Gs7PvX4x7xUK/FQCmQ=;
 b=BgoVko5jigt182wQ3/Bpba+bvlU4nXqsY2OHx9vwLPy/Y9g2JZxStWqXJ9D84u1s7U
 hTOcl8UuRjrNFt/6NJPbAiTW1RPGsUZEv9+X75EfjVF2pDlh31YChe06V6ncacCfeCN4
 u9W/tbFJN2ynhJaZciHmfZAaYRWnaMiCEnAEkBER8UmrThMTOM6zofKMVn4GH7CEFf1L
 K1/cjvm9GBTWfhcwtwhl2yNF9pe2QB5bn1ah2Qd1UR8UpIKBfxTLiWGrZ9uIgKgzHJLK
 vNwHft235vflY9sAPStDPhjTXp68G1omoZCaXtmX3R+VRzGGTE1lJJL+8evnnNekhLHt
 +SCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWMLMGJTwO/CM5dNR+AGU3FR2DFvZu3OBIuJa9hVbsKES8MkdmK76/0ojj+dP3Jn+ebxwMUqteaic=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJVw+8NuSU8/TGOkeJ7VYuRxgKtgm33X9/jFmGslgK4xeZd4Twz
 /VkHRz+djN00Bkfhf6HxpkIQhe2r0EwEvU69IQq4MEHx6D3y0x6HHcYMxwExNsQrl4/PxXDPPzz
 O3IqFzQxkuF++bXLJ4rFBXin3zRzrWA7xLRCRx5HeBx8UdOtYB8D/WGd6sTUGGk1roBoglTE=
X-Gm-Gg: AYBFou3VzQC2/alB/FIYiLszPqwkMcVTRG4Rc5GjTXAJKEfRucAB+TuILiCOFYkwWJx
 ea1LuJDXiuJqJcKu9LSKJ2ifzU90/oV5DXK37nK2oN0f1GWIzCHEzh8T4okWSTOIr92mkr4UpRw
 cSwpjMKDoTSRrk5NvahMY9NBppJ2PABZRzBEFYjFK2nHl7CvRZGdogw9YYQMNkj8ZL96UvcljBm
 HRDx+C9YWC0LB0+WgcRXCaB+0v9iDOnV5k21CST61tU37hVakn/5CVbwaxWk2rI0lff53H3AS4D
 RETOQ0aKtEXq2yTnMeirVCj8Xvie+MpIRrRBj3aMCqEW4Xf5DcdivIBSQ+UEqdLUytHq368uAOx
 j3XW4KWHNkIlL+euIyXboK20tgwPdXn3W3wOrE6af+g==
X-Received: by 2002:a05:693c:60d4:b0:359:2a1f:520 with SMTP id
 5a478bee46e88-3592a1f0673mr9050423eec.24.1791811424537; 
 Mon, 12 Oct 2026 06:23:44 -0700 (PDT)
X-Received: by 2002:a05:693c:60d4:b0:359:2a1f:520 with SMTP id
 5a478bee46e88-3592a1f0673mr9050362eec.24.1791811423763; 
 Mon, 12 Oct 2026 06:23:43 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm22827811eec.15.2026.10.12.06.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:23:43 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:23:35 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
Subject: Re: [PATCH 1/5] drm/msm/a6xx: Add Adreno 753 support
Message-ID: <aszfV2EYMN00RJTP@QCOM-aGQu4IUr3Y>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-1-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-nord-gpu1-v1-1-a06a6c57bde7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX2aioZjTp/S2M
 H7mD2WJ5BsJTaoXnOwVwSgsandzY7yZdz3v+4/OG8DVUoNy8bDBjBWfkdHGY0g+tF4VlxLYSMHt
 zLL9+vO1cINelm8hWAWnjsCq9UYJ2OkH6lT9+dmiKmn17ALE9wsNIMp34RfsswC5hVXwCD+BPWR
 /dKgDaalL/HojB1lI3Rp93xlUPYR8ttS4kLiWvNvAKkfaI3h0p/vkuyjOwxOOqnE/Phfme+Phdx
 iNndVJ4oKEaKImFgdIPQF/vX3YKNrj2vIrww57wKubVWUnyzfE6zCvpkRTQpkgnw3gXg/Y88M7C
 /il3FUNBnNH8GXBduLp1+uOVHIwBqhn+J3qTqC5uFuXRXFDEcYZnveXH4DZfU2GcS0yDo5IwcoQ
 puzXc0Dpen2DQ9Cx/6r2qb/DLkElxiJhVVslUCv8usBXh1mBlolG4Pi0yxzkM3q3R1TZnMa0s3w
 8QE4/0kEAfWZcKXXdug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXwMuqsnYi2Khd
 Qp+gcSeVzqLm1yITkeZKe1gJj2lhiVt1ke4Xm4XKTHnOq2khrSnjSkElPfX60ZmkcUEkjKbWO4R
 dtdMdTIhqSUav38daru5S2DR3Xt+ly8=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6accdf61 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zFX0IjAEx0uK6ydxyM8A:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: -e9VDl5FO3WkWQm6KQ3q_NpaUZ828uuJ
X-Proofpoint-ORIG-GUID: -e9VDl5FO3WkWQm6KQ3q_NpaUZ828uuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

On Fri, Oct 09, 2026 at 02:36:35AM +0530, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
> the A7xx Gen3 family. It is derived from A750 and shares the same
> IP-level configuration: protected registers, pwrup/IFPC register lists,
> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
> record size. The differences visible to the KMD are the chip id
> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
> firmware.
> 
> The Nord primary GPU is the same as A750 but has a different chip id,
> so it needs its own catalog entry. Add a new catalog entry for this
> GPU and an adreno_is_a753() helper. HW clock gating is not working at
> the moment, so it is kept disabled for now.
> 
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

On Nord Ride and RRD board:

Tested-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
