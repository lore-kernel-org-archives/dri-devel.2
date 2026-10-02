Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC599CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B5210E658;
	Fri,  2 Oct 2026 18:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrVDpYW4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QP80efW1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8791C10E63F
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 18:12:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H6ORa2357465
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 18:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=4CSRn9tEcJU8kiGoAhArcrJMiSynVhSMb0NK4Ngxt90=; b=Xr
 VDpYW4tG2obycAgp20TaucD8Vlyh2tE2ttwyxMbJfYFbQ3bj76r85LAnMm9+ONuc
 aIWOb7wmSr0krUoM2GvgQbwoclukaXijDnpdIje7jub9D8U7XJdtqAFarz5wCoSi
 EHpeNM6FgfcdOcX4KY2s+4qNoVtEbkT329pF4/6ZYBt4YNEGJ6lJpHWZp7lv7KTg
 ozklH6x0iRTsC4TQn+TBExdaqjUd9MRUUz2gJRH2Fd2q5b3fBLK9Y4MJEGfqg98b
 zHdL9oNCTt63yJUIfmj6Q2pU7ppqfdnvRHFd48KptMxSrtsKkZ7cc/w1QKeiNv3Z
 g1Ssx6fHfgHFEvM+V7kg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh3n5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 18:12:25 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-451d80641efso275902fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 11:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790964744; cv=none;
 d=google.com; s=arc-20260327;
 b=m5U1dJx3k7fZ0pDGp+mKceYwLp6lxTSCf1+c4few8+QTexzQ7gSEeW4ez+QY/zwU7S
 VMHj8Tvf5OA97JJCeUimFt2tx//yQoErdryu0ZMcVIsH+YMRPNLrnyVUtJi/r6wOfeVL
 ck/4G0HoH/wEw2M47Vz1Xg72V3jxlpEDf5QE3DSAIP+91RoP1avdjaiBEqQHXswxGxDo
 0SN4tnfxBRZNGMSmqOWR4C5vvnsblSTdaY2oj8iMJhYH7Rl7jr+GCyazN3RAwTtF8Z6S
 3JIgNLNdf19FLGIn8EU4UOXm1129YO+fS+xBYUHUMmwbpI/sgf01y46Zrquqh428hqcr
 rWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=4CSRn9tEcJU8kiGoAhArcrJMiSynVhSMb0NK4Ngxt90=;
 fh=I5eZWvwhoW7SqPP24GceHJe565cDY1NGJfWIdhzJAEM=;
 b=YzXSMSYyWq1n0FTE52133EmRrmuVXWio0VQotGsdPRa/YtCyKOlKZOHzlaJrjQVD1P
 Wc4dBr/jCRUTywOfeL7xh3r/lvqX6Yv7TQipmCqyFVEhe+SDsfAoJHY1/Ami6ALB4yKp
 K5hnsvZ4/p1OnYahq1NXnmI2sBbUTdgoeYTN3AOhn3alzXmAROb7UYTfw4C2EOnUNHmf
 cyULugSXrMC8LMJafsJRnO5cb9WgBghs9KcoVHxsIPl7UyxZ2arV1CF3Pyu/ucuUGCbi
 p+McwWdYndubygDC3Il1RA6i2rAj78CjtMfuvGPScSO2SCkdjrgtRmYSrglZNf7i30Lo
 u3MA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790964744; x=1791569544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4CSRn9tEcJU8kiGoAhArcrJMiSynVhSMb0NK4Ngxt90=;
 b=QP80efW1Gp4cM1IaJj4CUDR5Yat/VqcQ+4cVhXP8lNfcryrYBj8zBMf1VkY1Xn7Jxf
 JOSSjmeurbd/XCdaKSfuwFQh4m1okA+MXFvAPooo4/44FsKxfBw7J3a6mv7oK0veaVAU
 x2U4ZnZ89v/67DALriaFIUIZjAsnWhj2udewGidnlS0Adi0mpk/UmIgrCrE8Gt9RdNYQ
 I0XRqPL3lWrvDUnMk+KuEqiItneqOtTpVlnmutr6Ru1geRkiDdNfFgU8xMyZ7PmCZtCc
 mS/rG8wcbKN5qX6Orti2D50SO4JlgsMXD1kAXsbFi09X6m+DJ5XrXXHqSgolFnwP+qXN
 0xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790964744; x=1791569544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4CSRn9tEcJU8kiGoAhArcrJMiSynVhSMb0NK4Ngxt90=;
 b=OlcGFKo3OKbN5HdVdnj82qFfAJ6MLZb525R/XnywRUH13OInzcyJ/oJ7f2w/CSRmRA
 nXXleJ2ZR8R0R9YRQzKLnSFtLpE03q0rUaTZlDyGvyPlxK2U7e5bTU5H4QVXzGt68FNU
 2LtekPbI2wLeKoFhaijPXJDX/Np3aDo1yMhQ6wJqX4UU6UnKBRs+LiLnFFWCEGuyCMg6
 QeO87Z5cXaFbx+8hU/Rbx1aQxCb0ZBUhb7nQNLxY4KBsPjpuQx7sTIJvFYwpMBET/9Zb
 sFQx4iCJFqPXUGXSnj+SpXtJHPIta/2GtDCnrTpgLFWXFJIvNfAh8ojihMLqZVRPnHzA
 zQrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQv6Ck7r0l3G4O1ytJtYdJSZPzGMU0Hbythxm/FSJCi9cHn8jA1EfqlZfqUDcz2FJQsHfb/kp40P0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIl0BVL2ZA3ntjHSCh1PPkcCO9uHCTS6wOTliBx91Cdhh7nNB7n
 36I2vCDzg4v7ZOd/naUN28m19tnGiumHxZFmhlQZ99E2VHVAQF5DTf0hHCEjKPsyL+TEPHf8TJh
 QAr0LFfIhiKPFvCK3m+LyehrTjCNY+7gzCF0lYsHVqbxVVndujJ17SK8KpKeJ/tUwASzpsGfyyM
 +BQUwqxp2i4lvuLDbomJGIt8UKvCmq8bDfw539ZRkNpmVTug==
