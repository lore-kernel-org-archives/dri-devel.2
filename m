Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD5FCA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00C310E66E;
	Sat,  3 Oct 2026 02:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/PV9svv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJ5GRrMC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0B410E66E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:39:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6930Jjgd2790579
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 02:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=V4R6vTFZHRxxof56ea7ZkuigJ6CJbKK/4sD
 1d+syM7Y=; b=D/PV9svvGzfEUxvJ296QVavCvtrmj6yxbxL9MZ231vs/OG1hd9k
 OvDPctZWYBhKI9hlsHD9stB76aMnOj8ZV2v27D/V2QaYG6FtGmaRyKO/mnrcC3Gn
 T6eLbJNASJv00rw0Sr5/6ANM1JU1fAscvV/bU3FwfsRv4QhmPRLihkc7Kjpk31k2
 HqCWlIyH0FPMhZi7PYORIZ05o9bwk+hF7A/FrB8GSTH+mlLIW2TdPkBl0sAOWgiR
 RqzyOfD90Ze2xVLGkslcqx9MEJh2VN29gEmoZ6VdGTV7J9D9uiqh9lW/rH5U+jkS
 f0F/LAxip+a4PdiAv+AMT73SJ0HeddRZ5WQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2q2nr7xn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:39:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3282d5302ffso265665eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790995142; x=1791599942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V4R6vTFZHRxxof56ea7ZkuigJ6CJbKK/4sD1d+syM7Y=;
 b=gJ5GRrMCD81ri+o2f01OsSLWLBtrtn611uZ77DCFhzw+cz4ovCdjZek0ai7wORvJIW
 am38RdZ+hLAYNvops/5nLvyyWReE5+NgbNjDOonFWBMD5F6hZayCp3+aO7gwWi+3SdH9
 qOz7xZMv20pyFiBG/oSDDzTvaoXfT44NDhvbv3Vk75mhNrTM8JVUlode+bdDCZYJHTXy
 yqv2Y1YY9AObhHF1bFF3KKnhv8NYXVn21DGqjARSXzVvBJxZmwBSkNaKVVotQ7z6K2l1
 pGEnZBBrG9/G4DD4AiaY8tLvqln3W3b5eSBU79Ihb5Q+ANOEw5E0KtUUXHjX5+/iAH+Z
 zaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995142; x=1791599942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V4R6vTFZHRxxof56ea7ZkuigJ6CJbKK/4sD1d+syM7Y=;
 b=c7ZtYtusfVJ1Kkb56RV7Bv9r4vVNGRcs8MuYBo2mUOEbSu4trAaN/+f1KDF7ZKBIcM
 tsxq5lzsGhze877PZVk85/2Ag0Fc8eBJJHcJkefZIS4N9Ax6HXPtxkgkmqMYKCwYU06N
 DiInRoZ+1F1UP6LX5XO2zQqIt6glUzhhxO/QX6BqyMnhm7pFPlMdKr1m5LBsKHmDSnax
 Wh0aCKffAehfi9gZIqQosiiaahf7eJE6ROjlJZBLKkvZybOTtQ/TJJz3wgdIPAXyLYqU
 uUfl4yUdvlJwT1kXVjgloVuhC+yFHn8Atg2pf2zcptb3FhADeWrOQanSc2LUFhGCbhTL
 UPKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0VIhqCRdLdMTl3tNhdN47luv01JnpOvKTFxAkZV4Y72Reg8chbaVWSeEdS7jp+OO1dQn5P3ZNTq4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMSM1S9ZTMwZ0wE8YGd2QSsREqXcIVAY5HVYCBJP0Moa/Ykm2+
 J/vRIVy+hiaashfKFh2JTcaKQT/bjtNV6NUrIzXZ0aefkF6a10JGb7yRwpJxscsfVthM4TcC5my
 B0ibEKxOuEfZxZ1ox2BzWGC3IWIY3amNYlnKRyP8HsDBFA2k5e04YYijfTqXqxAfybMLKzUQ=
X-Gm-Gg: AYBFou1gyqM650SkXWSbz3q2YA+vDdkT7n3261YTa6n+csb/v13uo0h3XIATuLsuDKS
 tHSVX/Y7joX49XLQRyWof9Au3MPXjYa7fpUleZTiovhuNBXlpNmRmvoBFaNWVhdEYY/oAJAA9eL
 N5b2Z6VSnksjPqYekSZG2jikBPIHNapvYsfgH9a2OyCZFaX7KjQu84+jxnFB0NJ2+9P89JN78xC
 aXncFO4jNjels3U28XReW+ST7IkwUQVL0K1re158oCvtVCNIJ/kQ+zDk7ogOCOV9V7j5arL3II1
 H9YJbqAsu4N5RRM2eE3lMXlIOt6qgBTAOWpaaPUnv/anO0vHmeh89kwztNarTzCNuDIZlzRQ/Tf
 jadRvMQ8CV9YZQmF7NUTvBx/r89jpv2ieW41BY3CJXteDpTdYa8tIwf+y
X-Received: by 2002:a05:7301:46a6:b0:34d:7c41:cdf7 with SMTP id
 5a478bee46e88-34f150db269mr4243385eec.6.1790995142353; 
 Fri, 02 Oct 2026 19:39:02 -0700 (PDT)
X-Received: by 2002:a05:7301:46a6:b0:34d:7c41:cdf7 with SMTP id
 5a478bee46e88-34f150db269mr4243359eec.6.1790995141678; 
 Fri, 02 Oct 2026 19:39:01 -0700 (PDT)
