Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734E606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=M4EsLoAV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4910910E3EC;
	Wed,  4 Nov 2026 12:52:02 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A7A10E3EC;
 Wed,  4 Nov 2026 12:51:55 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKQLc11FszKpCr;
 Wed, 04 Nov 2026 13:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793796712; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSSJHqi/5pDzqpdufJwNl2YpFhO2QjjR6A1y0Moxtpc=;
 b=M4EsLoAVcRjppHMN9eECypbV/QByj3YorpSIV2U6hCM7yBmd7jLdzYxiJUBGTHX1jHXeBk
 Y/ElbTQJk7uw8UdWMxDaEkC14+J/PjvyG5Hl7qpB3nf/9FusJDoY5/DekTU1EzUBV2yz/o
 wRRb1NGUvmlF6/L2rVzvaz839cpV9NoaC3MtPDPtccy432Lv0DFs5pCNtwbd6JLljNDnxc
 g0CCP6RWy4enfdoUCfoWbkRxS/v26XIpYBnH7jyjdPYgfnmogYKcXt6pEEZhJgvCrGUdqA
 kd4fTU7j58EJw0/L5scMacZUhtEpEh2VvRPeJBeTehs9obGCLuTiKrsuGZn5nA==
Message-ID: <f02d51dd1d0f72951f9860f2a23fa6b53bf4b0ab.camel@mailbox.org>
Subject: Re: [PATCH 1/3] drm/sched: Reject double scheduler initialization
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Wed, 04 Nov 2026 13:51:50 +0100
In-Reply-To: <20261104123441.34842-2-tvrtko.ursulin@igalia.com>
References: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
 <20261104123441.34842-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: te5nfhai4ffpozea1xhin3zp5q6npirm
X-MBO-RS-ID: 4c67296647e6fec0541
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 12:34 +0000, Tvrtko Ursulin wrote:
> There is no point in having code and logging whose only purpose is to
> notify developers of incorrect usage of the API while bringing up a new
> driver. Lets simply return an error and let the developers figure it out.

What's your merge plan here, were those branched out of the previous
series? Is this a v2?


https://lore.kernel.org/dri-devel/20261020154123.33631-4-tvrtko.ursulin@iga=
lia.com/


P.
