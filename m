Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1332606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GMj8ZTSX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dLbqVAQY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1831B10E3FB;
	Fri,  6 Nov 2026 19:03:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A7310E3FB
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:03:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtFQv489663
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 19:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/0HAahlW4CgTua9qfMa4tCpqsXnFAGAWQee
 P/ULRLM0=; b=GMj8ZTSXIY6fuMnx29NuoxU02azIjSOoP0BKvCZhweZpZ/ABay2
 oalpjLrF6Dv3viZPCZxFeVLmR3YyWYX+l2VP1A3SEHNFXi8OSHJwZ7MK2jh9fkSR
 Dvrg0+SXIdRpVObK+YFSC7z+7YnopStl0hY30K3El6Sj1oh3+zhXaCC3EeGZyOph
 CQFFnYqiP6RYIISjjP+QEGlkjSOH+iMbyJ67MH/T8kN4MmQp5LMUCNcOUjLXxcu8
 ttBzQ24e1Tz2+2L4fVgOJodj5XlsDdakoI95CO5Lo9/urx43aX88aWUFZr+ciwJm
 lrmgkD8MWgt1x7K9neGm6YUHqxDqcdIkLcQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa4b91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 19:03:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eb5375cd68so8601635ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991802; x=1794596602;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/0HAahlW4CgTua9qfMa4tCpqsXnFAGAWQeeP/ULRLM0=;
 b=dLbqVAQYGQ/H2LlSTqmTFOCKT24hkumZEs/dhna+Tc2XH1YUrH7hBdRY/6cOeTDh4M
 7ZfakWYfaXNPZYIvy2e0PzYY+v+mxr4NGD1/4ZL2KNcOo3O6T5LXYDsFhltFMCkXykZj
 jSaxFUy5S2TJ4Tw5CwH3G37aYLcBmDrEuils4HAYxVPxMwDGpLxG3yUbQIDls3qS5wpY
 zyumxGqfLBo+4mihY0VBKLrsVdD4KunXut6P35K9a6M1nfOs4Un1PWqht6hjJUwFL1xo
 Jjjf0RPlMPnKQhmtZvlSOQHczjTNeIq7hCJg4aLnjmNWvp+M+EeKs7uaFdh9KWGcnxOv
 4EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991802; x=1794596602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/0HAahlW4CgTua9qfMa4tCpqsXnFAGAWQeeP/ULRLM0=;
 b=JqFATRjodk77tzVPKUL/4w8Fufb8/82H3iA9sSHQxM7+lawSoK75QxS87ayo26jY3U
 u2WR1QXftgz+nAZ9jxVkTeO3fescEdVXcjxlZiBi26CRZOZO52ZKsisZ1vfvFI+TiUOg
 4zAxlBKLo4KcnMNGukYaESMLdJehPR+X37t+GdQh5ONOBakMYeBSnXUCGgaQbLPHNLIB
 f+YK381DUJuI+V6dXZprDYvT3Sx0wYefTT0f2fTAw0Ja05SxCSC3Ju9mVnGcmH6vYkBX
 ESTC65ZnN2d9P4OFj2XraNam/gziPOXMCqI77rNiIPhh+cXcV/XvhenKXQEy1sfr6Pt6
 elLQ==
X-Gm-Message-State: APuU4Z9KcBJTXYiuBEYg2HBsaq4GV9hjzOWMXy5iYzSJpUQTszF1KVYf
 OmYa2zWxAzuVntE0CesVUQbsbXomtFAAz2pL82JK4AOCh6qKQz7/QIM32Vk/FTCMGouR6DwABlk
 GEFl0v2gYb56DiMXj4c+C57Bnl6tI12+B2NhwD1vvf8XAc8pDpwILcaSXU/PAw/mA9iqabhUbHL
 CcmUwkPg==
