Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52511606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=knSkjZp5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IAUJ2P7L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8EC10EF21;
	Mon, 23 Nov 2026 17:23:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0AA10EF6E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:23:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH2AJ3475199
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QqMha60toiq9cJ0Dwjl5c0knVmrMb1MbEveOjw8znfg=; b=knSkjZp5LKR92Av2
 al90EzL7Icqx9lO9pkbP/E0hjvkTFTphVMldeVE+zlb7IHvd9z9iDIX9vDs2133S
 Y1g99l8t+ePbH5zQzm3kjP13wyEiPZy+G1X0VNSTg7lYg2Silw1llyAPdX88XZaZ
 R8w5wfayKFiius+c5dkLpWVPFGVrPxrRF43w6glKhHLXL81FiuHnXVna4Y6rFz4K
 ZpgdopiaJfoiQwwf2XxxXLC3bR30QDGqUUuwZsHpnReLJE7tG/83wKt2wILqcAZR
 t7ww+/yE/ls/sWw3n1Zr056FB97gXM16MXHIod2hhA6Iaomrj5irQRrQYnjBatbX
 Qr4SfQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7t7a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:23:22 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5edfa7703ffso111641e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795454601; x=1796059401;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QqMha60toiq9cJ0Dwjl5c0knVmrMb1MbEveOjw8znfg=;
 b=IAUJ2P7LdU8F80sLBMltb1DrJ9/K3DqH/Y1bEmhCCNsx1z61Byu7M2ExtCk//iIPXu
 SmIVgU9ALz7Gy68DX+MQjo1iVPApWcGh7uTJY1eRob3zcNVlrHSGxowapY2FXKyoQKWU
 6ypSZIwKms2PJIDn1FB4+s4gtENGiUnHYWsu+iZFkmNQYhPwOTneJSTYoZmSqnuOgPeR
 5HEpBeXm4hPofDMV2hAoZsKuzKJRrDYOpna+/nZfeUEZUsqaNUiIkze1RNTCBq6RvTOt
 uAPQ9gAxi/Ew/oTwj8M9BCU7gwoxEXI7fVUJ8DOAZKvRVF4b0GEIxjgQrrhQx2ZITSrS
 PO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795454601; x=1796059401;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqMha60toiq9cJ0Dwjl5c0knVmrMb1MbEveOjw8znfg=;
 b=nIIQACCNj2voicw7UIZZFTRwCOBq46ewMv+Rv5AmJoxw/Tqvsf4v2Q+8/bvV4c/LcW
 AFsSaPZ1Ah/QPUrU89o1KZE5/iCFqgmn97g5ZD8y6AW3TMxq0qVl4HmCOw5vyu8/uKBA
 s2X5Oy/vj7MtnjluefuPxNY44O+bJ9paSwULCT6fsL8iFZmkn6NaQ8O9pV2OCRTpwXkv
 nPyFOvzty/zNt3d4vZjxuYao6vtTfWxIML9QAD0ESEVNvyoKDoVQb75hdMo15TYsizUd
 p7RvSPxuHCNvaaiX9vHx6WQr1D3ZcrPsmROOU5p5MoXFz/3oaRu8Uzl1XQ5LoFGaiQkz
 dsxg==
X-Forwarded-Encrypted: i=1;
 AL+hErFk69j1cqj9X1pxgfmd7Z8bb892O3P6Zle0UwhImo9OTFX2he9cP4aXzZI7XenBu2ZDldEDyngY54A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/47Nq5pQ5TUErlPna0kLa52uG5n8zutfFKovrkDWQd9pi+NzjQ
 ckXOPIGVuGX60jJ1z7NUF7sE8YbcWfN3b7hXmT5PAK9GLprPICCzLQl0HU0mFmGLJw7Moe/GlFl
 jdlSZWspNqrXwbhcb+WOIBX4eUsVyrkOvvNC6/BZr186lrs7R3eL0i4OR/PKsTHxWHstSXjw=
