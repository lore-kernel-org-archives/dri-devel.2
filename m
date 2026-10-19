Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C10606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rd412vdY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PD6uJfpa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B8910EEB0;
	Mon, 19 Oct 2026 15:53:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B158210EEF3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:53:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOtq23158902
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=WkXGpXOWiBs24ppXgXlnDUbNGC4cGBni/AXZNpiz1hc=; b=Rd
 412vdYZ6pr+FIF/LqCVeE65wVB2AaKvNCcSUOW3Ygrv2XQ1O8BxNWia0WShOYeFg
 TH5bNmIi5IQe4w/0dWJoYBxI/cnkulrBv3h/HX+thbMY+N1VEEG5tiZ2FeQF1/Rg
 6WJ8nvgBbbetfszsB9KU8lqRAw7RBWjt1ASWAsJGENN3xSqwLjTa5bb6buJA8Tgk
 EmRY2GXxOsaAUjiQp/dFxxBIzcm/IdIxcPh8K7wnAbQCl9kOIXEeT9GA7ckii7i1
 PFuHmlJi7x1qUOiGInfJQzoy0uRP5ovpfqJEpFor3F3LP8AHWXilAeTSowP0M8FW
 FIlrgi2j/xaJ7bNJUT7Q==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xa1rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:53:35 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4a72bcd6599so2495553fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792425214; cv=none;
 d=google.com; s=arc-20260327;
 b=lTCk03ZyivsE6ZL+hHCoWj0WI/ULMWfg2mHXn/gTfKgE/MBiybw5iBIHf9/vA7+lvy
 32qCgOcA0a5Vp3LaInClCORq39XXg+Fd397iw99VV2G8X0kIylJEbjUfwR2KF7WD0vzP
 3YMaTDHK/oDccitqnI8Pa7nwGMoVXKlEgMMLbma7QbnGX+bbPg1Svy8lxfC2w4mLJSaJ
 7eJZL6ubeFP4zG7K7Qe7rcILm+xT1oKoUgbk0/FeOqCUemhNYOX3kKryNiN3VyWfO7Eo
 XlxWddn7s+x7Gh5Ld6RgQZTtJ0iDgO4vvplTL9DFNXzxy5HIAHE1IhtAtQ9kElHs/s6+
 DCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=WkXGpXOWiBs24ppXgXlnDUbNGC4cGBni/AXZNpiz1hc=;
 fh=wflfke/ZVpldaQXYvnujcEpAMDGPOWmApJM2o513gMg=;
 b=Uqe8wwjyEDOhYoZ1zonRLnPlEQpZR1sXgji9pTFsSZHKyf3pjz73dU2F9O0ZpREEHs
 jHCLGn7F/9b1KXOJu2fRNZ9qgXrkfqStRGBLg62OOOMjoYPkeqNYGh4STdr9n5sZuXpj
 nSuTjhBevDvdvddJ5vPiAMoIY/FImyPSGQ/rhenCjlp0LzIsz1POs1Nejp/z5SkiRola
 zJZ1nfnIvqN46FmgqxZXmWvs0VjsUv9B6c/fbEQfBB8t40cxFSp8Gdydi9M9BUO2nV1i
 nH2DxYqa015RLbwa0NYen8teqIsbmdaqUKUxSRAkwsyCN21XRyz0tY7+Tf8riTaGyuYv
 RBGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792425214; x=1793030014;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WkXGpXOWiBs24ppXgXlnDUbNGC4cGBni/AXZNpiz1hc=;
 b=PD6uJfpaYCvbIR4Vlk3AhqpqeHAWvblv0rnzfa2uWs89bqlFlZ60oo/KR8fwbIgxK6
 6QqpNBY9+vSHY76lXwoK6MClsV+n3KcX2oL2MvtdAf9O7V+ZaWOWpweBQZcJ+EabnQ+4
 XtT6S+aSgrJ1VZjtvl+scOluRP0U1JcH7M2xUuqwm4pU/+ULWL6XqLUogmCCkUwfUvLy
 tK/Tt3APqJc7ogzalCF1IywXOItU+FPZynwDBhlUpVZQVXie4W79HTHAINod0g9ExOb9
 zaMFb7Wuxnnv1xcKNfo6R+LmA7m75sToVyO6PuzNl0Bd/h3DvOrOAhTxXRFWWgJPmkch
 szyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425214; x=1793030014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkXGpXOWiBs24ppXgXlnDUbNGC4cGBni/AXZNpiz1hc=;
 b=yN7XL7SxWDqqkI1eTU34VNqQ22FnT6/oViOM4ejYMP7d+mvpG3dqfBZr3VA71qSKJu
 6fjfZLY2/EWD1JHD0Wk/Iyk7j8CB2nEv0aZIgZmvnRlnPs6Dk6PE22K4C79RIv6a+9Rd
 vdaBcGmneqDX2ww0cTLHk5WOshVknXD+7FKH+j8lQUAcmv5Ta5RjyF1JlV+1vTD4WHrL
 Vje6lAh2/yKNsDhbcz+nRCwVxKSpCgdaToKlbRGkI4qmi6zhPJFL4sOIXwaQlFVC81r/
 B3sPMwo19BFhbazRLCRswLtdHCi+GZ5VB7beWjVKIFIRZjx7UjIILsuj59YaP714JoCZ
 xm5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByt3oGUSotoOlGQYn1VhbeQbH7LVyHHt40Z5T7vv+K3dSZebfeKMcH3kuxXApE5t8Ns+egtodAL9hg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5FQo4oFWoUV7y5ciG0onW6N5ypO7QBy0VrIMc80XavTjfh/eB
 pBFpRD5nTxFzjHO5z+Q/2a0pAWutKlhoGosiysXvHU8arDlspz9800KXaC+A809P0V12qMie8fB
 5UkmP2jtO+1pUpSJI5KN4EYSgDGBvibO7dZuuxXWfzunVK7+LFCux2GqKyeuOieoyat7u2nz8nM
 ZhW/nYANr+EntHOPfhPCSB5ghsY9476UuMNz7tqBTgi/ZkqQ==
