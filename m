Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD38606A323
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LlwgX1B9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y9UaeZgA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B5810E246;
	Wed, 21 Oct 2026 13:08:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF55710E246
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:07:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LCjvpZ630026
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uHps6C48bjErWLWTA2jyVj+V
 /HCuKfjWf7ze/6BLmro=; b=LlwgX1B9QPTmQmXJZC3FEVbGiGYzEgnKeg2Kv2j2
 x73Z6bydNkiDaDZz7Rkt36TgSMxA0Tcon7A/Qkx9jgOD1Gr1bX7uiFUeqxlYvU6m
 OBRVwUscuRRKuGqCYTHFdWJ6YCGGMfYt2upE8FItNlJmVASCW61RC9znVFkT611h
 tqRBVbVLIFrFdZgtmkD0Zrpc15+/D0sDRrbJ517N8TSD0K8NaN0Wn7VtvRpn7Q3f
 sgmJ2BUqwy1GDryKVySzuOW+wr9/z4nWf8gLxYeHV9EiBoR/oOkdP8pvQHlcJ7xT
 YSeiW3AYBYrq/mrwwj7o8LrXnjMRdplYPaRd1j9irawV2Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r33nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:07:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so3276163eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792588071; x=1793192871;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uHps6C48bjErWLWTA2jyVj+V/HCuKfjWf7ze/6BLmro=;
 b=Y9UaeZgA8ldha9JVK/fxgDvnt7vlstIXZrW8DCPzY98XkYt9jU4OTd6/S9t8wM//YR
 54shS3nUNpzmPtSyGbFY0xwcQqiem9QHIGzPEbniqeCiK0Zr3fXhFAK4ugg2mbtjUv+J
 mhHGep9QYss3tH7e7XgLyFYY1GR5k3Dm8/1YHQ7DpI2hqta5jR/gnwj1XInruA14EO2X
 O6g2Qtxs1CwYsoT4YbCAaxTIFV0vLLylN1qUCUA2PifJld7psdu0oKcWFCJSC85FHtvR
 JU4umoZ6O8NE/erK9iytAjGp1AZR+RUc1SnOpB9De52BBNDpKNlVdBqZAgJq34UnXLNe
 q9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588071; x=1793192871;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHps6C48bjErWLWTA2jyVj+V/HCuKfjWf7ze/6BLmro=;
 b=kT/Bf09tUDnsyk7HpXWqVdI8MUf2eg5Tgjzbg9lMqy8HWbbTfSJNmXsW8w+JLEfjlq
 tUXz9mp0+PP+7hUYSeCXtluLlAzFwiw9ZP8WClDIHhuVpJvujvOxowsOfq+5/J8oM9dL
 Y7W0caAfKTT4awgQse3UombZVWQIK6OKOR8Ivma8cTUX3w3Xq1LQRvo/m/Jrv0mVCa9a
 DWl5+eNgu4ZLP6UGjTkCCaJs4kFBjUaewKxoUud3r0lNuwawDljkGPJA8aM5+IcFpv3r
 KbC++Suok1NDL74YOeI4EwRbgTe9qodTxyC5bSwpz4uMjZ2rZYAFZtXG3twX9HPkPqGR
 y+gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlazm6758zZyRaLINXNRdf9rk7dHZ7BWw8nO7rm5ZTka4HOE0VnCnw8J18xlKgKQyGG2kOMasx6rw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLF6zdANbUCzSK3KijxiW+aiydnI1g90D5oinpoLWJUPEsIKthw
 gSiV99oUW/0jj9NPXV/L61teuAIhaH+4qJFAT/374uJy3Mq3YGE1NTWpMF3e5MojZYZpZ/H/711
 AJiibqeP3j3Ucq7xtGrbz2zXfwsoLkD1Kev9J029B+j4dLu+ScB1XcqOH9AJbd2dhXxmqCcA=