X-Gm-Gg: AZFdTZd1XkVlbxyZIdeRRhljKhoLTHrTWnrfEuPqo3V7TR/Y2m71PVNEokbr+FNu6qW
 7bbhApz+TVBgzI4xwXW8xDYjzZKNIUtLLSWpYwM2JhCEwaH0h4K5V5rGBQOmo6h0uKnYq2JOanH
 BqwEymcXiBdjTcA6tCs1vndlV9h+xW4/UEPF+YVJD16SqwHCvhtQ/22CfpLLPYEp6rO8EffCFd7
 9283d9h2/3vFfT+CxCIHkBDU2Z7YEIRcO0cJhfWvZQf9HcQl6dy93NTcGOHLH77tLn92LEfMLUm
 +jhM9ADGV9UvBp77ZO4xh/QArYBxZWyxGvKQm8Fr8p16zIGRQVZQH0OMrvBWHf9gqABYFGTuBKn
 JpOoPTkBXM+ub+tG+g39bP0H2O7LcURKlt2swt5NGr4/1dq0Dx/aouEOfa0iZvf45zXURSn4=
X-Received: by 2002:a05:6122:6846:20b0:5ec:b437:e670 with SMTP id
 71dfb90a1353d-5ee8aeb50e2mr6973957e0c.3.1795454601043; 
 Mon, 23 Nov 2026 09:23:21 -0800 (PST)
X-Received: by 2002:a05:6122:6846:20b0:5ec:b437:e670 with SMTP id
 71dfb90a1353d-5ee8aeb50e2mr6973910e0c.3.1795454600582; 
 Mon, 23 Nov 2026 09:23:20 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6872asm419548566b.13.2026.11.23.09.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:23:19 -0800 (PST)
Message-ID: <40157685-826e-4011-93f2-1632b244a1df@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 18:23:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a8xx: Add missing preempt_record_size
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Connor Abbott <cwabbott0@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261123172025.402295-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261123172025.402295-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b04768a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S6-QWJaKbxxgmz9MQ4kA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfXzrbdq7hjr+5m
 1THC3mguKF3dU+ooR8BszQ1/ZimCzyi5pZiSk1y8AVRc21FTfOtbZ0P6RYVBbR2tCsm6dORdpwP
 D9HMNALJuCs7P0ODZ1FAF7qd52C0iV8dW6fsyCn/iHlG2Y9qAZWvZ5yVhvatbd3OUriR1Y/96Wf
 cPyJuZu15WcAV9zNj+TY6FiHNedZm1Kyg0+xiqhooL+mncWdiuo/SzJ4yGkETW1Yg6cMxY244U3
 HtMEBLyRNqOrsaJu/zQiJN4NoCr5PpNkC2g3EqMvD9tRt3Citb4j6sIFaFOHYEjHILuR+xvPHCZ
 UkNveCdZvZHjzoLEZiL/pujS0CK36oNBjl83xdkAtWGUY9hvqM5s7PLISpThDH+I7NCU1QC1Dlh
 yaM7NtFHSPihghBSFVmif0dAfd02uxGfqJLwO7EtC5CyyZIOoQZtsOQc9kYuzcG5UGetnkL/Rwr
 h1xJooeSiLXpt7BvnyA==
X-Proofpoint-GUID: NClPmNlnjm9ZfurvHRL5c58pf28fYaFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX91Vf8mpTUcAm
 2WnluZldZtNoWHfvGZrNKpVDOHtQiLqTTw023r7AivVvzY46+okI6KxD41W7sRfqsNJwrH4UQou
 edaMlAg/DpSuRA0aYYVscIpj2Mv9TtA=
X-Proofpoint-ORIG-GUID: NClPmNlnjm9ZfurvHRL5c58pf28fYaFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230069
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 6:20 PM, Rob Clark wrote:
> Somehow this got overlooked, and Glymur/Mahua were falling back to the
> default 4MB.  Which is way too small for the amount of GMEM on these
> devices, causing faults in cases where preemption needs to same GMEM

s/same/save?

> contents.
> 
> Reported-by: Connor Abbott <cwabbott0@gmail.com>
> Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
