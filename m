Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTAMvPwP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bWbsqi/+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D5F10FF97;
	Thu, 26 Nov 2026 07:33:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C396210FF97
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:33:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7B1kh2175705
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YBSRWO6MC1F0PIG5BHgyDYra
 H89PBdVkETYH3/gn8Uk=; b=aTAMvPwPqHQpfSSIjX5E4px1lnzG2cUdofHhTWjs
 rEdm9YMKeU/HXSLrwMyyx05U0fRnumVrEGaAeqc8Xy4YhCxqx8eizuZssJ45o1xK
 34HW0aL29/rUwWASLeQIpRDvHcf7SV2OAvrNlOzHAIClC5QsT4mN7Dgav9EMkfAT
 tY89Z01pQXJhZWUFfi+urUkbU69jnIX6xsh0W1b3AQelmFlVyGV2wbpFY+jOuhIo
 h/X9hHsgf4tUNmovAMMKwYMdCw1HIdke+dAuB1FPDL8H5thIEcVgpkrrEPxDi6T6
 Mbjp+41D45mZc609bQdliJAMBJUNhXB4QT2S80C0mVjwMQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahu9vr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:33:42 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b0f1c06332so98253157b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795678421; cv=none;
 d=google.com; s=arc-20260327;
 b=fK1kUxnYgnquUMG6oui1D7LT6h7vWn+t7u/yolYSsaeqh+mD+0w1SKuT/PzY4UTFJa
 ozM72XD59hE826/JDbGEbyOA4V900TLyvuRnsm5Aw3kFUSRYmkd9tSJZ9IenIMhE3S4u
 UMo0V3YeXBSVlu7smK5N2igi2Td4Pqq+iMd4FMwYF//qbLtd6ORjLH7I30bYv7oE5+KP
 S5f/fkJnC900auqRyTvCh19as1NfLfl52EtOLuNWL0MFasrft1cLHB1jIhHwY8Fy2wx+
 4ojeaCCCihAaT35lmH3YTZ2si6RbsjR02364eJQ+sapwj7yNkvPiMJ6Uze6EHNx55Ouf
 fGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YBSRWO6MC1F0PIG5BHgyDYraH89PBdVkETYH3/gn8Uk=;
 fh=dPVzZ83nG1j3UabqkvF4I6z635pjF1yc7ENg25W2BF8=;
 b=Ki6iGzYCSrDLPCbCE4s8v1q158YQ0QZd+0Z+lSqyigc8BzKn3ZYTPjnpXbexwkfPlX
 Pf0ppoeGNMtDBPZpQRfOdnht8UWl5ydKl2Id46YGcARZwnTaHASy5DPUsa3GzM8yOEkv
 S2V56BQJYayLI68DuCdL0AhLKrNvtAuJUDPDNEjUdrmw2tDYNKAXvUjZtVq2YY/rvo4S
 b9rm/W0L3FiN/uUhwYFvKhe7PVJghsXo1nnd9V/O4rOmPOfugrW37BFt9i9vSRtPmbFR
 htOr4A6r57Hmlg7xVFXheubR7tfWMhxbut6xP7fnjc0xCCleWVhmAR7KD8zbjNc5HtFd
 0aWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795678421; x=1796283221;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YBSRWO6MC1F0PIG5BHgyDYraH89PBdVkETYH3/gn8Uk=;
 b=bWbsqi/+UxY4JNWtLCwnWBu1IXGHQJbVDhKL0gNGB1pgW1TYLMBRg0dhYXng5o1Urc
 L3Vm92qZ+st8/aCRnXBX1sFJvTMnNgiDIV8zbFQ4XtBZ1znr18qX2CmS6gW6baYZx0Sa
 PharGJpBLYQR7ZJF8ugFY//WLMmNePnYbH6q3hTj31ZJAhylgWQJwveJyjEu0fj9qBWN
 ZYUyneNMVyNn5SL3n5JklXtKaN+fda7f+L7921FSV0fLD25zlEDda2clLCcHc+AxBAlk
 dfZSclEdQQCW3aDeENd2Zx5m3p5amj83G7UKzb4nAEdGrr0Ld216ryVYKlci/OJp5PTD
 FQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795678421; x=1796283221;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YBSRWO6MC1F0PIG5BHgyDYraH89PBdVkETYH3/gn8Uk=;
 b=Czzg/sB1mAvuQ0upzdt0EX4riEhB13fhFqPKRs8tHr7Ce7HnR1l0a8WcWL2CNzEYZB
 R1w3DuVdEbZV/kTQsTlI1u5Z7jemEYjBelk3CS80HH9OZ1JGW67bhLybxt1h5lH5fFme
 SJ8hEMVdaPN9yJkiCNmNOtV0l4mZOt8cJenGeu5JdFPND2CA4lLfGY1eGTxEF9OBCmyi
 6Drl2DHx9ryvb68T8h+2vjF5zUAAakUkxprycM/Az+4ljdy5SzldNKdZJ+dBjJYx/Tkb
 88zaAsHbCciwF+YcaIKjPLBggbfd9eBjOedoC/GkKLEECu7PyH7k68Q7A3/Tf6IBEdcM
 XJ0g==
