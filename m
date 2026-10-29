Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF4606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=nPaKuxv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56AF112312;
	Thu, 29 Oct 2026 13:57:58 +0000 (UTC)
X-Greylist: delayed 421 seconds by postgrey-1.36 at gabe;
 Thu, 29 Oct 2026 13:57:52 UTC
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5638510E11B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
 t=1793281848; bh=tl/0tt4DBdnUlTF61vXRxhF+HFOKLRG/ZnDXYNQcxMU=;
 h=From:Message-ID:From;
 b=nPaKuxv/tGVfzxOcF7CanXXMNFyXL/yODBN8CwF9xXMo12U5uyq8zPY3tuCcwhA3H
 68e7M3EY6brLogSotsZTWQ9CwSlBMoMgXiTq2fBDSK/5FzM6g3KKCD6f9B1caw/dDE
 AgOBY4+91DV3DQl6Ir6fVEwC4fq0QT9hPcitenrk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
 by mta1.formilux.org (Postfix) with ESMTP id AB305C0923;
 Thu, 29 Oct 2026 14:50:48 +0100 (CET)
Date: Thu, 29 Oct 2026 14:50:47 +0100
From: Willy Tarreau <w@1wt.eu>
To: panyuhang@hdu.edu.cn
Cc: zack.rusin@broadcom.com, gregkh@linuxfoundation.org,
 bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: unpin BOs without revalidating placement
Message-ID: <auNPN50Nt51ih1Yt@1wt.eu>
References: <AD6AfwDkLPJWAKFimg*tgar*.1.1793261964318.Hmail.242270054@hdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD6AfwDkLPJWAKFimg*tgar*.1.1793261964318.Hmail.242270054@hdu.edu.cn>
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

On Thu, Oct 29, 2026 at 04:19:24PM +0800, you wrote:
> 
> Unpinning a buffer object does not change its memory placement.
> Placement revalidation is unnecessary. Currently
> vmw_bo_pin_reserved() calls ttm_bo_validate() for both pin and unpin
> operations and treats any validation error as impossible with BUG_ON().
(...)

Please *stop* CCing security@k.o for public e-mails. We already have
enough noise to stay busy, no need to add public messages there!

Thanks,
Willy
