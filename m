Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4740606A334
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M586mBLx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MDti5DVA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195B310E24A;
	Thu, 22 Oct 2026 09:07:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF1210E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M70KHa2174683
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T9mZuQQYoWWsPIv3lgJNtkF+nm2oQ1HULJ9PRpgeEvM=; b=M586mBLx+FD4X+tG
 R2Mk1TD2JkV2EZL8yi89fwMORGIse03JH2vFQSH9fImFtbxrK1C4QJDwi8c7EW7z
 HkKrxUS/8pFuTFkbNYrBO7PTzp1TJFJqN85FeTZVtkLBr8r4OCyAwIPSz6sahtEm
 KK5qXqiGl5dE0Voj0KEydZ5cVu/D+FUa8o2toyysfRgvw7Ma8HpH7q4oQYFQoRxC
 zR7m4j/DMD+wGONv4fxhG7KJlDpnG08roqKcj4ZDhUZiMWCHbtmGxf966hYrUGwl
 pQ/S8ITwYeRR/1CzVPPPk5LtucaHCebknQr2I2QgKLKapzQx6ACNEnR8GggRm8mu
 lduQGg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahkq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cac495d99so30389285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792660052; x=1793264852;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9mZuQQYoWWsPIv3lgJNtkF+nm2oQ1HULJ9PRpgeEvM=;
 b=MDti5DVABo0xq43qCYQhxFl3YirjjBQynjXrFBsm2ExwZSgcIVSzgQe6qoVJOzrbPB
 nirI2m6VN5R1JWGO/xJCBGs9vLaIt7TxPbFjiv9GikRI2Lg6Wv79G75IGAK7gg0png+1
 kWEUgeaPBDE0WJu9Vs+uVCpWUrdfxh2i3Rb1owRmh/90YgkLm4hVpM9+9IUtHbxWgcB9
 PTmqhlstuX6TwBoYqi9X24HYFpKvkMWw0VmkFfR7fY98ooJa5o/lnegF+ty30dgsaTCi
 fJjNUx4e8+t/0mVa6rDu26Z7LWUc+Bf1DC6W0ZrIH+c/NZgOdzf0zXvINGmZ7pEOCY87
 SsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660052; x=1793264852;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T9mZuQQYoWWsPIv3lgJNtkF+nm2oQ1HULJ9PRpgeEvM=;
 b=v40Fl6TeMnB1ZuazZ+29ewlaUnArqf1REE8vEOUJz6W8ZEtlSfDS0En3QYTGG6XIko
 Z5q8VJumxsaP2y7ysJbEAeWY+r8UrdU9RH9vLA8/PDi7Z95+WfeIclGA1os/Vv9f6q/M
 jAT5U4basjOLkal5qeSlIZkT8FM3KEJgv6vm1oQQDIt1d9WfhdYO532+tYDuaJAmeaW2
 amfoSrTxn+Cz3CdZbYgsFmzNti9mNwcl2FSnFdWm/bBRBSkNMtHqKWHXgTelZae/pMvw
 5iXeGnli5IEvu0PbSThcZE0MGMQwyuoZ5xBgxhzbV8ExK6yTfMYtPP2IRiXdXtHjk+nA
 WvTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3xT6jOgV3aIUaiABlw/95NHuEzUoSmk+FP+Kg23RdsO52KTrZrgTpxqLei4s/RKmWuPvKiKKqGqk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJBfrH3XiQ6Q2bl583bb84A74nBV6ZqOtKDNWppJNK9uFXgbKQ
 cGvpMpomXbgdLNVJo2EQCtcN5R14yYFYQTl7yslTjOBqcJ/bYVw8s14Pk8gUBbdT6gg0tnyboSd
 dU7mi0iLsseKB+a/PXdN+MKlFxn6Pf63UcqBe8GMAVMXhg3SDu4gVk7iXC4jMr5FVkLCIPIY=
