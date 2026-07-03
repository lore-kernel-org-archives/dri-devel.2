Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D388C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1840810E5B4;
	Fri,  3 Jul 2026 09:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXm0VbVG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyBu5IW6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B2610F741
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:23:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rrUK3088182
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 09:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=; b=JXm0VbVGUgl1DN4v
 Aocpo2T7qOQBSC+5Dm7ZAjfcEVQEHjJysI4lzG5vHRl8gWBXW0SMBRLjabn+gzp1
 LmM2ZecDViXL9GOw51Up0vWPGMQZ+xesNb9YVItRlH0RlOxbEdJMI56p7jW3xbxL
 j9qmhgWsdArGlvMC2tq/pviwt23W5T9IH2u7ukReIIEoe/o/9YDhWnvocMpcxkm3
 H4LAv3SyQBDE+u8Y+4ayG1/Vw1kDaNj34nmnSCTBxe3TMDrL/QEtFZbRjPF9K1A8
 HNTL4grsDMXDOyXpSvjXSOSoIF5DRpI4mYJ2B3jlnDh1PwxqHEHewegGljBFN1Rm
 NrBtIA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s2549cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 09:23:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c80be91ea3so7180345ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783070601; x=1783675401;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=;
 b=LyBu5IW67J7C+4eWqzGnNEUCsIb8HOL2wdQgQZbFFx+UvEu9QSXX75ScXooyh+rNkg
 HjGUDq5A1vsX4kPkaG586msqvHDfxcWaCSEadG66kMcOAXahN+PV7MdXZDGbZv4CSnOF
 pDLajlToOT4vvl+Rlpq2sTwqolfQNacQEfv1TOsVqGZI+P90xeLXMm98x4nhZH81L8ck
 mC65HqACp+2nIykPVWmQLDtFUQLGANsj95b9XWO/ShsvHBkihdNjrGdvD4olNVKgTCEO
 3FwyEz+V8VM3XGs1s//HRxltjHsIu22G5Wx6sY24dIEeYBegpyjHGUu4gBn8aSe2Yvm4
 txSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070601; x=1783675401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=;
 b=e2jeIHbto/JfDZVeBqKjosyoGks2Pz89w4M72JblEr0eeeNKgq38fpBtjHxjvP4BD9
 ABJpeZCBqOWXlMLlTuu9QPdS1ghbGk7FPBy1EVQUlU3VapQ7P2xnFn6bVEGui82mcO80
 tQan/N4ksIBi4CiFY3VjMvoTGA/7ASR8AByzDMUlzDORRTCFmtxb1oSkDO8GLVZ5wpU8
 cTCIC+mHm9hD1gud6QeYPLcUpUJ9/XMa2C+I0xJvKXno0d8yqzw0QjsgQry2Gjcj5Z1S
 CKJcS67ng1yn9aFOZ2vbQomvTmp+3BsCdJr6KRi22deG8Wh56FWhTdCz49Ccph7Ry5Y0
 jnYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roxqg8ZJgbugRnKhrYQzzaE9SvmWuoxhc9xXWxw3TpHE5iy2pP6S8QK+7zfPLeReooFq1L8hxpPsSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzzxk15bp0W0U37PtqowtDeO9YZ/P0H/RpDLu+5cXu5oXD6U3ZK
 sksu4THrT1lkrBwfElSJ5DhNhnPc7RWm9ruKjUTRSwdYG0gyN5vjhw5Ft1+CS9oriy/sbbblw0J
 KZjYojQwSlSmUlKf2oiuuQxdnGkTAjfKgAieWeTQtLgvwzCYnPfW6xVAUDrERmfSvp+Yu294=
