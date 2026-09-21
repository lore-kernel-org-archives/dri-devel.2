Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE9BC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BB910E151;
	Mon, 21 Sep 2026 12:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDV/uRKt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hPcGt4xK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B9D10E151
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:46:22 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAdvEU3818642
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=; b=FDV/uRKtPIY5Te0O
 /bQLtP7WCvqplyZdNh/yoW+2tP/GxJRj2pu/B6Bsl0tycX9TtwpAkZ2N0+iOYQKl
 JoIpLSfJsY+e7FBiFpYhQMo6g3XgQhIwE1nJh3JJb9MfQWsyWEC67O1f35xHuyZX
 z9qj1VvujtNw6wroAqLSizpGFKgzMfc5UYFj9zFzgjqJMMEnIgx1EYa5V6PwjB2a
 eidrXvUd6D9+bsRQYXBngget4ljibpHdqFk+dqh8Azy7g4c/vHo0NXQIrO3go1Ax
 kN0Go5GB7uylS/SACc7SzmeISBCOdGJhbq82oCS0UvZ4gOSftSsIEswUdfChrIa7
 CyqGeQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq79ap35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:46:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso6490a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 05:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994781; cv=none;
 d=google.com; s=arc-20260327;
 b=ZjjF+2sjQP+viphOpyZe7+9GIaMnVb1cOsVP8P3AnZZqsyyP+rysEp6u3zE2DYuCNC
 PDMgmzIPlLZQz1IeLIrlIVpRD5E0p4pRTOTIWpu40MCdpqeZVZk4IgF+gk6XJTdhNzME
 CX9P1nIUHDd+VzruQnGigMD3fAhuz+sD85VE/wXU/c3XWZJPkQdYBhMxxQfIFsZ3kEwh
 8VO7kbW5mhaQcBsYmHukonTqspM5Ah/lT/jMAA1rXIPa6Rh1oIL+klJUUebh7XDymh6g
 sC5SskaEjxVTXPooS3CPz7iJSZSjAuyGnr/7JDFebyvSPxVkeq68uAe6vnWQ+bYYIL5x
 E7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
 fh=TPAkwQs76C8O1ygCaJN2yEeRSVoEjWkQJcFoC4bG5Z8=;
 b=FrnVhXTIZpwlkxsWdrQ55ITv2Y2UGqRRsOYekGtLsk1P+exI0HVjHfYPTleOqzPa26
 f98mX7mmqPyPNAdGbVRSyJNpbfsq0VwNtF424U1EoH/+e7Gt3Q50zbjcdfmkwqJFMfnP
 7koqobqTPe65cjUueUDqt3VPGvH/4ammzed7yV6wdM42wl2+o3xPMFrIDD9D9wVtJJ1o
 OYoheML7cpaAsEBgiYQFMePNFBNsIt1+x8skI1U4Dng7DaIfQL0ErGERo/77/S2FnKdU
 3rW/CLpksgq2ewFWnGmclWiB6Uyy/QZ3N8tDJZnAQ7QEHY+tjSyIMFJCLCEsRI0o4l/2
 NEiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789994781; x=1790599581;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
 b=hPcGt4xKDtBwZsvxfjvd4JazHOaV1MRbKpwB7Onv10zBGv02Edx2YnQ1ivNaOS2Ds7
 tNSjguYz0SZwK+iLDUQqXvw04uisDqjux6/YiJ/l3uPL5uGx470N+2bDqJ4ZXrgafpj6
 YgZA+Pn68RSRix4WvKgsEGY9wPTrFVotZaVWpvraMKaw/Shjrxc9bd5H7MkzbXUwerSo
 wvGq2d15khJYmxfQslYxP+ICpLgTJcjLfdtP7jDVPHt0QjpiTum9Vdvy2dvPReNYEdSB
 HApbW7YPhaP9QmJcWKpFGMKs16YymlG28lh1UVMFw6jI78khUws7e4tx0kSezNjTc0yo
 vRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789994781; x=1790599581;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
 b=kQr0yHXmqCvfw1eSjJKO+NC1FjlzI/WIe9zqaY9GSVMoaiystTjOE/S5urxHzmSWY+
 0xKiK++I/9tUFUO6vbhPp1Fq67SSKKqbsfLAvd6FevJwU/T1jB5IiGDbje3Sas8vYfBn
 lFNI0Lu7Um5oLRNcEnSPydGYg06nLdovU1i9Wo9SB96pmU5t0U357+mJoXYaQl1ilf7T
 EkBqamfdjahRWI3yPM92JyJbkeRqtaP+CxQ/jodnUnu6vyZoY7pmLclbIwlvwIUH30tc
 cwfkAeChGz3Dmz+36LvDfZI+K75CORfBvWOL3Jd4f5r5rhXbk2vHjBNYtirLuGngXktf
 Sn9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxs2fP7+kZRmD/Qc9bhnur9kvuG270JKGIH2lEnWw/j4a6lk9UtCKtr3RFU0IBgqky62zkGJqgwjms=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nM12cbPh9rI3Z4ABivAiP8mRBrt1ZLvbNLzJxYpdX/OEvCt/1b
 EvPDxxogrz7iXvpCsisJGQyzSeN+77smXPO7/QD/N//CzOAVJsQAvifcTirBhqOyyUGWIvdmfos
 ElK2ZmpW7WQRdrdeTbIqCWjiYoNdRxnASHYvi/xojUu6sTTgqCipDRFP79xqOie4N0rUnAASPkK
 nDzKVt4K1EQhsyreNwEiF8B+UWonlaQWuR8xyduuJFhDHECA==