X-Forwarded-Encrypted: i=1;
 AL+hErHZbfZ072sSsX8WeNpaDie73aPxQxujTzTyW3NWJdjTRLBGBdnYkhn+XaY14CfM9JN/Fh12u+QTWf4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80d0ypml1kn7//GM/gQGupB6qewwn7nZ5n9vZe0yBJhA01hwHv
 +9ZV+YmUAZAs/K/vmVmCp1xNg9BGZlMrVXZrY4MCSoJMdpp0f5lOtBjugkuOBLh8LYBAnDu8rOn
 p/PylF1xUuDbjgqJh2NvyulHY3z3S0/jUND8woy0WPQQWD2SfN1ANwQuKIECHMA8j/u1BoRyd6Y
 6geOhtrvS3KhISriZ/FqDUcBQnDrtcqsskOEgtsF1SXNhJsQ==
X-Gm-Gg: AZFdTZeIkC2BlZRgH6jqNzmFw4kLzOZ3hQoDw6B+q/csJ4+5bjlgzwY5C4p8YL3tiUF
 SN5Z2y2b4K/UhokOG0GJ2VpB61iMFvdPpzNhXJ4fbjwOCo9oyoetErJFL/5CkyMbUSALQuX5oiZ
 zjpxWAgWUJre7UH0KT+m3LP+t2uYeUlJJyo0NyXvYNCCDIPeT1oKwyB2sCMC+v2CTZDXbF+9y6f
 AnVwQ6VxY2Wr39NFg==
X-Received: by 2002:a05:690e:1407:b0:67c:8a0:db52 with SMTP id
 956f58d0204a3-67df4429198mr9258166d50.67.1795678420901; 
 Wed, 25 Nov 2026 23:33:40 -0800 (PST)
X-Received: by 2002:a05:690e:1407:b0:67c:8a0:db52 with SMTP id
 956f58d0204a3-67df4429198mr9258131d50.67.1795678420457; Wed, 25 Nov 2026
 23:33:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
From: Chris Obbard <chris.obbard@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 07:33:29 +0000
X-Gm-Features: Aa3M54p9KPshpOehHxoS4BJg-DAEPGiNryfudrEn_XbVOFzPOSXBBvyMZarG90A
Message-ID: <CAPnEM6aAK8hwJ3EfhzS=gdMPTf+bhVgS-=JAoM+axcHzBQ1CGg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: l7pJ9cyoF2C1U57pqTB2ypiGscauKWCP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyOCBTYWx0ZWRfX/8USj+DNwu0l
 ESXKxlHnOi3pt93OD3xhEXRAZZG8oqo4o0qQSP5iG32psysweNlE6jfXHg/gX2VFjCUlRSbHRr3
 SrukkBPWvhR1S6DA653LDN2PR4/8Sqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyOCBTYWx0ZWRfX7JHWLP996+zs
 oLJfQiuGwlnbrL7pL8FGGFEJbrSEhkcNz5Kl1TKchfR4PGqBtHWziJd9lO4a8ZJgVagD9/0A6iu
 p7LFICk1c1Ga6x262GbuDZ31LjBG01BHiVcB/WQRRFQkoOvxiZTeB0dn5DMNFJH5bVmSIYG6TMU
 L4v+BMDPmrmpUCQFuAPS2xRU6IkkpIzKGxvB0Lr83CgUPge+jIpJoEkW9TpHqCVUGyxKY/nwrNR
 XssebDmZ3XK7xUJLSk23JhW9BndiHaTma7PMyk5pM79F4wTedLW9usnDzuAJ6Zk98P+s8DiUhHq
 HNoJR7qDLn+i87yX/Q2T1wM6YwdM025ObUNzycH8b4PMpKsUy54Ddnzh/3A9Tm3rX7sdMfiFmfR
 hBC44uHOmj+wMl3osa0bQvdMTwBAhQdt5Ypk3EBbFtNTiwA9fWGQ1dX65qhKlT906P4yKlqbEqT
 baak+NSmpDdmuYBGkUQ==
X-Proofpoint-ORIG-GUID: l7pJ9cyoF2C1U57pqTB2ypiGscauKWCP
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b07e0d6 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=ksxQWNrZAAAA:8
 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8
 a=P-IC7800AAAA:8 a=e5mUnYsNAAAA:8 a=slKOw8fCkYvWlRKagp4A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=FO4_E8m0qiDe52t0p3_H:22 a=l7WU34MJF0Z5EO9KEJC3:22
 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260028
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey,

