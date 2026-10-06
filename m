Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D89CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F6910E013;
	Tue,  6 Oct 2026 08:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N11QSB1z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOdefl/W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4DA10E013
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 08:53:21 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6967ScGk3537533
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 08:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QQGtjGd8ssqWuv/V61Y20ONf
 ksGn+OprzCvB7AXUQWs=; b=N11QSB1zHyJJcjTIZFpax126Tk7PweRduHBLIQfr
 9WI/6tPVU6/1Sq7jSIhD7iJncx2dewrhweyDOeUxV7rS7YUMXPT4CrkLbzD5QgzM
 2q+RyDEN71+5KHHvSjS5clpUzoAVcBcq//y305l50RsWDd6KAR//l+rjuKWZCW2+
 wipkInHf7SGEizuN4h6jeybHNmEW2SJIBirz46aStIzpgr6hKBd8oLIihZDzjNR7
 sb8BuFtQnbettKsV3vvYdZC4V6ZTrDJylyo07DXmfIVN3D37HZ2g3ECCIl7F5JQn
 rUollOwbyfQoRHPqdxD6SfvQavDSjhPpLiyRB6m2GiM92g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrr9dm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 08:53:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e594a90232so25086615ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 01:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791276800; cv=none;
 d=google.com; s=arc-20260327;
 b=D/tp3rJf5B39yQTK61CZkQsf1qWudUH7g8QxTmT7QqAE0fwZPy1FmSDAIS7t0eY2C6
 sIL8KnRa/QdvpGM+hXjO0hCIF7pWWvCllyZCM0/tTFDBMTE6fD/+Tdinswx7JayPx+ty
 DEsiez8NsPqKF0Jmojxk0drTsrOWDn4kMVohokHkC85/QSo7Lv+yKYVyFeqc52eJ5PAT
 +Q/xOSpTel+suD3zWEfootcO5b6opcvpHL3iJp3mftl8jFMBPRP/r9+ltrSZVPHuMHKa
 Xcj7FIBPnmYpq18i+LYRq7DindWyKt7Z++aW+EahzR3ObTRKg3tzu615+OUVM+BbvZ+E
 7N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
 fh=8zGmwH50SL0E4HWfceuQ1bsagfFqbVLz+wJPS52PtcE=;
 b=qh/GIK+m3TegsXIJ0CEblG//evYJSztnZ4oIJMTahDeF+0HQfO90q0vUtwRoKw6BIo
 ABFAC05El+fHxZsdgJZUPWbwxIlTZ9pOlxJE6FUTzOl/rp2IAbRCSULmojBKwiA9yvL9
 BhEfDm1WI0kNMshY3I1BZ5sscFRwZ+bPTlg2v7OG5pliWilcqHwD+RthPQtnmnt73ZP9
 C0YQbrs+U0MuTzu0dqfx+lgFI5VhW6hEK3FAHfK6UfmeeJVmJFRZx68F+ghs7P8o4gve
 gu/3SiTAkMGeXmDuTss8D6l1SdzMbRl3pMF5lPg2QnLbBTuSw5QCWaHbvpgHNVnBr6C2
 ZzjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791276800; x=1791881600;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
 b=eOdefl/W+8+mnNkDXeSPmVPqVUKhnxkcrlEaFfmDqdscQS/V3N6MtwVoJmAuhlRdDP
 UArI+f8L+2PmhYLNNaNEHSxzL9zlp5Vn9MHwW0vZga52vqBPZ1oF5syBSKijGjQew626
 Ltpe17NN400YzQmXyNG567ewYVIbmA/m+ibFpavwmjYg1Qnrgeow8O8oj+LuT8PfXDw4
 FE3GQ1WcQDlYpylAAX08ziVZ8Uz62UXnCtGHaKbADw5FlydQmrmQ8JZTg9arpNYJDFRx
 mUTlJ3zKbaSiHsXtn+Jvqui0JbU0Gnz4O65ZiDHfIqKEV78po/8tnFuy6pr5qsFbhI39
 YQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791276800; x=1791881600;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
 b=OzGe71UBwJ8/QHgPyXIjQRxQZxuaN3TMV6fpUGEumTXfLIIOvvi0dSnwBpxkMPk+4K
 cE75WLopPRF5/+06KJogBTMnHF3+J+igB8Se3RHod9cf/fwt9T2QAV7VMPk0B19aJYnY
 aXf36FcFAZr1ueoFDT/kHdi7zmfGAkrCN4baSo6aerQ9sMs3szBQImi7Q1TvJlhkoqbD
 DD1WcNChWVKUaoXy+SNq0+8FevjaAaZDKiVDzxYFJcH1tD9xoOfJE7qL7fT0fjNLDvI5
 LUbg9Pp2qCu/in6QvBI/G93V1c5iHCoVeJ7VRLuh4CZFJYOWNbgMft11+WNvB4JE08ak
 7K5g==
X-Forwarded-Encrypted: i=1;
 AKwUvByDx3u+NggubKyXPPD0fc0LlvyNr1QGOeMcYSj8Fyp8Gsa7mIoL4amcOFaSvMGs3nkUM9O3E2o09uI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI77f/21wY9f9c2iuaUmREnUDEeLQts1xKT4piA+hYFg4/oZN29
 Hdfm6uT7jlaH7fS93gjvoB8HffjLWeK/XuTyifuDElUYonpL184oP0kcAb9T032a5juHjAGXuIT
 L18Vgca5+Qvuv6fR2fPlja3iQQQxFi5Xypwqu/h636Q9RIycWZJfHsSslOFFyFcYaOszVLQNMmP
 1oZXvdQ45uRhwRHB/ju4DZlnaafTP/lN3UuuCVJNpr1XRwlg==