X-Gm-Gg: AYBFou39j8UMfycJAnuvBPMekRWUd8ebZkWu32h157A3CQpcFUVr3ZP1MAUxYDn3Cvw
 2eFDhklsB1Nfbtxd37fS7aqZWEjUBglxrvTaAD1fvFKWlcDcKn+7/ltLnBzP13nH0ocaCVo9zxC
 2NCMXQJNT2yIrPXj5Ae2XvAVrZr9YxiqG6YkBCahGHnbYDGXsWQzcg18o0Cw==
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3dda197f85emr11235073637.57.1789994780994; 
 Mon, 21 Sep 2026 05:46:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3dda197f85emr11235017637.57.1789994780421; Mon, 21 Sep 2026
 05:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:46:07 +0200
X-Gm-Features: AcwNN1X9mUUfG00OJyVIt6nOyuDWy2ZSHbWKT6BOlwyDwHXMMZbGC4tmToAM-O4
Message-ID: <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ab1271d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9GNsruGHAAAA:8 a=uuLM8HNXhctW1a4qv2gA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfX8HuX4XmBK/ZW
 CR+km7vKj5pa+HMEgRtUpEwO23bGGMZKz74jZuAxwe+QqVYEXr6si0qRJUlClSbU3iUQ/JlZGCK
 r6cwByPTd4B5fhnl6TRDLlTYr7iMRho=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfXwSurli5PqxRq
 A+Senl/RmkbjVLmoLtvKwNI1NBHiboMB5syjeT7YgWNCjEaSiCPum+srFD/WrmRaq939bt8r8hS
 PH+QYe/6G+t7YbsifD++4xFhCmvd6OFxZeYdfckeBU+/5Hf29UTvofcp4zXFoh3XG7U+9VDtv7/
 zFFKpVNVqufcHGqlGgsg0jm7tWrE6Z2wzRs7QMtvoO/Ku/Qmk6AKdm+Cb4mGM3kmEvT12h3Vvp/
 CeBwhkPKIn4SpKpW1D4/QwHjL5/a36QPEf+OUj0OZ2r8i9TcNLfAkY6C0h2og4um1a9IHEoHuxG
 24gH4KOIRs1CGc4MuTd+b1HbLXLyH1UVsQb5QYNSA9MqZGquhgs+jNdGz2JopUObR9CyMA89wj3
 BuedOO18mw7OGMWi4ZA4aO5fJ8phvHsIS3nxX0VZP4m1aY1lnghgh2cjoSs0IvqoIZhO4xlYeuI
 WPLhEwHaA6Y8upDB8Dg==
X-Proofpoint-ORIG-GUID: QbtHgw1VWN_qajYjGpZO3a8JX8aySVuK
X-Proofpoint-GUID: QbtHgw1VWN_qajYjGpZO3a8JX8aySVuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210185
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

On Tue, Sep 15, 2026 at 12:43=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset where the RK3588 has two, no NPU SRAM rail, and a
> PC_TASK_CON that packs the task number into sixteen bits, not twelve.
>

[...]

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 151 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  83 +++++++---
>  12 files changed, 456 insertions(+), 63 deletions(-)
>
>
> base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
> --
> 2.43.0
>

I assume it's fine for me to pick up patch7, 9 and 10 from this series
and funnel them via my pmdomain tree. If not, please let me know!

Kind regards
Uffe
