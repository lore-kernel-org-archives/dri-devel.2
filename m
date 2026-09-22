Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA1C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F20610E72A;
	Tue, 22 Sep 2026 16:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7ne/NAD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72A510E72A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 16:09:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87200432E6;
 Tue, 22 Sep 2026 16:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497841F000FF;
 Tue, 22 Sep 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790093380;
 bh=xGn1mmDRATqyVSnEIBoia7vAXtsDMxhrjcUN1OYR8HM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P7ne/NAD0qSooprU7uUF0JHwceb/6SFfhdI0F4T9Ht4GYCw0ftEomWCFFnmyT1ky9
 aZeCHlTA1gR9t0OLLpJFTMKtdQForhiYi5hDao1mrdp2G6MjBomG9LlSPEChac29lY
 gFFn/7FVKmjK8k6Ba40eUD/dkAEYdJA1WMt8yuuU1njfj6zUtG1HRz7BDqso1puQkU
 r6dNRPpfog9y8xgzPv1F04mNgwibMUW/UlsvMRP9tZQk0fvH3NtQtc1ZUNF4Fw9htD
 oMD+5tK1o9s8qC3daRhygmgqcDfPKpFfChG87XU3IQV0Ss3wBJLj829Tgbg7ftTqn+
 qpAev1HdeBexQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: fix NULL stream deref on MST DPMS-off
To: "Arthur Liberman" <arthur_liberman@hotmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
 <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 16:09:39 +0000
Message-Id: <20260922160940.497841F000FF@smtp.kernel.org>
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
- [Low] drm/amd/display: dead code in MST DPMS-off loop
--

commit 07293e89053ea9e3ce60dc0852be04a50a4ec01e
Author: Arthur Liberman <arthur_liberman@hotmail.com>

    drm/amd/display: fix NULL stream deref on MST DPMS-off

This commit adds a NULL check for streams in the MST DPMS-off loop in
link_set_all_streams_dpms_off_for_link() and adds stream NULL checks in
dc_stream_get_status().

> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gp=
u/drm/amd/display/dc/link/link_dpms.c
> index 48b086d15ab0c..17cb831ce8c48 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -177,6 +177,13 @@ void link_set_all_streams_dpms_off_for_link(struct d=
c_link *link)
>  		streams[i] =3D pipes[i]->stream;
> =20
>  	for (i =3D 0; i < count; i++) {
> +		/* A full update can release current_state and NULL remaining
> +		 * pipe streams. MST daisy-chains have multiple streams on one
> +		 * link, so skip any that disappeared mid-loop.
> +		 */
> +		if (!streams[i])
> +			continue;
> +

[Severity: Low]
Does this check actually protect against mid-loop state changes?

The function link_get_master_pipes_with_dpms_on() guarantees that
pipes[i]->stream is non-NULL when populated, and these pointers are copied
into the local streams[] array before the loop.

Since streams[] is a local array and its elements are not updated inside th=
is
loop, is it possible for streams[i] to become NULL during iteration? It app=
ears
this check might be dead code that provides no runtime protection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/DB9PR03MB73884B0D60=
4BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com?part=3D1
