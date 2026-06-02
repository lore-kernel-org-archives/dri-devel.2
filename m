Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B5ECD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0394B10EC87;
	Tue,  2 Jun 2026 07:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mvvBIJvE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMDi8Hlq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44DC10EC87
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:17:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tnCc1855109
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IEO53fTfGnYj/uK6CggP7yVALgVJ97/bhq7
 uN/lgdLg=; b=mvvBIJvEB1XNVOWuTCDGtvFQ4QXssMi4xBUIH7937bLuSajmpXd
 Xtp00Qb9L9+/8ZZOSyaasjRomZChRa+Xc+dUA+Y/A5maxwJtBT5qdCJw8g2d4vAR
 JQRA8px4oI3qurbeaB9GUZk2u/68bQVctsK+CzEggpOgzMR0LJkcO5wMkl4+k2LT
 jvrctL0jtLZV0VTjEgGUIQz81em6VUDjhlAdSl5BsEAQsWNnOQf0gS6aKLvJQ4Ii
 lp3ZGik28Ikot3gxzX952fhtK/z3bb7WIUYSXvPLQZ9UHhqirP8AVtYteLUmwTIu
 tEw/qVggJbR69rCgnW/qA0VgX7YZarKfBLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf78aa3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:17:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0d0516ad7so23594565ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384678; x=1780989478;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IEO53fTfGnYj/uK6CggP7yVALgVJ97/bhq7uN/lgdLg=;
 b=hMDi8HlqZ4N+LObAYSmFndqNqBgw+zhKadY+0EP6+7BCeykH4rxjMsOkXnoO/bOtfT
 ENdVCYoJ+Ug4PbUZoVOwieaaJ1WdOPolZDYRPS7CuwD+rHzCwi7vTs8fQtzQ9j8l6u06
 r8XmYjzFR+5uxQB73sKpbjReB2ut463so/+8vrrbrvWZyyIWzUa8E80sXVqU5OG7N4TL
 7IF2N7jIjmJic294ysYMf5KjVgTeGeuGYferby2ncXlYhUGeTplqkeFa7PN4iAmnfO99
 l1ZENIWQ7+KPZ+cBod5vpuNQYmtjnOaXzUgm5db5xBnUJn5lMmMDY5q0NVaQV2YFUUeF
 4DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384678; x=1780989478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEO53fTfGnYj/uK6CggP7yVALgVJ97/bhq7uN/lgdLg=;
 b=ZZ+5TiA6pXNZx4r+6JfzpGnrRiKT+Wwugh758GGmbjX+kjf6+SIvI+U5GPctPZqxZc
 hpsQDX0YRiBwO+sWGuCDrGGt6hdhUsxa8EQ2sS8z/9QigbmFe8sVlS72m6aE+NbVDgXA
 eHzky9p73KL8/PTIWDAN5/s5EiPxUdmlapkbbstoiCiuYRRfXd4nK4v8uLsOb4GZLSkt
 lEjnrgjvsip2n0T1nzwB7pmDDPDdNT24/YupdLdMLT+SMC1S9PsyhrlN86qOyzcKhGW6
 dg4l48aBnvTwwW8va962zTknkN4APEvIywOu+T3hO8l1JOEpXgFmU6Vx61THV5OX1ACd
 A43w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XXqX1n4gH7ZuDG64pfhTNsRKbV/j8E9GizP4rpNy2pvcVVp6oirsJ117IoSBRQGYMqywmMBXSCfs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzub8sIVJ4Ld4CMtFqlXavguQvyaQoGWkq9XkvBS1T4zf0RTNwY
 u/RTTpNKCOaQFlDMwvvucwPOPL94+FQ5f9yxgCljF46j+Cb6cDX+ZDUwxTdw7/Tntm3cVqT9Gdz
 g+FTFe/dSHBswdHkPbvkkB+i2d+YNxyBWGMti9STlJN9lTT9vjpSdPB9BywVJvbZVbbznv+8=
