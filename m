Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547956083E03
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=YV7AHBTE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42C210E05B;
	Mon,  2 Nov 2026 15:26:51 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C8010E05B;
 Mon,  2 Nov 2026 15:26:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jJFtC0W4XzKn28;
 Mon, 02 Nov 2026 16:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793633203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nP2e3PGjH3XUNquztLEZ0q/WCiO+28qYpsidPKUHKlc=;
 b=YV7AHBTE5mbv7+xt+PhpooXgBlcKB/sxubS+DnOWOTpFo3bbtlJmhkmRhkjPs6XVeoXWMe
 CFPFyNBZ1MPgn9FEDS+8f1Z8cIqJw7WGmFffza3UP412OxxJwIU9zo23GA5Z44namqId1u
 0DrJWeD98Be0H8s1EHSwCi9srHMwh0JTS1ceYuKMghdxohN1OL4V/iGCJuZtCmL33gk7Wt
 iHq2UjgSgp72i60hUZ1dvOAN+HeejZaG3Zif4EfSp91FXQHGAWZR5h0IK7imVPOdBKkUGs
 6U0idDFpMqothWuxI6Cfhc1ptrsK91XEZTHSHZwbNyb5KGyMzcwS6w5rTOx4rA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Mon, 2 Nov 2026 15:26:42 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <2112993263.278931.1793633202457@app.mailbox.org>
In-Reply-To: <auh8pUx_kXUYSdZ8@intel.com>
References: <20261031161952.660049-1-hugo@hsal.es> <auh8pUx_kXUYSdZ8@intel.com>
Subject: Re: [PATCH] drm/probe-helper: Sort and set crtcinfo before dropping
 the modeset locks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jJFtC0W4XzKn28
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/02/2026 12:05 PM WET Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.int=
el.com> wrote:
> On Sat, Oct 31, 2026 at 04:19:52PM +0000, Hugo Sales wrote:
> > amdgpu walks connector->modes from its atomic_check, in
>
> That is just wrong. connector->modes is protected by mode_config.mutex

You're right, I should have fixed the real issue rather than work around
it. Please drop this one

I'll try to fix it in amdgpu instead. atomic_check can't take
mode_config.mutex there, so amdgpu would pick the mode it needs while
probing and keep its own copy, like it already does for freesync_vid_base

> And regardless of changing the locking rules or not, someone
> should probably sprinkle lockdep asserts to bunch of places
> where connector->modes is consulted. Perhaps even introduce
> custom list iterator macros that include the assert...

Makes sense. amdgpu would trip them today, so I'll look at that once
the amdgpu side is fixed

Thanks for the review,
Hugo
