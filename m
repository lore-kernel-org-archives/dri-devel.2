Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A434CC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CF710F511;
	Thu,  3 Sep 2026 11:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGOhIpdz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pn2BG8YJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACEA10F511
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:03:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHEbJ162892
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 11:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CrS7dfh8VoX5AtGoISGosKA0+Y3IZxb5P0ICAJUvtHs=; b=aGOhIpdzvRQAqchU
 uG9DfyXvtVH98FaRuHRzZWhEO1VCYLDh563aE6VeoMTiMJSvWFyMvYKS8MLNngnW
 OlokO+amiETSFus8MJ6UtAYU9ljWwHg3SGUqTICF0Dx2jE9hJySSCApA1zfYT7aA
 CwHS/qIJ5X6gaDBiQ7ONxHwOaJaShf1wiSwHl+yn9nq+MHP1f5YhoLc1Xkj0/nK1
 RMPvixn5WIY+282rMOm7E7+FWprt9+0rWOGIdJ/IeVTyXvGW/eLzjhqsEHiBDLJU
 tMZHNZL0W97lfKZCX9Qw5huVToQA2sS6XzlPP9tCoIOz0q1366izrhK1n/K3e8tx
 jMTq9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx071x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:03:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9390ca1a9abso358398585a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788433381; x=1789038181;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrS7dfh8VoX5AtGoISGosKA0+Y3IZxb5P0ICAJUvtHs=;
 b=Pn2BG8YJTfL00/KFXuaEoKNqlArjygZ6DaAVpEhasORqvGfuWhXET2XJB3fTvevzHI
 UGB/fQkmCKEhygpeprSW6YBFPjPY2kTqt7vWVa3xfWDk+f1FuNuiFGVRAYB5d6Eqsj4y
 FnE2m8JyAuv1ReN9/3VRrwTmtEL9wj2V6jIUve94sYC27aOPvvdZ22wZpXfWbsi/p1Ub
 jAgAW8YTFiSkmrpv93Xe8fy/2OrbVw6agKkJ82AEr8ykWL63Vg2CGyJJi2lLXz9r+5Yk
 LmYmamnPH3avgDOhwxkICpLwYCXonVnr4q/r900GyC7TKKlZ5FUE7dXh2LaAGSRA/imZ
 Lm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788433381; x=1789038181;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrS7dfh8VoX5AtGoISGosKA0+Y3IZxb5P0ICAJUvtHs=;
 b=SqMYgeZUJNs8xXrsUV+vNW/spO9J4GEfuhg8Bof5+IwZ0IkrHw5hwoVLN1ywoESHDB
 lpQklH9vdmVs8C9cy/F7meI8T+a8eksmIfpCuAEQpVMk2zMMpDhC2zQvsXWdFgYOOhSw
 /OVTjBFAqWfAc+ASj4U3GlN8IeqBatdjyhZcAtLsuTUyEHsv+teOtKcgHdJk+ply4np7
 XKh/N4BkVwmvqiJ4aXg6mLweRHbnCdKzNeKemsWJbis3wkBoosLRO3NuVMN8hNSGkWAI
 dx7gKKSzGWlKTy416ebgMjmDRUn/3iggb1WZUPNPx/x3NpnCgRkM5lvpLegzjbNdoubG
 buzQ==
X-Gm-Message-State: AFuF++kLgGeq9iOUnLPIhG8E3PoQhA0KI1Z4aHLcGeOVLm5IgpoX3jeN
 UhrvmgrsO8Z8f6g/DYhvdqWD2bGhVrTnmG5w0NIe9B4IN2YX+ZM1b8BRmb9xS2lkIs3WWEyV9ZM
 m+xhg4nK4aXH/ltwz1Yzbxl8q0ZSVhWimJP3T2P44jttU3OLT5qeTx26Yo7MmgCsr70U90XBBEt
 LhdXA=
X-Gm-Gg: AYBFou1CAK1zq6Jcrd6b4Wavrj+V4XT3a92U9W78MicfVUXXPt2pTeBnpj5tgRJ/HaA
 +SuEUQl4dLY65SkeTya2B2U88CcQ9P9DvQTMmAl7QxxrGMvu8Ui3dmMLBT3fx5EOkwzVNLHMXaT
 vJPvPWnlOtbXIxAPFe97eF15HeTfwQgTAt+yJt+uqhwHRIEPiicg82QrKQ1bi+NJSoWpW1UsNOW
 Sfv5FVJQLLZS9FEtzXe4YSbYcvNwKmo6o0xbeoogWNKd+5iht0Mqtv4fKFAf7ex0GB9DK8OnlaL
 6C0oniLjqRzFJYqZvvDNC+3U5bzg5tvcfEm6CtYeVDv1TJrgkAza5+x1kAntg9GlDuKQnkoJfKn
 FQMscTrTK9Nuas4KLbgsi94Xhaqbg
X-Received: by 2002:a05:620a:ec4:b0:939:6df9:6547 with SMTP id
 af79cd13be357-9396df968e6mr417344185a.51.1788433380894; 
 Thu, 03 Sep 2026 04:03:00 -0700 (PDT)
X-Received: by 2002:a05:620a:ec4:b0:939:6df9:6547 with SMTP id
 af79cd13be357-9396df968e6mr417336785a.51.1788433380378; 
 Thu, 03 Sep 2026 04:03:00 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12046355f8f.19.2026.09.03.04.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:02:59 -0700 (PDT)
Message-ID: <de3e9d23-c55f-497c-9d82-caca692d2f66@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte
 clock
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260903105241.41C2A1F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903105241.41C2A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tmbxjazPzJyycrKXByUviM_VLpHIw7rL
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a9953e5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=rgpvN1PqdaeCXe83_U4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: tmbxjazPzJyycrKXByUviM_VLpHIw7rL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfX7nT2kDbP6eD4
 LhCagKlpl7ZcgsJqkrCAJ9Ew0x6qTp96rWTOR5rm97h4a6ttYFGjlNfwr8sqvloXVE16CJKH/hK
 ijsSaiHWbJ+tPW0JF/w77J24oTfhJ5QSuwjbJAIrglwmudlL0LeuEQE86+Rs/y24587TbpFD1hB
 ooQj3FgOoQBTC7tjdZ68z9JAGOP6dppGurxYdGgFXJ81YkTyRnD8boTTR9sXmLIz60mesFwpxuU
 oX4ubX8RnqWTAbtzc8+Mufhvgz0zuoYRBe0sKzpfDIxrrYaLDLjHkZAlzRjPyShEwdH44ugqn/L
 7q0X3Jm8vslC45DgyRf669yCOzMdwFNAWagOotJ8p4UdpOo40mIn5s3WatcM9q07645tlvq5t5r
 2/CR4Y+9atxF26URq6dZAOsC+YQ1QfbiVVrdx0kWQgqA4dNmpAa6gEbT0/lX20SdyQyWRuxOrs7
 AFwbonabjckGaDqEueQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfX/RY89G/zEaF4
 S75vt4ilS7IBAPO7YtHvHr/piqD7GlJkM9vP7+FFYanuQZIYBzRnox94TIRcKf4uwuCT3qLHipf
 5FUystGll1tlolYBPJ9Beu7RE0NvFjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030096
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

On 03/09/2026 12:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Reverting commit 6cd33b6f4155 directly reintroduces a panel scanout glitch on MSM8916 and similar older platforms during runtime DCS commands.

Obviously. The problem should be fixed other way, not by introducing
incorrect clock rate rounding breaking other platforms.

That commit introduced regression so it gets reverted till authors come
with proper solution, for example.


Best regards,
Krzysztof
