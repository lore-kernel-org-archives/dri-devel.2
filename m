Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AF8FD877D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E472110E677;
	Tue, 17 Mar 2026 14:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HnT35TMT";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E13210E675;
 Tue, 17 Mar 2026 14:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773757558; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GadWEUlcojdUNlb5/w4/EcQ6SH+h1bGh8DPIFE9jjZ346Swb3g42g6QO3xsxD36oQVQE50fh8FZtiHaBMa25KSSOFTadtEqrj3rfguP+IReTnCldLjbf2b6593G5eC4gC/sj7q+YvCUWc3ioeHn0TNmj16NDk3jvsH9LAUGERDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773757558;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tt8WteWjbd6fVZa1CqjR1h4UnWjp5UqhSJ+qIwPNGQE=; 
 b=Vg1gGaoUiGvL7vuK/0RAdnCgeYZTU1h3/BtBJRkPzs3PnZhuyiDZ2eLcz8m8fbWhjN3VkqgKwZxkTt5v1atMEOG0J7kiZktHdvJKlKdbVIu/eNyGSh8EYE5ihAFK5jIbKF4wsCAuaNMoD4ftjBU8yy8Y8ChOXd29NWPvtU5Uan8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773757558; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=tt8WteWjbd6fVZa1CqjR1h4UnWjp5UqhSJ+qIwPNGQE=;
 b=HnT35TMTzMLuA9TfcuQTuxM7WDPIbrQ90RG0BOQlExRa5H5r1OFTrOqitq8zOHjl
 gz31huIhsm9Heu5/8EJ/tFD/WBW1M/6XCwE0Mq87eDAfu48w0gWmVHSKBje0marHn9f
 UeCMjiNgaT0sGwl4UxUpXJ1KJ/JydTN7RTjzcUEA=
Received: by mx.zohomail.com with SMTPS id 1773757555465479.0341753244137;
 Tue, 17 Mar 2026 07:25:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DH524YJD4UD3.HLHJP0AM401N@kernel.org>
Date: Tue, 17 Mar 2026 11:25:35 -0300
Cc: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Stone <daniels@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, shashanks@nvidia.com,
 jajones@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <974E3052-FCA8-4985-A37D-A1F49C06A77C@collabora.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <DH524YJD4UD3.HLHJP0AM401N@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 17 Mar 2026, at 09:31, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Tue Mar 17, 2026 at 3:47 AM CET, Daniel Almeida wrote:
>> I agree with what Danilo said below, i.e.:  IMHO, with the direction =
that DRM
>> is going, it is much more ergonomic to add a Rust component with a =
nice C
>> interface than doing it the other way around.
>=20
> This is not exactly what I said. I was talking about the maintainance =
aspects
> and that a Rust Jobqueue implementation (for the reasons explained in =
my initial
> reply) is easily justifiable in this aspect, whereas another C =
implementation,
> that does *not* replace the existing DRM scheduler entirely, is much =
harder to
> justify from a maintainance perspective.

Ok, I misunderstood your point a bit.

>=20
> I'm also not sure whether a C interface from the Rust side is easy to =
establish.
> We don't want to limit ourselves in terms of language capabilities for =
this and
> passing through all the additional infromation Rust carries in the =
type system
> might not be straight forward.
>=20
> It would be an experiment, and it was one of the ideas behind the Rust =
Jobqueue
> to see how it turns if we try. Always with the fallback of having C
> infrastructure as an alternative when it doesn't work out well.

=46rom previous experience in doing Rust to C FFI in NVK, I don=E2=80=99t =
see, at
first, why this can=E2=80=99t work. But I agree with you, there may very =
well be
unanticipated things here and this part is indeed an experiment. No =
argument
from me here.

>=20
> Having this said, I don't see an issue with the drm_dep thing going =
forward if
> there is a path to replacing DRM sched entirely.

The issues I pointed out remain. Even if the plan is to have drm_dep + =
JobQueue
(and no drm_sched). I feel that my point of considering doing it in Rust =
remains.

>=20
> The Rust component should remain independent from this for the reasons =
mentioned
> in [1].
>=20
> [1] =
https://lore.kernel.org/dri-devel/DH51W6XRQXYX.3M30IRYIWZLFG@kernel.org/

Ok

=E2=80=94 Daniel

