Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D509C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4449710E933;
	Wed, 16 Sep 2026 13:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZPApaZ0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZW22/wp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5387210E0FA
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:22:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GCYjVt2586480
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=68DVc1Rw7Ic9+mA58NCJ+S
 OpY/N/DIaqlcODSFHBDqQ=; b=mZPApaZ0z4BcdwcaJcTb44icMDBjJOEfzL8rJx
 dFqU30MCM0qFW4eCgiB7/eAz2g0192qJnpfb02SLJF2BbxVEdIVtaw9RYTLI1M1Y
 SC7L+97UUtwITvk+Yx98INU0UDgRfaAiX9oU4sWFNtbTXCjFyuzl8QTG9/koU6Rz
 D1BSbFCwuHrtCK4YKfAS9D25qxweiEp9XTH0dj/3BSbch2cFnpOrC9TC1dlAijGv
 82rKZOs5ZA1A75JCuvM7udcWw5VI/83tqTwVrfxat99wV4cgoSTRvWWg+SMQ8Fkc
 maoyBBVs/dqTIgso4JjUiPF23RG2uRM9L2USBTDNCPsOQVmQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqkv7j6vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:22:47 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c82ad4977dso6197592e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789564967; x=1790169767;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=68DVc1Rw7Ic9+mA58NCJ+SOpY/N/DIaqlcODSFHBDqQ=;
 b=IZW22/wpYHFuK9QN7NHn0+w0g0CLW1yl7QM7GiE9NzFytYxYUvowCwphYuJc2MXZtw
 t3i2Ity8vdI1uSXeF782XKNoaT2tNN5DKSiIJzVonXZtjnAhDgK35pS42WmDLpzGJWTN
 jtB0WV3St5rRYxhu+Jn4pncaTJp7gWeS+yBuq1wx5VWXlMcU7kzK+QE4QnKqA60CCJsx
 sEWGXyeiEndAWdkWEMVJ4baiW8kdCmwOsMJHZSZogLO04p3fv5pC6mebCUW2NPs8KG3x
 HaWMGKo7sYl+CT9NnptUM3H0Eds99SR63rxdHkBzOuMd7ZVW4kIQfOolasvzm6e3in5w
 cOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564967; x=1790169767;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=68DVc1Rw7Ic9+mA58NCJ+SOpY/N/DIaqlcODSFHBDqQ=;
 b=LEgvfJGgwZco+2p2+zubV2jcSiLoIhJE8LM+BZcANFNT+aul3cxi4MoeH6va+CCN4z
 erNmTsFEQAQ5NgsfTwSrGr/Zq0G2ySt/IAzRuDl7tsXZhArrEXnaZVGPr2Hzqau5uzo9
 KyzZwhASUwb1Wz1LklG25Yls2QGO2sUmNRQiwWl9U94Darg09Vck/Yb2eFeVzjfx2mbB
 vaZa/abawKH/E9RNyeH3irsZhyRNc1PdRdnwrATiPSH9UdAk523x4z8HsBbVv5h2AHWA
 xcq2xwq61xmcHovKUXBLAzUUMbl/MABVZqNV+dtITIy2TYI39oxZyP+xwBTpBALM7iJw
 aOzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiMViJMyYqehM03/MGbuybEtMgJp+fMPDfzEFzUamvft0DUVYnGHMxiEbKdhgGSLcOwp2hKgyTriA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++naSpnOGtFoO5G3wEGfXfK0Lz+v/8aFftjhF4UYKDdv9Xw8u/3t
 dHAMo3tElccaln0GHzVtZPPuZWPBLoCUfNB+gEFyQ0qWRP9kiZxli/TGTg+ZJV6LDt/iJrYRqUA
 DtFUDADtnOCWzK93k7KvrAAeEs/LnIq/P+79lFcTicfS5UPgBJZJIoQ4FUxBLh0wEWqDwrkg=
X-Gm-Gg: AYBFou06ymPEzZ171/MHB8n7xC7lZAfT/4sY0VqB0YwMoAxc3WNuytwLw3V88ZncomB
 20+e9G1cqNSpUSAhlA2O/nsFOdSeqWeoPIpA2WDDhDospkKphHK9hDaMEP3OVwsUV84P5nQgLH8
 e45yKEri2+J/RpBik9gmFAK8pyQ5F/L3RUeZCmUnTqrN5H/YR3z5Re4TxtGfpAdzYVoyWpNB5HE
 AIZWsVMQiq7KSJbttv1A8KJ+zjFzLZn/F5lYaquP2ZSGrCb99JgirLkgwm6mw/poyTJ1+IAZt43
 aKusqqPrp2toU/ue5x4Q8h9ZTPTWj6ChEOR6WSHHLuP3c9KFYrkRmhpKQgFXBeILxRKMScdvGsV
 j0YY2Eul5+Pi87I5ho9KvaRJAKwmbVSqLCH3+s9ePId/WdElGhizhvdYh9RlRMPLEjuwYprD8Ho
 3F7FklHNQHzt2Q
