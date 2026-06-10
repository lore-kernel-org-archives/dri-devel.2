Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7500CD98D9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3910EE71;
	Thu, 11 Jun 2026 10:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="JG5F+hcS";
	dkim-atps=neutral
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCC710EB6D;
 Wed, 10 Jun 2026 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
 s=mail; t=1781117098;
 bh=W6FxcmvZc7O9uWrU0PcbRqzEAh2J4RoXnjElLIAkQk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JG5F+hcSVf1vQj8f77tOvQd4+XyAcTNN/DZFCIcnbElk9ntyMKC2AQuBIQw+qVguo
 lh1RkohVtLFglEBWusBcb06MA3Yny7z8fhZbDWnLCyX5dpmF0buY8dhqNroUB7XwE7
 nZZyXMYwmnjbe5oBgfjiSnelrK1Nbzqakx/2RmP/LixtS4HOznceU07akjTY150Whg
 uP7jk1dKszWteF/oyDQwbMEmO8UsLAuHP56rTOpPi8kRvS7wisx02mXJJJtbspc8nh
 SyEZoW9BxUgByXXP4TMjxYpaE4oC9r2rXyUu6TnS1F0bS20RCYO+ddC3+e8M05ZMAL
 6tFt83zZXC65Q==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
 by mail.sms-medipool.de (Postfix) with ESMTPS id E543C11F58;
 Wed, 10 Jun 2026 20:44:57 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
 by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
 Wed, 10 Jun 2026 20:44:57 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH] drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs
Date: Wed, 10 Jun 2026 20:44:56 +0200
Message-ID: <20260610184456.8424-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610180312.374901F00893@smtp.kernel.org>
References: <20260610180312.374901F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

On Wed, 10 Jun 2026, sashiko-bot@kernel.org wrote:
> If detailed capability info is not available, downstream_ports contains 1-byte
> descriptors per port. Doesn't this mean downstream_ports[2] would represent
> the third downstream port rather than byte 2 of Port 0?

The DPCD addressing concern is valid.
Without DP_DETAILED_CAP_INFO_AVAILABLE the registers at DPCD 0x80 hold
one byte per port, so downstream_ports[2] is the descriptor of port 2
and not byte 2 of the port 0 descriptor.
Bit 5 can even be legitimately set in that format, where it is part of
the non-EDID format bits (DP_DS_NON_EDID_720x480i_50).
So intel_dp_check_frl_training() evaluating DP_PCON_SOURCE_CTL_MODE on
that byte is indeed unguarded.

The practical exposure is small, though.
The same condition also requires intel_dp_is_hdmi_2_1_sink(), so the
EDID of the attached sink must additionally advertise HDMI FRL rates
in the HF-VSDB.
drm_dp_read_downstream_info() zeroes descriptor bytes beyond the
advertised port count, so hitting the bogus bit takes a branch device
that exposes three or more downstream ports without detailed
capability info while driving an HDMI 2.1 sink, which should be a
rare combination.

> Should intel_dp_check_frl_training() be updated with similar checks to ensure
> we only evaluate DP_PCON_SOURCE_CTL_MODE when appropriate?

This patch also narrows the remaining window.
With it, dfp.pcon_max_frl_bw is only non-zero for a branch device with
detailed capability info and an HDMI downstream port, so in the
scenario above intel_dp_pcon_start_frl_training() now fails the
max_frl_bw check before any FRL DPCD access happens.

What remains is the TMDS fallback write to DP_PCON_HDMI_LINK_CONFIG_1
in the error path of intel_dp_check_frl_training().
Gating the function on intel_dp->dfp.pcon_max_frl_bw, which after this
patch encodes exactly the checks added here, would close that.
That is an i915 change and out of scope for this helper patch.
If the maintainers think it is worth closing, I am happy to send a
separate follow-up patch for that.

Thanks,

Alexander

