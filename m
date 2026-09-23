Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0BCC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C6E10F911;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="W/Aw4x+l";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715CC10E0A1;
 Wed, 23 Sep 2026 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Reply-To:Content-ID:Content-Description;
 bh=SsCuNzmgxLzWx+3uyAmSPHK7VGXvDorQ27xP2xLHmRU=; b=W/Aw4x+lFhUAQTP4c1VKEhBS/V
 qQflp8IYrQAl8pv8CXmzSueYbdQlbdGtXcPdQ6DlaDUXAGXRQVGzdfG3JAIkiAF418cINcv429Tf9
 x0ddKXyg6vz556gpQ9U42oZA9RFYGH1aRVGNrbf9w5HYZUCFub35v3qmsgiBnKlKSfMIvcll254oS
 YCpye6/uqCSTorgSOcScAAxT79pJ8GFHpJPvun6H42jKJJ6NDqsPAcU4twDQX5edks3WAWRUSerMV
 QNODJ4x6htkGgcBvscwpFfG5tvqjQ9L6qGkFLrkEd5ErTwKSyQ8LkFBre7lRovikJDyL3K+WAs28c
 LYLh35Sw==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <leitao@debian.org>) id 1x9J7B-003ePq-0r;
 Wed, 23 Sep 2026 09:18:09 +0000
Date: Wed, 23 Sep 2026 02:18:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
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
Subject: Re: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
Message-ID: <arOZOVyT_F1nUvS1@gmail.com>
References: <bHvLFyR13nE7HUTBaSLSUZOfB-goGIQLnTtXl9nIQ_beVuvnPA2GpKpdWw-JM4MamQAdiSxOnCc_msKnwqqISw==@protonmail.internalid>
 <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <87tsnh2w3d.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsnh2w3d.fsf@t14s.mail-host-address-is-not-set>
X-Debian-User: leitao
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On Tue, Sep 22, 2026 at 04:34:46PM +0200, Andreas Hindborg wrote:
> Thomas Weiﬂschuh <linux@weissschuh.net> writes:
> 
> > The attribute structure defined in driver code never need to be
> > modified. Allow them to be marked as const.
> >
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> For the rust parts:
> 
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> 
> @Breno, will you take the entire series through your tree?

Yes, I can take the whole series through my tree.
