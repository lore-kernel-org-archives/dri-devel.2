Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E42DCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB9B11222F;
	Thu, 15 Oct 2026 09:12:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA55711222F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:12:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F72Vpq2121303
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=; b=aMNRiQwIIFWHlTal
 SIMFgwXbrdTzdpk6c7h5Fcz1W4YB/+YEt+u2yda6R1bMQEhvFAFGefcMhLVx4d6b
 cfrx+yJtHLY24a0xFmPGjI0TgUQS36D3YZFADs+ib07/NM0eNuP5HDMeuDPBF3Az
 FE0Z4+ApkZAntbkmtGmpDzjqllBIQo7FPDXkmRcQRKc1iTBOo23zjKxOiDzxLtxE
 xDEGP6YBLly6OPtftIC1XGtF7RpjLajAgWFHSsXoFHXniHNU0lpjME4SKEJ2w/rM
 bjC4ShzKR1cvtLxdqSckr/Y/1bkdqM0G8UOZUmBocuZ4WnZLj6N7+WgYxtkOgZ+m
 oXxSjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1x29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:12:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e58614290so36483885a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055524; x=1792660324;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=;
 b=Q9f3ixywOzmvmzkD+jnIQlIrpx3BAnXysSmhNOu/dQaHpHI7kJvtRr5JIg3Vgz7fFf
 /+Q/PPH4gsb2YugO5ZOsSeZji43FdfJGRq768lE6mn7WBfHNFro2e54+EQzsvqxSdUt9
 RnYnHWyxe7ANJSjQDz42b/P+eNdPg6cH9HtGoYP74fto1SLFjEwNh2KGQ+uHp4+P/7dK
 bk3l1aaqbV3MQXJr9WI/aVHzECCeA8WwGaWTlACkf4oPlNQAjI1Eagxh++sq4E++Tfqw
 907I1uM1CLvw8t4zXvWlAsK0u14vyza6AkU0ZfNRCG6twJcxABtFtPEUtVnUdC71v2RO
 qziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055524; x=1792660324;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=;
 b=YbxyuTZumcU0UH8l7u9XDwzuMd04ksrUWS0h5U7zIeTrYQ8uEjK9dvBPkHc6N7S8LT
 HfE1ZDbfYYG7CKDOz/k9+N0ywkVUSQZ04sxrIdxj4JhYobvqEI61CodNbutODmgbP2Hd
 nwj+LaMw7Iy4I4HU6eaNeF2qpEY8dCE6SaZEgZFfPTeOnDH+MeelI1NBnTaHJuDzpt8v
 ytzfyaYovfxG9EhgSLstiYvxkdOaTLFihM+CAL4LKc4mPtK0cr/V7cdR8uCDLL8RQ3kv
 E43TOClyFnG4DSHxsdYrEagJRnS9ZP2Ii7gNSiZdK4Sr8184Q1i2NxYbJ6qKemUtgr1y
 gv3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYtVxStG8h3v7SL47OusWbdLyiWgr4ibtvr/H4t6elKF1q3f0n0csI/zbdH+nkoQh5melwXjKKj4k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJeur6cEZtEd9jI/kzydHLjcfj+7PF5MrDT5hKBtKztL/sgtAcP
 iELSefUEZpx1fu8HQLKh+LHQXeg2RkGMitXbMgXiRuNGg7urpgHSzYYT9go1tzxEGfQF3m6z6Gs
 HcHg1yotstBDSeircUgPds3bRN0sGsRR0Oz9yXah4sFyIguQTvggGDVlKsLAMAbKYp2Izy6wKHS
 Dka34=
X-Gm-Gg: AYBFou1slJwRac9VVJYUFUhzn6Sqy/BbfDgsg0kDq3i+4TadEGZG8nM1ehHdSJC78KO
 u5nOnXl1MxnubNlYmvNIh9OrxZVMPHJjBVBNzqO4KM3Sij70iGLZNFa1MkR3tp7NhUOMobzZM19
 llPQj3WDojgOSXF+Tvn9FVh8RXMyNABpbeO5m8p0xcV6q31IvGsxsYkKwLAB/2oAGpp0tIWTPAo
 NN7/pbT7STOj2y1AWz7IHKOeW+7uI9yIqhubLeY++D0L3fHNW6zAvdbNemJYpjMIt1XNEANofyZ
 a1BPyavq2xpMgC//qM/X08IVDCb6e6hgedKj8/q0Vp1MSONKas0mmlabDplNLACT8xMybOIoMQu
 cx8Bnlltn96DJf2jpxWBdwg==
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id
 af79cd13be357-93ebd10b418mr3112657285a.2.1792055524070; 
 Thu, 15 Oct 2026 02:12:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id
 af79cd13be357-93ebd10b418mr3112654885a.2.1792055523631; 
 Thu, 15 Oct 2026 02:12:03 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b20388c1f1sm2263767a12.26.2026.10.15.02.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:12:02 -0700 (PDT)
Message-ID: <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXybuqNquAlUKi
 VNDJKaHIboA26tZkdqA+QIRNOspHKzSPPfcED9HyhNfcAs2xGxF5ttJ5ELgOaNJcSg9QDnBIlx6
 1AjBAotvzZFbiBXt3adAGveQMd00h2TS45dDRF8mm9sdOEf4i1zvmvDBpewb8bgPTpXeuJpfaAj
 I2gkjIH/B7XLdiKMMeeShn2QQ7o5Era6xk1wZ2kSFFw9lSZxxjdQYYlcvhpmIgFuISQ1DvojiTD
 QyGjTtWXsfX3F3unJPEchKN9l+U9kUJlHBXZKD1E1fDFrK3PYrl4/JY9O1zoQSPsZ5PVBhUgWfJ
 9fSI4BWaPq+LMtgz5eukQdl/Sxe5bifLrVjzE4vmr8hHrhY2e88zmJZMbe8OO75LwUdnqsKEVx1
 y+LDG0WNr4HqSyfnNwIfAFDIjfs2vYdv3ozOANt5sExrQB9u471RkwjRHwSvjReI7dOZe7TE8Hd
 wPy1Cg3l7K+QQVUIZMg==
X-Proofpoint-GUID: Eb85fC9e827em9Dh6h_7z6smJYpch9tL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX22zOzBmxknAz
 NwhQ1j+wzawXQgoBXigvCaNiiEacBgEjvUt5V3XUMhU1vABd0kNnA1p7JOkz3pLw9FItVQDOPLy
 cz38LbqcllFiZQTwSgJ+WN5SH02Ec3U=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad098e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3BQMGBUH80HoBbyhx_0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Eb85fC9e827em9Dh6h_7z6smJYpch9tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150036
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

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> If the bootloader leaves the WLED module enabled, the OVP interrupt is
> left enabled at probe time. The first brightness update then schedules
> wled_ovp_work(), which enables the interrupt for a second time and
> triggers the "Unbalanced enable for IRQ" warning.
> 
> Track whether the driver has disabled the interrupt and only enable it
> back in that case.
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

This was merged yesterday:

https://lore.kernel.org/lkml/20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz/

Konrad
