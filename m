Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C7606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iy78WORG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NzVEZI78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6440810ECDE;
	Mon, 26 Oct 2026 09:19:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C07D10ECDE
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b0TO2806300
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n9MudQ0NaHJP2SfNJ4CqXFHWBa7zfJmnwB9phhWhgS8=; b=iy78WORGwPeWAGI9
 z7s+NJqkRJDPjiGphkUqRD4G/WxwyZxs84YzVslcs70p10trDhQAt3MgJ7HOnv/I
 vYwbrT/UhU1HTX6nDrt8Zt5abLEPdhNfva29hqAxtc1aBS2cuTU6/PzLycmm++3I
 DupcSUEmiOz877jWhKZC7APZUkTN4lV5DfEfoerl6yOiOFTcQ3W9KjhHjIJltvP8
 1g6FHyFAaMg8ZiVK3beJXbAMeq+yWBvJbf+m732RbbYUIRmvwcbAcqTEAFmLSPgX
 X8HJ0SF6kLUFY9rqLxjKscr2GZTgJ9nNTAYad3zM9yglbq9WLjxuABgcl7nHapKz
 aayNrw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xnr5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:19:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53635fe2335so2849651cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006351; x=1793611151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n9MudQ0NaHJP2SfNJ4CqXFHWBa7zfJmnwB9phhWhgS8=;
 b=NzVEZI78s4tHmNkd/ZPlY1bG9NnNlAyHQiAuw3R8RcM8ZI+biwjgv/WnVxCFZDeJ37
 y13yyGP3qcsstsQt1WNMTWnVYbrWqRQpUP9KHYlq8o4r6D+ntyshh+OBOHEOokmARgwc
 ijWgj9Vjlp54GBd5zxsxN0xAlgyN/K7JGOOexTkauCH5kVI5SBjAj17aOuCHCy6fSxLk
 wLJ5E/SW6dwB3V/qKeosq3gXUBDGtlJZeEoVZxeVEyUCpJYZcvr9JROReln2EWueaSoB
 nr0uLw+xwOw4TUlBxvmR6pEWfKONrrzDkI8gApw59V9tmtd+T6pXxsg2j9iZbsS3ZQGj
 05uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006351; x=1793611151;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9MudQ0NaHJP2SfNJ4CqXFHWBa7zfJmnwB9phhWhgS8=;
 b=ZW0snaFNQarvta7EXWzmh5WoyKhi5IhXbw/rvpExVJFh7zEp8saufquORp4i04LdUV
 cnB9cHBrMbn+7tBuGWaEerNGu2K20TcrtDGhfw1m/OtZIXRpmn7sGsY3syQJ0N1/RJlW
 jW49m7IrNCWc3Kk8AZwcVF4xyFVfpiINOtTepvDDKdr2ucOsTkm56u0npeBbGnf0QHYV
 X9oeaN9lWl3+5pbFgm4tA5Xfvi64wjMuoCC6U1Qs6vNHviYR8FlK/4kIS5WDsc/ETku0
 NvykjRBST09gyGRjAfpDWmQH77ryXoO77EXv6PvW87KtG36uEZdy3DYpD695EvCr3NWq
 Druw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbREbLMD/F/5/nzf6tsm8Wb/H4R2+1otmDj40+mseseLi94AnJVoHhei3lKmrfVduTE4yXyiQkj1U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUlM4mTrEHyuYKjdRX4+vsz2oKMZdqQfZs7AvnZkmGIZdErpMs
 8s3qmwCT7yXfF0Hka8Ax86fVDPAXwgtiSpVVuP378Zvm30a8Kt2FpiZGVWA65NHunFiaQgbh+Yl
 GCft/pYUY3L++xh0ctanQcgXvWUiktiGKmIU4R2+6Vm45C/WbboeWP7khnMTFi653iFhIDe0=
