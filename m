Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785A0CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C398D10E397;
	Mon, 25 May 2026 14:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nT4JzVwX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="byswGyry";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D156710E397
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:04:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7c2rR1889308
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j83G7OBZi5YQwGrAtApyl0NYyFzj1V7Sk8Xmu26hFNA=; b=nT4JzVwX3bXdYDBn
 S/SpFHumX6xrvglOTeBEafIMlMStUexPJfWo1SV8ND6qsohhGmne0q7AGPLKJJ/6
 0TFAVV6YRXrfSt9C6dS8U5RtB18ED+QjP+YKBSIzifWEqQA+vxXvv86RVFxj5nex
 RU5cZaD3phWpP0Mu29rmL0fqchVLztx2GwXaJkxQNoo3RfN9BrdfxDqMLoA08vS1
 9G1dCa8F9nmZXYsW5ekXwt1wh/7MsQDK2qW0DosAU9Vh1vxYPfCWBQoMmRmTT1Oe
 mIFDaXKEC0KWBlaIJ1mGPf/qx42DdtZYRoX+4+hS+f35wzCIFrLaqK18uwrc1AW5
 ylDF9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0x4cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:04:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914b8fd12aeso53050985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779717848; x=1780322648;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j83G7OBZi5YQwGrAtApyl0NYyFzj1V7Sk8Xmu26hFNA=;
 b=byswGyryEUYAzYqccbT+H7bi0AFreqs6ZyC8EB6vY3RoNQZmdDURkO0w8nWN38Bxxh
 LFyv/5gyK88ezgC4oP4rN2W9OQ1KYXb0V9BYlxHhHo+rP4GIgWWdxYj9rYrgua/8sQ7t
 yiBLqMwDnHHDdJwoDx0XIx2b2wxmZWXA0fkHfkVosXn11uAGp77Yc58LaUT7zGXFDlNX
 /wMqjUyDwAW8CleeuhsEQEVKMplak4WqMaTT/3OwNRjvLXxql3Yl813Jhril7VeG0a0D
 7I0BtiWza7YI2cU/eC4dLwiWkp4Ttw4Kx2hNIChorsaOR8MDZqESvPx1tj3koKr/oLHV
 KT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717848; x=1780322648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j83G7OBZi5YQwGrAtApyl0NYyFzj1V7Sk8Xmu26hFNA=;
 b=febUA0hXvMWomi0kKdNU9o6GspLAHRvSBI9kGogRFmfz4DE5IvySHqsTO26XY62KVl
 /0t4fCgjCwCyjCi+qN4SpCBdook+0YqSgl5RSkT4QBVJnaBbbSjFMgEHk0V2H+dXosSE
 sZopTyYXFjumqj4BenKTXIgxdw0F30JAeFTuSfLZqsiTv3c/y1YjIv2mcFFs29V0i+kl
 LkMFpk8g/bWKd9wnx7dkJKf73ZI9/MpRoInLmpIMvJUc9DdXt+kuLLcQ2SL5qXbOdBD9
 NiCdQwCR+kh6lr/YF17IRq/WTjUwSjbEiPADyWzCtGV9Uyb+a53ne9vAWbOH08jOTTLL
 Ti5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GpmVkj+e8sNKSNuIov+olFZ/FnxnJYucMe49ya0LLS04NT2Yob69KhFrSFnuCev7elx6qypqqrz8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzR9VatGyyfSqaBTGgiPi0VN1oj0Jqpj5mKMgavZciYNwgchB72
 QnyUP3Pu66iidTZuFi2FNqAeHA5OVWnwwnEPr8URFoPYB+FjWNff6qrxiPSGyUycf928gOgnk03
 pvNs7jLfNY57e0scRW9czwwDduMHeJKROmmQaxI3sjUShX1x0/IQ+8sjbGTfutEN5uJrx+8w=
X-Gm-Gg: Acq92OFI9E01uNreSBSbGH62U4fO3f7oGp7fQm87udBTJo9/nDYNTUcRt0evIM7OwPE
 28Fgx/9KhvC+2feEGlmylwIL8CqUqIhMcbbZCYInDG5HA7PwgKvKYmaLkUjvLEI4ox+eDoqh0Aj
 ZnRgeEJ3Q4BjxIECni9mVTatPxcRIUL4XoEGGITQdmlVag7a8KR3GabQyCo8hzGYXgMsdH3Ruii
 1HOOh2gYItRYLwCX6NPUKGnTGdnKmkIhlF+NjTAEstxY1bmaoaK9jyn814k8Nr7FO/xK+YLH2nD
 mw8SVakDZQK/oaSubwcfO0ItFpmV5Bqx+0XZmGWmciG5jiR+lElETJ9Q0aJ+5+d8In4GSrLqNFz
 r3oLW6Cgthn49JQnzr/fC3h4DglhdqTQpYBH3eTmsq1zdqg==
X-Received: by 2002:a05:620a:4494:b0:912:38a1:1273 with SMTP id
 af79cd13be357-914b48c0d3cmr1405937385a.1.1779717819428; 
 Mon, 25 May 2026 07:03:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:912:38a1:1273 with SMTP id
 af79cd13be357-914b48c0d3cmr1405771785a.1.1779717738422; 
 Mon, 25 May 2026 07:02:18 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdfda7f3bbasm209718166b.28.2026.05.25.07.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 07:02:17 -0700 (PDT)
Message-ID: <5d6a60f1-0f3e-477a-87b1-dc7b2393f08f@oss.qualcomm.com>
Date: Mon, 25 May 2026 16:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] drm/msm/dp: clear EDID on display unplug
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
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-10-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-10-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TpI-vQZVX0CObniAzJcf6D27IfyuDQV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE0NCBTYWx0ZWRfX5Y9CgxovQ9KE
 CNHh/22988ODGRfXgEvddu1iqhBKNFhPrEsRNGvP2BRZzL4Jrkna6iD62MbRd0LAjlZEqPjrTTF
 9+13OLCsC9PdGvVq0uw0bG3q6cK0gSZDWXbdZ2ZoF6Fd2pv/i/bHXXFjq4FOqwUB28SYlWaLf09
 XuaNFTKfoIWkJw+r8r/CCuOUsZJ3dJzaq60rbuPdC2gr19DKoFZJE5RxH+JQAS+b8egTC7683rI
 12/1v3hg5PvDIfcn+0PBsrQMvEYdUs8UPkeMT2PoBqGqajfAGA+Mi6K98Vag/2RMfr/sWYykcLx
 ZuijGnOxOfvAFjiAEuCmiPBKvby5gvoFtdld0tvB/gQjsw1PG1SC+S5exc2xXvjwWt2oAk6Pg27
 LAYxCfQQ/QLrbkVQYTrsXGQ/kTCJMhCWEewGTEeZdcai6vfp8ksSXJDdJ+N8T9LHKPgL0UbtM29
 oU9gb1csSl9GccHxgrA==
X-Proofpoint-GUID: TpI-vQZVX0CObniAzJcf6D27IfyuDQV2
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a1456d9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=gi8-7LNsYNYCFf7QGhAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250144
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
> Currently the driver only updates the EDID when it detects a connected
> monitor, which results in the connector still listing outdated modes
> even after the display is unplugged. Set connector's EDID to NULL on
> unplug to clear the list of modes.
> 
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
