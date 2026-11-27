Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eCvRqXDb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HcNnUHpj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD782112CFE;
	Fri, 27 Nov 2026 19:11:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3726B112CFE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:10:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAnLB3038544
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=qUJKQY+6chdkwpLeZq8BndlS+hMFSdfQnsQ
 2JazMNJ8=; b=eCvRqXDbIa3DKZBgk8oFuNz0VcpsB2ggJihA1wNBhB/S9c8C/aw
 ZB/08H4o2ShRZakLs7qc+Dfm3yi+We3BUHd/F0e+9iWl3qjK8dmBnXJi7ccxiKO/
 9zrIYIlQmSjcbwvmNFKjp7YJrRcp1TCSdrCbifdxu6gwppBYIhecZNRfkjnFmkJc
 I75yj5TtaR84S5v3Pq15gzsaJA70t9cQ40exEALvggGXUXAo/f+2VuQqLB+ds7gq
 IJkJ/oLx0HDN8/8KlJNmR5Ax0820DOyBTXEgk+k5UHi1HriTZYBRUICdzudJBviA
 jCHyoVOpwjLgl8aOpUT4AKLpgMGp0oDyZ8A==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e4ng9b0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:10:49 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4574f1cac98so8130305fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795806648; cv=none;
 d=google.com; s=arc-20260327;
 b=ZtR1grSupWvvNoZWBat09XlorcEdQPxlWvlCcEL1++NgLN1fQV0rqMPzsEfqJEGhMU
 QIljfxlqLoCSxKSO4P4gzG7pDe383BU8kUhqEcX5QGFqRvCzp9hVv8XWO6iz76T92aWx
 v80S0kmoskgZ0M783IoJV67nEtCBDD2C5lxCSQwagUePNu3bKa4liZff24sjpbP4IID5
 UxY907SKH4fvbLb5nfohdDc3mprZLYtFDKzNaKawGD24i0Gs/0qhn8J23CpleGVLiTR/
 qjgBNN2YLm6Wq6fqpsgc5gfiruvTL8vFToibeDNgfR5sXa/8fKLgnz+Kp+D4nETmAHdi
 xmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=qUJKQY+6chdkwpLeZq8BndlS+hMFSdfQnsQ2JazMNJ8=;
 fh=clP5otieQdioyjYVtAEEb7JREOhkmgJhgNXNlt6LZlA=;
 b=OH++qP/p7Ez5dZGhrbv/2SldJ/Voenqy4p2YkGGY7fnI1dNxT0iIscZtX7uVFwOGGE
 8tvbKcsP36xj6C6kir6u5McR/AF94Ma0xLICsHJVpG/ohCxWLYuwd+xqBNPdCaJFs/6W
 r5Ic/4vfiFUyXVweBoBy/myZUspasgAL8VqCod/h6fU6FYf/fK3qVwrTYXy+LS2S6/oa
 5cG8nbbm82d8wffS4wXJj14oZLqFDTQqrTMiX0IJCqOyUfAv5rBAsgdD8IHdyGOLOBNK
 Q+lSxXXBrr2dnQkRJ72N1rHDN5OOW9DyCIbJufCkXMud2N7fMKzN2zzhrNvA/fJDFEUR
 cYdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795806648; x=1796411448;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qUJKQY+6chdkwpLeZq8BndlS+hMFSdfQnsQ2JazMNJ8=;
 b=HcNnUHpjXpPcCse77v5LCY5BXmlM6pzK11vXcZ8rK+auRzn5cESRxJG6A/WrvYyAa6
 NEJevE4a7F+0Hqc4QcaDgvvUJwxzLZnaHxoq8xXgLnNQXxxHqVlMkGgi4eketUCd5JpR
 a9xYHptlJelTJDfmIO3pgXsxgK5/VljlPjno+Vwfy9UT4Xs1iikVduxpaH9A+ynasKNf
 sB/RN/IppH34bDyzWaCxy8ZxkvMCmjxTu72/F5y+tjwZxVpz4kRYtpW+rc4bCH2oGHcl
 HZ1hilpQlXLgSqlNq4AVgIMbP6Lcvmyn5wnSxFcig2a0A292UfyY7QZrYhMKwbpWpQww
 WmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806648; x=1796411448;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qUJKQY+6chdkwpLeZq8BndlS+hMFSdfQnsQ2JazMNJ8=;
 b=ISOP5seoKoLQnsjjFJq3eRoZNy2289FVW6p2sCVFMrLQ1GNhZcmY/VqBdlqesv8Dm/
 jcwNW6gpgjGeB0Z8K1IE4w8Q/zucW48Pp0uEsRWOkrWvnQXgpCZEOCjBXTrgElLT1+FR
 /UQx14kYvZdFlVJzR+CeX+pNqVhgYL7CwKemQdeNzeZwhIn3z3Toj/UJqQ8AtrqvfM1B
 0RoeF/3ooeDHDfXl2RnKWA8AM+qqBW1r0/dcYJBTV1F2Z5OIuba+szLr8WbW8O3BYUKD
 brJJ8KsSfGaWvVyCVmg79d/SyLcHKh7ER+RLBoY6LLERSLzG3uSrVjA7AIVBnWuXCKKz
 pGjw==
