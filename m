Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519A606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=XlwidT4k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0191410E70B;
	Mon, 23 Nov 2026 08:19:20 +0000 (UTC)
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 04:26:07 UTC
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3917210E2B9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:26:07 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=xxZ7A6ARsfw5U5c4K3zdosZhEZzO/c/7t/gvu6JAhj0=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795407965; v=1; x=1796012765;
 b=XlwidT4k9HT8ja5aIFa7AGS2d3jZ8mY1PCm9ns/LxFsNukDIo1axmcPDh93HvHoxsGMbesjI
 YMqxa9DtYkso3F7z5185XyBej+q8L9/JkGcVVozfxauF7+Ej0Bo6AVxEi0ybjbMkr1d8xjx/1xc
 2ldAbFnLYfAp3mbIoXIJZ4oF35XaVL7RR90ye1jkhfHJO73bGZmm0DMg71SJCpJ/CE/AGeqAEmC
 cz9TNd7cbfzKRo5KfuZGbI7/Mrd+IEmkPjurxwcjjD8Qp5nHpABC8RRbwz+HCUv0N4nGT/66ipl
 zihagAl9bpvNExqzGAdVAwrHy68WaBsY7ih4/axv4O4XQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 53e2255c13b2d2f8;
 Mon, 23 Nov 2026 04:19:59 +0000
X-Mizu-Trace-ID: 53e2255c13b2d2f8
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 12:19:55 +0800
From: Weijie Yuan <wy@wyuan.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Document the union in dc_probe_status
Message-ID: <awO-665NEGdZtq1z@wyuan.org>
References: <20261121041427.1743954-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121041427.1743954-1-takano32@gmail.com>
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:19:18 +0000
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 04:14:26AM +0000, TAKANO Mitsuhiro wrote:
> The members of the union in dc_probe_status are described one by one as
> @u.bandwidth_mbps and so on, but the union itself has no description, so
> kernel-doc reports:
> 
>   dc.h:2225 struct member 'u' not described in
>   'dc_probe_status'
> 
> Describe it, saying that the member holding the result depends on the
> probe type.
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran kernel-doc on the file with and without the change.

The disclosure is appreciated but better put it ..

> Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---

.. here.

Thanks for doing this.

>  drivers/gpu/drm/amd/display/dc/dc.h | 1 +
>  1 file changed, 1 insertion(+)
