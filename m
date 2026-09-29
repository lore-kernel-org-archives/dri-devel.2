Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC41CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFD910EEC3;
	Tue, 29 Sep 2026 13:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk6mvLlV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KVGTBYnE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779F310EEC8
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:34:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqek5611450
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=; b=hk6mvLlVWv66MepN
 iXjqUBQgGPOer5qnBJte12x4wjPvxOCEYL7J06CYjn0EHwKp/mQIZhzGf/7PTCrr
 JPVMRa5P31yNjd0syZbjgMb1SqSQl0EhM88wLqYun1EFTHMdFhjcUQaYctLQJvLB
 m8rrLNP8N82Uo9R+rz0dot2NO2Ag+BRrRZy3QHNaATzsOSBlDlmyQoF67xxVYAwr
 6AvhbgJpiztMCqAaEVjfmc1yrAp8Qnex8FnEzTZH2Oi00Q9D6r5JmaAxiFebRClG
 r3l0ApPic+NoNoV0+qGAVh5h3Rn6Nx3BILxnO83SaAFd/J++STdI9TWC1odBWbQy
 41skTw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4uar6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:34:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so7789626a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688867; cv=none;
 d=google.com; s=arc-20260327;
 b=NJvsesynsOylKI9c+D74Z6aqpWa9ju4xi/m2oi/qVzHzHajZsO+TaaIhvH98NiDrPu
 sMXQ/EdLqylkouHHzrhf2mCeI4bpqZvcW2MeLqRpZfwBt6RhE1UPGsZgiYyellZtrwUa
 Bwa4sN+J+Pjljoy2JLOcJ6aqtz4N9m77LTb7gIuCkfseoI25cdkvpNQVDpfyEujaziOK
 s5/vnfkRSdt86fphjOLtnlPn0CjeeVva6WFLaWGUNzQO5hvhQGWHcgF7hQ5VXeOVT8HI
 BbKPSjYnnRt+U7Em0U/41ZNSF8nL8fyEj3Q33YKxG5iWk4cCoVDVOQgpjbz5a3K/6Hov
 k24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
 fh=Qa4mf54B4pXxZqf3a0V0sizsvh29E3yaR8YO4ILE2hs=;
 b=jev62Z7tasUZ6Ul3Ocx7di1cEcgIsExfF2E4brbzk9IduDlQ4J5SfwgYLRWJ9dPyIh
 XLzxIfsfEYP/ZKbPS29nYkFhtwNfuVjXhfxHSv31nhLqGlyJVBX7AF7EWC3WoR4EcriJ
 oKt3fYJDpsGSnV74vkPpkQOleGRzRo9NBcBdGk+gjked347reFKh7Gvcd2pE5VZV9QwV
 6DoC6OAecC9YlhUnlca09jPf5f/M7lGAnSa79g/WJ9Blu6soCd/59g+r6NLxvkM1VaHy
 1uKkxG72JXcsmvbZXR1h5x9IhTbXD+kQWcYM4Sygt1xPXrVJlpU7oue2cCwrZaJiD2Q0
 KbPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790688867; x=1791293667;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
 b=KVGTBYnEta6HVbqWCvQ4AdLAmt6A1Vyh/xoEZfoutipLFegjtymmvJbvDXyFjrD9CG
 mJ9PPGtmo6oTripJXcCkSKE3ywHJsncN7/D2zMim3Zq402wyl09EgMVLENKwB671CTVd
 D+qgg5DMUn1W1iZHfinIt0QuFdOsup56MC7WPs2hJw8XzeBapxO2DRvyIL3TcsGQYNts
 qrqibYLDhv1eUU81iIjqC0yGG+vokxid2bhr/gI7yDuKaxo/kQ7Wqt+eJHFPkqArlbBl
 uAIQOLWhvLeiHPu/ePUd320/kcvej2jmK8XpfSt5kQCxk6z8Px+gIZP3G2tWviKndDv/
 3OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790688867; x=1791293667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
 b=mIi4H/YlMySdSHjWpJU3aKO9gVB7Rz6J/IMqie7g/rRYVd1yzZGArOGdjhvxsY3dHM
 mZtHQY9a3KT8dW1uuABQUVrg1kio5E1J97cphJ8mR+aq5b2zG74Cm/M5WoACK2PBXWem
 dpKyA3vyhpbhHNMQ9d4gw2JQe3Ur47zXmU3zA8VOgTIX8WvGDyt5sZ/ga84M0swq+B6D
 ig69woGOx67wAwvkQQ7GW66620/bpuBxA4CJDvqr2tljl4iGm+ydZ9koa5cI/GLJqtty
 Zh9iWLyZKNmiVUoylh6R1G8/nLslKd53hwEXP1l6Kt6fi005wDuxPjcQ1rOdP0UAarYM
 Xo1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzZHkYnxCk92B5xFeZqLZsqQPIq0eI6RwkQnjgvvgKKsSLRkq4/1hNlLt2cVEycPZ1NdoQ1DktNlk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKpLPHQfRcCohJ1ot5hW2I4JXwTD4VCf00OLhUVlfi8Sl0Rtxm9
 zHNSt09xPX7wQjqHMqQstxwQdLOBoJM/LbnTAhFFF65KYm4Vm70De6xqSLKVSl7GBq0iASXszkP
 AO3SF9jBv2PGNnEO/3kv6fgjLA1CcCrpWR6WBn8KK7m+EDcD3E4D7jlLp0xOYOy1ilWRTuz+5d8
 KBIqd90w8IQu16y2y7+0GtmsiS2oXmLgPdFbKHLOkMxhsDBg==
