Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15CFC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F0310E3C0;
	Mon, 17 Aug 2026 04:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALHMvmZ6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIpYxnLI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F4910E3C0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:47:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCVU1855182
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ts9F4LI3Qew7SgAApfg24zoA58LocEvNJeGMCkgto4=; b=ALHMvmZ6t/9PwqYJ
 3E8YSg6h4Maib+VpEguh/GuwaJ2ct2VBHS5pjl/rFKMMsuha1cwpHUvR/rwod2ax
 jjZa838V/LMZW/UKNBF1isRV7Js3CCzFofqL/OEBQirBdhlpsy+63MWXwjoui9mH
 Dn1uNa4geehPCbbHVVkRFZvvuyaAWtmMr2DnTOdouX3jLIi/1kLf+jwhqhIP2lgy
 Gb+FNOCtmu6jpZO1t0LKG2LBop6d3IBaOxuAlWf50gYi7smMKIYEk4HsgCZ0qtzh
 qxCUQGcdZi9WSwSZZsxon4RsHiKdWWoRLfRksJUEi/vsrJa71VLe+6ObtssiQBlL
 q/mkjw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwn52j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:47:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so3188944b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942076; x=1787546876;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ts9F4LI3Qew7SgAApfg24zoA58LocEvNJeGMCkgto4=;
 b=KIpYxnLIohOP2P0GefpQAW3A5kUSvKl09CqyfXuv9WHVMRnvdObKMSulxGs9mx2bdz
 UwqJ40OTLpHSi6nGap2nWuthUmG/akd/e2X5HKInNZZJlw2D1lOrn7cuF1sXjSNy/mxl
 1IS53vSO7Of7wSmbCHGRcgOKmKf/lPVIsH45svucEXnrv6Xzf50tiyLuGJNKtR50Z2Db
 r3dXrnhiLiPuQNgOJgBlnH6cpJbknzWVzQvaBOvE15w0NIuzX9b4RA57O9r/SEQFoI65
 PaXOKxK6CvJ+mAtSDkEE+qUG3oFHz9EvFAYN00fUNEfx8xjJX/rIvM+/oJ3dTsBQPTt8
 yqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942076; x=1787546876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ts9F4LI3Qew7SgAApfg24zoA58LocEvNJeGMCkgto4=;
 b=IjbXg8TqXdFbVu4GhX1haQZZvqAR4yfqbSR86FZUkEOGpXF77PQO2/LO9ZyCqr0/hN
 r3Y5+/tCBB5XZN6I399VpKrqTINjJLbAUar8gnxlNjj7Urau6nEWrI+Yqy/5bXxrZbfv
 pfIbd9HF3RUpep27p7tDPptOoCaXz5iwCXAx2O7RXdIUGRLM9RjBkXH52JVt7fw2mKsh
 OZT+bXW01DFYorm4rdR95y2eZwESPNskEJVx7kuy8LCjuAtOE+R7gP2Le1bY6KB3h1Fc
 Iv9tvqzB1wqqrCVrTUd4sJspr5HzBar2pqZb8OAt12BH7DBAHUCvJJgqgVYncJqU9f5n
 JDYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNIHPCQeF1+TEPuUmyiL0ereKSY3OB8I2/0oo1NiUFwbayn98YSOET0IAxYmGJQMrFG1HTMVVPcUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8dtX9D5jqfMPYKHmir6SQyTd35lycdItze+bdusgFxyI10nAc
 9eUfz9vyZ7rm7I94Q3S+futvk6gtH5QGAbOQ9UsYGQgKgNfmu3wsVsIAU+3xZDUQgRAkD5VdwF9
 AlHBL4llVPrqGExRByjj7cXUdCobW0El6X1JFenm1LMdSc0mysoHT3OyeOnkwtBC1yDaPMLc=
