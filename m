Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B370606A33A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=h40MjvdU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BE610E057;
	Thu,  5 Nov 2026 14:23:58 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432B410E057;
 Thu,  5 Nov 2026 14:23:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jL4LD6YH0zKnFJ;
 Thu, 05 Nov 2026 15:23:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793888628; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7S65QIZQsBjvb34pEWk74AVltTtxelwCjMVIqjSTLv4=;
 b=h40MjvdUrtulnWWF/85n34BD5RbV5b/HCwzgkWFAxM6DOCCoJq9+Lw4jH38yumNEoJP+6y
 eFd7ebQfoaMH1OJN+g2HBEC36VYPN1BstItiWKUaezOKxL7pdiH3irzVC78CiheQHVVt54
 mtDiPsfNwB06xIeik6zNhBKHGomBGl3Ac+hC7ZZQ2Kp1jsUTJ7n1S6g5uACaDWOOoiCHGK
 rbZl8iOoSpm/aoQRE5x9ij9sKIG0VL6CGFgaXispLPgD4szImYMDHJrTM6lFZBLUECX1wZ
 wcWxze5X4H9I6rdG1eEjOqBmrCtl6iRB6UUreWJZcaUaFX0/peVpqm+QcXMqOg==
Message-ID: <3f8897209cf7e6cb9e13d1cd0ea15d640a85ea1d.camel@mailbox.org>
Subject: Re: [PATCH v2 0/2] DRM scheduler fair policy fixups
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>
Date: Thu, 05 Nov 2026 15:23:46 +0100
In-Reply-To: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: da2a3073fb2158589e3
X-MBO-RS-META: e31mrkm4sz4ihrh1uhedmtqnes6a99ya
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

On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
> Tvrtko Ursulin (2):
> =C2=A0 drm/sched: Fix out of bounds entity priority check
> =C2=A0 drm/sched: Adjust run-queue when changing priority at runtime

Fixed a minor checkpatch error and pushed both to drm-misc-fixes.

Looking forward to getting rid of FIFO and RR!


Thx
P.
