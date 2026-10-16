Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6B3CCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A20112658;
	Fri, 16 Oct 2026 07:35:48 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20BF10EBAE;
 Fri, 16 Oct 2026 01:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1792115247;
 bh=jAfnrnGiIjbwy6DUMFArHMpW2hsVj4XQG6NZXs5qtZQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=lkszyLHvxMCXYHVzgCBg7RpuEu65Hnao7tHWl9/P0SroDAIDRFwyPLS7Fl404OC4E
 Oh9sw9LbPvxi5XTGZfp44vUX/gW11vVfCwViHBcxTMNT4D+PpT7E440ZsSjmQY+PUU
 frrOWJ2DpRI8yR1QJPs51XjBKm4MnOZ1nPussGMw=
X-QQ-mid: zesmtpgz8t1792115242t70bbf3a9
X-QQ-Originating-IP: VNYSVdkFMAS8wxsNIB3aw0lfIdCRrIScZSFSQfiXSSI=
Received: from exmail.qq.com ( [14.153.252.100])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 16 Oct 2026 09:47:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11542745315812216630
EX-QQ-RecipientCnt: 7
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org, Hanson Wang <hanson.wang@ugreen.com>
Subject: [PATCH i915] drm/i915/bw: Ignore inactive CRTCs in bandwidth
 calculation
Date: Fri, 16 Oct 2026 09:47:04 +0800
Message-Id: <20261016014704.3876294-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nw9C1WBu09hP9NEw3zRZU+e3Asm0RwZeHNT32bYZVkhp+eBrtq1l1Nc4
 HGa1sgwRMsDQMhY5NixtGr7r7sd9I6ly4RvOnSHWY2oIZtgV54rKleHDd6xvrOnQsd7HBmN
 W4Bf+7akKhZkRwY3oGJs2sfXZoyRjps7Um65Lb9OjuOTMg4WPScm7JhsXZCjmNMrAHMYTmj
 lPideGcYhjnmbhwQygLpxMAtzMnpXdPqrSHdUnxa9gceJqIw0x3QDA1/jftV4NlvNMynW5l
 eiDMQVE4+tkk5YlDsAZdkQIxm4otgEcWlVrMN5QmoQ8MmOb9fwUUnTpEfKb4evMjml2EC4l
 vY6IemgsA6B7ZnMm+LqkialFtNy2uKrTcdISlHHGoU0LwJTtsghslwxIwGX/ZLKZ7yDkB3e
 n5kEVckmr+BG5KFNU+1WWXNLpaF3iMI7WM1sqN1qRZH0GoYyfi5iB+QxqtHGbAw1H+Vpftt
 8DbAW5g2/gqA9QlKmsy0AGnAPZdwGBLOa1N5l8t2faNcVlMzOpKAM+/kDRGeCalSw1rY76U
 SWrqstniT/jvwTwk5QCFpR1x+o2H92ryfVQhEHdE9R73Pyzl3TgZi2xpIS//DjQNCilyOD+
 8sHuTrq7JxpTv0XxFE5TAr9Jqye3DNdM8FQoVQ3yipO8PYsVqZ7a5AYCSGkw89IgurDrRix
 MZBa7USw+DySDAmiNvRJKrL7uU34OjkKEJo9it/EyrU+1ApKpSVVojFEkUhBlLZ8fQpTjeA
 GBZTSyV0FSOECbHMSmodGj/TedmFQBtCmMkucaVYXKgNBTwE/Ew2AMuUNwoIQc5ErbiMPCd
 w7WZ+UkemAIoiBhfq+IcAtt2EsPWyp6mSc/j+4fGfRQtQ/II+rtzSMJr//x0DtUuqc7a7eB
 BeMs0AlFhPlt31dgDucky/9vm9POHUd8lMsUCPeYv7ce1+pAcuFiWCUBJnelqpMoGrBaSTl
 zwaFUgl72I2U6txf5679gGmjvSedz+6PfZmRhnjQvDd8rfNQno2nnQ0jTr3sBPKzFo4YrDq
 WXg9j5Jyi6tB14gpN7
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

The per-CRTC bandwidth helpers use cached active_planes and data_rate
values without checking whether the CRTC is active. During hardware
state readout an inactive CRTC may retain stale plane state, causing
intel_bw_state to account phantom bandwidth.

This can leave bandwidth and an active plane accounted after an HDMI
disconnect and make the QGV check reject otherwise valid atomic commits.

Return zero from both helpers for inactive CRTCs so hardware readout
and atomic checks cannot propagate stale bandwidth.

Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
 drivers/gpu/drm/i915/display/intel_bw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index ac6da20d9..62d9ae416 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -838,6 +838,9 @@ void intel_bw_init_hw(struct intel_display *display)
 
 static unsigned int intel_bw_crtc_num_active_planes(const struct intel_crtc_state *crtc_state)
 {
+	if (!crtc_state->hw.active)
+		return 0;
+
 	/*
 	 * We assume cursors are small enough
 	 * to not not cause bandwidth problems.
@@ -852,6 +855,9 @@ static unsigned int intel_bw_crtc_data_rate(const struct intel_crtc_state *crtc_
 	unsigned int data_rate = 0;
 	enum plane_id plane_id;
 
+	if (!crtc_state->hw.active)
+		return 0;
+
 	for_each_plane_id_on_crtc(crtc, plane_id) {
 		/*
 		 * We assume cursors are small enough
-- 
2.34.1

