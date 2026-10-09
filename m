Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A26CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B30D10FFA3;
	Fri,  9 Oct 2026 08:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvDTc0BZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gzdhawxp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A89910FF9C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:29:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KOqj1103157
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Lfj6oSCKPER8z+P3DkIH58XgLvSuXtrBMTqgQC09sw=; b=hvDTc0BZhw3sQkyr
 kLrYI23ohlUDBErsLIm4Af6CvSE/HSU6Ze/XKZtwOFHdtozaz07r4vOQEGgSpLSM
 fM3UxiWrzFOzhvtFi4USRX4T5juE3F5TUm1lLWcW7+mTVOGEryu8DTbB0rPycUox
 fBvVu6pw3x2ngMbQVyTINZAgAB8LXoiyObkKrR60JchD4F5+uhN2EjIPaRKB7r45
 99qRoPVpNWMxxg/A2r9x8XBMU8lnna90ekEihJHWRNg8OzO6ypfoIqOqeP2AGqQh
 MuUgB62Mck2892KtG0Xk9W6Qr+828c6clEvBBimRvJ8AUyCl2Fxau0ksjPoaqDBn
 szWIww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kktsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:29:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so1204602985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534562; x=1792139362;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Lfj6oSCKPER8z+P3DkIH58XgLvSuXtrBMTqgQC09sw=;
 b=GzdhawxpUhE96iMp3s6yqygLUtzEcXkJdpSPY5FeP+ARLENQzBmkToemsj9hFoOYk6
 Htiewrl1CxZtbLZZMJLrgmZg4NTar1h5fHgj5/DIQo7l9kQYc1a+lGv8US4P7ySs1421
 mmmcoipimgphKMlxPpTUdhj1tvC9m9pEvOhsxTwm4lLUP0JNGvuf8tmh2gMBK+F26EMl
 srOULv4ttLywXfLmW3xI5JOtufSSfUdrYgea8FH9hmmjmbAwG8VbGbPypGnJ6UqlD2Wc
 IsLT4BT2UXkBdkhXm5KGP/duJr8awSRM2jwPvGOPURypothauzvhsh+Cy+RsuuzC5jPf
 78Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534562; x=1792139362;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Lfj6oSCKPER8z+P3DkIH58XgLvSuXtrBMTqgQC09sw=;
 b=nEFChwilMHhL7FHAugyr4UWMb8XNwHr40uYwtx8/WZX3249CMYujLN9EkxF5PPhMTs
 qZRYVl11MHVip7Mteqd03l8kicK7V9A+tYInnqfwXaHOGJ4yRfl+E1NAZ+enTx4h/qhn
 KhZbIzkg2QFdO3r3l6xSxSxnWH6oioGVZgseGiwgtXZ3Q2g3K/DYpjC73rAxsWCsGRdT
 oUQFmZUUGODKjediO2DYpRu0I+rCG1jX2Y8mAjfZiOOQ+y3dUVo6rlr0K1bBvqsS9jx4
 QY4DWqJR7Rv31oDbWYgrSJlv+Z9Sl0VCB/iW4Y63MAXj0jozlhjGLfx+Xzf8X2rez2u1
 uWmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy38c81pBL5O8KdHaKySGizqVj7afIYcsfE1gH03iyS3gCLquQA/Qa/pRnJiTFPUfsQbEG1q9l+HvY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++naD1WvVn/AdeZBKH4xvGsn+thYVD21zpAReMBArbfqRhBZ0ms8
 slGfoBMpnDhZeFYSmNRT4mYhsxtZZs8Zuoa5Cdgh2c71Dj8oZZu7MkZBwpn8mvR26WuVOsuYGut
 ztANug5WwgakASONdeoBYIv9qHMgYRiveqptz31jlJdKcan/pKA8/p1yJZNC1zaxkc17hq4Q=
