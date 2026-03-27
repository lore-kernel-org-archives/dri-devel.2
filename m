Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFCC10ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E3110EC67;
	Fri, 27 Mar 2026 11:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.b="S3bY1HHY";
	dkim-atps=neutral
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78ECD10EC67
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:57:46 +0000 (UTC)
Received: (wp-smtpd smtp.wp.pl 8113 invoked from network);
 27 Mar 2026 12:57:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
 t=1774612659; bh=dhTOyR8UKqY7SHJz5GHQLjXDNtmpvnLdVDZzqV+XcdA=;
 h=From:To:Cc:Subject;
 b=S3bY1HHYPKHernBCT0RMFPrtZRssIWCxkqHfL5/fCOzfr5qUTHh/sg6N/sbNdxDJf
 jO5p17BB+e/SiBcNQlxoPOCCJzVxg3Z+LDCn1NI/8Dbe4MCEsyJRv6MLRWxb8tw2Pl
 fEXiVvm92L+rpvByZatArkAXEwTp3ZdgjZGTPFwozoeO8zVOpc6JVAWe6z1BsU+sF4
 bXlv2s2vz8e+rHmDa31b9+GF7vm6lFvFmurDdGVyCnP7a+v+H4h8ut2N1+hy+tDLJ/
 eVJcTVSl7228LX/HbBqeaVslVfxnblUjGtACKc8DnIFUZ6TWq/8In6xsNFrOzeZCfm
 Ha7teirKUZngw==
Received: from 77-236-5-223.static.play.pl (HELO localhost)
 (stf_xl@wp.pl@[77.236.5.223]) (envelope-sender <stf_xl@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
 for <jackmanb@google.com>; 27 Mar 2026 12:57:39 +0100
Date: Fri, 27 Mar 2026 12:57:39 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
Message-ID: <20260327115739.GB16800@wp.pl>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-WP-MailID: 935123e2e45b6b0ec231f92885b872d7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [weNh]                               
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

On Thu, Mar 26, 2026 at 12:31:56PM +0000, Brendan Jackman wrote:
> This patchset used to be about switching gfp_t to unsigned long. That is
> probably not gonna happen any more but while writing it I found these
> cleanups that seem worthwhile regardless.

For the record, these patches are independent and could be sent separately
to the appropriate maintainers. Doing so would avoid unnecessarily large CC 
lists for people not interested about the changes in other subsystems.

Regards
Stanislaw

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

> Changes in v2:
> - Drop gfp_t changes
> - Add correct CCs
> - Add minor fixups to preexisting code spotted by AI review
> - Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com
> 
> ---
> Brendan Jackman (4):
>       drm/managed: Use special gfp_t format specifier
>       iwlegacy: 3945-mac: Fixup allocation failure log
>       mm/kfence: Use special gfp_t format specifier
>       net/rds: Use special gfp_t format specifier
> 
>  drivers/gpu/drm/drm_managed.c                  | 4 ++--
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  mm/kfence/kfence_test.c                        | 2 +-
>  net/rds/tcp_recv.c                             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260319-gfp64-7a970a80ba4e
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 
