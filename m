Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCD606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kcore.it header.i=@kcore.it header.a=rsa-sha256 header.s=spark header.b=N+5AiilH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4877B10F2DD;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1C410ECB3;
 Mon, 19 Oct 2026 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
 s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date;
 bh=g1lutFHGYHe3LPuQ+NNGIf8kI9HX1x3Px3jVkRoxCZ0=; b=N+5AiilHcPfm3cVdPdUtWZxjLU
 a1PUIZ/h+n1Jd+VH+xpPEfBTq1szBpT1GMuI6VsFVE7cwYFaFJtrdJ+ynfgE3F5awA9mmIT1JGS8Z
 2fx077ViyAKCwoY7Wz5AouYjigb/0HJK85kU+g5bMpRkjjKd4qvzFYsDeZ+sT2RN/IOU=;
Received: from mnencia by spark.kcore.it with local (Exim 4.100.1)
 (envelope-from <mnencia@kcore.it>) id 1xImfK-00000000XlT-42wx;
 Mon, 19 Oct 2026 14:40:34 +0200
Date: Mon, 19 Oct 2026 14:40:34 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, jani.nikula@linux.intel.com, lyude@redhat.com,
 xiaolu.xie@intel.com
Subject: Re: [PATCH] drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS
 off/on
Message-ID: <atYPws4_nSEKU_O6@spark.kcore.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014081448.2320363-1-xiaolu.xie@intel.com>
References: <20261014081448.2320363-1-xiaolu.xie@intel.com>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I hit the problem the automated review pointed out. It did not cause a
black screen here, but the MST topology was torn down during DPMS off.

Same setup as my Tested-by (Dell Pro Max 16, WD19DC, two monitors, i915
over TBT-alt, drm.debug=0x10e), now on Debian kernel 7.2.9 with the
patch applied.

I ran one DPMS off/on cycle each of 30 s, 60 s and 120 s. The 30 s and
60 s runs were clean: no connector probe during the off period, link
and topology kept. In the 120 s run i915 runtime-suspended 14 s into
the DPMS off and resumed 5 s later. The resume probed every connector,
with no user space probe at that point. intel_dp_detect() read
MSTM_CTRL as 0 (the value written by the new clear in
intel_ddi_post_disable_dp()):

  intel_dp_detect: MST support: port: yes, sink: MST, modparam: yes
    -> enable: MST
  drm_dp_dpcd_read: AUX USBC4/DDI TC4/PHY TC4: 0x00111 AUX
    -> (ret= 1) 00
  intel_dp_mst_verify_dpcd_state: [CONNECTOR:554:DP-4]
    [ENCODER:553:DDI TC4/PHY TC4] MST mode got reset, removing
    topology (ret=1, ctrl=0x00)

The topology was removed and the three MST connectors DP-5, DP-6 and
DP-7 were unregistered. The hotplug event made user space probe again
4 s later. That wrote 0x111 <- 07, sent CLEAR_PAYLOAD_ID_TABLE and
LINK_ADDRESS, and the topology came back as DP-5, DP-10 and DP-11.
MSTM_CTRL then stayed set while the hub was in D3, for the remaining
98 s, and the wake was still normal: link training passed at 810000 x4
on the sink and both LTTPRs, payloads allocated, both monitors
enabled. GNOME dropped the external monitors and added them back while
blanked, and logged logical monitor assertion failures.

My earlier 120 s run for the Tested-by did not hit this. It needs a
connector probe while MSTM_CTRL is 0. The patch does not change
intel_dp_mst_verify_dpcd_state(). Its only caller is
intel_dp_detect(), and it expects MST_EN | UP_REQ_EN |
UPSTREAM_IS_SRC whenever is_mst is set.

One way to avoid it: accept MSTM_CTRL == 0 in that function when no
MST stream is active, since that is the window where the patch clears
it on purpose, and the re-enable writes it again. No new flag is
needed. I have not tried it. I can test a v2 with that or any other
approach.

The log of the 120 s run is available if you want it.

Marco
