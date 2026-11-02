Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EE60A263F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U5Gx3lGv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NhY3meP+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BC110F0D7;
	Mon,  2 Nov 2026 17:20:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8202F10F0D7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:20:12 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2GZMTM256544
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 17:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r/WboLhhvDm
 VhQJbnTSwViwOgEjv6oVEPILntAbBAew=; b=U5Gx3lGvUzHDBeDBNSBPpwKzlva
 esSfDhf9M/mt8sqjqFFipFzhuRP2KnQFsyxX5iDD1fKYOS4vwxgpCuHxNThajY+9
 ZxhYv9LB0FHJHmLaWiKr9AWrjBBbVw+ZIlifI3i1XeblJkOqbs1u7EB5YOoYqe4a
 h6BUmdXy693kW9FhcjnC+q7KMkRA4edC47IyTdOhqkBrvOfSvAhldiyMSRyVt1u6
 QzstlZ7Wx5Poq6cJKrIjwmCi5JWUkeUa82sNYcfjXblqzjVq0u9/VKWqTQEB2GNS
 29uwCKMXKg2GSIo/MEIexuQqSdKiSptfjRGuP/o26PA0tsUR40/a9ExdiBg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5hgh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:20:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdae10aebfdso1917029a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793640011; x=1794244811;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r/WboLhhvDmVhQJbnTSwViwOgEjv6oVEPILntAbBAew=;
 b=NhY3meP+qUR5DARGrb1zWd0rL90VwTCSXlNCB3lh2sANw+p+kzjgbicEQvuLOSORNe
 5Df/kcC+tvONednxPFuTdzr3y6wKny1/3mnEp6v6aGG78e+02aA8h5iUYht14iHd8Lz5
 hAjBJ4Wo5BeyJrLa9VUZrQRoQ0CnEamdv+GPDR3JCMRBrL6YUfyHfDAz+kle0hwSK6eC
 zfU+hYDcrZgLTwWgdwnW43oJGzu+h/rMWdiCEBFEne90WHKyuSXRED1PBJfB9/B8ty+x
 NKWh2swMUWUB6g+5TBT+rqfGVAo0l9WdWPPHGKzCsPpGrl8H76M8njnIE0ngsgNXhYEZ
 1ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640011; x=1794244811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r/WboLhhvDmVhQJbnTSwViwOgEjv6oVEPILntAbBAew=;
 b=mxSom4H5bQy9DkIsgDKE9n+bC2XeIEz05XyfiUQb1b7ZPpT9LfBsaFLmdBe8xA2UGu
 EqDOfJBZrAXQiCsRhdFIu64/8PewelrMDH/DW/X2LmlZhZ5Zlpxmu0wyvoHQTpgwEk1N
 790JxypRVhVKC4L3vG5eUdzXRW7okNYqhRLpDdxwxPSoDhqJMKyJWWinp93eV1hYD7gJ
 5ZiHfX1McEKzgNBr6vF1ycJsagJUVNqA39jeQzf8rDJmsfHke8mAzQJziQkQtK4yzzvV
 C0QG6Sed8U+q310A27895BDbCcAkdKj1g1LhKyWeq/dxENfgTUQDiDV0AzgHH2WkWay4
 TPlw==
X-Gm-Message-State: AFq9FYI3wZG9JhOnNx0mToIgm+YartM7hE1jDjVtCzHvk7WPEe3ISgRp
 X7xYmfaef/0+j6WZw4+xjCD+lIF8E4BV4bFhkOqwE/EIyfHYuMlx3/I+ghKeHNJ/5scWyqX/RXP
 N9Bs34LFuhSGYNlFhIQS8JMUbw+OGYD9kxz1l0TuTAijM4c6X/kDCI0w1WSEktcvR2mnXz5N+jr
 srEpXOaA==
