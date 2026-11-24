Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BC606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGWcwVqO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C0D10F51C;
	Tue, 24 Nov 2026 11:56:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057FD10F508;
 Tue, 24 Nov 2026 11:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D961762614;
 Tue, 24 Nov 2026 11:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB161F000C0;
 Tue, 24 Nov 2026 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795521353;
 bh=FCk4hJGWPUnhJXWJTDgKqX8nTAjZ6DEdTfpvOFD9mxw=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=AGWcwVqOwcJ6k3arIAzYlO9cpSUxeGk9cZPoWHw7uVO8GhDTUho/5pxLOX4Z+pSEm
 oNnRJHGLiW52Y8pLS4JzH3xmeJ2hgT990g8+NnhslrZDLXkH/JemRE/zie3Y5DOriE
 yCplNT4VpMlbCOgvGtrHkzuH563IEwGja23JKNhbIJx28Y1oqbvaVXvVOe2+EjJSGS
 TYUpWSlpa90tBIPQLeD3dvXzEEObPyP+YhcZafpbdA7ZzmwOT4twe7DvCxYap0IEng
 yn+5GohlXJPjek9mNpC1hSc0dE4VSIk2IHzXja+jJUeUEo40ucs0w/DhuW1YQTxuRL
 6Yz6rWD4EuFNw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:55:50 +0100
Message-Id: <DN3F7521O232.LXJ8JBRTSTPQ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 3/3] nova-core: only bind to GPUs when explicitly
 requested
Cc: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>,
 <airlied@redhat.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>
To: "Dave Airlie" <airlied@gmail.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
 <DN2OVF03FAL6.2EKLEYINW79YO@kernel.org>
 <DN2QWVWVB2FP.2DL4ZSBMYRXEC@kernel.org>
 <CAPM=9tw4_Kn2+q0JTZ5Y6+m6PFORJSgq4qSrqtutwWJniusgvQ@mail.gmail.com>
In-Reply-To: <CAPM=9tw4_Kn2+q0JTZ5Y6+m6PFORJSgq4qSrqtutwWJniusgvQ@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 2:53 AM CET, Dave Airlie wrote:
> On Tue, 24 Nov 2026 at 02:54, Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On Mon Nov 23, 2026 at 4:18 PM CET, Danilo Krummrich wrote:
>> > On Mon Nov 23, 2026 at 3:50 AM CET, Dave Airlie via B4 Relay wrote:
>> >> @@ -30,3 +30,24 @@ config NOVA_CORE_SELFTESTS
>> >>        logs its failure and lets the probe continue.
>> >>
>> >>        If unsure, say N.
>> >> +
>> >> +config NOVA_CORE_BIND_GSP
>> >> +    bool "Make nova-core the default driver for GSP-capable GPUs"
>> >> +    depends on NOVA_CORE
>> >> +    default n
>> >> +    help
>> >> +      Make nova-core bind to all NVIDIA GPUs it supports by default.
>> >> +
>> >> +      By default nova-core does not bind to any GPU and leaves NVIDI=
A
>> >> +      GPUs to other drivers, such as nouveau. Say Y here, or boot wi=
th
>> >> +      nova-core.bind_gsp=3D1, to make nova-core claim NVIDIA GPUs
>> >> +      instead.
>> >> +
>> >> +      nova-core is work in progress and may not be functional, so th=
is
>> >> +      is intended for nova developers and testers only. When enabled=
,
>> >> +      nouveau must not bind to the same (GSP-capable) GPUs, i.e.
>> >> +      CONFIG_DRM_NOUVEAU_BIND_GSP=3DN or nouveau.bind_gsp=3D0 is req=
uired.
>> >> +      Otherwise both drivers compete for the same devices and
>> >> +      whichever is loaded first wins.
>> >
>> > I think this is a bit unsatisfying, for the Kconfig at least it would =
be nice to
>> > avoid the possibility of being able to configure
>> >
>> >       - NOVA_CORE_BIND_GSP=3Dy && DRM_NOUVEAU_BIND_GSP=3Dy
>> >
>> >       - NOVA_CORE_BIND_GSP=3Dn && DRM_NOUVEAU_BIND_GSP=3Dn
>> >
>> > since I wouldn't consider them valid combinations of Kconfig options.
>
> While I like the idea, expressing this sort of thing in Kconfig seems
> to never end well, I'd prefer to just keep them separate until we can
> figure out scenarios where it's screwed up.

Kconfig can be tricky in some (or actually many) cases, but this one seems
simple and correct to me.

Is there a specific concern?

> I'll think about it a bit more, but I'd rather not encode too much
> complexity here for fear of one or two people screwing it up and not
> reading dmesg.

Honestly, I think that the proposed approach is even simpler, because it
constrains the Kconfig to exactly the case we want it to exist for in the f=
irst
place.

In addition to the two odd cases I mentioned above, each driver exposes its
binding-default option even when the other driver isn't configured, althoug=
h
there is no choice between them.

Consequently, we also force that nova-core defaults to not binding even if =
it is
the only driver configured.

This is not the end of the world, but it's another inconvenience and also
becomes a bit odd once vGPU works.

I think the proposed option is sound; it is only available when both compet=
ing
drivers are configured (either m or y) and defaults to nouveau.
