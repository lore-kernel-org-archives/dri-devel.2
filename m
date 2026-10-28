Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B5606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L/rLsbvg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H8VkFcD0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E466D10FC33;
	Wed, 28 Oct 2026 12:53:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21E910FBE8
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:53:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBdx7R2105712
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zudB8ehQX5u98J8w7GI+7Vh+q5LvUPBV10Tq4giORk8=; b=L/rLsbvghXlEQj4y
 Ed1psalBUQZlIh7vhy6hXbY2UnJqeW26F8Ly3gvPuIqYn0ZHnPa1f0cSDPTCH5Y5
 UEvMgWP8aZY6aIr8OWKCHgS3uhsubW8Yk7ynCKkSFfmxYJEpIS3HW7Tf2jcjEdtm
 fm4cZClVjB3yomg6zgwLpOmh6IFWWh4l3Zaip3xL1+U0TKVMJUgfRvurzUsuex7/
 Rb9DKRNr/TCfiMwUDH9KLJV6zHMImkg/gZu7Kjv1iWrsXASllN4ZXzXUk2/csR/h
 +EXLZaj6IKJ4/3p5l6/+kLnC849CwcmPWkKmMdpeu44ruF7jd4keBsP7+cfE1Sbz
 M6HNEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk12pukpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:53:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb1091fffso12461785a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793192014; x=1793796814;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zudB8ehQX5u98J8w7GI+7Vh+q5LvUPBV10Tq4giORk8=;
 b=H8VkFcD098jofynfBKf4hFyDh2hoRepGzt7GqOumu5JJ4SnKPYlDhpXSgjK68d8GBV
 OX3JE3TF/gH4sR/BoZf+s7hRcBljAX2IaaqO6cig6ckD0Ew2dnVBC330BkkS73/C04qs
 5B21PuZsvKBtSzWkLZsbBy4WKC/dsO5ry7HkCOoBEzcIrLqbyEoou177Nke78C0xoJ6K
 w9aUJg9SYRYPiChTufUIVPsZx1UZpfHccmAoAizFUeRVe7GLvgEOFSMPXBknhvAiykfO
 HgaHOT+GMhBu+MkNZrlDDyeaHM8fIAuqqY8mhULyMsfLCrG5l31scz0owxdLStb3CPo3
 7NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793192014; x=1793796814;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zudB8ehQX5u98J8w7GI+7Vh+q5LvUPBV10Tq4giORk8=;
 b=jcGsm1SCy/cZfan/RC2wVl4VEz3Q4lB/OGyPnY1e7DG6eQQ1Uf8yT7Dym6RSLOD4Sf
 SCthhjs53da1zX6SeEml9qcT9esjwhwxdltMzMMYTv+IYrhJK7O++HQvptutwf7cB+cH
 9LlPlYsJpgG/gjUi1eDD/AO8/bgwVxiDok+bsranxCdcAm+qcwR4dDH416UoZozLXX48
 UIGoBSh8wPz4fcgjKmBGuv1G3NmvjilRECMlI5C6fzuJw7bSoa8M8INGLX5sIGWhVO+x
 L0HlWChgywOHrUN6bGJm2FJULMu53ybaQqK/sTMzOexg1jyOvTO/xMxW/7kdPJPpHQNx
 LvZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4qKsSuItOesIiUqqaLP9SpRgkoyw/Qrzu3dkvNeku/X/BGRXaNLeuVNrqOtDs32A3LfHFKRZPTWA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxU3787bntp1aCAWoNdVy6VdgW1lcJ8C43c4ZUv8BtF67Ve6lX
 ejS0sM+5LbdmPCQjr82rdgmWmagvMS9TUFw2kJzWms2L+SU6V4zETnqLqbOxl4S2nO9FdIsLhem
 oOld9gsc5HAK5p7xwDFcvUm7QLY5X+rPqmXXCbjDLtV9EfPcy9SQ+7Wo3IU77qSVrtIDORXI=
