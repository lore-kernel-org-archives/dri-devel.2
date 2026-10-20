Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04931606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MZ+opVEq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAA810F433;
	Tue, 20 Oct 2026 09:34:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC2410F433;
 Tue, 20 Oct 2026 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792488846; x=1824024846;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=UiTibeB8aRja4VBAdEF821lxVBIe0pJ/mcUtkq5XxrY=;
 b=MZ+opVEqNtrvobr9ukBp8E2ieOoIBCi9UidTKcGUHgBTxUF8If2fQpCZ
 XuskEQ8XO/YFpuCoZuJ878Zkw+lt0UXg9xbGb5QsclgD2bnP5JRJpFGJP
 dMjOIZMbYOX34HWk8RDAJ/E09u2cV3jVkYv5huaLIJ8FPN6mN8e24rQcz
 Vl9mLN7KwVIoEJbr53fVVbDVkEuuzSK34KkD6oCi8oxxcLf5YOm5EOsPh
 N6uIkcXb+UZ028BCWsOhYS8nTx5XttMHIqgFSHV2T6rcEIydhyNYsDLxi
 ZocMSGnIeLamfwJpBKuaOr4lS7j3cBX8Fr4ayFSRPojq4w0nP81StetxI w==;
X-CSE-ConnectionGUID: Omju1AsoTIKpZG+LDQFwug==
X-CSE-MsgGUID: vChoj4wUTZ+Wv3ZY60xabw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1198623"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1198623"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:34:06 -0700
X-CSE-ConnectionGUID: dxvBFNfLTI6MdSFCYVAvvg==
X-CSE-MsgGUID: lOp8WBZ6SBib+cC73AzpxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2774575"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.174])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:34:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Borislav Petkov <bp@alien8.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A.
 Dadhania" <nikunj@amd.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>, the arch/x86 maintainers
 <x86@kernel.org>
Subject: Re: Removing __get_user / __put_user for good
In-Reply-To: <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
Date: Tue, 20 Oct 2026 12:33:58 +0300
Message-ID: <664c8f8c979a76be18b3e6538a15d3c4235fb8ac@intel.com>
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
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026, Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> Bah. I made this branch of mine public because I wanted Michael
> Tsirkin to check the vhost part.
>
> But honestly, the i915 side and the coco/SEV patches are the much more
> interesting ones.
>
> So this brings in some new victims^Hpeople for that git branch to comment on.
>
> It's all in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> uaccess-cleanup
>
> I haven't dared actually boot it yet.

I rebased it on top of our development branch and sent it to i915
CI. Let's see if it blows up. ;)


BR,
Jani.


-- 
Jani Nikula, Intel
