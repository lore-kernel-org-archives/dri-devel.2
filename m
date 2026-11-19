Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0520606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YbBjV3Sn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18D410E1B5;
	Thu, 19 Nov 2026 07:23:50 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E6110E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:23:45 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jVVM20zstzKvdh;
 Thu, 19 Nov 2026 08:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795073022; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSAmRtT3yrbZt4K/fQTfT/uU1ARzqEc92zTiDgmMl0c=;
 b=YbBjV3SnXKx2Z18omeStciXg/459vJzsvqWJ1CDMGV3JDAKXh0F19kVxSk0ZGdT3rFBc4Z
 U1h2UOEc7jYkahiwv/S9ALly4cJI8jIncZzJwthwvFSHPSFfad5PBrNaRAxTxxV7xykx7P
 Putw2IPMmR7LpJwvDKLOZmET7Wsl3uJhnQHIEbU4QRTJ5d15LxiMH733+iOCWCnw/FLyrU
 ++KaeuJZejI2B8VoCAU5tAfIwN4Hkx2xS2fcblec21friEOSGEnXhSno8TVP6SBtOVdd1h
 7S1inbLw5u3wBWJdIlNik1WW80VqYh1vZ81w4ayWWPJfggHP9b7j5xod7x0HqA==
Message-ID: <48d9790a8f1d2ca7281907f1c32d7e7759e9eb77.camel@mailbox.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, phasta@kernel.org, 
 Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>,  Danilo Krummrich	 <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, 	ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Heiko Stuebner <heiko@sntech.de>,
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 08:23:39 +0100
In-Reply-To: <1b78ef4b-011e-4174-800e-425c94fddf3a@igalia.com>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-2-sidong.yang@furiosa.ai>
 <34494226eb920bdbd7f3257ef6f9b20f4e8ffd6a.camel@mailbox.org>
 <1b78ef4b-011e-4174-800e-425c94fddf3a@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 9257ce8575c14bb1251
X-MBO-RS-META: ir8144qoixqtt1apjywihsqo3j4z79ua
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-18 at 14:39 -0300, Ma=C3=ADra Canal wrote:
> Maybe we could name it drm_sched_entity_get_runtime_ns()?

Both fine by me. All no big deal.

Acked-by: Philipp Stanner <phasta@kernel.org>

Please merge how you see fit.


P.
