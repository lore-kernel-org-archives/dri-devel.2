Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E95606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nXOOeaKk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QZ3Vr+wu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09CD10E409;
	Tue, 27 Oct 2026 13:42:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3742110E409
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:42:19 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDWiQF1278345
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Wu6wfhQhW1dB1rR6rYt6nJ
 W2S0rcMaPPfRauIfBGxdg=; b=nXOOeaKk7UchDVGaTCxue398o4fNEl2F9RMKUe
 tBOhssxSTsYGSgty5eNrUv1WkgOgFS91zBrVTMQ+qz9v2hGr9SpvJSIyfFtHM61o
 EUc9+lve7LN75Ts4d2/joxo5EJimmu2vYXOQ25qjvGpf0zmnFDSLwjakS76IeEAh
 WzuxC7OXJIdEmCHdMderG62zXFkdCdET4bIxCjuqFHeRAB1rdMWL8yTH+QJvoXXp
 GZQp/fM2XRT/mt/kyn40iax9FOF7X43YYXvR8NPbOv9M7uCSqYw2dNW6KYo44MXI
 U5zvYk1HwITy0FdvG+fS36ZBz8yrVOsxfL4F94ZxUu0FWO2A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98a2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:42:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c60ab8929so47411766d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793108537; x=1793713337;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wu6wfhQhW1dB1rR6rYt6nJW2S0rcMaPPfRauIfBGxdg=;
 b=QZ3Vr+wugTG7RO0QJI+xlgMb9eXuBeAsPufcJJcHZlHpJFElhyiCcP1MHIkL2o8wMx
 7iE0/SDVZX7bVcDoa884oGcRhkdmNS1T03txGEE6diNVcVQEwVciIqVkz4SJbqxyi7Ky
 Lmgjd0xCiCKeKNnU2VULgn6yi+S2cDW8TvVS87OdeJqruMY2uO4R/+Nvy183NAx5LQAa
 phbh77P7eR4XXPHpM+751qHd+V5gwK914fXGobjXKEgTUIkptbYS+Cs6tfp1+L9H+I25
 xuRywSsNJDRCE6utktZzsv33vaw+LCT67vK8ltp3XBc2EHVl8+QmE0/tfTLMelg6tgbZ
 UxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108537; x=1793713337;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Wu6wfhQhW1dB1rR6rYt6nJW2S0rcMaPPfRauIfBGxdg=;
 b=iUfjUGaaC//JaMtf5vTnz5RM0ZxvbyzDNV2KdazgkJ0bUt+pi9I0XeD1JzwmaXJcPx
 mHrqHyjFpxJwdzOrTWMeJhhcnbhvtoO+lSRaVeRGTGbcmxn1C1gwoB6sGrhOHt0IxSkj
 4fMH3p8weUbKg9pn/sA8vncZRU34Akym6/IG0hVXksv5i69y1OZw1+ntVEqoh9YRuuK/
 IxXKxkUnOAJJ33ktMT6k+M/ubVOWRIm3MWInVly9WdF0dBffdNIVqHA2NFXysuIFYlKN
 fCUCEbOVc7GfQQ4bBsKhlT8s6vKCiCWOZpnv3uNKA1GK/dwpTdqeBGGk6BDEVULk5wBn
 Pndg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvykSaPrGWqE1/vkB/awBqeNszYZc/6WnbX0pY5XjS37BGkbNmVPGaVn1oRLzk4RMYykrpAgzPn+s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSd9RrdaoN9aFGCE0/L6hN4QrVbMCg0dWZtUIkNGjP6emf+NFa
 5EGrdwLRoWsfqjs2a4Zt0GwwD4EfDWhdXWkQPNMCDeHZzzfBCVc6yeJ7Vz1bjLz1MfOpBid0JTd
 NVwEJbypnVSuaJWm3pFAerS7ik9j1u3QaQ0AqdtFfHfsbmg4S8UjQYxyilyy4a3DnErFAGaU=
X-Gm-Gg: AYBFou38s9u3aq7+oT9p+d5sWbYN9Ra5qz9tobCiqCq+heWR9rt9Rwg+n0/A6+jXgaE
 yQe8z5ny75RwogoCHMuLN6zPQ3px76RGgwHybWG5zL0wWy3EaxXe49o/mfIgqKDZIVr2oFNiFEB
 szeu9IEVzGGDHRFo5IP6q4tfLVJSrcRhNYDamUDAmceAAvYulreoEJ7QNl0D1E2qrkLhGapDASV
 EF4jmojoGOq8kuHxDjFPM118KqjUm/FVTkjwt2quM6nkZN8mlnlL+00WN/yHIrFu+VZNRGGb/Vn
 cCXYijVq91phEKMoyWHdBtqM8HSNxHPOkE6EV2sCcxAotvX4HnnGpYHqB2Pr72/UCyZCLcAT0TZ
 4+zsZP3mRGcj7AfqGspL2JbAwntdcFhRYqA9STiVhGiSwjBq7lCfaIEsCvi+kCWSTJmdNnSASzE
 QSuU9glJE8ZHZHp/2iUisZIKCy7msUp+iRo6zYTNi+uyxvVPiwFpTsIxGGEkzJc9WDRPfGABuKq
 1uIkLmX
