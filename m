Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26986C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E60310E0B8;
	Tue,  8 Sep 2026 08:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MaO2e8Eu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IKJM5W1t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A508A10E0B8
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:37:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M2Rq2712391
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZTaGxO48p7y5EHqLgyxjGdy5PCz3+Tijey3+jZj03E=; b=MaO2e8Euaz4HQABZ
 XziflilKhZc4V7K/gf1k3DWHnRL0CBpuu3X0xhzr1d4+5Sw5cNvq5jNeuJkLPXc+
 xKI6MWA9yo7ETUl7aUhw9N2pNH1+GHhRBZvtLpSi4uFhzvJj2Ju///ehtNWYtNAy
 A7FFAU59d3lklwK0juKifK/1043S5ggHydiLv2LwRVIeHhsaA3fhKkmIyAHDNpAq
 z5pyensd1StF01VROFMJYF54DLwYYszIaRhOqJ50JnS7icwpa1EyUxIn95QUt8Qw
 p7TdtCMFnTvgwf/XRPMRd5vZxVvffJ85d3/88PZH8cQj7uOxGbknFHJIrObzrRcB
 eNvzww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqmac4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:37:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903982af1so941750285a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788856669; x=1789461469;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xZTaGxO48p7y5EHqLgyxjGdy5PCz3+Tijey3+jZj03E=;
 b=IKJM5W1tJprbUDKpr6Uikmfjh7RIDvoluOFy1MTa2GL5blZKKKGRjkhPmdmXCXBQbg
 moF722gRzv6XP1Y3HLZgRI0CTT05OQWQWEEN4RKzsqVd7nViGIVdryafxYu1c5MZu+zs
 /CFP0JE8yZB4xHWhaA0Ls/6oFXOGkUJy7HAOqCMZTlMrACDZa5LwK9poYnbymp7bao03
 oBJcmdgFXj7P6XFmv7tv5mH0Dj9TUlyD2Hmq2DsYP75VedVLOfOF9AaYQQK+oUo97bZd
 Vb/ebnXJdoUZ+ekbptVc0bhZbEfq7rVq+Y/uMKyLdFatL/UMJHXTaWGywB+zUY8+a2/L
 oG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856669; x=1789461469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZTaGxO48p7y5EHqLgyxjGdy5PCz3+Tijey3+jZj03E=;
 b=AuERmyvmBc7+uNT41p6sysoFvH9b3XwI6Zaz84sMIcxqkZfFRBBQLLsmO9ugsNi3A5
 zhLUjLUnya0bAxazjninp5Qqh4DMqdx/9Yszwg54BPVipSauDRXoOO0jhWQcRaypGloV
 lw2p1fc6ECd7KBpBHTowfLkoKA6yCddiMX1Of9Qfs5nncm2X6Qjmi+FBkKuZ8uJSOvWm
 1uH/+Nw74M02pppNmy6Uq2rFkVEdFvgWSKav5kpUUkbn/PbGmLZHBu5zlcxbBHB3J1pN
 j72/4Gp6Aeb91+6GPGT0cXL8cD1QUQgoMHeM+nXhpSaxjyFIzErcZO/0SfPlJ7zZg+OS
 xO9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSj3XLb//v0lXtpFOUCaLMCZfQ6QPbykObaZTvFKHsdqyTCgJt3QverhMWHU7p/g7wGKCKRvv2r9k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++meI4nMtJgg9KmkKydBsI2gjJnvkwppm/tHzVv8V3wPvxQZR8FX
 dTyfXvOgamNTbxzMEgrcJySYgOT6UB85o8POLy+rAzmYj40VyW/NUe/pipfZBHTX2EytLJW1fTw
 /q6gYhhgyUupOGmM8A/Ilv5vA3G9w/biIbNpZyBgaIm3qbPQMTOG66WKU5jVHjHehjGCKs/c=
