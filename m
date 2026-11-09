Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B9606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RomvDkRx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dn6MRBsm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38DC10F266;
	Mon,  9 Nov 2026 12:46:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC76E10F266
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:46:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99ushq550769
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 12:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=y2DrjEQhS2plkSy9Rd6l6RNy
 JAVrhDy3SRTeWurwWbA=; b=RomvDkRx5seqh3RBtVKxeSElUiTNUWGZRFrSS3EK
 YoOV3nhMHX6VByKAcP3tIYHQanrVkWHqOd6VvTuZIC9ypoApv5IuoZaYDOrOiM5a
 MVcF4O8d26Jx5um7DR5RzHKpdkbZzm8vSB/ocSUajzALuUxmKTtTTxbivPKwFBb/
 R/W5R1YAOMNNbENJuWBmNCums9L4H3IwLTJr7f2VMfWaUv4rHMCIQhTWcbLKgYhS
 FOQ6GJDPv7ZWj7Kv+Cb9JA5hbo6wdwS5aehNeQE2VBg7SVqDDFtoi+Lm23/ojvgG
 Kz+rzV6gMGdDr35CaFXafAPShlWb/I+0oGT9uLoUmVsh5Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm35j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:46:33 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2f2df81bbso382905137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794228393; x=1794833193;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2DrjEQhS2plkSy9Rd6l6RNyJAVrhDy3SRTeWurwWbA=;
 b=Dn6MRBsmFq55L7O9M0pdJ1El20iTx36MbEQ8lX2NM4Bbwya6cPRRFfyN+0ZleqiVJV
 MAzbKBGFet3CBdiKL+efyJK8T9+/bnWT5dNqnggseW8KIXTwUO6I2tB+zEjzA5n/rqZf
 J1W8Gc7aTeZwDAvP0HK3QuNzrDZOVhJEeJ2MvNwUL2DW0fBt45xgYqASIUnep5mwaaUh
 vC6VsTnk52IR9U0nPB14hcofK8oZOG3xmi3Rm85naH3XXI83P1m5e28nxAjX27CqO7BO
 +4AMS/pza8oXU2VUpXrkFBx6MGplK9wyy+lOI9lmJ54uIIEG129Gqbyt7yNmiX8G6CfS
 xKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228393; x=1794833193;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2DrjEQhS2plkSy9Rd6l6RNyJAVrhDy3SRTeWurwWbA=;
 b=KgtjtsXGZjSoqrmvTH1/AGfjLHTCPPSHeqFf28/JeZc6J0Z9K/UtPJkhZxPFc0muyT
 oW6t4wQlrWpREbZ/8xMGMEHo/n5lm0PFyNmv4uAh9GSIUgzbUDIBqBTGrCX745lNJydD
 nkr8QLrBU4otufsFbODaHsLT6reySbrlussMjGZPGE3EvbmFJO3RWjryX5DbpDQgV7PB
 BKq19imD19ORwyDGr7NIoxkyP7ZEf5EMxfHd3NQqOcjrLKIFphukJfbdGDoRu1jJ0UBA
 5WazBbG37nMHxaWZJyTF1QucdD0QRP2y7hQ4MXQjvOd9FbavmqtmAZR5748DCYUWkG62
 BeSA==
X-Forwarded-Encrypted: i=1;
 AL+hErELz7VNAtQ66NA0KlO1yCb/CYGd3J5lgu3KhWY9PrEZRdmWIYpduL4Gv2sBO4iQKPz3qncUMC52iOM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/lZAG31F7E8Yn3071fXkxOmv1asjwgcd9vstSvojTi6ZlSvvEx
 KBPgL45wQeebeQ5CP59BHpoIl/3jZ20t5hiusqDKQbHP1m9O6QPJpsHGXf2taLD+++vBx71ikrt
 BypQkCu4a2hKmX87ubOkrLeG8/2PeBvjZBqC1s6pxKszfoBDAx6xw7QvVtzlKVYyOlO1jIWs=
