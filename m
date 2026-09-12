Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A5C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 14:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23F910E700;
	Sat, 12 Sep 2026 14:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8l3qoA+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8CMcpVb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391D610E700
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEeBRC3829670
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3o6Eb4jJTSo
 LrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=; b=S8l3qoA+GRBPBBxSSdwuMtvF0cg
 8Wt7j+7nu7b4J44GoppgA5hRKV4FU8vmzmQjRViCjhPhS0P1EmAdtOpprzvxJJxB
 63qZX3Jchpk1Fz2+cIzznEn/+SQ6vQc8zUaLsea+tQus5T0CS28TB/NhA8UONckd
 vF7eWfilYjJ5EQBlvTpqHzqoQvAoUvDt5O4TnWSTWA9BpanSCz1tlLmc1EZiApAC
 Dx7dQgocdBrKZwDi+GUa7zJMe4MD3pE3l7TL8ayZCVEuV9/8TOy5LBBhpMxYFKOR
 RFw8fxu8hJTJU2oIt6Z3cN3xAnzb+MpPHge2uND7ZHTU3Aa+EpDn3vexF2g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dh72k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39d8646b10eso1863606a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789225167; x=1789829967;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3o6Eb4jJTSoLrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=;
 b=e8CMcpVbx1g/qYOk37S4Gxoeng9csYDDnZSSexx1psXvrZ6l779Kk+B+ei/6O5Vf3h
 qE8SgheWFETS5Jyls96vTampcmH8rlUzZMB0DnZr6tn3PHZklltvV5BkECYDcQtS7LA3
 5niOgK0X2YczUOEkJ0T39YDXoyA4yYcsB3P7yYCjOpZHXU7vyEnNrim4SjYA/z6ky2pd
 UzeEaVjLkBaTpJdbgf2Vdc8te6ecgzgLEOHDJ/fbBprnlVAcUE+QGIcuAXWBnI8javsU
 SdNBsCe6HHaysqWbG0FV9huxF4g9ihSFjQFmBNP/nkK12GL9foAOn4TYRMI7o4BTOlRK
 /AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225167; x=1789829967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3o6Eb4jJTSoLrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=;
 b=R4oYyrHSNjU2VzfZ5E/s9pnOcDdijedZ9CmeCafrABnsCeXu2kH1W2m7p5a1rrL4x6
 LKv0uBJDTjio2keGOdYiZ7886FHMsGX75qxTW0nYDtRhaxBNBptTVK58jBk1NpEWPYUJ
 VvsbFKwhpwUuLbpsD5JjlmsMfA7AhliPTc9q2mxN4rorkc4GKvZf2lZBOrow5u8Xmyct
 13kZbO/cIpeimHeO7BuVRqFqLk+m1cdQgnkkZq+PmlSsxk79ZdxRNxJN91R+uBoj1e7a
 ir2KQkItJRepPUqirAMviYnKnJdhXqm/C8XAQPmBfpS6edsprvzrVoAVE7UG78twqCdh
 78pg==
X-Gm-Message-State: AFuF++lndbnWhYNgZoSw8ZWlSwreBcdd6DySwLXvP88OaIdKwg3npahv
 oXAjf/f2bvG1/KBUYTqYBFt4sV3zHzgp3tjjxWLVceGkeratScu2jDC7xSjLf9twFpqKAE4I0s3
 QavbGUfQ+UT8ph0wlg1lsY1f4l33d43U4azK5eBYwkfcJ9WLdaLPryXV9gCkxXRFCWxAxxvHj0m
 uthww=
