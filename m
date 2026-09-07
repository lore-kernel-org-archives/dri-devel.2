Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64203C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9508910E694;
	Mon,  7 Sep 2026 07:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPzDHuBs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ksQVNZ2C";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7839310E47B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:31:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6877NNFP333054
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 07:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ub8FEJScFDDLe+jCWLvPZ6YRZ1bKlayVREYrYiZMyY8=; b=UPzDHuBsdZ/AU7BB
 s2Jf/q0+Sc60c7+j7Z2JdaW93vdzrGN09uxW+pFFT8rRBpTiVgU2LZTpipenqiMP
 oCDA5/EQW/srShamluwOSbjphyKxblC3oF7pQLc8n3zbLC2dtim1XRDmY9fl1Obs
 zsm6KnS7Ebxg6YNV03jV3P9SCoErRBI44OC4/kCbZHG9iReov6Fwi+IlanRFXYZZ
 iyqoB5FuODUWIM+N0tNtgYU3a5wAeA44jJam9aUzyrQ46GoIfHhtwrYJBC+eMknq
 cmn3MSzkr5ZK1fiCba+Xkb3xqBRul82342C7BcYxORJXqjZmDKKmtt/PuQvweqtc
 65TLYw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua84sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:31:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ff0dbeaabso2519311cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788766264; x=1789371064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ub8FEJScFDDLe+jCWLvPZ6YRZ1bKlayVREYrYiZMyY8=;
 b=ksQVNZ2C3FczSyHFHasFzWRdM4LYm0q/k2kKoNjxIgK4HMmY+HXZO1P7d3rsipSNm+
 /eVtL0jd6jJYkn+3L4wuqp2cNUelGp57SpmXxAu2XYU+Wa172mqRSITVZcDMoZY58npV
 Z+WZWBih7mMBc6CFaJ4+rYpVO0EI51S8JLFz5gaEwYptIaphUEdfEokq8tcjXI/+IHXI
 5umE2bgTPNgQeCNW+Jndd+ZXsh/mH+5JZprRjpZtoPgmk7l5hlPNs7qTVur5u8mOeWqG
 RdD/f6CAoKlxYmtTshp0iQv7OkOCNpspSB+o2LI46xVbGcKALQbKise3vc8KqMTLP5vh
 EkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766264; x=1789371064;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ub8FEJScFDDLe+jCWLvPZ6YRZ1bKlayVREYrYiZMyY8=;
 b=lJkvNNd3o1VgJ0b70s5TDtjEKnlQ/Ddzs4uFuy4elzFB1Pj7/LxRFJkp7uAy00ETxP
 5SHAT3MEatzdQh/sV8ZFcuIz7dQj0lH5JLfbxQStwW7sXYSsod7X71hymXI8gMHwabZh
 tMJOI7bI+QtOu0I/N4q+qLkz0qmER0gFzws/Q+UffZRZZGqDFLcgJP2kOybq1/WOKmc0
 vy9tvDXDJ0zvCgF1jGJwGOuQm/Yt8bmwaKyUp10x8thF2UM3XpSwDru7X8j6+W46X0hN
 o4wT3z9LM2qUi9bOZzkCZSjN+AyUkTO/mhnVWwjSCCs68kkse3LwL3t8EhSk03sNCr62
 OmHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHp1m+2IdguRLl+ymJQvk78lTTq8BEqmEkAu8w13z7kBeWOH1fC+zpJlnTQbZoTwtR9USUoJ9LkaU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwgKti3w17GnX+YCWai8VLXVYFK/3mOekr9lSby2QCKfeTkUs/
 Mn/dE7AXSSr3awhUM3IpFmIHnWtJ5nOL8odplQJWn/eh7C1Oex145L5PyUCpBJrpff6/9VoGX/7
 W4hg0z1QSBpJ+qLV3+sUcV0yig13DpwaMhsE82piD5Q0TwmccDYzO9wmBoOty8letl7LMd4g=
