Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD5606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M8zLzQAW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2756B10F2D5;
	Mon,  9 Nov 2026 13:50:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A038D10F2DA;
 Mon,  9 Nov 2026 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232247; x=1825768247;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=fk+ULn+LiMYolzMljOxfZYHMNqgMG1FKUhWrEn7F8iI=;
 b=M8zLzQAWzwL4X+pmhJLXkrOKsJaID5u5H+GbXsMoRlSF1mPJqSG9HWN3
 22uyYCTMIJ4iTvJfwUPzru+vvlRbdmP6CILujMjF069KCGBu7hIOnDehp
 jNj9kI40sIcm940nN5tyDAUbZCgP90Mq5oCWMY2it46Gff8j8ZPTaQiMZ
 1Kyp767u78KG1ezeVRtLeeTps3h71wMotgtWj7bVNIP3NA6sSWsVVbX02
 h7o1MBa/6it9VbwCRaKksOYaB/FOz9RbYyVlaD9e8fDF5eGcf0PLJqOQZ
 EeJYXgw6/zNWWgMfXkvPaTwuXMy3jkQSTNzivlIejGfEGJBf1zvr27O33 Q==;
X-CSE-ConnectionGUID: lFN3qfrbSmCwhnanCO3rVA==
X-CSE-MsgGUID: fJ4Xu4jZS86VPnO4+USGRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2985776"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2985776"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:50:47 -0800
X-CSE-ConnectionGUID: seZ/F5gVRPiD6OPQFxKKUQ==
X-CSE-MsgGUID: eQlnhf9cQb215+SktPBVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7897628"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.99])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:50:43 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
 <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 3/3] drm/i915: Remove driver side resource assignment
 after BAR resize
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 09 Nov 2026 15:50:40 +0200
Message-ID: <179423224043.176713.9574389595098924070@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Ilpo J=C3=A4rvinen (2026-11-09 15:10:10)
> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
>=20
> Remove the pci_assign_unassigned_bus_resources() call from
> i915_resize_lmem_bar().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Feel free to apply on pci tree where the refactoring also landed.

Regards, Joonas
