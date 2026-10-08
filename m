Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D781BCA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD8810FCC6;
	Thu,  8 Oct 2026 07:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="WZs6YJtT";
	dkim-atps=neutral
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com
 [203.205.221.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDA810E778
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1791444705; bh=d0eH5iO0On4vXoUUnrxJ7otqop8z0svHJFJ1BPfCn98=;
 h=From:To:Cc:Subject:Date;
 b=WZs6YJtTDT5dJP1e1REyJelKbxgDmRLGlrYMOYy+GEW5JyvoiR8G1+kuyNCtUoW1W
 dxbEQZzxUP7KioVraYRKfGkewKbsZEhG34lgfg89+X/JwasjnfCG5OQLxWJFjCA14h
 JDgnwniPtIVkh+B/HJ36UbL1EFJDHeem/az3Dgsk=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 7EA3786F; Thu, 08 Oct 2026 15:31:42 +0800
X-QQ-mid: xmsmtpt1791444702t4uny6kii
Message-ID: <tencent_B4299278015532212E7D2E624FA23C09C90A@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5TIpJ32xOmc8ljJioECF8WSFHTXltBzar1DonW34D2y8zRJp89yw
 lk75+QW4p5/8GemVW4aFPSAfnR581XMSPYsXGkbUqh4/XH45xQYyHKJRf2Q90GsGXym72w4393PC
 74aR5oa4m46zzYd5U6Lov69V+jBgIug9S7eIFATvkdvtxupb8gf8HjZtvZzmyl8L8Y18AgmEnfik
 xEKM7nkft3s8MtWPgt8wA8+7trRc8ZGC60xtKvg5VTQZfcsUk8Dsk6W76SgKgq4kmOr7ze+r4HMW
 LBvYdaCkhDzHakrd7MWhH8LobYf4T11DP7eUBRuTNHirOpEuzFDggJWCC7rfgToVuEcwbwHCLcAV
 +brFvEzJoSegqCToOegws687uHAQ3YKF3hK7Ijm1Etv+l+WDFKrJORbM0F/g4Is9GMIAbXmmpIZd
 ZMNG1kOlGwL2R6i/gf2aTh+aiDV/sNjnq9JcqBRlltYlnzeCSilol3oE6gJB+vF5tCyoUMn8sOQs
 Xqdj/wvjYcgCmNxqvuAAVOg1FKA3q5NKKWMG/sSGekZa5JofCJZ0N3/seqilL/pPWteM+XT9frX7
 O0QyK0MgoM9cYC1B9sgt2JJk7uX59tiKOv9p9042AixbQeGXr6sTyWYUZHotxQpDG1Fki/1GyjX9
 ISs8WCaXBGSS1LYmdeogm9J+MQT6KySeVvqfnRB3PR1+peH3MOm0exwcNUXXhDQPNL6+FH4ZmhEv
 gjzaI4A1Y8SRHYAG9eatY7t3xAQuqr5+Uot1p91UJEJtSrhg292y1TWqHbVLmtWIHKIGrK8US112
 E28idPx6OoVCnh1qkVlEO23rxJlvCLLJgPu8uUuY8j6OMiRaSmkTuipXyTzjkooBTXEKsblqlBES
 xevj5IduNnExAITuilUv1NkFasKyQuD/8Ag08JGEeRx69ccJNqtYie9dkls1U+im/m+6BEacD6vd
 gUmU31gLzGvtx9g2EIyKfdjxXve0MtPYIEqIwkgAxyZ2WtzKhsFtp7B8AMvopTX2e2oSNEOk2Dlg
 gbruP+mVx0TwWx/226
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: 2564278112@qq.com
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Alex Hung <alex.hung@amd.com>, Lu Yao <yaolu@kylinos.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/amd/display: Increase the HDMI HPD disconnect filter time
Date: Thu,  8 Oct 2026 15:31:40 +0800
X-OQ-MSGID: <20261008073140.570133-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Wang Jiang <jiangwang@kylinos.cn>

The HPD filter programmed for the DVI/HDMI link types uses 100ms for a
disconnect, which is shorter than the HPD low period that some sinks
generate while they reconfigure, for example when the video mode changes
or when the audio infoframe is updated. Such a sink is then reported as
unplugged and plugged back in, so the connector is torn down and
re-probed for nothing.

Raise the disconnect filter to 800ms for the DVI/HDMI link types,
including HDMI FRL. The delay is written to DC_HPD_TOGGLE_FILT_CNTL in
10ms units inside an 8-bit field, so 800ms is encoded as 80, and the
filter runs in hardware, so there is no CPU cost. The connect filter is
left at 500ms. A genuine unplug keeps HPD low, so the only cost is that
the event is reported up to 800ms later.

The DP branch above already tunes its filter values empirically to hide
a bouncing HPD, and link_factory.c notes that a badly programmed GPIO
makes HPD not "rise or drain fast enough, leading to bounces".

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index cfb5ef0523a7..2b38ddaaaa4b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -82,8 +82,12 @@ bool program_hpd_filter(const struct dc_link *link)
 	case SIGNAL_TYPE_HDMI_TYPE_A:
 	case SIGNAL_TYPE_HDMI_FRL:
 		/* Program hpd filter */
+		/* Some HDMI/DVI sinks drive HPD low for a few hundred ms while
+		 * they reconfigure; 100ms is not enough to hide that bounce,
+		 * which is then reported as a fake unplug/plug pair.
+		 */
 		delay_on_connect_in_ms = 500;
-		delay_on_disconnect_in_ms = 100;
+		delay_on_disconnect_in_ms = 800;
 		break;
 	case SIGNAL_TYPE_DISPLAY_PORT:
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-- 
2.25.1

