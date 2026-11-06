Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FE606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5EUH+5A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UYrXRLe2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8618810E438;
	Fri,  6 Nov 2026 19:44:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786B710E438
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:44:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JL4gN1699903
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 19:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qNABjluLPthmtzcypGb8y8qVQN2dUgrl8U9
 g5Yy0WKM=; b=M5EUH+5ALBu9wLCUWTAe64qDasOIq0JsubA/84y9FjuzFenBDls
 f3Ww50BuihEhchjwRCOxHk77N3ZQa3hpKRZn579L9bu6WMqDjm/i7126wmw1NWCN
 m+ZQGBovcmRy+B+D1siAasWWBuC/zuTbDwd16sLp2uSKJlb8zuefOwPgCy14eGht
 KnMsy+80i6DGgS1xsodKr1Gty3tTsrm5h9o8absrT0X1glmw0PuVLRY7kdaW9AJR
 7e8L5Txz8xUIf6wHo2hYmfsnR3ALvzMFJZ8r60mqPElTFeZl334fiW36AkX+cXrt
 ltdz/OU7VRRbih4ty07Zu3XOSce/xFnAMnw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmypg33w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 19:44:37 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9987bffdecdso731110241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793994277; x=1794599077;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qNABjluLPthmtzcypGb8y8qVQN2dUgrl8U9g5Yy0WKM=;
 b=UYrXRLe2FUiCQTdn1ko6ySGmWpvE54frxurznSZyGdcfhtqm3jz64Bus7PJ7mrinhx
 lo4hs/yEJuGrSWPHtmIfDl8rMxCfaILkCbnD7HxxvJ3DDVl4nKnLrGZyQ7NaXKSVhOVD
 +rG8W6eqQMKqrmqTRd+h+T81k3djfRFGiz678tmQgjGaiWwJUmolaUW7KXLGLIXBwZc9
 9+j4NPDjpdgbdIgTfxBGpWbQ17dc2ZDURBy0tcdRsKZRHsNCjD9d1YAcFa+vrtvC00TY
 g17hy+azeulCVjHWbBaE76fDhQm5r94ZHrKniLy4CI1KB6BPpmX3qCqxowh18nDeLxRp
 TUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994277; x=1794599077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qNABjluLPthmtzcypGb8y8qVQN2dUgrl8U9g5Yy0WKM=;
 b=sfqe1IM5pk2/5IfYHrAxzb2lzrw7+HgAB/DSydKGCK1w0c+rKFhE0dQyiyPXbl92BW
 aCx04JXKUtr9uB2YXMN2I0broCEWdwWi1BELpsJhEVPUtCLJPVn74oFODBtRGImEAGHD
 SJ8Ub+lg3M6sUl/1a4VAJGEWL/acnWXgh4IELDigPZfHKn/0DesJdxGuqzSAoxfX0X5G
 mToh9eVHhEUpCCb3fAp2T5W09+FDOWPRhd6SjBiLjYL/bnCSWncyrM2xAzmU+6aXA14z
 A8Sj0rE6jqthvk5wWumcfg88fBOl8olmwQBhCjSi9CY55+BAcrjixzXbotQh7ugjGfQv
 F+Rw==
X-Forwarded-Encrypted: i=1;
 AL+hErGFdWBHHzAMJ5YZzXuqRwVS0TmIJA9ihp7b9MFxpxp+TSYLBuPmgxr8EwIAlFbC32h7kZoKGH8ROn0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yn7nWImaEFUPj1B/HqHdk59HXlZ7MB3rNE6m5a0ske1ap6s5P
 q9hhlXiPpueSCy6cGufIwKw4mqU9aA4Wto3gK8ayaa46A2Gk83gjzFxm788btMLPJvUIS1+CPnp
 m3RrXB347n+RUV/+/mf1/SYQHwEqD2ELbTAHxMnBR+Or48uZhqwpWLeytl8AQC3vk/YP9q1g=
X-Gm-Gg: AYBFou0Y0fTCru/r9UF+EJu+BFRgo7Y25Z15+KYO/dfW7xqDZ4i5VPw/3vmT3et7eib
 XHWwm+8bId9RHCz4MGkD5PBai8M2pbh6At0mFBoWit8oplJEinDtGxluGFDysYB8MPMhh1uxhbw
 5QoBLIK/xtawuFvmKbydzVcu3Ak28427nhryscquTy3jvGC8lxyvnjpGIQUCURNocM1pq7YPcp7
 ODsV40Wt0Zcp/6F6PPDGQer+VpzcxFHB3v3TxXy4K0eaZnh2bao3vPJzq3x6fDj2sl7lU38ranG
 ZaOmkvxAUVVZyNa1bq6XgJxwUUCO4RRHWlfmWhANwUnaeDg2Epfn2smO3BVpEQk1IpzKEwoT/WZ
 6acfFpjGx6SKLjgqKmwS8CzSJAkOYiRzXGxRlFGL2zBHgy0TMLngNidwGlkaWb2AtEOMS0hNoYS
 rbussuQ3D0FxdGbQ==
