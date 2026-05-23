Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8ADCD5BBF
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 13:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FC810E258;
	Sat, 23 May 2026 13:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="YlyFWsyA";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="mgLB6mdJ";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EED10E258
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Date:Message-ID:Content-Type:References:In-Reply-To:Subject:Cc:To:
 From:Sender:Reply-To:MIME-Version:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8I6M7k7kvgcb+rn7uXV/Wj6J7nrwLozopthnqonkNsg=; b=YlyFWsyARxA+AbdcNaA/3+2vBk
 ofCOknei7v66h36nmqF/gX7X8JFvgr397C1pnjvr89kftxiv1pyI6KTZQrhSyJqDfbY+mOJoVZ/E/
 1RZXRCNgiWP+qs2K1Xz5zbx2P52ACriinFupNj6dtMjL0AuQo2Bu1OIIFqCA7tvLvqzj9bJLK0b/2
 gg7FbULx22JVcK/ZZt+VmSqQRDt4M9wIpA5Chk3ydmRWMcg6HLh3VYRd+GZ6poAPHSPjmH6wceu73
 XTjKiFQnV2kZYRTuGCtDgCeMECj+IB6O+uoE0NJJ2MQfMK92NuI+iXyqJPYjgohIjoE8a1RjC9O9r
 RyVYHvCw==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wQms6-004m0m-2M;
 Sat, 23 May 2026 13:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779544702; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=8I6M7k7kvgcb+rn7uXV/Wj6J7nrwLozopthnqonkNsg=;
 b=mgLB6mdJzY0l11XYSKbfLVCRpJyRRtzy+JnSpQxdRgVd9Usg/uDoH/p3U8TASl9B+jt5n
 KE4LdlNd43RoEZRcc8wuCu8a89mRJV8icZbIDsT2Oeb8zJSYqUW1XfGXB356LLqfl9fy02f
 bGTxruD4ndHjhqZ5KqiM4QWk3EPbmWH0f+34Ake/v7nLWxzwEQoBSniCqeDDchpjmMVSyWp
 QL1DT3AfjwZz+XQPVPKtoNAV3RJGHR2QiMXjszgkaBobnjnKnDIGZe8S+rd+NpVNif3FYdi
 OJGUYJiePLqh0fsinleNEFjSAS/j1ags/9uBqWjG45OgLEmPZ3QhaOOEjE/A==
From: Berkant Koc <me@berkoc.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mgag200: reject pixel clocks outside PLL range
In-Reply-To: <041bae47-bb5d-4db7-9435-f6c5d9c2fda1@suse.de>
References: <28e476e896dafdd31518dc5360ab7766@berkoc.com>
 <041bae47-bb5d-4db7-9435-f6c5d9c2fda1@suse.de>
Content-Type: text/plain; charset=UTF-8
Message-ID: <177954470241.415690.10502351545232803066@berkoc.com>
Date: Sat, 23 May 2026 15:58:22 +0200
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> The other models never did this check. Why is this now a problem?

You are right, and my Fixes tag is wrong. I checked the split again.
877507bb954e moved the per-model compute routines into separate files; it
did not remove a check. Only g200se ever had the permitteddelta guard (the
0.5% VESA comment lives only there). The other six helpers never had it,
before or after the split. So this is not a regression. Please drop the
Fixes tag and the stable Cc; I should not have framed it that way.

What remains is a latent robustness gap, not a bug users hit.
mgag200_crtc_helper_mode_valid does not bound the pixel clock, so a
hand-crafted out-of-range modeline can reach the search loop, match
nothing, and leave m/n/p/s at 0. atomic_update then does pixpllc->m - 1,
which underflows, and programs garbage into PIXPLLC. Normal EDID modes stay
inside the VCO window and never trigger this.

If you think hardening the six helpers to match g200se is still worth it, I
will resend without the Fixes/stable tags. Do you prefer a per-helper guard
like g200se, or one shared check after the loop? I will follow your call on
scope.

Thanks for catching the framing.

Berkant Koc
