Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38D606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mdi22M0D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KiU1iKqu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1658C10EBED;
	Mon, 26 Oct 2026 06:25:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CD310EBEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4as2B3303642
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=; b=Mdi22M0D0/nX8L8+
 EgIDzXe9Pn4OtwYwlygs/rQOkwznYAJuyISW+R0zkTb09HRmG2w7+CB+dkJ9x3QR
 wROQ2NmY8nxl7d1yrZMAVqeWJtn+OzG0IczwEdfpNHwmuBl4EE+59e38mNe1lefK
 7G4heGBp4GKNN6l0SWxwhsd8B6tw59IiSHlRmZJwi2ajbD0Akb8X0fn6z97ssX0z
 /TOvU/98EJugFgGmR2ANrhqnvA8CA/ikTJl44fYLf2376Z6U8u+/5Ffdx/aQj1RH
 t6H72W7/4ug8+6iR81IVbR/hg9yJ/+ZD4skdctIaqJqMX9rPHhQssTIQZ59oT6XI
 YIo3KQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsd59y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adcb81f487so4449014a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995925; x=1793600725;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
 b=KiU1iKquYaipX6OSoWau8QRQXzHhI84oMFum8Z8BKkYS/6/8KgRbpyB4qpAkh/lJk2
 5e6cZ3n/e0YfpPfT8W/oBZbg1PkTnTvn7tGpi/Xe6cYluBIOc8rykR+F34ACh7DwYsGS
 i0Aj9HHkhzmehrTSr2AORvn7F+IBrQiSzQee4NCj4O115u/PTgWafSdPXXPR1YGtMcGU
 Dk589gkLX+Yp84HA7wnhcXbG9rBrs9jep74YwDoiMlXdqwcn+o0t7PjCzk4MUpuAozNA
 FicA0f2+shvL+fc3GSKIE06W/k+iW55Qnipw9poVEaE3fpj08HDALb7mBGpSg18Xn26i
 ySCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995925; x=1793600725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
 b=SI0TCSXQgVLOhes8juVPsp7tig0ZVyJW3NYyqFwj95rsWNi0dTqdQWCew9t47Y36sp
 KuRHnHgQ+OuYFSIx3CYh6rmqBdJKtJa6r10l0p54NUsByAkdcnDXT8e+dGmsf6dQr+DY
 0lGPZ/65Kohn+hMHXcM5OslsyCKTxloBIii75E+2XfV4qCFET5eK9RYP+WFr4ClUiCyJ
 6tulkAuxLQ9Ofy7pMjRCGX/UMgOiLeX6fzjYJ6rQaH8e6keJQieHdrrL13YZfpQkWVLq
 NX0vm0dV2sU4M2nE3rXlMpcg3QEr53r7mdNxc/7pF1SMDJQT3ss2x20pv+wnJcOhUxuu
 AabQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuC+cty6SM2+eYQpN8R0OMjuo4mAq8dEXMvbM3n+T+vpWZPxmM9QNQdx90jZQGOmbPDLowXGRoXGY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJL9TqfuHVdCK0BfNvxE8iqvG+OzwHAP7AlQRt3erhKggI6sCqy
 dTcrLrOL52J/Zy0HFHE/pGeUgVPqTnfnhsj/XJREmpM5O8tGHzXCs3FVoKndL6M5u9HvsV8CFii
 nb5UlccLF/Q3xaMWflkKqFs/B2IKQ/PeuWNrr+qiYPSJxL3l9RqFSUlzjM3apGCUMKjVcSz0=
X-Gm-Gg: AYBFou2NXHJop/j/Dhaj2koBr7GxEHVhmrgVHxfVAxbejDTGoKlCkmtrOtT75faoQwG
 AFJbOPBd8PJE22BuLAfBJcXEAEwbuR1Mvy5aRa2mkMPR2tcpqWjOls/WL2uUZKeONC+x6skONuO
 iAk1au6otgX6vbrrsx7sW/1EsXy5APJ3k3Gu7U8NugtVw2jmzw2PLw1FGMRHsUVfG9wAoKoLIm1
 qE0GNSGJl33P9oq81+ZCYLuPnFKsUdLuzUc5A6KZu+yTiA14Vi5Wzd/Nk1PEMEt292LupJau/R2
 6quxWgFxjn6bezGkxk5ImHyW3bmgCEJOTy1Wsc+qP0Yyct7wZjtZH5neY3myfHc5WOETJnTKMkB
 eTS77k7ScV4g38NmLliEuUqi1GALA3CYMEQ==
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id
 98e67ed59e1d1-3adeaf9620emr4744329a91.47.1792995924567; 
 Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id
 98e67ed59e1d1-3adeaf9620emr4744280a91.47.1792995924114; 
 Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:25:23 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:31 +0530
Subject: [PATCH v2 21/23] drm/msm: Support KMS backends without a display IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1124;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DKmn9i1vJXXvP4IBsacfVZJPAx62TejKYArKw6N1S7c=;
 b=vcNZ0ngyibDuHfRXl+gMTdO0b/EpAD7rv0lv4FUaHdf/+mqY8ImRpBvwiZcSIeoQwYeo9vdXJ
 yc8Y5UbPo6uDgvAYRMfqwFRHOii6CxjBVS2R+enurNuUEuwobPHtCor
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: JwVCULsIU3BNwbPOIQU4OsphvJ9F4QfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX7UZQuhlbYMCQ
 RBD1M/9oder2nYLi9GliCurLLv7QWbq87tyDXD1QEUO3W5ZI2Yn28J4Hxexh9Cdvgz/aQ7uGRFe
 s3PHoFgzVH0xjEDhu+YcwUJCCV6MCcaXpz5Ov++76w31PuRV9R8EKmR/5Jsw/O7Aa1gfau7Op9+
 NCNWtUTfbPeXUwJkS9fzvIDNst2kQZm4JrQcAhnyWMS0V/Q0BBnUA4KKqmjCj6EciV879b822Fy
 RhVADyX1K1sFOqLu5PeQ+9w/eJkjKawyBytIiW9OorhK/d9Ht5htxgx3Zc3YY37fIvI/mRjry/H
 eNsFfp/+hTRNs1SMe0KH9UlynGP7IaKRHz6EaDTPp1x/z4P0RqKSrzim2YmyguSjPZgIZxnHDLu
 GSxdFsEubqpvgEXvcUHT/xnYdL9Mw0IWXvFHZvzionpNqi/wZhJ55qp4nXwi+ROsS0yN782yuQj
 BhrOYdr5ncxSiqc4XoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXysNn4V6kbsG2
 PPqdIMAsonAtORPchwq3OHrin1j0VUM+AQy1u2EeVRnVjTERJhRCku7umYggC0DAg66T5nBZcBr
 sv/rinNNfKjFNfboEciQQ3fejZTLpcw=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adef255 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: JwVCULsIU3BNwbPOIQU4OsphvJ9F4QfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025
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

Some MSM KMS backends receive display events through firmware or
another transport and therefore have no host-visible display interrupt.
Rejecting such a backend during common KMS initialization prevents
it from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..1870a7008ead 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -72,7 +72,7 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+		return 0;
 
 	msm_irq_preinstall(dev);
 

-- 
2.43.0

