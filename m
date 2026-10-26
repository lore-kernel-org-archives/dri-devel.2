Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14017606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hYNzNYxN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e1sMEqgI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CC110ED6C;
	Mon, 26 Oct 2026 09:47:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F1510ED36
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:47:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xHYp1912000
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=; b=hYNzNYxNpZUjWKls
 QvHeOhnNOU2Nm+KKSGOdRsMeYRWFtGso4ZLfC5YrZ9wH6VCKfDVSxMyH0Uk9qE0t
 ggJU0bFUFTVsdpWtipYHDtwTmjtXNeSHCCqnCgrYwSc22hB8u0HXH8FFbW9/A5xv
 qPQh2h36K81i2Bxd2AHk4v1W/RI861Olho2RfSPngTiHfaUsDqWAeCtZBMcKEdTO
 3qM/nZtdagc1K2TlsQmg1eJvC+l2scyn5DUbbCMKzJO+y1rWuKEWHkd6cNblT3vP
 ME9ZRLZHWFuI+Tadro4UdwyrGDD4+H4Sk+s/PZz1SXmRoQTKmpfC9QLeevokoGEl
 1uYiqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u605pt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:47:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc50fb0d2so44380785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008053; x=1793612853;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=;
 b=e1sMEqgIC+3MRPZNAF1oUB8AJ+OPiO23yg02EQ4aNq5PElYp2VGg/Jdqkrjr+b++Pg
 IWTCETsPdMMSPqKRax2XUY1mcqDjbuGn/I8AGO14hlxhnJGYxEclAeKtT1FAPWf1/gOv
 5L+48bwPzxFVcVamG1N7Dos5l+6vnxtAwXyhjuXW2ZyqO9Gcak7+N5pLXm9WiEaH8IjP
 iaIuvm/eXs/MgOH4K14dj1tlZgVbKhiqLYVQFnI/fOfRvaezh2lxGyQL8kLnw/5BWIvO
 vMlpr9NSlUiKEGys6J2JqgUypL4Ena+ByVIg7sQO5oaAHShyiQMWpIP6hdfUKe50YSgv
 gHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008053; x=1793612853;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=;
 b=n6k956G6frXy8egWzU+z2FwLsTWNiEA+v3Qkd/gJEC38dtaiw+Z6QQ2MqHVzF/r9fU
 09LbrPeo97qCcF8kjUPUdORJFrpLcDrtSDtJowUnoDyCAywUOA30MMMzH52rgLMU43hy
 jcfw27nfM8a2FcAZZ3/ixdSg9sgAic0cmyA2jMSIbeXsZyNT93d08i1FkIKqgYyJrx+J
 Sbqce1NvqE4S02CddAnhlFWpmeDKNfSTR2MCGK9yuSt2yw6djBAiy12E00zjrrljtwBs
 I/xJI0wZZzdDQYzdSjHifXOWqONVOI25t+Ykl0kCHEIuFPLht83so6r52C47+yrN3Xx9
 2Cog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmYiR/p6+Yyyu/Po8PvxZRQx6kjMHfIRT4EKWwErJYMD5SXctpg+ozaB7Z/ouORf3mf3DRfhbUzIg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZhbscBXxxQjtcr/Tx6pW8IrYDeLdk8nKN5iJKd+bOOrhi6NpY
 Hy3ih9kLSw4UsvcpCR9PrjvTlLMmCT2/b0qYeRadR4DotlSpFzLsOb5GL9U7faIB149dwJc/ekt
 uJsHGDskuqIKuBIkpxJNVY/Gf4ys31eCd+hOLY5zkXtlvo7okIkxGiJRNOICYqE40XFXEXIo=
X-Gm-Gg: AYBFou1wsARk9fCw2u5YcJANgqe5gOxEm2ehXk0hAws5m+pD+DbcYkHCW2pfrxLA0Ea
 bWVK/4FqlFo9974/7qyySOH03sWJuOc1Ah2SOc4XPW/UJtHsbKzM1Hy3BTqr3AudUVYINPsnF85
 FkvbJ+iChogyPGf7/8UBjSSg7U2m4N2u0qf4jlSO5rr+u/jR9VA68OsPz3oDNVKGQXOin6FmAAE
 0+4lrNKaBKeTso8Qo5da1EX6iIqnBsHIKt+qxDQv2s9Y5L/OmhWG+IM6TIr3aVtJB6dM3oPBnXk
 uHPFiqfHSW89JWyb+Bqfs6ptmqm3RNi5g/vuyo8Bds3GoafsC/KHewpZfYnWFrib6oG0ASofgTb
 gA0B9mn6sC1jhz6cUDbSyGQ==
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr1009173785a.3.1793008052857; 
 Mon, 26 Oct 2026 02:47:32 -0700 (PDT)
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr1009170885a.3.1793008052401; 
 Mon, 26 Oct 2026 02:47:32 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8b6sm295595766b.48.2026.10.26.02.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:47:31 -0700 (PDT)
Message-ID: <48d378b8-ca15-4e80-9c99-d4610f6657fb@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:47:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Fix GMU shutdown idle check
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
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JWBI6hDW2SPMtomrqbJxnn__AyPLE4vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX+GecZ4R/5qiW
 GAvPmhj5Z4xUm/SyDxNlv+Q+YIkX1BSr5IUYOtN03hFx4YEC2kZ5toEkYYKWZw9UuF04WAW3+Ju
 pITe+SY+ITrMGYbUGrneb9BPYqwvt7Cu0ZZ52VugqUqW1cR0gpOhj5Ys6Aw+4UsS9atwk91poet
 HJqijhIj8d2CByWy+xJNmPUuFrpN2nP3Eu2hxw0FwfW6wdrCbZoNi3MwVYZksObtvHE5jyixvl0
 HcNX61dx7Ujtx5224rODyXJ5C0g9ABGA0boCDIHtUdMrkTZWKB5LoWvSbUL1l/69qu9YyoRejpV
 LgCL/ZL1xfAmjN7a6F7rv+pW7Ok3M8zibmOqnLYtTP2qSgNGMhejN8vmBdQHtFDWEMKsSQnjB2D
 ES1jw0FXHTft7CuNm2tQFd7V52gJ5rWRyzuAw9vjkV67FiwC6MYIcNlHaSbfm6wuyET6BZpjQPG
 4CpzFPzFzjXkjSpN9Kw==
X-Proofpoint-ORIG-GUID: JWBI6hDW2SPMtomrqbJxnn__AyPLE4vw
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf21b5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX9HWq5RE6ZE7m
 6A3sccv/SXdsI/cdIHijrDvl28OeQM8L9J/vBA5Ms28LB4p5N/XYeFgOLODCuQ1jqRoVUtuwYuR
 VD7Bim8VvTNDh5puDWDlKYhMcgNGgXo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
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
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> GPUBUSYIGNAHB only indicates GPU hardware busy status and does not cover
> the whole GPU subsystem. Use CXGXCPUBUSYIGNAHB instead so GMU shutdown
> waits until CX/GX/CPU busy activity is cleared.
> 
> Also, increase the timeout to 100ms to match the downstream driver.
> 
> Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
