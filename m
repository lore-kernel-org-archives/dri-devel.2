Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DDBFEC11B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 21:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C5810E66E;
	Tue, 24 Mar 2026 21:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUc8eKrq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJOg+X05";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C50710E5F2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:43:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCsvC104359
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=w58gYwUV1l4ItIeSpmCHgD18qd8dug8WCJaRbNly3eM=; b=aU
 c8eKrqX5fI+LJtfTcZbeSmYmRv90HZMy4gCvGYF0H8VyUAFefeDLzJQaFfD+k1S6
 NbWcTPd6YHTCxysrxQ9IuWh7x2uREqEhD971KSufS28+BHX4x5Xu0yODxaZxzuWq
 m1svJP1zdw6zshfCsdQWX8lA/Sd/0yg/FZQIhjO/hvPC5Y3OkiiFemcA4ia37REV
 Ya7wSO89Fxdfyemgpv4b/Uo1aeSp9pL4+hRXZPqkAklMtktS41wh2gdUUzb7/A2X
 xBC192ScIRBp8GUTu0HObu59MyXj1T7IPe7HbFMh4xLAgshbd/sTMbqFD5GX1Big
 8/b5bnsmEBmz99g/nfgQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0jket-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:43:12 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-467954d5210so52479756b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 14:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774388591; cv=none;
 d=google.com; s=arc-20240605;
 b=Cq783Ew3dhDItZ8RNL/k+Yp5GjaukWl5K1XoZjygsxYLOoyXmmpfb0ZAHCFd1Z5Rce
 9TCCwq0gmKSM2in5gM+cVRtYGpJaX5ppP71n43F5flFnNkt4MwYeyOCEM+qgObketYms
 AsGjL4DWScx+/ZTKyiqMOr5Fo5j09CNzFgONPcbipBhkYjLnePfn0E04Ln3e+BTW4Wur
 4sMC9pzTXvXPODlaqNGSw+hFxIq9usqi5/gzZg9usPEr2NpYsuxO2uCUyqAWK68A0/JR
 bVVldTwb+Pd69DVbG4+hQGcmnCUnilvpWquvI125PBofcuA+PMg8RjQYdR5GkROmkgkq
 2ldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=w58gYwUV1l4ItIeSpmCHgD18qd8dug8WCJaRbNly3eM=;
 fh=sF3Fxpy4r0qfflQvszWsZOL/ZtIa2ivnu6avzz/V+zQ=;
 b=J1t3R6HeMmik67OySBYztJOj2oi1ASsRJQK8qDZWzX+X8HfGsF1QRJh9FSwbOIswxI
 Ijf8xsmSeRjVuHMCyciTaGj4SE6Hn4JBGOlW/ueWeWa0V/bovHteLeodJsV0VJ4FjlN5
 XF/8l2EDJEgQggMIl6Ts+eXbrfyNGPvLB02TyNSeAMnUja16FqLQkV7RsGre5OzkllYo
 9ODdZRLBfoIswb4hGQodO4YE7fxW9XIdat1G36weksf8Egxv37838oeG5cJv3u1+Sfnl
 yssh4wWWgRE+SmsgykOo0h3AU5SO9oBBfhMfTHWZ7cvRBPFDDUDRe8ww9eUv09MYuUlc
 Fq1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774388591; x=1774993391;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w58gYwUV1l4ItIeSpmCHgD18qd8dug8WCJaRbNly3eM=;
 b=PJOg+X05wWJB7jurCN+TJ1ejI/5+rw55F9HZsU2c7+9YxO99G0aM+TwEVR+IRW1R2Q
 Azb3zPNKl/R+PomH4vdtKMgs5FGzg9cLuiUw/UfIoLumh/8mXQCSr9PXQH3MiA0NcVeW
 oVTv79poB4dCmX6y1MnReHKQBPv8barHQAYeUgS1o73/JBEntq45B6noCr3JzwQnYKA3
 t/GF5WBulhBT4/E3oqEZjjM/CB9/ew5F2wwM5Jw8JgrgjM24td4m3nAMc3xSOvuj36fe
 DL2NrR/Op6TRUsMkMhEPZjD1yy2S1xDvT1IdXV9FVvPmMhoui3i4NtLqEuyrGq+KhtxG
 2OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774388591; x=1774993391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w58gYwUV1l4ItIeSpmCHgD18qd8dug8WCJaRbNly3eM=;
 b=dw9rsj6tl5r/ADLAlnW8/1J3kcOkonOC6+NZxP2eNmdDONr9MAJI9SzQNeJOzXhxvL
 McAQAmIZpPHdVX2fW16rOvqHcJ+pWDBKgUHHdwKy3vxVgRkUyzIbRiL1XWX5/1Af08zZ
 VgmZiAc6wj34Epg3ChnCfLxxerwedWxyLWgzh5NcBgiGItv43jD/zBVMev2yuKbIfdlY
 QtLsEaktj5kevN+zKWUPlXm3gGBr1Ez+NNC7kMZPV8Plc+JqedCFZOEDTYD9al1m3nx1
 6uBVP4j5OQKEKRUKIfkTP+TKImo55QCDYqYzrqimem/eSp2hkq4IGWHcV7c21vyPc+Ja
 CQ8Q==
