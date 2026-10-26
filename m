Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E5606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HE5Ej9OG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K65QCqnW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4494310E2E3;
	Mon, 26 Oct 2026 09:13:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E80810E1C7
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:13:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xN2E1912088
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 504GS7G2c5HvF1fzY/p3b+yghdp3at25Pz8Gt9PufVE=; b=HE5Ej9OGUxYGrI8N
 YKB+QS0Q8izHhB4qTjUsd1Mnr7E66NzQri9a3l5R8+cYFJHrRhgK77FsrOZvlbUw
 R32p9NpTqyhwXI1diVf635IA1Qk6+XUNiQU1p36fqcRqRRSJ7z73DtJ+wCcr2kTc
 GhaIMdBfug8bY7wCPqXmmkgTIWc/y1RwRikL2ObtwQEzrSwtFPlfVsTNqmnbrQxR
 HWsVRR5/nUjwJ+VgWEZ8bOe2fIhEb0MMkJi4cQOf2Ub1I4z4JTMWr1oGaTGKqw2k
 jR1UBzyEDgvhql3KRKQ/ovLU6aUGihyLLXO+3q119Zy/rKcrYYPNHEEHVFghPWcR
 97/0Ng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u601mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:13:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53568f05f8bso9732841cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006020; x=1793610820;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=504GS7G2c5HvF1fzY/p3b+yghdp3at25Pz8Gt9PufVE=;
 b=K65QCqnW2QcsT8P/qAlJ/Rsu8m7i3vLAYn/8Bb2khPuHzPoWHa0WwFGYrYDwDA/0si
 oFUHbi5nqxoQBVq0PBhj7dw176ZSXrBUw65UjTpP5r/CTUZY0hyCn+FmzTasxAwUFvFY
 TLXcNDy6gnTcamszjrVGGXK00WejiDVzgVJzzJIRwRLidi22SYG5pswAxAazzVFvd5QT
 PkIENVd1q1ov5mKEk1NyoEHXyRl5QqrWI5bry1Hnfw8XYu+5Sj4SMXCPfS0Bn/T/Djck
 +yyjDDxmxJSKWdfelAA44H4scFI3OdkWJGWm2s+WkIqMUGYbM3ZgjFAGyqsGYvM9YcaE
 n6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006020; x=1793610820;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=504GS7G2c5HvF1fzY/p3b+yghdp3at25Pz8Gt9PufVE=;
 b=Wykj5dAhjQq4KaoRJTIxwFuN25444JYUg73/YldYCbowWJT3+kbHfaPOE9abBw3eah
 MXjHxwcuCSXGn3vvep5xMi+goN8BTCEvPpV95SgPDnL0JYEr4qSLK47SHucXOH+MlyL8
 6A1BbTa6iC1hqXVbsQLe2rp96BzVXL39ueBNmZGcRIQA7K0OTNpINQNDCQMAEACQxcKj
 tGQzy3+mgJq+yg2Cf1P239nP3nI2QptXmd311wBARXHutBE0Bv2eFvul+O+GShD63l75
 iujIX6CJA88XOR7MbjlWzl+qiHsAe9+u8/4HRIH+ytpe3B/0vSQMZSMi9T8LcQv9dSUF
 wxwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHzrRWJJnylcoWkwV6iz4oxqEBA9i8u7GrNHM6XWikdU23H7HBKsqMbQKjhanngvnk2//ZPJ1LlYQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKaozkmIvFw+n+k4dpbOxTXb4kzL4mTBNx5SHut7yUg+/76k4YV
 vvGfTdlOgJVY9bM0xjsAzNDlrHlYJdke/3ExmDMekC45kud1XGtT12jOpOWphFEUpRsgOhd/wcT
 pN2ljnWMu/fFudGU2B5BMWzU/sK4cX4K19LbknE2pUJoJp1L1EE+pN0AEv5Yqk3ujb/RG7ZQ=
