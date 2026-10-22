Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DA606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=awUZGDvU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JIYlqAcY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C21610E32E;
	Thu, 22 Oct 2026 09:09:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D98112410
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M6xv371560116
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=; b=awUZGDvUo381zakE
 6IlU2NFPZS8CF4z1toImlJP1v4c1Us3D8S8tMGlDHsaLjViCgF5tKaRlScW2sGNR
 nzmedS4PMfnjR80vijvCqrG+GaG9VAtgMPp61NXNNJ+RGPWnoUrwzavCYwRD9Fqi
 Xu94BxbDRb0fejtCJuA7qXSkwI800z1MI2kh4i77allNd8iPzTyOwc1uN4mPJvyG
 HyzsOwQKdSGYfdPjTtbmSVQJ9M5NPr42HxJ+UdPWqwgtVfKifdlqH+nVZWQnYBBJ
 eGs2OR9c60sSgnLWeeuN0rZli8aJruEX5nBv+Y6TGTDLvc39pLaVUWJWwRKTO1A6
 EIc1wA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahn4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3692c5b061bso896452eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792660173; x=1793264973;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=;
 b=JIYlqAcYYRx1Xo7pYIcrHeGMt0tkqPky3xOjM3uttYRwe9XeT8wVtBugb4mx0T7nsK
 QQQFQ+YHTkgKbs21ML+RM5llsMkLT12CGpeK0yRdyjeWNytUn3KmVzUhgKGrcRXLGi2j
 P+lK2IlvQka8TZKixdqM119rrdnsOwR7PmK7IXsvATenzWOn2bTA4aEcekZOKT2IMqoT
 FBkiDn4n9Z6ao1ofw9qytqP8zs+Dn5x7mMjJpCXXJw+70l/DVZrblHo/DhT+i6AGz2Kq
 e/ZO1fHCZabFHieD1CHRBkE5PmvdXrayhWQT7kywiduwnDPe0Fi8eDq/ExYLm/pScdKD
 RfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660173; x=1793264973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=;
 b=gincQphQRBixImO49EsFBUhkCW6Zuj84d4uwEub2d9Hra502EhpHujv6UDjAXQ9pWF
 eqQM+2UDjuXWv376VGEbkdjbjdVOqvSazNAay8xyfPczJbTCd8KxQ/53y3vGSJ4wSG6o
 2ta4ga0maDFmsbqFPbtfPVRNT482SnhkNoKTpwUou06dX9tIy1Ha5zEmSPTnoYfnDKZq
 f4Xda6T15P1W+g9Pv64lkHYSTf0SPRdI2l+LtewSbnoPZWwPo8G1uQGNBqAFmZhBO9oF
 8pdGrckOlHwSsY48gCi7GkJzgziX6XoEXDkNREtUR+pkxZj51Mk9Zyk7sE9lRInO2zh4
 Y78Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGrlSKd3kEHlZM6tIwSnmu8Eq9fLDIfpbitg1xC3M0m//u51snq8MwOs5/olWlIu4t3puivGontZM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLRjBYKmk/W5C4lRLG8hBUOEq8oSe13mrsnYJw837kYFQn/ccVO
 h/GZQK/7LIKGjyNB2mNskfSnkv1ySLdR00GZJTwIgZYaHrLypp712TXmh4YxBUolbOgRYYCWpyz
 kQ16YAzCfPEF6o3/H+XPPNJ6mvTAdj6yMSrP3byvq7mFt4SB0bzDa13Fd+Z/QVCJp4sic/NM=
X-Gm-Gg: AYBFou3I5SOtDJwqeo5V55yl7NGtSnn99gH4GWYvgWv1rjtJRLUS5R4fxDYegB8Oyek
 TpI1U/Vf2PnXIwoUHmPpDtPYLGoV4N4bJ2fBFecf05pZfnLP+W6W4t6YD581rWSakPIBAMb1Q1p
 7+rKAE5ppIyEwoxc5Pqt22UUELIOibNpEsIibWmllcfluuOpoAWj93nc82UdHDVjTwuNpMb78e0
 sjQpNC0xpc9vXb1i+eX8cKcs/Zf4IduR05+JGzjhl/IGnYjOb6hcFSFOjUZcKG/UtHewAGQ47Mu
 42VWUF/jjOfbQ+iRwVm8BvNLAWotLolye/411sv6GUpovSCezFk4j5aqPN/MW4XS17KXI20vh9K
 zxRbzn0uaJLNPzgu565LF8y0ZkDrcA1D5
