Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD19CCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C6810E636;
	Fri, 15 May 2026 12:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MtOaV8z0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNJNWijA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E72C10E636
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:41:33 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBFrFw3197601
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkN
 FvjRNZcI=; b=MtOaV8z06trh6NO3LAF/heBio6dZNdEbOp452Erk8v629kS5Lvn
 F9R38O1CKMYEk62PpiYch//xGHy2MwSXpMVHvol0M+/ppsEBMiHWus8TIK8casn0
 2MK3/uRSCC7BAHMDE8gM5fffYsThRh3LiTWQtogrFJLyl9vTWT/uQ+ZEibjjGEAV
 K6A/UPyjdFvuJ91HPBZYgbQw7IlBVJWxnry+2fyjaljqMkcrjSqw0EF2nWMH5wVS
 BqyUVBLzirNCq8B5PuxBR4nYH9IQ4Fy77sCGlMLHkY4tYn7yWuI8GOJJi1TcUocZ
 CquZFqG9penCqYgnqZVM2+soVACIHtqBxSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qb8m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:41:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-369166fe5e3so2710730a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848891; x=1779453691;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkNFvjRNZcI=;
 b=BNJNWijAFplPcMCQNBM4fi0Vxq27bFT6wb+jMNEbv0cKMv9u1/MOv40/VJhgXBAlDX
 Ky7URazhAls73CCvLO+qv3KLutpwvLUqPqkhbHIlAygWlm6rI7zs//mofo6oNn347gT/
 wf3tQ1TsJba6StoRhh2yRCR6iC3WVM0mKGppMTMPLui3wFQmXyQvUeBvhp0t9z6bUp9r
 M7RcbT+Ck259kHz1Iycv5vVTqocz4IfASwxlQcky6G9yfaiL2DB53McbXfeyqJJI/SRg
 EH8TPqcossaJHfgNTIgk6Qd22wShmhFf5iH9tRzprOkscoYbauPXIKXRtaly9qU64s8b
 YI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848891; x=1779453691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkNFvjRNZcI=;
 b=dO1Iipk8yNFRAGHGpy2rf6VUygcdyC0vyG0TrYf1yZI2fMx4cmgqMcMRatQGUmBXVc
 sHJErdWhsyozCoXdXLACyRzEWCMpF+wPSoBc4Cg+zwvxTTMfya4JAP6GSZjLuhEk432a
 G4dZP4arZWHfZEA+v4TfaneG+C3SFbqMnuD0AsxCvMxyfKfCqXgcbby8IxOtELtlZ1QX
 ZsUUw8Rsq6cOqo7bPjSmO1dYpejaBIH50w95NOVGmZd/Qe0304USoRwKI/fetxukvCDI
 Ajsm8OGO40CC0edsU9/w6uct7oDWkaowRl8vx+QznehmJ5FGSR5mvMuC2XgZACqw1ZaZ
 BpUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b/n+vfRT7o8hNtj2qb4Q+KrZLyzDmpxz5YiJy3OTvLfmIyEK49o1zBgqq3NRzlGHnix+bnVwWqwo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlTaxu1d7UOPk6lfZjtO1Zo4rvrjB1GiCemoUoBTeYazWU4apq
 /YTvUc0i3Dt1fD7sIxbkJCE6aki4QrdVFB7bBh499LTk042+RnFJyWdPJ0aO3knFopDkioixyIq
 LPppYSgZe+HRSr9p3LzizQrVb3XqSkCELngWAk1xS63L7na0sGwi8O0CQGii3KHxHKRT3Q9M=
X-Gm-Gg: Acq92OHcF813P9mxOGzCssc8jCILk+4VcJZjf0ftLwXJ5b64sg/CJXJD3aBNW/fOJO0
 IsBZcwfDj29Xb10a3WanbcOauKGTxENb9OIDmWW2q4hV94kkuBIRyL15Z7Ffm1rySjKG9LkgGzv
 IewGrlVkTaHg373JfMnZ7fbh/Jx9SxyPkQjOkkp9kmXUHDjvRVDI9KAS24egeg8J/EFbo8Uyxk5
 qpOE9KAEsG+mQ/GqvbM94bDw/IqY4JJaYpZ/u5zRa6AXY7A7FU4kLREc0CVq2MxR+5NouhAL56P
 Pzs5/2SCRqRRbFNgPnVLOqaqixQXXH4upjshMX51qYovnqjCzjndFuavNjgIT2n5Xp0ZvmjJ8NO
 JwWy8oDdgZXpGwNlt+OT9wqHIQVAPg/VLHgH8drOX9kYRDW8eWYk=
