Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66940606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T0aRobmA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BC910EDC4;
	Mon,  2 Nov 2026 12:44:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C125D10EDC2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:44:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2B4KeT2616160
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 12:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=; b=EOioltV4rTXNoKF3
 ipmP8gz3lEBkTW5wy4eLvI4Uk9sWVyL/sio7Fh0GJKxk5fXSaL0VhZlQ37M5gKkl
 utI1djX5mcfcMR2+HBR7ym00h560mBPHQ18bsMi/7RC38I0QdVzzCaVslhFxPB8g
 WOQ8v9kMSmzZEf1Jp88whqKbJ/1aklD7VKWlFCwzgWhsfVoWp2Oiw4bKNw404hw6
 HfrnjxMrD+UPUO/PmrzmEn2hqobqG7OY2RbeXRZ+2UxMZ06IrUJGvsgmVvVdvgaB
 C2SVui3qlW+SumQ0SbJk3E6Qz5H/SzHMVgy3dcp4nnWhlThLJ6KEXmc17CFlcK+f
 ur6lYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavgbe1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 12:44:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536540909e5so8630041cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793623467; x=1794228267;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
 b=T0aRobmA1Eh8egfKj5AcpkeBDARk6zBLCK4VzQxHYAla4buP7IclRxC8KYOQyRCFXQ
 X2uKGr3ruqF52yT98zQWnJVztFkPwWl2aNTJGYJyP5YtoYVZO/+nEV/cDBB6ijX07abk
 eNBtWYUIm1mmKDj2R5wDOnJ6tYljhqJG/wwRSob8G/JGzR8YzquoANts2SCPZPIkfbWJ
 ve3JoMM4QDQ3AkdQ2FZmU7ibHo4QPQsPV1uICttXdq30yCsEDAR6f4Mt+0K7vZuwF+G5
 ADRDuS6QbHxKP+go1fPh3jkVgrm3ahBLrpif3TRq3lmO9NGNt4umg3JOBtpFUfiW9WJd
 XdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623467; x=1794228267;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
 b=LP4DVHDagmTuvtOtez3iEu0RcgB+p9N3XLy/P4mCyAdHM4k1tL0/PwvO+ahwlbSJbT
 kVifZ27qx6efnOpS37BMXXfZCDJ8xQHoHQm7P6bZlhiSEzYpymii7/ve5qrSNF67pAEf
 R2hBPprgcujOpdKGusfcaADIpPc403d3/AopUvT3SfJ/pXMjC1BSxZ2ZsJUfiGyPgUjJ
 pJBvBIcaSaDbnyi7g8P9B9g5m4YR10YNNafzO7dUe3BmLylEdABJijkcjjyUwMJziUoL
 BsDnn3Au8s+/Dxp+8fDAHP9ySb1qWb77DlmmrfEUx3VCuyEiz+TRN9nxuAaiErjP+0qT
 2bLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbziUxRbOE+uUGfi8ezC9KNX9DjSlIK2aUBggmj8ChpqnPJLvMbnL2grdjyAQb1zpPlZF0o+ZLbgo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL0xEeS840DW3z9rXAsCIrL3f8lUA6WFNHSqzJGTL73QADII68a
 oXtm2P5Flu5YDpD9CqBXnNaTjexsiy7qp3FP3qurDnEr8YuzbKJsXM0WlY63NR22NQXk/Rur5Ji
 zcIvzSFhEvSZxDcZ0DwfQEWfM72JuR8AFINX1Ra/RYJ6kqqeG27uV5eXq2k2vVzhiEKtoAAE=
X-Gm-Gg: AYBFou1gkl+Jwwp6ci/F8lrQH1AC3gkI905pyssxXIMVbBlbd3rsLUoKUANhFRW+9tx
 n/53zyQduoYkSzjkHt/BpE+/ilAZ1IMVtmrRnbAeiw6ccNC7YR87gYr/qJvowVRuGmPEUHbM7jV
 dV6tswTiMEQLV/WWA3trKkDSOq2Z6pLNvHB/BE4e9rWVR+oPq9xN/r9icyMN0Hjf4FhZMLePljy
 pvhYM5NiMDsv82T44OykJV+cLbMGdUDTEvgjcZMhwkoDv6J3MKuzXNlztiC2Ce80Ue5Iyz8zjBr
 sPdXGGg6VV0dkm9bL4wFF5os2zAOYYs5MnEfceezCsvVJwr+JLACxreqPqpDRoCIGbx/ay55KaG
 TtRcSvMb+2RQxX05LJiNC3CKYr8PRWSz8ULXqYRzfxBS986vbhgq27r6xZHoMm1+EreRdnAk=
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id
 af79cd13be357-944216cc78bmr1564912885a.4.1793623466988; 
 Mon, 02 Nov 2026 04:44:26 -0800 (PST)
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id
 af79cd13be357-944216cc78bmr1564904885a.4.1793623466454; 
 Mon, 02 Nov 2026 04:44:26 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe101d4sm389225666b.40.2026.11.02.04.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 04:44:25 -0800 (PST)
Message-ID: <73f05be8-6335-4d48-87fe-71ba5fb1d2c6@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:44:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXxKOGduPJEB9m
 lSjFYaQ2/MwPs3ar+L/QUDPb5PnRhGaeuog4PAHxcEyXaHF0JO5bZ/oArdk7wmWPcWNPryUk2HM
 NQxLYkLqDPRGD9lkwZpQ+V8z7Eh+w1s1qv0Ku01YJnmYl2dLRKF7k1hTkaVg08LY5meRN6uNQhL
 lOSCSpq/Z7F169onR89oeCuBBk8DPZF0FiRVIcZhtPjimwuxRVpMcysT0rem8AXZGWuE8ggXtBL
 NtH4QsCS3Kmmoj/gbeF7vJGydN4uU+z117vpwct/JKX2oFRKseE6BSyAD5bDlFdmPZccPkuK2If
 /DvI+Ot+601N4KHQMbajoVAqDrD5srTidVjHJ1snLhIz8CZNGb1/ML3wkcB1RU8QOE6rSDkcbjd
 UhNlBBylszApGMvjHVaja/FTqFBEuLyPKO5yUfIgsMmEcocYCPTO1eCMsi5W/uCP7OKhxXtuMMx
 86FUTyn6x/SVLnWUcFQ==
X-Proofpoint-GUID: eVw2ntD4vEQ3UwBh0jDwpb13F--pMMuA
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae885ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXxOzYXQc2otAY
 8p/cSrcU0Q0sgqz2ZcDJZEn7xJrQB18jfxQM+j6NOhQI6C9GpfM6GqcMZgEIZizySynrvwr8a5G
 U4HUahAkndHlHg6FXfaoyQsAKN7uHOI=
X-Proofpoint-ORIG-GUID: eVw2ntD4vEQ3UwBh0jDwpb13F--pMMuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
