Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5VyKavj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A2910F0BB;
	Mon, 26 Oct 2026 18:51:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B550C10F0BB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:50:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76EFD4168D;
 Mon, 26 Oct 2026 18:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7EB1F01825;
 Mon, 26 Oct 2026 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793040654;
 bh=ygtj/oT70XXAeLhMLm75r98qmCglsSTArDphuGHAX/I=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=g5VyKavjI10gkagJODkyzZ7acpHi96JPWtvrrCEIoOf0j/94q39dTOYjBSaHIaufR
 rZOMz6RtCkeqybXa3CMUVkqN3djCcvHEymeOW7bjNITIx1Fg2DVjrqw811jKVwfadx
 ynpgABm9tMWmbpwf+6oBxiTTUlT1ChbL9FUwu09PPJZwxTikhlv4/zR8Yww+oWsI7W
 oWgDlAoTK6218Gjx6L1pfOQhAuG7NxLKm+fsnNwr4RYVe3EV+iQUVAgfdix8HJrIVY
 Ht1qd96zVATIbed5OAlKR60dvkYMSqhB5O6CKuMMZPm/uKm+i8RBT99cOE+vWoeLBb
 wx/M0pZ4JsNVQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 19:50:51 +0100
Message-Id: <DMEZV3WOR5TI.GMTG5OXI3WNJ@kernel.org>
Cc: <airlied@redhat.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
In-Reply-To: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 26, 2026 at 5:24 AM CET, Dave Airlie via B4 Relay wrote:
> These aren't used on systems with no framebuffer memory.

Looks good, but I think it would be nice to have some more context in the c=
ommit
message.

Thanks,
Danilo
