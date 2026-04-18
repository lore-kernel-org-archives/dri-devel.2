Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88174F99C88
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 17:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB56F10E37E;
	Sat, 18 Apr 2026 17:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AETfn3ZY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YjHPr3O2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AD510E374
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:53:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4UBv83679633
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0yKS6gatsEUiAM5RPdSarvZ/
 I9lJ7Jjr5A0QwVgBKyQ=; b=AETfn3ZYqSvRsPlzGEObC5keHsWKOvYTGe5KCE4q
 5dfxHeCH+m6hz6X9v5UwuFD0mHcUTKRkMZ6CGApxANvfntQTp37KhimGa2IZRe2F
 Qlz3kpeq1dkCJU5FGcO7EXTpiUetwBm6gsWIx0UnxFeYS4MUt2nJkhLHWk9PWoB3
 cuHzf3tDsPw1HddLadjhKUkNwnqXy4r/SYGZ2cJA4aR5LiRyJde6LaOf4X/FBnyO
 9YsO5C6F6cay/OsfatD7TE1xFEI/Sidy0fP/w8YU7WfsyIx5W8Je6J29Gf5b7p8+
 U1LKMH30IvEfhbSJh/Eem+mmY8TmKGiZyXShtyVk7RfwEw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261s8py-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:53:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acd145817dso42710796d6.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776534834; x=1777139634;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0yKS6gatsEUiAM5RPdSarvZ/I9lJ7Jjr5A0QwVgBKyQ=;
 b=YjHPr3O2YdTK6bUBtyzl53S8FbA+PggkM7zgufWL3bLaEgusoMI2B+AixpiiNUbI73
 j2YeNquX6b33yidRV1XoBe4pa1mcyC7A3IE9BW1eN1fYHYo7/7m0jeG2J6i54rwsMoYR
 iDjVW9zzokjf8ZCKdad4OklHRNgUExFLwC/qdkGLfucOghNX14J5yVn2oK5rsHdi1cPQ
 w8ry96t6Ah0MFjW2nO1JrAVqzspl6yNB0XMjC4qymg0TiVzVYrOhzNB6DCRnpoBGwrRC
 UqoQfEk8Ja4zV+JmARQnsda4sRw122V1PNSLy+TN59PAWAsej26OQYyW48gbPkq+c8Qx
 0R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776534834; x=1777139634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yKS6gatsEUiAM5RPdSarvZ/I9lJ7Jjr5A0QwVgBKyQ=;
 b=pMvYBypEsuIjpZEn/fiTRFPMtu5iL0mocq0TSqyA+y9O1Te/0gTZgNf7KsbsuPOSJ9
 v7mvAvYxE3hnUz1+niRPOwUoIjbRksFbK38ptJIw0l5Pp2DYQnFD9lABGJt8/9pTcitn
 fkZf2ilcfjOYMwQHzfheoKhlil89tD32caTuQCtRjub4eUXZ3FBFmpczH2r0Z5FQ3vV8
 MmgGzxK3ITUXQEjzy9L7/WJhnKJLi7dQat8c6UGjUVWRFkIqjXgBd8PO7p0GQxu+RWPU
 RiwsXZY+P5hxVvXeynCGw0MA16bxt8oVGxy8lpobq297sKcjg5FQ1WjautmmMnuguZiy
 OuXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83JxJ/6+5iGM1e0ET+xQEFaUQABgpG+a1xttGFbOFk5CfO8OHeXGlrAVENNMriSGm/hGXzQ/QqP/E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR6ma/Ae7dZSSg0cD2Pm1/kN50misTRZRHnrmAnfn96fsgMgna
 z/hqI6A8zAn3IhzqZp70vMBuPC7WqC6nWq1hsRnOV3S/UY3jShWAa82mOfVmZtu0PTnj1hsrx99
 elqdTNVcpDlYifh9Mrcumr526+nuRUos9jVaJbOYaXH1rhQ58ulV8GDLgsY+bkL7bBG7M45M=
