Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3145DCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8221010E64B;
	Tue, 26 May 2026 16:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Isf0AQex";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1368E10E6D8
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779813390; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q1mjqmDRXQBJ9UnE09fB7WIVsaDY2NOIivd7MnqmH287x0ggU5IXnzT5pPtmTTzZj14KaQdfkZf97T+zc1K6O6Z7KOe6yxUlJe2bmw3xgdWpvB30LTe7NkxKyBTpg0bgw+iwuGTdwZtuaJ8nHmpDPeAmErJKrZaXBtqWK0GLKaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779813390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=V1Y8Qh6mitTx4NX5Mx6U9ei3R+n3NEvxuCei133kMXI=; 
 b=TlebiAZjorsGDG+ot0dYPdhBdnZlv4+bNd8sON37rvozKDQAzI8hv5p+6Bc12GFdULX2tRI2gwf9MS9fJDeAPcom4c8eqekMAAV2ClM/DzAa5NFw8jS1lABcLCDjc+mozKivI+2yLkQC5FTdyamsjZuuwkFiozPrCmtlSkv5sC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779813390; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=V1Y8Qh6mitTx4NX5Mx6U9ei3R+n3NEvxuCei133kMXI=;
 b=Isf0AQexepKpwQVcebDrBqA8KwKvnCQIpcDtyHAm6cOAt7hj8snXpRFJmk2JdgFV
 d3JfG5BnpGW88xILkkxvhdOt41KkSylfvDsgEcL6UPzQrW337dzhjyZV4odkKXG2J2r
 XViQo2AAKIw2aO0DouDXqKpJ/VGaSaKGWUAtJ5QA=
Received: by mx.zohomail.com with SMTPS id 1779813389125208.9739422841859;
 Tue, 26 May 2026 09:36:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 dri-devel@lists.freedesktop.org, Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: nd@arm.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Mihail Atanassov <mihail.atanassov@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: Re: [PATCH v6 4/7] drm/panthor: Introduce sampling sessions to handle
 userspace clients
Date: Tue, 26 May 2026 18:36:22 +0200
Message-ID: <qNyBEQ6rTuGUNU0cUjgOqA@collabora.com>
In-Reply-To: <20251215171453.2506348-5-lukas.zapolskas@arm.com>
References: <20251215171453.2506348-1-lukas.zapolskas@arm.com>
 <20251215171453.2506348-5-lukas.zapolskas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hello,

I know I'm a bit late, but I've found a bug.

On Monday, 15 December 2025 18:14:50 Central European Summer Time Lukas Zapolskas wrote:
> To allow for combining the requests from multiple userspace clients,
> an intermediary layer between the HW/FW interfaces and userspace is
> created, containing the information for the counter requests and
> tracking of insert and extract indices. Each session starts inactive
> and must be explicitly activated via PERF_CONTROL.START, and
> explicitly stopped via PERF_CONTROL.STOP. Userspace identifies a
> single client with its session ID and the panthor file it is
> associated with.
> 
> The SAMPLE and STOP commands both produce a single sample when called,
> and these samples can be disambiguated via the opaque user data field
> passed in the PERF_CONTROL uAPI. If this functionality is not desired,
> these fields can be kept as zero, as the kernel copies this value into
> the corresponding sample without attempting to interpret it.
> 
> Currently, only manual sampling sessions are supported, providing
> samples when userspace calls PERF_CONTROL.SAMPLE, and only a single
> session is allowed at a time. Multiple sessions and periodic sampling
> will be enabled in following patches.
> 
> No protection is provided against the 32-bit hardware counter
> overflows, so for the moment it is up to userspace to ensure that
> the counters are sampled at a reasonable frequency.
> 
> The counter set enum is added to the uapi to clarify the restrictions
> on calling the interface.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_perf.c | 706 ++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_perf.h |  16 +
>  2 files changed, 716 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index 3a65d6d326e8..cea8f678c4e1 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> [ ... snip ...]
> +
> +static int session_destroy(struct panthor_perf *perf, struct panthor_perf_session *session)
> +{
> +	session_put(session);
> +
> +	return 0;
> +}
> +
> +static int session_teardown(struct panthor_perf *perf, struct panthor_perf_session *session)
> +{
> +	if (test_bit(PANTHOR_PERF_SESSION_ACTIVE, session->state))
> +		return -EINVAL;
> +
> +	if (READ_ONCE(session->pending_sample_request) != SAMPLE_TYPE_NONE)
> +		return -EBUSY;
> +
> +	return session_destroy(perf, session);
> +}
> +
> +/**
> + * panthor_perf_session_teardown - Teardown the session associated with the @sid.
> + * @pfile: Open panthor file.
> + * @perf: Handle to the perf control structure.
> + * @sid: Session identifier.
> + *
> + * Destroys a stopped session where the last sample has been explicitly consumed
> + * or discarded. Active sessions will be ignored.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_teardown(struct panthor_file *pfile, struct panthor_perf *perf, u32 sid)
> +{
> +	int err;
> +	struct panthor_perf_session *session;
> +
> +	xa_lock(&perf->sessions);
> +	session = __xa_erase(&perf->sessions, sid);

This also needs to check for !session. __xa_erase will return NULL
on a bogus `sid`, and the ioctl handler doesn't actually check if
the `sid` userspace passed in is still around.

A simple

	if (!session) {
		xa_unlock(&perf->sessions);
		return -EINVAL;
	}

did the trick for me.

Kind regards,
Nicolas Frattaroli

> +
> +	if (xa_is_err(session)) {
> +		err = xa_err(session);
> +		goto restore;
> +	}
> +
> +	if (session->pfile != pfile) {
> +		err = -EINVAL;
> +		goto restore;
> +	}
> +
> +	session_get(session);
> +	xa_unlock(&perf->sessions);
> +
> +	err = session_teardown(perf, session);
> +
> +	session_put(session);
> +
> +	return err;
> +
> +restore:
> +	__xa_store(&perf->sessions, sid, session, GFP_KERNEL);
> +	xa_unlock(&perf->sessions);
> +
> +	return err;
> +}
> +
> [... snip ...]




