Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA8CC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3B410F410;
	Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="fI7c+mPx";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC35510E325
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:36:37 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-936dfd009d1so188890185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1788294997;
 x=1788899797; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EyAYuLXXzVtKL+Vc2WL6tPFoU1yZSAFLWXRw34l4tAk=;
 b=fI7c+mPxnGqiJ0k3b/RT7p2k3C3aQkYdY6AlBR0CbV/sJgspfrVe3wYIJDMVopSfWL
 fsnjNxGc5sblv0DoWhidTdPik5YH+h3xuCiqyEkd4iRwrH8zYA0sR/3//TlRccfM+MS0
 7VBBtlco4UpUGL+zWHH3ZkTZoq8yr+gCXL6Gd0axNxN8lptlJVqnioTjVhDsA+JcXFYN
 cxFziVmH82UTTNEejpwJ3zuM1JMh8xng8EqgO/YWkQCz7JO7jjrG3kuJ+1tsICQndMkR
 Y1JCWserUsIfVzafDA+GomGF9p4LyZLUeJGYRhDRfGFaes/4n9/ZGk64DFAAMNz/axOw
 SvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294997; x=1788899797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyAYuLXXzVtKL+Vc2WL6tPFoU1yZSAFLWXRw34l4tAk=;
 b=YvAMGKHzo6yL+BvzFcWRpjrH/1x/6NXiF8g6mbDt7DULyccWXLa3Pa6RgWbQA4VCMc
 QUHm5yj2OoBbTLG3p0wwtwdbDsT4GhTeGl5mXyorCqBNqfFuqWs37bfOkdW7hsrDfjSc
 v1Y10HLpmy3vU0hd7nkZBIy+8VrmlhcsBq+2szgV0QkKQvOqcR2+4ULdb1M/GzQyrYDQ
 igg0Bblaw+JYWCuheT09+uf+VjYPI1bHtw1EnJq/TfsmJ5Mdit2W3qkk4wakRbpsc+x8
 f1Wu2GROh476P+TI7IR46abx1EmuM1oeGAi3SZLTSKidyKTkoNNX+7GXL3Y9l5ucVFSH
 /fkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEBuuyOBPeg/CK2qlpcyCUOQ8waWWyjBvrBGT5s7cUFjecmBQ0eedbgq/YIodVEfUGM2kFHvOZtRM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8V2dIyyuEK3JGoQ3Ay0n8a9OTg1+w+sX/RGMNgHLTJ6Y+v3NN
 BNj1wSmFt8Dx6gUXdMVb6FsQ3w6xSxULzaQBgn83FHRjAZ45QSZ2K5lshBIotbAvqdg=
X-Gm-Gg: AR+sD13NVxvjCS5hnGxbM3JTNb6rDyNb/iBYa9YhjZVKAgSSdqPe6gzLiX/LjigufYm
 HiZC9VayB38W8vXJ2ppBZjGcaTEOJ3fxa8bLhkTOj1SQb3eLXNF523xWOLp1NNoHi9cwFVAtbaI
 xW7diR4/xkU+qoR+6I0nrUHvIuz1otenvi4LKmQF0p/xZJUROvS9HHNpiFwpqgrbO2MBnPi4cp6
 G9YsHrwQAvSDt3evU4uvRPH3GCPfHDatZPbh3NSuIKTt7gV83oY+sTlPZdbQvu7M+un1T/+2VRH
 NML4X0jZz2+QMoZlntco8WxIWKcfQpY0ZzCYN1u/rHdHz37zFqpDEJLuOSzFWi+hFOUo45soj8R
 S8viTde+m4lcm6ytA/KHbrONOsyUSG2ola3nCRLHkM4xEG7AhofBDrnCkWXyjjLtiAbFlSWaFh7
 toJE1GB2uC/Bv/iLptrrkW+zIwocp+QdFF7JAxD+0XniowMVlhNCujR2OaRuxnTgwIQfeI0iaqc
 uw0XUT3YQmHgvgpCexhbtoEuZLe+gIuyZNH/8duLu1TlqAWDnyMIEwy0mU9LREUktbKyhP0KIbt
 jFKNZS7NIiz/MyoDiiqh/m/GjktrO5cKwbuXsFF83kxpIPoR2vYWSymTUw==
X-Received: by 2002:a05:620a:a411:10b0:936:ce17:7792 with SMTP id
 af79cd13be357-9394bbfcd67mr879893085a.8.1788294996544; 
 Tue, 01 Sep 2026 13:36:36 -0700 (PDT)
Received: from jake-laptop ([153.67.1.208]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f35a3f3sm27146285a.27.2026.09.01.13.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:36:36 -0700 (PDT)
From: Jake Steinman <j@metarealtyinc.ca>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: jouni.hogander@intel.com, mika.kahola@intel.com,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/psr: clear the Panel Replay error status register
Date: Tue,  1 Sep 2026 16:36:33 -0400
Message-ID: <20260901203633.92628-1-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

psr_get_status_and_error_status() selects the DPCD offset to read the error
status from based on whether Panel Replay is enabled:

	offset = intel_dp->psr.panel_replay_enabled ?
		 DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS;

but intel_psr_short_pulse() acknowledges it unconditionally to the PSR
register:

	drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_ERROR_STATUS, error_status);

Under Panel Replay the error is therefore read from DP_PANEL_REPLAY_ERROR_STATUS
(0x2020) and the acknowledgement written to DP_PSR_ERROR_STATUS (0x2006).
DP_PANEL_REPLAY_ERROR_STATUS is never written anywhere in the tree; it appears
only in the read above and in its own #define.

The sink's Panel Replay error latch can consequently never be cleared. Once it
latches, every subsequent short pulse re-reads the same errors, so PSR is
disabled with sink_not_reliable set permanently, and until a short pulse
arrives the driver keeps Panel Replay enabled while the sink is reporting
errors it cannot see.

Observed on a Dell XPS 16 DA16260 (Panther Lake, Arc B390, display version
30.00) with the eDP Panel Replay quirk from commit cb8d155b0806 removed
locally so the feature could be exercised. The sink reports a persistently
latched error:

	Sink PANEL-REPLAY status: 0x2 [active, display from RFB]
	Sink PANEL-REPLAY error status: 0x1:
		PANEL-REPLAY Link CRC error

which survives across reads indefinitely, while dmesg stays silent and Panel
Replay Selective Update remains enabled.

Use the same conditional offset when clearing.

Signed-off-by: Jake Steinman <j@metarealtyinc.ca>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3885,7 +3885,10 @@ void intel_psr_short_pulse(struct intel_dp *intel_dp)
 			"PSR_ERROR_STATUS unhandled errors %x\n",
 			error_status & ~errors);
 	/* clear status register */
-	drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_ERROR_STATUS, error_status);
+	drm_dp_dpcd_writeb(&intel_dp->aux,
+			   psr->panel_replay_enabled ?
+			   DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS,
+			   error_status);
 
 	if (!psr->panel_replay_enabled) {
 		psr_alpm_check(intel_dp);
