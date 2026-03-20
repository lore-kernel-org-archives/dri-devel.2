Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F319D10987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4637110EB82;
	Fri, 20 Mar 2026 16:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="na/UHZbp";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1547910EB77;
 Fri, 20 Mar 2026 16:42:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 08A8B1A2F12;
 Fri, 20 Mar 2026 16:41:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D3560600E0;
 Fri, 20 Mar 2026 16:41:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08EC710450CB3; Fri, 20 Mar 2026 17:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tBb8G4iVQqneoaxtx3KstRHCNuo2y0iZkF3wbfaRCxE=;
 b=na/UHZbp1tvYB5Zgv5vYqz+RZ98im3EbgVM7FnecmXzXfhLxPBxCsAeLIZqPXUeH5w+tZi
 kG92C34Y5FesaCacOOPf1Z7MsGC3J8mHHag1YezJY+LEfurgM7iTHkglsA9K/mYx0EizmM
 PZ5hgRm4edei+qv5itIUI6Bc03aXfNNsYKkzajcZg1FwLzv57g23xCUcqLXOVhJViRByBb
 5RqChs1yE4xT9Kmv88IJsSdKxcWpZSKFgZXtrZ0RXD54UfJk7YFwfOfSZseVBSMFRuOJOn
 MMIVjsbzYF2/hqZQxYjg1yUfdAJvJuQclThQbC5SPjnchM/TeTYW9+zPHq04xw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 20/65] selftests-dyndbg: add a dynamic_debug
 run_tests target
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-21-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-21-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491436.6181.1302108073417304649.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=617;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=4FGYIZj4jeMs13vy3bZeZW/6B7jYNN4IjnVUCixotOQ=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjXnoFgy9PxuncgCjFS6oj11/EXF8EtgChbg
 w3zURjrm9WJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKTSRAAxZbv1cWSuVJoGcSh68D2E+KJ6P33eWN
 McRc1e9K7MIyhrXT0wiwh/t8FLhD8h2CfIduB0go5VMWgx1574Hp/TRqR39r8zIGEPC8bz1NKRf
 TkCgFR7INlE1eimDXYCzpIq2ZgItBB2OyaOWYrNB5+J7u14O6nMZxeLe3+PIAyj7Z+mPJQMZVEF
 VWqiGblXU7cuFKca+f95GXNIaGlzCIMCpAGzEVHUatlLxve3BARU2xtgVHzp4co9TkYh9E+8Ndn
 Y13g/akYlyZoaDpagoct57+u8la3KfQ4kUs3blNkFHslS5S4RRFqqnZJGEvdYsSNVH6gffHop+P
 AxGb9gm8l7iSKsMggKf0aC7OlN9nZn4Jkk5MKC54ZBAQ6KoaTgk1ZOyO5W9JlOWzSy7GI6PP8UO
 EBJzONA4E3cNk1vSgyN/dPsdjVsC7qPS8lZj1r/p1MJ2rTEZrY+Y8r29tYYkslXQXiIaJwv+UtK
 s5wTKNCcv00kNfIFD7D0bYQ2S6MKmyB8C3BCsXCWxI4Uwm4ll9mRh1U34mu3og8/svKtFCtmACR
 CA89WubDj8cpDEABTQC7lQK+FfSKwKXdw00qU+6qZlSHH4cSVNcqk6wTGFFEAKAUAKPi9atl6n1
 OMxr5fXsp5DKINKXrxbcu5G3bvFMtTP0k+hclm6lgRdSEIE74FeY=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:19:45 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Add a selftest script for dynamic-debug.  The config requires
> CONFIG_TEST_DYNAMIC_DEBUG=m and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m,
> which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
> CONFIG_DYNAMIC_DEBUG_CORE=y
> 
> ATM this has just basic_tests(), which modify pr_debug() flags in the
> builtin params module.  This means they're available to manipulate and
> observe the effects in "cat control".
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
