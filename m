Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACD8FED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579910E5AB;
	Tue, 17 Mar 2026 16:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SlbbBvFe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0FD10E576;
 Tue, 17 Mar 2026 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773765968; x=1805301968;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=+3vGLAAfgOZsjmSIKZYaf0zJhxEDsjy5dQzR30pVQy0=;
 b=SlbbBvFeSSBdBm170Szi2Ijf6bcE0RPt6dT7sxBNaEu2dQA8miFnTCB3
 VdvMnK0v5GIRWcZnNZli7/qGuIQTqQoIKe0Hmp50rxWJ4jaRk8MuL5hGd
 TmPI6gNi7R2vJa+K+caxHUACfmMXBtVuXnrLSQb++GpCkZa220A1hxjAr
 7DAIvzcsGdkaIiTWKFFzPIMGCJNvAIrFS2/77AW0y5sAw/9ASmyWIt0u8
 Vwo8t1A9iTQDUWluhfRpIKxyA5J6kgSSZBs98UfJ6HCBQhKkItEOV73pA
 D/+kM6RsrxQG7/puc4j2rTa4u6zoHA97qaaQLNG4gjz7AQ6EGolmbthCT Q==;
X-CSE-ConnectionGUID: zs5OpRSJSeCEYYIHqr48Cw==
X-CSE-MsgGUID: DbU4z8uPQta+j83pQDOKhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92187157"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="92187157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:45:56 -0700
X-CSE-ConnectionGUID: 6TmL274ZTKS1bD2XSPgHIg==
X-CSE-MsgGUID: U+NLJdK8QIaMdRJ8//ISvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="245344165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:45:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:45:48 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 20/22] platform/x86/intel/pmc/ssram: Add ACPI discovery
 scaffolding
In-Reply-To: <20260313015202.3660072-21-david.e.box@linux.intel.com>
Message-ID: <c6a6967d-eef2-10e7-87f0-574a09f14d1a@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-21-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 12 Mar 2026, David E. Box wrote:

> Prepare the SSRAM telemetry driver for ACPI-based discovery by adding the
> common initialization path and selection framework needed for resource
> discovery from the ACPI companion device.
> 
> At this stage, existing supported devices continue to use the PCI path.
> This change lays the groundwork for follow-on patches that wire platform
> IDs to the ACPI policy path.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  .../platform/x86/intel/pmc/ssram_telemetry.c  | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index 246efdcf6950..b937ebb2322f 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2023, Intel Corporation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/cleanup.h>
>  #include <linux/intel_vsec.h>
>  #include <linux/pci.h>
> @@ -26,14 +27,17 @@ DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_T))
>  
>  enum resource_method {
>  	RES_METHOD_PCI,
> +	RES_METHOD_ACPI,
>  };
>  
>  struct ssram_type {
>  	enum resource_method method;
> +	enum pmc_index p_index;
>  };
>  
>  static const struct ssram_type pci_main = {
>  	.method = RES_METHOD_PCI,
> +	.p_index = PMC_IDX_MAIN,
>  };
>  
>  static struct pmc_ssram_telemetry pmc_ssram_telems[3];
> @@ -146,6 +150,76 @@ static int pmc_ssram_telemetry_pci_init(struct pci_dev *pcidev)
>  	return ret;
>  }
>  
> +static int pmc_ssram_telemetry_get_pmc_acpi(struct pci_dev *pcidev,  unsigned int pmc_idx)
> +{
> +	void __iomem __free(pmc_ssram_telemetry_iounmap) * ssram = NULL;

__free() ... = NULL is a bad pattern as explained in the long comment in 
cleanup.h. The variable should be declared right at site of assignment.

It's not problem in this case but it is stick to the safer pattern.

> +	u64 ssram_base;
> +
> +	ssram_base = pci_resource_start(pcidev, 0);
> +	if (!ssram_base)
> +		return -ENODEV;
> +
> +	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!ssram)
> +		return -ENOMEM;
> +
> +	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
> +
> +	return 0;
> +}
> +
> +static int pmc_ssram_telemetry_acpi_init(struct pci_dev *pcidev,
> +					 enum pmc_index index)
> +{
> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_handle handle = ACPI_HANDLE(&pcidev->dev);
> +	struct intel_vsec_header header;
> +	struct intel_vsec_header *headers[2] = { &header, NULL };
> +	struct intel_vsec_platform_info info = { };
> +	union acpi_object *dsd;
> +	u32 (*acpi_disc)[4];
> +	acpi_status status;
> +	int ret;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status = acpi_evaluate_object(handle, "_DSD", NULL, &buf);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	dsd = pmc_find_telem_guid(buf.pointer);
> +	if (!dsd) {
> +		ret = -ENODEV;
> +		goto cleanup_acpi_buf;
> +	}
> +
> +	ret = pmc_parse_telem_dsd(dsd, &header, &acpi_disc);
> +	if (ret)
> +		goto cleanup_acpi_buf;
> +
> +	info.headers = headers;
> +	info.caps = VSEC_CAP_TELEMETRY;
> +	info.acpi_disc = acpi_disc;
> +	info.src = INTEL_VSEC_DISC_ACPI;
> +
> +	/* This is an ACPI companion device. PCI BAR will be used for base addr. */
> +	info.base_addr = 0;
> +
> +	ret = intel_vsec_register(&pcidev->dev, &info);
> +	if (ret)
> +		goto cleanup_acpi_disc;
> +
> +	ret = pmc_ssram_telemetry_get_pmc_acpi(pcidev, index);
> +
> +cleanup_acpi_disc:
> +	kfree(acpi_disc);
> +cleanup_acpi_buf:
> +	ACPI_FREE(buf.pointer);

kfree() + __free() as mentioned to some other patch.

> +
> +	return ret;
> +}
> +
>  /**
>   * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr information
>   * @pmc_idx:               Index of the PMC
> @@ -186,6 +260,7 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  {
>  	const struct ssram_type *ssram_type;
>  	enum resource_method method;
> +	enum pmc_index index;
>  	int ret;
>  
>  	ssram_type = (const struct ssram_type *)id->driver_data;
> @@ -196,6 +271,7 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  	}
>  
>  	method = ssram_type->method;
> +	index = ssram_type->p_index;
>  
>  	ret = pcim_enable_device(pcidev);
>  	if (ret) {
> @@ -205,6 +281,8 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  
>  	if (method == RES_METHOD_PCI)
>  		ret = pmc_ssram_telemetry_pci_init(pcidev);
> +	else if (method == RES_METHOD_ACPI)
> +		ret = pmc_ssram_telemetry_acpi_init(pcidev, index);
>  	else
>  		ret = -EINVAL;
>  
> @@ -238,6 +316,7 @@ static struct pci_driver pmc_ssram_telemetry_driver = {
>  };
>  module_pci_driver(pmc_ssram_telemetry_driver);
>  
> +MODULE_IMPORT_NS("INTEL_PMC_CORE");
>  MODULE_IMPORT_NS("INTEL_VSEC");
>  MODULE_AUTHOR("Xi Pardee <xi.pardee@intel.com>");
>  MODULE_DESCRIPTION("Intel PMC SSRAM Telemetry driver");
> 

-- 
 i.

