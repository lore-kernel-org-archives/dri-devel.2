Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B6606A321
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WT/u5oY4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=izFb2Dy/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611B310F394;
	Tue, 20 Oct 2026 08:28:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9C810F394
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K8ChQ1186498
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rvYWJFWcgvZUYKe8TM7FfKWltCT1YcCtXDDqW7fUltc=; b=WT/u5oY4quedgaYW
 sNkGzWJBXrGFl58suco6iOTM/CvDjTLebyfUUMjQd3LPvnBUhFAJU66cgBrgsg2X
 JZZyIFO5K9HmA/krlRozcBrmZn/r6kqRh68dgE7YbYLVsQHHWey4l3RpljtWcll1
 U0Dh55ii337z4yqu93Td6M7ZFJshHFAXtOG6Th5fW7lLD5dNppk9rbsjkcKPfc0+
 GZmSE6hXCG5PM/wYBchkExPQff+fwu4YRWYLX7MAB1Oob4lNGJrwz8sWglNKDR5l
 G81za669iwQOjSBwQkhTvGESG6Uz+qxUIRa7HHe4lrr3t9+1e9jl3gD/CnMauaag
 oT9xdA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nsmdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e58614290so45881185a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792484882; x=1793089682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rvYWJFWcgvZUYKe8TM7FfKWltCT1YcCtXDDqW7fUltc=;
 b=izFb2Dy/tJHQZ6Lbzs/8uRcgRCA2EW8yinO33+utfFb9LG9yXkXdTVyijvqKPhvzpr
 iJ/oulc9k9PhLVJEX4+m5RDs/OsQ6WPjur/8y1ENM7DpcG5fbsiyFN30Pc/imtoiWno+
 36om3Sq3YzAIUvor58fMfE16NsJ6ndGmUhJwtxV0w0hlE7om030V5U8MkC9XyzAHWBID
 7U6A9bJaS5NpzKwfC6OZPs2Wr3urQ7TV4rXpspDv0xHc9i0fHx5N4hImJkghA/nxgJ3U
 qPigdZ4fDRdo7/fuTd2afR6cHe7T4rgsxX3WRv2rpSTrW3n+K31nN+ceFyLj9o5MMzBL
 JauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792484882; x=1793089682;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvYWJFWcgvZUYKe8TM7FfKWltCT1YcCtXDDqW7fUltc=;
 b=dFg0MdievIR8e8d5jLCw59zAp6xC/IpcLSzFjaVKBxL6RkdHc3+GBacA0VgIemFGvH
 Y6UD6XUKBR2rGJ296XGR0O0AhtWx/PGIRKQRu9HZ5NkkDMvo6FD+zGoV2UGpEC4MGZqF
 L9oPqZKlpmEn/4/rZmcHwL592XEmQDrSxtga+Je2c5ggfg83BAT9Eov3tl6ZpVsMarXi
 9UZxtn3dQHAwASGS7KMnibfFeNNZwE2LEUfJlvgmgpcx4JaMPuP+S5IX//xJL3imAJ/0
 FF/n/ER+BrxJ7our79Qs/wiIcv1/maXcJjK8KuqtgauK1e/YKZrrTkvOvQZSG8ONwADj
 6zkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2Sdw3L4zsgkVEh6s/TjIA9IyhWRn6PTdKYOhWEcmRMr1UHZGNAITdNu3s/vYlqyUYbn5lRN2Xqzk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/j0aHFrJ5stB2hPq+xhNP/o/Jkdr7YmezpoXOH/zA09Uw8sPr
 8tXvO770lNYOFqaOiecUGa1X2IZUo0XY2EJkc7rmD5XxN0WdYuNiLl2/c2IR6gTF+pND3WoRtrH
 ek2T30ScBsX4YZqz6pIwQYw7WVkL3FmvUqQQPTHagp0dpYOnuY719ue4YPLF7R1iDHrW/YDg=
X-Gm-Gg: AYBFou1033fV1FpQOlOL8DqYtOC1Wv/gx01OWfWbhrgAiqKZ7qEZUDfyVo7BgJj466O
 EDnrq5uZKKEm2q3LFQQqRbz/VcGKD/+amANj7OYgKW/nDkpcH+AXjbFPTm4nWW4iSduI1Yemqnm
 kr7yrLdqlaMlE7EK6cqb6wULZZ0vqlkiDEyFWc7wxrm2nc2xkq70vfCuEquoVqQaD17CB1slLwV
 2n8UYRdu6jM4zbUiydm4uxhLuZ0EYzO7AJPNEdZaSTV+X2dh7gNAsZfvGyIu3Svp3wDX0aLQBse
 jCvfaV6Xa9fK0FbWID0msH+jXbbmIx64maLSBr4hsWTFKYjV9uao79JC1FwoqWghxx3hQUx0XGk
 kO+SNBYaMlmWlKlrxbkMxLQ==
X-Received: by 2002:a05:620a:c55:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93f29d39ad8mr1871583685a.3.1792484881686; 
 Tue, 20 Oct 2026 01:28:01 -0700 (PDT)
