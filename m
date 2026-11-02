Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqEp39Or
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A247D10ED08;
	Mon,  2 Nov 2026 11:14:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2736610ED08
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:14:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1769360DBF;
 Mon,  2 Nov 2026 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917E71F00A16;
 Mon,  2 Nov 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793618048;
 bh=rWEB2AIcHLZAE03nNDZwQOxaCv3vptr9wstyectKZNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iqEp39OrPmrisob/qFiZl41kCEpRx9LvzUQnBU7V7owSw3f0RRKc8eUTnxCPeMmo2
 jQyUkBYVG8ESrn+TKCqEG7r0bIroi3o/XO5i3plvWoDQuniOWgdyScNULRLNBP1sqk
 FUTsviC2nLlWNJ5HxEBPD4hg1MrY88Zsp3pYkEtmT4Q672in5J1IEH2IgCmOGUg0QP
 ErBnAxA5tj5kIC26SgiG1VKF1MI8rVhGVk3AiEmQthXhRw+JuFMxVI1ADldjQl9K3L
 e2w74/LeAfW8XVLVYjL9cBDXs33ah6t7YSL/DhNgw255UGvovITaXafyHj8Ke5Fxv9
 3888g6ojFJYSw==
Message-ID: <sashiko-outbox-193323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] media: cec: core: implement
 CEC_EVENT_FL_STATE_EDID_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <e5ad86f5e6a33e6b9c1b930a00c984f49eb316eb.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <e5ad86f5e6a33e6b9c1b930a00c984f49eb316eb.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:14:08 +0000
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
- [Medium] media: cec: missing CEC_EVENT_FL_STATE_EDID_PRESENT in cec_open()
--

commit 46a7f75b89b8be5b867c7e7aadb50668719e461a
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: implement CEC_EVENT_FL_STATE_EDID_PRESENT

This commit sets CEC_EVENT_FL_STATE_EDID_PRESENT on CEC_EVENT_STATE_CHANGE
events in cec_post_state_event() when CEC_LOG_ADDRS_FL_EDID_PRESENT is set
in adap->log_addrs.flags.

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index 06a596a0ede3e..c0de5835fea01 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -323,6 +323,8 @@ static void cec_post_state_event(struct cec_adapter *=
adap)
>  	ev.state_change.log_addr_mask =3D adap->log_addrs.log_addr_mask;
>  	ev.state_change.have_conn_info =3D
>  		adap->conn_info.type !=3D CEC_CONNECTOR_TYPE_NO_CONNECTOR;
> +	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT)
> +		ev.flags |=3D CEC_EVENT_FL_STATE_EDID_PRESENT;
>  	cec_queue_event(adap, &ev);
>  }

[Severity: Medium]
Should the initial CEC_EVENT_STATE_CHANGE event queued in cec_open() also
set CEC_EVENT_FL_STATE_EDID_PRESENT when an EDID is already present?

In drivers/media/cec/core/cec-api.c, cec_open() constructs the initial state
event directly:

drivers/media/cec/core/cec-api.c:cec_open() {
	struct cec_event ev =3D {
		.event =3D CEC_EVENT_STATE_CHANGE,
		.flags =3D CEC_EVENT_FL_INITIAL_STATE,
	};
	...
	/* Queue up initial state events */
	ev.state_change.phys_addr =3D adap->phys_addr;
	ev.state_change.log_addr_mask =3D adap->log_addrs.log_addr_mask;
	ev.state_change.have_conn_info =3D
		adap->conn_info.type !=3D CEC_CONNECTOR_TYPE_NO_CONNECTOR;
	cec_queue_event_fh(fh, &ev, 0);
}

When userspace opens a CEC device node while adap->log_addrs.flags has
CEC_LOG_ADDRS_FL_EDID_PRESENT set and dequeues the initial state event via
CEC_DQEVENT, ev.flags will be missing CEC_EVENT_FL_STATE_EDID_PRESENT.

Also note that under CONFIG_CEC_PIN, cec_open() reuses the same ev variable
to queue initial CEC_EVENT_PIN_HPD_HIGH/LOW and CEC_EVENT_PIN_5V_HIGH/LOW
events, so if CEC_EVENT_FL_STATE_EDID_PRESENT is set on ev.flags for the
initial state change event, it would need to be cleared before queueing the
pin events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D12
