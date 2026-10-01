Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DB0CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7A910E129;
	Thu,  1 Oct 2026 11:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N5ZZREsT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PVPl7zia";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE6A10E129
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:02:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691701oP1661288
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 11:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gIwNsqGluazdyvL/065a88
 cbyh4aj2fj/dBF6vgUhcI=; b=N5ZZREsTzczYNYT++0Itf3+EDTDtYgdZO5shT1
 SA0WuX8M8EM8mR52C7tkx7syN7xinmGE/QosuozmP/mg1qahyUVZhwvFJbEinEK7
 zeRW65RjTsweMDTUBpaQNA1xekF3bgY9UwU37poU58d0ybo+X/TVhPOwu8UmUOpi
 zDtyjQafQShfJMgP5uxV1JbLmSLSmrje7aCO/+DsfVWhLPNHbvUrNf1mkvKBXbcg
 5DRfesdYRZfsTDSfbVlknUzIYSAfy+Nq/3HU2P3owoq9KJwCqBgJQ3wLUQMO5XTb
 Ns76L3waniI/VSG1esJPeVwNhgrJGUAc5iPY334D3xOgVyqA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pm45r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 11:02:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-880babf652aso693439b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790852547; x=1791457347;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gIwNsqGluazdyvL/065a88cbyh4aj2fj/dBF6vgUhcI=;
 b=PVPl7ziar5CZrpg5fl6+Z0D44ehcMPl0BYxhWv+eyhl8Lb6bO18LOFgolJtaH92QJ0
 BfaSf9P9QgZasUjOd2q7fGikHg7UVPfAfEAT59pdF6LFcy7k970fTBiXxomH6ym/qAIC
 B7AvlxV6BUTUmaZ5A+xacbK7RiJ+7Mmx/5jVY0pW2eMvZovGtqy0n7rj7n6qNeHjHnxJ
 WEPxaZZ4RCKWxFkQ+yk2vDnyst//Yq2h+o/XERUpBryt2Jw+B6yIoDShhD8Uyh3xUqsQ
 ixJGzY8FW61EyU+4HgH4mXX5070KzUkyM9fysxh/hdsO5ru9MapSL8nT5193okLC4Gby
 7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790852547; x=1791457347;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gIwNsqGluazdyvL/065a88cbyh4aj2fj/dBF6vgUhcI=;
 b=16RBudVIGVAql0vo/cUTgl1rFPVnqIfULD8ySB8JviIVc0jeFNUTE8F5/tl18uuPtR
 WPryjcMmzdzNfU6bF0n2d14DUDoHIczYXDt3uVlb/OfUFcXpIiX6+FcMgZ39jj9B6KhL
 dfzq7XUCtfBPUdXTOrgg4nN2MIiqi/VKMYIXDHlbQHvZoZshGalifPnF08ltJENDp3Nd
 MkJqN2sO2q9xvQhifHMfxDTjSKC/XcHTDWv16G/vZlATYI80dnSitkLKBYOJLlb6kF7/
 T1xegl8uI/pE4xHeLJrFSdGn1FIMN1+jBs9kFc5AXjFWh3snQ2jICVOMIiExUWQAdNHu
 Kw+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzYpVOvuI9tMcyqrmbVUJwJOjRh7Ov2tYVrRxsQKqMBMyVxN6gwiyq4vyLgjkKaBqB333uf90qmYg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDTk1AS1E6ifPsxp43Lu1s6Aowm9y7WrcTYYcnAOiTyi/w+nQd
 1YYQeLvxgh7vYOcYq4dpmiJnThwh9OfU9LDVVrX6a9l42ZtWgj/TRfDzv3tJAtXxEwsXgupZscy
 syIp1Gkft+JLitAQLuFgddKuPHL0TVSGehj596YtVbmNDgx84W9s5gEYKBWCwBoxr0L/24L8=
X-Gm-Gg: AYBFou1/SaF5GHFHl35rbywifecfAEYrx2EOOdEbxn6ZG/Sombu1tUF+ISf4OH/eL/x
 ZwyqBCBhSvG4Z+GODAqByV9NWiguAeJurHLp0AbPnA2bDiuv+9qRlYzmw0kGIxhzY1CcMZxet+b
 RFBkoFw5LbUAfitNdPcke0CZm04/Jl6824MyRvqu3AUN75GKYcNL2yMRItdYi9VDfTGfjTPLHH1
 8kPwcSVv4xIMw29mdduL4zYaqft/Uh6e+73rG/rlQLCl06ZAQH2EofhbOa0rQE2FRuP4r6GQzhH
 oDKWIK+LFpYzzoAQUTE0TGHwEmykdallwyCuPnjCXRDrPpeqLQXuTyAm7wfraAMTjykMG7kafgk
 rHe8ArOeJeDXWcO+GIw/qKeMH/7R/sj249A==
