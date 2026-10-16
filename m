Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FBBCC6B2D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047A510E1D1;
	Fri, 16 Oct 2026 05:39:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0765E10E1D1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:39:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA8F64368D;
 Fri, 16 Oct 2026 05:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D72B1F000C4;
 Fri, 16 Oct 2026 05:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792129192;
 bh=uLjpFm4pO99mG3+3B3IR1g5KPHDf4i627GeInEad2o8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MvYi76I1kSuTWFSAaI0ISAe0o3PryMSWbG7796lWGggTSKmV2Pl5VsHKeM50wg05J
 xppt4v6pE78dxf0nDlNB+u0Sry7vXOnmfbXMqS1ss2phbO13PT9cB8WxZBu30T9kQD
 Kch7F/MsaZTvbpDgpoqv9qZPaFc9WJHK5wJ77fdfq5RshpcCVJ47hyjKTBMrPat2HZ
 TK/fS0qD+ABRuw6gWKXN5TzwQlQHdapeAo+3UO7mDnDSj8omCTZCh1GODEAl/7/LfH
 rEsW/FgrgH+F+6NY2fhUaLhITftM8Dp58w4nfuUaxAU24fyw3eWlaJoV4ICB1SUu/Y
 PR88OfA5uuolw==
Message-ID: <sashiko-outbox-173828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
To: "Devin Wittmayer" <lucid_duck@justthetip.ca>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016052722.60051-1-lucid_duck@justthetip.ca>
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:39:51 +0000
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
- [High] drm/panic: pointer underflow and off-by-one line skipping
--

commit 0e87da3652905d3ac59b3e4a4293f550785dff6f
Author: Devin Wittmayer <lucid_duck@justthetip.ca>

drm/panic: Fix kmsg screen hang on a long log line

This commit increases the size of kmsg_buf and makes it static to avoid=20
stack issues. It also adds a check to stop reading if kmsg_len is 0,
preventing an infinite loop when a log record doesn't fit in the buffer.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861d..29b1487de7ae0 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -574,6 +575,10 @@ static void draw_panic_screen_kmsg(struct drm_scanou=
t_buffer *sb)
>  		char *start;
>  		char *end;
> =20
> +		/* a record that does not fit comes back empty, every time */
> +		if (!kmsg_len)
> +			break;
> +
>  		/* ignore terminating NUL and newline */
>  		start =3D kmsg_buf + kmsg_len - 2;
>  		end =3D kmsg_buf + kmsg_len - 1;

[Severity: High]
Does this code underflow the pointer arithmetic if kmsg_len is 1? For
example, an empty printk that just outputs a newline would have a length
of 1, resulting in start pointing to kmsg_buf - 1, which causes undefined
behavior.

Also, looking at the code immediately following this in
draw_panic_screen_kmsg():

    while (start > kmsg_buf && yoffset >=3D 0) {
        ...

Does the strict inequality prematurely terminate parsing? It appears it
would silently drop 1-char lines. It also seems to skip the first log line =
of
every kmsg dump chunk, because the loop stops before processing when start
reaches kmsg_buf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016052722.6005=
1-1-lucid_duck@justthetip.ca?part=3D1
