Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4F606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kcore.it header.i=@kcore.it header.a=rsa-sha256 header.s=spark header.b=RRQpsBLq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB8D10FC19;
	Wed, 21 Oct 2026 08:51:52 +0000 (UTC)
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B949A10E7F9;
 Tue, 20 Oct 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
 s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date;
 bh=shIwbpRYBRVZ5arD1o5RN0HiHTcxgmGfKoAfYRtBsek=; b=RRQpsBLqehNBGjJmb+7qq/OvHm
 jw+06eGSDna85v9XK0tY00sbdWuHCq9LyHTltSSB4j6Usc1pXOaltLL0Mi4raRa8gRPIZlY6xlEuW
 VlqTMCPs8JxEkEQpfGN2nXrY6OESkCN4iA0qIAIMfAoZ9Xa4h5J8oIiUZcrstdXPT07Y=;
Received: from mnencia by spark.kcore.it with local (Exim 4.100.1)
 (envelope-from <mnencia@kcore.it>) id 1xJBnL-00000000apB-1qvn;
 Tue, 20 Oct 2026 17:30:31 +0200
Date: Tue, 20 Oct 2026 17:30:31 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, xiaolu.xie@intel.com
Subject: Re: [PATCH v3] drm/i915/dp: clear and restore MSTM_CTRL around MST
 DPMS off/on
Message-ID: <ateJFyHPSYMYdj7A@spark.kcore.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020110418.1272170-1-xiaolu.xie@intel.com>
References: <20261020021714.62573-1-xiaolu.xie@intel.com>
 <20261020110418.1272170-1-xiaolu.xie@intel.com>
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Marco Nenciarini <mnencia@kcore.it>

Tested v3 on a Dell Pro Max 16 (Arrow Lake-P) with a Dell WD19DC dock
(Synaptics VMM5331 MST hub), one monitor on DP and one on HDMI behind
it, i915 driving the dock over TBT-alt, drm.debug=0x10e. Kernel is
Debian 7.2.9 with v3 applied on top.

The only change needed for 7.2.9 was the context of the last hunk in
intel_dp_mst.c, which still uses drm_dp_dpcd_readb(). The new helpers
use drm_dp_dpcd_read_byte(), which exists in 7.2.9, so verify_ctrl()
needed no change.

Results for the points you asked about, 120 s DPMS off with a connector
probe forced on the trunk 30 s into the off period:

1. No "MST mode got reset" message, no MSTM_CTRL mismatch message and
   no connector was unregistered. DPMS off wrote MSTM_CTRL as 0x04
   and the probe read it back as 04.
2. After the wake, one LINK_ADDRESS was sent and the connectors kept
   their names and ids.
3. The wake was normal: link training passed at 810000 x4 on the sink
   and both LTTPRs, payloads were allocated and both monitors came
   back.

I also probed the two MST connectors while paused (90 s off, probes
at 30 s). Modes and EDID were identical before, during and after
(28 and 32 modes, 256 byte EDID). The first probe (DP-6) took about
5 s: its REMOTE_I2C_READ got a NAK (LINK_FAILURE) after 4 s and the
retry worked. The DP-7 probe took under a second with no NAK. The
probe of the trunk read MSTM_CTRL as 04 again.

Unplug and replug during DPMS off: four runs, one cable at a time
(HDMI and DP, 90 s off, cable moved 4 to 7 s into the off period). In
all four the dock raised a long HPD on the trunk and AUX failed for
about a second, so i915 took the normal disconnect path ("MST device
may have disappeared"): the MSTM_CTRL write failed with -6 and the
three MST connectors were unregistered. One second later MST was
enabled again (0x111 <- 07), LINK_ADDRESS was sent and the topology
was rebuilt with new connectors (DP-5, DP-10, DP-11), so the names
were not kept in these runs. There was no "MST mode got reset"
message. The wake that followed was normal, with link training at
810000 x4 and payloads only for the monitors that were connected.

There was no LINK_ADDRESS after the wake. As I read the code,
set_mst() clears the paused state and nothing paused it again after
the rebuild, so unpause() returned false and no re-probe followed.
The only noise was the usual REMOTE_DPCD_READ NAKs, 4 to 10 per run,
the same as the 4 at boot when the topology is first probed.

So on this dock a sink change while paused did not reach the re-probe
at unpause: the dock raised a long HPD and the disconnect path rebuilt
the topology first. The unpause re-probe was only exercised by the
normal wakes above (one LINK_ADDRESS, no topology change).

The logs are available if you want them.