X-Received: by 2002:a05:7022:3f09:b0:18b:bce0:a227 with SMTP id
 a92af1059eb24-190a6adcd36mr6565158c88.15.1792660173235; 
 Thu, 22 Oct 2026 02:09:33 -0700 (PDT)
X-Received: by 2002:a05:7022:3f09:b0:18b:bce0:a227 with SMTP id
 a92af1059eb24-190a6adcd36mr6565116c88.15.1792660172672; 
 Thu, 22 Oct 2026 02:09:32 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a180b9esm20475694c88.4.2026.10.22.02.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:09:32 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:38:47 +0530
Subject: [PATCH v2 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-fastrpc-probe-fixes-v2-1-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660163; l=2456;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=gXjATeM4mZmReR8r0Cip4k+l0pcgcK7OC7jL7Usz15g=;
 b=8iJBr+ATdJCU8iVTzYlUb94TGIBcH2KOuljI0XoPmBRr5XGtpiQDEOswWN590/Yv2vamfMEy3
 TbUqejlm+2lDL+f2YkKmWMu7HVv5HlkgMxM3BKl9mdpWAdKCNExxSM6
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX20rSi5ez7uXG
 B5NE+rs8A3AKtC+WbZTMzqcnqIYF157yIHSPIy7bPI9658SMA7/FUotjhV+OAPclzGYZX/D8m5L
 b3HeT/TnoB6KaX3Rjt8UIw4EWBawGLBrDdwA4pHvV5TOP0D0flX6zzSP25qiBhUoZTGzNHK6kWj
 V7UHCe9EqYJzQhAqSQth4rk1P7+gMxU//RgYz9vwI3r4xoa5M6dSFDdu5ame07daNkNnfac2pol
 EeDJHXcRGaacVOoHwF6GZQPvglQnjcCXiJzo11K1UV/XGbUDbdmtO96eGeCnheB299Ja6r5cluq
 2puKyjToeg9sbp93uL4nU43zkqw8MByilfysmfnfj1GbzYROD1UlbdLW2t93dxzOY3+NZkElTVp
 LqnbZUrDseSUNueX7A9rPWymC/EXcuYSGm3y88RpFBMFQ4xdX3zvE980fkF5XACimzaXOo+IA29
 8rIv6gPpGh7LEVq6BPQ==
X-Proofpoint-GUID: exjNoPQ_nibUJp4v8d-LL2EvvCqoK9ig
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9d2ce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HPkHAgnwbDoOiCnvmVMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: exjNoPQ_nibUJp4v8d-LL2EvvCqoK9ig
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfXxC/dSOamUFWU
 HrXE6xe1NAQYqV195uh6SfB/wiUE+AZy+5UwDkaKKigNQ0bC4Jklo9T3z0q869nXBDru/MN3wxY
 VxKkEBitkwKLvKGbuTmFvEXhjAbD4yg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036
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

When a fastrpc client process dies abnormally without closing its file
descriptor, fastrpc_device_release() is never called and the compute-cb
session slot is never freed. The abnormal client death on the DSP side
triggers a glink channel teardown which propagates up through the rpmsg
bus and calls fastrpc_rpmsg_remove().

fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
misc_deregister(). If a concurrent open() enters fastrpc_device_open()
in this window and fastrpc_session_alloc() returns NULL (sessions
exhausted by the leaked slot), the error path dereferences
cctx->rpdev->dev causing a NULL pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
  Call trace:
   fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
   misc_open+0xd8/0x1a0

Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
misc_deregister() both take misc_mtx, so misc_deregister() will either
block until fastrpc_device_open() completes or prevent new opens from
entering it entirely.

Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
Cc: stable@vger.kernel.org
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5dd1990d3e2a..f280bff2edf0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2697,6 +2697,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
@@ -2704,12 +2710,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 

-- 
2.34.1

