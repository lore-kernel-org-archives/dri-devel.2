Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340B606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XPq/q2OF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c3ZPoIUm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BAE10ECDF;
	Mon, 26 Oct 2026 08:56:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E252610ECDF
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:55:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arIt3303594
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FXg4xpgpqKJGIQZFyp8YqpU/D9tULXMJ9qr4Kv5LHP4=; b=XPq/q2OFwelomY31
 7jQqED3q7kO/Cqs3O3TBMuh2NdmHiVYuEeI8yXDtPrCTE8cWgCkIZDM9VBqpqceD
 Bs5TR97unIMvVfETuhEci3sylb4EA2F8OMfihATxiWUaol4oJnKgs6EDij0Ypjvf
 y9fmmIA4fR7neiJBiwIn/TYxF1lVvBL81PMS8gx2n1GF3SJg7UJdJjR/H/N0zgG1
 jdikEkgXRVD5gPQZ+hHSV+cXkqZn+C5aSIQe1bPiohMnlSU2df4+8Rjsu935B8Ha
 g2n79KAFb1NjKwQ1FMt9A5f+UykW6xIbVZF6WqagWLEdrNxKabZXUB8dCNQgWIBq
 8Kkuhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdnh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:55:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ea6b66e53so35139385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793004951; x=1793609751;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FXg4xpgpqKJGIQZFyp8YqpU/D9tULXMJ9qr4Kv5LHP4=;
 b=c3ZPoIUmKaM1p0FzC1YhQqO65HMxmVX1z+OOBL5DL5qGlvLxzYF9nccejNivTmE2av
 eyVhe8WQHBhZkYOxNafVnYk3vBduqtYz75b+tcC76bb83qJyf/sHe2EoBMdxQXRb2H5L
 8PkCuXzpn2E0fe4op9zAclxeTsRrzzlT2SNmzZCh2bLUMIpFXkLw+qMzhhxWveImM1UB
 jR6czIgAtiyk2qaIAF2kevZTDWt8X5g9ILuNX+JrbICH1lqz48Ibt0gVOxvmggqqCEG+
 2llC2fI9KOwq+V+8zXhM3TGwYL8aOrW47g0inzwAgU6hTOmyg3tze0iNNkeL5CoXn97B
 pGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004951; x=1793609751;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FXg4xpgpqKJGIQZFyp8YqpU/D9tULXMJ9qr4Kv5LHP4=;
 b=M+Mq3e9Rbz8sCEB5svLGtuto5eQVdq8ScJGzrxG5uYdCSTQYNGMUlKLG86JK1xMs+7
 aWppeOGOrwOdUwSf+aZA1xjphCljJHkYB0r48cL5Q34I1gQjX5Voz1Wa25wHzHyEvEv4
 Jz70ZNAc/pfh3lXGAhjUXJb97hwjU4FQtfjb9RW95OEqwDSOviyznrG2Buy1p7dWbrDH
 2SFssZfSXP61uU/2hu92P/idpUVLqwvn0zZj9U1s1YZZ+AmG2vjZue7oqmDVLkRSrGOs
 dTkFM1Zm4IUc00h2Ak8TMK/qbMp8PVJAEJHEO7rBRsT+Qi/cdaTqqLUR1VSvmX46LDfM
 nLEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp4Ux4TjIHMY2qQNaKBqEKvG5bYucQORjy9MR0VyUtQlEtpsbwQenINZByYQJxwQRZWWeutOOx2aQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJV2vQGEJqf/dR/e6fRRA6X0Fw2AmXJSHQdFXj5h2dnnLC1eZ+l
 SaQoIRW8BeUjXQ+PsQhVKb8Pums+du+Tbxv6QMhBgb2r83jOUgGoDKJZlmin6YJxVZfQQ5QRFA3
 YOIShwAbXgWICDEbj3kx+DfZXiRbnyumuSAKVq3j4M0oMy7VTweqDg6Vrq5gRByoTQ+ilt3U=