X-Gm-Gg: AYBFou3hlcD1f/hWEb5v5ne//usBxuJSmjm2NANQdXwdRSxPTuNO0ZHWj0nI+AjzNIU
 RN0rMxFsISydj5xIK7Gxx1vkNTVVx/vCaOLl1wzWcDL0uNnUgOMca8ITerw3oU1NbveTtb9ujup
 Pft0d4sKQNde4jAKNzwFoXWRlf4jeZk7THcRbPjs6ToxMw4ip790FTgYa0S3E2JbnEh0pJdaqR0
 JI7e8Ra1C0cotdp8XGC2uTRDt8EiWaO9R9LfU/OcXuILSJUNiFBvrvJS5cuhIh5e+q9MUWLcPTe
 FRQ8nEEHdApsJjMBGIajkcMk8nnFeT1dzJDIrgIs8f46hAttRFmKzYCx68Ag93g86zdNM45Zlou
 lGPfGK2gTNUsoRk0yRp02GA==
X-Received: by 2002:a05:620a:450e:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93f57faf861mr1017575085a.4.1792660052313; 
 Thu, 22 Oct 2026 02:07:32 -0700 (PDT)
X-Received: by 2002:a05:620a:450e:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93f57faf861mr1017570185a.4.1792660051883; 
 Thu, 22 Oct 2026 02:07:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a55ffb2sm81973866b.38.2026.10.22.02.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:07:31 -0700 (PDT)
Message-ID: <aa18ce17-4169-4f3e-8e25-c088c69db0c5@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:07:27 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
 <20261019-sdm845-hdk-v5-4-4aa7e22cd0ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-4-4aa7e22cd0ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pikI1W6PJGRWZ2JPAfaYCXuOoyC7u6__
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX9lTyjEcXs41m
 80S8mdAmy7Sw2B0hNjS0X10fDoGb/Fmf8BSoKLlz1AdIEhQ1VSf3pXBEyd04YeMo9KFJCw9U1yr
 Qcj0kzh6X9gBNe2cJH0D/UOahUy0kMs=
X-Proofpoint-ORIG-GUID: pikI1W6PJGRWZ2JPAfaYCXuOoyC7u6__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX7wmhtCpZVgNB
 9oOvmWObkR9yhGwSCIT7u7M/uHiAZLEaGKdy2n2A0/f1LVmtnAl+nI2GexIb84GJ4P8Rl9t489I
 wtV9xv6JnqJrdDaPjxFYlcb1YcAvAXKr7R4XChN0rCOuYPQ2moYENk5dXxRx8wT7dUrd7c2x61w
 sj8lb1DwlxyXh7gvwO3Dl5j+T2mYo/KoGPd071/xHjvrF3lO4TXSlxkB8Qw2raAVAeo8MxeQyGo
 96SbRXj9DESlyyOmugKKNb3Dlm5poDHJ4K1n0Ude04XlcrdYQTWx2hUFw492TJkwaT35hVNc1Tp
 9FMFsTWxPulDJKdIiLjU1ffeGwtDi/T4jQuaWJEsQyFxy8VVbkU2VfnjRc9OuVTWD2MPOAL2iyQ
 XhuPQCUH7x69AaOa9HPExFjxULIYFOb0FubLu8kf9iHMQMwmlePdmO72Oghy83vMnniPNjvVTr5
 4Qp3RrqjPRRTQ4DYuYQ==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9d255 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=YDUdIes_syoG-XcJBr4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220036
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

On 10/19/26 11:18 AM, Dmitry Baryshkov wrote:
> Add device tree for the Qualcomm / Lantronix SDM845 HDK. It is the
> development platform using the modem-less (SDA845) SoC, optional onboard
> DSI panel and a rich set of connectors.
> 
> Working:
> - HDMI display
> - uSD, UFS, USB
> - DSPs, WiFi, BT
> - Buttons, LEDs
> 
> Not working or not tested:
> - DisplayPort - TCPM not supported for this PMIC
> - WiGig - requires power sequencing driver, doesn't work with the
>   current in-kernel driver
> - Audio
> - FingerPrint
> - USIM
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