X-Gm-Gg: AYBFou04vbaKBWIySo+5AUwA8L3wMT7omfFO71QIUPq3eM2QVKbCLVNjLhNpMRLiNin
 rPj8X8P8O7SB/9NBak6dMt4ykgZNcwK8XHVJy0uoaQJhmnbr6Zcnen0pwe7pTYtrHQAxautmv9n
 s3onhW/NC/b3Xd2WHOufkSqLuAio3EZuvyxESJwI8rcDcRciCGXkQiR8ykBsF1JkFgioSD7gLiS
 VtdDp6muCIV3Tn9wbRyPKneQy1Gi0eTbgLycm7rDjoY88pik5tdxW7ulRqlfK/1PVvmD7t1053k
 3HHI4PO9z7w0NNfpcXPxP9gpuJjRlgvrykh/0VDiGcbcTwxQkaF+3vagfiM2J50N+WUKPspGkWR
 CWtfgeykTW7F73y0Z+tKj3A==
X-Received: by 2002:a05:620a:4bc9:b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-940ef942706mr813956085a.5.1793006351411; 
 Mon, 26 Oct 2026 02:19:11 -0700 (PDT)
X-Received: by 2002:a05:620a:4bc9:b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-940ef942706mr813951485a.5.1793006350822; 
 Mon, 26 Oct 2026 02:19:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f95csm299862866b.5.2026.10.26.02.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:19:09 -0700 (PDT)
Message-ID: <86bf919b-5528-42bb-aa89-b518452ed7a0@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:19:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
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
 <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fVAPQn6gqVh7Vr9ZaAMNI6t-3YvTc5mg
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adf1b10 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4sCBZ3MT6_yhT8qeVe4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX0kDyUxiNik49
 pqqIw/xZFTVc/GqJh8wUJzrzU4/NIPUme6f9lKjUMuGvqEaE4TnZWRr+F4xq/woAidNV6R9sid9
 hdqM5FJ2Qz+IunUdRMQJd7hSN33tWFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX9inWhUO35QA0
 rMBsSGcyUbcf1JzX5EBxdPRPyC0r1nsKJZPYze39PEyrJPEbRg+NFwdt7kcpu8SZ4NSNWIqvRg3
 IMpAV38u5pT2YegmGqJbFFAuWe0FqAJ0QMVznk3rouSBEHGj+n3c/BmTXsgg6fuYjZD/dVC3Wiu
 Y6uKCUuBP6znpbqRkcqlM9Ealy5N25fBWRhHYWWsP9MpQQAyJe/1VlhwXuC8bzZ4P5TuDUNp5pm
 Qnn+MoTrWh2ERiPXvf4x5/DnXpF43nQR4FzRvKLXuptyyUMk32vU9hZpdC4+NEiM9YDuTw5yPTQ
 HJ4In3oaQx7JuA4Yp91E77E3w8jyaZPQkeWOQpJ7gVZxRiqDgV4NC9UCMiw4Hz4V4TPOuubHx3e
 T4ylxapUg/I8veG86IXWXDLgWK0Jv2f1cJNv7mZ9GPFSagbihUdHthbCgpMWSTrhEcUbORgj98w
 NK0y9Bp3T7gJ5K9AJDQ==
X-Proofpoint-ORIG-GUID: fVAPQn6gqVh7Vr9ZaAMNI6t-3YvTc5mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260036
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
> Running kms_plane@pixel-format-source-clamping causes SMMU faults
> (fsr=0x402, iova=0x0001fb00): it sets a CTM, after which the display stops
> updating, so the test times out waiting for a CRC and the pipe is still
> fetching the framebuffers released when the runner kills it.
> 
> dpu_crtc_atomic_check() reassigns resources whenever color_mgmt_changed is
> set, but crtc_set_mode() only calls ->atomic_mode_set() for mode_changed or
> connectors_changed.  A colour management update therefore re-reserves and
> can get a different CTL: cstate->mixers[].lm_ctl points at the new one
> while phys->hw_ctl still points at the old, so the flush mask is
> accumulated on one and triggered on the other.  CTL_FLUSH is written with
> zero, so the pipe is not reprogrammed again until the next modeset.
> 
> Reassign only when the encoder is reprogrammed too.  Enabling colour
> management still needs a modeset, as that is when DSPPs join the topology,
> so ask for one in dpu_crtc_check_mode_changed() and only there.  Drop the
> msm_atomic_check() hack, which forced a modeset both ways, ignored
> GAMMA_LUT and overrode allow_modeset behind userspace's back.
> 
> Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

LLM is curious whether turning off CTM/GAMMA should trigger a modeset too.
My hunch is "yes"

Konrad
