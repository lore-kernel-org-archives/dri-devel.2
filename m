Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50496606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=euxiU796;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PEY35SNk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6113210E467;
	Thu, 22 Oct 2026 18:41:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE4710E055
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 18:41:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBb03741656
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 18:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=RQ1yqWlhaAsFxjht/bbSB5+ov/E3vUlh1iSz8HtB/lc=; b=eu
 xiU796OTje+8cVlY6U4i/+C6P7bDnqYXdUj2RMdFdSBexnjTyOCz7wc4bqd+UBnZ
 PWhKSFea3qn/zG72xD6debCbiMi6ljW1naa+uqOHDpt1D0JJ2SVa5N4H7TTp62re
 ELqIFYZCNzrHm9DS2Zg1oXQfYCFcS/5i5RiTLzOF/BCwJ/79txmsZpv7uf0Uq0Qw
 /QpAmR9+EkXNXsaEYmoIjcnSzFCl1ARu+Y4lkFkcQUkvIzJTFjsdGANvZMo3dzmo
 16uYy0s+vWLLJjiNmM+7ihz9kCyeUsrqoIhQ9u+HeYxS4ISEZGRQGaLmDQ4CUFI/
 bmPfmkHL6DbrAkR8q9oA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms030e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 18:41:37 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6f4d828b9eeso105248eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694497; cv=none;
 d=google.com; s=arc-20260327;
 b=ZH3hhWJJokppDJf+Sii+bkRfmQlxdarla4LpQ3TmvmtNG/wXZbNlHULSSTCvbxtdFI
 XB+G8RhdkydB0diAUwz1L4+kQigKZz7AOywcxFU+JGSLvGKpDOPSrehTvXweo50u4L//
 0UiM9GzXoj0DB0c0jCtqAJMyUteU1rdK76IqDUWedC7LrS8QaKyVjZhYdMLmFTnnXiU5
 pumDeQeh/3UV9e7ZJbWztExHN0nclBJ6wzUfVyW8fncgmBRCgIjnOHKye5U6sLE/5ACn
 GcJZNg9kkYMRiK+ykd/dGwWoLCh638W4jVQ8bHAwM6cx8B6RZpiDdZ+lqfUSkLxEV6t2
 Z6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=RQ1yqWlhaAsFxjht/bbSB5+ov/E3vUlh1iSz8HtB/lc=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=KvrsVk6Xk+PyoqCtqklXybABmT48et6Bl9gX/i8B1QKnW+fECHrRu5zxBoC0HqDa0Z
 b6x7+V8rFUkl6KqvqNuQWpGVY+yBHtvbqmfuC/wGtbHyI8v3cLavyRhVQIV5biTn3Gxs
 OUYbdtig7kFIUlKqAY4qUm29ILroVz5v4dbZ/okMYbY12PgYYxyZ/v6Loy1Bfj8gV0bc
 SdxfNbkN+66BlMiWuQTm/14ye/tqVORevLR+RJ/f9r8oGFkAo9rA+e9mdx82ofx5gZxT
 OBRKhW27sD1vbGlC0jWlhZa/gqKEGgKWCW46m8Fi2u/hsFRH/JstLhMqA9uRxHqt5gJG
 yK2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792694497; x=1793299297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RQ1yqWlhaAsFxjht/bbSB5+ov/E3vUlh1iSz8HtB/lc=;
 b=PEY35SNkvHzUCaT9ROUkzl8oqri5rmHZeZ3aOccnb8EBjJAVuTLYJDTPD1sQlWz/ah
 1XWAr7dL9naDWF616V3d+CPMlmA5u4HpQYWdP7cz1Pu/lH1p13yqNSTeXNUFFmZeYpEc
 Y0zf6fxTB1FHQl01ymWlwHfznlXbss7Z6OInbIKYVBRSDMkPct5+WYg0VF6FRrOggSEA
 QVTz208fSW0pPViSSmuwDB2If8aQCUz2lZur63I5Eq+Jz4kJmc522hXepyGU3RWMxT8z
 1pFjwOtFS8+p4O+eDX9vb5hjWfmg5a2h3TUip8wgoYPwFVwEc37cFJx3e4+P4XYoGu0K
 Rg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694497; x=1793299297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQ1yqWlhaAsFxjht/bbSB5+ov/E3vUlh1iSz8HtB/lc=;
 b=BvUbEAFGw/emW9pkFt6KacfIYMKV6m1pNwXQn5BY5mR1tBCjmkNX6alFNL0tUbrVx/
 GvlMcdy1BxObbZI21hlKHXDr6h9lsKkia7DK+9VUMoQIPFWj6Wd4howkIidwWsbVmtkw
 mPTHWnY9AhNYfOey84fIQjRqVYrLW1+yOv8HqPz/wifIFbh5okYxzea/fv2ECqT82/07
 nQlIkwxGfh3qgFveAryW506TpNlMKxSplU89Rc46+Kwfk5E6WlOxw3QhlGCUTYLGqyq2
 5U9YAcB4Wm1gLqvprNRGoG+mE8d4CwSZgS5miW5ALHBKFOA0Gu2F6lM4zvaFjpdjUIlh
 175Q==
