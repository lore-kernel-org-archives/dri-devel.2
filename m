Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIpHX3Da;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fb2Jo+9I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA4910ECFD;
	Mon, 26 Oct 2026 09:19:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0610ED00
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b2QV2806372
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4mPhZDRt9QlLUW4y6TN1ZMTZKVwC2eRdbQhQ0HjWnJg=; b=cIpHX3Da9S+jSWxY
 RilXb0nVvMKz/goG/S3rI5SZ7QrT6mo0KtNff+tblgqr0tnSrN7wJcRjU1fwhdfY
 khWQ8UCJCLaK/cp2wUYk9Sa5sUhCwFKvQfed4h3U9GhdYuo5Qg296Coe+TxwCrxK
 wjIV9dwknhWvm5HJBZGz9GTS26Z9bJj+o0NlMP44p2hdoHj2WGQEj2iMzs1+b8na
 gQK0j01Gn2ZXEty65PaqqeiICLewMfsssm56Z4JgX2bvQflon+2vkKltJVSzt915
 eNZ3vPfgBi05dUMwDrRi1eBWnPRiQu7SqpMBKKv1bf4K4XfaSyHM/XmLq2BwYXPi
 0LWItA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xnr5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c5ffce3f4so2573496d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006360; x=1793611160;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4mPhZDRt9QlLUW4y6TN1ZMTZKVwC2eRdbQhQ0HjWnJg=;
 b=fb2Jo+9ISz4VGLvcV1sdqVkHKTRsoyemBbClFkschJInJUKf/GxBiGPyn7HObAFA4y
 3MQuiTolH93Er0n6BFHZtWFeZVu2yy7c6SiPy9lj3ivzD/MxXlnWSPSRQ1XQJFjMEQ9N
 Sx8yFp9rSy0OsK7RXvVpYnAoOxLfhz0vxO5GZhDJr0XpbNFE3UiwRDb9wjZ/ftii480y
 FtegaIIvuKHpvy1pYuG2erOgkVTCRRPQFct6Lb1Gz94S5O4YYL3A/0/UeKgF38ntz2Cz
 Nqgsw7pQjpQBXZ7whrkyLqHGQek3eEM+0hc6++ztpia4ZN1tPbaDXd/cnDqYJrn3YXKT
 7QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006360; x=1793611160;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4mPhZDRt9QlLUW4y6TN1ZMTZKVwC2eRdbQhQ0HjWnJg=;
 b=JetaEu6F56xVGYLHTHHbvE8ZoHzROzpVEgdp7yfg6TfryJUexn0STmpZsAmwUGFiD+
 0KFSqmT4YmRklIs+Kw4UXvaSLIh+RRo11dvd1bv44Q7t0lHIKBASAU6nclnu9OyoEKPW
 PTCbzBWkdRQ/YsiCsu9Qqn7LGnaOFNrg/5pe3VY+b0i+ezdPjFUgl2kSUJIiJOoKBVkj
 Bp1r4SwOYo+24otDgDl8zBbHfPORe8BC5r6lWlHOLTd5MTe/cKc9ocmrDeJbwZGATQtc
 R1Ee/OH9sOlqAh1EqHNpBET6hndZ+sAjmo0aTqS/APDA2b0XsXAIjY8XuP0cFQ4QquTm
 rAEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK/Y7vm2x1oo8ZVGeCdSAenz94BNSVIryyB4XZ5jrp7TzE9/ogQAQn3Ai0x4GmEGvAZ2aKTFfXZgg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISn+V9Qq7x4nvi/LT5HuKvdk1Lfer9/vEfMMek1B6vnc62onGe
 hbwlybG1RTCvg0erUufoJg9145rs1Wit6xdg5mIbB91bkS5IlalGd4wtERKstsNTYn7iL4uC4h3
 WIIyy1fRe2k1191fw/qQ0p2whU70I+3At78RzhyLLKEIA1It4J55IozD8i3e3sn5r6FmHk4o=
X-Gm-Gg: AYBFou18wqiG8GMzTlPqdCCOiir7UjrznbqnZrCjczB4VeuWpv9+ny01ObQnQvmYpPq
 M5QOjTIGnnVHwsya8FQaopqvNK0biOQvE3iwTihAHRVcHEWby9LZMc81pIZcKw0IFHX1yFZ89sl
 tVzOa589LVUTAU3i2lsf25fmeMOHkTWlv8LwqC/tT+T1k7Q4Np+8C/HGPMHdmY6H9LYX89182+t
 FWeUknp+NUl69+gJO3HJpDw9ymNNW+1lRMaGlFOjuVQv3AEoTaoLW9brjkp1HmLHKi2k6NZiATK
 M8kkOxbpLZwNuuTTys7zLO6VBY4qhYJ9B64Dq8Kg/L3s46IoDdgzWWXKA1tH1SgSSeX+QigsTxh
 lBfiN0bOZLfCD+ZFhH+orcA==
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr885091585a.3.1793006359733; 
 Mon, 26 Oct 2026 02:19:19 -0700 (PDT)
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr885088485a.3.1793006359301; 
 Mon, 26 Oct 2026 02:19:19 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f95csm299862866b.5.2026.10.26.02.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:19:18 -0700 (PDT)
Message-ID: <dcf8619a-29c6-4ec7-bb98-fc9dc705b064@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:19:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] drm/ci: mark pixel-format tests as passing on
 SC7180
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-10-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-10-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1ZIVoGGBsYPvZ9Un_SKHZ_Z3fagvPMzW
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adf1b18 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FX_9VyN8hJSf147S1HYA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX+dr7NOABIpt4
 Z4znlvyIVr4+aowYO00+6ozyvnt7hLjbgBeNMiZOgOHF/UktyMABKvqh6ICGDZITOlAGUZlWNml
 tGXRNk/KCzDcGNjurFqhIORkXpuMnvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfXxeS5AuBguKyB
 M8vwtk5lqjm48teKUNERx6zQrLqR/pPeQPfwZsRWUSb+oHkXqeSClnj09zYQLLipy/u0pqT6PPl
 qgO6kie7R7D39f53/xY9xICLa0V59WoAwpDhfTar+lILV4xbw5I9J1gstI9SXUrUMiKLT7XET2X
 9MDD3RK3ahQ+BWZeVsVOr8oXU0gIg7vOQWQJj2V7xOVdoksOLRM6Pl0DBSBXMsj1dulFPeZxfnN
 mf8cVVdB4z9wkVmDc4jfE44lVq4S2EVc53YQF5iPDYbCRU1RooeNUnpnXzoFXEyth5lGDKEdhmf
 HBPEQRQibIUHXZIbgltvq2/ehXKn4CYsXCHvm61MFtEtbx+/9DZmin8znRMJ7KU5J3qOmeiYCip
 k+MGUy2ZiV+kQCZ/iR7c9tMGCsCBJZgy1l+M0cxB16fBliuTtw/RH1x5ROaIn02tETaC357BfVm
 H8KLta1Z9vMmB4ae9+g==
X-Proofpoint-ORIG-GUID: 1ZIVoGGBsYPvZ9Un_SKHZ_Z3fagvPMzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260036
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

On 10/24/26 1:25 AM, Dmitry Baryshkov wrote:
> kms_plane@pixel-format and kms_plane@pixel-format-source-clamping timed out
> waiting for the first CRC once the test had set a legacy gamma LUT.  They
> pass since "drm/msm/dpu: only reassign resources when the encoder is
> reprogrammed", so drop them from the expected failures.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