X-Received: by 2002:a05:6122:4d09:b0:5bf:9461:91d with SMTP id
 71dfb90a1353d-5c99ae6afa6mr2586478e0c.5.1789564967350; 
 Wed, 16 Sep 2026 06:22:47 -0700 (PDT)
X-Received: by 2002:a05:6122:4d09:b0:5bf:9461:91d with SMTP id
 71dfb90a1353d-5c99ae6afa6mr2586380e0c.5.1789564966816; 
 Wed, 16 Sep 2026 06:22:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57e0bdcsm849631e87.58.2026.09.16.06.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:22:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 16:22:41 +0300
Subject: [PATCH] drm/vblank: serialise drm_crtc_next_vblank_start() with
 vblank_off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-vblank-deadline-lock-v1-1-df377ba7f184@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACCYqmoC/yXMSw6DIBRG4a2YO+5NgIGvrTQdIPzVqwQbsKaJc
 e+ldfgNzjkoIwky9dVBCbtkWWOBvlXkJhtHsPhiMsrUqtM170OwcWEP64NEcFjdwo1pvFPQrUF
 HJX0lPOXz394fl/N7mOG234vO8wt3eFXzeAAAAA==
X-Change-ID: 20260916-vblank-deadline-lock-727dc0e182e9
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5512;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5soaOGZObSNGOcK95ZhMd5l24sDwrTJqxb1rZikxyIE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqqpglQSjO+6xtzyVKICjcTKfd5SgJbHOoriZi3
 25Jw2IDmQWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqqYJQAKCRCLPIo+Aiko
 1c/PCACWx3UFIaXNQ/810IYFWIDwqKiJ72t+9mR+3+0cWUNYptVdWWpCStHF01mZhGS7CnVrRkT
 62oyotOiXYYAKTS0Wsi6ptI8mzwgU2PV8mjECFJ77ULc2xTu6znRlmhD4op9ZSWsaZFNKK9mBX8
 FgtPHA3qZA+t6QmgysZ770Fxz1v5omQQZVi91u8A75vFxtEeD1VAlHQvtUDXw9QcWStkt0fWz2t
 7KdJLw8p2C8AgszW2dmahLVJU0xPpr1wSRopl9r4LHj8S+W2T0IeO+tP+BGqR0XWmzEbxmg39DO
 PgU3lVtTEe5sEdL3TWlOru2nGIbyczeG3TCcem+Ku4AtndLm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 89RYIZO0Uvc2Ysy7JvuV3yM1rPsVOkbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3OCBTYWx0ZWRfX/Gr9vsL65izN
 Xsecfko1WQ7XiAgwNTk8Tp7IRKBxIFEnnewJw25Dd7wAyduhY5x4v14gzr5trbI8bLaUH5l2mtq
 s8idcjaOYvXqZXogaBqEyI2J0e2KHfULYdmJM+VexsL7uWfOaMyJ16P+G13Xyi7MLWw5Xb0r3Nn
 o5fx35ELthw0YyIMt7yb6tFdvaxSZcW1794v7roIEOE5TMrzfNjbXnayA2YSjzQ8lKqtC1zrWDj
 +Zo2jZOai61oE4QxY9uVa3TCtVJeYORA/eInL1PmiDhOCVJB2YrlTwbyNDuHgrMU45u9lsAWzAf
 +ag+zftoE/Qcj8NLx0jJf728HqUmS2nf3ZB1DnQ53j7UC9GCrew0BYLLkhEXyWQWpJK95cOFwtI
 ympVA7PmDmrhY1GVzJQ4+ZUrg1U7Ur3OHapfo2uPXsB7PDg5fEuefJwWLAiiEs3/xZX9JaPgVKl
 fmGTwFiHyqhHRAA7xpg==
X-Authority-Analysis: v=2.4 cv=eKmGH3p1 c=1 sm=1 tr=0 ts=6aaa9828 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=ZQ5kVCjTFVWBDE528uIA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3OCBTYWx0ZWRfX9u5MpxnMDk9n
 MOA7CDy9eJ02WYSCEyhpdf6bt/QLMeRk5ARZiGU2vHvB4SsYNnJ69iJ2z1V8UmflD0HUeCA9TwC
 9TLuMMpSmvDlDNUXGHKua5cuHQ/uTrM=
X-Proofpoint-GUID: 89RYIZO0Uvc2Ysy7JvuV3yM1rPsVOkbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160178
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