X-Gm-Gg: AYBFou3SpzZNbAP3zbrRUlJvUtQCwWni8Dir2bnX94f6aq2Roc540R9b0XN7B9o8B1/
 OAyrz90HnmyybKrG7vKd0sGmekoppNM1XM6y6QI/o1vsLoR39AEXCXocO31HNRWxTa59fPH3VLR
 4weKHpUGZSiK+FtYFmvNy5skGgcjUJjZS4UyEWC4isIiQbBDo2+VZKvVBrq07zcztwPJvWaKFAn
 1T/+GDZks0UligVOPyyfLEYD5c2UBPbuI43lbjjEuU0GJ4oiVTOiTf+l1In3ckuhwZLoL56KUeL
 tOTqmkvEQSksJIx43HAjPP7vAUyUlTRq6SKqUIdnDMBxxG3+270Ye/538ZuR6L/0X7Bv7c7uGjb
 KdR/RrLE9nluiju1oj8iW5ds4nNAs
X-Received: by 2002:a05:620a:25d4:b0:939:6df9:1996 with SMTP id
 af79cd13be357-9398077453bmr2891048285a.50.1788856668707; 
 Tue, 08 Sep 2026 01:37:48 -0700 (PDT)
X-Received: by 2002:a05:620a:25d4:b0:939:6df9:1996 with SMTP id
 af79cd13be357-9398077453bmr2891046685a.50.1788856668327; 
 Tue, 08 Sep 2026 01:37:48 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d53c37csm563974466b.32.2026.09.08.01.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:37:47 -0700 (PDT)
Message-ID: <c7d1d6f2-4c47-4259-abf8-fdec33a27f95@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-2-dcf8956878ca@oss.qualcomm.com>
 <20260908072546.645FF1F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908072546.645FF1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX7f46Loqb7tX3
 avzy4Qd6ix6werT0/6k7WasKG4RqWL1UgFcRCFw9bd7OnNcgkkz9OPgB1KckC/Pxg/Lr1kJZfHD
 j5HzprXg6jO6w0nnnRoIEsHMZaaNx/SWNQaRVB/xzRt9/0idiWUtNTqieni7gA4fo8dbdJH3kgj
 6h+R+I4ahNNtTh3VLjxZ4jb5I6gqScLwWiaeAbkyTUgdvK/NPLWwPOs40lDnrjTXUtE/RigNOLy
 CfLcqxAh60wqDNCbtyUzL1JScdoYjq8Hg0lVLP57dgcQk3DRf+4hxrtDVNhm9ZZo8uem5aykzs4
 UBDlemo2aWY8O0mowv7qK9di9E6iw7z77RUp0jRJ1GYxpdRK5SFg0O/xEooxEjNvssw0lBA+Tt4
 JZ/Z3UolOAPM+faDBFW2XRnA2QW0lpgr9HEUlW2XoMShoTl+4SOyZNRDRfanPFi8B4WqVbRXF8+
 OcZlPASMo/wyOy5v9jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX7s/C3O7Cfdnh
 A+5HQgJ7j04O7VThYwUQB38t2Tj0vOGH7F3FOhKv/Qxn4ujSGly7yL67s9XY/57lvJQLrvaFg3f
 mqE0QAz/vQdlKKFygAL+FS7KKnp7syM=
X-Proofpoint-ORIG-GUID: 28JOH0XLS2kY4J23uOGjUnATjAGJWqwh
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9fc95d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=dYODrq4-AUaYJTIoUJAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 28JOH0XLS2kY4J23uOGjUnATjAGJWqwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080090
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

On 08/09/2026 09:25, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Aborting `atomic_pre_enable()` on power-on failure guarantees an imprecise abort (system crash) in `atomic_post_disable()` due to unconditional accesses to unpowered PHY and HDMI controller registers.

Pre existing issue really.


> 
> Pre-existing issues:
> - [High] Unclocked MMIO access in `msm_hdmi_set_timings()` before the HDMI PM runtime is resumed.
> --
Best regards,
Krzysztof