X-Gm-Gg: AYBFou2vAQIk1g06VRNJ63Tz99jeT4VHeApeUY3dAcZQcIoGqwZlxpkSVHT/uOa1n5x
 HqlhsXB+UsTeKKW/v4G+ahf2mp98F7Mr8LEMuUhmwvGZqFKsJhjvkfG0ZofDibk6rMU8StI2JgK
 ztVK8LENjWk7UmJByxVqVFvWQoS+2aIFaBU2IqX1fINtyYSnFGR1dbnjDWk8TNOVLbov+iVPPYT
 EzjHxw3LPI8ubKOK1Odc7CpGg5bX58NrlCfT6H657ReaVxS9KmClzk0NnH8hknnN6jpy2NrsrA9
 95Dk02C79KB47n9D8TtvD0tLyLbZ6H7Rby9uVQz8XCnUiUl23TJoixhy/93GV9Uah8kFcm9Tr3O
 d/ndhSqS4NfdJha9mSWor8jytwwHI927l46UDUReblv/myogp/5oJso+D9V7v6RCLADr/xxtxTK
 S1sG6Bkxt5kRzwM5m0YpNAJ2ws+lVCbjWIR2DgYdyHXVOzFw3ARN9WKOLbA9z6Nw==
X-Received: by 2002:a17:902:d48d:b0:2e8:1c7b:3b6e with SMTP id
 d9443c01a7336-2ed40aca726mr41087515ad.26.1793991802216; 
 Fri, 06 Nov 2026 11:03:22 -0800 (PST)
X-Received: by 2002:a17:902:d48d:b0:2e8:1c7b:3b6e with SMTP id
 d9443c01a7336-2ed40aca726mr41087225ad.26.1793991801750; 
 Fri, 06 Nov 2026 11:03:21 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d8949fsm8637105ad.62.2026.11.06.11.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:03:21 -0800 (PST)
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
Subject: [PATCH] drm/msm/gem: Deal with partial mmap's in fault path
Date: Fri,  6 Nov 2026 11:03:17 -0800
Message-ID: <20261106190317.17904-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXwNF/Bi53j0M8
 Chb1YneuiX2K4w2q9F5d8PQuINMHaLw8V6m0WI2Fh/4+p22VeAq7bapKLbBAoF1ClRmwOMkJ7Jk
 yZBm67jodR5g+6BNkwMjuHBeqz5vfrJi6v2X9CMIqk8y/CpCQBebXWsnAfyKpNqqgaTUiSw9udy
 XnVFAQRZSvrNnwatnEiazEy21asxw4aNYMcmKE58ahETnZe6D7sAj+dKMa02ETOJ23hULtN3Fva
 BxwwKhImmWtSBs+APKEyosh3ubDz41WdZvVZafYG96+Kcia7QCHN2o/Pyy4YkbZiSSpagI2smsZ
 hF/zsFFHpKDSsHpjvVIQQQKk5M2vi5Hk4AOCWJVeGpHlsqeYrLaauKz5amnm4Jh3cUIVWjpnt1N
 GJHNrP0gkrwsJhzgxYBB1AudBPcN94Ao5BFMuACCQO7Ca+we7qxc1aSfeDEBsn1PsQftK83kGa4
 Jzml8W/lyVEx+PqqVaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXx+E0ZyqhYShJ
 Pz1wO057oS1efoV/J6jT2qAeqESYWCb0Zl2bb9vaSU00svtgJ0OknSQ+W7azoh77MW2BsUqeWQ9
 bIkgKT+0GLz72T7u+Uiad4qFqOcKf+A=
X-Proofpoint-ORIG-GUID: vqX5E0d2vguZc9Vgw5BvUUIVNSTtMcB7
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee247b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=jYIoWETkLWJVVNRKBkMA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: vqX5E0d2vguZc9Vgw5BvUUIVNSTtMcB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
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

Historically we ignored pgoff, as it was a "fake" offset that simply
served to map back to the gem handle.  Mmaping a partial obj was dis-
allowed.

But we can instead just subtract off the fake offset.

drm_gem_mmap() still expects an exact match on pgoff, so unless we use
our own path for that, like some other drivers, we don't fully support
partial mmap.  But this at least makes things more robust if userspace
does funny things like partal unmap.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 000dfcec7809..5826fd69abe4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -374,8 +374,8 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 		return vmf_error(PTR_ERR(pages));
 	}
 
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = linear_page_delta(vma, vmf->address);
+	pgoff = linear_page_index(vma, vmf->address) -
+		drm_vma_node_start(&obj->vma_node);
 
 	pfn = page_to_pfn(pages[pgoff]);
 
-- 
2.56.0