drm_crtc_vblank_off() zeroes vblank->hwmode.crtc_clock to arm the sanity
check in drm_crtc_vblank_helper_get_vblank_timestamp_internal(), which
asserts that an atomic driver never asks for a vblank timestamp while the
mode timings are not set up.  The only caller that can ask for one outside
the vblank machinery is the fence deadline code, and it decides from atomic
state rather than from the vblank state:

  msm_dpu ae01000.display-controller: [drm] drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
  WARNING: drivers/gpu/drm/drm_vblank.c:756 at drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x310/0x380
   drm_crtc_vblank_helper_get_vblank_timestamp
   drm_crtc_get_last_vbltimestamp
   drm_crtc_next_vblank_start
   drm_atomic_helper_wait_for_fences
   drm_atomic_helper_commit
   drm_mode_cursor_universal
   drm_mode_cursor_common
   drm_mode_cursor_ioctl

set_fence_deadline() skips CRTCs that need a modeset or are not active, but
both of those describe the commit it is called for.  A cursor update on a
CRTC that a concurrent, already swapped in commit is taking through
drm_crtc_vblank_off() has neither flag set, and that commit runs in parallel
by design: drm_atomic_helper_wait_for_fences() is called before
drm_atomic_helper_swap_state(), i.e. before commit_tail() waits for the
previous commit.  kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
hits this window.

drm_crtc_next_vblank_start() cannot spot it either.  It guards on
framedur_ns and linedur_ns, which drm_crtc_vblank_off() leaves at their old
values, so it walks into the timestamp query anyway.  Nor would testing
crtc_clock there be enough on its own: both it and the query read state the
writer may be changing underneath.

Take vblank_time_lock across the check and the query, and take it over the
store in drm_crtc_vblank_off(), so the two cannot interleave, and reject the
call when the mode timings are gone.  Every other reader of hwmode already
holds this lock, drm_crtc_accurate_vblank_count() already calls into the
same timestamp path under it from process context, and it is the innermost
of the vblank locks, so nothing nests the wrong way round.

This does put the driver's get_scanout_position() callback inside an
interrupts-off section on the atomic commit path.  That is the same cost
drm_crtc_accurate_vblank_count() already pays, and it is bounded by
DRM_TIMESTAMP_MAXRETRIES.

Fixes: d39e48ca80c0 ("drm/atomic-helper: Set fence deadline for vblank")
Reported-by: Rob Clark <robin.clark@oss.qualcomm.com>
Closes: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/243#note_3662857
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Rob spotted this splat in the drm/msm CI on a sc7180 trogdor board, in
kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic.  It is not
msm specific: the fence deadline code queries the vblank timestamp based
on atomic state, which says nothing about whether a concurrent commit has
already taken the CRTC's vblank down.

f2c7ca890182 ("drm/atomic-helper: Don't set deadline for modesets") fixed
the case where the commit doing the query is itself the modeset.  This is
the other half of it.

Reproduced and tested on an SM8350 HDK: the WARN fires on the first run of
the subtest without the patch, and 20 consecutive runs are clean with it,
with CONFIG_PROVE_LOCKING=y.
---
 drivers/gpu/drm/drm_vblank.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..2984ce3b68ed 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1020,28 +1020,36 @@ EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
  */
 int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime)
 {
+	struct drm_device *dev = crtc->dev;
 	struct drm_vblank_crtc *vblank;
 	struct drm_display_mode *mode;
+	unsigned long irqflags;
 	u64 vblank_start;
+	int ret = -EINVAL;
 
-	if (!drm_dev_has_vblank(crtc->dev))
+	if (!drm_dev_has_vblank(dev))
 		return -EINVAL;
 
 	vblank = drm_crtc_vblank_crtc(crtc);
 	mode = &vblank->hwmode;
 
-	if (!vblank->framedur_ns || !vblank->linedur_ns)
-		return -EINVAL;
+	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
+
+	if (!vblank->framedur_ns || !vblank->linedur_ns || !mode->crtc_clock)
+		goto out;
 
 	if (!drm_crtc_get_last_vbltimestamp(crtc, vblanktime, false))
-		return -EINVAL;
+		goto out;
 
 	vblank_start = DIV_ROUND_DOWN_ULL(
 			(u64)vblank->framedur_ns * mode->crtc_vblank_start,
 			mode->crtc_vtotal);
 	*vblanktime  = ktime_add(*vblanktime, ns_to_ktime(vblank_start));
+	ret = 0;
+out:
+	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(drm_crtc_next_vblank_start);
 
@@ -1405,7 +1413,9 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 
 	/* Will be reset by the modeset helpers when re-enabling the crtc by
 	 * calling drm_calc_timestamping_constants(). */
+	spin_lock_irq(&dev->vblank_time_lock);
 	vblank->hwmode.crtc_clock = 0;
+	spin_unlock_irq(&dev->vblank_time_lock);
 
 	/* Wait for any vblank work that's still executing to finish */
 	drm_vblank_flush_worker(vblank);

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-vblank-deadline-lock-727dc0e182e9

Best regards,
--  
With best wishes
Dmitry

