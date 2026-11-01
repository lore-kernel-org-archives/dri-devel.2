Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B83606ECCD
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TqIfUXs5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EhD3FMBv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E149810EAC0;
	Sun,  1 Nov 2026 22:26:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206A210EAC0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:26:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KKFiY733053
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VH5oZcye/R46VG7GKGZ6vqEDOzHFGzla9wugxvshNp0=; b=TqIfUXs5sWgTMRRX
 FEe2xrUwCuW6Ic5OGPgZJL9qjLZpyf1zJcwTO+tm3fw6q6zFHu8RGTT2NhzXljjn
 4D7vXnvSEcURiG8C70nRxUhSL2a2trY6RUqoBhsnZFmsstxWQ3P/RNUWbDhO2RW0
 TT2ziFDPeFeH9P1euEyBU6xrigE1qcAWdYqU4WT6CJXOqqnqBqhLRQR9DPjpIAfx
 zgC3NRrenpCYuKRCs1g39ogxG6Q7RG+ZRAa2YJTehGqlAuHU7QHBYEuW3KI8OnVr
 ThufX4WLhtzX+QmH//fT+EkFq+7PQWlccFkmHuJMOzepsWv0tiYimolqlkqftR9f
 HikMpw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7v9mt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:26:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a26fe9521so3264411eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571960; x=1794176760;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VH5oZcye/R46VG7GKGZ6vqEDOzHFGzla9wugxvshNp0=;
 b=EhD3FMBvrhMNU1HZNWEtqxYCktAuJxWdhTuF1rUHtPJPVD/rV10QFpOBRwT8ffqjkm
 zfUvpoiFVmtBXzCnczteM9TRvAOW9/erO6TbfhTkE15gC0EpdRnefTJJ3u7UAh1wjJ78
 tcRewBNjbOBPj9NGcAs/M75GWDewwy32Vf21jFgUV/NzKYYDj24TLVCVUPiTuroo2CWL
 BWVL7W1upu4IqLVwZ7plX++X5fmnBaXigDs8cANAiutnaoTxrs/Cf2svQ+3wmBVTCmHf
 isxX78/Ph0SFEPM6eh73V5X77IF8JE7Z+w9iaTVViv55TOG86+ayZ4lJNk8F3+WXD2Gv
 50sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571960; x=1794176760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VH5oZcye/R46VG7GKGZ6vqEDOzHFGzla9wugxvshNp0=;
 b=2bAreVvL4AWTp46pY2UuZ3XaL4u0wHdAOR3ryO/HrIi94noNh5W9WjQcH8DVBdPY22
 yYzp5XEFpnjKW7Na1xluRHeNlnoIL65MSkn4YEYBfxxmtej0ihSzyK1Z88FX0OP6qUTC
 TgJuRLv0mtjg5XHYxRCWn7WiN8h0MiONWcc7aCHVbGAFig1uqoOlPo47VEU02DsPNgD4
 m1u8QcJmkDj58WVKnJNCUlYKAZTMi6CwPaiDPPmgjiyk0lxvQ62PATVEEvBJVIUBN1D4
 mnJXrsxJC/37qqv10DU651Iab86yZv+CPlyYI5hHLft3hwPS6vR2oKxPfAqdVHiVHAFF
 sxhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2zLg8WKL+gZaFz3YWmMthc3jp6fn/WY4Qb7U5RAhmAcpdP9JS+IzSHF21aOFd2bqWRIiy0Ij+F1Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQSt7e+HCx3/chY3YrViPvgH/UL/v8w6EVO2U4y3GRcEEHfGBX
 4p+pZUbfoFhy5VsbN/G+3JV0JmOgG5J6kpRVTEprA6PzvJ1kmVze7Mc1eZf5c9nbs/2ymlimCMy
 dhFIs1MtyOs1u8VrZzhfFpliphBAF894+arsrgbtXEveCrADykl8EqJ4ILc2SAOLnwiyown8=
