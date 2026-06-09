Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F85CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0615210E1CB;
	Tue,  9 Jun 2026 09:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSzRjhch";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0Zc6tp/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1766010E1CC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:19:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rZBv1923143
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=; b=dSzRjhchuv5J+lA0
 VNfzn1g/9zxFGeqrtj10w6mP+5Vx15ppW68zOAui5kM3IYYYrV/FVdhtdtFjAFNw
 Njo90gM6dPM/GInzXIdglHf2hVk7m/0SsMXmLLN50m+xjjCceihnhGAUlzr7AMtR
 fkz+GgyVYr3L2YD0dF61q0U1D4Kg4JHF6Qlk5v76WGgPnlfPZXMQNKfBLBkUAXVN
 hlsViLtumFWLgxE8/G9zq0IT+3pq3YbcwZ30UlQNaQ3FLXC1Bg7SreQ0tB6IPO6Q
 +uJCXUYqB6O93OSwbJuHpNx5SKbI/RnTF8kpSvscvF1oAfroI0Bx09Ns+492qPd1
 ICzikQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4gf78-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:19:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915b3587972so419502085a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780996791; cv=none;
 d=google.com; s=arc-20240605;
 b=Ly23fHqhpJOxPIkBBtCLm5ScGGsBW2jUppvfRRGaCb3aSbrP0oJTcCRyRrwpL7psvv
 MmgdF5tmTacem15Gon47VFj7J+Z/tPyVfWyyJ2VfA2Nok1zqmXRG2EpBv+A1Kjx5GlCs
 ZIHLfI+fwJlpi7a7OfTTMZ3VPa/kN87YqfiOrWM4HaxxPLnL9cykKiz2sSGbRR8nBYsy
 tP3CYoyZWmGZYOMWZSBUWltYDa0bO9LG5krRVzBlehf/uGpSDBjtLtI+jVtt78tUg/pY
 UD50byXR5J7Kaq5faSOEi0aJb16wXlev7KiLoRPt2CyLRR+ikfzxj4nbZy8AmoS/6tJY
 DArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
 fh=2SK9QsI9WuVNVZcv9xXKuG7G7QxPUorAy83lHg83/6Q=;
 b=WA5gSOwrC6yD1yFV7nzz/27acbWN8fVtpNINHpEEP8DvftAFeWYr+8vX2qxtpGjaMa
 2JQ2J6VlDM1qE4PNwHEbK09g8TOnHhxbNTld5LHjZ42ufP+RcuHXe99xBkms67tioDCQ
 4AZ6XpKKCuv9GuDAWPa4LNX5Sr0GXqd1/V3yCnHCRkEtXAgSZP7tCOfFKGS6Y04r+dWv
 Wu9AJT6XBSO5PAFZ7HfXfz2Z9lwMIZcPe4ASOf8fHR7bh8PO6bQCpqrStCjWUF0B2Mcf
 3s0cDba3QJ94AIxDHmfXUCQ1xNVF4BG3uzOXgpY+v3vO/EC/75YrEbcaRNzKKbAE7dPB
 lGKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780996791; x=1781601591;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
 b=U0Zc6tp/I6d7Cm5H5/ilMIGGio+jjcGHKdezvHLvLj9d35hqh1GJEN6ZWzz3vqf1ov
 Y9VX7VaFTcxKFrC+fPBDQUndwfdWyrqOV08sJePx8tBWSnRKFcRw2V/+SRpZGqvxQGz4
 3+QQRiw1hplbyS0Mwvr7QJuQ8lANbJUbX8WLdNiTedStiOPgJkI40RRKRwy5QnH2OWgM
 DhaCpAFTkNVs4xRf9iBESM+D9bvvTqQrHrpzggmH15fWwyiLw4h667UwKHqS1irmKUPq
 0EVrKvGBd1M+3v1iBLYY2QtITAbuRd/cykdSvZtAvUgDK0yZBtz7ueavONZ8varCztaf
 oL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996791; x=1781601591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
 b=O9EhlAAuasav7Iv4LbZZS+5T+m3501PUxIY0Wzn+GlA3gtBP/8dEnvcREdiaoEkxQe
 XyBZly+1eyDYcHDt3lBhE737kFLgoCmuoiqTJGe6MsGKWBQbwJ6tamVIUdS7YNtZYo26
 QglvOpBNhC7ARSNDQz2bclX0ZZHWSUP4oWnZbttGdPWAtPdkCIKYAZpx+AFEcx/MYL3x
 xDw6NV3vGntdqLy61r5Z3KnlHt22CU53ZkNOD2TuNUHcF9fT4DtLepsqs4Ze8jO8rR72
 XKn6BHxS1Szpf/W/PLG/t5mia/1baCWxO0pqSfwEfpyBvAXcEMXBjAV0ZebILVvt6gmu
 HOFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/C/yrY/d4mnQIUYIIMEzaVz1xcJV3/fwMJ29x/gfti1sg1fYR/GVXhyLRXofwkc899EmHjgu6CNlI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7irMICawUtnPKYuc4IGphYa/0zkyWdzSv/7nqAj1MMpmDUiWJ
 ejyDMdjjwqfnTI6Kcr2P3hjxwkXG5SN7ccvJc9KbUYQZWP/bGjw4Nhm16uZIeUT7ZatLEOgqXIa
 4Oq0sB2sMFjVoakSKq/o41W2uGBklKXqGP0FjRdKw1ewt0XZTVg6LLpYmJ9uqTEMSiDCctxUyeD
 kdwGLRzzqbUT8Mr8LffsTXP+KLAxCgzZDLnTNBWpazwnynDA==
