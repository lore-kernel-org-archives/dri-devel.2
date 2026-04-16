Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4172BF8E48F
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8112F10E246;
	Thu, 16 Apr 2026 22:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c1HwZFbs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A0F10E246;
 Thu, 16 Apr 2026 22:53:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D709F60128;
 Thu, 16 Apr 2026 22:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F2AC2BCAF;
 Thu, 16 Apr 2026 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776380003;
 bh=IWCEaQbl3udO2Tkn6BZ3hxIE47g64opbN1VZ4DBMm7A=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=c1HwZFbsb72W4guoxbgZfS9eMY+AE63X18cyoW2/y2nx/pBlBS9AJKBQZDoROZQ++
 URGs+VJynCBMwmXxs/C4he2Id/OMhgukzqvSY+gJ9PEs2wKYZo+08Jnof0oDD4TzNl
 wHyFwePKaPb0nCC/Twd64IQBmzPJLU9ZGXPNu0uDImY0SndAzTeYTOtC55mrpZugrL
 h2zyLoF/2sPZ7v4WA7NPyufsqM86gsgTj3c2HVrM0JIxnzJPSUS0qmEE0gKxRr7Vcl
 sysv8qOJdI53oQoVRgbQP7ZPGpyMC+VP69DWaDSJfIbDb+5WSdgKByOcRkvAVSSatA
 YMjyglABTXJFg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 00:53:11 +0200
Message-Id: <DHUY5IGHGE49.Z2UVYJ23KX2Y@kernel.org>
Subject: Re: [PATCH v11 07/20] gpu: nova-core: mm: Add TLB flush support
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Dave Airlie"
 <airlied@redhat.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 "Nikola Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>, "Christian
 Koenig" <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Lucas De Marchi"
 <lucas.demarchi@intel.com>, "Thomas Hellstrom"
 <thomas.hellstrom@linux.intel.com>, "Helge Deller" <deller@gmx.de>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260415210548.3776595-1-joelagnelf@nvidia.com>
 <20260415210548.3776595-7-joelagnelf@nvidia.com>
 <20260416212312.GA667928@joelbox2> <DHUWPQX14ZGZ.26BV7GQCJDZQI@kernel.org>
 <1e3c423e-1cf5-48b1-b012-c4af0eb6b95f@nvidia.com>
In-Reply-To: <1e3c423e-1cf5-48b1-b012-c4af0eb6b95f@nvidia.com>
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

On Fri Apr 17, 2026 at 12:18 AM CEST, Joel Fernandes wrote:
> On 4/16/2026 5:45 PM, Danilo Krummrich wrote:
>> Why do we need the try_access() dance in the first place? I assume this =
ends up
>> being called from the BarAccess destructor?
>
> BarAccess is different. The try_access() calls here are in tlb.rs and
> pramin.rs for Bar0.

Yes, and we shouldn't need them in the first place; we should have a
&Device<Bound> in all call paths this is called from.

>> If so, I think this is solvable. Gary and me are currently working on
>> higher-ranked types and a chained Devres type.
>
> Hmm, the issue here is we cannot hold revocable guard while sleeping, but
> we have read the bar as a condition in the body of the poll.

No, you should just require a &Device<Bound>; or maybe we can utilize the
mentioned higher-ranked types and DevresChain once we have it. But in any c=
ase
you shouldn't need try_access() here.

>> With that, such use-cases should be cleanly solvable without the need fo=
r
>> try_access().
>>=20
>> Besides that, I can't find where BarAccess is ever constructed.
>
> BarUser::map() constructs it.

I'm well aware, but absolutely nothing calls BarUser::map(). :)

>> It already has a lifetime 'a for &'a Bar1, so I don't see why you can't =
do the
>> same for Bar0.>
>> But again, I don't see this being constructed and I'm not sure the whole
>> construct works in the first place.
>
> BarAccess uses &'a Bar1 because it's a short-lived scoped object. In long
> lived objects I am trying to avoid this.

Don't get me wrong, if a lifetime is sufficient -- that's great! But I'm
suspicious whether it actually is, since BarAccess is never actually constr=
ucted
and hence I can't see how it would be used.
