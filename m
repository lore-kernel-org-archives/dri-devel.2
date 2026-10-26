Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAA606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IJTvIbc4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d1fL+KGa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380D110ED2A;
	Mon, 26 Oct 2026 09:40:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6701310ED21
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4ahSR1708828
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OcTBksbIW2mgBaa78YQJkuMhgafx6BdMoS+/otq+mGA=; b=IJTvIbc44rF5CL39
 Dl/OAuV0Pu4/t2JqcNSgZ8FgEH5YHfDNzAoTj1m6HyEwm/976G785vA1nB9G/KWG
 BVMCXYSejpmXkTLUFhQcFXpHxMSIr4bpVpd2tUMHRQJgb+vcLHCTbbloGhZzEBJV
 hRsagjmw5WTcY9ZkE8UF+T1gwIgJjtBMx7SjeiJJYVc8ReFj2bawChK/SPQmmOuC
 rY8XC6X3DZkd5gp60d0uuqdgAPixY4JoJ/Oypwj40+FttqVdbCeqXVMa3npiPcrc
 Ocr1J8ZzzEa/1tV0bVwNczkAT5ZFDXUfyWBOgttaIU+Ma0Nkt62t8+KQS5U62YeL
 MV3Ftw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9t90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc50fb0d2so44257385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007632; x=1793612432;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OcTBksbIW2mgBaa78YQJkuMhgafx6BdMoS+/otq+mGA=;
 b=d1fL+KGadJEOO8eTe1Qbin5gVCFgw6FT2W4+/A6ncmjdQ/3z6S1uz69cay1iCYVOpG
 ZB7O1A3vWPeDtGMoesLgPLksPczswH1vsCZfOL9ye+wTRV3jq9TrIuDYAMNCmZPJqQgb
 2gQXZrGv13QXNDBSNczkgbRpEfvBtbTXuRAlRsmwhSgYoWQhBroyB3Fu2a5jbe/5mxq4
 KoSHRbWbYbQCFIf0ZbyVZMG3NCX+MaioLx5Mz2xiYBBfa/eD8C+vKgJQXoAknoqxRkgz
 R1pKxBw437A2B1/n4GXeRfUxGC2qT37WhX5OHXww0dZDEv8WiC/Oel/KLAE8D8NZiZx7
 FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007632; x=1793612432;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcTBksbIW2mgBaa78YQJkuMhgafx6BdMoS+/otq+mGA=;
 b=vX1YY5djLUGOAN1bSsF5sgjW2cxSbiNXByS7qVbzBsox9mGnf6jdIm+v7BDZsnmcTI
 j85g7ifxKxvMVonr91l2L6Z6LxB71w8PhdoSWqKYuvMdI0Gqzc4UPc4Dtw3G9WaxtFir
 i30ozpdBGIHl/Py0doBWxOvzYydaDs7XxEPm6D8ZmItbT7gLGoMJI/LU13a7ciyWw1aE
 9wvB198y77XaJ7AEnUdDEPJvEEYlx29QDDI77k0iju3mBJfIueaVAqtwJHCG3PgN843H
 7G3HBoeDqgKPwC5fAbELQ88TgxOW/9QUKqTUN4xCXWV6ZxdYovLnsvVBsMPtzM0sPPwJ
 HjvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSxqcx+nUAj/cmzcbO8UnU7RwgoUcPWJ2h7Bv9bgzfiBY2sRsmCD2JPCGZf0ylbkZN9Wq/e5eldfM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBnWUdvOdXjwzC655s42h+DIJ+ixm2fbvhoH5wOyaZnymmJq21
 ROhFUHDvN9FrWu+SpWbwnPNxMQIVChPstc8eZoVkX/nCxqxQzOM7tn7MHTRy5TsOTcCLjeF+usb
 aiVRFsjoJvRtKkbkBvxdNzxCsqR/lRYF8YX/V0s+J2sIZYK445EszsXB/HG2sGxYJ5ZetRsA=