X-Gm-Gg: AYBFou3ekNuPS49lLGnSihmypwRYa2Spfi7PyMXERhscUecn3TLVaLykFDxqu9ghpPs
 L1THoO38febw4tohwlL1ON6Zvlv/3CBFzIrcv70bNDSvn3B9NeYXJEtzJVGXPeLHqykLskwM2US
 JpgJaCzUurN6lI6ZvX3SF9Ucjk0SMgkwN7nz2ZuQpkjDcRdsPA9E4cw9pDiad3scldM791rLIBw
 3h6tc9uEOEuinrqz0H9ylFTWl+fWRueCFn5QFpNAK9jtiM0xtzjgouxXg9u/9MviL29M37VMi1c
 gU5zifizcuwIkoczj+uIKRR4uyL9PE7uoDhpwxjzNetZsnXSDrIHUkwHzCAoo+YfdJDwR75rXjM
 9zxr1MayZ5nOt3Ns4iXL6y7CrZAMvihPjazleS8uTrQa/ALj0H7xgI5bfU3EvbtSuCrm3uSU=
X-Received: by 2002:a05:620a:a8cc:10b0:93c:61e0:81ff with SMTP id
 af79cd13be357-944089b232dmr292260385a.1.1793192013971; 
 Wed, 28 Oct 2026 05:53:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a8cc:10b0:93c:61e0:81ff with SMTP id
 af79cd13be357-944089b232dmr292255485a.1.1793192013511; 
 Wed, 28 Oct 2026 05:53:33 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm593191366b.68.2026.10.28.05.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 05:53:32 -0700 (PDT)
Message-ID: <e45d9d36-131e-4adf-ae70-321191964d4e@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 13:53:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sm8450-hdk: Add display card overlay
To: Vladimir Zapolskiy <vz@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org
References: <20261028095151.1682096-1-vz@kernel.org>
 <20261028095151.1682096-8-vz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261028095151.1682096-8-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zyQaLeYKnH04xr0Rn2_ejRpJgwMUHxOW
X-Authority-Analysis: v=2.4 cv=DtDDa2/+ c=1 sm=1 tr=0 ts=6ae1f04f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Mi3LwBMVhOuzPUwrl_IA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfX5F+7vk2wId01
 H+xO++7BlKMTk+WUVwpOWGFn7Jj0mg4LRy7PtNSh5oo2O0Zdli3DCwrhNeCKr0vNsWZ/apjvOCk
 Ib6lK0RGfBrI1d+KhBVcOW/50kisZakF+nEg5ih4u/bMWWkPEqSq4asf4IwwMmGBHh8HNXI5INq
 npAL4zO6OG786SR+XuEhQqk25g+sN1tRmtWScrsjqW7rX20iUYSoXB27X0IFFn46vQhjSRnpzb2
 YaqEUXFlQ62r8ckQovhgBt7a9nm86re8fw05t2v5XbL/s0jv2p3Vh6D+WVeWAiUyIsSjl2+EtDb
 B1JNQD4olCx40b4dYWq+tMwVSfgqx+L/XY/LnKotGR2IZNigez/EbiefXLGQnPZ6cHZgkYcMprj
 pAirUHwN9pkUe0PweN8N9MutTj7M3ODnSXwFXPMOwm8zFbo8W5oq2ElZQORn3Y7hIyp/4OpOGb/
 B/6myjbH7yqJq5diOyQ==
X-Proofpoint-GUID: zyQaLeYKnH04xr0Rn2_ejRpJgwMUHxOW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfXyKKwE//CiZM2
 QLclsMK4TEr0bDtnaAti9c68fetgZfzfgje3JzRiQrDz3H5je+emOcg2T5hOe+pWQKTO3kF92IY
 4Y9dASzpiC6Z7sVXh4InbCJYdXlltE4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280051
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 10:51 AM, Vladimir Zapolskiy wrote:
> The SM8450 HDK board can be connected to an external display card, which
> carries a 1080x2400 LCD panel module powered by the Novatek NT36672E
> display driver IC with an integrated touchscreen controller.
> 
> The panel is connected to DSI0 over a 3-trio MIPI C-PHY link, power is

Either "a trio" or "3 lanes", 3 trios would be *a lot* of bandwidth

Otherwise I think this looks good

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
