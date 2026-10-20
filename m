Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748F606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkG+4lf9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+X5R2UN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D6110F3C1;
	Tue, 20 Oct 2026 08:29:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B03310F3C1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K8HfMv3807111
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=; b=lkG+4lf97J9M1Jcm
 9rFwU/pY9ta+CZlYP8cdyba734bZluqzXOKHaZVvMjFY9cNTZ3g4N4J27pHDTpDJ
 KGp+pK7du9X4blUs5u0KiwWxGdv7n9oiFYG2JUWfieciXhVlJ4wEcOEYQqdMouSp
 0o53zwQVoZlr7Row84twP9dKTQyPZB5+g8fo3XkXfT0nNo8p5JYcOE0QVSXNDOjQ
 Ez7AKlSmZqHxcwIYaw6PFHkN+N4Cnpkb2xpGwuQaBrJ+aZXToBjFPGTMPQF4vRvg
 fb31HTx8bv9LEbhZTWI54XpwEas+L3AEVhEVazZ3XAjf2qpvt2+KJOXToRmyos3q
 rGgzvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p9mww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb1091fffso31030685a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792484931; x=1793089731;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=;
 b=K+X5R2UNRh231G4tPPJEfHnEypmhOaIik/7m51UODU6CgobdtIQNHJiPCQijUUAWyd
 y3LppxfbuSx75/sgFCO7iClJaQm1dPVNCpwpTn1L2CGdet58AmyX7c6DFb9Z+IA/aeac
 CwHdcze2106e8nap9OM3qJIr9ig8y1SP+/YevZE/wvantg65rsVfqMml3p4/Upd3XtJV
 dArM1GlBAGBePafzQiJnBUqiurET+jUyZZEjFmRFuoguV0fwmxohW8iy7Za3uX2cRgfW
 9jpEEe1L24R88wPseZlf/fmME9jlw4O9zpFJajNhMbhFXSnpg4JUNVzt8oZJq8FXgYIy
 UJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792484931; x=1793089731;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=;
 b=ihZ8RgNMcRTCC+JOPql6z/a7UHjSWyBxfZF1l7gCEa0SkcUGeTMgo6It/f/I2udkFz
 T0YOT1SIsxPJ1dlFbXzZ8XwybHck9cUdm8IOgFs/063/TTVy8DXppe2Z7UTYraRiF+ay
 Cl9qiOM8jNCYPBeP36ilF8kT7NDEt6q5u6OQQB7fNeUbmVff5MaGIybTKSXzBpUdzgT6
 MBYY8nfKenCt+47Cx/MqszelSZ2qupEJpINdBCrXG/7j+UPtF7cO6eRxc2taRbm2jtR3
 rzhiiVwo8CM/huxDdVl+qWgw+dSKAsnXhZPAz+79zYt1XzvJ78VUoXn9jUhXbKYlbQx5
 /6Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUYmYo21gcj3o552L3PeCWTr8w/Jfs8rt/kYOkidu7pXVEDsGpzOasIxmfwupZyKgjJkyXP0srxOg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNrtz9kjAC8VKp1jiQ3ZXG1EnN0xWIQhqOvKnAY24s9j0cAYFU
 H8ijhIYlPBjR9DoUVz1GuWImA/EsGNpKmNTk7CPnYQ9maBaDRq1DfZB9jSZnwq32yjkxnqrmmPN
 WIlZZ5PFLn5uW4LmceAeDlIH6SEIema1dSkO7Pp14ZmdiJ2d6+rP2h3lADj8s5GfUVDbqmyg=
X-Gm-Gg: AYBFou0PPHSXgUcYLV9Tw6NLnY9W91LUwGJHV10EtjFENF7O0SvQKiYKSe9OUzCKUOv
 7to52sgiGHOCern30qxikS0r1wh9yhkhKNo058fzh1J1S9Kkyykp0nchBufbLzdAi4lRXuIbslr
 sAg4Lr9Wx/LY5Yb4+kGfGEsVYzTZ2J3a9vyFU+/Lvp54/vGUTRe3YsC1h8wnzjI+zsW4sMULmCF
 tvh4IWchlCy8sDyAVOnYe0Tzl2H4vzF53FiOf8H/Sr6MyJBibXsyWOgBO0Y5ufzFGJLcyoPaASK
 uS5x2YOe3FqdA73N2BvGJZdujbdVbpkr51ml5n/aZJZy0AU9OOL/xvKJgShdauXQxTxifs9lbzd
 pgx8cqx6DhVySVnMbtnI4KQ==
X-Received: by 2002:a05:620a:3190:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93f29d216eemr1869316885a.4.1792484930877; 
 Tue, 20 Oct 2026 01:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93f29d216eemr1869313585a.4.1792484930511; 
 Tue, 20 Oct 2026 01:28:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b0f75sm5026181a12.13.2026.10.20.01.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:28:49 -0700 (PDT)
Message-ID: <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:28:44 +0200
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
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
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
X-Proofpoint-GUID: zxHmZyivDuOVTlKTSDGUbBx6_8-3LAE0
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad72643 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6_vhy4Ov9suG7DV3KvwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfXxY6ut4FJd2eL
 zMQ3LREdmmTuqLzZhru5d/CBd6xtBN4EJovM4LS4xQSnRkB+Vq0nBFwhuVitiZ+snhIqgJmNgkS
 PDJdw7tQvzNtu9Bw7ccuK2ttYjtX+/wckwWS4CpNWfqdMg28EKQsnwpSmGjhEbXVOXQckd8Q9S+
 qQ1aOv9KljciOy6Bnj5SZiMwQVU2HFHph2MDGWg5noq/Fkm2fJ7BeVuNT6c8gcW5FwH13D2zjyV
 TYlPIQzdEfAfU/1rch2vD5HHNgzWB81KLdc4hPs86XWbizIKpRHP6or7t75Algw0NAwSilKUX/z
 MHO+jycS+hWdMNb5wvSyTI0bzlLUQO9GzLRENYYbUKEHjPmuCXwv2bNbpbIFJrgXSSbQlJO5vFO
 llqBBWwhCBOUxEnHfXIYIuSNNqgOlD5VCHLWEwv3GsoIKz5cwLZjq7UJSzb0/MOWX1RXIdTyZDR
 CP7Fewl96TdGUBzlUyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX/k0OOTUqtqMk
 E1LAFM7UtE96zVO0MqaK2EmA9fS1xMj7cMlelpJjPh02iMrP7WlbePJEv6bYrK/ki/DJHFyiy0S
 W/PibXGbEV15HgF55zQWBX7AtCYfe6w=
X-Proofpoint-ORIG-GUID: zxHmZyivDuOVTlKTSDGUbBx6_8-3LAE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
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

> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";

No i2c bus and hpd?

Konrad