X-Gm-Gg: AR+sD12q45ctC5yWef4YYjkNfjDHI/yLkc4D+fSnPaDMo7L/XLdd2XAEWYyRyV5EkRF
 2qEkbCB8b7U9wp8mbOA5EUK7ZUClGwxl9tTvr7Rc//cpN9ct75bl83kY4EjYMg/7eydb0hlpZtC
 Hjo25wJHtAm1aviGpQJ/ZfnWQq6suqHMxlwJwec7ERPdd69GzCZpc5CAsr+A1plN4TcqO/OyYpc
 eFNSE8PihAUJsgiv4EkpmrXRmuzyLdjqKkoMDG5QP/yi0UpiJpifk7BtOcGcCxoTe5ntd0QTrgy
 kJZahxFrQUk6PQyYxijSGD/RDxNc9fkybT0BFBc/C/xKaYesCYGLjZ6A/OSb3W3IomQUqJSsIs7
 k+2F0eFtW+/9vxOuNZf7hs9oSH+uWVZf/
X-Received: by 2002:a05:6a00:8086:b0:848:7731:d95a with SMTP id
 d2e1a72fcca58-84fde47a4c8mr24275355b3a.37.1786942075808; 
 Sun, 16 Aug 2026 21:47:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:8086:b0:848:7731:d95a with SMTP id
 d2e1a72fcca58-84fde47a4c8mr24275302b3a.37.1786942075362; 
 Sun, 16 Aug 2026 21:47:55 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:47:54 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:36 +0530
Subject: [PATCH v2 01/15] MAINTAINERS: Add entry for Qualcomm DSP
 Accelerator (QDA) driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-1-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=1175;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=1OHxMv2wBW5/+XF2J6E2XUpLe6qHFrIRQAha7890YB0=;
 b=HyeeU74f3CsKVkGnmRyBHt0hVqLHg6pHSrSomMARbCMj8ww1CDL9Y/CwmryCZtNpCOfURrc7T
 hBv2bX9LYjIAjAhLgISSrFUBT4+VfnI3DUZj4hbuPuy/jsdJu5xv35r
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: E7suUAwctsR9vk_JSrMcmtthZ6jCK4FA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX954bJx6UBNjo
 NxrnvnD39I61XwQS0KH4YkD2MskIHL/L7fIl0gKWAUyOlYAM1LOL11E1UuKDZAB2bLJfHe9aq5y
 oPwPTeWY+wU+cYvRPGEN1RcU7/anlJDbqBznGb3LdOFNB0tv+8Ql9KF2BacXtvhJqUq6E2+p2eo
 F3QCnxE2R8CtwX1xuN33Qjo5JC+fwKVj41R/hYNpIcGNCe7LpVKIbV7RUHe/4TDGoE3HDqaluuM
 9LY+MGsgCOIXCNQjoHLyjCHy/qvlsyml8TBFk4ETkS6xoCMrhcPI0HFBiGlpkWdBUygmjvuHty0
 VD39RdLodKIpfY7njovYUotBiSE0j2u2FUc2KrLm1hEioQQtiolKfo1B1NRP5t3P2BcShr5Wvx0
 0IvWHZyJnb3Yh1rX1xwR/lzgxdTCDyISf7QYHp971WZeCncViLNfGxyojlzIRszK3b9it1xYlQg
 puRFWqocinrj2J6A3zA==
X-Proofpoint-GUID: E7suUAwctsR9vk_JSrMcmtthZ6jCK4FA
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a82927c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-nEfFi9kuEQa9ToJtW0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX1AiDp3uU/xYo
 R7peF00U0wgXM/BVmopmXRw/JHnQDQPmPQB03sUQJqv+leau6TuNE+yU42+G1/6tZkT9tfS0aUR
 2S7KXXovOfb9LIhvTV1HjAddcIIKdf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170033
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

Add a MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA) driver,
covering the driver source under drivers/accel/qda, documentation under
Documentation/accel/qda, and the UAPI header
include/uapi/drm/qda_accel.h. The linux-arm-msm and dri-devel mailing
lists are listed as the relevant review lists.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 912837dd4640..75fa90c137c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22388,6 +22388,17 @@ S:	Supported
 F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 F:	drivers/crypto/qce/
 
+QUALCOMM DSP ACCELERATOR (QDA) DRIVER
+M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/accel/qda/
+F:	drivers/accel/qda/
+F:	include/linux/qda_compute_bus.h
+F:	include/uapi/drm/qda_accel.h
+
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org

-- 
2.34.1

