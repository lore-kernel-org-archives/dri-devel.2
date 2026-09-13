Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F93C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812DA10E98C;
	Sun, 13 Sep 2026 18:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJB0+VLI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fO+sKhJ9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4630310E0B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:25:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DI2eJ71693466
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GkLKYhzdmWx8ASPEw+bfyEGrvJszZcX0ihy3/m9xYe4=; b=KJB0+VLID+cSRmJc
 EIWHRn+VH954/zglrkOFq0tU03iOMtCk3ZmbQ1nHHCR7xGASsfHWNfQzFHb6SL8F
 hB3ePZ9kXc70wJrEGbmCVFCaTZxBtAWG9i+7hs/u4fTdvL7KmApI8X6QgmazBr21
 XFrx8wSTeIMym88Phf2iEdH/oPL/dSa/JBqgjxS3IyII/CBoFp5JGZ74Et9K3lgw
 rorHUMAZYOvgZ1fSFTdMKjSjX4cn0XaH9S/qLAaEMuW9JF3ufYY3whAgKr9Im115
 er5/s5kUXytHDQdXAOqKKibQnyFR2fLZGvu6YZmoPcODjCylab61rPc68nsMLyFJ
 8FSXRg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018krxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:25:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso2233417a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789323911; x=1789928711;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GkLKYhzdmWx8ASPEw+bfyEGrvJszZcX0ihy3/m9xYe4=;
 b=fO+sKhJ9rg/deXSVCfiBi+r58Jp/4yvNU21Y9Qr6+Nq98rJvRg0W2/IK76n0vGE/fd
 fC8Hncvd0VDhaeVaU2CNepPpOdBWWokWKP0asvH8o9bRceu2sqZ/CaMh4Xgdj366PBDf
 q3selFsykH8nog0Llpqv5FaJUOcx8ax/mwrBVO8bGjxE0UQ66JV3Y8CKNwPFD8b8lrA8
 yavwTd7yT1UsizaYAY6hNR0eQW2wfWsZsARVAYgsS3PFlWmXp4PHliog6z74upUmwNiE
 rC1/yKQrP7CF2o834LDCgnmc3OpVkm11LAzKCv1xzHX7xJKR9ERKEH5B0Fd6uMgwgn5w
 fhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789323911; x=1789928711;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GkLKYhzdmWx8ASPEw+bfyEGrvJszZcX0ihy3/m9xYe4=;
 b=FYXYRPtvj1ClPSqnzWO3vIZMdNu+uGvmpeywAXua0QJjzkWaj/e4DiqgBzGC3UL3A3
 kZB3Np0VrmGuIOv0rg0uk10fusA+b0C5tpT2o0LJXpxWQ0z2B0QVlrHaDLmX6JPLbKUa
 ZeBLRWOTV8dPkjTMGI874OGBALsxyenYVfmLTARdNHrQkKyCmwxqdZJfLu9Fsvf/n9PN
 /CO/+d5etaTdCx1JO1Zuuthqzcluc0Boq0rBk1bADlvU02nIShl2xZz4YtjmQduWKnnG
 LbOCT0N3NHp12xakZ3oGF8adt9R1kv3pkKvcSHX+C9rgi+DSnllgnoRWVdo0HYoCcnea
 2TJw==
X-Gm-Message-State: AFuF++nVvLfU1kaSODZHE6OOgNedNITUFu9tcHA8snhmt45jTdLsofb3
 el0kIgdGZJrxRXs4Au5ovPVxIMsO3l9ymbxPLPuxkYIrsw8eu9cpNOkcYaF8HnWO7dM9uCbUAvj
 az9taH4QO2+SzMIejdHULrSPVTRQnk+ovtccw/ktUZNBKPXyuz3a5gRtqihC4/dQZTauSiLw=
X-Gm-Gg: AYBFou0OsaW4zi3LbGq1Ba9enHtqPDusPmhbSsMDIqVUfoQ+rWoQleilW5932/ddXF7
 /42WLSyPMvRqN69nmgugHBMx5z9hwDIZ7A/h5KdEpeQiybEpDi70P734ADgmaXfcUM0TlrxdNRe
 PMyxWcB8GIQxfG/XK7Q+o7sEbo8yivK/zjumooLMBroMfcFYWBy9Zrjd+HejtrJN0CN5hd61W8k
 kHL+2yLDzi7gK+ubV50SwQ1NPaAQo1OyZqJKE1A5ZdrM01r4VgBtoG9HHmc1uSP5VQgfJPAI+gY
 ICGzK9crxUN0ofFVfPoq7I5ysMzAC/jiHNeo+gGjkwxfPVQrdV7vORwuggngHCFoHw/ljyzHoA9
 XEWM=
X-Received: by 2002:a05:6a21:6016:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3db0e0ea40amr13919537637.8.1789323910646; 
 Sun, 13 Sep 2026 11:25:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6016:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3db0e0ea40amr13919502637.8.1789323910173; 
 Sun, 13 Sep 2026 11:25:10 -0700 (PDT)
Received: from localhost ([155.117.96.35]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf72dbsm23050289eec.3.2026.09.13.11.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 11:25:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 02:24:58 +0800
Message-Id: <DLEEDV17BW1I.2QLKNNOLNOTGS@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 00/17] drm/spacemit: add SpacemiT K3 display support
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <codykang.hk@gmail.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Vinod Koul"
 <vkoul@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Haylen
 Chu" <heylenay@4d2.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney" <bmasney@redhat.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Yao Zi" <me@ziyao.cc>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Guodong
 Xu" <docular.xu@gmail.com>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
