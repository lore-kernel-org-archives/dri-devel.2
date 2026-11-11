Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G/wgCCmm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kqBge7tE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39C310E20C;
	Wed, 11 Nov 2026 18:46:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE74310E416
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:46:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABIgEPQ2811685
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MHpOPQMnBsXdD4rxYXwjWTXKlMKBvycegMK8DhfOcg8=; b=G/wgCCmm3FHTOOQG
 e9/ng4bKh+OeU4l+jXQGRNS+CTxI5qvXs21sgkKyo4LH/y2+69ujEedssfuFYtDZ
 qrJiLmB3C55OzIT800Ia70b5MBla65L1pv8voXplP5uHxWxLkIS8PTRHDRNtdSVW
 Vg8ydmYis9+Xa54r9ps9Kovpp0FKv3RQNion6bMWVAiLzuND2hK/mEJMgJJhKEHT
 gBW7QmvP/kHO6K1XyJJrhfGXFQmT16qM8BXYnE5tIPV8GxHjLjw8aO3sMf6RBOVB
 oyOo4fn8oEQ+X55OhGFGV0YA+0dhh/T11OF5TBfThZ8Y32lpNirMgrB1MS5tktfj
 vgbVHg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0ga0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:46:42 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d2c415bb8fso653899137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794422802; x=1795027602;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MHpOPQMnBsXdD4rxYXwjWTXKlMKBvycegMK8DhfOcg8=;
 b=kqBge7tESTnxQCB++WVKGuDg9dkV1p6oTgI8aHfxKipIX67ROyR2i6KWhFCbgev1Xr
 SE5Thmb9Y9mMqrUGlrid9NJxdrR0ozNyI/tKM2gWN3JCKXEk2WQJ5/vt7XsWy6kjtbwG
 XoonA2Y7kO9sxIVIs2U8/GrHW+2eNEKAYn3ViWV2HihXog9cBvRaURdjr5NhSqqMML/v
 f4ZZcXPWSXPFppu4nCaUJDCRGl55ratrAh7laDfUS+l1HqAuOP7FLk/5o/dsoUV7Ot2Q
 /0gYsLCKMEi3lJaDO9a4MVCoUk0XG2H23mQM9zdF4SoyZHBKxwffFNynPnQObO34tf+2
 afCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794422802; x=1795027602;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MHpOPQMnBsXdD4rxYXwjWTXKlMKBvycegMK8DhfOcg8=;
 b=N9d6f2H/35Cn4MkY9VHlQwMZj5tfOKdCtwYohv71EFb9F2ZmZFZzw8JRjYVt9Zs0VX
 VOD+o3WJw3eZ0cQCxL0Qf0uPsbA1hnnYPzb6pcvuNYrv6rmzQPfAatboZ4ej9dTjhv+2
 kbmhmRl57bJkgAMbXmLrG/3XFyRCpocW9DaR4XCHpE7pl+UYjbwYTHRKUcpRDUEMYwQl
 jPyP77LHDTEudmioJ7M97zNT0QTeqg/g/rOaaIf+ynBg43zLbAewwMN1W/FVBSrYMsgO
 3IVoatiKLbU3gKj1pwHyJ0ebI3330laHL6KLPo00n+osupAgsndvuX9e1JsjaVdK2l1W
 LrLg==
X-Forwarded-Encrypted: i=1;
 AL+hErH4ugVm2IXykPHKnpbqwn0dpO5MuV9m4OOzHi+jXqpJB5QsOcUs6Nj6+Yawu1XUR/bt7LxCkiSMS0k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+HgIxieaVuowa8GrxTmr77gO/W5M/3dR8lMdLRmFoxCMGZ4+/4
 elVKcsloyV/2p3jsV8wGJwXEx43OQoQ3W8TB0moVTsgHH6iTViFoLtvtDDaXecofKpjLupEXJNo
 6T1NcVEdjdpw9g8GdlPNDTIAI+I8JdLCLmMcc+/sgziOSHDxwtFYreQ3oUrISGl6KWZff/pY=
