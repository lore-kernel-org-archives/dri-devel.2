Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EED606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ofHmSgH9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OGg8eFL5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B6D10ED47;
	Mon,  2 Nov 2026 11:49:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289B910ED47
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:49:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29A5Hp260605
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ok52yNh2y/vd7LQUBnqiLzCNFtiJc7744aqsR0f9mLc=; b=ofHmSgH9FKVoN6FP
 EZvtNVxIU+jc/kRrs1G26S5RN6Why14/9JolC2Eor5INtH3BV/IbexYikxiRnU0Y
 NBSn3RfePJCK0O8GLANKGocGJGWunwRYbna3uGmmQ2q/wtd/f7PGkOAM2+9F2frW
 of3Wu2rGREhEFuK+xehUq/u0NvHbwEaqN2GG6hrC9HY0Oe+SV9+kIzIWrU+onxiI
 xuC9P2/Ei6M2W6CEl6i2wfwgLIqMF0KyWH5Af1h7oFcaD7KhYCdedKfb0Iq+b6uf
 Gyt6a1sTqqhZ1qUadaKuk7yKlDHZIcIsLNBeOddysolN07KN2+GxL4lw5seOGw7O
 xvV9iw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvrkhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:49:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93df7a9466bso18275685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793620161; x=1794224961;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ok52yNh2y/vd7LQUBnqiLzCNFtiJc7744aqsR0f9mLc=;
 b=OGg8eFL5Ry2/I31XRdm6hdiCPRveJJTJ9/hqjlGVzXwvwKAzxr7euGrkN7LP/eb4+y
 oNdZ79tGT5ajDoVQCYBJVjSWGp/xgEykeGfKUqtIngqJ/T25I0lZui51kjICDQmGFmp7
 ZK9wcpvkRjg8vPi70wQDu9IDOUD+a3TJCPU1phceVkcH0riLcsOQgFaFW1MSY8plSmFZ
 15LVaBaLBssgcCirZgLDTFRWhgOE7yDRIhuBszl1xrQNmxUaoP00iLCczQDKYu9KZyrY
 hWcf9MjiWEZeae3LeRyKTlFz0rnQp8CI0CiUhbVScW6tUOLDjJko46U+SSEGTR3wUfQs
 UY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620161; x=1794224961;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ok52yNh2y/vd7LQUBnqiLzCNFtiJc7744aqsR0f9mLc=;
 b=kKQXZr4UTbzbC0TlD8xEt0A91U2fruAa4TRDyG08z6art22uwZeK4I6SE2n5KPvr4T
 7d7paaoF02yfi8VJtvIC2J0WZMerIYR5xbPsHqUwaQZcc5ulQoJ9B43gsbNlVooi2fB8
 GbgygE7VQw1+BGm942X7Kp31ijimiNwuj3TdEdn2mCyBxO4qwd5rof1T4IUiZEV5VCmI
 /94lPOolAlz+Y168T0wZ7jVc/+o4B1jZ7s7jpqCZFkAHexTAUuwPnCxL07RjA8SMn0Dy
 bNqOLqakFiaQLYteHnocREgfpV3ZqoQnoBDF4asvYIDHxsUO1zttGMFTHKfgPDk0W/Xw
 fyVA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZmMadQwRpVgvnhAgtmBXofOoKltGSD5Gxiv8qLuSo40FVxETYxx2UlCIo+wKiRfrlIHanjZtdEZY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI5Gp2NnjHmBhrdfy1BX53JrsjPVoMZDi06ewoaSFSh+jWjGudK
 u0OM/83AFVoJpFzqkIfKvB9RWbf71YDJZkYbGqr5bde7oLQCfSeUVaoJkpLFmN2hYYJeG26Y3e2
 RvEIAuKuGe1UXT385kCaBfKLqFQJdUdGFKksUowv06rbluUNYHNyLpkIcN7xN0GItdnAQq5o=
