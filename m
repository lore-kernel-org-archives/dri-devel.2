Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD560606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3HeTkAs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E1510E7BB;
	Tue,  3 Nov 2026 07:49:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B705910F3D3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:49:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B8CB6062C;
 Tue,  3 Nov 2026 07:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B9C1F000C1;
 Tue,  3 Nov 2026 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692166;
 bh=VsXaq/BufuxLG257nX4jKshzj3abwXkxkvCfU1X779I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E3HeTkAs66th0EGqbWsPtmg2to5nF1l8jEBpDfE9MPUde14nVI4/pApn24G2cCUgy
 HBHlu+Ejs4k+kJMddXVYBswtg5yMKiRtT2+xYXqGElHxwvSgrwFOdYNrjrDGvi/otn
 IhiQvEJPFx4BaOlrxXoOeppwFY30+8mSXxi6N7O9s6FlsJp3QL/a01lyBcrD2cdygp
 vzbiqu4CUFotZ3PVWBzsPfJRe1II7na/C/SmVL9ogV8LJLnmTbaIGKwOgJZ6GfuBeX
 XKXDVufyKDQmdKXulSpjbzBXznZ6dwPpk1oONXM62N7sGIP+53u/nREan/DIFFUb+m
 +Ut7/bKILVuAA==
Message-ID: <sashiko-outbox-194745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 10/13] media: uapi: cec.h: add
 CEC_EVENT_FL_STATE_EDID_PRESENT flag
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <215493fe7ce132b19dc109f0fa83d3bd2c081d2b.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <215493fe7ce132b19dc109f0fa83d3bd2c081d2b.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:49:26 +0000
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
- [Medium] media: cec: CEC_EVENT_FL_STATE_EDID_PRESENT is unimplemented and=
 undocumented
--

commit 91b7ee167841223aaa68aad5f0bc8e5da032f2c4
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: uapi: cec.h: add CEC_EVENT_FL_STATE_EDID_PRESENT flag

This commit adds the CEC_EVENT_FL_STATE_EDID_PRESENT event flag to
include/uapi/linux/cec.h to report whether the EDID is present.

> diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
> index fdfc97a6e4ec0..051125a446933 100644
> --- a/include/uapi/linux/cec.h
> +++ b/include/uapi/linux/cec.h
> @@ -453,6 +453,7 @@ struct cec_connector_info {
> =20
>  #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
>  #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)
> +#define CEC_EVENT_FL_STATE_EDID_PRESENT	(1 << 2)

[Severity: Medium]
Is part of this change missing from the commit?

CEC_EVENT_FL_STATE_EDID_PRESENT is added to include/uapi/linux/cec.h,
but nothing in the kernel ever references or sets it when queuing
CEC_EVENT_STATE_CHANGE events. Specifically, neither
cec_post_state_event() in drivers/media/cec/core/cec-adap.c:

    static void cec_post_state_event(struct cec_adapter *adap)
    {
            struct cec_event ev =3D {
                    .event =3D CEC_EVENT_STATE_CHANGE,
            };

nor cec_open() in drivers/media/cec/core/cec-api.c:

    struct cec_event ev =3D {
            .event =3D CEC_EVENT_STATE_CHANGE,
            .flags =3D CEC_EVENT_FL_INITIAL_STATE,
    };

sets CEC_EVENT_FL_STATE_EDID_PRESENT, so userspace applications
dequeuing struct cec_event via ioctl CEC_DQEVENT after opening a CEC
device or receiving an adapter state change notification will always
observe the flag as 0 even when a valid EDID is present.

In addition, Documentation/userspace-api/media/cec/cec-header.rst
parses include/uapi/linux/cec.h with :generate-cross-refs:,
:exception-file: cec.h.rst.exceptions, and :warn-broken:. Because
CEC_EVENT_FL_STATE_EDID_PRESENT is neither documented in the
cec-event-flags table in
Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst nor listed in
Documentation/userspace-api/media/cec/cec.h.rst.exceptions, does
running make htmldocs emit a broken cross-reference warning for
cec-event-fl-state-edid-present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/215493fe7ce132b19dc=
109f0fa83d3bd2c081d2b.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
