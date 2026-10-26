Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95570606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AM1cYYST;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bkPyZu8G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14FD10E0BB;
	Mon, 26 Oct 2026 09:12:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A0910E0BB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:11:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arqx3303612
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /vDERYeVL03wKO34taLC/BjiC0AyLdy7FJkp+DjJcs0=; b=AM1cYYSTA37KxufC
 Y9gCmJaHvPM8awTBsY97AbFNn/5c/owS0kW6fy15Ri9NiVS9o5nrNAHLFFoJ2HEw
 aJKbm0d5eJGmj5yj8rnlgqxBLtoekUOIRSYMh7IWS9GjoJtjZ0s57/W4lGmThLFj
 /O8/iiJAr6xLsRuQdKrGuRHpbX32hYprGHTCVK9PYWuGbX2MxfJH5EIV8I4cHQ+Y
 Hgy1iCBzc1bXClRZhAcPbAS9Jxj4tfWf6YL02QW2BHYue6CbdY3WgQPz4Ho57vMc
 DTiaswtRB1q3ataXB83m0qnfOAvqIwe6xsWXpWkf2N64OwQZnbhL/9hghwj33Je/
 WESGNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdqbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:11:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93df7a9466bso27919685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793005912; x=1793610712;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/vDERYeVL03wKO34taLC/BjiC0AyLdy7FJkp+DjJcs0=;
 b=bkPyZu8GTEWE362MXBihYYDBhF+IWOuoCirDOGgAU3IPgHm8jAmihhOMXKX6D8Ykv4
 t0Dj8fxEl6YglzzmXoBUAwPbhXBRtzJaN8YSZEoLXvL+u1CLlncRs03/GzNcNm+/uKAF
 90ukBx2Q3vPOM73HFIklivabSTwo1TjlRTqOLlCClVSthIkJiB1SdPrfHSpjHEU+zJHc
 l8iYpn/gHrg9ncz2XKS1KmRRV+xqBcXS/zLGFMzL8bYvix0oNIDbNSnyeboevx192nHb
 T/OLpFrvZ7PETK9bHIjCIoCsU4fU5cy4r3OY78Lii/vpBbS+Pv/bjFcz7Zvf+GU0BnLg
 ZlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005912; x=1793610712;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/vDERYeVL03wKO34taLC/BjiC0AyLdy7FJkp+DjJcs0=;
 b=MR0jabuqmuQrpFMB95I7sl80JG5PcDvPZLtZ4z2O1LKppdMJvq15Dx9imL7QJzzIEy
 d25qQFjXUhf5bAHlDeF7hbF5wJ7847Wg+OgoHFpS7iXY9atQvjGz4NdK/W4pY2DsSyQj
 bY+UkwE2bnfku8vmmRISsIscUIP5ntIF08fih1k5x+uEYQK+BQprGxOs6J5B8DcDiZEJ
 dy8Vu4RCCuIQiaLu6tX8QFVvxDVqq9/+Su3RlotqApHFx/pbRWt7Tb1IoUhZ21ZyhvL3
 Ph2odXtY20RriA7mw7ccHmJ9WCK4F8k793fVpSR++buuTZGf0rmTB3X533+rLhkZwtVV
 nfxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy18hkI8ILZlyY92HGpOaKLw2uBJG2/M83+cjJRPC6rIP3nYd6WFFg5DZtsq/O8rqs/AsBGadsZ9yE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKDXoBHpl8/uGXHKlaMTytHKBwzci4PIFariTXdfC6tl4Y5o+lD
 ZZRY+NwsX/L/DF+B475eYZyWxnGeo08nXktDF/qQDwRcGhGGrra8rWw/uWHnkcTvqFnpZfza9/d
 PFRjV7Nt4lfcMDUKGanKb19jHniyqdIFFBgTiUQhJ3Z3VHvR5jk/V+K6WIUqpX0J/D1hovHo=