X-Gm-Message-State: AFq9FYII6kN0AtdGqi8YtASnGugiLCfzzmUpgeito1awlZA4TEiKWHUn
 1NMgBcY59fJXtckMgoAASQqybZmZKlyk5Zta+P5jb1ZqmhoivfJ9O98MurM2zlrTwU1bXEGRAcJ
 KrFUI0uJF0HNWSblxSXsQaILbgRsS7+dRMZKC6okZ1IBof195z+Ph+013W162t+5Hu3siQdhduh
 4W4r1daFE+ZxNi6WeBce+4JDtVdSoNLqK6dN+CvpDWg4oylg==
X-Gm-Gg: AYBFou33fxi+X6sCRE6spic80+E8sz58JtQUzASqkgLJFzPuOilaRidCy3/0fRT2mTI
 ayJYkVP+Ctr2s38NPYDjAVDqOv7LEBA1fRvGseVsNN+BawyG4yBuqq3VZOykEkb9o1siei7JR3d
 n42/mF2wMnUSckBnI0yh3bNOhR3f2c+xgdabD7mMFPo7/iaaP73sa7jARhmQ==
X-Received: by 2002:a05:6820:5706:20b0:703:27e0:354 with SMTP id
 006d021491bc7-70b88a6d3abmr141605eaf.66.1792694496783; 
 Thu, 22 Oct 2026 11:41:36 -0700 (PDT)
X-Received: by 2002:a05:6820:5706:20b0:703:27e0:354 with SMTP id
 006d021491bc7-70b88a6d3abmr141590eaf.66.1792694496395; Thu, 22 Oct 2026
 11:41:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-13-robin.clark@oss.qualcomm.com>
 <4069a590-607b-474e-9e3e-f7e744d3dabc@oss.qualcomm.com>
In-Reply-To: <4069a590-607b-474e-9e3e-f7e744d3dabc@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:41:25 -0700
X-Gm-Features: AclHuK_E4qF_ycx7Q98oHOhvhifI0LrSBbfrv3Y0YeWAfO2MHE8rzdoP5FSSzrE
Message-ID: <CACSVV01rM0-kgpoZHw4g8sEHXk-bswfXB7G5Va6fn6y9izxqXw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] drm/msm/a8xx: Switch to generated nonctx regs
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfXyMrxBZvcZjQ1
 NYlu4NGYNCf+mGXDpRvUxYcZi8regLoPnbq7bZD94Ac+pYJknZN+wPEDpJcu8GTOCUzEft+w9Vb
 k3fdF6Ilt8qyriDizP42GmJTLbZvoYcwwinvt4Bw6dN3+QoNS/DvfLQbYij3lyr+GR3IiPxT31z
 FhmOAT3dFoJLuSfyuGkB1Ao1xL5tjeV/aV1utgjiuSmoH227/luKqfKnLdyRVyAEeRzFINc7d5b
 1HY9E1/gb2oetyTIDmRDdRF+65NHpFFnyqaICwBhLV8YNbY8Zn5xi9/c6BhuzkSww/3IfOfeJQs
 t6zHstAgQ6WWKNs/f4a0Ajo/ZIWONmvHkizdmFuY7E/owCan/rYoK5w+Wg+fCS0VfCybWlB4Y4L
 OmnTPt8elnpWWH79O6rfW8jufsPCisnPNTFfH2pyib1bjKcDjGbvmBZ3JlIc700awp7GyPgb0+Q
 sq5bdDL7nKEHhHkChog==
X-Proofpoint-GUID: G5_ce13dwh6019ed41qwzUInoYsoqYQ8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfXznSRKa5AOk4k
 1PL87PnO8CH2OD2bpJoUXQXNl5czrYDR9NmeavWKRTfMSeBvlg7oabiu5nYjxDbwd2xgxzFoafJ
 BtdwEyVfLoxxN7xMxqss8GyHFP5qAsY=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada58e1 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=b-Rxe3tx399ZIUr8oAMA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: G5_ce13dwh6019ed41qwzUInoYsoqYQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220074
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

On Thu, Oct 22, 2026 at 1:04=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/21/26 10:41 PM, Rob Clark wrote:
> > The generated headers contain the current (at time of generation) hw
> > recommended values.  Using these directly makes it easier to stay up
> > to date.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> For context, here's an LLM-generated change summary:
>
> What changed
> - RB_GC_GMEM_PROTECT is gone from every generated table. That matches the=
 code change, which now computes the value.
> - Every generated table adds GMU (GMUCX_*) entries, and most also add RBB=
M_INTERFACE_HANG_INT_CNTL.
> - Several hand-written entries are missing from the generated tables, for=
 example RB_CCU_DBG_ECO_CNTL and UCHE_MODE_CNTL on a810, and RB_RBP_CNTL an=
d SP_HLSQ_DBG_ECO_CNTL_1/2/3 on a840.
> - Some entries keep the same register but change value or pipe scope:
> - TPL1_DBG_ECO_CNTL changes from 0x10100000 to 0x10000000 on a810, a840, =
a845 and a850.
> - TPL1_DBG_ECO_CNTL1 on a830 changes from 0x04000724 to 0x720 and from PI=
PE_NONE to PIPE_BR.

I've fixed the PIPE_BR thing.  But there are still a few other issues.
I'll drop the generated nonctx list in the next version of this
series.

BR,
-R

> - PC_CHICKEN_BITS_3 on x285, a810 and a840 changes from 0x500000 to 0x400=
000.
> - GRAS_DBG_ECO_CNTL on a845 and a850 changes from 0x01000800 to 0x0000080=
0.
> - UCHE_HW_DBG_CNTL on a850 changes from 0x01410000 to 0x01010000.
>
> Konrad
