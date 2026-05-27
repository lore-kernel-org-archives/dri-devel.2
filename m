Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471C010E23E;
	Wed, 27 May 2026 09:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+bo5xbI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IOHavW3p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D66F10E23E
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mXA91167814
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1k37Lr5RJOy
 L0KwHRKq9W1TZ1KX8xpCbT9JxNvgGj4M=; b=c+bo5xbI3BNjUBX3bGZg4N+dWiy
 JykEeI1dy+CisQHHMLH/h59AuAz5zA8vm2O8zBZmhb9c4AKScab/+xcDUIoywljo
 On7wSCmpH3cK2RpCm4Qey0l4hFmTXPdb3MnQCJIsNoj/gXjL18dz2n7s8aecsCEU
 oCwHhbVgoiEcuj/KsyNxLR5o20bNTW9K6+65np8zx8MVEjdaA4jD8ykzP+XyerMa
 oJuVh7rnOOIQ63N2s0y0DqwvZqeEpcXLi3k8bFB1Q94t6JMZmpMbI98+pBJLb6Q3
 +EuPqVkwbRv0PH+HoIRKfxkZbQ+eRY73cKYrJpyndd11gMxw4tCywidu+fA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edfqk33ra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516879bf1a7so288690371cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779875299; x=1780480099;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1k37Lr5RJOyL0KwHRKq9W1TZ1KX8xpCbT9JxNvgGj4M=;
 b=IOHavW3pUU3rAqTcUDF3/rSQamr5dxvx5KfQNCD3J7PPORvfuYa5RKVo/8IESW5IUI
 aXJW1lWWqRnLoOL/E26B4uyFvlXcqdOuAIIhUV3AXSxw+cb+Zwvcy4rIwX7XfF5bQ4yo
 Hymfr9/oQZvH+4o1JjNYSwaSOU6tllKmNoet+oa1b0qou5zqwfi+KrFGLl1GE2lTv7TN
 r9gGeK86OWfmUzxXqVVtymcz9syUmHJZRnubs/UYUxSKhXbTOyClU2xmLHNF2f0UNk8U
 4TsD1Y4fAxPf3wCOTrjJQkusX+FYQCoDyTtDqTVa/yHotyVibDWAWH7qoeyo6FvTR5EQ
 +B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875299; x=1780480099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1k37Lr5RJOyL0KwHRKq9W1TZ1KX8xpCbT9JxNvgGj4M=;
 b=p49d+UAyfcMwWOh5oQYjf2aNmsmOnX0vuaMWUutmNv1xLAkiXnO/ZtX6QbvwLODaqh
 avaTASkU+GOpK7eCsU0p+XEpGegr1ulWvbD+Vg71VLFGREBIcTGf0joWvxcCDB75kltt
 +PTO746MoxoncnxB3IumbCPlTbsoSHUT6X/2yQ2Jds4X4SHYAUTZsWnP6PPS7gZ5F4Rn
 qZNi++dHVzx3bwM/ec0XQRUxpBtaPBqleCmgWQ6k7P9QhmgLBtAsyA+p/Ng8JJdQX00f
 1V7CZ4e8Y1OBDQiC3T3lxq/fF6RZrY5k9d31qkPqFGqA4qtJkIY7sHP6iVFaQFbsm5ti
 +oiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eE3UuE8Xbc3dJlRsZtkU8Xz1nRChudfJ0lkRxfsB/8uOrvuFeMgthqHlTlu4x066yKGfl9rKj2uI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyN0Zax3QBl1SdPk2UWGpf8ndhYy0yVBZaKj/Xo/U3kA2U4vmuH
 OrUpYDIwS5ngscrIV0UsaBPYi+djy9GAlBBSM4waegfIRGk3s2UAg1xI5A+c0JQ7HGVibM16Smg
 PwM052rY0pdG+7z7kQwzaUW2dNt63WH2mruPVP5+xATZP4qjFUnM6/dgLJkMOPNF/Xji3TJk=
