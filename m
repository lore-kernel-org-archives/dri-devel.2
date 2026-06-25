Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983BACDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E448410E24E;
	Thu, 25 Jun 2026 19:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XE7T3LJP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IyEf/R6W";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB9310E24C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PGKs0W2799661
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=uCz4HSt/dV0azaZEYvFQYeRALcLMsCkH8qo
 rWINBu7k=; b=XE7T3LJP38kcY6/dj/8vTLLV7SvfY0QX4aawwvgkaV6sQ6YQkD6
 jRDKXhxoCkabE3/nhqQRJtX4msZ1pmzz/14eRLHB218qVJbJuzlqL4egtl0l0g/0
 yFXYP6jbS/L85rxb9RVozt30z43oeS8n7w21BB9JqXfLECjc/KR+S9kEQe2aU+04
 vT6Psw/91RZT5E3wAmg4H5f/rxRQi3wokT10MBZVKtSMRffoYhuv+NsSdTgZ2gG7
 J6mJsqtiIjODbLXmP2zHBeBD35o8mOPf1aZja64uWFn67szTKK78DvdLHhnNICwx
 FSUN7I9lhYPHGxKCfHWQGVRGCHVHjgLWh4A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f17s8gtdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84534f17866so67024b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782414943; x=1783019743;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uCz4HSt/dV0azaZEYvFQYeRALcLMsCkH8qorWINBu7k=;
 b=IyEf/R6WGl9cqeNVYRNENk5fUp2AMFustIm+BRqjRsXoPYWmH6CBrQhm2nW5AuVjlZ
 Q045V5KNUfkJ2ngYjBx/MhZFU+0W8qw3c7qIz0XEAggqR0lfuGP9Xxu6xhO0qDPMxSXr
 maYoMRken5buW0CddtMWvkjHNOR8MWNhfaWT40jI4bepBDSw4TfVbGvZ07xJT6qjbafq
 j7SA7km+ipzkr7hEAuPxRd+lf+O57x0cEXw5QlcJkUiQ4LQzUdNcOsgpyUm4DBRGEO55
 jw3D7PTlHi2L27zUU1FShSlKFZVeuXGRMciNHf8PukzTSMLs14y2bqDR7IfHdaV65e/C
 ydlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414943; x=1783019743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCz4HSt/dV0azaZEYvFQYeRALcLMsCkH8qorWINBu7k=;
 b=Ias9t65fD7tOT6E65nbZ1VSjWFJ5q+sOp0Mhp0I78bj5CACBQdr63pwLUsqpHloBND
 uHVDhnPDwdvy3rJbBmO8na3L25GLv1W0Y+wTKHdqI9fHxp6oAesSVwF1gmPo6MssIJKK
 idufXIobCa56n4nozmV9NyCVCho7tb+YJYI6Jrq+rf6GjXFArdutdZpptYK5erywbWGT
 LxkF4WmBFIh+5+8WWbfzcGuPFwwdq6HtGCp9h9SKj2Q1PuiFMTcue2eVljfVTLrY49GY
 8ODQbEVc5N4zrCWR7TaC8hIqBqTjeoQX/8+ZR/tY/DMM/mg82S1dtwjbBphUiTe4516U
 kl/Q==
X-Gm-Message-State: AOJu0YzIy8PLnogLN0LHVnr3LbUm9OpS3EP3SY5BzNZQgRA0RcKABZJT
 ALcw9OFQsNFK+Q9mRbeZ9t6WRLvEqrwGxb2/w5z6t3zNcmE8VJ9l6zjnMqUzTDWdRmHyspa8ED5
 NQZ7I5Wo4ksqZab8fgLawKLtTqx6J5vu+pkBV1NZ6sBYg1D+YGZpA3WLQ+Azqbr6k8s3MukyHrm
 4Yfeo=
