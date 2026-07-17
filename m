Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98512C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CB210E485;
	Fri, 17 Jul 2026 15:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="C7A3hx32";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837CA10E485;
 Fri, 17 Jul 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784302527;
 bh=gXtoOXom+SZ6fQtLujthmE72o636wo7yJ2Varaquo7k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C7A3hx32jx895MFvzYe4hAelAzoV5JrxYVL5DhNvu226PRfs8EQMVKcO32Fi49mK9
 tGyECjWnZYRjaZD4Nz2T0lbWZlMiWVBTMpBzfOX6pAMH4c9VyX93D9RRVVUZVDAJfO
 rczg1jxOtPUk6bzpwTVQHSQJpUtGM37XrH0HxaAk=
Date: Fri, 17 Jul 2026 17:35:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dan Williams <djbw@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 5/6] configfs: Allow the registration of const struct
 configfs_attribute
Message-ID: <91f5e9dc-1ba0-4e20-9f1f-5100aaaf0a88@t-8ch.de>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-5-c545a4053cb5@weissschuh.net>
 <alnrJJNb1hwDrAxI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alnrJJNb1hwDrAxI@gmail.com>
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

On 2026-07-17 01:43:36-0700, Breno Leitao wrote:
> On Thu, Jul 16, 2026 at 07:09:30PM +0200, Thomas Weißschuh wrote:
> > The attribute structure defined in driver code never need to be
> > modified. Allow them to be marked as const.
> > 
> > As there are many drivers which use these attributes, prepare for a
> > phased transition by using a union of const and non-const attributes.
> 
> How many drivers need to be migrated? Isn't this a mechanism move?

The actual constification of the attribute will happen with a central
change to the CONFIGFS_ATTR* macros. But all users of the macro
will need to be prepared to handle the constness.

I have a branch with the full conversion here:

https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/log/?h=b4/configfs-const

 73 files changed, 241 insertions(+), 248 deletions(-)

 Most driver changes are really trivial. But a few do more interesting
 things. My goal is to heavily reduce the amount of patches in this
 branch by merging patches to the same subsystem.

 The last four patches will be the finalization going again through
 the configfs tree.


 Thomas
