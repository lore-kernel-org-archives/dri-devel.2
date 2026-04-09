Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C61E98FC2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F60A10E721;
	Thu,  9 Apr 2026 06:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/FZNqWo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LPmJrfkO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32C410E729
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:26:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Nbbd1674421
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 06:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cEmJBwZTivF
 /RSC2tmP5X0gUH+iQ6pYh8h5AOb4GCG0=; b=U/FZNqWoz9h74xg/WkfqqUZiAJh
 joY1iu4/n9oeAqFcM9AF3L3fXJNRwHCXF9JHiVMSJRL+40QjDZbnALzUfTzckItr
 Dw6mFVkQVjZiJTOUg87NJkk4zbDMRiGRuLjYzAcR5sCu36VKWBq/MyIMNJl8SZcw
 7MEVJFhcnRe0Hg6vm9MUT8xxZKrDzN7OFhejotnAXzEoRfVdX6vDtfzhWHX6s6xa
 N/t+uYETXR1j4ObDljFBZ4gKCxAV2IEjPFX7ZAKQar9eK7VZnrZ0v6tQrkt0hRBf
 Y5DEkOiicLQB8QwQtVSRQty5IaMk1tHymq+rfuXkDd60xhk9KGYk8ZxPNKw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtbmtqtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 06:26:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da4795b3cso1609455a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775716005; x=1776320805;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEmJBwZTivF/RSC2tmP5X0gUH+iQ6pYh8h5AOb4GCG0=;
 b=LPmJrfkO21JjsEN8GAN3g5UdN1jc6eaVCH4HIbhoR1RqcaW1rNFdoHbDHL4ENGBK9r
 DMLometSs2q8AXbXzO3RJJV1uIbyLCPI8ZsVCIVJZQ1odGk5GY+OsXcEiXmomlXNxrqR
 j0hEQ6vuGvb2yhUodipYHsSppZzDDlmxCv3/A6mXPwFx66HFJ3WfpQB9z2Mzuc8jj7xN
 r8+g3BwQ9mR+1eZsuJ10LZOFPBAnPPJI0e6s0YnV/FeTdWSyps1iHIMzNPeT07SFBIKI
 wu7v2ghV/Z+PpcNQpt36ESAbyH8euj4x3gQl7Ux/5Zud545YJIwBNYeV64RLV7GDAudH
 8CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775716005; x=1776320805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cEmJBwZTivF/RSC2tmP5X0gUH+iQ6pYh8h5AOb4GCG0=;
 b=R2I/Twnp2p78eV5sj2912PccPXdU2oh/O2BgNZjtnhNhVWSSyJL7mcEDpui/EukDAt
 HBc0dpgFHwKFOcbzgCRSJNq6LLrHG/zspXamyj2Yet0PRVCNG8Rjwsgi8Jstwd2T4P2v
 wCvF4dCWpE/8R27J7G8slrj0NtNFaMoAURJAVu5My9a6dvbiqzWoInfL8WdxYEywO3eq
 fkJuZKCmWwNEPct0mEredQS+uGvh/iaqOxWqa4WiJQ0lYMHhZVlX2LatMcc1KfqK5cjv
 qEcrIupoW+cHkV/SBLQqIT7ul7r4x0kyKuO3f8bHi9H3lAskixpMokyDkufA4cMJlFYg
 ySLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBzYRj3ipp2JjdbolCIBOv/PP5+6GxxGWm1x8BP71ZWNA+bCCOblCp+XRxMI4wwuO3lXiKadJYnK4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxUJ3bPehd8WOAjECwXha3x/jAZMkJ4JhAfnSBh8RJdEISQnhf
 zDAdzgIJMzIlptJnUHNDT5FvU8+FecT8uVUTnf9oRxT+QIcoMUfS0r+CeFeHcXAKY4b92SypvB9
 tr9QKsP21E0k7pdOB+mhVsY+glvBLnWxW84QfxcByMUIb0BKw8t4XpWWaCVkTfR77I2q30l3GzD
 x6bNmoyw==
