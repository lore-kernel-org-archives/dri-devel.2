Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EML11rx/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17F110FC57;
	Wed, 21 Oct 2026 08:51:52 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618AF10F479
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:04:37 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so5543248eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792490676; x=1793095476; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U0/lnzk5hFsVd5ZzP5Fnt4j1JlLknKQhx8BKtAG3IEE=;
 b=EML11rx/XCBPFDI4Cl4L1+GCra9Jg1h0syu58hEEfP7HB1W9BErWENwOgGgv2/Id7Y
 ngilioXrDkUWgPGcpxX5B3jhMs70FRY+bRulweXCD1DgcRqJy5KNFsuWzYO/dToXecw3
 00g45gbzKddTnkaHWpNKPTIX4QhA54zLFmKwsMkyckFzyUP2VXLFZ1CFYkd00khjoeVT
 hQsQ5RJsVYNvj92c+TjpPkB1pLfNUT+UiDSb1CppBL4tguKFsebaeZv5OJ6Cw/TOEdeC
 ai3zEh+H6PoNBtTp8UyljxcOI920iD3yaFxNzdg8dF8cdP9ls9etfAL6hzFRworPiQ4n
 Hm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792490676; x=1793095476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U0/lnzk5hFsVd5ZzP5Fnt4j1JlLknKQhx8BKtAG3IEE=;
 b=27pRsW9hj5XFEEUPjAsRA+LjzSVFRC5E7FXu0HOGQ8Hi1QUtBwW05fsD4O/FbXwaZt
 oaOi7sOJaekQ6CTB56ZU6KIMIFi+P7HgPPI+/sz+LsGCzncUNmmq1G6sGQ2J9EvsdOvt
 81mkHJ19NUR8t6B0/K/f9B4aTlXNZsqDrn0CNWvRYPUJmO9k7VKc0RGAFRWzqvJFDMJt
 efx1cTQlWgalkCBHppxzG9E5U0MuBemzoFsrhZiQc06Qe7DnKHMKBiQM9Kras8RbgBg4
 YW1q99JLLRr8hau0X1l9OkbvOjowy8M6U3L005Jz9ovN+22xMjwL6gph4h679PK/7WGB
 lUHA==
X-Gm-Message-State: AFq9FYLUMbRK1TnpdW2aOBNZvz42wQUKxBpcyx2d22EUJTFRLUBbfU8j
 b2Eoq6paMIpw9aLpUHfU841MTsJrkMlIYLwUr8b+UaYkVhYtBcWUzAaW
X-Gm-Gg: AYBFou28kBaVwXpSke5uZHRlnpiuCYDrB/6a1mTcwdDqIvEhg7lYzB4fIdmh9m/d+jv
 DKL2NMZzgIqlH+RY6f+mj1+6bHOwk9hxqhdIP3h6h6WvwMnqkWxG127rqgb1QqiKO+5IB/xgVdL
 WId4zUYrMfibajOIh9Gk5OsEJIcPqzr9LL1L/j/iW6L2mNznUjovBlsntUHCflLAY71UBybs5MR
 lNHQ3lwoUREQ3VMclXz2mA+swb3biBgs7qGsIKVuhfwKkc4GJCMU3euLXAoNnVhzoxLQKrkTcEj
 Hgw/UPNSindPAja8vGF6w0cQEIh2Fd1X/rDsnOEGrNPZ3FB2+nhsN8ypj57RLNyBWAVYcyVKKga
 ebLvItE7mtzC6H/DkmKJ3/mS/mLeLp2tiDGriCFVyONGIqrSCaOZ1bcbhQJj5wOU7pSbni+qRJn
 uVM4H7EdlzagTQ0gOMdJUuLHqrOpXOsPrOT8aPRWxl/4Q3f01+k4ICR2WFYFCjIzUdSoqHl8sjz
 zGm7Fqo/UiZK9vexmyEOVD03gVOu/OH0o20SY8gppJJNnpEsAodPY9dWWwjtQ==
X-Received: by 2002:a05:701b:204f:20b0:151:7f08:5961 with SMTP id
 a92af1059eb24-1850c9cf541mr15980378c88.4.1792490675971; 
 Tue, 20 Oct 2026 03:04:35 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm36076766c88.9.2026.10.20.03.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:04:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 07:04:29 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
