Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF18CD37B9
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 12:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE6910E6E1;
	Mon, 11 May 2026 12:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.b="Io79iC5+";
	dkim-atps=neutral
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2EB10E06E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 12:14:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C0F5410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1778501676; bh=04eLlvx/pZh/pgfhzlxjTsKybP+rISrltG/8U1AFLoI=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=Io79iC5+6DYLG4ji1PeaYkSLp3UayBLYIPW+N9+bquywMCfki2JFHiG8eXDoorJDh
 dEGcUkNrP74zz2mqmGWrPpUQjplN/xWftgHso71cF7m/6JIcbjSQdzbFJsLr+Dxqj7
 dqnJ3C89cqsFxC1xUQbqnv8aX12wJi9xWbXwIyDmiBzrkPRbORgc0pcDNBoJCXbyM4
 eioui6Ye17h6u9AJiIA+wUz9jrBK4XgtqScYk6O8EmSEX/hPVANF0BF+tB/sY2xXTp
 isYim1HfifeBm9HIXZ2WOFRWb1irDApKap3dW2TWcyVakVDWJYgFRwpXpfWZhcuodX
 L4ljznhdkoAmQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 6C0F5410B5;
 Mon, 11 May 2026 12:14:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Maxime
 Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 0/3] Documentation/gpu: tables of contents cleanups and
 fixes
In-Reply-To: <ad1be55a146a3680ad920588a7cfdbc154b8a4fc@intel.com>
References: <cover.1778238671.git.jani.nikula@intel.com>
 <ad1be55a146a3680ad920588a7cfdbc154b8a4fc@intel.com>
Date: Mon, 11 May 2026 06:14:35 -0600
Message-ID: <875x4uw3bo.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
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

Jani Nikula <jani.nikula@intel.com> writes:

> On Fri, 08 May 2026, Jani Nikula <jani.nikula@intel.com> wrote:
>> Make the GPU documentation slightly easier to navigate.
>
> Maxime, Thomas, Maarten, Jon -
>
> Any preferences which tree to merge this through? I'm thinking either
> drm-misc-next or docs-next.

Usually I stand back from DRM docs, expecting them to go through the DRM
tree.  I can certainly pick up this set if that's best, but I wasn't
expecting to.

Thanks,

jon
