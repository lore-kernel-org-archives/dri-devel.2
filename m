Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F99CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF28910E1A9;
	Fri,  2 Oct 2026 18:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtSL754p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VygBxra5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8779F10E1A9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 18:44:09 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692HbN1Z3052005
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 18:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=FQ08Xw8wztndrxT1uOejbuk9Ev7qAfsJYKeKbB6oswc=; b=Lt
 SL754pESNV29m2MosTwDEM4lQEE7sfWr0ssqW+SEAz3hgIRe9p1nG88sPKmvXw2K
 SQkyWumfGRpafbwwxqCDMst3fSlZG1kpHelJujTJIidpHpOt5149w12mUYO9hRz/
 FWJzrxsPSqyJQg+dvzhCI4IY3tz6nd0YmOYNUsEb1fP2Si80692TsxBREVPIznH7
 lWTyV+Kyc7q0kcV6wztMhspOFwEJsIG64asbozq+Wb5ye0+s+4d9lwTpqBbUt4oX
 wBjc77tIsTvMp5ny49II/EZwUKh6NH6xVc7j8Ot/1RGmNaivNrhossfeHGHaLCQw
 1RT6ynU7DMGBhgZSRTXA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mu12m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 18:44:08 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-806004ec379so381616a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 11:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790966648; cv=none;
 d=google.com; s=arc-20260327;
 b=Su6CmrWTP8IuUOUQcR/aQzROtMsi4plZ9lEYcYt7zu42shzbw0GaIYsz2Yq/Tnmwzz
 vg06YD7JC8cFq0ZjGnZ9GwQ6VVRmbtjEpP//YWivH50PWtiorf3MQ5L/HF1QM8Xz6fzK
 LKTJUIyM3HdY3vA7sTmL1PVrl3y5cgIzfNPTMUfani3YwQh1aYGtAlUVHi336FcSoCQJ
 stYqujMIukcKCZRHL7gAvyLw1rWNpOWcAVgZUNhVZaKydrjnNIGdGtTQraXPSeoAibiQ
 8bJsUdvDgBfXRkQotmkG6tBoosNLgtNb8tycp4m4VELeS8U59X32w49IxvrWCSQ/7lEt
 dhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=FQ08Xw8wztndrxT1uOejbuk9Ev7qAfsJYKeKbB6oswc=;
 fh=HeNwDpzZAsj/UwK935H2G5NQI5HZA5uxDBHNcHc2ULY=;
 b=nYeOW+aYDsMd20rniIgqYRGtSV8PHCnSWEhPWtyQwPsMgYJFVlLDjrF5SYSXQJXXBE
 0erSsRdqTtSLWYguICpDE19wumbB2E4RknsNUTgpd0Tek7/s6eyQBdizbozymyjQXKNj
 fqNRB388LcfkwuSFyeFzZiDAeLax81kFSoo/Z2pY84w6orgrtCG+sf7w6B2Xqnm32zvl
 2y9FsT+JDDbipGs4KkxKnBJDG8ysLG7KFJXjgmMvAZIwjNrsj1FXvQo66agZMkoGm4Ri
 hyvImBCtdvS150tKW3izbshjD/syRyMel6db+TRTqWPFDDGWbJOKbNiq0qf/aLAfq8qD
 r/wA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790966648; x=1791571448;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FQ08Xw8wztndrxT1uOejbuk9Ev7qAfsJYKeKbB6oswc=;
 b=VygBxra5zneQm5eZ4XOozDIm1T6GHuszMHwI2yFVsUqmXhiIlZNTTpxQOW7fq245ZC
 QCgQlHcm/D99pWq+4MKm8o5rl2xKzvZqTE+rFwnpVZOkNtSPTCWxN4iN5mrj+LkmRNe5
 qGHNlFdEpILIknT19m6acvUtHWlKBbF94qRN8MMv/LY8d7VUvloF6x4vr/uK6899JRel
 F7jzwIwaRkXOMg0Dj6dCzNxQFWxJwobiqAD0lPaBWUOY0ajSchA0ivqkPDN9E7Vv9p82
 xNQwyZ9YNT9ugts2lHYjDO5klUVwgTEE9ErrlkIi4iAk3gtszZByiK+DTJoR/Q4RRUyR
 PAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790966648; x=1791571448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FQ08Xw8wztndrxT1uOejbuk9Ev7qAfsJYKeKbB6oswc=;
 b=BShDeW3ypB3s3xvEfEXIu1Ffcc52SIGaTApa82OSH5vQ/Lloig8U2vqy1I9TFfZKPc
 7SxQwadpP0WnLracsOrn+sCAP2o5Y0iG+Wa7ENqX0SEMbtIGqQbpumVMq7CEmoWc/5H3
 DBQKOcvdz9LSxWfAoT/U7Oi2d8R3g8i4CfcPZT2t5pEOfHEGRf/hPLmc1ekWy/iGEGgG
 cUEbb6E+ske3jz9jg8PoWp5o9Klv97wV9LNBOg7OoZftGyEY/3K3+CM2+8tp9ANKFvra
 8/12WIdkoWcHG3PkoFYqSrMSr9Ig32xFzUQJuE+Nx23SUdY8r6tfos244+yAUxx3R95+
 lK4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5KbklmKuFuLASoznX2lxcJUU7bor4TGosTC1OD0vS0WkrrDi0CWE3FcMUihWOcR1w+q6ZTOuGkxI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMIhAHeQ9CGcrsO3Php1lEG0G6T7CAyRlbyIKgZQxiYc6hM9h3
 U4X1KQhbU85PsvW/4es4N4Z7IS/qXdcxR7y3cLGM+iOgKbGy+69MupighQCiDZ6box9e7mGFl7x
 iXpZDQ99w2PIT+OXD1PmqMdKjAzfaP6XJCFfUOQoDbMMjiSDSf0QlnZ5SrmT0AavyP8/nLZJL9J
 iTCWNn9G1hMibBqx/GRlC7shUrrPGH11nDf2u8zbI5z1rX8A==