X-Gm-Gg: AYBFou2ZToMT/Iy7lMljXoHglCNv93TWR43wJdsTAgn9kdcF4PzsFt+oSEdkFXSfG9w
 Rdw1QayANLaXKsIybrnrZnfrJ8A1Jkplnu5AEzDslu2/qIcjADg/UHc776WVjp8dLwEYubW4BrN
 OdJ9KRA9adcI4HTpkG3M1BSoOCR1dkLNUTo72JF2ziIntNoTfY3uT+6j6RYgXJJiShRmF24sCsR
 T7PVEQfCewhjTp57FEocV3b5fyrvbxyMP0FCpGHPdK/Vg+fux6AElg8kCtYUqNqKpb/HIGy9IDf
 4A/K9ve23o4XHSz9OSD6CQHIrNzUWSJ7AK3thjMZVtM0MO8qpHh1YuCq3uk3XAAjYwTUloCCGRP
 Mh/rDXWsU6gFioAuAYPfOdQ==
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr990258585a.6.1793004951328; 
 Mon, 26 Oct 2026 01:55:51 -0700 (PDT)
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr990255085a.6.1793004950822; 
 Mon, 26 Oct 2026 01:55:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595d5e8sm3412794a12.6.2026.10.26.01.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:55:49 -0700 (PDT)
Message-ID: <0453a913-37d9-42cb-bb4a-511c112d21b4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 09:55:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] drm/msm: serialise framebuffer pin state
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
 <20261024-fd-kms-fix-smmu-v5-1-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-1-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XhZMkUZ1dUonzuEbriXUpB_UB362Cew8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNSBTYWx0ZWRfX8BQiXOBhEYVk
 IZ5RQEJ+c7qKyaEfNAxZ3jz2BZ6EGvF01smIzKL62yet4ySTa6YZ2YOFGz46D6g5X4fgypvoDql
 hE2GizKua0ASBJmIk7Xu06tArwkmUXvEVWyrt5zvw53OguqQOyfS9/dKSBWZ8bmbAMkO3VVSPw4
 SRS7NdeNEcSypsjEomLPHJw/17OdOjHXhbsiHuUayiszuzDEK0ghd/e4dQhG56wHlUSrpdIYRc2
 2exfUjg7Cpxqp48hUFxSpezoHk3m7g2lugfEw08kC9KBxwGIETT5UMGk3+JdA0/0iIdltouKYcY
 A2KGLhwJR5RPZDMAI6yWr1+4+J86XRL0vzo0H0+HWM89FlV2+WW1O2psIRzKIdqcdnZ/xT9vD/C
 Sr7PQTQZQBR7DcxybnxF+2eFuh23KMjzxXj0/xWNbKh4RgpOC5WVViEWCOWWASEnR6RW2UbXDWZ
 AW2qcl8vnXYVG/GWx1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNSBTYWx0ZWRfXwOrG5XKZ3Fpb
 xO/SpCSqJIyto4XnhvSxBilzDGRsw44sHmir1JA3Z4E1bg+SuveSOw+u4DtLtJy1k7cUZahZIr9
 3X/QcsDuwo7PeWo6a/bEExtdp0uN7Z0=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf1598 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=II6hZ13XIzipqfIPTBcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: XhZMkUZ1dUonzuEbriXUpB_UB362Cew8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
> prepare_count, iova[] and the pins they describe are updated locklessly,
> but drm_atomic_helper_commit() prepares a new state in parallel with the
> completion of the previous one -- stall_checks() only stalls on the second
> previous commit.  Commit N+1's ->prepare_fb() thus runs while commit N is
> in ->cleanup_fb(), and for a double-buffered flip that is the same
> framebuffer:
> 
>   cleanup: prepare_count 1 -> 0
>   prepare: prepare_count 0 -> 1, pins, stores iova[]
>   cleanup: memset(iova, 0)
> 
> leaving the plane programmed with a NULL base address:
> 
>   arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
>       iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11
> 
> The opposite order is broken too since commit 8ac37c88f991 ("drm/msm:
> Refcount framebuffer pins"): a prepare which finds the count non-zero
> returns at once, assuming iova[] is populated.

The clanker thinks this is correct and was able to reproduce by doing
something similar with a test program

It also left the following comment:

The mutex approach in patch 1 has a direct precedent in omapdrm, so it's
a sound choice. msm is unusual in caching iova[] per framebuffer and
then zeroing it, which is why it needs the lock at all. If you want a
fix with less state, the amdgpu approach of not clearing the cached
address on cleanup would also avoid the NULL-base hazard. I'd keep
the mutex, though, since patch 2's count-leak fix sits on top of it.

any which way:

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
