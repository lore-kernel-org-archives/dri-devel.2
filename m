Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BA0CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E010EAEB;
	Sun,  4 Oct 2026 17:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=saltyming.net header.i=@saltyming.net header.b="ZAEh2sb1";
	dkim-atps=neutral
Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB28410E18C
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:From:Subject:Mime-Version:Content-Type; t=1791073637;
 x=1791678437; bh=9y565mXmPk14OT+EJKpfLw7jDnD7lIoT4YWiqhVhvcA=; b=ZAEh2sb1Jx
 VWc0h0VmGgYpyzPwiFnRpxjxhRJs7szG3MJvSn/jmX0Y9wOjhIbGQVXaaJAOH0TsO3/bDE5VO41
 mjLcdOeOY9hhmAX2kq/BR/fmvO6gNah4kxHz9qvlmtV9WT5EQKYzfITNZGJ+oUZALdI1CPaSiES
 +dES/8jDNXr/GU7e9FEGa0qE38QU0ZuQYN4Mh+94EDca9GqiVCxYE1ils5Zx6qZA44E0HVALgKb
 rFj7KezvPAf8c8/avU5fCHuSlWte2ILprgJo9c7n4odPONezTfamIeKtuKRyIWQMuGxqo2IhXnN
 kDUHUzD1PwOAd3BmcTTcqXvMiL1a3Jhg==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
 (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 bits=256/256)
 (No client certificate requested)
 id 2a469b8d-94dc-40e2-aedd-badbe8d016c7
 for <dri-devel@lists.freedesktop.org>; Sun, 4 Oct 2026 00:27:04 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none,
 av_clean, ham
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.41\))
Subject: Re: [PATCH] drm/nouveau: request a privileged CE channel only on
 Kepler and later
From: Hamin Sung <hamin@saltyming.net>
In-Reply-To: <cdc6f42770d824240a6d4474d090a9be8da7bc2a.camel@redhat.com>
Date: Sun, 4 Oct 2026 09:26:47 +0900
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yonatan Maman <Ymaman@Nvidia.com>, Gal Shalom <GalShalom@Nvidia.com>,
 Ben Skeggs <bskeggs@nvidia.com>, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F16C3327-4F6A-479E-B4D1-F8F2B1F55EF0@saltyming.net>
References: <20261003223244.63133-1-hamin@saltyming.net>
 <cdc6f42770d824240a6d4474d090a9be8da7bc2a.camel@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3901.200.41)
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

2026. 10. 4. 08:53, Lyude Paul <lyude@redhat.com> wrote:
> The LLM didn't mention this (of course), but you need to increment the =
version
> of the patches that you send out when sending new versions along with =
a list
> of changes that were actually made to the patch since the previous =
version
>
> Also, while LLM generated patches are fine for fixes (to an extent) - =
but
> please at least make sure you write the changelog by hand to avoid =
inevitable
> mistakes

Sorry for noise from the sudden series of patches I sent using LLM. =
These are my first kernel patches,
and I just wanted to fix some issues with my old NVIDIA graphics card.

Also, those weren=E2=80=99t new versions. My mail server had a bug =
delivering most messages twice
(I mentioned this in the devfreq RFC series). Sorry for the confusion, =
it=E2=80=99s fixed now

I=E2=80=99ll keep about versioning and hand-written changlogs in mind.=

