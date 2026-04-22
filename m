Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA0F9EDD1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6919010EA28;
	Wed, 22 Apr 2026 13:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bu7KSuGY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HQN5XsMY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DD610EA26
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:36:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MBDF8N2123716
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=g9nefJHLcFDzgFYMQF2xfJqqHCRUAKm/oWLJR0bSSUU=; b=bu
 7KSuGYhMoV2C8gojbjrBV6e/xch/wN/o+rlqGsvc8t5BMIIbGcwaTz11aZyOf9nW
 l42ECE69Q5KaoDbwgboZkZx38WBRV4GVjkTMs9a5njGMfHiKKYCxBs+GLQL0f4W2
 IxvfoepR5GeCSSRrvg9MrUcDJNyRaI3n79Rxi+odfY7NzStx2UQpCXN4Q0w/pF3s
 tVIYgHBV/0o7JSZ1Vy6hXvOE8aBWTP52cTXQJObbRJkB28QDqej38tukB+JbOWdX
 DEN2qI1jcez1uMzj+knW3OUw5KUz5jFHaP7Jl7VGy70imXKog69smqReOn4+hU0S
 0c7O0gRaZtuZGGpZOxbw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfuk4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:36:27 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4798b1ef934so7199084b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 06:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776864987; cv=none;
 d=google.com; s=arc-20240605;
 b=bXApR3cq2AGwshbeYhixlMQ//zXlF2n2FoEmr6ZLgKD3qyKHgctNvY6s6BoYY1r3ym
 f9cWkpf03HuT36wzUuMg1utr5e0RVlqi7ROjfzgneRmHve1Uu+Jr5I85GO7CCifecJJX
 iG/QFcsDEeXxNa90p1kPqd+vFHZZXdka1utxahE4c1tU3QUoOsIlIQcuwUQdcT60KPJC
 HtjJeisu2nobLUUuaXZyh95npjL/EalUqCm443y8R1Bh1YMZ6kNgCx94iuVXd9nhPn2k
 Fusf9M6LhLnb9O6+10t+LPByCY8ra/R6DTaTOyUKVaz3qY8njiMWhB0h1a8C/Xb8NWqc
 Bv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=g9nefJHLcFDzgFYMQF2xfJqqHCRUAKm/oWLJR0bSSUU=;
 fh=hX+6SYSFSVFCs09HqOcXxGYKc8cshKVRq1AGqwXH4Gs=;
 b=azjS9lFH/VgO1oSJEigA92PCuOCJAuE+3DR4R1j1Ajh7h1P5/EjTWI65ivZy3deN6O
 CIFhnI1Sw0KcxVgtXCgxVmj34cxWAkE9G+ojOIwGQT4VT6FUShBDimyjoMsHbVrrXYP7
 ErHa0pPj0LjbrCCDhaKQV6qdYbhqtBrJyUu2TZAGxzhr2imuYUio3el3iBM33yHzcLlJ
 ZpGmDL1d0mZlbNG4JIMjtsT0NxOzK5mrTM3fmwT83WmDKgrX9W5AInXZgXydQpC74mlu
 wuDadWTMGf4Hwc6RKoQIyn4y8sRGN3J8l0StuhPom8kQ4regyxbW140oN+GqggxdwDdi
 UMtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776864987; x=1777469787;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g9nefJHLcFDzgFYMQF2xfJqqHCRUAKm/oWLJR0bSSUU=;
 b=HQN5XsMYXVBKihdluA3rPsUV4QNdQHSct9m4q4vtdOTUAgxlgxqDoRGmYVQpazJ2Pc
 VmzpWyRH7YRLgVdgWvlbDHYG+lmlbzAskuzryL3KiBd7VcZ1o4GqEcd+QRPk0Ry2fB02
 Pl/l6uXX+BMcACISIOxmxldQYQ7ygQTPcEkE8EGG9jlULaWAaulrv0OiEip0wruXf9sW
 6abLDOaP/vCqT8PDCS+vVutmploptd9hYWwPnTNDa7vj/V886IyWydL0CGjFjtrb/r6P
 qhnZAs0wUmFiLrt91YRRuAaOHLg8OB0S23kZLc5uPC6RAGsot2T2RI7ZPK1M69Yfdt9A
 C2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776864987; x=1777469787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9nefJHLcFDzgFYMQF2xfJqqHCRUAKm/oWLJR0bSSUU=;
 b=ldbIMqa019XznQ99VHv9ILjQWde8rE6hiGwl90Y08r4+YecFenjWPoCoURcJAp2tUD
 1ZZR78/q5c4y213jpCJA87DSdQ/YG/U5ExcDay/osKzy+sLi6CZWvK4Jp25kAdsTwJ52
 7kwzndWmdcgjgXjXX/sr8VK/fQC3TpyjW3RvyhRuc2aKGQOGKnZ1Gd2IQJJd7n8Amztc
 ZwupBN129bte7PwbRKWBpKHgUatl3XJMu4B2M7RtFcSZXWtsOKIOBFRYhH/6pEhZWhIi
 0lEczYqDKEup0tsXVdkYIzJzBkBpCK0klw36Ul0J3qyDb+tULg9lRwdv3smgaYKNOHEp
 Cl0w==