X-Gm-Gg: AYBFou0zemKwSsJkAb6B9cCrIMcu0Y6lfWAA6jHvuZW8ncGmO3iBNMWSWyecY1Kwbs0
 9gX9Y4ugvQjeJ9s4jsGZ34At98dC3k+W1klDVXaad5gtGyOGs41z9YOukcBDIwg2UQ4rVh6PQwO
 SzPGO0MPwCDiH8yk/KpCdso5YFk+VCm8jsy7S/wQe2mKEJ/CGvi+CDVsAzlNSK6grl607yZhP5K
 KLYHhyr9sVRO86cINfc8b+6GRKRIskeyJFwM5TXispL6HkwSayjXtzQlhmk/qeGhWE94Jrx6yV2
 6ZAim+ks8FVtUoa3XHLrOhLdtv1mJf2WqC/bC2RCJ6vhxptOASK2tPHUsX6xRCqBvt0q+mlTkYQ
 nR7dfmXt5U4pyf3ZdR+zf0/noVJm/InekLMsyXXQvgJTQTqBKK5WnffGSE99eBbzqAgksjfVLtq
 tgFWcSlg==
X-Received: by 2002:a05:7022:b053:10b0:19d:233:989d with SMTP id
 a92af1059eb24-1ac5b02894bmr12804556c88.14.1793571959280; 
 Sun, 01 Nov 2026 14:25:59 -0800 (PST)
X-Received: by 2002:a05:7022:b053:10b0:19d:233:989d with SMTP id
 a92af1059eb24-1ac5b02894bmr12804508c88.14.1793571958553; 
 Sun, 01 Nov 2026 14:25:58 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:58 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:38 +0530
Subject: [PATCH v4 25/25] accel/qda: Add poll mode for invocation
 completion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-25-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=20282;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=+nPkE5NneCmaTJhchIOEXlxkCnJcDVLKMVDvWgcCpkA=;
 b=6+KxBiSn04aQ8+0IsDOZm32O2gNrJAGFR2fC78J2dqilYzKg1S4VC/UqxfLRD7CZ23VroIn4W
 oPaR5eDnldaAo6gTjGKr1ucceaMjPNLDFSQhiShyrST32Ay0vp1ku/k
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: xF0jdsJEucrW96dZMFVw-0viInkZCbwx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXx3hYZni30DJm
 Cdkind0wz+TEwx8maTu8D2z6RbucfARpgtkow4bi2ceMX4TKBd2RqM2qibYE+aBhgVhH4p3J0oS
 +nOqnXCLr/GsqXH6cmPCOBqlTwatB1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX5jLLlz/qRspO
 h0H79OZ4hB0+yw/fDOk9y9nJV4UQixm60f5/a0NWsG8NwLTEG+o02zqQNSq0dj1pa6igg3mIgky
 pQ1zJ5LlkNN2eCPaVAAycsh6s4LHgEs8zT+yY9N02EaH+quNQAFv7XC+SnYnAXoE5Vm60XRithQ
 vKxwQgRy57P8ekIvMiaediIUa5X3yGC5i0s+4nKEGPCsoCVbqygdXjmp5niGazPxMsmT5vBtsZJ
 c7aJyO8XE1UqoTTW0is4lpof/tgh5PrX2QFwxTwi6EAoEAQSYDBXWQMTOlEyHuB+I0sEIoL3Olm
 OtDmvqMKrxotUt0bkO0Sgmlcr5wkyS7NYBScXH0XshXuJ7WAHE34nWfaOVEUmfa7c1uK+wamcpO
 UHfzkL/p/LjgWw6VJMaysGPZLauTcQdBoTl+depVFuUFQpLm86S6myt/9qMPAxs8B8uvbOSrOTE
 ApDXOCUFiSiMu1EnKew==
X-Proofpoint-GUID: xF0jdsJEucrW96dZMFVw-0viInkZCbwx
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae7bc79 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ck3PsjUFfxvozorqPcMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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

From: Ekansh Gupta <ekangupt@qti.qualcomm.com>

Let a session opt in to completion polling for dynamically loaded
module invocations in a user PD via a new DRM_IOCTL_QDA_SET_OPTION
ioctl (and the equivalent legacy FASTRPC_IOCTL_SET_OPTION), mirroring
drivers/misc/fastrpc.c's FASTRPC_POLL_MODE.