X-Gm-Gg: AYBFou297JBiZHdbGVGNyrn86wFXQ7yQR89DqgiATL+fI/RISBz2zRbK1478259U5o6
 nSWAczb+cSaOGqyTUNLDk7BOU0OQ65EG15Br11c2PGb+MKjgNQdHr4GG1lRrLMpv4TvJXN8ifIM
 joyRsGHXN7TIZHd4j07pe+l6s1A6z0gDfclA2+lJ19JOMYHSXKNPuSCxQDmoXKSR4LNf+TzPaXo
 i9v4wy1SwprpKbtAX4JE+TBSex2MInUbOLa5v96erKgsqAx/x6+/j/vEZ6rdliLn7+F3kV+3CiM
 NiaCQun9VkwQtRf2LpNa6U4E0NJ1hmijv1Pn6UEpU50UvuoRyq0J/gqpR8aA5PP1fGdBVjdaIfA
 Xy9vqlFC0va/AxaAxnS/1+6QhtG1aiCO8FrICpr15T4XOSehqpo9wuoQy+XMjFcIj9NeBfv8=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1795218085a.3.1793620160660; 
 Mon, 02 Nov 2026 03:49:20 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1795215085a.3.1793620160155; 
 Mon, 02 Nov 2026 03:49:20 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0f376sm3301742a12.26.2026.11.02.03.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:49:17 -0800 (PST)
Message-ID: <d6126285-97b7-4424-a644-23828d58cd82@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:49:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: display/msm: Add SM7250 MDSS
To: Krzysztof Kozlowski <krzk@kernel.org>, Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-3-159f403ec405@brar.si>
 <20261102-wandering-peach-lemur-0c57fc@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-wandering-peach-lemur-0c57fc@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae878c1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ujgWmTuqKpTCez_IP1MA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tn4iAiD6OayXQxspMuCHPtc_wHEoj5mj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX50a/nefTdJ5j
 E1t9i4IXR5dmgjWoAXhR1I5xEG4jIK94ugE+g3iPAnGqQQELbvosnJPJKXHgutkg/gdyV5klehe
 ZSvEEoLTc1+XXVgOKUdua8yrVYUhmhA=
X-Proofpoint-ORIG-GUID: tn4iAiD6OayXQxspMuCHPtc_wHEoj5mj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX4IHQjZriF+U5
 jqTEO6poADvkLQNhBDVw5aUyKhxLa5a9ehFqLqojNj/oY8Kjl16f+P0hAMrz5Hj2z5sFo2OJp+X
 rYM5ymENTEBY+RjhKXZQkj+qd+T6R3BYO/FhHZAjBULuOD6Kj9KzfDICdcv5vm4L8hfMb4VQ6tk
 Pdh3VqeDTQ5CriGPgtxfWH97CKLHD3Y4V8eSp6JLIzl+ZAsobyle2h66vqV7bqkJbQBsDVOeFcG
 tYY0nhpP8acstmgZktTZtGJoLwXbSXguJEshtg4T4ucv6fwAjtDmrxgfG5gVB+owscfefWN/nAt
 elVz9zCTd23YqZ17KjnPFrJP27Api+CgSQckBrZz37eXySQ1PGT8sPFq1b9VDCqaKryDUuz24+G
 X3JUEkZC5WU0jiGRKm1RV2nHXtm1I+o1MtO86WknSQaLx+F/7R+0pXZYQux+3zHAfk+a0xPagtr
 BFE7TQCQ7H3X5d1AGmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046
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

On 11/2/26 12:35 PM, Krzysztof Kozlowski wrote:
> On Sat, Oct 31, 2026 at 01:23:39PM +0530, Ishu Brar wrote:
>> Add the binding for the SM7250 Mobile Display Subsystem. It has the
>> same clocks and children as the SM8250 one, so it is modeled on
>> qcom,sm8250-mdss.yaml. The example uses the SM8250 clock and
> 
> No DisplayPort?

FWIW This SoC has a single DP controller

Konrad
