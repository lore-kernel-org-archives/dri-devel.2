Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D6606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KX9kBpTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336AB10E214;
	Sat, 14 Nov 2026 20:26:47 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E711010E05E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794687995; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nM7G7lAub3qLv6N0ON7GAAEkyzNgyFgDqRDfMVxOo8CQ541UyjRuERjZm55IYNc0msks91bRBN4Z+/6Ou/F/Ss2BDy3tG5O7+TAD8W864aJNYFz42WuduBBDSO7tDpv7Nuv6zG1MBLGzo4vbh8+OXnmLjJM5ydRj8MwN2NUwmAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794687995;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ypx4hXwAoSBembIh9H3n5W3lgXyJZPIzRQD4Em4Bl4Q=; 
 b=BjkR4pF2lLOtvrOwWcUmJZgvhonNIOmSWJP2zD+DsbhxaikuOgFayWqM826l+LUOhyIZPu8V2DNoCiSs0+RrlUQCZ3+HKl/p87afEYKn/9m3x9scp7TKOLLndDrMf3wDgLBU+mkPGj5dkysGK80zPTDLihzXygWbeAodzWo6aoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=KX9kBpTjdF5mEUA15S1iVhx6Nj14gq1WtW3oE11uNwq1JFTsGDT4TtsOv9EFfTJ1uHYiT9SOXKiOfhdesG2I3RQNdp+vJWlRlT1gEMhUBF1wfMEdpzEAmPBgwPwds3ftVpgHta+WZ78bhY9yiylnWKeXHQpKpSybd5JyWKjgji8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ypx4hXwAoSBembIh9H3n5W3lgXyJZPIzRQD4Em4Bl4Q=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794687991847956.7695221547046;
 Sat, 14 Nov 2026 12:26:31 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: aiyengar1990@gmail.com, Arun Iyengar <aiyengar1990@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2] drm/bridge: Fail an unsatisfiable bus format
 negotiation with -EINVAL
Date: Sat, 14 Nov 2026 21:26:26 +0100
Message-ID: <b23U0RxuQmSNURVAsy1U6w@collabora.com>
In-Reply-To: <CAEy9hNXoPbWzx=EiOXJwiiY=XJF56g1MfM86cgp96einDbONmw@mail.gmail.com>
References: <20261111-drm-bridge-busfmt-einval-v2-1-fbb74905614b@gmail.com>
 <CAEy9hNXoPbWzx=EiOXJwiiY=XJF56g1MfM86cgp96einDbONmw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Friday, 13 November 2026 21:27:43 Central European Standard Time Arun Iyengar wrote:
> A correction to the commit message: the DW DP example cannot happen on
> mainline. No DisplayPort bridge connector has the "color format"
> property, so "userspace now hits this routinely" is wrong; I hit it
> with a dw-dp change that is not posted.
> 
> On mainline, -ENOTSUPP still reaches userspace from a chain with no
> common bus format, as in drm_test_bridge_rgb_yuv_no_path(). The code is
> unchanged; I can send a v3 with the message corrected.
> 
> Arun
> 

While you're at it, dramatically trim the amount of yapping. Just
because your LLM wrote a long text doesn't mean we want to read it.



