Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4FFD874E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE5410E621;
	Tue, 17 Mar 2026 12:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="X4FENUmD";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7190810E621;
 Tue, 17 Mar 2026 12:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773749120; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aSw+ZeQVp4FS3UfPiEqEyugMGGLnaSaQcKspC0AqEmqbwfdQDgP0oaOeHaNNnCKrlwt/EXmXjEKDgqXPft0YiXuFajWf9uXrQEgvGmIHp+3X4+77aR6aVbSaPOwS3/AQJJRUKhYyyle1Q70XL5ZtUPD8pUL6WQmBBxLEzctjYUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773749120;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GPSSGoZxjNOsc4QauRfSOblkZpvnUtKAHmRJMvKZsAA=; 
 b=Wlv55XXfsZgssAYIbW1h4INPe2vnu0Q8aeMUPYt97frytQeAh9cautTk3QBwZdX0vu5z7ZC4laXeRvHIVZwFyqgoy7YmPtWDN4ti91uQ3JsCT4hMvvpMEFR3TFRDHEudFe82+nNvrkRLydzp4a1iuv1iIXTOgT9M+NZYmNRDOkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773749119; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=GPSSGoZxjNOsc4QauRfSOblkZpvnUtKAHmRJMvKZsAA=;
 b=X4FENUmDDmpp9SOgWVEu3f/Z/7wCfsbF1zis/K7TNYTtDLUa6/RSZlIP59UsgTGQ
 LtgQI8CQs5XQxOq52wXMzcNjFKkShLwS2/W4sSfz+gewafma+DfrB6rqxm0JaRifC2m
 blm5iCS7bI9liBo193ndM++QMxWMdK1qt2jx6/Ek=
Received: by mx.zohomail.com with SMTPS id 1773749117110887.5184078065679;
 Tue, 17 Mar 2026 05:05:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
Date: Tue, 17 Mar 2026 09:04:56 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
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
 rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0722F4A2-EDA3-4CF6-A023-65A7EE23497C@collabora.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
 <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
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

Matthew,

> I get it =E2=80=94 you=E2=80=99re a Rust zealot. You can do this in C =
and enforce the
> rules quite well.
>=20
> RAII cannot describe ownership transfers of refs, nor can it express =
who
> owns what in multi-threaded components, as far as I know. Ref-tracking
> and ownership need to be explicit.
>=20
> I=E2=80=99m not going to reply to Rust vs C comments in this thread. =
If you want
> to talk about ownership, lifetimes, dma-fence enforcement, and =
teardown
> guarantees, sure.
>=20
> If you want to build on top of a component that=E2=80=99s been tested =
on a
> production driver, great =E2=80=94 please join in. If you want to =
figure out all
> the pitfalls yourself, well=E2=80=A6 have fun.
>=20
> Matt
>=20

It is not about being a Rust zealot. I pointed out that your code has =
issues.
Every time you access the queue you have to use a special function =
because the
queue might be gone, how is this not a problem?

+ * However, there is a secondary hazard: a worker can be queued while =
the
+ * queue is in a "zombie" state =E2=80=94 refcount has already reached =
zero and async
+ * teardown is in flight, but the work item has not yet been disabled =
by
+ * free_work.  To guard against this every worker uses
+ * drm_dep_queue_get_unless_zero() at entry; if the refcount is already =
zero
+ * the worker bails immediately without touching the queue state.

At various points you document requirements that are simply comments. =
Resource
management is scattered all over the place, and it=E2=80=99s sometimes =
even shared
with drivers, whom you have no control over.

+ * Drivers that set %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED and wish to
+ * serialise their own submit work against the bypass path must acquire =
this
+ * guard.  Without it, a concurrent caller of drm_dep_job_push() could =
take
+ * the bypass path and call ops->run_job() inline between the driver's
+ * eligibility check and its corresponding action, producing a race.

How is this not a problem? Again, you=E2=80=99re not in control of =
driver code.

+ * If set, the driver is responsible for freeing the job. If NULL,

Same here.

Even if we take Rust out of the equation, how do you plan to solve these =
things? Or
do you consider them solved as is?

I worry that we will find ourselves again at XDC in yet another =
scheduler
workshop to address the issues that will invariably come up with your =
new
design in a few years.

> If you want to build on top of a component that=E2=80=99s been tested =
on a
> production driver, great =E2=80=94 please join in. If you want to =
figure out all
> the pitfalls yourself, well=E2=80=A6 have fun.

Note that I didn=E2=80=99t show up with a low-effort =E2=80=9Chey, how =
about we rewrite
this in Rust?=E2=80=9D. Instead, I linked to an actual Rust =
implementation that I
spent weeks painstakingly debugging, not to mention the time it took to =
write
it. Again, I suggest that you guys have a look, like I did with your =
code. You
might find things you end up liking there.=20

=E2=80=94 Daniel



