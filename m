Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FFCC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92FE10E172;
	Thu, 30 Jul 2026 13:46:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com
 [216.40.44.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4198C10E172
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:46:24 +0000 (UTC)
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay01.hostedemail.com (Postfix) with ESMTP id A53B61C002E;
 Thu, 30 Jul 2026 13:46:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf14.hostedemail.com (Postfix) with ESMTPA id ED8A730; 
 Thu, 30 Jul 2026 13:46:15 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:46:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 3/3] drm/panthor: Add tracepoints for cache flushing
Message-ID: <20260730094653.79a70984@gandalf.local.home>
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-3-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-3-28790478bfff@collabora.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: ED8A730
X-Stat-Signature: 3xr5ty19me8uo1wzcdtakdfie6ne5zbr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Bhw59kfzQNPYkQwBWz54jtK4XcY5E/m8=
X-HE-Tag: 1785419175-148380
X-HE-Meta: U2FsdGVkX1/jpwT1TskgL/8RkTmgJSSA3mdbrwMWlIjuDJFHRIZ5QR/uiaEn8JgKY004bDZcowteBf7bEcqREBxJSC3irRFP5pqk4Ey10TuifZZpGJs9zul/zUAuC9Ut35duWPHzq4pIm6olTl8Zd4mDCbXu0zv3FW+cyzDjs8QNPbfh675GLmTjFkh0dPM30xzLKrPGodLDE+MNw3aFbCnhK3NsDFNvBQ3F8Uu8/4n5FWpEoz91c4rWPi1FCO/7WLmgHEfW3JEHtmI3zKk7Jxc5Y2PChRVAxWzGJArJGXSSoIgs74h6XJv4X0SrAYJN3z9Fk7IVBZly/b1Sgja5zrgqH6796bBR6sERLQspUmJth25u9Kz1FA/g8YrwB/wusoBxTXBg6X0Nt1PbJP5CBZoE1GjvkuTVqIoSE5fHLR8Ew8AbygxDC0GT0Lb7pLCb
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

On Thu, 30 Jul 2026 13:45:16 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> Add two new event tracepoints: gpu_cache_flush_start to be emitted after
> acquiring the flush mutex and reqs spinlock, and gpu_cache_flush_end to
> be emitted when leaving the function.
>=20
> This allows debugging the duration a flush takes irrespective of initial
> function entry lock contention by subtracting the start tracepoint's
> timestamp from the end tracepoint timestamp, and additionally contains
> information such as which caches were flushed.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c   |  3 ++
>  drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 52 insertions(+)

=46rom the tracing point of view:

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