A poll word is reserved at the end of every invocation's metadata
region. When polling is enabled, in use, and the invocation targets a
dynamically loaded handle in a user PD, the driver busy-waits on that
word for QDA_FASTRPC_POLL_RESPONSE instead of immediately blocking on
the rpmsg response, trading CPU cycles for lower round-trip latency.
If the DSP has not answered by the time the poll loop times out, the
driver falls back to waiting for the interrupt-based rpmsg response as
usual; the two paths share an is_work_done flag so whichever notices
completion first wins without racing the other.

Only SoCs whose DSP firmware actually implements this are allowed to
enable it: qda_soc_data gets a poll_mode_supported flag, set for
Kaanapali, and a closed list of older platforms using the generic
default_soc_data is checked as a fallback.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c          |  1 +
 drivers/accel/qda/qda_drv.h          |  8 +++++
 drivers/accel/qda/qda_fastrpc.c      | 67 +++++++++++++++++++++++++++++++++---
 drivers/accel/qda/qda_fastrpc.h      | 15 ++++++++
 drivers/accel/qda/qda_fastrpc_shim.c | 30 ++++++++++++++++
 drivers/accel/qda/qda_ioctl.c        | 45 ++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h        |  2 ++
 drivers/accel/qda/qda_legacy_ops.c   |  1 +
 drivers/accel/qda/qda_legacy_ops.h   |  2 ++
 drivers/accel/qda/qda_rpmsg.c        |  3 ++
 drivers/accel/qda/qda_soc.c          | 33 ++++++++++++++++++
 drivers/accel/qda/qda_soc.h          |  3 ++
 include/uapi/drm/qda_accel.h         | 27 +++++++++++++++
 13 files changed, 233 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 51d8ef10c6c1..912dcb2b593d 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -128,6 +128,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MMAP, qda_ioctl_mmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MUNMAP, qda_ioctl_munmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_ATTACH, qda_ioctl_attach, 0),
+	DRM_IOCTL_DEF_DRV(QDA_SET_OPTION, qda_ioctl_set_option, 0),
 };
 
 static const struct drm_driver qda_drm_driver = {
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index cbb580d03e0b..ff58bac77319 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -71,6 +71,12 @@ struct qda_session {
 	 * ioctls on one file can run concurrently.
 	 */
 	struct qda_gem_obj *init_mem_gem_obj;
+	/**
+	 * @poll_mode: Poll for completion of invocations on dynamically loaded
+	 * modules in a user PD. Set through the set-option ioctl, which can run
+	 * concurrently with invocations on the same file.
+	 */
+	bool poll_mode;
 	/**
 	 * @msg_buf_pool: Invoke header buffers this session is done with,
 	 * kept for its later invocations to reuse.
@@ -146,6 +152,8 @@ struct qda_dev {
 	struct mutex remote_heap_lock;
 	/** @audio_init_mem: True once the DSP has been given the remote heap */
 	bool audio_init_mem;
+	/** @poll_mode_supported: Sessions may opt in to invocation completion polling */
+	bool poll_mode_supported;
 };
 
 /**
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 6044cfad53e9..0617bb4842b5 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -3,6 +3,7 @@
 #include <linux/bitfield.h>
 #include <linux/capability.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
@@ -89,8 +90,8 @@ static u64 calculate_page_aligned_size(u64 addr, u64 len)
  * import time unless they are. So the metadata region needs exactly one
  * qda_remote_buf, one qda_invoke_buf and one qda_phy_page per scalar; unlike
  * drivers/misc/fastrpc.c, which supports multi-page buffers and so may need
- * several qda_phy_page entries per scalar. It ends with the handle list and
- * the CRC list.
+ * several qda_phy_page entries per scalar. It ends with the handle list, the
+ * CRC list and the poll word.
  */
 static size_t qda_fastrpc_get_meta_size(struct qda_fastrpc_invoke_ctx *ctx)
 {
@@ -98,7 +99,8 @@ static size_t qda_fastrpc_get_meta_size(struct qda_fastrpc_invoke_ctx *ctx)
 		sizeof(struct qda_invoke_buf) +
 		sizeof(struct qda_phy_page)) * ctx->nscalars +
 		sizeof(u64) * QDA_FASTRPC_MAX_HANDLELIST +
-		sizeof(u32) * QDA_FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * QDA_FASTRPC_MAX_CRCLIST +
+		sizeof(u32);
 }
 
 /**
@@ -518,6 +520,10 @@ static int qda_fastrpc_get_args(struct qda_fastrpc_invoke_ctx *ctx, struct qda_m
 	pages = (struct qda_phy_page *)&list[ctx->nscalars];
 	/* Kept so the handle list, which follows the pages, can be found later */
 	ctx->pages = pages;