Received: from carlv-linux.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3510752b575sm7665736eec.6.2026.10.02.19.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 19:39:01 -0700 (PDT)
From: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 0/6] accel/qaic: Use DRM Scheduler for submitting BO reqs
Date: Fri,  2 Oct 2026 19:38:12 -0700
Message-ID: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfXyqDmvS2RpN3Y
 OzcR2ACFe1UxElfJ+7nbg16SfTah1haIFrYnMMxRmaxrL2Zut6MM9eSftSQWizLaglgRLOv2Jkc
 s/Yr6jx0DYjLR+wCPgOdjIWRj0a3qmQ=
X-Proofpoint-ORIG-GUID: togUjW4olBAmxsbyPK5ATFj8PZnqDYYH
X-Proofpoint-GUID: togUjW4olBAmxsbyPK5ATFj8PZnqDYYH
X-Authority-Analysis: v=2.4 cv=SKHXx+vH c=1 sm=1 tr=0 ts=6ac06ac7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=zmZmqXXhmGQ7dVXqUE4A:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX5LbrgDXhFX23
 gbe5RVeWyMP7hZD0aovojKoAa4rwUOfIbT4flsmKSC4zTG0BbaXzQY0XRtilKDHePFCOvfwD03y
 lY7sWoiZ7EoV+euZBxouFflvUgzpWelTsbrWqchlQpYNLLVJ/XcPt9bvE0u7p8ktC0dfo6+FccF
 M/xG/tZwkQ9E0PxqBipB00YCNN2DenPMGEAGKG8Sa/Byx1WdDAjrCjMum0rW7gm+J/PujHxDm/f
 gSvQ8WPIxDBo+pQ0dc+KV8R+p9gvUcq8iUhHdjxZRFv50MYFyzuo81Fv9I84iV6WzfXuhg30BZ8
 Dp7401J88VdVjoLf/fYVi3YM7FQeKm0l69tdNv2OCkF7w3J2WSgFfs5plwhHTbuQ53BHanh6xrj
 TGmbmYpbb7eP8x7th4TJzG0RHgHPXkj4kqqdBakpMGcfjHrgU/jSPQB53EDeiglj//cJNLpZD2i
 FJaLpfhBON6okhjeGGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030010
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

Hi,

This series converts QAIC_(PARTIAL_)EXECUTE_BO to use the DRM Scheduler.

The immediate user-visible change is that BOs can use DMA-BUF resv
objects to track their use. Completion fences are attached to the BOs
sent with an EXEC ioctl, allowing userspace to synchronize through
DMA-BUF polling/epoll rather than relying on WAIT_BO.

The scheduler's credit system is used to prevent oversubmission. This
removes the requirement that every request generated by a BO fit within
the device's FIFO at the time it is submitted. BOs with large request
lists, including those resulting from fragmented memory, are split into
multiple jobs and submitted as space becomes available.

Implementation Notes:

Each DBC has its own scheduler and one scheduler entity, rather than
creating a entity per execute command or BO. This is to keep as close to
the current submission ordering.

When splitting BOs into multiple jobs, a dependency fence is added to
each subsequent job. This prevents the final request, which contains the
relevant semaphore and doorbell commands, from being submitted before the
rest of the BO is sent.

Each job is assigned credits in proportion to the number of DBC request
entries it submits. Since the requested size of the submission buffer
is not known until DBC activation, and the DBCs are initialized during
driver initialization, each scheduler is created with a fixed 64K
credit. At DBC activation, a per-DBC scaling ratio is calculated from
the FIFO size. The ratio is rounted up when necessary, which can lead to
small amounts of the FIFO being unused.

The final patch uses this and the DRM Scheduler's credit limit to support
buffers smaller than those requested by the user (preventing failures
occuring due to limited DMA-coherent memory).

Each scheduler is given a WQ_PERCPU submission workqueue with one active
worker. The default ordered workqueue showed a throughput regression
when large (32+) numbers of devices submitted large (1K+) numbers of
jobs since the single workqueue provided could not dispatch fast enough.

Testing:
  - Ran checkpatch.pl
  - Built and performed functional testing against v7.3-rc3
  - Production use with kernels v6.8 through v7.0 with 96+ devices and
    16k+ in-flight jobs.

Target tree: drm-misc-next

Carl Vanderlip (6):
  accel/qaic: Centralize execution info
  accel/qaic: Replace transfer completion with dma-fence
  accel/qaic: Isolate hw submission
  accel/qaic: Use DRM_SCHED to handle FIFO submission
  accel/qaic: Split oversized BO requests into multiple jobs
  accel/qaic: Use reduced size allocation for FIFOs

 drivers/accel/qaic/Kconfig        |   1 +
 drivers/accel/qaic/Makefile       |   2 +
 drivers/accel/qaic/qaic.h         | 182 +++++++-
 drivers/accel/qaic/qaic_control.c |  36 +-
 drivers/accel/qaic/qaic_data.c    | 710 ++++++++++++++++--------------
 drivers/accel/qaic/qaic_debugfs.c |   4 +-
 drivers/accel/qaic/qaic_drv.c     |  16 +-
 drivers/accel/qaic/qaic_fence.c   | 173 ++++++++
 drivers/accel/qaic/qaic_sched.c   | 249 +++++++++++
 include/uapi/drm/qaic_accel.h     |   2 +-
 10 files changed, 1001 insertions(+), 374 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_fence.c
 create mode 100644 drivers/accel/qaic/qaic_sched.c


base-commit: 0915fb19e08f7f14a03df78c67d081bbfa8ff1fa
-- 
2.43.0

