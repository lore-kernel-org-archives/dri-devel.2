Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC53C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB6D10EFB7;
	Thu, 23 Jul 2026 07:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GgMt6jaw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B468D10EFB5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09EF1600AB;
 Thu, 23 Jul 2026 07:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB9D1F000E9;
 Thu, 23 Jul 2026 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784790412;
 bh=rTzF78gpKM0WOaikT+l6GwHYtcuigFZW7oXSbpp8dOU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GgMt6jawVtlwsRHLcRFrkZzVODAcXlvIzzmXL2rnOOHmv+zENq+huYsZRbav8nBo8
 RTlOef7PP8v1qEPdjDAaR+cqeWgErUmN5ymaLdG6K6Hz1cav7nx9rk5ox2WxN7dZlQ
 9dyx/Ud6pQ2duSPndtnt6dwx1GzITKShDCN2YMBgioWLx8P7iJPcX8jqpgkFbzMwjm
 YbpgWJSGI94kVCg5zNGAWWjsXIkFQgjvSw4VRwgtxCPni2ftrRFLO/x8rE2ZCes0Yq
 IJebc0zu7Y37MjF1KCE6hjgnPpzKJqkRX59JrQfF6S5FW7dfGFw4Ffw6QFCkmObuvv
 iKvhQeOQxmTTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: nova-core: fix packed registry table size
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
References: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:06:48 +0000
Message-Id: <20260723070652.6DB9D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing memory barrier before write pointer update allows GSP to r=
ead stale command data.
- [High] Unrelated asynchronous messages are silently dropped while waiting=
 for a command reply or initialization event.
--

--- Patch [1]: [PATCH] gpu: nova-core: fix packed registry table size ---
commit 7a27da8622da09265a549e78737e3707931209c2
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: fix packed registry table size

PACKED_REGISTRY_TABLE::size describes the entire table, including its
fixed-size header. SetRegistry currently initializes it with only the
variable payload length, omitting the 8 bytes header.

Fix this by using CommandToGsp::size to obtain the actual command
size, including its header.

Fixes: 19b0a6e7c2be ("gpu: nova-core: gsp: Add SetRegistry command")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260722075253.B6DDB1F00A3D@smtp.kernel.o=
rg
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index 08380de39048a..0f8bd77acddf7 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -115,10 +115,7 @@ impl CommandToGsp for SetRegistry {
>      type InitError =3D Infallible;
> =20
>      fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        Self::Command::init(
> -            self.entries.len() as u32,
> -            self.variable_payload_len() as u32,
> -        )
> +        Self::Command::init(self.entries.len() as u32, self.size() as u3=
2)
>      }
> =20
>      fn variable_payload_len(&self) -> usize {

[Severity: High]
This isn't a bug introduced by this patch, but looking at advance_cpu_write=
_ptr()
in drivers/gpu/nova-core/gsp/cmdq.rs:

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_write_ptr() {
        MsgqTxHeader::set_write_ptr(tx, wptr);

        // Ensure all command data is visible before triggering the GSP rea=
d.
        fence(Ordering::SeqCst);
}

Does the fence(Ordering::SeqCst) need to be placed before set_write_ptr()?

Since it is executed after the write pointer update, could a weakly ordered
architecture reorder the payload stores to become globally visible after the
pointer update, allowing the GSP to read stale or zeroed command data?

[Severity: High]
This is a pre-existing issue, but in drivers/gpu/nova-core/gsp/cmdq.rs,
receive_msg() unconditionally advances the read pointer even when returning
ERANGE for an unmatched message:

drivers/gpu/nova-core/gsp/cmdq.rs:receive_msg() {
        ...
        } else {
            Err(ERANGE)
        };

        // Advance the read pointer past this message.
        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
            message.header.length().div_ceil(GSP_PAGE_SIZE),
        )?);

        result
}

When this ERANGE is caught in send_command() or wait_gsp_init_done(), the
loop simply continues:

drivers/gpu/nova-core/gsp/cmdq.rs:send_command() {
        loop {
            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
                Ok(reply) =3D> break Ok(reply),
                Err(ERANGE) =3D> continue,
                Err(e) =3D> break Err(e),
            }
        }
}

Will this permanently discard unrelated asynchronous messages (like GPU
thermal alerts or hardware faults) arriving from the GSP during this wait,
rather than processing or queuing them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-nova-regis=
try-size-fix-v1-1-8f471ba00ab4@nvidia.com?part=3D1