X-Gm-Gg: AfdE7cm0IRcMpY8M/efhf+zoqFKg6zTz8p0dJWhg4PafJ5OCJCddzY9HQJuHiyIJ9YY
 zwTgR144iAoizMceTajGQDufGoHN8JiTtEC/3khHVegfv9gLsNOxYovSd8wsrvxgz1GQVs7WpBQ
 Dwn5qK51xOXa+qv3+9YX6rHXl4oFsNuI1Q15ru4UiER3hSMEvKrwTeXZSzlc0u/4v+okDvdtHAC
 NuicY+UUGa0shpY2OP92dfONEik49bfZrpcvQq7qsCN8wjGw1IwrXK0IR32Aw5DFV/c0pvJoFDn
 x9B/Nej4XrJ2Mt12+wXgonAGKE2LfMZEj2w27L8a+jfhrgw9abLRuCKjSSj6hA8yBr2rN1Z0kDl
 96nX0fTuh+vFsG2n86XAj4pZrl4F4so2JL5ymujs=
X-Received: by 2002:a17:903:240a:b0:2c6:c9de:cd0e with SMTP id
 d9443c01a7336-2ca7e75afccmr103764015ad.23.1783070600759; 
 Fri, 03 Jul 2026 02:23:20 -0700 (PDT)
X-Received: by 2002:a17:903:240a:b0:2c6:c9de:cd0e with SMTP id
 d9443c01a7336-2ca7e75afccmr103763625ad.23.1783070600307; 
 Fri, 03 Jul 2026 02:23:20 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad789237bsm6382845ad.71.2026.07.03.02.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:23:19 -0700 (PDT)
Message-ID: <c72d2ac6-b1c8-4c96-a0c6-eafe18147ac0@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:53:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
 <0bbfd60c-236e-43e5-a150-93738961f3de@kernel.org>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <0bbfd60c-236e-43e5-a150-93738961f3de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a477f89 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=TT0SokwCUCox7tJrE_AA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: G_ghsbCM9kmT5X-hNWxelMuOZFuxqbpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfXyISvedHdUtfW
 gwRuRdzJ7CJnNX61HRsTWdKo+Pyv4Z8n5kQpRiULw6AGdtnkLufZ1V4/6fHb7DFdGGj7zz4k8vA
 mveVAPuQf4l7piyZRtIHq5uS6LEb16p9fxZ8l/etcIH8hyGiUek+ymlUhmz8UJ6j9xdTxYMLXCQ
 T2yYnsoJ66Ol+OlPfVWQ4L2Z640C8egRW7p9dkE5CSsZeghtbo5kzGZtPDxM9NaMOUmWlILkF7H
 Bq2ah5/0NRPhbgzbaxNhm7uqVESACRT/xDjJyihjExzftZ1XVsL+bNyHyehv2VN5LSHNaFuIKG2
 ErmOFHjM+CkRL0ENZerUAG+UlQ9jOu8aKi4d00xgwVrfi2qpgnoJMPs6LQwTjMtYBMovKpjH7ly
 1njLEmQPTb6DfSyi0STDiNkcwntZloEsO+7JlIxs+4n+IN8SxUobYSebeHD7JxMciHhjbkuoaDg
 8wgxvtNXVB/u1c3uX4A==
X-Proofpoint-GUID: G_ghsbCM9kmT5X-hNWxelMuOZFuxqbpY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX5bDRrT74Hpr2
 wMDlW00gVrQczwZavL8BpQaTTJS+g4PSiM+2I6IuwQVouIACup4x9LqR6lODR5XSg9dKyNYO3vj
 Nek8g2xdB7QRxV4/obivAMRXBkAG2qM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088
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


On 6/4/2026 6:23 PM, Krzysztof Kozlowski wrote:
> On 04/06/2026 14:30, Nabige Aala wrote:
>> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
>> used on the Shikra CQM EVK board.
>
> Does Samsung Shikra CQM EVK have it? I guess no.
>
> Best regards,
> Krzysztof
Hi Krzysztof,

I checked internally and found that there is no Samsung specific Shikra 
board. Shikra (CQS and CQM) boards have this panel and i am upstreaming 
for the same boards.

I hope this clarifies the concern. Please let me know if you have any 
further questions.


Thanks,
Nabige