In-Reply-To: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa6ea87 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rqWh80hda8-QOrsfWKMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI1OSBTYWx0ZWRfX2DkGscaj7bbj
 gfenYyUznZMKMb2EO2HQFf210rk1HQJomAjXVozaY3zaMjTY+4H2zp8C6crNetTXizp9fbl7FTH
 thasJgsBtPbsx2GKLnQ6CIGSqW+8pjA=
X-Proofpoint-GUID: zn0-zM31qcpWddQokOJflpsCRgm2a4Kv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI1OSBTYWx0ZWRfXwkdQRiixbjvU
 /xZ09AeTJ9bHbozA/fCWb1PDUSsyZfVG+mU1MQnmFczLETJXv89wSEBORybRUXKGz4asdSmkjOe
 kcoTuTz4pp17XkThlDDZrzHWiabI5BzX+eyHD/A74JbuDRnQQaVb9gyt21gErkGylIdhDLu3a0R
 35mmdYdGFsTZIMCuKQJxENNMmjqI031VLczCdtExn7tHVihFdb+6SSsHkwGDsGdfW7mA/ht72Yi
 +jad31voOGiA+kKM6L494tO/jAqpQLxlUIcDLWBorN4JpMuY3zFnbyEhPqySHkuMxXF9PmqjF5f
 u/7QJXBJ1SkLssdWfcTZpHjhmHNOodHy09qsFq/dRhJd9VZQ5UZv5bazad7xZx4lVdO/XVpPXLn
 TqLU022yafk9dnUnM7H3BpwDA61hyTxRduF0hyIZX1STYcguh0A4TXvPEl3bzUWMGBFF3X0KE8W
 lWk9h7kMAVSTwNR6wWw==
X-Proofpoint-ORIG-GUID: zn0-zM31qcpWddQokOJflpsCRgm2a4Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130259
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

On Sun Aug 9, 2026 at 9:14 PM CST, Cody Kang via B4 Relay wrote:
> This series adds display support for the SpacemiT K3 [2], a RISC-V SoC:
> a new DRM driver, a new PHY driver and three new bindings.
>
> The display path is three blocks deep:
>
>   Saturn DPU -> Innosilicon DP/eDP controller -> Innosilicon DP PHY
>
> In v2, two major improvements:
>
> - Module unload is now robust.
> - The bindings now require the controller's output port (port@1).
>
> The rest of the v2 changes please see below, with details in each patch's
> changelog.
>
> Sashiko AI review contributed total review comments: 57 items, which I
> accepted: 14 items.
>
> v2 repeated the full v1 test matrix on both boards, in built-in and
> modular configurations, plus the new module load/unload rounds.
>
> The v1 cover letter follows below, unchanged, to provide some backgroud
> (I can remove them from cover letter in next version):
>
> The Saturn DPU is SpacemiT's own display processing unit. It has a privat=
e
> address translation unit and a command-list composer that replays a batch
> of register writes when a flush is latched. It exposes one CRTC with one
> primary plane. The K3 instantiates two DPUs, one per display path.
>
> The DPU driver arrives as five staged patches to keep each one a
> reasonable size. The driver only becomes buildable with that last patch.
> Bisect safe.
>
> The DP/eDP controller and its PHY are Innosilicon IP, also two instances
> of each. An instance behaves as embedded DisplayPort or as external
> DisplayPort purely according to what its output port is wired to, so the
> bindings do not distinguish them. The PHY's registers are interleaved
> with the controller's inside one MMIO window, which is why it is
> described as a child node and shares the controller's regmap.
>
> The pixel clock is generated by the DP PHY's PLL, and the SoC's APMU
> pixel-clock mux takes that PLL as an input. Rather than let the display
> driver reach into PHY registers, the PHY registers its PLL as a clock
> provider and the APMU mux is parented to it through the clock framework.
> That is what patches 2, 4, 5 and 6 are for, and it is also what keeps the
> APMU and the DP/eDP controller out of a devicetree provider cycle.
>
> As a first posting of the K3 display subsystem, this patchset supports:
> a single primary plane per CRTC, linear RGB scanout (no plane scaling,
> rotation, YUV or writeback). It does not support DSI, DSC or DP audio,
> and link rates are capped at HBR2.
>
> Based on drm-misc-next at commit 5b9af25f2d0b ("accel/ivpu: Remove
> unnecessary min_t()/max_t() usage"), v7.2-rc2 based.
>
> Testing this series needs a SpacemiT u-boot carrying display support
> [1]. SpacemiT expects to add that support into an official u-boot
> release in August 2026.
>
> Tested on two K3 boards:
>
>   - Pico-ITX: an eDP panel and an external DisplayPort monitor.
>   - CoM260-IFX: DisplayPort only, no eDP.
>
> Note: The eDP panel DTS enablement is not part of this series; a separate
>       series will follow showing how eDP can be verified.
>
> What was run on both boards, with modetest from libdrm and with kmscube:
>
>   - modetest -s, looped over 1920x1080, 1280x720 and 3840x2160
>     on DisplayPort and 2560x1600 on eDP
>   - kmscube, on each head and on both at once
>   - hot-plug and sink swap on the DisplayPort connector

Hi Cody,

Tested the series on a K3 Pico-ITX (mainline v7.3-rc2 + these patches,
display drivers built in). On the DisplayPort output:

- modetest -s: 1920x1080 and 1280x720 OK (native 2560x1440 as well);
3840x2160 not tested: my monitor has no such mode.
- kmscube: OK.
- hot-plug: unplug/replug detected, output re-enables fine.

Tested with the stock vendor U-Boot (2022.10); DP works fine with it.

Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>
