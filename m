Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E1C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6682B10F2B6;
	Thu, 16 Jul 2026 11:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nIOEbz0x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0U9ODEq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7E610F2B6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:33:03 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G9rJEi3489652
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=WTRAy0sFKkt4K0c5tsI7r8dGzDm6tiowQmt
 RyKw+h+s=; b=nIOEbz0x42ITX9HMEChRpQQdhLHg32UyJEKHCfy1gJSH5X9iIOa
 g+neUaME8/v06rQnmfBdT+PSZTVaQ7tqGnRsncARLEUQTeKjQo3DadGlA/Dk5ENB
 0hY/y8O9x5ZZJoVvrBc42gkNDKAZl+RPhXnKa3zEaUClGHOHat+7DUEPGksFhmaU
 RFnhfr0Xitvkg9JP1gzDFIm0M7HnY1sDmFRZ45dytQAz+Gtj5if8DFiyR8bDmImg
 Ew53E7EnBLoFI0JWLZNkMH2/mx4oNRsj45XPVGQwf6WjT54nnM4AGfl6an8XJEzs
 4XzN0Ufr8QJEkfEwx8djBsIy3bYecxrVFKg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3phuns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:33:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487eb67173so10522885b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784201582; x=1784806382;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WTRAy0sFKkt4K0c5tsI7r8dGzDm6tiowQmtRyKw+h+s=;
 b=g0U9ODEqpigqlQd1CFnnkbxrdWBGk8x/coXAGPBPWJ0kaNRgZ+lhnP7F7PFT79z/TR
 ZWHXrlL48ric0yqwdvX6iCg1fYVMH3lhuemWjWOXVAQo8Gfc3LQOUeh61L2B9ydpf/3A
 Abft+JaqkcCU6VWduHuqKtLTFpbIfh43SeBUbdE/AwvPfGWTCK2hLIUDIxTMSuMiUFME
 NN1ZLHpodEuKrLAqoOT7tEmE5sm2rvOgpXZNm06Z4uDya5tfqoJNzxQVHRzRq/SHN9jD
 wrrTMy1/iY+8aDOzVnyceWB27tQ4x2jtodhMCO/PjKm78pWHUnTStx0KFwNxgWQcu6Mo
 RrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784201582; x=1784806382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WTRAy0sFKkt4K0c5tsI7r8dGzDm6tiowQmtRyKw+h+s=;
 b=bb4JD5SpRxXMzXHPH+MxkvJef9kWND4lZgHAiYrT507N3nxnw+FssvXRBiOT2+7hz/
 mzrwuW4YxKVfQjyjlwky6E50Y05P8VU+/q/pJitnWN/gemqSffdndydHVilzK/eJTubd
 XRbjvWSHReZJq+j3ah7M196CQ8L6I3xUrKlt7p+zebxVYlW27s0Ofy7/7HaAGmLuan/p
 7XbH8b8j679xPk2uFSeSYVSvppJ+j4XWN1m80fnKvho07xAcgaLeNvyH8B8ZMTqBns5Q
 F5aDNPDwcjaFR7/WprT9zpljO/XYsyf32W2x6nttXdnVf4H0okPVwq90Aykgv2SlLQyO
 Xhkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnkqhJh0DaiaE4zsRbDBn+sBaUvczFBcqWZjnQ8t+aq+T0UZbab1kaZ/DmK/4/J8enJGBadYZXlzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHXEWFQgbqAROfWfciexrXFKM2V3QStkKFxjvgLIzp7MpHeirm
 t9N0kECU3WFBYFHR/AoUK3p6+6/04k1ejZvyOKuGZ/eJZ96Rg21QYinVCh6Ewnjmo2XculB6eNl
 3+XKCzKyBtGOchgxyEI0AlvIp/HYILGsWplCQk2WpABVIGke+vRmzUgLVVowkWSEhBdn5bUA=
X-Gm-Gg: AfdE7cksA9pB2wg54Ywyel10XZdESf27wUdbxS3wVoq7Pn0NZI3kQx9jlTeFerjvqu8
 w76W8LI8okNt8tpDkO8F4yfpz0DvzPEGmrtZBFDxnrU5i+8Ah5foq50OCJXw+Cha+fItFpMuxv3
 K+mfczMyZkt5nT5By6270H6uWQ1eq2Pw8VQqnLLVgtZkYrBTMXZAHobPfaIRT+rgVo4Z5Q24QfL
 eWOBoP/JHVuPXZvJX6fIOWG8ksqZt5R/xtNUJGmST1QKpBznXONlofDub27tFFwrSs8sYm1E6j7
 ESCmYAHPczUIW7MS5j0Rd/cQ2+bVB9R7oGC6Q/LLQSxrSuxo7/NjISM/mdeLSgBlv73IgZQYSb2
 aCetsIiG2PUcqo7a3AM8s8zbERuBL9UA/QRXwCF2txsmjKoDQF9WwXAAROxjxjJ38phRDUt3Ydw
 ==