X-Gm-Gg: AYBFou3YCXebtv5dLJIb1a7Ck7cUNDScTzOMAz88Fb+QJW/8R0IhbJjFxr7y2xrpKPH
 GWickXXyukFNguYqwurLXnx5f9SSwjbD4sRxetkd8AEmtRjgICsCHTsbpTdw6FjAzDWgzEGi0d4
 kswqUJQnDgvmt7J7APE8X3DxQwvqSj3KxZewL7UyPkCziORDyut5jPvnLnTQ==
X-Received: by 2002:a05:6871:2ea5:b0:492:d8bd:949d with SMTP id
 586e51a60fabf-4a7575b6d76mr5836612fac.2.1792425214162; 
 Mon, 19 Oct 2026 08:53:34 -0700 (PDT)
X-Received: by 2002:a05:6871:2ea5:b0:492:d8bd:949d with SMTP id
 586e51a60fabf-4a7575b6d76mr5836575fac.2.1792425213472; Mon, 19 Oct 2026
 08:53:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <ar_AuRr1eaZzOfw9@baldur>
 <179096320161.1973.2852858792260211089@gmail.com>
 <c3c4d140-07ec-4402-a18b-389520df188e@leemhuis.info>
In-Reply-To: <c3c4d140-07ec-4402-a18b-389520df188e@leemhuis.info>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:53:21 -0700
X-Gm-Features: AclHuK8lwhBc9o-AjMwe7IooeXr_cgpIgGqUVsN4bF6VjxH_2L_fx0Hz7Wqdu8M
Message-ID: <CACSVV00x091i7BKW+bj0RUnkd4rOrHXbhZ4zF6SuTU1NAqsFTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Oleg Keri <okerixx@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tm9yO7p50g5VkCVqxiOvl_mMxGvTaPam
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfXzB1AR6jq4fCx
 gjhR9PurAL5kDvhOgioiP16zabG9GZFEdepihngNosmp3dBBQZBbpKmWgIM/+YTjQ8bLUvMMmT5
 sll8eRhsZtHcA7AyQbvLyycFR7CCxXI=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad63cff cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=lAgNKBcoAAAA:8 a=7w3WoVYdraEV06504AMA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-GUID: tm9yO7p50g5VkCVqxiOvl_mMxGvTaPam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfXyN23/cgR0R/9
 rHNXpUvZqv5ocnfgF1dKGQGLmKOv/z/NJl//s8MxW5YnVty1Ai15sKeO3RsSDHLJM8jLrIDL2nJ
 C6kio9TifMdg/wNoPvWPA98bazdvjbUqidpjRbRud1yifRxQfBPfZChSgR2vniom80vpGMgHhD1
 X+Gx62U3iseeTeX78C+CfliCF8mG+zWYKPwgr6nbiTvHJUd3oe8MA+Y21wFGhxBQ3LrI8SAlxhv
 MYgQLYSi9vny94ZQtMNkiuPUkJW55lGvuATi5xf+T418YLrV8mDe6j/Png7Asm0tnVpCd+kynJ4
 jLLPjtI9PIf5vuhS85VTTJ1k3VQ6sum7WZBvWfAcuz7AfpPD1cICMnXuM2lYMEPksJbqyrmue5C
 qJPzU/my/5mfMsewq8qNwkF6E+SO9HlasGlO8Ovmv1CcbILzHhFD9ZywaUoSZx4wXSj8VwNVRrd
 iCdVGRncmcnjNXNjDlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190063
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 6:47=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 10/2/26 19:47, Oleg Keri wrote:
> >> This patch landed in next-20261001 and while it works on my Glymur CRD
> >> (COB), on the Asus Zenbook A14 I see the following failure during boot=
:
> >
> > Same on a Lenovo Yoga Slim 7x Gen 11 (Glymur) with next-20261001, GMU
> > firmware v5.2.38:
> >
> > [    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interru=
pt] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for=
 response
> > [    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Tim=
eout waiting for GMU OOB set GPU_SET: 0x4
> > [    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu=
] *ERROR* gpu hw init failed: -110
> > [    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU =
firmware initialization timed out
> > [    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu=
] *ERROR* Couldn't power up the GPU: -110
> >
> > Compositor fails on the first start and works on the second.
> >
> > Reverting this patch fixes it here as well.
> What's the status here? Was this fixed meanwhile? Or is this regression
> how heading towards mainline now that the merge window is open?

AFAIU this is still open.. but seems to be contained to a non-typical
config (modules + fw built-in).  It seems to be caused by trying to
initialize the GPU (and send the CLX tables to the GMU) before
_something_ else is ready.  Tracking down what that _something_ is is
still ongoing.

OTOH not having CLX could lead to problems exceeding hw current
limits, which itself is a problem.  And why I did not revert CLX.

BR,
-R