X-Gm-Gg: AYBFou3YG7fVu9Yun9BSqEOsux9aCgwN5S+n8/TuauCfo188q9C6f61j1p+VdsB5UOp
 C+r4DRU0PrPQeEoNH7ISFUZ+upBnr32HDgo0Y8J+8BX8+fWd5l+daWSwXFLah7z4Wb3zf6cUdQD
 ufneazoFoNo5/fNTwOCgPW8BQtrdGzKBQ0FR3RvMZyqEmaGBdY2FSQn7zYGxmnpfWM4ANmBJ/zp
 2BZ9E7U8sAvdZQ3+WlS/n01AdoZHuwrdGTLLxyOqbiGWH7OaFR5BzhBUcN/bJ/nYeKpvfRbaYIo
 GF3+FS1CgcTLRbSVQSd/TbyvlWaFEEoMAM/pdt00BQMHZK6hUl5Av8iLR53V7FPcDNhKfpap9mV
 /IvUNd+HXSLD3+NDLn0HND2Gv0Cw2KA3pdU7fN940d7FNu2o=
X-Received: by 2002:a17:90b:384c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39d9b99384dmr14378711a91.0.1789225166905; 
 Sat, 12 Sep 2026 07:59:26 -0700 (PDT)
X-Received: by 2002:a17:90b:384c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39d9b99384dmr14378658a91.0.1789225166443; 
 Sat, 12 Sep 2026 07:59:26 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d98a58d23sm12533511a91.2.2026.09.12.07.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 07:59:26 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm/gem: Add modparam to disable shrinker blocking
Date: Sat, 12 Sep 2026 07:59:22 -0700
Message-ID: <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
References: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xunrkXDapP6Z_sqII1mppzBpagDq6i6p
X-Proofpoint-ORIG-GUID: xunrkXDapP6Z_sqII1mppzBpagDq6i6p
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa568cf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RQ8Jhd0wILkaI2gFI60A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDIxNyBTYWx0ZWRfX2F+Pyfw8G0y/
 Odjxtpd8E8oZTojMvlRfUzkRaDHSpKMx0W1fDgtk6gdZrWtVbzOkFN7fIQYdiPLzI051PB6We/Q
 91DcMkjbMDPr5tEEedTmrOoBh5t8dWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDIxNyBTYWx0ZWRfX0IsL4VYG3fJr
 obUYyh5r1A4+PcOXzHbmuR8OVidsuRx+wWkmX9Kdu1RTfWcKvRxq1mzQwIHW9uTH8LwkHXjrTZQ
 lkrScP6GjegHXIMA33/9lZx06L3bKWX6U0L7tD3TaUUJe8ZZJYl2MyzCD7+9K9CcaQ3vfVzy+WP
 2/fs3O0+A/zCTsmNNGfmPnkAAxJpO3kjg7C2aC2DQnIeV5RG05IJ5m1edWQ1ITNet9hGXnrtq5t
 qUYS7XvWP94qo1GVt7Gl9y8GXzDKafLdjUkZXa/lSaC3CYqRaPjfU/wsAjSC1cpLPMepa7CXxxw
 GEGQsMDNLKQxxhfJ5t0ieVl3UoAssnjk7gNlDYorVIlnxVLfZPe6KBKz38fHHdTaSt6CZS50Sqr
 ADWit5zkoHCzcv5vBdujTYPsp+uM63hMgX3SgbpSppGbxPwjkn1cdtJhlENu1CsA+b8KYl8qvJI
 WAxGgbaufXpLyyIZT2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120217
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

Normally if we are under enough memory pressure, the shrinker will
eventually start waiting for BOs to become idle.  In some very latency
sensitive use-cases this is undesirable.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 3514d5c84989..83ee032cb21d 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -19,6 +19,10 @@ static bool enable_eviction = true;
 MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
 module_param(enable_eviction, bool, 0600);
 
+static bool eviction_can_block = true;
+MODULE_PARM_DESC(eviction_can_block, "Enable blocking for GEM buffer to become idle for eviction");
+module_param(eviction_can_block, bool, 0600);
+
 static bool can_swap(void)
 {
 	return enable_eviction && get_nr_swap_pages() > 0;
@@ -26,6 +30,8 @@ static bool can_swap(void)
 
 static bool can_block(struct shrink_control *sc)
 {
+	if (!eviction_can_block)
+		return false;
 	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
 	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
 }
-- 
2.55.0