X-Gm-Gg: AYBFou0krwbqSQ7rA9NPZRO4ActcpdjJlIsmzvfZ4qDHOURxp7VXtedJIgksDYtGG2l
 OVfyMgW+ZjoHwyHjfmlja6UdG7U4App6CfWlY4qfy8bX5PpIPpEvCz9/kNgn5TtnuVT6ChnHT2T
 aGpl+7i/rCnB8hc/MqcQUtOrssidkNlQSuYK+Lw1Ihql5C3mg1GW2Mx/q5b5CpFdGNFmdpjzgHX
 +iiXIqiyDkNJ0NAFoONx2tgCPma+z5GzD9OCx/LUPH/ZfWf6vuhzYr3l+0nt2LjMnTYrTkIoW+Q
 piSg5XMUevu7i1kVhc2r21TpqjQk8Au2PJWZPkSxl10OlETUY9im5WPjkvgJuiJEWkRV/dbDUPk
 bHePdmEFfR6V7lqfh38C7VBZm2xjxXkIL/1s4XGFMxpNCLaoiWYfFqGNWia0DtNmW4c9Sp0V+VM
 yvnfZ+7/iyYYfC
X-Received: by 2002:a05:620a:8088:b0:93e:c12c:f11a with SMTP id
 af79cd13be357-93ec12d0581mr47268585a.70.1791534561638; 
 Fri, 09 Oct 2026 01:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:8088:b0:93e:c12c:f11a with SMTP id
 af79cd13be357-93ec12d0581mr47264385a.70.1791534561145; 
 Fri, 09 Oct 2026 01:29:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3caab0asm4295171fa.18.2026.10.09.01.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:29:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
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
 Linus Walleij <linusw@kernel.org>, Xilin Wu <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
In-Reply-To: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
Subject: Re: (subset) [PATCH v2 0/4] arm64: dts: qcom: Add support for
 Radxa Dragon Q8B
Message-Id: <179153455955.2970577.14103639336377928226.b4-ty@b4>
Date: Fri, 09 Oct 2026 11:29:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: fabvimgysSgB9u-Uqpth0LIZM6yuPz2g
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac8a5e2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=qk-nXHHSopyJew9tVzIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXxK8rmLlePsav
 HDw2Dbgl7XHV1MlLwmvshMmoC1eaqo5wQbDAOtWOxmHYmAjILkp0ftosLDapHbFW+ZTiRaXWcOk
 VX2ncWfluGrkXQAMkBp957ywWrnw+94=
X-Proofpoint-GUID: fabvimgysSgB9u-Uqpth0LIZM6yuPz2g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXyNJ7W3kEdWSx
 0aczoC4OLO2NyaQKvk/ltO9JXfbxJjSaSnl46jQxeS+qqnfQlqGAmjPvd7PobfnB3LrjfiAv7mK
 hqGdd73JOQ7FLXno+JilNbb0VSUpCWzo9whMwl716ZHl8lP0/sowTbg8jSig5lgXv9QWS1SPKVB
 6/IChXJ6UQQ9RtzQZCyFDtzFsVLjvkSWslndBpy5USBDsvyUDT6DhH5e+nQJGDyjfr2aovfE20S
 7VdC7G5wNGblcPVgwSB6EUL2GXXkCb/o4LrY0feaNPtX/qt567TL0l7+xIX3WZy3TJpBtFUfF26
 0iF8G+kkMV3y+CYmdRr6dhnhkCthkQsyMJDySCdCC3X5aMLTg/w3uSlkqx3KAV5VY4FRZJQ9B77
 /uDB+ICFmXDzLIG9TMmCHkRadjf5iV82HwBSF3sVIkpX7VoivJ93EHwfRkPMr3a9RvTgS4HzsJN
 wHjm6qgmXFtpXaTMsqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090032
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

On Fri, 09 Oct 2026 15:55:05 +0800, Xilin Wu wrote:
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.
> 
> The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
> E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
> alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
> a 40-pin expansion header.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/4] dt-bindings: display: bridge: simple: document Chrontel CH7218A
      commit: 377682cf917027396211426c509cae5785305ba8
[2/4] drm/bridge: simple: add Chrontel CH7218A
      commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8

Best regards,
-- 
With best wishes
Dmitry