X-Received: by 2002:a05:620a:1a24:b0:93e:6c02:d181 with SMTP id
 af79cd13be357-940ef914ad7mr1601498485a.14.1793108536698; 
 Tue, 27 Oct 2026 06:42:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:93e:6c02:d181 with SMTP id
 af79cd13be357-940ef914ad7mr1601493385a.14.1793108535897; 
 Tue, 27 Oct 2026 06:42:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net.
 [82.64.236.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm23218174f8f.16.2026.10.27.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:42:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:42:13 +0100
Subject: [PATCH] misc: fastrpc: fix use-after-free of fastrpc_user in
 dma_buf release
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fastrpc-fix-v1-1-4610a10a2901@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADSq4GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bTE4pKigmTdtMwKXaMkyyQDE6OUNFOjJCWgjoKiVKAw2LTo2Np
 aANgI2G9dAAAA
X-Change-ID: 20261027-fastrpc-fix-2b9b042df52b
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0aa39 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qbNRoFHTQ0jijyljazYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: qXPoeSY9sImW17Jh2el3S_zmjdndNSVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXxFQrmKSttzXq
 2wi9cxYESngMyLQduWozm73kjl08C773ZqeoQJZ9DUzGLIBjIjYTcMHUEbVN0s4TMKrSzU5fCRV
 MIsHL4O3+MGlxlqFF+qJxp4r07ftuy3y3yi2ERVGh0oKoN0y2KethyeMrImmcXV0340SLGex7SC
 jTfurdjb2zX98o0e6LoFgyk0GUmMafLatAyGYIHzBGAHvxSLz60rwpHCYvSoZhhTdxyWWPew+f5
 ibsSDjh4WhM41xUGsA+LLlmZGipJyLGBMdBLHiwHqmUwt6yIwrkCnyhKDV6Zorahy25x1fTPzYR
 n+Mvn5QFAvf0z9H66rfaX7tDR5NC7BsgH2T7WMkRgRLvmfyk6VcmI2g1QziEaSnRVr38mFpoA9p
 Pe4ebI1/BQqAiueIO11tCAmpjUji3GuULb7ZKPAIEVmRSIGCmfr2GDoy3zC6ZqK8a2NzEgFkvu8
 7+aSw5ZIWT2FAVKSu7A==
X-Proofpoint-GUID: qXPoeSY9sImW17Jh2el3S_zmjdndNSVY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX8S0MOnVN4g5o
 l5G5pbXUFNNrQG00ayXImmh+8I6RhXhi021Qqnc7mvc26yWDg3y2VKK9Bdcbc6uB0r7N5aAMUa3
 4qGze+f2NuJI/kASz11LyyK+26OiNrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054
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

When a process closes its fastrpc device file descriptor, the release
function drops the fl refcount via fastrpc_user_put(). If that was the
last reference, fastrpc_user_free() runs immediately and frees fl.

However, any dma_buf exported via fastrpc_dmabuf_alloc() stores a raw
buf->fl pointer without holding a reference on fl. If the dma_buf
outlives the device fd (e.g. passed to another process, or simply
released later via delayed_fput), the dma_buf .release callback fires
after fl is already freed.

Then accessing the now invalid buf->fl triggers a kernel oops:

Unable to handle kernel paging request at virtual address 000103f6a9025bf5
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    FSC = 0x04: level 0 translation fault
  [000103f6a9025bf5] address between user and kernel address ranges
  Internal error: Oops: 0000000096000004 [#1] SMP
  CPU: 0 PID: 74 Comm: kworker/0:3
  Workqueue: events delayed_fput
  pc : fastrpc_buf_free+0x34/0x6c [fastrpc]
  lr : fastrpc_release+0x14/0x20 [fastrpc]
  x1 : aa0103f6a9025bf5  <- corrupted buf->fl pointer

Fix this by taking a reference to the fastrpc user via fastrpc_user_get(fl)
before calling dma_buf_export(), and releasing it with fastrpc_user_put(fl)
in fastrpc_release() once the dma_buf is freed. This mirrors the reference
management already used by fastrpc_context_alloc/fastrpc_context_free.

Fixes: 35a82b87135d ("misc: fastrpc: Add dma handle implementation")
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992eedb6f44ff57ded4f0c577e040e885..36722ed66edff307d166bda30db1d4fe9f73da0f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -796,8 +796,10 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 static void fastrpc_release(struct dma_buf *dmabuf)
 {
 	struct fastrpc_buf *buffer = dmabuf->priv;
+	struct fastrpc_user *fl = buffer->fl;
 
 	fastrpc_buf_free(buffer);
+	fastrpc_user_put(fl);
 }
 
 static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
@@ -1802,10 +1804,12 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	exp_info.size = bp.size;
 	exp_info.flags = O_RDWR;
 	exp_info.priv = buf;
+	fastrpc_user_get(fl);
 	buf->dmabuf = dma_buf_export(&exp_info);
 	if (IS_ERR(buf->dmabuf)) {
 		err = PTR_ERR(buf->dmabuf);
 		fastrpc_buf_free(buf);
+		fastrpc_user_put(fl);
 		return err;
 	}
 

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261027-fastrpc-fix-2b9b042df52b

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

