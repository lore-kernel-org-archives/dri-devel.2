Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A34606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UFlPsP6N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b9EPVhqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C7410E2E2;
	Mon, 26 Oct 2026 09:00:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1EB10E2E2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:59:57 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4axv82727320
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EITttCplPBszuYmRY3XITt4UQcQyLGgPfNuHXF+5Hgk=; b=UFlPsP6Ni/9BBo8w
 bsRJcpKJmfnq3F/TPwop48kefP1i+H/QqCheh0KVa3P+uejNFwzIxLwT26hltKF+
 2jfLLZjYsEi7NFvvoj8ojZQ6/KQuSdDPHMD/7o139NLK7xP9l+hhnHVgYcMZsk8L
 ZQ5wpqL8fXckWanU3awtl8nmxk0P17qWRYFjAGcweH1OZD49SZPrU1raE1b6Z15S
 XSzUUdkQf7D3rW8T/CJ/xNRDE3XcirAPbXBkbKt+jXGzmXaNd9fsAw60+7vYpmu0
 1ms5Y7AOf4NvWPrzV8h5OrvYy47895KXSIHwaJvQaZwqmGSA0dZ6gNVL1uAvgqst
 MTXx5g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6nqjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:59:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-533758f24f4so3626141cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793005195; x=1793609995;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EITttCplPBszuYmRY3XITt4UQcQyLGgPfNuHXF+5Hgk=;
 b=b9EPVhqUEESR7DaY7iqw+k3a5+kzUGGuL5Nv1Pw7NiUF3u63zWziCb+hOjQ3wdMWXu
 OQNmxHSZtdoHqADjanRxjkjFn5VdHQ07tYI+015jgWLd9SZceJjkl+7u5OQBWTTnPst6
 XCuW+q3eTeORBcJXlC9nd/V30OGF5y2WwFNJDuCSHoYymQuQWm5ipfpN+YRBGIleQNlU
 R9Z6pbmo2x87M4x7QEdCm0/exEZTdICWW4sHYNVxZXYzSFAEvHfRgYtUo7MPprkXHwhd
 MLcKEXSGqUmJinxGk0BnCISHsQMjURAtIkP5tAaUyF7wwKPDlZ/g+beZ7Jn49FJqnCwY
 JJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005195; x=1793609995;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EITttCplPBszuYmRY3XITt4UQcQyLGgPfNuHXF+5Hgk=;
 b=uwyKjfRUWBaU7Ei4WONwXA9QqFCRBodMfznNm0i+XplER/iig27QuUkzySdmotPach
 TNayN/+6ry8nLIb/wRlgvANNNpI/L/S/BsFY2qVOxhNZsUNC0PeMR7C49grwZTooWeQR
 dIwB+zxOnT+G7oyp5s++heymXNJMQiSlRwSx/Y59wmqysF6723Ip+kagnrldK7FNI9E2
 /my7Nk+COwzYLhUJxKkBlXtvGEVmDsUIoOOuJrLWPZBFUWIMAMGjVOdTEgPyyVvGWmo9
 cQm7FGvsp6qehV3a/Q866wv+inUHh2Yygg5CTHuM3PIy3ETheoMOIKOZZRtQoq/tWim2
 WAWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaCsnl6X0FrqKWr8mZDMY0ZKfkgMjUqqwW278BFYX6V4bAYSIjzQBwu4Uqa/Qy+eR60rbETdFe+t0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJrjv6v3yqimYdsPlpiq9Oil8NF3bPHqvDipxE+29fA/qNEnG3p
 gGZEe7hWjeuCH6R/KQ2CJ3TqyPCIDTRhkXTwBA9ZzAoFCdcTO5Cbj8nNjItKjgoSI7CmuEBG01O
 3oSuZ9O4TTKp+cOurF6haaHj3QwUjJV3MOe9f/9BncjmE7R39UBoXusPLNMW5+BaOBw4cESU=
X-Gm-Gg: AYBFou1DAXOdkTY8vv97ximnHGqaL4/OHZp8nPE3lGAa52FwZKwt+R4cTWeVOi/laKH
 uWxSS0MKl7rhzP9HRW8L9SkdM5hvr5aoC74wVZSLv/iCHtyzhJeIDtuITQ4VkGVb18nRojIHQl5
 ACJKHL1/HhnswtvnBftJDqfq0n1cYWIifmE6xlQ2dloIl1jq4i8E13DvdSNiP5Zqit469EMfk/p
 WrMXfdXBiAoN42sgFPezp6ImWz1vfnkXsCzcPn+9WMGUpcqAoOtHciLWSvrTorDAYhK999sdcm4
 VaQS7okDMAXQcNAXNDwHDht4yh2RL3h13VbIkJ5QQGYj4ZKaXSxhwLbynfcf+PyjiRfPhjKLMt+
 bD17wLd781zs2aZPPVx2fIA==
