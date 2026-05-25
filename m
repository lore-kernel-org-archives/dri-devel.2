Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6F1CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B260D892C8;
	Mon, 25 May 2026 12:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnbHTBxG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bo3U+wKj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098FB892C8
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:40:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P8f3Dl4156310
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MmglVhlO6xRIyqHwjXuSIzMFaQCymWUXmP5JOhtQ+JE=; b=CnbHTBxGNIfzUJ08
 j0kVrg06YgdpZTAj4LUN6Nzq4fIsVGZvtLuSPcFlPFvuRTtqby6areJRJ85RSo5o
 /S8F3Mmi5IQYhtXa1TIpdH2ro1Y6jZ847LkD9kNbFWPaUmh2e1SpFMYJ3IGyrARA
 pd5KqXEOviFl+SJr64kdLcc2wBfgZQ/cT5nEDEp0/T6diM9vNV6YCSCkabKuM9R7
 9qj+cAzmhVjsDnC7DhxMyDMUmEvMVxJoVUmfHn5HwAazetU+tu3EBq5i58hCQ2Fa
 Fe495Y6rjA3aDlh8YrGgi3YvwPkxkIh7ukh/JH5im2dwElNODNqAxLMW+rMlsHq4
 ASVgRA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7pm73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:40:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914ae262b06so68925385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779712816; x=1780317616;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmglVhlO6xRIyqHwjXuSIzMFaQCymWUXmP5JOhtQ+JE=;
 b=Bo3U+wKjeTxDds0JstRYPpH4wKA7SicGUQfryIZcRarSfSLGqWc2DnDtdrIDFWy1AF
 wtbM2uIQbkjOCPeY/HHFVBhr3Lb/qyHQIsRG8GaI2TE5Vlx0ee4Pk1SyzkiUoKH/4k9D
 bpYom0WhDsKjEkV6eQm26y9nfpixjgi4Sa1suZdZEfwkTTZScciaisthhE4bvJU2xKu6
 FGLNkqBP4G/2+RJDY8s9i57BmHZZHOpfapgDBjwqkljeumSQbx6tfBASuqVvPfjdtXoS
 4+9mFFAaN0ezkH4RhQMGnOzZVjb8nXKgFe2NAm8MLskqbkKlB8jDFSmusQCGI+giIr4E
 0AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779712816; x=1780317616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MmglVhlO6xRIyqHwjXuSIzMFaQCymWUXmP5JOhtQ+JE=;
 b=oRpwHG644K6G20yLbM+F4aQX73+ippcvPHidKybqGOh2/6mQpUSnKG+fJJoW7tDC10
 9OGfDpjFpFCLGAC9JCAoPSko+gjc4nJf4xQMLAeBUJNR6mYLfMGUdM0U3N2CvFlNOahf
 5l86RoGA0H1/PeOBtt2i5CC07dE+0lAVcrzVwimoYCcmziSvu0WOk+LKpAqg+aCgEDIB
 Uq0sXvKYdHz0EsJazko2ljRu56DNk+ve0jAen02w9NDbZ3r4VZmjLfHfPVb0j4jjfPDm
 2JQJBYQclnoMEqhh76LsDogzOkl8R+URe2UwFMagHOsFTuz4Z4gY/gNGoL7/GBiVuNun
 rVAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80vrpgvy2ilBwV+PN+9gNjDFoKrM4bnHMcwkQf280E9se/wA6FXcOVl8dqIV8v2TifP+/EUSHGV7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiixJwAAEzjLKMdnofFcjJivkVKh4GKGJclAQGTPhq3Q9llWat
 SCeifMXr3C0S9GJh5c9PYRib1m5dRflun29PjIkwxTeTtZWSwNG3gCkbJsmTE5zWMxAaI1v+xTf
 JelWyAn6WtgbFcKG/yzOxmilvWUym/B6FmUl+48spT8et2Ty8t0KDr5VT2OX9B6d7oZ6zVrk=
X-Gm-Gg: Acq92OHpkdCbUQoEBOTLCi2/uyhftFY8kaRXiZld1/1CKnhVAMa4GH7zLvdIxe6RPqn
 DYodaKcgsoCEutoIjUWAL6lhdFhjUQiwn89p2rkZa1UywcjimTpkX3uIdavT6K41UmgtswoegK+
 VXby11Bx8GbH2ArZFaD49RuBaFvEgRaNvaFLwaZeosyLyX8LZUZH9X37u+/al4fNNZTwrO9Av1I
 FjyuD7I+rFRsAuNpolByzHK2yvdpWblA4E0cBKcy6T9iA6ethDNagSDT7eOfRPjv/KnywwG3QO1
 c45sWc2rtFtfUbjVo9LXkdGorkwBcKGBWQ+6ZXxTNAWbHVDIdtvhXHACOi1RFo7u19oKhUatFI0
 nVDhSqjZaiYCI/dZC8akvRRY271d8odhXNwE9RPALshbvDg==
X-Received: by 2002:a05:620a:468a:b0:8ee:a1d:bac6 with SMTP id
 af79cd13be357-914b49e9d14mr1374572485a.4.1779712816373; 
 Mon, 25 May 2026 05:40:16 -0700 (PDT)
X-Received: by 2002:a05:620a:468a:b0:8ee:a1d:bac6 with SMTP id
 af79cd13be357-914b49e9d14mr1374569185a.4.1779712815873; 
 Mon, 25 May 2026 05:40:15 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f603desm3917557a12.12.2026.05.25.05.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 05:40:14 -0700 (PDT)
Message-ID: <934e6039-4639-49bd-8cf9-a1674f86b8c8@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] soc: qcom: rpmh-rsc: Skip TCS init when RSC is
 managed by firmware
To: Graham O'Connor <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-2-graham.oconnor@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522060645.4399-2-graham.oconnor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dsCaxFEVZufioNk3aV6OAVJhxNzJyCbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMCBTYWx0ZWRfX2qrFyKBEPirP
 8pBp+STuNuzk44prDR9HgGL2uPAfQcBLhjaYYBxBrmBOmtssM8RETucthFrwDilU7VLUfoheBz5
 RTObXQj0M0wXvMAaOAdp1gliR+4jXTY6AGc88PSlxOA5bXF/USOPemwf5SZxUDxW4gQpM8J+Mu3
 H3iWASvxQXEF4FT06eao6i0b8zq1x25VpBs+C0wjn7OjOy0+dOEBSEvask1J0Q71C6O13jNEF7H
 USa5zxPi2CNDwKrLOYlhx8csdni5I+El5d/1JIVTy4d2hXNCz0rU/8WTZprE2fYclXzRdWHj5lW
 7V24Ff9Sov+N3iM8OJGG8RbJ2etRi250L8EPEP4v2gYNZVwYrv47vC+LbRiV49q3Mu+0Sg9g4RM
 r7lqTvgqtVvvhOmnfMOUw2lujoQsbFPb5m1LcDpBSYES7etXtt+TJs/9vZb4H6tqcNBAxsF/gQC
 vqqax6y2IC2IhVCo6UA==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a144331 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VOnKaOCXMBmNH4hAPL4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: dsCaxFEVZufioNk3aV6OAVJhxNzJyCbQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250130
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

On 5/22/26 8:06 AM, Graham O'Connor wrote:
> On QCS6490-based platforms booting via UEFI, the RSC hardware solver
> is already active when the kernel takes over from the firmware. Calling
> rpmh_probe_tcs_config() in this state reinitializes the controller
> while the firmware is actively managing it, causing a security
> violation and system reset.

I don't think this has been an issue so far on other platforms..

Do you have some more details?

Konrad
