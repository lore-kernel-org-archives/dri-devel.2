Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C45606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ywY/1UxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB97910FFF7;
	Thu, 29 Oct 2026 07:50:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2016210FFF7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A92AC42D7C;
 Thu, 29 Oct 2026 07:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF45D1F031E0;
 Thu, 29 Oct 2026 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793260222;
 bh=MV4ytUjkkUv8kGNfsO80EzlV4FKpsKt0v9OLD73l06w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ywY/1UxZ1aWD7wkfTUYfqOTPn8ouDyPikF8GbfMYtO+iZa4EBkkSuCL0cloborX4K
 3JpIZWobFGX4dj00UT2r3F0vxt8sKDoV+vna4CgcwrlZRqNDiaXJbmcwEy+z8opHg+
 +zBa5GogV/n3GfSi/eYUagc1VDZss2ZMYD+39TZs=
Date: Thu, 29 Oct 2026 08:50:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: 0001-drm-vmwgfx-unpin-BOs-without-revalidating-placement
Message-ID: <2026102910-prodigal-fraternal-0b7b@gregkh>
References: <AKoAagBcLENWUVxRNA4*KqoJ.1.1793259618800.Hmail.242270054@hdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AKoAagBcLENWUVxRNA4*KqoJ.1.1793259618800.Hmail.242270054@hdu.edu.cn>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 03:40:18PM +0800, 潘煜杭 wrote:
> Hello,
> 
> Thank you for the review and for pointing out the kernel-version,
> patch-format, and maintainer-CC issues.

All of this was rejected by the public lists due to html in your message
:(

Please just send a normal patch, as documented, and it can be handled
that way.  And as it's public, no need to get security@k.o involved.

thanks,

greg k-h