X-Gm-Message-State: APuU4Z8XUUQG/5+R9FSJl1Ujg22IKX3JyCTIrV3vGrny53x5ULzwIejI
 GrXo+cPgwP0KZA8hqZ+lz5E0nzuwUEPr4gQlgplSi0GNh9rKIoqv+7OlhB+qjrY05CZzkrhuk5s
 bKHt33X2UYgab9M2s8wXRyZzKmTzEZPnkEGGo1JSnLTH415lo9CnhzOQ6j591T9MF7TBigWof9Q
 0SQ//US9xYT24/a+S6l4iHkRkggq45mOSIdOYuAuUMxlLj5Q==
X-Gm-Gg: AZFdTZdhZcvpChOf5cv88XSto0hCHwKxU2e3zQnUQG1ZNPPU+W2UAdmlfK93er//Peo
 n85QOwpE0cWsAXht/ohPlysWOf/wKadFMXycu+BO8YnUkTew44rtKzJjjv2yY7Na08J/LFOW3kR
 oWRE5Nd37ZUNwceSbRPNNNu72fb6vvD4lw7zGhWwZIchE0mqKznLNBmbGzK95ZDiPyUZP68Q6s5
 FPy4c4xpxGDgSnehpXXIA==
X-Received: by 2002:a05:6870:c087:b0:4a9:58d3:b60c with SMTP id
 586e51a60fabf-4bc835713b6mr23882299fac.32.1795806648353; 
 Fri, 27 Nov 2026 11:10:48 -0800 (PST)
X-Received: by 2002:a05:6870:c087:b0:4a9:58d3:b60c with SMTP id
 586e51a60fabf-4bc835713b6mr23882274fac.32.1795806647955; Fri, 27 Nov 2026
 11:10:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:10:37 -0800
X-Gm-Features: Aa3M54or7po1wOJDBldCWAtXw4-4b2F5L7dB7l0quEcTlymd-Cv_Z8mSfMZvETU
Message-ID: <CACSVV03hO_QBSuk9ueAKve0PF5wkXYY0FXWBq1c3mvP374Ggcg@mail.gmail.com>
Subject: [pull] drm/msm: drm-msm-fixes-2026-10-27 for v7.4-rc5
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3NiBTYWx0ZWRfXw/6JoEDVhucO
 YLzXV9ZxNm1yxp5FfTISCOTXt82J169oQuktJ2rmgJRMJlu7K+5miUjdMa39h/mhVqFCNwVCKGt
 ZTSnGrRllP3OMq/2lEGXUCyD7spCva4=