X-Gm-Gg: AYBFou2wnj7isWJTRiUT1rip4K8eBL62i8O/EoNp7px4If8ErpRHtMEznej67xKQNV0
 gHQWHOqYpIuLwjoa8Fcfi/LFkxBduKrX7/1kruSJJgIc6/VEql9ggjUDIRrNArazST/Y08iSVGW
 tZzFbT1qNqhRqeF2M+05bMe7FWRd1exjZdywGlAovkLAz6BWHy86Ni80pkDALgAfbtGcsjMvHr6
 H6z8mQ3alA4lbbCUSc+Ip69F0je3T0jdNZWFYYQkaQpnTTjRA9Pfv3dNYCOR+V2iPwr2x/UMsjA
 Z+rZmuup3i+N1e89K/AGh/9HDbHZt+CrIjEVeXAr4uV0GQM5sA+co05HboV3eP2yTo0dqvEbcmc
 S3TX9h3tebeyeLlQxcW5OMQ==
X-Received: by 2002:a05:620a:4918:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-940ef7e9992mr970011485a.2.1793006019696; 
 Mon, 26 Oct 2026 02:13:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4918:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-940ef7e9992mr970007185a.2.1793006019169; 
 Mon, 26 Oct 2026 02:13:39 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66bd3asm295841466b.56.2026.10.26.02.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:13:38 -0700 (PDT)
Message-ID: <d9d6a2c2-545f-4b48-ae19-dc30234540e0@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:13:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] drm/msm/dpu: clear the CWB blocks left by a
 previous reservation
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
 <20261024-fd-kms-fix-smmu-v5-5-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-5-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bjp2MwquJOPy4gmUD2fh23ddGWcLx6q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX6gRZ75BJnCE2
 RwI7wkPtVvgPLpvqt6ew3e+FIO30wXHui8YruHotqqJG27Bz1BQIZC+k4t4a6Y7ZaD5cRRriw5Y
 tCPiXVbk4qWqZMn3UKUVxitfsPAOwQUXzr22lm57/YM9cvTY84wbyFV6JYH53KlIh2IZdxhtLM5
 aX8lwX9IZYg1JMT14J1k/KPWLb0ED477Bm2NS7KThBz3vHTNrDvoOF8198c+lGINEkc6UV2BdAL
 2p9iglYzkq3i5H5M/HWypwaafbE2d64jXTXbBRDohIkps81OldNAWuEgtFyy7WcLWrzSUkvSeTm
 6/pqNiAfK4ndA9yJEMRdYZcE1Wkvox5VLeM41zES75zPGsqy5EkHdIDgPWnQqbrPDDQLOdGeC8O
 Wfee7hSRwtbxPtbCrT10EpxHT1cRMYfNVhdDpM8u5WnsIPyl5doXhPCvz9TS5db4ffpos+awuml
 1NHxz/PKUbWUR0dFa7w==
X-Proofpoint-ORIG-GUID: bjp2MwquJOPy4gmUD2fh23ddGWcLx6q_
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf19c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xIhFS8ZktLuDZ2I-VrQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX9aKp7L/9p3rd
 LPbMDuSeJi6FCGac8/vgAJJInMZgbUrB0DGBiGOAEB37aQwYh1G2vzOyBIOFjNaP4rCEK1JWM+D
 9DjgLHETcczC7pxu4rK+Z9pY95gqDvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
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
> dpu_encoder_virt_atomic_mode_set() only writes the first num_cwb entries
> of dpu_enc->hw_cwb[], and not at all when the encoder is not the
> writeback of a clone, so a modeset which drops the clone, or reserves
> fewer CWB blocks, keeps the pointers from the previous reservation.
> dpu_encoder_helper_phys_setup_cwb() then walks every non-NULL entry: it
> programs a CWB mux the crtc no longer owns, and looks its pingpong up past
> the pingpongs actually assigned, in the uninitialised part of rt_pp_list[].
> 
> Store NULL for the entries which have no CWB block, as is done for the
> pingpongs.
> 
> Fixes: 5008375443ed ("drm/msm/dpu: Reserve resources for CWB")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
