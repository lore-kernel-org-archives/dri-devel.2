Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BC2CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472ED10E25D;
	Sun, 11 Oct 2026 17:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZzUdYaKb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECA410E25D
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:47:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDC1E600E2;
 Sun, 11 Oct 2026 17:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC861F0089B;
 Sun, 11 Oct 2026 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791740870;
 bh=NumRxj5nsjPQ2mUuE1Nu27M0FMXAMpyMLjw9oLTHqwc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZzUdYaKb9oNhPFw/Movj0iB88/zVujOF3gYzXkvjMo8yOk4fk9XZF1nXS5LjEHCLj
 4VF2ih22YvMLgWjsYAp0Z7bAW9+4KyBzvu09h2DcLaqWazQoAiH6fuJpy3QZCkN6jk
 zXwP2/+/gvNj8OfEjEMFVnTMhhnjtIRXc1tQEWnwYh+Hxn15lUqxX+GebVkVMbTOK5
 fIdLlIzEmO6Ov7dOIraViTADDqIL50LTlWOBWDR8cMjxtDIaIAHG3gguJOKeF+RtJ3
 scBWSJ60EH5GITyhYM2WitVUnwFAS81ejlURuVznuOvP3Pp/+Fyfk9ctHTEBV9c5+A
 u8s9GuFVbKvbg==
Message-ID: <sashiko-outbox-167357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/8] drm/panthor: Add performance counter uAPI
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:47:49 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/panthor: missing output handle field in PERF_SESSION_CREATE UA=
PI
--

commit 94c846a97bea171800cf5afb9d2812fd54ce5a02
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Add performance counter uAPI

This commit extends the DEV_QUERY ioctl and introduces the new
DRM_PANTHOR_PERF_SESSION ioctls to allow for the sampling of performance
counters. It adds several structures to map user buffers and configure
the counter sessions.

> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
[ ... ]
> +/**
> + * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANT=
HOR_PERF_SESSION_CREATE.
> + */
> +struct drm_panthor_perf_session_create {
> +	/**
> +	 * @block_set: Set of performance counter blocks, member of
> +	 *             enum drm_panthor_perf_counter_set.
> +	 *
> +	 * This is a global configuration and only one set can be active at a t=
ime. If
> +	 * another client has already requested a counter set, any further requ=
ests
> +	 * for a different counter set will fail and return an -EBUSY.
> +	 *
> +	 * If the requested set does not exist, the request will fail and retur=
n an -EINVAL.
> +	 *
> +	 * Some sets have additional requirements to be enabled, and the setup =
request will
> +	 * fail with an -EACCES if these requirements are not satisfied.
> +	 */
> +	__u8 block_set;
> +
> +	/** @pad: MBZ. */
> +	__u8 pad[7];
> +
> +	/** @fd: eventfd for signalling the availability of a new sample. */
> +	__u32 fd;
> +
> +	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. =
*/
> +	__u32 ringbuf_handle;
> +
> +	/**
> +	 * @control_handle: Handle to the BO containing a contiguous 16 byte ra=
nge, used for the
> +	 * insert and extract indices for the ringbuffer.
> +	 */
> +	__u32 control_handle;

[Severity: High]
Does this structure need a __u32 handle output field to return the created
session identifier to userspace?

It appears that this UAPI returns the newly allocated session ID directly v=
ia
the ioctl's integer return value rather than writing it back to an output
field in this struct.

Returning positive values from ioctls can cause standard DRM wrappers, such=
 as
libdrm's drmIoctl(), to misinterpret the positive return value as an error
code, which might render the API unusable for those clients.

Additionally, the core drm_ioctl() function prints a debug warning for any
non-zero ioctl return value. Could this cause every successful session
creation to spam the kernel debug log with false errors?

> +
> +	/**
> +	 * @sample_slots: The number of slots available in the userspace-provid=
ed BO. Must be
> +	 * a power of 2.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-panthor-pe=
rformance-counters-v7-0-12c32495062f@arm.com?part=3D1
