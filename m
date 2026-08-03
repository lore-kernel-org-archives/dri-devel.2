Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A8C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D5F10E885;
	Tue,  4 Aug 2026 07:15:13 +0000 (UTC)
X-Greylist: delayed 17690 seconds by postgrey-1.36 at gabe;
 Mon, 03 Aug 2026 15:44:02 UTC
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9894510E036;
 Mon,  3 Aug 2026 15:44:02 +0000 (UTC)
Received: from fzu.edu.cn (unknown [10.132.197.193])
 by mtasvr (Coremail) with SMTP id _____7DwbCM1t3BqKYkAAA--.714S3;
 Mon, 03 Aug 2026 23:43:51 +0800 (CST)
Received: from Archlinux (unknown [10.132.197.193])
 by front25 (Coremail) with UTF8SMTPA id GTAi0gAHQzk1t3BqvqJvAA--.8818S2;
 Mon, 03 Aug 2026 23:43:49 +0800 (CST)
From: Jinman Ma <justdreemurr@fzu.edu.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: Jinman Ma <justdreemurr@fzu.edu.cn>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] [PATCH v2] drm/i915/dsi: Fix command mode line time
 calculation
Date: Mon,  3 Aug 2026 23:42:21 +0800
Message-ID: <20260803154221.2102752-1-justdreemurr@fzu.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803104851.267090-1-justdreemurr@fzu.edu.cn>
References: <20260803104851.267090-1-justdreemurr@fzu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GTAi0gAHQzk1t3BqvqJvAA--.8818S2
X-CM-SenderInfo: iquskiirrsiqxi2xhvlgxou0/1tbiAgEICGpwRIwBmAAEsM
X-CM-DELIVERINFO: =?B?lh7qIlYeYwyZs1/OPERtTLXWCzObpZf1vPAd2grVCeLVvPYVBn/PLrhdkrnZPXykKm
 e1/WCO3aFlFb14bHIyBd2lo1v/GYKzntgmsHnuNz0qYUz/I8pUmuW1+6xywH7E4m5JdUDJ
 gS8Q3LFc5HmkHvTOkneu9ZY3vlXtX5EQd4HEA1/G
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1rGrWxAr4UKF1fuw1ktFc_yoWrWFWfpF
 WfWrykJF4kJFy0y34xJa129FyrWa95tay7Ary5X3yak3Z8Gan8Jrs5KF47GF98WFn3Ar1v
 vrnrta9I93WFkrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ36c02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE-sDv73VFW2AGmfu7
 bjvjm3AaLaJ3UjIYCTnIWjp_UUUYv7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4
 v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
 rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
 14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
 I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
 jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5V
 A0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI42IY6xIIjxv20xvE
 14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
 JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:15:10 +0000
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

Thank you for the review. I verified both reported issues and addressed
them in v2.

For dual-link DSI configurations, intel_dsi->pclk and afe_clk() describe
the per-link bandwidth, while the previous calculation used the full
horizontal total. This made the calculated line time twice the actual
per-link line time and provided only about half of the required 400 us
vertical blanking interval.

v2 now calculates the line time using a per-link horizontal total by
dividing htotal by two for dual-link configurations.

The second DIV_ROUND_UP_ULL() call also used line_time_ns, a u64 value,
as its divisor. This does not match the macro's u32 divisor contract.
v2 replaces it with DIV64_U64_ROUND_UP(), which supports a 64-bit
numerator and divisor.

The changes were tested on a Huawei MateBook E with a Tiger Lake GPU and
a 2560x1600 RGB888 dual-link front-back command-mode DSI panel.

Before v2, the driver programmed a vtotal below vsync_end and reported:

i915 0000:00:02.0: [drm] *ERROR* Invalid vsync_end value
i915 0000:00:02.0: [drm] *ERROR*
[CRTC:171:pipe A] mismatch in hw.pipe_mode.crtc_vtotal
(expected 1710, found 1622)

With v2, the per-link line time is approximately 8.18 us. The driver
requests 49 blanking lines, providing approximately 400.9 us of vertical
blanking and programming vtotal to 1649.

After a clean build and boot:

  - vtotal is programmed to 1649
  - Invalid vsync_end is no longer reported
  - no divide error or kernel Oops occurs
  - no FIFO underrun, GPU hang, or atomic update failure is reported
  - the DSI connector and display pipe initialize successfully

The existing modeset verification differences between the mode timings
and command-mode transcoder timings remain unchanged and are outside the
scope of this patch.


Signed-off-by: Jinman Ma <justdreemurr@fzu.edu.cn>
---

Changes in v2:
  - Use the per-link htotal when calculating dual-link DSI line time.
  - Use DIV64_U64_ROUND_UP() when dividing by the u64 line_time_ns.
  - Preserve the existing bpp selection for compressed and uncompressed
      configurations.

Testing notes:

The corrected dual-link calculation removes the Invalid vsync_end error
and provides the required 400 us vertical blanking interval. A slight
intermittent display jitter is still visible, so the dual-link line-time
error was not the sole cause of the previously reported jitter.

TTY switching and suspend/resume can also leave the internal panel
blank. These appear to involve separate fbcon and DSI command-mode
resume paths and are not addressed by this patch. They will be reported
and investigated separately.

 drivers/gpu/drm/i915/display/icl_dsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ea0cdb782..0f942cc6e 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -917,16 +917,24 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	if (is_vid_mode(intel_dsi)) {
 		vtotal = adjusted_mode->crtc_vtotal;
 	} else {
-		int bpp, line_time_us, byte_clk_period_ns;
+		int bpp;
+		u64 line_time_ns;
+		u16 link_htotal = htotal;
+
+		if (intel_dsi->dual_link)
+			link_htotal /= 2;
 
 		if (crtc_state->dsc.compression_enable)
 			bpp = fxp_q4_to_int(crtc_state->dsc.compressed_bpp_x16);
 		else
 			bpp = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
+		line_time_ns =
+			DIV_ROUND_UP_ULL((u64)link_htotal * bpp * 1000000,
+					afe_clk(encoder, crtc_state) *
+					intel_dsi->lane_count);
 
-		byte_clk_period_ns = 1000000 / afe_clk(encoder, crtc_state);
-		line_time_us = (htotal * (bpp / 8) * byte_clk_period_ns) / (1000 * intel_dsi->lane_count);
-		vtotal = vactive + DIV_ROUND_UP(400, line_time_us);
+		vtotal = vactive +
+			DIV64_U64_ROUND_UP(400000ULL, line_time_ns);
 	}
 	vsync_start = adjusted_mode->crtc_vsync_start;
 	vsync_end = adjusted_mode->crtc_vsync_end;
-- 
2.55.0