X-Received: by 2002:a05:620a:8703:20b0:93f:a34:d9fa with SMTP id
 af79cd13be357-940ef7d5676mr940739785a.1.1793005195160; 
 Mon, 26 Oct 2026 01:59:55 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:20b0:93f:a34:d9fa with SMTP id
 af79cd13be357-940ef7d5676mr940736685a.1.1793005194699; 
 Mon, 26 Oct 2026 01:59:54 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b445984c99sm3437518a12.28.2026.10.26.01.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:59:53 -0700 (PDT)
Message-ID: <109df222-efc8-4298-9bc4-937ef9edb59f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 09:59:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
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
 <20261024-fd-kms-fix-smmu-v5-2-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-2-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D8cS0RQWHgA5TJzTzOG1eV9iIarbnxyt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNSBTYWx0ZWRfX0/Y8E+mKcE+0
 Ckz7jUlSnTInjnXxDHcbIKHgbzyRn+nraacuCUJGeFR7rqpjuaFV3rfqBDf1oZIVWQ4F5UI5LCO
 x6yV/4u/4mQZ12UUpKzKhZEBTHqA870=
X-Proofpoint-GUID: D8cS0RQWHgA5TJzTzOG1eV9iIarbnxyt
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adf168b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Mfa03keUj_DI804JYAIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNSBTYWx0ZWRfX9DiyM8tEiGP6
 04dqvXYAidO9Z39G5TFL0ADvw7lj8bjWlQq2ofhZGeXi8dolhJSwRmgDM6Emrk3lRekLhujC+ps
 dgEXxJ1s0Dl34mVX29rjyI8TMml3yWnvD6eV7QrHU2PQ7mY/8i+FZL4wNlk1ptLSclTaO9Jr7+N
 SfzcNNBlxd9QShO+zZJ4chzYkW5zCd2SDteQf7WQiNM/JVkvqgu2ob7JI+ukVp7WYJQOlXU9Owq
 G242QkuPgGcSsskMVQxxsBWEaWCXQPon3XRF5TvOTQtXLm8OA143iEpRCdqUG/0NGp9XnzZ/B0i
 8Zgfm60qjGAi7tKy3mjqmT28gubLMJGOm5UFrwKjSzzF90hJ3w2fyrae1YO9sMz7/HahrGg1/yl
 hoUy3L3D+O8TR2LzInuwFpcx2ECEaqGQW7VJLz1ieCR1xLn2LWEwDhl72xQEUWsHT3GGB5E9zOQ
 tMxzMI/BLPeyiz5z4fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260035
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
> msm_framebuffer_prepare() bumps prepare_count before pinning, but returns
> straight out of the pin loop on error, leaking the count, the
> msm_gem_vma_get() reference and any planes already pinned.
> drm_atomic_helper_prepare_planes() does not call cleanup_fb() for the
> plane whose prepare_fb() failed, so nothing ever drops it.
> 
> Since commit 8ac37c88f991 ("drm/msm: Refcount framebuffer pins") a
> prepare which finds the count already non-zero returns early, assuming
> iova[] is populated.  With the count stuck, every later prepare of that
> framebuffer reports success while iova[] is still zero, and DPU scans out
> from a NULL base address:
> 
>   arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
>       iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11
> 
> Unwind properly on failure instead.
> 
> Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

LLM:

Regression: writeback path double-decrements prepare_count

DPU writeback swallows the prepare error, so cleanup still runs for
a count that the error unwind has already dropped:

1. dpu_wb_conn_prepare_job() (dpu_writeback.c) calls
   dpu_encoder_prepare_wb_job(), which returns void, then always
   returns 0.
2. dpu_encoder_phys_wb_prepare_wb_job() calls
   msm_framebuffer_prepare(). On failure it logs and returns, so the
   error is lost.
3. drm_writeback_prepare_job() therefore sets job->prepared = true.
4. drm_writeback_cleanup_job() (drm_writeback.c:501) calls
   dpu_encoder_phys_wb_cleanup_wb_job(), which calls
   msm_framebuffer_cleanup().

With patch 2, the failed prepare has already dropped prepare_count
from 1 to 0. Cleanup decrements it again. Because prepare_count is
unsigned (patch 1), it wraps to UINT_MAX and never reaches zero, so
the planes are not unpinned. The next prepare of that framebuffer
does prepare_count++, sees a nonzero old value, and returns success
with iova[] still zero: the original NULL-base-address fault.

Before patch 2 the same path left the count at 1 and cleanup brought
it back to 0, so it was consistent.


Konrad:

I had a hunch to suggest using refcount_t in patch 1 and I think
we can go forward with that

Konrad