X-Gm-Gg: AYBFou3JgDT07RZ3U4K8EL7tWZd9Y0nOPXOrwX66NFXgrI/kiazPyE3ez5XKuZfUJ/I
 AIVmFgelxg9N85QD5//DIjL0gENDVERSaDjx4rb4UaIrb3fR6kMbZ6CymX2DFdi0IwyD3f4tKpc
 XV6WtISdY3iwJPCTWBUPljgInsLZ+Kc4tQj/b5l6LmOfRGZ/XxTmrP2P6iAyCbkh59c8eoZcIkv
 nYUEPIBNydwhHUvC8KugHzDKUfX6fUA1vJ0TgBNrArFg/Jjy3D4hVEvr4AWySLaYgjlBDFWEJUP
 SN6KSiHQvTWiMEcAFy2tJnPkwyKXx8kuObM8HLCx5MovdmqaEecbwdO0dOzDlR5wuZS/v5HYnlr
 hc/BeqawfEusVydJxVbt3lDkAYiljILLMCpCstF04XDEX4dZHH8L4DrVTPfxh2aI=
X-Received: by 2002:a05:6102:83d9:b0:7d2:8dd0:2ed with SMTP id
 ada2fe7eead31-7d2daf1bf52mr1009726137.10.1794228392938; 
 Mon, 09 Nov 2026 04:46:32 -0800 (PST)
X-Received: by 2002:a05:6102:83d9:b0:7d2:8dd0:2ed with SMTP id
 ada2fe7eead31-7d2daf1bf52mr1009708137.10.1794228392284; 
 Mon, 09 Nov 2026 04:46:32 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597e0097dsm9855429f8f.57.2026.11.09.04.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:46:31 -0800 (PST)
Date: Mon, 9 Nov 2026 14:46:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] arm64: dts: qcom: sdm845-samsung-starqltechn:
 Update panel compatible
Message-ID: <lr67aes7lfunacwf64sorfvuqgqshsmsg72kwebwq7ol5rt7q3@b6vmojxbaobs>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-8-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-crosshatch-panel-v3-8-87dd4ec4f7cc@ixit.cz>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX/33IaJEgugiP
 P3i1jm9avVV+3XBJYMZFxtqgKbkGb5jHuEepApUDsH+1mL5jv4cEOXOO1fZXwO9OgQfSzN0+yLf
 zx/i/td1ZVwlvYQgi6WJtEzvGJY/+8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX1dYdHB7TE2wb
 oMD77L6Rlg2ltPHt/i4z44x2we/LmrpjzUk9QtOe5wxWdg875xjdhXI8yZ4EAH4XvUTk1qXuilk
 lWcc8nseDge4NSaPYZNkUilmEReLVjA4fZR5wDVib5KWi+JXsBwiSzSJ6frjZleICnmnipXmvuW
 KLeFOiHhC6vc+Xg2nwx00sEn32vuhR6pFmWXM/HMhoxV6Lf/h31bhdThVP2i0NjpnH6fUVN9hF6
 WP0/9izBuKzDHOz+xalm2fuMexKRREKTlI+f0+fJcS0utK7A3O8W6fn3gJ3+xLmdVIPmzX9xaDo
 iBjdtE553UR0eliDV7JlwisXt7HyovArQobe2YBEtbpgUiJlqUY14DWK3KXajD+Vmbprs9rBe/d
 yQxpikBFEceVLKGZxmLHDCqoHH5eUqcPO+MlUYdZBj2zK+DSTRF/vWF4yAPGULvL6V0i+wrvnCR
 +w7QKZBPfBYH+Ib5q5Q==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1c0a9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aFgLPouUvLL-lAFSJXcA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: PizqTRx_PJQkOJ86cGcYL9DJ7GLix6JK
X-Proofpoint-ORIG-GUID: PizqTRx_PJQkOJ86cGcYL9DJ7GLix6JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090050
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-08 12:32:29, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Original compatible describing only the DDIC used, but omit describing
> the panel used (Samsung AMB577PX01), which we have no way to detect.
> 
> New compatible allows without breaking ABI fixing the inverted reset.
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