X-Gm-Gg: Acq92OHQ7zW0ndARh+gD/nafpbWx7RS6i8FG9LdHFDXfMV9WXm65X01ZcfJOiUfI+ww
 tfrRDH4WFg1GFSl09HnMHvVJ+Xsx4Fa+b72yDmuvkDdwzW9L81AaFmuOa5Ymh1fb5Luowj2hWDe
 Tl9srCltRyfcGuQZiE5Af6CcTh4zZm04hasiO2N6OQtW2/mik7JJAcHi2gHGMBDMuDj7C6SZu+2
 O+vMhSINomJE4KxTsxQLx2h3gJUuy/9/nkQZL+RK/XD+KOpz81s+4Lo0uq7auzK6vxNHTIsD99g
 8BRv4CXo3SYd4ypB3HDVVSBzSQRa8pl4
X-Received: by 2002:a05:620a:4590:b0:915:89d4:df22 with SMTP id
 af79cd13be357-915a9db5d00mr3035341685a.50.1780996791263; 
 Tue, 09 Jun 2026 02:19:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4590:b0:915:89d4:df22 with SMTP id
 af79cd13be357-915a9db5d00mr3035339585a.50.1780996790847; Tue, 09 Jun 2026
 02:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
 <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:19:39 +0200
X-Gm-Features: AVVi8CejLh9w5S_OQ6YRu4HaLtjG5GDBpmdR78mQwKNwD0qnxyg2L6IjHLml8Xs
Message-ID: <CAFEp6-3imORRS5FqjTMYV2zOn+bpf54uwhf7Fy_4-uTDadtAxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27dab7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=h5pAuauRZTFNeIU57NgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: syZFr4X-t6balYNc-OXcmEnd0LbyBwFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX0jr7Q5TZ5TxQ
 uPL8gjanwCyDiK07wLgTcsolLiwDmk8hLynzh9g4S0MX9v0L7bdVlofOmuEwVIGVVjBzYWjl3fI
 5r3QyA16wGYlHx+VyYeZ3uJp2xEEb/9o0u/jutFst35Eqy/x+yldxeNRLBdGkNGRoCWqVHBnAzF
 DNTWf4joAaVHy10jSWXw938q57n6xdDHugYwE/sOv+GbCQWKIRUN0lR1v3d+8i0HiT1h7rJ6Zlh
 Aeac/tL3C2svPvUxuwhlQlWzpt14S6A62BcVZD4gypW+QybcQw+TCI7Ax0dipfR0Ndxs9ILain0
 hvpTl1iHc0zaJL9ztEFDBJ793RnOqW/5FRl9e5ojFavSNu1pQ5Vs0r3d6IVmNGtS3CyVHuBpf0+
 wHC6vbuZ8so/rDJWio5F//giy+SWq7ValsJlLCCUNiED0LpVJ7UGJNI+242KVCWliLiNTDUsDTd
 H0y2gKwarqhfx6BylwQ==
X-Proofpoint-ORIG-GUID: syZFr4X-t6balYNc-OXcmEnd0LbyBwFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090085
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

On Mon, Jun 8, 2026 at 9:02=E2=80=AFAM Nabige Aala <nabige.aala@oss.qualcom=
m.com> wrote:
>
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