X-Gm-Gg: AYBFou1STHT2c5M3ITFh58rdFQi2E1rLeq6c788X8bRkuJEq6ss3cBcpvv408fVUlOy
 1KbcTSGmcVaPeQroLn9zHNtkezM0PyEHTOT0O7k4gnae1QK3YtrWlNVlcKBRk0tL2TLbRm+VYHB
 OTNPK4NsMw5p7hDIZmRUg+KXproSRR9dOf005I27C+q36c3nzW5jWyUUU0QJzGNEvTol2iOkrw2
 NLnbGjAGT88ZHQUCYDT0bRFnlQXz2I+vyIfS6dEdLxUpQmqojOQuEWcFYVrUEFuH+GvrdW/eO40
 UxIb2gicJsRiiG7O3jix0m9j40tMTEJsoVSOvNS8fFNrspw9i5JmUSyIupj1QL6Afv8zIyZ6H+V
 S71woXfjEa+Bn5kGoqhtFDIQFZA==
X-Received: by 2002:a05:7022:7e04:b0:15c:705f:b981 with SMTP id
 a92af1059eb24-190a67fb474mr2783339c88.32.1792588070419; 
 Wed, 21 Oct 2026 06:07:50 -0700 (PDT)
X-Received: by 2002:a05:7022:7e04:b0:15c:705f:b981 with SMTP id
 a92af1059eb24-190a67fb474mr2783235c88.32.1792588069115; 
 Wed, 21 Oct 2026 06:07:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bf5d0a1sm6052461c88.14.2026.10.21.06.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:07:48 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:37:35 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Message-ID: <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8b928 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=wXrbNP8IbqZU6GI7zsQA:9 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Efr32FmpZa1QFrPUSsmEugPQe6xbntEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfXxNjODkN3EHc8
 qQrF44bY1Y1d7nTpFqZDoZEMtOfbKjQdC0viy2s4zS1COiGr4xvWJjq83ARVx/m/OqnTaLDGcR2
 aJTmaRFw8xB64F2MQd5DEJ+XE5SqeYbOOuH4bzTrl67A/q1DQilzU4cL/hem39Bfe6aU2eBwutS
 pG5ki7FABDCPL3uonDE/4HuABVH+WTbO7ShDkXxC1EVUqGZqG/903mI+elvu0rlTe3pBxpWCrNF
 04dA5aP3bVJuHTmrAIK5PoKmaJIz3i4JmW8b1PhzD3fU9bF0PySD18WF2w6UMKO/7chxiSDsqLM
 gSVsRtFFp8Z6yIdkXczT4nBJSdyAM9LOFSruI80AuAXl4o+OWhtJ/Zo9Yq/kUw4dj/gA6u4SEnU
 1VnOpy1F1QF6QaTy5pICnH9Jxd3GukuJxQahdastuK0XvHJ5hFd+RfUPMbo/weA05ojzPH4YFIm
 3C2N0gRe6T72/85DeWw==
X-Proofpoint-GUID: Efr32FmpZa1QFrPUSsmEugPQe6xbntEv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfX/FIYVEQFUu0B
 r5c5paeAlT1OT5X/dFsJZaKsHjYTEswfqxM0rDIlIoCd66tHlP+KxOc+oPtBjt8jno0VyHrx8Ie
 bHjkG/4t7hkIX95Bjl+JDn9JGOkHZlM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210052
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > public function, migrate every user to the new PAS context-aware API
> > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > 
> > This series migrates every remaining caller of the deprecated APIs
> > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > 
> > This series is based on top of although no dependency as such.
> >   firmware: qcom: pas: Make MDT buffer retention explicit
> 
> LLM has the following comments:
> 
>  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> reload, because qcom_pas_metadata_release() is never called
> (patches 1-6)
>  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
>  3. use_tzmem is never set, so the shmbridge prepare step never
> runs on SCM and the commit messages are inaccurate; TEE gets
> a real mem_phys/mem_size change
>  4. Not bisectable: patch 4 relies on the NULL mem_region
> handling that only arrives in patch 7
>  5. Patches 3 and 4 don't apply to this tree; iris
> iris_detect_firmware() still needs mem_virt after the load;
> the base of the series is not stated
>  6. Patch 7: NULL mem_region now means "map internally", which
> weakens the -EINVAL sanity check
>  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> persistent memremap()
>  8. Patch 6: ctx is set under one scm_auth_enabled check and
> used under another, which is fragile
>  9. Patch 2: the context now carries the full region size instead of
> the MDT size, which matters if use_tzmem gets enabled
> 10. Patch 3: stale qcom_mdt_load() comments remain in
> iris_firmware.c
> 11. Patch 8: no issues found

Thanks.  Will address them along with Sasiko's one.

-- 
-Mukesh Ojha