X-Gm-Gg: AYBFou1SZf13LpToDU1XPemoTyHDw5huYRQGvdUFyvTtn14I4050YhRXjprc2wWLrzB
 d/3dX5F1A8Vsv0rGNvWNMiiSBNRA5ytVS5wbkJo5h9a6qXDWkwGvYQ7+wJFWBU9W3Lntw7TCIM5
 s796PWqj33JJFf0B7LwvyqaehhkRcEx8SotJXa4eyjHzYqvrfsJM3ywcpMvo9nXnYmtvcD6Kp8e
 vE4daPbdzqmVS4=
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id
 d9443c01a7336-2e5dcde4da4mr6597225ad.55.1791276799656; 
 Tue, 06 Oct 2026 01:53:19 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id
 d9443c01a7336-2e5dcde4da4mr6596685ad.55.1791276799127; Tue, 06 Oct 2026
 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <179098834078.3641559.798772743228949994.b4-ty@b4>
 <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
In-Reply-To: <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:53:07 +0200
X-Gm-Features: AclHuK-hxeLXCCkrwwvQbFIYUVeIjRX4eEFvyGsggP4ez254hGL6BWI-C4KAx08
Message-ID: <CAO9ioeVAf2GgS+wu9GiQ3kM-_1KnrdMfhcpVotxhiFegEiZP2A@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac4b700 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8 a=OuZLqq7tAAAA:8
 a=wG-LvS21qxlCLh7KYX8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: QDbtwdP3xGQdAmNRGKBoehwn2Lq_snC4
X-Proofpoint-ORIG-GUID: QDbtwdP3xGQdAmNRGKBoehwn2Lq_snC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfXwLvGnygNqUpD
 SSMEvcWCZwjio5PDsuBGS8whM4RIjq1zbW1WyVebRzCnCzTRcpjd5fee6rQ/tRqWd7RfJ3CqEd8
 4Bmfcv7qfoxsAPqUXRUwZwvU/d/d+I7/aJRVI012R8pNrl7owQIJqHbCWWFTT9R0plWtA3yBiau
 +KkTQoOdKJ7NO5H5hLpx8vFrKq3cp0h42S2upte6IcFVC6XWA7JC7uLHnTJTN4HPi0+B/LbcdvR
 ifNDJw2b0mRAI2i7kGgVh+gx7zrRfL/uOq2AZzD31tbqbY/fxaMhGQHhmYYBeN+9VDs+/Bls5eE
 LvnD4d39bSbdVRed2MWs1C43MLStAo3AhuT2Nl7d5UEFTs+AS+KQswEVMI9aXyfDWeKJroy7U5h
 zY1A8NCt2k3QEw/+S45or+8A8XG1JBmN3aQuXjQfWZs4t3bEo4wLZh4BQGyUNztByu3jFL5bEoM
 XIXHv228naUf/F48vQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX1o96PkGMVp6V
 5UOsspLvGuxojhkrnL8PCnYkmGSsclrCIx2UMvboBVA7HDVIju2qK0g2O0EZe5RwKUzfPHi6Nxd
 JKobpt3isRZ0yYIrRq6C7L3W5r6cP1E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060035
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

On Mon, 5 Oct 2026 at 16:00, Muzaffer Kadir
<muzafferkadir@mainlining.org> wrote:
>
> On Sat,  3 Oct 2026 03:46:52 +0300, Dmitry Baryshkov wrote:
> > On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
> >> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> >>
> >> Ported without uart connection. ramoops and usb
> >> mainly used to debug.
> >> USB is not enabled in this series because it
> >> depends on the not yet upstreamed (and not developed by me)
> >> pmi8950_smbcharger.
> >>
> >> [...]
> >
> > Applied to ttt, thanks!
> >
> > [01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
> >         (no commit info)
> > [02/19] clk: qcom: Add global clock controller driver for MSM8952
> >         (no commit info)
> > [03/19] dt-bindings: nvmem: Add compatible for MSM8952
> >         (no commit info)
> > [04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
> >         (no commit info)
> > [05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
> >         (no commit info)
> > [06/19] dt-bindings: vendor-prefixes: Add General Mobile
> >         (no commit info)
> > [07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
> >         (no commit info)
> > [08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
> >         (no commit info)
> > [09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
> >         (no commit info)
> > [10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
> > [11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
> >         (no commit info)
> > [12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
> >         (no commit info)
> > [13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
> > [14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
> >         (no commit info)
> > [15/19] dt-bindings: thermal: tsens: Add MSM8952
> >         (no commit info)
> > [16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
> >         (no commit info)
> > [17/19] arm64: dts: qcom: Add initial support for MSM8952
> >         (no commit info)
> > [18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
> >         (no commit info)
> > [19/19] arm64: dts: qcom: generalmobile-shamrock: new device
> >         (no commit info)
>
> Hi Dmitry,
>
> Thanks for accepting MDP5 patches.
>
> The message lists all 19 patches, but only 10 and 13 have commit
> links, the rest say "(no commit info)". Does this mean the whole
> series was applied, or only the MDP5 ones?

Only MDP5 ones.

>
> Best regards,
> Muzaffer Kadir
>


-- 
With best wishes
Dmitry