X-Proofpoint-GUID: cBlrRZYPt2WxZugoHl16ahjPHE_WBf8V
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6b09d5b9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8 a=AAlKfgPkOSAJutToXukA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: cBlrRZYPt2WxZugoHl16ahjPHE_WBf8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3NiBTYWx0ZWRfXyjVTRS1oxTQy
 EyYPorfzU+VJixgRtpl36WqAiaAzA6zAfTSw6eCw+SZNYzYMMNFziGH/1hzO8ctDTeMKZq2iox7
 yhliV/SQxsIpGdhs85ZafDcLGfvQlR6x9w1Co9a8Vt4GFsGh0aC0IxhU6gnI831PkV9cMM3MSd2
 FUC0Lz4SVj9CQvKhdxpSG4fsu0hhGPraA+KwnvzFBndo6TpxLkyr2KjL8wVVPASsgW2WmHUHGWk
 EHQpk/WPUHt3WYsICam5W4ZxK2FuaqqU7OZ2cEv1cY8CA/rZE5WCgJ/JOx/0edujGbrHVxx1Vb7
 mLjBVjsoz66VEujG4I3IZdECoHzNLzzQMDx9vb8yHn/7lzKnIJxTHLZlwvdVcNoJSe7xeb6suFM
 tGpfujXj3/If3am2BZxP2qwhWwFeCvrw2vATFlDPbRg9nwKvV6O9mxFi8Ig51Pcn2+9MllNEd8l
 /AxGvD49kHcP4FStcRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270076
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

Fixes for v7.4 as described below.

The following changes since commit d024361c631b3f020a26c07d683e5103404b0fbf:

  drm/msm/a6xx: Split out a7xx/a8xx device tables (2026-10-10 15:00:45 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-fixes-2026-10-27

for you to fetch changes up to cdc466fd769b9f29887f5921d2db5b7205120973:

  drm/msm/a8xx: Add missing preempt_record_size (2026-11-25 05:31:48 -0800)

----------------------------------------------------------------
Fixes for v7.4-rc4:

GPU:
- Fix GMEM_BASE on gen8
- VM_BIND parameter validation and related fixes
- Reset preemption records across suspend
- Fix missing CLX request
- Fix lock leak
- Add missing AQE fw for x2-90
- Fix 1/2b alpha filtering precision on gen8
- Fix priority inversion caused by commit 38f922a563aa ("drm/sched:
  Reverse run-queue priority enumeration")
- Fix missing preempt_record_size on glymur/mahua

----------------------------------------------------------------
Akhil P Oommen (4):
      drm/msm/a6xx: Check BX dependency vote index
      drm/msm/a6xx: Reset preemption records across suspend
      drm/msm/a6xx: Request CLX enable from secure world
      drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU

Bart Van Assche (1):
      drm/msm: Fix a lock leak in msm_ioctl_gem_info_set_metadata()

Connor Abbott (1):
      drm/msm: Fix GMEM_BASE on a8xx

Jie Zhang (4):
      drm/msm/a6xx: Fix GMU shutdown idle check
      drm/msm/a6xx: Fix stale boot up BW vote
      drm/msm/devfreq: Record idle_time at GPU idle onset
      drm/msm: Fix sched_prio inversion within a ring

Rob Clark (7):
      drm/msm/adreno: Soften no-firmware message
      drm/msm/gem: Fix VM_BIND range check
      drm/msm/gem: Disallow nr_bos for VM_BIND contexts
      drm/msm/gem: Decrement loop idx if handle lookup fails
      drm/msm/gem: Clear nr_ops in lookup_ops() failure path
      drm/msm/a8xx: Fix 1/2b alpha filtering precision
      drm/msm/a8xx: Add missing preempt_record_size

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 31 ++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         | 37 +++++++++++++----------
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c         | 15 +++++----
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c         | 11 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           | 12 +++++---
 drivers/gpu/drm/msm/msm_drv.c                     |  3 +-
 drivers/gpu/drm/msm/msm_gem_submit.c              |  5 ++-
 drivers/gpu/drm/msm/msm_gem_vma.c                 | 11 ++++---
 drivers/gpu/drm/msm/msm_gpu.h                     | 24 ++++++---------
 drivers/gpu/drm/msm/msm_gpu_devfreq.c             |  3 +-
 drivers/gpu/drm/msm/msm_submitqueue.c             |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  1 +
 16 files changed, 101 insertions(+), 60 deletions(-)