X-Received: by 2002:a17:90b:5648:b0:35e:27ec:de0 with SMTP id
 98e67ed59e1d1-36951b971e2mr3588932a91.13.1778848891280; 
 Fri, 15 May 2026 05:41:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5648:b0:35e:27ec:de0 with SMTP id
 98e67ed59e1d1-36951b971e2mr3588899a91.13.1778848890751; 
 Fri, 15 May 2026 05:41:30 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com ([114.94.8.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd60275sm54910485ad.7.2026.05.15.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:41:30 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com
Subject: [PATCH v5 0/5] misc: fastrpc: Add missing bug fixes
Date: Fri, 15 May 2026 20:40:05 +0800
Message-Id: <20260515124010.20679-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xMBH3E6Kq99n_TseHhGIOEm3_xzF00n-
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a07147c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mSfM1xQJxAVIrMv2y48A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX2jl3xnOixI8s
 ewwN90EZkebj3h/3z6ZeHQ9HYNElOMYJf0cInhHTUnPxME1L5ZDHTZnury53rIWD95PFuQq+7hi
 6tVMU8WAbgTBzyXOfggPrxOmO2gTBl5t8KyI/tn6WWGQazA8KNOViR3I/mMKQRS3LSwvXR62XvC
 7YW876kK7G2f8LQHmMYfXLfbNGJCUWgKLDpCG04xlY8UVfCUTs0bFHRoT3GQdjM1QLSd/pXHYg3
 iK+QpyunhsY/kyE2nqQywds9VdtT2aPKAy1QKI2JQPh4LzDZVIpn/UusAd2+esUYiCykqbZEVap
 gRLq+mFz7FZsoB41W9DcC5WQBDiVT27Kvz+M/P85veRveKHQRjnsY/AC08/uvHtghMe1Y0OjmvI
 w3q7QvaS8XXysgdmkxUXY8/glzFt2StdiaN3sZOcL2oj/bzkQvyfdM5a2IVG+DQ59YWCYScJb7u
 oTeTCRpgukq+GYRVktg==
X-Proofpoint-ORIG-GUID: xMBH3E6Kq99n_TseHhGIOEm3_xzF00n-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150129
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

Add missing bug fixes in memory areas. This patch series fixes multiple memory
handling issues in the FastRPC driver, primarily around the Audio PD remote heap.

The Audio PD uses a reserved memory-region that is shared between HLOS
and the DSP. Allocating and freeing this memory from userspace is unsafe,
as the kernel cannot reliably determine when the DSP has finished using
the buffers.

To address this, the entire reserved memory-region for the Audio PD is
now fully assigned to the DSP during remoteproc boot-up, and its lifetime
is tied to the rpmsg channel.

Patch [v4]: https://lore.kernel.org/all/20260409062617.1182-1-jianping.li@oss.qualcomm.com/

Change in v5:
  - Split reserved-memory handling into separate patches

Change in v4:
  - Fail Audio PD static process creation when no reserved memory-region
    is present, instead of silently proceeding

Change in v3:
  - Adjusted the order of the series, placing NULL check changes that are not bug fixes at the end
  - Modified the commit message to describe the bug background in detail
  - Switch buf->list_lock back to fl->lock
  - Add locking to the operation of audio_init_mem

Changes in v2:
  - Remove the if check outside fastrpc_buf_free
  - Store the spinlock pointer in the struct fastrpc_buf instead
  - Allocate entire reserved memory to audio PD through remote heap

Ekansh Gupta (3):
  misc: fastrpc: Fix initial memory allocation for Audio PD memory pool
  misc: fastrpc: Remove buffer from list prior to unmap operation
  misc: fastrpc: Allow fastrpc_buf_free() to accept NULL

Jianping Li (2):
  misc: fastrpc: Fail Audio PD init when reserved memory is missing
  misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

 drivers/misc/fastrpc.c | 135 ++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 64 deletions(-)

-- 
2.43.0