X-Gm-Gg: AYBFou0AyOy2XXUopWPNcLIz3albx/Y17XeGwLEjL3mYbwxzom2OeotZcY0D7+LpMHg
 HtY+DlpxDZ0mjxgn4/mMAB8MVMuuQXRNuKYD2holExMJUG1AytReAl8+3e5B+9FJfymE0/Pdqk0
 ug5uszz2pQg10GqWLJ/D8V4xUTAn40W6diAjBbB7qKtrCdSEXCFxnqcATO
X-Received: by 2002:a05:6820:207:b0:6d8:d3d:de6a with SMTP id
 006d021491bc7-6df35c3999dmr2503472eaf.73.1790966648028; 
 Fri, 02 Oct 2026 11:44:08 -0700 (PDT)
X-Received: by 2002:a05:6820:207:b0:6d8:d3d:de6a with SMTP id
 006d021491bc7-6df35c3999dmr2503443eaf.73.1790966647508; Fri, 02 Oct 2026
 11:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACSVV00GwWvMFDR5QC7h8gonC-9qYbaG958nZHSxtUdWXGG_sg@mail.gmail.com>
 <179096555582.4050.16689195326008531646@gmail.com>
In-Reply-To: <179096555582.4050.16689195326008531646@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:43:56 -0700
X-Gm-Features: AclHuK_1A84ea1UaaxIckCd9ugOaiHEjc7V1vuwTcIvjWzRFw0FRu-Vm12FS3cA
Message-ID: <CACSVV01iV3g4uZ9WnVFuOMEiqdQcOudXXr39+5m8yE0XqC7X1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Oleg Keri <okerixx@gmail.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NCBTYWx0ZWRfX3tkbvIjZ5hMu
 OuMWw7ljL5e6BnQjkylsP+p/s1/d9A4GG8RQcNEckDdMBujjsg4okU/buX4bWKL888eAzGNd7Ok
 FPzKruW2iBFW6GRCem/vkPH09KAVrp4=
