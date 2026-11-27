Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB675606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KhhLuoXP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsE7ENsm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2762F112952;
	Fri, 27 Nov 2026 20:33:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FE9112952
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:33:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBCrG3982579
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kary4tpVak749MIykKPuUJuApttRdkpkDxBb1+9hRJY=; b=KhhLuoXPtYKJmZ1m
 ZEF2K3cefasJIk4hiewimvXxiG0by+EZ7jIxX04DKx6DzyHuvzG1doxhJJmSOf2q
 Hu+4C5gT+1hfAMIllKkZ9bUh6Xn6ptec5k0SPMBDpD8wR8VRi36Zft3xC55BiQ18
 bHIUm5U4qKAxkYIJWVwPSyyamhQF5CxJhyJTTNq5E+hn5BqxBkud0rXpksLsFV6J
 nDv4bg44cpTQv3gu/PwN0Nx24hXHgkWBdssu6Wv+Vpuug2+PHoNtAmmA/zicYbdp
 IdufUzDYLgwuexZs5NeG268OCAap3Gq8+s3yCgnc3ClS39z/T9+bGRYqoE9vIydw
 NE0ORg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d892j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:33:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso1408888485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811580; x=1796416380;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Kary4tpVak749MIykKPuUJuApttRdkpkDxBb1+9hRJY=;
 b=PsE7ENsmNuuZFEPa7A/ApQss84h9EHTHNHA49KXtbD3E4Zxs96btRzJAd7gqvL/JKX
 uPCBzPk05My0wliHG1jbgovAXwmkKaX0zMrFfusp5IE/MXWGZM1FQc3pzGCE2+1REu8E
 vQl+ktH/JTYATVSx9RobszA47ngdu5NVjfhZetLCqB5NBWqMMAgjxbt/0uuvG/mY1qKz
 iQyOGKJVYNPpWEbx+/GFT1/3o5DErb9gC2EAkW2YsxZZCK6kALoiZpa8Hwp3QtUIBbnb
 nrrUC2Kcy6NdO8ubQLdW93UVdn6f57jvHeaeVb0vHq7zvm2TEnR+Mikn5OQCbqIE8pvr
 84zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811580; x=1796416380;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kary4tpVak749MIykKPuUJuApttRdkpkDxBb1+9hRJY=;
 b=l3nHRvO5NkO2XrZgjMcGVR3hIXFt/TuOStPfXsHjO2d8M/siIQoFQ5vIRa6x6PUuTZ
 azq/bt6l4D/BMWR+ZjxW4+ASU1n/kQ3EYc5f1K/geB/wgb7CQYZxEdkMwRMBjiKDaScS
 M9HEwlNuUTOjdNV61uhTwHfV47jtNDWrf2WuVfNBwK+bX/+HBGgdnGY/f2szRRnj6+mT
 bl3Ny+BzJ/ILBF87TuekkN0EpGp8NMt2LQXDLWhUmGx8hBsRqIh3lUPlUhsXSDnX+73V
 FmDQ3CZjKYa3A5er8i9pd93ieNwJmnab7uf3dgPTBu51mgIHHEe+/CzG4FE/NRNifKnq
 gfqg==
X-Forwarded-Encrypted: i=1;
 AL+hErFDwBWrFFmjSuZVjrr3qBIpD98z9JGXvJVqa98HkduCvR31R3EJ77CLqQwYtZpPMjdtmCw5OUN8Arg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/lHSv3F+9hzCL8tgYLpSgQOkXgnNrTwrC2kkxGw2ogIe5AdVXH
 mM4jQtrohg5wOIvaxIMKn97nQefORj/3e/+BWqJFJlCiKrxXh4CMe8ha+ISCKVcKUYa3x0VVZBz
 ym+n2LCDosrx0QGrR7cKlKAcc7VyIYXBvES7T3V72lKMa6YQ2qW1tM+AQf0kumAOrDKoQQlY=
