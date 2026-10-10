Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A932FCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8295810E4F9;
	Mon, 12 Oct 2026 07:32:08 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023112.outbound.protection.outlook.com
 [40.107.44.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B0B10E0D3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyJ5HqNoODl9B7HgmBUMCuBdsXY1NRKFnbDA7m+GTJmlXmTMxj8Lri3uoMhkGyTJPx3mg1NdTMTaWh+hF1Msu2j9Fi4hNqlzT09jFnGmCjx2c7HgcTADMe/Tk1CJIZ+yq8LryLoSubnqFJyf7YC5CPdvmntS5zsInUp4Aq10yHJAi2dFhoRgjXfBVvpkRV8m/MNiuRkoFXJOB6gkI+5cS62ZHT5e9q8CN68R2hnlFKeWpgzkD7/uCBtAYV3Q2mneQQyI/tZM5wV+DGN/I+FSGou6mPuBRHindSBAGbSVx2y8hWhGMztXgXRz3ayQENACEj9bO6iFXeC6P2pvH09elA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4DOenSHZXLOEY44pTD3DkipbCFtO9ZoOq+R0x9TSxY=;
 b=YxTpRytQxu8AeH8FSvEvlQkAE7uoTHDpvlt9GFcU31r87XPhyfwQpaL4Wa5mTwlP6XzLdLclvTX8VYBL4UHesdqCLiFvSN7xS2/zhBRf7MycZ20hOyv1iIMkm6hinsJie8UZODOIkI9e38tudNc9kakA1WMfUU3L1nuSOqPh1Ti9FG2F+Kqz+oio8DAPt0e0gNqnJKuXabGrZowxwP3N5pRo1+6OHffia7Rz7uQTQbZ6PHpYQpJz15A/gCJs7rdlVwEzEkZ/kGkjVTFooEwNQDudD8lVG8yzEBIzFmC9ihvYjU5apf9i/QZFwVJwhUUqVQUMIpylRWfj4g5bG2maWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4DOenSHZXLOEY44pTD3DkipbCFtO9ZoOq+R0x9TSxY=;
 b=e6CkoebYBzsQWjItLR+07gacrsI16mD41Womr11mcesQxX8Q5m2l9iGBGpLgaHi/w50ztysjv5kkKP/bC1WAFnIaANTccc6viPKhq8BqpPfR4X0iOSQumCar79xm5YdFZ+v1rtmtQgTeHO/mfnQLkF2GBz4hr2LfIB+WmIfW2ydaaGI9FjVvDEZuUQ34hJs/66choekMG1FJN4fd0BHpj5zlWP2uDHj5Ykwe+5x4wK0DdJgjXFBDZ1uL2dIUFG++GSzR5viWF/dh/mEbH7vbX7EF/1wVfYvgRa6bOBOEeKxudeLI/iI6mHkN33X60p9gHIQrHFSw+oW8gAO5eEX0wg==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYZPR01MB4380.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 23:29:00 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 23:29:00 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "heiko@sntech.de" <heiko@sntech.de>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>
CC: "airlied@gmail.com" <airlied@gmail.com>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "jesszhan0024@gmail.com"
 <jesszhan0024@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "noralf@tronnes.org" <noralf@tronnes.org>,
 "robh@kernel.org" <robh@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable display on UNIHIKER M10 V1.2
Thread-Topic: [PATCH 2/2] arm64: dts: rockchip: Enable display on UNIHIKER M10
 V1.2
Thread-Index: AQHdWQ8hFJRhwWXzdE2tquFEKUvWcQ==
Date: Sat, 10 Oct 2026 23:29:00 +0000
Message-ID: <20261010232857.26950-3-founder@crepuse.com>
References: <20261010232857.26950-1-founder@crepuse.com>
In-Reply-To: <20261010232857.26950-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TYZPR01MB4380:EE_
x-ms-office365-filtering-correlation-id: c90915bf-cea8-4208-25c6-08df272643a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|261009223027099003|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 7nsbm5xvzJT5GOO5PIlw1ik4b6OxO1D53KkN3wgbRrqJ+F62pLYGATjZFe2HXm6UgnWoFAi7l1MMRfeB1nbhgLGhaBvc+k3MyysVZwcNobBvCIMJEtoaUwm/y88hQAQeypKQLmCpq6ylvj4Yfbyt6qOoQ6NKuVapSRUJZoJ83CB48o/utvKxJ11ZXJ8N+e4ucZ7vJtTLzHOZ/A2HQvuKqYkoQBnZvVV2Vm32WfH+wVLTH0XDASOdlmPnusRHg8qt88a9zm39arkpsVih66ZwWbOUjO2s5Y3STLy29Mv5v0xgIGeNA0ZRIUPVzFUMQ5HaG56bv8FvJpFzT4Jru2HWfNRg8b64n82Y6TETy3lDSuYZ5FiUs0yiXPlnAUwROAfnDecDiqr35qTZPaRLV6bC2XEpmREoP2VEszmppfPSkAb741mrYJxgjS0Rv2UxFp4g7DTMoVch2MgxeAU1rEQ85iUZ/T4dvgFRYv87FdLWdYeN+rUyTL/DtR00Cc73TL3aW3JdHjqvLI2/oTKPHsDPFWPen/7DXS6vlXF2Si9L3kT7Ww62RY2smcNrOtOvEvub8B78IztjhMgOzW46Y7+8WtyEeDnXkCWfJGzGbdsauM0hS6zHi7RRXcEKZb74tU11QFFolcChMcLl0Jh0UNfufGpFOw44ZX9WQjoD8fGxIoG7C036dh8q2aEqIq8gH4BGYaUhGRWx2X7M/KssloVwCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(261009223027099003)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lDNKaSbxlju37eV/MdEAv4vY1IN4Rhbr0m3hE13sz7+JBrUXFCZxrkRrNw?=
 =?iso-8859-1?Q?D27t0KKyMkhSTR8KttkAHWpv5IEosr3B9Hvj+GVO8gp57ijJOOQ8IUtvp/?=
 =?iso-8859-1?Q?1w1HQ8mjIGSL4FVgLh/mhaa70E+NXA8tHV7ItrH8rnwlgBCvUjwOrcjroi?=
 =?iso-8859-1?Q?Khe+w5dFzo/C7w/sVxMa0q/SFLiZG72M5DI1JdtVU0IZDLqdqTOI/xiZ/H?=
 =?iso-8859-1?Q?QEDczOL2jaRFdYb4yAv6SF3NMJz1d3aBq/OgY3Wzep7ABzeZZPr9J8FLNZ?=
 =?iso-8859-1?Q?o92b21iiZATuHAajO/gASNbfgHOj5aqpGzTcEMJIhBdT8ugPE2wDnSoYTB?=
 =?iso-8859-1?Q?NaW8dZeGwJL20Q9rA3tRhpauMvd1ezdrZ/NZYvt2BmyoZBnnMoVf7bnlc8?=
 =?iso-8859-1?Q?MrXKiJwxwcIThyjHL+3aj5oX0KofQTd9dGx9ysgstEZK8EgdBAsczfpRnc?=
 =?iso-8859-1?Q?irciUxuKiL6uq+R7AC6beJcyUXF5J2ITT0CztwtA5kU+TvKwSbQ2GvQ0Jm?=
 =?iso-8859-1?Q?Qh7IvivSx9d7DvAdjliOz2773dV55ZDyh2sXRfBPn4eUiPs1CFQWFUvOKb?=
 =?iso-8859-1?Q?Inf65Yw0XO3awrNSc7vbqbxAMXVdzXOtKn5HXHEm7tg9dNlI1WRuYSoDl4?=
 =?iso-8859-1?Q?Q+UCcho+3kgO/D2Rx2KdhJf/XXPRAp9Gs6C0yqXj0Z0mnsw6cqbjzjXEDC?=
 =?iso-8859-1?Q?HlObTavJynAPBSwlC1+mbNv762Lk7Lr+9876ucUU0Th35QScP8jeCI2AMy?=
 =?iso-8859-1?Q?d0HJJN8JY+v0vw5F//dhZF51WfhGkMdQzIUbG3S9Iui5FHnx9q6JjexhB4?=
 =?iso-8859-1?Q?ZPeTDZKY4YtHvOdOTgcaD9VpcA8dLy4fFB08G6aga7k4T9LU4oqFZgEPnX?=
 =?iso-8859-1?Q?H+0iDj4v0u6lA1f5SyHE51xIXcma4ktFaJwhSYzBfgK1HYiSuAKuJuBBD9?=
 =?iso-8859-1?Q?Y0i9U4iQ6bRpWrdUFJs7l2NAQ1OrzHPmb61iZmiRXxyEF/ZaxUIaQoy7yr?=
 =?iso-8859-1?Q?FNJedVAXzWsSGuvsabh1qn3f+nx8RrhuAVCwJuC9wHmMDjoPoUWJxi9N2h?=
 =?iso-8859-1?Q?v4YHdNVypEBVtP8g+obVJCiCXxZx2KTS7pZvhaTlmMzMuwWS/vPuRLj42R?=
 =?iso-8859-1?Q?o22mF1fpJRwIgmotzdxbjIPOA1uqBB2tzMtHr0D6Ba8TQfQekDlkaPllPV?=
 =?iso-8859-1?Q?tg9Cf/+gbdQBBYM/Gg7w0XIPWQpT1/HyCoy5SMjf2Z9LoystBSSAgPbNxs?=
 =?iso-8859-1?Q?NB8fq8MuYbc38BMD59mM4xeQ+0pS5Mvlzn9hCFPxdhxKpKRaWN77bgXDR8?=
 =?iso-8859-1?Q?oIVHEFZth8vcmRd0YA0+mdd0kcFXNYW1QjMTtjtVcN5K4B9kMC8yRoEI/H?=
 =?iso-8859-1?Q?6r+BzXV79eswXwiisDWrFHY3KD90DTBvclZNIMHzMNlpSlesb0Ze4kd9n0?=
 =?iso-8859-1?Q?uHeC9B80pS01uHzDBmpQiWe6/iMoxQUC+qhrzIZgJS2AjJDCBr5qDirYdk?=
 =?iso-8859-1?Q?VQynbZ6GbJQwJ5oLEADjAUC8uMSpuD2IsVGy3KribuhEYd5bIbCzhaHxnm?=
 =?iso-8859-1?Q?4cT1cIqJM8dq8tRz5eOYD6zRKfY47tWqEvTa65IkAk4FqkHK81/AuFFc3y?=
 =?iso-8859-1?Q?c1SFKGpqLSbUKWiP9HlvohurKL1t3wkwAdM9CEuplNJztSlTyc5fRi3HDi?=
 =?iso-8859-1?Q?mvYzFyvcQ/k7/iBSB/wKJKPbNjJ24k0pcinKRQL/OWvQVOjJjz3nEYFbid?=
 =?iso-8859-1?Q?FiGvIUb8iecGq2QrwpcwfqQK9hTfeMZwYXUS3mzupEIetp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90915bf-cea8-4208-25c6-08df272643a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 23:29:00.6616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1pKG1j8KdfU2x2kfdTRDNPu0uPtkZTytlx1jwwP/WR1oWmCgKrLqPAgzTJ9qC0KRWrdNK7f9EB7v1xxM8DvXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4380
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

Enable the onboard 240x320 SPI display using panel-mipi-dbi. Add its=0A=
D/C and reset GPIOs, display timing, and PWM1 backlight, and enable=0A=
SPI2 with a maximum transfer frequency of 50 MHz.=0A=
=0A=
Assign SPI2 a 100 MHz input clock from DPLL so that the controller's=0A=
even baud-rate divider can provide 50 MHz for pixel transfers.=0A=
=0A=
Describe the 43.2 x 57.6 mm active area as 43 x 58 mm in the integer=0A=
millimetre properties. The panel uses RGB565 pixel data and requires the=0A=
external=0A=
initialization file dfrobot,unihiker-m10-display.bin. No DRM or SPI=0A=
controller driver changes are needed.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 .../dts/rockchip/rk3308-unihiker-m10-v1.2.dts | 53 +++++++++++++++++++=0A=
 1 file changed, 53 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts b/ar=
ch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts=0A=
index 0c03f118378a..4dc01ea73e44 100644=0A=
--- a/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts=0A=
+++ b/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts=0A=
@@ -22,6 +22,14 @@ chosen {=0A=
 		stdout-path =3D "serial0:1500000n8";=0A=
 	};=0A=
 =0A=
+	backlight: backlight {=0A=
+		compatible =3D "pwm-backlight";=0A=
+		pwms =3D <&pwm1 0 10000 0>;=0A=
+		brightness-levels =3D <0 16 32 48 64 80 96 112 128=0A=
+				     144 160 176 192 208 224 240 255>;=0A=
+		default-brightness-level =3D <12>;=0A=
+	};=0A=
+=0A=
 	keys {=0A=
 		compatible =3D "gpio-keys";=0A=
 =0A=
@@ -154,6 +162,13 @@ &pinctrl {=0A=
 	pinctrl-names =3D "default";=0A=
 	pinctrl-0 =3D <&rtc_32k>;=0A=
 =0A=
+	lcd {=0A=
+		lcd_control: lcd-control {=0A=
+			rockchip,pins =3D <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>,=0A=
+				       <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;=0A=
+		};=0A=
+	};=0A=
+=0A=
 	sdmmc {=0A=
 		sd_vcc_en: sd-vcc-en {=0A=
 			rockchip,pins =3D <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;=0A=
@@ -183,6 +198,10 @@ &pwm0 {=0A=
 	status =3D "okay";=0A=
 };=0A=
 =0A=
+&pwm1 {=0A=
+	status =3D "okay";=0A=
+};=0A=
+=0A=
 &sdio {=0A=
 	#address-cells =3D <1>;=0A=
 	#size-cells =3D <0>;=0A=
@@ -216,6 +235,40 @@ &sdmmc {=0A=
 	status =3D "okay";=0A=
 };=0A=
 =0A=
+&spi2 {=0A=
+	assigned-clocks =3D <&cru SCLK_SPI2>;=0A=
+	assigned-clock-parents =3D <&cru PLL_DPLL>;=0A=
+	assigned-clock-rates =3D <100000000>;=0A=
+	status =3D "okay";=0A=
+=0A=
+	display@0 {=0A=
+		compatible =3D "dfrobot,unihiker-m10-display", "panel-mipi-dbi-spi";=0A=
+		reg =3D <0>;=0A=
+		spi-max-frequency =3D <50000000>;=0A=
+		pinctrl-names =3D "default";=0A=
+		pinctrl-0 =3D <&lcd_control>;=0A=
+		dc-gpios =3D <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;=0A=
+		/* The DBI reset helper drives logical low, then high. */=0A=
+		reset-gpios =3D <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;=0A=
+		backlight =3D <&backlight>;=0A=
+		format =3D "r5g6b5";=0A=
+		width-mm =3D <43>;=0A=
+		height-mm =3D <58>;=0A=
+=0A=
+		panel-timing {=0A=
+			clock-frequency =3D <0>;=0A=
+			hactive =3D <240>;=0A=
+			vactive =3D <320>;=0A=
+			hback-porch =3D <0>;=0A=
+			hfront-porch =3D <0>;=0A=
+			hsync-len =3D <0>;=0A=
+			vback-porch =3D <0>;=0A=
+			vfront-porch =3D <0>;=0A=
+			vsync-len =3D <0>;=0A=
+		};=0A=
+	};=0A=
+};=0A=
+=0A=
 &u2phy {=0A=
 	status =3D "okay";=0A=
 };=0A=
-- =0A=
2.56.0=0A=
=0A=
