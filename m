Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441C1CA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8968510E27D;
	Sat, 10 Oct 2026 19:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTBF1d7t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V98ba3BS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9C610E0E8
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 19:52:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AIeuem2375520
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 19:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwjqTvVgkBjNJF/ouDo5/S2ypeV7Y1OJppFgq5AUL+0=; b=NTBF1d7tsKuvErin
 2j1axxi0Ng5VZcUaaonMlLnsXgbJE6vUuzaEmQFHnrdUbvf26fPsjf5gp9t56eg/
 Cg9Cqde/4E//M1NbOHyUM67uXs9Zh7jpev9BYOMW66vormUsReVfxfsbuAbO0u9q
 HAFw6uv2CY85dGtHOTXAY5k+WfkMciPmfQMBpSPZu7nSBt/UTfsf56843AAMJeQE
 d3dMuWkCQr49rInIoA9bYjAF+mcOOzHvN4OTWnNiTBvuNa8LJl8mWLpFACFg8TVr
 1Eijba4WKtYTdXmIDXMG/Gsw7UZJY9cra3ysWngbNg0JemBJLeh6+yvi3Ir/MGsT
 zVEy1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cas9vbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 19:52:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so3685216eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791661972; x=1792266772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lwjqTvVgkBjNJF/ouDo5/S2ypeV7Y1OJppFgq5AUL+0=;
 b=V98ba3BSx2EimoTRH43aubi+3cWiB1/78p/Zu3m7pJBPxl2mgfIzGezpUrNFO208VT
 AuPtHMbXxr3vdKRGDAC3dJDEZfmyrq4SipjApsycVNlVdv8Fuki88ZNB1N63COZsXttV
 SHFKhZICg0y5bMK7zUVR2Jwc1PjDwQxXjcDS1GXLjfWb1mVcm0y6KgJIkKuoixYTcqFz
 p+/WOkpEQqhyRnO3YyEck/IYXQKiXtV3xZ/5mpIfTR8LkEbBaZ/k3Tkxe0pnGrh5Tigt
 RK1P9cmw4G+SOU3wdu9X6c0RMWgUz93qQLl4tKUeRrmHsGWqeQ4SC7j+0cMNN7C4p4EO
 sRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791661972; x=1792266772;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lwjqTvVgkBjNJF/ouDo5/S2ypeV7Y1OJppFgq5AUL+0=;
 b=fiLXiCeXkPhCn5G1ib/CN4xyfQ1OtqzUKKGK6BLm219DTgeUkJglZ1GJ4fBlCS6DtW
 dQmXhQdcDtjVOvcUEjoYGsRbSSwSv91gc4Epy6jAwfJNfpriXmLDeAWB5LfjFzVESEqo
 uObmfGqK6wGQfuVrV81YoDNXDG4yT4H2B/RIOnD0UMslqa3cAvvdcker2aqOAtE93sRp
 Q1lTwN/wmfDiGvx6/OQGrE3OT6lHTtN/oX/Z47EUvvMSOKohX3uWZoSbis20uTWp9w9R
 +VEmKI0Y6foiGBCE3fUWCjndGT1HqWbfceOQJwgIeH2G5mrKtyB98VN0+2Py67mRE1dQ
 fz6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdHT8gvZKM4EUtrN9n8HF2wALY3Chl6YuD4nH5hm/sDLcunMbr9iK1XQuj/oHFxsYWo7HxCCAChfs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKsIKDXcnKQrubPWTe0QT7iX4ePXka9y9KOeArMDgPoWFpl1Un4
 Kmp015mloe7vc6P/sEnhPNfNu1y5d4UU72tgasv/59dcLI+cDRhfp1p1pB2GKjdcTk4H+XsWxlb
 p2BPyQADe1t4xHBjQXuuKcjdO3E6ba8FFIR8+cDZs1BJoKBDpYMuEmq47cLyrl4i0VcADbHU=
X-Gm-Gg: AYBFou1ZaQxaWtU8MhPuSjqRts436cPXYlitb6sOM7ce2y+EDfR8i2IUnJzdgLhMhmT
 55qzreEPWGMYx5Ty6FIqLdGnKhgpOD75g4DaQ1ymMqPzF6VNrxhOCiAbLnVRnkqtwFx9SCGQne0
 RorhxPIEb91tcsvGUwAn1mdOY/k1UZnQ7goA/CiY5r0Bc1giWni74xo4LdzV9dIA4Hv/rgir2an
 9H/Tn9kQMeJHabBRjtpeu0MoJaVjkYqOU5oJepewutsF8Mln/s53l2wDoA+DX9EcyzChnlHSBpl
 itFj+kMjl+F0Omwz/eBfcwaz6Cv/OSa9hNe6F7bd/lXGMe4EhxySmdWXruVfBjfVOeKrS2SjK19
 sx1rdXUATcMh78wKH+9b01SYP5NgajQ==
X-Received: by 2002:a05:7022:1702:b0:13f:b41f:bda with SMTP id
 a92af1059eb24-16a5c5f4414mr7341872c88.16.1791661971814; 
 Sat, 10 Oct 2026 12:52:51 -0700 (PDT)
