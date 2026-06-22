Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C28CD98F6
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D66510E08A;
	Mon, 22 Jun 2026 03:47:43 +0000 (UTC)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA2F10E08A
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 03:47:42 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout1.hostsharing.net (Postfix) with ESMTPS id 1FDD435B;
 Mon, 22 Jun 2026 05:47:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 0CF686011CD9; Mon, 22 Jun 2026 05:47:40 +0200 (CEST)
Date: Mon, 22 Jun 2026 05:47:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
Message-ID: <ajiwXJuY0PrGq7Gj@wunner.de>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
 <20260612080722.26726-13-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
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

On Fri, Jun 12, 2026 at 01:37:28PM +0530, Mallesh Koujalagi wrote:
> PUNIT errors can only be recovered using a power-cycle. Xe KMD
> sends a uevent to notify userspace to trigger a power cycle.
> On platforms where link drop caused by powering the device off and
> back on is reported by hardware as a Surprise Link Down (SLD), which
> AER then escalates as an Uncorrectable Fatal Error. That error fires
> before the device finishes coming back up and defeats the
> very recovery we are attempting.
> 
> To keep the expected, recovery-induced link drop from being raised as
> a fatal AER event, mask the Surprise Link Down bit
> (PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
> Mask register before punit_error_handler() requests the cold reset.

You need to clear the Surprise Down Error Status bit in the
Uncorrectable Error Status Register after the reset.

You should also unmask the error.

> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);

pci_clear_and_set_config_dword()?

OSPM is not supposed to fiddle with AER registers unless it has been
granted control of those registers through the ACPI _OSC method.

There's a pcie_aer_is_native() helper to skip access to those registers
but its only visible to the PCI core currently.

Thanks,

Lukas