X-Received: by 2002:a05:6a00:4c8f:b0:848:4d4f:d477 with SMTP id
 d2e1a72fcca58-84a51442133mr11053323b3a.18.1784201582156; 
 Thu, 16 Jul 2026 04:33:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c8f:b0:848:4d4f:d477 with SMTP id
 d2e1a72fcca58-84a51442133mr11053277b3a.18.1784201581521; 
 Thu, 16 Jul 2026 04:33:01 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4ff2ea4csm4624667b3a.23.2026.07.16.04.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:33:01 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ling Xu <quic_lxu5@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v2] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
Date: Thu, 16 Jul 2026 19:32:54 +0800
Message-Id: <20260716113254.570-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 36LhDEoL6kHY5mUouCTf839iVoxgfdTu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDExOSBTYWx0ZWRfX4tpYeJhrfz1b
 RZ7CYUxeRhBU6gLOVyR21XrNPJ4mYWKqaQJbNxSTIXSetG0YvZOi3m3RqrVWKKP93TmAXhO5hnR
 fW219Oukv2E6hfISgCSXv3pN/RKNLN0=
X-Proofpoint-GUID: 36LhDEoL6kHY5mUouCTf839iVoxgfdTu
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58c16f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jcsToSEUEPbHcpESBJIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDExOSBTYWx0ZWRfX8KFpUrxnVdAY
 PleIqYvStwzsemJZ94Q0PAVDZ/v9lap4f0jAIIgE7zcoFnCNdaIQV/GKuC1r/mNmPCVWqSADc0n
 qf6wtoooMPzB+dXkHLW2/ReSyeAA3SuhaRSXc0dIvJacNeIFyU1r6QTPJCY1VvCnqWqprIiUvC+
 MnZzDEkfENoLiTrSoSx7TE/DUX5IKeL3/HKhEK9SALBRcBRbfcjMwvHup/+KMI7Mug4x8xBcW6Q
 lB88JP+nJ6YNgH2BMboleISuYIntovS0Ef3+dRQVH1XHUUaZAxk3tt+q/D7VX8yZrUddwl28bv2
 0P5BNOJ1OqExH5YyJkC4OFmg3dRY40CSP5MkQ+GASCjhw7zp1VspA/yUnG5clHrEhI63g3Jvb0r
 6xqFCyHfyy9AsSAMcP9oB9RdAxEAH8IRj9b++HFgabQYHsimlht7ZdxFYY0GfyZLxCXPCuCA2cl
 mOq4EyNsCQH1VbxIVbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160119
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

DMA handles passed as invoke arguments (scalars beyond nbufs) may refer
to the same dma_buf fd as an input/output buffer argument. Taking an
extra reference for such DMA handle maps leads to duplicate mappings and
an unbalanced reference count, since DMA handle maps are released
separately when the DSP returns the fd through the fdlist.

Fix this by not taking an extra reference for DMA handle arguments
(take_ref = false) and tagging them with FASTRPC_MAP_DMA_HANDLE. As
these maps are borrowed references, fastrpc_get_args() re-validates the
map via fastrpc_map_lookup() before dereferencing it, so it is not used
after being freed. fastrpc_put_args() only releases maps flagged as
FASTRPC_MAP_DMA_HANDLE and clears the flag to guarantee the map is freed
exactly once.

Also reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since such
handles are already mapped implicitly during the remote invoke call and
must not be mapped again through the explicit MEM_MAP path.

Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
Patch [v1]: https://lore.kernel.org/all/20260625080832.17477-1-jianping.li@oss.qualcomm.com/

Changes in v2:
- Rework the commit message to describe the DMA handle reference and
  lifetime problem more precisely.
- Introduce a new FASTRPC_MAP_DMA_HANDLE uapi flag and a 'flags' field
  in struct fastrpc_map to explicitly tag DMA handle maps, instead of
  relying only on the nbufs boundary / take_ref.