X-Gm-Gg: Acq92OEPgZdMtwZQXUI6kiuII5qzlNctlBH6XBLkcceXctj+BGNgDjp+AMUvEX9qK5A
 B9qJtTcSFPJGD1q+NH3MNkOpOTtvKoeeTFAL42bA0MX47yikjb0K/2bN3keJZS2I6rYIhmGuZJD
 X/n6WQXIwYlB8l08GKFShZ/ojivyDPbqx3K6+KcuH7jJxSsbq0SofrUjPR0shUPce9O8axe4aa0
 O4H8TbnKskNCH2jfFcpijaFc/IYKQo0TwaedI/N0q/Lr3a+/Rlr9oXHXbVlnmwlNuvojqk0ZrFk
 8ZsCJCl+IVwflJgnZmrSKGYjxcka3FpvUAp5bTHuOYo9ZVN7mGWzF9HtlmJbFlbDjELS3ls4Ksw
 NbS0jEmUKPdfxyR2j+XEhuOK5TZ0tMH3daTjdM0HuvzGJu6eGrCJ1MqnRTMuM/OXHLI7auyOmSJ
 an8BSj2/FnN4zuu/6Aacl7moPWzMH8QA==
X-Received: by 2002:a17:90b:4b47:b0:36d:ae6a:22fe with SMTP id
 98e67ed59e1d1-36dae6a241dmr9389526a91.16.1780384678463; 
 Tue, 02 Jun 2026 00:17:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4b47:b0:36d:ae6a:22fe with SMTP id
 98e67ed59e1d1-36dae6a241dmr9389491a91.16.1780384677982; 
 Tue, 02 Jun 2026 00:17:57 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:17:57 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com
Subject: [PATCH v7 0/5] misc: fastrpc: Add missing bug fixes
Date: Tue,  2 Jun 2026 15:17:45 +0800
Message-Id: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1e83a7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iZgqdknpxvlyNCGGVIUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ENAvVgGax30g_Zxa90jSvcxhdf8DDz6A
X-Proofpoint-ORIG-GUID: ENAvVgGax30g_Zxa90jSvcxhdf8DDz6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfXxsWzhMBed+80
 6rx7df4FpgvsrYZj6Q+iza90Lg06Uq3A22+uAwcGToLLqYrHIrS5AG67gOI1wCVfLPuzGdvXxRy
 8uvELekvKnMF/Dwf+LQvDlfCaLeCGl97cCdx+yPbeQyVOjRwO5WFlM7RIhfSMfE0MhGrMiabag2
 vsaRSFJOHg3Ne4mPSR/x5h4MLrC9c+vlGPcMeIJZzsaU7L5hhpMgaJNKtAoGhgEVfnCSurE2OTB
 fKJnTI4UhSEPoBKRZ5j63VC8AabL/+W9TKWDxMYNGW8+ztNN7dnRjQJnQe0gsu9RfZBqlK9yPA7
 Jf9tVUO4zuj5SEt6QX7zTGke83Ysrb6Pb7AiaxCBLWtyTDbzZTmhcsHLcY8OvbV9tFJvkN72oN7
 S7Dr/7b+NQBgI3mkE5jZhLFhBh+66zp++vKa211xxLNG6QArPeaPtea6antPuKJb4TdAmjdulkb
 iEGkI37wX5a0InQXP/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020066
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

Patch [v6]: https://lore.kernel.org/all/20260526111124.515-2-jianping.li@oss.qualcomm.com/

Change in v7:
  - Removed duplicate remote heap validation check; keep it only at
    the beginning of fastrpc_init_create_static_process()

Change in v6:
  - Separate the handling of err_copy
  - Place the check for remote_heap at the beginning of the function

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

 drivers/misc/fastrpc.c | 128 +++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 62 deletions(-)

-- 
2.43.0