X-Gm-Gg: AYBFou37sfgFhNTK2+gi6YSa/QwBcklx90Ni1EEbOV0etYDI5FfEwvP/itRMWQ2C1aO
 geVe/AO8p4huU8NbHjdnukf+7tI4BMfi/UbHzp8G5a1a6AQgNJKtF4qKevYkYzOadzYVIczqTPG
 k5htJzNKNTfY3tuapnS/8DTHtVgbp4vFlI3S8x7uxuXw3zCawaH3KLL3A6BBBWp/2Ot6ptcLX3u
 VUttl9e8xaVylGPQA2KYIlqFqR98Pls1x4BlOuVV1fMtlEfT6CHPxgHq0nbrZyCHSKZgcj02rga
 5SVDfFW3IQxAYtSlkF3DvSzi9aCdohmURzUIKPkCpXRpoVByPs/Vu2f8THUAmxHqa9Su92Acelc
 qR/Dn6op6LCpr97gmG3a4FA==
X-Received: by 2002:a05:620a:8794:b0:93f:43a4:a48f with SMTP id
 af79cd13be357-940ef96b4d0mr911111185a.5.1793007631888; 
 Mon, 26 Oct 2026 02:40:31 -0700 (PDT)
X-Received: by 2002:a05:620a:8794:b0:93f:43a4:a48f with SMTP id
 af79cd13be357-940ef96b4d0mr911109685a.5.1793007631426; 
 Mon, 26 Oct 2026 02:40:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f465sm296760466b.8.2026.10.26.02.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:40:30 -0700 (PDT)
Message-ID: <c3fa2f7b-42ba-4e10-af06-4cbf5676e438@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:40:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] drm/msm/mdp4: unwind a failed mdp4_kms_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-8-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-8-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qippkdepHgkFoXOCzWxthqPYZoDniz9p
X-Proofpoint-GUID: qippkdepHgkFoXOCzWxthqPYZoDniz9p
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf2010 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kk-Jr0jdRmDx8_r1h5YA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX1K8CS0PReNmf
 j7IcY62/yhYJuN5GdHOja9QIC6Q57x6IeMdK11mQnphIJDCpKUJQtpCCNBwLPMNVM5xXnxQ5DuP
 ULDJF7ZZzZQakD2Vzsh36jMcxPEYDQg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX0SvWImU+ZAx7
 c5gb0qXJ1m0r9ay3fPWd35yZ0fT9dstBzQH9ZFyKezMxJ4YEzSh2U71p8dQ+KhD4s681ZydZyxa
 voM/Fiduy0qsPO93aWK4S774lTZ/nbXYZVatyGVZSIC66h7Qq4lj2uCdiyPZAihxkizyi4reyEL
 QosJkfkogdHMWSdfmL6DhXUqzMis5lXxDvWfNysVjRDv9i7RaEQjQH+kCkd+Yfgjs1/VsJ67wKH
 vAeFOYmqft97XqS1okUlBmtIP6uWVbAmBtSJFU5b8duDvGORLHPcegGdZhUx3kgHDNaq2t/PiBn
 uknMkkCIQB+J69IkfmK4Dc/+gq2pDVSqrPBkuFauDXGCnwv/fYp5LazRoxVtBKzCMv8r+0WNlYp
 fznWz2llvx7+2auNI4DnYvi/URmfixPTKRGmpYKsBW6mT6d5hwWya71c9isTdaTRaaBtg7SmGiT
 7fFPyooAyZFAYMDkVzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038
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

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> mdp4_kms_init() returns straight away when one of its steps fails and
> lets the ->destroy() callback, which the caller runs afterwards, clean
> up. mdp4_destroy() however dereferences mdp4_kms->dev, which is only set
> after mdp_kms_init() has succeeded, so a failure there turns into a NULL
> pointer dereference. It also leaves the vdd regulator enabled.
> 
> Set mdp4_kms->dev before anything can fail, undo the steps which have
> completed, in the reverse order, and tell the caller not to run
> ->destroy() after a failed init. Fold the hardware setup, which can't
> fail, into mdp4_kms_init().
> 
> Fixes: 93c125e4ea98 ("drm/msm: don't tear down KMS twice when KMS init fails")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
