Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685F606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es3UkxZ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A572710F20C;
	Mon, 23 Nov 2026 21:15:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9EB10F20C;
 Mon, 23 Nov 2026 21:14:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF691436FC;
 Mon, 23 Nov 2026 21:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7251F000CA;
 Mon, 23 Nov 2026 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795468494;
 bh=uMUkPd17tmOQBq2oh/KOicPLQhomscvQuJiftTF2lFc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Es3UkxZ/c5iLCjXzVJ/DrmMfMuRgCNrr/zsOCRDRPHOUs5nZJXeCxpcnJqTKK+ny7
 N2G/kPyASzYdhV4KhuqBINhWf+//1ETeflW7nMfLA9M4Mc8AA3psgTDAcCmltHK/AZ
 SQ/vXKdPMHhZzsPmKLBaWLe2wG0OeU+Hq0lptxMe7DPAhOzwLgCNzVUtRcY+19E4hF
 XKCKFn6oVTmbe4vEXTIzxHVq1p5Snk7jmtwclc4llkhmQRkL1qsQglgH8azHZwwl76
 zV/NhBcWYGyrn2etfZM0AOQ68wzGVAuM8niiltu/snaeTAetd6G8jL9PQRtWMDfGly
 hRuY8MIy4sprg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 22:14:51 +0100
Message-Id: <DN2WGM8KWOD4.1Q96FIYG22NA0@kernel.org>
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable
 GPUs to other drivers
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "lyude@redhat.com" <lyude@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>
To: "David Airlie" <airlied@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
 <617a6fcc6a541f27351fb7f5abe21fb89553438a.camel@nvidia.com>
 <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
In-Reply-To: <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
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

On Mon Nov 23, 2026 at 10:11 PM CET, David Airlie wrote:
> At some point we need to give the option, but indeed we don't have to
> right now, if nova developers are fine with always providing the
> command line option then we could drop the bind options for now,
> but I know it can be annoying for devs.

I'd prefer to go with a Kconfig option right away.
