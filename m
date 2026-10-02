Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7746ACA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD28F10E5AB;
	Fri,  2 Oct 2026 12:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ileTv8IO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERyE3n4Q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA6E10E5AB
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:46:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6929nQjt2061960
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 12:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6lyYymx3dDTOEqcC+QoyEp2I
 DDrTkkMvcQgBdtGhsSc=; b=ileTv8IOLZDeS6W19nnEvF2Y8bPz4TeDXtYbq5L4
 fgnJgDUVqE+uEjD6iMH3VL8l2rF6GIJJdeZXzqGFEuKkV6f7jy2Axg1lA7LpVgXP
 VkaL3YJnwMSw82iSLb4t5OU9ZcOg7Wp/RhCuccNoe66nAE5Ev8bfBzdfbiVWk4JT
 Zcx4CseMKkgwUHMl3ykSr/Klmz5cd8Uoh4AghgfdudUzNAukNQaFRoOWpy0Ssc7a
 RiBUdkS6Dl4K5OfxA+rO0yEfh6BHKlTt5Mu2FeXH+kdnoru98OSJSgo7JIUqz0W4
 2RkZMQSVXKbUY9JBWBuG/Jzz4fJzOY7jqCbb9zSVdSYgmQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256msemu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:46:15 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98c46da4b04so465758241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790945174; x=1791549974;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6lyYymx3dDTOEqcC+QoyEp2IDDrTkkMvcQgBdtGhsSc=;
 b=ERyE3n4QGSFojsmKT5bVbijFvyvew5geaIiLAPfpT2phXxW+kq+gHGSIOCNsNs7jlB
 sUaH1u5BdGiXJkHua4OBVTynqo7TGaPWRqx3Zb/0h8g8tf3waeDiriJflhkHgrP2JPMV
 VJ8qPQPnHo4YKDn8FPx2sW62pwf0FPgvFC8RGAPXn5aVCTwDGTrv1JhCSTHCITl4zgvr
 9F9vINYg52IZEQ6/e/pEUvXHyGJZXjb5hu8FLXNHnRo+JD6BzK7hcLIpJ79sYQiG/Dvq
 u7j3D8VlBAaltD4ruTgtroYvnbHDO5gGren9w6FE/0hkhpIgEP6lEav0nI4jx8Qu2/v4
 Z9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945174; x=1791549974;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6lyYymx3dDTOEqcC+QoyEp2IDDrTkkMvcQgBdtGhsSc=;
 b=JqmWzSpr65aR/1RNXp7XYgtk7oDRKMMHkFCSGmauSDdO6gz+GKOjZyyRASNZS5X289
 6uKN3s9dIV+O59upUOThjyUllkj0rI9JWx+G7xgoWFQqQmBNCBa4UpVfazUhKYwLmp3y
 P9Q2KRbj9h91eJQNXVi+pfWKmIGcUm3RMHXvISG23MUn7afMMptUG4K+9pLXxXsK6VUA
 4xxhg15ZTh+8DQPMiuLVYbROUUrOOOvaSSym1xrkIFzRP8Dp0myZMzjQ5FLqTOTNuSPO
 94EQEk6uND7YIpaNaLrfV25iPBXwOoWh/xOOt3j61karjyRFmPh9QWPNiUaFOof93uKc
 OoZA==
X-Gm-Message-State: AFq9FYJJXc5F36cwu8KgUilnXtR47iAxlllJAf/kSEQjOis4w9wRUWr8
 uGdB8cjC3fR7vFJ/J3qm1+I1Iq7q7/Qto1kWG2qp1MjUxL9KG7xM4wsPr8B3gxph59D1KaExeIV
 P16wvhDGRNAbNU8/DghtSjqL9cU5DB4XUV7nrw1/sr2bezKdzGds3mPi/OcTeGkyP58QG1NA=
X-Gm-Gg: AYBFou2zMtTKRXh+bAmRrnz/Geqxm58YXlakZJcYvN0FBVQwweC81TEj9pH/+fKzEqC
 yNNdxuetQpo6tW3mgaGEohmrTEkQk2hrFJZjUtKRQb7iGV3c5te6eUbukRdA/yH/xL0MUdWn6tP
 QT5Ie1KSa8+jbtiI+s37I3UjeEcAwwBa87LNlenRaYmfSMQYLa/vUbxBKtXkJWx/GU5iY/5aKPh
 mv9ly/cOsrbrKIk3hsKYx5O2zIN5M6VzcWGzGYzSPTO9dc5IEOUdL4hVMXIuAnsgMlozD8NxR7/
 gC5LnVHyQ8j4tKFUWen0vtjIZvaaGeQfV0HQJBN5efHg3Gmo/r4ZUGrvCWL0PD+VsxXLsHxRSyy
 kYtrp9yg0kp0vyvcgmzBuCFfxnsUvHlvI0Uh5ELt+y+ASUyKp4j3o3sl9Z7gtyml9GXTAD0l2B6
 ULjYX9AyaKa4l5