X-Gm-Gg: AeBDiet4NHvPsSH61GdT0o9cyAz55iJ6VhI5HDAQtT+4/B+wPqT1RYBGw0WP5JhmZyN
 v7gjqdsOkTkR+5qdBMjKT5FnBi3n3Fhfo1QIsAX7BYSJttbIJPw3LfjzNwR4bGNMLYQmC1opqR4
 oag0b2somgL3pyH3LdJNYAdRXWAYkgQiYCGbbb2iLrK67hj4Mu+1kyCggt5qyxhy8idxd3Pbo4P
 cmJohWDIYoSJ7ZL9Soh0qvhdYygmXw3z/WG/xeoAPxACufzbHglAIlrJmQjMsyLH17pVFOo3hW/
 If383aqTlx+kG936Y6nfmBza+CS76ZYPjpxL9w9AK9ufOGM3QuR9HeaC8UFQtEd0fgKHJVt3BWZ
 hpogB5WpccX1p28YxEzH0yRfO7USYWDiV38avooidJE8cJJKYYHl/DWdx+DqbO1TEr0l6d6Brm5
 ras32OW8tzAxDmWjn/AH9f+M4cTTigyvqfO7PCecIlGFNsGw==
X-Received: by 2002:a05:6214:4a0a:b0:89c:6ba4:e306 with SMTP id
 6a1803df08f44-8b02812dfffmr139628716d6.43.1776534834283; 
 Sat, 18 Apr 2026 10:53:54 -0700 (PDT)
X-Received: by 2002:a05:6214:4a0a:b0:89c:6ba4:e306 with SMTP id
 6a1803df08f44-8b02812dfffmr139628376d6.43.1776534833880; 
 Sat, 18 Apr 2026 10:53:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e1248sm1509867e87.38.2026.04.18.10.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 10:53:52 -0700 (PDT)
Date: Sat, 18 Apr 2026 20:53:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 7/7] arm64: dts: qcom: milos: Add Adreno 810 GPU
 and GMU nodes
Message-ID: <inedwkfju4qtfccw2mv76sdvnbhibewdm53uhyv5qrwyluxohb@a3r6atqocugj>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-7-61676e073f8a@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-adreno-810-v4-7-61676e073f8a@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE3OCBTYWx0ZWRfX2GxVGaxCja5Z
 gxutD9Bf2XaPpNw1qAMROvLNVfSOTDAspIvMy8h7YpmU66dZPtDLbRwfH3na/opQBO4X/lyN2Yf
 7DzXSrjQbQEtOf+nq+2F0eRxWbb49BeDGphb5CyT6l17cE4PUl07Ok4LgqK6cx746W5xUJmI8Gl
 85TSOLf/4RXdZk6Ei/O+FnIFEINZovks/PDrVLzTcy0tW3vpZqy2U6l0Tbm5D2vpUWd72/Kv8mD
 SJZoaSKXZW5DtvQlK4z3Ebsr2Av4QYFYxU0wpxgHyCCOMLwcPjhUhVoquRd/AMvGSpzFdFhN5Fb
 r8ttUXSfK4KFgyrkFbzbyti1gUyD/QPCLfOXxY7V3vDj4yKUTAe7fx0m/3rwoCklxPWT1n/ZgEK
 RjfUsHX91K5P5OcMactX0z+/PNCCzv8lnMzgibi4FY6aMMUibWt7C4uZBgd3InFRucTfg4vah22
 qjvH6Byz8zS2sIXj3Vg==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e3c533 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=REw7ijk5hhyOG_fLH2gA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: Sfyp_ULRU71IsFz0aXlpPql86lSlR-NQ
X-Proofpoint-GUID: Sfyp_ULRU71IsFz0aXlpPql86lSlR-NQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180178
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

On Thu, Apr 16, 2026 at 11:05:57AM +0000, Alexander Koskovich wrote:
> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> Qualcomm SM7635 (Milos) based devices.
> 
> The qcom,kaanapali-gxclkctl.h header can be reused here because
> Milos uses the same driver and the GX_CLKCTL_GX_GDSC definition
> is identical.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 166 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
