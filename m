Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFE606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLzDT6SW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076F210EA0F;
	Tue, 20 Oct 2026 10:18:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099E110EA0F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C49F6057A;
 Tue, 20 Oct 2026 10:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB71F000D3;
 Tue, 20 Oct 2026 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792491481;
 bh=5f9thILjfP/wUHZzyU6Bf3VFuMfVVPsFtmjQKW5C88E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KLzDT6SWByvFAC1Gpcl3rEEbp50HV2RSYWuWgD9qKAiNYpqLB6wXGjLcPAiMgtlw3
 7rYn/GWrjSKzqB7EdBLA04IEB88clBf4TzD1YUqK7E0zOPamwUgyipBizbajmytmyz
 08DmwzJ7m8KVylRPYgrNGzBJJ5ihFKtTk9o8ycDYqU7aqRozLZ3KdqY6A7RpXHU/4o
 q9evjdYzPTo4HlyY9L4MjjfDbBhvPG4GxGmcwiBnoqFv8cZweMRsjccldX7ZezfhJJ
 1/qxTJ1QTZYeTds49r5KblPOjGgsVOqoCarDbqDvgD+r0xcEAI+o7lbU+tuPiSRC/Y
 VlvQOjh4C9FMw==
Message-ID: <sashiko-outbox-178822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
To: "Alexandre Courbot" <acourbot@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:18:00 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] gpu: nova-core: unintended 1ms sleep in CmdqInner::drain() on em=
pty queue
--

commit c3321749b8f493965661eed66b6e6bf889cebd66
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: use consume_element to implement drain

This commit refactors CmdqInner::drain() to use consume_element() and
adds a log() helper method to GspParsedMessage.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 7db3d28e8902c..54e87fd7158cd 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -1054,21 +1063,14 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Res=
ult<M>
>      /// `EIO` if a message fails framing or checksum validation, or if a=
 message's page count
>      /// overflows a `u32`.
>      fn drain(&mut self) -> Result {
> -        while !self.gsp_mem.driver_read_area().0.is_empty() {
> -            // A message is available, so this returns without waiting.
> -            let msg =3D self.wait_for_msg(Delta::ZERO)?;
> -
> -            let pages =3D
> -                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE_=
SIZE)).map_err(|_| {
> -                    dev_err!(&self.dev, "GSP drain: message length overf=
low\n");
> -                    EIO
> -                })?;
> -
> -            RpcMessage::parse(self.dev, msg)?.log(self.dev);
> -
> -            self.gsp_mem.advance_cpu_read_ptr(pages);
> +        loop {
> +            match self.consume_element(Delta::ZERO, |message| message.lo=
g(self.dev)) {
> +                Ok(()) =3D> (),
> +                // No more message pending on the queue, drain is comple=
te.
> +                Err(ETIMEDOUT) =3D> return Ok(()),
> +                // Other errors are fatal, and stall the queue.
> +                Err(e) =3D> return Err(e),
> +            }
>          }
> -
> -        Ok(())
>      }
>  }

[Severity: Medium]
Can removing the !self.gsp_mem.driver_read_area().0.is_empty() check
cause CmdqInner::drain() to sleep for 1 ms when the queue is empty?

Previously, CmdqInner::drain() only called wait_for_msg(Delta::ZERO)
after confirming a message was available in driver_read_area(). With the
new loop, consume_element(Delta::ZERO, ...) is called until the queue is
empty, which invokes wait_for_msg(Delta::ZERO):

drivers/gpu/nova-core/gsp/cmdq.rs:CmdqInner::wait_for_msg()
        let (slice_1, slice_2) =3D read_poll_timeout(
            || Ok(self.gsp_mem.driver_read_area()),
            |driver_area| !driver_area.0.is_empty(),
            Delta::from_millis(1),
            timeout,
        )

In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
false, the timeout check uses a strict greater-than comparison:

        if start.elapsed() > timeout_delta {
            // Unlike the C version, we immediately return.
            // We have just called `op()` so we don't need to call it again.
            return Err(ETIMEDOUT);
        }

        if !sleep_delta.is_zero() {
            fsleep(sleep_delta);
        }

Because op() only reads two u32 indices from coherent memory in RAM, if
the monotonic clock has not advanced by at least 1 ns between
Instant::now() and start.elapsed() (for instance on architectures with
coarser timer resolution or under virtualization), start.elapsed() is
Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) while
holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded() ->
Cmdq::drain() and Gpu::new() -> Cmdq::drain()).

Would it make sense to keep the while
!self.gsp_mem.driver_read_area().0.is_empty() loop condition around
self.consume_element(Delta::ZERO, |message| message.log(self.dev))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-cmdq-rpc-v=
5-0-dceeb8f360ec@nvidia.com?part=3D11