X-Received: by 2002:a05:620a:c55:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93f29d39ad8mr1871579585a.3.1792484881209; 
 Tue, 20 Oct 2026 01:28:01 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb165bsm451124266b.71.2026.10.20.01.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:27:59 -0700 (PDT)
Message-ID: <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:27:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Nu1KAw1pByS3u36oEoqCA3YMiMeGWBcw
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad72612 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=u2Fyij-s7XdpVA4p1MkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Nu1KAw1pByS3u36oEoqCA3YMiMeGWBcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX6pAgIyQ2iL+0
 oVkOcugyJ8Kcnxs0J2oNqAn/t2WTnYr75GmrwXa3KVq3DCjjea0Cq5ZJ/ob09dgCtO1Q5ewqRBv
 KPvNtlB5BwkmsicC9FsDKiEVON+RWm0u9I0uAThcU8P96js+CyhtcZpKSWMoSECk6yEWbl53uSE
 ro8r8W5CMAyATkImCloCnuyCdz+WUdY1JQQz6UsSmhCn8tTkV69jWurmmy4EE/ejqYjFrAC/YPR
 /Le05BES/bu06o7Ruvn0T1Ghbl3eVtxCYeijAnnzaRrMN0+llabZ5LLZFGX14fH2jgLUhM2hwAV
 n1Fs/W35mmL/5NhBEZsguj0bsqNWQzRO4mkWJJmQI82sq8+fFiG3pXjhk0wsVcxlsOD+cwAEsYv
 a959S1eMq/b0rlLFMhHEK6pHhyV8ujHwb6ftL6LM5twadSIanRJCSidmlKC4vwtqOmd4gWI/KJX
 fii4rMjkblkYJI8yhGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX2/GiMV34KZdX
 H2LGmZ2VLujEWTwrc0HfiZm7TGU+rKUu1cyp5mK3F5HHxcnwzhKDvKVnAixuv1WyC9sGk2s0Rzr
 qXyNzUTOKBpfdFNgYiWWpIP0c5w6NaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200033
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/9/26 9:55 AM, Xilin Wu wrote:
> Add initial device tree support for the Radxa Dragon Q8B,
> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
> SC8280XP platform.

[...]

> +	pmic-glink {
> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
> +					<&tlmm 49 GPIO_ACTIVE_HIGH>;

Please align the '<'s


> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {

Please add a \n before the subnode

[...]

> +	vcc_5v_s: regulator-vcc-5v-s {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vcc_5v_s";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&tlmm 159 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <250000>;
> +		off-on-delay-us = <150000>;
> +
> +		pinctrl-0 = <&vcc_5v_s_reg_en>;
> +		pinctrl-names = "default";
> +
> +		/* CH7218A needs to be powered on for HPD logic to work */
> +		regulator-always-on;

Does the power supply reference at the connector node not handle this?

[...]

> +&gpu_zap_shader {
> +	/* Reuse firmware from x13s as the SoC is unfused */
> +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
> +};

Other than the signature, the zap firmware is wholly generic.. I wonder
if we can just add a symlink in l-f to get a generic path..

WDYT +Dmitry?

[...]

> +/* M-key Gen3 x4 */
> +&pcie2a {
> +	/* Place ECAM and BAR space above 4 GiB to accommodate large BARs. */
> +	reg = <0x0 0x01c20000 0x0 0x3000>,
> +	      <0x0 0x3c000000 0x0 0xf1d>,
> +	      <0x0 0x3c000f20 0x0 0xa8>,
> +	      <0x0 0x3c001000 0x0 0x1000>,
> +	      <0x5 0x00000000 0x0 0x10000000>, /* ECAM config */
> +	      <0x0 0x01c23000 0x0 0x1000>;
> +
> +	ranges = /* IO (1 MiB) */
> +		 <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
> +		 /* 32-bit non-prefetchable memory (256 MiB) */
> +		 <0x02000000 0x0 0x40000000 0x5 0x10000000 0x0 0x10000000>,
> +		 /* 64-bit non-prefetchable memory (3.5 GiB) */
> +		 <0x03000000 0x5 0x20000000 0x5 0x20000000 0x0 0xe0000000>;

Please drop this change on the board side, this is SoC-specific.
Likewise for the other ports.

[...]

> +&pmk8280_pon_pwrkey {
> +	status = "okay";
> +};

I am confused why this isn't enabled by deafult but that's of course
not your fault

[...]


> +&sdc2 {
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
> +	pinctrl-names = "default", "sleep";
> +
> +	full-pwr-cycle;

Hm, is that something that comes from the controller itself? Should
we advertise it on other SoCs too?

[...]

> +
> +	vmmc-supply = <&vreg_l9c>;
> +	vqmmc-supply = <&vreg_l6c>;
> +
> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
> +&sound {
> +	compatible = "qcom,sc8280xp-sndcard";
> +	model = "SC8280XP-Radxa-Dragon-Q8B";
> +
> +	audio-routing =
> +		"IN1_HPHL", "HPHL_OUT",

Please don't break the line here, start right after the '='

[...]

> +	usb0_sbu_default: usb0-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio101";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +			output-high;

Drop the forced output state from both SBU pin states

Konrad
