Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A7606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEIpKjUj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDAF1121AA;
	Thu,  5 Nov 2026 07:35:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B451121AA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:35:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 172EF41B52;
 Thu,  5 Nov 2026 07:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0151F00A18;
 Thu,  5 Nov 2026 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864145;
 bh=dM/XiQa4ubfJtThi41cw4YF4oUMSNdps4oWTOC8RNbw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WEIpKjUjh+pGstfbuIpZNo/66PTa9gnHbIUQd9JUCa28Br44V1otmQ78XVsWxtoOo
 w3nrXGWu+iUqAQXsy/U1iKNH4SYtcIcTd4G6dESt0wlT/2bpqkw+dBfKdxKLf9D5+n
 Bo95E1VG1lBeGj4bHOdFyK4hJF9RRVyAnC+wggnUWYYNUK5O6rHnDqs1pxFOXs2hJE
 ZxGlxusmg2uD43RQtLGRt+8d8sbXtUqCwkY3qjY33CzXEM9pzOfLIYrIkKrU/ZPMuN
 0pxTRs9FrK6O+zTQBuV0w7u/Bdi51bHPnUrlc0fAtd0dDmRjQg3yngCVSx/7flYWzk
 eBKlTprrAmGSQ==
Message-ID: <sashiko-outbox-198683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 10/13] media: uapi: cec.h: add
 CEC_EVENT_FL_STATE_HPD_PRESENT flag
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <81a832c5568748e37f081d217998f80880ab8dc4.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <81a832c5568748e37f081d217998f80880ab8dc4.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:35:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] media: cec: unimplemented and undocumented CEC_EVENT_FL_STATE_HP=
D_PRESENT flag
--

commit 6f18f1544823dafcf8a17b474c711348256f2340
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: uapi: cec.h: add CEC_EVENT_FL_STATE_HPD_PRESENT flag

This commit adds the CEC_EVENT_FL_STATE_HPD_PRESENT flag to
include/uapi/linux/cec.h to report whether HPD is present.

> diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
> index fdfc97a6e4ec0..d9300a6010806 100644
> --- a/include/uapi/linux/cec.h
> +++ b/include/uapi/linux/cec.h
> @@ -453,6 +453,7 @@ struct cec_connector_info {
> =20
>  #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
>  #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)
> +#define CEC_EVENT_FL_STATE_HPD_PRESENT	(1 << 2)

[Severity: Medium]
The commit message states that CEC_EVENT_FL_STATE_HPD_PRESENT will report
whether HPD is present or not, but nothing in the kernel ever sets or
references this flag.

When userspace dequeues CEC_EVENT_STATE_CHANGE events via CEC_DQEVENT, the
events are populated in cec_post_state_event() in
drivers/media/cec/core/cec-adap.c:

	struct cec_event ev =3D {
		.event =3D CEC_EVENT_STATE_CHANGE,
	};

and on device open in cec_open() in drivers/media/cec/core/cec-api.c:

	struct cec_event ev =3D {
		.event =3D CEC_EVENT_STATE_CHANGE,
		.flags =3D CEC_EVENT_FL_INITIAL_STATE,
	};

Neither path sets CEC_EVENT_FL_STATE_HPD_PRESENT in ev.flags, so any
application checking ev.flags & CEC_EVENT_FL_STATE_HPD_PRESENT will always
observe 0.

In addition, Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
(under the CEC Event Flags table) and include/uapi/linux/cec.h do not
document CEC_EVENT_FL_STATE_HPD_PRESENT or specify which CEC_EVENT_* types
carry it.

Finally, without a corresponding capability flag or tri-state indicator
(unlike struct cec_event_state_change.have_conn_info, which is gated by
CEC_CAP_CONNECTOR_INFO), how can userspace distinguish between HPD being
low, a CEC driver that does not report HPD state, and an older kernel that
predates CEC_EVENT_FL_STATE_HPD_PRESENT? Should this UAPI definition be
held back until an in-kernel user, documentation, and capability signaling
are included?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/81a832c5568748e37f0=
81d217998f80880ab8dc4.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