X-Gm-Gg: AZFdTZfdNm4jYdAdt1hUeeytEz/DoVwv3l7dtDrIQ3FFoi8VYrvOy6dd6/sdoan2wez
 SjGdkiefvaCYMJ5DAd1d5a0r+oGEwloEfS8CJC05P3o9ZgQOifbYJeZCBsk4Lz63Yt9nfbmHE1C
 kcWIXabrypSpha6QxpoTjupsfOYg8JsQ+QJKBh6jgQSN5HtalVA4wcbIwluASXrS8LiiyfgwqIo
 DuybHK3/lKzHxwHaEjeI8ZWOzVmMenWPJ2r+bPbzsOx2K5+GKNYUqyfe+yqD642/jvqwbE07EJ1
 henSj5Dbw7aTded6cgU1KKihMsoGPzpPsyp1dvO1gWxKJ6JFMFyGg/isMPunyg1qmQe8MKZWlWe
 JkK2BqQBg7H15/R+adMaFNg+HUeO338w3YXqmL0VYH6J4zST3gWG2uoFW6KIDvg==
X-Received: by 2002:a05:620a:2a12:b0:949:7497:7c1c with SMTP id
 af79cd13be357-949bab5ae05mr4368926685a.60.1795811580030; 
 Fri, 27 Nov 2026 12:33:00 -0800 (PST)
X-Received: by 2002:a05:620a:2a12:b0:949:7497:7c1c with SMTP id
 af79cd13be357-949bab5ae05mr4368922885a.60.1795811579603; 
 Fri, 27 Nov 2026 12:32:59 -0800 (PST)
