Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07024CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E63A10E372;
	Mon, 25 May 2026 13:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdzgqagf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7liRSue";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7443010E375
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:36:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7Suob961954
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gkAVthLnfyAhplTespkvjb8SZ60S4Dh4P0IflCERNoQ=; b=mdzgqagf1O3zzUHc
 vHcBbRtTJYJ91YULjQVI+koNPIfrsiggWgZFY7slpS1SyoW+pfryM4bn6wBl44AY
 EazfNTqMl7Zs/0Ngvlpn/rBTZvCKdOeEH+WEIZBzWbNnXMZ//IQv9cAZLzLjIlma
 On1JfmCxLI9oj0WVCekC/uHcx27LkZAuQgkvchAVz0Joo4mEWqt7c7wxGOylAMC+
 +uzmWv4BJCjh+KVfkiXkvlAITSj+tLtOJdu0lWPUvon2J22TlP9cVYTgDFxxxBBU
 B3C1GEJH0lISwB+nFo3UTtGGdAwu4lsfpZODn4q4hqKxCsYE6bud9jEB7UNPJZ2q
 EQhwdg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3eswq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:36:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-910a755d717so142097885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779716175; x=1780320975;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gkAVthLnfyAhplTespkvjb8SZ60S4Dh4P0IflCERNoQ=;
 b=R7liRSueWkaVXBT7doS+KBe6O8osPyyBQh2mardUyo5ISZuuIj8K5NncvFJQMdhTn0
 2XXjz7mJx3YcSnkUQkV6gs4fGn2Vpk3JnU4BElUNW2zo9ARo8kB7uxc9OB+K37oobXOl
 h13W+94YpMf33nxFGQGPL540r155Vy65BsUJ2KnIRxuqMBOyEj5/qh+ub6kMIG2Udyw6
 q/9XXn2ey4geI/pBYs1NHs47Y5+Sw9aNjsh6eV851gCgvH2R6lsRFftiTWsoHvXm96Br
 j5zQ0xPCXtfd4fwE3a4m8K4qH5HYiB77uO3lUGd0L0m6CjSOIpP9KN8LPvcgqOE83lV1
 O2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779716175; x=1780320975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkAVthLnfyAhplTespkvjb8SZ60S4Dh4P0IflCERNoQ=;
 b=XKqfo5w+VEyJ081cloPreIpZ6RAGb8FCsUjgJtNsBRwwS9mNJteGq837qWkuqpgmvV
 +4TjTc8DD/8U3rUjjQZkEIQj/s1n22x7ZDI36vlQq9CVYMoQ/NkH1Q0IDQrpMcxFtPHL
 2TuATXlFaBXfNwQ+fSBsxvXZKksZEuQLhZVNlv5fCMUlQONjs3sPZFksCXb++3ytjhms
 WDMgGk2gFGGPC9SVZ1htZQDJnYvhmZsATrpesvkmtLoqq5tNHbAtw3uzMmZNJMGit4zH
 uBvlPbgDGSSb+D8PNGLwNrlkGFdK45RNcs4AkKdFWV7+2/YroCeHaJ25Egd7koR6ZPSt
 Bvig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/URa/5Qr50z3ccjCmH/vkJRGFY0+ZEddWVpi+pFTCGMG4hyP7ga7DZufztKgk2Fnm/s+lRh6CChjw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRnLvnD6Dkxc6QmY2DWUQpe8ic9XRENddRPftk9iJHeCGR9ri9
 ezgj7bY90nXAdyL2iY9ZBkGuaJF1onM6DidRukhTLu0KZpmXJr5SibmwnslCjqvq92O4xMW/iZI
 tYXwaKB+iwic87N/1WnJqdpfZV2haHTm930sJYXnzu+fewqci/yRqF+WeChZHBGpeo1GSass=
X-Gm-Gg: Acq92OFa7cNb7E2hnNAAkMmjhv207bZg6b3vjHpfrWgXMfwYuEFao+NIu9ISFxBf7Lp
 Q9aMfJ5V/p29laB5P8V1z+n1iH7/5uuU76fvUbD+5oMJkGiVtC/vJaZWUdpv2QQeDrGhLYz6YTq
 capZLiSISDF/Tpf8+OyokhqSjMz8fbuBdXqlxy1dS+f9hPt/dh1Gdd7H5FAc22kdarTZZkTP10U
 gVgwZPG5hfgGGuBo/p92T8Pxj6bnHDGeLxPn7BWLT3KZslLlf+SeZyKLY9HUVpLKXLUjr5nYHrh
 Fbw82cbWP+bzewFSyFdWxrwBFljp2G4By0qS1oyFpBTEd8sd1FMvBVbNqCl8w7sapJ6zNo6vpgV
 7ZZg3lEV8Ps6/e6Uscl9JPnlRRE1tySM8bBJ6IWQUSNA3ZmJdIiX/6pQa
X-Received: by 2002:a05:620a:2682:b0:913:b4b9:5ec8 with SMTP id
 af79cd13be357-914b49a070dmr1378456585a.6.1779716175013; 
 Mon, 25 May 2026 06:36:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:913:b4b9:5ec8 with SMTP id
 af79cd13be357-914b49a070dmr1378453585a.6.1779716174573; 
 Mon, 25 May 2026 06:36:14 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688bb427027sm3995814a12.25.2026.05.25.06.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:36:13 -0700 (PDT)
Message-ID: <f7872330-4f95-49ff-9635-87c115c15cf9@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] drm/msm/dp: Add sink_count to debug logs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-8-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-8-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8sE8DuS2m924tr0i8rsASdYH6l6ttdB4
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a14504f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iZbbsgHGrt-r5UQur64A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX+EnX1xeaMTac
 iMzkyM95CdxSVqdUns5v1vvG7tbuDLoHCVwXLYnGOAon/MPRN7ZRcCVdSRQrzybWRZKJsVULE/W
 Ri/X2tRhT2GoCGyuGMv9W4HIWeSTh0OrQYC8LapZStHdBJx+gKOGUn4IC+VcFU/d2si5qunSwFt
 nwjGvYnxCmHHtNSSGrL4yudrFHJNNGXqi7Ctpu5cjx0VX11bAXjG3nvUiw4sGJUIphk50kmxT2V
 ODu3AIP6rNljVzlE/BU9SnVQeU4sicihIls8SHQJsGFSYZtd9d6JVIOs+ZnbHE9KIO25GKzEi4j
 kH0X+AGI0gfNe1V/5cmAChDYvBT9gsupg7RlnUto0XOmY9EcXs6RrBxZBg7SCpYBnQ/VJdo3vEt
 6HUkKLFlpmGMJb/c5UDOdPLVlvugpbs3itcGxUDRNTFStlSnDGwr/z8DkQQLjk4dcq393/gNQGH
 IJdtAG1hSxdzkvfO+XA==
X-Proofpoint-GUID: 8sE8DuS2m924tr0i8rsASdYH6l6ttdB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250138
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

On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Add sink count to the debug logs for [un]plug and HPD IRQ handling.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> [DB: dropped link_ready handling]
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