X-Gm-Gg: AfdE7cmcWUNmueatoPjI4PO1T77Awvr4cd5KVghsn0x/lKNO4pktmq/MYgpV6QvHcRV
 RNeAJz8paVq2LDph4L0DtfoL9tJYDaUkypdUDeOPMtcA1AcD0oNNP9znXpSh7EmRV+Ou7VstD1F
 R9niVcqg2Hlc2IwqEUtRdqM00N5B/DYfF39t9u5x8ZmHu+cE0wB6CG3MTOsisOuWm7fjT0+AnZZ
 xjn6YFD2W5BFvwF9+e0kJGGPf4A9U7YCHG9lM2lbYHG3i/bqaZ3n9GBPm8sRPFs2I72tFQg4bJl
 HqVPLxUHkq8kScJ3kVpbVa1cgF6zi0rFqWfbSpo17GM8WKUWZZ/JJ2o4K5zzIdQiYvUpZR0/M62
 cBZVwjyIire4xJ4xMhXg+PZnUI3OBvbvRl6M6qvQ2v9EeqWmxS9jA1ceE3A==
X-Received: by 2002:a05:6a00:cd5:b0:842:6e1f:c8fc with SMTP id
 d2e1a72fcca58-845b3acc185mr4310598b3a.32.1782414943038; 
 Thu, 25 Jun 2026 12:15:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:cd5:b0:842:6e1f:c8fc with SMTP id
 d2e1a72fcca58-845b3acc185mr4310554b3a.32.1782414942575; 
 Thu, 25 Jun 2026 12:15:42 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fcc65csm5185755b3a.6.2026.06.25.12.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:15:42 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/3] drm/msm: A couple lazy-vm fixes
Date: Thu, 25 Jun 2026 12:15:32 -0700
Message-ID: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FG7EZkAx5VX_6GZ-S0UVOVREerrCrAKV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX5Z1iHz01knvr
 uE2br5g1Mrxhzt+CNn2jM5IHwZXby05yyreYtf0JH5aRVkrObtqyXyYoQgz6kn8DnmenbjA6X8y
 IZSdXJFZEC4xT/jD/zPYdLkPU49CXR4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX04FKBOsT8lfy
 7szBfOUZ2/ch4lbFXTBw1lGQb4NoSN7BVNvKAdX/YvFp2GP7e7KIaZXeQutIKeq0KpKPZDeFwr/
 3OnUSILDic7+QNAu1LAMvkldBu4PzorzUTKlP7NNO9obsoxWRCkO2bJtRvulNurq+bkOCxPTEPP
 Z2/pCzhL7plg4zIVOSkE6hZfnWz6L+TpUXZjb+eANHtWUx/iUiskwc2u4tnTKvJ34iYnerPFqcM
 ZoyOrNUteAfJpkQ2JYuSoqZR8MG5IAkxByfbjOqf8oiJZ9LbVloTqNMLw9MxbMSlcvmXZweNN3O
 NAPUCCPl/dgVl2CDA6TlVdVGG/lCNVLAq2KOvg5HYrhiJtrY8MkQkA9JMKsW3DH6BNNYK9zsLiI
 K5Cp1tckkNHqsnl5Lk/IncJfA/XJK8MkVRomMwYIeBCEI0xoqtqtmOf2FFieafkfFJkUipEUBvo
 FA1puxG6kMOOvC3eJEw==
X-Authority-Analysis: v=2.4 cv=GKo41ONK c=1 sm=1 tr=0 ts=6a3d7e60 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=384pi0yy4wJ6F0PkkBwA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: FG7EZkAx5VX_6GZ-S0UVOVREerrCrAKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250165
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

The VM is created lazily to give userspace a chance to opt-in to
VM_BIND.  But Sashiko noticed a couple paths that were not handling
this properly.

Rob Clark (3):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Validate lazy VM is created in GEM_SUBMIT
  drm/msm: Validate lazy VM in GEM_NEW

 drivers/gpu/drm/msm/msm_drv.c        | 13 +++++++------
 drivers/gpu/drm/msm/msm_gem.c        |  7 ++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c |  9 +++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.54.0

