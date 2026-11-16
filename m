Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED14606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dMO8ecDb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E707B10EF36;
	Mon, 16 Nov 2026 10:35:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFAD10EF31;
 Mon, 16 Nov 2026 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794825330; x=1826361330;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=/UZDrPrPsnD6LBTHOM4nV0t5o1AUMv0eEZfDcvrX/es=;
 b=dMO8ecDbRCuSSm+wqSUU4ZAqvw7c/fzCrMwfpcYClhsGuUP6n67MoONk
 e+e3DCTGuqS3P14lO7Ys+xfl/xatnvXex38Y7dk9sK7Uf7HpVckYa1Sq2
 GAlSwipzDyALwv9lJ8x7dRrYogF7zIwkIKbF3TDaAmylr7Zo5IUVRjblb
 Nz8npAKT66CCsnEpNfgKwvAy0K86cQFayYHy2baprCIofrlOKUD+CQEcG
 1wBKVuC0i9RL86L8WYThY16ffeRS6t2vl+EiWaBizkXN+y1Dhw1/W3DFx
 zpfTk2bCptUr5qcliVskZYs4bpOVbaB3ELFT90xDj3w+oALETBOugJc/G A==;
X-CSE-ConnectionGUID: +320i786RLCHVK5iYsm5Lw==
X-CSE-MsgGUID: AKpf12vEQZ2Pfbm46DOqLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3546263"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3546263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:35:30 -0800
X-CSE-ConnectionGUID: /bxSobFmRn26xiMcwxAH0g==
X-CSE-MsgGUID: cBiure3tSf6iBViQ1OYQYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9762142"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:35:28 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Frederik Schwan <frederik@tty42.de>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: regressions@lists.linux.dev, Imre Deak <imre.deak@intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
In-Reply-To: <aveDNRBLx1a-9hRQ@mail.tty42.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <aveDNRBLx1a-9hRQ@mail.tty42.de>
Date: Mon, 16 Nov 2026 12:35:25 +0200
Message-ID: <40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026, Frederik Schwan <frederik@tty42.de> wrote:
> Hi everyone,
> I just upgraded my system to 7.3.x and found a regression with my notebook/dock setup.
> 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I guess that DP-alt mode then).
>
> Until 7.2 all displays worked. With 7.3 all displays work until kernel switches from fbdev (?) after
> which the 2 DP displays have no signal anymore but the USB-C one still works.

Please file i915 bugs as described at [1].

BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


-- 
Jani Nikula, Intel