X-Gm-Gg: Acq92OGpD8QrVRqd11kB3bSqT8qfq3ya0xUIU+9yxjzU6jyspTc7Yugm/k5vB26E189
 3YuSd0APBdEmIJNIHnmge9EBoKn/YMWxn5O9I1VoFsYdDAaM1/5XPmKPlpjdZjqrxKupq/dAgmL
 20YWUQC64LzZ2auiExxDSj+p8c0N7UrpPuMB5FkKv+cy6rxkk/+ZsISDO+DqDA3ckdyvNRcx4WJ
 9PfhdZj3XM9mR3gqETLIvHC7fdeCKN/hM2tGrC8B33HG8Hc+pHhP2oqXkkmfVy2T5EnX3BiPH6f
 nDOw1rsDmu+sN03KR88TNGs+L/Gnx1c6mW80cHf+7b1Vj69lI0RPfoaFc63iS5/ilul6gsGEQ2d
 NGWEOJ6eb0UtsrU7LRCohwoV0t7TSAjYxGZZ7M/+ZEWWY6BUwE9Rp5FgMQlrUV1jQrhdXVMgoyx
 bSU+88uXqkLulseXyf2N0Gs5Gww1sxmisHfkDRKg2n3HsvZms=
X-Received: by 2002:a05:622a:8c3:b0:516:e6e6:63cd with SMTP id
 d75a77b69052e-516e6e66935mr173376021cf.2.1779875298931; 
 Wed, 27 May 2026 02:48:18 -0700 (PDT)
X-Received: by 2002:a05:622a:8c3:b0:516:e6e6:63cd with SMTP id
 d75a77b69052e-516e6e66935mr173375871cf.2.1779875298537; 
 Wed, 27 May 2026 02:48:18 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6fb31611sm544001a12.22.2026.05.27.02.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:48:17 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 2/3] drm/sysfb: simpledrm: Use
 __clk_disable_unprepare_counts_only()
Date: Wed, 27 May 2026 11:48:10 +0200
Message-ID: <20260527094811.116977-3-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fqPsol4f c=1 sm=1 tr=0 ts=6a16bde3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=3MuA7b1g13mpG401syMA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WzUxQBKg8SMTC0Iw88M1_22WaUSEmnQ6
X-Proofpoint-GUID: WzUxQBKg8SMTC0Iw88M1_22WaUSEmnQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA5NCBTYWx0ZWRfX5MWwfHjwL1JH
 jhd6Jcqd6+WZgh1gD2CnE0nIfT/QMEjTJ1vJqrmxQGqtiGkr6nt8VaOVw5m73QyZ7+aL0E/oHjz
 f2ngmvKvJbQtyEw0kUJGJEZjcbImLeCLBgp93lOoED/aoG1hWIbqwLzPwJyZr+0S/iIGFjT2OfG
 SQ/6bpbPVmFpzsyDs14wXoq0R7CDBm6Lg1QE8460rv5JdYzoadDC4O91yIBagl9PFm0oYHGrEum
 JFyJZ2MMKGGTa+AHlX8uZb2aervqhbmEFYx0T1bu8ykz3TkbSaVjuqB+EeDjMtx/2NvElVL1Y4S
 rkaQZLsOEnAIwAvYvpCq5ld6Tzf/jyWAG0pMxMbBccpoIT2OSnuMCbyS++ridJeYp3VlCQY8cTG
 jJV6xf08cSQxr9T+bdtOhKCOQcZa7Yws32ysiD9OYea4pVgY3j1uwU2fJ1CCfc4jUSnPutSEnUs
 9qnLOuT+NZBIH4VqK7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270094
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

simpledrm_device_init_clocks() calls clk_prepare_enable() to avoid clocks
used by the framebuffer getting turned off while in use.

simpledrm_device_release_clocks() then must call clk_disable_unprepare()
to balance the enable count. clk_disable_unprepare() actually turns the
clock off, messing with the hardware state before the real display driver
loads, without any knowledge of the proper display power-off sequence.

Sometimes this leaves the hardware in an undefined state e.g. on some
Qualcomm platforms turning off the DP clocks at simpledrm remove() results
in the following error when the msm display driver tries to re-enable them:

[    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
[    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100

Switch to using the new __clk_disable_unprepare_counts_only() function,
which decrements the counts without actually turning off the clocks.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 7a95d2dacd9d..6927a32ed282 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -261,7 +261,7 @@ static void simpledrm_device_release_clocks(void *res)
 
 	for (i = 0; i < sdev->clk_count; ++i) {
 		if (sdev->clks[i]) {
-			clk_disable_unprepare(sdev->clks[i]);
+			__clk_disable_unprepare_counts_only(sdev->clks[i]);
 			clk_put(sdev->clks[i]);
 		}
 	}
@@ -315,7 +315,7 @@ static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
 	while (i) {
 		--i;
 		if (sdev->clks[i]) {
-			clk_disable_unprepare(sdev->clks[i]);
+			__clk_disable_unprepare_counts_only(sdev->clks[i]);
 			clk_put(sdev->clks[i]);
 		}
 	}
-- 
2.54.0