X-Gm-Gg: AYBFou2sImOqAzxFpUE+GB0T1do9HzB5QKMy3rld0V9E6cK1g+fqMslHIES7PVlLTOw
 +dgeMC7gt2QJwBlbnYldFNzuDcQtuqh6clAAvOlGrop0EI+EkRRe8WBE023CV7FElUlr8AKLd59
 cXsa6TeMrriNdosixYvy+RnbRuLp8TjOeccbcTURwBGHdVc0u/gNFORt3kdTin4ANhqlpmjEJgo
 wFq0IbRl6Yf0ydVWnv/DblbyuES7wqqSZWtdC/DdInAUFgF4jbtfRGyDbUjFVqwP6jh8POR9ylQ
 XNfrmWT4c9aVfVfsXm3Z7JJ6k4LfJ11xYQfG0GOWwF2YKvZliJEuYhwnwSzLWxUamUIyW7uRik7
 xtbgxIDDKoAXNFqve3V+2EBTsSxvqIh7+wZ8OwOEfRpRbzv6QXxFsqz/ENAt21sJyT5bQZ26+08
 0=
X-Received: by 2002:a05:6102:605c:b0:7d2:9cb2:88 with SMTP id
 ada2fe7eead31-7d5061dee63mr964756137.32.1794422802158; 
 Wed, 11 Nov 2026 10:46:42 -0800 (PST)
X-Received: by 2002:a05:6102:605c:b0:7d2:9cb2:88 with SMTP id
 ada2fe7eead31-7d5061dee63mr964715137.32.1794422801221; 
 Wed, 11 Nov 2026 10:46:41 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc9asm11539016f8f.29.2026.11.11.10.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:46:39 -0800 (PST)
Message-ID: <88380d74-ab37-4903-8f8c-4e6652dd5ded@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:46:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>, Richard Acayan
 <mailingradian@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
 <7gqjjq7v5krgibjxqelyjwmrfygfnbsvyfubgbpkshkvgdftxr@dwm3rdpoqbnb>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7gqjjq7v5krgibjxqelyjwmrfygfnbsvyfubgbpkshkvgdftxr@dwm3rdpoqbnb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o6KaAlV_be4w9ah3YTYWcpmTN1D-qmO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NCBTYWx0ZWRfX+2yD9dotntxx
 8AskQ57v/PBFXvpm/iHzFcRqyGX53jp+PdmlS35E8opYtm28tvsdIBWBGm5oZBmCRapNw7HNX7D
 G2uqFmfETDJKbQ7RdyTMgk5yb3e5iUBDNLYyOzmRwK1yaRVjvS3g4/xa3dAAxfvvEJsVl51KA9a
 rk5dPGK7DBpthqGZ/cBdx+RsUOwrBR3gmw5HdNx6Q+UgOgros/PtrMbqhCrMauiSwTniPQEF28t
 +nhPSui/OTngAvC0JyMJOlX2BYbf1sr9i/ir27cUVfjq42cGE0ceZ1ro+NHDuqTEexSiy1jOReX
 LjFEA0aca9nGvaewldZOhUA0FS7nhb0bTOErI7cfN8pv50X/z3eqJeyyc9rcfgsHo9O8Q+AGAKW
 B1x389aqesYEBdX6i5r9eJRZQ7lVP9ZkrK022J6bhgNQfN2WVgp+KOmTZ1MHCT1OlatPfwZNdQ1
 2aOuMfUHU68lFwvH/7Q==
X-Proofpoint-ORIG-GUID: o6KaAlV_be4w9ah3YTYWcpmTN1D-qmO_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NCBTYWx0ZWRfX1xx/pCP4XNu6
 LcUKrTsW/Spv1MVICrmQVC3lqmW7qi5U5XXSWjDOby/Iit2ryzhWq9u2Co4/fJPlU95pmLEgNOV
 acsN+beeSNWpAN7Gz49aZjVZGBOuwXI=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af4b812 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NUy6FM0n4CcUAni1w6YA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110074
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 19:16, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 06:45:01PM +0100, Krzysztof Kozlowski wrote:
>> MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
>> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
>> drivers will also fail the probe.
> 
> I don't think they will fail the probe. Nothing will be registered, no
> bridge will be attached to the DSI host, which means that the component
> device will not be constructed / bound.
> 

Indeed, I'll rephrase.

Best regards,
Krzysztof