X-Received: by 2002:a05:6102:4b11:b0:7a7:198a:c2bd with SMTP id
 ada2fe7eead31-7c0f59b12damr762568137.37.1790945174124; 
 Fri, 02 Oct 2026 05:46:14 -0700 (PDT)
X-Received: by 2002:a05:6102:4b11:b0:7a7:198a:c2bd with SMTP id
 ada2fe7eead31-7c0f59b12damr762553137.37.1790945173587; 
 Fri, 02 Oct 2026 05:46:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c795bd0sm692372e87.38.2026.10.02.05.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:46:11 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:46:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/ci: add sc7180-trogdor-wormdingler-rev1-boe
Message-ID: <mxfi2t4qwxb5n3xebdfesq2rwwrimtpav5uwvkchtqfjksl2rt@gr4bjqqyt22y>
References: <20260616115410.325837-1-vignesh.raman@collabora.com>
 <20260616115410.325837-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616115410.325837-3-vignesh.raman@collabora.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX6Gvay4ZyFt8u
 O3TxySBLIZq8LK/UNIPKFLcbfkrnzdDktKRQax337GLiF+v33rImy86mCWTQHFMDbuB5O2tc5F+
 rgLKNoDJpc+lsqw1YFKvcjeKNo8gNvU=
X-Proofpoint-ORIG-GUID: QtOhQZuCrYC_0h92aSR7oP_lC722YMrg
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfa797 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QX4gbG5DAAAA:8
 a=xPXTalVV15vKJwUFfvMA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: QtOhQZuCrYC_0h92aSR7oP_lC722YMrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX0hCsBndLmpSf
 TWw7LaKQSDTZ+s1/zIxSxlJjQXlKnu3RyEekGX0NqqFhSsZ8Zw5oiSZHYA1yHZvLuBK0zFQJpRy
 aeo63jSKhhKHoOpgLXgkVPTLcOeK+FoZf0NNgQ8ttQwMKHcR+tzmOGrY1MGT3sc2lFgs0qyeJXd
 3dUvBauZCpsYOLMK8t4PN6dTlddtLO8zuq29a/akyMITXGkkHaGYdvSJ19qzmIx7lxFtuQLGWSg
 Z2w3VYMM9y2ksOmGGMyW5TsewSHJBnDn66f0lMe5BiCQSgyL+9Bh+8K2dizXlJdOrWQGEih7kfD
 vuVpsBF/HsVuW0FlHqudn8wzcYL9riBOzSRm+jLXBxMZw7+GSqQ8wSO0dPV5OF9X3Rv8WUx70Bd
 BEJHanXLyGFPzX1zTC+E/ms8wx2Zac3/X5mfFu1M9Pj78dSe7E69uNlG23HBMrkii7PLf+EYmDS
 Ba0xQogAruYcihNtafA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020050
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

On Tue, Jun 16, 2026 at 05:24:05PM +0530, Vignesh Raman wrote:
> Add job that executes the IGT test suite for
> sc7180-trogdor-wormdingler-rev1-boe.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index fdaa26ad79d6..61ac2d043ce3 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -28,6 +28,7 @@ if [[ "$KERNEL_ARCH" = "arm64" ]]; then
>      DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb"
>      DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb"
>      DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sm8350-hdk.dtb"
> +    DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb"

Let's keep it at least minimally sorted, puting wormdingler between
kingoftown and sm8350

>  elif [[ "$KERNEL_ARCH" = "arm" ]]; then
>      GCC_ARCH="arm-linux-gnueabihf"
>      DEBIAN_ARCH="armhf"

[..]

> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
> new file mode 100644
> index 000000000000..4af93eeeaf99
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
> @@ -0,0 +1,23 @@

Most of the entries here are shared with kingoftown / limozeen, except
for:

> +kms_invalid_mode@overflow-vrefresh,Fail

Do you know why it fails? Why does it not on previous devices?

> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
> new file mode 100644
> index 000000000000..8d1768de90cc
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt

This is mostly a copy of the existing lists, but kingoftown and limozeen
list .*suspend.* here. If we don't skip them for wormdingler, should we
unskip them for kingoftown too?

Also, I see that kingoftown lists several additional tests to be skipped
(kms_flip@2x-wf_vblank-ts-check, kms_cursor_crc@cursor-random-max-size,
kms_invalid_mode@overflow-vrefresh). Do you remember why?

Overall, I _think_ I have commented beforehand, but I can't find that
comment (so it might be my delusion or false memory). Is there a way to
unify the configuration for sc7180 trogdor devices?

-- 
With best wishes
Dmitry
