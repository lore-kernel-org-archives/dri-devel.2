Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB632606A8B8
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=matt3o12.de header.i=@matt3o12.de header.a=rsa-sha256 header.s=securedbylima-20230709 header.b=F0afJlIh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C65310E135;
	Sun, 15 Nov 2026 22:34:48 +0000 (UTC)
X-Greylist: delayed 475 seconds by postgrey-1.36 at gabe;
 Sun, 15 Nov 2026 22:34:42 UTC
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4B910E135
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 22:34:42 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
X-Lima-ML-UUID: 0bbccc4b-eafb-4d59-b301-18d3d57f673f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1794781605;
 bh=H70rAsqDd/+AoMBICHrr1CVS1yQL3pOatKeHtbn/fqc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F0afJlIh36LdOWU/yR723YEDCGdV7vz0vzPgGDfRb2aa4uiBcmenyF0IcEtp5sRBi
 hP1QWFqxQBm4NOreCKlfLKJZFYAu5fuELhKLHCpI7hqPTbjAN+fYPyT9bdesXVaSNM
 1LMJDLrUWczucqNKGMAr9rhtH+gPe8n3Pf82ISLQDmBo6GwCkyfC7q0xnyYSBlYrTM
 BmJnEx2gUnG3s7ZW48bKN3SgMPn5rZHhE4cK7VbUKgxVys6breT5FGsy2jhceCkL6t
 WZNsLdy8Z+TRCpX/TTRN1Ak5C/xJcVT0M3BGMRD7JBi2iKWIUDrfkS32nr2ec7mmcV
 +lgXl9GnwzYjw==
To: acourbot@nvidia.com
Cc: dakr@kernel.org, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum segment
 size
Date: Sun, 15 Nov 2026 23:26:33 +0100
Message-ID: <20261115222633.393501-1-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DMRGPTJ9CH1A.2M8LD751KZRIB@nvidia.com>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DMRGPTJ9CH1A.2M8LD751KZRIB@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 7:35 PM JST, Alexandre Courbot wrote:
> Hi Matteo,
>
> Do you have plans to keep working on this and follow up on the feedback
> received on this revision?

Hi Alex,

Yes, I do. Sorry for not getting back to you sooner, I was unusual busy at
work.

I've had a patch implementing the approach we discussed ready for quite
a while now, but haven't found the time to review it properly myself.
I plan to do that and send it out as an RFC by the end of this week.