- Plumb an mflags argument through fastrpc_map_create() and
  fastrpc_map_attach() so DMA handle maps are tagged at creation time.
- Re-validate the borrowed map in fastrpc_get_args() via
  fastrpc_map_lookup() before dereferencing it, to avoid a
  use-after-free when the map was created with take_ref = false.
- In fastrpc_put_args(), only release maps tagged FASTRPC_MAP_DMA_HANDLE
  and clear the flag afterwards, so such maps are freed exactly once.
- Reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since these
  handles are already mapped implicitly during the remote invoke and
  must not be mapped again through the explicit MEM_MAP path.
---
 drivers/misc/fastrpc.c      | 56 ++++++++++++++++++++++++++-----------
 include/uapi/misc/fastrpc.h |  2 ++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..fa8c58a97e35 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -223,6 +223,7 @@ struct fastrpc_map {
 	u64 len;
 	u64 raddr;
 	u32 attr;
+	u32 flags;
 	struct kref refcount;
 };
 
@@ -833,7 +834,7 @@ static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t s
 }
 
 static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap, int mflags)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
@@ -850,6 +851,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 
 	map->fl = fl;
 	map->fd = fd;
+	map->flags = mflags;
 	map->buf = dma_buf_get(fd);
 	if (IS_ERR(map->buf)) {
 		err = PTR_ERR(map->buf);
@@ -924,13 +926,13 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	return err;
 }
 
-static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd, u64 len, u32 attr,
+			      struct fastrpc_map **ppmap, bool take_ref, int mflags)
 {
-	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
+	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
 		return 0;
 
-	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
+	return fastrpc_map_attach(fl, fd, len, attr, ppmap, mflags);
 }
 
 /*
@@ -1000,23 +1002,25 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	int i, err;
 
 	for (i = 0; i < ctx->nscalars; ++i) {
+		bool take_ref = i < ctx->nbufs;
+		int mflags = 0;
 
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
 		    ctx->args[i].length == 0)
 			continue;
 
-		if (i < ctx->nbufs)
-			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
-		else
-			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		/* Set the DMA handle mapping flag for DMA handles */
+		if (i >= ctx->nbufs)
+			mflags = FASTRPC_MAP_DMA_HANDLE;
+
+		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
+					 ctx->args[i].attr, &ctx->maps[i], take_ref, mflags);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
 		}
-
 	}
+
 	return 0;
 }
 
@@ -1144,6 +1148,16 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
 		if (ctx->maps[i]) {
+			/* It is possible that map is created with
+			 * mflags FASTRPC_MAP_DMA_HANDLE and take_ref
+			 * is false. Check if map still exists or is
+			 * being freed as take_ref is false
+			 */
+			if (fastrpc_map_lookup(ctx->fl, ctx->args[i].fd,
+					       &ctx->maps[i], false)) {
+				ctx->maps[i] = NULL;
+				return -EINVAL;
+			}
 			pages[i].addr = ctx->maps[i]->dma_addr;
 			pages[i].size = ctx->maps[i]->size;
 		}
@@ -1200,8 +1214,13 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
+		/* Validate the map flags for DMA handles and skip freeing map if invalid */
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
+		    mmap->flags == FASTRPC_MAP_DMA_HANDLE) {
+			/* Allow DMA handle maps to free only once */
+			mmap->flags = 0;
 			fastrpc_map_put(mmap);
+		}
 	}
 
 	return ret;
@@ -1511,7 +1530,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true, 0);
 		if (err)
 			goto err;
 	}
@@ -2107,9 +2126,14 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
-
+	/*
+	 * Prevent mapping backward compatible DMA handles here, as they are
+	 * already mapped in the remote call.
+	 */
+	if (req.flags == FASTRPC_MAP_DMA_HANDLE)
+		return -EINVAL;
 	/* create SMMU mapping */
-	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
+	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true, 0);
 	if (err) {
 		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
 		return err;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index c6e2925f47e6..142ddaeed85f 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -44,6 +44,8 @@ enum fastrpc_map_flags {
 	FASTRPC_MAP_FD = 2,
 	FASTRPC_MAP_FD_DELAYED,
 	FASTRPC_MAP_FD_NOMAP = 16,
+	/* Map the DMA handle in the invoke call for backward compatibility */
+	FASTRPC_MAP_DMA_HANDLE = 0x20000,
 	FASTRPC_MAP_MAX,
 };
 
-- 
2.43.0

