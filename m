Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36580CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 14:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812DA10E20C;
	Sat, 16 May 2026 14:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.b="FkOaEQAi";
	dkim-atps=neutral
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2D810E20C;
 Sat, 16 May 2026 14:09:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 950D2410B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1778940583; bh=ou8DOGO+SAzFBsITu8uOd2acXVesjslZQVd52PzTi6s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FkOaEQAiXekO5PIMvT466xeKe6fz+LPEpA0XS5Uag4J+nfmEdmU6HIrZGBJYOGQgm
 nuwVf4OtiaO81wyi8KFYxQ+6df+IvzsPQUUccFgd5n5jc2s7FOdOJ8os63dAN3mDLW
 QKDSFyA/Djymuje+VGi0MT05sb5JoHyLo6GfSya38SyF2KFfGpcI+STADgAHPiPGIo
 PqJZEVNhHxMc66G6LlBtZu7l917oDvGyX+zDlIPP5Umq/OozWiLWaNYNd8eGKCRiwN
 w9Kaop3t43V7SN3E72e/KnanMIcfPrtS+RH5lMCDGVTjjqB3QIUc0v0rgn3bPrhLkC
 e1RYQl4cVVeUA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 950D2410B8;
 Sat, 16 May 2026 14:09:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Cheesecake <cheesecake2960@icloud.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Cheesecake
 <cheesecake2960@icloud.com>
Subject: Re: [PATCH] docs: fix typo in mpo-overview.rst
In-Reply-To: <20260516100406.21070-1-cheesecake2960@icloud.com>
References: <20260516100406.21070-1-cheesecake2960@icloud.com>
Date: Sat, 16 May 2026 08:09:42 -0600
Message-ID: <87se7rmont.fsf@trenco.lwn.net>
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

Cheesecake <cheesecake2960@icloud.com> writes:

> Replace "transparant" with "transparent"
>
> Signed-off-by: Cheesecake <cheesecake2960@icloud.com>

Patches need a proper signoff with a real name, please.

Thanks,

jo
