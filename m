Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1BC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3761610E7EF;
	Tue,  8 Sep 2026 08:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkCXs8g1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMv2BH70";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE1B10E0BC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:00:43 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M1sn2712324
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=; b=NkCXs8g1T6e/kcQ8
 3LCq7wK7GG90UQimigTvNwffh8vfCx9bH5IXT8VvYqBGWLlRhlp2uUQjPK0AZHEW
 6xicy/3Q2e2pj214fgikSy45UByEJg33BFmlgPBzjKlqX934DdDxkye/k9VAdNur
 GxDfq5I5gogRGvJ4Wi88bb/cldgCOemfnalTGKWjqwZnlyg9WGqCGQZnIR4IvffQ
 Ji9X8q4pMqGsyn9qQCvqMf+YI1KTySNeRBKrupw2kjyZU46sRizOV8ncNFHxqU+P
 /amaHRs/7z4d6ONFWV2OFz24PLKVJaJ+Gxd+SF+v674qfUAKN6WP9evKAYnu+ZFc
 CU/BLw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqm5qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:00:42 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c39b4f3229so123722e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788854442; x=1789459242;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=;
 b=gMv2BH701FT4lhpWNhGu6S/FTGfXM2MplZqoau6256gWB+qEbAt5VD2qfXUQr8QUuc
 6xjHPSAjeev9445BAXJmm+UAkdYdUgS79Z4UfBz46p7EECWJmNUYi7USLxFzI16h92b5
 lHr6sOm+ujS2GJ0iatNMMnkXCsGATi0OEnrUdwUNJQrKvT1JnrLxtvJUfkW+H28wSWGH
 gd/lNS1tazOfpkwBfIiBase2JasdbltgHTiBYvaw3oGie44DiVZrstfzps9+9axHRCoP
 vhssSwXivsnmaLo+o6zAtJGS1U55Ybhaj+pAmx2cAiOkjoAfZ0u0SvKtdLxayLzVjasW
 3Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788854442; x=1789459242;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=;
 b=E0ZZuqTvty6V95JKYo0siYPFsRuFYKHPyh9mjRhrNVynt7bLDJSTmDf5dH8L6p0yOH
 /u7nTOyB8Tmr4UkoVe7BtUqWwsGzE/Nh7CadR3Ub0Yhqu9hQvDpjPsBOrBfoO9E2axI9
 PR72gBjC5rNpqgA/9TywMCdQhhoRf/5iRFhyMbFmHB9jVzJryzna1gj1DgWlh1n71cEv
 GjPOSftex2WOwOcv0Op/U/Sz8voViQDLyxfrCV5he+KkCD10O2U3fQu0H9AQFY5k2Ooe
 Kz/dzZMEz5h2SbTE4u9x/BaH09po6lGMPSVov5GfEqmuG29XBQtEy7D0ZZqi8iu6MC/b
 kqJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkMniP0/Q7Uo7HSUkLnh6XzXOIxHv4x2P+KHzgTzJO54eQLz0Rw6m11MvrX86L+FRRtHdTaLZyV78=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kmEFhO+FVVYmnfxK8p4s6ow5CCKnDkRyooRbO0b1zAwptsfw++
 HV3J/KbWfa5wLHlJQ4KZyQvNPTTkmCBLi37px03L1jl/j0AX/DDNAHN6qjos8KoAItCNVXHas/l
 U8EtHxaY7JjGuJiFaAqIykg41RcRHbPKk+P7VrwMKuaYXwqMnel0+mebdThZzcGSn7JlhAhE=
X-Gm-Gg: AYBFou1J8MudTACrwiloBOQ0tcPK9tQD8ZCFOTnEi6/oXIneI23AOAFRWjt2X5oXFkA
 VDwnzz+W4iI+WUNLMVpLMHXyY3moS3QjvfvXEPb2Y9ZipBelY959Wsln5vD1HB+sMBsjNmGTJFs
 3JBpeO8vAgAijFgGGuatq8V4QIsj4MDRqkJgaIdNuJnKtWfx0cv5DCqxZyS9YyKZUZjvw7URk0Y
 aYlzbyqkUKUG+r0v9akWINXsNgGP3WvNcZbqof0Uk5YdCxHdMvxI19YuH56lwzMRayPGlj+8w2s
 IBWIg/LaeG0a+0+yoi1fRPJXLK1pF7GTi9K5JP9vnEBD/LSh0rmj2ZKPBSPozqp2k9SUW+JGyE+
 hRTQXPIei2y/MGYrl4vZeyQ==
X-Received: by 2002:ac5:c88e:0:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5c7fb54d026mr2461879e0c.0.1788854441555; 
 Tue, 08 Sep 2026 01:00:41 -0700 (PDT)
X-Received: by 2002:ac5:c88e:0:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5c7fb54d026mr2461861e0c.0.1788854441099; 
 Tue, 08 Sep 2026 01:00:41 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b61669ae43sm2831689e87.3.2026.09.08.01.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:00:40 -0700 (PDT)
Message-ID: <7faefff1-5aa4-4277-a250-add84a880a19@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXx93w3BN/DHR+
 oBaFkMgqF9wbmx26h6wm6KUxurgRwSPSZZhyoafFNSwkyjcfHNL96VrZ1o+ksw2/j/igTEN1beQ
 4WwHM41YfzL7W6prtAzHAjcN+piClbBVkbTG/6hin1Dj6Y5CGl+mOXS+37Pa+RIZmrHBOdGcWBl
 6xiYe0qxIE7EiE/CUUmFJ48M7trEu7kWm94ZTAHoqSJTgHzR4E/WnDfpHpUIrPBBmTbccSuZKSz
 2ha6LkQs5nyVh3s5QJoRu93ecBghfwOItng0tc3WrN9J3i9IjtSyBh4hoLfzkhhOCFFGWGqzCnC
 5MhRteayNA/H+1NEcwqVM5gtVWosEPj/72K2jypsRguu7jHA/n+hpAWDpTldMS+6Q6BwtuXNarf
 YHG3lS2js9VZwVfIrSqOsjvRTExxso1OxsM5rYQYvJuKQr8GuE7AtKSkbUuy52r14T1u6jnnjb9
 cVVOrOkMobH8TPG8PDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXyK2pCQmqSc5K
 weoL7Sz337nWpCiZ6dvD3RlkNYehtoUbEKXgtd9gBlstyluqEgI+FXAOcj4h182HrDPM8VX9KKv
 v3pE9yDCCkESK9je3D+C8UTdBwuEXNI=
X-Proofpoint-ORIG-GUID: yFy1IfH0AWTbrr3eV2gTxsioEiuKLRlQ
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9fc0aa cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VKk1TRdkn99K7eK9r0A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: yFy1IfH0AWTbrr3eV2gTxsioEiuKLRlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080082
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

On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
> Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
> follow reverse order of powering up, not only because it is logical, but
> also because msm_hdmi_audio_update() accesses registers thus block
> should still be powered on.
> 
> Depending on specific timing, existing code could have accesses to MMIO
> of powered off block.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