X-Proofpoint-ORIG-GUID: x2pf9djAZfo4DjKHqT07TATIbkPLZazL
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abffb78 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=j9aERBNnXM6nCbgg6pwA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: x2pf9djAZfo4DjKHqT07TATIbkPLZazL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NCBTYWx0ZWRfX5TFFgzsufKHI
 L2ivFoxlRbV9set3XbQ+esTeaDsZbSYKdS7Sd/IHlAh35s6z+qzAPGasHjcwN4k7QWeMoVLf2To
 uMWyQeg5dyZ9pdVnz4uyGAn0wjSCJypz7R5VGE+V1LWMSOqhWMGcxlI7MDe+XNrGn9kvNVfMfX5
 rIJI5fgPRQXXKtndEVoDuw+DZFQFJRH0HznfgygpImctMPJ870PNfZ/Qh4k40X0VqiIhEYzCTce
 2Tm9uQzo5JpgzpCUvb9hDJiUXjjiX4vaEssEvStU/bCR5NZIuSx0dJEJJGfa9BUcLJVyb9ZMGs6
 b7PWU4WxYl32gip54s/j76jVovNhEn4f4LM+kvPEsWB5bgfX2Lpov8aszl77hewshDVHrcegE9T
 QoaUPDSa3cUYS4QV8CwS6VFhAEUffxyQ/mVHpXsbJoI2tu4Gg2RLIlAg9GqlNBsxNtZXqnuE5VW
 RcNqqUp7int5EE+3WhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020074
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

On Fri, Oct 2, 2026 at 11:29=E2=80=AFAM Oleg Keri <okerixx@gmail.com> wrote=
:
>
> On Fri, Oct 02, 2026, Rob Clark wrote:
> > Can you share `dmesg | grep drm`?  In my case the initrd is missing fw
> > so gpu is initialized later, I guess when the compositor starts.
>
> Here it is. The kernel is built without modules and with the firmware
> built in, so the GPU is brought up right at boot. The GMU firmware is
> gen80100_gmu.bin from linux-firmware (v5.2.38).
>
> [    0.620358] msm_dpu ae01000.display-controller: [drm] Using Transparen=
t Hugepage
> [    0.621120] [drm:dpu_kms_hw_init:1168] dpu hardware revision:0xc002000=
0
> [    0.625910] [drm] Initialized msm 1.13.0 for ae01000.display-controlle=
r on minor 0
> [    0.626015] msm_dpu ae01000.display-controller: [drm:adreno_request_fw=
] loaded qcom/gen80100_sqe.fw from new location
> [    0.626115] msm_dpu ae01000.display-controller: [drm:adreno_request_fw=
] loaded qcom/gen80100_gmu.bin from new location
> [    0.626994] [drm] Loaded GMU firmware v5.2.38
> [    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt=
] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for r=
esponse
> [    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeo=
ut waiting for GMU OOB set GPU_SET: 0x4
> [    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] =
*ERROR* gpu hw init failed: -110
> [    1.652389] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeo=
ut waiting for GMU OOB set GPU_SET: 0x4
> [    1.652401] platform 3d6c000.gmu: [drm:a6xx_hfi_stop] *ERROR* HFI queu=
e 2 is not empty
> [    1.858322] msm_dpu ae01000.display-controller: [drm] fb0: msmdrmfb fr=
ame buffer device
> [    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU fi=
rmware initialization timed out
> [    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] =
*ERROR* Couldn't power up the GPU: -110
> [    8.187443] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU fi=
rmware initialization timed out
> [    8.187650] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] =
*ERROR* Couldn't power up the GPU: -110
>

Ok, now it would be interesting to compare the same from Bjorn's CRD
vs zenbook..

BR,
-R