Message-ID: <t5mkri7cbalmy55ylrb7stanrnmxc7ep4vhmtw2nzulhgdi6wm@jsdhywrqubwx>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
 <sashiko-outbox-177001@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-177001@kernel.org>
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 10:36:09AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ARM: dts: imx6q-apalis: VGA data-enable-active ignored by simple-bridge
> --
> 
> commit a66c8dd73182954ba43ed81cada90ae73edf93a0
> Author: Leonardo Costa <leonardo.costa@toradex.com>
> 
> ARM: dts: imx6q-apalis: Add VGA overlay
> 
> This commit adds a device tree overlay for the VGA output on the Apalis
> Evaluation Board, connecting the parallel RGB display interface to a
> non-programmable video DAC and VGA connector with an active-low data-enable
> signal, and wires up composite DTB targets in the Makefile.
> 
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
> > new file mode 100644
> > index 0000000000000..991c2b7c27773
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
> > @@ -0,0 +1,80 @@
> 
> [ ... ]
> 
> > +	vga-encoder {
> > +		compatible = "dumb-vga-dac";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +
> > +				vga_enc_in: endpoint {
> > +					data-enable-active = <0>;
> > +					remote-endpoint = <&vga_display_out>;
> > +				};
> > +			};
> 
> [Severity: High]
> Does data-enable-active = <0> on vga_enc_in actually reach the IPUv3
> CRTC?
> 
> In simple_bridge_probe() in drivers/gpu/drm/bridge/simple-bridge.c, the
> data-enable-active property is parsed into timings->input_bus_flags:
> 
> 	if (de_present && !sbridge->bridge.timings) {
> 		struct drm_bridge_timings *timings;
> 
> 		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
> 		if (!timings)
> 			return -ENOMEM;
> 
> 		timings->input_bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
> 						DRM_BUS_FLAG_DE_LOW;
> 		sbridge->bridge.timings = timings;
> 	}
> 
> However, simple_bridge_bridge_funcs registers atomic bridge state
> callbacks without an .atomic_check callback:
> 
> static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
> 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> 	.attach		= simple_bridge_attach,
> 	.atomic_enable = simple_bridge_enable,
> 	.atomic_disable = simple_bridge_disable,
> };
> 
> During drm_atomic_bridge_chain_check() ->
> drm_atomic_bridge_propagate_bus_flags(), sbridge's
> bridge_state->input_bus_cfg.flags is overwritten with the downstream
> display-connector bridge's input_bus_cfg.flags (which is 0), and
> sbridge->bridge.timings->input_bus_flags is never copied into
> bridge_state->input_bus_cfg.flags.
> 
> Then, upstream in imx_pd_bridge_atomic_check() in
> drivers/gpu/drm/imx/ipuv3/parallel-display.c:
> 
> 	if (next_bridge)
> 		next_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
> 								    next_bridge);
> 
> 	if (next_bridge_state)
> 		bus_flags = next_bridge_state->input_bus_cfg.flags;
> 	else
> 		bus_flags = di->bus_flags;
> 
> Because next_bridge_state is non-NULL, bus_flags is read as 0 from
> next_bridge_state->input_bus_cfg.flags without consulting
> next_bridge->timings->input_bus_flags.
> 
> When ipu_crtc_mode_set_nofb() -> ipu_di_init_sync_panel() runs,
> sig_cfg.enable_pol = !(imx_crtc_state->bus_flags & DRM_BUS_FLAG_DE_LOW)
> evaluates to 1, driving the data-enable pin active-high instead of
> active-low and gating off the VGA DAC output during active video.
> 
> Should simple-bridge implement .atomic_check to populate
> bridge_state->input_bus_cfg.flags from bridge->timings->input_bus_flags
>  so the active-low polarity is propagated to imx-parallel-display?
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com?part=3

This and the other comment regarding atomic_check are addressed by the
patch series below, which is listed as a dependency for this patch series:

    https://lore.kernel.org/all/20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com/T/#u

Leonardo