On Thu, 29 Oct 2026 at 10:19, Xilin Wu <sophon@radxa.com> wrote:
>
> Hi,
>
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.
>
> The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
> E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
> alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
> a 40-pin expansion header.
>
> This series adds the initial device tree support for the board. It
> describes the regulators, storage, PCIe topology, USB and display outputs,
> audio, remote processors, thermal sensors, RTC, EEPROM and expansion
> header. Build targets for both the regular and EL2 device trees are
> included.
>
> The TC9563 power-control driver powers off external downstream ports whose
> device tree nodes have status = "disabled". On the Dragon Q8B,
> config-space reads to these powered-off port functions raise an Arm SError
> instead of returning an all-ones PCI error response, preventing the board
> from completing boot.
>
> The PCI OF change to skip config-space reads for unavailable DT-described
> bridge functions has been split out into a separate two-patch series for
> the PCI tree. Disabled endpoint functions remain discoverable so PCI
> fixups can still be applied, while driver binding continues to be
> suppressed later.
>
> The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
> to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
> flash and requires no host-side configuration.
>
> The PCIe ECAM and 64-bit memory windows are defined in the shared
> SC8280XP DTSI for all five controllers. The board DTS inherits these
> SoC resources.
> The SA8540P PCIe2a and PCIe3a address maps are kept unchanged.
>
> The series also documents the board compatible. The SC8280XP TLMM binding
> change allowing gpio-line-names has already been applied and is no longer
> included in this series.
>
> The PCI change is required before applying the board DTS patch; otherwise
> the disabled TC9563 downstream ports cause a boot-time SError.

I've been testing this series rebased on top of Bjorn's/qcom's
for-next [1], with a vanilla Debian forky userspace
+ gnome, booting from a USB stick (in one of the USB-A ports). I've
had a couple of issues:

1) Reboot shortly after booting; with:

    qcom-iris aa00000.video-codec: core init failed
    arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
iova=0x00000000, fsynr=0x120001, cbfrsynra=0x2a00, cb=7
    Unbalanced enable for IRQ 252
    WARNING: kernel/irq/manage.c:776 at __enable_irq+0x4c/0x80, CPU#6:
v4l_id/918

Adding module_blacklist=qcom_iris to the cmdline works around this; I
didn't look any further yet.


2) With the above workaround I get to the gnome login screen (GDM),
but the device appears to lock up when changing the password on the
first login. No logs or reboots this time, just appears to hang.

I'll try to debug 2 some more over the next week.


Have you seen either of these issues? It could be related to my rebase
or userspace.



[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=for-next


Cheers!

Chris

>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
> Changes in v4:
> - Add the missing pinctrl configuration for Bluetooth UART2. (Sashiko)
> - Link to v3: https://patch.msgid.link/20261029-q8b-dts-v3-0-655696dfec45@radxa.com
>
> Changes in v3:
> - Rebase onto next-20261027.
> - Drop tested-by tag in the dt binding patch
> - Drop CH7218A patches which have been applied
> - Mark vcc_5v_s regulator as boot on
> - Add the device to the QSEECOM allowlist
> - Move PCIe ECAM and 64-bit memory windows to a separate SoC DTSI patch
>   covering all five SC8280XP controllers; preserve the original SA8540P
>   PCIe2a and PCIe3a register and memory windows.
> - Format the board DTS with dtfmt and fix subnode and audio-routing layout.
> - Drop forced output states from the SBU pinctrl configurations.
> - Explain why full-pwr-cycle is needed to recover the SD card state left
>   by boot firmware.
> - Link to v2: https://patch.msgid.link/20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com
>
> Changes in v2:
> - Describe the TC9563 embedded GPIO controller and use its GPIOs 2 and 3
>   for the external downstream port PERST# reset lines.
> - Drop "PCI: of: Avoid config reads for disabled bridge nodes"; split it
>   into a separate two-patch PCI series, including the kernel-doc fix.
> - Drop "dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names"
>   because it has already been applied.
> - Link to v1: https://patch.msgid.link/20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com
>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: Abel Vesa <abelvesa@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
>
> ---
> Xilin Wu (4):
>       arm64: dts: qcom: sc8280xp: enable PCIe ECAM and 64-bit memory
>       dt-bindings: arm: qcom: document Radxa Dragon Q8B
>       arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
>       firmware: qcom: scm: Allow QSEECOM for Radxa Dragon Q8B
>
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi              |    9 +
>  .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2053 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   25 +-
>  drivers/firmware/qcom/qcom_scm.c                   |    1 +
>  6 files changed, 2081 insertions(+), 10 deletions(-)
> ---
> base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
> change-id: 20260901-q8b-dts-a3afc5f9b8b2
> prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v3
> prerequisite-patch-id: d799218553d1a8d44d83ab7d5c36a9ba7dd05e92
>
> Best regards,
> --
> Xilin Wu <sophon@radxa.com>
>
>