X-Received: by 2002:a05:6a00:e06:b0:87c:e44e:569b with SMTP id
 d2e1a72fcca58-887fef8fa6bmr1653658b3a.49.1790852547050; 
 Thu, 01 Oct 2026 04:02:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:e06:b0:87c:e44e:569b with SMTP id
 d2e1a72fcca58-887fef8fa6bmr1652798b3a.49.1790852528147; 
 Thu, 01 Oct 2026 04:02:08 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-888197ced69sm886049b3a.48.2026.10.01.04.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 04:02:07 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH 0/2] fastrpc: fix probe-time races between rpmsg and userspace
Date: Thu, 01 Oct 2026 16:31:24 +0530
Message-Id: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQ9vmoC/0XOwQ6DIAwG4FcxnNcEAZn4KosHqHXj4HRUzRLju
 w/1sFv/Nv+XboIpRWLRFJtItEaO4zuH8lYIfPn3kyB2OQsllZVOaeg9z2lCmNIYCPr4JQYtsXS
 1DJUkK3JzSnQecvHRXjnRZ8n4fC3/dlOccrahWyZg4uMDBvLKo/fZdaZZq0MNnglwHIY4N0WFp
 jOldVaaoHWFug4B7y5g2aPU0ihX58n2ot33HyLY5L7lAAAA
X-Change-ID: 20260923-fastrpc-probe-fixes-30c1980b50e6
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852523; l=1578;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=X0YuF0S/pI4xRaYCEnZpArGR4s6grsgcg+v3wGzQ8sY=;
 b=bH2dKFWVwLfwtMlopYO6Si7aJ7JOruej1mHbsM++YBkEgvJRLfQIOwFcxY1D+UObPS39X36Yf
 rFFNe4FtcXwAf+4Q0Ric//mKWAvvlsqbERerzgX8wwQjCDWJyE+6pcY
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: e0JQMg6t83LtE2w59OuqF3rHTVPs4y0Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX264GqrcW2db9
 EB5C4W9kP1benQOpCHBGCsKX2C/8p2GMK3xqmcEDa9pfky7nWnbagyFMHfoRv8e80jSTGobu8jV
 Zdn3v8rBmW3Ihi3JlWxxc0aeaZuJLt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXyRSmFi0o45//
 2/yvXDGkqe9jFfr2SvlQupP1kHqkjzeBwKny2pfKsmWNAdoZ7uJBGhZc1UM9tBlUR6AdoRfdsSb
 opwgSsAn6YHQhPVMib1T+g7tQk/737npl4NzOZN4Nw1eSB8b7g9zDPpJV/8TTCBc/0flw6iP6t+
 cyMHQa9WeTRqmFFMYAxra2lXuYC3AylmSKzZ5rQ/ACTzBQ1e8iW7EZRKJHXgrbF64UdhvbNApuC
 NB6VPOd7XShY/nfZb7tiZAFGUrcoiKywvQ2AASiO0dYbTw/9ucWW991PovSiH90/EMlxCBWuWz4
 lbfwySIHIy1Oh8+7G1LDioNzUJVdptbRNXlbHcgQakZ/k7Z33ev0SAArJX+oTSUdi5sFGjS8Ljo
 sMZRZrrZDDgyRQXDSeaDOHMVJ5Qn8RT++DPNDlv3JDXX63Z9If2FWBm/Cm+x+4jgbe5r5s26uvU
 Y76hYYtTWy6HlViABJw==
X-Proofpoint-GUID: e0JQMg6t83LtE2w59OuqF3rHTVPs4y0Y
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe3dc4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Z9hRlnAjW1SqKzzyvooA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
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

This series fixes two races in fastrpc_rpmsg_probe() that can be
triggered when userspace opens a fastrpc device node concurrently with
the rpmsg probe sequence.

fastrpc_device_register() calls misc_register() before the channel
context is fully initialised. A concurrent open() in that window hits
kref_get() on a zero refcount, and because fastrpc_cb_devices_create()
has not yet run sesscount is 0, the error path calls kref_put() on the
saturated refcount, triggering kfree() of the channel context. A
subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
freed spinlock, causing a kernel panic. A NULL dereference in the
fastrpc_device_open() error path when cctx->rpdev is concurrently
cleared by fastrpc_rpmsg_remove() is also addressed.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Vinayak Katoch (2):
      misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      misc: fastrpc: fix init ordering race in rpmsg probe

 drivers/misc/fastrpc.c | 55 ++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v5
prerequisite-patch-id: 425dc9414848bbc3f2a053d067195d849898e2ae
prerequisite-patch-id: 4fea14b47d11a5a3e18065d8cf3a461841ee2b86
prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

