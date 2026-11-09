Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981A60A2608
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrAW11MW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73ED810E260;
	Mon,  9 Nov 2026 22:51:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C8910E260;
 Mon,  9 Nov 2026 22:51:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B56DD61E10;
 Mon,  9 Nov 2026 22:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1271F008A3;
 Mon,  9 Nov 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794264690;
 bh=OLJ67V8X7KC85E5hy4wyiU8tc9lVp4VzA68SRJcP5ck=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=VrAW11MWqmE8FHeSQc8ncdp1WQph7/ZKqQKoG5d04gFFAh/KiyOeMyhbs9tgUPVEH
 yu0Sw/LVrEnq1l0/D1Ogtek0IwM86wjZL3ojvdP6jRRRvgmhv+3Yt1Qlzl2Ay3tSfi
 CGCdK0drexkQf8k6w5Z73HDDhrQ0OlxihxA9oNkzZhHXoFCMq+7x9TlJyew0p1V8ix
 dAfTAyuGDAb2n7DcSnbSgQBxeYdtPNk1xfWrFJ5zmfRW9HQ5lVc+fCuBDBWH3eY7mp
 qXuHsRYFc7+UJBGV9tH7o+jCuK7GtShutCPiQGcOj8hWCcvxwDoO5/MJYxga8YJXp+
 rFWDHRUqWDABw==
Date: Mon, 9 Nov 2026 16:51:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 0/3] PCI: remove redundant resource assignments done
 after BAR resize
Message-ID: <20261109225129.GA334675@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
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

On Mon, Nov 09, 2026 at 03:10:07PM +0200, Ilpo Järvinen wrote:
> The BAR resize rework removed the resource assignment call that
> followed the BAR resize in amdgpu. The xe and i915 drivers and the
> PCI sysfs resize interface still make the same call.
>  
> The current BAR resize code should properly assign all resources and
> handle fallback gracefully so a driver-side call to assign resource
> right after BAR resize is just duplicate work (no-op). If that isn't
> the case somewhere, the fix belongs either the BAR resize code or the
> code that left the resource unassigned (e.g. a hotplug race or whatever
> left an resource unassigned prior to resize).
> 
> If drm wants to take their patches out of these, it's fine with me
> (either drm+pci or through pci tree only works for me).
> 
> 
> Ilpo Järvinen (3):
>   PCI/sysfs: Remove resource assignment after BAR resize
>   drm/xe: Remove driver side resource assignment after BAR resize
>   drm/i915: Remove driver side resource assignment after BAR resize
> 
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
>  drivers/gpu/drm/xe/xe_pci_rebar.c           | 2 --
>  drivers/pci/pci-sysfs.c                     | 3 ---
>  3 files changed, 6 deletions(-)

All applied to pci/resource for v7.5, thank you!