X-Gm-Gg: AYBFou0N603rwFBUFqlAyRnCWCuu+ZtxpOekYP3iALkM2DnRn/1TG38m7SK1c6gXNXR
 X8swNS2+SPFexhWQuuJy3hPVkkdvGCA0v8SSiNAU9V+BfdUwCz5dXdPosJQYGHTC9UhVZUV+8qM
 wdncs8Wut3ahP/WOiGg5obSi5HNE0uuLgBmr1qsmwfNd626KUTaO0jfp9T
X-Received: by 2002:a05:6871:c941:b0:49d:e1d3:e6e5 with SMTP id
 586e51a60fabf-49e15ead8e1mr2700821fac.43.1790964744583; 
 Fri, 02 Oct 2026 11:12:24 -0700 (PDT)
X-Received: by 2002:a05:6871:c941:b0:49d:e1d3:e6e5 with SMTP id
 586e51a60fabf-49e15ead8e1mr2700784fac.43.1790964744129; Fri, 02 Oct 2026
 11:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <ar_AuRr1eaZzOfw9@baldur>
 <179096320161.1973.2852858792260211089@gmail.com>
In-Reply-To: <179096320161.1973.2852858792260211089@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:12:13 -0700
X-Gm-Features: AclHuK8o91bLNwt3TjoUBHpVEYotMXP-4T0PZxyf-cMbJnzFu-NNTFKBRF7Wws8
Message-ID: <CACSVV00GwWvMFDR5QC7h8gonC-9qYbaG958nZHSxtUdWXGG_sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Oleg Keri <okerixx@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfX/uhreHRSDTOO
 s6k4kd6ox4o9TdwcwrBT7pl/UDH5I8CU6HCB4LWbdmJlk3PpblMnnBkrEtOZrd9VhsxNC79LGBf
 raWsz1MECnylrhyW0dNWiCkDLpCG9O8=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abff409 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=AHIf9BOdGwd-gaNHwY0A:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfX7oOBZIEkpW7u
 mU9/p+ujwviZMiAxMRL/e+tW8CMR8NroryBZygnJ30UyNolHAUfGBx6HxcUoTmEhOMQbIa4Jemh
 iStSdVpliTZqCN9twDCuO/4Kg2YwxvbrTi1psQRiftvErEH+fpPXmn44TD1lRehBQ7GNMwbtV8Y
 vKUBDhxcU+CcoRe5IjOlxz+kyRPD6HsbkSAtXIkEhhk4bG3zF6tDDu0PafNqXQtwNfMGYR5IQQT
 GqVF1DXdnpDZvQ3Mts/xJ4rgaPyzBvV7nZ2iGsD45YdPISmjuDPV7UWU/+zpPLg62vTHDlvsa0Y
 rw0qadYugCP9IJxyw3M430Ud5quqHVe5ZW+mg0rLz731u93WBXYEU9xrC/i2ChwAqkHIF2HqiKu
 VaMR0/PIzrh7IthWX+UNE3gsxlcoCZQfaUUJI3PNMTqi7yRfgOaWjJqoDbPzrC8pen6pGh0Xk1T
 /Pia/6wmrFumiOJPPsw==
X-Proofpoint-GUID: pG_AJLeYjdTSYykJobQMF5FY21DQe4O5
X-Proofpoint-ORIG-GUID: pG_AJLeYjdTSYykJobQMF5FY21DQe4O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020072
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

On Fri, Oct 2, 2026 at 10:47=E2=80=AFAM Oleg Keri <okerixx@gmail.com> wrote=
:
>
> Same on a Lenovo Yoga Slim 7x Gen 11 (Glymur) with next-20261001, GMU
> firmware v5.2.38:
>
> [    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt=
] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for r=
esponse
> [    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeo=
ut waiting for GMU OOB set GPU_SET: 0x4
> [    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] =
*ERROR* gpu hw init failed: -110
> [    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU fi=
rmware initialization timed out
> [    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] =
*ERROR* Couldn't power up the GPU: -110
>
> Compositor fails on the first start and works on the second.
>
> Reverting this patch fixes it here as well.

Interesting.. I'd been using this patch, but cherry-picked on v7.3-rc3
(on glymur slim7x) for a few weeks with no issue

Can you share `dmesg | grep drm`?  In my case the initrd is missing fw
so gpu is initialized later, I guess when the compositor starts.

BR,
-R