X-Gm-Gg: AYBFou0Toi//17vakD37b+DMc6shQ+qYY+CKQbh0ggSLQkBM+xAq//aL7Hskxv2Lc1v
 0Zgaef1Wx/JrZTY4H5M/Wbul1SoLW+ooJ2Mf3Qp0SHQDv9MeQKrzGT9lQ5VY80L3WpmhZFKjV6g
 zPBHqux70Y9JCWv4iS5J/wvjJwIrjBqbrAWbym1qOyKetsWtf54fMhugATHzhO4kBCWEDWLr5Iv
 vUMWNlQqauJ40R4bgD1Lo5V8riOe/lukOyV8UH07cyoCLUtkkGlEWDqkuYDzerEJX3Whh9FxOEX
 Az7udzbWQlFpIrfxS4iznJJdlmlvcHIR4gi4nKpq3+ZQ2Hc80bqXKeqBQteFts9Y2iBxo96PtOB
 rrFFEhot0GkjgkAVKGI92eg==
X-Received: by 2002:a05:620a:628e:b0:939:8b89:5076 with SMTP id
 af79cd13be357-939916c18a0mr1150649385a.1.1788766263953; 
 Mon, 07 Sep 2026 00:31:03 -0700 (PDT)
X-Received: by 2002:a05:620a:628e:b0:939:8b89:5076 with SMTP id
 af79cd13be357-939916c18a0mr1150645885a.1.1788766263535; 
 Mon, 07 Sep 2026 00:31:03 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d6e1c93sm428217766b.63.2026.09.07.00.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:31:02 -0700 (PDT)
Message-ID: <ffd50f94-69ff-49e6-a7d7-3a7c83d2d50d@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Fix the skip_gpu parameter description
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260906170301.2393-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260906170301.2393-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Lkj0bEOCM-JLf7VQA747WA5tyDlb34Rc
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e683e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5ybYm7-rvbIEH7tdHsYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Lkj0bEOCM-JLf7VQA747WA5tyDlb34Rc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX9lIToaaOFqK8
 BkwAyuhrtQZOgmv3z9Mos2tcTHQIWqnWxOi/Mpx8aWeqcsASgIQBXk3kZ0PYjt97TVHKUJEAj0V
 azc7u3yrPTNk98ItnVQIxyT7BqlaRlI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX6R/uGojKutEC
 8nRKWwEsVs/f9flQ1PnBbvHvdRDQH8tMhdjxfw47f28RtEqGPMXIcVP/MrYlZFj578QXXo2iLl1
 a3xcAuwjl1ROibdRYVBtUEmKYz/Dxn++4WckYGJb5KJh1j+TbOr/aPs1EkaJU1BWOw+7EnXHcwI
 Eek0LQ3XXH/MQ16InWDPCpsFmYwGqFgQ0cQetM28Tz5D7eQZyJGWdzO8LudjS/Cf/CwIssMayBI
 PHS9ppt4zY0QD8gVTV4M58/K/UoWhcU1fU5Tm3N9reLmdwRnilwbKd2D6ENVGIHNnRY3EEXettM
 atSVAMIsJoiTTdZ4JgiyWkOpRF0TZiGciQbN75DVye4NSkjzCvfkO+XXsHsKsuvR2IBpNVeipy1
 2FVdaypeXljLEbYtF0/9/SY7V8e9TfRnYm33rIW1Ab9RbDfrf7+6UJxLHz41tjbBp3vV3+WiCt6
 9FEkkSoMfeJgqVja9SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070080
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

On 9/6/26 7:03 PM, Karl Mehltretter wrote:
> The module parameter is skip_gpu, but its MODULE_PARM_DESC() names
> no_gpu, so modinfo describes a parameter that does not exist and shows
> no description for the real one.
> 
> Use the parameter name in the description.
> 
> Fixes: 3f17991488af ("drm/msm/adreno: Add a modparam to skip GPU")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