X-Received: by 2002:a05:7022:1702:b0:13f:b41f:bda with SMTP id
 a92af1059eb24-16a5c5f4414mr7341825c88.16.1791661970943; 
 Sat, 10 Oct 2026 12:52:50 -0700 (PDT)
Received: from [192.168.29.225] ([49.37.144.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a42407e7sm16545214c88.15.2026.10.10.12.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 12:52:50 -0700 (PDT)
Message-ID: <396781e8-8115-4524-87a8-ec989330ce4f@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 01:22:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] drm/msm/dpu: rework layer mixer allocation and
 mode limits
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA3OSBTYWx0ZWRfXz/mow7qWdhPM
 6+FEoecfh3KBuRuqJC62rlsRxF/Z0i5i8deu8EOmlAs9bfUhwdmxioti20jbanoNkpjXxXtwfz1
 ERkolxJq3zOuric/BlXaYSOIrHMluYo=
X-Proofpoint-ORIG-GUID: eDHloZehsqiu0SjfXjO6MmSshZse8mLF
X-Proofpoint-GUID: eDHloZehsqiu0SjfXjO6MmSshZse8mLF
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6aca9795 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=20alU+YIu2uqf8Hyrg49Cw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=L3DgtkeIYyT9a_Y7rtsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA3OSBTYWx0ZWRfX+VczcPwmjCEc
 a+HADtgM2fHutHnm8S/EUVNUaIHP0MUJ6OLFKB9/tXRe1SvJsqdSQMoZGIEFlKBC8zF+FZv3hDQ
 FBvv379US0tFkO8pEIH9KZKaF5HuobKhVi5oOiyPbKhBNSBA9we0EqVZjuyw/Gl4UPyCZYF4e1X
 3N/isoZ2RcYw6ZgI7iDUxVtqqfdn3l+Y+rpyZrECVwNoJY1GYBXp1GqjzJKK0XgIbzipYBqlgns
 gHh3diEJqshUxgDO1iMw1VbmUk89e08qJnuMVf4pnI1nyYlzPa7hW6oP/it0PzbjYkw9zPA+p3e
 GkQ1UU4o8cpZI4wHF8FFwQMMXZNiqIVMEDV4pbMZZ27NukWHdJNWtYTHdAw/z6sE0+Z8q9j9vcm
 vB9m95xdLbVJ+cVW+taoj/ro6E5trbRVSW3iee62FPb4wSfaFIgOr+cX6M1FOIXlJJi+97ymtAA
 CaBLZBA/mWJEG1EbHOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100079
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

On 10/8/2026 10:53 PM, Mahadevan P wrote:

> Currently, the DPU driver bases LM reservation off of the maximum
> supported width for the layer mixer and an arbitrary MAX_HDISPLAY_SPLIT.
> However, these limits are not hardware limits meaning that a single LM
> can support higher resolutions.
>
> Switch to basing LM reservation off of PINGPONG and DSC encoder hardware
> limits.
>
> This revision also adds clock-based mixer selection and a source-pipe
> width guard for mixers without source split.
Hi Dmitry,

I missed the ongoing quad-pipe changes 
(https://lore.kernel.org/all/20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com/#t) 
when preparing this v4.
I’ll rework my changes on top of your series, check the topology 
interactions, and resend an updated version.

Thanks, Mahadevan
>
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
> Changes in v4:
> - Rebased on msm-next, resolving conflicts.
> - Added clock-based mixer selection and reused the helper in mode
>    validation.
> - Added a source-pipe width guard for mixers without source split.
> - Extended the catalog cleanup to newer platforms.
> - Link to v3: https://lore.kernel.org/r/20260112-max-mixer-width-v3-0-f98063ea21f5@oss.qualcomm.com
>
> Changes in v3:
> - Rebased on msm-next, fixing conflicts
> - Updated commit messages to describe the actual issue.
> - Link to v2: https://lore.kernel.org/r/20260103-max-mixer-width-v2-0-ef5d3d246709@oss.qualcomm.com
>
> Changes in v2:
> - Dropped PP and DSC encoder width drop the catalog, they are now
>    determined in the code by using the DPU programming
> - Corrected DSC encoder width for DPUs < 8.x (2048 vs 2560)
> - Link to v1: https://lore.kernel.org/r/20250514-max-mixer-width-v1-0-c8ba0d9bb858@oss.qualcomm.com
>
> ---
> Jessica Zhang (3):
>        drm/msm/dpu: check mode against PINGPONG or DSC max width
>        drm/msm/dpu: filter writeback modes using writeback maxlinewidth
>        drm/msm/dpu: remove max_mixer_width from catalog
>
> Mahadevan P (3):
>        drm/msm/dpu: split modes a single layer mixer cannot clock
>        drm/msm/dpu: do not assume a merged datapath when validating mode clock
>        drm/msm/dpu: limit the mode width to a pipe if the LM has no source split
>
>   .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h   |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h   |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h    |  1 -
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_9_1_sar2130p.h   |  1 -
>   .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |  1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           | 82 +++++++++++++++++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  9 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  9 +--
>   36 files changed, 79 insertions(+), 54 deletions(-)
> ---
> base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
> change-id: 20261008-lm_fixes_final-9b9a8d0d9835
>
> Best regards,