X-Received: by 2002:a05:6102:3346:b0:7cf:61e8:c508 with SMTP id
 ada2fe7eead31-7d2a15c6fafmr1978055137.21.1793994276728; 
 Fri, 06 Nov 2026 11:44:36 -0800 (PST)
X-Received: by 2002:a05:6102:3346:b0:7cf:61e8:c508 with SMTP id
 ada2fe7eead31-7d2a15c6fafmr1978049137.21.1793994276224; 
 Fri, 06 Nov 2026 11:44:36 -0800 (PST)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4930a5a91dbsm4090686f8f.35.2026.11.06.11.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:44:35 -0800 (PST)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] accel/qaic: Harden checks in BO execute and wait IOCTLs
Date: Fri,  6 Nov 2026 20:44:34 +0100
Message-ID: <20261106194434.4062205-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3OCBTYWx0ZWRfX7tmBEQlmHyqP
 a0SIgCoFjW2S68/RcRLdYdPjjUmZKchHvw7QZdFXYLO0nDUBT0hP4HXC23Sm7T7PaxW/VDY/xa+
 Ck07/cNhaIb0qmycgSYCPfDojZ5DGWdr6qpztKeat3edMaJCW94YqDqDLbDFytTjl0Y6jjEP2GM
 0BY1YtyZA4aykDyBU0UCdO4F6eNk4c9K6kRlyWfrJWAJtGYEURSIgcrmMs3BSfIXZ4/B3UmtM5i
 zpW2lVz0iIR6BJBv/Qanqn1wgPmGxSFzvl9KnFB7fu+geNnIoObpBiMuaqpKRJBH6aKhfhiWAzR
 KJGnUNHKA6Y/mbNAyVpYmefB3Ibi6KQh50DZtUJ57Vo220xa43qgwn++KAc6vVw/O4wKZEchPkm
 pI1dlNHfKFzSnbhtb2auwlUm0bDczSp2+mylv2a26vgvTtaFcCJnfpDIAi2DzBveAd0apU4lOls
 6d9ZRK5RI1YSOzGzQBg==
X-Proofpoint-GUID: bH7cDOv7L2kXR6EXtkf2QxHKPCTG_iTx
X-Proofpoint-ORIG-GUID: bH7cDOv7L2kXR6EXtkf2QxHKPCTG_iTx
X-Authority-Analysis: v=2.4 cv=TZ4DJhQh c=1 sm=1 tr=0 ts=6aee2e25 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=i3Tp0zCUGlA69Xfs4B8A:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3OCBTYWx0ZWRfX52hWJDLwk/mP
 WxqzbMwt+e4DlxVO4CVAasOEZ8k402MGBTlfd/mPv1APoH82sWQXW3Nz36dEzBjxJmpBxwzbrNX
 ed8I51E4SnBQUMvhMpKR+0cn0Zz7yMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060078
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

send_bo_list_to_device() does not validate if the BOs the user passes
through DRM_QAIC_EXECUTE_BO and DRM_QAIC_PARTIAL_EXECUTE_BO IOCTLs are
attached to the DBC provided. This allows the user to slice and attach
BOs to one DBC, and execute them over another DBC.

The same case applies for qaic_wait_bo_ioctl() as well as it neither
checks if the BO is sliced, nor if it attached to the passed DBC.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_data.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index ee35e13091b3..be3ceb8c51a0 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1256,6 +1256,11 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 			goto unlock_bo;
 		}
 
+		if (bo->dbc->id != dbc->id) {
+			ret = -EINVAL;
+			goto unlock_bo;
+		}
+
 		if (is_partial && pexec[i].resize > bo->base.size) {
 			ret = -EINVAL;
 			goto unlock_bo;
@@ -1769,6 +1774,17 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 	}
 
 	bo = to_qaic_bo(obj);
+
+	if (!bo->sliced) {
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
+	if (bo->dbc->id != dbc->id) {
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
 	timeout = args->timeout ? args->timeout : wait_exec_default_timeout_ms;
 	timeout = msecs_to_jiffies(timeout);
 	ret = wait_for_completion_interruptible_timeout(&bo->xfer_done, timeout);
-- 
2.43.0

