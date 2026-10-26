Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19C606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NxyqMdmK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LclaumL8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414F010ED4A;
	Mon, 26 Oct 2026 09:46:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88E7210ED36
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:46:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aP7a3300568
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=; b=NxyqMdmKoVvfLMeO
 s40Z+fdjqNzuH4HzMnn20HG0ND+xaBGNFrCcuouUvBGONCTVF41j+iPQgVk4k5ni
 5gni8uuNjA9QSJJKKacl1iHxQXdebwkrcxMuMHfGjOlfMvKlAsPK2WpYclqnv/Rq
 6akED298mhKi16QeS5bvtYd77+kY5gz5AuS0sZMXNXLTWa8fYdLZAej3tePbOYuS
 hgPyRE/iVSaNR9q7gpD6GkQRBlkz+Y0/ziLvRAS54Hz0QlnIFgxZFTbCggD1B+D2
 MpzEldAro2OZjDceWlLYrvHOqz4xfW+kxDI4NesTf1/5/PpznIJEOXVmbFV70xtu
 za0lrg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpssn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:46:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53635fe2335so2901141cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007985; x=1793612785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=;
 b=LclaumL8NsZmm4Wm0N28viv5YXbOIIVF0c7Mt9mkUPAEy+W5P0/40Xh5DiuDVHseTO
 CsiZ+G094qwCHG/J8rZIwMr94oyOy2t5B026+CvLrLONpo2g0ufZgmSHxgxvat20JDW8
 LPqzLssJ2RmoOM1+e4xvIA5tvS8gKd6/rUmKHMY3zrDLYVhORIofJhRIzqaQ5L9y1giJ
 NkmFft5Yac2hh2MgqHdGcks1TXeDVxh82VOQPTsp1AdOBWY6SvA67qafseEgETJEoaSe
 teHij1Ckj/xkwVMksGtlH3rM27w0An6C/VIxgHyaN0y6CR6vgRMyvRRnblqIt/d9eYfM
 3N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007985; x=1793612785;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=;
 b=YlefIrkL71+0suKFJDrDYfBW1pLVDMU8HAVPj7G5xHVxEL9k6iupswisqm+mJf721v
 +xmKcjTew9QK2tUb+bYENt7jtVCVwvLLmLWo0u91Bcn+4laWKjth9gvm69uSqKtQsP8X
 JBxKId3XFHCLbspB9kF6fK4rcL7rZG8OIGt530mNUioOA97KKuj3tsGs8wL1jJOxakhw
 T7lLi3FGeq+ifneWBn7i/ix9zUpnXBuHvqwiwZUeOhUmBRSXUROTjHSggKnC6m30AEYH
 PmvY2d40U+RAU+fFQMX28BVA+0zMVyPCJUvRCz6U5q+1yEMbU5nP5HoEjL47qUIZnd5Y
 Lycg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTg9+vaULUp4/tjzrZHxkQ/rTkIpHoqOjRi6i07eLqi+Vvj7iCfEMV6nSDdk/yG4SVb/OxXnq7Tt8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKu9rlpfs8GsxMSZ3moHMrL0iXT5mtH18maJW3IT3xS8zHoLQbr
 12E9Bo8YpYeHgKms4U7YV/WayaXH5BQtuLiK1enhqqYIA8SFJr5RR3D6IpjQiBGQdyPnDTSuT4a
 a6Mxj0SIe/Q1AiKAU+CYtSgYsOV8ve26qTlI+CdRKeHdgGtysZfVzbHhNq82FaOLgvdMj024=
X-Gm-Gg: AYBFou2COrb0htMyAA16o952B8fTTK5FPNkf2Mr5AjKnjMjgTQjMJkYR2KPk1UrbdFU
 WlMKEY9sR84yjLu60eeGE+M2yLGcGSUBHYyASVkh7g6CE8AVNvf8px1VT5xGYXTU2khGOwJRrKb
 2wiY/1tzJNJbOCTTptIBqpbdJj3BNvxX0TmdgSFp7okWpcwoorAoDEF16rPjq2LNaEIlu0f7IvM
 YzT874LFgbab4dAltUTuNcYuXGOR6YpdDpmQkgGuFrt4mkRWsF8irO2ZdRj7+viEY+zBUCEKlnd
 am1AzwrdaJ84YC6jNyT75X4fnqPDZGPwMaxJ/nkYDGsVJJ0aUzn6F+tTeFjiXR2acMgdCAHGOkJ
 Cd9kJXzaRAu14/7AAEoBgAg==
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-940ef915dc2mr1132232985a.4.1793007984971; 
 Mon, 26 Oct 2026 02:46:24 -0700 (PDT)
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-940ef915dc2mr1132230885a.4.1793007984572; 
 Mon, 26 Oct 2026 02:46:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650118sm301524966b.49.2026.10.26.02.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:46:23 -0700 (PDT)
Message-ID: <269610c6-5ace-4faf-aa44-6074074e0cb6@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:46:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/msm/a6xx: Check BX dependency vote index
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-1-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-1-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXzAwM3YllAxmd
 mDDtGMYLSRxaBeMYWM++gLwS8ahZj+PAbSwruwKSvQpOMNay3b3c/pZ6AvHtOWE3FpQdj4GgKXQ
 a7oVCx7HMbYWpJuRMeCxPggFwG4Jx6M=
X-Proofpoint-GUID: AbuuWC1nR9rgIwCrf3REE3Kvk_Jtc2UX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXz+b9qyQB0DP8
 OJXWz93/smhp8iAcjINco25H0G3Wsb9VMfwx5WnKQT919kYsJVKrNPWdhExGB74atFqiJWm++7S
 rwO9WSYbxnJE7B9qORiRF5YESZoZGL+m9oNPiMlt4uv5/DDnDSldU98If3/+PAV+Pkl9iY+hy57
 claDzI4rgcmI/cccygMGOCW7oLsiyTZR3JS6MGP7gaMce9cBTPvM8zLWgI53BveNZ6va2JlfXJ2
 WFdFXGovf0TtH9UCYaYH4T9c+8nsh3r/A+Bjlz077lGTJuyQfUtWr8IE55vXv0P1QoT+CbCPgnJ
 45lpzL/3ahqun9gBv0ySEa4s3CtaHS0MjZ83hAjGMyLmjdeyBijWzrICnboW1jZJeCMMCG6tQjg
 FD38XVFhC30h6ctOup/XU9Aht+0MUIH6k8QsuvmvosADd5OeLM0hFCCkPciiF27MOMFnBQD7S+H
 p2NBHjabBOfjqsPnRCw==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf2172 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=kjaib4mTrQJa5ucwwGQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: AbuuWC1nR9rgIwCrf3REE3Kvk_Jtc2UX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
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

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> a6xx_gmu_rpmh_arc_index() returns a signed error value. Check the result
> before passing it to FIELD_MODIFY(), which rejects a compiler-propagated
> negative value as too large for the field.
> 
> Fixes: 020b8eaa1db8 ("drm/msm/a6xx: Add BX rail support to GMU dependency votes")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610070334.bYvBJSpj-lkp@intel.com/
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