+	/* The poll word follows the handle list and the CRC list */
+	ctx->poll_addr = (u32 *)((u8 *)(pages + ctx->nscalars) +
+				 sizeof(u64) * QDA_FASTRPC_MAX_HANDLELIST +
+				 sizeof(u32) * QDA_FASTRPC_MAX_CRCLIST);
 
 	for (i = 0; i < ctx->nbufs; ++i) {
 		rpra[i].buf.addr = 0;
@@ -598,6 +604,54 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *
 	return 0;
 }
 
+static u32 qda_fastrpc_read_poll_addr(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	dma_rmb();
+
+	return READ_ONCE(*ctx->poll_addr);
+}
+
+/*
+ * Busy-wait for the DSP to write QDA_FASTRPC_POLL_RESPONSE into the poll word,
+ * which saves the interrupt and scheduling latency of waiting for the rpmsg
+ * response. The response still arrives afterwards and drops the reference
+ * qda_rpmsg_send_msg() took for it as usual.
+ *
+ * Return: 0 if the invocation completed, negative error code if it has not
+ * answered within QDA_FASTRPC_POLL_MAX_TIMEOUT_US
+ */
+static int qda_fastrpc_poll_for_rsp(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	u32 val;
+	int err;
+
+	err = read_poll_timeout_atomic(qda_fastrpc_read_poll_addr, val,
+				       val == QDA_FASTRPC_POLL_RESPONSE ||
+				       READ_ONCE(ctx->is_work_done),
+				       1, QDA_FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
+	if (err)
+		return err;
+
+	/* The rpmsg path records its own status, so only the poll path's is set here */
+	if (val == QDA_FASTRPC_POLL_RESPONSE) {
+		WRITE_ONCE(ctx->is_work_done, true);
+		ctx->retval = 0;
+	}
+
+	return 0;
+}
+
+static int qda_fastrpc_wait_for_completion(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	if (ctx->is_polled && !qda_fastrpc_poll_for_rsp(ctx))
+		return 0;
+
+	/* Polling timed out, so fall back to waiting for the rpmsg response */
+	ctx->is_polled = false;
+
+	return qda_rpmsg_wait_for_rsp(ctx);
+}
+
 /**
  * qda_fastrpc_flush_pending() - Fail every invocation still in flight
  * @qdev: Device whose invocations should be failed
@@ -617,6 +671,7 @@ void qda_fastrpc_flush_pending(struct qda_dev *qdev)
 
 	xa_for_each(&qdev->ctx_xa, idx, ctx) {
 		ctx->retval = -EPIPE;
+		WRITE_ONCE(ctx->is_work_done, true);
 		complete(&ctx->work);
 		kref_put(&ctx->refcount, qda_fastrpc_context_free);
 	}
@@ -680,11 +735,15 @@ int qda_fastrpc_invoke_common(struct qda_dev *qdev, struct qda_fastrpc_invoke_ct
 	if (err)
 		return err;
 
+	/* Only invocations of a dynamically loaded module in a user PD are polled */
+	ctx->is_polled = READ_ONCE(ctx->session->poll_mode) && ctx->pd == QDA_USER_PD &&
+			 ctx->handle > QDA_FASTRPC_MAX_STATIC_HANDLE;
+
 	err = qda_rpmsg_send_msg(qdev, &msg);
 	if (err)
 		return err;
 
-	err = qda_rpmsg_wait_for_rsp(ctx);
+	err = qda_fastrpc_wait_for_completion(ctx);
 	if (err)
 		return err;
 
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 7d5cd04943a3..2e01d126addc 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -75,6 +75,15 @@ struct qda_session;
 #define QDA_USER_PD			1
 #define QDA_SENSORS_PD			2
 
+/* Handles up to this value name static DSP services, not loaded modules */
+#define QDA_FASTRPC_MAX_STATIC_HANDLE	20
+
+/* Value the DSP writes to the poll word once a polled invocation completes */
+#define QDA_FASTRPC_POLL_RESPONSE	0xdecaf
+
+/* How long to poll before falling back to waiting for the rpmsg response */
+#define QDA_FASTRPC_POLL_MAX_TIMEOUT_US	10000
+
 /* Largest ELF image a process may be created from */
 #define QDA_FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
 
@@ -342,6 +351,12 @@ struct qda_fastrpc_invoke_ctx {
 	struct drm_gem_object *map_obj;
 	/** @pages: Array of physical page descriptors inside the payload */
 	struct qda_phy_page *pages;
+	/** @poll_addr: Poll word at the end of the payload, written by the DSP */
+	u32 *poll_addr;
+	/** @is_polled: Wait for completion by polling @poll_addr first */
+	bool is_polled;
+	/** @is_work_done: Set once either the poll or the rpmsg path saw completion */
+	bool is_work_done;
 	/** @work: Completed once the DSP has answered */
 	struct completion work;
 	/**
diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda_fastrpc_shim.c
index 2be1dd116ef7..acd1b1b2f2b7 100644
--- a/drivers/accel/qda/qda_fastrpc_shim.c
+++ b/drivers/accel/qda/qda_fastrpc_shim.c
@@ -463,6 +463,34 @@ static long qda_shim_mem_unmap(struct qda_shim_file *sf, void __user *argp)
 	return 0;
 }
 
+/*
+ * The legacy request IDs and values match the accel ones, but they are
+ * translated rather than passed through, so the two ABIs stay independent.
+ */
+static long qda_shim_set_option(struct qda_shim_file *sf, void __user *argp)
+{
+	struct fastrpc_ioctl_set_option args;
+	int i;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(args.reserved); i++)
+		if (args.reserved[i])
+			return -EINVAL;
+
+	if (args.request_id != FASTRPC_POLL_MODE)
+		return -EINVAL;
+
+	if (args.value != FASTRPC_POLL_MODE_ENABLE &&
+	    args.value != FASTRPC_POLL_MODE_DISABLE)
+		return -EINVAL;
+
+	return qda_legacy_ops_table.set_option(sf->session, QDA_SET_OPTION_POLL_MODE,
+					       args.value == FASTRPC_POLL_MODE_ENABLE ?
+					       QDA_POLL_MODE_ENABLE : QDA_POLL_MODE_DISABLE);
+}
+
 static long qda_shim_get_dsp_info(struct qda_shim_file *sf, void __user *argp)
 {
 	struct fastrpc_ioctl_capability args;
@@ -570,6 +598,8 @@ static long qda_shim_dispatch(struct qda_shim_file *sf, unsigned int cmd, void _
 		return qda_shim_invoke(sf, argp);
 	case FASTRPC_IOCTL_GET_DSP_INFO:
 		return qda_shim_get_dsp_info(sf, argp);
+	case FASTRPC_IOCTL_SET_OPTION:
+		return qda_shim_set_option(sf, argp);
 	default:
 		/*
 		 * Includes FASTRPC_IOCTL_FREE_DMA_BUFF, which the driver this
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index c784defd0f70..f43fae60059d 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -413,3 +413,48 @@ int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_p
 {
 	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INVOKE_DYNAMIC, data, file_priv->driver_priv);
 }
+
+/**
+ * qda_session_set_option() - Set a per-session option
+ * @session: Session to update
+ * @request_id: Option to set (QDA_SET_OPTION_*)
+ * @value: Request-specific value
+ *
+ * Shared by the accel UAPI and the legacy shim's FASTRPC_IOCTL_SET_OPTION.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_session_set_option(struct qda_session *session, u32 request_id, u32 value)
+{
+	switch (request_id) {
+	case QDA_SET_OPTION_POLL_MODE:
+		if (!session->qda_dev->poll_mode_supported)
+			return -EOPNOTSUPP;
+
+		if (value == QDA_POLL_MODE_ENABLE)
+			WRITE_ONCE(session->poll_mode, true);
+		else if (value == QDA_POLL_MODE_DISABLE)
+			WRITE_ONCE(session->poll_mode, false);
+		else
+			return -EINVAL;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * qda_ioctl_set_option() - Set a per-session option
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_set_option)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_set_option(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_set_option *args = data;
+
+	return qda_session_set_option(file_priv->driver_priv, args->request_id, args->value);
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 329f3809c8ce..277c16742196 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -20,6 +20,8 @@ int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *f
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_set_option(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_session_set_option(struct qda_session *session, u32 request_id, u32 value);
 int qda_session_init_create(struct qda_session *session, struct qda_init_create_args *create);
 int qda_session_attach(struct qda_session *session, u32 pd_type, const char __user *name,
 		       u32 namelen);
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index 8d9d597c76c2..18c17d5a9d2b 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -198,6 +198,7 @@ const struct qda_legacy_ops qda_legacy_ops_table = {
 	.session_destroy = legacy_session_destroy,
 	.init_create = legacy_init_create,
 	.attach = qda_session_attach,
+	.set_option = qda_session_set_option,
 	.release = legacy_release,
 	.mmap = legacy_mmap,
 	.mem_map = legacy_mem_map,
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
index c79003021fc1..ffb3ebd9b1c5 100644
--- a/drivers/accel/qda/qda_legacy_ops.h
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -36,6 +36,8 @@ struct qda_legacy_ops {
 	/** @attach: Attach the session to a DSP-resident protection domain */
 	int (*attach)(struct qda_session *session, u32 pd_type, const char __user *name,
 		      u32 namelen);
+	/** @set_option: Set a per-session option */
+	int (*set_option)(struct qda_session *session, u32 request_id, u32 value);
 	/** @release: Release the session's DSP process, if it has one */
 	int (*release)(struct qda_session *session);
 	/** @mmap: Map a buffer into the DSP's address space */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
index b93e906b5793..c2a6798cb50d 100644
--- a/drivers/accel/qda/qda_rpmsg.c
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -132,6 +132,7 @@ static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 	}
 
 	ctx->retval = resp_msg->retval;
+	WRITE_ONCE(ctx->is_work_done, true);
 	complete(&ctx->work);
 
 	/*
@@ -267,6 +268,8 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!qdev->soc_data)
 		return -ENODEV;
 
+	qdev->poll_mode_supported = qda_soc_poll_mode_supported(qdev->soc_data);
+
 	ret = of_property_read_string(rpdev->dev.of_node, "label", &qdev->dsp_name);
 	if (ret) {
 		dev_err(&rpdev->dev, "Missing 'label' property in DT node: %d\n", ret);
diff --git a/drivers/accel/qda/qda_soc.c b/drivers/accel/qda/qda_soc.c
index fb316b74103d..c670f747e1f5 100644
--- a/drivers/accel/qda/qda_soc.c
+++ b/drivers/accel/qda/qda_soc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/of.h>
 #include <linux/string.h>
 #include "qda_drv.h"
 #include "qda_soc.h"
@@ -8,6 +9,7 @@ const struct qda_soc_data kaanapali_soc_data = {
 	.sid_pos = 56,
 	.dma_addr_bits_cdsp = 34,
 	.dma_addr_bits_default = 32,
+	.poll_mode_supported = true,
 };
 
 const struct qda_soc_data default_soc_data = {
@@ -16,6 +18,37 @@ const struct qda_soc_data default_soc_data = {
 	.dma_addr_bits_default = 32,
 };
 
+/*
+ * Platforms that share default_soc_data but whose DSP firmware does implement
+ * invocation completion polling. The list is closed: new SoCs advertise
+ * polling support through their own qda_soc_data instead.
+ */
+static const struct of_device_id qda_poll_mode_machines[] = {
+	{ .compatible = "qcom,milos" },
+	{ .compatible = "qcom,qcs8300" },
+	{ .compatible = "qcom,sa8775p" },
+	{ .compatible = "qcom,sar2130p" },
+	{ .compatible = "qcom,sm8450" },
+	{ .compatible = "qcom,sm8550" },
+	{ .compatible = "qcom,sm8650" },
+	{ .compatible = "qcom,sm8750" },
+	{ .compatible = "qcom,x1e80100" },
+	{ .compatible = "qcom,x1p42100" },
+	{ }
+};
+
+/**
+ * qda_soc_poll_mode_supported() - Whether the DSP supports completion polling
+ * @soc_data: SoC parameters of the device
+ *
+ * Return: true if invocations on this SoC may use poll mode
+ */
+bool qda_soc_poll_mode_supported(const struct qda_soc_data *soc_data)
+{
+	return soc_data->poll_mode_supported ||
+	       of_machine_get_match(qda_poll_mode_machines);
+}
+
 /**
  * qda_soc_dma_addr_bits() - DMA address width of a device's context banks
  * @qdev: QDA device
diff --git a/drivers/accel/qda/qda_soc.h b/drivers/accel/qda/qda_soc.h
index fb5b786d0928..db8f10a30f7b 100644
--- a/drivers/accel/qda/qda_soc.h
+++ b/drivers/accel/qda/qda_soc.h
@@ -24,11 +24,14 @@ struct qda_soc_data {
 	u32 dma_addr_bits_cdsp;
 	/** @dma_addr_bits_default: DMA address width of all other context banks */
 	u32 dma_addr_bits_default;
+	/** @poll_mode_supported: DSP firmware supports invocation completion polling */
+	bool poll_mode_supported;
 };
 
 extern const struct qda_soc_data kaanapali_soc_data;
 extern const struct qda_soc_data default_soc_data;
 
+bool qda_soc_poll_mode_supported(const struct qda_soc_data *soc_data);
 u32 qda_soc_dma_addr_bits(const struct qda_dev *qdev);
 
 /**
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 07b943a3c822..816f2c10accf 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -20,6 +20,7 @@ extern "C" {
 #define DRM_QDA_REMOTE_MMAP		0x05
 #define DRM_QDA_REMOTE_MUNMAP		0x06
 #define DRM_QDA_REMOTE_SESSION_ATTACH	0x07
+#define DRM_QDA_SET_OPTION		0x08
 
 #define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
@@ -39,6 +40,8 @@ extern "C" {
 #define DRM_IOCTL_QDA_REMOTE_SESSION_ATTACH					\
 	DRM_IOW(DRM_COMMAND_BASE + DRM_QDA_REMOTE_SESSION_ATTACH,		\
 		struct drm_qda_remote_attach)
+#define DRM_IOCTL_QDA_SET_OPTION	DRM_IOW(DRM_COMMAND_BASE + DRM_QDA_SET_OPTION, \
+					 struct drm_qda_set_option)
 
 /* Request types for drm_qda_mem_map.request */
 #define QDA_REQUEST_MMAP	1	/* Map a whole buffer */
@@ -248,6 +251,30 @@ struct drm_qda_remote_attach {
 	__u64 name;
 };
 
+/* Request IDs for drm_qda_set_option.request_id */
+#define QDA_SET_OPTION_POLL_MODE	1
+
+/* Values for drm_qda_set_option.value with QDA_SET_OPTION_POLL_MODE */
+#define QDA_POLL_MODE_DISABLE	0
+#define QDA_POLL_MODE_ENABLE	1
+
+/**
+ * struct drm_qda_set_option - Set a per-session option
+ * @request_id: Option to set (QDA_SET_OPTION_*)
+ * @value: Request-specific value
+ *
+ * For QDA_SET_OPTION_POLL_MODE, @value is QDA_POLL_MODE_ENABLE or
+ * QDA_POLL_MODE_DISABLE. Enabling poll mode lets the driver poll shared
+ * memory for completion of a dynamically loaded module's invocations in a
+ * user PD instead of waiting for an interrupt-based response, trading CPU
+ * cycles for lower round-trip latency. DSPs that do not support it reject
+ * the request with EOPNOTSUPP.
+ */
+struct drm_qda_set_option {
+	__u32 request_id;
+	__u32 value;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

