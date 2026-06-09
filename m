Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095E4CD98C5
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD3610E390;
	Tue,  9 Jun 2026 15:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TGK5LE6p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8609810E390
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:50:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B03A560200;
 Tue,  9 Jun 2026 15:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E901F00898;
 Tue,  9 Jun 2026 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781020238;
 bh=McbuzhZwCbiuQ38U0aq7g+Id45jAA/VUyV9mxpAaDEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TGK5LE6pyE3kclNpDOVZzhr2neWm14Agx+F0oHV0srWBwHDxx8Hq3OBhQ+J30ieGB
 3UYus/xEFD3P23y5hkJLWnI8AWX2O1KwPkFcMLkPidvexr4Yicj4f/VKE3U+Xt1Dtr
 AgVcuToq9IvGxXezpjXhtI/1UnVDxQ/asTXZ7lI8cDkZ+FfIf1hwFyrPZ18f8+HgrV
 ikXr5lxYSaDtaxl3ljlZjdDwC6j/QojDEpk2PQIYI4Ehg6VBOWyHSzGmeDIGZpR0y0
 RmaOipWTemigqihIX9dqKxhpW7/3x+Dvg7FmgHX7dUBcFDXQ1of0VznzHVgIEkqUZQ
 emDDkCJxe82rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-rust-barrier-v2-3-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-3-30fcc48e1cd0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:50:37 +0000
Message-Id: <20260609155038.20E901F00898@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing sequence number validation allows mismatched RPC replies t=
o be accepted after a timeout.
--

commit 0c5cf61612018cf7b218d6031a8329297e4ac9dc
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: fix barrier usage in CPU->GSP messaging path

This commit fixes the barrier usage in the CPU->GSP messaging path. It
clarifies the LOAD->STORE ordering dependency and moves the STORE->STORE
barrier to immediately before the write pointer advance to prevent the GSP
from observing an advanced pointer before the command is fully written.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 070de0731e950..94c2790d943d0 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the
messaging path, I noticed a potential issue with sequence number
validation.

If a previous command times out in Cmdq::send_command():

drivers/gpu/nova-core/gsp/cmdq.rs:Cmdq::send_command() {
    ...
    loop {
        match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
            Ok(reply) =3D> break Ok(reply),
            Err(ERANGE) =3D> continue,
            Err(e) =3D> break Err(e),
        }
    }
    ...
}

The timeout returns ETIMEDOUT and drops the command queue lock, but the
delayed reply might eventually arrive and remain in the message queue.

When another command with the same function code is subsequently sent,
CmdqInner::receive_msg() validates the incoming message:

drivers/gpu/nova-core/gsp/cmdq.rs:CmdqInner::receive_msg() {
    ...
    let result =3D if function =3D=3D M::FUNCTION {
        let (cmd, contents_1) =3D M::Message::from_bytes_prefix(...
    ...
}

Does this code incorrectly accept the stale reply as a successful response
because it only checks if function =3D=3D M::FUNCTION?

Could this break RPC protocol synchronization and cause the driver to
process incorrect payload data? Should the sequence number be validated
(e.g., via header.sequence()) to prevent mismatched replies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-rust-barri=
er-v2-0-30fcc48e1cd0@garyguo.net?part=3D3