Received: from localhost ([2a00:23c4:e5c9:901:c496:8838:86d0:bc8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm803588425e9.10.2026.11.27.12.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon
 Q8B
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
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
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
In-Reply-To: <20261029-q8b-dts-v4-3-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-3-e8e7438f5545@radxa.com>
Date: Fri, 27 Nov 2026 20:32:48 +0000
Message-Id: <179581156894.3905807.15541615145912093878.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zw8CBJxBhIDNvajIi9kB0Fx30RehupBLh/bFg9twIcU=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBrCej4YHFMtAdwvfmFzZlObFpeRfGBDqrwzv0L1
 r1cfaxxLjeJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCawno+AAKCRBjTcTwaHBG
 +M0lD/9qyuAyJ9EWCklJW1SzcbV6KdpPMvLNQV6VWhRz8pQqvJZkA56ESN+sJywGWvf9De2xapz
 XDaLgv+mb383qfjVNpjEO8s27y0qQTJHfpzRSOE6eevld/3T0ho6fVY5H4dROzjzyDIdzRlbIqH
 8VkiISoP4UBDolSBwaqKYc4MNqj54IFVJKOz+UjBhumcPnViG2RJEHomj4nOZEx5LmvNILQU92h
 8i2HS9zCD4TLJMn/byvc8dv52DaR4197Gx43JBNtFGgNKFieAobvppaVnIZHU/e8cngYqBpmHla
 RMVQcofGoBecsyej9HTWidcqxfed/ZAm7N72jBYdGtPqSEcNyCXiRTFQuOYwxjPsI2fh8f2PDvx
 krfmeh1MU9wnjUzVwXuXZe2V3DAw1wm9zNr6u7b+wDvnWsUrVIhzk5ODGINcKCWiQP4uGj0qgi6
 opLFv+m4qU4eriWal5igLueVGwvqp/+Md7aSeOGVE9abeu2WB33gpwx/Qo5B9z5hOMPKp9COLd5
 1nC1ECz2tN2BMn/3WnmcVD/kBjM9GTShO86L6Az9CAkQsuVHknyBdbxmacm484Uoo4C5jY/wFxH
 aig7nEXFAPw1Hh3GJ1zN7exRukhfEv5MWybN46cZvNw4zyKU6uG5lwg84r3DFPeOs4fYHxgypLl
 nk5o4j6DoRlktmQ==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Proofpoint-ORIG-GUID: 2czTlS4ygmhs2G0AiTREwGmBy1LwhjGc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX6qOP9FbS55he
 EtHYa/Daa6Y6OO5hCtGbDMyBfMN7Jjx9ZDe0cJUvk+e03GbowcpHZKvVJ4oAkkZgwrjwbo/IFQq
 fBPlxlYP9dVtJeXA+zkdY8mxS5TLLgk=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09e8fd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ksxQWNrZAAAA:8
 a=uG0LtI-mtgFhubywtQIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: 2czTlS4ygmhs2G0AiTREwGmBy1LwhjGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX/Ja2pu/N2+K9
 5aidbN5W2q5xh566vzzU3wieOtltGOskCjjsA/aadr/exOBfqQFwLsAfD5TmzIn0r42kSki/mP8
 pxuLyPXF0pjzVlRz4iiq1dpGlqAuZxzhLo4fWxdfE0gvCxdlH0EjzXY35a5Xfeyzuj4qnsUMk1b
 sRAXTOGBAaHdTDLo9p8HFXZiqAql97ET0MtdX52wyLYMTYjsfhD0iMOqX1R0oxkABLEV0m387b4
 eNvG7vTtBcMT2feci0rKc7WsERxbwoyrC8zExdR6g0eLhdpTEtQH+DEXikF4uTcUiGnovjhPF4V
 mFCiftmak13aePWHD99v8MPK6HcM3YQbNbE3rSEaw4oKFx6Nr13h5E153F04vzBfVSO5cpuIOk2
 tHx67s+2kN/1Otc8OFPOsfaRXJvc5xZN0u2kYs6Egzpg/mgHNy4DY0SQab+tPxn3XQtQq4HHGE0
 cY1ANwrqA+KZNEt55vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add initial device tree support for the Radxa Dragon Q8B,
> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
> SC8280XP platform.
> 
> Describe the following hardware:
> 
> - UFS and microSD storage
> - Two M.2 M-key PCIe connectors
> - An M.2 E-key connector for Wi-Fi and Bluetooth
> - The TC9563 (QPS615) PCIe switch and its downstream topology
> - Two USB-C ports with DisplayPort alternate mode
> - USB Type-A ports
> - HDMI 2.1 output through the Chrontel CH7218A bridge
> - WCD9385 headset audio
> - GPU, video, ADSP and CDSP remote processors
> - RTC, EEPROM, thermal sensors and the 40-pin expansion header
> 
> Co-developed-by: Stephen Chen <stephen@radxa.com>
> Signed-off-by: Stephen Chen <stephen@radxa.com>
> Co-developed-by: Junhao Xie <bigfoot@radxa.com>
> Signed-off-by: Junhao Xie <bigfoot@radxa.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 88230c4e00ea9..cab70c36e420b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -335,6 +335,8 @@ sc8280xp-microsoft-arcata-el2-dtbs	:= sc8280xp-microsoft-arcata.dtb sc8280xp-el2
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-microsoft-arcata.dtb sc8280xp-microsoft-arcata-el2.dtb
>  sc8280xp-microsoft-blackrock-el2-dtbs	:= sc8280xp-microsoft-blackrock.dtb sc8280xp-el2.dtbo
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-microsoft-blackrock.dtb sc8280xp-microsoft-blackrock-el2.dtb
> +sc8280xp-radxa-dragon-q8b-el2-dtbs	:= sc8280xp-radxa-dragon-q8b.dtb sc8280xp-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-radxa-dragon-q8b.dtb sc8280xp-radxa-dragon-q8b-el2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-lenovo-tbx605f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..e0fae337ab667
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> @@ -0,0 +1,2053 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sc8280xp.dtsi"
> +#include "sc8280xp-pmics.dtsi"
> +
> +/delete-node/ &pil_video_mem;
> +/delete-node/ &pil_nsp1_mem;
> +/delete-node/ &remoteproc_nsp1;
> +
> +/ {
> +	model = "Radxa Dragon Q8B";
> +	compatible = "radxa,dragon-q8b", "qcom,sc8280xp";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &uart17;
> +		serial1 = &uart2;
> +	};

It would be good to include stdout-path so that userspace knows the
default serial console.

-- 
Christopher Obbard