X-Gm-Gg: AYBFou1JrroMiwmz5i/tNc7DlhFVP2BpAOXeA/wu3h6PoyXB53ZhnUe8O2Rp3NL9J2j
 YK3nhrcMKn+RpYRUZG+73f9DDh4H9o67Tq+CWTrV8lSmGRZML0yXelh+C0lNI/QJ2dierTt792N
 3yj474ZsJXIyWESZS8ti5rEnZGIiVHtwVnxuBrilh+NNzvC6tqIR/gFQ5bGjun4qtOYyHlWcRzE
 8MKnNucC4D2x+pux33FdDc9nUlooXTfP5HQzDKUeBthZUOvD9CsNCB7lRvvlhBCZUH/Mqun8sY1
 lTR6gceGIOcaFgLElIxPdwkJAk99jRWT4DdRiBXwCzr7squ/xZaJnUJNPeAJfUtaFeSirVy2D3K
 K2Mjprg+TIa8wOPZAPUun5w==
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr999830285a.3.1793005912437; 
 Mon, 26 Oct 2026 02:11:52 -0700 (PDT)
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr999825585a.3.1793005911851; 
 Mon, 26 Oct 2026 02:11:51 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4459711d2sm3281710a12.17.2026.10.26.02.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:11:50 -0700 (PDT)
Message-ID: <c86259a3-f719-4e92-ad8b-a0cb6e1d685d@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:11:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] drm/msm/mdp5: flush the interface before
 starting the timing engine
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-4-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-4-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lMxersox_xtCpoagnDJlK7UxZEGR_5pO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfXxTafPVzur7y6
 xhOKmC4EivgAjod7mgPm6N5kZDvvaiX0H7sAg40LV9hg5RGxxFAtm3nrFrh74eJtU+dBtM6yAvs
 C+0GLO5g+BTiyt2wtwuHDaea0f+mFKONx2QdpnE9wAl++SxeU4QE7itozIgZnRaeqRIDHYBR+Mb
 zyCXVKMKXjX8L61F1yyNfEbUwajZb3qA79r1REdzdNM3r1B0gKbymoSm/vQPVmx/YFEJFFZbN5h
 z6me/AdkI48pp1Odh2RMFfR0zhBKyXTGX4ygCVjXLomVbLpOap8m3/Mlk+A6yL5dMymznFxPYMY
 cornZ3r8wlc7BvLxknvndal/q1SNHsBv3ZUDsNmBH0sOu2U5muPDQccTWpAOxR8pSF2Hf49kCAq
 TwdHvg/7PG2G4dk9prH84Y1+XIZ70GzWBfcdPxQQAGjqtRzQKLGIOq+be+mjiI0WUrWN3zT2kup
 CPDkQbPZ1f+Qxf+6OMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX5PMIErRrW7+k
 pWO1Xe+Xwvp6oRMpRBHwTYkB/f6Z8DBVVJHsBwIo3d3rJcUmrDG84DyFkSaiXi9YqbREHH1mKPF
 g0+ECp1iE1b+ynM7fwOxstDBPPfzjoM=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf1959 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=t3vDU1A9I6D9DDbkPvEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: lMxersox_xtCpoagnDJlK7UxZEGR_5pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260036
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

On 10/24/26 1:25 AM, Dmitry Baryshkov wrote:
> Disabling a CRTC and then enabling it again can produce an SMMU fault on
> MSM8996 as soon as the timing engine restarts, e.g. when fbcon takes over
> after kms_atomic:
> 
>   arm-smmu d00000.iommu: Unhandled context fault: fsr=0x402, iova=0x01fa6e00
> 
> The faulting address is inside the framebuffer that was scanned out
> before the disable, which has been released since. The pipes keep that
> address latched (CURRENT_SRC0_ADDR still points to the released buffer)
> because the plane removal flushed after the timing engine stopped never
> takes effect. On the next enable the pipes are programmed and flushed
> before the encoder is enabled, but that flush doesn't include the
> interface: the encoder enables the timing engine first and only then
> flushes the INTF. The first frame is fetched with the latched pipe
> configuration, from the released buffer.
> 
> Flush the interface before enabling the timing engine, the order used by
> both the DPU driver and the downstream mdss driver. With the INTF flush
> pending, the whole pending flush takes effect when the timing engine
> starts and the first frame is fetched with the new configuration.
> 
> Fixes: 06c0dd96bfbb ("drm/msm: add mdp5/apq8x74")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