X-Gm-Gg: AYBFou1NVT3b3NG6AxsiVDak9VEIviAkeIr1PNYAVBjrpmQAtVgG7Ia4BdgVcQ2Omvc
 iaxt9OlSkBJIHYEJqlDvvuLXzVR4w0kJsKesKaq3trPEyQmVZc8URnRPkLJjseVamXURiItD/9D
 xrTpP/kboM3CPura7/SQ5qrVHao4eq7q1OVMK9KQPiJL/dswJ/C9R+gUJDt3TmBA0x+2Uta8kPF
 T+b2s3enHro4xwyNURgE1Jpl21JFD1A3n6bdv7qpTKcO+5Dl2rGL4x9PUbWwNT4c3ld3XGkS8Xd
 2nSjAw+U03zoRn0bqxUOUN/3XxeV3dioIG9EprMDrCGwqarSEPBQJ4eIVtTt6O9uQLcUmL84rmT
 gW4rrLhKeryarVOrquZ7c22Tkz7R44qz5w31uchlKPJ+ZkTE+fBe6xR3NVXk5gPKLPbEn58tgr7
 mRJf3dX+O6PVPgjlmSXdcl/w==
X-Received: by 2002:a05:6a20:ef1b:b0:3e1:fcc6:2f12 with SMTP id
 adf61e73a8af0-3e928632c18mr5575751637.4.1793640010371; 
 Mon, 02 Nov 2026 09:20:10 -0800 (PST)
X-Received: by 2002:a05:6a20:ef1b:b0:3e1:fcc6:2f12 with SMTP id
 adf61e73a8af0-3e928632c18mr5575738637.4.1793640009907; 
 Mon, 02 Nov 2026 09:20:09 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9637134sm2275551b3a.11.2026.11.02.09.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:20:09 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] drm/msm/gem: Decrement loop idx if handle lookup fails
Date: Mon,  2 Nov 2026 09:19:59 -0800
Message-ID: <20261102172001.508440-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae8c64b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 18Ez7oWqITLxW3fQrKk0mT74NspdEdDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfXxFgePfTueTUM
 /8X/pl66XfiIQrwwDTs7DuzXzFTAqi14BRiogWYZSuaQpn5T52fAGjDhm3XaBMKxhcnJa9a6XEK
 KAbRUAwBVngoVAyTZRub4c0uvZtSBtFrKLlphF4jwp7Mh0uNiNRShWD/rohnG2+mWCkPOKRN/Wd
 M/o6VmCtWCB9VBjQtO+0Z9+hxTfZnQ5xORwZPnUldsQqgPOEwOtmklWLFGk7lHG8qA7V5tOiLrk
 +x4q1bvVjEJHH9UybuPffoXRG2AWmE/mgV1IyD/tEDXDh21wEvL2OujWFifhbWvWrHDMSFxdvLN
 bH5joAnIUY1CYJncCN4hXd+oQNLRRqcuobPSjmioxL6TW48H29M1FXCQsY56G5hq2fCddLhpxQW
 PzI4NkJOpXl2t5rT0VxLsa17Jg6N8sCo3/1xU7h8/tKLPMWcTfdx+S+Rdiy9aLUrvv0nYr8HwnY
 kj4z7mrQJlzaakCj4/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfX4RrKaSlf/rrY
 JvV+R8ywrPW/tqkGF4ZRP4/5ENglpf02O8Z0Ome+SrbrV7y7icXA2oAsdhdZX5vsw1k3MVqRaWr
 UCTds6XNSE0nKWZJau/yWIc+wGxRMKs=
X-Proofpoint-GUID: 18Ez7oWqITLxW3fQrKk0mT74NspdEdDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020069
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the out_unlock unlock loop, we should skip the op which still has the
gem handle instead of gem obj ptr.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index bd1c3ceeea51..3177461d7ad0 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1110,6 +1110,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		obj = idr_find(&file->object_idr, op->handle);
 		if (!obj) {
 			ret = UERR(EINVAL, dev, "invalid handle %u at index %u\n", op->handle, i);
+			i--;
 			goto out_unlock;
 		}
 
-- 
2.56.0

