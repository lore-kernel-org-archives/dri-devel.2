Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E82606A891
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Xs/eWaT5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010E510EC10;
	Fri, 13 Nov 2026 13:12:26 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD3210EC10;
 Fri, 13 Nov 2026 13:12:19 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jQyN10tGhz8vS5;
 Fri, 13 Nov 2026 14:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794575537; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlLaDhKM+OYhA2+4URfH0HPy5JUgfSSC1i9FpcUqAp4=;
 b=Xs/eWaT5hR7FY/Gw/fqU3x4QZNZ5X9Xz7OtRAkEOrqvSW4tPpbr/emO3YhzTt6BuyDZW2f
 nTMARJsq5WdFCYlAmIxkeD87g9H9V5WVJ56UvxuhOpBKQX9qDtCEnn0oMdPH4yZGiZjYaa
 q5DLP7EMNkxKGn82h8woCNX98RvlmAbPxbVL55X4XY1Dksql1VnyPPbyvS2JFgPOcjofy1
 MOSrDxVFc+ALwfbvxtok9WHCYeAKRVKtwgwGnVYv7ENvL6+gfv6Ie2q1X0Of5+cOqzCDdK
 yTljYm5G4FDj65np51sFSFlx6bokgn3SR0G9yOxo03DFyJw8eN96HERUwhOZ4w==
Message-ID: <83668fc32b64162ef38b79dedb093c4f46d5ca21.camel@mailbox.org>
Subject: Re: [PATCH 1/3] drm/sched: Reject double scheduler initialization
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>
Date: Fri, 13 Nov 2026 14:12:15 +0100
In-Reply-To: <aff2d7c2-8da8-46be-8130-7addb8ac0853@igalia.com>
References: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
 <20261104123441.34842-2-tvrtko.ursulin@igalia.com>
 <f02d51dd1d0f72951f9860f2a23fa6b53bf4b0ab.camel@mailbox.org>
 <18165b2c-8e8b-4e5a-afec-0cc8b2a24fd9@igalia.com>
 <aff2d7c2-8da8-46be-8130-7addb8ac0853@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 3e5d175a1378531a9b1
X-MBO-RS-META: rhctpuo3g7faytw4p6byz11qx3yhbkzo
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

On Fri, 2026-11-13 at 10:44 +0000, Tvrtko Ursulin wrote:
> Gentle ping on these three. I think it's good to reduce the number of
> allowed init combinations and remove some then and now pointless log=20
> messages from the codebase.

Yes, those are good changes. Thx for the ping.
Pushed them to misc-next

Thx
P.
