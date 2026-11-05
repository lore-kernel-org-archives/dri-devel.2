Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B2606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B41/EYZN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C68112250;
	Thu,  5 Nov 2026 08:42:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A64F112250
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:42:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA9E541B5D;
 Thu,  5 Nov 2026 08:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173321F000C1;
 Thu,  5 Nov 2026 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793868141;
 bh=rvsdMBspxxqECpjbAI42lx5NbPMQgGmPQp0lLwZaU7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B41/EYZNq0qVnbGM0+UPdI+TmVYCH8wdptnRHUogjpZEWiWsVErfrqXjQp06oVawG
 XkincJ0pHFnuaEM4S79uEMbnoIXOr5JF0GT4VPqgOI9FQzCZoubKwAM24J8TfJAPfH
 hUOncuyRHxk4c6EiPBa5rceqbp5ZPMasjapX/5VDsie96uWO/FxPDZcj16EjXolUUy
 gzNzmnzhPNYVuHbTTmMDpFtrEpeZ1mSHeB1nbjfc2aZZEp+TAC3MLfd9fVf23UNflV
 syv8SL/fn92MXH9/15ucH1ODMGO3+yC0lC2OMmXW22DreMHPBIj3rkjoUEDjPllA+I
 6xcO7/dAsiVlA==
Date: Thu, 5 Nov 2026 10:42:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v12 15/19] PCI: Add KUnit coverage for ACS isolation checks
Message-ID: <20261105084217.GJ478286@unreal>
References: <20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com>
 <20261103-fix-p2p-acs-v4-0-v12-15-912101f93517@nvidia.com>
 <sashiko-outbox-195118@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-195118@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:11:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] PCI: duplicated mock device setup in pci_acs_flags_enabled_test()
> --
> 
> commit cd21c328560f2b4befdb418098279304a429237f
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI: Add KUnit coverage for ACS isolation checks
> 
> This commit exposes pci_acs_flags_enabled() when KUnit is enabled and adds
> KUnit tests in drivers/pci/pci_acs_test.c using mock config-space operations
> to verify ACS isolation checks, missing capabilities, and failed config reads.
> 
> > diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
> > index 18c697226762d..369444d2a04a0 100644
> > --- a/drivers/pci/pci_acs_test.c
> > +++ b/drivers/pci/pci_acs_test.c
> > @@ -103,10 +103,145 @@ static void pci_acs_p2pdma_completion_test(struct kunit *test)
> 
> [ ... ]
> 
> > +static void pci_acs_flags_enabled_test(struct kunit *test)
> > +{
> > +	const struct acs_isolation_case *c = test->param_value;
> > +	struct acs_ctrl_cfg cfg = {
> > +		.devfn = PCI_DEVFN(0, 0),
> > +		.cap = ACS_TEST_CAP,
> > +		.ctrl = c->ctrl,
> > +	};
> > +	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
> > +	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
> > +
> > +	KUNIT_ASSERT_NOT_NULL(test, bus);
> > +	KUNIT_ASSERT_NOT_NULL(test, pdev);
> > +
> > +	bus->ops = &acs_ctrl_ops;
> > +	bus->sysdata = &cfg;
> > +
> > +	pdev->bus = bus;
> > +	pdev->devfn = cfg.devfn;
> > +	pdev->acs_cap = ACS_TEST_CAP;
> > +	pdev->acs_capabilities = ACS_ALL_CAPS;
> > +
> > +	KUNIT_EXPECT_EQ(test, pci_acs_flags_enabled(pdev, c->req), c->expect);
> > +}
> > +
> > +static bool acs_isolated(struct kunit *test, struct acs_ctrl_cfg *cfg,
> > +			 u16 acs_cap, u16 acs_flags)
> > +{
> > +	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
> > +	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
> > +
> > +	KUNIT_ASSERT_NOT_NULL(test, bus);
> > +	KUNIT_ASSERT_NOT_NULL(test, pdev);
> > +
> > +	bus->ops = &acs_ctrl_ops;
> > +	bus->sysdata = cfg;
> > +
> > +	pdev->bus = bus;
> > +	pdev->devfn = cfg->devfn;
> > +	pdev->acs_cap = acs_cap;
> > +	pdev->acs_capabilities = ACS_ALL_CAPS;
> > +
> > +	return pci_acs_flags_enabled(pdev, acs_flags);
> > +}
> 
> [Severity: Low]
> This isn't a bug, but in drivers/pci/pci_acs_test.c,
> pci_acs_flags_enabled_test() open-codes the same mock struct pci_bus and
> struct pci_dev allocation and initialization that acs_isolated() performs
> immediately below it.
> 
> Also, struct acs_ctrl_cfg already carries the cap field, which every caller
> initializes to the same value passed as the separate acs_cap argument to
> acs_isolated().
> 
> Could acs_isolated() set pdev->acs_cap from cfg->cap directly, and could
> pci_acs_flags_enabled_test() call acs_isolated() to avoid duplicating the
> setup?

Yes, I can combine them.

Thanks

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com?part=15
