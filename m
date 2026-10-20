Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C585606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA5410EA01;
	Tue, 20 Oct 2026 09:12:45 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A47810F419
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:12:43 +0000 (UTC)
X-QQ-mid: zesmtpgz6t1792487489t04aa9426
X-QQ-Originating-IP: xblyLXtYUkaN+mcRUZlY6MFFt1npan14bWp9+SQNemM=
Received: from [127.0.0.1] ( [180.159.160.209])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 20 Oct 2026 17:11:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10771054805953698164
EX-QQ-RecipientCnt: 32
Message-ID: <C782C697D7D26A70+05200ff5-c7c6-4425-ad15-67222a2ebacc@radxa.com>
Date: Tue, 20 Oct 2026 17:11:23 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
 <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MQbZ3LMi49qq+N6BKNU+xXew/vYHBzKGoOmdpWN3wRLQLRtvbGR8q36a
 JWqCt2nOWFOyJlgTPNN5loPgvA8/Rh50R/m6gv0w1UiJnqVHnLOfMxCr5yOTqG5YNesD/PU
 5LCijL35v5LYw23E721p9eg/uSUc8M19d8cvcH8DWo9DzHAoM+pH3DgybbUKw3/j/DLTRgE
 gZ7f8y1mlha3AoHEzmf3OJ23R9Imwlm8ISiqC9VxZlsq1u2lG8nIFs7pN5Z83sU2uNTEMUj
 ryY9xVWftrFRn+1+VFx3UUHqOUgHzI1opRjyswOwc6aMwMW67U7XRKDLvJCF8ZDzj+GRx2I
 V5rcvOK2Bs3O5xUMHrHI9l8+d+vpp5LCXey/usohLjjDUXG5A8f61naufgii+Sf5FKWxqKS
 uqzv79yQVOIlSZCSaEUG9oE6CUjshZweCvx2PSGPjHNyo4mBO8ecjv/tm12ww9oMYb0iovw
 5hCZwFiHpyLH/BBC+nncwWpr4VixeJCujYmNcdpA/2pM41V2H8KwyTopB3Vr6z9r3t+fB7y
 wjjuuTlTWrnVqv/AhqR8yO5KNw8SskANLa1wubMMJ8XeAeWRGgdX2a8+H/8nhGwhavwh14E
 iag7Dvi9EmmGwVCCHZBK/mSRaE1UZs+vRHpoSdRPXQ/AQB2FRtBYNjFSjMT9Qt4RqC/Oo54
 AaYpjGEoDq3nL7fcfa2XfRYuzXueGPNn8jpUyIBEQTsC3HCVzcISdQ38MulRK8Md2W2Ibw6
 Cb3wVFcVcKGIPKrn7/Vs5uJ1ufRGtWGR5r5GPJBWzWvlFOae124dLVSlzP3yMNFrgvGqX0G
 nAjVccOTBmUWF0Un/PgrcMIX9ZH6ZxBhrZmeUSw7PMy2gcRoZD8f3A872w37q1z3seglb6S
 nQkYZvetHteCaXWR2KsPTWnC7Tg/uxeI0eF0XkEcnA55hJidM0ZDnRAWRr2Be5ndd02WjRT
 1vQEqa4wnpdOOcXEhe8ALZg1oat3wrfMTYo5MCUUNopOo8bGbL0BqKbMXqG5fAKFQ4fTmh6
 ZNeA+2Ncb1ogsNwVcTdEOqP8AKx7CyS8uKoqzW4v7IBktxOZUBXpdv/Ng/NpgmesV9yr9oT
 7gukB5FWO1aprUBGJvanIIXLpdiqFdPnfbmHG/CcKYH
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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
Reply-To: sophon@radxa.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 4:27 PM, Konrad Dybcio wrote:
> On 10/9/26 9:55 AM, Xilin Wu wrote:
>> Add initial device tree support for the Radxa Dragon Q8B,
>> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
>> SC8280XP platform.
> 
> [...]
> 
>> +	pmic-glink {
>> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
>> +					<&tlmm 49 GPIO_ACTIVE_HIGH>;
> 
> Please align the '<'s
> 

Ack.

> 
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				port@0 {
> 
> Please add a \n before the subnode
> 

Ack.

> [...]
> 
>> +	vcc_5v_s: regulator-vcc-5v-s {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "vcc_5v_s";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +
>> +		gpio = <&tlmm 159 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		startup-delay-us = <250000>;
>> +		off-on-delay-us = <150000>;
>> +
>> +		pinctrl-0 = <&vcc_5v_s_reg_en>;
>> +		pinctrl-names = "default";
>> +
>> +		/* CH7218A needs to be powered on for HPD logic to work */
>> +		regulator-always-on;
> 
> Does the power supply reference at the connector node not handle this?
> 

No, the regulator will be turned off if there's no active display.

> [...]
> 
>> +&gpu_zap_shader {
>> +	/* Reuse firmware from x13s as the SoC is unfused */
>> +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
>> +};
> 
> Other than the signature, the zap firmware is wholly generic.. I wonder
> if we can just add a symlink in l-f to get a generic path..
> 
> WDYT +Dmitry?
> 

I would prefer that indeed.

> [...]
> 
>> +/* M-key Gen3 x4 */
>> +&pcie2a {
>> +	/* Place ECAM and BAR space above 4 GiB to accommodate large BARs. */
>> +	reg = <0x0 0x01c20000 0x0 0x3000>,
>> +	      <0x0 0x3c000000 0x0 0xf1d>,
>> +	      <0x0 0x3c000f20 0x0 0xa8>,
>> +	      <0x0 0x3c001000 0x0 0x1000>,
>> +	      <0x5 0x00000000 0x0 0x10000000>, /* ECAM config */
>> +	      <0x0 0x01c23000 0x0 0x1000>;
>> +
>> +	ranges = /* IO (1 MiB) */
>> +		 <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
>> +		 /* 32-bit non-prefetchable memory (256 MiB) */
>> +		 <0x02000000 0x0 0x40000000 0x5 0x10000000 0x0 0x10000000>,
>> +		 /* 64-bit non-prefetchable memory (3.5 GiB) */
>> +		 <0x03000000 0x5 0x20000000 0x5 0x20000000 0x0 0xe0000000>;
> 
> Please drop this change on the board side, this is SoC-specific.
> Likewise for the other ports.
> 

Ack. Do you think this change can be applied to SoC DTSI?

> [...]
> 
>> +&pmk8280_pon_pwrkey {
>> +	status = "okay";
>> +};
> 
> I am confused why this isn't enabled by deafult but that's of course
> not your fault
> 
> [...]
> 
> 
>> +&sdc2 {
>> +	pinctrl-0 = <&sdc2_default_state>;
>> +	pinctrl-1 = <&sdc2_sleep_state>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	full-pwr-cycle;
> 
> Hm, is that something that comes from the controller itself? Should
> we advertise it on other SoCs too?
> 

It is observed that the boot firmware can leave an inserted SD card in a 
state that makes the first Linux enumeration fall back to 50 MHz 
high-speed mode. This property allows the MMC core to fully cycle the 
controllable card supply after voltage selection so UHS-I voltage 
switching succeeds reliably.

> [...]
> 
>> +
>> +	vmmc-supply = <&vreg_l9c>;
>> +	vqmmc-supply = <&vreg_l6c>;
>> +
>> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&sound {
>> +	compatible = "qcom,sc8280xp-sndcard";
>> +	model = "SC8280XP-Radxa-Dragon-Q8B";
>> +
>> +	audio-routing =
>> +		"IN1_HPHL", "HPHL_OUT",
> 
> Please don't break the line here, start right after the '='
> 

Ack.

> [...]
> 
>> +	usb0_sbu_default: usb0-sbu-state {
>> +		oe-n-pins {
>> +			pins = "gpio101";
>> +			function = "gpio";
>> +			bias-disable;
>> +			drive-strength = <16>;
>> +			output-high;
> 
> Drop the forced output state from both SBU pin states
> 

Ack. Thank you for the review.

> Konrad


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