X-Gm-Message-State: AOJu0YwivdcdQfRDfItR21+m2m/6cw+9q2X0xHhXz5T3jVH7G1P/G7zo
 wNkdSMDn6el++FQaO1BOfi8kTFRLCQuq8VgHi3gEp/7TgAIcWvJpr8aWaaOC6qiSDLeCMS96scm
 +2uFvjkgAouvr0cGxAM0sCUItcE8sMPzZPxxWA9z9DifHFQXCtqa25+VW/vhYZoLCmlc+3Mnv9u
 rc4QXWwnhuxDxdfCKNiKJjAjvygHfdF66vqmaj4m56OBSnww==
X-Gm-Gg: AeBDieuusJInownoAuI/9KKPRK/Fqn41C1WkmpRkkn9ql4+RI3bLwRaY1RX1To8HDEM
 WtqC6OtICBrj14idC4Ss8IQSJvVnhP5TX71ojXIECQXngI2jhhdP7gloaM9Pg+rxrStPOi2i8Cl
 jIDj8tbjiWv1L5qczmlf5+eOaD/lEh1ZamNjvJSWcG0axmDdCSTm7PAOLfQlDoZmzmnechwOAbM
 u0YLeHaPYIRMB7DjizfC15zzKJn04+/dP84J8988K4x2zPV
X-Received: by 2002:a05:6808:30a0:b0:467:13b5:8af2 with SMTP id
 5614622812f47-4799c7ec4d6mr13102262b6e.5.1776864987157; 
 Wed, 22 Apr 2026 06:36:27 -0700 (PDT)
X-Received: by 2002:a05:6808:30a0:b0:467:13b5:8af2 with SMTP id
 5614622812f47-4799c7ec4d6mr13102227b6e.5.1776864986760; Wed, 22 Apr 2026
 06:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-4-robin.clark@oss.qualcomm.com>
 <qpvedddi36ihfldioqep7alve7ah3lbsk3txkru57e22f4ud2h@rhxsnu2fovot>
In-Reply-To: <qpvedddi36ihfldioqep7alve7ah3lbsk3txkru57e22f4ud2h@rhxsnu2fovot>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 06:36:15 -0700
X-Gm-Features: AQROBzDpl_YQ4irJrW5IPEjK4Fxl70V756sJkA12Vz0QJ03GGx5p1Lde8HxXvx0
Message-ID: <CACSVV00pBmXQLTpJfH0-bD9UBvEgwrru_pv6Yw2BSQqEqO=FXA@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/msm/registers: Sync gen_header.py from mesa
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e8cedb cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=N1XRXrzMJDIqkiJVU_QA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: cO6g_RKHhw2aPwbIDwAkrfJPqAIe1p-x
X-Proofpoint-GUID: cO6g_RKHhw2aPwbIDwAkrfJPqAIe1p-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzMSBTYWx0ZWRfXyFegTqN+OaIV
 2Izk/9Z2JmAkBTnoUbr2RxNh+Fe7WoMzPvJ4zCbE8JfDS72CRnuU+WV5CFssF1d7HMwTyfw+whZ
 Wr5q8zQWt0FPwnV1U5lZaXwDsfLuZ2fqgOZ3KJV4oWEf/KWmfD586LcRS9Cm02cSh/NaeVEvXXl
 E/OnNFhg6MiQXeAHcw7zso/3xpw2jegnOh9BVI5OhrCBJy/joqYdmwNXcueeG4Z86+5Rp+EympB
 dTs3hTHHy6YZ6DJG9+91OiL1nrVafg5vlJ3EzzhPZzty4sOMPbyNVWx49FokOwuSu2DzR4UFoP2
 YELhr6yfojljSXKKMSJrtxcidB5f6tp639Dh2jl7LUGV9TBky6kWzWdliWjK97bIadaABIYPl5x
 r8eDtEzH5xCiPr5Jv7xwmaZx/EUEAFxxXizZdmxoMgfgH2ogreo4UYmkbI5PGlDgjxrYN7Rf/Ze
 GFwOUbK8VXkLzTEjX4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220131
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Apr 21, 2026 at 8:39=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 03:25:25PM -0700, Rob Clark wrote:
> > Update gen_header.py to bring in support for generating perfcntr tables=
.
> >
> > Sync from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/405=
22
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/registers/gen_header.py | 2079 ++++++++++---------
> >  1 file changed, 1146 insertions(+), 933 deletions(-)
> >
>
> Syncing with the MR is not so nice, it's a moving target, but I assume
> we don't have a choice...

final version will sync to a merged commit, ofc..  that just doesn't
exist yet :-)

thx

BR,
-R

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
>
> --
> With best wishes
> Dmitry