X-Gm-Gg: AYBFou2Xe6o//ucG6F5jMR4pkdNtb1Yig0w1XNA7dGeW6vXweInptIo3nlAZl15TNdY
 ZqGiGA6NDsIksFtwFHZ5BOKI5n/8OBi9impbbpI6mTfiuIgnW/zj2CcFV1V75zE5xcse2Rnu72U
 vOIgh9OYWZAdJF5nF7VvthK20i/wPDMkp8Ujm21bpf6SrYEK/yYn7gVFV19g==
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071547a91.39.1790688867364; 
 Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071507a91.39.1790688866886; Tue, 29 Sep 2026
 06:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:16 +0200
X-Gm-Features: AclHuK_IsoMVZ8jA--KFIskLK5LDOvw3Q0lyiLyhAEn2l6B1awM5w3Hl8Ax8gbg
Message-ID: <CAPx+jO9qPRgae_VqWrGQ8bhDOHBf+zDzw3A-BxCMa25XfPaa7Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX4E0RwgAV5Y3/
 rZMZTtQdcr785rjGdpAL94xHy4HxDoGp2ntTiFX4Pt8297tu7wLCKF5qdpoWy7ZaE2OPECuEHYZ
 UQPdSf10sepWlm62tNoldkIzT8TsXiY=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abbbe63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=wO7LUizMVtHDz2nkp9wA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX4chYaR1pKRA0
 Jzas+VxpMamTyxA+7qY/k48wK4BB/awZk+9dUb+QTL5qmprvPpxWm4cRKp/69eIa7XN/I9cwVLy
 BSzTp1QRvqbr+jOpOTAKERom2hvbG/FLz8bOG8Re7A+z8daPKymPDEhZM0B/bUUkuwROZ9bVUrM
 93CdL0ckn3fS1gCsBe74pVSy5KWIl1S6q1Ngx4jl/FwRBbsO7W/asCQNURt/zil3gEoylkyi45t
 jpbN9Oirt1r68MmUelmAFzAxSju2plZWhXYUoOrw4cGWPZgi01Az9bAxmJY8BGIifiy7cfxYlWg
 0zL7siczRDuPvwzNTfiIOh2BmxWkNK4UxE9ObZErMNljJlLngtQkvFdmRSzzrxnpC/mb38b3ppD
 xQaiV9dj4HzcRY5o6MCyNhQ8D9pCaoB65EeSy2FFh4a4FFYx6j/hqAlBr4mhcX6ck8PAz+KDCX3
 0URjRyc3n4mXlWa1nyg==
X-Proofpoint-GUID: 09Q1xpy3K5dvtaOLpnA5A4lHaxXnARng
X-Proofpoint-ORIG-GUID: 09Q1xpy3K5dvtaOLpnA5A4lHaxXnARng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290054
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

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 69bd44e65ad7..9d4409c958fa 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,ipq4019-sdhci
>                - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
> +              - qcom,msm8952-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
>                - qcom,msm8976-sdhci
>
> --
> 2.55.0
>
>
