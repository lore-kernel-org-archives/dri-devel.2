Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AE606A333
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akq8/ulw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED7910E19A;
	Thu, 26 Nov 2026 00:33:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65810E19A;
 Thu, 26 Nov 2026 00:33:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A27461B14;
 Thu, 26 Nov 2026 00:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C1F1F000C6;
 Thu, 26 Nov 2026 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795653191;
 bh=8pIzqjiV/StT7AHcIrYh5KJvxuCIG6PlfMWhHLglXYw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=akq8/ulwNlgdA0bhzr8EInShYXOdCDGAGHFspNfhQ/7K3qYCbpW/GSxjcD2rCr3L5
 VNi7arUPwuomzIxH/zvC0y+El42ptroMpAIU+RRDLNGFqgq1igfTYBf8Fr4K+QxRM/
 xukKesZwfNwGVfLC9Exdee0kR8zv9dlbKmOd/rim31Q184PMzsTjfkLteRWrEC9VY+
 UTfuG4JVm8PT/c05MQhl9QBUWVIWKQq0eDgy377aTjCn95CP7QEtM6gB9i8be7YYMJ
 mwo+YkQLTgKRMeUgAZO6waWln1d/sJ2dp790BiG9jJBjuDPKkTtz3VSNNzNzJPL0WL
 FHn/IRe158mlw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:33:08 +0100
Message-Id: <DN4PXIYXRY4O.1FKD2ELMKOUEK@kernel.org>
Subject: Re: [PATCH v3 1/2] drm/nouveau: add option to leave GSP-capable
 GPUs to other drivers
Cc: <airlied@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
To: "M Henning" <mhenning@darkrefraction.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
 <20261124-nova-nouveau-gsp-v3-1-e1440479ded6@redhat.com>
 <CAAgWFh2VmmZfdEM1hDB+8921ktfRrD81kXFqEc6dJ3ys+=vJYw@mail.gmail.com>
In-Reply-To: <CAAgWFh2VmmZfdEM1hDB+8921ktfRrD81kXFqEc6dJ3ys+=vJYw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 25, 2026 at 5:43 AM CET, M Henning wrote:
> On Tue, Nov 24, 2026 at 12:50=E2=80=AFAM Dave Airlie via B4 Relay
> <devnull+airlied.redhat.com@kernel.org> wrote:
>> +config DRM_NOUVEAU_BIND_GSP
>> +       bool "Make nouveau the default driver for GSP-capable GPUs"
>> +       depends on DRM_NOUVEAU
>> +       default y
>> +       help
>> +         Make nouveau bind to all NVIDIA GPUs by default, as it always
>> +         has.
>> +
>> +         If another NVIDIA driver, such as nova-core, should claim the
>> +         GSP-capable (Turing and later) GPUs instead, say N here; nouve=
au
>> +         then leaves those GPUs alone and continues to bind to pre-Turi=
ng
>> +         GPUs itself. nouveau can also be prevented from binding to
>> +         GSP-capable GPUs at boot with nouveau.bind_gsp=3D0 on the kern=
el
>> +         command line.
>> +
>> +         If unsure, say Y.
>
> Maybe the documentation should make this option sound a little
> scarier? Right now all this does is break nouveau (unless you're a
> nova developer),. We really don't want users or distros turning it on.

I assume you mean turning it off; turning it on (which is the default) shou=
ld
not cause any trouble. It has some rough edges though, which is why I sugge=
sted
[1] instead.

[1] https://lore.kernel.org/nova-gpu/DN3F7521O232.LXJ8JBRTSTPQ@kernel.org/