X-Gm-Message-State: AOJu0YyaCJyC7xfJ3xgVwhafJ3iYRGAIXdJsVGKwqqGvh6yTNEqWwRav
 uwzuZtwGLDiycLTpsEoTxAYSqV77pTmvmHqetYIST5WwyUf3gLkCbZFmrXn4aGPSY0ltdkazbeB
 mhxpVLufSdo9MXEue+G9uM4lKdOSBTKtcPhUT9Yi5FWxipidQjJUAFZsxv1dREcPHWpy4RAv6He
 eZtiu7UwwLzhd6PJSMJUXYUnp5171QABhWhv+VMIpqZfvN8xPFp3YKcH7R
X-Gm-Gg: ATEYQzyrs7cEH6+bVUoj9H43SDc5Ezn1//z3or9UtUiC6r/dtj6ECKXxZPliArh1oaz
 tnehfoNhh5mMw+/WEQFMKM8mq8kykrbrQ6T6GqLFkMfglz9LMIEJ7LqrWOYAFZ9d6WVUhiqoArr
 rECCoK3eMRtMjskQi+Q4FzHaqvweolJMdJPYal0dNLSb5B5oWB2qmJpYH8BFBoRvKVr5X2fLfw8
 MIwyV7N2epq17xQeh/nSzS7rWcCkhjhVRa0OQ==
X-Received: by 2002:a05:6808:c1e6:b0:466:f57b:2ae5 with SMTP id
 5614622812f47-46a5c8146cbmr574908b6e.47.1774388591342; 
 Tue, 24 Mar 2026 14:43:11 -0700 (PDT)
X-Received: by 2002:a05:6808:c1e6:b0:466:f57b:2ae5 with SMTP id
 5614622812f47-46a5c8146cbmr574897b6e.47.1774388591000; Tue, 24 Mar 2026
 14:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260324214033.1219113-1-robin.clark@oss.qualcomm.com>
 <20260324214033.1219113-2-robin.clark@oss.qualcomm.com>
In-Reply-To: <20260324214033.1219113-2-robin.clark@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 14:42:59 -0700
X-Gm-Features: AaiRm53mUOBBEXXTGElWNDWMF71f0GXcbkuUdhmcBkK6174tM9DL4iGnCvJUjh0
Message-ID: <CACSVV01pA9rw94joFxaR+mOO456s+d6CYOsmSZzkcjrqFRrgnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: Fix VM_BIND UNMAP locking
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NyBTYWx0ZWRfXwoty4HVWixJ1
 YLCQmRoQNT/Zv2UxlCasEuFnkiyT2KugXd/L5eV/sX9bfYwANu8oSbFlFlQt69UZIkmzrXeiSAh
 BduDwJii/PVDt5r42ai5uMnkJJnaNNYuPqxJXtZ05Tno/1CUhbFm0gWbMlkB1e4QWSdNQTAakSy
 znFlIpcPC8WrRU3SGwwhqeDDsvQs8IUn9o6R6Zjcd6yfyJzLX2bmijRqcuya/r/TWlI3PNnYeHw
 j4HnY8TK9zKvDpnBXIZLJMhG0g9TO0ULEjg9c9hIFle2Qn94YhobT+G2myt94YeHxLW8c27lDVx
 1So9eDqgoq9PNkXROYt3PN/XEy85KY6wS3sukOaRFBPLHFn+O/v7vL3437YZ1Ac3WbEGYGx5oK3
 dlWDAVPNnM5NWbjwBta5ibsVmD2Ufq8eAJo56eutLpOXZoXb2dnIU49eHusJq9Fx+S/ADfQWFB/
 yYrBTG6DtYFSSCBulFg==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c30570 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=-h2ecdokoZO4K1dx4WEA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: P-pRcmYRVt36YK39MtZ8Gpk_8oeKbAS5
X-Proofpoint-GUID: P-pRcmYRVt36YK39MtZ8Gpk_8oeKbAS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240167
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

On Tue, Mar 24, 2026 at 2:40=E2=80=AFPM Rob Clark <robin.clark@oss.qualcomm=
.com> wrote:
>
> Wrong argument meant that the objs involved in UNMAP ops were not always
> getting locked.
>
> Since _NO_SHARE objs share a common resv with the VM (which is always
> locked) this would only show up with non-_NO_SHARE BOs.
>

Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/94
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")

> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 68a8f8f592fb..40892e206dbd 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -1251,7 +1251,7 @@ vm_bind_job_lock_objects(struct msm_vm_bind_job *jo=
b, struct drm_exec *exec)
>                         case MSM_VM_BIND_OP_UNMAP:
>                                 ret =3D drm_gpuvm_sm_unmap_exec_lock(job-=
>vm, exec,
>                                                               op->iova,
> -                                                             op->obj_off=
set);
> +                                                             op->range);
>                                 break;
>                         case MSM_VM_BIND_OP_MAP:
>                         case MSM_VM_BIND_OP_MAP_NULL: {
> --
> 2.53.0
>
