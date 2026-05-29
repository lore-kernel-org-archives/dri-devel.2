Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B524ECD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A926B112716;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n0GY4Nlm";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F88D112194
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:56:19 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so72250005e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780070178; x=1780674978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXtmoRa4P06Ph2LHtyp4xqyCcrT4FMd0i5231H6kh7A=;
 b=n0GY4Nlms33Fc8xJPWJb4HGQVlDXHpkpxUXGTOt566Dx3rKyCf5RKD4AcQ53qZqqnz
 kPfwqixMjIzgy64Ezj0iM0/uuB1ia9SibhJOc0LnSsEHjcxgslK0wvkaC4ZBe3f6j3kh
 tvnbKZaArdZJ+f6hBAonpdHWFF+PIw3XHSq1v3lC+w7QYDTQQXB6lITCFGH5OnC2XxKY
 4dBrtm1GCXwMurUs9jJlsNwhB9o40FoiM7GeiRS1avsYmqxGpMtweFagbj0Q4KqKapiZ
 eLfgC4xwNDaKSp47riRgR0OAOJi1x1R0MMnRpizHnYpJ+09kQtWylco01KS8+YNemBeZ
 nuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070178; x=1780674978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXtmoRa4P06Ph2LHtyp4xqyCcrT4FMd0i5231H6kh7A=;
 b=VrYVMtZYQXJ/raanPTq7yy+ajMAvRdkpA/OGFQXei3GAJ4o6mmpzj1f8Yr/5Zr3OgR
 hqDYbvBU9W6uVqGzlNLYQ6KOdjLPuTmmN+w8Gb/1lEp2N/OtkAEZgq1hQswMJV+aU5zO
 4yOFnD5104Lbt0mu9g5Hn88S6wKnwOrxDVCVqf3ChSDSSa7QkKfD1a0767RwQSdZ0s7w
 V/MsbwNuqXpxPd2ARCgj+hUCZwOHf8JBtGhgVuF2yBz5NBeI/RtjJvA1prZJuTmKN8oY
 2vN/qoEem1LUsKRZxlRLMSYUOhJExSp2ADe+pzBlhxtc67cLoD21pibaUsKVYbXZFSN6
 +T+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/r+rPggxX78RiRDe0nvK0wXjHZAtzScI1D9TTsOJTxGde0JIeGu9BD22H9hvO55gN7F9cGY8WfHm0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycMd71qAQmZGspUVr9ApnPYw92PAYKdZp48sDxHEx775+u51Sm
 guXyABoaiRF4iEQx+ZDP0KT5q9WnW7ueJwiz5T1GtY8ODMs2ckn2zzxG
X-Gm-Gg: Acq92OFDYx1uaVTEyy+OirqQl94gkB50zTI3NfXMyAjc87Auq/1zJDPFzcFWFlJL6dV
 EjKJjMi+hJSYpV0vPPDmRwcx8iNeDwt8s59G67OlJNk7OhfXUGr8tZgypw8ioeaf6K6QLy55ayG
 ag8tHZKrqa38El36g4JRRwn2EBsq5rQ8/IBRFIugnNgVnenlVT+JB+vwy1xvV21RGYgJJZxBnlK
 aGbacFBUtFtiyxOhD4xn3DHyC4wSeiRP5vwvaQ0Dzl1Q5Ht9WMfv+qJKa1lXPOep5S/EMPcsBBI
 UPzXwJcz+9NfSzJByveJYdpKMtytXQ+jfCnGjGzuiycGL8Fk39ZM4Uo3sjihp0vF9Tk3XQlEyu8
 EI8jPk+v524qangEkwadoiAiDokDnSvKn5BKWvdBG2ceuU8A7UzlGBa8Kjf5B6khqW7ii6uG700
 RQBy1lQ9Ddh1oXABU6ym6JyQbV+04V7POG72y77eeJBn1Qz4oKyvhVfanOknn/WOF4scW1FfYCa
 Y0mrhCkwHxRDSEwY2UZF9OCTwvMYAGxhh5p41IB
X-Received: by 2002:a05:600c:1382:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490a29e4449mr1171935e9.11.1780070177866; 
 Fri, 29 May 2026 08:56:17 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 (2a01cb09e0354cc878d00097536575e1.ipv6.abo.wanadoo.fr.
 [2a01:cb09:e035:4cc8:78d0:97:5365:75e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm55150315e9.15.2026.05.29.08.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:56:17 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Midgy BALON <midgy971@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: rk3568-rock-3b: Enable NPU
Date: Fri, 29 May 2026 17:58:24 +0200
Message-Id: <20260529155824.3099831-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260529155824.3099831-1-midgy971@gmail.com>
References: <20260529155824.3099831-1-midgy971@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

From: Midgy BALON <midgy971@gmail.com>

Enable the RKNN core 0 and its IOMMU on the Radxa ROCK 3B by
overriding their status. The Rocket accel driver binds via the
rockchip,rk3568-rknn-core compatible.

The NPU is powered from vdd_npu (regulator already defined for OPP
table). The IOMMU node is also enabled so the rocket driver can manage
its own paging domain for user-mode submissions.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 3d0c1ccfa..d54229123 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -779,3 +779,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.39.5

