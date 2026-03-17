Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC42FD877E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D21810E695;
	Tue, 17 Mar 2026 14:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HF1ZiEVK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE6610E66B;
 Tue, 17 Mar 2026 14:33:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D3214169B;
 Tue, 17 Mar 2026 14:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB59C4CEF7;
 Tue, 17 Mar 2026 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773757999;
 bh=UMKGlEB6GEb6d3+ga9RF5Uym94ud3HWbnp9OP+wid2Q=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=HF1ZiEVKHe1ymrCoIKfF8q078IFJHcAcjYeIk1K5k/X6OPIHqRshn79IVh/mcojhc
 Qkl72/vCSsXRxwiK010QnUwPMfPCjYLEkdjOF4b0a3HG+9qyQRiEc6+Rr1SpQ33Gts
 KpZOTikBPCsb2OpgbWLjO8GfkhCkhNPPyZGDYozdrBNOppFo624sX6QOlNNVhmsIXs
 vYMqlNWWVGebdNOPNDxH5+n+W4Uc8rTkNT5i/mpH7xsVZYGFvXYUrtTwCnddqPSCAM
 EWlA1c1eDfUW7hPp9kFlaCSIPTR5jMzZN/pjtbwcBFys0XRPU2/oBE3n9e6o+JdNKf
 KVZnlBDjxvL7w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 15:33:13 +0100
Message-Id: <DH54QCVVTUZD.3L5VPUW8B38V5@kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Cc: "Matthew Brost" <matthew.brost@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David Airlie"
 <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Philipp Stanner" <phasta@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Jeffrey Vander Stoep" <jeffv@google.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Stone"
 <daniels@collabora.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <shashanks@nvidia.com>,
 <jajones@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <DH524YJD4UD3.HLHJP0AM401N@kernel.org>
 <974E3052-FCA8-4985-A37D-A1F49C06A77C@collabora.com>
In-Reply-To: <974E3052-FCA8-4985-A37D-A1F49C06A77C@collabora.com>
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

On Tue Mar 17, 2026 at 3:25 PM CET, Daniel Almeida wrote:
>
>
>> On 17 Mar 2026, at 09:31, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Tue Mar 17, 2026 at 3:47 AM CET, Daniel Almeida wrote:
>>> I agree with what Danilo said below, i.e.:  IMHO, with the direction th=
at DRM
>>> is going, it is much more ergonomic to add a Rust component with a nice=
 C
>>> interface than doing it the other way around.
>>=20
>> This is not exactly what I said. I was talking about the maintainance as=
pects
>> and that a Rust Jobqueue implementation (for the reasons explained in my=
 initial
>> reply) is easily justifiable in this aspect, whereas another C implement=
ation,
>> that does *not* replace the existing DRM scheduler entirely, is much har=
der to
>> justify from a maintainance perspective.
>
> Ok, I misunderstood your point a bit.
>
>>=20
>> I'm also not sure whether a C interface from the Rust side is easy to es=
tablish.
>> We don't want to limit ourselves in terms of language capabilities for t=
his and
>> passing through all the additional infromation Rust carries in the type =
system
>> might not be straight forward.
>>=20
>> It would be an experiment, and it was one of the ideas behind the Rust J=
obqueue
>> to see how it turns if we try. Always with the fallback of having C
>> infrastructure as an alternative when it doesn't work out well.
>
> From previous experience in doing Rust to C FFI in NVK, I don=E2=80=99t s=
ee, at
> first, why this can=E2=80=99t work. But I agree with you, there may very =
well be
> unanticipated things here and this part is indeed an experiment. No argum=
ent
> from me here.
>
>>=20
>> Having this said, I don't see an issue with the drm_dep thing going forw=
ard if
>> there is a path to replacing DRM sched entirely.
>
> The issues I pointed out remain. Even if the plan is to have drm_dep + Jo=
bQueue
> (and no drm_sched). I feel that my point of considering doing it in Rust =
remains.

I mean, as mentioned below, we should have a Rust Jobqueue as independent
component. Or are you saying you'd consdider having only a Rust component w=
ith a
C API eventually? If so, that'd be way too early to consider for various
reasons.

>> The Rust component should remain independent from this for the reasons m=
entioned
>> in [1].
>>=20
>> [1] https://lore.kernel.org/dri-devel/DH51W6XRQXYX.3M30IRYIWZLFG@kernel.=
org/
>
> Ok
>
> =E2=80=94 Daniel