X-Gm-Gg: AeBDieu2Dcv3ViWk9lsV5//MVkH3B3Gg03e8oKOvCKzTQ5QstD/Y+mFPoo0ShGCqc6x
 4RTJPixScD6InKWgzm4BjzIVt7y4HVoEli4XMyybway3x4AVxprryEm3D2pUTCbDfLRa2fFIkTT
 F4ENM0cNOJLbitKZCFxxBQAdIkGVZlasl3YWDQD1yZAfs+g4m/nzF3eCafyPA7PWuc8SG1OZSol
 Zf/jtPkOqzSC0ekF4FHAzaCN59JFx567BQ65NknbGvqfFhBHesbHoGDK9aqJ5kk+986PAEk9gHZ
 aw2MT31CybCCL49moZJR7DkOybjFQMwZtQegxYzguuwf95mVoLZny5qz/+wt/6ucN7GdCvp8LNx
 Sb9q959C/VE2h7FYPw+TVo7yL41UM/Ocn6aZR6tbOPN0ExWTEqwaj/VBoZ/dkED4xWGHIjhfVgf
 MZSksCkzX5wkIu+xXB/A==
X-Received: by 2002:a17:903:3586:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b28194ec0fmr245636615ad.39.1775716004876; 
 Wed, 08 Apr 2026 23:26:44 -0700 (PDT)
X-Received: by 2002:a17:903:3586:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b28194ec0fmr245636355ad.39.1775716004452; 
 Wed, 08 Apr 2026 23:26:44 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd4dsm220786795ad.76.2026.04.08.23.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 23:26:44 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v4 4/4] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
Date: Thu,  9 Apr 2026 14:26:17 +0800
Message-Id: <20260409062617.1182-5-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L_3Ym0M0gCR6-BGc-vqAGSH4fj_mv09O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NSBTYWx0ZWRfX4aS/9TnwBnmJ
 lLWOBhuj8gWafNbu5DuKe4fIfNkpgXk/yOqeSQlOuzlR7X5zzO8aYrZiR3qhcZI9pQXidwUFAIE
 oWAPuP5kqSFNe7Ps1Bk9CvynkmzGmHb9l11opp1LomufUQpJEIc6I0hhHIRXGQcMo0JTc3wWHC9
 kNbaICP7B0wdj6fV/nXgewAqTykYfgeJJKv9AlcvXs53JevECzDiBOiNjjdVaj5zRGdsk3GduuB
 TPw2HNU0pWhfHZbRh4bmut/JK2oSN990zqrJ+n7UYkYQuhFAURzXB61ovWXwNjaogZ6soPDMpgn
 oihmPTF7q1B23Wns+TOsWt+9Qfrhf2A2E8qdVa1fH1Pxf/+d9i4FOkYM3soEFCrQvU1Qz/ZxMZI
 KlQpxNUxv3HmbZTi5EzMU2J96o+URmMxK2rQphCJgHddlfT/zG9TIiPPWBNqN5tQTvEA9ASHgaH
 vxw6PWyp7/L33R1/zvA==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69d746a5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=GmafkBk8WXepDEkBruoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: L_3Ym0M0gCR6-BGc-vqAGSH4fj_mv09O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090055
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Make fastrpc_buf_free() a no-op when passed a NULL pointer, allowing
callers to avoid open-coded NULL checks.

Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a67ae991c0b0..3cce81d0cd8b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -416,6 +416,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
+	if (!buf)
+		return;
+
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
 			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
 	kfree(buf);
@@ -512,8 +515,7 @@ static void fastrpc_context_free(struct kref *ref)
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
-	if (ctx->buf)
-		fastrpc_buf_free(ctx->buf);
+	fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
@@ -1565,8 +1567,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
+	fastrpc_buf_free(fl->init_mem);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
 		list_del(&ctx->node);
-- 
2.43.0

