Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEC606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=doiwQeqe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8372A10E097;
	Mon,  9 Nov 2026 22:07:11 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 67B6D10E097
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:07:05 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id B9B2320B7168; Mon,  9 Nov 2026 14:07:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9B2320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794262022;
 bh=FojzXsTv6Y+YEm4k8gUu4cy3Bf4RRdBAAG4ubxfrbl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=doiwQeqeLPJqIJkCZ2pVLmC0DW83f7uvmFT+mjYcgt3T48qzdze2TzuzAg0SnbFwI
 0bIdQ681waPkCSynG7aF80Vp3SJ3CgMaTJkBPQQRlrvAFDlF4hnfVBEOQQPF11E1+4
 5iN//JTDKNSCe7m0H7OAhvXPFntms35Xawuh510I=
Date: Mon, 9 Nov 2026 17:07:02 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V
 DRM driver
Message-ID: <avJEBr2OsZLpsB1s@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 11:00:04AM -0500, Hamza Mahfooz wrote:
> I have been informally co-maintaining the driver for some time now,
> so make it official.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c10342aa32f3..63b70f3da896 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8359,6 +8359,7 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
>  
>  DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
>  M:	Dexuan Cui <decui@microsoft.com>
> +M:	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>  M:	Saurabh Sengar <ssengar@linux.microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
> -- 
> 2.56.0
