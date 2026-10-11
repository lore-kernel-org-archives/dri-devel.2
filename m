Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6909CA9ECA
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 00:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2594310E0A3;
	Sun, 11 Oct 2026 00:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="i1bSzKdE";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11E510E0A3
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791678148; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RtJ+Y5yFVjFpWdC4PqXJ7qZsJRqt8s6mwjSC0jSNde3JeYg219d/VgxrUKF8IAf3bxHe95paI5drCSe/jLqlJQCwF/6bYhAohXQPunz1GKUr+BsQd8G/nynoLf1rtVP74bcs134HxJOX/cNib4k8dU5H7hgAIUHR6tFmcLTcwpE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791678148;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=41dPddWoQKnpWMYRbAvh5x0oiXREGVQ4pqzdMYi7w6A=; 
 b=Veop6pQhMd+18pin7jk2NMYmbcPRgtECUcTTV/a9KOkS2qDWYPcdO7gHXjOxJqn5KMMlMaPVBd1mKrb6VqfmtUzKz75CNhPJy1tjmVOmftgZsmT+AWU0DlM7eVVrInQpDabyDMfdj3UmvsnQyWFnqb43asqy5V4jLoAsGaPDxDs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791678148; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=41dPddWoQKnpWMYRbAvh5x0oiXREGVQ4pqzdMYi7w6A=;
 b=i1bSzKdEqE/viofxpvNNSpKDshCMhnIEq1x9CfVhyWXrx8UtAC5hT/f322iQi9Ru
 XoukuCzrdcAcQ2apBzDoBeljfkSo7mzKO20Aiyzd6hq1NZxpyTUB9DmiIQhN18wO+yV
 NE0Sfm0cZf/lMw21NX2dKZ6tJWpVYjZFgfqmVn9Q=
Received: by smtp.zohomail.com with SMTPS id 1791678146138728.6489422256464;
 Sat, 10 Oct 2026 17:22:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [RFC PATCH v5 0/6] rust: Add drm::JobQueue
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261009191124.1022902-2-phasta@kernel.org>
Date: Sat, 10 Oct 2026 21:22:07 -0300
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>, John.harrison@igalia.com,
 da.gomez@kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F09C7397-AF97-4947-89D5-759498BCF7B0@collabora.com>
References: <20261009191124.1022902-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
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

Hi Philipp,

> On 9 Oct 2026, at 16:11, Philipp Stanner <phasta@kernel.org> wrote:
>=20
> Changes in v5:
>  - Add back the Revocable<JobQueueInner=E2=80=A6> from my earliest =
RFCs. Reason
>    is still the same: JQ dropping while dependency fences signal could
>    deadlock. Similarly, this solves a dependency kicking of the work
>    item again while drop() is running.

Can you expand a bit on this? IIUC the problem is introduced by trying =
to take
the jq lock on signal? If so, this could be avoided by queuing the =
worker from
that path instead?

>  - Do not call run_job() with a lock held, since run_job() might =
sleep.
>    AFAICS, this also makes the proposed XArray solution impossible and
>    demands that we use a list.

Can you expand on this a bit?

>  - Re-add the earlier credit-count-system, so that run_job() is
>    infallible. Simplifies the design quite a bit. (Danilo)

What is AGX=E2=80=99s position on this? IIRC, this credit system could =
not represent
their submission model exactly, like it can for others.


>  - Drop jobs in a deferred manner through the work item so that job
>    payload data can do atomic-hostile stuff.
>  - Because of the point above, I suggest that we stop dropping a
>    DriverFence on signal (Danilo's and my idea). It has no real
>    advantage, and getting rid of it allows for better controlling what
>    drops when through JobQueue. For fence it's only relevant that =
there
>    is an RCU grace period, thus:
>  - Replace DriverFence::drop()'s call_rcu() with synchronize_rcu(). We
>    would, therefore, demand that everyone who's got a problem with the
>    delay drops via work item.

I will get back to you.

>=20
> This can still not be tested as I'm blocked by pin-init vs self-ref.
> Just FYI.
>=20
> I would appreciate confirmation of these following thoughts on locking
> design:
>=20
> 1.
> I believe that callers of jq.new_job() and jq.submit_job() do not need
> an outer serialization mutex. Reason is that JQ serializes with its
> internal lock. Sequence numbers cannot take over older seqnos because =
it
> is submit_job() who sets the seqno.

I guess this makes sense, so long as submit_job() doesn=E2=80=99t take =
&mut self?

Also, submit_job() assigning seqnos is not compatible with the XArray =
IIRC.
Fine if going with lists, I suppose.


>=20
> 2.
> I, furthermore, believe that a driver will not need to hold a
> driver-lock while calling jq.complete_jobs_up_to_seqno().

In tyr, we hold _no_ locks. The driver signals the fences, and this will
enqueue the worker thread.

>=20
> IOW, I am suggesting that a driver can always safely use JQ without an
> outer lock, and actually *should* do so to avoid potential locking
> issues.
>=20
> Reason:
>=20
> let driver_stuff =3D foo.lock();
> let current_gpu_seqno =3D driver_stuff.get_seqno();
> drop(driver_stuff);
> jq.complete_jobs_up_to_seqno(current_gpu_seqno);
>=20
> Thus, I believe that it is OK for me to take the JQ lock in
> jq.complete_jobs_up_to_seqno().
>=20
> Please correct me if I'm missing something.
>=20
> Should I be wrong and a lock inversion could occur, then we could
> hypothetically add a fence Signaler object, with which we could signal
> fences with a different lock. Similar to how drm_sched does it with =
the
> hardware_fence.
>=20
>=20
> Regards
> P.
>=20
>=20

I will have a more thorough look this week :)

=E2=80=94 Daniel


