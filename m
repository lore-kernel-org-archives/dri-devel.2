Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B3BC624D1
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1140510EB9A;
	Tue,  1 Sep 2026 07:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kait2en.org header.i=@kait2en.org header.b="azzukf0M";
	dkim-atps=neutral
Received: from sirius.syn-flut.de (sirius.syn-flut.de [94.125.25.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B94BE10E040;
 Mon, 31 Aug 2026 11:01:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 96649140326; Mon, 31 Aug 2026 13:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kait2en.org; s=dkim;
 t=1788174116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=st0h5eJ2nnQs7ofobVciLWNyA2cU/o3+QS/j1depyO0=;
 b=azzukf0Mzt6inZfRxBpNN0FTq3w0/225VbLq5BCBpyYW4KMi4j36lHmoS56xs1d3/B0/of
 hLsUcf9MdJ/4WPnZMI5saMsSQXmjuv8izB7LgiKhofk/wccxDZmt1pWCNUx5HBp3QtFxMy
 JXEIFSMlNigmUBTGTKXrvuuWSLN77z2Zi1NnreXYELLi0lmwM0dBAPgVWM9YlFKzkyHBuL
 FRupKazsfAlEOk7YbmhYIIbHElXSh2svSH/v6IIN+c9iMP1MeQjevc5KxPIRJyhM7rsNa9
 cR/bH5pZcn0aIrmGBm62LTCsXMXNr77JqXQ9pWJZOXcw4q/fUnf0vbx7/Ns9YA==
Message-ID: <18712116082b2affddf3b509a96e3abf066d00a6.camel@kait2en.org>
Subject: Re: [PATCH] drm/i915/psr: enable PSR on Apple T2 eDP panels
From: Alexander Fischer <alexander.fischer@kait2en.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jani Nikula	
 <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie	 <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>,  =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza	
 <jose.souza@intel.com>, =?ISO-8859-1?Q?Andr=E9?= Eikmeyer	
 <andre.eikmeyer@kait2en.org>, Yossef Osman <yossef.osman@proton.me>
Date: Mon, 31 Aug 2026 13:01:53 +0200
In-Reply-To: <apUq8bYCZ3I9bErN@wunner.de>
References: <20260829161622.11396-1-alexander.fischer@kait2en.org>
 <apUq8bYCZ3I9bErN@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

On Mon, 2026-08-31 at 09:19 +0200, Lukas Wunner wrote:
> We've got pci_dev_present() for this.

Thanks, will use it in v2.
